import TableTemplate from "./TableTemplate";


function ProfessorOrDocent() {
    const fields =
        [
            "id"
        ];
    return <TableTemplate url = "professorOrDocent" fields = {fields}/>;
}

export default ProfessorOrDocent;