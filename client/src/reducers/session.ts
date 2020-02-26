import actionTypes from '../actionTypes';

const initialState = {
  isAuthenticated: false,
  currentUser: {}
};

export default function(state = initialState, action) {
  switch(action.type) {
    case actionTypes.LOGIN:
      return {
        ...state,
        isAuthenticated: true,
        currentUser: {
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