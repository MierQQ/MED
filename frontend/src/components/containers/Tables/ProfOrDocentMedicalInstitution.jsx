import TableTemplate from "./TableTemplate";


function ProfOrDocentMedicalInstitution() {
    const fields =
        [
            "id",
            "profOrDocentId",
            "medicalInstitutionId",
        ];
    const type =
        {
            "id": "number",
            "profOrDocentId": "number",
            "medicalInstitutionId": "number"
        };
    const relatedTables = ["ProfessorOrDocent", "MedicalInstitution"];
    return <TableTemplate url = "profOrDocentMedicalInstitution" fields = {fields} type = {type} relatedTables={relatedTables}/>;
}

export default ProfOrDocentMedicalInstitution;