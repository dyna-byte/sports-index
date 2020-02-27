const actionTypes = {
  LOGIN: "",
  LOGIN_REQUEST: "",
  LOGIN_FAILURE: "",
  LOGOUT: ""
}

for (let key in actionTypes) {
  actionTypes[key] = key;
}

export default Object.freeze(actionTypes);


