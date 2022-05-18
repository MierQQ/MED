import TableTemplate from "./TableTemplate";

function MedicalInstitution() {
    const fields = ["id"];
    return <TableTemplate url = "medicalInstitution" fields = {fields}/>;
}

export default MedicalInstitution;