Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1AE3CF20D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 04:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbhGTBxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 21:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443880AbhGSXFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:05:20 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC884C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 16:40:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GTJHk5wV5z9sV8;
        Tue, 20 Jul 2021 09:40:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1626738035;
        bh=KUtE9s+XfuHDKmkULQPx3VNEWFy5r9n2T/EDbhyAh+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q2z1vHv/YfjSPqLAB+uid0pK0GfmkdaM6Uh2373vDYcujIknJnd0gvAoD2x4I1/G/
         sPeVENDm+idHsQ8oGkhS5R/w6TY6/Vf9KMrsSvSgrRBSUu0qN8FEbA4W4NvgPSsHb+
         LPhppD2boYk7L7Vqx+6Crbhq9YmJsKgUYuiYGtvYboVUDkStFyYjOhwoFn29Urepui
         wKdKRT+iyT7BlhqReMu/K2UAkf8XHZpVTfQcy0MS3EkPoADq2M4unyiPQiB05fW2Wa
         m+vCGxW0SObzi3WwBE6Euvb0Zz2TgN6KAm+xMy64ccnaH4KxMEW9J6uE/OHbZBJgTn
         rqCJKd5Fpw5fQ==
Date:   Tue, 20 Jul 2021 09:40:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Folio tree for next
Message-ID: <20210720094033.46b34168@canb.auug.org.au>
In-Reply-To: <20210718205758.65254408be0b2a17cfad7809@linux-foundation.org>
References: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
        <20210718205758.65254408be0b2a17cfad7809@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zKNic3GmZ/Lw+8j3yhoWPiW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/zKNic3GmZ/Lw+8j3yhoWPiW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Sun, 18 Jul 2021 20:57:58 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Mon, 19 Jul 2021 04:18:19 +0100 Matthew Wilcox <willy@infradead.org> w=
rote:
>=20
> > Please include a new tree in linux-next:
> >=20
> > https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads=
/for-next
> > aka
> > git://git.infradead.org/users/willy/pagecache.git for-next
> >=20
> > There are some minor conflicts with mmotm.  I resolved some of them by
> > pulling in three patches from mmotm and rebasing on top of them.
> > These conflicts (or near-misses) still remain, and I'm showing my
> > resolution: =20
>=20
> I'm thinking that it would be better if I were to base all of the -mm
> MM patches on linux-next.  Otherwise Stephen is going to have a pretty
> miserable two months...

If they are only minor conflicts, then please leave them to me (and
Linus).  That way if Linus decides not to take the folio tree or the
mmotm changes (or they get radically changed), then they are not
contaminated by each other ... hints (or example resolutions) are
always welcome.

--=20
Cheers,
Stephen Rothwell

--Sig_/zKNic3GmZ/Lw+8j3yhoWPiW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmD2DXEACgkQAVBC80lX
0GwF4Qf/VsSEPt/aVV1Anr6ehtKHYxdX8jQan/DCOaN+PDSywZs+oUEbStba/dPf
OtpRANe8olL1/P0/Zxmz2uwZheaFrCsMNAM2qHysE9rvoeRpkI868ejpsG31NNGI
8mK1vrJLZppzrm5KpKxP4iQBkDDjfatvqi4xsx7BC33yiYHuvzadoAy1Hc/1kp6t
E4a1jrVSjGm78j3nIBBouSF/dXhI3nF+wh3mX3s4b175HhIYt1hsJPoDvPykKO6/
n4+SiJxRo9znUV1F8UUrYSBD4AtZzZ+uBx2tcDebGVonbMyXC3TwyEkcl+Xip4m2
NfVoiP6cnXhJvOKsix+0O2Lg6VJrVw==
=GmfZ
-----END PGP SIGNATURE-----

--Sig_/zKNic3GmZ/Lw+8j3yhoWPiW--
