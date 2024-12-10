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
    Lea_p char(20) not null,
    Arr_p char(20) not null,
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
    (N'CZ', N'中国南方航空集团有限公司', 0.66),
    (N'PN', N'西部航空有限责任公司', 0.75),
    (N'MU', N'中国东方航空集团有限公司', 0.9),
    (N'MF', N'厦门航空有限公司', 0.72),
    (N'SC', N'山东航空股份有限公司', 0.85);
/**/
INSERT INTO Flight_Management_System.dbo.Flight (Fid, Lea_t, Arr_t, Lea_p, Arr_p, Cid, Add_Day)
VALUES
    (N'001', N'14:38:00.0000000', N'18:42:00.0000000', N'001', N'003', N'PN', 0),
    (N'002', N'23:41:00.0000000', N'04:26:00.0000000', N'002', N'004', N'SC', 1),
    (N'003', N'06:27:00.0000000', N'08:40:00.0000000', N'003', N'006', N'MU', 0),
    (N'004', N'17:05:00.0000000', N'22:44:00.0000000', N'004', N'005', N'CZ', 0),
    (N'005', N'20:56:00.0000000', N'02:10:00.0000000', N'005', N'007', N'PN', 1),
    (N'006', N'09:07:00.0000000', N'12:13:00.0000000', N'006', N'002', N'MF', 0),
    (N'007', N'01:39:00.0000000', N'05:50:00.0000000', N'007', N'001', N'CA', 0);
/**/
INSERT INTO Flight_Management_System.dbo.[User] (Uid, Uname, Height, Sex, Age)
VALUES
    (N'001', N'王强', 173, N'F', 20),
    (N'002', N'钱敏', 170, N'M', 50),
    (N'003', N'王芳', 175, N'M', 46),
    (N'004', N'吴秀英', 119, N'F', 7),
    (N'005', N'钱秀英', 180, N'F', 17),
    (N'006', N'赵强', 145, N'F', 12),
    (N'007', N'孙伟', 125, N'M', 6),
    (N'008', N'郑秀英', 100, N'M', 4),
    (N'009', N'孙丽', 173, N'M', 40),
    (N'010', N'吴伟', 176, N'F', 32),
    (N'011', N'赵伟', 170, N'F', 59),
    (N'012', N'李娜', 172, N'F', 22),
    (N'013', N'周强', 168, N'M', 28),
    (N'014', N'吴敏', 165, N'F', 24),
    (N'015', N'郑静', 180, N'M', 36),
    (N'016', N'王丽', 175, N'F', 31),
    (N'017', N'赵敏', 160, N'F', 29),
    (N'018', N'钱芳', 162, N'F', 23),
    (N'019', N'孙伟', 170, N'M', 42),
    (N'020', N'周娜', 166, N'F', 27),
    (N'021', N'李强', 175, N'M', 39),
    (N'022', N'吴伟', 182, N'M', 35),
    (N'023', N'郑芳', 168, N'F', 30),
    (N'024', N'王秀英', 169, N'F', 26),
    (N'025', N'赵敏', 174, N'M', 33),
    (N'026', N'钱静', 163, N'F', 25),
    (N'027', N'孙丽', 170, N'F', 21),
    (N'028', N'周强', 176, N'M', 37),
    (N'029', N'李娜', 169, N'F', 20),
    (N'030', N'吴秀英', 174, N'F', 18);
