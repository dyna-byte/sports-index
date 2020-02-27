import React from 'react';
import { connect } from 'react-redux';
import { IStore } from '../../reducers';
import { AppBar, makeStyles, Toolbar, IconButton,
   Typography, Button, Drawer, List, ListItem,
    ListItemIcon, ListItemText } from '@material-ui/core';
import MenuIcon from '@material-ui/icons/Menu';
import DashboardIcon from '@material-ui/icons/Dashboard';

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
    position: 'relative',
    whiteSpace: 'nowrap',
    overflowX: 'hidden',
    width: theme.spacing(7),
    [theme.breakpoints.up('sm')]: {
      width: theme.spacing(9)
    }
  }
}));
const Navbar = (props) => {
  const classes = useStyles();
  const { isAuthenticated } = props;
  const [open, setOpen] = React.useState(false);

  const handleOpen = () => setOpen(!open)

  return (<nav className={classes.root}>
    <AppBar position="static" className={classes.appBar}>
      <Toolbar>
        <IconButton color="inherit" className={classes.menuButton} aria-label="menu" edge="start"
        onClick={handleOpen}>
          <MenuIcon />
        </IconButton>
        <Typography variant="h6" className={classes.title}>
          Sports Index
        </Typography>
        {isAuthenticated
        ? <Button color="inherit">Logout</Button>
        : <Button color="inherit">Login</Button> 
        }
      </Toolbar>
    </AppBar>
    <Drawer variant="permanent" open={open} className={classes.drawerClose}>
      <div className={classes.toolbarIcon}></div>
      <List>
        <ListItem button>
          <ListItemIcon>
            <DashboardIcon />
          </ListItemIcon>
            <ListItemText primary="Assets" />
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
  null,
)(Navbar);