import React from 'react';
import { Route } from 'react-router-dom';
import Home from './Home';
import Navbar from '../components/layout/Navbar';
import { Container, makeStyles } from '@material-ui/core';
import Wallets from './Wallets';

const styles = makeStyles(theme => ({
  container: {
    marginLeft: theme.spacing(30),
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
  },
  containerDrawerClose: {
    marginLeft: theme.spacing(8),
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  }
}));

function Main(props) {
  const classes = styles();

  const [open, setOpen] = React.useState(true)
  const handleDrawerToggle = () => setOpen(!open)

  return (
    <>
      <Navbar drawerOpen={open} handleDrawerToggle={handleDrawerToggle} />
      <Container maxWidth="lg" className={open ? classes.container : classes.containerDrawerClose}>
        <Route exact path="/" component={Home} />
        <Route exact path="/balance" component={Wallets} />
      </Container>
    </>
  );
}

export default Main;
