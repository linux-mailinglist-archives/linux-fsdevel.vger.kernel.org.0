Return-Path: <linux-fsdevel+bounces-5454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBA080C351
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 09:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37172B20A04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54020DF0;
	Mon, 11 Dec 2023 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uzUzlNey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41BFB7;
	Mon, 11 Dec 2023 00:34:26 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231211083423euoutp02d7a9f17e13c99f10e7c77aa6c360e767~fufkmg7CC3271332713euoutp026;
	Mon, 11 Dec 2023 08:34:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231211083423euoutp02d7a9f17e13c99f10e7c77aa6c360e767~fufkmg7CC3271332713euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702283663;
	bh=P29krkBAQBqnkKdOFl3EL3UyYbzgflEhF00VK7ufnuM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uzUzlNeyBw9G+WkxzlsmJV7laWBEf5QvdxoGfuR+fIDKVJNVVkYgLI8c7eIk6f72x
	 JxXeQYZw2Rv5w2aiTI0gc1mIf0xfcvnAPs3uWqKtVmm2zMTTn7rqQFtwlGlei4MhJZ
	 7abzVXfB93iemPbQOAC24SRYXqhcqzdgWuyKHqy4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231211083423eucas1p299da08b36c59c3686e93af53df3983f1~fufkJmrSf1581415814eucas1p20;
	Mon, 11 Dec 2023 08:34:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 22.E4.09814.F89C6756; Mon, 11
	Dec 2023 08:34:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231211083423eucas1p273a157b7e673f588d396d5c2e75e3cc1~fufjyA_v51581515815eucas1p2s;
	Mon, 11 Dec 2023 08:34:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231211083423eusmtrp17aef497af7333a7357f90d125c118c13~fufjw2pMD0981409814eusmtrp1b;
	Mon, 11 Dec 2023 08:34:23 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-b9-6576c98f87a9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 5D.F5.09274.E89C6756; Mon, 11
	Dec 2023 08:34:22 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231211083422eusmtip12475ee422a03dbfe874e6401921d8ec9~fufjhYrFT1823418234eusmtip1w;
	Mon, 11 Dec 2023 08:34:22 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 11 Dec 2023 08:34:22 +0000
