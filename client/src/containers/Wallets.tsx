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

function Wallets(props) {
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
      <h1>Wallet</h1>
    </Paper>
  )
}

export default connect(
  ({wallet}: IStore) => ({
    isLoading: wallet.loading,
    wallets: wallet.wallets
  }),
  {  }
)(Wallets);