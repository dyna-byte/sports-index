const actionTypes: {[type: string]: string} = {
  LOGIN: "",
  LOGOUT: ""
}

for (let key in actionTypes) {
  actionTypes[key] = key;
}

export default Object.freeze(actionTypes);


