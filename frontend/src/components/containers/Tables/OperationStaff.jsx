import TableTemplate from "./TableTemplate";


function OperationStaff() {
    const fields = ["id", "numOfSurgeries", "numOfFatalSurgeries"];
    return <TableTemplate url = "operationStaff" fields = {fields}/>;
}

export default OperationStaff;