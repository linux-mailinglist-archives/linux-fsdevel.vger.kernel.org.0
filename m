Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6A6C721
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 05:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390236AbfGRDVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 23:21:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33349 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392297AbfGRDVa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:21:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45pztt4f7mz9sNr;
        Thu, 18 Jul 2019 13:21:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563420086;
        bh=onp2VmPiELbvIvkg2tf00xZcG6KP/CQLzKyAEZzDib4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kA006oxQfewIgA9PWNvgcNJ9JvzlF26mMPNUPdKr70a7iDhrLEsAq/As3QzuSrgeZ
         +hLFNtgTLS9LvJCEVCMByH+InBq7/ul40/FzhhXCLvxeZEiheUDeK2Mn7I+XeVGtfA
         T7z7uhHkrsfr1sDu3ktsndOKtVhzYpT4lrQywk++uGd+KViY69ioJOZXB07KPePr+j
         8+3gB8VHfXkr5vX8cTsSoilu+hjP0X2D5YqNClpj8E5Uu/O7OlI3VIgw6iT0CAB4YQ
         PMPWCaytNPerKOgfI0c9JKbQMCoRqHPGb5cL1QOPdDDJq14hD03oc4RwHQAirU9u4f
         qzN3cyznabT6g==
Date:   Thu, 18 Jul 2019 13:21:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     akpm@linux-foundation.org
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: mmotm 2019-07-17-16-05 uploaded
Message-ID: <20190718132111.1f55f46f@canb.auug.org.au>
In-Reply-To: <20190717230610.zvRfipNL4%akpm@linux-foundation.org>
References: <20190717230610.zvRfipNL4%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JOd2f8N3wfkBrruihbRJymm"; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/JOd2f8N3wfkBrruihbRJymm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 17 Jul 2019 16:06:10 -0700 akpm@linux-foundation.org wrote:
>
> * mm-migrate-remove-unused-mode-argument.patch

This patch needs updating due to changes in the iomap tree.

The section that updated fs/iomap/migrate.c should be replaced by:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index da4d958f9dc8..e25901ae3ff4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -489,7 +489,7 @@ iomap_migrate_page(struct address_space *mapping, struc=
t page *newpage,
 {
 	int ret;
=20
-	ret =3D migrate_page_move_mapping(mapping, newpage, page, mode, 0);
+	ret =3D migrate_page_move_mapping(mapping, newpage, page, 0);
 	if (ret !=3D MIGRATEPAGE_SUCCESS)
 		return ret;
=20
--=20
Cheers,
Stephen Rothwell

--Sig_/JOd2f8N3wfkBrruihbRJymm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0v5acACgkQAVBC80lX
0Gy4Fgf/e9X65fZvCbB0Nhqw4PpeHOAdJvQRDvZA84FLdP/vsEKnLjFlFir0togF
JgD4OAYOQvGeZqhbFOfSFETsraF4HOvu0CWObY7pHuDrizRDl4GX9ZKPGx/9+VkV
dLoS2uFuV0tMC9fvyT/o+kLJE/r/zZNcXOJs/E5Fpzx8R7EN4nmS71quPkhezPeb
/joItlo6DtsauVnTtUnrYqlDieWVOMCb0Xa+nHF3IzbQR/afTyoWxIYkCWhCS6/D
muCE72/kFn5C5/9A637Xtffweis6aS4t47HVEesWFh5BZoFrOzYUN7AJGLoQ9tzm
GPh337OUHu0D+XgyPiI4kazKcLXWRg==
=HJt9
-----END PGP SIGNATURE-----

--Sig_/JOd2f8N3wfkBrruihbRJymm--
