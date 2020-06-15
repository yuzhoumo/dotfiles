const available = availableBuilds();

if (available['Discord'].length) {
    document.getElementById('installStable').checked   = true;
    document.getElementById('uninstallStable').checked = true;
    document.getElementById('repairStable').checked    = true;
    document.querySelector('#stablePath input').value  = available['Discord'][0];
    document.querySelector('#uStablePath input').value = available['Discord'][0];
    document.querySelector('#rStablePath input').value = available['Discord'][0];
}
if (available['Discord PTB'].length) {
    document.getElementById('installPTB').checked      = true;
    document.getElementById('uninstallPTB').checked    = true;
    document.getElementById('repairPTB').checked       = true;
    document.querySelector('#PTBPath input').value     = available['Discord PTB'][0];
    document.querySelector('#uPTBPath input').value    = available['Discord PTB'][0];
    document.querySelector('#rPTBPath input').value    = available['Discord PTB'][0];
}
if (available['Discord Canary'].length) {
    document.getElementById('installCanary').checked   = true;
    document.getElementById('uninstallCanary').checked = true;
    document.getElementById('repairCanary').checked    = true;
    document.querySelector('#canaryPath input').value  = available['Discord Canary'][0];
    document.querySelector('#uCanaryPath input').value = available['Discord Canary'][0];
    document.querySelector('#rCanaryPath input').value = available['Discord Canary'][0];
}

validate('stablePath');
validate('PTBPath');
validate('canaryPath');

validate('uStablePath');
validate('uPTBPath');
validate('uCanaryPath');

validate('rStablePath');
validate('rPTBPath');
validate('rCanaryPath');

function validate(id) {
    const input    = document.querySelector(`#${id} input`);
    const button   = document.querySelector(`#${id} button`);
    const checkbox = input.parentElement.parentElement.querySelector('input[type="checkbox"]');
    input.addEventListener('input', () => {
        const path = input.value;
        const info = verifyApp(path);
        if (info.error) {
            input.setAttribute('invalid', info.error);
            checkbox.checked = false;
            checkbox.setAttribute('disabled', '');
            input.parentElement.getElementsByClassName('invalidReason')[0].innerText = info.error;
        } else {
            input.removeAttribute('invalid');
            checkbox.checked = true;
            checkbox.removeAttribute('disabled');
            input.parentElement.getElementsByClassName('invalidReason')[0].innerText = '';
        }
    });

    button.addEventListener('click', () => {
        selectApplication(path => {
            input.value = path;
            input.dispatchEvent(new Event('input'));
        });
    });
}

function changeView(view) {
    document.querySelector('.view.current').classList.remove('current');
    document.getElementById(view).classList.add('current');
}


function selectApplication(callback) {
    require('electron').remote.dialog.showOpenDialog(
        {message: "Select your Discord.app", defaultPath:"/Applications/", properties: ['openFile'], 
            filters: [{name: 'Applications', extensions:['app']}]
        },
        filePaths => {
            callback(filePaths[0]);
        }
    );
}

document.getElementById('installDetails').addEventListener('click', e => {
    const verbose = e.target.checked;
    Array.from(document.querySelectorAll('#installLog .verbose')).forEach(el => {
        el.style.display = verbose ? '' : 'none';
    });
});

async function startInstall() {
    const stableChecked = document.getElementById('installStable').checked;
    const PTBChecked    = document.getElementById('installPTB').checked;
    const canaryChecked = document.getElementById('installCanary').checked;

    if (!(stableChecked || PTBChecked || canaryChecked)) return;

    changeView('installing');
    const logElement = document.getElementById('installLog');
    function log (text, verbose) {
        const isVerbose = document.getElementById('installDetails').checked;
        if (verbose) {
            const elem = document.createElement('span');
            elem.innerHTML = text + '<br>';
            elem.classList.add('verbose');
            if (!isVerbose) elem.style.display = 'none';
            logElement.appendChild(elem);
        } else {
            logElement.innerHTML += text + '<br>';
        }
    }
    let errored = false;
    function error (text) {
        logElement.innerHTML += '<span style="color: red">' + text + '</span><br>';
        errored = true;
    }
    const progressBar = document.querySelector('#installProgress .bar');
    function progress (current) {
        progressBar.style.width = current + '%';
    }
    const restart = document.getElementById('restartDiscords').checked;
    if (stableChecked) {
        log('Installing to Stable.');
        const path = document.querySelector('#stablePath input').value;
        await install(path, log, error, progress, restart);
        log('----------------------------------------');
    }
    if (PTBChecked) {
        log('Installing to PTB.');
        const path = document.querySelector('#PTBPath input').value;
        await install(path, log, error, progress, restart);
        log('----------------------------------------');
    }
    if (canaryChecked) {
        log('Installing to Canary.');
        const path = document.querySelector('#canaryPath input').value;
        await install(path, log, error, progress, restart);
        log('----------------------------------------');
    }
    if (!errored) log('Done installing! You can now safely exit the installer.');
    document.getElementById('installExit').removeAttribute('disabled');
}


document.getElementById('uninstallDetails').addEventListener('click', e => {
    const verbose = e.target.checked;
    Array.from(document.querySelectorAll('#uninstallLog .verbose')).forEach(el => {
        el.style.display = verbose ? '' : 'none';
    });
});

