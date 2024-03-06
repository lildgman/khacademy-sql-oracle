SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

/*
    ORDER BY
    SELECT�� ���� ������ �ٿ� �ۼ�
    ��������� �������� ����
    
    [ǥ����]
    SELECT ��ȸ�� �÷� 
    FROM ��ȸ�� ���̺�
    WHERE ���ǽ�
    ORDER BY ���ı����� �� �÷��� | ��Ī | �÷� ���� 
    [ ASC | DESC ][ NULL FIRST | NULL LAST ] <- ��������
    
    - ASC: ��������(������ -> ū��), �⺻��
    - DESC: ��������(ū�� -> ������)
    
    -- NULL�� �⺻������ ���� ū ������ �з��ؼ� ����
    - NULLS FIRST: �����ϰ����ϴ� �÷����� NULL�� ���� ��� �ش� ������ �� �տ� ��ġ(DESC�� �� �⺻��)
    - NULLS LAST: �����ϰ����ϴ� �÷����� NULL�� ���� ��� �ش� ������ �� �ڿ� ��ġ(ASC�� �� �⺻��)
*/

SELECT * FROM EMPLOYEE
--ORDER BY BONUS; -- �⺻���� ��������
--ORDER BY BONUS ASC;
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- NULLS FIRST �⺻

-- ���ı��ؿ� �÷����� ������ ��� ���ı����� �� ���� ������ ���� ���� ���� ������ �� �ִ�.
ORDER BY BONUS DESC, SALARY ASC;

-- �� ����� �����, ���� ��ȸ(���ʽ� ����),�� �� ������ �������� ����
SELECT EMP_NAME, SALARY, SALARY*12 AS ����
FROM EMPLOYEE
ORDER BY ���� DESC;
--ORDER BY 3 DESC; -- �÷� �������� ���� ����(��ȣ���� ����)

--========================================================================

/*
    �Լ� FUNCTION
    ���޵� �÷����� �о�鿩�� �Լ��� ������ ����� ��ȯ
    
    - ������ �Լ�: N�� ���� �о�鿩�� N�� ������� ����(�� �ึ�� �Լ� ���� ��� ��ȯ)
    - �׷��Լ�: N�� ���� �о�鿩�� 1���� ��� ���� ����(�׷��� ��� �׷캰�� �Լ� ������ ��ȯ)
    
    SELECT ���� ������ �Լ��� �׷��Լ��� �Բ� ������� ����
    -> ��� ���� ������ �ٸ��� ����
    
    �Լ����� ����� �� �ִ� ��ġ: SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
    
*/

--==================������ �Լ�====================

/*
    ���� ó�� �Լ�
    LENGTH(�÷� | '���ڿ�'): �ش� ���ڿ��� ���ڼ� ��ȯ
    LENGTHB(�÷� | '���ڿ�'): �ش� ���ڿ��� ����Ʈ�� ��ȯ
    
    '��', '��' �� �ѱ��� ���ڴ� 3BYTE
    ����, ����, Ư�����ڴ� ���ڴ� 1BYTE
*/

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;

SELECT LENGTH('oracle'), LENGTHB('ORACLE')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

------------------------------------------------------------------------

/*
    INSTR
    ���ڿ��κ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷� | '���ڿ�', 'ã�����ϴ� ����',['ã�� ��ġ�� ���۰�', ����]) => ����� NUMBER�� ����
*/

SELECT INSTR('AABAACAABBAA','B')FROM DUAL; -- ���ʿ� �ִ� ù B�� 3��° ��ġ�� �ִٰ� ����
-- ã�� ��ġ ���۰�: 1, ����: 1 => �⺻��
SELECT INSTR('AABAACAABBAA','B', -1)FROM DUAL; -- -1�� �ڿ������� ã�ڴ�. ���� ���� �տ������� �о �˷���
SELECT INSTR('AABAACAABBAA','B', 1, 2)FROM DUAL; -- ������ �����Ϸ��� ã�� ��ġ�� ���۰��� ǥ���ؾ���
SELECT INSTR('AABAACAABBAA','B', 1, 3)FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_') AS "_��ġ", INSTR(EMAIL, '@') AS "@��ġ"
FROM EMPLOYEE;

