/* 
    SELECT
    SELECT ������������ ����(�÷�) FROM ���̺�;
    SELECT (*) �Ǵ� �÷�1, �÷�2, �÷�3 ... FROM ���̺�;
*/

-- ��� ��� ����
SELECT * FROM EMPLOYEE;

-- ��� ��� �̸�, �ֹι�ȣ, �ڵ�����ȣ
SELECT EMP_NAME, EMP_NO, PHONE FROM EMPLOYEE;


---------�ǽ�--------
-- JOB ���̺��� ���޸� �÷��� ��ȸ
SELECT JOB_NAME FROM JOB;
-- DEPARTMENT ���̺��� ��� �÷� ��ȸ
SELECT * FROM DEPARTMENT;
-- DEPARTMENT ���̺��� �μ��ڵ� �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;
-- DEPARTMENT ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY FROM EMPLOYEE;

-- <�÷����� ���� �������>
-- SELECT�� �÷��� �ۼ��κп� ������� ����

-- ex) EMPLOYEE���̺��� �����, ������ ��ȸ, EMPLOYEE���� ���������� ����
-- ������ SALARY*12
SELECT EMP_NAME, SALARY*12 FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �޿�, ���ʽ�, ����, ���ʽ� ���� ���� ��ȸ
SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY + (SALARY*BONUS))*12 FROM EMPLOYEE;

-- ������� ���� �� NULL �����Ͱ� ���ԵǾ� �ִٸ� ������ ������� NULL�̴�.

-- �����, �Ի���, �ٹ��ϼ� ��ȸ
-- ����ð� - �Ի��� = �ٹ��ϼ�
-- DATE - DATE => �Ϸ� ǥ��
-- SYSDATE : �ڵ� ������ ��¥ : [��/��/��/��/��/��]

SELECT EMP_NAME as �����, 
HIRE_DATE as ä������,
SYSDATE - HIRE_DATE as �ٹ�����
FROM EMPLOYEE;

-- DUAL: ����Ŭ���� �������ִ� �������� ���̺�(���̵�����)
SELECT SYSDATE FROM DUAL;

/*
    <�÷��� ��Ī �����ϱ�>
    ��������� �ϰԵǸ� �÷����� �����������µ�
    �̶� �÷����� ������ �� �ִ�.
    [ǥ����]
    �÷��� ��Ī / �÷��� as ��Ī / �÷��� "��Ī" / �÷��� as "��Ī"
*/

SELECT EMP_NAME �����,
SALARY as �޿�,
(SALARY*BONUS) "�󿩱�",
(SALARY+(SALARY*BONUS))*12 as ����
FROM EMPLOYEE;

/*
    <���ͷ�>
    ���Ƿ� ������ ���ڿ�(' ')
    ��ȸ�� ���(RESULT SET)�� ��� �࿡ �ݺ������� ����ϰ��� �� ��
*/

-- EMPLOYEE ���̺��� ���, �����, �޿�
SELECT EMP_ID, EMP_NAME, SALARY,'��' as ���� FROM EMPLOYEE;


/*
    <���Ῥ����: ||>
    ���� �÷������� ��ġ �ϳ��� �÷�ó�� ������ �� �ִ�.
    
*/
SELECT EMP_ID, EMP_NAME, SALARY || '��' as «�� FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ��� ����� ������ ��ȸ
-- ������ ���� ��ȸ�غ���

SELECT EMP_NAME || '�� ' || '������ ' || SALARY || '�� �Դϴ�.' as ��� FROM EMPLOYEE;

/*
    <DISTINCT>
    �ߺ����� - �÷��� ǥ�õ� ������ �ѹ����� ��ȸ�ϰ��� �� �� ���
*/

-- EMPLOYEE �����ڵ� ��ȸ
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE �μ��ڵ� ��ȸ
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

-- SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE FROM EMPLOYEE;
-- DISTINCT�� �� ���� ��� ����

SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;
-- JOB_CODE�� DEPT_CODE ��� ���� �ߺ��� ����

/*
    <WHERE��>
    ��ȸ�ϰ����ϴ� ���̺�κ��� 
    Ư�� ���ǿ� �����ϴ� �����͸� ��ȸ�� �� ���
    ���ǽĿ����� �پ��� ������ ����� ����
    [ǥ����]
    SELECT �÷�, �÷� ... FROM ���̺�
    WHERE ����;
    
    �񱳿�����
    >, <, >=, <=, : ��Һ�
    =             : ������ ����.
    !=, ^=, <>    : ������ �ٸ���.
*/

