import TableTemplate from "./TableTemplate";


function HospitalRoomExpiring() {
    const fields = ["id", "record", "date"];
    const type = {"id": "number", "record": "number", "date": "date"};
    const relatedTables = ["PatientRecords"];
    const fieldsUrl = {"record": "patientRecords"};
    return <TableTemplate url = "hospitalRoomExpiring" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default HospitalRoomExpiring;