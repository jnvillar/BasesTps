CREATE TABLE Maestro (
    NroDePlacaMaestro integer NOT NULL,
    Nombre varchar(255) NOT NULL,
        Apellido varchar(255) NOT NULL,
        Graduacion varchar(255) NOT NULL,
    PRIMARY KEY (NroDePlacaMaestro),
    CHECK (Graduacion IN ("Primer Dan", "Segundo Dan", "Tercer Dan", "Cuarto Dan", "Quinto Dan", "Sexto Dan"))
);

CREATE TABLE Escuela (
    IdEscuela integer NOT NULL,
    Nombre varchar(255) NOT NULL,
    Pais varchar(255) NOT NULL,
    NroDePlacaMaestro integer NOT NULL,
    PRIMARY KEY (IdEscuela),
    FOREIGN KEY (NroDePlacaMaestro) REFERENCES Maestro(NroDePlacaMaestro)
);

CREATE TABLE Alumno (
    DNI integer NOT NULL,
    Nombre varchar(255) NOT NULL,
        Apellido varchar(255) NOT NULL,
        NroCertificadoITF integer NOT NULL,
        Graduacion varchar(255) NOT NULL,
        Foto varchar(255) NOT NULL,
    PRIMARY KEY (DNI),
    CHECK (Graduacion IN ("Primer Dan", "Segundo Dan", "Tercer Dan", "Cuarto Dan", "Quinto Dan", "Sexto Dan"))
);

CREATE TABLE Equipo (
    IdEquipo integer NOT NULL,
    Nombre varchar(255) NOT NULL,
    PRIMARY KEY (IdEquipo)
);

CREATE TABLE Coach (
    DNI integer NOT NULL,
    PRIMARY KEY (DNI),
    FOREIGN KEY (DNI) REFERENCES Alumno(DNI)
);

CREATE TABLE Competidor (
    DNI integer NOT NULL,
    Peso integer NOT NULL,
        Sexo char(1) NOT NULL,
        FechaDeNacimiento date NOT NULL,
    IdEquipo integer,
    DNICoach integer NOT NULL,
    PRIMARY KEY (DNI),
    FOREIGN KEY (IdEquipo) REFERENCES Equipo(IdEquipo),
    FOREIGN KEY (DNI) REFERENCES Alumno(DNI),
    FOREIGN KEY (DNICoach) REFERENCES Coach(DNI)
);

CREATE TABLE Modalidad (
    IdModalidad integer NOT NULL,
    Tipo varchar(255) NOT NULL,
    Sexo char(1) NOT NULL,
    Peso varchar(255),
    Edad varchar(255),
    Graduacion varchar(255),
    PRIMARY KEY (IdModalidad),
    CHECK (Tipo IN ("Combate", "Forma", "Salto", "Rotura Potencia", "Combate Equipos")),
    CHECK (Sexo IN ('F', 'M')),
    CHECK (Peso IN ("Liviano", "Medio", "Pesado", NULL)),
    CHECK (Edad IN ("Juveniles", "Adultos", NULL)),
    CHECK (Graduacion IN ("Primer Dan", "Segundo Dan", "Tercer Dan", "Cuarto Dan", "Quinto Dan", "Sexto Dan"))
);


CREATE TABLE Inscripcion (
    IdModalidad integer NOT NULL,
    DNI integer NOT NULL,
    NroDePlacaMaestro integer NOT NULL,
    PRIMARY KEY (IdModalidad,DNI),
    FOREIGN KEY (IdModalidad) REFERENCES Modalidad(IdModalidad),
    FOREIGN KEY (DNI) REFERENCES Competidor(DNI),
      FOREIGN KEY (NroDePlacaMaestro) REFERENCES Maestro(NroDePlacaMaestro)
);

CREATE TABLE Competencia (
    IdCompetencia integer NOT NULL,
    IdModalidad integer NOT NULL,
    PRIMARY KEY (IdCompetencia),
    FOREIGN KEY (IdModalidad) REFERENCES Modalidad(IdModalidad)
);

CREATE TABLE Arbitro (
        NroPlacaDeArbitro integer NOT NULL,
    Nombre varchar(255) NOT NULL,
        Apellido varchar(255) NOT NULL,
        Pais varchar(255) NOT NULL,
        Graduacion varchar(255) NOT NULL,
    PRIMARY KEY (NroPlacaDeArbitro),
    CHECK (Graduacion IN ("Primer Dan", "Segundo Dan", "Tercer Dan", "Cuarto Dan", "Quinto Dan", "Sexto Dan"))
);

