import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';
import Home from './containers/Home';
import Navbar from './components/layout/Navbar';
import { CssBaseline, Container, withStyles } from '@material-ui/core';
import { IStore } from './reducers';
import { connect } from 'react-redux';
import Login from './containers/Login';
import RedirectAuthenticated from './components/auth/RedirectAuthenticated';

const styles = theme => ({
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
        <Navbar />
        <CssBaseline />
        <Container maxWidth="lg" className={classes.container}>
          <Switch>
            <Route exact path="/" component={Home} />
            <RedirectAuthenticated exact path="/login" component={Login} {...authProps }/>
          </Switch>
        </Container>
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
