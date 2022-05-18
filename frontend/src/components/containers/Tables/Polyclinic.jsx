import TableTemplate from "./TableTemplate";


function Polyclinic() {
    const fields =
        [
            "id",
            "name",
        ];
    return <TableTemplate url = "polyclinic" fields = {fields}/>;
}

export default Polyclinic;