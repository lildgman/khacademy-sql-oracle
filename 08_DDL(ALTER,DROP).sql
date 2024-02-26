/*
    DDL: ������ ���� ���
    ��ü�� ����(CREATE), ����(ALTER), ����(DELETE)�ϴ� ����

    ALTER
    ��ü�� �����ϴ� ����
    
    [ǥ����]
    ALTER TABLE ���̺�� ������ ����
    
    *������ ����
    1) �÷� �߰� / ���� / ����
    2) �������� �߰� / ���� --> ������ �Ұ�(���� �� �ٽ� �߰��ؾ���)
    3) �÷��� / �������Ǹ� / ���̺�� ���� 

    
*/
-- 1) �÷� �߰� / ���� / ����
-- DEPT_TABLE�� CNAME �÷� �߰�
ALTER TABLE DEPT_TABLE ADD CNAME VARCHAR2(20);

-- LNAME �÷� �߰�(�⺻�� -> �ѱ�)
ALTER TABLE DEPT_TABLE add LNAME VARCHAR2(20) DEFAULT '�ѱ�';

-- 1_2 �÷� ����(MODIFY)
--> ������ Ÿ�� ����: MODIFY �÷��� �ٲٰ����ϴ� ������Ÿ��
--> DEFAULT�� ����: MODIFY �÷��� DEFAULT �ٲٰ����ϴ� �⺻��
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5);
--ALTER TABLE DEPT_TABLE MODIFY DEPT_ID number; -- ������Ÿ�Կ� ���� ���� ������ �߻�
--ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(20); -- ũ�� ������ �߻�

-- DEPT_TITLE �÷��� VARCHAR2(40)���� ����
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(40);
-- LNAME �÷��� �⺻���� '�̱�'���� ����
ALTER TABLE DEPT_TABLE MODIFY LNAME DEFAULT '�̱�';

-- ���ߺ��� ����
ALTER TABLE DEPT_TABLE
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LNAME DEFAULT '�Ϻ�';
    
-- 1_3 �÷� ����(DROP COLUMN): DROP COLUMN �����ϰ��� �ϴ� �÷�
CREATE TABLE DEPT_COPY AS SELECT * FROM DEPT_TABLE;

SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID; -- �ּ� �Ѱ��� �÷��� �����ؾ� �Ѵ�.

------------------------------------------------------------------------------
--2) �������� �߰� / ���� (������ �����ϰ� �ٽ� �߰��ϱ�� ��ü)
/*
    2_1)
    - PRIMARY KEY: ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
    - FOREIGN KEY: ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[(������ �÷���)]
    - UNIQUE: ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
    - CHECK: ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�);
    - NOT NULL: ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;   
    
    �������Ǹ� �����ϰ��� �Ѵٸ� [CONSTRAINT �������Ǹ�] ��������
*/
-- DEPT_TABLE
-- DEPT_ID�� PRIMARY KEY �������� �߰�
ALTER TABLE DEPT_TABLE ADD PRIMARY KEY (DEPT_ID);
-- DEPT_TITLE�� UNIQUE �������� �߰�
ALTER TABLE DEPT_TABLE ADD UNIQUE (DEPT_TITLE);
-- LNAME�� NOT NULL �������� �߰�
ALTER TABLE DEPT_TABLE MODIFY LNAME NOT NULL;

-- 2_2) �������� ����: DROP CONSTRAINT �������Ǹ� / NOT NULL�� ���� �ȵ�, ���� ����
ALTER TABLE DEPT_TABLE DROP CONSTRAINT SYS_C007139;

ALTER TABLE DEPT_TABLE DROP CONSTRAINT SYS_C007139;

ALTER TABLE DEPT_TABLE
    DROP CONSTRAINT SYS_C007140
    MODIFY LNAME NULL;
    
------------------------------------------------------------------------------
-- ���̺� ����
DROP TABLE DEPT_TABLE;
-- ��򰡿� �����ǰ� �ִ� �θ����̺� �Ժη� ������ ���� �ʴ´�.
-- ���� ������� �Ѵٸ�
-- 1. �ڽ����̺� ���� ���� �� ����
-- 2. �׳� �θ����̺� �����ϴµ� �������Ǳ��� �����ϴ� ��
-- DROP TABLE ���̺� �� CASCADE CONSTRAINT;

--------------------------------------------------------------------------

--3) �÷���, �������ǿ���
--3_1) �÷��� ���� : RENAME
CREATE TABLE DEPT_TABLE
AS (SELECT * FROM DEPARTMENT);

-- DEPT_TITLE - DEPT_NAME
ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

SELECT *FROM DEPT_TABLE;

--3_2) �������Ǹ� ����: RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
ALTER TABLE DEPT_TABLE RENAME CONSTRAINT SYS_C007142 TO DTABLE_LID_NN;

--3_3) ���̺�� ����: RENAME TO �ٲ� ���̺��
ALTER TABLE DEPT_TABLE RENAME TO DEPT_TEST;

------------------------------------------------------------------------------
-- TRUNCATE: ���̺� �ʱ�ȭ
-- DROP���� �ٸ��� ���̺��� �����͸��� ���� �����Ͽ� ���̺��� �ʱ���·� �����ش�.
TRUNCATE TABLE DEPT_TEST;

SELECT * FROM DEPT_TEST;
ROLLBACK;