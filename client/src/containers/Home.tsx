import React from 'react';
import Button from '@material-ui/core/Button';
import { login } from '../actions/session';
import { connect } from 'react-redux';
import { IStore } from '../reducers';

class Home extends React.Component<any, any> {

  handleLogin = data => this.props.login(data)

  render() {
    const { currentUser } = this.props;

    return (
      <div>
        <h1>Home</h1>
        { currentUser && 
        <h2>User: { currentUser.name }</h2>}
        <Button onClick={this.handleLogin}>
          Login
        </Button>
      </div>
    )
  }

}

export default connect(
  ({session}: IStore) => ({
    currentUser: session.currentUser
  }),
  { login }
)(Home);