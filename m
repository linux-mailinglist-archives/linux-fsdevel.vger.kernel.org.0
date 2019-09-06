Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB4CAB684
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392034AbfIFK5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:57:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388816AbfIFK5G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:57:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1ED6F308FB9A;
        Fri,  6 Sep 2019 10:57:06 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52FDF5D9E1;
        Fri,  6 Sep 2019 10:56:59 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:56:58 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 10/18] virtiofs: Do not use device managed mem for
 virtio_fs and virtio_fs_vq
Message-ID: <20190906105658.GR5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-11-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Sf3MmCJcUNNLokcm"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-11-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 06 Sep 2019 10:57:06 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Sf3MmCJcUNNLokcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:51PM -0400, Vivek Goyal wrote:
> These data structures should go away when virtio_fs object is going away.
> When deivce is going away, we need to just make sure virtqueues can go
> away and after that none of the code accesses vq and all the requests
> get error.
>=20
> So allocate memory for virtio_fs and virtio_fs_vq normally and free it
> at right time.
>=20
> This patch still frees up memory during device remove time. A later patch
> will make virtio_fs object reference counted and this memory will be
> freed when last reference to object is dropped.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Sf3MmCJcUNNLokcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yO3oACgkQnKSrs4Gr
c8gsdQgAw8es95r3jldWITNK2HV3hQUadAUD6wcJTqh47Co/1pn1JWttU9UhsGCs
wlgovlHxIO9oPsjaBc+Vcyczu7QtV+5x4r2lAsxHBH0idZnq6H8T+Om+iM9F3Bhs
hlXTBKrjDt3anxgGHZ/EysPRolxSBPr3W81uqVOATwsS8zKO0liMr6z6brUc12Jx
a9w/zciAljgcusrSgVkQ5C1JwCvMxgGctU1rqzPE1QwPHOT+1/+f7KqJYmTvCYHJ
NfWPrl8z3I68LSE9XkSL6oVU9NDNbey1lzpGIBOpOmZZqucUU67jXy8HO3z2iNB6
UUKV1kzQjkeYn8GGRSqyyJhao8stKw==
=d30F
-----END PGP SIGNATURE-----

--Sf3MmCJcUNNLokcm--
