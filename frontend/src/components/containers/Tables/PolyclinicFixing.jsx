import TableTemplate from "./TableTemplate";


function PolyclinicFixing() {
    const fields =
        [
            "id",
            "polyclinicId",
            "hospitalId",
        ];
    return <TableTemplate url = "polyclinicFixing" fields = {fields}/>;
}

export default PolyclinicFixing;