import TableTemplate from "./TableTemplate";


function HospitalRoom() {
    const fields = ["id", "departmentId", "bedNumber"];
    const type = {"id": "number", "departmentId": "number", "bedNumber": "number"};
    const relatedTables = ["Department"];
    const fieldsUrl = {"departmentId": "department"};
    return <TableTemplate url = "hospitalRoom" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default HospitalRoom;