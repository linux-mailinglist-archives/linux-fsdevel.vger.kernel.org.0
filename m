Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6632D115AB1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 03:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLGCJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 21:09:11 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34301 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfLGCJK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 21:09:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47VCYr5Y8nz9sPf;
        Sat,  7 Dec 2019 13:09:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1575684548;
        bh=+0JuL1NBfWAFLxpfqXjZlVNiiaAfVa1OIU9nnVKfIlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BMWz+6gx76bqNPDPz02K5XR+5faW+YPQ3DLWF9ujw6KxW79+/NCm0qoxgHQ+h0UHr
         AvUKS2mmwZzb9pG6QCuhpJ6+zmeu8YMcxZA1xFXoqm8M12tKN0ALOdPir1usEwpTT3
         lCwWrP4n85MK7pv2ZuMd0g4HnLmogxnn/1me4HOpDXNK/dogk74jTKWuayd0kLekhN
         5GTPNrnmuyQ+Xj6/Mm+ii01tMu1Y5qBL2cc6+dejP9Y1lAtvUsdOn5LrvWZUweL0f5
         F8YCrK6pEc8B5bLNK7lgOIUnOO0VzjbLYTOnPD+HhankuzY9M4bQFm9L4YaGcGywgW
         sXFhuWWBgn2SQ==
Date:   Sat, 7 Dec 2019 13:08:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [git pull] vfs.git d_inode/d_flags barriers
Message-ID: <20191207130859.4850b07f@canb.auug.org.au>
In-Reply-To: <CAHk-=wgPd1dYZjywZqPYZP-7dD2ihwviYfYLY3i+K=OLk2ZozQ@mail.gmail.com>
References: <20191206013819.GL4203@ZenIV.linux.org.uk>
        <CAHk-=wgPd1dYZjywZqPYZP-7dD2ihwviYfYLY3i+K=OLk2ZozQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z9xpQ9CcDuBmTZl9CI/9mPS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/z9xpQ9CcDuBmTZl9CI/9mPS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Thu, 5 Dec 2019 18:15:54 -0800 Linus Torvalds <torvalds@linux-foundation=
.org> wrote:
>
> On Thu, Dec 5, 2019 at 5:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes =20
>=20
> I'm not pulling this.
>=20
> Commit 6c2d4798a8d1 ("new helper: lookup_positive_unlocked()") results
> in a new - and valid - compiler warning:
>=20
>   fs/quota/dquot.c: In function =E2=80=98dquot_quota_on_mount=E2=80=99:
>   fs/quota/dquot.c:2499:1: warning: label =E2=80=98out=E2=80=99 defined b=
ut not used
> [-Wunused-label]
>    2499 | out:
>         | ^~~
>=20
> and I don't want to see new warnings in my tree.
>=20
> I wish linux-next would complain about warnings (assuming this had
> been there), because they aren't ok.

I did ... https://lore.kernel.org/lkml/20191203093203.2f88400d@canb.auug.or=
g.au/

--=20
Cheers,
Stephen Rothwell

--Sig_/z9xpQ9CcDuBmTZl9CI/9mPS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3rCbsACgkQAVBC80lX
0Gxl8QgAmVlRrQXReAvUik1AyrMX3/qS2x3hAZKBlw8K7YfbjHiWd+PbDSpHRSRV
qNnXUgvBGvnGgDyTEaN8LWt/c2UNaWtYK+VSn9e52vw1EdmBmTC8PjQUy5EJEiLZ
19IjKm7YBkKZuDKzvueqVXB+BE4vhzp7fX7GaWsnyssbFN3wXUNzwPbxoqwHjM5l
H07y3PAr/ar79ZTAatj79Sm9QPLj7qv2Fzi/OXmoPZNlTtWaCgfshODH79kw1sRx
LV08iPfA0gqyb6PsioGBcF7P8jtyEIDUcNAx2ZAiEX047o0Ng0uGXVHoZAKCq4WM
f+2Ais4A5FLl4X66abSuzSr0H9CU4A==
=rzpu
-----END PGP SIGNATURE-----

--Sig_/z9xpQ9CcDuBmTZl9CI/9mPS--