SELECT EMAIL,INSTR(EMAIL,'_')-1
FROM EMPLOYEE;

--========================================================================================

/*
    SUBSTR -- ���� ����
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
    
    [ǥ����]
    SUBSTR(STRING, POSITION, [LENGTH])
    - STRING: ����Ÿ���� �÷� | '���ڿ�'
    - POSITION: ���ڿ� ������ ������ġ�� ��
    - LENGTH: ������ ���� ����(�����ϸ� ������)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7��° ��ġ���� ������
SELECT SUBSTR('SHOWMETHEMONEY', 5,2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',1,6) FROM DUAL; --SHOWME
SELECT SUBSTR('SHOWMETHEMONEY', -8,3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1) AS ����
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'_')-1)
FROM EMPLOYEE;

-- ����� �� ������鸸 ��ȸ
SELECT EMP_NAME, EMP_NO 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (2,4);

-- ����� �� ������鸸 ��ȸ
SELECT EMP_NAME, EMP_NO 
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1
ORDER BY EMP_NAME;

SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,INSTR(EMP_NO,'-')+1,1) = 2;

-- �Լ� ��ø ��� ����
-- �̸��� ���̵� �κи� ����
-- �����Ͽ��� �����, �̸���, ���̵� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,(INSTR(EMAIL,'@')-1)) AS ���̵�
FROM EMPLOYEE;

-----------------------------------------------------------------------

/*
    LPAD / RPAD
    
    ���ڿ��� ��ȸ�� �� ���ϰ��ְ� ��ȸ�ϰ��� �� �� ���
    
    [ǥ����]
    LPAD/RPAD(STRING, ���������� ��ȯ�� ������ ����, [�����̰��� �ϴ� ����])
    
    ���ڿ��� �����̰����ϴ� ���ڸ� ���� �Ǵ� �����ʿ� �ٿ��� ���� N���� ��ŭ ���ڿ��� ��ȯ
    
*/

-- 20��ŭ�� ���� �� EMAIL �÷����� ���������� �����ϰ�, ������ �κ��� �������� ä���
SELECT EMP_NAME, LPAD(EMAIL, 20, ' ')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- ������� ����� �ֹι�ȣ ��ȸ("910524-1******")
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*') AS �ֹι�ȣ
FROM EMPLOYEE;

SELECT RPAD(SUBSTR(EMP_NO,1,(INSTR(EMP_NO,'-')+1)),14,'*')
FROM EMPLOYEE;

---------------------------------------------------------------------------

/*
    LTRIM / RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ ������ ��ȯ
    LTRIM/RTRIM(STRING, [�����ϰ����ϴ� ���ڵ�])
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ����ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ� ��ȯ
    
*/

SELECT LTRIM('    K    H') FROM DUAL;
SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('ACABACCKH','ABC') FROM DUAL; -- �����ϰ��� �ϴ� ���ڴ� ���ڿ��� �ƴ� ���ڵ�
SELECT RTRIM('574185KH323','01234556') FROM DUAL;

/*
    TRIM
    ���ڿ��� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    TRIM([LEADING | TRAILING | BOTH] �����ϰ����ϴ� ���ڿ� FROM ���ڿ�)
*/

