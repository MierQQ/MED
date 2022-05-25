import TableTemplate from "./TableTemplate";


function MedStaffPatient() {
    const fields = ["id", "medStaffId", "patientId"];
    const type = {"id": "number", "medStaffId": "number", "patientId": "number"};
    const relatedTables = ["MedStaff", "Patient"];
    return <TableTemplate url = "medStaffPatient" fields = {fields} type = {type} relatedTables={relatedTables}/>;
}

export default MedStaffPatient;