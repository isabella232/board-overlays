# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit cros-binary

DESCRIPTION="NVIDIA binary nvrm daemon and libraries for Tegra2"
SLOT="0"
KEYWORDS="arm"
IUSE="tegra-local-bins"

RDEPEND="chromeos-base/chromeos-init"
DEPEND="${RDEPEND}"

if use tegra-local-bins; then
	URI_BASE="file://"
else
	URI_BASE="ssh://tegra2-private@git.chromium.org:6222/home/tegra2-private"
fi
CROS_BINARY_URI="${URI_BASE}/${CATEGORY}/${PN}/${P}.tbz2"
CROS_BINARY_SUM="9ea8510811ce5d81ecf23ce5b63afad4a03c7ba1"

src_install() {
	insinto /etc/init
	doins ${FILESDIR}/etc/init/nvrm.conf			|| die

	insinto /etc/udev/rules.d
	doins ${FILESDIR}/etc/udev/rules.d/51-nvrm.rules	|| die

	cros-binary_src_install
}
