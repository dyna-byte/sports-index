import actionTypes from '../actionTypes';

const initialState: ISessionStore = {
  isAuthenticated: false,
  isAuthenticating: false,
  willAuthenticate: false,
  currentUser: {}
};

export default function sessionReducer(state = initialState, action) {
  switch(action.type) {
    case actionTypes.LOGIN:
      return {
        ...state,
        isAuthenticated: true,
        currentUser: action.response.user
      };
    case actionTypes.LOGIN_REQUEST:
      return {
        ...state,
        isAuthenticated: false,
        isAuthenticating: true
      };
    case actionTypes.LOGIN_FAILURE:
      return {
        ...state,
        isAuthenticated: false,
        isAuthenticating: false
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
  isAuthenticating: boolean;
  willAuthenticate: boolean
  currentUser: {
    id: number,
    name: string
  } | {};
}