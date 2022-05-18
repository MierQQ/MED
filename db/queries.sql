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
                date date,
                visit integer
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT patient.id, patient.name, pr.data, pr.date::date, pr.grouping
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
        FROM patient p inner join public.patient_records pr on p.id = pr.patient_id join hospital_room_expiring hre on hre.record = pr.grouping join hospital h on pr.medical_institution_id = h.id
        where   ((pr.date between startDate and endDate) or (hre.date between startDate and endDate) or (pr.date < startDate and hre.date > endDate)) and
                ((cardinality(institutionIds) != 0 AND pr.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0)) AND
                ((cardinality(medStaffIds) != 0 AND pr.doctor_id = ANY(medStaffIds)) OR (cardinality(medStaffIds) = 0))
        ORDER BY p.id;
END
$$ LANGUAGE plpgsql;

--8th
DROP FUNCTION find_patient_by_specialization(VARCHAR[], integer[]);
CREATE OR REPLACE FUNCTION find_patient_by_specialization(specializations varchar[], institutionIds integer[])
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
        FROM patient p join med_staff_patient msp on p.id = msp.patient_id join staff s on s.id = msp.med_staff_id join staff_medical_institution smi on s.id = smi.staff_id
        where   ((cardinality(specializations) != 0 AND s.specialization = ANY(specializations)) OR (cardinality(specializations) = 0)) and
                ((cardinality(institutionIds) != 0 AND smi.medical_institution_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0))
        ORDER BY p.id;
END
$$ LANGUAGE plpgsql;

--9th
DROP FUNCTION get_number_of_hospital_room(integer[]);
CREATE OR REPLACE FUNCTION get_number_of_hospital_room(hospitalIds integer[])
    RETURNS TABLE
        (
            count INTEGER
        )
AS
$$
BEGIN
    RETURN QUERY
        SELECT count(hr.id)::INTEGER
        FROM hospital_room hr join department d on hr.department_id = d.id join building_body bb on d.building_body_id = bb.id
        join hospital h on (bb.hospital_id = h.id and ((cardinality(hospitalIds) != 0 AND h.id = ANY(hospitalIds)) OR (cardinality(hospitalIds) = 0)));
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_number_of_hospital_room_beds(integer[]);
CREATE OR REPLACE FUNCTION get_number_of_hospital_room_beds(hospitalIds integer[])
    RETURNS TABLE
        (
            count INTEGER
        )
AS
$$
BEGIN
    RETURN QUERY
        SELECT sum(hr.bed_number)::INTEGER
        FROM hospital_room hr join department d on hr.department_id = d.id join building_body bb on d.building_body_id = bb.id
        join hospital h on (bb.hospital_id = h.id and ((cardinality(hospitalIds) != 0 AND h.id = ANY(hospitalIds)) OR (cardinality(hospitalIds) = 0)));
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_number_of_hospital_room_by_departments(integer[]);
CREATE OR REPLACE FUNCTION get_number_of_hospital_room_by_departments(hospitalIds integer[])
    RETURNS TABLE
        (
            departmentId INTEGER,
            count INTEGER
        )
AS
$$
BEGIN
    RETURN QUERY
        SELECT d.id, count(hr.id)::INTEGER
        FROM hospital_room hr join department d on hr.department_id = d.id join building_body bb on d.building_body_id = bb.id
        join hospital h on (bb.hospital_id = h.id and ((cardinality(hospitalIds) != 0 AND h.id = ANY(hospitalIds)) OR (cardinality(hospitalIds) = 0)))
        group by d.id
        ORDER BY d.id;
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_number_of_hospital_room_beds_by_departments(integer[]);
CREATE OR REPLACE FUNCTION get_number_of_hospital_room_beds_by_departments(hospitalIds integer[])
    RETURNS TABLE
        (
            departmentId INTEGER,
            count INTEGER
        )
AS
$$
BEGIN
    RETURN QUERY
        SELECT d.id, sum(hr.bed_number)::INTEGER
        FROM hospital_room hr join department d on hr.department_id = d.id join building_body bb on d.building_body_id = bb.id
        join hospital h on (bb.hospital_id = h.id and ((cardinality(hospitalIds) != 0 AND h.id = ANY(hospitalIds)) OR (cardinality(hospitalIds) = 0)))
        group by d.id
        ORDER BY d.id;
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_number_of_free_hospital_room_by_departments(integer[]);
CREATE OR REPLACE FUNCTION get_number_of_free_hospital_room_by_departments(hospitalIds integer[])
    RETURNS TABLE
        (
            departmentId INTEGER,
            count INTEGER
        )
AS
$$
BEGIN
    RETURN QUERY
        SELECT jjj.id, sum(jjj.flagIsNull)::INTEGER
        from (SELECT d.id id, (prid.hospital_room_id is null)::integer flagIsNull
        FROM hospital_room join department d on hospital_room.department_id = d.id join building_body bb on d.building_body_id = bb.id join hospital h on (bb.hospital_id = h.id and ((cardinality(hospitalIds) != 0 AND h.id = ANY(hospitalIds)) OR (cardinality(hospitalIds) = 0)))
            left join
            (
                select distinct pr.hospital_room_id
                from patient_records pr join hospital_room_expiring hre on pr.grouping = hre.record
                where current_date < hre.date
            ) prid on hospital_room.id = prid.hospital_room_id) jjj
        group by jjj.id
        ORDER BY jjj.id;
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_number_of_free_hospital_room_beds_by_departments(integer[]);
CREATE OR REPLACE FUNCTION get_number_of_free_hospital_room_beds_by_departments(hospitalIds integer[])
    RETURNS TABLE
        (
            departmentId INTEGER,
            count INTEGER
        )
