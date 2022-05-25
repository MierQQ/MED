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
    const fieldsUrl = {"id": "medicalInstitution"};
    return <TableTemplate url = "polyclinic" fields = {fields} type = {type} relatedTables={relatedTables} fieldsUrl = {fieldsUrl} />;
}

export default Polyclinic;