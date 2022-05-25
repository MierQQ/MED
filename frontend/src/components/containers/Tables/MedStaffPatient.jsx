import TableTemplate from "./TableTemplate";


function MedStaffPatient() {
    const fields = ["id", "medStaffId", "patientId"];
    const type = {"id": "number", "medStaffId": "number", "patientId": "number"};
    const relatedTables = ["MedStaff", "Patient"];
    const fieldsUrl = {"medStaffId": "medStaff", "patientId": "patient"};
    return <TableTemplate url = "medStaffPatient" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default MedStaffPatient;