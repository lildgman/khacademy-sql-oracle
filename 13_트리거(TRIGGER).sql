/*
    트리거
    내가 지정한 테이블에 INSERT, UPDATE, DELETE 등 DML문에 의해 변경사항이 생길 때
    (테이블에 이벤트가 발생할 때)
    
    EX)
    회원탈퇴시 기존의 회원 테이블에 데이터 DELETE 후 곧바로 
    탈퇴한 회원들만 따로 보관하는 테이블에 자동으로 INSERT 시켜야한다.
    신고횟수가 일정 수를 넘었을 때 묵시적으로 해당 회언을 블랙리스트로 처리되게끔
    입출고에 대한 데이터가 기록(INSERT)될 때마다
    해당 상품에 대한 재고수량을 수정(UPDATE)해야한다.
    
    트리거 종류
    - SQL문의 실행시기에 따른 분류
    > BEFORE TRIGGER: 내가 지정한 테이블에 이벤트가 발생되기 전에 트리거 실행
    > AFTER TRIGGER: 내가 지정한 테이블에 이벤트가 발생된 후 트리거 실행
    
    - SQL문에 의해 영향을 받는 각 행에 따른 분류
    > 문장 트리거: 이벤트가 발생한 SQL문에 대해 딱 한 번만 실행하기
    > 행 트리거: 해당 SQL문 실행할 때마다 매번 트리거 실행
                (FOR EACH ROW 옵션 기술해야함)
                > :OLD - BEFORE UPDATE(수정 전 자료), BEFORE DELETE(삭제 전 자료)
                > :NEW - AFTER INSERT(추가 된 자료), AFTER UPDATE(수정 후 자료)
    트리거 생성 구문
    [표현식]
    CREATE [OR REPLACE] TRIGGER 트리거명
    BEFORE | AFTER              INSERT | UPDATE | DELETE ON 테이블
    [FOR EACH ROW]
    [DECLARE 변수선언]
    BEGIN
        실행내용(해당 위에 지정된 이벤트 발생시 실행할 구문)
    [EXCEPTION]
    END;
    /    
*/

--EMPLOYEE 테이블에 새로운 행이 INSERT될 때마다 자동으로 '신입사원님 환영합니다' 출력
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES(500,'DDD','111111-2222222','D7','J7',SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES(501,'GGG','111122-2222222','D7','J7',SYSDATE);

-------------------------------------------------------------------------------
-- 상품입고 및 출고 관련 예시
--> 필요한 테이블 및 시퀀스 생성

-- 1. 상품에 대한 데이터를 보관할 테이블(TB_PRODUCT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30) NOT NULL,
    BRAND VARCHAR2(30) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
);

-- 상품번호 중복 안되게끔 매번 새로운 상품번호를 발생시키기 위한 시퀀스 생성
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

-- 샘플데이터 추가
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL,'갤럭시24','삼성',1400000,DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL,'아이폰15','애플',1200000,10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL,'대륙폰','샤우미',700000,20);
COMMIT;
SELECT * FROM TB_PRODUCT;

-- 2. 상품 입출고 상세 이력 테이블 생성(TB_PRODETAIL)
-- 어떤 상품이 어떤 날짜에 몇개가 입고 또는 출고가 되는지 데이터를 기록
CREATE TABLE TB_PRODETAIL(
    DECODE NUMBER PRIMARY KEY,
    PCODE NUMBER REFERENCES TB_PRODUCT(PCODE),
    PDATE DATE NOT NULL, -- 입출고일
    AMOUNT NUMBER NOT NULL, -- 입출고 수량
    STATUS CHAR(6) CHECK (STATUS IN ('입고','출고'))
);

-- 이력번호 매번 새로운 번호를 발생시켜 들어갈 수 있게 도와줄 시퀀스 생성
CREATE SEQUENCE SEQ_DECODE
NOCACHE;

-- 200번 상품이 오늘날짜로 10개 입고
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 200,SYSDATE,10,'입고');

-- 200번 상품 재고수량 10 증가
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT;

-- 205번 상품이 오늘날짜로 20개 입고
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 205,SYSDATE,20,'입고');
-- 205번 상품 재고수량 20 증가
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;

-- 210번 상품이 오늘날짜로 5개 입고
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 210,SYSDATE,5,'입고');
-- 210번 상품 재고수량 20 증가
UPDATE TB_PRODUCT
SET STOCK = STOCK + 5
WHERE PCODE = 210;
COMMIT;
--TB_PRODETAIL 테이블에 INSERT 이벤트 발생 시
--TB_PRODUCT 테이블에 매번 자동으로 재고수량 UPDATE 되게끔 트리거 작성

/*
    - 상품이 입고된 경우 -> 해당 상품을 찾아 재고수량 증가 UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK + 현재 입고된 수량(INSERT된 자료 AMOUNT)
    WHERE PCODE = 입고된 상품 번호(INSERT된 자료의 PCODE);
    - 상품이 출고된 경우 -> 해당 상품을 찾아 재고수량 감소 UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK - 현재 출고된 수량(INSERT된 자료 AMOUNT)
    WHERE PCODE = 출고된 상품 번호(INSERT된 자료의 PCODE);
*/

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    IF(:NEW.STATUS = '입고')
        THEN UPDATE TB_PRODUCT
             SET STOCK = STOCK + :NEW.AMOUNT
             WHERE PCODE = :NEW.PCODE;
    END IF;
    
    IF(:NEW.STATUS = '출고')
        THEN UPDATE TB_PRODUCT
             SET STOCK = STOCK - :NEW.AMOUNT
             WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 210번 상품이 오늘날짜로 7개 출고
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 210,SYSDATE,7,'출고');
-- 200번 상품이 오늘날짜로 100개 입고
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 200,SYSDATE,100,'입고');