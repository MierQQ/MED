import TableTemplate from "./TableTemplate";


function ProfOrDocentMedicalInstitution() {
    const fields =
        [
            "id",
            "profOrDocentId",
            "medicalInstitutionId",
        ];
    return <TableTemplate url = "profOrDocentMedicalInstitution" fields = {fields}/>;
}

export default ProfOrDocentMedicalInstitution;