import actionTypes from '../actionTypes';

const initialState: ISessionStore = {
  isAuthenticated: false,
  isAuthenticating: false,
  willAuthenticate: false, // currently unused, maybe delete
  error: null,
  currentUser: {}
};

export default function sessionReducer(state = initialState, action) {
  switch(action.type) {
    case actionTypes.LOGIN:
      return {
        ...state,
        isAuthenticated: true,
        isAuthenticating: false,
        currentUser: action.data.user
      };
    case actionTypes.LOGIN_REQUEST:
      return {
        ...state,
        error: null,
        isAuthenticated: false,
        isAuthenticating: true
      };
    case actionTypes.LOGIN_FAILURE:
      return {
        ...state,
        isAuthenticated: false,
        isAuthenticating: false,
        error: "Failed to login"
      };
    case actionTypes.SIGNUP:
      return {
        ...state,
        isAuthenticated: true,
        currentUser: action.data.user
      };
    case actionTypes.SIGNUP_REQUEST:
      return {
        ...state,
        error: null,
        isAuthenticated: false,
        isAuthenticating: true
      };
    case actionTypes.SIGNUP_FAILURE:
      return {
        ...state,
        isAuthenticated: false,
        isAuthenticating: false,
        error: "Failed to signup"
      };
    case actionTypes.REFRESH_REQUEST:
      return {
        ...state,
        error: null,
        isAuthenticated: false,
        isAuthenticating: true
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
  error: any;
  willAuthenticate: boolean;
  currentUser: {
    id: number,
    name: string
  } | {};
}