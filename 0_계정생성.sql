-- �ּ�
/*
    ������ �ּ�
*/
SELECT * FROM DBA_USERS; -- ���� ��� �����鿡 ���ؼ� ��ȸ�ϴ� ��ɹ�
--��ɹ� �� ���� ����(���� ��� ��ư or ctrl+enter

--�Ϲ� ����� ������ �����ϴ� ����(���� ������ ���������� �� �� ����)
--[ǥ����] CREATE USER ������ IDENTIFIED BY ��й�ȣ;
CREATE USER KH IDENTIFIED BY KH;
CREATE USER odg IDENTIFIED BY odg;

-- ������ ��й�ȣ�� ��ҹ��ڸ� �����Ѵ�.

-- ������ ������ �Ϲ� ����ڰ����� �ּ����� ����(����, ������ ����) �ο�
--[ǥ����] GRANT ����1, ����2, ... TO ������;
GRANT RESOURCE, CONNECT TO KH;
GRANT RESOURCE, CONNECT TO odg;

