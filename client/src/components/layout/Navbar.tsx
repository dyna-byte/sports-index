import React from 'react';
import { connect } from 'react-redux';
import { IStore } from '../../reducers';
import { logout } from '../../actions/session';
import { AppBar, makeStyles, Toolbar, IconButton,
   Typography, Button, Drawer, List, ListItem,
    ListItemIcon, ListItemText, SvgIcon } from '@material-ui/core';

// Icons
import MenuIcon from '@material-ui/icons/Menu';
import DashboardIcon from '@material-ui/icons/Dashboard';
import AccountBalanceIcon from '@material-ui/icons/AccountBalance';
import { Link } from 'react-router-dom';
import Logo, { ReactComponent as  ReactLogo } from '../../logo.svg';

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
  drawerClose: {
    whiteSpace: 'nowrap',
    overflowX: 'hidden',
    width: theme.spacing(30)
  },
  logo: {
    padding: theme.spacing(1),
  }
}));
const Navbar = (props) => {
  const classes = useStyles();
  const { isAuthenticated, currentUser } = props;
  const [open, setOpen] = React.useState(false);

  const handleOpen = () => setOpen(!open)
  const handleLogout = () => props.logout();

  return (<nav className={classes.root}>
    <AppBar position="static" className={classes.appBar}>
      <Toolbar>
        <IconButton color="inherit" className={classes.menuButton} aria-label="menu" edge="start"
        onClick={handleOpen}>
          <MenuIcon />
        </IconButton>
        <div className={classes.logo}>
          <SvgIcon component={ReactLogo} viewBox="0 0 12.386 14.359" />
        </div>
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
    <Drawer variant="permanent" open={open} classes={{paper: classes.drawerClose}}>
      <div className={classes.toolbarIcon}></div>
      <List>
        <ListItem button>
          <ListItemIcon>
            <DashboardIcon />
          </ListItemIcon>
            <ListItemText primary="Assets" />
        </ListItem>

        <ListItem button>
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