CREATE TABLE Arbitrada (
    NroPlacaDeArbitro integer NOT NULL,
    IdCompetencia integer NOT NULL,
    Rol varchar(255) NOT NULL,
    PRIMARY KEY (NroPlacaDeArbitro,IdCompetencia),
    FOREIGN KEY (NroPlacaDeArbitro) REFERENCES Arbitro(NroPlacaDeArbitro),
    FOREIGN KEY (IdCompetencia) REFERENCES Competencia(IdCompetencia),
    CHECK (Rol IN ("Presidente de Mesa", "Arbitro Central", "Juez", "Suplente"))    
);

CREATE TABLE GanaIndividualmente (
    IdCompetencia integer NOT NULL,
    DNI integer NOT NULL,
    Medalla varchar(255) NOT NULL, 
    PRIMARY KEY (IdCompetencia,DNI),
    FOREIGN KEY (IdCompetencia) REFERENCES Competencia(IdCompetencia),
    FOREIGN KEY (DNI) REFERENCES Competidor(DNI)
);

CREATE TABLE GanaComoEquipo (
    IdCompetencia integer NOT NULL,
    IdEquipo integer NOT NULL,
    Medalla varchar(255) NOT NULL,
    PRIMARY KEY (IdCompetencia,IdEquipo),
    FOREIGN KEY (IdCompetencia) REFERENCES Competencia(IdCompetencia),
    FOREIGN KEY (IdEquipo) REFERENCES Equipo(IdEquipo),
    CHECK (Medalla IN ("Oro", "Bronce", "Plata"))
);

delimiter $$
CREATE FUNCTION FiveInTeam()
RETURNS int
deterministic
BEGIN
 DECLARE TeamsNoFiveMembers INT;
    SET TeamsNoFiveMembers = 0;
 select count(1) INTO TeamsNoFiveMembers
    from
  (select count(*) as Cant
  from Competidor
  group by IdEquipo) t
 where t.Cant <> 8;
    return TeamsNoFiveMembers;
END$$


ALTER TABLE Competidor ADD CONSTRAINT FiveForTeam CHECK (FiveInTeam() = 0)

INSERT INTO Maestro VALUES (1, 'Pepe', 'Argento', 'Primer Dan');
INSERT INTO Maestro VALUES (2, 'Armando', 'Barreda', 'Segundo Dan');
INSERT INTO Maestro VALUES (3, 'Jose', 'Martinez', 'Tercer Dan');
INSERT INTO Maestro VALUES (4, 'Facundo', 'Gonzalez', 'Tercer Dan');
INSERT INTO Maestro VALUES (5, 'Benito', 'Fernandez', 'Segundo Dan');
INSERT INTO Maestro VALUES (6, 'Carlos', 'Segundo', 'Cuarto Dan');
INSERT INTO Maestro VALUES (7, 'Marcos', 'Galperin', 'Sexto Dan');

INSERT INTO Escuela VALUES(1,'Escuela 1', 'Argentina', 1);
INSERT INTO Escuela VALUES(2,'Escuela 2', 'Bolivia', 2);
INSERT INTO Escuela VALUES(3,'Escuela 3', 'Paraguay', 3);
INSERT INTO Escuela VALUES(4,'Escuela 3', 'Chile', 4);
INSERT INTO Escuela VALUES(5,'Escuela 3', 'Chile', 5);
INSERT INTO Escuela VALUES(6,'Escuela 3', 'Chile', 6);
INSERT INTO Escuela VALUES(7,'Escuela 3', 'Argentina', 7);

