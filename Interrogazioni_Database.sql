use universita;

	/*
	Mostrare nome e descrizione di tutti i moduli da 9 CFU
	*/

	select nome, descrizione
	from modulo
	where cfu > 9;

	/*
	Mostrare matricola, nome e cognome dei docenti che hanno più di 60 anni
	*/

	select matricola, nome, cognome
	from docente
	where timestampdiff(year, data_nascita, curdate()) > 60;

	/*
	Mostrare nome, cognome e nome del dipartimento di ogni docente, ordinati dal più giovane al più anziano.
	*/

	select nome, cognome, dipartimento
	from docente
	order by data_nascita desc;

	/*
	Mostrare città e indirizzo di ogni sede del dipartimento di codice "INFO"
	*/

	select citta, indirizzo
	from sede as s join sede_dipartimento as d on s.codice = d.codice_sede
	where codice_dipartimento = 'INFO'; 

	/*
	Mostrare nome del dipartimento, città e indirizzo di ogni sede di ogni dipartimento, 
	ordinate alfabeticamente prima per nome dipartimento, poi per nome città e infine per indirizzo.
	*/

	select d.nome as nomeDipartimento, s.citta, s.indirizzo
        from dipartimento as d, sede as s, sede_dipartimento as sd
        where d.codice = sd.codice_dipartimento and
        sd.codice_sede = s.codice
        order by d.nome, s.citta, s.indirizzo;

	/*
	Mostrare il nome di ogni dipartimento che ha una sede a Bari.
	*/

	select d.nome
	from dipartimento as d join sede_dipartimento as sd on d.codice = sd.codice_dipartimento
	join sede as s on codice_sede = s.codice
	where citta = 'Bari'; 

	/*
	Mostrare il nome di ogni dipartimento che non ha sede a Brindisi.
	*/

	select d.nome as nomeDipartimento
        from dipartimento as d
        where d.nome not in (select sd.codice_dipartimento
        from sede as s, sede_dipartimento as sd
        where sd.codice_sede = s.codice
        and s.citta = 'Brindisi');

	/*
	Mostrare media, numero esami sostenuti e totale CFU acquisiti dello studente con matricola 123456.
	*/

	select count(*) as numeroEsami, avg(voto) as media, sum(cfu) as sommaCFU
	from studente as s join esame as e on matricola = matricola_studente join modulo as m on codice = e.codice_modulo
	where matricola = '697556';

	/*
	Mostrare nome, cognome, nome del corso di laurea, media e numero esami sostenuti dello studente con matricola 123456.
	*/

	select s.nome, s.cognome, cl.nome, avg(voto) as media, count(*) as numeroEsami
	from studente as s join esame as e on s.matricola = e.matricola_studente 
	join corso_di_laurea as cl on cl.codice = corso_laurea
	where matricola = '697556';

	/*
	Mostrare codice, nome e voto medio di ogni modulo, ordinati dalla media più alta alla più bassa.
	*/

	select m.codice, m.nome, avg(voto) as votoMedio
	from modulo as m right join esame as e on m.codice = e.codice_modulo
	group by e.codice_modulo
	order by votoMedio desc;

	/*
	Mostrare nome e cognome del docente, nome e descrizione del modulo per ogni docente ed ogni modulo di 
	cui quel docente abbia tenuto almeno un esame; il risultato deve includere anche i docenti che non abbiano
	tenuto alcun esame, in quel caso rappresentati con un'unica tupla in cui nome e descrizione del modulo avranno 
	valore NULL.
	*/

	select m.nome, m.descrizione, d.nome, d.cognome
	from modulo as m left join esame as e on m.codice = e.codice_modulo  join docente as d on matricola_docente = d.matricola
	union
	select m.nome, m.descrizione, d.nome, d.cognome
	from modulo as m right join esame as e on m.codice = e.codice_modulo right join docente as d on matricola_docente = d.matricola;

	/*
	Mostrare matricola, nome, cognome, data di nascita, media e numero esami sostenuti di ogni studente.
	*/

	select s.matricola, s.nome, s.cognome, s.data_nascita, avg(voto) as mediaVoti, count(*) as numeroEsami
	from studente as s join esame as e on s.matricola = e.matricola_studente
	group by s.matricola;

	/*
	Mostrare matricola, nome, cognome, data di nascita, media e numero esami sostenuti di ogni 
	studente del corso di laurea di codice "ICD" che abbia media maggiore di 27.
	*/

	select s.matricola, s.nome, s.cognome, s.data_nascita, avg(voto) as mediaVoti, count(*) as numeroEsami
	from studente as s join esame as e on s.matricola = e.matricola_studente
	where corso_laurea = "ICD"
	group by s.matricola
	having mediaVoti > 27;

	/*
	Mostrare nome, cognome e data di nascita di tutti gli studenti che ancora non hanno superato nessun esame.
	*/

	select nome, cognome, data_nascita
	from studente
	where matricola not in (select matricola_studente from esame);

	/*
	Mostrare la matricola di tutti gli studenti che hanno superato almeno un esame
	e che hanno preso sempre voti maggiori di 26.
	*/

	select matricola 
	from studente
	where matricola in (select matricola_studente from esame group by matricola_studente having min(voto) > 26);

	/*
	Mostrare, per ogni modulo, il numero degli studenti che hanno preso tra 18 e 21,
	quelli che hanno preso tra 22 e 26 e quelli che hanno preso tra 27 e 30 (con un'unica interrogazione).
	*/

	select distinct m.nome,
	sum(case when e.voto >= 18 and e.voto <= 21 then 1 else 0 end) as numeroStudenti18_21,
	sum(case when e.voto >= 22 and e.voto <= 26 then 1 else 0 end) as numeroStudenti22_26,
	sum(case when e.voto >= 27 and e.voto <= 30 then 1 else 0 end) as numeroStudenti27_30
	from modulo as m right join esame as e on m.codice = e.codice_modulo
	group by m.codice;

	/*Mostrare matricola, nome, cognome e voto di ogni studente che ha preso un voto 
	maggiore della media nel modulo "BDD"*/

	select s.matricola, s.nome, s.cognome, e.voto
	from studente as s join esame as e on s.matricola = e.matricola_studente
	where e.codice_modulo = "BdD"
	group by e.codice_modulo
	having e.voto > avg(e.voto);

	/*
	Mostrare matricola, nome, cognome di ogni studente che ha preso ad almeno
	3 esami un voto maggiore della media per quel modulo.
	*/