/**/
INSERT INTO [Vip] (Uid, Cid)
VALUES 
(N'005', N'CA'),
(N'005', N'MU'),
(N'005', N'SC'),
(N'012', N'PN'),
(N'027', N'MF'),
(N'015', N'CZ'),
(N'008', N'MU'),
(N'009', N'CA'),
(N'021', N'PN'),
(N'021', N'SC'),
(N'014', N'MF'),
(N'010', N'CZ'),
(N'030', N'MU'),
(N'026', N'CA'),
(N'016', N'PN');
/**/
INSERT INTO Flight_Management_System.dbo.Staff (Sid, Sname, Sleader_id, Stitle, Sairport_id)
VALUES 
    ('001', '赵刚', '001', '总管', '001'),
       ('002', '钱强', '001', '安保', '001'),
       ('003', '孙丽', '001', '地勤', '001'),
       ('004', '李梅', '001', '保洁', '001'),
       ('005', '周华', '001', '服务', '001'),
       ('006', '吴杰', '006', '总管', '002'),
       ('007', '郑勇', '006', '安保', '002'),
       ('008', '王芳', '006', '地勤', '002'),
       ('009', '陈静', '006', '保洁', '002'),
       ('010', '林玲', '006', '服务', '002'),
       ('011', '胡明', '011', '总管', '003'),
       ('012', '徐峰', '011', '安保', '003'),
       ('013', '郭悦', '011', '地勤', '003'),
       ('014', '唐强', '011', '保洁', '003'),
       ('015', '潘丽', '011', '服务', '003'),
       ('016', '朱杰', '016', '总管', '004'),
       ('017', '秦勇', '016', '安保', '004'),
       ('018', '梁芳', '016', '地勤', '004'),
       ('019', '魏静', '016', '保洁', '004'),
       ('020', '蔡玲', '016', '服务', '004'),
       ('021', '黄明', '021', '总管', '005'),
       ('022', '苏峰', '021', '安保', '005'),
       ('023', '范悦', '021', '地勤', '005'),
       ('024', '董强', '021', '保洁', '005'),
       ('025', '薛丽', '021', '服务', '005'),
       ('026', '彭杰', '026', '总管', '006'),
       ('027', '韩勇', '026', '安保', '006'),
       ('028', '罗芳', '026', '地勤', '006'),
       ('029', '石静', '026', '保洁', '006'),
       ('030', '吕玲', '026', '服务', '006'),
       ('031', '苗明', '031', '总管', '007'),
       ('032', '顾峰', '031', '安保', '007'),
       ('033', '毛悦', '031', '地勤', '007'),
       ('034', '夏强', '031', '保洁', '007'),
       ('035', '韦丽', '031', '服务', '007');
/**/
INSERT INTO Flight_Management_System.dbo.Fli_Date (Fid, Date, Fir_Num, Fir_Pri, Eco_Num,Eco_Pri)
VALUES 
    (N'001', N'2024-12-10', 5, 1000, 10, 800),
    (N'001', N'2024-12-11', 2, 1200, 11, 900),
    (N'001', N'2024-12-12', 8, 800, 9, 500),
    (N'002', N'2024-12-10', 2, 1000, 8, 800),
    (N'002', N'2024-12-11', 0, 1500, 1, 1000),
    (N'002', N'2024-12-12', 7, 1000, 13, 700),
    (N'003', N'2024-12-10', 4, 1000, 2, 500),
    (N'003', N'2024-12-11', 2, 1300, 8, 800),
    (N'003', N'2024-12-12', 3, 900, 15, 500),
    (N'004', N'2024-12-10', 8, 1000, 5, 800),
    (N'004', N'2024-12-11', 7, 1600, 1, 800),
    (N'004', N'2024-12-12', 6, 1000, 0, 500),
    (N'005', N'2024-12-10', 5, 1800, 7, 1000),
    (N'005', N'2024-12-11', 3, 2000, 9, 900),
    (N'005', N'2024-12-12', 2, 2200, 1, 1000),
    (N'006', N'2024-12-10', 4, 1200, 6, 800),
    (N'006', N'2024-12-11', 0, 800, 0, 300),
    (N'006', N'2024-12-12', 5, 1000, 10, 800),
    (N'007', N'2024-12-10', 1, 900, 0, 700),
    (N'007', N'2024-12-11', 2, 1000, 1, 600),
    (N'007', N'2024-12-12', 2, 1500, 3, 800);
