import TableTemplate from "./TableTemplate";


function Department() {
    const fields = ["id", "buildingBodyId", "specialization"];
    return <TableTemplate url = "department" fields = {fields}/>;
}

export default Department;