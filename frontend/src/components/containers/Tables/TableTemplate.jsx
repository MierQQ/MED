import axios from "axios";
import {useState} from "react";
import "../../../styles/Table.css"
import Query1 from "../Queries/Query1";
import Query2 from "../Queries/Query2";
import Query3 from "../Queries/Query3";
import Query4 from "../Queries/Query4";
import Query5 from "../Queries/Query5";
import Query6 from "../Queries/Query6";
import Query7 from "../Queries/Query7";
import Query8 from "../Queries/Query8";
import Query9 from "../Queries/Query9";
import Query10 from "../Queries/Query10";
import Query11 from "../Queries/Query11";
import Query12 from "../Queries/Query12";
import Query13 from "../Queries/Query13";
import Query14 from "../Queries/Query14";
import Analyzes from "./Analyzes";
import Patient from "./Patient";
import BuildingBody from "./BuildingBody";
import Cabinets from "./Cabinets";
import Department from "./Department";
import Hospital from "./Hospital";
import HospitalRoom from "./HospitalRoom";
import HospitalRoomExpiring from "./HospitalRoomExpiring";
import LabMedicalInstitution from "./LabMedicalInstitution";
import Laboratory from "./Laboratory";
import MedicalInstitution from "./MedicalInstitution";
import MedStaff from "./MedStaff";
import MedStaffPatient from "./MedStaffPatient";
import OperationStaff from "./OperationStaff";
import PatientRecords from "./PatientRecords";
import Polyclinic from "./Polyclinic";
import PolyclinicFixing from "./PolyclinicFixing";
import ProfessorOrDocent from "./ProfessorOrDocent";
import ProfOrDocentMedicalInstitution from "./ProfOrDocentMedicalInstitution";
import Staff from "./Staff";
import StaffMedicalInstitution from "./StaffMedicalInstitution";

