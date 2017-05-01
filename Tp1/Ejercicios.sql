Ejercicio 1:

Select  a.nombre as Nombre, m.id as Categoria
From Competidor as c, Inscripcion as i, Modalidad as m, Alumno as a
Where c.dni = i.dni
and a.dni = c.dni
and	i.idModalidad = m.idModalidad


Ejercicio 2:

Medallas que gano cada pais individualmente

Select t.pais as pais, sum(t.Cantidad) from 
Union All(

(Select e.pais as Pais, gi.medalla as Medalla, count(1) as Cantidad
From Escuela e, Maestro m, Inscripcion i, Competidor c, GanaIndividualmente as gi
Where  e.NroDePlacaMaestro = m.NroDePlacaMaestro
and m.NroDePlacaMaestro = i.NroDePlacaMaestro
and c.dni = i.dni
and gi.DNI = c.DNI
group by e.pais, gi.medalla) gi,

(Select e.pais as Pais, ge.medalla as Medalla, count(1) as Cantidad
From Escuela e, Maestro m, Inscripcion i, Competidor c, Equipo eq, GanaComoEquipo as ge
Where  e.NroDePlacaMaestro = m.NroDePlacaMaestro
and m.NroDePlacaMaestro = i.NroDePlacaMaestro
and c.dni = i.dni
and ge.IdEquipo = eq.IdEquipo
and eq.idEquipo = c.idEquipo
group by e.pais, ge.medalla) ge) t

group by pais, medalla




