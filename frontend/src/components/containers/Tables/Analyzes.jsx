import TableTemplate from "./TableTemplate";


function Analyzes() {
    const fields = ["id", "record", "labId"];
    const type = {"id": "number", "record": "number", "labId": "number"};
    const relatedTables = ["PatientRecords", "Laboratory"];
    const fieldsUrl = {"record": "patientRecords", "labId": "laboratory"};
    return <TableTemplate url = "analyzes" fields = {fields} type = {type} relatedTables = {relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default Analyzes;