function TableTemplate(props) {

    const container = {
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

    let [data, setData] = useState([]);
    let [toSave, setToSave] = useState({});
    let [toDelete, setToDelete] = useState(null);
    let [toUpdate, setToUpdate] = useState({});
    let [toShow, setToShow] = useState({});
    let [toSearch, setToSearch] = useState("");
    let [keyTables, setKeyTables] = useState([]);
    let [info, setInfo] = useState({});
    let [maxId, setMaxId] = useState("");
    let [init, setInit] = useState(false);

    const getByURL = (url, id) => {
        axios.get('/' + url + "/" + id).then((response) => {
            setToShow(response.data);
        }).catch((error) => {
            console.log(error);
        })
    }

    const getByURLForSell = (url, id, selfId, key) => {
        axios.get('/' + url + "/" + id).then((response) => {
            if (!info.hasOwnProperty(selfId) ){
                info[selfId] = {};
            }
            info[selfId][key] = response.data;
            setInfo(Object.assign({}, info));
        }).catch((error) => {
            console.log(error);
        })
    }

    const getAll = () => {
        axios.get('/' + props.url).then((response) => {
            setData(response.data);
            setMaxId(response.data.reduce((acc, value) => {
                return acc > parseInt(value.id) ? acc : parseInt(value.id)
            }, -1) + 1);
            if (props.hasOwnProperty("fieldsUrl")) {
                response.data.forEach((value) => {
                    for (let key in props.fieldsUrl) {
                        getByURLForSell(props.fieldsUrl[key], value[key], value.id, key);
                    }
                })
            }
        }).catch((error) => {
            console.log(error)
        })
    }

    const search = () => {
        if (toSearch === "") {
            getAll();
            return;
        }
        axios.get('/' + props.url + "/" + toSearch).then((response) => {
            setData([response.data]);
        }).catch((error) => {
            console.log(error);
            setData([]);
        })
    }

    const save = () => {
        console.log(toSave);
        axios.post('/' + props.url, toSave).then((response) => {
            getAll();
            console.log(response.data);
        }).catch((error) => {
            console.log(error)
        })
    }

    const deleteById = () => {
        axios.delete('/' + props.url + "/" + toDelete).then((response) => {
            getAll();
            console.log(response.data);
        }).catch((error) => {
            console.log(error)
        })
    }

    const update = () => {
        axios.put('/' + props.url + '/' + toUpdate.id, toUpdate).then((response) => {
            getAll();
            console.log(response.data);
        }).catch((error) => {
            console.log(error)
        })
    }

    const show = () => {
        let result = [];
        for (let key in toShow) {
            result.push(
                <div>
                    <label>{key.replace(/([A-Z]+)*([A-Z][a-z])/g, "$1 $2")} : {toShow[key] + ""}</label>
                </div>
            );
        }
        return result;
    }

    const showInfo = (obj) => {
        let result = [];
        for (let key in obj) {
            result.push(
                <div>
                    <label>{key.replace(/([A-Z]+)*([A-Z][a-z])/g, "$1 $2")} : {obj[key] + ""}</label>
                </div>
            );
        }
        return result;
    }

    if (!init) {
        getAll();
        setInit(true);
    }

    const getCell = (id, val) => {
        if (info.hasOwnProperty(id)) {
            if (info[id].hasOwnProperty(val))
            return <div>{showInfo(info[id][val])}</div>;
        }
        return null;
    }

    return (<div className={"tableHolder"}>

        <div className="inputs-container">
            <div>Update</div>
            {props.fields.map((value, key) => (<div className="input-container">
                <label className="input-label">{value.replace(/([A-Z]+)*([A-Z][a-z])/g, "$1 $2")}</label>
                <input type={props.type[value]} value={toUpdate[value]} onChange={(e) => {
                    toUpdate[value] = e.target.value;
                    setToUpdate(Object.assign({}, toUpdate));
                }}/>
            </div>))}
            <div className="input-container">
                <button className="search-button" onClick={update}>Update</button>
                <button className="search-button" onClick={deleteById}>Delete</button>
            </div>
        </div>
        <div className="inputs-container">
            <div>Search</div>
            <div className="input-container">
                <label className="input-label">id</label>
                <input onChange={(e) => {
                    setToSearch(e.target.value)
                }}/>
            </div>
            <div className="input-container">
                <button className="search-button" onClick={search}>Search</button>
            </div>
        </div>

        <div>
            {show()}
        </div>

        <div>
            <table className="table">
                <thead>
                <tr>
                    {props.fields.map((value, key) => (
                        <th>{value.replace(/([A-Z]+)*([A-Z][a-z])/g, "$1 $2")}</th>))}
                </tr>
                </thead>
                <tbody>
                {data.sort((a, b) => {
                    return a.id - b.id
                }).map((value, key) => <tr className={toDelete !== value.id ? "tr" : "trToDelete"} onClick={() => {
                    setToDelete(value.id);
                    setToUpdate(Object.assign({}, value));
                }}>
                    {props.fields.map((index, k) => (<th className={getCell(value.id, index) === null ? "" : "tableCellWithObject"} onClick={() => {
                        if (props.hasOwnProperty("fieldsUrl") && props.fieldsUrl.hasOwnProperty(index)) {
                            getByURL(props.fieldsUrl[index], value[index]);
                        }
                    }}>
                        {
                            getCell(value.id, index) === null ? value[index] + "" : getCell(value.id, index)
                        }
                    </th>))}
                </tr>)}
                <tr>
                    {props.fields.map((value, key) => (<th>
                        <input type={props.type[value]} placeholder={value === "id" ? maxId : ""}
                               onChange={(e) => {
                                   let newValueOfToSave = toSave;
                                   newValueOfToSave[value] = e.target.value;
                                   setToSave(newValueOfToSave);
                               }}/>
                    </th>))}
                </tr>
                </tbody>
            </table>
            <div className="input-container">
                <button className="search-button" onClick={save}>Save</button>
            </div>
        </div>

        {props.hasOwnProperty("relatedTables") ? <div>
            <div>Foreign key tables</div>
            {props.relatedTables.map((value, key) => (<button className="search-button" onClick={() => {
                let newKeyTable = {};
                newKeyTable[value] = !keyTables.hasOwnProperty(value) || !keyTables[value];
                setKeyTables(Object.assign({}, newKeyTable));
            }}>{value.replace(/([A-Z]+)*([A-Z][a-z])/g, "$1 $2")}</button>))}
            {props.relatedTables.map((value, key) => (<div>
                {keyTables.hasOwnProperty(value) && keyTables[value] ? <div>
                    <div>{value}</div>
                    {container[value]}
                </div> : <div/>}
            </div>))}
        </div> : <div></div>}

    </div>)
}

export default TableTemplate;