import TableTemplate from "./TableTemplate";


function ProfessorOrDocent() {
    const fields =
        [
            "id"
        ];
    const type =
        {
            "id": "number"
        };
    const relatedTables = ["MedStaff"];
    return <TableTemplate url = "professorOrDocent" fields = {fields} type = {type} relatedTables={relatedTables}/>;
}

export default ProfessorOrDocent;