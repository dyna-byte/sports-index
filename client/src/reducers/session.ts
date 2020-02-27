import actionTypes from '../actionTypes';

const initialState: ISessionStore = {
  isAuthenticated: false,
  willAuthenticate: true,
  currentUser: {}
};

export default function sessionReducer(state = initialState, action) {
  switch(action.type) {
    case actionTypes.LOGIN:
      return {
        ...state,
        isAuthenticated: true,
        currentUser: {
          id: 1,
          name: "Arman"
        }
      };
    case actionTypes.LOGOUT:
      return {
        ...state,
        ...initialState
      }
    default:
      return state;
  }
}

export interface ISessionStore {
  isAuthenticated: boolean;
  willAuthenticate: boolean
  currentUser: {
    id: number,
    name: string
  } | {};
}