INSERT INTO Alumno VALUES(100000, 'Marcos', 'Perez', 1, 'Primer Dan', 'link a foto de Marcos');
INSERT INTO Alumno VALUES(100001, 'Laura', 'Gonzalez', 2, 'Segundo Dan', 'link a foto de Laura');
INSERT INTO Alumno VALUES(100002, 'Romina', 'Martinez', 3, 'Tercer Dan', 'link a foto de Romina');
INSERT INTO Alumno VALUES(100003, 'Raul', 'Gaitan', 4, 'Primer Dan', 'link a foto de Raul');
INSERT INTO Alumno VALUES(100004, 'Gonzalo', 'Herrera', 5, 'Quinto Dan', 'link a foto de Gonzalo');
INSERT INTO Alumno VALUES(100005, 'Alexis', 'Herrero', 6, 'Tercer Dan', 'link a foto de Alexis');
INSERT INTO Alumno VALUES(100006, 'Sebastian', 'Perez', 7, 'Cuarto Dan', 'link a foto de Sebastian');
INSERT INTO Alumno VALUES(100007, 'Sebastian', 'Perez', 8, 'Cuarto Dan', 'link a foto de Sebastian');
INSERT INTO Alumno VALUES(100008, 'Florencia', 'Gonzalez', 9, 'Primer Dan', 'link a foto de Florencia');
INSERT INTO Alumno VALUES(100009, 'Maria', 'Emilia', 10, 'Segundo Dan', 'link a foto de Maria');
INSERT INTO Alumno VALUES(100010, 'Lucia', 'Diano', 11, 'Tercer Dan', 'link a foto de Lucia');
INSERT INTO Alumno VALUES(100011, 'Candela', 'Bustos', 12, 'Primer Dan', 'link a foto de Candela');
INSERT INTO Alumno VALUES(100012, 'Sofia', 'Iguerabide', 13, 'Segundo Dan', 'link a foto de Sofia');
INSERT INTO Alumno VALUES(100013, 'Brian', 'Bohe', 14, 'Quinto Dan', 'link a foto de Brian');
INSERT INTO Alumno VALUES(100014, 'Jessica', 'Aguirre', 15, 'Cuarto Dan', 'link a foto de Jessica');
INSERT INTO Alumno VALUES(100015, 'Joaquin', 'Diaz', 16, 'Sexto Dan', 'link a foto de Joaquin');
INSERT INTO Alumno VALUES(100016, 'Lucas', 'Perez', 17, 'Primer Dan', 'link a foto de Lucas');
INSERT INTO Alumno VALUES(100017, 'Walter', 'Nicolas', 18, 'Segundo Dan', 'link a foto de Walter');
INSERT INTO Alumno VALUES(100018, 'Juan', 'Noli', 19, 'Tercer Dan', 'link a foto de Juan');
INSERT INTO Alumno VALUES(100019, 'Axel', 'Lew', 20, 'Primer Dan', 'link a foto de Axel');
INSERT INTO Alumno VALUES(100020, 'German', 'Pinzon', 21, 'Quinto Dan', 'link a foto de German');
INSERT INTO Alumno VALUES(100021, 'Ezequiel', 'Ferrin', 22, 'Tercer Dan', 'link a foto de Ezequiel');
INSERT INTO Alumno VALUES(100022, 'Agustin', 'Waigand', 23, 'Cuarto Dan', 'link a foto de Agustin');
INSERT INTO Alumno VALUES(100023, 'Leandro', 'De Pietro', 24, 'Cuarto Dan', 'link a foto de Leandro');
INSERT INTO Alumno VALUES(100024, 'Oscar', 'Ortiz', 25, 'Primer Dan', 'link a foto de Oscar');
INSERT INTO Alumno VALUES(100025, 'Augusto', 'Consolani', 26, 'Segundo Dan', 'link a foto de Augusto');
INSERT INTO Alumno VALUES(100026, 'Erick', 'Chamo', 27, 'Tercer Dan', 'link a foto de Erick');
INSERT INTO Alumno VALUES(100027, 'Hernan', 'Wilkinson', 28, 'Primer Dan', 'link a foto de Hernan');
INSERT INTO Alumno VALUES(100028, 'Esteban', 'Wilkinson', 28, 'Primer Dan', 'link a foto de Esteban');

INSERT INTO Equipo VALUES(1, 'Equipo ROJO');
INSERT INTO Equipo VALUES(2, 'Coon y Amigos');
INSERT INTO Equipo VALUES(3, 'Los Taekwondistas indestructibles');
INSERT INTO Equipo VALUES(4, 'El robo del siglo');

INSERT INTO Coach VALUES(100000);
INSERT INTO Coach VALUES(100001);
INSERT INTO Coach VALUES(100002);
INSERT INTO Coach VALUES(100003);
INSERT INTO Coach VALUES(100014);
INSERT INTO Coach VALUES(100019);
INSERT INTO Coach VALUES(100025);
INSERT INTO Coach VALUES(100028);

