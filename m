Return-Path: <linux-fsdevel+bounces-2590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6024A7E6E1F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8B41C20C31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87340208D5;
	Thu,  9 Nov 2023 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ra0/TNGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54457208BE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 16:00:46 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A143254;
	Thu,  9 Nov 2023 08:00:45 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231109160043euoutp02b19c5109a8f1c47c44ad0f5a4f7de09a~V-8IZmgC53069030690euoutp02k;
	Thu,  9 Nov 2023 16:00:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231109160043euoutp02b19c5109a8f1c47c44ad0f5a4f7de09a~V-8IZmgC53069030690euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1699545643;
	bh=pa+bEWDjIl0GN9JmokWdsk4Q7Gcs1efzNkFal1HDZTc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ra0/TNGjJ+Y2pndDRS6b2Vt2aHroEen4QKszrw7BGp1sf6O41F6YGLZgB0Q8iUlsa
	 pDmQPV5PoG6lo/3tFp4jQ1ZEU45QFWk96kxc5gnx2TnVtRliL0R2sbX0jCXuE74txt
	 Occ9f7vltx0BrriT5gXeKPwTiUudqSIHbR7kHwzk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231109160043eucas1p296ace87297fe35b2e35e618a3f216a7a~V-8ILuzLy2854228542eucas1p21;
	Thu,  9 Nov 2023 16:00:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 28.C3.11320.B220D456; Thu,  9
	Nov 2023 16:00:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231109160042eucas1p2b119336f287d1d59325a03009cce1e84~V-8HvkAUf2327723277eucas1p2n;
	Thu,  9 Nov 2023 16:00:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231109160042eusmtrp1e151f7a0d35f6031c55f46a4929927ba~V-8HuPi7e0589505895eusmtrp1X;
	Thu,  9 Nov 2023 16:00:42 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-c2-654d022ba255
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 11.A8.10549.A220D456; Thu,  9
	Nov 2023 16:00:42 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231109160042eusmtip2313c1dffb58902dbd51aa957b98bf10e~V-8HcdEM70179101791eusmtip2k;
	Thu,  9 Nov 2023 16:00:42 +0000 (GMT)
Received: from localhost (106.210.248.176) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 9 Nov 2023 16:00:41 +0000
Date: Thu, 9 Nov 2023 17:00:40 +0100
From: Joel Granados <j.granados@samsung.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, <willy@infradead.org>,
	<josh@joshtriplett.org>, Kees Cook <keescook@chromium.org>, David Howells
	<dhowells@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Benjamin LaHaise <bcrl@kvack.org>, Eric
	Biederman <ebiederm@xmission.com>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
	Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
	Anton Altaparmakov <anton@tuxera.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
	<joseph.qi@linux.alibaba.com>, Iurii Zaikin <yzaikin@google.com>, "Theodore
 Y. Ts'o" <tytso@mit.edu>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick
 J. Wong" <djwong@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
	<coda@cs.cmu.edu>, <linux-cachefs@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-aio@kvack.org>, <linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>,
	<linux-ntfs-dev@lists.sourceforge.net>, <ocfs2-devel@lists.linux.dev>,
	<fsverity@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
	<codalist@telemann.coda.cs.cmu.edu>
Subject: Re: [PATCH 2/4] aio: Remove the now superfluous sentinel elements
 from ctl_table array
