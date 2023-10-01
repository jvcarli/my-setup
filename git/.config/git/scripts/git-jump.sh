#!/bin/sh

usage() {
cat <<\EOF
usage: git jump <mode> [<args>]

Jump to interesting elements in an editor.
The <mode> parameter is one of:

diff: elements are diff hunks. Arguments are given to diff.

merge: elements are merge conflicts. Arguments are ignored.

grep: elements are grep hits. Arguments are given to git grep or, if
      configured, to the command in `jump.grepCmd`.

ws: elements are whitespace errors. Arguments are given to diff --check.
EOF
}

# HACK: here's the patched part that differs from:
# https://github.com/git/git/blob/master/contrib/git-jump/git-jump
# TODO: Does it work from inside n(vim)?
# patch taken from: https://gist.github.com/romainl/a3ddb1d08764b93183260f8cdf0f524f
open_editor() {
	if test -t 1; then
		editor=`git var GIT_EDITOR`
		eval "$editor -q \$1"
	else
		eval "cat \$1"
	fi
}

mode_diff() {
	git diff --no-prefix --relative "$@" |
	perl -ne '
	if (m{^\+\+\+ (.*)}) { $file = $1; next }
	defined($file) or next;
	if (m/^@@ .*?\+(\d+)/) { $line = $1; next }
	defined($line) or next;
	if (/^ /) { $line++; next }
	if (/^[-+]\s*(.*)/) {
		print "$file:$line: $1\n";
		$line = undef;
	}
	'
}

mode_merge() {
	git ls-files -u |
	perl -pe 's/^.*?\t//' |
	sort -u |
	while IFS= read fn; do
		grep -Hn '^<<<<<<<' "$fn"
	done
}

# Grep -n generates nice quickfix-looking lines by itself,
# but let's clean up extra whitespace, so they look better if the
# editor shows them to us in the status bar.
mode_grep() {
	cmd=$(git config jump.grepCmd)
	test -n "$cmd" || cmd="git grep -n --column"
	$cmd "$@" |
	perl -pe '
	s/[ \t]+/ /g;
	s/^ *//;
	'
}

mode_ws() {
	git diff --check "$@"
}

if test $# -lt 1; then
	usage >&2
	exit 1
fi
mode=$1; shift

trap 'rm -f "$tmp"' 0 1 2 3 15
tmp=`mktemp -t git-jump.XXXXXX` || exit 1
type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
"mode_$mode" "$@" >"$tmp"
test -s "$tmp" || exit 0
open_editor "$tmp"