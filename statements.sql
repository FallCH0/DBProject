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
/*
   