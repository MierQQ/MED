import TableTemplate from "./TableTemplate";


function StaffMedicalInstitution() {
    const fields =
        [
            "id",
            "staffId",
            "medicalInstitutionId",
        ];
    return <TableTemplate url = "staffMedicalInstitution" fields = {fields}/>;
}

export default StaffMedicalInstitution;