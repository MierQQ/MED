import TableTemplate from "./TableTemplate";


function PolyclinicFixing() {
    const fields =
        [
            "id",
            "polyclinicId",
            "hospitalId",
        ];
    const type =
        {
            "id": "number",
            "polyclinicId": "number",
            "hospitalId": "number",
        };
    const relatedTables = ["Polyclinic", "Hospital"];
    const fieldsUrl = {"polyclinicId": "polyclinic", "hospitalId": "hospital"};
    return <TableTemplate url = "polyclinicFixing" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl}/>;
}

export default PolyclinicFixing;