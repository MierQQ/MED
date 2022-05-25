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
    const relatedTables = ["StaffId", "MedicalInstitution"];
    return <TableTemplate url = "staffMedicalInstitution" fields = {fields} type = {type} relatedTables={relatedTables}/>;
}

export default StaffMedicalInstitution;