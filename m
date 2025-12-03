Return-Path: <linux-fsdevel+bounces-70555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5706CC9F21B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 14:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8EF3A775D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1AA2F7AA4;
	Wed,  3 Dec 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQAahHD4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF382DFF28;
	Wed,  3 Dec 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768458; cv=none; b=H9yD9INxtZKEUgyJduqhIKSQsXHqSvwZhgicRRfy/LYL8m03URcY9iilM4iAN/lPG1DTL0dWHHt8acVgqkr7iXrrOlbVTSL99+Gl29bVssdHeDnqp60QhOOk9w7/0xFpknVuxTVXGo8GYGIHWzhgpgqWyWHOeSlJ4dA18TOMOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768458; c=relaxed/simple;
	bh=/Y0QHuPC2ySE8xuOgec2Zq5zdB4V34dJ1EXa6n2zwDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ljp/uV5909jkBykLld91kNTG2W9ed40Yo5bzeuxbu1AhS7LCGPfo9Dnw48ODVXj8XKtSQHMqG7EeszaDxD+gCXBmNliNZA+LObefvBlt6ILO90l66CxHTPi5dBiBdVwY2ZlaNcAc6tCR35Yf2MSL7wKLRWdb0WXmv6fZo2v37dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQAahHD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA258C4CEFB;
	Wed,  3 Dec 2025 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764768457;
	bh=/Y0QHuPC2ySE8xuOgec2Zq5zdB4V34dJ1EXa6n2zwDc=;
	h=Date:From:To:Cc:Subject:From;
	b=QQAahHD4DXlrM8EARO4UACWQB2RkzL8eDrMPWdOfcpePdzdKMPwOdZ0TtUnyvNW3t
	 CRTawL7wmcSOPE6F8yRYVaphd0PtZesNvh0c3+SV/hAIuzhS1KEiSbJfYIuBtHfv4w
	 wZUhQOl439YnaujK+/3SoeMYErwFCKZIWQjt6YBpD6RsxWWzo8zOXd3hQ4rBSVtDYQ
	 mOqIM7k38xF7NELl5he/DfcjyvthbfZw+QcGABntZ25zifn7dJgsFbogwZ1MzJ0RVu
	 F7FmNmDepBXsOd6WyL0b6tuwDYvvWQfJxp1IinRYOf9ZiCuWBVsraIOQGqF3P9g9Hu
	 2xwjxQWXHoIVA==
Date: Wed, 3 Dec 2025 14:27:31 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl changes for v6.19-rc1
Message-ID: <tqz52ig2b5jas3qqt6jqqek7uwyg64ny5qnwy6gclhgjcy4ltb@s7jiay5vyomg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fmy2irrdfffrhu55"
Content-Disposition: inline


--fmy2irrdfffrhu55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus:

Seeing that I leaned quite a bit on macros in this PR, I'm working on
the "function only" version here [1]. I believe it is still worth while
merging this in, because it allows Jiffies to move out of sysctl.c (So
at least that bit does not have to go through the review/testing
process)

Best

[1] : https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.g=
it/log/?h=3Djag/no-macro-conv


The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysc=
tl-6.19-rc1

for you to fetch changes up to 564195c1a33c8fc631cd3d306e350b0e3d3e9555:

  sysctl: Wrap do_proc_douintvec with the public function proc_douintvec_co=
nv (2025-11-27 15:45:38 +0100)

----------------------------------------------------------------
Summary

* Move jiffies converters out of kernel/sysctl.c

  Moved the jiffies converters into kernel/time/jiffies.c and replaced
  the pipe-max-size proc_handler converter with a macro based version.
  This is all part of the effort to relocate non-sysctl logic out of
  kernel/sysctl.c into more relevant subsystems. No functional changes.

