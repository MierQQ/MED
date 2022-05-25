import TableTemplate from "./TableTemplate";


function OperationStaff() {
    const fields = ["id", "numOfSurgeries", "numOfFatalSurgeries"];
    const type = {"id": "number", "numOfSurgeries": "number", "numOfFatalSurgeries": "number"};
    const relatedTables = ["MedStaff"];
    return <TableTemplate url = "operationStaff" fields = {fields} type = {type} relatedTables={relatedTables}/>;
}

export default OperationStaff;