Date: Fri, 8 Dec 2023 10:59:26 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <20231208095926.aavsjrtqbb5rygmb@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="tkudj6zge43ee23g"
Content-Disposition: inline
In-Reply-To: <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87r9J8tSDdqXi1k0L17PZvHr4jRW
	izPduRZ79p5ksZi3/iejxeVdc9gsfv94xmRxY8JTRotlO/0cOD1mN1xk8ViwqdRj06pONo/9
	c9ewe3zeJOfR332MPYAtissmJTUnsyy1SN8ugStj6uJjrAXX1CuuLT/C0sD4RL6LkZNDQsBE
	4sGC/+xdjFwcQgIrGCU2/poJ5XxhlGjce4YFwvnMKPFwwU5GmJY1+2YxQySWM0psPvyICa6q
	s+8eVP8WRokP77eBtbAIqEh8On+DHcRmE9CROP/mDjOILSJgI7Hy22ewBmaBXUwSjx/OBRrF
	wSEs4CCxrUkSpIZXwFxi7oeNLBC2oMTJmU/AbGaBComfPxeAlTMLSEss/8cBEuYEGnmoaQE7
	xKVKEl/f9LJC2LUSp7bcYoKwl3NKHP4RBmG7SEw4tAbqM2GJV8e3QPXKSJye3AP2voTAZEaJ
	/f8+sEM4qxklljV+hZpkLdFy5QlUh6PEurlLWUEOkhDgk7jxVhDiTj6JSdumM0OEeSU62oQg
	qtUkVt97wzKBUXkWks9mIflsFsJnEGE9iRtTp7BhCGtLLFv4mhnCtpVYt+49ywJG9lWM4qml
	xbnpqcVGeanlesWJucWleel6yfm5mxiBSe70v+NfdjAuf/VR7xAjEwfjIUYVoOZHG1ZfYJRi
	ycvPS1US4ZU5UpwqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9sSQ1OzW1ILUIJsvE
	wSnVwCT0X9xgVXbGLoW9s9WYynVnnIjW2/hU9vvMe+fSzppZXDhTz9H8/uIZxuBJCYvXbNyw
	+3xPyMdI/WX7uvfO3xG15/OLdtO8jRKuLs/z/Q+/M71g+tMtueGY162bsS/Oyi1Kf3Lice2L
	51PFKmY/1ns357nMlOvXC8zX9jzu7LwqvO9uS5ZWe1C33NtHhzoNxLRFvGV/C27PeXVUW77+
	1upoY2Hjli3V0mfyDlR99lR98HbVn+qQ+lDvL9YfmDpMxX7oLfjIuN96PfvLmXsnvTh6sbxk
	9dwZLxpueG+3WX6O6/pTM8uzticyd2VrXDuVsI/z/kFrLYVXmdzf+XwvaDoxzliXfnT2f4m0
	8o0c1Wn/lFiKMxINtZiLihMBqtWqNO0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xu7p9J8tSDZ7/MrNoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
	SmpOZllqkb5dgl5G/4rPrAVX1CuWv1RpYHwk38XIySEhYCKxZt8sZhBbSGApo8SszmqIuIzE
	xi9XWSFsYYk/17rYuhi5gGo+MkrMP/2EBaJhC6PEyj5dEJtFQEXi0/kb7CA2m4COxPk3d8CG
	igjYSKz89pkdpJlZYBeTxOOHc5m6GDk4hAUcJLY1SYLU8AqYS8z9sJEFYsEPRom7jxuZIRKC
	EidnQixjFiiTuPzxEitIL7OAtMTyfxwgYU6g+YeaFrBDHKok8fVNL9TRtRKf/z5jnMAoPAvJ
	pFlIJs1CmAQR1pHYufUOG4awtsSyha+ZIWxbiXXr3rMsYGRfxSiSWlqcm55bbKRXnJhbXJqX
	rpecn7uJERjl24793LKDceWrj3qHGJk4GA8xqgB1Ptqw+gKjFEtefl6qkgivzJHiVCHelMTK
	qtSi/Pii0pzU4kOMpsBQnMgsJZqcD0w/eSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZ
	qakFqUUwfUwcnFINTNu2ulh4zfoaWW64ZW31+uB5UorFGh2Xgx05b7R3pa/sbJg69+AzFmX5
	1uzb6vO11I5Fs4T+ChN81iKzWn/aDKY7Icemh56JuhenrpFXvGWzM+uTgJk5p/wrgp5fDDz0
	exWj1SGzk/p6bqnHYv7MDV/mn3/mewlXPOuMq8c9hbOTV7AVilZweBjaWFw2fvz6prym1zer
	OmaF0Cbre/YC4hUm6huTDXZfXXe33cJxg4Bz+heV3OkGVzjrrO4YlvDlTdA+LjDF7C6TL2P9
	3cLbK1ruthscj6oMYPCb9HlJ40mu3XbrZAInCH6p/20k1VMlm32AKa/2zDT+otmJDoc/O7r9
	OMhZ/nWFyopXa04qsRRnJBpqMRcVJwIA0IeB34cDAAA=
X-CMS-MailID: 20231211083423eucas1p273a157b7e673f588d396d5c2e75e3cc1
X-Msg-Generator: CA
X-RootMTR: 20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
	<20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<20231207104357.kndqvzkhxqkwkkjo@localhost>
	<fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>

