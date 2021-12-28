import React from "react";

export function  CreateLunchSplitWithFriends({ createLunchEvent, tokenSymbol }) {
  return (
      <div>
        <h4>CreateLunchWithFriends</h4>
        <form
            onSubmit={(event) => {
              // This function just calls the transferTokens callback with the
              // form's data.
              event.preventDefault();

              const formData = new FormData(event.target);
              const date = formData.get("date");
              const amount = formData.get("amount");
              const checkboxes = document.querySelectorAll('input[name="friend"]:checked');
              let to_account = [];
              checkboxes.forEach((checkboxes)=>{
                to_account.push(checkboxes.value);
                console.log(checkboxes.value);
              })
              if ( date && amount) {
                createLunchEvent(to_account, date, amount);
              }
            }}
        >
          <div className="form-group">
            <label>Amount of {tokenSymbol}</label>
            <input
                className="form-control"
                type="number"
                step="1"
                name="amount"
                placeholder="1"
                required
            />
          </div>
          <div className="form-group">
            <label>Date</label>
            <input className="form-control" type="text" name="date" required />
          </div>
          <div className="form-group">
            <input className="btn btn-primary" type="submit" value="Create" />
          </div>
        </form>
      </div>
  );
}
