import {useState} from "react";
import Panel from "./components/Panel/Panel";
import "./styles/App.css"
import Query1 from "./components/containers/Queries/Query1";
import Query2 from "./components/containers/Queries/Query2";
import Query3 from "./components/containers/Queries/Query3";
import Query4 from "./components/containers/Queries/Query4";
import Query5 from "./components/containers/Queries/Query5";
import Query6 from "./components/containers/Queries/Query6";
import Query7 from "./components/containers/Queries/Query7";
import Query8 from "./components/containers/Queries/Query8";
import Query9 from "./components/containers/Queries/Query9";
import Query10 from "./components/containers/Queries/Query10";
import Query11 from "./components/containers/Queries/Query11";
import Query12 from "./components/containers/Queries/Query12";
import Query13 from "./components/containers/Queries/Query13";
import Query14 from "./components/containers/Queries/Query14";
import Analyzes from "./components/containers/Tables/Analyzes";
import Patient from "./components/containers/Tables/Patient";

function App() {
    let [containerKey, setContainerKey] = useState();
    let [buttonTypes, setButtonTypes] = useState("tableButtons");
    const container =
        {
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
        };
    return (
        <div>
            <div className="left">
                <Panel setContainer={setContainerKey} buttonTypes={buttonTypes} setButtonTypes={setButtonTypes}/>
            </div>
            <div className="right">
                {container[containerKey]}
            </div>
        </div>
    );
}

export default App;
