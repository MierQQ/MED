import {useState} from "react";
import Panel from "./components/Panel/Panel";
import "./styles/App.css"

function App() {
    let [container, setContainer] = useState();
    let [buttonTypes, setButtonTypes] = useState("tableButtons");
    return (
        <div>
            <div className="left">
                <Panel setContainer={setContainer} buttonTypes={buttonTypes} setButtonTypes={setButtonTypes}/>
            </div>
            <div className="right">
                {container}
            </div>
        </div>
    );
}

export default App;
