import TableTemplate from "./TableTemplate";


function BuildingBody() {
    const fields = ["id", "hospitalId"];
    return <TableTemplate url = "buildingBody" fields = {fields}/>;
}

export default BuildingBody;