-- First option
DROP FUNCTION find_med_staff(integer[], VARCHAR[]);
CREATE OR REPLACE FUNCTION find_med_staff(
    institutionIds INTEGER[], specializations VARCHAR[])
    RETURNS TABLE
            (
                name            VARCHAR,
                id              INTEGER,
                specialization  VARCHAR,
                salary          INTEGER
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT DISTINCT s.name, m.id, s.specialization, s.salary
        FROM med_staff m inner join staff s on s.id = m.id inner join staff_medical_institution smi on m.id = smi.staff_id
        where   ((cardinality(institutionIds) != 0 AND smi.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
            ((cardinality(specializations) != 0 AND s.specialization = ANY(specializations)) OR (cardinality(specializations) = 0))
        ORDER BY m.id;
END
$$ LANGUAGE plpgsql;

--Second option
DROP FUNCTION find_service_staff(integer[], VARCHAR[]);
CREATE OR REPLACE FUNCTION find_service_staff(
    institutionIds INTEGER[], specializations VARCHAR[])
    RETURNS TABLE
            (
                name            VARCHAR,
                id              INTEGER,
                specialization  VARCHAR,
                salary          INTEGER
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT DISTINCT s.name, s.id, s.specialization, s.salary
        FROM staff s inner join staff_medical_institution smi on s.id = smi.staff_id
        where   s.type = 'service_staff' and
                ((cardinality(institutionIds) != 0 AND smi.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
                ((cardinality(specializations) != 0 AND s.specialization = ANY(specializations)) OR (cardinality(specializations) = 0))
        ORDER BY s.id;
END
$$ LANGUAGE plpgsql;

--3rd option
DROP FUNCTION find_med_staff_with_operations(integer[], VARCHAR[], INTEGER);
CREATE OR REPLACE FUNCTION find_med_staff_with_operations(
    institutionIds INTEGER[], specializations VARCHAR[], surgeriesNumber INTEGER)
    RETURNS TABLE
            (
                name            VARCHAR,
                id              INTEGER,
                specialization  VARCHAR,
                salary          INTEGER
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT DISTINCT s.name, m.id, s.specialization, s.salary
        FROM operation_staff os inner join med_staff m on m.id = os.id inner join staff s on s.id = m.id inner join staff_medical_institution smi on m.id = smi.staff_id
        where   os.num_of_surgeries > surgeriesNumber and
                ((cardinality(institutionIds) != 0 AND smi.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
                ((cardinality(specializations) != 0 AND s.specialization = ANY(specializations)) OR (cardinality(specializations) = 0))
        ORDER BY m.id;
END
$$ LANGUAGE plpgsql;

--4th option
DROP FUNCTION find_med_staff_with_standing(integer[], VARCHAR[], INTERVAL);
CREATE OR REPLACE FUNCTION find_med_staff_with_standing(
    institutionIds INTEGER[], specializations VARCHAR[], standing INTERVAL)
    RETURNS TABLE
            (
                name            VARCHAR,
                id              INTEGER,
                specialization  VARCHAR,
                salary          INTEGER
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT DISTINCT s.name, m.id, s.specialization, s.salary
        FROM med_staff m inner join staff s on s.id = m.id inner join staff_medical_institution smi on m.id = smi.staff_id
        where   current_date - s.employment_date > standing and
                ((cardinality(institutionIds) != 0 AND smi.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
                ((cardinality(specializations) != 0 AND s.specialization = ANY(specializations)) OR (cardinality(specializations) = 0))
        ORDER BY m.id;
END
$$ LANGUAGE plpgsql;

--5th
DROP FUNCTION find_med_staff_with_regalia(integer[], VARCHAR[]);
CREATE OR REPLACE FUNCTION find_med_staff_with_regalia(
    institutionIds INTEGER[], specializations VARCHAR[])
    RETURNS TABLE
            (
                name            VARCHAR,
                id              INTEGER,
                specialization  VARCHAR,
                salary          INTEGER
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT DISTINCT s.name, m.id, s.specialization, s.salary
        FROM med_staff m inner join staff s on s.id = m.id inner join staff_medical_institution smi on m.id = smi.staff_id
        where   (m.phd or m.professor or m.docent or m.condidate_degree) and
                ((cardinality(institutionIds) != 0 AND smi.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
                ((cardinality(specializations) != 0 AND s.specialization = ANY(specializations)) OR (cardinality(specializations) = 0))
        ORDER BY m.id;
END
$$ LANGUAGE plpgsql;

--6th

DROP FUNCTION find_patients_hospital(integer[], integer[], integer[]);
CREATE OR REPLACE FUNCTION find_patients_hospital(
    hospitalIds INTEGER[], departmentIds INTEGER[], hospitalRoomIds INTEGER[])
    RETURNS TABLE
            (
                id integer,
                name varchar,
                data varchar,
                date date
            )
AS
$$
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
$$ LANGUAGE plpgsql;

--7th
DROP FUNCTION find_patient_between_date(INTEGER[], integer[], date, date);
CREATE OR REPLACE FUNCTION find_patient_between_date(
    institutionIds INTEGER[], medStaffIds integer[], startDate date, endDate date)
    RETURNS TABLE
            (
                name            VARCHAR,
                id              INTEGER
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT DISTINCT p.name, p.id
        FROM patient p inner join public.patient_records pr on p.id = pr.patient_id
        where   (pr.data between startDate and endDate) and
                ((cardinality(institutionIds) != 0 AND pr.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
                ((cardinality(medStaffIds) != 0 AND pr.doctor_id = ANY(medStaffIds)) OR (cardinality(medStaffIds) = 0))
        ORDER BY p.id;
END
$$ LANGUAGE plpgsql;

--8th
DROP FUNCTION find_patient_between_date(VARCHAR[], integer[]);
CREATE OR REPLACE FUNCTION find_patient_between_date(specializations varchar[], institutionIds integer[])
    RETURNS TABLE
            (
                name            VARCHAR,
                id              INTEGER
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT DISTINCT p.name, p.id
        FROM patient p inner join patient_records pr on p.id = pr.patient_id inner join staff s on s.id = pr.doctor_id
        where   ((cardinality(specializations) != 0 AND s.specialization = ANY(specialization)) OR (cardinality(specialization) = 0)) and
                ((cardinality(institutionIds) != 0 AND pr.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0))
        ORDER BY p.id;
END
$$ LANGUAGE plpgsql;

--9th
DROP FUNCTION get_number_of_hospital_room();
CREATE OR REPLACE FUNCTION get_number_of_hospital_room()
    RETURNS TABLE
        (
            count INTEGER
        )
AS
$$
BEGIN
    RETURN QUERY
        SELECT count(hospital_room.id)
        FROM hospital_room;
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_number_of_hospital_room_beds();
CREATE OR REPLACE FUNCTION get_number_of_hospital_room_beds()
    RETURNS TABLE
        (
            count INTEGER
        )
AS
$$
BEGIN
    RETURN QUERY
        SELECT sum(hospital_room.bed_number)
        FROM hospital_room;
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_number_of_hospital_room_by_departments();
CREATE OR REPLACE FUNCTION get_number_of_hospital_room_by_departments()
    RETURNS TABLE
        (
            departmentId INTEGER,
            count INTEGER
        )
AS
$$
BEGIN
    RETURN QUERY
        SELECT d.id, count(hospital_room.id)
        FROM hospital_room join department d on hospital_room.department_id = d.id
        group by d.id;
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_number_of_hospital_room_beds_by_departments();
CREATE OR REPLACE FUNCTION get_number_of_hospital_room_beds_by_departments()
    RETURNS TABLE
        (
            departmentId INTEGER,
            count INTEGER
        )
AS
$$
BEGIN
    RETURN QUERY
        SELECT d.id, sum(hospital_room.bed_number)
        FROM hospital_room join department d on hospital_room.department_id = d.id
        group by d.id;
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_number_of_free_hospital_room_by_departments();
CREATE OR REPLACE FUNCTION get_number_of_free_hospital_room_by_departments()
    RETURNS TABLE
        (
            departmentId INTEGER,
            count INTEGER
        )
AS
$$
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
$$ LANGUAGE plpgsql;

DROP FUNCTION get_number_of_free_hospital_room_beds_by_departments();
CREATE OR REPLACE FUNCTION get_number_of_free_hospital_room_beds_by_departments()
    RETURNS TABLE
        (
            departmentId INTEGER,
            count INTEGER
        )
AS
$$
BEGIN
    RETURN QUERY
        SELECT d.id, sum(hospital_room.bed_number) - count(pr.id)
        FROM hospital_room join department d on hospital_room.department_id = d.id left join
        patient_records pr on hospital_room.id = pr.hospital_room_id left join hospital_room_expiring hre on pr.grouping = hre.record
        where hre.date is null or hre.date > current_date
        group by d.id;
END
$$ LANGUAGE plpgsql;
--10th

DROP FUNCTION get_count_of_cabinets(INTEGER[]);
CREATE OR REPLACE FUNCTION get_count_of_cabinets(
    institution_ids INTEGER[])
    RETURNS TABLE
            (
                count INTEGER
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT count(*) as count
        FROM cabinets as c
        where  ((cardinality(institution_ids) != 0 AND c.polyclinic_id = ANY(institution_ids)) OR (cardinality(institution_ids) = 0));
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_count_of_cabinets_usage(date, date);
CREATE OR REPLACE FUNCTION get_count_of_cabinets_usage(
    startDate date, endDate date)
    RETURNS TABLE
            (
                id integer,
                number integer,
                count integer
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT c.id, c.number, count(pr.grouping)
        FROM cabinets c left join patient_records pr on c.id = pr.cabinet
        where (pr.type = 'visit' and pr.date between startDate and endDate) or (pr.type is NULL)
        group by c.id
        ORDER BY c.id;

END
$$ LANGUAGE plpgsql;

--11th

DROP FUNCTION get_productivity_polyclinic(date, date, INTEGER[], varchar[], INTEGER[]);
CREATE OR REPLACE FUNCTION get_productivity_polyclinic(startDate date, endDate date, doctorIds INTEGER[], specializationIds varchar[], polyclinicIds INTEGER[])
    RETURNS TABLE
            (
            id INTEGER,
            name VARCHAR,
            productivity DOUBLE PRECISION
            )
AS
$$
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
$$ LANGUAGE plpgsql;

--12th

DROP FUNCTION get_productivity_hospital(date, date, INTEGER[], varchar[], INTEGER[]);
CREATE OR REPLACE FUNCTION get_productivity_hospital(startDate date, endDate date, doctorIds INTEGER[], specializationIds varchar[], hospitalIds INTEGER[])
    RETURNS TABLE
            (
            id INTEGER,
            name VARCHAR,
            productivity DOUBLE PRECISION
            )
AS
$$
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
$$ LANGUAGE plpgsql;

--13th

DROP FUNCTION get_surgeon_patients(INTEGER[], INTEGER[]);
CREATE OR REPLACE FUNCTION get_surgeon_patients(doctorIds INTEGER[], medIds INTEGER[])
    RETURNS TABLE
            (
            id INTEGER,
            name VARCHAR
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT p.id, p.name
        FROM patient_records pr join patient p on pr.patient_id = p.id
        WHERE pr.type = 'operaton' and
              ((cardinality(doctorIds)!=0 AND pr.doctor_id = ANY(doctorIds)) OR cardinality(doctorIds)=0) and
              ((cardinality(medIds)!=0 AND pr.medical_institution_id = ANY(medIds)) OR cardinality(medIds)=0);
END
$$ LANGUAGE plpgsql;

--14th

DROP FUNCTION get_lab_productivity(date, date, INTEGER[]);
CREATE OR REPLACE FUNCTION get_lab_productivity(startDate date, endDate date, medIds INTEGER[])
    RETURNS TABLE
            (
            id INTEGER,
            productivity DOUBLE PRECISION
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT l.id, (count(pr.id)::DOUBLE PRECISION / (endDate - startDate)::DOUBLE PRECISION)
        FROM laboratory l join lab_medical_institution lmi on l.id = lmi.laboratory_id left join analyzes a on l.id = a.lab_id left join patient_records pr on a.record = pr.id
        WHERE pr.date between startDate and endDate and
              ((cardinality(medIds)!=0 AND lmi.medical_institution_id = ANY(medIds)) OR cardinality(medIds)=0)
        group by l.id;
END
$$ LANGUAGE plpgsql;