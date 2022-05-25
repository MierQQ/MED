import TableTemplate from "./TableTemplate";


function Cabinets() {
    const fields = ["id", "polyclinicId", "number"];
    const type = {"id": "number", "polyclinicId": "number", "number": "text"};
    const relatedTables = ["Polyclinic"];
    return <TableTemplate url = "cabinets" fields = {fields} type = {type} relatedTables = {relatedTables}/>;
}

export default Cabinets;