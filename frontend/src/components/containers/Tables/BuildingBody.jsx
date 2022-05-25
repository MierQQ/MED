import TableTemplate from "./TableTemplate";


function BuildingBody() {
    const fields = ["id", "hospitalId"];
    const type = {"id": "number", "hospitalId": "number"};
    const relatedTables = ["Hospital"];
    const fieldsUrl = {"hospitalId": "hospital"};
    return <TableTemplate url = "buildingBody" fields = {fields} type = {type} relatedTables = {relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default BuildingBody;