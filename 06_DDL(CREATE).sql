/*
    DDL: 데이터 정의 언어
    오라클에서 제공하는 객체를 새로 만들고(CREATE),
    구조를 변경하고(ALTER),
    구조자체를 삭제(DELETE)
    
    즉, 실제 데이터 값이 아닌 규칙 자체를 정의하는 언어
    오라클에서의 객체(구조): 테이블, 뷰, 시퀀스, 인덱스, 패키지, 트리거
                        프로시저, 함수, 동의어, 사용자

    CREATE
    객체를 새로 생성하는 구문
*/

/*
    1. 테이블 생성
    테이블이란?
    행과 열로 구성되는 가장 기본적인 데이터베이스 객체
    모든 데이터들은 테이블을 통해서 저장됨
    
    CREATE TABLE 테이블 명(
        컬렴명 자료형(크기),
        컬렴명 자료형(크기),
        컬렴명 자료형,
        ...
    )
    
    자료형
    - 문자(CHAR(바이트크기) | VARCHAR2(바이트크기))
        CHAR: 최대 2000바이트까지 지정가능 / 고정길이(고정된 글자수의 데이터가 담길 경우)
        (지정한 크기보다 더 작은 값이 들어오면 공백으로라도 채워서 처음 지정한 크기를 만들어준다.)
        VARCHAR2: 최대 4000바이트까지 지정가능 / 가변길이(몇글자가의 데이터가 담길지 모르는 경우)
        (담긴 값에 따라서 공간 크기가 맞춰짐)
        
    - 숫자(NUMBER)
    - 날짜(DATE)
    
*/

--회원에 대한 데이터를 담기위한 테이블 MEMBER 생성
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

SELECT * FROM MEMBER;

-- 데이터 딕셔너리: 다양한 객체들의 정보를 저장하고 있는 시스템 테이블
SELECT * FROM USER_TABLES;
SELECT * FROM USER_TAB_COLUMNS;