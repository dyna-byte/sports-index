import actionTypes from "../actionTypes";

/**
 * Log the user in
 */
export function login(data) {
  return dispatch => dispatch({
    type: actionTypes.LOGIN,
    data: data
  })
}