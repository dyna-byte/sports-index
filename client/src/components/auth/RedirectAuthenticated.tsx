import React from 'react';
import { Route, Redirect } from 'react-router-dom';
import { queryString } from '../../tools/http';


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
      const redirect: string = queryString(props.location.search).redirect;
      if (isAuthenticated) { return <Redirect to={redirect || '/'} />; }
      if (willAuthenticate) { return null; }
      if (!willAuthenticate && !isAuthenticated) { return <Component {...props} />; }
      return null;
    }}
  />;

export default RedirectAuthenticated;