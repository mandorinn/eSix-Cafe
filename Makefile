S=./node_modules/.bin/sass
SFLAGS=--no-source-map

all: eSixCafe eSixCafeStylus

eSixCafe:
	mkdir -p release/
	${S} ${SFLAGS} src/eSixCafe.scss release/eSixCafe.css
	sed -i 's^\/\*@-moz-document domain.*^^g' release/eSixCafe.css

eSixCafeStylus:
	mkdir -p release/tmp/

	cp -a src/eSixCafe.scss src/eSixCafe.user.scss
	cp -a src/common/_comment_container_*.scss \
		src/common/main_layout_theme_*.scss \
		release/tmp/
	cp -a src/specific/blips_buttons.scss \
		src/specific/comments_rank_border.scss \
		release/tmp/

	sed -i 's^@import \"base\/themable.*^^g' src/eSixCafe.user.scss
	sed -i 's^@import \"common\/_comment_container_.*^^g' src/eSixCafe.user.scss
	sed -i 's^@import \"common\/main_layout_theme_.*^^g' src/eSixCafe.user.scss
	sed -i 's^@import \"specific\/blips_buttons.*^^g' src/eSixCafe.user.scss
	sed -i 's^@import \"specific\/comments_rank_border.*^^g' src/eSixCafe.user.scss

	sed -i 's^@if.*^@if 1 == 1 {^g' release/tmp/*.scss
	cat src/base/_colors.scss release/tmp/comments_rank_border.scss >release/tmp/comments_rank_border.scss.new

	${S} ${SFLAGS} release/tmp/_comment_container_buttons.scss release/tmp/_comment_container_buttons.css
	${S} ${SFLAGS} release/tmp/_comment_container_profile_picture_circle.scss release/tmp/_comment_container_profile_picture_circle.css
	${S} ${SFLAGS} release/tmp/_comment_container_profile_picture_square.scss release/tmp/_comment_container_profile_picture_square.css
	${S} ${SFLAGS} release/tmp/_comment_container_rank_border.scss release/tmp/_comment_container_rank_border.css
	${S} ${SFLAGS} release/tmp/main_layout_theme_classic.scss release/tmp/main_layout_theme_classic.css
	${S} ${SFLAGS} release/tmp/main_layout_theme_muted.scss release/tmp/main_layout_theme_muted.css
	${S} ${SFLAGS} release/tmp/blips_buttons.scss release/tmp/blips_buttons.css
	${S} ${SFLAGS} release/tmp/comments_rank_border.scss.new release/tmp/comments_rank_border.css
	${S} ${SFLAGS} src/eSixCafe.user.scss release/eSixCafe.user.css

	echo "if buttons {" >>release/eSixCafe.user.css
	cat release/tmp/_comment_container_buttons.css >>release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

	echo "if roundness == circle {" >>release/eSixCafe.user.css
	cat release/tmp/_comment_container_profile_picture_circle.css >>release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

	echo "if roundness == square {" >>release/eSixCafe.user.css
	cat release/tmp/_comment_container_profile_picture_square.css >>release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

	echo "if borderRank {" >>release/eSixCafe.user.css
	cat release/tmp/_comment_container_rank_border.css >>release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

	echo "if themep == classic {" >>release/eSixCafe.user.css
	cat release/tmp/main_layout_theme_classic.css >>release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

	echo "if themep == muted {" >>release/eSixCafe.user.css
	cat release/tmp/main_layout_theme_muted.css >>release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

	echo "if buttons {" >>release/eSixCafe.user.css
	cat release/tmp/blips_buttons.css >>release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

	echo "if borderRank {" >>release/eSixCafe.user.css
	cat release/tmp/comments_rank_border.css >>release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

	printf "$$%s\n" "theme-pack: \"classic\";" >src/eSixCafe.user.scss
	echo "@import \"base/themable\";" >>src/eSixCafe.user.scss
	${S} ${SFLAGS} src/eSixCafe.user.scss release/tmp/theme_classic.css

	printf "$$%s\n" "theme-pack: \"muted\";" >src/eSixCafe.user.scss
	echo "@import \"base/themable\";" >>src/eSixCafe.user.scss
	${S} ${SFLAGS} src/eSixCafe.user.scss release/tmp/theme_muted.css

	printf "$$%s\n" "theme-pack: \"popular\";" >src/eSixCafe.user.scss
	echo "@import \"base/themable\";" >>src/eSixCafe.user.scss
	${S} ${SFLAGS} src/eSixCafe.user.scss release/tmp/theme_popular.css

	echo "if themep == classic {" >>release/eSixCafe.user.css
	cat release/tmp/theme_classic.css >>release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

	echo "if themep == muted {" >>release/eSixCafe.user.css
	cat release/tmp/theme_muted.css >>release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

	echo "if themep == pThemes {" >>release/eSixCafe.user.css
	cat release/tmp/theme_popular.css >>release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

	sed -i 's^\/\*@-moz-document domain^@-moz-document domain^g' release/eSixCafe.user.css
	sed -i 's^e926.net\") {\*\/^e926.net\") {^g' release/eSixCafe.user.css
	echo "}" >>release/eSixCafe.user.css

clean:
	rm -rf release/tmp
	rm -f release/eSixCafe.css
	rm -f release/eSixCafe.user.css
	rm -f src/eSixCafe.user.scss

setup:
	yarn add sass@1.42.1

setup-clean:
	rm -rf node_modules
	rm -f package.json
	rm -f yarn.lock

