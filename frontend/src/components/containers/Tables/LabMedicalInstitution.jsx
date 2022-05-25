import TableTemplate from "./TableTemplate";


function LabMedicalInstitution() {
    const fields = ["id", "medicalInstitutionId", "laboratoryId"];
    const type = {"id": "number", "medicalInstitutionId": "number", "laboratoryId": "number"};
    const relatedTables = ["MedicalInstitution", "Laboratory"];
    const fieldsUrl = {"medicalInstitutionId": "medicalInstitution", "laboratoryId": "laboratory"};
    return <TableTemplate url = "labMedicalInstitution" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default LabMedicalInstitution;