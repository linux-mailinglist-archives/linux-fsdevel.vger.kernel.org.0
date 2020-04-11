Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5B51A4E50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Apr 2020 08:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgDKGCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 02:02:47 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151]:61600 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgDKGCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 02:02:47 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 48zknL3lx7zKmhJ;
        Sat, 11 Apr 2020 08:02:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id xMOYaSJb-_Fq; Sat, 11 Apr 2020 08:02:43 +0200 (CEST)
Date:   Sat, 11 Apr 2020 16:02:36 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Askar Safin <safinaskar@mail.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: What about adding AT_NO_AUTOMOUNT analogue to openat2?
Message-ID: <20200411060236.swlgw6ymzikgcqxl@yavin.dot.cyphar.com>
References: <1586558501.806374941@f476.i.mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6p3dbgp22fa2tsjp"
Content-Disposition: inline
In-Reply-To: <1586558501.806374941@f476.i.mail.ru>
X-Rspamd-Queue-Id: 6C8921666
X-Rspamd-Score: -4.58 / 15.00 / 15.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--6p3dbgp22fa2tsjp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-11, Askar Safin <safinaskar@mail.ru> wrote:
> What about adding stat's AT_NO_AUTOMOUNT analogue to openat2?

There isn't one. I did intend to add RESOLVE_NO_AUTOMOUNTS after openat2
was merged -- it's even mentioned in the commit message -- but I haven't
gotten around to it yet. The reason it wasn't added from the outset was
that I wasn't sure if adding it would be as simple as the other
RESOLVE_* flags.

Note that like all RESOLVE_* flags, it would apply to all components so
it wouldn't be truly analogous with AT_NO_AUTOMOUNT (though as I've
discussed at length on this ML, most people do actually want the
RESOLVE_* semantics). But you can emulate the AT_* ones much more easily
with RESOLVE_* than vice-versa).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--6p3dbgp22fa2tsjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXpFdeQAKCRCdlLljIbnQ
EkBdAQCyBuNZE9ioj/ohykgD3FtzjKulyef5zi5jsYPDmT1XLwD9Fe/NINk/la6W
Olxgvlm69tk3c1jdvqxb+2yHkbpemA8=
=g3dY
-----END PGP SIGNATURE-----

--6p3dbgp22fa2tsjp--
