--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-0ubuntu0.24.04.2)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-0ubuntu0.24.04.2)

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

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: personnages; Type: TABLE; Schema: public; Owner: meodel
--

CREATE TABLE public.personnages (
    id_personnages integer NOT NULL,
    nom_personnages character varying(50) NOT NULL
);


ALTER TABLE public.personnages OWNER TO meodel;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: meodel
--

CREATE TABLE public.roles (
    id_roles integer NOT NULL,
    nom_roles character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO meodel;

--
-- Name: salles; Type: TABLE; Schema: public; Owner: meodel
--

CREATE TABLE public.salles (
    id_salles integer NOT NULL,
    nom_salles character varying(50)
);


ALTER TABLE public.salles OWNER TO meodel;

--
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: meodel
--

CREATE TABLE public.utilisateurs (
    uuid_utilisateurs uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    pseudo_utilisateurs character varying(50) NOT NULL,
    id_roles integer NOT NULL,
    id_personnages integer NOT NULL
);


ALTER TABLE public.utilisateurs OWNER TO meodel;

--
-- Name: visiter; Type: TABLE; Schema: public; Owner: meodel
--

CREATE TABLE public.visiter (
    id_personnages integer NOT NULL,
    id_salles integer NOT NULL,
    heure_arrivee time without time zone,
    heure_sortie time without time zone NOT NULL
);


ALTER TABLE public.visiter OWNER TO meodel;

--
-- Data for Name: personnages; Type: TABLE DATA; Schema: public; Owner: meodel
--

COPY public.personnages (id_personnages, nom_personnages) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: meodel
--

COPY public.roles (id_roles, nom_roles) FROM stdin;
\.


--
-- Data for Name: salles; Type: TABLE DATA; Schema: public; Owner: meodel
--

COPY public.salles (id_salles, nom_salles) FROM stdin;
\.


--
-- Data for Name: utilisateurs; Type: TABLE DATA; Schema: public; Owner: meodel
--

COPY public.utilisateurs (uuid_utilisateurs, pseudo_utilisateurs, id_roles, id_personnages) FROM stdin;
\.


--
-- Data for Name: visiter; Type: TABLE DATA; Schema: public; Owner: meodel
--

COPY public.visiter (id_personnages, id_salles, heure_arrivee, heure_sortie) FROM stdin;
\.


--
-- Name: personnages personnages_pkey; Type: CONSTRAINT; Schema: public; Owner: meodel
--

ALTER TABLE ONLY public.personnages
    ADD CONSTRAINT personnages_pkey PRIMARY KEY (id_personnages);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: meodel
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_roles);


--
-- Name: salles salles_pkey; Type: CONSTRAINT; Schema: public; Owner: meodel
--

ALTER TABLE ONLY public.salles
    ADD CONSTRAINT salles_pkey PRIMARY KEY (id_salles);


--
-- Name: utilisateurs utilisateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: meodel
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (uuid_utilisateurs);


--
-- Name: visiter visiter_pkey; Type: CONSTRAINT; Schema: public; Owner: meodel
--

ALTER TABLE ONLY public.visiter
    ADD CONSTRAINT visiter_pkey PRIMARY KEY (id_personnages, id_salles);


--
-- Name: utilisateurs fk_personnages; Type: FK CONSTRAINT; Schema: public; Owner: meodel
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT fk_personnages FOREIGN KEY (id_personnages) REFERENCES public.personnages(id_personnages);


--
-- Name: visiter fk_personnages; Type: FK CONSTRAINT; Schema: public; Owner: meodel
--

ALTER TABLE ONLY public.visiter
    ADD CONSTRAINT fk_personnages FOREIGN KEY (id_personnages) REFERENCES public.personnages(id_personnages);


--
-- Name: utilisateurs fk_roles; Type: FK CONSTRAINT; Schema: public; Owner: meodel
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT fk_roles FOREIGN KEY (id_roles) REFERENCES public.roles(id_roles);


--
-- Name: visiter fk_salles; Type: FK CONSTRAINT; Schema: public; Owner: meodel
--

ALTER TABLE ONLY public.visiter
    ADD CONSTRAINT fk_salles FOREIGN KEY (id_salles) REFERENCES public.salles(id_salles);


--
-- PostgreSQL database dump complete
--

