Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233581D8B88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 01:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgERXPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 19:15:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgERXPu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 19:15:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49QvyC16t4z9sPF;
        Tue, 19 May 2020 09:15:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1589843748;
        bh=Yr6CwYHiLwBFpM58o+pP6uQFb+BzpavnPqWxARGMspk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i0lP0ArHYOopLpo/ulIzUZV0Eyz56WR+lHqqzeLmXw05m3Anvhox79Cnjg1087o0C
         CeQco0K7wIx3tKUZpQ+5mCAi3CTznXI7hbu6PAvJefS/WXRec8ErSCqWkh0pbpKFvw
         XB4rMIC8qFaMVqw7vBbMfgxNkL9ltRe9KquDO4B/lNn1vwwOCl3wwfApCkMSaryqt0
         l/De8Mle/0FVN0535lJKQJJiBMsktAuui4OE0DB6zHW4auR02VsV7EYGolatGHNIPW
         8Xqz0oiTYAWbKoh5quL/2vflhUHAeRv10Lp3zOwEf51sRCkW1pD6eioX66RanNHZES
         bqhChVdIPtjOQ==
Date:   Tue, 19 May 2020 09:15:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2020-05-15-16-29 uploaded
Message-ID: <20200519091546.3a46bc9a@canb.auug.org.au>
In-Reply-To: <20200516155358.3683f11e@canb.auug.org.au>
References: <20200513175005.1f4839360c18c0238df292d1@linux-foundation.org>
        <20200515233018.ScdtkUJMA%akpm@linux-foundation.org>
        <20200516155358.3683f11e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NX+9Qji75+ZpECdglkZfFOu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/NX+9Qji75+ZpECdglkZfFOu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Sat, 16 May 2020 15:53:58 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Fri, 15 May 2020 16:30:18 -0700 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
> >
> > * mm-introduce-external-memory-hinting-api.patch =20
>=20
> The above patch should have
>=20
> #define __NR_process_madvise 443
>=20
> not 442, in arch/arm64/include/asm/unistd32.h
>=20
> and
>=20
>  442    common  fsinfo                          sys_fsinfo
> +443    common  process_madvise                 sys_process_madvise
>=20
> in arch/microblaze/kernel/syscalls/syscall.tbl
>=20
> > * mm-introduce-external-memory-hinting-api-fix.patch =20
>=20
> The above patch should have
>=20
> #define __NR_process_madvise 443
>=20
> not 442
>=20
> > * mm-support-vector-address-ranges-for-process_madvise-fix.patch =20
>=20
> The above patch should have
>=20
> #define __NR_process_madvise 443
>=20
> not 442 in arch/arm64/include/asm/unistd32.h

I fixed those up in yesterday's linux-next.
--=20
Cheers,
Stephen Rothwell

--Sig_/NX+9Qji75+ZpECdglkZfFOu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7DFyIACgkQAVBC80lX
0Gyv5wf/bFZWdRWdC4qRrizPtE6GYb9OWZSjQllEKYi+bG5mPwhKpdrYEmD7DIoj
6am/5l1Apt0m2G81GvJIfDGr6jDAuNRYMEu5PqAInKtNKVH9ZaqJPbtaL0DxB0IV
rW6QvgSs7Lyg8K4ne38w5rRCTnRhpE5EzgfSmYaoo1q2roVYtjBHPN7cYAGVSKjy
jT9bUUGJnR8U0QvbiGSJzkKCsnBDmCgq9w4Sirin4VCiPVU8nQpOqSqQwBMZ2W4t
htIFSsF/oBmRc+RLB33Ugy34q+p5GaI+HT7vRbcYH07Jf2IgSuwySMwn0TiwFLSt
m3RyI3PIYidLBRo/WuPj14FpcVxMIg==
=GhoY
-----END PGP SIGNATURE-----

--Sig_/NX+9Qji75+ZpECdglkZfFOu--
