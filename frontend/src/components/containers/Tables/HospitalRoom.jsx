import TableTemplate from "./TableTemplate";


function HospitalRoom() {
    const fields = ["id", "departmentId", "bedNumber"];
    return <TableTemplate url = "hospitalRoom" fields = {fields}/>;
}

export default HospitalRoom;