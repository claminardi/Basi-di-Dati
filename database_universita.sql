drop database universita;
create database if not exists universita;

	use universita;

	drop table if exists studente;
	create table studente (
		matricola char(6) primary key,
		corso_laurea varchar(10) not null,
		nome varchar(20) not null,
		cognome varchar(20) not null,
		data_nascita date not null,
		codice_fiscale char(16) unique,
		foto blob);

	drop table if exists docente;
	create table docente (
		matricola char(6) primary key,
		dipartimento varchar(5) not null ,
		nome varchar(20) not null ,
		cognome varchar(20) not null,
		data_nascita date not null,
		codice_fiscale char(16) unique,
		foto blob);

	drop table if exists modulo;
	create table modulo (
		codice varchar(5) primary key unique,
		nome varchar(100) not null,
		descrizione varchar(100),
		cfu smallint not null check (cfu > 0 and cfu <= 20));

	drop table if exists esame;
	create table esame (
		matricola_studente char(6) not null,
		codice_modulo varchar(5) not null,
		matricola_docente char(6) not null,
		data date not null,
		voto smallint not null check (voto >= 18 and voto <= 30),
		note varchar(50),
		foreign key(matricola_studente) references studente(matricola) on delete no action on update cascade,
		foreign key(matricola_docente) references docente(matricola) on delete no action on update cascade,
		foreign key(codice_modulo) references modulo(codice) on delete no action on update cascade);

	drop table if exists corso_di_laurea;
	create table corso_di_laurea (
		codice varchar(10) primary key,
		nome varchar(60) unique,
		descrizione varchar(50));

	drop table if exists dipartimento;
	create table dipartimento (
		codice varchar(5) primary key,
		nome varchar(30) unique);

	drop table if exists sede;
	create table sede (
		codice varchar(10) primary key,
		indirizzo varchar(30) not null,
		citta varchar(30) not null);

	drop table if exists sede_dipartimento;
	create table sede_dipartimento (
		codice_sede varchar(10) not null,
		codice_dipartimento varchar(10) not null,
		note varchar(50),
		foreign key(codice_sede) references sede(codice) on delete no action on update cascade,
		foreign key(codice_dipartimento) references dipartimento(codice) on delete no action on update cascade);


	insert into studente (matricola, corso_laurea, nome, cognome, data_nascita, codice_fiscale, foto)
		values('697556', 'ICD', 'Mario', 'Rossi', '1999-10-23', 'RSSMRA99R23L049M', NULL);

	insert into studente (matricola, corso_laurea, nome, cognome, data_nascita, codice_fiscale, foto)
		values('348965', 'ITPS', 'Alessio', 'Ferrari', '1999-12-12', 'FRRLSS99T12A662Z', NULL);

	insert into docente (matricola, dipartimento, nome, cognome, data_nascita, codice_fiscale, foto)
		values('281145', 'INFO', 'Francesco', 'Verdi', '1977-03-24', 'VRDFNC77D24A662Z', NULL);

	insert into docente (matricola, dipartimento, nome, cognome, data_nascita, codice_fiscale, foto)
		values('321450', 'MAT', 'Anna', 'Russo', '1958-05-12', 'RSSNNA73E52D612E', NULL);

	insert into modulo (codice, nome, descrizione, cfu)
		values('BdD', 'Basi di Dati', 'Corso di Basi di Dati', 12);

	insert into modulo (codice, nome, descrizione, cfu)
		values('AM', 'Analisi Matematica', 'Corso di Analisi Matematica', 9);

	insert into esame (matricola_studente, codice_modulo, matricola_docente, data, voto, note)
		values('697556', 'BdD', '281145', '2020-01-24', 30, NULL);

	insert into esame (matricola_studente, codice_modulo, matricola_docente, data, voto, note)
		values('348965', 'BdD', '281145', '2020-02-25', 28, NULL);

	insert into esame (matricola_studente, codice_modulo, matricola_docente, data, voto, note)
		values('697556', 'AM', '321450', '2020-01-13', 29, NULL);

	insert into esame (matricola_studente, codice_modulo, matricola_docente, data, voto, note)
		values('348965', 'AM', '321450', '2020-02-13', 21, NULL);

	insert into corso_di_laurea (codice, nome, descrizione)
		values('ICD', 'Informatica e Comunicazione Digitale', NULL);

	insert into corso_di_laurea (codice, nome, descrizione)
		values('ITPS', 'Informatica e Tecnologie per la Produzione del Software', NULL);

	insert into dipartimento (codice, nome)
		values('INFO', 'Dipartimento di Informatica');

	insert into dipartimento (codice, nome)
		values('MAT', 'Dipartimento di Matematica');

	insert into sede (codice, indirizzo, citta)
		values('INFOBA', 'Via Edoardo Orabona, 4', 'Bari');

	insert into sede (codice, indirizzo, citta)
		values('MATBA', 'Via Edoardo Orabona, 4', 'Bari');

	insert into sede_dipartimento (codice_sede, codice_dipartimento, note)
		values('INFOBA', 'INFO', NULL);

	insert into sede_dipartimento (codice_sede, codice_dipartimento, note)
		values('MATBA', 'MAT', NULL);

	insert into docente (matricola, dipartimento, nome, cognome, data_nascita, codice_fiscale, foto)
		values('983478', 'INFO', 'Lorenzo', 'Neri', '1975-04-29', 'NRELNZ75D29L049J', NULL);

	insert into modulo (codice, nome, descrizione, cfu)
		values('IdS', 'Ingegneria del Software', 'Corso di Ingegneria del Software', 12);

	insert into studente (matricola, corso_laurea, nome, cognome, data_nascita, codice_fiscale, foto)
		values('655796', 'ICD', 'Maria', 'Russo', '1999-05-23', 'RSSMRA99E63L049R', NULL);

	insert into esame(matricola_studente, codice_modulo, matricola_docente, data, voto, note)
		values('348965', 'IdS', '983478', '2020-07-10', '25', NULL);

	insert into docente (matricola, dipartimento, nome, cognome, data_nascita, codice_fiscale, foto)
		values('763242', 'INFO', 'Marco', 'Torri', '1980-11-11', 'TRRMRC80S11L049A', NULL);

	insert into modulo (codice, nome, descrizione, cfu)
		values('AdESO', 'Architettura degli Elaboratori e Sistemi Operativi', 'Architettura degli Elaboratori e Sistemi Operativi', 9);

    insert into esame(matricola_studente, codice_modulo, matricola_docente, data, voto, note)
		values('348965', 'AdESO', '763242', '2020-07-13', '20', NULL);

	insert into esame(matricola_studente, codice_modulo, matricola_docente, data, voto, note)
		values('697556', 'AdESO', '763242', '2020-07-13', '30', NULL);

	insert into esame(matricola_studente, codice_modulo, matricola_docente, data, voto, note)
		values('655796', 'AdESO', '763242', '2020-07-13', '21', NULL);




