import TableTemplate from "./TableTemplate";


function HospitalRoomExpiring() {
    const fields = ["id", "record", "date"];
    const type = {"id": "number", "record": "number", "date": "date"};
    const relatedTables = ["PatientRecords"];
    return <TableTemplate url = "hospitalRoomExpiring" fields = {fields} type = {type} relatedTables={relatedTables}/>;
}

export default HospitalRoomExpiring;