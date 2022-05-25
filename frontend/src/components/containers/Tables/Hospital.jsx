import TableTemplate from "./TableTemplate";


function Hospital() {
    const fields = ["id", "name"];
    const type = {"id": "number", "name": "text"};
    const relatedTables = ["MedicalInstitution"];
    const fieldsUrl = {"id": "medicalInstitution"};
    return <TableTemplate url = "hospital" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default Hospital;