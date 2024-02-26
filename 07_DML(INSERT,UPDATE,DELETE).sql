/*
    DQL(QUERY, ������ ���Ǿ�): SELECT
    DML(MANIPULATION, ������ ���۾�): INSERT, UPDATE, DELETE
    -> C(INSERT), R(SELECT), U(UPDATE), D(DELETE)
    DDL(DEFINITION,������ ���Ǿ�): CREATE, ALTER, DROP
    DCL(CONTROL, ������ ����): GRANT, REVOKE
    TCL(TRANSACTION CONTROL): COMMIT, ROLLBACK
    
    DML: ������ ���� ���
    
    ���̺� ���� ����(INSERT)�ϰų�, ����(UPDATE), ����(DELETE)�ϴ� ����
*/

/*
    1. INSERT
        ���̺� ���ο� ���� �߰��ϴ� ����
    
    [ǥ����]
    1) INSERT INTO ���̺�� VALUES(��1, ��2, ��3,....)
    ���̺��� ��� �÷��� ���� ���� ���� �����ؼ� �� ���� INSERT�ϰ��� �� ��
    �÷��� ������ ���Ѽ� VALUES�� ���� �����ؾ���
    
    �����ϰ� ���� ������ ��� -> not enough values ��� ������ �߻��Ѵ�.
    ���� �� ���� ������ ��� -> too many values ��� ���� �߻�
*/
SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE 
VALUES(250,'�̿���','901024-1234567','250@gmail.com','01011112222',
    'D7','J5',2500000,0.2,200,sysdate,null,default);
    
/*
    2) INSERT INTO ���̺��(�÷�1, �÷�2, �÷�3) VALUES(�÷�1�� ���� ��, �÷�2�� ���� ��, �÷�3�� ���� ��);
    ���̺� ���� ������ �÷��� ���� ���� INSERT�� �� ���
    �׷��� �� �� ������ �߰��Ǳ� ������ ���� �ȵ� �÷��� �⺻������ NULL�� ���� �ȴ�.
    => NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� ���� �־���� �Ѵ�.
        ��, �⺻���� �ִ� �÷��� ���� �־����� �ʾƵ� �ȴ�. -> �־����� ������ �⺻���� ���� �ȴ�.
*/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO,JOB_CODE, HIRE_DATE)
VALUES(290, '�̱���', '990322-1234567', 'J7',SYSDATE);
    
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
        '�̿���',
        '000725-3456789',
        'J7',
        SYSDATE);

---------------------------------------------------------------------------
/*
    3) INSERT INTO ���̺�� (��������);
    VALUES�� ���� ���� ����ϴ� �� ���
    ���������� ��ȸ�� ������� ��ä�� INSERT �����ϴ�.
*/
-- ���̺� ���� �����
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
    �� �� �̻��� ���̺� ���� INSERT�� ��
    �̶� ���Ǵ� ���������� ������ ���


*/
-- �׽�Ʈ ���̺� ����
CREATE TABLE EMP_DEPT
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1=0); -- �����⸸ �����ϰ���� �� ���� �ȵǴ� ������ ����

CREATE TABLE EMP_MANAGER
AS (SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1=0);
    
-- �μ��ڵ尡 D1�� ������� ���, �̸�, �μ��ڵ�, �Ի���, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    [ǥ����]
    INSERT ALL
    INTO ���̺��1 VALUES(�÷�, �÷�, �÷�, ...)
    INTO ���̺��2 VALUES(�÷�, �÷�, �÷�, ...)
    ��������;
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
    ���̺� ��ϵǾ��ִ� ������ �����͸� �����ϴ� ����
    
    [ǥ����]
    UPDATE ���̺��
    SET �÷� = ��,
        �÷� = ��,
        ... -- AND�� �����ϴ� ���� �ƴ� ,(�޸�)�� �����Ѵ�.
    [WHERE ����] --> �����ϰ� �Ǹ� ��ü ��� ���� �����Ͱ� ����
    
    ������Ʈ�ÿ��� ���������� �� Ȯ���ؾ��Ѵ�.
*/

CREATE TABLE DEPT_TABLE
AS (SELECT * FROM DEPARTMENT);

SELECT * FROM DEPT_TABLE;

-- D9�μ��� �μ����� '������ȹ��'���� ����
UPDATE DEPT_TABLE
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';

CREATE TABLE EMP_SALARY
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE);

SELECT * FROM EMP_SALARY;
--���ö ����� �޿��� 100�������� ����
UPDATE EMP_SALARY
SET SALARY = 1000000
WHERE EMP_NAME = '���ö';
--������ ����� �޿��� 700����, ���ʽ��� 0.2�� ����
UPDATE EMP_SALARY
SET SALARY = 7000000,
    BONUS = 0.2
WHERE EMP_NAME = '������';
--��ü����� �޿��� ���� �޿��� 10���� �λ�� �ݾ����� ����(�����޿� * 1.1)
UPDATE EMP_SALARY
SET SALARY = SALARY*1.1;

-- UPDATE�� �������� ����ϱ�
/*
    UPDATE ���̺��
    SET �÷��� = (��������)
    WHERE ����
*/

-- ���� ����� �޿��� ���ʽ����� ����� ����� �޿��� ���ʽ� ������ ����

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
              FROM EMP_SALARY
              WHERE EMP_NAME = '�����'),
    BONUS = (SELECT BONUS
              FROM EMP_SALARY
              WHERE EMP_NAME = '�����')              
WHERE EMP_NAME = '����';

SELECT * FROM EMP_SALARY;

-- ���߿��� ����
UPDATE EMP_SALARY
    SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                             FROM EMP_SALARY
                             WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';

--ASIA �������� �ٹ��ϴ� ������� ���ʽ� ���� 0.3���� ����
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
    ���̺� ��ϵ� �����͸� �����ϴ� ����(�� �� ������ ������ �ȴ�.)
    
    [ǥ����]
    DELETE FROM ���̺��
    [WHERE ����] --> WHERE�� ���� ���ϸ� ��ü�� ������
*/

DELETE FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;
ROLLBACK;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '�̿���';

DELETE FROM EMPLOYEE
WHERE EMP_ID = '290'; -- ���ﶧ �ַ� �⺻Ű�� �̿��ؼ� ����
COMMIT;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
--D1�� ���� ������ ���� �ڽĵ����Ͱ� �ֱ� ������ ������ ���� �ʴ´�.