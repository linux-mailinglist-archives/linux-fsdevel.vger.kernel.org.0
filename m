Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB395AB761
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 13:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbfIFLwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 07:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfIFLwF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:52:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDE3CC057F2C;
        Fri,  6 Sep 2019 11:52:05 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 721DC5C1D4;
        Fri,  6 Sep 2019 11:51:59 +0000 (UTC)
Date:   Fri, 6 Sep 2019 12:51:58 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 12/18] virtiofs: Use virtio_fs_free_devs() in error path
Message-ID: <20190906115158.GT5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-13-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yypaS3FvPkEUiGyo"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-13-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 06 Sep 2019 11:52:05 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--yypaS3FvPkEUiGyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:53PM -0400, Vivek Goyal wrote:
> We already have an helper to cleanup fuse devices. Use that instead of
> duplicating the code.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yypaS3FvPkEUiGyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ySF4ACgkQnKSrs4Gr
c8hVlggAupQb9gfTAr4egGumTVeZNasLSgBakY+MqFVWz6P9M1eU0+mtx0t+LTvK
6hPYtUtYRNcR4U4LWcuAf30gKaYbr5UFDYmQ8zp8sCouPeTZChlnd35T2Aez6RQw
lTlB2cAikH0aAjaLU1ldhLnx/+NkO8KkPh5tEYfCOHPEgpZSz1BQ5ce5iwVY9s5a
2OZEet0IehG38kKsyXW88H+F/p8vHVLRrUkhi5CCezvlim7HFWRLFhj4Dc6Eu0sT
HQmMvhppnlYqoDj8+Nkhs2Xv87KZxK2E6k2Z5NLle7vl1H6HbROZPMJB0WPLLZ2y
+yZpbk5cezyZigVO/ES7VBTJc6IZyA==
=OijB
-----END PGP SIGNATURE-----

--yypaS3FvPkEUiGyo--
