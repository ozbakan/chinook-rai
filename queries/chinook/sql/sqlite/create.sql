/*******************************************************************************
   Drop Tables
*******************************************************************************/
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


/*******************************************************************************
   Create Tables
*******************************************************************************/
CREATE TABLE album
(
    album_id INTEGER NOT NULL,
    title NVARCHAR(160) NOT NULL,
    artist_id INTEGER NOT NULL,
    CONSTRAINT pk_album PRIMARY KEY (album_id),
    FOREIGN KEY (artist_id) REFERENCES artist (artist_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
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
    CONSTRAINT pk_customer PRIMARY KEY (customer_id),
    FOREIGN KEY (support_rep_id) REFERENCES employee (employee_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
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
    CONSTRAINT PK_Employee PRIMARY KEY (employee_id),
    FOREIGN KEY (reports_to) REFERENCES employee (employee_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
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
    CONSTRAINT pk_invoice PRIMARY KEY (invoice_id),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE invoice_line
(
    invoice_line_id INTEGER NOT NULL,
    invoice_id INTEGER NOT NULL,
    track_id INTEGER NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL,
    quantity INTEGER NOT NULL,
    CONSTRAINT pk_invoice_line PRIMARY KEY (invoice_line_id),
    FOREIGN KEY (invoice_id) REFERENCES invoice (invoice_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (track_id) REFERENCES track (track_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
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
    CONSTRAINT pk_playlist_track PRIMARY KEY (playlist_id, track_id),
    FOREIGN KEY (playlist_id) REFERENCES playlist (playlist_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (track_id) REFERENCES track (track_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
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
    CONSTRAINT pk_track PRIMARY KEY (track_id),
    FOREIGN KEY (album_id) REFERENCES album (album_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (media_type_id) REFERENCES media_type (media_type_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*******************************************************************************
   Create Foreign Keys
*******************************************************************************/
CREATE INDEX ifk_album_artist_id ON album (artist_id);

CREATE INDEX ifk_customer_support_rep_id ON customer (support_rep_id);

CREATE INDEX ifk_employee_reports_to ON employee (reports_to);

CREATE INDEX ifk_invoice_customer_id ON invoice (customer_id);

CREATE INDEX ifk_invoice_line_invoice_id ON invoice_line (invoice_id);

CREATE INDEX ifk_invoice_line_track_id ON invoice_line (track_id);

CREATE INDEX ifk_playlist_track_track_id ON playlist_track (track_id);

CREATE INDEX ifk_track_album_id ON track (album_id);

CREATE INDEX ifk_track_genre_id ON track (genre_id);

CREATE INDEX ifk_track_media_type_id ON track (media_type_id);
