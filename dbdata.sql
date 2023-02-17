--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accion_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accion_tipo (
    accion_tipo_id integer NOT NULL,
    accion character varying(250) NOT NULL
);


ALTER TABLE public.accion_tipo OWNER TO postgres;

--
-- Name: accion_tipo_accion_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accion_tipo_accion_tipo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accion_tipo_accion_tipo_id_seq OWNER TO postgres;

--
-- Name: accion_tipo_accion_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accion_tipo_accion_tipo_id_seq OWNED BY public.accion_tipo.accion_tipo_id;


--
-- Name: cuestionarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuestionarios (
    cuestionario_id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    titulo character varying(250) NOT NULL
);


ALTER TABLE public.cuestionarios OWNER TO postgres;

--
-- Name: cuestionarios_cuestionario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuestionarios_cuestionario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cuestionarios_cuestionario_id_seq OWNER TO postgres;

--
-- Name: cuestionarios_cuestionario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuestionarios_cuestionario_id_seq OWNED BY public.cuestionarios.cuestionario_id;


--
-- Name: cuestionarios_resueltos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuestionarios_resueltos (
    cues_resuelto_id integer NOT NULL,
    cuestionario_id integer NOT NULL,
    fecha_hora timestamp without time zone NOT NULL
);


ALTER TABLE public.cuestionarios_resueltos OWNER TO postgres;

--
-- Name: cuestionarios_resueltos_cues_resuelto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuestionarios_resueltos_cues_resuelto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cuestionarios_resueltos_cues_resuelto_id_seq OWNER TO postgres;

--
-- Name: cuestionarios_resueltos_cues_resuelto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuestionarios_resueltos_cues_resuelto_id_seq OWNED BY public.cuestionarios_resueltos.cues_resuelto_id;


--
-- Name: cuestionarios_resueltos_det; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuestionarios_resueltos_det (
    detalle_id integer NOT NULL,
    cues_resuelto_id integer NOT NULL,
    respuesta_id integer NOT NULL,
    valor_num integer,
    valor_num_dec double precision,
    valor_texto character varying(250),
    valor_texto_area text
);


ALTER TABLE public.cuestionarios_resueltos_det OWNER TO postgres;

--
-- Name: cuestionarios_resueltos_det_detalle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuestionarios_resueltos_det_detalle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cuestionarios_resueltos_det_detalle_id_seq OWNER TO postgres;

--
-- Name: cuestionarios_resueltos_det_detalle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuestionarios_resueltos_det_detalle_id_seq OWNED BY public.cuestionarios_resueltos_det.detalle_id;


--
-- Name: preguntas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preguntas (
    pregunta_id integer NOT NULL,
    seccion_id integer NOT NULL,
    pregunta_tipo_id integer NOT NULL,
    pregunta character varying(250) NOT NULL,
    orden integer DEFAULT 1 NOT NULL,
    numero character varying(5) DEFAULT 1 NOT NULL
);


ALTER TABLE public.preguntas OWNER TO postgres;

--
-- Name: preguntas_pregunta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preguntas_pregunta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.preguntas_pregunta_id_seq OWNER TO postgres;

--
-- Name: preguntas_pregunta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preguntas_pregunta_id_seq OWNED BY public.preguntas.pregunta_id;


--
-- Name: preguntas_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preguntas_tipo (
    pregunta_tipo_id integer NOT NULL,
    tipo character varying(150) NOT NULL
);


ALTER TABLE public.preguntas_tipo OWNER TO postgres;

--
-- Name: preguntas_tipo_pregunta_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preguntas_tipo_pregunta_tipo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.preguntas_tipo_pregunta_tipo_id_seq OWNER TO postgres;

--
-- Name: preguntas_tipo_pregunta_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preguntas_tipo_pregunta_tipo_id_seq OWNED BY public.preguntas_tipo.pregunta_tipo_id;


--
-- Name: respuesta_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.respuesta_tipo (
    respuesta_tipo_id integer NOT NULL,
    tipo character varying(150) NOT NULL
);