Message-ID: <20231109160040.bahkcsp44t5xu7qo@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="l4g2lsqapwic34ka"
Content-Disposition: inline
In-Reply-To: <20231108034231.GB2482@sol.localdomain>
X-Originating-IP: [106.210.248.176]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTe1BUZRztu/fuvcsy0GWl+AIEZyUyUMpH40el0kwz3RxMsGYq/wB34g5i
	PHfdBGZQWlTYlZGHIfKSRXkJgrogjwXiDfIwHlYur51Yl4mAjPeI0G4sF8uZ/jvnfOf85pw/
	Pj4uLKPs+UGhp1lJqDhYRAqIqo6Vvl3u2BH23aFUAeovLwXoQq2JQLXqSh5SGisJNN06D9Bg
	uxMyjf2OoeXbWgzVlT/FUO6NChI9la8S6JHBGpmqzlOorH4NRwq9iURZ6XEYKhhR8NBKYQmF
	un5aJtCtwmcUMqnCUO+lEFQzZiBQytUCHP1wVQ7QXH43heobutaPabJJpLtt4qH+ph4eik/I
	BkizVkOhSynpFNImTwDUkBtLoBbdLzwkz2nkoe7n3RgyaQ+hC4krFOr7u5OHVp+tHyms/czL
	ncmKHSAYVZs3MzFwjLkzlEoytZljFKNSy5i1lnsUU1HsxgxPH2DUJQqSUc+nUkztuCczWZEB
	mDrVAsbIe9tx5tr8Iuljf1zwYQAbHPQdK3nn4AnByVu6Q+EFosiatItULGhzVAILPqT3wZUk
	NaYEAr6QLgZQmzGEc2QRwPvNDSRHFgC8UaLBX0QKWos2XUUALuZf5v3rGtDUEhypBFCviyfM
	EYJ2gZe11zfiJL0T9s2MrmM+35Z2hR0FR81+nK6whEp9M2bWt9BimNvsarZb0fvhSHE7wWEb
	2JVh2MA4HQkzqrI3zuC0Aywy8s2yxXq54fy7gCu6HcZVN1EcjoHdlcMbOyH9yBKuTnZsmj6G
	WSnGTbwFTnVWbgYcYc+VRIILXAGw0ThLcaQUwMLvlzDO9QE8/7NhM/ERTFEmEeZGkLaG2j9t
	uKLWMLUqHedkK5hwUci5XWGpboZIBtszX5qW+dK0zP+mcfJOqKqbJ/8nu8PCvGmcwwdgeflf
	hApQJcCOlUlDAlnpnlD2jIdUHCKVhQZ6fBMWogbrv6jH2LlYA4qm5jxaAMYHLcBlPay/W9oP
	7InQsFBWZGvVv8+bFVoFiKOiWUmYv0QWzEpbgAOfENlZvRngzArpQPFp9luWDWclL14xvoV9
	LPaK99Co59mFL/psvDpLwr2RQvGwTdcxcTDa3pYvl1klkXumIo79ei+lscfR1jpPnaxx/tTT
	L26vz243i/vjmXeWJpu6ys4d9X8S4bg1J5EneCIveHtmdCS+32/4+vGbQVrl+9VtMxazST8+
	zntP5D0wR/5WOrQcCc/aSlt6nb6y6FhJ+PwTr5w5rx79jpAEp72VdHWjwH/wzHhcRJ6lUPS6
	LC/KoT2CH67R+xjEgzVlh0XWRr/qa4Tv1l3nto3HvPrGCdfZI3ZzGueY+SXf5zfTmh5SljtS
	R2ODKtJmHjg0tp6y9I122f/HW4r6r/u+3Ba1qD/1Wpig87B/nNvjIMyQtmZ4ICKkJ8W73XCJ
	VPwPDUSbhsAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTbVBUVRjHOfdl74KhN6C6IDjOili8rCyvZxlRP1BzS+kFPqSG4hVuwMju
	4r6gNCPRIiMshUCksqisxgIuRLJLxCqOsgYEUqKFbCCrEVhEYbswKoG77brT5Ezf/uf//J/f
	PM+Zc7iozyAngJsjlrNSMZPL43hh1+39lohQJJmNtB7ZAIfbWgAsMTowaNR34FBl78Dg7DUb
	gLd610DHxK8IfNhqRuCltjkE1p8zcOCccgmDP0ythI7OIwT8onsZhWWTDg6sO1GMQO14GQ4X
	G3UEHPj+IQbPNz4moEMjgUPlItg1MYXBquNaFNYcVwJobRgkYPflASfs4ikOtLQ6cDh89ToO
	j5aeAvDichcBy6tOENBcOQ3g5foiDJosIzhUnr6Cw8G/BxHoMG+BJR8vEvDGk34cLj12QhqN
	b24No+uKbmK05pvt9PTNFPrLn6o5tFE9QdAavYJeNrUTtKE5lB6bTaT1ujIOrbdVE7TxZyH9
	m6EW0Jc08witHOpF6ZO2Bc7bAbv4m6QShZxdmy2RyRN57wlgFF8ghPyoGCFfEB2/OyEqlrdx
	86ZMNjcnn5Vu3LyXnz0w/gDP+5x3qHboNqcImAJVwJNLkTGU9loTqgJeXB9SC6jWY92YuxBI
	tS+M4G7tSy3fVnHcISugxsdu4e5DB6DKrJWIK4WRwVSF+Qzq0hwynLrxxx2n5nL9yBCqT/uW
	K4+ShhVUzV3jU9+XZKj6nhBX3JuMp8abezE38zRCdRaP4u7C89RA7dTTiVAynxrtmiFcvSi5
	mmqyc122p3ODsYYLwD3oOqr466uEWx+m5p/cB5XAV/0MSf0MSf0fyW2HUmb7DPI/O4xqPDuL
	unUi1db2ANMAQgf8WIVMlCWSCfgyRiRTiLP4GRKRHjgfcmffoqELnPndyjcBhAtMINjZOXmh
	ZRgEYGKJmOX5eQ/HbGd9vDOZgg9YqSRdqshlZSYQ67zEKjTghQyJ81eI5emCuMhYQUycMDJW
	GBfNe8n79bxSxofMYuTsfpbNY6X/9iFcz4AiZE/I+vZXbckf2e9WktOCbS+qnuMzujlLXrhA
	kqNcFxx5NEjYQjXds/fnK0fjd/L2rjk8s5QW1I3UFbyS1JKqO0m+xkwes3zWHKhvTU2yjwA/
	8ZXSmpdRGKFCpwvKIw5oa3mFHaJDurXnetDUwvAej+CEd3/cZ/mOuQdI7yS5vxTbv4Pc8otP
	WuCnmQJ/jdXr/QzbDrXc/EZF9Z2/tq1/J6jYEJfStHpiHtV6+ld/MltWIdj3aGtYS+GeD3cv
	pInSV3oEJf+5yHwbpUrZyRJp0dYDDZ4btOdb+w4iPfdTdykCGxODEszDq+jOZr3o4Aqth9z4
	VXsSnrHK+qjk7IhNzsNk2YwgFJXKmH8Ajnig1V0EAAA=
