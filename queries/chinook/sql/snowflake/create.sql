create warehouse if not exists chinook_wh;
create database if not exists chinook;
use database chinook;
create schema if not exists public;

drop table if exists album;
drop table if exists artist;
drop table if exists customer;
drop table if exists employee;
drop table if exists genre;
drop table if exists invoice;
drop table if exists invoice_line;
drop table if exists media_type;
drop table if exists playlist;
drop table if exists playlist_track;
drop table if exists track;

create table album
(
    album_id integer not null,
    title nvarchar(160) not null,
    artist_id integer not null,
    constraint pk_album primary key (album_id)
);

create table artist
(
    artist_id integer not null,
    name nvarchar(120),
    constraint pk_artist primary key (artist_id)
);

create table customer
(
    customer_id integer not null,
    first_name nvarchar(40) not null,
    last_name nvarchar(20) not null,
    company nvarchar(80),
    address nvarchar(70),
    city nvarchar(40),
    state nvarchar(40),
    country nvarchar(40),
    postal_code nvarchar(10),
    phone nvarchar(24),
    fax nvarchar(24),
    email nvarchar(60) not null,
    support_rep_id integer,
    constraint pk_customer primary key (customer_id)
);

create table employee
(
    employee_id integer not null,
    last_name nvarchar(20) not null,
    first_name nvarchar(20) not null,
    title nvarchar(30),
    reports_to integer,
    birth_date date,
    hire_date date,
    address nvarchar(70),
    city nvarchar(40),
    state nvarchar(40),
    country nvarchar(40),
    postal_code nvarchar(10),
    phone nvarchar(24),
    fax nvarchar(24),
    email nvarchar(60),
    constraint pk_employee primary key (employee_id)
);

create table genre
(
    genre_id integer not null,
    name nvarchar(120),
    constraint pk_genre primary key (genre_id)
);

create table invoice
(
    invoice_id integer not null,
    customer_id integer not null,
    invoice_date date not null,
    billing_address nvarchar(70),
    billing_city nvarchar(40),
    billing_state nvarchar(40),
    billing_country nvarchar(40),
    billing_postal_code nvarchar(10),
    total numeric(10,2) not null,
    constraint pk_invoice primary key (invoice_id)
);

create table invoice_line
(
    invoice_line_id integer not null,
    invoice_id integer not null,
    track_id integer not null,
    unit_price numeric(10,2) not null,
    quantity integer not null,
    constraint pk_invoice_line primary key (invoice_line_id)
);

create table media_type
(
    media_type_id integer not null,
    name nvarchar(120),
    constraint pk_media_type primary key (media_type_id)
);

create table playlist
(
    playlist_id integer not null,
    name nvarchar(120),
    constraint pk_playlist primary key (playlist_id)
);

create table playlist_track
(
    playlist_id integer not null,
    track_id integer not null,
    constraint pk_playlist_track primary key (playlist_id, track_id)
);

create table track
(
    track_id integer not null,
    name nvarchar(200) not null,
    album_id integer,
    media_type_id integer not null,
    genre_id integer,
    composer nvarchar(220),
    milliseconds integer not null,
    bytes integer,
    unit_price numeric(10,2) not null,
    constraint pk_track primary key (track_id)
);