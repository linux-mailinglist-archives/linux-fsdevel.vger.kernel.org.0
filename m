Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE492F4289
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 04:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbhAMDcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 22:32:25 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:58285 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbhAMDcZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 22:32:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DFtK92Qg1z9sRK;
        Wed, 13 Jan 2021 14:31:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1610508701;
        bh=df+PBbrEhpZVbvdtf2ZFLzNzjs4lW9MwPOq5lRWon78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BJQcjoyq/rS41N1eGXY0KOuJOqLKpHDbAAnR1D/49tMldR0fSUZGx1CwdGz0s1Pbh
         Lpgrl13jGBpfdVS4pmZI2e57EKVdCfO1KxcA+kB02mUAZYQN5vp+5R1XjEd+MsDE6S
         rWbWLMmjPREvFLX7mHT/xgnKwbMfRj4PUZiqTf+D4pAFhsyF7l9ULg3HAUV9zt+17i
         8GsZGr3d96jr7DyWFsbiU+EJs2rY80Ilv1VWhB2y0qCTWWLeeqdEqPzGbF7jMczvwA
         ZSxBRIb1/YcWdCK1HVzhI+qFkVN+xJpfpNWcH6v0L2DuhMaL9MEIxe2EcFBhMGMcmb
         fh2PaL/t6+4iw==
Date:   Wed, 13 Jan 2021 14:31:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Subject: Re: mmotm 2021-01-12-01-57 uploaded (NR_SWAPCACHE in mm/)
Message-ID: <20210113143140.568dbf53@canb.auug.org.au>
In-Reply-To: <20210112135010.267508efa85fe98f670ed9e9@linux-foundation.org>
References: <20210112095806.I2Z6as5al%akpm@linux-foundation.org>
        <ac517aa0-2396-321c-3396-13aafba46116@infradead.org>
        <20210112135010.267508efa85fe98f670ed9e9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w7eI=p7dXr=HbdLnMuWAzs3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/w7eI=p7dXr=HbdLnMuWAzs3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 12 Jan 2021 13:50:10 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Tue, 12 Jan 2021 12:38:18 -0800 Randy Dunlap <rdunlap@infradead.org> w=
rote:
>=20
> > On 1/12/21 1:58 AM, akpm@linux-foundation.org wrote: =20
> > > The mm-of-the-moment snapshot 2021-01-12-01-57 has been uploaded to
> > >=20
> > >    https://www.ozlabs.org/~akpm/mmotm/
> > >=20
> > > mmotm-readme.txt says
> > >=20
> > > README for mm-of-the-moment:
> > >=20
> > > https://www.ozlabs.org/~akpm/mmotm/
> > >=20
> > > This is a snapshot of my -mm patch queue.  Uploaded at random hopeful=
ly
> > > more than once a week.
> > >  =20
> >=20
> > on i386 and x86_64:
> >=20
> > when CONFIG_SWAP is not set/enabled:
> >=20
> > ../mm/migrate.c: In function =E2=80=98migrate_page_move_mapping=E2=80=
=99:
> > ../mm/migrate.c:504:35: error: =E2=80=98NR_SWAPCACHE=E2=80=99 undeclare=
d (first use in this function); did you mean =E2=80=98QC_SPACE=E2=80=99?
> >     __mod_lruvec_state(old_lruvec, NR_SWAPCACHE, -nr);
> >                                    ^~~~~~~~~~~~
> >=20
> > ../mm/memcontrol.c:1529:20: error: =E2=80=98NR_SWAPCACHE=E2=80=99 undec=
lared here (not in a function); did you mean =E2=80=98SGP_CACHE=E2=80=99?
> >   { "swapcached",   NR_SWAPCACHE   },
> >                     ^~~~~~~~~~~~ =20
>=20
> Thanks.  I did the below.
>=20
> But we're still emitting "Node %d SwapCached: 0 kB" in sysfs when
> CONFIG_SWAP=3Dn, which is probably wrong.  Shakeel, can you please have a
> think?
>=20
>=20
> --- a/mm/memcontrol.c~mm-memcg-add-swapcache-stat-for-memcg-v2-fix
> +++ a/mm/memcontrol.c
> @@ -1521,7 +1521,9 @@ static const struct memory_stat memory_s
>  	{ "file_mapped",		NR_FILE_MAPPED			},
>  	{ "file_dirty",			NR_FILE_DIRTY			},
>  	{ "file_writeback",		NR_WRITEBACK			},
> +#ifdef CONFIG_SWAP
>  	{ "swapcached",			NR_SWAPCACHE			},
> +#endif
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	{ "anon_thp",			NR_ANON_THPS			},
>  	{ "file_thp",			NR_FILE_THPS			},
> --- a/mm/migrate.c~mm-memcg-add-swapcache-stat-for-memcg-v2-fix
> +++ a/mm/migrate.c
> @@ -500,10 +500,12 @@ int migrate_page_move_mapping(struct add
>  			__mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
>  			__mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
>  		}
> +#ifdef CONFIG_SWAP
>  		if (PageSwapCache(page)) {
>  			__mod_lruvec_state(old_lruvec, NR_SWAPCACHE, -nr);
>  			__mod_lruvec_state(new_lruvec, NR_SWAPCACHE, nr);
>  		}
> +#endif
>  		if (dirty && mapping_can_writeback(mapping)) {
>  			__mod_lruvec_state(old_lruvec, NR_FILE_DIRTY, -nr);
>  			__mod_zone_page_state(oldzone, NR_ZONE_WRITE_PENDING, -nr);
> _
>=20

Applied to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/w7eI=p7dXr=HbdLnMuWAzs3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/+aZwACgkQAVBC80lX
0GwRXAf8D166bsfL4hwZk8RE1CvR5PUSAH3voBHK5q1Ip0AmXERUKNgQMRzOZVRf
MA0vlUaxSmQ618gbWKyBlI2oZP2B7iGl4vfWxO27obeZ1NrU6Jk8Zob28/aNgSWp
S9jwafnxTCHGnM6CDYZSbdf1PpLfCEq9c3adQLDNpzLfucr/3buAWDEvN2HpqhTI
tlqRTMWQ4tiOdxYBZRsBLHY2am/YMzeUECIfX4m5x/qLWHZGS6wv7DpbPT8URH02
tGyHcxMQriK/eLws8PYdT9ErVRCexgTTHYEI3YcmIAjl7UCGxQoV80KYQudOmn1l
5/nzBOYySlK4k7V5j+HozaZU3+fuGg==
=6zS1
-----END PGP SIGNATURE-----

--Sig_/w7eI=p7dXr=HbdLnMuWAzs3--
