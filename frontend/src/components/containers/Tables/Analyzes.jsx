import TableTemplate from "./TableTemplate";


function Analyzes() {
    const fields = ["id", "record", "labId"];
    const type = {"id": "number", "record": "number", "labId": "number"};
    const relatedTables = ["Laboratory"];
    return <TableTemplate url = "analyzes" fields = {fields} type = {type} relatedTables = {relatedTables}/>;
}

export default Analyzes;