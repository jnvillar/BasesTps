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
    CHECK (Peso IN ("Liviano", "Medio", "Pesado", NULL) ),
    CHECK (Edad IN ("Juveniles", "Adultos", NULL) )
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


INSERT INTO Maestro VALUES (1, 'Pepe', 'Argento', 'Primer Dan');
INSERT INTO Maestro VALUES (2, 'Armando', 'Barreda', 'Segundo Dan');
INSERT INTO Maestro VALUES (3, 'Jose', 'Martinez', 'Tercer Dan');

INSERT INTO Escuela VALUES(1,'Escuela 1', 'Argentina', 1);
INSERT INTO Escuela VALUES(2,'Escuela 2', 'Bolivia', 2);
INSERT INTO Escuela VALUES(3,'Escuela 3', 'Paraguay', 3);

INSERT INTO Alumno VALUES(100000, 'Marcos', 'Perez', 1, 'Primer Dan', 'link a foto de Marcos');
INSERT INTO Alumno VALUES(100001, 'Laura', 'Gonzalez', 2, 'Segundo Dan', 'link a foto de Laura');
INSERT INTO Alumno VALUES(100002, 'Romina', 'Martinez', 2, 'Tercer Dan', 'link a foto de Romina');
INSERT INTO Alumno VALUES(100003, 'Raul', 'Gaitan', 1, 'Primer Dan', 'link a foto de Raul');
INSERT INTO Alumno VALUES(100004, 'Gonzalo', 'Herrera', 2, 'Segundo Dan', 'link a foto de Gonzalo');
INSERT INTO Alumno VALUES(100005, 'Alexis', 'Herrero', 2, 'Tercer Dan', 'link a foto de Alexis');
INSERT INTO Alumno VALUES(100006, 'Sebastian', 'Perez', 2, 'Cuarto Dan', 'link a foto de Sebastian');
INSERT INTO Alumno VALUES(100007, 'Sebastian', 'Perez', 2, 'Cuarto Dan', 'link a foto de Sebastian');

INSERT INTO Equipo VALUES(1, 'Equipo ROJO');
INSERT INTO Equipo VALUES(2, 'Coon y Amigos');
INSERT INTO Equipo VALUES(3, 'Los Taekwondistas indestructibles');

INSERT INTO Coach VALUES(100000);
INSERT INTO Coach VALUES(100001);
INSERT INTO Coach VALUES(100002);
INSERT INTO Coach VALUES(100003);

INSERT INTO Competidor VALUES(100003, 120, 'M', CURDATE(), NULL, 100002);
INSERT INTO Competidor VALUES(100004, 120, 'M', CURDATE(), NULL, 100000);
INSERT INTO Competidor VALUES(100005, 120, 'M', CURDATE(), NULL, 100001);
INSERT INTO Competidor VALUES(100006, 120, 'M', CURDATE(), 1, 100002);
INSERT INTO Competidor VALUES(100007, 120, 'M', CURDATE(), NULL, 100002);

INSERT INTO Modalidad VALUES(1, 'Formas', 'M', NULL, 'Juveniles','Primer Dan');
INSERT INTO Modalidad VALUES(2, 'Combate', 'F', 'Liviano', 'Juveniles','Segundo Dan');
INSERT INTO Modalidad VALUES(3, 'Combate', 'M', 'Medio', 'Juveniles','Primer Dan');
INSERT INTO Modalidad VALUES(4, 'Combate Equipos', 'M', NULL, NULL,'Tercer Dan');
INSERT INTO Modalidad VALUES(5, 'Combate', 'M', 'Medio', 'Juveniles','Primer Dan');

INSERT INTO Inscripcion values(1, 100003, 1);
INSERT INTO Inscripcion values(2, 100004, 1);
INSERT INTO Inscripcion values(3, 100005, 2);
INSERT INTO Inscripcion values(4, 100006, 3);
INSERT INTO Inscripcion values(1, 100007, 3);

INSERT INTO Competencia VALUES(1, 1);
INSERT INTO Competencia VALUES(2, 2);
INSERT INTO Competencia VALUES(3, 3);
INSERT INTO Competencia VALUES(4, 4);
INSERT INTO Competencia VALUES(5, 5);

INSERT INTO Arbitro VALUES(1, 'Gonzalo', 'Perez', 'Argentina', 'Primer Dan');
INSERT INTO Arbitro VALUES(2, 'Pepito', 'Gonzalez', 'Paraguay', 'Segundo Dan');
INSERT INTO Arbitro VALUES(3, 'Armando', 'Martinez', 'Bolivia', 'Tercer Dan');
INSERT INTO Arbitro VALUES(4, 'Raul', 'Perez', 'Paraguay', 'Primer Dan');

INSERT INTO Arbitrada VALUES(1, 1, 'Juez');
INSERT INTO Arbitrada VALUES(2, 2, 'Presidente de Mesa');
INSERT INTO Arbitrada VALUES(3, 3, 'Suplente');
INSERT INTO Arbitrada VALUES(4, 4, 'Arbitro Central');
INSERT INTO Arbitrada VALUES(4, 5, 'Arbitro Central');

INSERT INTO GanaIndividualmente VALUES(1, 100003, 'Oro');
INSERT INTO GanaIndividualmente VALUES(2, 100004, 'Oro');
INSERT INTO GanaIndividualmente VALUES(3, 100005, 'Plata');
INSERT INTO GanaIndividualmente VALUES(1, 100007, 'Oro');
INSERT INTO GanaIndividualmente VALUES(2, 100007, 'Bronce');
INSERT INTO GanaIndividualmente VALUES(3, 100007, 'Plata');

INSERT INTO GanaComoEquipo VALUES(4, 1, 'Oro');
INSERT INTO GanaComoEquipo VALUES(3, 1, 'Bronce');
INSERT INTO GanaComoEquipo VALUES(2, 1, 'Plata');

-- Ejercicio 1:
Select  a.Nombre as Nombre, m.*
From Competidor as c, Inscripcion as i, Modalidad as m, Alumno as a
Where c.DNI = i.DNI
and a.DNI = c.dni
and  i.IdModalidad = m.IdModalidad

-- Ejercicio 2:

CREATE VIEW MagicView AS
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
from MagicView t
where t.Medalla = 'oro' and t.cantidad = (select MAX(m.Cantidad) from MagicView M where m.Medalla = 'oro'))
union
(select t.Pais, t.Medalla, t.Cantidad
from MagicView t
where t.Medalla = 'plata' and t.cantidad = (select MAX(m.Cantidad) from MagicView M where m.Medalla = 'plata')))
union
(select t.Pais, t.Medalla, t.Cantidad
from MagicView t
where t.Medalla = 'bronce' and t.cantidad = (select MAX(m.Cantidad) from MagicView M where m.Medalla = 'bronce'))
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