INSERT INTO Competidor VALUES(100003, 120, 'M', CURDATE(), 1, 100000);
INSERT INTO Competidor VALUES(100004, 120, 'F', CURDATE(), 1, 100000);
INSERT INTO Competidor VALUES(100005, 120, 'F', CURDATE(), 1, 100000);
INSERT INTO Competidor VALUES(100006, 120, 'M', CURDATE(), 1, 100000);
INSERT INTO Competidor VALUES(100007, 120, 'M', CURDATE(), 1, 100000);

INSERT INTO Competidor VALUES(100008, 120, 'M', CURDATE(), NULL, 100000);
INSERT INTO Competidor VALUES(100009, 120, 'M', CURDATE(), 2, 100001);
INSERT INTO Competidor VALUES(100010, 120, 'M', CURDATE(), 2, 100001);
INSERT INTO Competidor VALUES(100011, 120, 'M', CURDATE(), 2, 100001);
INSERT INTO Competidor VALUES(100012, 120, 'M', CURDATE(), 2, 100002);
INSERT INTO Competidor VALUES(100013, 120, 'M', CURDATE(), 2, 100002);

INSERT INTO Competidor VALUES(100014, 120, 'M', CURDATE(), 3, 100014);
INSERT INTO Competidor VALUES(100015, 120, 'M', CURDATE(), 3, 100014);
INSERT INTO Competidor VALUES(100016, 120, 'M', CURDATE(), 3, 100014);
INSERT INTO Competidor VALUES(100017, 120, 'M', CURDATE(), 3, 100014);
INSERT INTO Competidor VALUES(100018, 120, 'M', CURDATE(), 3, 100014);

INSERT INTO Competidor VALUES(100019, 120, 'M', CURDATE(), 4, 100019);
INSERT INTO Competidor VALUES(100020, 120, 'M', CURDATE(), 4, 100019);
INSERT INTO Competidor VALUES(100021, 120, 'M', CURDATE(), 4, 100019);
INSERT INTO Competidor VALUES(100022, 120, 'M', CURDATE(), 4, 100019);
INSERT INTO Competidor VALUES(100023, 120, 'M', CURDATE(), 4, 100019);

INSERT INTO Competidor VALUES(100024, 120, 'M', CURDATE(), NULL, 100019);
INSERT INTO Competidor VALUES(100025, 120, 'M', CURDATE(), NULL, 100025);
INSERT INTO Competidor VALUES(100026, 120, 'M', CURDATE(), NULL, 100025);
INSERT INTO Competidor VALUES(100027, 120, 'M', CURDATE(), NULL, 100025);
INSERT INTO Competidor VALUES(100028, 120, 'M', CURDATE(), NULL, 100028);


INSERT INTO Modalidad VALUES(1, 'Formas', 'M', NULL, 'Juveniles','Primer Dan');
INSERT INTO Modalidad VALUES(2, 'Combate', 'F', 'Liviano', 'Juveniles','Segundo Dan');
INSERT INTO Modalidad VALUES(3, 'Combate', 'M', 'Medio', 'Juveniles','Primer Dan');
INSERT INTO Modalidad VALUES(5, 'Combate', 'M', 'Medio', 'Juveniles','Tercer Dan');
INSERT INTO Modalidad VALUES(7, 'Forma', 'M', NULL, 'Juveniles','Tercer Dan');
INSERT INTO Modalidad VALUES(8, 'Rotura de Potencia', 'M', NULL, NULL,'Tercer Dan');

INSERT INTO Modalidad VALUES(4, 'Combate Equipos', 'M', NULL, NULL,'Tercer Dan');
INSERT INTO Modalidad VALUES(6, 'Combate Equipos', 'F', NULL, NULL,'Primer Dan');

INSERT INTO Inscripcion values(4, 100004, 1); 
INSERT INTO Inscripcion values(4, 100005, 1);
INSERT INTO Inscripcion values(4, 100006, 1);
INSERT INTO Inscripcion values(4, 100007, 1);
INSERT INTO Inscripcion values(4, 100003, 1);

INSERT INTO Inscripcion values(4, 100009, 2);
INSERT INTO Inscripcion values(4, 100010, 2);
INSERT INTO Inscripcion values(4, 100011, 2);
INSERT INTO Inscripcion values(4, 100012, 2);
INSERT INTO Inscripcion values(4, 100013, 2);

