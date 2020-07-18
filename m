Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA22247BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 03:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGRBcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 21:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRBcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 21:32:18 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AB2C0619D2;
        Fri, 17 Jul 2020 18:32:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B7r801fNHz9sSd;
        Sat, 18 Jul 2020 11:32:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595035936;
        bh=zbqPgE8v7ON2kH31+pvIfuRRd/Syn3vdJv6lvJRWYSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qpW/K+16DKipBBvhuDO1XEIr7Q2RitPvywDHHcuSSFB3K3o0lf1Ha511qrwUZUpzU
         mQhdYNiTZM++fABgsYxblhT0e++7SG7OnSOidZRn3roE/RHYflo5J8zUrndxs8y4b7
         kZn1bP2Fc4y54zoHUR2t9xuRSvlY1bg1VOMcwuwj/12B8qm5Rg31jofCSCSsvAQf3w
         6ZqT0evS2bQJsMPp5gztr9CX77bgmO9qv4YDqD8fWRV10nUvjnOpoTkkHF8yZVuJms
         hex/GWpkJIMf8Ut9djV0GHbTJtObpVLyMxfoCBWc+b0+s8bKeWVMpbjS+GuToewrXu
         Cer626C0CobFg==
Date:   Sat, 18 Jul 2020 11:32:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2020-07-16-22-52 uploaded (mm/hugetlb.c)
Message-ID: <20200718113215.2099dab3@canb.auug.org.au>
In-Reply-To: <267a50e8-b7b2-b095-d62e-6e95313bc4c2@infradead.org>
References: <20200717055300.ObseZH9Vs%akpm@linux-foundation.org>
        <267a50e8-b7b2-b095-d62e-6e95313bc4c2@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MIM/s.l/+DRjtjirRvNy8b0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/MIM/s.l/+DRjtjirRvNy8b0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Fri, 17 Jul 2020 08:35:45 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> on i386:
> 6 of 10 builds failed with:
>=20
> ../mm/hugetlb.c:1302:20: error: redefinition of =E2=80=98destroy_compound=
_gigantic_page=E2=80=99
>  static inline void destroy_compound_gigantic_page(struct hstate *h,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../mm/hugetlb.c:1223:13: note: previous definition of =E2=80=98destroy_co=
mpound_gigantic_page=E2=80=99 was here
>  static void destroy_compound_gigantic_page(struct hstate *h, struct page=
 *page,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported here: https://lore.kernel.org/lkml/20200717213127.3bd426e1@canb.au=
ug.org.au/

> ../mm/hugetlb.c:1223:13: warning: =E2=80=98destroy_compound_gigantic_page=
=E2=80=99 defined but not used [-Wunused-function]
> ../mm/hugetlb.c:50:https://lore.kernel.org/lkml/20200709191111.0b63f84d@c=
anb.auug.org.au/20: warning: =E2=80=98hugetlb_cma=E2=80=99 defined but not =
used [-Wunused-variable]
>  static struct cma *hugetlb_cma[MAX_NUMNODES];
>                     ^~~~~~~~~~~

Reported here: https://lore.kernel.org/lkml/20200709191111.0b63f84d@canb.au=
ug.org.au/

--=20
Cheers,
Stephen Rothwell

--Sig_/MIM/s.l/+DRjtjirRvNy8b0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8SUR8ACgkQAVBC80lX
0Gw2BQgAlJRnzqsEMwMGbGxshd1VTQJzQfPAxyeaASZ7c0wyXS1gaxlaXqHhO93Q
qsVKoYpqn8ZH2vZTyK5DcWS98nncrlu35W8yseL1DLep/2mSuCa7BEE049/madFh
YY2YfT00oXifVMGBYx312bgou7D8fFc5j4RdXd/nUQYNJ8TUDeZZLA5K2IF3kyw7
nrwE94xTxLBJNiSTS6hdQeVFLT5Wd0ZFlT3CLkwL2RMMwjIZkLGJ9ytkzlr/QgII
MdYhZ/J10kcMbb0Y0VeFEJN9VBvK/IxZ8wIqB9+5UnmQARQE0sEmSadyJZQS0z34
QWVUbzUGRcHDslowYETvaqiHW742mA==
=FhKn
-----END PGP SIGNATURE-----

--Sig_/MIM/s.l/+DRjtjirRvNy8b0--
