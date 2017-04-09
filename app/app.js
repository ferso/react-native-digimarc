import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  Button
} from 'react-native';

import {TabNavigator} from 'react-navigation'

import ScanView from './components/ScanView'

class MyHomeScreen extends React.Component {
  static navigationOptions = {
    tabBar: {
      label: 'User',
      // Note: By default the icon is only shown on iOS. Search the showIcon option below.
      icon: ({ tintColor }) => (
        <Image
          source={require('./images/user.png')}
          style={[styles.icon, {tintColor: tintColor}]}
        />
      ),
    },
  }

  render() {
    return (
      <Button
        onPress={() => this.props.navigation.navigate('Scan')}
        title="Go to notifications"
      />
    );
  }
}

const styles = StyleSheet.create({
  icon: {
    width: 26,
    height: 26,
  },
});

export const App = TabNavigator({
  Home: {
    screen: MyHomeScreen,
  },
  Scan: {
    screen: ScanView,
  }
}, {
  tabBarOptions: {
    activeTintColor: '#e91e63',
  },
});