AS
$$
BEGIN
    RETURN QUERY
        SELECT d.id, (sum(hospital_room.bed_number) - count(hre.record))::INTEGER
        FROM hospital_room join department d on hospital_room.department_id = d.id join building_body bb on d.building_body_id = bb.id join hospital h on (bb.hospital_id = h.id and ((cardinality(hospitalIds) != 0 AND h.id = ANY(hospitalIds)) OR (cardinality(hospitalIds) = 0)))
        left join
        patient_records pr on hospital_room.id = pr.hospital_room_id left join hospital_room_expiring hre on (pr.grouping = hre.record and hre.date > current_date)
        where pr.type = 'visit' or pr.type is null
        group by d.id
        ORDER BY d.id;
END
$$ LANGUAGE plpgsql;
--10th

DROP FUNCTION get_count_of_cabinets(INTEGER[]);
CREATE OR REPLACE FUNCTION get_count_of_cabinets(
    institutionIds INTEGER[])
    RETURNS TABLE
            (
                count INTEGER
            )
AS
$$
BEGIN
    RETURN QUERY
        SELECT count(*)::INTEGER as count
        FROM cabinets as c
        where  ((cardinality(institutionIds) != 0 AND c.polyclinic_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0));
END
$$ LANGUAGE plpgsql;

DROP FUNCTION get_count_of_cabinets_usage(integer[], date, date);
CREATE OR REPLACE FUNCTION get_count_of_cabinets_usage(
    institutionIds integer[], startDate date, endDate date)
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
        select c.id, c.number, sum(flag)::integer
        from cabinets c join
        (SELECT c.id id, ((pr.id is not null) and pr.type = 'visit' and pr.date between startDate and endDate)::integer flag
        FROM cabinets c left join patient_records pr on (c.id = pr.cabinet)) cc on c.id = cc.id
        where ((cardinality(institutionIds) != 0 AND c.polyclinic_id = ANY(institutionIds)) OR (cardinality(institutionIds) = 0))
        group by c.id, c.number
        order by c.id;
END
$$ LANGUAGE plpgsql;

--11th

DROP FUNCTION get_productivity_polyclinic(date, date, INTEGER[], varchar[], INTEGER[]);
CREATE OR REPLACE FUNCTION get_productivity_polyclinic(startDate date, endDate date, doctorIds INTEGER[], specializations varchar[], polyclinicIds INTEGER[])
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
              ((cardinality(specializations)!=0 AND s.specialization = ANY(specializations)) OR cardinality(specializations)=0) and
              ((cardinality(polyclinicIds)!=0 AND pr.medical_institution_id = ANY(polyclinicIds)) OR cardinality(polyclinicIds)=0)
        GROUP BY s.id, s.name
        ORDER BY s.id;
END
$$ LANGUAGE plpgsql;

--12th

DROP FUNCTION get_productivity_hospital(INTEGER[], varchar[], INTEGER[]);
CREATE OR REPLACE FUNCTION get_productivity_hospital(doctorIds INTEGER[], specializations varchar[], hospitalIds INTEGER[])
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
        SELECT s.id, s.name, count(hre.id)::DOUBLE PRECISION
        FROM staff s join med_staff ms on s.id = ms.id join staff_medical_institution smi
            on (s.id = smi.staff_id and
                ((cardinality(specializations)!=0 AND s.specialization = ANY(specializations)) OR cardinality(specializations)=0) and
                ((cardinality(hospitalIds)!=0 AND smi.medical_institution_id = ANY(hospitalIds)) OR cardinality(hospitalIds)=0)) left join
                (patient_records pr join hospital_room_expiring hre on
                (pr.grouping = hre.record and hre.date > current_date and pr.type = 'visit') and ((cardinality(doctorIds)!=0 AND pr.doctor_id = ANY(doctorIds)) OR cardinality(doctorIds)=0)) on s.id = pr.doctor_id and pr.medical_institution_id = smi.medical_institution_id

        GROUP BY s.id, s.name
        ORDER BY s.id;
END
$$ LANGUAGE plpgsql;

--13th

DROP FUNCTION get_surgeon_patients(date, date, INTEGER[], INTEGER[]);
CREATE OR REPLACE FUNCTION get_surgeon_patients(startDate date, endDate date,doctorIds INTEGER[], medIds INTEGER[])
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
        WHERE pr.type = 'operaton' and pr.date between startDate and endDate and
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
              ((cardinality(medIds)!=0 AND lmi.medical_institution_id = ANY(medIds)) OR cardinality(medIds)= 0)
        group by l.id;
END
$$ LANGUAGE plpgsql;