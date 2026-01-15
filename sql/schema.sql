--
-- PostgreSQL database dump
--

\restrict IU291EEOcKGmShpO4cvueP7kLJqj4K6DiY3nMG3HVJZJ7cAshsGKak290y1Lv3t

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
-- Name: splits; Type: TABLE; Schema: earnings; Owner: avnadmin
--

CREATE TABLE earnings.splits (
    id integer NOT NULL,
    id_tasas integer NOT NULL,
    id_ingreso integer NOT NULL,
    monto_ahorro numeric(10,2) NOT NULL,
    monto_objetivo numeric(10,2) NOT NULL,
    monto_libre numeric(10,2) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    active boolean DEFAULT true NOT NULL,
    CONSTRAINT montos_positivos CHECK (((monto_ahorro >= (0)::numeric) AND (monto_objetivo >= (0)::numeric) AND (monto_libre >= (0)::numeric)))
);


ALTER TABLE earnings.splits OWNER TO avnadmin;

--
-- Name: TABLE splits; Type: COMMENT; Schema: earnings; Owner: avnadmin
--

COMMENT ON TABLE earnings.splits IS 'Almacena la distribución física en dinero basada en las tasas aplicadas';


--
-- Name: splits_id_seq; Type: SEQUENCE; Schema: earnings; Owner: avnadmin
--

CREATE SEQUENCE earnings.splits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE earnings.splits_id_seq OWNER TO avnadmin;

--
-- Name: splits_id_seq; Type: SEQUENCE OWNED BY; Schema: earnings; Owner: avnadmin
--

ALTER SEQUENCE earnings.splits_id_seq OWNED BY earnings.splits.id;


--
-- Name: tasas; Type: TABLE; Schema: earnings; Owner: avnadmin
--

CREATE TABLE earnings.tasas (
    id integer NOT NULL,
    tasa_ahorro numeric(5,2) NOT NULL,
    tasa_objetivo numeric(5,2) NOT NULL,
    tasa_libre numeric(5,2) GENERATED ALWAYS AS ((((100)::numeric - tasa_ahorro) - tasa_objetivo)) STORED,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    active boolean DEFAULT true NOT NULL,
    CONSTRAINT integridad_porcentual CHECK (((tasa_ahorro + tasa_objetivo) <= (100)::numeric)),
    CONSTRAINT tasas_positivas CHECK (((tasa_ahorro >= (0)::numeric) AND (tasa_objetivo >= (0)::numeric)))
);


ALTER TABLE earnings.tasas OWNER TO avnadmin;

--
-- Name: COLUMN tasas.tasa_libre; Type: COMMENT; Schema: earnings; Owner: avnadmin
--

COMMENT ON COLUMN earnings.tasas.tasa_libre IS 'Calculado automáticamente como el remanente del ahorro y objetivo';


--
-- Name: tasas_id_seq; Type: SEQUENCE; Schema: earnings; Owner: avnadmin
--

CREATE SEQUENCE earnings.tasas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE earnings.tasas_id_seq OWNER TO avnadmin;

--
-- Name: tasas_id_seq; Type: SEQUENCE OWNED BY; Schema: earnings; Owner: avnadmin
--

ALTER SEQUENCE earnings.tasas_id_seq OWNED BY earnings.tasas.id;


--
-- Name: ingresos id; Type: DEFAULT; Schema: earnings; Owner: avnadmin
--

ALTER TABLE ONLY earnings.ingresos ALTER COLUMN id SET DEFAULT nextval('earnings.ingresos_id_seq'::regclass);


--
-- Name: splits id; Type: DEFAULT; Schema: earnings; Owner: avnadmin
--

ALTER TABLE ONLY earnings.splits ALTER COLUMN id SET DEFAULT nextval('earnings.splits_id_seq'::regclass);


--
-- Name: tasas id; Type: DEFAULT; Schema: earnings; Owner: avnadmin
--

ALTER TABLE ONLY earnings.tasas ALTER COLUMN id SET DEFAULT nextval('earnings.tasas_id_seq'::regclass);


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
-- Name: splits splits_pkey; Type: CONSTRAINT; Schema: earnings; Owner: avnadmin
--

ALTER TABLE ONLY earnings.splits
    ADD CONSTRAINT splits_pkey PRIMARY KEY (id);


--
-- Name: tasas tasas_pkey; Type: CONSTRAINT; Schema: earnings; Owner: avnadmin
--

ALTER TABLE ONLY earnings.tasas
    ADD CONSTRAINT tasas_pkey PRIMARY KEY (id);


--
-- Name: splits fk_config_tasas; Type: FK CONSTRAINT; Schema: earnings; Owner: avnadmin
--

ALTER TABLE ONLY earnings.splits
    ADD CONSTRAINT fk_config_tasas FOREIGN KEY (id_tasas) REFERENCES earnings.tasas(id) ON UPDATE CASCADE ON DELETE RESTRICT;


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
-- Name: TABLE splits; Type: ACL; Schema: earnings; Owner: avnadmin
--

GRANT ALL ON TABLE earnings.splits TO miky WITH GRANT OPTION;


--
-- Name: TABLE tasas; Type: ACL; Schema: earnings; Owner: avnadmin
--

GRANT ALL ON TABLE earnings.tasas TO miky WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: earnings; Owner: avnadmin
--

ALTER DEFAULT PRIVILEGES FOR ROLE avnadmin IN SCHEMA earnings GRANT ALL ON TABLES TO miky WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict IU291EEOcKGmShpO4cvueP7kLJqj4K6DiY3nMG3HVJZJ7cAshsGKak290y1Lv3t

