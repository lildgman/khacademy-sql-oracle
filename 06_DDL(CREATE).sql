/*
    DDL: ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü�� ���� �����(CREATE),
    ������ �����ϰ�(ALTER),
    ������ü�� ����(DELETE)
    
    ��, ���� ������ ���� �ƴ� ��Ģ ��ü�� �����ϴ� ���
    ����Ŭ������ ��ü(����): ���̺�, ��, ������, �ε���, ��Ű��, Ʈ����
                        ���ν���, �Լ�, ���Ǿ�, �����

    CREATE
    ��ü�� ���� �����ϴ� ����
*/

/*
    1. ���̺� ����
    ���̺��̶�?
    ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
    ��� �����͵��� ���̺��� ���ؼ� �����
    
    CREATE TABLE ���̺� ��(
        �÷Ÿ� �ڷ���(ũ��),
        �÷Ÿ� �ڷ���(ũ��),
        �÷Ÿ� �ڷ���,
        ...
    )
    
    �ڷ���
    - ����(CHAR(����Ʈũ��) | VARCHAR2(����Ʈũ��))
        CHAR: �ִ� 2000����Ʈ���� �������� / ��������(������ ���ڼ��� �����Ͱ� ��� ���)
        (������ ũ�⺸�� �� ���� ���� ������ �������ζ� ä���� ó�� ������ ũ�⸦ ������ش�.)
        VARCHAR2: �ִ� 4000����Ʈ���� �������� / ��������(����ڰ��� �����Ͱ� ����� �𸣴� ���)
        (��� ���� ���� ���� ũ�Ⱑ ������)
        
    - ����(NUMBER)
    - ��¥(DATE)
    
*/

--ȸ���� ���� �����͸� ������� ���̺� MEMBER ����
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

-- ������ ��ųʸ�: �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�
SELECT * FROM USER_TABLES;
SELECT * FROM USER_TAB_COLUMNS;

--------------------------------------------------------------------------
/*
    2. �÷��� �ּ��ޱ�(�÷��� ���� ������ ����)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����'
    -> �߸����� �� ���� �����ϸ� �ȴ�.
    
    

*/
-- ��ȣ, ���̵�, ��й�ȣ, �̸�, ����, ��ȭ��ȣ, �̸���, ȸ��������
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.GENDER IS 'ȸ������';
COMMENT ON COLUMN MEMBER.PHONE IS 'ȸ����ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS 'ȸ���̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

--���̺� �����ϰ��� �� ��: DROP TABLE ���̺��;
DROP TABLE MEMBER;

-- ���̺� �����͸� �߰���Ű�� ����(INSERT)
-- INSERT INTO ���̺�� VALUES(��1, ��2, ��3, ...)
INSERT INTO MEMBER
VALUES (1, 'USER1','PWD1','ȫ�浿','��','01011112222','QWER@gmail.com',SYSDATE);

SELECT * FROM MEMBER;

INSERT INTO MEMBER
VALUES (2, 'USER2','PWD2','ȫ�浿',NULL,NULL,NULL,'24/02/23');

---------------------------------------------------------------------------------
/*
    ��������
    ���ϴ� �����Ͱ�(��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
    ������ ���Ἲ ������ �������� �Ѵ�.
    
    ����: NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY

*/

/*
    NOT NULL ��������
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ���(��, ���� NULL�� ������ �ȵǴ� ���)
    ����/���� �� NULL���� ������� �ʵ��� ����
    
    ���������� �ο��ϴ� ����� ũ�� 2������ �ִ�.
    �÷�������� / ���̺������
    
    NOT NULL ���������� ������ �÷�����������θ� �����ϴ�
*/

CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_NOTNULL
VALUES (1, 'USER1','PWD1','ȫ�浿','��','01011112222','QWER@gmail.com');

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL
VALUES(2, 'USER2', 'PWD2', 'ȫ���', NULL, NULL, NULL);

INSERT INTO MEM_NOTNULL
VALUES(3, NULL, 'PWD2', 'ȫ���', NULL, NULL, NULL);
-- �ǵ���� ������ �߻� (NOT NULL �������ǿ� ����Ǿ� ������ �߻�)

INSERT INTO MEM_NOTNULL
VALUES(3, 'USER2', 'PWD2', 'ȫ���', NULL, NULL, NULL);
-- ���̵� �ߺ��Ǿ������� �ұ��ϰ� �� �߰��� �ȴ�.
------------------------------------------------------------------------
/*
    UNIQUE ��������
    �ش� �÷��� �ߺ��� ���� ������ �ȵ� ��� ����Ѵ�.
    �÷����� �ߺ����� �����ϴ� ��������
    ����/���� �� ������ �ִ� ������ �� �� �ߺ����� ���� ��� ������ �߻���Ų��.
*/
DROP TABLE MEM_UNIQUE;
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL, -- �÷��������
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NT NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) -- ���̺������
);

