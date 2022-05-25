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
    const type =
        {
            "id": "number",
            "name": "text",
            "specialization": "text",
            "salary": "number",
            "type": "text",
            "employmentDate": "date"
        };
    return <TableTemplate url = "staff" fields = {fields} type = {type}/>;
}

export default Staff;