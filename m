Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B16E2CE1D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 23:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgLCWfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 17:35:34 -0500
Received: from ozlabs.org ([203.11.71.1]:35825 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbgLCWfe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:35:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cn9d45gkYz9sVJ;
        Fri,  4 Dec 2020 09:34:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1607034891;
        bh=VrxoLFii3XtXFphKy9zwC0afo2U9H3/0MV4x2B1n/9c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N0ga7O3vq/pN8Q7oMT8hzsMk/UCM9Yptjv6HMq6cJb6b4CZunLiykXwdSwXU/YIFZ
         7AddrX1PNqTqmInXAprdY40tczVszfLg8rHd1hwFDYJkEvNq0xSoGMm6J203v7eUQT
         h2Ps2EiiwV5PghTAlEWe30GnQFXE3TMWcXcvD6XfcNCl/yzZBwGggtY/D/ZhQr7oCD
         n5OfDJKPBKo/imMEg3UrVd+Bq+nQ/wPxk1gma1ucXcuuh7UWI29LdjG/GGPBmeDfuO
         q6J/kdqsKrn5gyOLNaYmnlyWU4L8PiAdyMjx0mx+4PJs62zevigZ/ikXNV5a80d7EN
         4iTss967j5aLA==
Date:   Fri, 4 Dec 2020 09:34:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        m.szyprowski@samsung.com, qcai@redhat.com, dchinner@redhat.com,
        hannes@cmpxchg.org, hch@lst.de, jack@suse.cz,
        kirill.shutemov@linux.intel.com, mm-commits@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, william.kucharski@oracle.com,
        willy@infradead.org, yang.shi@linux.alibaba.com
Subject: Re: +
 mm-truncateshmem-handle-truncates-that-split-thps-fix-fix.patch added to
 -mm tree
Message-ID: <20201204093447.2cf9d164@canb.auug.org.au>
In-Reply-To: <alpine.LSU.2.11.2012031348120.12944@eggly.anvils>
References: <20201126054713.GmEiU5MZ_%akpm@linux-foundation.org>
        <alpine.LSU.2.11.2012031348120.12944@eggly.anvils>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UibknY4IjlQ9I0lgzOL6.ag";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/UibknY4IjlQ9I0lgzOL6.ag
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Hugh,

On Thu, 3 Dec 2020 14:04:18 -0800 (PST) Hugh Dickins <hughd@google.com> wro=
te:
>
> On Wed, 25 Nov 2020, akpm@linux-foundation.org wrote:
> >=20
> > The patch titled
> >      Subject: mm-truncateshmem-handle-truncates-that-split-thps-fix-fix
> > has been added to the -mm tree.  Its filename is
> >      mm-truncateshmem-handle-truncates-that-split-thps-fix-fix.patch =20
>=20
> This lot is proving to be a work in progress,
> the current state breaks booting on 32-bit, livelocks trinity,
> and breaks shmem in more ways than I can quickly explain.
> Please revert (in reverse order):
>=20
> mm-truncateshmem-handle-truncates-that-split-thps.patch
> mm-truncateshmem-handle-truncates-that-split-thps-fix.patch
> mm-truncateshmem-handle-truncates-that-split-thps-fix-fix.patch
> mm-filemap-return-only-head-pages-from-find_get_entries.patch

I have removed all 4 patches from linux-next for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/UibknY4IjlQ9I0lgzOL6.ag
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/JaAcACgkQAVBC80lX
0GwEQAgAgheUQdaeeJkyOAWwDDVh74tnjSTadn8z2CerfltVQxpU0EQDLNPlJU2R
h5HijEmgz+ZOcujo1O2Toh/U7DJ47jBhuvmueRCDt/PQM7K+bXOPx6RtrL/M68KV
lMQYVkFAnEXwEmNeINL8D2gBrI3gLg1DvcL4bbCUQjbcvyUUSnEaBWWicJtp3ig/
2ecetXicKF41Q2YgrCZZoprC7sLck/pQcEfGmgyrqai6a8U1k6Zr5F76uvhFihnk
azn5q37X1zFRsvkIpzihyucA+rDCPiN3JgZ1s4DxVUEPGn1DvJeHGRFSKv03T1na
wCIVvi0zbM7jUNUU3bUrHOjPsCXakA==
=Zfx1
-----END PGP SIGNATURE-----

--Sig_/UibknY4IjlQ9I0lgzOL6.ag--
