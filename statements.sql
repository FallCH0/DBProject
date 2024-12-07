/*创建数据库*/
CREATE DATABASE Flight_Management_System
ON PRIMARY
    (NAME='FMS_data',
    FILENAME='E:\DBProject\FMS_data.mdf',
    SIZE=20MB,
    FILEGROWTH=10%
    )
LOG ON
    (NAME='FMS_log',
    FILENAME='E:\DBProject\FMS_log.ldf',
    SIZE=8MB,
    FILEGROWTH=10%
    )
/*创建表user并设置主键*/
create table dbo.[User]
(
    Uid    char(20)  not null
        constraint User_pk_Uid
            primary key,
    Uname  nchar(20) not null,
    Height int       not null,
    Sex    char(2),
    Age    int       not null
)
/*创建表Flight并设置主键*/
create table dbo.Flight
(
    Fid   char(20)  not null
        constraint Flight_pk_Fid
            primary key,
    Lea_t datetime  not null,
    Arr_t datetime  not null,
    Lea_p nchar(20) not null,
    Arr_p nchar(20) not null,
    Cid   char(20) not null
)
alter table dbo.Flight
    alter column Lea_t time not null
alter table dbo.Flight
    alter column Arr_t time not null
alter table dbo.Flight
    add Add_Day int not null
alter table dbo.Flight
alter column Lea_p char(20) not null
alter table dbo.Flight
    alter column Arr_p char(20) not null
/*创建表Ticket并设置主键*/
create table dbo.Company
(
    Cid      char(20)  not null
        constraint Company_pk_Cid
            primary key,
    Cname    nchar(20) not null,
    Discount float     not null
)
/*创建表Airport并设置主键*/
create table dbo.Airport
(
    Aid   char(20)  not null
        constraint Airport_pk_Aid
            primary key,
    Aname NCHAR(20) not null
)
/*创建表Crew_Flight并设置主键*/
create table dbo.Crew_Flight
(
    Cfid        char(20)  not null
        constraint Crew_Flight_Cfid
            primary key,
    Cfname      nchar(20) not null,
    Cfleader_id char(20)  not null,
    Cftitle     nchar(20) not null,
    Cflight_id  char(20)  not null
)
/*创建表Staff并设置主键*/
create table dbo.Staff
(
    Sid         char(20)  not null
        constraint staff_pk_Sid
            primary key,
    Sname       nchar(20) not null,
    Sleader_id  char(20) not null,
    Stitle      nchar(20) not null,
    Sairport_id char(20)  not null
)
/*创建表Vip并设置主键*/
create table dbo.Vip
(
    Uid char(20) not null
        constraint Vip_pk_Uid
            primary key,
    Cid char(20) not null
)
alter table dbo.Vip
    add constraint Vip_pk
        primary key (Uid, Cid)
/*创建表Order并设置主键*/
create table dbo.[Order]
(
    Oid   char(20)  not null
        constraint Order_pk_Oid
            primary key,
    Uid   char(20)  not null,
    Fid   char(20)  not null,
    Date  datetime  not null,
    Pay   float     not null,
    Grade nchar(20) not null
)
alter table dbo.[Order]
    alter column Date date not null
/*创建表Fli_Date并设置主键*/
create table dbo.Fli_Date
(
    Fid     char(20) not null
    Date    date     not null,
    Fir_Num int      not null,
    Fir_Pri float    not null,
    Eco_Num int      not null,
    Eco_Pri int      not null,
    alter table dbo.Fli_Date
    add constraint [Fli_Date_pk_Fid&Date]
        primary key (Fid, Date)
)
/*通过外键构建表之间的约束与联系*/
/*航班-公司*/
alter table dbo.Flight
    add constraint Flight_Company_Cid_fk
        foreign key (Cid) references dbo.Company
/*机组人员-航班*/
alter table dbo.Crew_Flight
    add constraint Crew_Flight_Flight_Fid_fk
        foreign key (Cflight_id) references dbo.Flight
/*机组人员-对应领导*/
alter table dbo.Crew_Flight
    add constraint Crew_Flight_Crew_Flight_Cfid_fk
        foreign key (Cfleader_id) references dbo.Crew_Flight
/*员工-对应领导*/
alter table dbo.Staff
    add constraint Staff_Staff_Sid_fk
        foreign key (Sleader_id) references dbo.Staff
/*员工-机场*/
alter table dbo.Staff
    add constraint Staff_Airport_Aid_fk
        foreign key (Sairport_id) references dbo.Airport
/*会员-公司*/
alter table dbo.Vip
    add constraint Vip_Company_Cid_fk
        foreign key (Cid) references dbo.Company
/*会员-乘客*/
alter table dbo.Vip
    add constraint Vip_User_Uid_fk
        foreign key (Uid) references dbo.[User]
/*订单-航班*/
alter table dbo.[Order]
    add constraint Order_Fli_Date_Fid_Date_fk
        foreign key (Fid, Date) references dbo.Fli_Date
/*订单-乘客*/
alter table dbo.Order
    add constraint Order_User_Uid_fk
        foreign key (Uid) references dbo.[User]
