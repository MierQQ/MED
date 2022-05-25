import TableTemplate from "./TableTemplate";


function StaffMedicalInstitution() {
    const fields =
        [
            "id",
            "staffId",
            "medicalInstitutionId",
        ];
    const type =
        {
            "id": "number",
            "staffId": "number",
            "medicalInstitutionId": "number"
        };
    const relatedTables = ["Staff", "MedicalInstitution"];
    const fieldsUrl = {"staffId": "staff", "medicalInstitutionId": "medicalInstitution"};
    return <TableTemplate url = "staffMedicalInstitution" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl}/>;
}

export default StaffMedicalInstitution;