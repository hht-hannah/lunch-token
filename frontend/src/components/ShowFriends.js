import React from "react";

export function ShowFriends({friendsList}) {
  // create the necessary elements
  // fixme:Testing purpose
  // friendsList = [
  //     {name:'stephen',accountBalance:100,address:'0x448A3Aa842e189730a7CAb4D5fA8b4F249263cd2'},
  //     {name:'steve',accountBalance:10,address:'0x2d0ec23C72C39Fb81829b49Aeb1c7aA37D9b0A14'},
  //     {name:'tom',accountBalance:20,address:'0x93327e47F8426E194e820664eBe86C4cC840424c'}
  // ]
  return (
  <div>
    <h4>CreateLunchWithFriends</h4>
    <form
        onSubmit={(event) => {
          // This function just calls the transferTokens callback with the
          // form's data.
          event.preventDefault();
          removeAllChildNodes(document.getElementById('friends'))
          var container= document.createElement("label");
          console.log(friendsList.length)
          for(let i=0;i<friendsList.length;i++){
            var checkbox = document.createElement("input");
            checkbox.type = "checkbox";
            checkbox.id = "friend";
            checkbox.name = "friend";
            checkbox.value = friendsList[i].personalAddress;
            var label = document.createElement("label");
            label.htmlFor = "friend";
            label.appendChild(document.createTextNode(friendsList[i].name));
            var br = document.createElement('br');
            container.appendChild(checkbox);   // add the box to the element
            container.appendChild(label);// add the description to the element
            container.appendChild(br);
          }
          var friendsContainer=document.getElementById('friends');
          friendsContainer.appendChild(container);
        }}
    >
      <div className="form-group" id="split_bills_among_friends">
        <div id="friends"></div>
        <input className="btn btn-primary" type="submit" value="Show Friends List" />
      </div>
    </form>
  </div>
  );
}

function removeAllChildNodes(parent){
  while(parent.firstChild){
    parent.removeChild(parent.firstChild);
  }
}