import QtQuick 2.4
import QtMultimedia 5.6
import Eos.Window 0.1
import Eos.Items 0.1
import WebOS.Global 1.0

WebOSWindow {
    id: root

    visible: true
    width: 1920
    height: 1080

    keyMask: WebOSWindow.KeyMaskBack | keyMask

    Component.onCompleted: {
        // Window will handle back key event only when this set to true on my TV.
        windowProperties["_WEBOS_ACCESS_POLICY_KEYS_BACK"] = "true"
    }

    Item {
        anchors.fill: parent
        focus: true

        MediaPlayer {
            id: mediaplayer
            // file://, http(s?):// are confirmed to be supported. More to find.
            source: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        }

        VideoOutput {
            anchors.fill: parent
            source: mediaplayer
            
            // This is the key to display video. This sounds quite familiar to SurfaceView on Android.
            // Also, the hierarchy is not important I guess. You can put this as a sibiling of VideoOutput
            PunchThrough {
                x: 0; y: 0; z: -1
                width: parent.width
                height: parent.height
            }
        }

        MouseArea {
            id: playArea
            anchors.fill: parent
            onPressed: {
                if (mediaplayer.playbackState == MediaPlayer.PlayingState) {
                    mediaplayer.pause();
                } else {
                    mediaplayer.play();
                }
            }
        }

        Keys.onPressed: {
            // webOS related key codes are defined in qweboskeyextension.h
            if (event.key == WebOS.Key_webOS_Back) {
                Qt.quit()
            }
        }
    }
}
