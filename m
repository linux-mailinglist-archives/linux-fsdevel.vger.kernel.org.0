Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D97217B76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 01:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgGGXDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 19:03:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48895 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgGGXDK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 19:03:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B1dJW0qcDz9s1x;
        Wed,  8 Jul 2020 09:03:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594162988;
        bh=ZyI/3429U87XB0Dgnc42vomRNERSgupm2+gTzZsuAM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lZzBB8vQfCvQhg6iR19YFVBr5s4z9Jx0lwNYpjDAyp2LFivTrFJ7NBNT8Xk6eNR1S
         i6GhNs8QfympzmpRcxhiZfHnDlXsPbaWUfA+V7wdOqUe5sChRdCNlgNTzYL9CdpKw6
         jOPFUYHEMon1dCdLgp9iSX6vZqO9LAMc+/Eff1EYi2cr3dtU6oh2lxkcsYdlLpEWEL
         LcLc3Dd4pmjkNyQoRsfPef8093qrYHwbgeLDI3LnAR6My+VmEFJqc2iQdalur3Y3Al
         VcKXv2yHtwSTq/Ag9BhAl7x67pFO4gqX8UdFHUYV2ILzna5XlUF+LT3EctnoP15GNa
         1vCtxO30SvOkg==
Date:   Wed, 8 Jul 2020 09:03:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: stop using ->read and ->write for kernel access v3
Message-ID: <20200708090306.2209802a@canb.auug.org.au>
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zQt_i5i/0wX+K.IyNJL8Y3s";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/zQt_i5i/0wX+K.IyNJL8Y3s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Tue,  7 Jul 2020 19:47:38 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> A git branch is available here:
>=20
>     git://git.infradead.org/users/hch/misc.git set_fs-rw
>=20
> Gitweb:
>=20
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/set_f=
s-rw
>=20
> Given that this has been out and cooking for a while, is there a chance to
> add the above as a temp branch to linux-next to get a little more exposure
> until Al reviews it and (hopefully) picks it up?

No worries, I will add it in later today and drop it after Al grabs it.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/zQt_i5i/0wX+K.IyNJL8Y3s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8E/yoACgkQAVBC80lX
0GwGjwf+Mat7xlpqLTM/Bvrnt5C85aBmgIUU1wqEjpLFAEI6mEMGIsy+jcN3CirD
5aGD65LRyq51fE75O+4BNUzKh4arvhTLst+ydJuN3yzIVU5dUv63GwFsyHGnOTB9
U/h+B/7rXOGtTgxmLBoDswY8cay68JLP+YKoPgrJaLduR49ZICvx1kx6LNIWPfRc
sphTE0ktVkM4849BkoYYmeDjypr+ig+jugHgna4N2RVZYjgbKY7SDubk6gROXi4s
7T8BIeO6KFCYltv4joyECkFI20pKdDymemPlnTPRtlXvyRVqh1/pHX/iVSx1eG5Y
M4n1BWkJ7XWUI6x8yppyykJRHSsfZA==
=I7ho
-----END PGP SIGNATURE-----

--Sig_/zQt_i5i/0wX+K.IyNJL8Y3s--