SELECT TRIM('    K    H    ') FROM DUAL; -- ���� ���� ����
SELECT TRIM('Z' FROM 'ZZZZKHZZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; --LTRIM
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL; -- RTRIM
SELECT TRIM(BOTH 'Z' FROM 'ZZZZKHZZZZ') FROM DUAL;

----------------------------------------------------------------------

/*
    LOWER / UPPER / INITCAP

    LOWER: �� �ҹ��ڷ� ������ ���ڿ� ��ȯ
    UPPER: �� �빮�ڷ� ������ ���ڿ� ��ȯ
    INITCAP: ���� ���� ù ���ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
*/
SELECT LOWER('Welcome To The Jungle') FROM DUAL;
SELECT UPPER('Welcome To The Jungle') FROM DUAL;
SELECT INITCAP('welcome to the jungle') FROM DUAL;

-----------------------------------------------------------------------

/*
    CONCAT
    ���ڿ� �� �� ���޹޾� �ϳ��� ��ģ �� ��ȯ
    CONCAT(STRING1, STRING2)
*/
SELECT CONCAT('������','ABC') FROM DUAL; -- CONCAT�� �� �� ���ڿ��� ����
SELECT '������' || '��������' || '������' FROM DUAL;

------------------------------------------------------------------------

/*
    REPLACE
    Ư�� ���ڿ����� Ư���κ��� �ٸ��κ����� ��ü
    REPLACE(���ڿ�, ã�� ���ڿ�, ������ ���ڿ�)
*/

SELECT EMAIL, REPLACE(EMAIL, 'KH.or.kr', 'gmail.com')
FROM EMPLOYEE;

-------------------------------------------------------------------------

/*
    ���� ó�� �Լ�
    ABS
    ������ ���밪�� �����ִ� �Լ�
    
*/

SELECT ABS(-10), ABS(-55.4) FROM DUAL;

--------------------------------------------------------------------------
/*
    MOD
    �� ���� ���� ������ ���� ��ȯ
    MOD(NUMBER, NUMBER)
*/

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9, 4.2) FROM DUAL;

--------------------------------------------------------------------------

/*
    ROUND
    �ݿø��� ����� ��ȯ
    
    ROUND(NUMBER, [��ġ])
*/

SELECT ROUND(123.456,0) FROM DUAL; -- �Ҽ� ù° �ڸ����� �ݿø�
SELECT ROUND(123.456, 1) FROM DUAL; -- ����� �����Ҽ��� �Ҽ��� �ڷ� ��ĭ�� �̵�
SELECT ROUND(123.456, -1) FROM DUAL; -- ������ �����Ҽ��� �Ҽ��� ���ڸ��� �̵�

/*
    CEIL
    �ø�ó���� ���� �Լ�, �Ҽ��� ù°�ڸ����� �ø�(���� ����)
    
    [ǥ����]
    CEIL(NUMBER)
*/

SELECT CEIL(124.1966666) FROM DUAL; -- �Ҽ��� ù°�ڸ����� �ø�

/*
    FLOOR
    ����ó�� �Լ�, �Ҽ��� ù°�ڸ����� ����(���� ����)
    
    TRUNC
    ����ó�� �Լ�, ��𼭺��� ���� �� ���� ����
    
    [ǥ����]
    FLOOR(NUMBER), TRUNC(NUMBER, [��ġ])

*/
SELECT FLOOR(214.1966666) FROM DUAL; -- �Ҽ��� ù°�ڸ����� ����

SELECT TRUNC(123.4445) FROM DUAL;
SELECT TRUNC(123.4445, 1) FROM DUAL;
SELECT TRUNC(123.4445, -1) FROM DUAL;

---------------------------------QUIZ-------------------------------------
--�˻��ϰ��� �ϴ� ����
--JOB_CODE�� J7�̰ų� J6�̸鼭 SALARY���� 200���� �̻��̰�
--BONUS�� �ְ� �����̸� �̸����ּҴ� _ �տ� 3���ڸ� �ִ� ����� �̸� ,�ֹι�ȣ, �����ڵ�, �μ��ڵ�, �޿�, ���ʽ� ��ȸ
--���������� ��ȸ�Ǹ� ����� 2���� ���;���

SELECT EMP_NAME AS �����, 
        EMP_NO AS �ֹι�ȣ, 
        JOB_CODE AS �����ڵ�, 
        DEPT_CODE AS �μ��ڵ�,
        SALARY AS ����, 
        SALARY*BONUS AS ���ʽ�
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7', 'J6')
    AND SALARY >= 2000000
    AND BONUS IS NOT NULL
    AND SUBSTR(EMP_NO,8,1) = 2
    AND INSTR(EMAIL,'_')-1 = 3;


SELECT EMP_NAME AS �����, 
        RPAD(SUBSTR(EMP_NO,1,(INSTR(EMP_NO,'-')+1)),14,'*') AS �ֹι�ȣ, 
        JOB_CODE AS �����ڵ�, 
        DEPT_CODE AS �μ��ڵ�,
        SALARY AS ����, 
        SALARY*BONUS AS ���ʽ�
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7', 'J6')
    AND SALARY >= 2000000
    AND BONUS IS NOT NULL
    AND SUBSTR(EMP_NO,8,1) IN (2,4)
    AND INSTR(EMAIL,'_')-1 = 3;

