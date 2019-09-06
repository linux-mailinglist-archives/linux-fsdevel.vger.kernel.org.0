Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9B9AB7C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404541AbfIFMGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 08:06:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404502AbfIFMGj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:06:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AA20307D88D;
        Fri,  6 Sep 2019 12:06:39 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF22B60610;
        Fri,  6 Sep 2019 12:06:38 +0000 (UTC)
Date:   Fri, 6 Sep 2019 13:06:37 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 17/18] virtiofs: Remove TODO to quiesce/end_requests
Message-ID: <20190906120637.GY5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-18-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lYVfafuUkPqz/tKz"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-18-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 06 Sep 2019 12:06:39 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lYVfafuUkPqz/tKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:58PM -0400, Vivek Goyal wrote:
> We now stop queues and drain all the pending requests from all virtqueues.
> So this is not a TODO anymore.
>=20
> Got rid of incrementing fc->dev_count as well. It did not seem meaningful
> for virtio_fs.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lYVfafuUkPqz/tKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yS80ACgkQnKSrs4Gr
c8iYtAf+M+W93KWyYjt/Ozu/X8KfP7/va+YH3UjLCSvUxvX5CnMw8go9WAGz79SW
h3CwH86zMiiBVTqVtUcV6HyxuDRdKDSLC123iMP5ydQGJYa63zkdGpbq8Xnc3kFB
vQdt2JHMqvByjMdtgAzOSdVYb5kslR6VxFrH8xd+fd7x6gKvp4dNE1lDfuI5iUHN
vS3OQ2IcSBv1TpPGTRrUhDEcz7N5ebnh5/JQvDbyPbmspchYS+PUvFofzLAQ61Pl
2gKkBnoYAnpHQJwXaFq7aTp/48t2BIsX9j6WrXeK2PjkV2Xa24O1M7jM995KwK+n
lHQUmHQMYTsl27X2YQeHusZ4XB1Gdw==
=LskU
-----END PGP SIGNATURE-----

--lYVfafuUkPqz/tKz--