INSERT INTO Inscripcion values(6, 100014, 3);
INSERT INTO Inscripcion values(6, 100015, 3);
INSERT INTO Inscripcion values(6, 100016, 3);
INSERT INTO Inscripcion values(6, 100017, 3);
INSERT INTO Inscripcion values(6, 100018, 3);

INSERT INTO Inscripcion values(6, 100019, 4);
INSERT INTO Inscripcion values(6, 100020, 4);
INSERT INTO Inscripcion values(6, 100021, 4);
INSERT INTO Inscripcion values(6, 100022, 4);
INSERT INTO Inscripcion values(6, 100023, 4);

INSERT INTO Inscripcion values(1, 100010, 2);
INSERT INTO Inscripcion values(1, 100027, 6);
INSERT INTO Inscripcion values(1, 100028, 7);

INSERT INTO Inscripcion values(2, 100003, 1);
INSERT INTO Inscripcion values(2, 100016, 3);
INSERT INTO Inscripcion values(2, 100008, 1);

INSERT INTO Inscripcion values(3, 100018, 3);
INSERT INTO Inscripcion values(3, 100012, 2);
INSERT INTO Inscripcion values(3, 100007, 1);

INSERT INTO Inscripcion values(5, 100025, 6);
INSERT INTO Inscripcion values(5, 100027, 6);
INSERT INTO Inscripcion values(5, 100024, 5);

INSERT INTO Inscripcion values(7, 100016, 3);
INSERT INTO Inscripcion values(7, 100010, 2);
INSERT INTO Inscripcion values(7, 100020, 4);

INSERT INTO Inscripcion values(8, 100026, 6);
INSERT INTO Inscripcion values(8, 100024, 5);
INSERT INTO Inscripcion values(8, 100015, 3);

INSERT INTO Competencia VALUES(1, 4);
INSERT INTO Competencia VALUES(2, 6);

INSERT INTO Competencia VALUES(3, 8);
INSERT INTO Competencia VALUES(4, 5);
INSERT INTO Competencia VALUES(5, 1);
INSERT INTO Competencia VALUES(6, 3);
INSERT INTO Competencia VALUES(7, 2);
INSERT INTO Competencia VALUES(8, 7);

INSERT INTO Arbitro VALUES(1, 'Gonzalo', 'Perez', 'Argentina', 'Primer Dan');
INSERT INTO Arbitro VALUES(2, 'Pepito', 'Gonzalez', 'Paraguay', 'Segundo Dan');
INSERT INTO Arbitro VALUES(3, 'Armando', 'Martinez', 'Bolivia', 'Tercer Dan');
INSERT INTO Arbitro VALUES(4, 'Raul', 'Perez', 'Paraguay', 'Primer Dan');

INSERT INTO Arbitrada VALUES(1, 1, 'Juez');
INSERT INTO Arbitrada VALUES(2, 2, 'Presidente de Mesa');
INSERT INTO Arbitrada VALUES(3, 3, 'Suplente');
INSERT INTO Arbitrada VALUES(4, 4, 'Arbitro Central');
INSERT INTO Arbitrada VALUES(4, 5, 'Arbitro Central');

INSERT INTO GanaIndividualmente VALUES(1, 100010, 'Oro');
INSERT INTO GanaIndividualmente VALUES(1, 100027, 'Bronce');
INSERT INTO GanaIndividualmente VALUES(1, 100028, 'Plata');

INSERT INTO GanaIndividualmente VALUES(2, 100003, 'Oro');
INSERT INTO GanaIndividualmente VALUES(2, 100016, 'Bronce');
INSERT INTO GanaIndividualmente VALUES(2, 100008, 'Plata');

INSERT INTO GanaIndividualmente VALUES(3, 100018, 'Oro');
INSERT INTO GanaIndividualmente VALUES(3, 100012, 'Bronce');
INSERT INTO GanaIndividualmente VALUES(3, 100007, 'Plata');

INSERT INTO GanaIndividualmente VALUES(5, 100025, 'Oro');
INSERT INTO GanaIndividualmente VALUES(5, 100024, 'Bronce');
INSERT INTO GanaIndividualmente VALUES(5, 100017, 'Plata');

INSERT INTO GanaIndividualmente VALUES(7, 100016, 'Oro');
INSERT INTO GanaIndividualmente VALUES(7, 100010, 'Bronce');
INSERT INTO GanaIndividualmente VALUES(7, 100020, 'Plata');

