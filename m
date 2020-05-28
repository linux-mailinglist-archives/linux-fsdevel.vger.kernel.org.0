Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76E1E6398
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 16:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391084AbgE1OTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 10:19:12 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9442 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390924AbgE1OTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 10:19:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecfc8010000>; Thu, 28 May 2020 07:17:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 May 2020 07:19:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 May 2020 07:19:07 -0700
Received: from [10.2.171.246] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 May
 2020 14:19:07 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/36] mm: Allow hpages to be arbitrary order
Date:   Thu, 28 May 2020 10:19:04 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <8525A9D1-6551-42C6-BF19-CAC4926FA500@nvidia.com>
In-Reply-To: <20200515131656.12890-4-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-4-willy@infradead.org>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_FD669B2F-AEAF-47A4-97AA-FCD5FE99CAAC_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590675457; bh=Wlo8+HURmTm34DNdJz6dWr6yZsksCAAqTCXZJbkhVbE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=Rs9Pjsv/BsgE+4GnQaXYQ2zC00rQvevnynjjFoLpA6dZxvUmsVfllz57KctZN/93p
         nQWiSglzChbezUyqV3K9OgmVOJMDudQRjTail2WOCFWYCr7YezkPAsSUgv//KNBHDN
         wiTjymfMy52PDItX8lZgx5Om1dKPliiFcmqIlaOSo7dONIWI0kgzyOAbUgCTognOkq
         jnS8sPkFlhBX+Z17T8H6IeIXAHa7qAf0TmWtTE3DnwWToBeGuXBK/JpTMqew0cHjQN
         Pd2Q6tyBDtlk2K6UhIro8blHcsiODEN1/dUWteITriORMrugk8GUOhgpo9Wo39PeDr
         zgbQcD8ko0y8w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_FD669B2F-AEAF-47A4-97AA-FCD5FE99CAAC_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 15 May 2020, at 9:16, Matthew Wilcox wrote:

> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Remove the assumption in hpage_nr_pages() that compound pages are
> necessarily PMD sized.  Move the relevant parts of mm.h to before the
> include of huge_mm.h so we can use an inline function rather than a mac=
ro.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/huge_mm.h |  5 +--
>  include/linux/mm.h      | 96 ++++++++++++++++++++---------------------=

>  2 files changed, 50 insertions(+), 51 deletions(-)
>
Glad to see this change. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_FD669B2F-AEAF-47A4-97AA-FCD5FE99CAAC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl7PyFgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKz6oP/iNKzP4qN28njUEd3e1klGCPQ+FIxbVvsd6j
vnWoNATamPXz7wGWxlpdmZggbEmnsU3NZp55eSWq8N2iD9N6W5D6IqzS/whsuLFB
hI3Bk7Qin6mXUVMj3NHzdYIGSbnBpayTfslxDG16pHiaRBDShn+Dms8Sq7Jb9b92
ZuDh+tP1qW3QIREdVkRFfiEwDuN2C8VvHZD63g5bmyNFfA8s+JDyycuUWTyLrsi1
b8cvb0IbhW8KbR2WsIEO0GtoKToKHLqqWo/BeElZSL+3Q1W/dHZKACEMsY2DpJgX
ePPw5pYjPtGTY7fjtnK4alaCCZmmRNaJMjaZk44uW54k1S+ScKBs0RJRBC8Lw3CZ
TrCY8SpDVSZf5Kls7yKl7ekkh7BFMwfe2ks7gvL65PAaGr/+IYy9htE20urLKFiK
NJMsNnM6unujfQw2AmkOrZUuLvUGsjkIVTkfnpM50E0MR6xaEu60HOcY94ZFLaZB
qesZi7+5nlw6dKircty9mwDP4mFO4yAWCNhY2/fgiqvs9k0Dnb0G+uO77UcAUtxm
Hij82oW8pUyNXrxX8cffrPd3VG69e1/3Gz7AStWAvM17QECkksepN5FBtmsgIrmr
3EH7IZahdA7kRZZz6Nfd1n5bchhPgFTSCoJulz0rR+FtrD+Rz4z2jADCTd6LDatH
7dWVogzJ
=Hw9v
-----END PGP SIGNATURE-----

--=_MailMate_FD669B2F-AEAF-47A4-97AA-FCD5FE99CAAC_=--
