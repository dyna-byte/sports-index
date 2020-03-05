import actionTypes from '../actionTypes';

const initialState: IWalletStore = {
  loading: false,
  wallet: null,
  transactions: null
};

export default function sessionReducer(state = initialState, action) {
  switch(action.type) {
    case actionTypes.WALLETS_REQUEST:
      return {
        ...state,
        loading: true,
      };
    case actionTypes.WALLETS:
      return {
        ...state,
        loading: false,
        wallet: action.data
      };
    case actionTypes.TRANSACTONS_RESQUEST:
      return {
        ...state,
        transactions: null,
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
  loading: boolean;
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