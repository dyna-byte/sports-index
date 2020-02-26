import ReduxThunk from 'redux-thunk';
import { createStore, applyMiddleware } from 'redux';
import reducers from './reducers';
import logger from './middlwwares/logger';

const middlewares = [ReduxThunk, logger]

const store = createStore(reducers, undefined, applyMiddleware(...middlewares))

export default store;
