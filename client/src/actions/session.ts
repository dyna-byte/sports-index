import actionTypes from "../actionTypes";
import api from "./api";
import { setToken, removeToken } from "../tools/sessionStore";

/**
 * Log the user in
 */
export function login(data) {
  return dispatch => {
    dispatch({ type: actionTypes.LOGIN_REQUEST });

    return api.post('api/sessions', data)
      .then(async (response) => {
        console.log(response);
        setCurrentUser(response.data);
        dispatch({ type: actionTypes.LOGIN, response: response.data })
      }).catch((err) => {
        dispatch({ type: actionTypes.LOGIN_FAILURE })
      });
  }
}

export function logout() {
  return dispatch => {
    return api.delete('api/sessions')
      .then(async () => {
        setCurrentUser(null);
        dispatch({ type: actionTypes.LOGOUT })
      }).catch((err) => {
        console.error("Failed to log out", err)
      });
  }
}

function setCurrentUser(response) {
  if (response && response.meta && response.meta.token)
    setToken(response.meta.token);
  else
    removeToken();
}