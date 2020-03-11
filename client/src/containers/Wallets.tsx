import React from 'react';
import { loadWallet, add, loadTransactions } from '../actions/wallet';
import { connect } from 'react-redux';
import { Paper, Button, Typography, makeStyles, 
  TextField, InputAdornment, ButtonGroup } from '@material-ui/core';
import { IStore } from '../reducers';
import clsx from '../tools/clsx';
import Transactions from 'src/components/Transactions';
import useMount from 'src/hooks/useMount';
import Loading from 'src/components/progress/Loading';

const useStyles = makeStyles(theme => ({
  wallet: {
    marginTop: theme.spacing(2),
  }
}))

function Wallets(props) {
  const classes = useStyles();

  const { isLoading } = useMount(() =>
    Promise.all([
      props.loadWallet(),
      props.loadTransactions(),
    ])
  )

  const add = (amount) => props.add(amount);

  return (
    <>
    <Paper className={clsx("paper", classes.wallet)}>
      <Typography variant="h5">
        Wallet
      </Typography>
      { !isLoading && props.wallet ?
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
        : <Loading />
      }
    </Paper>
    <Transactions transactions={props.transactions} />
    </>
  )
}

export default connect(
  ({wallet}: IStore) => ({
    wallet: wallet.wallet,
    transactions: wallet.transactions
  }),
  { loadWallet, add, loadTransactions }
)(Wallets);