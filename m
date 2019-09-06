Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234ECAB638
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfIFKng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:43:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfIFKng (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:43:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B065F308FC20;
        Fri,  6 Sep 2019 10:43:35 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C3C160605;
        Fri,  6 Sep 2019 10:43:30 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:43:29 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 02/18] virtiofs: Check whether hiprio queue is connected
 at submission time
Message-ID: <20190906104329.GJ5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEkEgRdBLZYkpbX2"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-3-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 06 Sep 2019 10:43:35 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:43PM -0400, Vivek Goyal wrote:
> For hiprio queue (forget requests), we are keeping a state in queue wheth=
er
> queue is connected or not. If queue is not connected, do not try to submit
> request and return error instead.
>=20
> As of now, we are checking for this state only in path where worker tries
> to submit forget after first attempt failed. Check this state even in
> the path when request is being submitted first time.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PEkEgRdBLZYkpbX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yOFEACgkQnKSrs4Gr
c8hhnwf8C1VOQGWJHHILCVCJLNrPVQsE6GduEOaYKWu+DWRzDGKRdA6vZkRi4Pm4
M2fEi34e41LhBT3A++2Qlom33KMRqy9E9OtEkPvwJcL5NJIzoaxmfAVfuHHSTlsL
zkfGOJeruqBsGl1LzEZkJ/3BSEGv/LP45bONl4uJC5f1ebV5HWleV8dZ92nenXZ7
UQDVXLNqiwX8V1Xq3xv21CSKwgq/XakX/fu0kuLmtTJhExLjgQOeiLb6qOJ/QeUO
wV5cFWUKMZv6xSro34316GVjuRvAh9H5B4g1IXiDlQ9nel6/anE1zcTWiDAoP5Pg
boT9ocfdxNM33hESs2aomGPnPOCbzg==
=HWp9
-----END PGP SIGNATURE-----

--PEkEgRdBLZYkpbX2--
