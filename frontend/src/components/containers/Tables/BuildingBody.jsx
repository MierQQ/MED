import TableTemplate from "./TableTemplate";


function BuildingBody() {
    const fields = ["id", "hospitalId"];
    const type = {"id": "number", "hospitalId": "number"};
    const relatedTables = ["Hospital"];
    return <TableTemplate url = "buildingBody" fields = {fields} type = {type} relatedTables = {relatedTables}/>;
}

export default BuildingBody;