INSERT INTO GanaIndividualmente VALUES(8, 100026, 'Oro');
INSERT INTO GanaIndividualmente VALUES(8, 100024, 'Bronce');
INSERT INTO GanaIndividualmente VALUES(8, 100015, 'Plata');

INSERT INTO GanaComoEquipo VALUES(1, 1, 'Oro');
INSERT INTO GanaComoEquipo VALUES(3, 1, 'Plata');
INSERT INTO GanaComoEquipo VALUES(2, 1, 'Bronce');

INSERT INTO GanaComoEquipo VALUES(2, 2, 'Oro');
INSERT INTO GanaComoEquipo VALUES(4, 2, 'Bronce');
INSERT INTO GanaComoEquipo VALUES(1, 2, 'Plata');

-- Ejercicio 1:
Select  a.Nombre as Nombre, m.*
From Competidor as c, Inscripcion as i, Modalidad as m, Alumno as a
Where c.DNI = i.DNI
and a.DNI = c.dni
and  i.IdModalidad = m.IdModalidad

-- Ejercicio 2:

CREATE VIEW MedallasPais AS
Select res.pais as Pais, res.medalla as Medalla, sum(res.cantidad) as Cantidad from (
(Select e.pais as Pais, gi.medalla as Medalla, count(1) as Cantidad
From Escuela e, Maestro m, Inscripcion i, Competidor c, GanaIndividualmente as gi
Where e.NroDePlacaMaestro = m.NroDePlacaMaestro
and m.NroDePlacaMaestro = i.NroDePlacaMaestro
and c.dni = i.dni
and gi.DNI = c.DNI
group by e.pais, gi.medalla)
Union All
(Select e.pais as Pais, ge.medalla as Medalla, count(1) as Cantidad
From Escuela e, Maestro m, Inscripcion i, Competidor c, Equipo eq, GanaComoEquipo as ge
Where e.NroDePlacaMaestro = m.NroDePlacaMaestro
and m.NroDePlacaMaestro = i.NroDePlacaMaestro
and c.dni = i.dni
and ge.IdEquipo = eq.IdEquipo
and eq.idEquipo = c.idEquipo
group by e.pais, ge.medalla) ) res
group by res.pais, res.medalla



select t2.Pais, t2.Medalla, t2.Cantidad
from 
(
(( select t.Pais, t.Medalla, t.Cantidad
from MedallasPais t
where t.Medalla = 'oro' and t.cantidad = (select MAX(m.Cantidad) from MedallasPais M where m.Medalla = 'oro'))
union
(select t.Pais, t.Medalla, t.Cantidad
from MedallasPais t
where t.Medalla = 'plata' and t.cantidad = (select MAX(m.Cantidad) from MedallasPais M where m.Medalla = 'plata')))
union
(select t.Pais, t.Medalla, t.Cantidad
from MedallasPais t
where t.Medalla = 'bronce' and t.cantidad = (select MAX(m.Cantidad) from MedallasPais M where m.Medalla = 'bronce'))
) t2

-- Ejercicio 3 Por Pais:
Select medallero.Pais, sum(medallero.Puntaje) as Puntaje from(
    Select res.pais as Pais, (Case res.medalla when 'Oro' then 3 when 'Plata' then 2 else 1 end) * sum(res.cantidad) as Puntaje from (
        (Select e.pais as Pais, gi.medalla as Medalla, count(1) as Cantidad
        From Escuela e, Maestro m, Inscripcion i, Competidor c, GanaIndividualmente as gi
        Where  e.NroDePlacaMaestro = m.NroDePlacaMaestro
        and m.NroDePlacaMaestro = i.NroDePlacaMaestro
        and c.dni = i.dni
        and gi.DNI = c.DNI
        group by e.pais, gi.medalla)
    Union All
        (Select e.pais as Pais, ge.medalla as Medalla, count(1) as Cantidad
        From Escuela e, Maestro m, Inscripcion i, Competidor c, Equipo eq, GanaComoEquipo as ge
        Where  e.NroDePlacaMaestro = m.NroDePlacaMaestro
        and m.NroDePlacaMaestro = i.NroDePlacaMaestro
        and c.dni = i.dni
        and ge.IdEquipo = eq.IdEquipo
        and eq.idEquipo = c.idEquipo
        group by e.pais, ge.medalla) 
    ) res
    group by res.pais, res.medalla
) medallero
group by medallero.Pais

