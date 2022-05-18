import TableTemplate from "./TableTemplate";


function Hospital() {
    const fields = ["id", "name"];
    return <TableTemplate url = "hospital" fields = {fields}/>;
}

export default Hospital;