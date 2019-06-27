Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDCC58343
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfF0NSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 09:18:42 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60164 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0NSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:18:41 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hgUIO-0006Ad-1j; Thu, 27 Jun 2019 09:18:36 -0400
Message-ID: <8026a0341c83ceee69d04cbe55f1e0fa3d6cb610.camel@surriel.com>
Subject: Re: [PATCH v9 6/6] mm,thp: avoid writes to file with THP in
 pagecache
From:   Rik van Riel <riel@surriel.com>
To:     Song Liu <songliubraving@fb.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     matthew.wilcox@oracle.com, kirill.shutemov@linux.intel.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        akpm@linux-foundation.org, hdanton@sina.com
Date:   Thu, 27 Jun 2019 09:18:35 -0400
In-Reply-To: <20190625001246.685563-7-songliubraving@fb.com>
References: <20190625001246.685563-1-songliubraving@fb.com>
         <20190625001246.685563-7-songliubraving@fb.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WfH5iiK7XcqIOQRh+gpO"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-WfH5iiK7XcqIOQRh+gpO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-06-24 at 17:12 -0700, Song Liu wrote:
> In previous patch, an application could put part of its text section
> in
> THP via madvise(). These THPs will be protected from writes when the
> application is still running (TXTBSY). However, after the application
> exits, the file is available for writes.
>=20
> This patch avoids writes to file THP by dropping page cache for the
> file
> when the file is open for write. A new counter nr_thps is added to
> struct
> address_space. In do_last(), if the file is open for write and
> nr_thps
> is non-zero, we drop page cache for the whole file.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-WfH5iiK7XcqIOQRh+gpO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0UwisACgkQznnekoTE
3oNDZAgAhCigDJCHSHlL1abXwMFGGvkGQl64ICm1ia7nRSP9ppL9746ikxugPxnz
oCURzm/HvLsSaR6w5Orpm9e/su04mjAOdax5Ab1+ZyVTAzRTY7353e12znTqSLBL
p4ABWVBJ8LRquZvHJCD3XMUMtkyrfiA4pm10cP5irPZI7BEnmnpSR3FxhXOLJOxg
DVvD5fo/0JRBgh18pLOaw1BdZXW4MlbRrnsEmkCr+cHP/oViU6S0LwKKnandYKoh
y2s8zhUH4+aPl0lLLy3irNfXkXzPfnPDzBtwFaboLO/iUI1+bTrd8nax43O1pTxV
AoHIzhfHDW7cPSs7GDBgvNa9PTgohw==
=trnf
-----END PGP SIGNATURE-----

--=-WfH5iiK7XcqIOQRh+gpO--

