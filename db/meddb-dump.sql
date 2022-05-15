--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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

DROP DATABASE meddb;
--
-- Name: meddb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE meddb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';


ALTER DATABASE meddb OWNER TO postgres;

\connect meddb

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
-- Name: record_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.record_type AS ENUM (
    'visit',
    'temperature',
    'analyses',
    'operaton',
    'procedure',
    'diagnose'
);


ALTER TYPE public.record_type OWNER TO postgres;

--
-- Name: staff_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.staff_type AS ENUM (
    'med_staff',
    'service_staff'
);


ALTER TYPE public.staff_type OWNER TO postgres;

--
-- Name: find_med_staff(integer[], character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_med_staff(institutionids integer[], specializations character varying[]) RETURNS TABLE(name character varying, id integer, specialization character varying, salary integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT DISTINCT s.name, m.id, s.specialization, s.salary
        FROM med_staff m inner join staff s on s.id = m.id inner join staff_medical_institution smi on m.id = smi.staff_id
        where   ((cardinality(institutionIds) != 0 AND smi.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
            ((cardinality(specializations) != 0 AND s.specialization = ANY(specializations)) OR (cardinality(specializations) = 0))
        ORDER BY m.id;
END
$$;


ALTER FUNCTION public.find_med_staff(institutionids integer[], specializations character varying[]) OWNER TO postgres;

--
-- Name: find_med_staff_with_operations(integer[], character varying[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_med_staff_with_operations(institutionids integer[], specializations character varying[], surgeriesnumber integer) RETURNS TABLE(name character varying, id integer, specialization character varying, salary integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT DISTINCT s.name, m.id, s.specialization, s.salary
        FROM operation_staff os inner join med_staff m on m.id = os.id inner join staff s on s.id = m.id inner join staff_medical_institution smi on m.id = smi.staff_id
        where   os.num_of_surgeries > surgeriesNumber and
                ((cardinality(institutionIds) != 0 AND smi.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
                ((cardinality(specializations) != 0 AND s.specialization = ANY(specializations)) OR (cardinality(specializations) = 0))
        ORDER BY m.id;
END
$$;


ALTER FUNCTION public.find_med_staff_with_operations(institutionids integer[], specializations character varying[], surgeriesnumber integer) OWNER TO postgres;

--
-- Name: find_med_staff_with_regalia(integer[], character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_med_staff_with_regalia(institutionids integer[], specializations character varying[]) RETURNS TABLE(name character varying, id integer, specialization character varying, salary integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT DISTINCT s.name, m.id, s.specialization, s.salary
        FROM med_staff m inner join staff s on s.id = m.id inner join staff_medical_institution smi on m.id = smi.staff_id
        where   (m.phd or m.professor or m.docent or m.condidate_degree) and
                ((cardinality(institutionIds) != 0 AND smi.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
                ((cardinality(specializations) != 0 AND s.specialization = ANY(specializations)) OR (cardinality(specializations) = 0))
        ORDER BY m.id;
END
$$;


ALTER FUNCTION public.find_med_staff_with_regalia(institutionids integer[], specializations character varying[]) OWNER TO postgres;

--
-- Name: find_med_staff_with_standing(integer[], character varying[], interval); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_med_staff_with_standing(institutionids integer[], specializations character varying[], standing interval) RETURNS TABLE(name character varying, id integer, specialization character varying, salary integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT DISTINCT s.name, m.id, s.specialization, s.salary
        FROM med_staff m inner join staff s on s.id = m.id inner join staff_medical_institution smi on m.id = smi.staff_id
        where   current_date - s.employment_date > standing and
                ((cardinality(institutionIds) != 0 AND smi.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
                ((cardinality(specializations) != 0 AND s.specialization = ANY(specializations)) OR (cardinality(specializations) = 0))
        ORDER BY m.id;
END
$$;


ALTER FUNCTION public.find_med_staff_with_standing(institutionids integer[], specializations character varying[], standing interval) OWNER TO postgres;

--
-- Name: find_patient_between_date(character varying[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_patient_between_date(specializations character varying[], institutionids integer[]) RETURNS TABLE(name character varying, id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT DISTINCT p.name, p.id
        FROM patient p inner join patient_records pr on p.id = pr.patient_id inner join staff s on s.id = pr.doctor_id
        where   ((cardinality(specializations) != 0 AND s.specialization = ANY(specialization)) OR (cardinality(specialization) = 0)) and
                ((cardinality(institutionIds) != 0 AND pr.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0))
        ORDER BY p.id;
END
$$;


ALTER FUNCTION public.find_patient_between_date(specializations character varying[], institutionids integer[]) OWNER TO postgres;

--
-- Name: find_patient_between_date(integer[], integer[], date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_patient_between_date(institutionids integer[], medstaffids integer[], startdate date, enddate date) RETURNS TABLE(name character varying, id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT DISTINCT p.name, p.id
        FROM patient p inner join public.patient_records pr on p.id = pr.patient_id
        where   (pr.data between startDate and endDate) and
                ((cardinality(institutionIds) != 0 AND pr.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
                ((cardinality(medStaffIds) != 0 AND pr.doctor_id = ANY(medStaffIds)) OR (cardinality(medStaffIds) = 0))
        ORDER BY p.id;
END
$$;


ALTER FUNCTION public.find_patient_between_date(institutionids integer[], medstaffids integer[], startdate date, enddate date) OWNER TO postgres;

--
-- Name: find_patients_hospital(integer[], integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_patients_hospital(hospitalids integer[], departmentids integer[], hospitalroomids integer[]) RETURNS TABLE(id integer, name character varying, data character varying, date date)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT patient.id, patient.name, pr.data, pr.date
        FROM patient_records pr join hospital_room on pr.hospital_room_id = hospital_room.id
        join department on hospital_room.department_id = department.id join building_body on department.building_body_id = building_body.id
        join hospital on building_body.hospital_id = hospital.id join patient on pr.patient_id = patient.id
        join hospital_room_expiring on pr.grouping = hospital_room_expiring.record
        where ((cardinality(hospitalIds) != 0 AND hospital.id = ANY(hospitalIds)) OR (cardinality(hospitalIds) = 0)) AND
              ((cardinality(departmentIds) != 0 AND department.id = ANY(departmentIds)) OR (cardinality(departmentIds) = 0)) AND
              ((cardinality(hospitalRoomIds) != 0 AND hospital_room.id = ANY(hospitalRoomIds)) OR (cardinality(hospitalRoomIds) = 0)) AND
              hospital_room_expiring.date >= current_date
        ORDER BY pr.id;
END
$$;


ALTER FUNCTION public.find_patients_hospital(hospitalids integer[], departmentids integer[], hospitalroomids integer[]) OWNER TO postgres;

--
-- Name: find_service_staff(integer[], character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_service_staff(institutionids integer[], specializations character varying[]) RETURNS TABLE(name character varying, id integer, specialization character varying, salary integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT DISTINCT s.name, s.id, s.specialization, s.salary
        FROM staff s inner join staff_medical_institution smi on s.id = smi.staff_id
        where   s.type = 'service_staff' and
                ((cardinality(institutionIds) != 0 AND smi.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
                ((cardinality(specializations) != 0 AND s.specialization = ANY(specializations)) OR (cardinality(specializations) = 0))
        ORDER BY s.id;
END
$$;


ALTER FUNCTION public.find_service_staff(institutionids integer[], specializations character varying[]) OWNER TO postgres;

--
-- Name: get_count_of_cabinets(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_count_of_cabinets(institution_ids integer[]) RETURNS TABLE(count integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT count(*) as count
        FROM cabinets as c
        where  ((cardinality(institution_ids) != 0 AND c.polyclinic_id = ANY(institution_ids)) OR (cardinality(institution_ids) = 0));
END
$$;


ALTER FUNCTION public.get_count_of_cabinets(institution_ids integer[]) OWNER TO postgres;

--
-- Name: get_count_of_cabinets_usage(date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_count_of_cabinets_usage(startdate date, enddate date) RETURNS TABLE(id integer, number integer, count integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT c.id, c.number, count(pr.grouping)
        FROM cabinets c left join patient_records pr on c.id = pr.cabinet
        where (pr.type = 'visit' and pr.date between startDate and endDate) or (pr.type is NULL)
        group by c.id
        ORDER BY c.id;

END
$$;


ALTER FUNCTION public.get_count_of_cabinets_usage(startdate date, enddate date) OWNER TO postgres;

--
-- Name: get_lab_productivity(date, date, integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_lab_productivity(startdate date, enddate date, medids integer[]) RETURNS TABLE(id integer, productivity double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT l.id, (count(pr.id)::DOUBLE PRECISION / (endDate - startDate)::DOUBLE PRECISION)
        FROM laboratory l join lab_medical_institution lmi on l.id = lmi.laboratory_id left join analyzes a on l.id = a.lab_id left join patient_records pr on a.record = pr.id
        WHERE pr.date between startDate and endDate and
              ((cardinality(medIds)!=0 AND lmi.medical_institution_id = ANY(medIds)) OR cardinality(medIds)=0)
        group by l.id;
END
$$;


ALTER FUNCTION public.get_lab_productivity(startdate date, enddate date, medids integer[]) OWNER TO postgres;

--
-- Name: get_number_of_free_hospital_room_beds_by_departments(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_number_of_free_hospital_room_beds_by_departments() RETURNS TABLE(departmentid integer, count integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT d.id, sum(hospital_room.bed_number) - count(pr.id)
        FROM hospital_room join department d on hospital_room.department_id = d.id left join
        patient_records pr on hospital_room.id = pr.hospital_room_id left join hospital_room_expiring hre on pr.grouping = hre.record
        where hre.date is null or hre.date > current_date
        group by d.id;
END
$$;


ALTER FUNCTION public.get_number_of_free_hospital_room_beds_by_departments() OWNER TO postgres;

--
-- Name: get_number_of_free_hospital_room_by_departments(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_number_of_free_hospital_room_by_departments() RETURNS TABLE(departmentid integer, count integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT d.id, count(hospital_room.id)
        FROM hospital_room join department d on hospital_room.department_id = d.id left join
            (
                select distinct pr.hospital_room_id
                from patient_records pr join hospital_room_expiring hre on pr.date = hre.date
                where current_date < hre.date
            ) prid on hospital_room.id = prid.hospital_room_id
        where prid.hospital_room_id is null
        group by d.id;
END
$$;


ALTER FUNCTION public.get_number_of_free_hospital_room_by_departments() OWNER TO postgres;

--
-- Name: get_number_of_hospital_room(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_number_of_hospital_room() RETURNS TABLE(count integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT count(hospital_room.id)
        FROM hospital_room;
END
$$;


ALTER FUNCTION public.get_number_of_hospital_room() OWNER TO postgres;

--
-- Name: get_number_of_hospital_room_beds(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_number_of_hospital_room_beds() RETURNS TABLE(count integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT sum(hospital_room.bed_number)
        FROM hospital_room;
END
$$;


ALTER FUNCTION public.get_number_of_hospital_room_beds() OWNER TO postgres;

--
-- Name: get_number_of_hospital_room_beds_by_departments(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_number_of_hospital_room_beds_by_departments() RETURNS TABLE(departmentid integer, count integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT d.id, sum(hospital_room.bed_number)
        FROM hospital_room join department d on hospital_room.department_id = d.id
        group by d.id;
END
$$;


ALTER FUNCTION public.get_number_of_hospital_room_beds_by_departments() OWNER TO postgres;

--
-- Name: get_number_of_hospital_room_by_departments(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_number_of_hospital_room_by_departments() RETURNS TABLE(departmentid integer, count integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT d.id, count(hospital_room.id)
        FROM hospital_room join department d on hospital_room.department_id = d.id
        group by d.id;
END
$$;


ALTER FUNCTION public.get_number_of_hospital_room_by_departments() OWNER TO postgres;

--
-- Name: get_productivity_hospital(date, date, integer[], character varying[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_productivity_hospital(startdate date, enddate date, doctorids integer[], specializationids character varying[], hospitalids integer[]) RETURNS TABLE(id integer, name character varying, productivity double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT s.id, s.name, (count(pr.grouping)::DOUBLE PRECISION / (endDate - startDate)::DOUBLE PRECISION) productivity
        FROM patient_records pr join staff s on pr.doctor_id = s.id join med_staff ms on s.id = ms.id join hospital h on pr.medical_institution_id = h.id
        WHERE (pr.date between startDate and endDate) and
              ((cardinality(doctorIds)!=0 AND pr.doctor_id = ANY(doctorIds)) OR cardinality(doctorIds)=0) and
              ((cardinality(specializationIds)!=0 AND s.specialization = ANY(specializationIds)) OR cardinality(specializationIds)=0) and
              ((cardinality(hospitalIds)!=0 AND pr.medical_institution_id = ANY(hospitalIds)) OR cardinality(hospitalIds)=0)
        GROUP BY s.id, s.name
        ORDER BY s.id;
END
$$;


ALTER FUNCTION public.get_productivity_hospital(startdate date, enddate date, doctorids integer[], specializationids character varying[], hospitalids integer[]) OWNER TO postgres;

--
-- Name: get_productivity_polyclinic(date, date, integer[], character varying[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_productivity_polyclinic(startdate date, enddate date, doctorids integer[], specializationids character varying[], polyclinicids integer[]) RETURNS TABLE(id integer, name character varying, productivity double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT s.id, s.name, (count(pr.grouping)::DOUBLE PRECISION / (endDate - startDate)::DOUBLE PRECISION) productivity
        FROM patient_records pr join staff s on pr.doctor_id = s.id join med_staff ms on s.id = ms.id join polyclinic p on pr.medical_institution_id = p.id
        WHERE (pr.date between startDate and endDate) and
              ((cardinality(doctorIds)!=0 AND pr.doctor_id = ANY(doctorIds)) OR cardinality(doctorIds)=0) and
              ((cardinality(specializationIds)!=0 AND s.specialization = ANY(specializationIds)) OR cardinality(specializationIds)=0) and
              ((cardinality(polyclinicIds)!=0 AND pr.medical_institution_id = ANY(polyclinicIds)) OR cardinality(polyclinicIds)=0)
        GROUP BY s.id, s.name
        ORDER BY s.id;
END
$$;


ALTER FUNCTION public.get_productivity_polyclinic(startdate date, enddate date, doctorids integer[], specializationids character varying[], polyclinicids integer[]) OWNER TO postgres;

--
-- Name: get_surgeon_patients(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_surgeon_patients(doctorids integer[], medids integer[]) RETURNS TABLE(id integer, name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT p.id, p.name
        FROM patient_records pr join patient p on pr.patient_id = p.id
        WHERE pr.type = 'operaton' and
              ((cardinality(doctorIds)!=0 AND pr.doctor_id = ANY(doctorIds)) OR cardinality(doctorIds)=0) and
              ((cardinality(medIds)!=0 AND pr.medical_institution_id = ANY(medIds)) OR cardinality(medIds)=0);
END
$$;


ALTER FUNCTION public.get_surgeon_patients(doctorids integer[], medids integer[]) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: analyzes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analyzes (
    record integer,
    lab_id integer,
    id integer NOT NULL
);


ALTER TABLE public.analyzes OWNER TO postgres;

--
-- Name: analyzes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analyzes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.analyzes_id_seq OWNER TO postgres;

--
-- Name: analyzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analyzes_id_seq OWNED BY public.analyzes.id;


--
-- Name: building_body; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.building_body (
    id integer NOT NULL,
    hospital_id integer
);


ALTER TABLE public.building_body OWNER TO postgres;

--
-- Name: building_body_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.building_body_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.building_body_id_seq OWNER TO postgres;

--
-- Name: building_body_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.building_body_id_seq OWNED BY public.building_body.id;


--
-- Name: cabinets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cabinets (
    id integer NOT NULL,
    polyclinic_id integer NOT NULL,
    number integer NOT NULL
);


ALTER TABLE public.cabinets OWNER TO postgres;

--
-- Name: cabinets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cabinets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cabinets_id_seq OWNER TO postgres;

--
-- Name: cabinets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cabinets_id_seq OWNED BY public.cabinets.id;


--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id integer NOT NULL,
    building_body_id integer,
    specialization character varying
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.department_id_seq OWNER TO postgres;

--
-- Name: department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_id_seq OWNED BY public.department.id;


--
-- Name: hospital; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hospital (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.hospital OWNER TO postgres;

--
-- Name: hospital_room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hospital_room (
    id integer NOT NULL,
    department_id integer,
    bed_number integer
);


ALTER TABLE public.hospital_room OWNER TO postgres;

--
-- Name: hospital_room_expiring; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hospital_room_expiring (
    record integer NOT NULL,
    date date NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.hospital_room_expiring OWNER TO postgres;

--
-- Name: hospital_room_expiring_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hospital_room_expiring_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hospital_room_expiring_id_seq OWNER TO postgres;

--
-- Name: hospital_room_expiring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hospital_room_expiring_id_seq OWNED BY public.hospital_room_expiring.id;


--
-- Name: hospital_room_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hospital_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hospital_room_id_seq OWNER TO postgres;

--
-- Name: hospital_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hospital_room_id_seq OWNED BY public.hospital_room.id;


--
-- Name: lab_medical_institution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lab_medical_institution (
    medical_institution_id integer,
    laboratory_id integer,
    id integer NOT NULL
);


ALTER TABLE public.lab_medical_institution OWNER TO postgres;

--
-- Name: lab_medical_institution_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lab_medical_institution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lab_medical_institution_id_seq OWNER TO postgres;

--
-- Name: lab_medical_institution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lab_medical_institution_id_seq OWNED BY public.lab_medical_institution.id;


--
-- Name: laboratory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.laboratory (
    id integer NOT NULL,
    specialization character varying
);


ALTER TABLE public.laboratory OWNER TO postgres;

--
-- Name: laboratory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.laboratory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.laboratory_id_seq OWNER TO postgres;

--
-- Name: laboratory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.laboratory_id_seq OWNED BY public.laboratory.id;


--
-- Name: med_staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.med_staff (
    id integer NOT NULL,
    salary_coefficient double precision,
    vocation_bonus integer,
    condidate_degree boolean,
    phd boolean,
    professor boolean,
    docent boolean,
    polyclinic_id integer,
    hospital_id integer
);


ALTER TABLE public.med_staff OWNER TO postgres;

--
-- Name: med_staff_patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.med_staff_patient (
    med_staff_id integer,
    patient_id integer,
    id integer NOT NULL
);


ALTER TABLE public.med_staff_patient OWNER TO postgres;

--
-- Name: med_staff_patient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.med_staff_patient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.med_staff_patient_id_seq OWNER TO postgres;

--
-- Name: med_staff_patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.med_staff_patient_id_seq OWNED BY public.med_staff_patient.id;


--
-- Name: medical_institution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medical_institution (
    id integer NOT NULL
);


ALTER TABLE public.medical_institution OWNER TO postgres;

--
-- Name: medical_institution_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medical_institution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.medical_institution_id_seq OWNER TO postgres;

--
-- Name: medical_institution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medical_institution_id_seq OWNED BY public.medical_institution.id;


--
-- Name: operation_staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operation_staff (
    id integer NOT NULL,
    num_of_surgeries integer,
    num_of_fatal_surgeries integer
);


ALTER TABLE public.operation_staff OWNER TO postgres;

--
-- Name: patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient (
    id integer NOT NULL,
    name character varying,
    birth_day timestamp without time zone
);


ALTER TABLE public.patient OWNER TO postgres;

--
-- Name: patient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patient_id_seq OWNER TO postgres;

--
-- Name: patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patient_id_seq OWNED BY public.patient.id;


--
-- Name: patient_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient_records (
    id integer NOT NULL,
    patient_id integer,
    medical_institution_id integer,
    data character varying,
    type public.record_type,
    date timestamp without time zone,
    doctor_id integer,
    hospital_room_id integer,
    cabinet integer,
    "grouping" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.patient_records OWNER TO postgres;

--
-- Name: patient_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patient_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patient_records_id_seq OWNER TO postgres;

--
-- Name: patient_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patient_records_id_seq OWNED BY public.patient_records.id;


--
-- Name: polyclinic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.polyclinic (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.polyclinic OWNER TO postgres;

--
-- Name: polyclinic_fixing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.polyclinic_fixing (
    polyclinic_id integer,
    hospital_id integer,
    id integer NOT NULL
);


ALTER TABLE public.polyclinic_fixing OWNER TO postgres;

--
-- Name: polyclinic_fixing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.polyclinic_fixing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polyclinic_fixing_id_seq OWNER TO postgres;

--
-- Name: polyclinic_fixing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.polyclinic_fixing_id_seq OWNED BY public.polyclinic_fixing.id;


--
-- Name: prof_or_docent_medical_institution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prof_or_docent_medical_institution (
    prof_or_docent_id integer NOT NULL,
    medical_institution_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.prof_or_docent_medical_institution OWNER TO postgres;

--
-- Name: prof_or_docent_medical_institution_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prof_or_docent_medical_institution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prof_or_docent_medical_institution_id_seq OWNER TO postgres;

--
-- Name: prof_or_docent_medical_institution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prof_or_docent_medical_institution_id_seq OWNED BY public.prof_or_docent_medical_institution.id;


--
-- Name: professor_or_docent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.professor_or_docent (
    id integer NOT NULL
);


ALTER TABLE public.professor_or_docent OWNER TO postgres;

--
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    id integer NOT NULL,
    name character varying,
    specialization character varying,
    salary integer,
    type public.staff_type,
    employment_date timestamp without time zone
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staff_id_seq OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;


--
-- Name: staff_medical_institution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff_medical_institution (
    staff_id integer NOT NULL,
    medical_institution_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.staff_medical_institution OWNER TO postgres;

--
-- Name: staff_medical_institution_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_medical_institution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staff_medical_institution_id_seq OWNER TO postgres;

--
-- Name: staff_medical_institution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_medical_institution_id_seq OWNED BY public.staff_medical_institution.id;


--
-- Name: analyzes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analyzes ALTER COLUMN id SET DEFAULT nextval('public.analyzes_id_seq'::regclass);


--
-- Name: building_body id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_body ALTER COLUMN id SET DEFAULT nextval('public.building_body_id_seq'::regclass);


--
-- Name: cabinets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cabinets ALTER COLUMN id SET DEFAULT nextval('public.cabinets_id_seq'::regclass);


--
-- Name: department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN id SET DEFAULT nextval('public.department_id_seq'::regclass);


--
-- Name: hospital_room id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital_room ALTER COLUMN id SET DEFAULT nextval('public.hospital_room_id_seq'::regclass);


--
-- Name: hospital_room_expiring id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital_room_expiring ALTER COLUMN id SET DEFAULT nextval('public.hospital_room_expiring_id_seq'::regclass);


--
-- Name: lab_medical_institution id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_medical_institution ALTER COLUMN id SET DEFAULT nextval('public.lab_medical_institution_id_seq'::regclass);


--
-- Name: laboratory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laboratory ALTER COLUMN id SET DEFAULT nextval('public.laboratory_id_seq'::regclass);


--
-- Name: med_staff_patient id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.med_staff_patient ALTER COLUMN id SET DEFAULT nextval('public.med_staff_patient_id_seq'::regclass);


--
-- Name: medical_institution id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_institution ALTER COLUMN id SET DEFAULT nextval('public.medical_institution_id_seq'::regclass);


--
-- Name: patient id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient ALTER COLUMN id SET DEFAULT nextval('public.patient_id_seq'::regclass);


--
-- Name: patient_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_records ALTER COLUMN id SET DEFAULT nextval('public.patient_records_id_seq'::regclass);


--
-- Name: polyclinic_fixing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polyclinic_fixing ALTER COLUMN id SET DEFAULT nextval('public.polyclinic_fixing_id_seq'::regclass);


--
-- Name: prof_or_docent_medical_institution id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prof_or_docent_medical_institution ALTER COLUMN id SET DEFAULT nextval('public.prof_or_docent_medical_institution_id_seq'::regclass);


--
-- Name: staff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- Name: staff_medical_institution id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_medical_institution ALTER COLUMN id SET DEFAULT nextval('public.staff_medical_institution_id_seq'::regclass);


--
-- Data for Name: analyzes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.analyzes VALUES (2, 1, 1);


--
-- Data for Name: building_body; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.building_body VALUES (1, 1);
INSERT INTO public.building_body VALUES (2, 2);
INSERT INTO public.building_body VALUES (3, 3);
INSERT INTO public.building_body VALUES (4, 4);
INSERT INTO public.building_body VALUES (5, 5);
INSERT INTO public.building_body VALUES (6, 6);
INSERT INTO public.building_body VALUES (7, 7);
INSERT INTO public.building_body VALUES (8, 8);
INSERT INTO public.building_body VALUES (9, 9);
INSERT INTO public.building_body VALUES (10, 10);
INSERT INTO public.building_body VALUES (11, 1);
INSERT INTO public.building_body VALUES (12, 2);
INSERT INTO public.building_body VALUES (13, 3);
INSERT INTO public.building_body VALUES (14, 1);
INSERT INTO public.building_body VALUES (15, 1);
INSERT INTO public.building_body VALUES (16, 1);
INSERT INTO public.building_body VALUES (17, 1);
INSERT INTO public.building_body VALUES (18, 1);


--
-- Data for Name: cabinets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cabinets VALUES (1, 11, 101);
INSERT INTO public.cabinets VALUES (2, 11, 102);
INSERT INTO public.cabinets VALUES (3, 11, 103);
INSERT INTO public.cabinets VALUES (4, 12, 1);
INSERT INTO public.cabinets VALUES (5, 12, 2);
INSERT INTO public.cabinets VALUES (6, 12, 3);
INSERT INTO public.cabinets VALUES (7, 13, 1);
INSERT INTO public.cabinets VALUES (8, 13, 2);
INSERT INTO public.cabinets VALUES (9, 14, 1);
INSERT INTO public.cabinets VALUES (10, 15, 1);
INSERT INTO public.cabinets VALUES (11, 16, 1);
INSERT INTO public.cabinets VALUES (12, 17, 1);
INSERT INTO public.cabinets VALUES (13, 18, 1);
INSERT INTO public.cabinets VALUES (14, 19, 1);
INSERT INTO public.cabinets VALUES (15, 20, 1);


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.department VALUES (1, 1, 'Дерматологическое отделение');
INSERT INTO public.department VALUES (2, 1, 'Тубдиспансер');
INSERT INTO public.department VALUES (3, 1, 'Инфекционное отделение');
INSERT INTO public.department VALUES (4, 1, 'Травмоталогическое отделение');
INSERT INTO public.department VALUES (5, 2, 'Дерматологическое отделение');
INSERT INTO public.department VALUES (6, 2, 'Тубдиспансер');
INSERT INTO public.department VALUES (7, 2, 'Инфекционное отделение');
INSERT INTO public.department VALUES (8, 2, 'Травмоталогическое отделение');
INSERT INTO public.department VALUES (9, 3, 'Дерматологическое отделение');
INSERT INTO public.department VALUES (10, 3, 'Тубдиспансер');
INSERT INTO public.department VALUES (11, 3, 'Травмоталогическое отделение');
INSERT INTO public.department VALUES (12, 4, 'Дерматологическое отделение');
INSERT INTO public.department VALUES (13, 5, 'Инфекционное отделение');
INSERT INTO public.department VALUES (14, 6, 'Травмоталогическое отделение');
INSERT INTO public.department VALUES (15, 7, 'Дерматологическое отделение');
INSERT INTO public.department VALUES (16, 8, 'Тубдиспансер');
INSERT INTO public.department VALUES (17, 9, 'Инфекционное отделение');
INSERT INTO public.department VALUES (18, 10, 'Травмоталогическое отделение');
INSERT INTO public.department VALUES (19, 11, 'Дерматологическое отделение');
INSERT INTO public.department VALUES (20, 12, 'Тубдиспансер');
INSERT INTO public.department VALUES (21, 13, 'Инфекционное отделение');
INSERT INTO public.department VALUES (22, 14, 'Травмоталогическое отделение');
INSERT INTO public.department VALUES (23, 15, 'Дерматологическое отделение');
INSERT INTO public.department VALUES (24, 16, 'Тубдиспансер');
INSERT INTO public.department VALUES (25, 17, 'Инфекционное отделение');
INSERT INTO public.department VALUES (26, 18, 'Травмоталогическое отделение');


--
-- Data for Name: hospital; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hospital VALUES (1, 'Центральная новосибирская больница');
INSERT INTO public.hospital VALUES (2, 'Больница святого Петра');
INSERT INTO public.hospital VALUES (3, 'Больница имени Билли');
INSERT INTO public.hospital VALUES (4, 'Больница мексиканских рестрлеров');
INSERT INTO public.hospital VALUES (5, 'Центр новых медицинских технологий');
INSERT INTO public.hospital VALUES (6, 'Больница имени Вана');
INSERT INTO public.hospital VALUES (7, 'Государственная больница');
INSERT INTO public.hospital VALUES (8, 'Тюремная больница');
INSERT INTO public.hospital VALUES (9, 'Больница Акхэм');
INSERT INTO public.hospital VALUES (10, 'Дурдом');


--
-- Data for Name: hospital_room; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hospital_room VALUES (1, 1, 1);
INSERT INTO public.hospital_room VALUES (2, 2, 2);
INSERT INTO public.hospital_room VALUES (3, 3, 3);
INSERT INTO public.hospital_room VALUES (4, 4, 4);
INSERT INTO public.hospital_room VALUES (5, 5, 5);
INSERT INTO public.hospital_room VALUES (6, 6, 6);
INSERT INTO public.hospital_room VALUES (7, 7, 6);
INSERT INTO public.hospital_room VALUES (8, 8, 6);
INSERT INTO public.hospital_room VALUES (9, 9, 6);
INSERT INTO public.hospital_room VALUES (10, 10, 6);
INSERT INTO public.hospital_room VALUES (11, 11, 6);
INSERT INTO public.hospital_room VALUES (12, 12, 6);
INSERT INTO public.hospital_room VALUES (13, 13, 6);
INSERT INTO public.hospital_room VALUES (14, 14, 6);
INSERT INTO public.hospital_room VALUES (15, 15, 6);
INSERT INTO public.hospital_room VALUES (16, 16, 6);
INSERT INTO public.hospital_room VALUES (17, 17, 6);
INSERT INTO public.hospital_room VALUES (18, 18, 6);
INSERT INTO public.hospital_room VALUES (19, 19, 6);
INSERT INTO public.hospital_room VALUES (20, 20, 6);
INSERT INTO public.hospital_room VALUES (21, 21, 6);
INSERT INTO public.hospital_room VALUES (22, 22, 6);
INSERT INTO public.hospital_room VALUES (23, 23, 6);
INSERT INTO public.hospital_room VALUES (24, 24, 6);
INSERT INTO public.hospital_room VALUES (25, 25, 6);
INSERT INTO public.hospital_room VALUES (26, 26, 6);
INSERT INTO public.hospital_room VALUES (27, 10, 6);
INSERT INTO public.hospital_room VALUES (28, 10, 6);
INSERT INTO public.hospital_room VALUES (29, 10, 6);
INSERT INTO public.hospital_room VALUES (30, 10, 6);
INSERT INTO public.hospital_room VALUES (31, 10, 6);
INSERT INTO public.hospital_room VALUES (32, 10, 6);
INSERT INTO public.hospital_room VALUES (33, 10, 6);
INSERT INTO public.hospital_room VALUES (34, 10, 6);
INSERT INTO public.hospital_room VALUES (35, 10, 6);
INSERT INTO public.hospital_room VALUES (36, 10, 6);
INSERT INTO public.hospital_room VALUES (37, 10, 6);


--
-- Data for Name: hospital_room_expiring; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hospital_room_expiring VALUES (3, '2021-05-31', 1);
INSERT INTO public.hospital_room_expiring VALUES (4, '2021-04-08', 2);


--
-- Data for Name: lab_medical_institution; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.lab_medical_institution VALUES (1, 1, 1);
INSERT INTO public.lab_medical_institution VALUES (1, 2, 2);
INSERT INTO public.lab_medical_institution VALUES (2, 2, 3);
INSERT INTO public.lab_medical_institution VALUES (2, 3, 4);
INSERT INTO public.lab_medical_institution VALUES (3, 3, 5);
INSERT INTO public.lab_medical_institution VALUES (3, 4, 6);
INSERT INTO public.lab_medical_institution VALUES (4, 4, 7);
INSERT INTO public.lab_medical_institution VALUES (4, 5, 8);
INSERT INTO public.lab_medical_institution VALUES (5, 5, 9);
INSERT INTO public.lab_medical_institution VALUES (5, 6, 10);
INSERT INTO public.lab_medical_institution VALUES (6, 6, 11);
INSERT INTO public.lab_medical_institution VALUES (6, 7, 12);
INSERT INTO public.lab_medical_institution VALUES (7, 7, 13);
INSERT INTO public.lab_medical_institution VALUES (7, 8, 14);
INSERT INTO public.lab_medical_institution VALUES (8, 8, 15);
INSERT INTO public.lab_medical_institution VALUES (8, 9, 16);
INSERT INTO public.lab_medical_institution VALUES (9, 9, 17);
INSERT INTO public.lab_medical_institution VALUES (9, 1, 18);
INSERT INTO public.lab_medical_institution VALUES (10, 1, 19);
INSERT INTO public.lab_medical_institution VALUES (10, 2, 20);
INSERT INTO public.lab_medical_institution VALUES (11, 1, 21);
INSERT INTO public.lab_medical_institution VALUES (12, 2, 22);
INSERT INTO public.lab_medical_institution VALUES (13, 3, 23);
INSERT INTO public.lab_medical_institution VALUES (14, 4, 24);
INSERT INTO public.lab_medical_institution VALUES (15, 5, 25);
INSERT INTO public.lab_medical_institution VALUES (16, 6, 26);
INSERT INTO public.lab_medical_institution VALUES (17, 7, 27);
INSERT INTO public.lab_medical_institution VALUES (18, 8, 28);
INSERT INTO public.lab_medical_institution VALUES (19, 9, 29);
INSERT INTO public.lab_medical_institution VALUES (20, 1, 30);


--
-- Data for Name: laboratory; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.laboratory VALUES (1, 'Биохимическая');
INSERT INTO public.laboratory VALUES (2, 'Биохимическая');
INSERT INTO public.laboratory VALUES (3, 'Биохимическая');
INSERT INTO public.laboratory VALUES (4, 'Физиологическая');
INSERT INTO public.laboratory VALUES (5, 'Физиологическая');
INSERT INTO public.laboratory VALUES (6, 'Физиологическая');
INSERT INTO public.laboratory VALUES (7, 'Химические исследования');
INSERT INTO public.laboratory VALUES (8, 'Химические исследования');
INSERT INTO public.laboratory VALUES (9, 'Химические исследования');


--
-- Data for Name: med_staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.med_staff VALUES (1, 1, 0, false, false, false, false, 11, 1);
INSERT INTO public.med_staff VALUES (2, 1.5, 30, true, false, false, false, 12, 2);
INSERT INTO public.med_staff VALUES (3, 1, 0, false, true, false, false, 13, 3);
INSERT INTO public.med_staff VALUES (4, 1, 0, false, true, true, false, 14, 4);
INSERT INTO public.med_staff VALUES (5, 1, 0, false, true, false, false, 15, 5);
INSERT INTO public.med_staff VALUES (6, 1.5, 30, true, false, false, false, 16, 6);
INSERT INTO public.med_staff VALUES (7, 1, 0, true, true, false, true, 17, 7);
INSERT INTO public.med_staff VALUES (8, 1, 0, false, true, true, false, 18, 8);
INSERT INTO public.med_staff VALUES (9, 1, 0, false, false, false, false, 19, 9);
INSERT INTO public.med_staff VALUES (10, 1, 0, false, false, false, false, 20, 10);
INSERT INTO public.med_staff VALUES (11, 1, 0, false, true, true, false, NULL, 1);
INSERT INTO public.med_staff VALUES (12, 1, 0, true, false, false, true, NULL, 2);
INSERT INTO public.med_staff VALUES (13, 1.5, 0, false, false, false, false, NULL, 3);
INSERT INTO public.med_staff VALUES (14, 1, 0, false, true, true, false, NULL, 4);
INSERT INTO public.med_staff VALUES (15, 1, 0, false, false, false, false, NULL, 5);
INSERT INTO public.med_staff VALUES (16, 1, 0, false, false, false, false, NULL, 6);
INSERT INTO public.med_staff VALUES (17, 1, 0, true, false, false, true, NULL, 7);
INSERT INTO public.med_staff VALUES (18, 1, 0, false, false, false, false, NULL, 8);
INSERT INTO public.med_staff VALUES (19, 1, 0, false, false, false, false, NULL, 9);
INSERT INTO public.med_staff VALUES (20, 1, 0, false, false, false, false, NULL, 10);


--
-- Data for Name: med_staff_patient; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.med_staff_patient VALUES (1, 1, 1);
INSERT INTO public.med_staff_patient VALUES (2, 7, 2);
INSERT INTO public.med_staff_patient VALUES (3, 1, 3);


--
-- Data for Name: medical_institution; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.medical_institution VALUES (1);
INSERT INTO public.medical_institution VALUES (2);
INSERT INTO public.medical_institution VALUES (3);
INSERT INTO public.medical_institution VALUES (4);
INSERT INTO public.medical_institution VALUES (5);
INSERT INTO public.medical_institution VALUES (6);
INSERT INTO public.medical_institution VALUES (7);
INSERT INTO public.medical_institution VALUES (8);
INSERT INTO public.medical_institution VALUES (9);
INSERT INTO public.medical_institution VALUES (10);
INSERT INTO public.medical_institution VALUES (11);
INSERT INTO public.medical_institution VALUES (12);
INSERT INTO public.medical_institution VALUES (13);
INSERT INTO public.medical_institution VALUES (14);
INSERT INTO public.medical_institution VALUES (15);
INSERT INTO public.medical_institution VALUES (16);
INSERT INTO public.medical_institution VALUES (17);
INSERT INTO public.medical_institution VALUES (18);
INSERT INTO public.medical_institution VALUES (19);
INSERT INTO public.medical_institution VALUES (20);


--
-- Data for Name: operation_staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.operation_staff VALUES (1, 10, 1);
INSERT INTO public.operation_staff VALUES (2, 100, 100);
INSERT INTO public.operation_staff VALUES (5, 42, 0);
INSERT INTO public.operation_staff VALUES (9, 8, 0);
INSERT INTO public.operation_staff VALUES (11, 10, 9);
INSERT INTO public.operation_staff VALUES (13, 111, 11);
INSERT INTO public.operation_staff VALUES (14, 101, 11);


--
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.patient VALUES (1, 'Мальцев Игорь Сергеевич', '2001-12-01 00:00:00');
INSERT INTO public.patient VALUES (2, 'Куклачев Анатоий Павлович', '2001-12-01 00:00:00');
INSERT INTO public.patient VALUES (3, 'Акулин Павел Борисович', '2001-12-01 00:00:00');
INSERT INTO public.patient VALUES (4, 'Евтушенко Александр Александрович', '2001-12-01 00:00:00');
INSERT INTO public.patient VALUES (5, 'Щукин Виктор сергеевич', '2001-12-01 00:00:00');
INSERT INTO public.patient VALUES (6, 'Гомелев Константин Васильевич', '2001-12-01 00:00:00');
INSERT INTO public.patient VALUES (7, 'Ульянов Андрей Максимович', '2001-12-01 00:00:00');
INSERT INTO public.patient VALUES (8, 'Артемов Артем Артемович', '2001-12-01 00:00:00');


--
-- Data for Name: patient_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.patient_records VALUES (2, 1, 11, 'Анализ крови: гемоглобин 70 дл/л', 'analyses', '2021-01-29 00:00:00', 1, NULL, 2, 1);
INSERT INTO public.patient_records VALUES (3, 1, 11, 'Без патологий', 'diagnose', '2021-01-20 00:00:00', 1, NULL, 2, 1);
INSERT INTO public.patient_records VALUES (1, 1, 11, 'Жалоба на боль в колене', 'visit', '2021-01-20 00:00:00', 1, NULL, 2, 1);
INSERT INTO public.patient_records VALUES (11, 1, 11, 'Боль в пояснице', 'visit', '2020-05-05 05:30:33', 1, NULL, 1, 5);
INSERT INTO public.patient_records VALUES (7, 3, 1, 'Боль в области печени', 'visit', '2021-05-20 00:00:00', 1, 1, NULL, 3);
INSERT INTO public.patient_records VALUES (5, 2, 17, 'Сухой кашель, боль в горле', 'visit', '2021-02-20 00:00:00', 7, NULL, 12, 2);
INSERT INTO public.patient_records VALUES (6, 2, 17, 'Простуда', 'diagnose', '2021-02-20 00:00:00', 7, NULL, 12, 2);
INSERT INTO public.patient_records VALUES (10, 1, 1, 'Удаление апендицита', 'operaton', '2021-03-20 00:00:00', 1, 26, NULL, 4);
INSERT INTO public.patient_records VALUES (4, 2, 17, 'температура 38.7', 'temperature', '2021-02-20 00:00:00', 7, NULL, 12, 2);
INSERT INTO public.patient_records VALUES (9, 1, 1, 'Боль в правом боку', 'visit', '2021-03-20 00:00:00', 1, 26, NULL, 4);
INSERT INTO public.patient_records VALUES (8, 3, 1, 'Оперция на печени', 'operaton', '2021-05-20 00:00:00', 1, 1, NULL, 3);
INSERT INTO public.patient_records VALUES (14, 1, 1, 'температура 36.6', 'temperature', '2021-03-20 00:00:00', 1, 26, NULL, 4);
INSERT INTO public.patient_records VALUES (13, 3, 1, 'температура 39.9', 'temperature', '2021-05-20 05:13:34', 1, 1, NULL, 3);
INSERT INTO public.patient_records VALUES (12, 1, 11, 'температура 36.6', 'temperature', '2021-01-20 05:11:32', 1, NULL, 2, 1);


--
-- Data for Name: polyclinic; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.polyclinic VALUES (11, 'Поликлиника имени Рыбникова');
INSERT INTO public.polyclinic VALUES (12, 'Диагностичексая профилактическая поликлиника');
INSERT INTO public.polyclinic VALUES (13, 'Районая поликлиника Октябрьский райнон');
INSERT INTO public.polyclinic VALUES (14, 'Центральная поликлиника');
INSERT INTO public.polyclinic VALUES (15, 'Поликлиника военого подразделения');
INSERT INTO public.polyclinic VALUES (16, 'Частная поликлиника Ромашка');
INSERT INTO public.polyclinic VALUES (17, 'Поликлиника диагностики рака');
INSERT INTO public.polyclinic VALUES (18, 'Косультативно-диагностическая поликлиника');
INSERT INTO public.polyclinic VALUES (19, 'Поликлиника традиционной медицины');
INSERT INTO public.polyclinic VALUES (20, 'Поликлиника восточной медицины');


--
-- Data for Name: polyclinic_fixing; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.polyclinic_fixing VALUES (11, 1, 1);
INSERT INTO public.polyclinic_fixing VALUES (12, 2, 2);
INSERT INTO public.polyclinic_fixing VALUES (12, 3, 3);
INSERT INTO public.polyclinic_fixing VALUES (14, 4, 4);
INSERT INTO public.polyclinic_fixing VALUES (15, 5, 5);
INSERT INTO public.polyclinic_fixing VALUES (16, 6, 6);
INSERT INTO public.polyclinic_fixing VALUES (17, 7, 7);
INSERT INTO public.polyclinic_fixing VALUES (18, 8, 8);
INSERT INTO public.polyclinic_fixing VALUES (20, 1, 9);


--
-- Data for Name: prof_or_docent_medical_institution; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.prof_or_docent_medical_institution VALUES (4, 1, 1);
INSERT INTO public.prof_or_docent_medical_institution VALUES (4, 4, 2);
INSERT INTO public.prof_or_docent_medical_institution VALUES (4, 14, 3);
INSERT INTO public.prof_or_docent_medical_institution VALUES (7, 2, 4);
INSERT INTO public.prof_or_docent_medical_institution VALUES (7, 7, 5);
INSERT INTO public.prof_or_docent_medical_institution VALUES (7, 17, 6);
INSERT INTO public.prof_or_docent_medical_institution VALUES (8, 3, 7);
INSERT INTO public.prof_or_docent_medical_institution VALUES (8, 8, 8);
INSERT INTO public.prof_or_docent_medical_institution VALUES (8, 18, 9);
INSERT INTO public.prof_or_docent_medical_institution VALUES (11, 1, 10);
INSERT INTO public.prof_or_docent_medical_institution VALUES (11, 4, 11);
INSERT INTO public.prof_or_docent_medical_institution VALUES (12, 2, 12);
INSERT INTO public.prof_or_docent_medical_institution VALUES (14, 4, 13);
INSERT INTO public.prof_or_docent_medical_institution VALUES (17, 7, 14);


--
-- Data for Name: professor_or_docent; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.professor_or_docent VALUES (4);
INSERT INTO public.professor_or_docent VALUES (7);
INSERT INTO public.professor_or_docent VALUES (8);
INSERT INTO public.professor_or_docent VALUES (11);
INSERT INTO public.professor_or_docent VALUES (12);
INSERT INTO public.professor_or_docent VALUES (14);
INSERT INTO public.professor_or_docent VALUES (17);


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.staff VALUES (1, 'Мусорский Владимир Гельевич', 'Хирург', 150000, 'med_staff', '2001-01-01 00:00:00');
INSERT INTO public.staff VALUES (2, 'Херсонов Шансон Максимович', 'Стоматолог', 120000, 'med_staff', '2001-02-01 00:00:00');
INSERT INTO public.staff VALUES (3, 'Жежик Василий Львович', 'Анестезиолог', 100000, 'med_staff', '2001-03-02 00:00:00');
INSERT INTO public.staff VALUES (4, 'Кеков Дамир Анатольевич', 'Педиатр', 50000, 'med_staff', '2001-01-15 00:00:00');
INSERT INTO public.staff VALUES (5, 'Жемчужина Анастасия Кирилловна', 'Хирург', 150000, 'med_staff', '2001-01-04 00:00:00');
INSERT INTO public.staff VALUES (6, 'Нестерова Василиса Петровна', 'Ренгенолог', 170000, 'med_staff', '2010-01-01 00:00:00');
INSERT INTO public.staff VALUES (7, 'Гигачад Егор Сергеевич', 'Терапевт', 2000000, 'med_staff', '2020-01-01 00:00:00');
INSERT INTO public.staff VALUES (8, 'Базированный Артем Максимович', 'Травматолог', 2000000, 'med_staff', '2020-05-01 00:00:00');
INSERT INTO public.staff VALUES (9, 'Итсвенсдеймайдюдс Валерия Александровна', 'Хирург', 2000000, 'med_staff', '2020-01-05 00:00:00');
INSERT INTO public.staff VALUES (10, 'Октябрьский Камрад Ульянович', 'Патологоанатом', 100, 'med_staff', '2001-01-23 00:00:00');
INSERT INTO public.staff VALUES (11, 'Цербер Константин Себастьянович', 'Генеколог', 10200, 'med_staff', '2001-11-01 00:00:00');
INSERT INTO public.staff VALUES (12, 'Винницский Артас Злобыч', 'Травматолог', 100000, 'med_staff', '2021-01-01 00:00:00');
INSERT INTO public.staff VALUES (13, 'Совина София Викторовна', 'Стоматолог', 120000, 'med_staff', '2001-05-01 00:00:00');
INSERT INTO public.staff VALUES (14, 'Вадимов Вадим Вадимович', 'Хирург', 100000, 'med_staff', '2001-01-21 00:00:00');
INSERT INTO public.staff VALUES (15, 'Артемов Артем Артемович', 'Терапевт', 100000, 'med_staff', '2001-01-03 00:00:00');
INSERT INTO public.staff VALUES (16, 'Максимов Максим Максимович', 'Терапевт', 100000, 'med_staff', '2001-01-04 00:00:00');
INSERT INTO public.staff VALUES (17, 'Тайцзы Ин Ян', 'Терапевт', 100000, 'med_staff', '2001-01-08 00:00:00');
INSERT INTO public.staff VALUES (18, 'Кириллов Кирилл Кириллович', 'Терапевт', 100000, 'med_staff', '2001-01-11 00:00:00');
INSERT INTO public.staff VALUES (19, 'Андреев Андрей Андреевич', 'Терапевт', 100000, 'med_staff', '2001-01-03 00:00:00');
INSERT INTO public.staff VALUES (20, 'Батоев Бато Батоевич', 'Терапевт', 100000, 'med_staff', '2001-01-06 00:00:00');
INSERT INTO public.staff VALUES (21, 'Швабрин Анатолий Максимович', 'Уборщик', 150000, 'service_staff', '2001-01-01 00:00:00');
INSERT INTO public.staff VALUES (22, 'Медбратов Медбрат Медбратович', 'Медбрат', 150000, 'service_staff', '2001-01-01 00:00:00');
INSERT INTO public.staff VALUES (23, 'Медсестрова Медсестра Медсестровна', 'Медсестра', 150000, 'service_staff', '2001-01-01 00:00:00');
INSERT INTO public.staff VALUES (24, 'Бугалтеров Бугалтер Бугалтерович', 'Бугалтер', 150000, 'service_staff', '2001-01-01 00:00:00');
INSERT INTO public.staff VALUES (25, 'Швабрина Ирина Андреевна', 'Уборщик', 150000, 'service_staff', '2001-01-01 00:00:00');


--
-- Data for Name: staff_medical_institution; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.staff_medical_institution VALUES (1, 1, 1);
INSERT INTO public.staff_medical_institution VALUES (2, 2, 2);
INSERT INTO public.staff_medical_institution VALUES (3, 3, 3);
INSERT INTO public.staff_medical_institution VALUES (4, 4, 4);
INSERT INTO public.staff_medical_institution VALUES (4, 1, 5);
INSERT INTO public.staff_medical_institution VALUES (5, 5, 6);
INSERT INTO public.staff_medical_institution VALUES (6, 6, 7);
INSERT INTO public.staff_medical_institution VALUES (7, 7, 8);
INSERT INTO public.staff_medical_institution VALUES (7, 2, 9);
INSERT INTO public.staff_medical_institution VALUES (8, 8, 10);
INSERT INTO public.staff_medical_institution VALUES (8, 3, 11);
INSERT INTO public.staff_medical_institution VALUES (9, 9, 12);
INSERT INTO public.staff_medical_institution VALUES (10, 10, 13);
INSERT INTO public.staff_medical_institution VALUES (1, 11, 14);
INSERT INTO public.staff_medical_institution VALUES (2, 12, 15);
INSERT INTO public.staff_medical_institution VALUES (3, 13, 16);
INSERT INTO public.staff_medical_institution VALUES (4, 14, 17);
INSERT INTO public.staff_medical_institution VALUES (5, 15, 18);
INSERT INTO public.staff_medical_institution VALUES (6, 16, 19);
INSERT INTO public.staff_medical_institution VALUES (7, 17, 20);
INSERT INTO public.staff_medical_institution VALUES (8, 18, 21);
INSERT INTO public.staff_medical_institution VALUES (9, 19, 22);
INSERT INTO public.staff_medical_institution VALUES (10, 20, 23);
INSERT INTO public.staff_medical_institution VALUES (11, 1, 24);
INSERT INTO public.staff_medical_institution VALUES (11, 4, 25);
INSERT INTO public.staff_medical_institution VALUES (12, 2, 26);
INSERT INTO public.staff_medical_institution VALUES (13, 3, 27);
INSERT INTO public.staff_medical_institution VALUES (14, 4, 28);
INSERT INTO public.staff_medical_institution VALUES (15, 5, 29);
INSERT INTO public.staff_medical_institution VALUES (16, 6, 30);
INSERT INTO public.staff_medical_institution VALUES (17, 7, 31);
INSERT INTO public.staff_medical_institution VALUES (18, 8, 32);
INSERT INTO public.staff_medical_institution VALUES (19, 9, 33);
INSERT INTO public.staff_medical_institution VALUES (20, 10, 34);
INSERT INTO public.staff_medical_institution VALUES (21, 1, 35);
INSERT INTO public.staff_medical_institution VALUES (21, 2, 36);
INSERT INTO public.staff_medical_institution VALUES (21, 3, 37);
INSERT INTO public.staff_medical_institution VALUES (21, 4, 38);
INSERT INTO public.staff_medical_institution VALUES (21, 5, 39);
INSERT INTO public.staff_medical_institution VALUES (21, 6, 40);
INSERT INTO public.staff_medical_institution VALUES (21, 7, 41);
INSERT INTO public.staff_medical_institution VALUES (21, 8, 42);
INSERT INTO public.staff_medical_institution VALUES (22, 11, 43);
INSERT INTO public.staff_medical_institution VALUES (22, 12, 44);
INSERT INTO public.staff_medical_institution VALUES (22, 13, 45);
INSERT INTO public.staff_medical_institution VALUES (22, 14, 46);
INSERT INTO public.staff_medical_institution VALUES (22, 15, 47);
INSERT INTO public.staff_medical_institution VALUES (22, 16, 48);
INSERT INTO public.staff_medical_institution VALUES (22, 17, 49);
INSERT INTO public.staff_medical_institution VALUES (22, 18, 50);
INSERT INTO public.staff_medical_institution VALUES (23, 15, 51);
INSERT INTO public.staff_medical_institution VALUES (23, 16, 52);
INSERT INTO public.staff_medical_institution VALUES (23, 17, 53);
INSERT INTO public.staff_medical_institution VALUES (23, 18, 54);
INSERT INTO public.staff_medical_institution VALUES (23, 19, 55);
INSERT INTO public.staff_medical_institution VALUES (24, 6, 56);
INSERT INTO public.staff_medical_institution VALUES (24, 7, 57);
INSERT INTO public.staff_medical_institution VALUES (24, 8, 58);
INSERT INTO public.staff_medical_institution VALUES (24, 9, 59);
INSERT INTO public.staff_medical_institution VALUES (24, 10, 60);
INSERT INTO public.staff_medical_institution VALUES (24, 11, 61);
INSERT INTO public.staff_medical_institution VALUES (25, 9, 62);
INSERT INTO public.staff_medical_institution VALUES (25, 10, 63);
INSERT INTO public.staff_medical_institution VALUES (25, 11, 64);


--
-- Name: analyzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.analyzes_id_seq', 1, true);


--
-- Name: building_body_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.building_body_id_seq', 1, false);


--
-- Name: cabinets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cabinets_id_seq', 15, true);


--
-- Name: department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_id_seq', 1, false);


--
-- Name: hospital_room_expiring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hospital_room_expiring_id_seq', 2, true);


--
-- Name: hospital_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hospital_room_id_seq', 1, false);


--
-- Name: lab_medical_institution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lab_medical_institution_id_seq', 30, true);


--
-- Name: laboratory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.laboratory_id_seq', 1, false);


--
-- Name: med_staff_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.med_staff_patient_id_seq', 3, true);


--
-- Name: medical_institution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medical_institution_id_seq', 1, false);


--
-- Name: patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patient_id_seq', 1, false);


--
-- Name: patient_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patient_records_id_seq', 1, true);


--
-- Name: polyclinic_fixing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.polyclinic_fixing_id_seq', 9, true);


--
-- Name: prof_or_docent_medical_institution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prof_or_docent_medical_institution_id_seq', 14, true);


--
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_id_seq', 1, false);


--
-- Name: staff_medical_institution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_medical_institution_id_seq', 64, true);


--
-- Name: analyzes analyzes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analyzes
    ADD CONSTRAINT analyzes_pk PRIMARY KEY (id);


--
-- Name: analyzes analyzes_pk_2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analyzes
    ADD CONSTRAINT analyzes_pk_2 UNIQUE (record, lab_id);


--
-- Name: building_body building_body_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_body
    ADD CONSTRAINT building_body_pkey PRIMARY KEY (id);


--
-- Name: cabinets cabinets_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cabinets
    ADD CONSTRAINT cabinets_pk PRIMARY KEY (id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- Name: hospital hospital_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital
    ADD CONSTRAINT hospital_id_key UNIQUE (id);


--
-- Name: hospital hospital_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital
    ADD CONSTRAINT hospital_name_key UNIQUE (name);


--
-- Name: hospital hospital_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital
    ADD CONSTRAINT hospital_pk PRIMARY KEY (id);


--
-- Name: hospital_room_expiring hospital_room_expiring_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital_room_expiring
    ADD CONSTRAINT hospital_room_expiring_pk PRIMARY KEY (id);


--
-- Name: hospital_room hospital_room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital_room
    ADD CONSTRAINT hospital_room_pkey PRIMARY KEY (id);


--
-- Name: lab_medical_institution lab_medical_institution_medical_institution_id_laboratory_i_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_medical_institution
    ADD CONSTRAINT lab_medical_institution_medical_institution_id_laboratory_i_key UNIQUE (medical_institution_id, laboratory_id);


--
-- Name: lab_medical_institution lab_medical_institution_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_medical_institution
    ADD CONSTRAINT lab_medical_institution_pk PRIMARY KEY (id);


--
-- Name: laboratory laboratory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laboratory
    ADD CONSTRAINT laboratory_pkey PRIMARY KEY (id);


--
-- Name: med_staff med_staff_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.med_staff
    ADD CONSTRAINT med_staff_id_key UNIQUE (id);


--
-- Name: med_staff_patient med_staff_patient_med_staff_id_patient_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.med_staff_patient
    ADD CONSTRAINT med_staff_patient_med_staff_id_patient_id_key UNIQUE (med_staff_id, patient_id);


--
-- Name: med_staff_patient med_staff_patient_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.med_staff_patient
    ADD CONSTRAINT med_staff_patient_pk PRIMARY KEY (id);


--
-- Name: med_staff med_staff_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.med_staff
    ADD CONSTRAINT med_staff_pk PRIMARY KEY (id);


--
-- Name: medical_institution medical_institution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_institution
    ADD CONSTRAINT medical_institution_pkey PRIMARY KEY (id);


--
-- Name: operation_staff operation_staff_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operation_staff
    ADD CONSTRAINT operation_staff_id_key UNIQUE (id);


--
-- Name: operation_staff operation_staff_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operation_staff
    ADD CONSTRAINT operation_staff_pk PRIMARY KEY (id);


--
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (id);


--
-- Name: patient_records patient_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_records
    ADD CONSTRAINT patient_records_pkey PRIMARY KEY (id);


--
-- Name: polyclinic_fixing polyclinic_fixing_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polyclinic_fixing
    ADD CONSTRAINT polyclinic_fixing_pk PRIMARY KEY (id);


--
-- Name: polyclinic_fixing polyclinic_fixing_polyclinic_id_hospital_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polyclinic_fixing
    ADD CONSTRAINT polyclinic_fixing_polyclinic_id_hospital_id_key UNIQUE (polyclinic_id, hospital_id);


--
-- Name: polyclinic polyclinic_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polyclinic
    ADD CONSTRAINT polyclinic_id_key UNIQUE (id);


--
-- Name: polyclinic polyclinic_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polyclinic
    ADD CONSTRAINT polyclinic_name_key UNIQUE (name);


--
-- Name: polyclinic polyclinic_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polyclinic
    ADD CONSTRAINT polyclinic_pk PRIMARY KEY (id);


--
-- Name: prof_or_docent_medical_institution prof_or_docent_medical_instit_prof_or_docent_id_medical_ins_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prof_or_docent_medical_institution
    ADD CONSTRAINT prof_or_docent_medical_instit_prof_or_docent_id_medical_ins_key UNIQUE (prof_or_docent_id, medical_institution_id);


--
-- Name: prof_or_docent_medical_institution prof_or_docent_medical_institution_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prof_or_docent_medical_institution
    ADD CONSTRAINT prof_or_docent_medical_institution_pk PRIMARY KEY (id);


--
-- Name: professor_or_docent professor_or_docent_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professor_or_docent
    ADD CONSTRAINT professor_or_docent_id_key UNIQUE (id);


--
-- Name: professor_or_docent professor_or_docent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professor_or_docent
    ADD CONSTRAINT professor_or_docent_pk PRIMARY KEY (id);


--
-- Name: staff_medical_institution staff_medical_institution_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_medical_institution
    ADD CONSTRAINT staff_medical_institution_pk PRIMARY KEY (id);


--
-- Name: staff_medical_institution staff_medical_institution_pk_2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_medical_institution
    ADD CONSTRAINT staff_medical_institution_pk_2 UNIQUE (staff_id, medical_institution_id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: analyzes_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX analyzes_id_uindex ON public.analyzes USING btree (id);


--
-- Name: cabinets_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cabinets_id_uindex ON public.cabinets USING btree (id);


--
-- Name: hospital_room_expiring_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX hospital_room_expiring_id_uindex ON public.hospital_room_expiring USING btree (id);


--
-- Name: hospital_room_expiring_record_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX hospital_room_expiring_record_uindex ON public.hospital_room_expiring USING btree (record);


--
-- Name: lab_medical_institution_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX lab_medical_institution_id_uindex ON public.lab_medical_institution USING btree (id);


--
-- Name: med_staff_patient_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX med_staff_patient_id_uindex ON public.med_staff_patient USING btree (id);


--
-- Name: polyclinic_fixing_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX polyclinic_fixing_id_uindex ON public.polyclinic_fixing USING btree (id);


--
-- Name: prof_or_docent_medical_institution_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX prof_or_docent_medical_institution_id_uindex ON public.prof_or_docent_medical_institution USING btree (id);


--
-- Name: staff_medical_institution_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX staff_medical_institution_id_uindex ON public.staff_medical_institution USING btree (id);


--
-- Name: analyzes analyzes_lab_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analyzes
    ADD CONSTRAINT analyzes_lab_id_fkey FOREIGN KEY (lab_id) REFERENCES public.laboratory(id);


--
-- Name: analyzes analyzes_record_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analyzes
    ADD CONSTRAINT analyzes_record_fkey FOREIGN KEY (record) REFERENCES public.patient_records(id);


--
-- Name: cabinets cabinets_polyclinic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cabinets
    ADD CONSTRAINT cabinets_polyclinic_id_fkey FOREIGN KEY (polyclinic_id) REFERENCES public.polyclinic(id);


--
-- Name: department department_building_body_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_building_body_id_fkey FOREIGN KEY (building_body_id) REFERENCES public.building_body(id);


--
-- Name: hospital hospital_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital
    ADD CONSTRAINT hospital_id_fkey FOREIGN KEY (id) REFERENCES public.medical_institution(id);


--
-- Name: hospital_room hospital_room_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital_room
    ADD CONSTRAINT hospital_room_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: lab_medical_institution lab_medical_institution_laboratory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_medical_institution
    ADD CONSTRAINT lab_medical_institution_laboratory_id_fkey FOREIGN KEY (laboratory_id) REFERENCES public.laboratory(id);


--
-- Name: lab_medical_institution lab_medical_institution_medical_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_medical_institution
    ADD CONSTRAINT lab_medical_institution_medical_institution_id_fkey FOREIGN KEY (medical_institution_id) REFERENCES public.medical_institution(id);


--
-- Name: med_staff med_staff_hospital_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.med_staff
    ADD CONSTRAINT med_staff_hospital_id_fkey FOREIGN KEY (hospital_id) REFERENCES public.hospital(id);


--
-- Name: med_staff med_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.med_staff
    ADD CONSTRAINT med_staff_id_fkey FOREIGN KEY (id) REFERENCES public.staff(id);


--
-- Name: med_staff_patient med_staff_patient_med_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.med_staff_patient
    ADD CONSTRAINT med_staff_patient_med_staff_id_fkey FOREIGN KEY (med_staff_id) REFERENCES public.med_staff(id);


--
-- Name: med_staff_patient med_staff_patient_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.med_staff_patient
    ADD CONSTRAINT med_staff_patient_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(id);


--
-- Name: med_staff med_staff_polyclinic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.med_staff
    ADD CONSTRAINT med_staff_polyclinic_id_fkey FOREIGN KEY (polyclinic_id) REFERENCES public.polyclinic(id);


--
-- Name: operation_staff operation_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operation_staff
    ADD CONSTRAINT operation_staff_id_fkey FOREIGN KEY (id) REFERENCES public.med_staff(id);


--
-- Name: patient_records patient_records_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_records
    ADD CONSTRAINT patient_records_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.med_staff(id);


--
-- Name: patient_records patient_records_hospital_room_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_records
    ADD CONSTRAINT patient_records_hospital_room_id_fk FOREIGN KEY (hospital_room_id) REFERENCES public.hospital_room(id);


--
-- Name: patient_records patient_records_medical_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_records
    ADD CONSTRAINT patient_records_medical_institution_id_fkey FOREIGN KEY (medical_institution_id) REFERENCES public.medical_institution(id);


--
-- Name: patient_records patient_records_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_records
    ADD CONSTRAINT patient_records_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(id);


--
-- Name: polyclinic_fixing polyclinic_fixing_hospital_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polyclinic_fixing
    ADD CONSTRAINT polyclinic_fixing_hospital_id_fkey FOREIGN KEY (hospital_id) REFERENCES public.hospital(id);


--
-- Name: polyclinic_fixing polyclinic_fixing_polyclinic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polyclinic_fixing
    ADD CONSTRAINT polyclinic_fixing_polyclinic_id_fkey FOREIGN KEY (polyclinic_id) REFERENCES public.polyclinic(id);


--
-- Name: polyclinic polyclinic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polyclinic
    ADD CONSTRAINT polyclinic_id_fkey FOREIGN KEY (id) REFERENCES public.medical_institution(id);


--
-- Name: prof_or_docent_medical_institution prof_or_docent_medical_institution_medical_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prof_or_docent_medical_institution
    ADD CONSTRAINT prof_or_docent_medical_institution_medical_institution_id_fkey FOREIGN KEY (medical_institution_id) REFERENCES public.medical_institution(id);


--
-- Name: prof_or_docent_medical_institution prof_or_docent_medical_institution_prof_or_docent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prof_or_docent_medical_institution
    ADD CONSTRAINT prof_or_docent_medical_institution_prof_or_docent_id_fkey FOREIGN KEY (prof_or_docent_id) REFERENCES public.professor_or_docent(id);


--
-- Name: professor_or_docent professor_or_docent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professor_or_docent
    ADD CONSTRAINT professor_or_docent_id_fkey FOREIGN KEY (id) REFERENCES public.med_staff(id);


--
-- Name: staff_medical_institution staff_medical_institution_medical_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_medical_institution
    ADD CONSTRAINT staff_medical_institution_medical_institution_id_fkey FOREIGN KEY (medical_institution_id) REFERENCES public.medical_institution(id);


--
-- Name: staff_medical_institution staff_medical_institution_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_medical_institution
    ADD CONSTRAINT staff_medical_institution_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(id);


--
-- PostgreSQL database dump complete
--