ALTER TABLE public.respuesta_tipo OWNER TO postgres;

--
-- Name: respuesta_tipo_respuesta_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.respuesta_tipo_respuesta_tipo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.respuesta_tipo_respuesta_tipo_id_seq OWNER TO postgres;

--
-- Name: respuesta_tipo_respuesta_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.respuesta_tipo_respuesta_tipo_id_seq OWNED BY public.respuesta_tipo.respuesta_tipo_id;


--
-- Name: respuestas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.respuestas (
    respuesta_id integer NOT NULL,
    pregunta_id integer NOT NULL,
    accion_tipo_id integer NOT NULL,
    titulo character varying(150) NOT NULL,
    orden integer NOT NULL,
    accion_seccion_id integer,
    accion_pregunta_id integer,
    respuesta_tipo_id integer
);


ALTER TABLE public.respuestas OWNER TO postgres;

--
-- Name: respuestas_respuesta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.respuestas_respuesta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.respuestas_respuesta_id_seq OWNER TO postgres;

--
-- Name: respuestas_respuesta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.respuestas_respuesta_id_seq OWNED BY public.respuestas.respuesta_id;


--
-- Name: secciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.secciones (
    seccion_id integer NOT NULL,
    cuestionario_id integer NOT NULL,
    nombre character varying(150) NOT NULL
);


ALTER TABLE public.secciones OWNER TO postgres;

--
-- Name: secciones_seccion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.secciones_seccion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secciones_seccion_id_seq OWNER TO postgres;

--
-- Name: secciones_seccion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.secciones_seccion_id_seq OWNED BY public.secciones.seccion_id;


--
-- Name: vw_cuestionario_resuelto; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_cuestionario_resuelto AS
 SELECT a.cues_resuelto_id AS id,
    a.fecha_hora,
    b.nombre AS cuestionario,
    e.pregunta,
        CASE e.pregunta_tipo_id
            WHEN 4 THEN (c.valor_num_dec)::character varying(250)
            ELSE
            CASE d.respuesta_tipo_id
                WHEN 1 THEN (c.valor_num)::character varying(250)
                WHEN 2 THEN (c.valor_num_dec)::character varying(250)
                WHEN 3 THEN c.valor_texto
                ELSE d.titulo
            END
        END AS respuesta
   FROM ((((public.cuestionarios_resueltos a
     JOIN public.cuestionarios b ON ((b.cuestionario_id = a.cuestionario_id)))
     JOIN public.cuestionarios_resueltos_det c ON ((c.cues_resuelto_id = a.cues_resuelto_id)))
     JOIN public.respuestas d ON ((d.respuesta_id = c.respuesta_id)))
     JOIN public.preguntas e ON ((e.pregunta_id = d.pregunta_id)));


ALTER TABLE public.vw_cuestionario_resuelto OWNER TO postgres;

--
-- Name: accion_tipo accion_tipo_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accion_tipo ALTER COLUMN accion_tipo_id SET DEFAULT nextval('public.accion_tipo_accion_tipo_id_seq'::regclass);


--
-- Name: cuestionarios cuestionario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios ALTER COLUMN cuestionario_id SET DEFAULT nextval('public.cuestionarios_cuestionario_id_seq'::regclass);


--
-- Name: cuestionarios_resueltos cues_resuelto_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios_resueltos ALTER COLUMN cues_resuelto_id SET DEFAULT nextval('public.cuestionarios_resueltos_cues_resuelto_id_seq'::regclass);


--
-- Name: cuestionarios_resueltos_det detalle_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios_resueltos_det ALTER COLUMN detalle_id SET DEFAULT nextval('public.cuestionarios_resueltos_det_detalle_id_seq'::regclass);


--
-- Name: preguntas pregunta_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas ALTER COLUMN pregunta_id SET DEFAULT nextval('public.preguntas_pregunta_id_seq'::regclass);


--
-- Name: preguntas_tipo pregunta_tipo_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas_tipo ALTER COLUMN pregunta_tipo_id SET DEFAULT nextval('public.preguntas_tipo_pregunta_tipo_id_seq'::regclass);


