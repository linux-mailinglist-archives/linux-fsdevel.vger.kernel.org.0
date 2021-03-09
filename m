Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D525533305A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 21:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhCIU5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 15:57:00 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59755 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhCIU42 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:56:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Dw6vD207tz9sW5;
        Wed, 10 Mar 2021 07:56:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1615323385;
        bh=Q6GcSsIjU4/8fscAKA4ja2cTi2mrX+hfESDsVlxKeq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i+PS8BzHE1hgZWIVcMF+gCaKLyKz3KEM1V7BHqudofkB4f+VOyM+EvR6eDYU/5wyy
         ov+Sa3O0wK02XgsEWBV5VV1wDqabuiY0prmQ/BLKvaRLHiRNdPHKB+Yws23O7wN0Yu
         3hA5yy66Xhi88ON04Eq8UcYubAO2eTqzMwFTfHfN3EJGd2AukAC80hPkb7LvZ/OWkE
         Vy9Zx2EhSpmL6O9hDf9vk+wfFRRtWN0fnTDB70JDx7U7pzyjlgRTwyOh6fiugPHjzd
         gdjILPjYpMcP7F+rAcq4ymE/WRacOk17LiUdHqV/hv9ZPPfjVKPCDAIPfdpwBrf+Ci
         Jcb3fGgp4dfxg==
Date:   Wed, 10 Mar 2021 07:56:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2021-03-08-21-52 uploaded
Message-ID: <20210310075623.303ce786@canb.auug.org.au>
In-Reply-To: <20210309204502.GL3479805@casper.infradead.org>
References: <20210309055255.QSi-xADe2%akpm@linux-foundation.org>
        <20210309204502.GL3479805@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_SZDwKGM1/IOkm8Ic+qkYwH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/_SZDwKGM1/IOkm8Ic+qkYwH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Tue, 9 Mar 2021 20:45:02 +0000 Matthew Wilcox <willy@infradead.org> wrot=
e:
>
> On Mon, Mar 08, 2021 at 09:52:55PM -0800, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2021-03-08-21-52 has been uploaded to
> >=20
> >    https://www.ozlabs.org/~akpm/mmotm/ =20
> ...
> > This mmotm tree contains the following patches against 5.12-rc2:
> > (patches marked "*" will be included in linux-next) =20
>=20
> Something seems to have gone wrong in next-20210309.  There are a number
> of patches listed here which are missing, and some patches are included
> that aren't listed here.
>=20
> > * mm-use-rcu_dereference-in-in_vfork.patch =20
>=20
> This was the one I noticed was missing.

I haven't done a linux-next with this new mmotm yet, it arrived after I
finished 20210309.  It will be included today.

--=20
Cheers,
Stephen Rothwell

--Sig_/_SZDwKGM1/IOkm8Ic+qkYwH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmBH4PcACgkQAVBC80lX
0GzOHQf6AqJgmlOVzuqFC3eg4ohshlDCZhzT8RGSwqf+RZBBiu4x7x0i+gio4DcM
vhUA5t+3q1WAXrUyC+ZS1BzY+9A4zoNMJaLtz6LN2sx79qblUlmW+juTCG+d+v7z
xg7NF6d1Tj1qv4io36Xe2IU0qaWcQpSeUP6CYTSFXS5e4zaq4q5IbnLnpRq4Du0P
CVi3yvw2CVl/I6akHVs/Enehtf4gqcvyqK8O7A4rKb0YMEYT2+87E7RtAL5IJn7n
Gd5+0w8E/28CcXKyLj4kh2LinUNUYgmVrhLQOxKcKgf2P5+I8GFh5exkxpTBz1VI
TdosS7+aS4Yj+fGMMUhAziGRH2wqLA==
=quys
-----END PGP SIGNATURE-----

--Sig_/_SZDwKGM1/IOkm8Ic+qkYwH--