INSERT INTO MEM_UNIQUE
VALUES (1, 'USER1','PWD1','ȫ�浿','��','01011112222','QWER@gmail.com');

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE
VALUES (2, 'USER1','PWD2','ȫ���','��','01011112222','QWER2@gmail.com');

INSERT INTO MEM_UNIQUE
VALUES (2, NULL,'PWD2','ȫ���','��','01011112222','QWER2@gmail.com');


INSERT INTO MEM_UNIQUE
VALUES (3, 'USER3','PWD3','WWW',NULL,NULL,NULL);


INSERT INTO MEM_UNIQUE
VALUES (4, 'USER4','PWD4','WWW',NULL,NULL,NULL);
-- UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT ����
--> ���������� �������Ǹ����� �˷��ش�.
--> ���� �ľ��ϱ�� ��ƴ�
--> �������� �ο� �� �������Ǹ��� ���������� ������ �ý��ۿ��� �̸��� �ο��Ѵ�.
SELECT * FROM MEM_UNIQUE;
---------------------------------------------------------------------------------------
/*
    �������� �ο� �� �������Ǹ���� �����ִ� ���
    1) �÷��������
    CRATE TABLE ���̺��(
        �÷��� �ڷ��� (CONSTRAINT �������Ǹ�) ��������
    )
    2) ���̺������
    CRATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        (CONSTRAINT �������Ǹ�)��������(�÷���)
    )
*/

-------------------------------------------------------------------
/*
    CHECK(���ǽ�)
    �ش� �÷��� ���� �� �ִ� ���� ���� ������ �ο��� �� ����
    �ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����
*/
DROP TABLE MEM_CHECK;
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER  NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), -- ��, ��
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
--CHECK(GENDER IN ('��','��')
);

INSERT INTO MEM_CHECK
VALUES (1, 'USER1','PWD1','ȫ�浿','��','01011112222','QWER@gmail.com');

INSERT INTO MEM_CHECK
VALUES (2, 'USER2','PWD2','ȫ���','��','01022223333','QWER4@gmail.com');

INSERT INTO MEM_CHECK
VALUES (2, 'USER2','PWD2','ȫ���',NULL,'01022223333','QWER4@gmail.com');
--> CHECK �������� ������ ������ �߻��Ѵ�.
--> ���� GENDER�÷��� �����͸� �ְ��� �Ѵٸ� CHECK�������ǿ� �����ϴ� ���� �־���Ѵ�.
--> NULL�� ���� ���ٴ� ���̱� ������ ����
SELECT * FROM MEM_CHECK;

--------------------------------------------------------------------------
/*
    PRIMARY KEY(�⺻Ű) ��������
    
    ���̺��� �� ��(ROW)�� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� ��������(�ĺ��� ����)
    
    EX) ȸ����ȣ, �й�, ����, �μ��ڵ�, �����ڵ�, �ֹ���ȣ, �ù������ȣ, �����ȣ ��....
    PRIMARY KEY ���������� �ο� -> NOT NULL + UNIQUE ��� �����ϸ� �ȴ�.
    
    ���ǻ���: �� ���̺�� ���� �Ѱ��� ���� ����
*/
CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
--    PRIMARY KEY(MEM_NO)
);

INSERT INTO MEM_PRI
VALUES (1, 'USER1','PWD1','ȫ�浿','��','01011112222','QWER@gmail.com');

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI
VALUES (1, 'USER2','PWD2','ȫ���','��','01011112222','QWER@gmail.com');
--> �⺻Ű�� �ߺ����� �������� �� ��(UNIQUE �������� ����)

INSERT INTO MEM_PRI
VALUES (NULL, 'USER2','PWD2','ȫ���','��','01011112222','QWER@gmail.com');
--> �⺻Ű�� NULL�� �������� �� ��(NOT NULL �������� ����)

INSERT INTO MEM_PRI
VALUES(2, 'USER2','PWD2','ȫ���','��','01011112222','QWER2@gmail.com');

---------------------------------------------------------------------------

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID)
);
-- ����Ű: �� ���� �÷��� ���ÿ� �ϳ��� PRIMARY KEY �� �����ϴ� ��


INSERT INTO MEM_PRI2 VALUES(1, 'USER1','PWD1','ȫ�浿',NULL,NULL, NULL);

