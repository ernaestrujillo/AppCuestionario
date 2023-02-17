CREATE DATABASE db_cuestionario
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Spain.1252'
    LC_CTYPE = 'Spanish_Spain.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


CREATE TABLE IF NOT EXISTS public.accion_tipo
(
    accion_tipo_id integer NOT NULL DEFAULT 'nextval('accion_tipo_accion_tipo_id_seq'::regclass)',
    accion character varying(250) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT accion_tipo_pkey PRIMARY KEY (accion_tipo_id)
);


CREATE TABLE IF NOT EXISTS public.preguntas_tipo
(
    pregunta_tipo_id integer NOT NULL DEFAULT 'nextval('preguntas_tipo_pregunta_tipo_id_seq'::regclass)',
    tipo character varying(150) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT preguntas_tipo_pkey PRIMARY KEY (pregunta_tipo_id)
);

CREATE TABLE IF NOT EXISTS public.respuesta_tipo
(
    respuesta_tipo_id integer NOT NULL DEFAULT 'nextval('respuesta_tipo_respuesta_tipo_id_seq'::regclass)',
    tipo character varying(150) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT respuesta_tipo_pkey PRIMARY KEY (respuesta_tipo_id)
);

CREATE TABLE IF NOT EXISTS public.cuestionarios
(
    cuestionario_id integer NOT NULL DEFAULT 'nextval('cuestionarios_cuestionario_id_seq'::regclass)',
    nombre character varying(150) COLLATE pg_catalog."default" NOT NULL,
    titulo character varying(250) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT cuestionarios_pkey PRIMARY KEY (cuestionario_id)
);



