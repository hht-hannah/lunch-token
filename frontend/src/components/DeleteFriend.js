import React from "react";

export function  DeleteFriend({ deleteFriend,personalAddress }) {
  return (
      <div>
        <h4>Delete Friends</h4>
        <form
            onSubmit={(event) => {
              // This function just calls the transferTokens callback with the
              // form's data.
              event.preventDefault();
              const formData = new FormData(event.target);
              const to = formData.get("to");
              if (to) {
                deleteFriend(personalAddress,to)
              }
            }}
        >
          <div className="form-group">
            <label>The address of the friend you want to delete</label>
            <input className="form-control" type="text" name="to" required />
          </div>
          <div className="form-group">
            <input className="btn btn-primary" type="submit" value="Create" />
          </div>
        </form>
      </div>
  );
}
