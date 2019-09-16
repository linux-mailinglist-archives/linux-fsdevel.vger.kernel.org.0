Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A4BB38A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 12:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfIPKuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 06:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfIPKuu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:50:50 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 263FE2067D;
        Mon, 16 Sep 2019 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568631049;
        bh=U82Tr8FbEpQ0OJbT7LiytXXfUulzIz1X0TDl8YNIEFo=;
        h=Subject:From:To:Cc:Date:From;
        b=gZQZ1UxGxemHcxzW4lTiVFDyiN1pDQzvh1P/DPEfwPGRSm7br5Yg+7s/t3gflhhIU
         EYlot5c3IXiT8ZF2AdZgqoEiicgcM5NxM2hVQcp7o/IkuLQiW2YBSUFZ2I7lzi2FQ0
         W/qUlSj2a2qV56RhQaJjGw37D626oEC1P1iLRlEQ=
Message-ID: <f3b4a58a47b4eb3346581f541348a1fc18aabdce.camel@kernel.org>
Subject: [GIT PULL] file locking changes for v5.4
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 16 Sep 2019 06:50:40 -0400
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MnDTmiEyDIGT695orHds"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-MnDTmiEyDIGT695orHds
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b=
:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/file=
lock-v5.4-1

for you to fetch changes up to cfddf9f4c9f038c91c6c61d5cf3a161731b5c418:

  locks: fix a memory leak bug in __break_lease() (2019-08-20 05:48:52 -040=
0)

----------------------------------------------------------------

Hi Linus,

Just a couple of minor bugfixes, a revision to a tracepoint to account
for some earlier changes to the internals, and a patch to add a pr_warn
message when someone tries to mount a filesystem with '-o mand' on a
kernel that has that support disabled.

----------------------------------------------------------------
Jeff Layton (2):
      locks: revise generic_add_lease tracepoint
      locks: print a warning when mount fails due to lack of "mand" support

Pavel Begunkov (1):
      locks: Fix procfs output for file leases

Wenwen Wang (1):
      locks: fix a memory leak bug in __break_lease()

 Documentation/filesystems/mandatory-locking.txt | 10 ++++++++++
 fs/locks.c                                      | 11 ++++++-----
 fs/namespace.c                                  | 11 ++++++++---
 include/trace/events/filelock.h                 | 14 +++++++-------
 4 files changed, 31 insertions(+), 15 deletions(-)


--=-MnDTmiEyDIGT695orHds
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAl1/aQATHGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFfKxEAC2xqzxj143HDWQqM3HbwDc6n7vMBFx
d1kSFgQUoHSH5waAZ7to4AD1IPPk9aWQ6NQAWBLRHZ2/bfvkKtws9smoEKASgpVq
P2xWuiylcgglxFsIyQutO53qS6l1m5E9+F8Zf0lq+n5JHqqhNTvXmNp8XNxiilv/
dK12vy6XTXHeB3Hv2BPvvUMDrlwGWlQASIk1lyBUQ94RuLjGNaV93hL32YeGpEE0
GaYooBHhH4+yOsZuWZpaiLmLSjncE7fLo2HUB5x6AKjEc1c1j8HbW88ckM51Umd8
fH0efyyO3sZ31n/0Bs73ZQPhQCKtbEDD2YIrvqsqVnp3NLPnMe2t8wZbWX9dxKWG
zGcJz03QAp4wwExL0F4OsqpbC6uFhJJqzdYuuPs+5kQFSW8chlcsXcKba6efFgPg
EYNjKC4KhcKLJetegzFXsxpwjyAxjFHFisgdZAfPAYdtiymZ735JwVbJqE/BCzOW
eRCOoT9PS5vEqxwPVpL+gc7VJDeWAluYXkASyuQj2G3QCM7pTidmjd6ybytroyup
qV/9Ak4pBG4namBjJZ4STb/i84k9F1UOzKedUphqNmO2vuoSKv4WgnuoVoZCBaRE
m2Tl2fdeKl1PPQjQH/WQZJR7imM4l1nBgHeTM1B7A0Lv542jgdI8FoWjeMFi2PIu
kcGBj+HPhtlxKQ==
=XdCd
-----END PGP SIGNATURE-----

--=-MnDTmiEyDIGT695orHds--

