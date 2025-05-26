Return-Path: <linux-fsdevel+bounces-49893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7321AC48EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 09:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB67189C258
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 07:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064442153F1;
	Tue, 27 May 2025 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj7dHuPA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4BC202969;
	Tue, 27 May 2025 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329066; cv=none; b=usd20Tl4LM3wVOYYNk1W/uPYvPERHJbQb4z3tvsKJkA2dtWihzKtgbjfGyGy//ZQluk2GGFsmfJBGJpS/YbbyekRKWSadssBW30a5nNyTIPPyr1Z9AN0N3DKuJCfdajxuQxpU6HWnAewCST1RWpeQuAjSgoYLyyQpbGDJxTa89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329066; c=relaxed/simple;
	bh=rwfo8SIdPFnNrt8tKiPaablBSYJZdJTbHs2zOmEbAUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YV92DCffsGmUTo7z2eGOrB3az0wIV6th0/wd3kpfhuqlfYzndTy88JWm4t+yAttrtIpwQvK7UniaXSim+8hlzPZcIBWLdhaRlzq/PN71mwcqzzM22e2lylwOCISKCG5s7cx60bNWS6X5cE/02kttwV47Poqbg7rRjRuthbP7FWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj7dHuPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26561C4CEF2;
	Tue, 27 May 2025 06:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748329065;
	bh=rwfo8SIdPFnNrt8tKiPaablBSYJZdJTbHs2zOmEbAUo=;
	h=Date:From:To:Cc:Subject:From;
	b=Sj7dHuPAN0ED0yLw1mDbkcnNFGQP70BcRvbu9SuoRMRHtuqOxki2+ECpow6I5QEkx
	 jBFJ0zkU9AGJm4Oy7mSh3XACDhyh1wxTo90z1eB0a+TYxYQN8m4FWNJvPjL9mazgzy
	 pKQqEQypffqfjW1md85W2ShFmna99CojMbfE0tEFlIihZFCkvIBAxU5W2Br7J9W+3T
	 bRsKUw4rii6njouQWaucCGhSALi0A5tOhpW6hSK/AL+Jyxtjew67uWcUM7BJTZDIh1
	 EoWHj7FHAYxDeKzYDYEf/VGakAAppz1XiHJVMIRJOXd88bq4zIiddekhtgirVRiyFp
	 o8nIyZnnen6JQ==
Date: Mon, 26 May 2025 08:35:51 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl changes for v6.16-rc1
Message-ID: <itvalur2ynrnjc3grs5nk36fbfm52atybcad2nmxidaavkeqap@nlxzuqvygpta>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nxgspzmyeafrwyvk"
Content-Disposition: inline


--nxgspzmyeafrwyvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sys=
ctl-6.16-rc1

for you to fetch changes up to 23b8bacf154759ed922d25527dda434fbf57436a:

  sysctl: Close test ctl_headers with a for loop (2025-04-14 14:13:41 +0200)

----------------------------------------------------------------
Summary

* Move kern_table members out of kernel/sysctl.c

  Moved a subset (tracing, panic, signal, stack_tracer and sparc) out of the
  kern_table array. The goal is for kern_table to only have sysctl elements=
=2E All
  this increases modularity by placing the ctl_tables closer to where they =
are
  used while reducing the chances of merge conflicts in kernel/sysctl.c.

* Fixed sysctl unit test panic by relocating it to selftests

* Testing

  These have been in linux-next from rc2, so they have had more than a month
  worth of testing.

----------------------------------------------------------------
Joel Granados (9):
      panic: Move panic ctl tables into panic.c
      signal: Move signal ctl tables into signal.c
      tracing: Move trace sysctls into trace.c
      stack_tracer: move sysctl registration to kernel/trace/trace_stack.c
      sparc: mv sparc sysctls into their own file under arch/sparc/kernel
      sysctl: move u8 register test to lib/test_sysctl.c
      sysctl: Add 0012 to test the u8 range check
      sysctl: call sysctl tests with a for loop
      sysctl: Close test ctl_headers with a for loop

 arch/sparc/kernel/Makefile               |   1 +
 arch/sparc/kernel/setup.c                |  46 +++++++++++
 include/linux/ftrace.h                   |   9 ---
 kernel/panic.c                           |  30 +++++++
 kernel/signal.c                          |  11 +++
 kernel/sysctl-test.c                     |  49 ------------
 kernel/sysctl.c                          | 108 -------------------------
 kernel/trace/trace.c                     |  36 ++++++++-
 kernel/trace/trace_stack.c               |  22 ++++-
 lib/test_sysctl.c                        | 133 +++++++++++++++++++++------=
----
 tools/testing/selftests/sysctl/sysctl.sh |  30 +++++++
 11 files changed, 266 insertions(+), 209 deletions(-)
 create mode 100644 arch/sparc/kernel/setup.c

--=20

Joel Granados

--nxgspzmyeafrwyvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmg0C7gACgkQupfNUreW
QU/OOAv/XMiF/DqGJP9K1HXyqWAJgPIG0Kapfsw6EgNXfMTMjLVRgbsKpfcV2qAA
JhePKLluuYoFbcKKVaGT+bHkLdMtYD4Yw46KYCg3/dsCFdZv3Y8khP2a+lNedleF
Xskmwey2E3fmi+zKgXgvQSgAKizXx65/QCP6+PSf2hlLXLWxI991kiQ+xmJ9+79x
/BJJ6osWpoNJFzxx5TCJmqNG2/yG79C1GTn9+pSlfBPiiOjMUVuQReecTuCEp3qd
pfZzA9HJ1JN1DLf4u53AnywyUXbOsUYJctseIkegGoRlZ9Q64ckAsiAytjbHOroW
ObkHJJxc4TzOTRdlVB6vbEB0b3yvIlzjJBh6ZaPuaotI4ST773lHebICXxIE64yN
oV6qW8991ncE15MzBvJh37RS0JDCNEThT66Kqrjot09TOWca4CdrKGoucqWaz8RR
1/jlAq2NQG4i6RtFlWIOgXC1KrrgeVxF7oOD6tWDCmMgxrI3g9+GKJDaULGlxwME
D0JdXDZB
=G2NI
-----END PGP SIGNATURE-----

--nxgspzmyeafrwyvk--

