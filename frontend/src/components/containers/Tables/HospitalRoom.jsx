import TableTemplate from "./TableTemplate";


function HospitalRoom() {
    const fields = ["id", "departmentId", "bedNumber"];
    const type = {"id": "number", "departmentId": "number", "bedNumber": "number"};
    const relatedTables = ["Department"];
    return <TableTemplate url = "hospitalRoom" fields = {fields} type = {type} relatedTables={relatedTables}/>;
}

export default HospitalRoom;