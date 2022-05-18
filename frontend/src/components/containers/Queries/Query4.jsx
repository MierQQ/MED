import "../../../styles/Queries.css"
import axios from "axios";
import {useState} from "react";
import "../../../styles/Table.css"

function Query4() {
    let [institutionIds, setInstitutionIds] = useState([]);
    let [specializations, setSpecializations] = useState([]);
    let [standing, setStanding] = useState(0);
    let [data, setData] = useState([]);

    function addBraces(str) {
        return '{' + str + '}';
    }

    const getQuery = () => {
        axios.get('/query/4', {
            params: {
                institutionIds: addBraces(institutionIds),
                specializations: addBraces(specializations),
                standing: standing
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
                    <label className="input-label">specializations</label>
                    <input onChange={(e) => {
                        setSpecializations([e.target.value])
                    }}/>
                </div>
                <div className="input-container">
                    <label className="input-label">standing</label>
                    <input onChange={(e) => {
                        setStanding(e.target.value)
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
                        <th>specialization</th>
                        <th>salary</th>
                    </tr>
                    </thead>
                    <tbody>
                    {data.map((value, key) =>
                        <tr>
                            <td>{value.id}</td>
                            <td>{value.name}</td>
                            <td>{value.specialization}</td>
                            <td>{value.salary}</td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

export default Query4;