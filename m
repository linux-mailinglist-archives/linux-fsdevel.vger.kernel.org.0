Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A5AB769B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbfISJrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 05:47:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388883AbfISJrj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:47:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2DDF308218D;
        Thu, 19 Sep 2019 09:47:38 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDF625D6B0;
        Thu, 19 Sep 2019 09:47:37 +0000 (UTC)
Date:   Thu, 19 Sep 2019 10:47:36 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Smelkov <kirr@nexedi.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: unexport fuse_put_request
Message-ID: <20190919094736.GD3606@stefanha-x1.localdomain>
References: <20190918195822.2172687-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <20190918195822.2172687-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 19 Sep 2019 09:47:39 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 09:58:16PM +0200, Arnd Bergmann wrote:
> This function has been made static, which now causes
> a compile-time warning:
>=20
> WARNING: "fuse_put_request" [vmlinux] is a static EXPORT_SYMBOL_GPL
>=20
> Remove the unneeded export.
>=20
> Fixes: 66abc3599c3c ("fuse: unexport request ops")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/fuse/dev.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DTrgACgkQnKSrs4Gr
c8gfJggAxvYng+EtRs9QOwx/Eu7fywLxOT5mIL4XN2OZsXuMfgL1bpTzLWfkeNmW
SVGB09XQW6hYunV0WDyeEneXuCIrUnicmn3ufRiiAaIBKN6b2PBJjQBrACPibgmj
WXKL/sPlN/T9NtQq6wlxlhP5aAnl9FuR9Qt8SmvR/zk/Vk5H+vhpCDLDvKlgnZS3
JgdGgVVqDPPUb7oyiP4erfa2gEgJA0D7McDxM7KD+Y8MEwcl9Z6eUEuiQs90A8NZ
gfYWuz1AgShnt/vr4j+vwm565KN0KNmRDeOMvg4eVBQMHzDP/HsIwRdUff7sjGbv
V3+4DnQJoaBHV385pOkLVj43zXe7JQ==
=NaDP
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
