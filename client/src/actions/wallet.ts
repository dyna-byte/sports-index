import actionTypes from "../actionTypes";
import api from "./api";

/**
 * Load user wallet information
 */
export function loadWallet() {
  return dispatch => {
    dispatch({ type: actionTypes.WALLETS_REQUEST });

    return api.get('api/wallets')
      .then(async (response) => {
        dispatch({ type: actionTypes.WALLETS, data: response.data })
      }).catch((err) => {
        console.error("Failed to load wallets", err);
      });
  }
}

/**
 * add an amount to the wallet
 * @param amount number
 */
export function add(amount) {
  return dispatch => {
    dispatch({ type: actionTypes.WALLETS_REQUEST });

    return api.post('api/wallets/add', { amount })
      .then(async (response) => {
        dispatch({ type: actionTypes.WALLETS, data: response.data })
      }).catch((err) => {
        console.error("Failed to load wallets", err);
      });
  }
}
