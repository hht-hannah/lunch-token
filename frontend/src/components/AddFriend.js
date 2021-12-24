import React from "react";

export function  AddFriend({ addFriend,personalAddress }) {
  return (
      <div>
        <h4>Add Friends</h4>
        <form
            onSubmit={(event) => {
              // This function just calls the transferTokens callback with the
              // form's data.
              event.preventDefault();
              const formData = new FormData(event.target);
              const to = formData.get("to");
              const name = formData.get("nickname");
              if (to && name) {
                addFriend(personalAddress,to,name)
              }
            }}
        >
          <div className="form-group">
            <label>The address of the friend you want to connect</label>
            <input className="form-control" type="text" name="to" required />
          </div>
          <div className="form-group">
            <label>The nickname of the friend you want to connect</label>
            <input className="form-control" type="text" name="nickname" required />
          </div>
          <div className="form-group">
            <input className="btn btn-primary" type="submit" value="Create" />
          </div>
        </form>
      </div>
  );
}
