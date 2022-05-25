import TableTemplate from "./TableTemplate";


function OperationStaff() {
    const fields = ["id", "numOfSurgeries", "numOfFatalSurgeries"];
    const type = {"id": "number", "numOfSurgeries": "number", "numOfFatalSurgeries": "number"};
    const relatedTables = ["MedStaff"];
    const fieldsUrl = {"id": "medStaff"};
    return <TableTemplate url = "operationStaff" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default OperationStaff;