--
-- Name: respuesta_tipo respuesta_tipo_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuesta_tipo ALTER COLUMN respuesta_tipo_id SET DEFAULT nextval('public.respuesta_tipo_respuesta_tipo_id_seq'::regclass);


--
-- Name: respuestas respuesta_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas ALTER COLUMN respuesta_id SET DEFAULT nextval('public.respuestas_respuesta_id_seq'::regclass);


--
-- Name: secciones seccion_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.secciones ALTER COLUMN seccion_id SET DEFAULT nextval('public.secciones_seccion_id_seq'::regclass);


--
-- Data for Name: accion_tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accion_tipo (accion_tipo_id, accion) FROM stdin;
1	Ir a una pregunta
2	Ir a una sección
3	Finalizar
\.


--
-- Data for Name: cuestionarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuestionarios (cuestionario_id, nombre, titulo) FROM stdin;
1	Cuestionario 1	Cuestionario Demo
\.


--
-- Data for Name: cuestionarios_resueltos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuestionarios_resueltos (cues_resuelto_id, cuestionario_id, fecha_hora) FROM stdin;
6	1	2023-02-16 23:08:17.257966
7	1	2023-02-16 23:21:36.947593
8	1	2023-02-16 23:22:12.012082
9	1	2023-02-16 23:39:28.242293
10	1	2023-02-16 23:44:47.705603
11	1	2023-02-16 23:45:21.304775
12	1	2023-02-16 23:46:31.65505
13	1	2023-02-16 23:50:15.867425
14	1	2023-02-16 23:53:44.980516
15	1	2023-02-16 23:57:42.332271
16	1	2023-02-16 23:58:24.832457
17	1	2023-02-16 23:59:02.332285
18	1	2023-02-16 23:59:34.074335
19	1	2023-02-17 00:02:43.981321
20	1	2023-02-17 00:03:14.641001
21	1	2023-02-17 00:03:41.329332
22	1	2023-02-17 00:04:11.609205
23	1	2023-02-17 00:07:38.227362
24	1	2023-02-17 00:08:05.580322
25	1	2023-02-17 00:08:32.101253
26	1	2023-02-17 00:09:11.125848
27	1	2023-02-17 00:11:11.448089
28	1	2023-02-17 00:11:43.268199
29	1	2023-02-17 00:12:08.741604
30	1	2023-02-17 00:12:37.266656
\.