* Generalize proc handler converter creation

  Removed duplicated sysctl converter logic by consolidating it in
  macros. These are used inside sysctl core as well as in pipe.c and
  jiffies.c. Converter kernel and user space pointer args are now
  automatically const qualified for the convenience of the caller. No
  functional changes.

* Miscellaneous

  Fixed kernel-doc format warnings, removed unnecessary __user
  qualifiers, and moved the nmi_watchdog sysctl into .rodata.

* Testing

  This series was run through sysctl selftests/kunit test suite in
  x86_64. It went into linux-next after rc2, giving it a good 4/5 weeks
  of testing.

----------------------------------------------------------------
Joel Granados (20):
      watchdog: move nmi_watchdog sysctl into .rodata
      sysctl: Replace void pointer with const pointer to ctl_table
      sysctl: Remove superfluous tbl_data param from "dovec" functions
      sysctl: Remove superfluous __do_proc_* indirection
      sysctl: Indicate the direction of operation with macro names
      sysctl: Discriminate between kernel and user converter params
      sysctl: Create converter functions with two new macros
      sysctl: Create integer converters with one macro
      sysctl: Add optional range checking to SYSCTL_INT_CONV_CUSTOM
      sysctl: Create unsigned int converter using new macro
      sysctl: Add optional range checking to SYSCTL_UINT_CONV_CUSTOM
      sysctl: Create macro for user-to-kernel uint converter
      sysctl: remove __user qualifier from stack_erasing_sysctl buffer argu=
ment
      sysctl: Allow custom converters from outside sysctl
      sysctl: Move INT converter macros to sysctl header
      sysctl: Move UINT converter macros to sysctl header
      sysctl: Move jiffies converters to kernel/time/jiffies.c
      sysctl: Move proc_doulongvec_ms_jiffies_minmax to kernel/time/jiffies=
=2Ec
      sysctl: Create pipe-max-size converter using sysctl UINT macros
      sysctl: Wrap do_proc_douintvec with the public function proc_douintve=
c_conv

Randy Dunlap (1):
      sysctl: fix kernel-doc format warning

 fs/pipe.c               |  28 +--
 include/linux/jiffies.h |  12 +
 include/linux/sysctl.h  | 157 ++++++++++--
 kernel/kstack_erase.c   |   2 +-
 kernel/sysctl.c         | 649 ++++++++++++--------------------------------=
----
 kernel/time/jiffies.c   | 125 ++++++++++
 kernel/watchdog.c       |   9 +-
 7 files changed, 436 insertions(+), 546 deletions(-)

--=20

Joel Granados

--fmy2irrdfffrhu55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmkwOroACgkQupfNUreW
QU8Yjwv/Ym9s7Nsvslow9FiKex9maUwdwP1u6HbGIqQizwDq4RrmWf2srcdtasih
NzSTu3ZW9CjlQRPKI8VKdehe31uS+UmkeR/ZvBDzzFDcKWU9cT5CGxRfbXVWRq5r
jOyxnJIgkfreXo77hXjMgxSKbK8MVmBs7eYTkX8+l5O8J7KszBeEaW6FBKIYAQQm
4GOPNLW8LqqXhvxkosq4lFVw9OM/nx/mpxm3KO8ctQQw2JsTuSMKjel6HzL2Rpj0
bgobxb6SkQYwxNSVWJKD7zXutG2ZeYj2MweMxQFMXVWf1GgTglX0BrcKs81mMxX1
pXEJ2e654R6PQdtT/tDQSnmVvY5MXd4ZSubyY4bJgEUcpS0qtdJZmleNvb2ShJ3B
lW7jSXAaCRGr2zlm26POvOGyWp287e/RtscspL0RMKX68Ge7XO0tvNfwrWIitJ3s
UQT0063GezGbyf1rQJu6O/BsUyTb2KUqskq+yVtjWaCjlZJuKhyR3PFFifvWZVQ+
YTI7GBHT
=Z1oD
-----END PGP SIGNATURE-----

--fmy2irrdfffrhu55--

