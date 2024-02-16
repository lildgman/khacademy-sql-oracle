SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

/*
    ORDER BY
    SELECT문 가장 마지막 줄에 작성
    실행순서도 마지막에 실행
    
    [표현법]
    SELECT 조회할 컬럼 
    FROM 조회할 테이블
    WHERE 조건식
    ORDER BY 정렬기준이 될 컬럼명 | 별칭 | 컬럼 순번 
    [ ASC | DESC ][ NULL FIRST | NULL LAST ] <- 생략가능
    
    - ASC: 오름차순(작은값 -> 큰값), 기본값
    - DESC: 내림차순(큰값 -> 작은값)
    
    -- NULL은 기본적으로 가장 큰 값으로 분류해서 정렬
    - NULLS FIRST: 정렬하고자하는 컬럼값에 NULL이 있을 경우 해당 데이터 맨 앞에 배치(DESC일 때 기본값)
    - NULLS LAST: 정렬하고자하는 컬럼값에 NULL이 있을 경우 해당 데이터 맨 뒤에 배치(ASC일 때 기본값)
*/

SELECT * FROM EMPLOYEE
--ORDER BY BONUS; -- 기본값이 오름차순
--ORDER BY BONUS ASC;
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- NULLS FIRST 기본

-- 정렬기준에 컬럼값이 동일할 경우 정렬기준을 그 다음 차순을 위해 여러 개를 제시할 수 있다.
ORDER BY BONUS DESC, SALARY ASC;

-- 전 사원의 사원명, 연봉 조회(보너스 제외),이 때 연봉별 내림차순 정렬
SELECT EMP_NAME, SALARY, SALARY*12 AS 연봉
FROM EMPLOYEE
ORDER BY 연봉 DESC;
--ORDER BY 3 DESC; -- 컬럼 순번으로 정렬 가능(선호하지 않음)

--========================================================================

/*
    함수 FUNCTION
    전달된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환
    
    - 단일행 함수: N개 값을 읽어들여서 N개 결과값을 리턴(매 행마다 함수 실행 결과 반환)
    - 그룹함수: N개 값을 읽어들여서 1개의 결과 값을 리턴(그룹을 지어서 그룹별로 함수 실행결과 반환)
    
    SELECT 절에 단일행 함수와 그룹함수를 함께 사용하지 못함
    -> 결과 행의 개수가 다르기 때문
    
    함수식을 기술할 수 있는 위치: SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
    
*/

--==================단일행 함수====================

/*
    문자 처리 함수
    LENGTH(컬럼 | '문자열'): 해당 문자열의 글자수 반환
    LENGTHB(컬럼 | '문자열'): 해당 문자열의 바이트수 반환
    
    '가', '나' 등 한글은 글자당 3BYTE
    영어, 숫자, 특수문자는 글자당 1BYTE
*/

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;

SELECT LENGTH('oracle'), LENGTHB('ORACLE')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

------------------------------------------------------------------------

/*
    INSTR
    문자열로부터 특정 문자의 시작위치를 찾아서 반환
    
    INSTR(컬럼 | '문자열', '찾고자하는 문자',['찾을 위치의 시작값', 순번]) => 결과는 NUMBER로 나옴
*/

SELECT INSTR('AABAACAABBAA','B')FROM DUAL; -- 앞쪽에 있는 첫 B는 3번째 위치에 있다고 나옴
-- 찾을 위치 시작값: 1, 순번: 1 => 기본값
SELECT INSTR('AABAACAABBAA','B', -1)FROM DUAL; -- -1은 뒤에서부터 찾겠다. 읽을 때는 앞에서부터 읽어서 알려줌
SELECT INSTR('AABAACAABBAA','B', 1, 2)FROM DUAL; -- 순번을 제시하려면 찾을 위치의 시작값을 표시해야함
SELECT INSTR('AABAACAABBAA','B', 1, 3)FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_') AS "_위치", INSTR(EMAIL, '@') AS "@위치"
FROM EMPLOYEE;

--========================================================================================

/*
    SUBSTR -- 자주 쓰임
    문자열에서 특정 문자열을 추출해서 반환
    
    [표현법]
    SUBSTR(STRING, POSITION, [LENGTH])
    - STRING: 문자타입의 컬럼 | '문자열'
    - POSITION: 문자열 추출할 시작위치의 값
    - LENGTH: 추출할 문자 개수(생략하면 끝까지)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7번째 위치부터 끝까지
SELECT SUBSTR('SHOWMETHEMONEY', 5,2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',1,6) FROM DUAL; --SHOWME
SELECT SUBSTR('SHOWMETHEMONEY', -8,3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1) AS 성별
FROM EMPLOYEE;

-- 사원들 중 여사원들만 조회
SELECT EMP_NAME, EMP_NO 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 2;

-- 사원들 중 남사원들만 조회
SELECT EMP_NAME, EMP_NO 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1
ORDER BY EMP_NAME;

-- 함수 중첩 사용 가능
-- 이메일 아이디 부분만 추출
-- 사원목록에서 사원명, 이메일, 아이디 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,(INSTR(EMAIL,'@')-1)) AS 아이디
FROM EMPLOYEE;

-----------------------------------------------------------------------

/*
    LPAD / RPAD
    
    문자열을 조회할 때 통일감있게 조회하고자 할 때 사용
    
    [표현법]
    LPAD/RPAD(STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자 하는 문자])
    
    문자열에 덧붙이고자하는 문자를 왼쪽 또는 오른쪽에 붙여서 최종 N길이 만큼 문자열을 반환
    
*/