-- EMPLOYEE���� �μ��ڵ尡 'D9'�� ����鸸 ��ȸ(��� �÷�)
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE���� �μ��ڵ尡 'D1'�� ������� �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_NAME as �����, 
SALARY as �޿�, 
DEPT_CODE as �μ��ڵ�
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE���� �μ��ڵ尡 'D1'�� �ƴ� ������� �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_NAME as �����, 
SALARY as �޿�, 
DEPT_CODE as �μ��ڵ�
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';

-- ������ 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME as �����,
DEPT_CODE as �μ��ڵ�,
SALARY as �޿�
FROM EMPLOYEE
WHERE SALARY >= 4000000;

------------------------�ǽ�---------------------------

-- 1. �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ���� ��ȸ(��Ī->����) ��ȸ
SELECT EMP_NAME as �����,
SALARY as �޿�,
HIRE_DATE as �Ի���,
SALARY * 12 as ����
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. ������ 5õ���� �̻��� ������� �����, �޿�, ����(��Ī -> ����), �μ��ڵ� ��ȸ
SELECT EMP_NAME as �����,
SALARY as �޿�,
SALARY * 12 as ����,
DEPT_CODE as �μ��ڵ�
FROM EMPLOYEE
WHERE SALARY*12 > 50000000;
-- ������� FROM -> WHERE -> SELECT

-- 3. �����ڵ尡 'J3'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ
SELECT EMP_ID as ���,
EMP_NAME as �����,
JOB_CODE as �����ڵ�,
ENT_YN as ��翩��
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- 4. �޿��� 350���� �̻� 600���� ������ ��� ����� �����, ���, �޿� ��ȸ
SELECT EMP_NAME as �����, 
EMP_ID as ���,
SALARY as �޿�
FROM EMPLOYEE
WHERE SALARY >= 3500000 and SALARY <= 6000000;

/*
    AND, OR
    [ǥ����]
    ����A AND ����B -> ����A�� ����B ��� �����ϴ� �� ������
    ����A OR ����B -> ����A�� ����B �� �ϳ��� �����ϴ� �� ������

    BETWEEN AND
    ���ǽĿ� ���Ǵ� ����
    �� �̻� �� ���� ������ ���� ������ ������ �� ����ϴ� ������
    [ǥ����]
    �񱳴�� �÷� BETWEEN ���Ѱ� AND ���Ѱ�
    
    
*/

-- �޿��� 350���� �̻� 600���� ������ ��� ����� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;
-- WHERE SALARY >= 3500000 AND SALARY <= 6000000

-- �޿��� 350���� �̸� 600���� �ʰ��� ��� ����� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY < 3500000 OR SALARY > 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- NOT: ������������
-- �÷��� �� �Ǵ� BETWEEN �տ� ���� ����

-- �Ի����� '90/01/01' ~ '01/01/01' ��� ��ü ��ȸ
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
-- DATE�� �� ����

--------------------------------------------------------------------------

/*
    LIKE
    ���ϰ����ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��쿡 ��ȸ
    [ǥ����]
    ���� ��� Į�� LIKE 'Ư������';
    
    Ư�������� ������ �� ���ϵ�ī���� Ư�������� ���ǵǾ��ִ�.
    '%': ���Թ��� �˻�(0���� �̻� ���� ��ȸ)
    ex) �񱳴���÷� LIKE '����%': �񱳴���÷��� �� �ش� ���ڷ� �����ϴ� ���鸸 ��ȸ
        �񱳴���÷� LIKE '%����': �񱳴���÷��� �� �ش� ���ڷ� ������ ���鸸 ��ȸ
        �񱳴���÷� LIKE '%����%' : �񱳴���÷��� �� �ش� ���ڰ� ���Ե� �� ��ȸ
    '_': �ѱ��ڸ� ��ü�ϴ� �˻�
    ex) �񱳴���÷� LIKE '_����': �񱳴���÷��� �� ���� �տ� �ƹ����ڳ� N���� ���ڰ� �ִ� �� ��ȸ
        �񱳴���÷� LIKE '����_': �񱳴���÷��� �� ���� �ڿ� �ƹ����ڳ� N�� ���ڰ� �ִ� �� ��ȸ
        �񱳴���÷� LIKE '_����_': �񱳴���÷��� �� ���� ��, �ڿ� �ƹ����ڳ� N�� ���ڰ� �ִ� �� ��ȸ
        

*/

