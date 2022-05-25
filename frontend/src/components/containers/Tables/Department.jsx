import TableTemplate from "./TableTemplate";


function Department() {
    const fields = ["id", "buildingBodyId", "specialization"];
    const type = {"id": "number", "buildingBodyId": "number", "specialization": "text"};
    const relatedTables = ["BuildingBody"];
    return <TableTemplate url = "department" fields = {fields} type = {type} relatedTables={relatedTables}/>;
}

export default Department;