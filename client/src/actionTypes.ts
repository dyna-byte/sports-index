const actionTypes = {
  LOGIN: undefined,
  LOGOUT: undefined
}

for (let key in actionTypes) {
  actionTypes[key] = key;
}

export default Object.freeze(actionTypes);