--
-- Data for Name: cuestionarios_resueltos_det; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuestionarios_resueltos_det (detalle_id, cues_resuelto_id, respuesta_id, valor_num, valor_num_dec, valor_texto, valor_texto_area) FROM stdin;
1	6	1	0	0	\N	\N
2	6	3	0	0	\N	\N
3	6	17	0	0	\N	\N
4	6	21	0	0	\N	\N
5	6	37	0	0	\N	\N
6	6	38	0	0	\N	\N
7	7	1	0	0	\N	\N
8	7	4	0	0	\N	\N
9	7	17	0	0	\N	\N
10	7	20	0	0	\N	\N
11	7	23	0	0	\N	\N
12	7	36	0	568.56	\N	\N
13	8	1	0	0	\N	\N
14	8	10	0	0	\N	\N
15	8	18	0	0	\N	\N
16	8	20	0	0	\N	\N
17	8	24	0	0	\N	\N
18	8	32	0	0	\N	\N
19	8	33	0	0	\N	\N
20	8	35	0	0	Otra	\N
21	9	1	0	0	\N	\N
22	9	5	0	0	\N	\N
23	9	17	0	0	\N	\N
24	9	21	0	0	\N	\N
25	9	39	0	0	\N	\N
26	9	40	0	0	\N	\N
27	9	41	0	0	\N	\N
28	10	1	0	0	\N	\N
29	10	6	0	0	\N	\N
30	10	18	0	0	\N	\N
31	10	21	0	0	\N	\N
32	10	39	0	0	\N	\N
33	10	40	0	0	\N	\N
34	10	41	0	0	\N	\N
35	11	1	0	0	\N	\N
36	11	7	0	0	\N	\N
37	11	18	0	0	\N	\N
38	11	21	0	0	\N	\N
39	11	38	0	0	\N	\N
40	11	40	0	0	\N	\N
41	11	41	0	0	\N	\N
42	12	1	0	0	\N	\N
43	12	6	0	0	\N	\N
44	12	17	0	0	\N	\N
45	12	21	0	0	\N	\N
46	12	39	0	0	\N	\N
47	12	40	0	0	\N	\N
48	12	41	0	0	\N	\N
49	13	1	0	0	\N	\N
50	13	5	0	0	\N	\N
51	13	18	0	0	\N	\N
52	13	21	0	0	\N	\N
53	13	37	0	0	\N	\N
54	13	38	0	0	\N	\N
55	13	39	0	0	\N	\N
56	14	1	0	0	\N	\N
57	14	7	0	0	\N	\N
58	14	18	0	0	\N	\N
59	14	20	0	0	\N	\N
60	14	23	0	0	\N	\N
61	14	36	0	58.63	\N	\N
62	15	2	0	0	\N	\N
63	16	1	0	0	\N	\N
64	16	7	0	0	\N	\N
65	16	17	0	0	\N	\N
66	16	20	0	0	\N	\N
67	16	22	0	0	\N	\N
68	16	25	0	0	\N	\N
69	16	26	0	0	\N	\N
70	16	27	0	0	\N	\N
71	17	1	0	0	\N	\N
72	17	6	0	0	\N	\N
73	17	17	0	0	\N	\N
74	17	20	0	0	\N	\N
75	17	23	0	0	\N	\N
76	17	36	0	56.3	\N	\N
77	18	1	0	0	\N	\N
78	18	5	0	0	\N	\N
79	18	17	0	0	\N	\N
80	18	20	0	0	\N	\N
81	18	24	0	0	\N	\N
82	18	29	0	0	\N	\N
83	18	30	0	0	\N	\N
84	18	31	0	0	\N	\N
85	18	35	0	0	Otra Prueba	\N
86	19	2	0	0	\N	\N
87	20	1	0	0	\N	\N
88	20	5	0	0	\N	\N
89	20	17	0	0	\N	\N
90	20	21	0	0	\N	\N
91	20	37	0	0	\N	\N
92	20	38	0	0	\N	\N
93	20	39	0	0	\N	\N
94	21	1	0	0	\N	\N
95	21	3	0	0	\N	\N
96	21	16	0	0	\N	\N
97	21	20	0	0	\N	\N
98	21	23	0	0	\N	\N
99	21	36	0	56.3	\N	\N
100	22	1	0	0	\N	\N
101	22	5	0	0	\N	\N
102	22	17	0	0	\N	\N
103	22	20	0	0	\N	\N
104	22	24	0	0	\N	\N
105	22	29	0	0	\N	\N
106	22	30	0	0	\N	\N
107	22	31	0	0	\N	\N
108	22	35	0	0	Otra Prueba	\N
109	23	2	0	0	\N	\N
110	24	1	0	0	\N	\N
111	24	7	0	0	\N	\N
112	24	17	0	0	\N	\N
113	24	21	0	0	\N	\N
114	24	37	0	0	\N	\N
115	24	38	0	0	\N	\N
116	24	39	0	0	\N	\N
117	25	1	0	0	\N	\N
118	25	5	0	0	\N	\N
119	25	17	0	0	\N	\N
120	25	20	0	0	\N	\N
121	25	23	0	0	\N	\N
122	25	36	0	56.36	\N	\N
123	26	1	0	0	\N	\N
124	26	5	0	0	\N	\N
125	26	17	0	0	\N	\N
126	26	20	0	0	\N	\N
127	26	23	0	0	\N	\N
128	26	24	0	0	\N	\N
129	26	29	0	0	\N	\N
130	26	30	0	0	\N	\N
131	26	31	0	0	\N	\N
132	26	35	0	0	Otra Prueba	\N
133	27	2	0	0	\N	\N
134	28	1	0	0	\N	\N
135	28	6	0	0	\N	\N
136	28	17	0	0	\N	\N
137	28	21	0	0	\N	\N
138	28	37	0	0	\N	\N
139	28	38	0	0	\N	\N
140	28	39	0	0	\N	\N
141	28	40	0	0	\N	\N
142	29	1	0	0	\N	\N
143	29	5	0	0	\N	\N
144	29	17	0	0	\N	\N
145	29	20	0	0	\N	\N
146	29	23	0	0	\N	\N
147	29	36	0	56.32	\N	\N
148	30	1	0	0	\N	\N
149	30	5	0	0	\N	\N
150	30	16	0	0	\N	\N
151	30	20	0	0	\N	\N
152	30	24	0	0	\N	\N
153	30	29	0	0	\N	\N
154	30	30	0	0	\N	\N
155	30	31	0	0	\N	\N
156	30	35	0	0	Otra Prueba	\N
\.


