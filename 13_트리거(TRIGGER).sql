/*
    Ʈ����
    ���� ������ ���̺� INSERT, UPDATE, DELETE �� DML���� ���� ��������� ���� ��
    (���̺� �̺�Ʈ�� �߻��� ��)
    
    EX)
    ȸ��Ż��� ������ ȸ�� ���̺� ������ DELETE �� ��ٷ� 
    Ż���� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ���Ѿ��Ѵ�.
    �Ű�Ƚ���� ���� ���� �Ѿ��� �� ���������� �ش� ȸ���� ������Ʈ�� ó���ǰԲ�
    ����� ���� �����Ͱ� ���(INSERT)�� ������
    �ش� ��ǰ�� ���� �������� ����(UPDATE)�ؾ��Ѵ�.
    
    Ʈ���� ����
    - SQL���� ����ñ⿡ ���� �з�
    > BEFORE TRIGGER: ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ����
    > AFTER TRIGGER: ���� ������ ���̺� �̺�Ʈ�� �߻��� �� Ʈ���� ����
    
    - SQL���� ���� ������ �޴� �� �࿡ ���� �з�
    > ���� Ʈ����: �̺�Ʈ�� �߻��� SQL���� ���� �� �� ���� �����ϱ�
    > �� Ʈ����: �ش� SQL�� ������ ������ �Ź� Ʈ���� ����
                (FOR EACH ROW �ɼ� ����ؾ���)
                > :OLD - BEFORE UPDATE(���� �� �ڷ�), BEFORE DELETE(���� �� �ڷ�)
                > :NEW - AFTER INSERT(�߰� �� �ڷ�), AFTER UPDATE(���� �� �ڷ�)
    Ʈ���� ���� ����
    [ǥ����]
    CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    BEFORE | AFTER              INSERT | UPDATE | DELETE ON ���̺�
    [FOR EACH ROW]
    [DECLARE ��������]
    BEGIN
        ���೻��(�ش� ���� ������ �̺�Ʈ �߻��� ������ ����)
    [EXCEPTION]
    END;
    /    
*/

--EMPLOYEE ���̺� ���ο� ���� INSERT�� ������ �ڵ����� '���Ի���� ȯ���մϴ�' ���
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES(500,'DDD','111111-2222222','D7','J7',SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES(501,'GGG','111122-2222222','D7','J7',SYSDATE);

-------------------------------------------------------------------------------
-- ��ǰ�԰� �� ��� ���� ����
--> �ʿ��� ���̺� �� ������ ����

-- 1. ��ǰ�� ���� �����͸� ������ ���̺�(TB_PRODUCT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30) NOT NULL,
    BRAND VARCHAR2(30) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
);

-- ��ǰ��ȣ �ߺ� �ȵǰԲ� �Ź� ���ο� ��ǰ��ȣ�� �߻���Ű�� ���� ������ ����
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

-- ���õ����� �߰�
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL,'������24','�Ｚ',1400000,DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL,'������15','����',1200000,10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL,'�����','�����',700000,20);
COMMIT;
SELECT * FROM TB_PRODUCT;

-- 2. ��ǰ ����� �� �̷� ���̺� ����(TB_PRODETAIL)
-- � ��ǰ�� � ��¥�� ��� �԰� �Ǵ� ��� �Ǵ��� �����͸� ���
CREATE TABLE TB_PRODETAIL(
    DECODE NUMBER PRIMARY KEY,
    PCODE NUMBER REFERENCES TB_PRODUCT(PCODE),
    PDATE DATE NOT NULL, -- �������
    AMOUNT NUMBER NOT NULL, -- ����� ����
    STATUS CHAR(6) CHECK (STATUS IN ('�԰�','���'))
);

-- �̷¹�ȣ �Ź� ���ο� ��ȣ�� �߻����� �� �� �ְ� ������ ������ ����
CREATE SEQUENCE SEQ_DECODE
NOCACHE;

-- 200�� ��ǰ�� ���ó�¥�� 10�� �԰�
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 200,SYSDATE,10,'�԰�');

-- 200�� ��ǰ ������ 10 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT;

-- 205�� ��ǰ�� ���ó�¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 205,SYSDATE,20,'�԰�');
-- 205�� ��ǰ ������ 20 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;

-- 210�� ��ǰ�� ���ó�¥�� 5�� �԰�
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 210,SYSDATE,5,'�԰�');
-- 210�� ��ǰ ������ 20 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 5
WHERE PCODE = 210;
COMMIT;
--TB_PRODETAIL ���̺� INSERT �̺�Ʈ �߻� ��
--TB_PRODUCT ���̺� �Ź� �ڵ����� ������ UPDATE �ǰԲ� Ʈ���� �ۼ�

/*
    - ��ǰ�� �԰�� ��� -> �ش� ��ǰ�� ã�� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK + ���� �԰�� ����(INSERT�� �ڷ� AMOUNT)
    WHERE PCODE = �԰�� ��ǰ ��ȣ(INSERT�� �ڷ��� PCODE);
    - ��ǰ�� ���� ��� -> �ش� ��ǰ�� ã�� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK - ���� ���� ����(INSERT�� �ڷ� AMOUNT)
    WHERE PCODE = ���� ��ǰ ��ȣ(INSERT�� �ڷ��� PCODE);
*/

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    IF(:NEW.STATUS = '�԰�')
        THEN UPDATE TB_PRODUCT
             SET STOCK = STOCK + :NEW.AMOUNT
             WHERE PCODE = :NEW.PCODE;
    END IF;
    
    IF(:NEW.STATUS = '���')
        THEN UPDATE TB_PRODUCT
             SET STOCK = STOCK - :NEW.AMOUNT
             WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 210�� ��ǰ�� ���ó�¥�� 7�� ���
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 210,SYSDATE,7,'���');
-- 200�� ��ǰ�� ���ó�¥�� 100�� �԰�
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 200,SYSDATE,100,'�԰�');