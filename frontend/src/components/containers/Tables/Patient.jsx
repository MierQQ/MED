import TableTemplate from "./TableTemplate";


function Patient() {
    const fields = ["id", "name", "birthDay"];
    const type = {"id": "number", "name": "text", "birthDay": "date"};
    return <TableTemplate url = "patient" fields = {fields} type = {type}/>;
}

export default Patient;