--
-- Data for Name: preguntas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preguntas (pregunta_id, seccion_id, pregunta_tipo_id, pregunta, orden, numero) FROM stdin;
1	1	1	Contestaré esta encuesta respecto a la experiencia de la empresa que represento:	1	1
2	1	1	¿A qué sector se dedica la empresa?	2	2
3	1	1	Número de empleados:	3	3
4	1	1	¿Este año habrá entrega de reparto de utilidades? \n	4	4
5	2	1	En comparación con el año anterior ¿Cómo será el monto repartido de PTU?	1	5
7	2	2	¿Cuáles fueron las razones por las que habrá menor reparto de utilidades?	3	5.2
8	2	4	Días de salario estimado a pagar por PTU ejercicio 2021 	4	6
9	3	2	¿Cuáles fueron las razones por las que no hubo reparto de utilidades?	1	7
10	3	1	El año anterior, ¿hubo reparto de PTU?	2	8
6	2	2	¿Cuáles fueron las razones por las que el monto de reparto de utilidades fue\nmayor?	2	5.1
\.


--
-- Data for Name: preguntas_tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preguntas_tipo (pregunta_tipo_id, tipo) FROM stdin;
1	Opción Mutiple
2	Selección Mutiple
3	Numerica
4	Numerica Decimal
5	Texto
6	Area de Texto
\.


--
-- Data for Name: respuesta_tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.respuesta_tipo (respuesta_tipo_id, tipo) FROM stdin;
1	Abierta Numerica
2	Abierta Numerica Decimal
3	Texto
\.


