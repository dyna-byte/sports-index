import React from 'react';
import { connect } from 'react-redux';
import { IStore } from '../../reducers';
import { logout } from '../../actions/session';
import { AppBar, makeStyles, Toolbar, IconButton,
   Typography, Button, Drawer, List, ListItem,
    ListItemIcon, ListItemText, SvgIcon } from '@material-ui/core';

// Icons
import DashboardIcon from '@material-ui/icons/Dashboard';
import AccountBalanceIcon from '@material-ui/icons/AccountBalance';
import { Link } from 'react-router-dom';
import { ReactComponent as  ReactLogo } from '../../logo.svg';

const useStyles = makeStyles(theme => ({
  root: {
    flexGlow: 1
  },
  menuButton: {
    marginRight: theme.spacing(2)
  },
  title: {
    flexGrow: 1
  },
  appBar: {
    zIndex: theme.zIndex.drawer + 1
  },
  toolbarIcon: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'flex-end',
    padding: '0 8px',
    ...theme.mixins.toolbar,
  },
  drawerOpen: {
    whiteSpace: 'nowrap',
    overflowX: 'hidden',
    width: theme.spacing(30),
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  drawerClose: {
    whiteSpace: 'nowrap',
    overflowX: 'hidden',
    width: theme.spacing(8),
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
  }
}));
const Navbar = (props) => {
  const classes = useStyles();
  const { isAuthenticated, currentUser, drawerOpen, handleDrawerToggle } = props;

  const handleLogout = () => props.logout();

  return (<nav className={classes.root}>
    <AppBar position="static" className={classes.appBar}>
      <Toolbar>
        <IconButton color="inherit" className={classes.menuButton} aria-label="menu" edge="start"
        onClick={handleDrawerToggle}>
          <SvgIcon component={ReactLogo} viewBox="0 0 12.386 14.359" />
        </IconButton>
        <Typography variant="h6" className={classes.title}>
          Sports Index
        </Typography>
        {isAuthenticated
        ? <Button color="inherit" onClick={handleLogout}>
            Logout { currentUser.name } 
          </Button>
        : <Link to="/login">
            <Button variant="contained" color="inherit">Login</Button> 
          </Link>
        }
      </Toolbar>
    </AppBar>
    <Drawer variant="permanent" open={drawerOpen} 
      classes={{paper: drawerOpen ? classes.drawerOpen : classes.drawerClose}}>
      <div className={classes.toolbarIcon}></div>
      <List>
        <ListItem button>
          <ListItemIcon>
            <DashboardIcon />
          </ListItemIcon>
            <ListItemText primary="Assets" />
        </ListItem>

        <ListItem button component={Link} to="/balance">
          <ListItemIcon>
            <AccountBalanceIcon />
          </ListItemIcon>
            <ListItemText primary="Balance" />
        </ListItem>
      </List>
    </Drawer>
  </nav>)
}

export default connect(
  ({session}: IStore) => ({
    isAuthenticated: session.isAuthenticated,
    currentUser: session.currentUser
  }),
  { logout },
)(Navbar);