-- Ejercicio 3 por escuela
Select medallero.Escuela, sum(medallero.Puntaje) as Puntaje from(
    select t.nombre as Escuela, (Case t.medalla when 'Oro' then 3 when 'Plata' then 2 else 1 end)*sum(t.cantidad) as Puntaje
    from
    ((select es.nombre, gi.medalla, count(1) as Cantidad
    from Escuela es, GanaIndividualmente gi, Competidor c, Maestro m, Inscripcion i
    where gi.DNI = c.DNI and m.NroDePlacaMaestro = i.NroDePlacaMaestro and i.DNI = c.DNI and es.NroDePlacaMaestro = m.NroDePlacaMaestro
    group by es.nombre, gi.medalla
    )
    union
    (select es.nombre, ge.medalla ,count(1) as Cantidad
    from Escuela es, GanaComoEquipo ge, Competidor c, Equipo e, Maestro m, Inscripcion i
    where ge.idEquipo = e.idEquipo and e.idEquipo=c.idEquipo and m.NroDePlacaMaestro = i.NroDePlacaMaestro and i.DNI = c.DNI and es.NroDePlacaMaestro = m.NroDePlacaMaestro
    group by es.nombre, ge.medalla
    )) t
    group by t.nombre, t.medalla
)medallero
group by medallero.escuela

-- Ejecicio 4 

CREATE VIEW TournamentsByStudent AS
select t.DNI, t.Nombre, t.Apellido, t.Tipo, t.Sexo, t.Peso, t.Edad, if (gi.medalla is not null,gi.medalla,if(ge.medalla is not null,ge.medalla,'No ganó medalla')) as Medalla
from
(select c.DNI, al.Nombre, al.Apellido, m.Tipo, m.Sexo, m.Peso, m.Edad, compet.IdCompetencia, c.idEquipo
from Alumno al, Competidor c, Inscripcion i , Modalidad m , Competencia compet
where al.DNI = c.DNI and c.DNI = i.DNI and i.IdModalidad = m.IdModalidad and compet.IdModalidad = i.IdModalidad) t
left outer join
GanaIndividualmente gi
on gi.IdCompetencia = t.IdCompetencia and t.DNI = gi.DNI
left outer join
GanaComoEquipo ge
on ge.IdCompetencia = t.IdCompetencia and t.idEquipo = ge.idEquipo

select *
from TournamentsByStudent t
where t.DNI = '100003'

-- Ejercicio 5
select t.nombre,
sum(case when t.medalla = 'Oro' then 1 else 0 end) as Oro,
sum(case when t.medalla = 'Plata' then 1 else 0 end) as Plata,
sum(case when t.medalla = 'Bronce' then 1 else 0 end) as Bronce
from
((select es.nombre, gi.medalla, gi.IdCompetencia
from Escuela es, GanaIndividualmente gi, Competidor c, Maestro m, Inscripcion i
where gi.DNI = c.DNI and m.NroDePlacaMaestro = i.NroDePlacaMaestro and i.DNI = c.DNI and es.NroDePlacaMaestro = m.NroDePlacaMaestro
)
union
(select es.nombre, ge.medalla, ge.IdCompetencia
from Escuela es, GanaComoEquipo ge, Competidor c, Equipo e, Maestro m, Inscripcion i
where ge.idEquipo = e.idEquipo and e.idEquipo=c.idEquipo and m.NroDePlacaMaestro = i.NroDePlacaMaestro and i.DNI = c.DNI and es.NroDePlacaMaestro = m.NroDePlacaMaestro
)) t
group by t.nombre

-- Ejercicio 6
SELECT Nombre, Apellido, Pais FROM Arbitro

-- Ejercicio 7
select a.nombre, a.apellido 
  from Arbitro a, arbitrada ar, competencia c, modalidad m
    where a.NroPlacaDeArbitro = ar.NroPlacaDeArbitro and ar.IdCompetencia = c.IdCompetencia and
        c.IdModalidad = m.IdModalidad and m.tipo = "Combate" and ar.rol = "Arbitro Central"

-- Ejercicio 8
SELECT e.Nombre, es.Pais
FROM Equipo e, Competidor c, Inscripcion i, Maestro m, Escuela es
WHERE e.IdEquipo = c.IdEquipo AND i.DNI = c.DNI AND m.NroDePlacaMaestro = es.NroDePlacaMaestro
AND i.NroDePlacaMaestro = m.NroDePlacaMaestro