import React, { useEffect } from 'react';
import { loadWallet, add } from '../actions/wallet';
import { connect } from 'react-redux';
import { Paper, Button, Typography, makeStyles, 
  TextField, InputAdornment, ButtonGroup, FormControl } from '@material-ui/core';
import { IStore } from '../reducers';
import clsx from '../tools/clsx';

const useStyles = makeStyles(theme => ({
  wallet: {
    marginTop: theme.spacing(2),
  }
}))

function Wallets(props) {
  const classes = useStyles();

  useEffect(() => {
    props.loadWallet();
  }, [])

  const add = (amount) => props.add(amount);

  return (
    <Paper className={clsx("paper", classes.wallet)}>
      <Typography variant="h5">
        Wallet
      </Typography>
      { !props.loading && props.wallet ?
        <form noValidate autoComplete="off">
          <TextField label="" margin="normal" variant="filled" disabled fullWidth
            value={props.wallet.value}
            size="small"
            InputProps={{
              startAdornment: <InputAdornment position="start">£</InputAdornment>
            }} />
          <div>
            <ButtonGroup color="primary" variant="contained" fullWidth>
              {[10, 20, 50, 100, 200, 400, 600, 1000]
              .map((amount) => 
                <Button key={amount} color="primary" onClick={() => add(amount)} >Add {amount}</Button>
              )
              }
            </ButtonGroup>
          </div>
        </form>
        : <Typography variant="h6">Loading ...</Typography>
      }
    </Paper>
  )
}

export default connect(
  ({wallet}: IStore) => ({
    loading: wallet.loading,
    wallet: wallet.wallet
  }),
  { loadWallet, add }
)(Wallets);