function coolmathCallStart() {
    try {
        window.parent.postMessage({'cm_game_event': true, 'cm_game_evt' :
        'start', 'cm_game_lvl': 0}, '*');
        console.log("game start event sent via postMessage");
    } catch (e) {
        console.error("Error sending game start event via postMessage:", e);
    }
}

function coolmathCallLevelStart(level) {
    try {
        window.parent.postMessage({'cm_game_event': true, 'cm_game_evt' :
        'start', 'cm_game_lvl': String(level)}, '*');
        console.log("level start " + level + " event sent via postMessage");
    } catch (e) {
        console.error("Error sending level start event via postMessage:", e);
    }
}
function coolmathCallLevelRestart(level) {
    try {
        window.parent.postMessage({'cm_game_event': true, 'cm_game_evt' :
        'replay', 'cm_game_lvl': String(level)}, '*');
        console.log("level restart " + level + " event sent via postMessage");
    } catch (e) {
        console.error("Error sending level restart event via postMessage:", e);
    }
}

var shouldUnlockAll = false;

function unlockAllLevels() {
    shouldUnlockAll = true;
    console.log("All levels set to be unlocked.");
}

function coolMathShouldUnlockAll() {
    return shouldUnlockAll;
}