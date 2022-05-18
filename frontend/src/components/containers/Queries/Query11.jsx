import "../../../styles/Queries.css"
import axios from "axios";
import {useState} from "react";
import "../../../styles/Table.css"

function Query11() {
    let [doctorIds, setDoctorIds] = useState([]);
    let [specializations, setSpecializations] = useState([]);
    let [polyclinicIds, setPolyclinicIds] = useState([]);
    let [startDate, setStartDate] = useState();
    let [endDate, setEndDate] = useState();

    let [data, setData] = useState([]);

    function addBraces(str) {
        return '{' + str + '}';
    }

    const getQuery = () => {
        axios.get('/query/11', {
            params: {
                doctorIds: addBraces(doctorIds),
                specializations: addBraces(specializations),
                polyclinicIds: addBraces(polyclinicIds),
                startDate: startDate,
                endDate: endDate
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
                    <label className="input-label">polyclinicIds</label>
                    <input onChange={(e) => {
                        setPolyclinicIds([e.target.value])
                    }}/>
                </div>
                <div className="input-container">
                    <label className="input-label">startDate</label>
                    <input type="date" onChange={(e) => {
                        setStartDate(e.target.value)
                    }}/>
                </div>
                <div className="input-container">
                    <label className="input-label">endDate</label>
                    <input type="date" onChange={(e) => {
                        setEndDate(e.target.value)
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

export default Query11;