import "../../../styles/Queries.css"
import axios from "axios";
import {useState} from "react";
import "../../../styles/Table.css"

function Query1() {
    let [institutionIds, setInstitutionIds] = useState([]);
    let [specializations, setSpecializations] = useState([]);
    let [data, setData] = useState([]);

    function addBraces(str) {
        return '{' + str + '}';
    }

    const getQuery = () => {
        axios.get('/query/1', {
            params: {
                institutionIds: addBraces(institutionIds),
                specializations: addBraces(specializations)
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

export default Query1;