--=========================================================================
/*
    ��¥ ó�� �Լ� 
*/

-- SYSDATE: �ý����� ���� ��¥ �� �ð� ��ȯ
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN: �� ��¥ ������ ���� ��
-- ������� �����, �Ի���, �ٹ��ϼ�, �ٹ������� ��ȸ
SELECT EMP_NAME AS �����, 
    HIRE_DATE AS �Ի���, 
    TRUNC(SYSDATE - HIRE_DATE) AS �ٹ��ϼ�, 
    CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '������' AS �ټӰ���
FROM EMPLOYEE;

-- ADD_MONTH: Ư�� ��¥�� NUMBER�������� ���� ��ȯ
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL;

-- �ٷ��� ���̺��� �����, �Ի���, �Ի� �� 3���� ���� ��¥(������ ��ȯ��)
SELECT EMP_NAME AS �����,
    HIRE_DATE AS �Ի���,
    ADD_MONTHS(HIRE_DATE, 3) AS "������ ��ȯ��"
FROM EMPLOYEE;

-- NEXT_DAY(DATE, ����(���� | ����)): Ư����¥ ���� ���� ����� ������ ��¥ ��ȯ
SELECT NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 7) FROM DUAL;
-- 1: �� ~ 7: ��
SELECT NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL; -- �� �ٲ������
SELECT NEXT_DAY(SYSDATE, 'WED') FROM DUAL; -- �� �ٲ������

--��� ����
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; 
ALTER SESSION SET NLS_LANGUAGE = KOREAN; 

-- LAST_DAY(DATE): �ش� ���� ������ ��¥ ���ؼ� ��ȯ
SELECT LAST_DAY(HIRE_DATE) FROM EMPLOYEE;

-- ������̺��� �����, �Ի���, �Ի���� ������ ��¥, �Ի���� �ٹ��ϼ� ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

/*
    EXTRACT: Ư�� ��¥�κ��� �⵵|��|�� ���� �����ؼ� ��ȯ�ϴ� �Լ�
    
    [ǥ����]
    EXTRACT(YEAR FROM DATE): ������ ����
    EXTRACT(MONTH FROM DATE): ���� ����
    EXTRACT(DAY FROM DATE): �ϸ� ����
*/

-- ����� �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) AS �Ի�⵵,
    EXTRACT(MONTH FROM HIRE_DATE) AS �Ի��,
    EXTRACT(DAY FROM HIRE_DATE) AS �Ի���
FROM EMPLOYEE
ORDER BY 2,3,4;

--==========================================================
/*
    [����ȯ �Լ�]
    TO_CHAR: ���� Ÿ�� �Ǵ� ��¥ Ÿ���� ���� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    [ǥ����]
    TO_CHAR(����|��¥,[����])
*/

SELECT TO_CHAR(123) FROM DUAL;
SELECT TO_CHAR(123, '999999') AS NUM FROM DUAL; -- '9' 9�� �ڸ�����ŭ ����Ȯ��, ������ ����, �� ĭ ����
SELECT TO_CHAR(123, '00000') AS NUM FROM DUAL; -- '0' 0�ڸ��� ��ŭ ����Ȯ��, ������ ����, �� ĭ 0���� ä��
SELECT TO_CHAR(1234,'L99999') FROM DUAL; -- ���� ������ ������ ���� ȭ����� ����
SELECT TO_CHAR(500000000,'L999,999,999') FROM DUAL;

-- ������� �����, ����, ������ ��ȸ
SELECT EMP_NAME AS �����, 
    TO_CHAR(SALARY,'L99,999,999') AS ����, 
    TO_CHAR(SALARY*12,'L99,999,999') AS ����
FROM EMPLOYEE;

-- ��¥Ÿ�� => ����Ÿ��
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH:MI:ss') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- AM, PM ����� ���� ���Ŀ� ���� ����
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; -- 24�ð� �������� ǥ��
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

