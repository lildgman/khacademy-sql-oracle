--�ǽ����� --
--�������� ���α׷��� ����� ���� ���̺�� �����--
--�̶�, �������ǿ� �̸��� �ο��� ��
--   �� �÷��� �ּ��ޱ�

drop table tb_member;
drop table tb_book;
drop table tb_publisher;

/*
    1. ���ǻ�鿡 ���� �����͸� ������� ���ǻ� ���̺�(TB_PUBLISHER)
    �÷� : PUB_NO(���ǻ� ��ȣ) - �⺻Ű(PUBLISHER_PK)
          PUB_NAME(���ǻ��) -- NOT NULL(PUBLISHER_NN)
          PHONE(���ǻ���ȭ��ȣ) -- �������Ǿ���
*/
create table TB_PUBLISHER (
	PUB_NO integer primary key,
	PUB_NAME VARCHAR(20) NOT NULL,
	PHONE VARCHAR(20) 
);
comment on column tb_publisher.pub_no is '���ǻ� ��ȣ';
comment on column tb_publisher.pub_name is '���ǻ��';
comment on column tb_publisher.phone is '���ǻ���ȭ��ȣ';

alter table TB_PUBLISHER
add constraint PUBLISHER_PK primary key(PUB_NO);

alter table TB_PUBLISHER
add constraint PUBLISHER_NN check(pub_name is not null);

--���� 3������ ����
insert into TB_PUBLISHER (pub_no, pub_name, phone) 
values (1,'�Ѻ�','010-1111-2222');
insert into TB_PUBLISHER (pub_no, pub_name, phone) values (2,'���л�','010-3333-4444');
insert into TB_PUBLISHER (pub_no, pub_name, phone) values (3,'����','010-5555-6666');

select * from tb_publisher;
/*
    2. �����鿡 ���� �����͸� ������� ���� ���̺�(TB_BOOK)
    �÷� : BK_NO(������ȣ)--�⺻Ű(BOOK_PK)
          BK_TITLE(������)--NOT NULL(BOOK__NN_TITLE)
          BK_AUTHOR(���ڸ�)--NOT NULL(BOOK__NN_AUTHOR)
          BK_PRICE(����)-- �������Ǿ���
          BK_PUB_NO(���ǻ� ��ȣ)--�ܷ�Ű(BOOK_FK)(TB_PUBLISHER���̺��� ����)
                                �̶� �����ϰ� �ִ� �θ����� ������ �ڽĵ����͵� ���� �ǵ��� �ɼ�����              
*/

create table TB_BOOK (
	BK_NO integer primary key,
	BK_TITLE varchar(30) not null,
	BK_AUTHOR varchar(20) not null,
	BK_PRICE integer,
	BK_PUB_NO integer references tb_publisher(pub_no) on delete cascade
	);

alter table tb_book
drop constraint SYS_C007108;

alter table tb_book
add constraint BOOK_PK primary key (BK_NO); 
	
alter table tb_book
add constraint BOOK__NN_TITLE check (bk_title is not null);

alter table tb_book
add constraint BOOK__NN_AUTHOR check (bk_author is not null);

alter table tb_book
add constraint book_fk foreign key (BK_PUB_NO) references TB_PUBLISHER(PUB_NO)on delete cascade;

comment on column tb_book.bk_no is '������ȣ';
comment on column tb_book.bk_title is '������';
comment on column tb_book.bk_author is '���ڸ�';
comment on column tb_book.bk_price is '���ݸ�';
comment on column tb_book.bk_pub_no is '���ǻ� ��ȣ';

--5�� ������ ���� ������ �߰��ϱ�
insert into tb_book (bk_no, bk_title, bk_author, bk_price, bk_pub_no)
values (1,'�ڹ�������','����',32500, 1);

insert into tb_book (bk_no, bk_title, bk_author, bk_price, bk_pub_no)
values (2,'next step','����',22500, 3);
	
insert into tb_book (bk_no, bk_title, bk_author, bk_price, bk_pub_no)
values (3,'������','�輺��',35000, 1);

insert into tb_book (bk_no, bk_title, bk_author, bk_price, bk_pub_no)
values (4,'html','���Ͽ�',17300, 2);

insert into tb_book (bk_no, bk_title, bk_author, bk_price, bk_pub_no)
values	(5,'jsp','����',34500, 3);

