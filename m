Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA5258349
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfF0NTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 09:19:14 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60182 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0NTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:19:14 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hgUIz-0006BR-AX; Thu, 27 Jun 2019 09:19:13 -0400
Message-ID: <2f94b350ce562701bf31820d0ba745a06c983223.camel@surriel.com>
Subject: Re: [PATCH v9 4/6] khugepaged: rename collapse_shmem() and
 khugepaged_scan_shmem()
From:   Rik van Riel <riel@surriel.com>
To:     Song Liu <songliubraving@fb.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     matthew.wilcox@oracle.com, kirill.shutemov@linux.intel.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        akpm@linux-foundation.org, hdanton@sina.com
Date:   Thu, 27 Jun 2019 09:19:12 -0400
In-Reply-To: <20190625001246.685563-5-songliubraving@fb.com>
References: <20190625001246.685563-1-songliubraving@fb.com>
         <20190625001246.685563-5-songliubraving@fb.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XX3VlRGl2hyUPeG85tjf"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-XX3VlRGl2hyUPeG85tjf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-06-24 at 17:12 -0700, Song Liu wrote:
> Next patch will add khugepaged support of non-shmem files. This patch
> renames these two functions to reflect the new functionality:
>=20
>     collapse_shmem()        =3D>  collapse_file()
>     khugepaged_scan_shmem() =3D>  khugepaged_scan_file()
>=20
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-XX3VlRGl2hyUPeG85tjf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0UwlEACgkQznnekoTE
3oMxUQgAifzfEQEqWrpF79WAQuJKF6M1RfFVcdGX22cjDZlnZKZdbZM16fG55kdN
0AsMM+3LHgBLS1mYq/8d/sjFPxCH8UH3qebrvr8RgZSOIQ6Yiy+GWoPMYgkfDqPd
RX08C+un8MGcnzIcHnot4Ha8v4i/+AUFcYWcEdChkrXvaooEdjjOUPeoAaNt3um/
lAP/vIGiFh+7paL/LSk0VGG5OUMn5EXtIBWiCRdcU8adw+2tcprzDBexQH5kGnA/
qUpJSGlHjJzLgb/zan9+kc8ajJRqf2ybIMCTLmhpuFFHLOnhfly8aYkZiwOtvlmL
nGKZ3qK9CZZrKTTQJwpQ70zomYRxQg==
=37zQ
-----END PGP SIGNATURE-----

--=-XX3VlRGl2hyUPeG85tjf--

