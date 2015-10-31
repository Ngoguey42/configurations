URL=`git remote -v | grep fetch | sed "s/origin//" | sed "s/(fetch)//"`

/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --kiosk --args $URL
