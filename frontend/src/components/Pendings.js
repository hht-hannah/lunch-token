import React, {useState} from "react";

export function Pendings({ pendingReceive, pendingSend, collect, allowSend }) {
    const [checkReceive, setCheckReceive] = useState([]);
    const [checkSend, setCheckSend] = useState([]);


    const onReveiveChange = (id) => {
      if (checkReceive.includes(id)) {
        setCheckReceive(checkReceive.filter(item => item !== id));
      } else {
        setCheckReceive(checkReceive => [...checkReceive, id]);
      }
    }

    const onSendChange = (id) => {
      if (checkSend.includes(id)) {
        setCheckSend(checkSend.filter(item => item !== id));
      } else {
        setCheckSend(checkSend => [...checkSend, id]);
      }
    }

    const pendingReceiveList = pendingReceive.map((item) =>
      <div>
        <input 
          type="checkbox" 
          key={Number(item.id)} 
          onChange={() => onReveiveChange(Number(item.id))}
          >
        </input> 
        <span>{item.account} - {Number(item.amount)}LCH</span>
      </div>
    );

    const pendingSendList = pendingSend.map((item) =>
      <div>
        <input 
          type="checkbox" 
          key={Number(item.id)} 
          onChange={() => onSendChange(Number(item.id))}
          >
        </input> 
        <span>{item.account} - {Number(item.amount)}LCH</span>
      </div>
    );

    const onCollect = () => {
      checkReceive.forEach((id) => {
        collect(id)
      })
    }

    const onAllow = () => {
      checkSend.forEach((id) => {
        allowSend(id)
      })
    }

  return (
    <div>
      <h4>Pendings</h4>

      <h5> To Receive: </h5>
      {pendingReceiveList}
      <br />
      <button onClick={onCollect}> Collect </button>

      <h5> To Send: </h5>
      {pendingSendList}
      <br />
      <button onClick={onAllow}> Allow </button>

      <br />
      <br />
      
    </div>
  );
}
