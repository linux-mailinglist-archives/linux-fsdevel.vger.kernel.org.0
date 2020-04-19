Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48C81AF927
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 11:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDSJ5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 05:57:11 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:43820 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSJ5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 05:57:11 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 494lc13wsszQkJn;
        Sun, 19 Apr 2020 11:57:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id NEBcbWR4rXqI; Sun, 19 Apr 2020 11:57:01 +0200 (CEST)
Date:   Sun, 19 Apr 2020 19:56:51 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH] vfs: add faccessat2 syscall
Message-ID: <20200419095651.djee6mgneyf3qi3v@yavin.dot.cyphar.com>
References: <20200416143532.11743-1-mszeredi@redhat.com>
 <c47459a5-3323-121e-ec66-4a8eb2a8afca@samba.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lmda2lbevichqywo"
Content-Disposition: inline
In-Reply-To: <c47459a5-3323-121e-ec66-4a8eb2a8afca@samba.org>
X-Rspamd-Queue-Id: 37BD217EF
X-Rspamd-Score: -9.29 / 15.00 / 15.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lmda2lbevichqywo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-18, Stefan Metzmacher <metze@samba.org> wrote:
> > POSIX defines faccessat() as having a fourth "flags" argument, while the
> > linux syscall doesn't have it.  Glibc tries to emulate AT_EACCESS and
> > AT_SYMLINK_NOFOLLOW, but AT_EACCESS emulation is broken.
> >=20
> > Add a new faccessat(2) syscall with the added flags argument and implem=
ent
> > both flags.
> >=20
> > The value of AT_EACCESS is defined in glibc headers to be the same as
> > AT_REMOVEDIR.  Use this value for the kernel interface as well, together
> > with the explanatory comment.
>=20
> It would be nice if resolv_flags would also be passed in addition to the
> at flags.
> See:https://lore.kernel.org/linux-api/CAHk-=3DwiaL6zznNtCHKg6+MJuCqDxO=3D=
yVfms3qR9A0czjKuSSiA@mail.gmail.com/
>=20
> We should avoid expecting yet another syscall in near future.

If faccessat2() supported AT_EMPTY_PATH (which I'd be in favour of),
there's no need to add resolve flags because you could open the file as
O_PATH with whatever resolve flags you want, and then check it with
faccessat2().

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--lmda2lbevichqywo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXpwgYAAKCRCdlLljIbnQ
ElqnAQDppWaDa1Cc9a8o5EOeojrE4ZHo8+PiXfVr3y9Ee7V75AD/d35WYD5+LhFD
cVKGSxPjCXAcAalrnfXQI8yCl/6iFAs=
=mf5A
-----END PGP SIGNATURE-----

--lmda2lbevichqywo--