--
-- Data for Name: respuestas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.respuestas (respuesta_id, pregunta_id, accion_tipo_id, titulo, orden, accion_seccion_id, accion_pregunta_id, respuesta_tipo_id) FROM stdin;
2	1	3	b. No acepto	2	\N	\N	\N
1	1	1	a. Acepto	1	\N	2	\N
3	2	1	a. Agricultura, cría y explotación de animales, aprovechamiento forestal,\npesca y caza	1	\N	3	\N
4	2	1	b. Minería	2	\N	3	\N
5	2	1	c. Generación, transmisión, distribución y comercialización de energía\neléctrica, suministro de agua y de gas natural por ductos al consumidor\nfinal	3	\N	3	\N
6	2	1	d. Construcción	4	\N	3	\N
7	2	1	e. Industrias manufactureras	5	\N	3	\N
8	2	1	f. Comercio al por mayor	6	\N	3	\N
9	2	1	g. Comercio al por menor	7	\N	3	\N
10	2	1	h. Transportes, correos y almacenamiento	8	\N	3	\N
11	2	1	i. Información en medios masivos	9	\N	3	\N
12	2	1	j. Servicios financieros y de seguros	10	\N	3	\N
13	2	1	k. Servicios inmobiliarios y de alquiler de bienes muebles e intangibles	11	\N	3	\N
14	2	1	l. Servicios profesionales, científicos y técnicos	12	\N	3	\N
15	2	1	s. Otros servicios excepto actividades gubernamentales	19	\N	3	\N
16	3	1	a. 1 a 10 	1	\N	4	\N
17	3	1	b. 11 a 50	2	\N	4	\N
18	3	1	c. 51 a 250	3	\N	4	\N
19	3	1	d. 251 o más	4	\N	4	\N
20	4	2	a. Sí	1	2	\N	\N
21	4	2	b. No	2	3	\N	\N
22	5	1	a. Mayor	1	\N	6	\N
23	5	1	b. Igual	2	\N	8	\N
24	5	1	c. Menor	3	\N	7	\N
25	6	3	a. Aumento en la productividad de las y los colaboradores	1	\N	\N	\N
26	6	3	b. Aumento de ventas	2	\N	\N	\N
27	6	3	c. Entorno económico favorable	3	\N	\N	\N
28	6	3	d. Nuevas oportunidades de negocio	4	\N	\N	\N
29	7	3	a. Disminución en la productividad de las y los colaboradores\n	1	\N	\N	\N
30	7	3	b. Afectaciones por inseguridad	2	\N	\N	\N
31	7	3	c. Afectaciones por el entorno político y económico	3	\N	\N	\N
32	7	3	d. Continuación de la pandemia COVID-19	4	\N	\N	\N
33	7	3	e. Problemas para mejorar la innovación y los procesos al interior de la\nempresa	5	\N	\N	\N
34	7	3	f. Complicaciones por la inflación	6	\N	\N	\N
37	9	3	a. Disminución en la productividad de las y los colaboradores	1	\N	\N	\N
38	9	3	b. Afectaciones por inseguridad	2	\N	\N	\N
39	9	3	c. Afectaciones por el entorno político y económico	3	\N	\N	\N
40	9	3	d. Continuación de la pandemia COVID-19	4	\N	\N	\N
41	9	3	e. Problemas para mejorar la innovación y los procesos al interior de la\nempresa	5	\N	\N	\N
42	9	3	f. Complicaciones por la inflación	6	\N	\N	\N
45	10	3	a. Sí	1	\N	\N	\N
46	10	3	b. No	2	\N	\N	\N
35	7	3	Otro	7	\N	\N	3
36	8	3	Días	1	\N	\N	2
\.


--
-- Data for Name: secciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.secciones (seccion_id, cuestionario_id, nombre) FROM stdin;
1	1	Sección 1
2	1	Sección 2
3	1	Sección 3
\.


--
-- Name: accion_tipo_accion_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accion_tipo_accion_tipo_id_seq', 3, true);


--
-- Name: cuestionarios_cuestionario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuestionarios_cuestionario_id_seq', 1, true);


--
-- Name: cuestionarios_resueltos_cues_resuelto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuestionarios_resueltos_cues_resuelto_id_seq', 30, true);


--
-- Name: cuestionarios_resueltos_det_detalle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuestionarios_resueltos_det_detalle_id_seq', 156, true);


--
-- Name: preguntas_pregunta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preguntas_pregunta_id_seq', 10, true);


--
-- Name: preguntas_tipo_pregunta_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preguntas_tipo_pregunta_tipo_id_seq', 6, true);


--
-- Name: respuesta_tipo_respuesta_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.respuesta_tipo_respuesta_tipo_id_seq', 2, true);


--
-- Name: respuestas_respuesta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.respuestas_respuesta_id_seq', 46, true);


--
-- Name: secciones_seccion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.secciones_seccion_id_seq', 3, true);


--
-- Name: accion_tipo accion_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accion_tipo
    ADD CONSTRAINT accion_tipo_pkey PRIMARY KEY (accion_tipo_id);


--
-- Name: cuestionarios cuestionarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios
    ADD CONSTRAINT cuestionarios_pkey PRIMARY KEY (cuestionario_id);


--
-- Name: cuestionarios_resueltos_det cuestionarios_resueltos_det_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios_resueltos_det
    ADD CONSTRAINT cuestionarios_resueltos_det_pkey PRIMARY KEY (detalle_id);


