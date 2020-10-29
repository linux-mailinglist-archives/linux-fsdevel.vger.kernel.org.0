Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBE529F66F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 21:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgJ2UuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 16:50:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11819 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJ2UuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:50:11 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9b2b050001>; Thu, 29 Oct 2020 13:50:13 -0700
Received: from [10.2.173.19] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 20:50:10 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/19] mm: Support arbitrary THP sizes
Date:   Thu, 29 Oct 2020 16:50:09 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <962AED13-94AF-434C-B57F-B5ACB2E4E7A6@nvidia.com>
In-Reply-To: <20201029193405.29125-4-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_7B92662D-59FE-4883-9A1B-BABA732D62A2_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604004613; bh=zgkzcXgIKZjaU+WDa7GgELxMv9oeMLsflOIdw7AergU=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=p0DAOayn4ChEYXS0++JjH4oJ2nzyGapcQ89hOW4NiNV8r3UuE0L7JtJhco2irel3j
         PMA25+h82hF/5zCpccmgDK6xo/UGj+/d3EvV3vSxPATfNmkU1VjmfLhsRIRSCOzZK6
         4e1U/eEjdy6FQs8n4CVkw6XnGw1a+WeqEr9cpFvNFPQE0oyYEfYzJSClTnDAWaiQd+
         S32KYW/iKGq9/mbmahmTfusFstTA5FlktXbu/2ldXMoNonFpGhnkvaaSX6gvzUnZ7F
         vC1zHGjCp0IsoRZBmOOPxGtdkpyAaPVoTBAC7viO7WQxYeIYg8AtTkn73FDMUlgotH
         ihAqp/yyTQL7w==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_7B92662D-59FE-4883-9A1B-BABA732D62A2_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 29 Oct 2020, at 15:33, Matthew Wilcox (Oracle) wrote:

> Use the compound size of the page instead of assuming PTE or PMD size.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/huge_mm.h |  8 ++------
>  include/linux/mm.h      | 42 ++++++++++++++++++++---------------------=

>  2 files changed, 23 insertions(+), 27 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_7B92662D-59FE-4883-9A1B-BABA732D62A2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+bKwEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKOlkQAI0vInc9A2kkHcnEeGD6T4EfmnTJXFjz78jr
NkUmYQQI9RoIk9H6+dDHWBqOKjfJ6qm3oBxGw3QAeKjPbCysha9oOZtRd1kcZG8+
LNAiWJX0HkrmYjIWvPF7J7V6jc4sDA6f3vwSOpIemoviGfue7vU5VVzrFmC9dLm+
DsaJ05ptYrUFguxFA8FZ8k/h6FpLYB05J7Br/68v7kn/mHPqamuS6uM+d7D2COP3
yuskpoyidl4KjEcyzTzLalYuih4AmjoJ5GYzsr6TwVu7E5L87RS1Xm/Ta2fXJGLm
VLIgl8G3OsM+o72bnXuFU9hRZeykoXrF8g8IRTmb7Ikg5wn6tHRm7onuNUMsW/QA
qbcw3lIavsPI154Pi/c9HJxRmU6r2bkze6K0yXuM4rdrmFsUVALnC/PMkLcXS7xC
RIAmU6qXtlYUdp8QomXC+dUXkGkxHuIUizi4eMtefajH5wwBDjX2WDgGKl0PAp2+
l3xFVMSDKEpJbRUYBZW5RHarIkfMtWAsD1rnxqKbDHgMKORA4B6YdGkh/oG4J30t
uuvBAiHm50IisCMB2KZdWVMA7k/6oeXMGFCWDXX+vbeG3/LX5JWj+SDjSdvkz0eq
5w+czf2BT6sgzGYQiQs0HzC0nnsRATxOPDicTdGvdWpeQ6MOvJYG8gAHCLnZ6cdz
uqpbSGbY
=vqm0
-----END PGP SIGNATURE-----

--=_MailMate_7B92662D-59FE-4883-9A1B-BABA732D62A2_=--
