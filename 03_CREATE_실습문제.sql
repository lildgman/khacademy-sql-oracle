--실습문제 --
--도서관리 프로그램을 만들기 위한 테이블들 만들기--
--이때, 제약조건에 이름을 부여할 것
--   각 컬럼에 주석달기

drop table tb_member;
drop table tb_book;
drop table tb_publisher;

/*
    1. 출판사들에 대한 데이터를 담기위한 출판사 테이블(TB_PUBLISHER)
    컬럼 : PUB_NO(출판사 번호) - 기본키(PUBLISHER_PK)
          PUB_NAME(출판사명) -- NOT NULL(PUBLISHER_NN)
          PHONE(출판사전화번호) -- 제약조건없음
*/
create table TB_PUBLISHER (
	PUB_NO integer primary key,
	PUB_NAME VARCHAR(20) NOT NULL,
	PHONE VARCHAR(20) 
);
comment on column tb_publisher.pub_no is '출판사 번호';
comment on column tb_publisher.pub_name is '출판사명';
comment on column tb_publisher.phone is '출판사전화번호';

alter table TB_PUBLISHER
add constraint PUBLISHER_PK primary key(PUB_NO);

alter table TB_PUBLISHER
add constraint PUBLISHER_NN check(pub_name is not null);

--샘플 3개정도 생성
insert into TB_PUBLISHER (pub_no, pub_name, phone) 
values (1,'한빛','010-1111-2222');
insert into TB_PUBLISHER (pub_no, pub_name, phone) values (2,'지학사','010-3333-4444');
insert into TB_PUBLISHER (pub_no, pub_name, phone) values (3,'구름','010-5555-6666');

select * from tb_publisher;
/*
    2. 도서들에 대한 데이터를 담기위한 도서 테이블(TB_BOOK)
    컬럼 : BK_NO(도서번호)--기본키(BOOK_PK)
          BK_TITLE(도서명)--NOT NULL(BOOK__NN_TITLE)
          BK_AUTHOR(저자명)--NOT NULL(BOOK__NN_AUTHOR)
          BK_PRICE(가격)-- 제약조건없음
          BK_PUB_NO(출판사 번호)--외래키(BOOK_FK)(TB_PUBLISHER테이블을 참조)
                                이때 참조하고 있는 부모데이터 삭제시 자식데이터도 삭제 되도록 옵션지정              
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

comment on column tb_book.bk_no is '도서번호';
comment on column tb_book.bk_title is '도서명';
comment on column tb_book.bk_author is '저자명';
comment on column tb_book.bk_price is '가격명';
comment on column tb_book.bk_pub_no is '출판사 번호';

--5개 정도의 샘플 데이터 추가하기
insert into tb_book (bk_no, bk_title, bk_author, bk_price, bk_pub_no)
values (1,'자바의종석','남성',32500, 1);

insert into tb_book (bk_no, bk_title, bk_author, bk_price, bk_pub_no)
values (2,'next step','박재',22500, 3);
	
insert into tb_book (bk_no, bk_title, bk_author, bk_price, bk_pub_no)
values (3,'스프링','김성훈',35000, 1);

insert into tb_book (bk_no, bk_title, bk_author, bk_price, bk_pub_no)
values (4,'html','남하영',17300, 2);

insert into tb_book (bk_no, bk_title, bk_author, bk_price, bk_pub_no)
values	(5,'jsp','구성',34500, 3);

select * from tb_book;
/*
    3. 회원에 대한 데이터를 담기위한 회원 테이블(TB_MEMBER)
    컬럼명 : MEMBER_NO(회원번호) -- 기본키(MEMBER_PK)
            MEMBER_ID(아이디) -- 중복금지(MEMBER_UQ_ID)
            MEMBER_PWD(비밀번호) -- NOT NULL(MEMBER_NN_PWD)
            MEMBER_NAME(회원명) -- NOT NULL(MEMBER_NN_NAME)
            GENDER(성별) -- M또는 F로 입력되도록 제한(MEMBER_CK_GEN)
            ADDRESS(주소) -- 제약조건없음
            PHONE(연락처)-- 제약조건없음
            STATUS(탈퇴여부) -- 기본값을 N으로 지정, 그리고 N또는 Y만 입력되도록 제약조건 설정(MEMBER_CK_STA)
            ENROLL_DATE(가입일) -- 기본값으로 SYSDATE, NOT NULL 제약조건(MEMBER_NN_EN)
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
comment on column tb_member.member_no is '회원번호';
comment on column tb_member.member_id is '아이디';
comment on column tb_member.member_pwd is '비밀번호';
comment on column tb_member.member_name is '회원명';
comment on column tb_member.gender is '성별';
comment on column tb_member.address is '주소';
comment on column tb_member.phone is '연락처';
comment on column tb_member.status is '탈퇴여부';
comment on column tb_member.enroll_date is '가입일';

alter table tb_member
add constraint member_nn_id check(member_id is not null);

--5개 정도의 샘플 데이터 추가하기
insert into tb_member (member_no, member_id, member_pwd, member_name, gender, address, phone, status)
values (1,'user1','pwd1','username1','M','서울시 ~','010-1111-2222','N');

insert into tb_member (member_no, member_id, member_pwd, member_name, gender, address, phone, status)
values	(2,'user2','pwd2','username2','F','경기도 ~','010-3333-4444','N');

insert into tb_member (member_no, member_id, member_pwd, member_name, gender, address, phone, status)
values (3,'user3','pwd3','username3','F','서울시 ~','010-4444-5555','N');

insert into tb_member (member_no, member_id, member_pwd, member_name, gender, address, phone, status)
values (4,'user4','pwd4','username4','M','서울시 ~','010-5555-6666','Y');
	
insert into tb_member (member_no, member_id, member_pwd, member_name, gender, address, phone, status)
values   (5,'user5','pwd5','username5','M','서울시 ~','010-7777-8888','N');
	
select * from tb_member;
/*
    4.어떤 회원이 어떤 도서를 대여했는지에 대한 대여목록 테이블(TB_RENT)
    컬럼명 : RENT_NO(대여번호)-- 기본키(RENT_PK)
            RENT_MEM_NO(대여회원번호)-- 외래키(RENT_FK_MEM) TB_MEMBER와 참조하도록
                                        이때 부모 데이터 삭제시 자식데이터 값이 NULL이 되도록 지정
            RENT_BOOK_NO(대여도서번호)-- 외래키(RENT_FK_BOOK) TB_BOOK와 참조하도록
                                        이때 부모 데이터 삭제시 자식데이터 값이 NULL이 되도록 지정
            RENT_DATE(대여일) -- 기본값 SYSDATE
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

comment on column tb_rent.rent_no is '대여번호';
comment on column tb_rent.rent_mem_no is '대여회원번호';
comment on column tb_rent.rent_book_no is '대여도서번호';
comment on column tb_rent.rent_date is '대여일';


--3개 정도의 샘플 데이터 추가하기
insert into tb_rent (rent_no, rent_mem_no, rent_book_no, rent_date)
values (1,1,1,sysdate);
insert into tb_rent (rent_no, rent_mem_no, rent_book_no, rent_date)
values(2,2,3,sysdate);
insert into tb_rent values (3,3,5,sysdate);

select * from tb_rent;