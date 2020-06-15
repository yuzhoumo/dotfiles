require("module").Module.globalPaths.push(require('path').resolve(require("electron").remote.app.getAppPath() + '.asar', "node_modules"));

const process  = require('process');
const exec     = require('child_process').exec;
const fs       = require('fs');
const path     = require('path');
const request  = require('request');
const os       = require('os');

function killAllDiscords(appName) {
    exec(`pgrep -i ${appName.replace(' ', '\\ ')}$ | grep -v ${process.pid} | xargs kill`);
}

function availableBuilds() {
    let available = { 'Discord': [], 'Discord PTB': [], 'Discord Canary': [] };
    const dirs   = ['/Applications/', path.join(os.homedir(), '/Applications/'), path.join(os.homedir(), '/Desktop/')];
    const builds = ['Discord', 'Discord PTB', 'Discord Canary'];
    dirs.forEach(dir => {
        builds.forEach(build => {
            const testPath = path.join(dir, build + '.app');
            if (fs.existsSync(testPath)) {
                available[build].push(testPath);
            }
        });
    });
    return available;
}

// 1. Locate the Discord executable (and ensure the resources folder is there)
// 2. Download this https://github.com/rauenzi/BetterDiscordApp/archive/injector.tar.gz to the resources folder and extract it (it contains a folder called BetterDiscordApp-injector)
// 3. Rename BetterDiscordApp-injector to app
// 4. Verify the files inside the app folder (just checks to make sure these exist: index.js, config.json, package.json, betterdiscord/index.js, betterdiscord/config.json, betterdiscord/utils.js)

function install(appPath, log, error, progress, restart) {
    const err = err => {
        const errString = 'Failed to install to ' + appPath + ': ' + err;
        error(errString);
        return errString;
    };

    try {
        progress(0);
        const appInfo = verifyApp(appPath);
        if (appInfo.error) return err(appInfo.error);
        log('Found application...', true);
        progress(10);
        const cDir = path.join(appPath, 'Contents', 'Resources');
        process.chdir(cDir);
        progress(15);
        if (fs.existsSync('./app')) {
            log('Deleting old injection' + path.join(cDir, 'app') + '...', true);
            rimraf('./app');
        }
        if (fs.existsSync('./app-tmp-rename')) {
            log('Deleting old injection ' + path.join(cDir, 'app-tmp-rename') + '...', true);
            rimraf('./app-tmp-rename');
        }
        progress(20);
        const injectorFolderExists  = fs.existsSync('./BetterDiscordApp-injector');
        const injectorTarballExists = fs.existsSync('./injector.tar.gz');
        if (injectorFolderExists || injectorTarballExists) {
            log('Deleting remnants from previous install attempt...', true);
            if (injectorFolderExists) rimraf('./BetterDiscordApp-injector');
            if (injectorTarballExists) fs.unlinkSync('./injector.tar.gz');
        }
        progress(25);
        log('Killing all Discord processes...');
        killAllDiscords(appInfo.appName);
        progress(30);
        log('Downloading from https://github.com/rauenzi/BetterDiscordApp/archive/injector.tar.gz');
        return downloadTar('https://github.com/rauenzi/BetterDiscordApp/archive/injector.tar.gz', './injector.tar.gz', log, progress, 30)
        .then(() => {
            progress(70);
            log('Renaming package dir...', true);
            fs.renameSync('./BetterDiscordApp-injector', './app');
            progress(80);
            log('Verifying install...');
            const checkFiles = ['./app/index.js', './app/config.json', './app/package.json', './app/betterdiscord/index.js', './app/betterdiscord/config.json', './app/betterdiscord/utils.js'];
            let verified = true;
            for (let file in checkFiles) {
                if (!fs.existsSync(checkFiles[file])) {
                    err('Missing file: ' + checkFiles[file] + '! -- Please retry install.');
                    verified = false;
                }
            }
            if (restart && verified) {
                progress(90);
                log('Restarting Discord...');
                exec('open -n ' + appPath.replace(' ', '\\ '));
                progress(100);
            } else {
                progress(100);
            }
        })
        .catch(err);
    } catch (e) {
        return err(e);
    }
}

