Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212CF44E036
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 03:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhKLCWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 21:22:11 -0500
Received: from shelob.surriel.com ([96.67.55.147]:48654 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKLCWL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 21:22:11 -0500
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Nov 2021 21:22:10 EST
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1mlM1M-00082M-7O; Thu, 11 Nov 2021 21:10:28 -0500
Message-ID: <f6bc63e6a9dd4077b021743583fa30325ca87c45.camel@surriel.com>
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
From:   Rik van Riel <riel@surriel.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <sforshee@digitalocean.com>, kernel-team@fb.com
Date:   Thu, 11 Nov 2021 21:10:27 -0500
In-Reply-To: <20211111221142.4096653-1-davemarchevsky@fb.com>
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-EfjSzByVTtxiEAj2xuEH"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-EfjSzByVTtxiEAj2xuEH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-11-11 at 14:11 -0800, Dave Marchevsky wrote:
>=20
> This patch adds an escape hatch to the descendant userns logic
> specifically for processes with CAP_SYS_ADMIN in the root userns.
> Such
> processes can already do many dangerous things regardless of
> namespace,
> and moreover could fork and setns into any child userns with a FUSE
> mount, so it's reasonable to allow them to interact with all
> allow_other
> FUSE filesystems.
>=20
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: kernel-team@fb.com

This will also want a:

Fixes: 73f03c2b4b52 ("fuse: Restrict allow_other to the superblock's
namespace or a descendant")
Cc: stable@kernel.org

The patch itself looks good to my untrained eye, but could
probably use some attention from somebody who really understands
the VFS :)

--=20
All Rights Reversed.

--=-EfjSzByVTtxiEAj2xuEH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmGNzRMACgkQznnekoTE
3oPyiQgAt505tis73i+DpmfSamsufzQ+ppH6zvlbouYV11cJyEw06g6vyQ2L9qhJ
p0LUR8lJc7ZUYqIfxlXoOqDy0oNS9mnqzD9qlTxT2rEbbKXBmYNd5SHQaB9ixCA0
eynTmW2TJ+E/tu1NF72UbkW2PUgGiB0rZIklAjVMqlm4YM6eRqBBn86Yf+4/RsFq
ZVCgZ3BisJweST3+BCGDpgORP++tSKZ3S+WnuXQMNITSY99FQsB9LRYGWXfJYqX8
G92sCVMG/HCI1qjFNJEKeJcugh4hxT65TjlrotIjFW1H8MAXikATH26ytydDuz3O
TuQqkR8Mk0a2rush5327DKDKvSRoCQ==
=hwwA
-----END PGP SIGNATURE-----

--=-EfjSzByVTtxiEAj2xuEH--

