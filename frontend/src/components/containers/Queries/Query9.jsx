import "../../../styles/Queries.css"
import axios from "axios";
import {useState} from "react";
import "../../../styles/Table.css"

function Query9() {
    let [hospitalIds, setHospitalIds] = useState([]);

    let [data1, setData1] = useState([]);
    let [data2, setData2] = useState([]);
    let [data3, setData3] = useState([]);
    let [data4, setData4] = useState([]);
    let [data5, setData5] = useState([]);
    let [data6, setData6] = useState([]);

    function addBraces(str) {
        return '{' + str + '}';
    }

    const getQueries = () => {
        getQuery1();
        getQuery2();
        getQuery3();
        getQuery4();
        getQuery5();
        getQuery6();
    }

    const getQuery1 = () => {
        axios.get('/query/9/1', {
            params: {
                hospitalIds: addBraces(hospitalIds)
            }
        }).then((response) => {
            setData1(response.data);
        }).catch((error) => {
            console.log(error)
        })
    }
    const getQuery2 = () => {
        axios.get('/query/9/2',{
            params: {
                hospitalIds: addBraces(hospitalIds)
            }
        }).then((response) => {
            setData2(response.data);
        }).catch((error) => {
            console.log(error)
        })
    }
    const getQuery3 = () => {
        axios.get('/query/9/3',{
            params: {
                hospitalIds: addBraces(hospitalIds)
            }
        }).then((response) => {
            setData3(response.data);
        }).catch((error) => {
            console.log(error)
        })
    }
    const getQuery4 = () => {
        axios.get('/query/9/4',{
            params: {
                hospitalIds: addBraces(hospitalIds)
            }
        }).then((response) => {
            setData4(response.data);
        }).catch((error) => {
            console.log(error)
        })
    }
    const getQuery5 = () => {
        axios.get('/query/9/5',{
            params: {
                hospitalIds: addBraces(hospitalIds)
            }
        }).then((response) => {
            setData5(response.data);
        }).catch((error) => {
            console.log(error)
        })
    }
    const getQuery6 = () => {
        axios.get('/query/9/6',{
            params: {
                hospitalIds: addBraces(hospitalIds)
            }
        }).then((response) => {
            setData6(response.data);
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
                    <button className="search-button" onClick={getQueries}>Search</button>
                </div>
            </div>
            <div>
                <div className="table">Общее число палат</div>
                <table className="table">
                    <thead>
                    <tr>
                        <th>count</th>
                    </tr>
                    </thead>
                    <tbody>
                    {data1.map((value, key) =>
                        <tr>
                            <td>{value.count}</td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
            <div>
                <div className="table">Общее число коек</div>
                <table className="table">
                    <thead>
                    <tr>
                        <th>count</th>
                    </tr>
                    </thead>
                    <tbody>
                    {data2.map((value, key) =>
                        <tr>
                            <td>{value.count}</td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
            <div>
                <div className="table">Общее число палат по департаментам</div>
                <table className="table">
                    <thead>
                    <tr>
                        <th>department</th>
                        <th>count</th>
                    </tr>
                    </thead>
                    <tbody>
                    {data3.map((value, key) =>
                        <tr>
                            <td>{value.departmentId}</td>
                            <td>{value.count}</td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
            <div>
                <div className="table">Общее число коек по департаментам</div>
                <table className="table">
                    <thead>
                    <tr>
                        <th>department</th>
                        <th>count</th>
                    </tr>
                    </thead>
                    <tbody>
                    {data4.map((value, key) =>
                        <tr>
                            <td>{value.departmentId}</td>
                            <td>{value.count}</td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
            <div>
                <div className="table">Общее число полностью свободных палат по департаментам</div>
                <table className="table">
                    <thead>
                    <tr>
                        <th>department</th>
                        <th>count</th>
                    </tr>
                    </thead>
                    <tbody>
                    {data5.map((value, key) =>
                        <tr>
                            <td>{value.departmentId}</td>
                            <td>{value.count}</td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
            <div>
                <div className="table">Общее число свободных коек по департаментам</div>
                <table className="table">
                    <thead>
                    <tr>
                        <th>department</th>
                        <th>count</th>
                    </tr>
                    </thead>
                    <tbody>
                    {data6.map((value, key) =>
                        <tr>
                            <td>{value.departmentId}</td>
                            <td>{value.count}</td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

export default Query9;