import React from 'react';
import { signup } from '../actions/session';
import { connect } from 'react-redux';
import { Paper, Button, Typography, makeStyles, Divider } from '@material-ui/core';
import { Form, Field } from 'react-final-form';
import FormTextField from '../components/form/FormTextField';
import { validator, validators } from '../tools/validation';
import { IStore } from '../reducers';
import { Link } from 'react-router-dom';

const useStyles = makeStyles(theme => ({
  form: {
    margin: theme.spacing(1)
  },
  divider: {
    marginTop: theme.spacing(1),
    marginBottom: theme.spacing(1),
  }
}))

function Signup(props) {
  const onSubmit = data => props.signup(data)
  const classes = useStyles();

  const { required, min, email } = validators;
  const validate = validator([
    { field: 'name', validators: [ required() ] },
    { field: 'email', validators: [ required(), email() ] },
    { field: 'password', validators: [ required(), min(6) ] },
  ]);

  return (
    <Paper className="paper">
      <Form
        onSubmit={onSubmit}
        validate={validate}
        render={({handleSubmit}) => (
          <form onSubmit={handleSubmit} className={classes.form}>
            <Typography variant="h5">
              Signup
            </Typography>
            <Field name="name"
             component={FormTextField} label="Name" autoComplete="name" 
             margin="normal" variant="outlined" fullWidth />

            <Field name="email"
             component={FormTextField} label="Email" autoComplete="email" 
             margin="normal" variant="outlined" fullWidth />

            <Field name="password"
             component={FormTextField} label="Password"
             margin="normal" variant="outlined" fullWidth type="password" />

            <Button type="submit" color="primary" fullWidth variant="contained"
             {...{disabled: props.isAuthenticating}}> 
              { props.isAuthenticating ? "Signing you up ..." : "Signup" }
            </Button>
            <Divider className={classes.divider} />
            <Link to="/login">
              <Button variant="contained" color="inherit" fullWidth>Login</Button> 
            </Link>
          </form>
        )}
      />
    </Paper>
  )
}

export default connect(
  ({session}: IStore) => ({
    isAuthenticating: session.isAuthenticating
  }),
  { signup }
)(Signup);