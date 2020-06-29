Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB6F20D71F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbgF2T1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:27:10 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10625 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732310AbgF2T1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:27:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efa2eff0000>; Mon, 29 Jun 2020 11:12:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Jun 2020 11:13:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Jun 2020 11:13:04 -0700
Received: from [10.2.167.170] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jun
 2020 18:13:03 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/7] THP prep patches
Date:   Mon, 29 Jun 2020 14:13:00 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <67FC215E-F408-4968-8700-D64C8EF7385A@nvidia.com>
In-Reply-To: <20200629151959.15779-1-willy@infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_0C080286-7A66-4AE0-8E59-24023F4B7243_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593454335; bh=9ciH1aLFLrJTJwXrof0RT8opbahX/1Jrox8IFO47kHg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=IfRJPhWeDs0SVuqk8II/p1tlP3lZr/4PgtFXZZajoiouw++lNYAT+FNTAsGuyn/RG
         c7JdOM4Oi4HOcKRijVhHXZ5TUlptgUgUHBl4tVvyt/8moxdjU4XESAvO3nVOXwUUmg
         CUknPhq0ziaowJL8S32uHv0WqleJDqeTYE54bv6Q6Ub6pLPlF+/JWuNxh8iDqJMKTT
         I3sBZLgCyEdsRXcxSSyDfXzOqoUMJAA28aTnK+YRSP3qeX0/1ih74eJqb9+VRzdXYn
         xmCo4ZteMdkBh3B0SUcmdiVIx94LXmm4gnfA9HiTd7M+8RcGzQsgSno7jwqgKbe+hv
         WdyaNOSTPQU6w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_0C080286-7A66-4AE0-8E59-24023F4B7243_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 29 Jun 2020, at 11:19, Matthew Wilcox (Oracle) wrote:

> These are some generic cleanups and improvements, which I would like
> merged into mmotm soon.  The first one should be a performance improvem=
ent
> for all users of compound pages, and the others are aimed at getting
> code to compile away when CONFIG_TRANSPARENT_HUGEPAGE is disabled (ie
> small systems).  Also better documented / less confusing than the curre=
nt
> prefix mixture of compound, hpage and thp.
>
> Matthew Wilcox (Oracle) (7):
>   mm: Store compound_nr as well as compound_order
>   mm: Move page-flags include to top of file
>   mm: Add thp_order
>   mm: Add thp_size
>   mm: Replace hpage_nr_pages with thp_nr_pages
>   mm: Add thp_head
>   mm: Introduce offset_in_thp
>

The whole series looks good to me. Thank you for the patches.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_0C080286-7A66-4AE0-8E59-24023F4B7243_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl76LywPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKN2AP/0Fg8v28rXGKocdIpHUNf75BP+ZxEuvTk0Vu
W5z9p8W5qtUbpf+4A8CJfGVvNzQV4qFHYWOLg1928glKROdSrwadQVUfe84Sm+HN
icQG0uuA1v28dKYc3oM5itIVA8eBNNCRxu62V4Ed/aKLglgwWGxiubwPF9uXdV8w
xJB9t1r8sp9Pt2yO0zH1UNdawaDYLhETPubQ44kf40M2S6W974RvcKP83GQlS35R
D1RHpA6iXyIe5JC1BxvWonqXych/EJigPvyIbAOGFZbGFkD35Xvu/DoRSMTqpDAG
VZyki4PoiPxv1T1ksz76WFkRTI/ikQNhkMo9BEOEZ2ZNd2UIUgIJKrzlq+ejV+qM
qMjdSQ4cGMwef5zwqxSWk80NMGZVtlfUfw8SGU5ONuc4wxNwDLwyIa687Rqk+PPs
2m64nzN1k/faUAp5EVprf1KYUfrBe1tiIxSTfav/XdgEr2hR0Fo3BWbskFc20EEw
wgcbGm13seVW+Fuq85PY5NkZRlsOXLb+SZ6s+JlP5wHOA2H2KFGBbsK7l1KLb9xL
zRf8GQrRKoS/gg8U8AW9QH5ncAg7MGWNMaErvPVBkk/KjoG7ni7K7/FmhfY1S1RF
qQEi65x1aMqyyiH5PzyQURzzuouq8bldsd+NhhfXjXTmY8M5jgYugVkD83KN3XmY
8CMTJyCe
=2V/v
-----END PGP SIGNATURE-----

--=_MailMate_0C080286-7A66-4AE0-8E59-24023F4B7243_=--
