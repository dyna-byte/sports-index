import actionTypes from "../actionTypes";
import api from "./api";

/**
 * Load user wallet information
 */
export function loadWallet() {
  return dispatch => {
    return api.get('api/wallets')
      .then(async (response) => {
        dispatch({ type: actionTypes.WALLETS, data: response.data })
      });
  }
}

/**
 * Load user wallet's transactions
 */
export function loadTransactions() {
  return dispatch => {
    return api.get('api/wallets/transactions')
      .then(async (response) => {
        dispatch({ type: actionTypes.TRANSACTONS, data: response.data })
      });
  }
}

/**
 * add an amount to the wallet
 * @param amount number
 */
export function add(amount) {
  return dispatch => {
    return api.post('api/wallets/add', { amount })
      .then(async (response) => {
        dispatch({ type: actionTypes.WALLETS, data: response.data })

        // re-load transactions
        dispatch(loadTransactions());
      });
  }
}
