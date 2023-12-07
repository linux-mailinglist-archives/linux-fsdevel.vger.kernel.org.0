Return-Path: <linux-fsdevel+bounces-5147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C872B8087D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 13:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D03C1F21492
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE133D0A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dnsN/Wrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F3C13D;
	Thu,  7 Dec 2023 04:06:02 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231207120600euoutp021afe78d5a88592cff751fe50e48c2acf~eizMME8tP1758317583euoutp02P;
	Thu,  7 Dec 2023 12:06:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231207120600euoutp021afe78d5a88592cff751fe50e48c2acf~eizMME8tP1758317583euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701950760;
	bh=YztNyyLT9T8PeUHhm36EHNMC9OwgWapW+CJQNiPG0XA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dnsN/Wrj9y5g3QjtHKpnLFpa5Kpmnnpj6J2EoTIb2gs1UALBtvN3jhG82GcWWrFyw
	 e7ZdkytaTXqMM6YxSdRn+xFym5dkZ2MKLkGcyVwJby0slU0pyIpaPcD3y/e2ngi9wl
	 FnPMg4VsIGNg3J17wZPdCqjRJRyNFhXwEvmOIvtI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231207120600eucas1p10a7e2faac34b2d63bfa1e43024b941a7~eizL-Y5j_3104031040eucas1p1R;
	Thu,  7 Dec 2023 12:06:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A1.EF.09552.825B1756; Thu,  7
	Dec 2023 12:06:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231207120559eucas1p221e7f8bcbd98f1083d17421761d60ad3~eizLlfbL21395513955eucas1p2z;
	Thu,  7 Dec 2023 12:05:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231207120559eusmtrp285b9ce79a9130a04491c0bc7a4e466f1~eizLk3k1d1641516415eusmtrp2y;
	Thu,  7 Dec 2023 12:05:59 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-6f-6571b52877f9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7F.1D.09274.725B1756; Thu,  7
	Dec 2023 12:05:59 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231207120559eusmtip265ab489396f9b6d59930ab1ec282e370~eizLV32cQ0342503425eusmtip2R;
	Thu,  7 Dec 2023 12:05:59 +0000 (GMT)
