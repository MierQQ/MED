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
    const fieldsUrl = {"id": "medStaff"};
    return <TableTemplate url = "professorOrDocent" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl}/>;
}

export default ProfessorOrDocent;