import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
Window {
    visible:true
    width:420
    height:530
    property double needleAngle: 60;
    property int loc:1;
Rectangle{
    id: recta
    Behavior on x { PropertyAnimation {} }

    Image {
        source: "/files/images/Arrow.png"
        x:330
        y: 0
        width: 88
        height: 48
        MouseArea {
            anchors.fill: parent
            onClicked: {
                recta.x -= 430
            }
        }
    }

    Image {
        source: "/files/images/Arrow.png"
        x : 424
        y: 48
        width: 93
        height: 47
        transformOrigin: Item.Top
        z: 18
        rotation: 180
        MouseArea {
            anchors.rightMargin: 0
            anchors.bottomMargin: -1
            anchors.leftMargin: 0
            anchors.topMargin: 1
            transformOrigin: Item.TopLeft
            anchors.fill: parent
            onClicked: {
                recta.x += 430
            }
        }
    }

    Image {
        source: "/files/images/Arrow.png"
        x : 748
        y: 0
        width: 102
        height: 50
        transformOrigin: Item.Top
        MouseArea {
            transformOrigin: Item.Top
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent
            onClicked: {
                recta.x -= 430
            }
        }
    }

    Image {
        source: "/files/images/Arrow.png"
        x:860
        y: -3
        width: 91
        height: 44
        rotation: 180
        MouseArea {
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: -6
            anchors.topMargin: -9
            transformOrigin: Item.TopLeft
            anchors.fill: parent
            onClicked: {
                recta.x += 430
            }
        }
    }

    /*COMPLETELY WORKING FLICKABLE. Has been disabled as it will make draw action difficult*/

//    Flickable {
//        flickDeceleration: 750
//        maximumFlickVelocity: 1000
//        anchors.fill: parent
//        contentWidth: 1300
//        contentHeight: 520

//        NumberAnimation on contentX {
//            id: xAnimation
//                to: 0
//                duration: 200
//            }
//        onMovementEnded: {
//               var index = Math.round(contentX / (430))
//               xAnimation.to = index * 430
//               xAnimation.start()
//        }

    Row{
        id: tools
        x: -2
        y: 49
        width: 450
        height: 40

        Button {
            id:clean
            width: 75
            text:"Clean"
            onClicked: {
                canvas.clear()
            }
        }

        Button {
            id:saveB
            width: 75
            text:"Save"
            onClicked: {
                canvas.save("~/Desktop/Woohoo.jpg") //C:/Users/XXXYYY/Desktop/Woohoo.jpg
            }
        }
        Button {
            id:eraser
            width: 75
            text:"Eraser"
            onClicked: {
                canvas.drawColor = Qt.rgba(255,255,255,255)
                canvas.thickness =  10
            }
        }
        Button {
            id:redButton
            width:40
            height:40
            background: Rectangle {
                border.color: Qt.rgba(255,0,0,255)
                color: Qt.rgba(255,0,0,255)
            }
            onClicked: {
                canvas.drawColor = Qt.rgba(255, 0, 0, 255)
                canvas.thickness =  2
            }
        }
        Button {
            id:blueButton
            width:40
            height:40
            background: Rectangle {
                border.color: Qt.rgba( 0, 0, 255,255)
                color: Qt.rgba( 0, 0, 255,255)
            }
            onClicked: {
                canvas.drawColor = Qt.rgba( 0, 0, 255,255)
                canvas.thickness =  2
            }
        }
        Button {
            id:greenButton
            width:40
            height:40
            background: Rectangle {
                border.color: Qt.rgba( 0, 255, 0, 255)
                color: Qt.rgba( 0, 255, 0, 255)
            }
            onClicked: {
                canvas.drawColor = Qt.rgba( 0, 255, 0, 255)
                canvas.thickness =  2
            }
        }
        Button {
            id:yellowButton
            width:40
            height:40
            background: Rectangle {
                border.color: Qt.rgba(255,255,0,255)
                color: Qt.rgba(255,255,0,255)
            }
            onClicked: {
                canvas.drawColor = Qt.rgba(255,255,0,255)
                canvas.thickness =  2
            }
        }
        Button {
            id:blackButton
            width:40
            height:40
            background: Rectangle {
                //border.color: Qt.rgba(0, 0,0,255)
                color: Qt.rgba(0, 0,0,255)
            }
            onClicked: {
                canvas.drawColor = Qt.rgba(0,0,0,255)
                canvas.thickness =  2
            }
        }


    }

    Canvas{
        id:canvas
        anchors.top : tools.bottom
        width: 420
        height: 452
        anchors.topMargin: -1
        property int lastX: 0
        property int lastY: 0
        property color drawColor: Qt.rgba(0,0,0,257);
        property int thickness: 2
        x: -2

        Text {
            id: text1
            x: 114
            y: -68
            width: 193
            height: 32
            text: qsTr("DRAW YOURSELF!")
            font.bold: true
            font.family: "Verdana"
            textFormat: Text.RichText
            fontSizeMode: Text.HorizontalFit
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 23
        }

        Rectangle {
            x: 1
            y: -3
            width: canvas.width
            height: 435
            border.width : 5
            border.color : Qt.rgba(0,0,0,257)
            color : Qt.rgba(0, 0, 0, 0)
        }

        function clear(){
            var ctx = getContext("2d")
            ctx.reset()
            canvas.drawColor = Qt.rgba(0, 0,0,255)
            canvas.thickness = 2
            canvas.requestPaint()
            mouse.clear()
        }

        function clamp(num, min, max) {
            return num <= min ? min : num >= max ? max : num;
        }

        onPaint: {
            //Do cool stuff here
            var ctx = getContext("2d") // it is very important
            ctx.lineWidth = thickness
            ctx.fillStyle = "blue"
            ctx.strokeStyle = canvas.drawColor
            ctx.beginPath()
            ctx.moveTo(lastX, lastY)
            lastX = area.mouseX
            lastY = area.mouseY
            ctx.lineTo(lastX, lastY)

            ctx.stroke()

            mouse.test() //add this after doing all the below Stuff. this is the engine.rootContext()->setContextProperty("mouse", mouse.data()); in main.cpp
            mouse.add(lastX,lastY);
            mouse.add(Qt.point(lastX,lastY))
        }

        MouseArea {
            id: area
            height: 435
            anchors.topMargin: 0
            anchors.fill: parent

            onPressed:{
                canvas.lastX = mouseX
                canvas.lastY = mouseY
            }

            onPositionChanged: {
                canvas.requestPaint()
            }

        }
    }

    Image {
        id: speedometer
        x: 430
        y: 40
        width: 420
        height: 420
        source: "/files/images/speedometer.png"

        Text {
            id: text2
            x: 106
            y: -36
            width: 174
            height: 36
            text: qsTr("SPEEDOMETER")
            font.bold: true
            font.pixelSize: 26
        }
        Image {
            id: needle
            x: 210
            y: 240
            width: 20
            height: 164
            source: "/files/images/needle.png"
            transform:Rotation{origin.x:5; origin.y:5;angle:Math.min(Math.max(needleAngle,55),315)
                Behavior on angle {
                    SpringAnimation {spring: 2; damping: 0.2; mass: 3;}
                }}
            smooth:true
        }

        Button {
            id: addButton
            x: 173
            y: 408
            width: 100
            height: 62
            text: qsTr("Accelerate")
            checkable: false
            onClicked: needleAngle +=20
        }

        Text {
            id: angleText
            x: 222
            y: 31
            //text: needleAngle
            font.pixelSize: 12

        }

        Timer {
            interval: 50; running: true; repeat: true;
            onTriggered: needleAngle -=4
        }
        Timer {
            interval: 25; running: true; repeat: true;
            onTriggered: needleAngle = Math.min(Math.max(needleAngle,55),315)

        }
    }

    Image {
        id: gameArt
        x: 860
        y: 40
        width: 420
        height: 420
        property string locS: "/files/images/road.png"
        source: locS

        Image {
            id: map
            x: 0
            y: 0
            width: 174
            height: 109
            source: "/files/images/map.png"
        }

        Row{
            id: buttonRow
            anchors.top:gameArt.bottom
            Button {
                id:north
                width: 80
                text:"North"
                onClicked: {
                    loc = game.findLoc(loc, "N");
                    gameArt.updateLocation();
                }
            }
            Button {
                id:east
                width: 80
                text:"East"
                onClicked: {
                    loc = game.findLoc(loc, "E");
                    gameArt.updateLocation();
                }
            }
            Button {
                id:west
                width: 80
                text:"West"
                onClicked: {
                    loc = game.findLoc(loc, "W");
                    gameArt.updateLocation();
                }
            }
            Button {
                id:south
                width: 80
                text:"South"
                onClicked: {
                    //do what needs to be done
                    loc = game.findLoc(loc, "S");
                    gameArt.updateLocation();
                }
            }
            Button {
                id:quit
                width: 100
                text:"Quit"
                onClicked: {
                    gameArt.source = "/files/images/computer.png"
                    gameStatus.text = "You are in front of your Computer!"
                    north.enabled = false
                    south.enabled = false
                    east.enabled = false
                    west.enabled = false
                }
            }
        }

        Text {
            id: gameStatus
            x: 189
            y: 74
            text: qsTr("START GAME FROM THE ROAD")
            anchors.centerIn: gameArt
            font.pixelSize: 12
        }

        Text {
            id: text3
            x: 149
            y: -38
            text: qsTr("GAME :)")
            font.bold: true
            font.pixelSize: 26
        }
        function updateLocation(){
            gameStatus.text = game.setText(loc);
            gameArt.source = game.setLocation(loc, gameArt.source);
        }
    }

}
}
//}