--
-- Name: cuestionarios_resueltos cuestionarios_resueltos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios_resueltos
    ADD CONSTRAINT cuestionarios_resueltos_pkey PRIMARY KEY (cues_resuelto_id);


--
-- Name: preguntas preguntas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas
    ADD CONSTRAINT preguntas_pkey PRIMARY KEY (pregunta_id);


--
-- Name: preguntas_tipo preguntas_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas_tipo
    ADD CONSTRAINT preguntas_tipo_pkey PRIMARY KEY (pregunta_tipo_id);


--
-- Name: respuesta_tipo respuesta_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuesta_tipo
    ADD CONSTRAINT respuesta_tipo_pkey PRIMARY KEY (respuesta_tipo_id);


--
-- Name: respuestas respuestas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_pkey PRIMARY KEY (respuesta_id);


--
-- Name: secciones secciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.secciones
    ADD CONSTRAINT secciones_pkey PRIMARY KEY (seccion_id);


--
-- Name: cuestionarios_resueltos_det FK_DETALLE_RESPUESTA; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios_resueltos_det
    ADD CONSTRAINT "FK_DETALLE_RESPUESTA" FOREIGN KEY (respuesta_id) REFERENCES public.respuestas(respuesta_id);


--
-- Name: cuestionarios_resueltos_det FK_DETALLE_RESUELTO; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios_resueltos_det
    ADD CONSTRAINT "FK_DETALLE_RESUELTO" FOREIGN KEY (cues_resuelto_id) REFERENCES public.cuestionarios_resueltos(cues_resuelto_id);


--
-- Name: preguntas FK_PREGUNTA_SECCION; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas
    ADD CONSTRAINT "FK_PREGUNTA_SECCION" FOREIGN KEY (seccion_id) REFERENCES public.secciones(seccion_id) NOT VALID;


--
-- Name: preguntas FK_PREGUNTA_TIPO; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas
    ADD CONSTRAINT "FK_PREGUNTA_TIPO" FOREIGN KEY (pregunta_tipo_id) REFERENCES public.preguntas_tipo(pregunta_tipo_id) NOT VALID;


--
-- Name: respuestas FK_RESPUESTA_ACCION_PREGUNTA; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT "FK_RESPUESTA_ACCION_PREGUNTA" FOREIGN KEY (accion_seccion_id) REFERENCES public.secciones(seccion_id) NOT VALID;


--
-- Name: respuestas FK_RESPUESTA_ACCION_SECCION; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT "FK_RESPUESTA_ACCION_SECCION" FOREIGN KEY (accion_pregunta_id) REFERENCES public.preguntas(pregunta_id) NOT VALID;


--
-- Name: respuestas FK_RESPUESTA_ACCION_TIPO; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT "FK_RESPUESTA_ACCION_TIPO" FOREIGN KEY (accion_tipo_id) REFERENCES public.accion_tipo(accion_tipo_id);


--
-- Name: respuestas FK_RESPUESTA_PREGUNTA; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT "FK_RESPUESTA_PREGUNTA" FOREIGN KEY (pregunta_id) REFERENCES public.preguntas(pregunta_id);


--
-- Name: respuestas FK_RESPUESTA_TIPO; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT "FK_RESPUESTA_TIPO" FOREIGN KEY (respuesta_tipo_id) REFERENCES public.respuesta_tipo(respuesta_tipo_id) NOT VALID;


--
-- Name: cuestionarios_resueltos FK_RESUELTO_CUESTIONARIO; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios_resueltos
    ADD CONSTRAINT "FK_RESUELTO_CUESTIONARIO" FOREIGN KEY (cuestionario_id) REFERENCES public.cuestionarios(cuestionario_id) NOT VALID;


--
-- Name: secciones FK_SECCION_CUESTIONARIO; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.secciones
    ADD CONSTRAINT "FK_SECCION_CUESTIONARIO" FOREIGN KEY (cuestionario_id) REFERENCES public.cuestionarios(cuestionario_id) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--