--tkudj6zge43ee23g
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 08:19:43PM +0100, Thomas Wei=DFschuh wrote:
> On 2023-12-07 11:43:57+0100, Joel Granados wrote:
> > Hey Thomas
> >=20
> > You have a couple of test bot issues for your 12/18 patch. Can you
> > please address those for your next version.
>=20
> I have these fixed locally, I assumed Luis would also pick them up
> directly until I have a proper v2, properly should have communicated
> that.
>=20
> > On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Wei=DFschuh wrote:
> > > Problem description:
> > >=20
> > > The kernel contains a lot of struct ctl_table throught the tree.
> > > These are very often 'static' definitions.
> > > It would be good to make the tables unmodifiable by marking them "con=
st"
> > Here I would remove "It would be good to". Just state it: "Make the
> > tables unmodifiable...."
>=20
> Ack.
>=20
> >=20
> > > to avoid accidental or malicious modifications.
> > > This is in line with a general effort to move as much data as possible
> > > into .rodata. (See for example[0] and [1])
>=20
> > If you could find more examples, it would make a better case.
>=20
> I'll look for some. So far my constifications went in without them :-)
>=20
> > >=20
> > > Unfortunately the tables can not be made const right now because the
> > > core registration functions expect mutable tables.
> > >=20
> > > This is for two main reasons:
> > >=20
> > > 1) sysctl_{set,clear}_perm_empty_ctl_header in the sysctl core modify
> > >    the table.
> > > 2) The table is passed to the handler function as a non-const pointer.
> > >=20
> > > This series migrates the core and all handlers.
>=20
> > awesome!
> >=20
> > >=20
> > > Structure of the series:
> > >=20
> > > Patch 1-3:   Cleanup patches
> > > Patch 4-7:   Non-logic preparation patches
> > > Patch 8:     Preparation patch changing a bit of logic
> > > Patch 9-12:  Treewide changes to handler function signature
> > > Patch 13-14: Adaption of the sysctl core implementation
> > > Patch 15:    Adaption of the sysctl core interface
> > > Patch 16:    New entry for checkpatch
> > > Patch 17-18: Constification of existing "struct ctl_table"s
> > >=20
> > > Tested by booting and with the sysctl selftests on x86.
> > >=20
> > > Note:
> > >=20
> > > This is intentionally sent only to a small number of people as I'd li=
ke
> > > to get some more sysctl core-maintainer feedback before sending this =
to
> > > essentially everybody.
>=20
> > When you do send it to the broader audience, you should chunk up your b=
ig
> > patches (12/18 and 11/18) and this is why:
> > 1. To avoid mail rejections from lists:
> >    You have to tell a lot of people about the changes in one mail. That
> >    will make mail header too big for some lists and it will be rejected.
> >    This happened to me with [3]
> > 2. Avoid being rejected for the wrong reasons :)
> >    Maintainers are busy ppl and sending them a set with so many files
> >    may elicit a rejection on the grounds that it involves too many
> >    subsystems at the same time.
> > I suggest you chunk it up with directories in mind. Something similar to
> > what I did for [4] where I divided stuff that when for fs/*, kernel/*,
> > net/*, arch/* and drivers/*. That will complicate your patch a tad
> > because you have to ensure that the tree can be compiled/run for every
> > commit. But it will pay off once you push it to the broader public.
>=20
> This will break bisections. All function signatures need to be switched
I was suggesting a solution without breaking bisections of course. I can
think of a couple of ways to do this in chunks but it might be
premature. You can send it and if you get push back because of this then
we can deal with chunking it down.

I'm still concerned about the header size for those mails. How does the
mail look like when you run the get maintainers script on it?

> in one step. I would strongly like to avoid introducing broken commits.
>=20
> The fact that these big commits have no functional changes at all makes
> me hope it can work.

--=20

Joel Granados

--tkudj6zge43ee23g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVy6PQACgkQupfNUreW
QU/kqwwAl4AzqtXuQrIiZVZuxbjC/B9vxdgnwDjJnHVbQ9QuNz4y3ZJq60tFYYib
uwYwA72xqqXdZFiWG5RXuqFrqMxZRVxJUKhm4NfEDW+ol0cP+fXMFE4t806KCEQF
cu+JQVXYWVhmscjWZE6zm79A1xtMLUa9wbaVnzyp6SFr0Q0B8ReM/7/xYIgHi72s
qj5rd3sj5Ss3t5l5iskdEZ4ncDU75M1fIehCRDlf5bQZSbmifuTpA5q72qTiux5W
83w3d9rTjo5f4Y9YZMG8dn06MG0CHWSBK919IS+RaiBZ9dWimNRxLgOxlstHxfMX
Dmm8zUQNl7RMPJEAkYxNoPRmZMSDR2a2mYILLTwCc/w7vUsselS8ngK+L4JdKbbA
Gl2aet6SwpjP3c/32vq+pCM9iFm6Hh4JYto4Bcqfncsa5bIvOnyiLDBvNe1hoQ0q
2vV0aY5/IOvW61UnR4p+AkQBFWPs6fln4vM2l7wIzC8pcsdEoqdmdaiyN3OdVKxF
OCQuggkL
=xR5S
-----END PGP SIGNATURE-----

--tkudj6zge43ee23g--

