const fs       = require('fs');
const electron = require('electron');
const path     = require('path');
const url      = require('url');

const app = electron.app;
const BrowserWindow = electron.BrowserWindow;
let mainWindow;

// Get rid of the symlink from the bash script

const argv = require('process').argv;

fs.unlinkSync(argv[1]);

// Fix name of renamed app folder

const renamedApp = path.join(path.dirname(argv[1]), 'app-tmp-rename');
if (fs.existsSync(renamedApp)) {
    fs.renameSync(renamedApp, path.join(path.dirname(argv[1]), 'app'));
}


app.dock.setIcon(path.join(__dirname, 'images', 'icon.png'));

function createWindow() {

    mainWindow = new BrowserWindow({
        title: "BandagedBD Installer",
        resizable: false,
        width: 800,
        height: 600,
        webPreferences: {
            nodeIntegration: true
        }
    });

    mainWindow.setMenu(null);
    mainWindow.loadURL(url.format({
        pathname: path.join(__dirname, 'index.html'),
        protocol: 'file:',
        slashes: true
    }));
    mainWindow.on('closed', function () {
        mainWindow = null;
    });
    //mainWindow.webContents.openDevTools();
}

app.on('ready', createWindow);

app.on('window-all-closed', function () {
    app.quit();
});

app.on('activate', function () {
    if (mainWindow === null) {
        createWindow();
    }
});
