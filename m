Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29B247C95B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 23:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhLUWqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 17:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLUWqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:46:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E216CC061574;
        Tue, 21 Dec 2021 14:46:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JJWlg0GpLz4xRC;
        Wed, 22 Dec 2021 09:46:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640126785;
        bh=p32mOdwag3BtmIf/PhPiqm5PRAITCzSp9OIsXNmGyh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oyUYQYzK6lHpvOouITz7gmu8Y0DNr07/g+P1LxQgvjED58RUj9h1Afb4jCrF4HvlQ
         GoRA77QKZeNB5mR2A7//zRXL+37DBhFabraDgLx7v1Tpp7yi4i+g1furJmU7K75VoT
         6h6rcnAkPdxA6v8aWEk6rlROgz7WJPra3fVM2tfs170wojsTUoyyg9mg3/0iPfoc/I
         eE7X2puKwDIXG6YIgA/ChUTEVozAbwK3YOlH9QrL7NAyAtYbB8yPgx898krGf3Cr4a
         w0T90MksrfBZLIXm17+R2P6yJApL95eESxnXIcn6VUYAsBs2tTfqKnVH4kn61nOzaK
         C88eQmtBI/j0g==
Date:   Wed, 22 Dec 2021 09:46:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: iomap-folio & nvdimm merge
Message-ID: <20211222094621.0de42c07@canb.auug.org.au>
In-Reply-To: <YcIipecYCUrqbRBu@casper.infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
        <20211216210715.3801857-17-willy@infradead.org>
        <YcIIbtKhOulAL4s4@casper.infradead.org>
        <20211221184115.GY27664@magnolia>
        <YcIipecYCUrqbRBu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v+fS+Q._F/DnpLkg4wl6AH1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/v+fS+Q._F/DnpLkg4wl6AH1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Tue, 21 Dec 2021 18:53:25 +0000 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> Glad to hear it passed that thorough testing.  Stephen, please pick
> up a new tree (hopefully just temporarily until Darrick can swim to
> the surface):
>=20
>  git://git.infradead.org/users/willy/linux.git folio-iomap
>=20
> Hopefully the previous message will give you enough context for
> the merge conflict resolution.

I have added that after the folio tree today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/v+fS+Q._F/DnpLkg4wl6AH1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHCWT0ACgkQAVBC80lX
0GzAGwf8DI9pHuTm4NgcBGUWaj+kLNj/Bv1JKijkd/qmbgPgehMdBvceEHMVN6iD
4+KVRpi38srP95wMD9Gv27tdoGejLfs223r6bp63lsCwQp9l13uDSCDMRZKnkjIw
WZjMMe5/y4z5Pl3B6m1hmD7+20KplPDdeCxKQiVYCgAHCnoDMG93JbIERNCsP4U2
GyHoRe9uSqssUK0GW9Q4i/rSZQcov7aZlvzNatGAfif2b7wxeOrgyGZj6tXaMov+
5x9llVh31pV6eJFMBfM4NlfAI0HQAk49t7nm8fabqS6n32DLypuU+Ns7EODQ1klt
ZediYJyMk3AQpviiOnhH70/gOGaPtw==
=dVTg
-----END PGP SIGNATURE-----

--Sig_/v+fS+Q._F/DnpLkg4wl6AH1--
