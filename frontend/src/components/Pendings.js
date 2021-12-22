import React from "react";

export function Pendings({ pendingReceive, pendingSend }) {

    const pendingReceiveList = pendingReceive.map(() =>
        <li>{"hi"}</li>
    );

  return (
    <div>
      <h4>Pendings</h4>

      <h5> To Receive: </h5>
      {pendingReceiveList}

      <h5> To Send: </h5>
      {pendingReceiveList}

      <br />
      <br />
      
    </div>
  );
}