INSERT INTO MEM_PRI2 VALUES(1, 'USER2','PWD2','ȫ���',NULL,NULL, NULL);

INSERT INTO MEM_PRI2 VALUES(2, 'USER3','PWD3','ȫ���',NULL,NULL, NULL);

SELECT * FROM MEM_PRI2;

-- ����Ű ��� ����(� ȸ���� � ��ǰ�� ���ϴ����� ���� �����͸� �����ϴ� ���̺�)
CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(10),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

-- ȸ���� 2��(1��, 2��) ����
-- ��ǰ�� ����A, ����B �� ����

SELECT * FROM TB_LIKE;
INSERT INTO TB_LIKE VALUES(1, '������A', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '������B', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '������A', SYSDATE);
 
----------------------------------------------------------------------------
-- ȸ����޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

SELECT * FROM MEM_GRADE;
INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');


CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER
);

INSERT INTO MEM VALUES(1, 'USER1', 'PASS01','ȫ���','��', NULL,NULL,NULL);
INSERT INTO MEM VALUES(2, 'USER2', 'PASS02','ȫ���','��', NULL,NULL,10);
INSERT INTO MEM VALUES(3, 'USER3', 'PASS03','������', NULL, NULL,NULL,10);
INSERT INTO MEM VALUES(4, 'USER4', 'PASS04','������', NULL, NULL,NULL,10);
INSERT INTO MEM VALUES(5, 'USER5', 'PASS05','������', NULL, NULL,NULL,40);
-------��ȿ�� ȸ����޹�ȣ�� �ƴϿ��� INSERT�� �� �ȴ�.

SELECT * FROM MEM;


--------------------------------------------------------------------------
/*
    FOREIGN KEY(�ܷ�Ű) ��������
    �ٸ� ���̺� �����ϴ� ���� ���;��ϴ� Ư�� �÷��� �ο��ϴ� ��������
    -> �ٸ� ���̺��� �����Ѵٰ� ǥ��
    -> �ַ� �ٸ� ���̺��� PRIMARY KEY�� ����
    -> FOREING KEY ������������ ���� ���̺� �� ���谡 �����ȴ�.
    
    > �÷��������
    �÷��� �ڷ��� REFERENCES ������ ���̺� ��[(������ �÷���)]
    
    > ���̺������
    FOREIGN KEY(�÷���) REFERENCES ������ ���̺� ��[(������ �÷���)]
    -> ������ �÷��� ���� �� ������ ���̺� PRIMARY KEY�� ������ �÷��� ��Ī�ȴ�.
*/

DROP TABLE MEM;
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE)
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

INSERT INTO MEM VALUES(1, 'USER1', 'PASS01','ȫ�浿','��', NULL,NULL,NULL);
INSERT INTO MEM VALUES(2, 'USER2', 'PASS02','ȫ���','��', NULL,NULL,10);
INSERT INTO MEM VALUES(3, 'USER3', 'PASS03','ȫ�泲',NULL, NULL,NULL,40);
--> parent key not found, parent key�� ã�� �� ���ٴ� ���� �߻�

-- MEM_GRADE(�θ����̺�)-��-------------<- MEM(�ڽ����̺�)
--               1                         N --1:N ���� (1���� �θ����̺�, N���� �ڽ����̺�)
INSERT INTO MEM VALUES(3, 'USER3', 'PASS03','ȫ�泲',NULL, NULL,NULL,20);
INSERT INTO MEM VALUES(4, 'USER4', 'PASS04','ȫ����',NULL, NULL,NULL,10);

SELECT * FROM MEM;

--> �̶� �θ����̺��� �����Ͱ��� �����ϸ� ��� �ɱ�?
-- ������ ����: DELETE FROM ���̺�� WHERE ����;
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--> �ڽ����̺��� 10�̶�� ���� ����ϰ� �ֱ� ������ ������ �ȵȴ�.
 
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;
--> �ڽ����̺��� 30�̶�� ���� ����ϰ� ���� �ʱ� ������ ������ �� �ȴ�.
SELECT * FROM MEM_GRADE;

--> �ڽ����̺� �̹� ����ϰ� �ִ� ���� ���� ���,
--> �θ����̺�κ��� ������ ������ �ȵǴ� "��������" �ɼ��� �ɷ��ִ�.

