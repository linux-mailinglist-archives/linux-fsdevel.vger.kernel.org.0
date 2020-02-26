Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95311705C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 18:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgBZRNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 12:13:35 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18005 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBZRNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:13:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e56a6ef0000>; Wed, 26 Feb 2020 09:12:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Feb 2020 09:13:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Feb 2020 09:13:34 -0800
Received: from [172.16.126.1] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Feb
 2020 17:13:32 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v8 07/25] mm: Rename various 'offset' parameters to
 'index'
Date:   Wed, 26 Feb 2020 12:13:30 -0500
X-Mailer: MailMate (1.13.1r5676)
Message-ID: <0681AC00-BFA7-4C1B-9E92-6B36FA906924@nvidia.com>
In-Reply-To: <20200225214838.30017-8-willy@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
 <20200225214838.30017-8-willy@infradead.org>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_07A99A6D-503B-4120-84DB-898871E175DC_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582737136; bh=mg3n04aLS3/0aW0eyWChE9vpAgeCbiunpfGU7AghRnM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=M7uNS8WbS5inK7ffF1gDGqi6BEnQKPsrcjMLXdvezxqm0AiTFvwllSVW/w8n59f9F
         V34n2s9nEVY/4D6//i/EKK3lz0KuHjR3/AgLEuzhAH8zTRapedCwdzvdMzLgfssxVk
         6uuoU0/a0CeBBeWlpM+GBiX4U36tZbBkrzY2AgMOcah+bFG40dbvC3bzNBqVuiQfnn
         7B23COHktbG67CvYwyCLEeevESVB1M0ttcUXyjDxpyKQzFZ/o14kx7Vlnjp1Vl3kYh
         QPNIQpY+qazBjfLuQS9hBZsPPYD+/0AGowk4y/Yrv7Es5gxHxuSBtcU0OCfz4sOxIR
         54TA+M6T9wTUg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_07A99A6D-503B-4120-84DB-898871E175DC_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 25 Feb 2020, at 16:48, Matthew Wilcox wrote:

> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> The word 'offset' is used ambiguously to mean 'byte offset within
> a page', 'byte offset from the start of the file' and 'page offset
> from the start of the file'.  Use 'index' to mean 'page offset
> from the start of the file' throughout the readahead code.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_07A99A6D-503B-4120-84DB-898871E175DC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl5WpzoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKV10P/3wdODr0Q7tZ/M8jMum6zEQU0MY220Wz5wz6
/mYps3gNEW6eEhbFsQpnK4823yVMDfBih1WwZLdS/6HbJlXHjhTfcLtEFLdkxyPJ
DuWVLGx0uTRwFpUI9Lafd/SpIKAYfnyNi82WlR85zfoFbD4aQSkH19hRScGERL0B
sig3qcFbjLk9Ej7AbviIflLo7gvPaui2EgVjubLfWgUW66U0X7vnCu355fRnlkmK
3Fa9Ipx8EoTp6CG4PWteDdp8lP8CvdJwZKfluaHj/NJjOqxpL/SUTuF9FXtr8nov
l6pElk5cSwy4T4gvyhfmUIYSptxeU+KJSx3hA687R53i9gCQqLepFRwbhe03M87h
2p63F1KGiqm4uzJSDTiKyRLBJOrpDQRjpZSSQ2XBQUOHd2tDHSN5l/2ADupYaF2Y
zXvGbPgzVdHRVY0Ijsu6DqPk0aJfbvtOPZHWfZ9FEVoSj+viLH/AB/8l7OEEGS9M
3h1dW2ghyuDEZfbTB6ow7XVEd2d1B8xxiGTlg13HU2KSuJQlkVGbEZV2Zw9Z/bQx
sYt9io5U0tZ2Q4M8pBiuHeEK3LbKSdXf0kHj0Ovnxg+njzZlZgCfnn2mJOPSdBqs
YksF5IfUgMM+j9I94cj8dJJIz1HyLGox6fq4DxluYIIBkOcVFfinqTqRjgr/AxX+
P6tLcgNH
=g1cC
-----END PGP SIGNATURE-----

--=_MailMate_07A99A6D-503B-4120-84DB-898871E175DC_=--
