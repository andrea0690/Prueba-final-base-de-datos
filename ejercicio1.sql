
-- crear tabla peliculas
create table peliculas(
   peliculas_id serial primary key,
   nombre varchar(255),
   anio integer 
);

select * from peliculas;


-- crear tabla tags
create table tags(
    tags_id serial primary key,
    tag varchar(32)

);

select *from tags;

-- crear tabla intermedia reparto
create table pelicula_tag(
	id serial primary key,
    peliculas_id int references peliculas(peliculas_id),
    tags_id int references tags(tags_id)
	 
);

select * from pelicula_tag;


-- inserta 5 peliculas

INSERT INTO peliculas (nombre, anio) VALUES 
    ('Jumanji', 2020),
    ('Chicas Blancas', 2018),
    ('La vida es bella', 2019),
    ('Misión imposible', 2021),
    ('Duna', 2017);

select * from peliculas;

--insertar 5 tags

INSERT INTO tags (tag) VALUES 
    ('alucinante'),
    ('risas'),
    ('interesante'),
    ('genial'),
    ('fantastico');

select * from tags;

-- asociar 3 tags a la pelicula 1 y asociar 2 tags a la pelicula 2
INSERT INTO pelicula_tag (peliculas_id, tags_id) VALUES
    (1, 5),
    (1, 2),
    (1, 3),
    (2, 2),
    (2, 4);

select * from pelicula_tag;

--Cuente la cantidad de tags que tiene cada pelicula. Si una pelicula no tiene tags debe mostrar cero

SELECT p.nombre AS nombre_pelicula, COALESCE(COUNT(pt.tags_id), 0) AS cantidad_tags
FROM peliculas p
LEFT JOIN pelicula_tag pt ON p.peliculas_id = pt.peliculas_id
GROUP BY p.peliculas_id
ORDER BY p.peliculas_id;
