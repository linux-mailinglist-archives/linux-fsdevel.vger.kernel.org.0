Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB03329F63D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 21:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgJ2UdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 16:33:20 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17777 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2UdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:33:20 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9b271a0000>; Thu, 29 Oct 2020 13:33:30 -0700
Received: from [10.2.173.19] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 20:33:19 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/19] XArray: Expose xas_destroy
Date:   Thu, 29 Oct 2020 16:33:16 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <5E20B229-D373-4BC7-A987-BD6EEBD226D9@nvidia.com>
In-Reply-To: <20201029193405.29125-2-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_225082CE-DC41-46CB-BE57-AF86FE80B18C_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604003610; bh=CBIRzfKI17jIJysRDkOk+461wfERIR8WfLkwMUgzHzs=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=WCZLXwYdxytktBsR1F2eM7dt4w/htg2BycJfEeDlSC0gxSdf7/UUI8XHZbRCjw+3Y
         JLBO+uL6SQdgg7Em+mTUYVDf+lozP4WHqAiOFSentHQRAuQ7+1u04nmPDfjhVrWfNc
         8ov9e96wD7M6T4HTnpR4nLdOA71YvqreP5KnHvwZ2QtSPUYjtICE/62Qb0SsQzmOQN
         y37Cke8ARYwiiJRP7udJQJXSklSUlny+c4wV3J16DFHuFBFVHcbz9kc+uI9GmW6KBy
         vwg/x2uI2SPh+MjOffmoPvr3GBeoXkjAVqwpYsNlqW128G14Mt7eBXz6xj+QeVDVpr
         gRFjE+tR6XMSw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_225082CE-DC41-46CB-BE57-AF86FE80B18C_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 29 Oct 2020, at 15:33, Matthew Wilcox (Oracle) wrote:

> This proves to be useful functionality for the THP page cache.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/xarray.h | 1 +
>  lib/xarray.c           | 7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_225082CE-DC41-46CB-BE57-AF86FE80B18C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+bJwwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKINoP/3qR+U/xblc7dSzny5GvES/OdBhXcrdcDxkg
+YZdO9M4hlWLlmDAYH3KWQAr3tmzMuG4VF38iMpbhmHORdufgLY6Y2fnw3fiatOm
Io5nrzXOFmxFMG/8aYs8r9cuG7cuCXFnwUNasUNDU1S9vyN22pkyQ28qkyIa79jw
3nk8QADmEJPoPytzEISI671R83rtyhisj6TTD12pR205SkIxX7JkkHGBjPjbPK/m
e/UVpRIve4U7xAgtkZ1AER0LxiiVNwjThFK3z3b4kaHfN0NHAOFs+4+MHgv57EWH
JiBW7bRgonbWa/5hOK1D7pLC4Ti4J1MG11oUvHdJyImCDRv4kIFentHF020/JPF/
zHXuorKURYnFzF8zY1telnJBkGdZKvE5u681+6zDsYyoyRE0PdwzFYyMro56RTR2
0sfpW5qE7e8mjx05wGrIIdM7ZQbHV7NRcIkpX7Ql+i16L6p+SVF05kjPhgjyrOi1
GDRgLlvOXcnVDxyEDyCdhQKplsWT0cl6tyR1wkgpP/Br5nnk7HQ/CcqnlO47jpSx
PEFM6K5oab3tevlbFWFJAPXB6jhexbjvMwqtGi6g9ERIuE2YaAs7ZPYfObdSUzNr
BHdMBeZAL4MB8RjLhqoDxjgBP81LdjovDwOa1doDJVeAWu0+PNV1/XJrRqzwpu/h
6nL9kChb
=A2hJ
-----END PGP SIGNATURE-----

--=_MailMate_225082CE-DC41-46CB-BE57-AF86FE80B18C_=--
