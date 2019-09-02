Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E85CEA520C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 10:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfIBInH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 04:43:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39534 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfIBInG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:43:06 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ACB57809D3; Mon,  2 Sep 2019 10:42:50 +0200 (CEST)
Date:   Mon, 2 Sep 2019 10:43:03 +0200
From:   Pavel Machek <pavel@denx.de>
To:     dsterba@suse.cz, Joe Perches <joe@perches.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190902084303.GC19557@amd>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
 <20190829103252.GA64893@architecture4>
 <67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com>
 <20190830120714.GN2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <20190830120714.GN2752@twin.jikos.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Rather than they didn't run "gdb" or "pahole" and change it by mistak=
e.
> >=20
> > I think Christoph is not right here.
> >=20
> > Using external tools for validation is extra work
> > when necessary for understanding the code.
>=20
> The advantage of using the external tools that the information about
> offsets is provably correct ...

No. gdb tells you what the actual offsets _are_.

> > The expected offset is somewhat valuable, but
> > perhaps the form is a bit off given the visual
> > run-in to the field types.
> >=20
> > The extra work with this form is manipulating all
> > the offsets whenever a structure change occurs.
>=20
> ... while this is error prone.

While the comment tells you what they _should be_.

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1s1hcACgkQMOfwapXb+vLwegCgmC1y9HxKZu/YFm0T4U+rH5ko
oJcAni3phOqqriczOS1slpVzLy+HY7Nv
=pnr4
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
