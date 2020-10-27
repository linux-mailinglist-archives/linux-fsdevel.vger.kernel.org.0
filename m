Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1396A29B1F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 15:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760819AbgJ0Ogg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 10:36:36 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10690 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760811AbgJ0Oge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:36:34 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9830780005>; Tue, 27 Oct 2020 07:36:40 -0700
Received: from [10.2.173.19] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 14:36:33 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/9] More THP fixes
Date:   Tue, 27 Oct 2020 10:36:21 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <A6E21592-98F1-4030-BB87-47C366F99C2A@nvidia.com>
In-Reply-To: <20201026183136.10404-1-willy@infradead.org>
References: <20201026183136.10404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_7DC03037-44EC-4B9C-AA63-1AE3B845D3DF_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603809401; bh=lMZLsnbv4bPvmRMvHH5HlYSCqzYY8J8HFBwFPgiU8Ow=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=kuF4Tebqz3n1msI/SVKaAPPNAn6IjERZy6KPyYTfKYDlQwUdm7ReGbAGjAxpOt2aZ
         n7lReJOCdyfchO9xywmY4X152Sw3k6Zccf470b5y3sbK9wcTLasSz73y4LTiPQkHC7
         3V11Wze9WUgGkj1yC/bqcX/akqO7FB+PKzd7hAYXjRHx+X+eGM3YabD7Cq9gOKHxGH
         fErTV8/pHAz2KmzE8HDoVBQXtecoXWvXIX1XyKXsEYE6hku4sLaJjVtb5MATUQ0dhY
         iUwulB5LghnUb/TEUeH1A2vuFiaoqZ9nnkMykcvriyRkBXSGQ+0fQFmoOGcg728cxi
         b0T2L5uhVxmIw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_7DC03037-44EC-4B9C-AA63-1AE3B845D3DF_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 26 Oct 2020, at 14:31, Matthew Wilcox (Oracle) wrote:

> I'm not sure there's a common thread to this set of THP patches other
> than I think they're pretty uncontroversial.  Maybe I'm wrong.
>
> Matthew Wilcox (Oracle) (8):
>   mm: Support THPs in zero_user_segments
>   mm/page-flags: Allow accessing PageError on tail pages
>   mm: Return head pages from grab_cache_page_write_begin
>   mm: Replace prep_transhuge_page with thp_prep
>   mm/truncate: Make invalidate_inode_pages2_range work with THPs
>   mm/truncate: Fix invalidate_complete_page2 for THPs
>   mm/vmscan: Free non-shmem THPs without splitting them
>   mm: Fix READ_ONLY_THP warning

They look good to me. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_7DC03037-44EC-4B9C-AA63-1AE3B845D3DF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+YMGUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK3l0QAKGShCDIX4KP9cAnECNzpwnORd/C0m0X2hV/
YgkryXPkCp9Mw9XRlacN+N5UXyDSAR8Cfd6i7eizr0EiZB4dMQ3ElfMUPEGpylIS
tmSgAEEMxie2CjODJ8lZ7fIm5Khgvv7JST1eDP3/gE7/GtanvSnYExvvT2ukwP8i
fb4c2guWSBou4bcTdMO8UtYky5neQzDnXSA2U/+4Bjm45Fta8+6+zkSWU+HYIJJT
PkN/VE3LJ63Kd9AIy9vX99Cr26rRn8gTh0r3iIN4QPRreJi8OjJ9L7t629Igc4xh
jNqE9IGGFATcXEABMmJxWGq5JZyJQHB4bgVs+RGXugHbIHJmIuKu2DWrNvnBKNq4
ns2qMBK1jb46cMLU/Ssmjt/Nq+ZWxfEhH0+Sn+kWVcqksPSwW0aGi+SD48+cITtE
PJvK6mnRZjXvH7QvKVU+6tVI8NzNOp5Lo9ASQMJhE070YyKNlShc8WdTXss+spAO
n6h81b3GmNhARiIT8IyT1RiELEGZTffce8esTcrJFYOt0VxlSgbtM2ExR/gE0Ok9
lz0Zi5S3vTCGdEvHhCHqgSUXTnin/CYZhVhoH8atRTPv69PY8CV55R7i1CvLS/AM
T4OQEOdcuFYgkGAnkzU8a3njdeS69zxz0rNAHeGwdtEoAjFFaLgnWnklgFvPaONb
vOt60e47
=Xdma
-----END PGP SIGNATURE-----

--=_MailMate_7DC03037-44EC-4B9C-AA63-1AE3B845D3DF_=--
