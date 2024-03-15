-- MENDEFINISIKAN TABLE=====================================================

-- Membuat database
create database binar;

-- Ganti database
\c binar

-- Create table nasabah
create table nasabah(
	nasabah_id bigserial primary key,
	nik varchar(16) not null,
	nama varchar(50) not null,
	email varchar(100) not null,
	telp varchar(13) not null,
	alamat varchar(255) not null,
	tgl_lahir date not null
);

-- Create table akun
create table akun(
	akun_id bigserial primary key,
	nasabah_id int,
	tipe_akun varchar(50) not null,
	saldo int not null,
	foreign key (nasabah_id) references nasabah(nasabah_id) on delete cascade
);

-- Create table transaksi
create table transaksi(
	transaksi_id bigserial primary key,
	akun_id int,
	tipe_transaksi varchar(50) not null,
	jumlah_transaksi int not null,
	keterangan varchar(255),
	foreign key (akun_id) references akun(akun_id) on delete cascade
);

-- CRUD OPERATIOIN======================================================
-- 
-- CREATE DATA USING INSERT INTO
insert into nasabah (nik,nama,email,telp,alamat,tgl_lahir)
values ('36062359979','I Ketut Krisna','ketutkrisna@gmail.com','081314206253','Bonang','2003-03-28');

insert into akun(nasabah_id,tipe_akun,saldo)
values ((select nasabah_id from nasabah where nama = 'I Ketut Krisna'),'Gold',500000);

insert into transaksi(akun_id,tipe_transaksi,jumlah_transaksi,keterangan)
values (
	(select akun_id from akun where nasabah_id = 
	(select nasabah_id from nasabah where nama = 'I Ketut Krisna')),'Deposit',100000,'Menabung');

-- READ DATA USING SELECT
select * from nasabah;
select nasabah_id,tipe_akun,saldo from akun;
select akun_id,tipe_transaksi,jumlah_transaksi,keterangan from transaksi;

-- UPDATE DATA USING UPDATE
update nasabah
set nama = 'ketut'
where nik ='36062359979';

update akun
set saldo = saldo + (select jumlah_transaksi from transaksi where akun_id = 1)
where akun_id =1;

-- DELETE DATA

delete from transaksi where akun_id = 1;
delete from akun where nasabah_id = 
	(select nasabah_id from nasabah where nik = '36062359979');
