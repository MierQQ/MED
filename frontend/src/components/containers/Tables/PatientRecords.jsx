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
    const type =
        {
            "id": "number",
            "patientId": "number",
            "medicalInstitutionId": "number",
            "data": "text",
            "type": "text",
            "date": "date",
            "doctorId": "number",
            "hospitalRoomId": "number",
            "cabinet": "number",
            "grouping": "number",
        };
    const relatedTables = ["Patient", "MedicalInstitution", "MedStaff", "HospitalRoom", "Cabinets", "HospitalRoomExpiring"];
    const fieldsUrl = {"patientId": "patient", "medicalInstitutionId": "medicalInstitution", "doctorId": "medStaff",
        "hospitalRoomId": "hospitalRoom", "cabinet": "cabinets"};
    return <TableTemplate url = "patientRecords" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default PatientRecords;