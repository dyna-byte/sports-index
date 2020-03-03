import { combineReducers } from 'redux';
import session, { ISessionStore } from './session';
import wallet, { IWalletStore } from './wallet';

const reducers = combineReducers({
  session,
  wallet
});

export default function (state, action) {
  return reducers(state, action);
}

export interface IStore { 
  session: ISessionStore
  wallet: IWalletStore
}