Received: from localhost (106.210.248.38) by CAMSVWEXC02.scsc.local
	(106.1.227.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 Dec
	2023 12:05:58 +0000
Date: Thu, 7 Dec 2023 13:05:57 +0100
From: Joel Granados <j.granados@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Kees Cook
	<keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Message-ID: <20231207120557.2om7knogbsu3cgrf@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="db4qfr2oz7c2s6rl"
Content-Disposition: inline
In-Reply-To: <CAB=NE6UCP05MgHF85TK+t2yvbOoaW_8Yu6QEyaYMdJcGayVjFQ@mail.gmail.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (106.1.227.71) To
	CAMSVWEXC02.scsc.local (106.1.227.72)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djPc7oaWwtTDX7fE7BoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBbFJdNSmpOZllqkb5dAlfG8qkNbAUTxSrWb5FpYJwg1MXIySEhYCLx
	5eQRpi5GLg4hgRWMEttunWQCSQgJfGGU+NqqBZH4zCjR0wyRAOk4ceo8G0RiOaPE0qZN7HBV
	1383QGWWMUocbHsK1sIioCJxevscMJtNQEfi/Js7zCC2iICGxL4JvWDLmQXOMUmsOHGdFSQh
	LOAlcWPackYQm1fAXOLo1KOsELagxMmZT1hAbGaBComObyALOIBsaYnl/zhAwpwCgRKPf11g
	hDhVSeLw5M/MEHayRMufv2C7JARWc0o8vXkQ6h8XiQsrp7JD2MISr45vgbJlJP7vnA/VMJlR
	Yv+/D+xQ3YwSyxq/QnVbS7RceQLV4ShxeNINFpCLJAT4JG68FYQ4lE9i0rbpzBBhXomONmjI
	q0msvveGZQKj8iwkr81C8toshNcgTE2J9bv0UURBirUlli18zQxh20qsW/eeZQEj+ypG8dTS
	4tz01GLjvNRyveLE3OLSvHS95PzcTYzAFHf63/GvOxhXvPqod4iRiYPxEKMKUPOjDasvMEqx
	5OXnpSqJ8Oacz08V4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi
	4JRqYNq01qz+19dFz3Xmu5kXfGwWWmRT5jxlU3v5st0Gu4XcUu7P2fZ1p4Z9wIdzG9a9XKn2
	rT2oVX+XyqLq30ffhYclG7AHVLImSz5vSIvQnP151h6Raq53G/lq9V3Nw8s8uSqXsmtxn/J4
	uzb0qHGg0NRkM/PPc1XuL2Gtbv5vr8R543Sk76ywJf73et+sX2HXP7c61ETw18ekSQePvT04
	QWbitueVbh9P7N57QGdPq+eZJYLm2fzPV9bdS+5N+dJQrOcYs8yGIyhR3TqJ5doq5rW/L53p
	Tpy2bpOpQdRNjt0X3yaITVudLeguX/NROkalf8o55sVMUvemTPKxkPp+J1bmpsIDp8XypS9u
	C9yZ8UeJpTgj0VCLuag4EQCkRkyH7AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsVy+t/xe7rqWwtTDV7+M7JoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
	SmpOZllqkb5dgl7GxPnRBf1iFZO3XWJpYOwT6mLk5JAQMJE4ceo8WxcjF4eQwFJGiY+zbjFB
	JGQkNn65ygphC0v8udYFVfSRUWLNyq8sEM4yRomDpzrYQapYBFQkTm+fA9bNJqAjcf7NHWYQ
	W0RAQ2LfhF4mkAZmgXNMEru2XQVLCAt4SdyYtpwRxOYVMJc4OvUoK8TUn0wSb++fgEoISpyc
	+YQFxGYWKJNY+Xwv0DYOIFtaYvk/DpAwp0CgxONfFxghTlWSODz5MzOEnSwxac8vxgmMwrOQ
	TJqFZNIshEkQYXWJP/MuMWMIa0ssW/iaGcK2lVi37j3LAkb2VYwiqaXFuem5xUZ6xYm5xaV5
	6XrJ+bmbGIGxvu3Yzy07GFe++qh3iJGJg/EQowpQ56MNqy8wSrHk5eelKonw5pzPTxXiTUms
	rEotyo8vKs1JLT7EaAoMxonMUqLJ+cAklFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKa
	nZpakFoE08fEwSnVwJQqXr190dsrq9Nlfm01ktAUrcq+8Del/fGT+nO/o7x9t9xyW/dvqdlK
	z/5jISEGomsW3kt5NtmrMjHo2p4Xx1TVevw4J8UEmwdz2volcBxdqxJ8+cfCPNszNs0HXN+y
	PNm+cMXNdc6au4/dMLp8xXHZm1/Cr08L/Nj583HnPqvJfcad86YfjmFxqCnnMA1+d+yESaF4
	Nfs9R1ZpHx6DHcr3tZ9/lTfge3Q3S2DVIh/N59qp3otVTqSwnGL76vvrl/dLMVHTDUtOTG8X
	eWt9Ml2Ox9Bh0b4Ym81LXrNw3biVd7b+nbqA09m1jmqPZzn/iC7c41W91tLtGseaY3Y+l6ok
	zPMSol8tWK8wLbp02QclluKMREMt5qLiRADhR7n6igMAAA==
X-CMS-MailID: 20231207120559eucas1p221e7f8bcbd98f1083d17421761d60ad3
X-Msg-Generator: CA
X-RootMTR: 20231205225020eucas1p2873217afd908334ba2669aad02b95cbb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231205225020eucas1p2873217afd908334ba2669aad02b95cbb
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
	<ZW+lQqOSYFfeh8z2@bombadil.infradead.org>
	<4a93cdb4-031c-4f77-8697-ce7fb42afa4a@t-8ch.de>
	<CGME20231205225020eucas1p2873217afd908334ba2669aad02b95cbb@eucas1p2.samsung.com>
	<CAB=NE6UCP05MgHF85TK+t2yvbOoaW_8Yu6QEyaYMdJcGayVjFQ@mail.gmail.com>

--db4qfr2oz7c2s6rl
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 02:50:01PM -0800, Luis Chamberlain wrote:
> On Tue, Dec 5, 2023 at 2:41=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weiss=
schuh.net> wrote:
> >
> > On 2023-12-05 14:33:38-0800, Luis Chamberlain wrote:
> > > On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Wei=C3=9Fschuh wrote:
> > > > @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir, s=
truct ctl_table_header *header)
> > > >             return -EROFS;
> > > >
> > > >     /* Am I creating a permanently empty directory? */
> > > > -   if (sysctl_is_perm_empty_ctl_header(header)) {
> > > > +   if (header->ctl_table =3D=3D sysctl_mount_point ||
> > > > +       sysctl_is_perm_empty_ctl_header(header)) {
> > > >             if (!RB_EMPTY_ROOT(&dir->root))
> > > >                     return -EINVAL;
> > > >             sysctl_set_perm_empty_ctl_header(dir_h);
> > >
> > > While you're at it.
> >
> > This hunk is completely gone in v3/the code that you merged.
>=20
> It is worse in that it is not obvious:
>=20
> +       if (table =3D=3D sysctl_mount_point)
> +               sysctl_set_perm_empty_ctl_header(head);
Notice that the test is done on the header and the set is done on the
dir_h.

I mention this because here you wrote:
"sysctl_set_perm_empty_ctl_header(head)"
instead of
"sysctl_set_perm_empty_ctl_header(dir_h)"

dir_h and head are different.

Was this your concern? or did I miss your point?
>=20
> > Which kind of unsafety do you envision here?
>=20
> Making the code obvious during patch review hy this is needed /
> special, and if we special case this, why not remove enum, and make it
> specific to only that one table. The catch is that it is not
> immediately obvious that we actually call
> sysctl_set_perm_empty_ctl_header() in other places, and it begs the
> question if this can be cleaned up somehow.
>=20
>   Luis

--=20

Joel Granados

--db4qfr2oz7c2s6rl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVxtSQACgkQupfNUreW
QU+dkgv+IVdWMcibpYRbbXQoIvmp+lnMk4qkm9BsJi0/8ejv4NT5T9fFzk8Y4dYA
5hWIk9KWoG4qSBgQKOhaOv79mDsScZr4rv0PsEAYbK/ZKppmAKW3Pm2Ex6OBNyv2
BneQ8Coci9h1sWUQkoiX7+NgCQczzi6TgRpRtucbFoN+BIkYklcrwyZszBkiX6jW
dt50vOI1NGKqpu6GSZ2F22d+V58BBS7QmOmK1LRlTmPut/t5dJOfN/5d9JNNxIyJ
O8aSQ0iDXCH4E6qiZV5qC+aJBldu8T0gynVXDg/IoPInwr8d10kD5JEjxbgXo/Ey
s/aFB0qBToVQqK8xAG7T6p99QB1uIyQfBC/d9YRDhGTYiAXxYrfyc0cIFmQJ9AES
s9hh8ZVw0OLcg6lRycWfYv8eiqGYVKf5XOMsxHW+d1k5X9/L+Oxn9KCVc7bU2kez
hgqI3A3mvjW9ppDOq7CFsTH82CVZAHxNGXWBEETxCOu3q6OAGJXReXAqQEzna61A
Q1NQcRWM
=ca10
-----END PGP SIGNATURE-----

--db4qfr2oz7c2s6rl--

