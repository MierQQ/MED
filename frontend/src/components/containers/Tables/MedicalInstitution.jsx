import TableTemplate from "./TableTemplate";

function MedicalInstitution() {
    const fields = ["id"];
    const type = {"id": "number"};

    return <TableTemplate url = "medicalInstitution" fields = {fields} type = {type}/>;
}

export default MedicalInstitution;