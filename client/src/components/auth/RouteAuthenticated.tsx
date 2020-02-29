import React from 'react';
import { Route, Redirect } from 'react-router-dom';


const RouteAuthenticated = ({
  path,
  exact,
  isAuthenticated,
  willAuthenticate,
  children,
}) =>
  <Route
    exact={exact}
    path={path}
    render={(props) => {
      if (isAuthenticated) { return children; }
      if (willAuthenticate) { return null; }
      if (!willAuthenticate && !isAuthenticated) {
         return <Redirect to={`/login?redirect=${encodeURIComponent(props.location.pathname)}` } />; 
      }
      return null;
    }}
  />;

export default RouteAuthenticated;