/**/
INSERT INTO Crew_Flight (Cfid, Cfname, Cfleader_id, Cftitle, Cflight_id)
VALUES 
       ('001', '李明', '001', '机长', '001'),
       ('002', '王丽', '001', '副机长', '001'),
       ('003', '张悦', '001', '乘务长', '001'),
       ('004', '赵强', '001', '空乘', '001'),
       ('005', '李明', '005', '机长', '002'),
       ('006', '王丽', '005', '副机长', '002'),
       ('007', '张悦', '005', '乘务长', '002'),
       ('008', '赵强', '005', '空乘', '002'),
       ('009', '刘峰', '009', '机长', '003'),
       ('010', '陈静', '009', '副机长', '003'),
       ('011', '孙浩', '009', '乘务长', '003'),
       ('012', '周玲', '009', '空乘', '003'),
       ('013', '吴杰', '013', '机长', '004'),
       ('014', '郑芳', '013', '副机长', '004'),
       ('015', '钱敏', '013', '乘务长', '004'),
       ('016', '朱华', '013', '空乘', '004'),
       ('017', '黄勇', '017', '机长', '005'),
       ('018', '徐丽', '017', '副机长', '005'),
       ('019', '胡晓', '017', '乘务长', '005'),
       ('020', '郭明', '017', '空乘', '005'),
       ('021', '林强', '021', '机长', '006'),
       ('022', '苏瑶', '021', '副机长', '006'),
       ('023', '蔡晨', '021', '乘务长', '006'),
       ('024', '潘婷', '021', '空乘', '006'),
       ('025', '秦宇', '025', '机长', '007'),
       ('026', '梁辉', '025', '副机长', '007'),
       ('027', '唐悦', '025', '乘务长', '007'),
       ('028', '魏玲', '025', '空乘', '007');
/**/
INSERT INTO [Order] (Oid, Uid, Fid, Date, Grade)
VALUES
('POSGMW1S9M', '009', '003', '2024-12-11', N'头等舱'),
('4S4KVBR3UY', '007', '003', '2024-12-11', N'经济舱'),
('KH40NNNPAO', '008', '007', '2024-12-10', N'头等舱'),
('AEYRHMYJUM', '023', '007', '2024-12-11', N'头等舱'),
('Q2MBW0460I', '017', '005', '2024-12-10', N'经济舱'),
('Z2CL1Y2I56', '010', '006', '2024-12-10', N'经济舱'),
('4EYSMOMU5C', '020', '003', '2024-12-11', N'经济舱'),
('6KH6PW26P1', '026', '003', '2024-12-11', N'经济舱'),
('R5F1YC5TEJ', '028', '003', '2024-12-12', N'经济舱'),
('63ZHD6XMFV', '002', '002', '2024-12-10', N'经济舱'),
('IT6NN159BG', '019', '002', '2024-12-12', N'经济舱'),
('T23U154LYY', '026', '006', '2024-12-11', N'头等舱'),
('O3OE8XSDA3', '022', '004', '2024-12-12', N'经济舱'),
('QRMFKLJD7O', '013', '005', '2024-12-12', N'经济舱'),
('KLR25TP988', '017', '004', '2024-12-10', N'经济舱'),
('IGKQQY42GG', '002', '003', '2024-12-10', N'头等舱'),
('CW72F5MGSY', '018', '004', '2024-12-11', N'头等舱'),
('VBX96VH8S4', '007', '004', '2024-12-10', N'经济舱'),
('MLE4GDFKDG', '015', '004', '2024-12-10', N'头等舱'),
('K2BIAP4H17', '019', '007', '2024-12-12', N'头等舱'),
('WCVVNGQ1EE', '021', '003', '2024-12-10', N'头等舱'),
('E7SQ562QKE', '015', '003', '2024-12-12', N'头等舱'),
('0YF9J491X6', '015', '005', '2024-12-12', N'头等舱'),
('IQ8G3ZSK6B', '015', '002', '2024-12-12', N'头等舱'),
('N7N113622F', '028', '002', '2024-12-12', N'头等舱'),
('NXC5THI3BK', '020', '006', '2024-12-12', N'头等舱'),
('6L2K14GGI1', '009', '006', '2024-12-12', N'经济舱'),
('5KPG413CAX', '024', '007', '2024-12-10', N'经济舱'),
('FO540VWIGU', '014', '004', '2024-12-11', N'头等舱'),
('63P4KNJ4H2', '027', '007', '2024-12-11', N'头等舱')
/*增，删，改与添加约束*/
/*顾客周强开通了山东航空股份有限公司的vip，在vip表中加入此数据*/
INSERT INTO Vip (Uid, Cid) 
SELECT User.Uid, Company.Cid
FROM User, Company
WHERE User.Uname = '周强' AND Company.Cname = '山东航空股份有限公司';
/*003航班在2024-12-11的行程因天气取消，删除此次航班订单的相关信息*/
DELETE FROM [Order]
WHERE Fid = '003' AND Date = '2024-12-11';
/*安保钱强请了一周假，他的职位由迪丽热巴·迪力木拉提暂时顶替，修改员工表中的数据*/
UPDATE Staff
SET Sname = '迪丽热巴·迪力木拉提',
    Sex = '女'
