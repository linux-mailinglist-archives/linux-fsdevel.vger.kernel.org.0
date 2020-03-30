Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12276197801
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgC3Jsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 05:48:55 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:21070 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgC3Jsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:48:55 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48rSMl5DjbzQlJg;
        Mon, 30 Mar 2020 11:48:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id JK5Ffe5fM8nK; Mon, 30 Mar 2020 11:48:45 +0200 (CEST)
Date:   Mon, 30 Mar 2020 20:48:36 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2)
 syscall
Message-ID: <20200330094836.lhcipdujroahiu4y@yavin.dot.cyphar.com>
References: <20200202151907.23587-1-cyphar@cyphar.com>
 <20200202151907.23587-3-cyphar@cyphar.com>
 <4dcea613-60b8-a8af-9688-be93858ab652@gmail.com>
 <20200330092051.umcu2mjnwqazml7a@yavin.dot.cyphar.com>
 <ae275f67-9277-547c-e78c-bca4f388f694@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zcsmuu77p43qapkn"
Content-Disposition: inline
In-Reply-To: <ae275f67-9277-547c-e78c-bca4f388f694@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zcsmuu77p43qapkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-30, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> On 3/30/20 11:20 AM, Aleksa Sarai wrote:
> > On 2020-03-30, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wro=
te:
> >> Hello Aleksa,
> >>
> >> On 2/2/20 4:19 PM, Aleksa Sarai wrote:
> >>> Rather than trying to merge the new syscall documentation into open.2
> >>> (which would probably result in the man-page being incomprehensible),
> >>> instead the new syscall gets its own dedicated page with links between
> >>> open(2) and openat2(2) to avoid duplicating information such as the l=
ist
> >>> of O_* flags or common errors.
> >>>
> >>> In addition to describing all of the key flags, information about the
> >>> extensibility design is provided so that users can better understand =
why
> >>> they need to pass sizeof(struct open_how) and how their programs will
> >>> work across kernels. After some discussions with David Laight, I also
> >>> included explicit instructions to zero the structure to avoid issues
> >>> when recompiling with new headers.>
> >>> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> >>
> >> I'm just editing this page, and have a question on one piece.
> >>
> >>> +Unlike
> >>> +.BR openat (2),
> >>> +it is an error to provide
> >>> +.BR openat2 ()
> >>> +with a
> >>> +.I mode
> >>> +which contains bits other than
> >>> +.IR 0777 ,
> >>
> >> This piece appears not to be true, both from my reading of the
> >> source code, and from testing (i.e., I wrote a a small program that
> >> successfully called openat2() and created a file that had the
> >> set-UID, set-GID, and sticky bits set).
> >>
> >> Is this a bug in the implementation or a bug in the manual page text?
> >=20
> > My bad -- it's a bug in the manual. The actual check (which does work,
> > there are selftests for this) is:
> >=20
> > 	if (how->mode & ~S_IALLUGO)
> > 		return -EINVAL;
> >=20
> > But when writing the man page I forgot that S_IALLUGO also includes
> > those bits. Do you want me to send an updated version or would you
> > prefer to clean it up?
>=20
> I'll clean it up.
>=20
> So, it should say, "bits other than 07777", right?

Yes, that would be correct.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--zcsmuu77p43qapkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXoHAcQAKCRCdlLljIbnQ
EvucAP9GXcbNItNpaRbdUdGWIFNP8w+Mq+hSgnLQuuxq/Zo+kQEAqlkhi7iQyli9
3DsFmRfEOOZM9ZV1HezhJaFSfwUEpgo=
=AQVl
-----END PGP SIGNATURE-----

--zcsmuu77p43qapkn--
