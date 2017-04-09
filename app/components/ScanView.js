import React, {Component} from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Image,
    Button,
} from 'react-native';

import {requireNativeComponent} from 'react-native';

const ScanViewManager = requireNativeComponent('ScanView', null);

export default class ScanView extends Component {
    static navigationOptions = {
        tabBar: {
            label: 'Scan',
            icon: ({tintColor}) => (
            <Image
                source={require('../images/scan.png')}
                style={[
                styles.icon, {
                    tintColor: tintColor
                }
            ]}/>)
        }
    }

    constructor() {
        super()
        this._onChange = this
            ._onChange
            .bind(this);
    }
    _onChange(event) {
        console.log(JSON.stringify(event))
        debugger
    }
    render() {
        return <ScanViewManager style={{flex: 1, marginTop: 20}} {...this.props} onChange={this._onChange}/>
    }
}

const styles = StyleSheet.create({
  icon: {
    width: 26,
    height: 26,
  },
});