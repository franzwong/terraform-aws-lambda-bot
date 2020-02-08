rm -rf dist
mkdir dist
cp *.js dist/
cp *.json dist/
cd dist
npm install --production
zip -r output.zip .
