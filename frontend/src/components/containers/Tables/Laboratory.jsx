import TableTemplate from "./TableTemplate";


function Laboratory() {
    const fields = ["id", "specialization"];
    return <TableTemplate url = "laboratory" fields = {fields}/>;
}

export default Laboratory;