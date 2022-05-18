import "../../../styles/Queries.css"
import axios from "axios";
import {useState} from "react";
import "../../../styles/Table.css"

function Query7() {
    let [institutionIds, setInstitutionIds] = useState([]);
    let [medStaffIds, setMedStaffIds] = useState([]);
    let [startDate, setStartDate] = useState();
    let [endDate, setEndDate] = useState();

    let [data, setData] = useState([]);

    function addBraces(str) {
        return '{' + str + '}';
    }

    const getQuery = () => {
        axios.get('/query/7', {
            params: {
                institutionIds: addBraces(institutionIds),
                medStaffIds: addBraces(medStaffIds),
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
                    <label className="input-label">institutionIds</label>
                    <input onChange={(e) => {
                        setInstitutionIds([e.target.value])
                    }}/>
                </div>
                <div className="input-container">
                    <label className="input-label">medStaffIds</label>
                    <input onChange={(e) => {
                        setMedStaffIds([e.target.value])
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
                    </tr>
                    </thead>
                    <tbody>
                    {data.map((value, key) =>
                        <tr>
                            <td>{value.id}</td>
                            <td>{value.name}</td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

export default Query7;