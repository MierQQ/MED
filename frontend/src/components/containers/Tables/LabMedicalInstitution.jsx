import TableTemplate from "./TableTemplate";


function LabMedicalInstitution() {
    const fields = ["id", "medicalInstitutionId", "laboratoryId"];
    return <TableTemplate url = "labMedicalInstitution" fields = {fields}/>;
}

export default LabMedicalInstitution;