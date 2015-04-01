/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
    AppRegistry,
    StyleSheet,
    Text,
    TextInput,
    View,
    TouchableHighlight
} = React;


var {
    MCFileWriterUtil
} = require('NativeModules');

// // Step #1
// (function() {
//     var fileContents = Math.random().toString();

//     // MCFileWriterUtil.writeFile(
//     MCFileWriterUtil.readFile(
//         'MyFile.txt',
//         // fileContents,
//         function errorCallback(results) {
//             results = JSON.parse(results);

//             // alert('Error: ' + results.errMsg);
//         },
//         function successCallback(results) {
//             results = JSON.parse(results);

//             // alert('Success : ' + results.contents);
//         }
//     );
// })();



var CustomComponent = React.createClass({
    textInputValue : null,
    
    getInitialState : function() {
        return {
            resultsText : 'Nothing has happened yet :('
        }
    },

    onSavePress : function() {
        var me           = this,
            fileName     = this.textInputValue,
            fileContents = Math.random().toString();

        MCFileWriterUtil.writeFile(
            fileName,
            fileContents,
            function errorCallback(results) {
                results = JSON.parse(results);

                alert('Error: ' + results.errMsg);
            },
            function successCallback(results) {
                results = JSON.parse(results);
                var resultsText = 'Saved to ' + fileName + '. Press load to see contents.';

                me.setState({
                    resultsText : resultsText
                });
            }
        );
    },
    onLoadPress : function() {
        var me = this;
        MCFileWriterUtil.readFile(
            me.textInputValue,
            function errorCallback(results) {
                results = JSON.parse(results);

                alert('Error: ' + results.errMsg);
            },
            function successCallback(results) {
                results = JSON.parse(results);
                var resultsText = 'Contents of ' + me.textInputValue 
                                + ' ' + results.contents;
                me.setState({
                    resultsText : resultsText
                });
            }
        );

    },
    
    onTextInputChange : function(event) {
        this.textInputValue = event.nativeEvent.text;
    },

    render: function() {
        var state = this.state;

        return (
            <View style={styles.container}>
                <Text style={styles.instructionsText}>
                    Custom React Native Utility Demo
                </Text>
                <View style={styles.separator}/>


                <View style={styles.labelContainer}>
                    <Text style={styles.labelText}>
                        File Name : 
                    </Text>
                    <TextInput
                        placeHolder="Test placeHolder"
                        autoCapitalize="sentences"
                        style={styles.textInput}
                        ref="textInput"
                        onChange={this.onTextInputChange}
                    />
                </View>
                <View style={styles.buttonContainer}> 
                    <TouchableHighlight 
                        style={styles.touchableHighlight} 
                        underlayColor="#99AA99" 
                        onPress={this.onLoadPress}>
                            <View style={[styles.buttonBox, styles.loadButtonBox]}>
                                <Text style={styles.buttonText}>
                                    Load
                                </Text>
                            </View>
                    </TouchableHighlight>

                    <TouchableHighlight 
                            underlayColor="#AA9999"
                            onPress={this.onSavePress}>
                                <View style={[styles.buttonBox, styles.saveButtonBox]}>
                                    <Text style={styles.buttonText}>
                                        Save
                                    </Text>
                                </View>
                    </TouchableHighlight>
                </View>
                <View style={styles.outputContainer}>
                    <Text style={styles.outputText} ref="outputContainer">
                        {state.resultsText}
                    </Text>

                </View>

             
            
            </View>
        );
      }
});

var styles = StyleSheet.create({    
    container: {  
        flex            : 1,
        alignItems      : 'center',
        backgroundColor : '#F5FCFF',
        paddingTop      : 30
    },

    instructionsText : {
        fontSize : 20
    },

    separator : {
        borderWidth  : .5,
        borderColor  : '#AEAEAE',
        height       : 1,
        width        : 300,
        marginBottom : 25
    },

    labelContainer : {
        flexDirection  : 'row',
        width          : 300
    },

    labelText : {
        paddingRight   : 10,
        fontSize       : 18
    },
    
    textInput : {
        height      : 26,
        borderWidth : 0.5,
        borderColor : '#0f0f0f',
        padding     : 4,
        flex        : 1,
        fontSize    : 13,
    },

    buttonContainer : {
        flexDirection : 'row',
        justifyContent  : 'center',
        alignItems      : 'center',
        marginTop       : 20
    },
    touchableHighlight : {
        marginLeft : 10,
        marginRight
         : 10,
    },
    buttonBox : {
        flexDirection  : 'row',
        justifyContent : 'center',
        alignItems     : 'center',
        padding        : 10,
        borderWidth    : 2,
        borderRadius   : 5
    },

    saveButtonBox : {
        borderColor : '#AA0000'
    },
    loadButtonBox : {
        borderColor : '#00AA00'
    },

    buttonText : {
        fontSize : 16,
    },

    outputContainer : {
        width          : 300,
        height         : 200,
        justifyContent : 'center',
        alignItems     : 'center',
        borderWidth    : .5,
        borderColor    : "#999999",
        marginTop      : 20
    }
});

AppRegistry.registerComponent('CustomComponent', () => CustomComponent);