function uninstall(appPath, log, error, progress, removeData, restart) {
    const err = err => {
        const errString = 'Failed to uninstall from ' + appPath + ': ' + err;
        error(errString);
        return errString;
    };

    try {
        progress(0);
        const appInfo = verifyApp(appPath);
        if (appInfo.error) return err(appInfo.error);
        log('Found application...', true);
        progress(30);
        if (restart) {
            log('Killing all Discord processes...');
            killAllDiscords(appInfo.appName);
        }
        const cDir = path.join(appPath, 'Contents', 'Resources');
        process.chdir(cDir);
        removeData ? progress(60) : progress(75);
        if (fs.existsSync('./app')) {
            log('Removing injection...');
            log(path.join(cDir, 'app'), true);
            rimraf('./app');
            removeData ? progress(80) : progress(100);
        }
        if (fs.existsSync('./app-tmp-rename')) {
            log('Removing injection...');
            log(path.join(cDir, 'app-tmp-rename'), true);
            rimraf('./app-tmp-rename');
            removeData ? progress(80) : progress(100);
        }
        if (removeData) {
            log('Removing BD data...');
            rimraf(path.join(process.env.HOME, 'Library', 'Preferences', 'BetterDiscord'));
        }
        if (restart) {
            log('Starting Discord...');
            exec('open -n ' + appPath.replace(' ', '\\ '));
        }
        progress(100);
    } catch (e) {
        return err(e);
    }
}

function rimraf(dir_path) {
    if (fs.existsSync(dir_path)) {
        fs.readdirSync(dir_path).forEach(function (entry) {
            var entry_path = path.join(dir_path, entry);
            if (fs.lstatSync(entry_path).isDirectory() && path.extname(entry_path) !== '.asar') {
                rimraf(entry_path);
            } else {
                try {
                    fs.unlinkSync(entry_path);
                } catch (e) {
                    console.log(e);
                }
            }
        });
        try {
            fs.rmdirSync(dir_path);
        }  catch (e) {
            console.log(e);
        }
    }
};

function downloadTar(url, dest, log, progress, currentProgress) {
    return new Promise((resolve, reject) => {
        const file = fs.createWriteStream(dest);
        log('Downloading file...', true);
        request(url)
            .pipe(file)
            .on('close', () => {
                progress(currentProgress + 10);
                file.close();
                log('Extracting...', true);
                exec(`tar -xzf ${dest}`, () => {
                    progress(currentProgress + 20);
                    log('Deleting tarball...', true);
                    fs.unlinkSync(dest);
                    progress(currentProgress + 30);
                    resolve();
                });
            })
            .on('error', reject);
    });
}

function verifyApp(appPath) {
    if (!fs.existsSync(appPath)) return {error: `Could not find ${path.basename(appPath)}!`};
    const baseName       = path.basename(appPath);
    const parts          = baseName.split('.');
    if (parts.length < 2 || parts[1] !== 'app') return {error: `${baseName} is not a '.app' file!`};
    const appName        = parts[0];
    const executablePath = path.join(appPath, 'Contents', 'MacOS', appName);
    if (!fs.existsSync(executablePath)) return {error: `No executable file found in ${baseName}!`};
    const resourcesPath  = path.join(appPath, 'Contents', 'Resources');
    if (!fs.existsSync(resourcesPath)) return {error: `${baseName} has no resources directory!`};
    return {
        executable: executablePath,
        resources:  resourcesPath,
        appName:    appName
    };
}

function deleteAppSupport(name) {
    const dir      = path.join(process.env.HOME, 'Library', 'Application Support', name);
    const dirs     = fs.readdirSync(dir);
    const location = path.join(dir, dirs.find(e => e.includes('0.0.')));
    rimraf(location);
}