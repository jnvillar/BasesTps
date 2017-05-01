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
    Tipo varchar(255),
    Sexo char(1) NOT NULL,
    PRIMARY KEY (IdModalidad),
    CHECK (Tipo IN ("Combate", "Forma", "Salto", "Rotura Potencia", "Combate Equipos")),
  	CHECK (Sexo IN ('F', 'M')) 
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

CREATE TABLE Combate (
    IdModalidad integer NOT NULL,
    Peso varchar(255) NOT NULL,
    Edad varchar(255) NOT NULL,
    PRIMARY KEY (IdModalidad),
    FOREIGN KEY (IdModalidad) REFERENCES Modalidad(IdModalidad),
  	CHECK (Peso IN ("Liviano", "Medio", "Pesado") ),
  	CHECK (Edad IN ("Juveniles", "Adultos") )
);

CREATE TABLE Forma (
    IdModalidad integer NOT NULL,
    Edad varchar(255) NOT NULL,
    PRIMARY KEY (IdModalidad),
    FOREIGN KEY (IdModalidad) REFERENCES Modalidad(IdModalidad),
    CHECK (Edad IN ("Juveniles", "Adultos") )
);

CREATE TABLE Salto (
    IdModalidad integer NOT NULL,
    Edad varchar(255) NOT NULL,
    PRIMARY KEY (IdModalidad),
    FOREIGN KEY (IdModalidad) REFERENCES Modalidad(IdModalidad),
    CHECK (Edad IN ("Juveniles", "Adultos") )
);

CREATE TABLE RoturaPotencia (
    IdModalidad integer NOT NULL,
    PRIMARY KEY (IdModalidad),
    FOREIGN KEY (IdModalidad) REFERENCES Modalidad(IdModalidad)
);

CREATE TABLE CombateEquipos (
    IdModalidad integer NOT NULL,
    PRIMARY KEY (IdModalidad),
    FOREIGN KEY (IdModalidad) REFERENCES Modalidad(IdModalidad)
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

INSERT INTO Escuela VALUES(1, 'Argentina', 1);
INSERT INTO Escuela VALUES(2, 'Bolivia', 2);
INSERT INTO Escuela VALUES(3, 'Paraguay', 3);

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

INSERT INTO Modalidad VALUES(1, 'Formas', 'M');
INSERT INTO Modalidad VALUES(2, 'Combate', 'F');
INSERT INTO Modalidad VALUES(3, 'Combate', 'M');
INSERT INTO Modalidad VALUES(4, 'Combate Equipos', 'M');

INSERT INTO Inscripcion values(1, 100003, 1);
INSERT INTO Inscripcion values(2, 100004, 1);
INSERT INTO Inscripcion values(3, 100005, 2);
INSERT INTO Inscripcion values(4, 100006, 3);
INSERT INTO Inscripcion values(1, 100007, 3);

INSERT INTO Combate VALUES(2, 'Liviano', 'Juveniles');
INSERT INTO Combate VALUES(3, 'Medio', 'Juveniles');

INSERT INTO Forma VALUES(1, 'Juveniles');

INSERT INTO CombateEquipos VALUES(4);

INSERT INTO Competencia VALUES(1, 1);
INSERT INTO Competencia VALUES(2, 2);
INSERT INTO Competencia VALUES(3, 3);
INSERT INTO Competencia VALUES(4, 4);

INSERT INTO Arbitro VALUES(1, 'Gonzalo', 'Perez', 'Argentina', 'Primer Dan');
INSERT INTO Arbitro VALUES(2, 'Pepito', 'Gonzalez', 'Paraguay', 'Segundo Dan');
INSERT INTO Arbitro VALUES(3, 'Armando', 'Martinez', 'Bolivia', 'Tercer Dan');
INSERT INTO Arbitro VALUES(4, 'Raul', 'Perez', 'Paraguay', 'Primer Dan');

INSERT INTO Arbitrada VALUES(1, 1, 'Juez');
INSERT INTO Arbitrada VALUES(2, 2, 'Presidente de Mesa');
INSERT INTO Arbitrada VALUES(3, 3, 'Suplente');
INSERT INTO Arbitrada VALUES(4, 4, 'Arbitro Central');

INSERT INTO GanaIndividualmente VALUES(1, 100003, 'Oro');
INSERT INTO GanaIndividualmente VALUES(2, 100004, 'Oro');
INSERT INTO GanaIndividualmente VALUES(3, 100005, 'Plata');
INSERT INTO GanaIndividualmente VALUES(1, 100007, 'Oro');

INSERT INTO GanaComoEquipo VALUES(4, 1, 'Oro');

Select  a.Nombre as Nombre, m.IdModalidad as Categoria
From Competidor as c, Inscripcion as i, Modalidad as m, Alumno as a
Where c.DNI = i.DNI
and a.DNI = c.dni
and  i.IdModalidad = m.IdModalidad


Select res.pais, res.medalla, sum(res.cantidad) from (
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
group by e.pais, ge.medalla) ) res
group by res.pais, res.medalla

20:31:07	Select res.pais, res.medalla, res.cantidad from ( (Select e.pais as Pais, gi.medalla as Medalla, count(1) as Cantidad From Escuela e, Maestro m, Inscripcion i, Competidor c, GanaIndividualmente as gi Where  e.NroDePlacaMaestro = m.NroDePlacaMaestro and m.NroDePlacaMaestro = i.NroDePlacaMaestro and c.dni = i.dni and gi.DNI = c.DNI group by e.pais, gi.medalla) Union All (Select e.pais as Pais, ge.medalla as Medalla, count(1) as Cantidad From Escuela e, Maestro m, Inscripcion i, Competidor c, Equipo eq, GanaComoEquipo as ge Where  e.NroDePlacaMaestro = m.NroDePlacaMaestro and m.NroDePlacaMaestro = i.NroDePlacaMaestro and c.dni = i.dni and ge.IdEquipo = eq.IdEquipo and eq.idEquipo = c.idEquipo group by e.pais, ge.medalla) ) res group by res.pais, res.medalla LIMIT 0, 1000	Error Code: 1055. Expression #3 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'res.Cantidad' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by	0.0015 sec
