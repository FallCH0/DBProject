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
/*创建表Fli_Date并设置主键*/
create table dbo.Fli_Date
(
    Fid     char(20) not null
    Date    datetime not null,
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
alter table dbo.Order
    add constraint Order_Flight_Fid_fk
        foreign key (Fid) references dbo.Flight
/*订单-乘客*/
alter table dbo.Order
    add constraint Order_User_Uid_fk
        foreign key (Uid) references dbo.[User]
/*航班对应*/
alter table dbo.Fli_Date
    add constraint Fli_Date_Flight_Fid_fk
        foreign key (Fid) references dbo.Flight