-- ����� �� ���� '��'�� ������� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- ����� �� �̸��� '��'��� ���ڰ� ���Ե� ����� ��ȭ��ȣ ��� ��ȸ
SELECT PHONE, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

--����� �� �̸��� �߰����ڰ� '��'�� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

--��ȭ��ȣ�� 3��° �ڸ��� 1�� ������� ���, �����, ��ȭ��ȣ ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

--�̸��� �� _ �ձ��ڰ� 3������ ������� ���, �̸� �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '____%'; -> ���ϵ�ī�� ���ڶ����� ������� ���� ����
-- ���ϵ�ī�� ���ڿ� �Ϲݹ����� ������ �ʿ�
-- �����Ͱ����� ����ϰ���� ���ϵ�ī�� ���� �տ� ������ Ż�⹮�ڸ� �����ؼ� Ż������ָ� �ȴ�.
-- ESCAPE OPTION�� ����ؼ� ���
WHERE EMAIL LIKE '___\_%' ESCAPE '\';

--�� ������� �ƴ� �� �� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL, EMP_NO
FROM EMPLOYEE
WHERE EMAIL NOT LIKE '___\_%' ESCAPE '\';

--==================�ǽ�===================
-- 1. �̸��� '��'���� ������ ������� �����, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';
-- 2. ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
-- 3. �̸��� '��'�� ���ԵǾ��ְ� �޿��� 240���� �̻��� ������� �����, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' 
AND SALARY >= 2400000;
-- 4. �μ����̺��� �ؿܿ������� �μ����� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';

--==========================================================
/*
    IN
    WHERE������ �񱳴�� �÷����� ���� ������ ��� �߿� ��ġ�ϴ� ���� �����ϴ��� �˻�
    [ǥ����]
    �񱳴���÷� IN('��1', '��2', ...)
    
*/

-- �μ��ڵ尡 D6�̰ų� D8�̰ų� D5 �� �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6', 'D8', 'D5');
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';

-- ====================================================================

/*
    IS NULL & IS NOT NULL
    �÷����� NULL�� ���� ��� NULL���� ���ϱ� ���ؼ��� �� ������ ���
*/

-- ���ʽ��� �������� ������� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ������� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- ����� ���� ������� �����, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--�μ���ġ�� ���� �ʾҰ� ���ʽ��� �޴� ������� �̸�, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL and BONUS IS NOT NULL;

--===============================================================

/*
    ������ �켱����
    1. ���������
    2. ���Ῥ����
    3. �񱳿�����
    4. IS NULL / LIKE / IN
    5. BETWEEN A AND B
    6. NOT
    7. AND
    8. OR
*/

--�����ڵ尡 J7�̰ų� J2�� ����� �߿� �޿��� 200���� �̻��� ������� ����÷� ��ȸ
SELECT * FROM EMPLOYEE
WHERE JOB_CODE IN ('J7' , 'J2') and SALARY >= 2000000;

--===========================�ǽ�����==============================
-- 1. ����� ���� �μ���ġ�� ���� ���� ������� �����, ���, �μ��ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 2. ����(���ʽ� ������)�� 3õ���� �̻��̰� ���ʽ��� ���� �ʴ� ������� ���, �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE (SALARY*12 >= 30000000) AND BONUS IS NULL;

-- 3. �Ի����� '95/01/01' �̻��̰� �μ���ġ�� ���� ���� ������� ���, �����, �Ի���, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NULL;

-- 4. �޿��� 200���� �̻��̰� 500���� ������ ��� �� �Ի����� '01/01/01' �̻��̰� ���ʽ��� ���� �ʴ� ������� ���, �����, �޿�, �Ի��� ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 5000000) 
AND HIRE_DATE >= '01/01/01' AND BONUS IS NULL;

-- 5. ���ʽ��� ���� ������ NULL�� �ƴϰ� �̸��� '��'�� ���Ե� ������� ���, �����, �޿�, ���ʽ� ���� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, (SALARY +(SALARY*BONUS))*12 as ���ʽ����Կ���
FROM EMPLOYEE
WHERE (SALARY +(SALARY*BONUS))*12 IS NOT NULL AND EMP_NAME LIKE '%��%';
