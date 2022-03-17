/*******************************************************************************
   Drop Tables
*******************************************************************************/
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


/*******************************************************************************
   create tables
*******************************************************************************/
create table album
(
    album_id integer not null,
    title nvarchar(160) not null,
    artist_id integer not null,
    constraint pk_album primary key (album_id),
    foreign key (artist_id) references artist (artist_id) 
        on delete no action on update no action
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
    constraint pk_customer primary key (customer_id),
    foreign key (support_rep_id) references employee (employee_id) 
        on delete no action on update no action
);

create table employee
(
    employee_id integer not null,
    last_name nvarchar(20) not null,
    first_name nvarchar(20) not null,
    title nvarchar(30),
    reports_to integer,
    birth_date datetime,
    hire_date datetime,
    address nvarchar(70),
    city nvarchar(40),
    state nvarchar(40),
    country nvarchar(40),
    postal_code nvarchar(10),
    phone nvarchar(24),
    fax nvarchar(24),
    email nvarchar(60),
    constraint PK_Employee primary key (employee_id),
    foreign key (reports_to) references employee (employee_id) 
        on delete no action on update no action
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
    invoice_date datetime not null,
    billing_address nvarchar(70),
    billing_city nvarchar(40),
    billing_state nvarchar(40),
    billing_country nvarchar(40),
    billing_postal_code nvarchar(10),
    total numeric(10,2) not null,
    constraint pk_invoice primary key (invoice_id),
    foreign key (customer_id) references customer (customer_id) 
        on delete no action on update no action
);

create table invoice_line
(
    invoice_line_id integer not null,
    invoice_id integer not null,
    track_id integer not null,
    unit_price numeric(10,2) not null,
    quantity integer not null,
    constraint pk_invoice_line primary key (invoice_line_id),
    foreign key (invoice_id) references invoice (invoice_id) 
        on delete no action on update no action,
    foreign key (track_id) references track (track_id) 
        on delete no action on update no action
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
    constraint pk_playlist_track primary key (playlist_id, track_id),
    foreign key (playlist_id) references playlist (playlist_id) 
        on delete no action on update no action,
    foreign key (track_id) references track (track_id) 
        on delete no action on update no action
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
    constraint pk_track primary key (track_id),
    foreign key (album_id) references album (album_id) 
        on delete no action on update no action,
    foreign key (genre_id) references genre (genre_id) 
        on delete no action on update no action,
    foreign key (media_type_id) references media_type (media_type_id) 
        on delete no action on update no action
);

/*******************************************************************************
   Create Foreign Keys
*******************************************************************************/
create index ifk_album_artist_id on album (artist_id);

create index ifk_customer_support_rep_id on customer (support_rep_id);

create index ifk_employee_reports_to on employee (reports_to);

create index ifk_invoice_customer_id on invoice (customer_id);

create index ifk_invoice_line_invoice_id on invoice_line (invoice_id);

create index ifk_invoice_line_track_id on invoice_line (track_id);

create index ifk_playlist_track_track_id on playlist_track (track_id);

create index ifk_track_album_id on track (album_id);

create index ifk_track_genre_id on track (genre_id);

create index ifk_track_media_type_id on track (media_type_id);
