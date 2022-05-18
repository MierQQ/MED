import TableTemplate from "./TableTemplate";


function MedStaffPatient() {
    const fields = ["id", "medStaffId", "patientId"];
    return <TableTemplate url = "medStaffPatient" fields = {fields}/>;
}

export default MedStaffPatient;