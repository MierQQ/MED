import TableTemplate from "./TableTemplate";


function PatientRecords() {
    const fields =
        [
            "id",
            "patientId",
            "medicalInstitutionId",
            "data",
            "type",
            "date",
            "doctorId",
            "hospitalRoomId",
            "cabinet",
            "grouping",
        ];
    return <TableTemplate url = "patientRecords" fields = {fields}/>;
}

export default PatientRecords;