ROLLBACK;
--------------------------------------------------------------------
/*
    �ڽ����̺� ���� �� �ܷ�Ű �������� �ο��� �� �����ɼ��� ������ �� �ִ�.
    �����ɼ�: �θ����̺��� ������ ���� �� �� �����͸� ����ϰ� �ִ� �ڽ����̺��� ���� ��� �� ���ΰ�?
    
    - ON DELETE RESTRICTED(�⺻��): �������ѿɼ�, �ڽĵ����ͷκ��� ���̴� �θ����ʹ� ������ �ƿ� �ȵ�
    - ON DELETE SET NULL: �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽ� �������� ���� NULL�� ����
    - ON DELETE CASCADE: �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͵� ���� ������Ű�� �ɼ�
*/

DROP TABLE MEM;
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

INSERT INTO MEM VALUES(1, 'USER1', 'PASS01','ȫ�浿','��', NULL,NULL,NULL);
INSERT INTO MEM VALUES(2, 'USER2', 'PASS02','ȫ���','��', NULL,NULL,10);
INSERT INTO MEM VALUES(3, 'USER3', 'PASS03','ȫ�泲',NULL, NULL,NULL,20);
INSERT INTO MEM VALUES(4, 'USER4', 'PASS04','ȫ����',NULL, NULL,NULL,30);

SELECT * FROM MEM;

-- 10�� ��� ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--> �� ������ �Ϸ��, 10�� ������ �����ִ� �ڽĵ������� ���� NULL�� �����

ROLLBACK;

DROP TABLE MEM;
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

INSERT INTO MEM VALUES(1, 'USER1', 'PASS01','ȫ�浿','��', NULL,NULL,NULL);
INSERT INTO MEM VALUES(2, 'USER2', 'PASS02','ȫ���','��', NULL,NULL,10);
INSERT INTO MEM VALUES(3, 'USER3', 'PASS03','ȫ�泲',NULL, NULL,NULL,20);
INSERT INTO MEM VALUES(4, 'USER4', 'PASS04','ȫ����',NULL, NULL,NULL,30);

SELECT * FROM MEM;

-- 10�� ��� ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--> ���� �ߵ�, �ش絥���͸� ����ϰ� �ִ� �ڽĵ����䵵 ���� ������ ��

------------------------------------------------------------------------------
/* 
    DEFAULT �⺻�� - ���������� �ƴϴ�.
    �÷��� �������� �ʰ� INSERT�� NULL�� �ƴ� �⺻���� INSERT�ϰ��� �Ѵ�.
    �̶� �����ص� �� �ִ� ��
    
    �÷��� �ڷ��� DEFAULT �⺻��
*/

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '����',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

-- INSERT INTO ���̺�� VALUES(�÷���, �÷���...)

INSERT INTO MEMBER VALUES(1,'������',20,'�','20/01/01');
INSERT INTO MEMBER VALUES(2,'����',22,NULL,NULL);
INSERT INTO MEMBER VALUES(3,'����',24,DEFAULT, DEFAULT);

SELECT * FROM MEMBER;

-- INSERT INTO MEMBER(�÷�1, �÷�2 ....) VALUES(�÷�1��, �÷�2�� ...);
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4,'����');
--> ���õ��� ���� �÷����� �⺻������ NULL�� ��
--> ��, �ش� �÷��� DEFAULT���� �ο��Ǿ� ���� ��� NULL�� �ƴ� DEFAULT���� ��

--------------------------------------------------------------------------
-- ���̺��� ������ �� �ִ�.
CREATE TABLE EMPLOYEE_COPY
AS (SELECT * FROM MEMBER);

SELECT * FROM EMPLOYEE_COPY;
SELECT * FROM MEMBER;

DROP TABLE EMPLOYEE_COPY;

CREATE TABLE EMPLOYEE_COPY
AS (SELECT * FROM EMPLOYEE);
--------------------------------------------------------------------------
/*
    ���̺��� �� ������ ���Ŀ� �ڴʰ� ���������� �߰��ϴ� ���
    ALTER TABLE ���̺�� ������ ����
    
    - PRIMARY KEY: ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
    - FOREIGN KEY: ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[(������ �÷���)]
    - UNIQUE: ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
    - CHECK: ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�);
    - NOT NULL: ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;    
*/

-- EMPLOYEE_COPY ���̺� PRIMARY_KEY ���������� �߰�(EMP_ID)

ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);
ALTER TABLE EMPLOYEE_COPY DROP PRIMARY KEY;

--EMPLOYEE ���̺� DEPT_CODE�� �ܷ�Ű �������� �߰�
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;

--EMPLOYEE ���̺� JOB_CODE�� �ܷ�Ű �������� �߰�
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;

--DEPARTMENT ���̺� LOCATION_ID�� �ܷ�Ű �������� �߰�
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;