-- ������� �̸�, �Ի糯¥(0000�� 00�� 00��) ��ȸ
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') AS �Ի糯¥ -- ������ ���Ĵ�θ� ��� ����
FROM EMPLOYEE;

-- �⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
    TO_CHAR(SYSDATE, 'YY'),
    TO_CHAR(SYSDATE, 'RRRR'), --RR���� ����, 50�� �̻� ���� ���� +100�� ������
    TO_CHAR(SYSDATE, 'RR'),
    TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

SELECT HIRE_DATE, TO_CHAR(HIRE_DATE)FROM EMPLOYEE;


ALTER SESSION SET NLS_LANGUAGE = KOREAN; 

-- ���� ���õ� ����
SELECT TO_CHAR(SYSDATE,'MM') -- �̹� �� ���� ���ڸ�
    ,TO_CHAR(SYSDATE,'MON') -- �� ���
    ,TO_CHAR(SYSDATE,'MONTH')
FROM DUAL;

-- �Ͽ� ���õ� ����
SELECT TO_CHAR(SYSDATE,'DDD')  --������ �̹��⵵���� ���° �ϼ�����
    , TO_CHAR(SYSDATE,'DD') -- ������ ��ĥ����
    , TO_CHAR(SYSDATE,'D') -- ���� -> ����
FROM DUAL;

--���Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE,'DAY')
    , TO_CHAR(SYSDATE,'DY')
FROM DUAL;

--==================================================================

/*
    TO_DATE: ����Ÿ�� OR ����Ÿ���� ��¥Ÿ������ �����ϴ� �Լ�
    
    TO_DATE(���� | ����, [����]) => DATE
*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE('100101') FROM DUAL;
SELECT TO_DATE(220219) FROM DUAL; -- 50�� �̸��� �ڵ����� 20XX���� �����ǰ�, 50�� �̻��� 19XX�� �����ȴ�.

SELECT TO_DATE(20020505) FROM DUAL; -- ���ڴ� 0���� �����ϸ� �ȵ�
SELECT TO_DATE('020505') FROM DUAL;

SELECT TO_DATE('20240219 140830','YYYYMMDD HH24MISS') FROM DUAL; -- ������ ������� ��, ��, �ʸ� ǥ���� �� �ִ�.
--======================================================================

/*
    TO_NUMBER: ����Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    [ǥ����]
    TO_NUMBER(����,[����])
*/

SELECT TO_NUMBER('051233123') FROM DUAL;

SELECT '100000' + '55000' FROM DUAL;
SELECT '100,000' + '55,000' FROM DUAL; -- , �� ���־� ���ڷ� ���

SELECT TO_CHAR(TO_NUMBER('100,000','999,999') + TO_NUMBER('55,000','99,999'),'999,999,999') FROM DUAL;

--=========================================================================

/*
    [NULL ó�� �Լ�]
*/

-- NVL(�÷�, �ش� �÷��� NULL�� ��� ������ ��)
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

-- �� ����� �̸�, ���ʽ� ���� ����
SELECT EMP_NAME, (SALARY + (SALARY * NVL(BONUS,0))) * 12
FROM EMPLOYEE;

-- NVL2(�÷�, ��ȯ��1, ��ȯ��2)
-- ��ȯ�� 1: �ش� �÷��� ������ ��� ������ ��
-- ��ȯ�� 2: �ش� �÷��� NULL�� ��� ������ ��

SELECT EMP_NAME, BONUS, NVL2(BONUS, 'O', 'X')
FROM EMPLOYEE;

-- ������� ��� ��� �μ� ��ġ���� ��ȸ
SELECT EMP_NAME AS �����,
NVL2(DEPT_CODE, '�����Ϸ�', '�̹���') AS ��ġ����
FROM EMPLOYEE;

-- NULLIF(�񱳴��1, �񱳴��2)
-- �� ���� ��ġ�ϸ� NULL, ��ġ���� �ʴ´ٸ� �񱳴��1 ��ȯ
SELECT NULLIF('123','123') FROM DUAL;
SELECT NULLIF('123','1234') FROM DUAL;

--==========================================================================

