import TableTemplate from "./TableTemplate";


function Department() {
    const fields = ["id", "buildingBodyId", "specialization"];
    const type = {"id": "number", "buildingBodyId": "number", "specialization": "text"};
    const relatedTables = ["BuildingBody"];
    const fieldsUrl = {"buildingBodyId": "buildingBody"};
    return <TableTemplate url = "department" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default Department;