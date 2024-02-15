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
