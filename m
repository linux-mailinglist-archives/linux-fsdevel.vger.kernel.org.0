Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5729A1F6A86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgFKPDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 11:03:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6891 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFKPDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:03:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee2477a0001>; Thu, 11 Jun 2020 08:02:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 11 Jun 2020 08:03:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 11 Jun 2020 08:03:04 -0700
Received: from [10.2.166.236] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Jun
 2020 15:03:03 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 04/51] mm: Move PageDoubleMap bit
Date:   Thu, 11 Jun 2020 11:03:00 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <48AB34D3-BE1C-48D3-92C4-F1B72F0224B0@nvidia.com>
In-Reply-To: <20200610201345.13273-5-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
 <20200610201345.13273-5-willy@infradead.org>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_C8F162B3-6103-488D-A11B-82A1C5F1BC76_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591887738; bh=AgX2Zhbr7lEd6E8+Hf0L3s/xusOAST/vLsbKY8Zh+Uc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=Urxb3IptKUN/bMIzPDLnwxWEWyKGvfDE5yjGwfFxRbF4Gacik8qjoU/xe8yevukoS
         YtMO0+UlqO4TszZ7xO7BasoZEHhdzd491eeOkpYb2ZHHZrpxz0h+/xdWPJ8PzGCQXW
         5DyLWMT2d0jO8WMJiQuBLDC5tP024E8aWL1zIBgkCTODW4x6QdGDbJMPHbj3IDrl1v
         v68G8qnRfOGOUT38y6XFRWMxOv49fn2R9oF2fujwoFJUO7o+mFel26xJswSY7D3nAu
         0tD49vnkCTs61Lwyh+lVGlGVu3pWgOksSl1knTUPrD2ectRixlxP/T7SIe/m/7MoaS
         km/QtTQjb7vlQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_C8F162B3-6103-488D-A11B-82A1C5F1BC76_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10 Jun 2020, at 16:12, Matthew Wilcox wrote:

> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> PG_private_2 is defined as being PF_ANY (applicable to tail pages
> as well as regular & head pages).  That means that the first tail
> page of a double-map page will appear to have Private2 set.  Use the
> Workingset bit instead which is defined as PF_HEAD so any attempt to
> access the Workingset bit on a tail page will redirect to the head page=
's
> Workingset bit.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Make sense to me.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_C8F162B3-6103-488D-A11B-82A1C5F1BC76_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl7iR6QPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKaDIQALG0sa0NvW2mhCPElFp0IWMCGwsfD7Q/2NQL
OU6KnUC6CZJdYv03EMzKqrLCyVfM1hjZ/85L/qQotE7xSlMsSnsYcmuAQwLzH7/d
0qupSup0Yh+YQtbwjaWQvq2SqH+N2YL3h9VK1I31PnVHaofndl+ODDYAK3FtraX0
S5Q9hCZ42vN/ezAFiw7oR3W+JgowCLZQT7CAA6IGOYBCZAV3FBdjbe0h/Wg4nwjl
kx+pdOuvqr0RQBH1zfrFgnW9Xx/y8cNlWb5706u3ZWXsVMReQuGcjoZtml+sTpl5
zWF8eU7s3EUZofYONgxJQTXNg98xQrK0+srwsXhhNiVCALtB/+nZ88CA63VgWkLn
ZYLR8pqf2jV5c9bveX+jv8yUK55IbDQuz27oqhpX2vKJZNRJWjxhWGBlt8loHPx8
tLTC+fIevQXW2dQYpM+Oqj+vl0EDn3jWNVSeQgYO86LK1cqfK8RkfLGmkqJzDWj0
sn+A3DJSm85Cg02lQ1Un3P1oqQtEMU5LApB49RFTph6+FxAUP1E4B26ifqtl5egg
fEIuuPCex+KgwcijJuDFj00+qeDUBad30lzc019HrxRj42jSJXBemCd6QJBEikwY
86rimHfHZZFReSDLEXKip4b/Shjzsg1J4BEq/nSR2ivhLB6MN64iVa7Q+CLrviit
eZEojhX/
=pM5p
-----END PGP SIGNATURE-----

--=_MailMate_C8F162B3-6103-488D-A11B-82A1C5F1BC76_=--