WHERE Sname = '钱强';
/*添加vip折扣的约束为0-1之间*/
ALTER TABLE Company
ADD CONSTRAINT discount_c
CHECK (Discount BETWEEN 0 AND 1);
/*1.查询2024/12/11到达秦皇岛的人员的uid与姓名*/
SELECT DISTINCT [User].[Uid] AS '编号',Uname AS '姓名'
FROM [User]
WHERE [User].[Uid] IN (SELECT [Uid]
					   FROM [Order]
					   WHERE Date = '2024-12-11' AND Fid in (SELECT Fid
															 FROM Flight
															 WHERE Arr_p IN (SELECT Aid
																			 FROM Airport
																			 WHERE Aname LIKE '秦皇岛%')));
/*2.查找满足从北京到广州的航班的机长的工号，姓名及其公司*/
SELECT Cfid AS '工号',Cfname AS '姓名',Cname AS '公司'
FROM Crew_Flight,Company,(SELECT Fid,Cid
						  FROM Flight
						  WHERE Arr_p IN (SELECT Aid
										  FROM Airport
										  WHERE Aname LIKE '广州%')
							    AND Lea_p IN (SELECT Aid
											  FROM Airport
											  WHERE Aname LIKE '北京%')) AS FC(F,C)
WHERE Cftitle =  '机长' AND Cflight_id = F AND Cid = C;
/*3.查找近期满足从上海去厦门的航班的航班号，日期对应的经济舱数量以及余票*/
SELECT Fid AS '航班号',Date AS '日期',Eco_num AS '经济舱余票',Eco_pri AS '票价',Cname AS '航司'
FROM Fli_Date,Company,(SELECT Fid,Cid
						  FROM Flight
						  WHERE Arr_p IN (SELECT Aid
										  FROM Airport
										  WHERE Aname LIKE '厦门%')
							    AND Lea_p IN (SELECT Aid
											  FROM Airport
											  WHERE Aname LIKE '上海%')) AS FC(F,C)
WHERE Cid = C AND Fid = F;
/*4.李强想在2024/12/10从重庆到香港，想坐头等舱，查询符合条件的航班号，所属航司，原票价，实付金额*/
SELECT Fid AS '航班号',Cname AS '航司',Fir_Pri AS '原价',(Fir_Pri * COALESCE((SELECT Discount 
																			  FROM Company 
																			  WHERE Cid = C AND Cid IN (SELECT Cid
																										FROM Vip
																								WHERE [User].[Uid]=Vip.[Uid])),1 )) AS '实付金额'
FROM [User],Fli_Date,Company,(SELECT Fid,Cid
						  FROM Flight
						  WHERE Arr_p IN (SELECT Aid
										  FROM Airport
										  WHERE Aname LIKE '香港%')
							    AND Lea_p IN (SELECT Aid
											  FROM Airport
											  WHERE Aname LIKE '重庆%')) AS FC(F,C)
WHERE [Uname]='李强' AND Date = '2024-12-10' AND Company.Cid = C AND Fid = F ;
/*5.显示郑静近期的出行计划表，要求输出日期，航班号，出发地，目的地（按日期升序排列）*/
SELECT Date AS '日期',Flight.Fid AS '航班号',A.Aname AS '出发地',B.Aname AS '目的地'
FROM [Order],[User],Flight INNER JOIN Airport A ON A.Aid = Lea_p INNER JOIN Airport B ON B.Aid = Arr_p
WHERE Uname='郑静' AND [Order].[Uid] = [User].[Uid] AND [Order].Fid = Flight.Fid
ORDER BY Date;