CREATE TABLE IF NOT EXISTS public.secciones
(
    seccion_id integer NOT NULL DEFAULT 'nextval('secciones_seccion_id_seq'::regclass)',
    cuestionario_id integer NOT NULL,
    nombre character varying(150) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT secciones_pkey PRIMARY KEY (seccion_id),
    CONSTRAINT "FK_SECCION_CUESTIONARIO" FOREIGN KEY (cuestionario_id)
        REFERENCES public.cuestionarios (cuestionario_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);


CREATE TABLE IF NOT EXISTS public.preguntas
(
    pregunta_id integer NOT NULL DEFAULT 'nextval('preguntas_pregunta_id_seq'::regclass)',
    seccion_id integer NOT NULL,
    pregunta_tipo_id integer NOT NULL,
    pregunta character varying(250) COLLATE pg_catalog."default" NOT NULL,
    orden integer NOT NULL DEFAULT 1,
    numero character varying(5) COLLATE pg_catalog."default" NOT NULL DEFAULT 1,
    CONSTRAINT preguntas_pkey PRIMARY KEY (pregunta_id),
    CONSTRAINT "FK_PREGUNTA_SECCION" FOREIGN KEY (seccion_id)
        REFERENCES public.secciones (seccion_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_PREGUNTA_TIPO" FOREIGN KEY (pregunta_tipo_id)
        REFERENCES public.preguntas_tipo (pregunta_tipo_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

CREATE TABLE IF NOT EXISTS public.respuestas
(
    respuesta_id integer NOT NULL DEFAULT 'nextval('respuestas_respuesta_id_seq'::regclass)',
    pregunta_id integer NOT NULL,
    accion_tipo_id integer NOT NULL,
    titulo character varying(150) COLLATE pg_catalog."default" NOT NULL,
    orden integer NOT NULL,
    accion_seccion_id integer,
    accion_pregunta_id integer,
    respuesta_tipo_id integer,
    CONSTRAINT respuestas_pkey PRIMARY KEY (respuesta_id),
    CONSTRAINT "FK_RESPUESTA_ACCION_PREGUNTA" FOREIGN KEY (accion_seccion_id)
        REFERENCES public.secciones (seccion_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_RESPUESTA_ACCION_SECCION" FOREIGN KEY (accion_pregunta_id)
        REFERENCES public.preguntas (pregunta_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "FK_RESPUESTA_ACCION_TIPO" FOREIGN KEY (accion_tipo_id)
        REFERENCES public.accion_tipo (accion_tipo_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_RESPUESTA_PREGUNTA" FOREIGN KEY (pregunta_id)
        REFERENCES public.preguntas (pregunta_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_RESPUESTA_TIPO" FOREIGN KEY (respuesta_tipo_id)
        REFERENCES public.respuesta_tipo (respuesta_tipo_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

CREATE TABLE IF NOT EXISTS public.cuestionarios_resueltos
(
    cues_resuelto_id integer NOT NULL DEFAULT 'nextval('cuestionarios_resueltos_cues_resuelto_id_seq'::regclass)',
    cuestionario_id integer NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    CONSTRAINT cuestionarios_resueltos_pkey PRIMARY KEY (cues_resuelto_id),
    CONSTRAINT "FK_RESUELTO_CUESTIONARIO" FOREIGN KEY (cuestionario_id)
        REFERENCES public.cuestionarios (cuestionario_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);


CREATE TABLE IF NOT EXISTS public.cuestionarios_resueltos_det
(
    detalle_id integer NOT NULL DEFAULT 'nextval('cuestionarios_resueltos_det_detalle_id_seq'::regclass)',
    cues_resuelto_id integer NOT NULL,
    respuesta_id integer NOT NULL,
    valor_num integer,
    valor_num_dec double precision,
    valor_texto character varying(250) COLLATE pg_catalog."default",
    valor_texto_area text COLLATE pg_catalog."default",
    CONSTRAINT cuestionarios_resueltos_det_pkey PRIMARY KEY (detalle_id),
    CONSTRAINT "FK_DETALLE_RESPUESTA" FOREIGN KEY (respuesta_id)
        REFERENCES public.respuestas (respuesta_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_DETALLE_RESUELTO" FOREIGN KEY (cues_resuelto_id)
        REFERENCES public.cuestionarios_resueltos (cues_resuelto_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE OR REPLACE VIEW public.vw_cuestionario_resuelto
 AS
 SELECT a.cues_resuelto_id AS id,
    a.fecha_hora,
    b.nombre AS cuestionario,
    e.pregunta,
        CASE e.pregunta_tipo_id
            WHEN 4 THEN c.valor_num_dec::character varying(250)
            ELSE
            CASE d.respuesta_tipo_id
                WHEN 1 THEN c.valor_num::character varying(250)
                WHEN 2 THEN c.valor_num_dec::character varying(250)
                WHEN 3 THEN c.valor_texto
                ELSE d.titulo
            END
        END AS respuesta
   FROM cuestionarios_resueltos a
     JOIN cuestionarios b ON b.cuestionario_id = a.cuestionario_id
     JOIN cuestionarios_resueltos_det c ON c.cues_resuelto_id = a.cues_resuelto_id
     JOIN respuestas d ON d.respuesta_id = c.respuesta_id
     JOIN preguntas e ON e.pregunta_id = d.pregunta_id;

INSERT INTO "accion_tipo" ("accion_tipo_id", "accion") VALUES (1, 'Ir a una pregunta');
INSERT INTO "accion_tipo" ("accion_tipo_id", "accion") VALUES (2, 'Ir a una sección');
INSERT INTO "accion_tipo" ("accion_tipo_id", "accion") VALUES (3, 'Finalizar');


INSERT INTO "preguntas_tipo" ("pregunta_tipo_id", "tipo") VALUES (1, 'Opción Mutiple');
INSERT INTO "preguntas_tipo" ("pregunta_tipo_id", "tipo") VALUES (2, 'Selección Mutiple');
INSERT INTO "preguntas_tipo" ("pregunta_tipo_id", "tipo") VALUES (3, 'Numerica');
INSERT INTO "preguntas_tipo" ("pregunta_tipo_id", "tipo") VALUES (4, 'Numerica Decimal');
INSERT INTO "preguntas_tipo" ("pregunta_tipo_id", "tipo") VALUES (5, 'Texto');
INSERT INTO "preguntas_tipo" ("pregunta_tipo_id", "tipo") VALUES (6, 'Area de Texto');

INSERT INTO "respuesta_tipo" ("respuesta_tipo_id", "tipo") VALUES (1, 'Abierta Numerica');
INSERT INTO "respuesta_tipo" ("respuesta_tipo_id", "tipo") VALUES (2, 'Abierta Numerica Decimal');
INSERT INTO "respuesta_tipo" ("respuesta_tipo_id", "tipo") VALUES (3, 'Texto');


INSERT INTO "cuestionarios" ("cuestionario_id", "nombre", "titulo") VALUES (1, 'Cuestionario 1', 'Cuestionario Demo');


INSERT INTO "secciones" ("seccion_id", "cuestionario_id", "nombre") VALUES (1, 1, 'Sección 1');
INSERT INTO "secciones" ("seccion_id", "cuestionario_id", "nombre") VALUES (2, 1, 'Sección 2');
INSERT INTO "secciones" ("seccion_id", "cuestionario_id", "nombre") VALUES (3, 1, 'Sección 3');

INSERT INTO "preguntas" ("pregunta_id", "seccion_id", "pregunta_tipo_id", "pregunta", "orden", "numero") VALUES (1, 1, 1, 'Contestaré esta encuesta respecto a la experiencia de la empresa que represento:', 1, '1');
INSERT INTO "preguntas" ("pregunta_id", "seccion_id", "pregunta_tipo_id", "pregunta", "orden", "numero") VALUES (2, 1, 1, '¿A qué sector se dedica la empresa?', 2, '2');
INSERT INTO "preguntas" ("pregunta_id", "seccion_id", "pregunta_tipo_id", "pregunta", "orden", "numero") VALUES (3, 1, 1, 'Número de empleados:', 3, '3');
INSERT INTO "preguntas" ("pregunta_id", "seccion_id", "pregunta_tipo_id", "pregunta", "orden", "numero") VALUES (4, 1, 1, '¿Este año habrá entrega de reparto de utilidades? 
', 4, '4');
INSERT INTO "preguntas" ("pregunta_id", "seccion_id", "pregunta_tipo_id", "pregunta", "orden", "numero") VALUES (5, 2, 1, 'En comparación con el año anterior ¿Cómo será el monto repartido de PTU?', 1, '5');
INSERT INTO "preguntas" ("pregunta_id", "seccion_id", "pregunta_tipo_id", "pregunta", "orden", "numero") VALUES (7, 2, 2, '¿Cuáles fueron las razones por las que habrá menor reparto de utilidades?', 3, '5.2');
INSERT INTO "preguntas" ("pregunta_id", "seccion_id", "pregunta_tipo_id", "pregunta", "orden", "numero") VALUES (8, 2, 4, 'Días de salario estimado a pagar por PTU ejercicio 2021 ', 4, '6');
INSERT INTO "preguntas" ("pregunta_id", "seccion_id", "pregunta_tipo_id", "pregunta", "orden", "numero") VALUES (9, 3, 2, '¿Cuáles fueron las razones por las que no hubo reparto de utilidades?', 1, '7');
INSERT INTO "preguntas" ("pregunta_id", "seccion_id", "pregunta_tipo_id", "pregunta", "orden", "numero") VALUES (10, 3, 1, 'El año anterior, ¿hubo reparto de PTU?', 2, '8');
INSERT INTO "preguntas" ("pregunta_id", "seccion_id", "pregunta_tipo_id", "pregunta", "orden", "numero") VALUES (6, 2, 2, '¿Cuáles fueron las razones por las que el monto de reparto de utilidades fue
mayor?', 2, '5.1');


INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (2, 1, 3, 'b. No acepto', 2, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (1, 1, 1, 'a. Acepto', 1, NULL, 2, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (3, 2, 1, 'a. Agricultura, cría y explotación de animales, aprovechamiento forestal,
pesca y caza', 1, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (4, 2, 1, 'b. Minería', 2, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (5, 2, 1, 'c. Generación, transmisión, distribución y comercialización de energía
eléctrica, suministro de agua y de gas natural por ductos al consumidor
final', 3, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (6, 2, 1, 'd. Construcción', 4, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (7, 2, 1, 'e. Industrias manufactureras', 5, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (8, 2, 1, 'f. Comercio al por mayor', 6, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (9, 2, 1, 'g. Comercio al por menor', 7, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (10, 2, 1, 'h. Transportes, correos y almacenamiento', 8, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (11, 2, 1, 'i. Información en medios masivos', 9, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (12, 2, 1, 'j. Servicios financieros y de seguros', 10, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (13, 2, 1, 'k. Servicios inmobiliarios y de alquiler de bienes muebles e intangibles', 11, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (14, 2, 1, 'l. Servicios profesionales, científicos y técnicos', 12, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (15, 2, 1, 's. Otros servicios excepto actividades gubernamentales', 19, NULL, 3, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (16, 3, 1, 'a. 1 a 10 ', 1, NULL, 4, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (17, 3, 1, 'b. 11 a 50', 2, NULL, 4, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (18, 3, 1, 'c. 51 a 250', 3, NULL, 4, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (19, 3, 1, 'd. 251 o más', 4, NULL, 4, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (20, 4, 2, 'a. Sí', 1, 2, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (21, 4, 2, 'b. No', 2, 3, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (22, 5, 1, 'a. Mayor', 1, NULL, 6, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (23, 5, 1, 'b. Igual', 2, NULL, 8, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (24, 5, 1, 'c. Menor', 3, NULL, 7, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (25, 6, 3, 'a. Aumento en la productividad de las y los colaboradores', 1, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (26, 6, 3, 'b. Aumento de ventas', 2, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (27, 6, 3, 'c. Entorno económico favorable', 3, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (28, 6, 3, 'd. Nuevas oportunidades de negocio', 4, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (29, 7, 3, 'a. Disminución en la productividad de las y los colaboradores
', 1, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (30, 7, 3, 'b. Afectaciones por inseguridad', 2, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (31, 7, 3, 'c. Afectaciones por el entorno político y económico', 3, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (32, 7, 3, 'd. Continuación de la pandemia COVID-19', 4, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (33, 7, 3, 'e. Problemas para mejorar la innovación y los procesos al interior de la
empresa', 5, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (34, 7, 3, 'f. Complicaciones por la inflación', 6, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (37, 9, 3, 'a. Disminución en la productividad de las y los colaboradores', 1, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (38, 9, 3, 'b. Afectaciones por inseguridad', 2, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (39, 9, 3, 'c. Afectaciones por el entorno político y económico', 3, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (40, 9, 3, 'd. Continuación de la pandemia COVID-19', 4, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (41, 9, 3, 'e. Problemas para mejorar la innovación y los procesos al interior de la
empresa', 5, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (42, 9, 3, 'f. Complicaciones por la inflación', 6, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (45, 10, 3, 'a. Sí', 1, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (46, 10, 3, 'b. No', 2, NULL, NULL, NULL);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (35, 7, 3, 'Otro', 7, NULL, NULL, 3);
INSERT INTO "respuestas" ("respuesta_id", "pregunta_id", "accion_tipo_id", "titulo", "orden", "accion_seccion_id", "accion_pregunta_id", "respuesta_tipo_id") VALUES (36, 8, 3, 'Días', 1, NULL, NULL, 2);
