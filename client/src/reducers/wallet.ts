import actionTypes from '../actionTypes';

const initialState: IWalletStore = {
  wallet: null,
  transactions: null
};

export default function sessionReducer(state = initialState, action) {
  switch(action.type) {
    case actionTypes.WALLETS:
      return {
        ...state,
        loading: false,
        wallet: action.data
      };
    case actionTypes.TRANSACTONS:
      return {
        ...state,
        transactions: action.data,
      };
    default:
      return state;
  }
}

export interface IWalletStore {
  wallet: IWallet | null
  transactions: ITransaction[] | null
}

export interface IWallet {
  value: number
}

export interface ITransaction {
  amount: number,
  source: string
}