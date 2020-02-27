import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';
import Home from './containers/Home';
import Navbar from './components/layout/Navbar';
import { CssBaseline, Container } from '@material-ui/core';

class App extends React.Component {

  render() {
    return (
      <BrowserRouter>
        <Navbar />
        <CssBaseline />
        <Container maxWidth="lg">
          <Switch>
            <Route exact path="/" component={Home} />
          </Switch>
        </Container>
      </BrowserRouter>
    );
  }
}

export default App;
