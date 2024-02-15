/* 
    SELECT
    SELECT 가지고오고싶은 정보(컬럼) FROM 테이블;
    SELECT (*) 또는 컬럼1, 컬럼2, 컬럼3 ... FROM 테이블;
*/

-- 모든 사원 정보
SELECT * FROM EMPLOYEE;

-- 모든 사원 이름, 주민번호, 핸드폰번호
SELECT EMP_NAME, EMP_NO, PHONE FROM EMPLOYEE;


---------실습--------
-- JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME FROM JOB;
-- DEPARTMENT 테이블의 모든 컬럼 조회
SELECT * FROM DEPARTMENT;
-- DEPARTMENT 테이블의 부서코드 부서명 조회
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;
-- DEPARTMENT 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY FROM EMPLOYEE;

-- <컬럼값을 통한 산술연산>
-- SELECT절 컬럼명 작성부분에 산술연산 가능

-- ex) EMPLOYEE테이블의 사원명, 연봉을 조회, EMPLOYEE에는 연봉정보가 없음
-- 연봉은 SALARY*12
SELECT EMP_NAME, SALARY*12 FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스, 연봉, 보너스 포함 연봉 조회
SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY + (SALARY*BONUS))*12 FROM EMPLOYEE;

-- 산술연산 과정 중 NULL 데이터가 포함되어 있다면 무조건 결과값은 NULL이다.

-- 사원명, 입사일, 근무일수 조회
-- 현재시간 - 입사일 = 근무일수
-- DATE - DATE => 일로 표시
-- SYSDATE : 코드 실행한 날짜 : [년/월/일/시/분/초]

SELECT EMP_NAME as 사원명, 
HIRE_DATE as 채용일자,
SYSDATE - HIRE_DATE as 근무일자
FROM EMPLOYEE;

-- DUAL: 오라클에서 제공해주는 가상데이터 테이블(더미데이터)
SELECT SYSDATE FROM DUAL;

/*
    <컬럼명에 별칭 지정하기>
    산술연산을 하게되면 컬럼명이 지저분해지는데
    이때 컬럼명을 지정할 수 있다.
    [표현법]
    컬럼명 별칭 / 컬럼명 as 별칭 / 컬럼명 "별칭" / 컬럼명 as "별칭"
*/

SELECT EMP_NAME 사원명,
SALARY as 급여,
(SALARY*BONUS) "상여금",
(SALARY+(SALARY*BONUS))*12 as 연봉
FROM EMPLOYEE;

/*
    <리터럴>
    임의로 지정한 문자열(' ')
    조회된 결과(RESULT SET)의 모든 행에 반복적으로 출력하고자 할 때
*/

-- EMPLOYEE 테이블의 사번, 사원명, 급여
SELECT EMP_ID, EMP_NAME, SALARY,'원' as 단위 FROM EMPLOYEE;


/*
    <연결연산자: ||>
    여러 컬럼값들을 마치 하나의 컬럼처럼 연결할 수 있다.
    
*/
SELECT EMP_ID, EMP_NAME, SALARY || '원' as 짬뽕 FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 모든 사원의 월급을 조회
-- 다음과 같이 조회해보자

SELECT EMP_NAME || '의 ' || '월급은 ' || SALARY || '원 입니다.' as 결과 FROM EMPLOYEE;

/*
    <DISTINCT>
    중복제거 - 컬럼에 표시된 값들을 한번씩만 조회하고자 할 때 사용
*/

-- EMPLOYEE 직급코드 조회
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE 부서코드 조회
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

-- SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE FROM EMPLOYEE;
-- DISTINCT는 한 번만 사용 가능

SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;
-- JOB_CODE와 DEPT_CODE 모두 같은 중복값 제거

/*
    <WHERE절>
    조회하고자하는 테이블로부터 
    특정 조건에 만족하는 데이터만 조회할 때 사용
    조건식에서도 다양한 연산자 사용이 가능
    [표현법]
    SELECT 컬럼, 컬럼 ... FROM 테이블
    WHERE 조건;
    
    비교연산자
    >, <, >=, <=, : 대소비교
    =             : 양쪽이 같다.
    !=, ^=, <>    : 양쪽이 다르다.
*/

-- EMPLOYEE에서 부서코드가 'D9'인 사원들만 조회(모든 컬럼)
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE에서 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드 조회
SELECT EMP_NAME as 사원명, 
SALARY as 급여, 
DEPT_CODE as 부서코드
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE에서 부서코드가 'D1'이 아닌 사원들의 사원명, 급여, 부서코드 조회
SELECT EMP_NAME as 사원명, 
SALARY as 급여, 
DEPT_CODE as 부서코드
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';

-- 월급이 400만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME as 사원명,
DEPT_CODE as 부서코드,
SALARY as 급여
FROM EMPLOYEE
WHERE SALARY >= 4000000;

------------------------실습---------------------------

-- 1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉 조회(별칭->연봉) 조회
SELECT EMP_NAME as 사원명,
SALARY as 급여,
HIRE_DATE as 입사일,
SALARY * 12 as 연봉
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. 연봉이 5천만원 이상인 사원들의 사원명, 급여, 연봉(별칭 -> 연봉), 부서코드 조회
SELECT EMP_NAME as 사원명,
SALARY as 급여,
SALARY * 12 as 연봉,
DEPT_CODE as 부서코드
FROM EMPLOYEE
WHERE SALARY*12 > 50000000;
-- 실행순서 FROM -> WHERE -> SELECT

-- 3. 직급코드가 'J3'가 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT EMP_ID as 사번,
EMP_NAME as 사원명,
JOB_CODE as 직급코드,
ENT_YN as 퇴사여부
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- 4. 급여가 350만원 이상 600만원 이하인 모든 사원의 사원명, 사번, 급여 조회
SELECT EMP_NAME as 사원명, 
EMP_ID as 사번,
SALARY as 급여
FROM EMPLOYEE
WHERE SALARY >= 3500000 and SALARY <= 6000000;
