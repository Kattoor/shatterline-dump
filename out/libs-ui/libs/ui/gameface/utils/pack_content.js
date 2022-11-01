const fs = require('fs');
const Path = require('path');


function getFiles(directory, extension = '', fileNames = [])
{
    const currentFileNames = fs.readdirSync(directory);

    for (const currentFileName of currentFileNames)
    {
        const fullFileName = directory + '/' + currentFileName;

        if (fs.statSync(fullFileName).isDirectory())
            getFiles(fullFileName, extension, fileNames);
        else if (!extension || Path.extname(fullFileName) === extension)
            fileNames.push(fullFileName);
    }

    return fileNames;
}


function packFiles(fileNames, outFileName, handleBegin = null, handleFile = null, handleEnd = null)
{
    try
    {
        let buffer = { data: '' };

        const maxIndex = fileNames.length - 1;

        if (handleBegin != null)
            handleBegin(buffer);

        for (const index in fileNames)
        {
            const fileName = fileNames[index];

            const fileData = fs.readFileSync(fileName, 'utf8');

            if (handleFile != null)
                handleFile(buffer, fileData, index, maxIndex, fileName);
            else
                buffer.data += fileData;
        }

        if (handleEnd != null)
            handleEnd(buffer);

        fs.writeFileSync(outFileName, buffer.data);
        console.log('Packed:', outFileName);
    }
    catch (err)
    {
        console.error(err);
    }
}


function packCssFiles(fileNames, outFileName)
{
    const generalCssInfex = fileNames.indexOf('src/General.css');

    if (generalCssInfex >= 0)
    {
        const generalCss = fileNames[generalCssInfex];
        fileNames.splice(generalCssInfex, 1);
        fileNames.unshift(generalCss);
    }


    function handleFile(buffer, fileData, index, maxIndex, fileName)
    {
        if (fileData)
        {
            buffer.data += fileData;

            if (index < maxIndex)
                buffer.data += '\n\n';
        }
    }


    packFiles(fileNames, outFileName, null, handleFile);
}


function packHtmlFiles(fileNames, outFileName)
{
    function handleBegin(buffer)
    {
        buffer.data = '<html>\n' +
            '<body>\n\n' +
            '<link href="build.css" rel="stylesheet">\n\n\n' +
            '<div id="SafeArea"></div>\n\n\n' +
            '<div id="Templates" style="visibility: hidden; height:0px">\n\n\n';
    }


    function handleFile(buffer, fileData, index, maxIndex, fileName)
    {
        if (fileData)
            buffer.data += fileData + '\n\n\n';
    }


    function handleEnd(buffer)
    {
        buffer.data += '</div>\n\n\n' +
            '<script src="libs/cohtml.js"></script>\n' +
            '<script src="build.js"></script>\n\n\n' +
            '</body>\n' +
            '</html>';
    }


    packFiles(fileNames, outFileName, handleBegin, handleFile, handleEnd);
}


function packJsonFiles(directory, extension, outFileName)
{
    const fileNames = getFiles(directory, extension);
    const prefixLength = directory.length + 1;


    function handleBegin(buffer)
    {
        buffer.data = '{\n\n';
    }


    function handleFile(buffer, fileData, index, maxIndex, fileName)
    {
        const relativeFileName = fileName.substr(prefixLength);
        buffer.data += '"' + relativeFileName + '":\n' + fileData;

        if (index < maxIndex)
            buffer.data += ',\n\n';
    }


    function handleEnd(buffer)
    {
        buffer.data += '\n\n}';
    }


    packFiles(fileNames, outFileName, handleBegin, handleFile, handleEnd);
}


function makeDebugScreenHtml(fileNames, outFileName, jsCode = '')
{

    function handleBegin(buffer)
    {
        buffer.data = '<script>\n' + jsCode + '\n' + '</script>\n\n';
    }

    packFiles(fileNames, outFileName, handleBegin);
}


packCssFiles(getFiles('src', '.css'), 'build/build.css');
packHtmlFiles(getFiles('src', '.html'), 'build/build.html');
// makeDebugScreenHtml(['build/build.html'], 'build/debug_screen.html', 'window.debugScreen = "ProceduralScreen";');
// packJsonFiles('test_layouts', '.json', 'build/test_layouts.json');