/*
    [�����Լ�]
    DECODE(���ϰ����ϴ� ���(�÷�, �����, �Լ���), �񱳰�1, �����1, �񱳰�2, �����2, �񱳰�3,�����3, ...)
    
    �ڹ��� ���
    SWITCH(�񱳴��){
        CASE �񱳰�1:
            �����ڵ�
        CASE �񱳰�2:
            �����ڵ�
            ...
    }
    
*/
-- ���, �����, �ֹι�ȣ, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, EMP_NO,
    DECODE(SUBSTR(EMP_NO,(INSTR(EMP_NO,'-')+1),1),'1','��', '2','��') AS ����
FROM EMPLOYEE;

-- ������ �޿� ��ȸ, �޿� ��ȸ * �� ���޺��� �λ��ؼ� ��ȸ
-- J7�̸� �޿��� 10% �λ�
-- J6�̸� �޿��� 15% �λ�
-- J5�̸� �޿��� 20% �λ�
-- �� �� ������� �޿��� 5% �λ�

SELECT EMP_NAME AS �����, 
    JOB_CODE AS ����,
    SALARY AS �λ���, 
    DECODE(JOB_CODE,
        'J7',SALARY*1.1,
        'J6',SALARY*1.15,
        'J5',SALARY*1.2,
        SALARY*1.05) AS �λ���
FROM EMPLOYEE
ORDER BY JOB_CODE;

/*
    CASE WHEN THEN
    
    CASE 
        WHEN ���ǽ�1 THEN �����1
        WHEN ���ǽ�2 THEN �����2
        ...
        ELSE �����
    END
*/
SELECT EMP_NAME, SALARY,
    CASE 
        WHEN SALARY >= 5000000 THEN '���'
        WHEN SALARY >= 3500000 THEN '�߱�'
        ELSE '�ʱ�'
    END AS �޼�
FROM EMPLOYEE;

--=======================�׷��Լ�===========================
-- 1. SUM(����Ÿ���÷�): �ش��÷� ������ �� �հ踦 ���ؼ� ��ȯ���ִ� �Լ�

--�ٷ������̺��� ������� �� �޿�
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- ���� ������� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,INSTR(EMP_NO,'-')+1,1) IN (1,3);


-- �μ��ڵ尡 D5�� ������� �� ����
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


-- 2. AVG(NUMBER): �ش� �÷������� ��հ�
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(���Ÿ�԰���): �ش� �÷��� �� ���� ���� �� ���ؼ� ��ȯ
SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 4. MAX(��� Ÿ�� ����) : �ش� �÷����� �� ���� ū ���� ���ؼ� ��ȯ
SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- 5. COUNT(* | �÷� | DISTINCT �÷�): �ش� ���ǿ� �´� ���� ������ ���� ��ȯ
-- COUNT(*): ��ȸ�� ����� ��� ���� ������ ���� ��ȯ
-- COUNT(�÷�): ������ �ش� �÷����� NULL�� �ƴ� �͸� ���� ������ ���� ��ȯ
-- COUNT(DISTINCT �÷�): �ش� �÷����� �ߺ��� ������ �� ���� ������ ���� ��ȯ

-- ��ü ��� ��
SELECT COUNT(*) AS ����� FROM EMPLOYEE;

SELECT COUNT(DISTINCT JOB_CODE) FROM EMPLOYEE;

-- ���� ��� ��
SELECT COUNT(*) AS "���� ��� ��"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,INSTR(EMP_NO,'-')+1,1) IN ('2','4');

-- ���ʽ��� �޴� ��� ��
--SELECT COUNT(*) AS "���ʽ��� �޴� ��� ��"
--FROM EMPLOYEE
--WHERE BONUS IS NOT NULL;
SELECT COUNT(BONUS)
FROM EMPLOYEE;

-- �μ���ġ�� ���� ��� ��
--SELECT COUNT(*) AS "�μ���ġ"
--FROM EMPLOYEE
--WHERE DEPT_CODE IS NOT NULL;

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- ���� ������� �� �� �� �μ��� �����Ǿ� �ִ���
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;
--WHERE DEPT_CODE IS NOT NULL;
