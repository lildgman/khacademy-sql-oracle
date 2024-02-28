/*
    DCL: ������ ���
    �������� �ý��� ���� �Ǵ� ��ü���� ������ �ο��ϰų� ȸ���ϴ� ����
    
    �ý��� ����: DB�� �����ϴ� ����, ��ü�� ������ �� �ִ� ����
    ��ü ���� ����: Ư�� ��ü���� ������ �� �ִ� ����
    
    ���� ����
    CREATE USER ������ IDENTIFIED BY ��й�ȣ;
    GRANT ���� (RESOURCE, CONNECT) TO ����;
*/

SELECT *
FROM ROLE_SYS_PRIVS;

/*
    TCL: Ʈ����� ���
    
    Ʈ�����
    - �����ͺ��̽��� ���� �������
    - �������� �������(DML)���� �ϳ��� Ʈ����ǿ� ��� ó��
    - DML�� �� ���� ������ �� Ʈ������� �������� �ʴ´ٸ� Ʈ������� ���� ����
                                                  Ʈ������� �����Ѵٸ� �ش� Ʈ����ǿ� ��� ó��
    COMMIT�ϱ� ������ ������׵��� �ϳ��� Ʈ����ǿ� ��´�.
    - Ʈ����ǿ� ����� �Ǵ� SQL: INSERT, UPDATE, DELETE
    
    COMMIT(Ʈ����� ���� ó�� �� Ȯ��)
    ROLLBACK(Ʈ����� ���)
    SAVEPOINT(�ӽ�����)
    
    -COMMIT: �� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ���Ű�ڴٴ� �ǹ�
    -ROLLBACK: �� Ʈ����ǿ� ����ִ� ������׵��� ����(���)�� �� ������ COMMIT �������� ���ư�
    -SAVEPOINT ����Ʈ��: ���� ������ �ش� ����Ʈ������ �ӽ������� �صδ� ��

*/

DROP TABLE EMP_01;
CREATE TABLE EMP_01
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID));
    
SELECT * FROM EMP_01;

DELETE FROM EMP_01
WHERE EMP_ID = 250;

DELETE FROM EMP_01
WHERE EMP_ID = 203;
ROLLBACK;

SELECT * FROM EMP_01;

---------------------------------------------------------------------
DELETE FROM EMP_01
WHERE EMP_ID = 250;

DELETE FROM EMP_01
WHERE EMP_ID = 203;

SELECT * FROM EMP_01;

COMMIT;
ROLLBACK;

----------------------------------------------------------------------
--217, 216, 214 ����
DELETE FROM EMP_01
WHERE EMP_ID IN (214, 216, 217);
SELECT * FROM EMP_01;

SAVEPOINT SP;

INSERT INTO EMP_01
VALUES(801,'������','���������');
DELETE FROM EMP_01
WHERE EMP_ID = 210;
SELECT * FROM EMP_01;

ROLLBACK TO SP;
SELECT * FROM EMP_01;

COMMIT;

--------------------------------------------------------------------
DELETE FROM EMP_01
WHERE EMP_ID = 210;

CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;
SELECT * FROM EMP_01;

--DDL��(CREATE, ALTER, DROP)�� �����ϴ� ���� ���� Ʈ����ǿ� �ִ� ������׵���
--������ COMMIT�� �ȴ�.(���� DB�� �ݿ��� �ȴ�.)
--��, DDL�� ���� �� ������׵��� �ִٸ� ��Ȯ�ϰ� �Ƚ��ϰ� ��������
