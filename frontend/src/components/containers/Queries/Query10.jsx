import "../../../styles/Queries.css"
import axios from "axios";
import {useState} from "react";
import "../../../styles/Table.css"

function Query10() {
    let [institutionIds, setInstitutionIds] = useState([]);
    let [startDate, setStartDate] = useState();
    let [endDate, setEndDate] = useState();

    let [data1, setData1] = useState([]);
    let [data2, setData2] = useState([]);

    function addBraces(str) {
        return '{' + str + '}';
    }

    const getQuery1 = () => {
        axios.get('/query/10/1', {
            params: {
                institutionIds: addBraces(institutionIds)
            }
        }).then((response) => {
            setData1(response.data);
        }).catch((error) => {
            console.log(error)
        })
    }
    const getQuery2 = () => {
        axios.get('/query/10/2', {
            params: {
                institutionIds: addBraces(institutionIds),
                startDate: startDate,
                endDate: endDate
            }
        }).then((response) => {
            setData2(response.data);
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
                    <button className="search-button" onClick={() => {
                        getQuery1();
                        getQuery2();
                    }}>Search</button>
                </div>
            </div>
            <div className="total">Всего кабинетов: {data1.map((value, key) =>
                <div>{value.count}</div>
            )}</div>
            <div>
                <table className="table">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>number</th>
                        <th>count</th>
                    </tr>
                    </thead>
                    <tbody>
                    {data2.map((value, key) =>
                        <tr>
                            <td>{value.id}</td>
                            <td>{value.number}</td>
                            <td>{value.count}</td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

export default Query10;