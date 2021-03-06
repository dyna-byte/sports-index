import React from 'react';
import { Paper, Typography, makeStyles, 
  TableContainer, Table, TableHead, TableRow,
   TableCell, TableBody } from '@material-ui/core';
import clsx from '../tools/clsx';
import Loading from './progress/Loading';

const useStyles = makeStyles(theme => ({
  transaction: {
    marginTop: theme.spacing(2),
  },
  tableContainer: {
    maxHeight: 500
  },
  positive: {
    color: 'green',
    '&:after': {
      content: '"\\25B2"',
      paddingLeft: theme.spacing(1)
    }
  },
  negative: {
    color: 'red',
    '&:after': {
      content: '"\\25BC"',
      paddingLeft: theme.spacing(1)
    }
  }
}))

function Transactions(props) {
  const classes = useStyles();

  const { transactions } = props;
  const cols = [
    {id: 'id', label: 'ID' },
    {id: 'inserted_at', label: 'Date' },
    {id: 'source', label: 'Source' },
    {id: 'amount', label: 'Amount', align: 'right',
     format: (value: number) => `£${value.toLocaleString()}`,
     classes: (value: number) => value > 0 ? classes.positive : classes.negative
     },
  ];

  return (
    <Paper className={clsx("paper", classes.transaction)}>
      <Typography variant="h5">
        Transactions
      </Typography>
      { !transactions 
        ? <Loading />
        : transactions.length < 1 
        ? <Typography variant="h6">No Transactions found!</Typography>
        :
        <>
          <TableContainer className={classes.tableContainer}>
            <Table stickyHeader>
              <TableHead>
                <TableRow>
                  {cols.map(col =>(
                    <TableCell key={col.id} align={(col.align as any)}>{col.label}</TableCell>
                  ))}
                </TableRow>
              </TableHead>
              <TableBody>
                {transactions.map(t => (
                  <TableRow hover key={t.id} >
                    {cols.map(col => (
                      <TableCell key={col.id} align={col.align as any}
                       {...(col.classes && {className: col.classes(t[col.id])})}>
                        {col.format ? col.format(t[col.id]) : t[col.id]}
                      </TableCell>
                    ))}
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </>
      }
    </Paper>
  )
}

export default Transactions;