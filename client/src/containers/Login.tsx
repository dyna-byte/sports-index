import React from 'react';
import { login } from '../actions/session';
import { connect } from 'react-redux';
import { Paper, Button, Typography, makeStyles } from '@material-ui/core';
import { Form, Field } from 'react-final-form';
import FormTextField from '../components/form/FormTextField';
import { validator } from '../tools/validation';
import { IStore } from '../reducers';

const useStyles = makeStyles(theme => ({
  form: {
    margin: theme.spacing(1)
  }
}))

function Login(props) {
  const onSubmit = data => props.login(data)
  const classes = useStyles();

  const validate = validator([
    { field: 'email', required: true },
    { field: 'password', required: true },
  ]);

  return (
    <Paper className="paper">
      <Form
        onSubmit={onSubmit}
        validate={validate}
        render={({handleSubmit}) => (
          <form onSubmit={handleSubmit} className={classes.form}>
            <Typography variant="h5">
              Login
            </Typography>
            <Field name="email"
             component={FormTextField} label="Email" autoComplete="email" 
             margin="normal" variant="outlined" fullWidth />

            <Field name="password"
             component={FormTextField} label="Password"
             margin="normal" variant="outlined" fullWidth type="password" />

            <Button type="submit" color="primary" fullWidth variant="contained"
             {...{disabled: props.isAuthenticating}}> 
              { props.isAuthenticating ? "Logging in ..." : "Login" }
            </Button>
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
  { login }
)(Login);