X-CMS-MailID: 20231109160042eucas1p2b119336f287d1d59325a03009cce1e84
X-Msg-Generator: CA
X-RootMTR: 20231108034239eucas1p2e5dacae548e47694184df217ee168da9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231108034239eucas1p2e5dacae548e47694184df217ee168da9
References: <20231107-jag-sysctl_remove_empty_elem_fs-v1-0-7176632fea9f@samsung.com>
	<20231107-jag-sysctl_remove_empty_elem_fs-v1-2-7176632fea9f@samsung.com>
	<CGME20231108034239eucas1p2e5dacae548e47694184df217ee168da9@eucas1p2.samsung.com>
	<20231108034231.GB2482@sol.localdomain>

--l4g2lsqapwic34ka
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 07:42:31PM -0800, Eric Biggers wrote:
> On Tue, Nov 07, 2023 at 02:44:21PM +0100, Joel Granados via B4 Relay wrot=
e:
> > [PATCH 2/4] aio: Remove the now superfluous sentinel elements from ctl_=
table array
>=20
> The commit prefix should be "fs:".
>=20
> > Remove sentinel elements ctl_table struct. Special attention was placed=
 in
> > making sure that an empty directory for fs/verity was created when
> > CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not defined. In this case we use=
 the
> > register sysctl call that expects a size.
> [...]
> > diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> > index d071a6e32581..8191bf7ad706 100644
> > --- a/fs/verity/fsverity_private.h
> > +++ b/fs/verity/fsverity_private.h
> > @@ -122,8 +122,8 @@ void __init fsverity_init_info_cache(void);
> > =20
> >  /* signature.c */
> > =20
> > -#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> >  extern int fsverity_require_signatures;
> > +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> >  int fsverity_verify_signature(const struct fsverity_info *vi,
> >  			      const u8 *signature, size_t sig_size);
> > =20
> > diff --git a/fs/verity/init.c b/fs/verity/init.c
> > index a29f062f6047..e31045dd4f6c 100644
> > --- a/fs/verity/init.c
> > +++ b/fs/verity/init.c
> > @@ -13,7 +13,6 @@
> >  static struct ctl_table_header *fsverity_sysctl_header;
> > =20
> >  static struct ctl_table fsverity_sysctl_table[] =3D {
> > -#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> >  	{
> >  		.procname       =3D "require_signatures",
> >  		.data           =3D &fsverity_require_signatures,
> > @@ -23,14 +22,17 @@ static struct ctl_table fsverity_sysctl_table[] =3D=
 {
> >  		.extra1         =3D SYSCTL_ZERO,
> >  		.extra2         =3D SYSCTL_ONE,
> >  	},
> > -#endif
> > -	{ }
> >  };
> > =20
> >  static void __init fsverity_init_sysctl(void)
> >  {
> > +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> >  	fsverity_sysctl_header =3D register_sysctl("fs/verity",
> >  						 fsverity_sysctl_table);
> > +#else
> > +	fsverity_sysctl_header =3D register_sysctl_sz("fs/verity",
> > +						 fsverity_sysctl_table, 0);
> > +#endif
> >  	if (!fsverity_sysctl_header)
> >  		panic("fsverity sysctl registration failed");
>=20
> This does not make sense, and it causes a build error when CONFIG_FS_VERI=
TY=3Dy
> and CONFIG_FS_VERITY_BUILTIN_SIGNATURES=3Dn.
>=20
> I think all you need to do is delete the sentinel element, the same as
> everywhere else.  I just tested it, and it works fine.
I found the reason why I added the CONFIG_FS_VERITY_BUILTIN_SIGNATURES
here: it is related to
https://lore.kernel.org/all/20230705212743.42180-3-ebiggers@kernel.org/
where the directory is registered with an element only if
CONFIG_FS_VERITY_BUILTIN_SIGNATURES is defined. I had forgotten, but I
even asked for a clarification on the patch :).

