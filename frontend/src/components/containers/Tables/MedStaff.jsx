import TableTemplate from "./TableTemplate";


function MedStaff() {
    const fields = ["id", "salaryCoefficient", "vocationBonus", "condidateDegree", "phd", "professor", "docent", "polyclinicId", "hospitalId"];
    const type = {
        "id": "number",
        "salaryCoefficient": "number",
        "vocationBonus": "number",
        "condidateDegree": "text",
        "phd": "text",
        "professor": "text",
        "docent": "text",
        "polyclinicId": "number",
        "hospitalId": "number"
    };
    const relatedTables = ["Staff", "Hospital", "Polyclinic"];
    const fieldsUrl = {"id": "staff", "hospitalId": "hospital", "polyclinicId": "polyclinic"};
    return <TableTemplate url="medStaff" fields={fields} type={type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default MedStaff;