# Maintainer: SandyLaw  <freelxs@gmail.com>
pkgname=webtree
pkgver=1.2.r.
pkgrel=1
pkgdesc="list contents of http/ftp directories in a tree-like format."
arch=(any)
url="https://github.com/sandylaw/webtree.git"
license=('Apache License 2.0')
groups=()
depends=(wget)
makedepends=(git)
checkdepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
source=("git+$url")
noextract=()
md5sums=('SKIP')
validpgpkeys=()

pkgver() {
  cd "${_pkgname}"
  printf "1.2.r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}
build() {
  cd webtree
  make X11INC=/usr/include/X11 X11LIB=/usr/lib/X11
}

package() {
  cd webtree 
  install -Dm755 webtree "${pkgdir}/usr/bin/webtree"
  install -Dm644 LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
  install -Dm644 README.md "${pkgdir}/usr/share/doc/${pkgname}/README.md"
}

