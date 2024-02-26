/*
    DQL(QUERY, 데이터 정의어): SELECT
    DML(MANIPULATION, 데이터 조작어): INSERT, UPDATE, DELETE
    -> C(INSERT), R(SELECT), U(UPDATE), D(DELETE)
    DDL(DEFINITION,데이터 정의어): CREATE, ALTER, DROP
    DCL(CONTROL, 데이터 제어): GRANT, REVOKE
    TCL(TRANSACTION CONTROL): COMMIT, ROLLBACK
    
    DML: 데이터 조작 언어
    
    테이블 값을 삽입(INSERT)하거나, 수정(UPDATE), 삭제(DELETE)하는 구문
*/

/*
    1. INSERT
        테이블에 새로운 행을 추가하는 구문
    
    [표현식]
    1) INSERT INTO 테이블명 VALUES(값1, 값2, 값3,....)
    테이블의 모든 컬럼에 대한 값을 직접 제시해서 한 행을 INSERT하고자 할 때
    컬럼의 순번을 지켜서 VALUES에 값을 나열해야함
    
    부족하게 값을 제시할 경우 -> not enough values 라는 오류가 발생한다.
    값을 더 많이 제시할 경우 -> too many values 라는 오류 발생
*/
SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE 
VALUES(250,'이오공','901024-1234567','250@gmail.com','01011112222',
    'D7','J5',2500000,0.2,200,sysdate,null,default);
    
/*
    2) INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3) VALUES(컬럼1에 대한 값, 컬럼2에 대한 값, 컬럼3에 대한 값);
    테이블에 내가 선택한 컬럼에 대한 값만 INSERT할 때 사용
    그래도 한 행 단위로 추가되기 때문에 선택 안된 컬럼은 기본적으로 NULL이 들어가게 된다.
    => NOT NULL 제약조건이 걸려있는 컬럼은 반드시 값을 넣어줘야 한다.
        단, 기본값이 있는 컬럼은 값을 넣어주지 않아도 된다. -> 넣어주지 않으면 기본값이 들어가게 된다.
*/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO,JOB_CODE, HIRE_DATE)
VALUES(290, '이구공', '990322-1234567', 'J7',SYSDATE);
    
SELECT * FROM EMPLOYEE;

INSERT
    INTO EMPLOYEE(
        EMP_ID,
        EMP_NAME,
        EMP_NO,
        JOB_CODE,
        HIRE_DATE)
    VALUES (
        258,
        '이오팔',
        '000725-3456789',
        'J7',
        SYSDATE);

---------------------------------------------------------------------------
/*
    3) INSERT INTO 테이블명 (서브쿼리);
    VALUES로 값을 직접 명시하는 것 대신
    서브쿼리로 조회된 결과값을 통채로 INSERT 가능하다.
*/
-- 테이블 새로 만들기
CREATE TABLE TMP_01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR(20),
    DEPT_TITLE VARCHAR(20)
);

INSERT
    INTO TMP_01
    (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
     FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID));

SELECT * FROM TMP_01;

--===============================================================================

/*
    2. INSERT ALL
    두 개 이상의 테이블에 각각 INSERT할 때
    이때 사용되는 서브쿼리가 동일한 경우


*/
-- 테스트 테이블 생성
CREATE TABLE EMP_DEPT
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1=0); -- 껍데기만 복사하고싶을 때 말도 안되는 조건을 쓰자

CREATE TABLE EMP_MANAGER
AS (SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1=0);
    
-- 부서코드가 D1인 사원들의 사번, 이름, 부서코드, 입사일, 사수사번 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    [표현식]
    INSERT ALL
    INTO 테이블명1 VALUES(컬럼, 컬럼, 컬럼, ...)
    INTO 테이블명2 VALUES(컬럼, 컬럼, 컬럼, ...)
    서브쿼리;
*/

INSERT ALL
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME,MANAGER_ID)
        (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
        FROM EMPLOYEE
        WHERE DEPT_CODE = 'D1');
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;
-------------------------------------------------------------------------------
/*
    3. UPDATE
    테이블에 기록되어있는 기존의 데이터를 수정하는 구문
    
    [표현식]
    UPDATE 테이블명
    SET 컬럼 = 값,
        컬럼 = 값,
        ... -- AND로 연결하는 것이 아닌 ,(콤마)로 연결한다.
    [WHERE 조건] --> 생략하게 되면 전체 모든 행의 데이터가 변경
    
    업데이트시에도 제약조건을 잘 확인해야한다.
*/

CREATE TABLE DEPT_TABLE
AS (SELECT * FROM DEPARTMENT);

SELECT * FROM DEPT_TABLE;

-- D9부서의 부서명을 '전략기획팀'으로 변경
UPDATE DEPT_TABLE
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';

CREATE TABLE EMP_SALARY
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE);

SELECT * FROM EMP_SALARY;
--노옹철 사원의 급여를 100만원으로 변경
UPDATE EMP_SALARY
SET SALARY = 1000000
WHERE EMP_NAME = '노옹철';
--선동일 사원의 급여를 700만원, 보너스를 0.2로 변경
UPDATE EMP_SALARY
SET SALARY = 7000000,
    BONUS = 0.2
WHERE EMP_NAME = '선동일';
--전체사원의 급여를 기존 급여에 10프로 인상된 금액으로 변경(기존급여 * 1.1)
UPDATE EMP_SALARY
SET SALARY = SALARY*1.1;

-- UPDATE시 서브쿼리 사용하기
/*
    UPDATE 테이블명
    SET 컬럼명 = (서브쿼리)
    WHERE 조건
*/

-- 방명수 사원의 급여와 보너스값을 유재식 사원의 급여와 보너스 값으로 변경

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
              FROM EMP_SALARY
              WHERE EMP_NAME = '유재식'),
    BONUS = (SELECT BONUS
              FROM EMP_SALARY
              WHERE EMP_NAME = '유재식')              
WHERE EMP_NAME = '방명수';

SELECT * FROM EMP_SALARY;

-- 다중열로 변경
UPDATE EMP_SALARY
    SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                             FROM EMP_SALARY
                             WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

--ASIA 지역에서 근무하는 사원들의 보너스 값을 0.3으로 변경
UPDATE EMP_SALARY
    SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                   FROM EMP_SALARY
                 JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                 JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                 WHERE LOCAL_NAME LIKE 'ASIA%');     
                 
SELECT *
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
;

COMMIT;
---------------------------------------------------------------------------------
/*
    4. DELETE
    테이블에 기록된 데이터를 삭제하는 구문(한 행 단위로 삭제가 된다.)
    
    [표현식]
    DELETE FROM 테이블명
    [WHERE 조건] --> WHERE절 제시 안하면 전체행 삭제됨
*/

DELETE FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;
ROLLBACK;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '이오팔';

DELETE FROM EMPLOYEE
WHERE EMP_ID = '290'; -- 지울때 주로 기본키를 이용해서 지움
COMMIT;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
--D1의 값을 가져다 쓰는 자식데이터가 있기 때문에 삭제가 되지 않는다.