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