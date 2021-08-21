Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507793F3A6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Aug 2021 13:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhHULpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Aug 2021 07:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhHULpK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Aug 2021 07:45:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6C4461163;
        Sat, 21 Aug 2021 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629546271;
        bh=CNRkFdCftq0m0tdcw43cUUVsXEoTPdAFXOIDI9K3Av8=;
        h=Subject:From:To:Cc:Date:From;
        b=YMlmpiZR6X2i+O39E1sZPP/+ZmNdR3naOyNydfzMbhF/jDuh/1fj4SCUhCEifPnVt
         xpob5HNwpT0VH5F6B4vRkRePgwKtAxTqqbTogAiSZ04cLwWLluBMQjJHUeDv2yT3Kx
         mUrGAj3dqF0baobAbEjUmcEGECUxtcx8JOvwj7Mh40xmxUgKp+njer0DS1q+V7CN44
         4v4SjE0ab3oOp/eKWlIyA+i4dFpK0FEiuzuaf+2Y7tor+tcMRx12IGpOTqDZJt4s6d
         xFACsCSnv8Xd6RSo4/sgw2cWB5BrDYqIM3VcWY9bZ32WqBt+CbiLB/q93T5fmNvugS
         L+T03GPkjYSvg==
Message-ID: <31485fdcfad7852abb7f29d73ae0ab718c6357bb.camel@kernel.org>
Subject: [GIT PULL] file locking change for v5.14
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bruce Fields <bfields@fieldses.org>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat, 21 Aug 2021 07:44:09 -0400
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-8ndcaWifXjFnSKDtUJSr"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-8ndcaWifXjFnSKDtUJSr
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 3dbdb38e286903ec220aaf1fb29a8d94297da246=
:

  Merge branch 'for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/=
tj/cgroup (2021-07-01 17:22:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git locks-v5.=
14

for you to fetch changes up to fdd92b64d15bc4aec973caa25899afd782402e68:

  fs: warn about impending deprecation of mandatory locks (2021-08-21 07:32=
:45 -0400)

----------------------------------------------------------------
Hi Linus,

As discussed on the list, this patch just adds a new warning for folks
who still have mandatory locking enabled and actually mount with "-o
mand". I'd like to get this in for v5.14 so we can push this out into
stable kernels and hopefully reach folks who have mounts with -o mand.

For now, I'm operating under the assumption that we'll fully remove this
support in v5.15, but we can move that out if any legitimate users of
this facility speak up between now and then.
----------------------------------------------------------------
Jeff Layton (1):
      fs: warn about impending deprecation of mandatory locks

 fs/namespace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
--=20
Jeff Layton <jlayton@kernel.org>

--=-8ndcaWifXjFnSKDtUJSr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAmEg5wkTHGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFY3FD/9Sg2uBSAcmZibr/XYnNhzZirFBK0il
NKgwXzAsbQwOHn+2Zn4BqKCMSKIxld8H0Z5THYq5GPuKUxKjL/70e07OjDGGZfSp
oeuUKY/FXyQHqEEwIBA5gx19vpUM/JgCVai0+busazZo2TBkYHZ4Airimga78top
fqz8v/zhA95enp3nxqbsBWkodh5QALC8ax563Qk33nRDGJ/yHBSKAW7HZhi5PFNf
UXP2L9UTCwrJd+RN/KATRp9FwSEAGi2w9XTPFLcMS3XvuiPtJr/MH/lzVFO+09pe
cNthyvkKcMnmLTlDswwhsjALfU3bqvfp7Q28cCDuEkEmQX3bFHIptp0yv+BR6Tkm
rJCoGPwckBCcf9I/rgA/bJniQnoOj70AIyrtCad1LWWdQJ6Rc9EVt1kZMaDZjCX8
gTT9D4S6zNC7nnboZNnW5ATjL56fkQvr7OwvSXgUWOxI9/3FZ9wpka1JC2FRPUPS
QcTPY8M/2pcvGZCJWuKhYBanjaeBUcFs0pJyQr6DOsNY/K+Mg5llqAjb6fcZ4jJN
y+E7joupMZOVkN6nZYUEbIkBlW+hSzdg0Y8b2CDOWbvunQEr8B39dfKPsoQybyCT
z+15TcM3nie1Mv30b/FVlPsi/k7C75IrS7/mnVsU+3LR1bSKXVEWVA1zpc31+UYm
1hNIs+bHSUZUbQ==
=zlOz
-----END PGP SIGNATURE-----

--=-8ndcaWifXjFnSKDtUJSr--

