all: build

build: hakyll
	./hakyll clean
	./hakyll build

hakyll: hakyll.hs
	ghc --make hakyll.hs

new:
	@./new_post.sh

publish: build
	git stash save
	git checkout publish
	rsync -r --delete _site/{,.}* ./
	git add -A && git co "Publish" || true
	git push
	git push clever publish:master
	git checkout master
	git stash pop || true

preview: hakyll
	./hakyll clean
	./hakyll preview -p 9000

clean: hakyll
	./hakyll clean
	rm -f hakyll

check: hakyll
	./hakyll check
