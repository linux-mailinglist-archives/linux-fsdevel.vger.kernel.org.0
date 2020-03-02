Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB2F175884
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 11:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgCBKiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 05:38:11 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:21402 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCBKiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:38:10 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 48WGnV3GqqzKmgS;
        Mon,  2 Mar 2020 11:38:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id titW3oOKldKy; Mon,  2 Mar 2020 11:38:02 +0100 (CET)
Date:   Mon, 2 Mar 2020 21:37:54 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     lampahome <pahome.chen@mirlab.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: why do we need utf8 normalization when compare name?
Message-ID: <20200302103754.nsvtne2vvduug77e@yavin>
References: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vt4djlomkycskysi"
Content-Disposition: inline
In-Reply-To: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--vt4djlomkycskysi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-02, lampahome <pahome.chen@mirlab.org> wrote:
> According to case insensitive since kernel 5.2, d_compare will
> transform string into normalized form and then compare.
>
> But why do we need this normalization function? Could we just compare
> by utf8 string?

The problem is that there are multiple ways to represent the same glyph
in Unicode -- for instance, you can represent =C5 (the symbol for
angstrom) as both U+212B and U+0041 U+030A (the latin letter "A"
followed by the ring-above symbol "=B0"). Different software may choose to
represent the same glyphs in different Unicode forms, hence the need for
normalisation.

[1] is the Wikipedia article that describes this problem and what the
different kinds of Unicode normalisation are.

[1]: https://en.wikipedia.org/wiki/Unicode_equivalence

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--vt4djlomkycskysi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXlzh/wAKCRCdlLljIbnQ
Et6tAQCq8ZXt+A2whrSxyf0bcHdIFSYEonsJIKRgPmRE16VhpgD+IoBvz+ekhdw1
q7VArnP8oJQ/PLZkF3Cs2fO4Y7j2sAs=
=Ed33
-----END PGP SIGNATURE-----

--vt4djlomkycskysi--
