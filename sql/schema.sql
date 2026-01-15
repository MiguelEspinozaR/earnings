--
-- PostgreSQL database dump
--

\restrict TzwAHl0w3gV3ROjmjPYGz6AdO15ehDQF5enfLYo0YF4foQ7gYCZ0oD4EBqnZNbw

-- Dumped from database version 17.7
-- Dumped by pg_dump version 17.7 (Ubuntu 17.7-3.pgdg24.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: earnings; Type: SCHEMA; Schema: -; Owner: miky
--

CREATE SCHEMA earnings;


ALTER SCHEMA earnings OWNER TO miky;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ingresos; Type: TABLE; Schema: earnings; Owner: avnadmin
--

CREATE TABLE earnings.ingresos (
    id integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    fecha_facturacion date NOT NULL,
    fecha_pago date,
    descripcion character varying(255),
    realizado boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    active boolean DEFAULT true NOT NULL,
    CONSTRAINT positivo CHECK ((monto > (0)::numeric))
);


ALTER TABLE earnings.ingresos OWNER TO avnadmin;

--
-- Name: TABLE ingresos; Type: COMMENT; Schema: earnings; Owner: avnadmin
--

COMMENT ON TABLE earnings.ingresos IS 'registra los ingresos';


--
-- Name: CONSTRAINT positivo ON ingresos; Type: COMMENT; Schema: earnings; Owner: avnadmin
--

COMMENT ON CONSTRAINT positivo ON earnings.ingresos IS 'el monto nunca podrá ser negativo';


--
-- Name: ingresos_id_seq; Type: SEQUENCE; Schema: earnings; Owner: avnadmin
--

CREATE SEQUENCE earnings.ingresos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE earnings.ingresos_id_seq OWNER TO avnadmin;

--
-- Name: ingresos_id_seq; Type: SEQUENCE OWNED BY; Schema: earnings; Owner: avnadmin
--

ALTER SEQUENCE earnings.ingresos_id_seq OWNED BY earnings.ingresos.id;


--
-- Name: ingresos id; Type: DEFAULT; Schema: earnings; Owner: avnadmin
--

ALTER TABLE ONLY earnings.ingresos ALTER COLUMN id SET DEFAULT nextval('earnings.ingresos_id_seq'::regclass);


--
-- Name: ingresos consistencia fechas; Type: CHECK CONSTRAINT; Schema: earnings; Owner: avnadmin
--

ALTER TABLE earnings.ingresos
    ADD CONSTRAINT "consistencia fechas" CHECK ((fecha_pago >= fecha_facturacion)) NOT VALID;


--
-- Name: CONSTRAINT "consistencia fechas" ON ingresos; Type: COMMENT; Schema: earnings; Owner: avnadmin
--

COMMENT ON CONSTRAINT "consistencia fechas" ON earnings.ingresos IS 'la fecha del pago nunca será previa a la facturación';


--
-- Name: ingresos ingresos_pkey; Type: CONSTRAINT; Schema: earnings; Owner: avnadmin
--

ALTER TABLE ONLY earnings.ingresos
    ADD CONSTRAINT ingresos_pkey PRIMARY KEY (id);


--
-- Name: SCHEMA earnings; Type: ACL; Schema: -; Owner: miky
--

REVOKE ALL ON SCHEMA earnings FROM miky;
GRANT ALL ON SCHEMA earnings TO miky WITH GRANT OPTION;


--
-- Name: TABLE ingresos; Type: ACL; Schema: earnings; Owner: avnadmin
--

GRANT ALL ON TABLE earnings.ingresos TO miky WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: earnings; Owner: avnadmin
--

ALTER DEFAULT PRIVILEGES FOR ROLE avnadmin IN SCHEMA earnings GRANT ALL ON TABLES TO miky WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict TzwAHl0w3gV3ROjmjPYGz6AdO15ehDQF5enfLYo0YF4foQ7gYCZ0oD4EBqnZNbw

