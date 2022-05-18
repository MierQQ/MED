import "../../../styles/Queries.css"
import axios from "axios";
import {useState} from "react";
import "../../../styles/Table.css"

function Query12() {
    let [doctorIds, setDoctorIds] = useState([]);
    let [specializations, setSpecializations] = useState([]);
    let [hospitalIds, setHospitalIds] = useState([]);

    let [data, setData] = useState([]);

    function addBraces(str) {
        return '{' + str + '}';
    }

    const getQuery = () => {
        axios.get('/query/12', {
            params: {
                doctorIds: addBraces(doctorIds),
                specializations: addBraces(specializations),
                hospitalIds: addBraces(hospitalIds),
            }
        }).then((response) => {
            setData(response.data);
        }).catch((error) => {
            console.log(error)
        })
    }

    return (
        <div>
            <div className="inputs-container">
                <div className="input-container">
                    <label className="input-label">doctorIds</label>
                    <input onChange={(e) => {
                        setDoctorIds([e.target.value])
                    }}/>
                </div>
                <div className="input-container">
                    <label className="input-label">specializations</label>
                    <input onChange={(e) => {
                        setSpecializations([e.target.value])
                    }}/>
                </div>
                <div className="input-container">
                    <label className="input-label">hospitalIds</label>
                    <input onChange={(e) => {
                        setHospitalIds([e.target.value])
                    }}/>
                </div>
                <div className="input-container">
                    <button className="search-button" onClick={getQuery}>Search</button>
                </div>
            </div>
            <div className="total">Total: {data.length}</div>
            <div>
                <table className="table">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>name</th>
                        <th>productivity</th>
                    </tr>
                    </thead>
                    <tbody>
                    {data.map((value, key) =>
                        <tr>
                            <td>{value.id}</td>
                            <td>{value.name}</td>
                            <td>{value.productivity}</td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

export default Query12;