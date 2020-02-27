import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';
import Home from './containers/Home';
import Navbar from './components/layout/Navbar';
import { CssBaseline, Container, withStyles } from '@material-ui/core';

const styles = theme => ({
  container: {
    marginLeft: theme.spacing(30)
  }
});

class App extends React.Component<any, any> {

  render() {
    const { classes } = this.props;
    return (
      <BrowserRouter>
        <Navbar />
        <CssBaseline />
        <Container maxWidth="lg" className={classes.container}>
          <Switch>
            <Route exact path="/" component={Home} />
          </Switch>
        </Container>
      </BrowserRouter>
    );
  }
}

export default withStyles(styles)(App);
