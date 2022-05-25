import TableTemplate from "./TableTemplate";


function MedStaff() {
    const fields = ["id", "salaryCoefficient", "vocationBonus", "condidateDegree", "phd", "professor", "docent", "polyclinicId", "hospitalId"];
    const type = {
        "id": "number",
        "salaryCoefficient": "number",
        "vocationBonus": "number",
        "condidateDegree": "number",
        "phd": "number",
        "professor": "number",
        "docent": "number",
        "polyclinicId": "number",
        "hospitalId": "number"
    };
    const relatedTables = ["Staff", "Hospital", "Polyclinic"];
    return <TableTemplate url="medStaff" fields={fields} type={type} relatedTables={relatedTables}/>;
}

export default MedStaff;