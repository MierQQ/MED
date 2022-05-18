import TableTemplate from "./TableTemplate";


function MedStaff() {
    const fields = ["id", "salaryCoefficient", "vocationBonus", "condidateDegree", "phd", "professor", "docent", "polyclinicId", "hospitalId"];
    return <TableTemplate url = "medStaff" fields = {fields}/>;
}

export default MedStaff;