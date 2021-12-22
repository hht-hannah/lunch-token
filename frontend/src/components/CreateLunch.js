import React from "react";

export function CreateLunch({ createLunchEvent, tokenSymbol }) {
  return (
    <div>
      <h4>CreateLunch</h4>
      <form
        onSubmit={(event) => {
          // This function just calls the transferTokens callback with the
          // form's data.
          event.preventDefault();

          const formData = new FormData(event.target);
          const to = formData.get("to");
          const date = formData.get("date");
          const amount = formData.get("amount");

          if (to && date && amount) {
            let to_account = to.split(', ')
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
          <label>People who takes the lunch with you, split using ", "</label>
          <input className="form-control" type="text" name="to" required />
        </div>
        <div className="form-group">
          <input className="btn btn-primary" type="submit" value="Create" />
        </div>
      </form>
    </div>
  );
}