select * from tb_book;
/*
    3. ȸ���� ���� �����͸� ������� ȸ�� ���̺�(TB_MEMBER)
    �÷��� : MEMBER_NO(ȸ����ȣ) -- �⺻Ű(MEMBER_PK)
            MEMBER_ID(���̵�) -- �ߺ�����(MEMBER_UQ_ID)
            MEMBER_PWD(��й�ȣ) -- NOT NULL(MEMBER_NN_PWD)
            MEMBER_NAME(ȸ����) -- NOT NULL(MEMBER_NN_NAME)
            GENDER(����) -- M�Ǵ� F�� �Էµǵ��� ����(MEMBER_CK_GEN)
            ADDRESS(�ּ�) -- �������Ǿ���
            PHONE(����ó)-- �������Ǿ���
            STATUS(Ż�𿩺�) -- �⺻���� N���� ����, �׸��� N�Ǵ� Y�� �Էµǵ��� �������� ����(MEMBER_CK_STA)
            ENROLL_DATE(������) -- �⺻������ SYSDATE, NOT NULL ��������(MEMBER_NN_EN)
*/
create table tb_member(
	member_no integer constraint MEMBER_PK primary key,
	member_id varchar(20) constraint MEMBER_UQ_ID unique,
	member_pwd varchar(20) constraint MEMBER_NN_PWD not null,
	member_name varchar(20) constraint MEMBER_NN_NAME not null,
	gender char(1) constraint MEMBER_CK_GEN check (gender in ('M','F')),
	address varchar(50),
	phone varchar(20),
	status char(1) default 'N' constraint MEMBER_CK_STA check(status in ('N','Y')),
	enroll_date date default SYSDATE constraint MEMBER_NN_EN NOT null
);
comment on column tb_member.member_no is 'ȸ����ȣ';
comment on column tb_member.member_id is '���̵�';
comment on column tb_member.member_pwd is '��й�ȣ';
comment on column tb_member.member_name is 'ȸ����';
comment on column tb_member.gender is '����';
comment on column tb_member.address is '�ּ�';
comment on column tb_member.phone is '����ó';
comment on column tb_member.status is 'Ż�𿩺�';
comment on column tb_member.enroll_date is '������';

alter table tb_member
add constraint member_nn_id check(member_id is not null);

--5�� ������ ���� ������ �߰��ϱ�
insert into tb_member (member_no, member_id, member_pwd, member_name, gender, address, phone, status)
values (1,'user1','pwd1','username1','M','����� ~','010-1111-2222','N');

insert into tb_member (member_no, member_id, member_pwd, member_name, gender, address, phone, status)
values	(2,'user2','pwd2','username2','F','��⵵ ~','010-3333-4444','N');

insert into tb_member (member_no, member_id, member_pwd, member_name, gender, address, phone, status)
values (3,'user3','pwd3','username3','F','����� ~','010-4444-5555','N');

insert into tb_member (member_no, member_id, member_pwd, member_name, gender, address, phone, status)
values (4,'user4','pwd4','username4','M','����� ~','010-5555-6666','Y');
	
insert into tb_member (member_no, member_id, member_pwd, member_name, gender, address, phone, status)
values   (5,'user5','pwd5','username5','M','����� ~','010-7777-8888','N');
	
select * from tb_member;
/*
    4.� ȸ���� � ������ �뿩�ߴ����� ���� �뿩��� ���̺�(TB_RENT)
    �÷��� : RENT_NO(�뿩��ȣ)-- �⺻Ű(RENT_PK)
            RENT_MEM_NO(�뿩ȸ����ȣ)-- �ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_BOOK_NO(�뿩������ȣ)-- �ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_DATE(�뿩��) -- �⺻�� SYSDATE
*/

create table tb_rent(
	rent_no integer constraint rent_pk primary key,
	rent_mem_no integer,
	rent_book_no integer,
	rent_date date default sysdate
);

alter table tb_rent
add constraint rent_fk_mem foreign key (rent_mem_no) references tb_member(member_no) on delete set null;

alter table tb_rent
add constraint rent_fk_book foreign key (rent_book_no) references tb_book(bk_no) on delete set null;

comment on column tb_rent.rent_no is '�뿩��ȣ';
comment on column tb_rent.rent_mem_no is '�뿩ȸ����ȣ';
comment on column tb_rent.rent_book_no is '�뿩������ȣ';
comment on column tb_rent.rent_date is '�뿩��';


--3�� ������ ���� ������ �߰��ϱ�
insert into tb_rent (rent_no, rent_mem_no, rent_book_no, rent_date)
values (1,1,1,sysdate);
insert into tb_rent (rent_no, rent_mem_no, rent_book_no, rent_date)
values(2,2,3,sysdate);
insert into tb_rent values (3,3,5,sysdate);

select * from tb_rent;