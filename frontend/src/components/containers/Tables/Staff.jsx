import TableTemplate from "./TableTemplate";


function Staff() {
    const fields =
        [
            "id",
            "name",
            "specialization",
            "salary",
            "type",
            "employmentDate",
        ];
    return <TableTemplate url = "staff" fields = {fields}/>;
}

export default Staff;