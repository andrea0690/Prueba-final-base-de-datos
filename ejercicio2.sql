create table preguntas(
    id serial primary key,
    pregunta varchar(255),
    respuesta_correcta varchar
);

select * from preguntas;

create table usuarios(
    id serial primary key,
    nombre varchar(255),
    edad integer
);

select * from usuarios;

create table respuestas(
    id serial primary key,
    respuesta varchar(255),
    usuario_id integer references usuarios(id),
    pregunta_id integer references preguntas(id)
);

select * from respuestas;


-- Agregar registros a la tabla preguntas
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES 
    ('¿Cuál es la capital de Francia?', 'París'),        
    ('¿Cuál es el océano más grande del mundo?', 'Pacífico'),      
    ('¿Cuál es el planeta más grande del sistema solar?', 'Júpiter'), 
    ('¿Quién pintó la Mona Lisa?', 'Van Gogh'),                   
    ('¿Cuántos continentes hay en el mundo?', '6');   
select * from preguntas;           

-- Insertar usuarios
INSERT INTO usuarios (nombre, edad) VALUES ('Juan', 25);
INSERT INTO usuarios (nombre, edad) VALUES ('María', 30);
INSERT INTO usuarios (nombre, edad) VALUES ('Pedro', 28);
INSERT INTO usuarios (nombre, edad) VALUES ('Ana', 35);
INSERT INTO usuarios (nombre, edad) VALUES ('Luis', 20);

select * from usuarios;

-- agregar respuestas
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES 
    ('París', 1, 1), -- Respuesta de Juan
    ('París', 5, 1),
    ('Pacífico', 3, 2),
    ('Da Vinci', 4, 4),
    ('5', 2, 5);

select * from respuestas;


-- 6. cuenta la cantidad de respuestas totales por usuarios
SELECT u.nombre, COUNT(*) AS respuestas_correctas_totales
from respuestas r
left join preguntas p on r.pregunta_id = p.id 
left join usuarios u on r.usuario_id = u.id 
where r.respuesta = p.respuesta_correcta
group by u.nombre;

-- 7. por cada pregunta, en la tabla preguntas, cuenta cuantos usuarios tuvieron la respuesta correcta.

SELECT p.pregunta, COALESCE(
	COUNT(CASE WHEN r.respuesta = p.respuesta_correcta THEN 1 END), 0) 
	as numero_usuarios
FROM preguntas p
left JOIN respuestas r ON r.pregunta_id = p.id
GROUP BY p.pregunta;


-- 8.implementa un borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementacion

ALTER TABLE respuestas
DROP CONSTRAINT IF EXISTS respuestas_usuario_id_fkey,
ADD CONSTRAINT respuestas_usuario_id_fkey
FOREIGN KEY (usuario_id)
REFERENCES usuarios (id)
ON DELETE CASCADE;

--borrado usuario Juan con id 1
DELETE FROM usuarios WHERE id = 1;

--Verificación
select * from usuarios;
select * from respuestas;



-- 9.Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos

ALTER TABLE usuarios
ADD CONSTRAINT chk_edad_mayor_18
CHECK (edad >= 18);

INSERT INTO usuarios (nombre, edad) VALUES ('Pedrito', 16);


--10. Altera la tabla existente de usuarios agregando el campo email con la restricción de único


alter table usuarios add email varchar unique;

select * from usuarios;

-- Insertar registros de ejemplo con correos electrónicos únicos
INSERT INTO usuarios (nombre, edad, email) VALUES ('Andrea', 25, 'andrea@gmail.com');
INSERT INTO usuarios (nombre, edad, email) VALUES ('Marcos', 30, 'andrea@gmail.com');


