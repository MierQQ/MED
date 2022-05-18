import TableTemplate from "./TableTemplate";


function Analyzes() {
    const fields = ["id", "record", "labId"];
    return <TableTemplate url = "analyzes" fields = {fields}/>;
}

export default Analyzes;