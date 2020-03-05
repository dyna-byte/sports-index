import actionTypes from '../actionTypes';

const initialState: IWalletStore = {
  loading: false,
  wallet: null
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
    default:
      return state;
  }
}

export interface IWalletStore {
  loading: boolean;
  wallet: IWallet | null
}

export interface IWallet {
  value: number
}