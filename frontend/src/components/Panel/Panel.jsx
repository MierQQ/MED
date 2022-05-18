import "../../styles/Panel.css"
import App from "../../App";
import {useState} from "react";
import Query1 from "../containers/Queries/Query1";

function Panel(props) {
    const tableButtons =
        (
            <div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("Analyzes")}}>Analyzes</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("BuildingBody")}}>Building Body</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("Cabinets")}}>Cabinets</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("Department")}}>Department</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("Hospital")}}>Hospital</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("HospitalRoom")}}>Hospital Room</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("HospitalRoomExpiring")}}>Hospital Room Expiring</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("LabMedicalInstitution")}}>LabMedical Institution</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("Laboratory")}}>Laboratory</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("MedicalInstitution")}}>Medical Institution</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("MedStaff")}}>Med Staff</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("MedStaffPatient")}}>Med Staff Patient</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("OperationStaff")}}>Operation Staff</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("Patient")}}>Patient</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("PatientRecords")}}>Patient Records</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("Polyclinic")}}>Polyclinic</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("PolyclinicFixing")}}>Polyclinic Fixing</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("ProfessorOrDocent")}}>Professor Or Docent</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("ProfOrDocentMedicalInstitution")}}>Prof Or Docent Medical Institution</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("Staff")}}>Staff</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("StaffMedicalInstitution")}}>Staff Medical Institution</button>
                </div>
            </div>
        );
    const queryButtons =
        (
            <div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("1")}}>1</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("2")}}>2</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("3")}}>3</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("4")}}>4</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("5")}}>5</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("6")}}>6</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("7")}}>7</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("8")}}>8</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("9")}}>9</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("10")}}>10</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("11")}}>11</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("12")}}>12</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("13")}}>13</button>
                </div>
                <div className="panel-button-container">
                    <button className="panel-button" onClick={()=>{props.setContainer("14")}}>14</button>
                </div>

            </div>
        );
    return (
        <div className="panel-container">
            <div className="panel-typePanel">
                <button className="panel-typePanel-button" onClick={()=>{props.setButtonTypes("tableButtons")}}>Tables</button>
                <button className="panel-typePanel-button" onClick={()=>{props.setButtonTypes("queryButtons")}}>Queries</button>
            </div>
            <div className="panel-buttons-container">
            {
                props===null?null:(props.buttonTypes==="tableButtons"?tableButtons:(props.buttonTypes==="queryButtons"?queryButtons:null))
            }
            </div>
        </div>
    );
}

export default Panel;