Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6D28E527
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 09:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfHOHBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 03:01:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50169 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfHOHBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:01:35 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 34AD7806FD; Thu, 15 Aug 2019 09:01:20 +0200 (CEST)
Date:   Thu, 15 Aug 2019 09:01:32 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v7 08/24] erofs: add namei functions
Message-ID: <20190815070132.GB3669@amd>
References: <20190813091326.84652-1-gaoxiang25@huawei.com>
 <20190813091326.84652-9-gaoxiang25@huawei.com>
 <20190813114821.GB11559@amd>
 <20190813122332.GA17429@138>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20190813122332.GA17429@138>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +	/*
> > > +	 * on-disk error, let's only BUG_ON in the debugging mode.
> > > +	 * otherwise, it will return 1 to just skip the invalid name
> > > +	 * and go on (in consideration of the lookup performance).
> > > +	 */
> > > +	DBG_BUGON(qd->name > qd->end);
> >=20
> > I believe you should check for errors in non-debug mode, too.
>=20
> Thanks for your kindly reply!
>=20
> The following is just my personal thought... If I am wrong, please
> kindly point out...
>=20
> As you can see, this is a new prefixed string binary search algorithm
> which can provide similar performance with hashed approach (but no
> need to store hash value at all), so I really care about its lookup
> performance.
>=20
> There is something needing to be concerned, is, whether namei() should
> report any potential on-disk issues or just return -ENOENT for these
> corrupted dirs, I think I tend to use the latter one.

-ENOENT is okay for corrupted directories, as long as corrupted
directories do not cause some kind of security bugs (memory
corruption, crashes, ...)


Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1VA0wACgkQMOfwapXb+vJ0RACeIl9SXkQ+HyKjoz6KEOY1IIxQ
fokAoLx3vqeReYdzJjSOjFpCjcgEgtud
=GkrJ
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
