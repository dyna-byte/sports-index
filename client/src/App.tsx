import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';
import Home from './containers/Home';
import Navbar from './components/layout/Navbar';
import { CssBaseline, Container, withStyles } from '@material-ui/core';
import { IStore } from './reducers';
import { connect } from 'react-redux';
import Login from './containers/Login';
import RedirectAuthenticated from './components/auth/RedirectAuthenticated';
import Signup from './containers/Signup';
import RouteAuthenticated from './components/auth/RouteAuthenticated';

const styles = theme => ({
  emptyContainer: {
    paddingTop: theme.spacing(6)
  },
  container: {
    marginLeft: theme.spacing(30)
  }
});

class App extends React.Component<any, any> {

  render() {
    const { classes, isAuthenticated, willAuthenticate } = this.props;
    const authProps = { isAuthenticated, willAuthenticate };
    return (
      <BrowserRouter>
        <CssBaseline />
        <Switch>
          <Route path={["/login", "/signup"]}>
            <Container maxWidth="sm" className={classes.emptyContainer}>
              <RedirectAuthenticated exact path="/login" component={Login} {...authProps }/>
              <RedirectAuthenticated exact path="/signup" component={Signup} {...authProps }/>
            </Container>
          </Route>
          <RouteAuthenticated exact={false} path="/" {...authProps}>
            <>
              <Navbar />
              <Container maxWidth="lg" className={classes.container}>
                <Route exact path="/" component={Home} />
              </Container>
            </>
          </RouteAuthenticated>
        </Switch>
      </BrowserRouter>
    );
  }
}

export default withStyles(styles)(connect(
  ({session}: IStore) => ({
    isAuthenticated: session.isAuthenticated,
    willAuthenticate: session.willAuthenticate
  })
)(App));
