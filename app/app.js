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
        onPress={() => this.props.navigation.navigate('Notifications')}
        title="Go to notifications"
      />
    );
  }
}

class MyNotificationsScreen extends React.Component {
  static navigationOptions = {
    tabBar: {
      label: 'Scan',
      icon: ({ tintColor }) => (
        <Image
          source={require('./images/scan.png')}
          style={[styles.icon, {tintColor: tintColor}]}
        />
      ),
    },
  }

  render() {
    return (
      <Button
        onPress={() => this.props.navigation.goBack()}
        title="Go back home"
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
  Notifications: {
    screen: MyNotificationsScreen,
  },
}, {
  tabBarOptions: {
    activeTintColor: '#e91e63',
  },
});
