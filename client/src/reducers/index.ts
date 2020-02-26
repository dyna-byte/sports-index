import { combineReducers } from 'redux';
import session from './session';

const reducers = combineReducers({
  session
});

export default function (state, action) {
  return reducers(state, action);
}

export interface IStore { 
  session: any
}