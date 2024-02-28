/*
    DDL: 데이터 정의 언어
    객체를 생성(CREATE), 변경(ALTER), 삭제(DELETE)하는 구문

    ALTER
    객체를 변경하는 구문
    
    [표현식]
    ALTER TABLE 테이블명 변경할 내용
    
    *변경할 내용
    1) 컬럼 추가 / 수정 / 삭제
    2) 제약조건 추가 / 삭제 --> 수정은 불가(삭제 후 다시 추가해야함)
    3) 컬럼명 / 제약조건명 / 테이블명 변경 
*/

-- 1) 컬럼 추가 / 수정 / 삭제
-- DEPT_TABLE에 CNAME 컬럼 추가
ALTER TABLE DEPT_TABLE ADD CNAME VARCHAR2(20);

-- LNAME 컬럼 추가(기본값 -> 한국)
ALTER TABLE DEPT_TABLE add LNAME VARCHAR2(20) DEFAULT '한국';

-- 1_2 컬럼 수정(MODIFY)
--> 데이터 타입 수정: MODIFY 컬럼명 바꾸고자하는 데이터타입
--> DEFAULT값 수정: MODIFY 컬럼명 DEFAULT 바꾸고자하는 기본값

ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5);
--ALTER TABLE DEPT_TABLE MODIFY DEPT_ID number; -- 데이터타입에 대한 형식 오류가 발생
--ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(20); -- 크기 오류가 발생

-- DEPT_TITLE 컬럼을 VARCHAR2(40)으로 수정
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(40);
-- LNAME 컬럼의 기본값을 '미국'으로 변경
ALTER TABLE DEPT_TABLE MODIFY LNAME DEFAULT '미국';

-- 다중변경 가능
ALTER TABLE DEPT_TABLE
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LNAME DEFAULT '일본';
    
-- 1_3 컬럼 삭제(DROP COLUMN): DROP COLUMN 삭제하고자 하는 컬럼
CREATE TABLE DEPT_COPY AS SELECT * FROM DEPT_TABLE;

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID; -- 최소 한개의 컬럼은 존재해야 한다.

------------------------------------------------------------------------------
--2) 제약조건 추가 / 삭제 (수정은 삭제하고 다시 추가하기로 대체)
/*
    2_1)
    - PRIMARY KEY: ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY: ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명[(참조할 컬럼명)]
    - UNIQUE: ALTER TABLE 테이블명 ADD UNIQUE(컬럼명);
    - CHECK: ALTER TABLE 테이블명 ADD CHECK(컬럼에 대한 조건식);
    - NOT NULL: ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;   
    
    제약조건명 지정하고자 한다면 [CONSTRAINT 제약조건명] 제약조건
*/
-- DEPT_TABLE
-- DEPT_ID에 PRIMARY KEY 제약조건 추가
ALTER TABLE DEPT_TABLE ADD PRIMARY KEY (DEPT_ID);
-- DEPT_TITLE에 UNIQUE 제약조건 추가
ALTER TABLE DEPT_TABLE ADD UNIQUE (DEPT_TITLE);
-- LNAME에 NOT NULL 제약조건 추가
ALTER TABLE DEPT_TABLE MODIFY LNAME NOT NULL;

-- 2_2) 제약조건 삭제: DROP CONSTRAINT 제약조건명 / NOT NULL은 삭제 안됨, 변경 가능
ALTER TABLE DEPT_TABLE DROP CONSTRAINT SYS_C007139;

ALTER TABLE DEPT_TABLE DROP CONSTRAINT SYS_C007139;

ALTER TABLE DEPT_TABLE
    DROP CONSTRAINT SYS_C007140
    MODIFY LNAME NULL;
    
------------------------------------------------------------------------------
-- 테이블 삭제
DROP TABLE DEPT_TABLE;
-- 어딘가에 참조되고 있는 부모테이블 함부로 삭제가 되지 않는다.
-- 만약 지우고자 한다면
-- 1. 자식테이블 먼저 삭제 후 삭제
-- 2. 그냥 부모테이블만 삭제하는데 제약조건까지 삭제하는 법
-- DROP TABLE 테이블 명 CASCADE CONSTRAINT;

--------------------------------------------------------------------------

--3) 컬럼명, 제약조건연결
--3_1) 컬럼명 변경 : RENAME
CREATE TABLE DEPT_TABLE
AS (SELECT * FROM DEPARTMENT);

-- DEPT_TITLE - DEPT_NAME
ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

SELECT *FROM DEPT_TABLE;

--3_2) 제약조건명 변경: RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
ALTER TABLE DEPT_TABLE RENAME CONSTRAINT SYS_C007142 TO DTABLE_LID_NN;

--3_3) 테이블명 변경: RENAME TO 바꿀 테이블명
ALTER TABLE DEPT_TABLE RENAME TO DEPT_TEST;

------------------------------------------------------------------------------
-- TRUNCATE: 테이블 초기화
-- DROP과는 다르게 테이블의 데이터만을 전부 삭제하여 테이블의 초기상태로 돌려준다.
TRUNCATE TABLE DEPT_TEST;

SELECT * FROM DEPT_TEST;
ROLLBACK;