const actionTypes = {
  // Session
  LOGIN: "",
  LOGIN_REQUEST: "",
  LOGIN_FAILURE: "",
  SIGNUP: "",
  SIGNUP_REQUEST: "",
  SIGNUP_FAILURE: "",
  REFRESH_REQUEST: "",
  LOGOUT: "",
  WALLETS_REQUEST: "",
  WALLETS: "",
  TRANSACTONS_RESQUEST: "",
  TRANSACTONS: "",
}

for (let key in actionTypes) {
  actionTypes[key] = key;
}

export default Object.freeze(actionTypes);


