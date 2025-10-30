import QtQuick 2.8
import QtQuick.Controls 2.8
import QtQuick.Controls 1.4 as Q1
import QtQuick.Controls.Styles 1.4
import SddmComponents 2.0
import "."
Rectangle {
    id : container
    LayoutMirroring.enabled : Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit : true
    property int sessionIndex : session.index

    //SET DEFAULTS
    property int defaultscale : setdefaultScale()


    property int targetscreenwidth : container.width
    property int targetscreenheight : container.height

    property int defaultscreenwidth : 1920 * defaultscale
    property int defaultscreenheight : 1200 * defaultscale

    property int defaultcharwidth : 8 * defaultscale
    property int defaultcharheight : 8 * defaultscale

    property string doscolor : "#9effe9"
    property string dosblack : "#000000"


    //Background Settings
    property string borderimage : "Background.png"


    //FONT SECTION (1 px = .75 pt)
    property string fontstyle : "wartext.ttf"
    property int dosfontsize : 20 * defaultscale


    //Wecome Text
    property int welcometoppadding : 50 * defaultscale
    property int welcomeleftpadding : 50 * defaultscale
    property string welcometext : "TRZ. 34/53/76\nACTIVE PORTS: 34,53,75,94\n#45/34/53  ALT MODE FUNCT: PV-8-AY345  STANDBY MODE ACTIVE\n#543.654\n\n-:LOGON REQUIRED:-\n\n"
    property bool welcometextvisible : true


    //Username
    property int usernametoppadding : 250 * defaultscale
    property int usernameleftpadding : 150 * defaultscale
    property int usernamewidth : 200 * defaultscale
    property int usernameheight : 50 * defaultscale
    property string usernametext : "USERNAME:"
    property bool usernametextvisible : true


    //Username Box
    property int usernameboxtoppadding : 238 * defaultscale
    property int usernameboxleftpadding : 240 * defaultscale
    property int usernameboxwidth : 200 * defaultscale
    property int usernameboxheight : 50 * defaultscale
    property string usernameboxtextboximage : ""


    //Password
    property int passwordtoppadding : 325 * defaultscale
    property int passwordleftpadding : 150 * defaultscale
    property string passwordtext : "PASSWORD:"


    //Password Box
    property int passwordboxtoppadding : 315 * defaultscale
    property int passwordboxleftpadding : 240 * defaultscale
    property int passwordboxwidth : 400 * defaultscale
    property int passwordboxheight : 40 * defaultscale


    //Login Button
    property int loginbuttontoppadding : 400 * defaultscale
    property int loginbuttonleftpadding : 150 * defaultscale
    property int loginbuttonimagewidth : 100 * defaultscale
    property int loginbuttonimageheight : 50 * defaultscale
    property string logintbuttonup : "None.svg"
    property string loginbuttondown : "None.svg"
    property string loginbuttonhover : "None.svg"
    property string loginbuttontext : "LOGIN"
    property string loginbuttoncolor : doscolor


    //RESTART BUTTON SECTION
    property int restartbuttontoppadding : 400 * defaultscale
    property int restartbuttonleftpadding : 300 * defaultscale
    property int restartbuttonimagewidth : 100 * defaultscale
    property int restartbuttonimageheight : 50 * defaultscale
    property string restartbuttonup : "None.svg"
    property string restartbuttondown : "None.svg"
    property string restartbuttonhover : "None.svg"
    property string restartbuttontext : "RESTART"
    property string restartbuttoncolor : doscolor
    property int restartbuttonfontsize : 20 * defaultscale


    //SHUTDOWN BUTTON SECTION
    property int shutdownbuttontoppadding : 400 * defaultscale
    property int shutdownbuttonleftpadding : 450 * defaultscale
    property int shutdownbuttonimagewidth : 100 * defaultscale
    property int shutdownbuttonimageheight : 50 * defaultscale
    property string shutdownbuttonup : "None.svg"
    property string shutdownbuttondown : "None.svg"
    property string shutdownbuttonhover : "None.svg"
    property string shutdownbuttontext : "SHUTDOWN"
    property string shutdownbuttoncolor : doscolor
    property int shutdownbuttonfontsize : 20 * defaultscale


    //COMBOBOX
    property int comboboxtoppadding : 390 * defaultscale
    property int comboboxleftpadding : 600 * defaultscale
    property string comboboxcolor : dosblack
    property string comboboxbordercolor : dosblack
    property string comboboxhovercolor : dosblack
    property string comboboxfocuscolor : dosblack
    property string comboboxtextcolor : doscolor
    property string comboboxmenucolor : dosblack
    property string comboboxarrowcolor : "transparent"
    property int comboboxwidth : 170 * defaultscale
    property int comboboxheight : 50 * defaultscale
    property string comboboximage : "Arrow.svg"
    property int comboboxfontsize : 20 * defaultscale
    property bool comboboxvisible : true


    //Set Scale
    function setdefaultScale()
    {
        var setscale = 1

        //Set UHD
        if (container.width > 1920)
        {
            setscale = 2
        }

        return setscale
    }


    TextConstants {
        id : textConstants
    }

    FontLoader {
        id : loginfont
        source : fontstyle
    }

    Connections {
        target : sddm
        onLoginSucceeded : {
            errorMessage.color = "green"
            errorMessage.text = textConstants.loginSucceeded
        }
        onLoginFailed : {
            password.text = ""
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginFailed
            errorMessage.bold = true
        }
    }
    color : doscolor
    anchors.fill : parent

    Background {
        anchors.fill: parent
        source: borderimage
        fillMode: Image.Stretch
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }


    //Welcome Message
    Column {
        id : entryColumn1
        anchors.left : parent.left
        topPadding : welcometoppadding
        leftPadding : welcomeleftpadding
        Text {
                color : doscolor
                text : welcometext
                visible : welcometextvisible
                font.family : loginfont.name
                font.italic : false
                font.pointSize : dosfontsize
        }
    }

        //Username
        Column {
        id : entryColumn2
        anchors.left : parent.left
        topPadding : usernametoppadding
        leftPadding : usernameleftpadding

        Text {
                color : doscolor
                text : usernametext
                visible : usernametextvisible
                font.family : loginfont.name
                font.italic : false
                font.pointSize : dosfontsize
        }
    }

        //Username Box
        Column {
        id : entryColumn3
        anchors.left : parent.left
        topPadding : usernameboxtoppadding
        leftPadding : usernameboxleftpadding

        TextField {
                    id : name
                    font.family : loginfont.name
                    font.italic : false
                    width : usernameboxwidth
                    height : usernameboxheight
                    text : userModel.lastUser
                    font.pointSize : dosfontsize
                    //verticalAlignment : Text.verticalAlignment
                    color : doscolor
                    background : Image {
                        source : usernameboxtextboximage
                    }
                    KeyNavigation.tab : password
                    Keys.onPressed : {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            password.focus = true
                            event.accepted = true
                        }
                    }
        }
    }


        //Password Text
        Column {
            id : entryColumn4
            anchors.left : parent.left
            topPadding : passwordtoppadding
            leftPadding : passwordleftpadding

            Text {
                color : doscolor
                text : passwordtext
                visible : true
                font.family : loginfont.name
                font.italic : false
                font.pointSize : dosfontsize
            }
        }


        //Password Box
        Column {
            id : entryColumn5
            anchors.left : parent.left
            topPadding : passwordboxtoppadding
            leftPadding : passwordboxleftpadding

                TextField {
                    id : password
                    font.family : loginfont.name
                    font.italic : false
                    width : passwordboxwidth
                    height : passwordboxheight
                    echoMode : TextInput.Password
                    font.pointSize : 15
                    //verticalAlignment : Text.verticalAlignment
                    color : doscolor
                    background : Image {
                        source : passwordtextboximage
                    }
                    KeyNavigation.backtab : name
                    KeyNavigation.tab : loginButton
                    focus : true
                    Keys.onPressed : {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(name.text, password.text, sessionIndex)
                            event.accepted = true
                        }
                    }
                }
        }


            //Login Button
            Column {
                    id : entryColumn7
                    anchors.left : parent.left
                    topPadding : loginbuttontoppadding
                    leftPadding : loginbuttonleftpadding

                    Image {
                            id : loginButton
                            source : loginbuttonup
                            width : loginbuttonimagewidth
                            height : loginbuttonimageheight
                            visible : true
                            //anchors.right : parent.right

                            MouseArea {
                                        //anchors.fill : parent
                                        hoverEnabled : true

                                        onEntered : {
                                                        parent.source = loginbuttonhover
                                        }
                                        onExited : {
                                                        parent.source = loginbuttonup
                                        }
                                        onPressed : {
                                                        parent.source = loginbuttondown
                                                        sddm.login(name.text, password.text, sessionIndex)
                                        }
                                        onReleased : {
                                                        parent.source = loginbuttonup
                                        }
                            }

                            Text {
                                        text : loginbuttontext
                                        //anchors.centerIn : parent
                                        font.family : loginfont.name
                                        font.italic : false
                                        font.pointSize : dosfontsize
                                        color: doscolor
                            }

                            KeyNavigation.backtab : password
                            KeyNavigation.tab : restartButton
                    }
            }



            //Restart Button
            Column {
                    id : entryColumn8
                    anchors.left : parent.left
                    topPadding : restartbuttontoppadding
                    leftPadding : restartbuttonleftpadding

                    Image {
                            id : restartButton
                            source : restartbuttonup
                            width : restartbuttonimagewidth
                            height : restartbuttonimageheight
                            visible : true
                            //anchors.right : parent.right

                            MouseArea {
                                        //anchors.fill : parent
                                        hoverEnabled : true

                                        onEntered : {
                                                        parent.source = restartbuttonhover
                                        }
                                        onExited : {
                                                        parent.source = restartbuttonup
                                        }
                                        onPressed : {
                                                        parent.source = restartbuttondown
                                                        sddm.login(name.text, password.text, sessionIndex)
                                        }
                                        onReleased : {
                                                        parent.source = restartbuttonup
                                        }
                            }

                            Text {
                                        text : restartbuttontext
                                        //anchors.centerIn : parent
                                        font.family : loginfont.name
                                        font.italic : false
                                        font.pointSize : dosfontsize
                                        color: doscolor
                            }

                            KeyNavigation.backtab : password
                            KeyNavigation.tab : shutdownButton
                    }
            }




            //Shutdown Button
            Column {
                    id : entryColumn9
                    anchors.left : parent.left
                    topPadding : shutdownbuttontoppadding
                    leftPadding : shutdownbuttonleftpadding

                    Image {
                            id : shutdownButton
                            source : shutdownbuttonup
                            width : shutdownbuttonimagewidth
                            height : shutdownbuttonimageheight
                            visible : true
                            //anchors.right : parent.right

                            MouseArea {
                                        //anchors.fill : parent
                                        hoverEnabled : true

                                        onEntered : {
                                                        parent.source = shutdownbuttonhover
                                        }
                                        onExited : {
                                                        parent.source = shutdownbuttonup
                                        }
                                        onPressed : {
                                                        parent.source = shutdownbuttondown
                                                        sddm.login(name.text, password.text, sessionIndex)
                                        }
                                        onReleased : {
                                                        parent.source = shutdownbuttonup
                                        }
                            }

                            Text {
                                        text : shutdownbuttontext
                                        //anchors.centerIn : parent
                                        font.family : loginfont.name
                                        font.italic : false
                                        font.pointSize : dosfontsize
                                        color: doscolor
                            }

                            KeyNavigation.backtab : password
                            KeyNavigation.tab : loginButton
                    }
            }

        //ComboBox
        Column {
                id : entryColumn10
                anchors.left : parent.left
                topPadding : comboboxtoppadding
                leftPadding : comboboxleftpadding

                ComboBox {
                            id : session
                            color : comboboxcolor
                            borderColor : comboboxbordercolor
                            hoverColor : comboboxhovercolor
                            focusColor : comboboxfocuscolor
                            textColor : doscolor
                            menuColor : comboboxmenucolor
                            arrowColor: comboboxarrowcolor
                            width : comboboxwidth
                            height : comboboxheight
                            visible : comboboxvisible
                            font.pointSize : dosfontsize
                            font.italic : false
                            font.family : loginfont.name
                            arrowIcon : comboboximage
                            model : sessionModel
                            index : sessionModel.lastIndex
                            KeyNavigation.backtab : shutdownButton
                            KeyNavigation.tab : loginButton
                }
        }




        Column {
            id : entryColumn22
            anchors.top : parent.top
            anchors.horizontalCenter : container.horizontalCenter
            topPadding : welcometoppadding
            //leftPadding : usernameleftpadding

        Text {
                color : doscolor
                text : "SYS PROC 3435.45.6456"
                visible : true
                font.family : loginfont.name
                font.italic : false
                font.pointSize : dosfontsize
            }
        }

        Column {
            id : entryColumn222
            anchors.top : parent.top
            anchors.horizontalCenter : container.horizontalCenter
            topPadding : welcometoppadding
            //leftPadding : usernameleftpadding

        Text {
                color : doscolor
                text : "\n\n\n#989.283      #028.392      #099.293      #934.905"
                visible : true
                font.family : loginfont.name
                font.italic : false
                font.pointSize : dosfontsize
            }
        }

        Column {
            id : entryColumn33
            anchors.right : parent.right
            //anchors.horizontalCenter : container.horizontalCenter
            topPadding : welcometoppadding
            //leftPadding : usernameleftpadding

        Text {
                color : doscolor
                text : "XCOMP STATUS: PV-450\nCPU TM USED: 23:43"
                visible : true
                font.family : loginfont.name
                font.italic : false
                font.pointSize : dosfontsize
            }
        }



        Column {
            id : entryColumn44
            anchors.right : parent.right
            //anchors.horizontalCenter : container.horizontalCenter
            topPadding : welcometoppadding
            //leftPadding : usernameleftpadding

        Text {
                color : doscolor
                text : "XCOMP STATUS: PV-450\nCPU TM USED: 23:43\n\n#261.372"
                visible : true
                font.family : loginfont.name
                font.italic : false
                font.pointSize : dosfontsize
            }
        }



        Column {
            id : entryColumn55
            anchors.right : parent.right
            //anchors.horizontalCenter : container.horizontalCenter
            topPadding : welcometoppadding
            //leftPadding : usernameleftpadding

        Text {
                color : doscolor
                text : "#989.283"
                visible : true
                font.family : loginfont.name
                font.italic : false
                font.pointSize : dosfontsize
            }
        }
}
