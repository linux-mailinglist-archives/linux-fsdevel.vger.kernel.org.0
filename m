Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89C21162D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 00:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgGAWij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 18:38:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34051 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGAWij (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:38:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49xx2z1zgrz9sR4;
        Thu,  2 Jul 2020 08:38:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593643117;
        bh=56kkZWfTbbU44VtbMKX6G3us6NnUdwyya0+ubSH0zvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EwL7oan4ciMK5fL2OM4dxkApV9lHHZ6Os/huvXrCSK6Orlv10cHBYZcJl/6AO1o52
         6EIkH4c7/1gdNDFzgS+hB+N/wbUbu4+yDb1d3MiRf6150cf6rfzCJ73hq/K85X4G1I
         3AmNu1m06v5crQ62SNWDjt0oFqr5RTLNiEM1TKV07e3A5pk9U2JD67lO3v7R+L57oI
         NAl5CDiSGtlavrhH54VhA5BMphH8bVFqaxQ+bm5huHTqX/fsBo4dT3Jytd1d1lvLvy
         g7HXc1umYWRPc5/qTYe7J5vXImwcA8N6VnoWNzkTveJJyhm9+kZI+mnWr4QBe48D8t
         I0RJZ2XZKdGLw==
Date:   Thu, 2 Jul 2020 08:38:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH -mmotm] mm/memory-failure: remove stub function
Message-ID: <20200702083833.1f71c272@canb.auug.org.au>
In-Reply-To: <adb60490-484f-a154-e163-725e35a821dc@infradead.org>
References: <20200701045312.af2lR%akpm@linux-foundation.org>
        <adb60490-484f-a154-e163-725e35a821dc@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VR5G_wXkj+V7Hl9wfElARea";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/VR5G_wXkj+V7Hl9wfElARea
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Wed, 1 Jul 2020 08:47:30 -0700 Randy Dunlap <rdunlap@infradead.org> wrot=
e:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> This stub is no longer needed since the function is no longer
> inside an #ifdef/#endif block.
>=20
> Fixes this build error:
>=20
> ../mm/memory-failure.c:180:13: error: redefinition of =E2=80=98page_handl=
e_poison=E2=80=99
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/memory-failure.c |    4 ----
>  1 file changed, 4 deletions(-)
>=20
> --- mmotm-2020-0630-2152.orig/mm/memory-failure.c
> +++ mmotm-2020-0630-2152/mm/memory-failure.c
> @@ -169,10 +169,6 @@ int hwpoison_filter(struct page *p)
>  	return 0;
>  }
> =20
> -static bool page_handle_poison(struct page *page, bool hugepage_or_freep=
age, bool release)
> -{
> -	return true;
> -}
>  #endif
> =20
>  EXPORT_SYMBOL_GPL(hwpoison_filter);

Added to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/VR5G_wXkj+V7Hl9wfElARea
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl79EGkACgkQAVBC80lX
0Gyltwf+INFvxklNVE+y18MHcQE7vPpPq9Q6Gxojn0PoSy80x0j2hHHxT74mfg3L
t5yN0fshRh4JfvFBrigvRn2NxS5dKTuo3TrBOmjAWwc4bZx6KkpqfPU5sMrkMgeN
A8HEDWExOXl75U/tICF4esOVG7lVXFvDuBF8tMczysKZlqUA4fNqgkH3rJ7n+lSG
GKbTSjFCEdI1pbICuyohp4ttUAJqSL6APL6qMjtuYlTB5oWgRGe7vBv3uZZ8o1Qq
WHvG/lIR3X9kvGLAYhhYi2ii1il/WDZJSp7o3Ftj0UTw+3NoxaKdpucOGk/8nJfu
49xC19PqDfK4OFG9EjFoPgEnvrDP1A==
=239s
-----END PGP SIGNATURE-----

--Sig_/VR5G_wXkj+V7Hl9wfElARea--
