Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58526684A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfGOH4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 03:56:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39892 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfGOH4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:56:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9159880525; Mon, 15 Jul 2019 09:56:30 +0200 (CEST)
Date:   Mon, 15 Jul 2019 09:56:41 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/24] erofs: promote erofs from staging
Message-ID: <20190715075641.GA7695@amd>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
 <20190714104940.GA1282@xo-6d-61-c0.localdomain>
 <63b9eaca-5d4b-0fe2-c861-7531977a5b48@aol.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <63b9eaca-5d4b-0fe2-c861-7531977a5b48@aol.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Changelog from v1:
> >>  o resend the whole filesystem into a patchset suggested by Greg;
> >>  o code is more cleaner, especially for decompression frontend.
> >>
> >> --8<----------
> >>
> >> Hi,
> >>
> >> EROFS file system has been in Linux-staging for about a year.
> >> It has been proved to be stable enough to move out of staging
> >> by 10+ millions of HUAWEI Android mobile phones on the market
> >> from EMUI 9.0.1, and it was promoted as one of the key features
> >> of EMUI 9.1 [1], including P30(pro).
> >=20
> > Ok, maybe it is ready to be moved to kernel proper, but as git can
> > do moves, would it be better to do it as one commit?
> >=20
> > Separate patches are still better for review, I guess.
>=20
> Thanks for you reply. Either form is OK for me... The first step could
> be that I hope someone could kindly take some time to look into these
> patches... :)
>=20
> The patch v2 is slightly different for the current code in the staging
> tree since I did some code cleanup these days (mainly renaming / moving,
> including rename unzip_vle.{c,h} to zdata.{c,h} and some confusing
> structure names and clean up internal.h...). No functional chance and I
> can submit cleanup patches to staging as well if doing moves by git...

I believe you should get those committed to staging/, yes. Then you
ask Al Viro to do pull the git move, I guess, and you follow his
instructions at that point...

FILESYSTEMS (VFS and infrastructure)
M:      Alexander Viro <viro@zeniv.linux.org.uk>
L:      linux-fsdevel@vger.kernel.org

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0sMbkACgkQMOfwapXb+vIr6QCfeBDCyzFgvaSHJ4qypSy3Ws3a
t+QAoIMCkNTsXsQe3twlBOhsbV6DSfvw
=KP0L
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
