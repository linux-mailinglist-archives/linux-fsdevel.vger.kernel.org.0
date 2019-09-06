Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC83AB765
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 13:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391092AbfIFLws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 07:52:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfIFLws (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:52:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16FFF305D637;
        Fri,  6 Sep 2019 11:52:48 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51C755D6A9;
        Fri,  6 Sep 2019 11:52:42 +0000 (UTC)
Date:   Fri, 6 Sep 2019 12:52:41 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 13/18] virtiofs: Do not access virtqueue in request
 submission path
Message-ID: <20190906115241.GU5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-14-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iBHcHRCIarfY7C0j"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-14-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 06 Sep 2019 11:52:48 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--iBHcHRCIarfY7C0j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:54PM -0400, Vivek Goyal wrote:
> In request submission path it is possible that virtqueue is already gone
> due to driver->remove(). So do not access it in dev_dbg(). Use pr_debug()
> instead.
>=20
> If virtuqueue is gone, this will result in NULL pointer deference.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--iBHcHRCIarfY7C0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ySIkACgkQnKSrs4Gr
c8gXMQf/QUTibXMbQdKidGB1Vqv7pi+fendYycKROG3QMPsuTAtmXYzqvaPyQ+V7
IQKRcXkPStzxee3RJePDleTtTNsjDlsuLgfpvgh0Bik7ZTOfN7ddHzXvcBx2VDJf
OtV+D2N9Cm2YkI1r2OEVWylqmv9aH83xFJHj5hsc7vNO+yu9V+7TA+RZKasdT1GX
zd/W2E4xlYS/vz9fKRX7QReLWIla2yJVy7Qb6MECtMGELGmq02OdzsO5SJWX52cG
gSh58Gw1wIyidQXqTbEkl+gNMORVs3xtNvlIXNyEcXjvaVZzRCAdq3UGVAFL2C7x
LeqWw3/P3WTKxDZwTHLyAwoo2fpnpg==
=cLla
-----END PGP SIGNATURE-----

--iBHcHRCIarfY7C0j--
