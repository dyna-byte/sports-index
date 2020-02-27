import React from 'react';
import { Route, Redirect } from 'react-router-dom';


const RedirectAuthenticated = ({
  path,
  exact,
  isAuthenticated,
  willAuthenticate,
  component: Component,
}) =>
  <Route
    exact={exact}
    path={path}
    render={(props) => {
      if (isAuthenticated) { return <Redirect to={'/'} />; }
      if (willAuthenticate) { return null; }
      if (!willAuthenticate && !isAuthenticated) { return <Component {...props} />; }
      return null;
    }}
  />;

export default RedirectAuthenticated;