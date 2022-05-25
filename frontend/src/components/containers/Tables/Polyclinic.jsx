import TableTemplate from "./TableTemplate";


function Polyclinic() {
    const fields =
        [
            "id",
            "name",
        ];
    const type =
        {
            "id": "number",
            "name": "text",
        };
    const relatedTables = ["MedicalInstitution"];
    return <TableTemplate url = "polyclinic" fields = {fields} type = {type} relatedTables={relatedTables}/>;
}

export default Polyclinic;