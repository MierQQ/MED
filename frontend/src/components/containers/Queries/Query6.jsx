import "../../../styles/Queries.css"
import axios from "axios";
import {useState} from "react";
import "../../../styles/Table.css"
import {logDOM} from "@testing-library/react";

function Query6() {
    let [hospitalIds, setHospitalIds] = useState([]);
    let [departmentIds, setDepartmentIds] = useState([]);
    let [hospitalRoomIds, setHospitalRoomIds] = useState([]);
    let [data, setData] = useState([]);

    function addBraces(str) {
        return '{' + str + '}';
    }

    const getQuery = () => {
        axios.get('/query/6', {
            params: {
                hospitalIds: addBraces(hospitalIds),
                departmentIds: addBraces(departmentIds),
                hospitalRoomIds: addBraces(hospitalRoomIds)
            }
        }).then((response) => {
            console.log(response.data);
            let result = [];
            for (let it in response.data) {
                if (result[response.data[it].visit] == null) {
                    result[response.data[it].visit] = response.data[it];
                } else {
                    result[response.data[it].visit].data += "; " + response.data[it].data;
                }
            }
            setData(result);
            console.log(result);
        }).catch((error) => {
            console.log(error)
        })
    }

    return (
        <div>
            <div className="inputs-container">
                <div className="input-container">
                    <label className="input-label">hospitalIds</label>
                    <input onChange={(e) => {
                        setHospitalIds([e.target.value])
                    }}/>
                </div>
                <div className="input-container">
                    <label className="input-label">departmentIds</label>
                    <input onChange={(e) => {
                        setDepartmentIds([e.target.value])
                    }}/>
                </div>
                <div className="input-container">
                    <label className="input-label">hospitalRoomIds</label>
                    <input onChange={(e) => {
                        setHospitalRoomIds([e.target.value])
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
                        <th>date</th>
                        <th>data</th>
                    </tr>
                    </thead>
                    <tbody>
                    {data.map((value, key) =>
                        <tr>
                            <td>{value.id}</td>
                            <td>{value.name}</td>
                            <td>{value.date}</td>
                            <td>{value.data}</td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

export default Query6;