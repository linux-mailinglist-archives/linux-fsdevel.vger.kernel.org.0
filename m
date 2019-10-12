Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB183D4EFA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 12:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfJLKZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Oct 2019 06:25:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfJLKXv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Oct 2019 06:23:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 978F8308424E;
        Sat, 12 Oct 2019 10:23:51 +0000 (UTC)
Received: from localhost (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F0A5608A5;
        Sat, 12 Oct 2019 10:23:48 +0000 (UTC)
Date:   Sat, 12 Oct 2019 11:23:47 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, msys.mizuma@gmail.com
Subject: Re: [PATCH] virtio_fs: Change module name to virtiofs.ko
Message-ID: <20191012102347.GB17940@stefanha-x1.localdomain>
References: <20191011181826.GA13861@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <20191011181826.GA13861@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sat, 12 Oct 2019 10:23:51 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 02:18:26PM -0400, Vivek Goyal wrote:
> We have been calling it virtio_fs and even file name is virtio_fs.c. Modu=
le
> name is virtio_fs.ko but when registering file system user is supposed to
> specify filesystem type as "virtiofs".
>=20
> Masayoshi Mizuma reported that he specified filesytem type as "virtio_fs"=
 and
> got this warning on console.
>=20
>   ------------[ cut here ]------------
>   request_module fs-virtio_fs succeeded, but still no fs?
>   WARNING: CPU: 1 PID: 1234 at fs/filesystems.c:274 get_fs_type+0x12c/0x1=
38
>   Modules linked in: ... virtio_fs fuse virtio_net net_failover ...
>   CPU: 1 PID: 1234 Comm: mount Not tainted 5.4.0-rc1 #1
>=20
> So looks like kernel could find the module virtio_fs.ko but could not find
> filesystem type after that.
>=20
> It probably is better to rename module name to virtiofs.ko so that above
> warning goes away in case user ends up specifying wrong fs name.
>=20
> Reported-by: Masayoshi Mizuma <msys.mizuma@gmail.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/Makefile |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> Index: rhvgoyal-linux/fs/fuse/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rhvgoyal-linux.orig/fs/fuse/Makefile	2019-10-11 13:53:43.905757435 -0=
400
> +++ rhvgoyal-linux/fs/fuse/Makefile	2019-10-11 13:54:24.147757435 -0400
> @@ -5,6 +5,7 @@
> =20
>  obj-$(CONFIG_FUSE_FS) +=3D fuse.o
>  obj-$(CONFIG_CUSE) +=3D cuse.o
> -obj-$(CONFIG_VIRTIO_FS) +=3D virtio_fs.o
> +obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
> =20
>  fuse-objs :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdi=
r.o
> +virtiofs-y +=3D virtio_fs.o

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2hqbMACgkQnKSrs4Gr
c8hzPwf9EGq7n78zLI7WXmZzLq+aRRmqpXomJeVpspfpdsQp2HXEEWqxK/IbDysk
VKjiZJnyTQLGujvxy5+rSs2evsgEc1MMcpFAzqK/iXK5HqhH43XBsfbNa/ojQeZL
WBC8y7hallEQjJZbxo0eL9KvGjCPw7PgfXyVXp31CSgdtX/HnFZITpcEk5D0FcE0
9MJs6vGNnrto7oKGuQdnAMDeL6B/OwDeAz/GJ9tUsZyNjWIfxLGBRroqiLY1jAcP
t7IrCuLDxpE3lLPApfQLHuSHuuhCaQSeVPWk13+0KQWGRyWk6/qvIoaQxU5eevT1
ckHZ5lcucX2cJlkNn/6w1wkSaE//+g==
=hmmz
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
