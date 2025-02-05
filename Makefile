S=./node_modules/.bin/sass
SFLAGS=

all: eSixCafe eSixCafeStylus

eSixCafe:
	mkdir -p release/
	${S} ${SFLAGS} src/eSixCafe.scss release/eSixCafe.css

eSixCafeStylus:
	mkdir -p release/

clean:
	rm -f release/eSixCafe.css
	rm -f release/eSixCafe.user.css

setup:
	yarn add sass@1.42.1

setup-clean:
	rm -rf node_modules
	rm -f package.json
	rm -f yarn.lock