-- 20만큼의 길이 중 EMAIL 컬럼값은 오른쪽으로 정렬하고, 나머지 부분은 공백으로 채운다
SELECT EMP_NAME, LPAD(EMAIL, 20, ' ')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 사원들의 사원명 주민번호 조회("910524-1******")
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*') AS 주민번호
FROM EMPLOYEE;

SELECT RPAD(SUBSTR(EMP_NO,1,(INSTR(EMP_NO,'-')+1)),14,'*')
FROM EMPLOYEE;

---------------------------------------------------------------------------

/*
    LTRIM / RTRIM
    문자열에서 특정 문자를 제거한 나머지 반환
    LTRIM/RTRIM(STRING, [제거하고자하는 문자들])
    
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자하는 문자들을 찾아서 제거한 나머지 문자열 반환
    
*/

SELECT LTRIM('    K    H') FROM DUAL;
SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('ACABACCKH','ABC') FROM DUAL; -- 제거하고자 하는 문자는 문자열이 아닌 문자들
SELECT RTRIM('574185KH323','01234556') FROM DUAL;

/*
    TRIM
    문자열의 앞/뒤/양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    TRIM([LEADING | TRAILING | BOTH] 제거하고자하는 문자열 FROM 문자열)
*/

SELECT TRIM('    K    H    ') FROM DUAL; -- 양쪽 공백 제거
SELECT TRIM('Z' FROM 'ZZZZKHZZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; --LTRIM
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- RTRIM
SELECT TRIM(BOTH 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL;

----------------------------------------------------------------------

/*
    LOWER / UPPER / INITCAP

    LOWER: 다 소문자로 변경한 문자열 반환
    UPPER: 다 대문자로 변경한 문자열 반환
    INITCAP: 띄어쓰기 기준 첫 글자마다 대문자로 변경한 문자열 반환
*/
SELECT LOWER('Welcome To The Jungle') FROM DUAL;
SELECT UPPER('Welcome To The Jungle') FROM DUAL;
SELECT INITCAP('welcome to the jungle') FROM DUAL;

-----------------------------------------------------------------------

/*
    CONCAT
    문자열 두 개 전달받아 하나로 합친 후 반환
    CONCAT(STRING1, STRING2)
*/
SELECT CONCAT('가나다','ABC') FROM DUAL; -- CONCAT은 두 개 문자열만 가능
SELECT 'ㅋㅋㅋ' || 'ㅇㅎㅇㅎ' || 'ㄹㄹㄹ' FROM DUAL;

------------------------------------------------------------------------

/*
    REPLACE
    특정 문자열에서 특정부분을 다른부분으로 교체
    REPLACE(문자열, 찾을 문자열, 변경할 문자열)
*/

SELECT EMAIL, REPLACE(EMAIL, 'KH.or.kr', 'gmail.com')
FROM EMPLOYEE;

-------------------------------------------------------------------------

/*
    숫자 처리 함수
    ABS
    숫자의 절대값을 구해주는 함수
    
*/

SELECT ABS(-10), ABS(-55.4) FROM DUAL;

--------------------------------------------------------------------------
/*
    MOD
    두 수를 나눈 나머지 값을 반환
    MOD(NUMBER, NUMBER)
*/

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9, 4.2) FROM DUAL;

--------------------------------------------------------------------------

/*
    ROUND
    반올림한 결과를 반환
    
    ROUND(NUMBER, [위치])
*/

SELECT ROUND(123.456,0) FROM DUAL; -- 소수 첫째 자리에서 반올림
SELECT ROUND(123.456, 1) FROM DUAL; -- 양수로 증가할수록 소수점 뒤로 한칸씩 이동
SELECT ROUND(123.456, -1) FROM DUAL; -- 음수로 감소할수록 소수점 앞자리로 이동

---------------------------------QUIZ-------------------------------------
--검색하고자 하는 내용
--JOB_CODE가 J7이거나 J6이면서 SALARY값이 200만원 이상이고
--BONUS가 있고 여자이며 이메일주소는 _ 앞에 3글자만 있는 사원의 이름 ,주민번호, 직급코드, 부서코드, 급여, 보너스 조회
--정상적으로 조회되면 결과가 2개가 나와야함

SELECT EMP_NAME AS 사원명, 
        EMP_NO AS 주민번호, 
        JOB_CODE AS 직급코드, 
        DEPT_CODE AS 부서코드,
        SALARY AS 봉급, 
        SALARY*BONUS AS 보너스
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7', 'J6')
    AND SALARY >= 2000000
    AND BONUS IS NOT NULL
    AND SUBSTR(EMP_NO,8,1) = 2
    AND INSTR(EMAIL,'_')-1 = 3;


SELECT EMP_NAME AS 사원명, 
        RPAD(SUBSTR(EMP_NO,1,(INSTR(EMP_NO,'-')+1)),14,'*') AS 주민번호, 
        JOB_CODE AS 직급코드, 
        DEPT_CODE AS 부서코드,
        SALARY AS 봉급, 
        SALARY*BONUS AS 보너스
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7', 'J6')
    AND SALARY >= 2000000
    AND BONUS IS NOT NULL
    AND SUBSTR(EMP_NO,8,1) = 2
    AND INSTR(EMAIL,'_')-1 = 3;



