import TableTemplate from "./TableTemplate";


function Cabinets() {
    const fields = ["id", "polyclinicId", "number"];
    return <TableTemplate url = "cabinets" fields = {fields}/>;
}

export default Cabinets;