import {useState} from "react";
import Panel from "./components/Panel/Panel";
import "./styles/App.css"
import Query1 from "./components/containers/Queries/Query1";
import Query2 from "./components/containers/Queries/Query2";
import Query3 from "./components/containers/Queries/Query3";
import Query4 from "./components/containers/Queries/Query4";
import Query5 from "./components/containers/Queries/Query5";
import Query6 from "./components/containers/Queries/Query6";
import Query7 from "./components/containers/Queries/Query7";
import Query8 from "./components/containers/Queries/Query8";
import Query9 from "./components/containers/Queries/Query9";
import Query10 from "./components/containers/Queries/Query10";
import Query11 from "./components/containers/Queries/Query11";
import Query12 from "./components/containers/Queries/Query12";
import Query13 from "./components/containers/Queries/Query13";
import Query14 from "./components/containers/Queries/Query14";
import Analyzes from "./components/containers/Tables/Analyzes";
import Patient from "./components/containers/Tables/Patient";
import BuildingBody from "./components/containers/Tables/BuildingBody";
import Cabinets from "./components/containers/Tables/Cabinets";
import Department from "./components/containers/Tables/Department";
import Hospital from "./components/containers/Tables/Hospital";
import HospitalRoom from "./components/containers/Tables/HospitalRoom";
import HospitalRoomExpiring from "./components/containers/Tables/HospitalRoomExpiring";
import LabMedicalInstitution from "./components/containers/Tables/LabMedicalInstitution";
import Laboratory from "./components/containers/Tables/Laboratory";
import MedicalInstitution from "./components/containers/Tables/MedicalInstitution";
import MedStaff from "./components/containers/Tables/MedStaff";
import MedStaffPatient from "./components/containers/Tables/MedStaffPatient";
import OperationStaff from "./components/containers/Tables/OperationStaff";
import PatientRecords from "./components/containers/Tables/PatientRecords";
import Polyclinic from "./components/containers/Tables/Polyclinic";
import PolyclinicFixing from "./components/containers/Tables/PolyclinicFixing";
import ProfessorOrDocent from "./components/containers/Tables/ProfessorOrDocent";
import ProfOrDocentMedicalInstitution from "./components/containers/Tables/ProfOrDocentMedicalInstitution";
import Staff from "./components/containers/Tables/Staff";
import StaffMedicalInstitution from "./components/containers/Tables/StaffMedicalInstitution";

function App() {
    let [containerKey, setContainerKey] = useState();
    let [buttonTypes, setButtonTypes] = useState("tableButtons");
    const container =
        {
            "1": <Query1/>,
            "2": <Query2/>,
            "3": <Query3/>,
            "4": <Query4/>,
            "5": <Query5/>,
            "6": <Query6/>,
            "7": <Query7/>,
            "8": <Query8/>,
            "9": <Query9/>,
            "10": <Query10/>,
            "11": <Query11/>,
            "12": <Query12/>,
            "13": <Query13/>,
            "14": <Query14/>,
            "Analyzes": <Analyzes/>,
            "Patient": <Patient/>,
            "BuildingBody": <BuildingBody/>,
            "Cabinets": <Cabinets/>,
            "Department": <Department/>,
            "Hospital": <Hospital/>,
            "HospitalRoom": <HospitalRoom/>,
            "HospitalRoomExpiring": <HospitalRoomExpiring/>,
            "LabMedicalInstitution": <LabMedicalInstitution/>,
            "Laboratory": <Laboratory/>,
            "MedicalInstitution": <MedicalInstitution/>,
            "MedStaff": <MedStaff/>,
            "MedStaffPatient": <MedStaffPatient/>,
            "OperationStaff": <OperationStaff/>,
            "PatientRecords": <PatientRecords/>,
            "Polyclinic": <Polyclinic/>,
            "PolyclinicFixing": <PolyclinicFixing/>,
            "ProfessorOrDocent": <ProfessorOrDocent/>,
            "ProfOrDocentMedicalInstitution": <ProfOrDocentMedicalInstitution/>,
            "Staff": <Staff/>,
            "StaffMedicalInstitution": <StaffMedicalInstitution/>,
        };
    return (
        <div>
            <div className="left">
                <Panel setContainer={setContainerKey} buttonTypes={buttonTypes} setButtonTypes={setButtonTypes}/>
            </div>
            <div className="right">
                {container[containerKey]}
            </div>
        </div>
    );
}

export default App;