async function startUninstall() {
    const stableChecked = document.getElementById('uninstallStable').checked;
    const PTBChecked    = document.getElementById('uninstallPTB').checked;
    const canaryChecked = document.getElementById('uninstallCanary').checked;

    if (!(stableChecked || PTBChecked || canaryChecked)) return;

    changeView('uninstalling');
    const logElement = document.getElementById('uninstallLog');
    function log (text, verbose) {
        const isVerbose = document.getElementById('uninstallDetails').checked;
        if (verbose) {
            const elem = document.createElement('span');
            elem.innerHTML = text + '<br>';
            elem.classList.add('verbose');
            if (!isVerbose) elem.style.display = 'none';
            logElement.appendChild(elem);
        } else {
            logElement.innerHTML += text + '<br>';
        }
    }
    let errored = false;
    function error (text) {
        logElement.innerHTML += '<span style="color: red">' + text + '</span><br>';
        errored = true;
    }
    const progressBar = document.querySelector('#uninstallProgress .bar');
    function progress (current) {
        progressBar.style.width = current + '%';
    }
    const removeData = document.getElementById('removeData').checked;
    const restart    = document.getElementById('uRestart').checked;
    if (stableChecked) {
        log('Removing from Stable.');
        const path = document.querySelector('#uStablePath input').value;
        uninstall(path, log, error, progress, removeData, restart);
        log('----------------------------------------');
    }
    if (PTBChecked) {
        log('Removing from PTB.');
        const path = document.querySelector('#uPTBPath input').value;
        uninstall(path, log, error, progress, removeData, restart);
        log('----------------------------------------');
    }
    if (canaryChecked) {
        log('Removing from Canary.');
        const path = document.querySelector('#uCanaryPath input').value;
        uninstall(path, log, error, progress, removeData, restart);
        log('----------------------------------------');
    }
    if (!errored) log('Done uninstalling! You can now safely exit.');
    document.getElementById('uninstallExit').removeAttribute('disabled');
}

document.getElementById('repairDetails').addEventListener('click', e => {
    const verbose = e.target.checked;
    Array.from(document.querySelectorAll('#repairLog .verbose')).forEach(el => {
        el.style.display = verbose ? '' : 'none';
    });
});

async function startRepair() {
    const stableChecked = document.getElementById('repairStable').checked;
    const PTBChecked    = document.getElementById('repairPTB').checked;
    const canaryChecked = document.getElementById('repairCanary').checked;

    const repairBootLoop   = document.getElementById('rBootLoop').checked;
    const repairUninjected = document.getElementById('rUninjected').checked;
    const repairInfinite   = document.getElementById('rInfinite').checked;
    const repairError      = document.getElementById('rError').checked;

    if (
        !(
            (stableChecked || PTBChecked || canaryChecked)
            &&
            (repairBootLoop || repairError || repairInfinite || repairUninjected)
        )
        ) {
        return;
    }

    changeView('repairing');
    const logElement = document.getElementById('repairLog');
    function log (text, verbose) {
        const isVerbose = document.getElementById('repairDetails').checked;
        if (verbose) {
            const elem = document.createElement('span');
            elem.innerHTML = text + '<br>';
            elem.classList.add('verbose');
            if (!isVerbose) elem.style.display = 'none';
            logElement.appendChild(elem);
        } else {
            logElement.innerHTML += text + '<br>';
        }
    }
    let errored = false;
    function error (text) {
        logElement.innerHTML += '<span style="color: red">' + text + '</span><br>';
        errored = true;
    }
    const progressBar = document.querySelector('#repairProgress .bar');
    function progress (current) {
        progressBar.style.width = current + '%';
    }

    const deleteAppSupp = repairError || repairBootLoop;
    const deleteApp     = repairBootLoop;
    const deleteStorage = repairInfinite;
    const reinstall     = repairUninjected || repairBootLoop;
    const restart       = document.getElementById('rRestart').checked;

    if (deleteApp || deleteAppSupp) {
        if (stableChecked) {
            log('Repairing Stable.');
            const path = document.querySelector('#rStablePath input').value;
            if (deleteApp) await uninstall(path, log, error, progress, false, restart);
            if (deleteAppSupp) deleteAppSupport('discord');
            log('----------------------------------------');
        }
        if (PTBChecked) {
            log('Repairing PTB.');
            const path = document.querySelector('#rPTBPath input').value;
            if (deleteApp) await uninstall(path, log, error, progress, false, restart);
            if (deleteAppSupp) deleteAppSupport('discordptb');
            log('----------------------------------------');
        }
        if (canaryChecked) {
            log('Repairing Canary.');
            const path = document.querySelector('#rCanaryPath input').value;
            if (deleteApp) await uninstall(path, log, error, progress, false, restart);
            if (deleteAppSupp) deleteAppSupport('discordcanary');
            log('----------------------------------------');
        }
    }
    if (deleteStorage) {
        log('Fixing infinite loading...');
        const fs = require('fs');
        const path = require('path').join(require('process').env.HOME, 'Library', 'Preferences', 'BetterDiscord', 'bdstorage.json');
        log('Deleting ' + path, true);
        if (fs.existsSync(path)) fs.unlinkSync(path);
    }
    if (!(errored || reinstall)) log('Done repairing! You can now safely exit.');
    if (reinstall) {
        const button = document.getElementById('repairExit');
        button.innerText = 'Install';
        button.onclick   = () => {
            changeView('install');
        };
        document.getElementById('installStable').checked = stableChecked;
        document.getElementById('installPTB').checked    = PTBChecked;
        document.getElementById('installCanary').checked = canaryChecked;
        log('In order to complete repairs BandagedBD needs to be reinstalled. Click install to continue.');
    }
    document.getElementById('repairExit').removeAttribute('disabled');
}