/*航班对应*/
alter table dbo.Fli_Date
    add constraint Fli_Date_Flight_Fid_fk
        foreign key (Fid) references dbo.Flight
/*航班-航班号*/
alter table dbo.Fli_Date
    add constraint Fli_Date_Flight_Fid_fk
        foreign key (Fid) references dbo.Flight
/*始末站-机场*/
alter table dbo.Flight
    add constraint Flight_Airport_Aid_fk
        foreign key (Lea_p) references dbo.Airport
/*向各个表中添加数据*/
INSERT INTO Flight_Management_System.dbo.Airport (Aid, Aname)
VALUES 
    (N'001', N'北京大兴国际机场'),
    (N'002', N'上海虹桥国际机场'),
    (N'003', N'广州白云国际机场'),
    (N'004', N'厦门高崎国际机场'),
    (N'005', N'重庆江北国际机场'),
    (N'006', N'秦皇岛北戴河国际机场'),
    (N'007', N'香港国际机场');
/**/
INSERT INTO Flight_Management_System.dbo.Company (Cid, Cname, Discount)
VALUES 
    (N'CA', N'中国国际航空股份有限公司', 0.88),
    (N'CZ', N'中国南方航空公司', 0.66),
    (N'PN', N'西部航空有限责任公司', 0.75),
    (N'MU', N'东方航空公司', 0.9),
    (N'MF', N'厦门航空公司', 0.72),
    (N'SC', N'山东航空公司', 0.85);
/**/
INSERT INTO Flight_Management_System.dbo.Flight (Fid, Lea_t, Arr_t, Lea_p, Arr_p, Cid, Add_Day)
VALUES
    (N'001', N'14:38:00.0000000', N'18:42:00.0000000', N'北京大兴国际机场', N'广州白云国际机场', N'PN', 0),
    (N'002', N'23:41:00.0000000', N'04:26:00.0000000', N'上海虹桥国际机场', N'厦门高崎国际机场', N'SC', 1),
    (N'003', N'06:27:00.0000000', N'08:40:00.0000000', N'广州白云国际机场', N'秦皇岛北戴河国际机场', N'MU', 0),
    (N'004', N'17:05:00.0000000', N'22:44:00.0000000', N'厦门高崎国际机场', N'重庆江北国际机场', N'CZ', 0),
    (N'005', N'20:56:00.0000000', N'02:10:00.0000000', N'重庆江北国际机场', N'香港国际机场', N'PN', 1),
    (N'006', N'09:07:00.0000000', N'12:13:00.0000000', N'秦皇岛北戴河国际机场', N'上海虹桥国际机场', N'MF', 0),
    (N'007', N'01:39:00.0000000', N'05:50:00.0000000', N'香港国际机场', N'北京大兴国际机场', N'CA', 0);
/**/
INSERT INTO Flight_Management_System.dbo.[User] (Uid, Uname, Height, Sex, Age)
VALUES
    (N'001', N'乘客1', 173, N'F', 20),
    (N'002', N'乘客2', 170, N'M', 50),
    (N'003', N'乘客3', 175, N'M', 46),
    (N'004', N'乘客4', 119, N'F', 7),
    (N'005', N'乘客5', 180, N'F', 17),
    (N'006', N'乘客6', 145, N'F', 12),
    (N'007', N'乘客7', 125, N'M', 6),
    (N'008', N'乘客8', 100, N'M', 4),
    (N'009', N'乘客9', 173, N'M', 40),
    (N'010', N'乘客10', 176, N'F', 32),
    (N'011', N'乘客11', 170, N'F', 59);
/**/
INSERT INTO Flight_Management_System.dbo.Vip (Uid, Cid)
VALUES 
(N'001', N'CZ'),
(N'002', N'MU'),
(N'002', N'SC'),
(N'003', N'PN');
/**/
INSERT INTO Flight_Management_System.dbo.Staff (Sid, Sname, Sleader_id, Stitle, Sairport_id)
VALUES 
(N'001', N'员工1', N'001', N'职位1', N'001'),
(N'002', N'员工2', N'001', N'职位2', N'001'),
(N'003', N'员工3', N'003', N'职位1', N'002'),
(N'004', N'员工4', N'004', N'职位1', N'003'),
(N'005', N'员工5', N'005', N'职位3', N'004'),
(N'006', N'员工6', N'006', N'职位1', N'005'),
(N'007', N'员工7', N'006', N'职位4', N'005'),
(N'008', N'员工8', N'008', N'职位1', N'006'),
(N'009', N'员工9', N'009', N'职位5', N'007');
/**/
INSERT INTO Flight_Management_System.dbo.Fli_Date (Fid, Date, Fir_Num, Fir_Pri, Eco_Num, Eco_Pri)
VALUES 
    (N'001', N'2024-12-20', 1, 1000, 0, 800),
    (N'002', N'2024-12-10', 1, 800, 1, 700),
    (N'002', N'2024-12-28', 0, 900, 1, 800),
    (N'003', N'2024-12-12', 0, 700, 0, 500);

