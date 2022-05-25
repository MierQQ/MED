import TableTemplate from "./TableTemplate";


function Hospital() {
    const fields = ["id", "name"];
    const type = {"id": "number", "name": "text"};
    const relatedTables = ["MedicalInstitution"];
    return <TableTemplate url = "hospital" fields = {fields} type = {type} relatedTables={relatedTables}/>;
}

export default Hospital;