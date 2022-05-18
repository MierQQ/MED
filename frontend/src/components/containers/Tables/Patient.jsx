import TableTemplate from "./TableTemplate";


function Patient() {
    const fields = ["id", "name", "birthDay"];
    return <TableTemplate url = "patient" fields = {fields}/>;
}

export default Patient;