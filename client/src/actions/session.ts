import actionTypes from "../actionTypes";
import api from "./api";
import { setToken } from "../tools/sessionStore";

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
      .then(async (response) => {
        setCurrentUser(null);
        dispatch({ type: actionTypes.LOGIN, response: response.data })
      }).catch((err) => {
        dispatch({ type: actionTypes.LOGIN_FAILURE })
      });
  }
}

function setCurrentUser(response) {
  if (response)
    setToken(response.meta.token);
  else
    setToken(undefined);
}