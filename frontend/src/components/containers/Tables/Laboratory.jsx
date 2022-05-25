import TableTemplate from "./TableTemplate";


function Laboratory() {
    const fields = ["id", "specialization"];
    const type = {"id": "number", "specialization": "text"};

    return <TableTemplate url = "laboratory" fields = {fields} type = {type}/>;
}

export default Laboratory;