I see that that patch made it to v6.6. So the solution is not to remove
the CONFIG_FS_VERITY_BUILTIN_SIGNATURES, but for me to rebase on top of
a more up to date base.

@Eric: Please get back to me if the patch in
https://lore.kernel.org/all/20230705212743.42180-3-ebiggers@kernel.org/
is no longer relevant.

Best.

>=20
> BTW, the comments for register_sysctl_sz() and __register_sysctl_table() =
are
> outdated, as they still say "A completely 0 filled entry terminates the t=
able."
>=20
> - Eric

--=20

Joel Granados

--l4g2lsqapwic34ka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVNAicACgkQupfNUreW
QU/GDgv/RABlWS8CUHeazT6R6sZRrWYGzO5BFRViRaIJEt9DGxPeVdxGY5fggAJB
noHXVpWD4pdS23h/JVKSgpbTgLL6Cf7ZpIz0dx/AaPEA6GaYaZQu0V+MlDeDJtAv
NxOvKTvaCgiCkWS/VYVSs2lSfGhSdHLUuZYLAdeAym0Iw0xwxbBneYjoCTDAxVh/
QE8RNvzM8YP6UJmUjOLYqGmb9CQS1tFtq92ISERe+sMogfc0EECLD0vzOM+CXT/Q
Ps87qwdFoDxwCoQzGRmdYLkpwEJZ9pIZ1cHUI29/VBh5F6utWGZvefDz8vSVcbNc
x8R5Pi4IMIax7MSUrASAljHq5hpaKDJGOIzMxBnCe/1im78XVYg70RwBPL7tyfdm
FyHNyDDQJuy6B74bEqGsolKqY8peghoOmAOF047JXbMnWUgtqLVtoj6R7blYdQAh
5OX13eCmTHSlYS+F62ayufBClYx3Sv2Lm1tyrr2Jt8R/nqjn49MLyfPAFZ96yeLH
5C8y/YbF
=rsQZ
-----END PGP SIGNATURE-----

--l4g2lsqapwic34ka--

