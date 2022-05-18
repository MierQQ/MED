import TableTemplate from "./TableTemplate";


function HospitalRoomExpiring() {
    const fields = ["id", "record", "date"];
    return <TableTemplate url = "hospitalRoomExpiring" fields = {fields}/>;
}

export default HospitalRoomExpiring;