Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5048CA6762
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfICL1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:27:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44464 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbfICL1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:27:13 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BFF3C819EF; Tue,  3 Sep 2019 13:26:54 +0200 (CEST)
Date:   Tue, 3 Sep 2019 13:27:07 +0200
From:   Pavel Machek <pavel@denx.de>
To:     dsterba@suse.cz, Pavel Machek <pavel@denx.de>,
        Joe Perches <joe@perches.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <20190903112707.GA3844@amd>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
 <20190829103252.GA64893@architecture4>
 <67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com>
 <20190830120714.GN2752@twin.jikos.cz>
 <20190902084303.GC19557@amd>
 <20190902140712.GV2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20190902140712.GV2752@twin.jikos.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > No. gdb tells you what the actual offsets _are_.
>=20
> Ok, reading your reply twice, I think we have different perspectives. I
> don't trust the comments.
>=20
> The tool I had in mind is pahole that parses dwarf information about the
> structures, the same as gdb does. The actual value of the struct members
> is the thing that needs to be investigated in memory dumps or disk image
> dumps.
>=20
> > > > The expected offset is somewhat valuable, but
> > > > perhaps the form is a bit off given the visual
> > > > run-in to the field types.
> > > >=20
> > > > The extra work with this form is manipulating all
> > > > the offsets whenever a structure change occurs.
> > >=20
> > > ... while this is error prone.
> >=20
> > While the comment tells you what they _should be_.
>=20
> That's exactly the source of confusion and bugs. For me an acceptable
> way of asserting that a value has certain offset is a build check, eg.
> like
>=20
> BUILD_BUG_ON(strct my_superblock, magic, 16);

Yes, that would work, too. As would documentation file with the disk
structures.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1uTgsACgkQMOfwapXb+vL2IgCgs+lvDMnGJBdzf4Ded3ls5qz4
u/sAn1m34p0fdk6NLGSW8jaPems7I5EL
=38MN
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
