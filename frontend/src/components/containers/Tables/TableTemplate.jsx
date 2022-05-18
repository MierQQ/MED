import axios from "axios";
import {useState} from "react";
import "../../../styles/Table.css"

function TableTemplate(props) {

    let [data, setData] = useState([]);
    let [dataSearch, setDataSearch] = useState([]);
    let [toSave, setToSave] = useState({});
    let [toDelete, setToDelete] = useState(null);
    let [toUpdate, setToUpdate] = useState({});
    let [toSearch, setToSearch] = useState("");

    const getAll = () => {
        axios.get('/' + props.url).then((response) => {
            setData(response.data);
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
            setDataSearch(response.data);
        }).catch((error) => {
            console.log(error);
            setDataSearch([]);
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

    return (
        <div>
            <div className="inputs-container">
                <div>Save</div>
                {props.fields.map((value, key) => (
                    <div className="input-container">
                        <label className="input-label">{value}</label>
                        <input onChange={(e) => {
                            let newValueOfToSave = toSave;
                            newValueOfToSave[value] = e.target.value;
                            setToSave(newValueOfToSave);
                        }}/>
                    </div>
                ))}
                <div className="input-container">
                    <button className="search-button" onClick={save}>Save</button>
                </div>
            </div>
            <div className="inputs-container">
                <div>Update</div>
                {props.fields.map((value, key) => (
                    <div className="input-container">
                        <label className="input-label">{value}</label>
                        <input onChange={(e) => {
                            let newValueOfToUpdate = toUpdate;
                            newValueOfToUpdate[value] = e.target.value;
                            setToUpdate(newValueOfToUpdate);
                        }}/>
                    </div>
                ))}
                <div className="input-container">
                    <button className="search-button" onClick={update}>Update</button>
                </div>
            </div>
            <div className="inputs-container">
                <div>Delete</div>
                <div className="input-container">
                    <label className="input-label">id</label>
                    <input onChange={(e) => {
                        setToDelete(e.target.value)
                    }}/>
                </div>
                <div className="input-container">
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
                <table className="table">
                    <thead>
                    <tr>
                        {props.fields.map((value, key) => (<th>{value}</th>))}
                    </tr>
                    </thead>
                    <tbody>
                        <tr>
                            {props.fields.map((index, k) => (<th>{dataSearch[index]}</th>))}
                        </tr>
                    </tbody>
                </table>
            </div>
            <div>
                <table className="table">
                    <thead>
                    <tr>
                        {props.fields.map((value, key) => (<th>{value}</th>))}
                    </tr>
                    </thead>
                    <tbody>
                    {data.map((value, key) =>
                        <tr>
                            {props.fields.map((index, k) => (<th>{value[index]}</th>))}
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
        </div>
    )
}

export default TableTemplate;