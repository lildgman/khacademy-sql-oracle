/*
    * 서브쿼리 (SUBQUERY)
    하나의 SQL문 안에 포함된 또 다른 SELECT문
    메인 SQL문을 위해 보조 역할을 하는 쿼리문
    
*/

-- 간단한 서브쿼리 예시
-- 1. 노옹철 사원과 같은 부서에 속한 사원들 조회

-- 1) 노옹철 사원의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 2) 부서코드가 D9인 사원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 위에 두 단계를 하나의 쿼리문으로
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (
    SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철');
    
-- 간단한 서브쿼리 예시2
-- 전 직원 평균급여보다 더 많은 급여를 받는 사원들의 사번, 이름, 직급코드, 급여 조회
-- 1) 전직원의 평균급여
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 2) 3047663보다 많이 받는 사원의 사번, 이름, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;
     
-- 3) 두 단계를 합해보자
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (
    SELECT ROUND(AVG(SALARY))
    FROM EMPLOYEE
    );
    
/*
    서브쿼리의 구분
    서브쿼리를 수행한 결과값이 몇행 몇열로 나오냐에 따라 분류
*/