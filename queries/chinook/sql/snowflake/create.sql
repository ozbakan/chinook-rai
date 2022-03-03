CREATE WAREHOUSE IF NOT EXISTS chinook_wh;
CREATE DATABASE IF NOT EXISTS chinook;
USE DATABASE chinook;
CREATE SCHEMA IF NOT EXISTS public;

DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS invoice;
DROP TABLE IF EXISTS invoice_line;
DROP TABLE IF EXISTS media_type;
DROP TABLE IF EXISTS playlist;
DROP TABLE IF EXISTS playlist_track;
DROP TABLE IF EXISTS track;

CREATE TABLE album
(
    album_id INTEGER NOT NULL,
    title NVARCHAR(160) NOT NULL,
    artist_id INTEGER NOT NULL,
    CONSTRAINT pk_album PRIMARY KEY (album_id)
);

CREATE TABLE artist
(
    artist_id INTEGER NOT NULL,
    name NVARCHAR(120),
    CONSTRAINT pk_artist PRIMARY KEY (artist_id)
);

CREATE TABLE customer
(
    customer_id INTEGER NOT NULL,
    first_name NVARCHAR(40) NOT NULL,
    last_name NVARCHAR(20) NOT NULL,
    company NVARCHAR(80),
    address NVARCHAR(70),
    city NVARCHAR(40),
    state NVARCHAR(40),
    country NVARCHAR(40),
    postal_code NVARCHAR(10),
    phone NVARCHAR(24),
    fax NVARCHAR(24),
    email NVARCHAR(60) NOT NULL,
    support_rep_id INTEGER,
    CONSTRAINT pk_customer PRIMARY KEY (customer_id)
);

CREATE TABLE employee
(
    employee_id INTEGER NOT NULL,
    last_name NVARCHAR(20) NOT NULL,
    first_name NVARCHAR(20) NOT NULL,
    title NVARCHAR(30),
    reports_to INTEGER,
    birth_date DATETIME,
    hire_date DATETIME,
    address NVARCHAR(70),
    city NVARCHAR(40),
    state NVARCHAR(40),
    country NVARCHAR(40),
    postal_code NVARCHAR(10),
    phone NVARCHAR(24),
    fax NVARCHAR(24),
    email NVARCHAR(60),
    CONSTRAINT PK_Employee PRIMARY KEY (employee_id)
);

CREATE TABLE genre
(
    genre_id INTEGER NOT NULL,
    name NVARCHAR(120),
    CONSTRAINT pk_genre PRIMARY KEY (genre_id)
);

CREATE TABLE invoice
(
    invoice_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    invoice_date DATETIME NOT NULL,
    billing_address NVARCHAR(70),
    billing_city NVARCHAR(40),
    billing_state NVARCHAR(40),
    billing_country NVARCHAR(40),
    billing_postal_code NVARCHAR(10),
    total NUMERIC(10,2) NOT NULL,
    CONSTRAINT pk_invoice PRIMARY KEY (invoice_id)
);

CREATE TABLE invoice_line
(
    invoice_line_id INTEGER NOT NULL,
    invoice_id INTEGER NOT NULL,
    track_id INTEGER NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL,
    quantity INTEGER NOT NULL,
    CONSTRAINT pk_invoice_line PRIMARY KEY (invoice_line_id)
);

CREATE TABLE media_type
(
    media_type_id INTEGER NOT NULL,
    name NVARCHAR(120),
    CONSTRAINT pk_media_type PRIMARY KEY (media_type_id)
);

CREATE TABLE playlist
(
    playlist_id INTEGER NOT NULL,
    name NVARCHAR(120),
    CONSTRAINT pk_playlist PRIMARY KEY (playlist_id)
);

CREATE TABLE playlist_track
(
    playlist_id INTEGER NOT NULL,
    track_id INTEGER NOT NULL,
    CONSTRAINT pk_playlist_track PRIMARY KEY (playlist_id, track_id)
);

CREATE TABLE track
(
    track_id INTEGER NOT NULL,
    name NVARCHAR(200) NOT NULL,
    album_id INTEGER,
    media_type_id INTEGER NOT NULL,
    genre_id INTEGER,
    composer NVARCHAR(220),
    milliseconds INTEGER NOT NULL,
    bytes INTEGER,
    unit_price NUMERIC(10,2) NOT NULL,
    CONSTRAINT pk_track PRIMARY KEY (track_id)
);