Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C7F7332
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 12:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfKKLhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 06:37:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51345 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbfKKLhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573472242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fp61CWS//Q9E9TEcOwi1Jd6e8o1eEd928Hz82Hyjf68=;
        b=cUMJ/FGzEk7UclqkZ2n/KcouEvQkaEfzu3dmW4/xMhvn/41M1Cexdvg0MnOfEEStr1cBgh
        dZBcifFoP+9UN1asdK4A6limZVNjiFos9njh/2Pehs6YEBvVmm/Ib6BUdHEwIG8KmohdiR
        kJvgNMT+bc3mPwFDGoiHhzLt/TG1TNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-ocj4iVjXOM-sSiQWiIP7tQ-1; Mon, 11 Nov 2019 06:37:21 -0500
X-MC-Unique: ocj4iVjXOM-sSiQWiIP7tQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CE96DB20;
        Mon, 11 Nov 2019 11:37:20 +0000 (UTC)
Received: from localhost (ovpn-117-169.ams2.redhat.com [10.36.117.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A09FB100034E;
        Mon, 11 Nov 2019 11:37:19 +0000 (UTC)
Date:   Mon, 11 Nov 2019 11:37:18 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     vgoyal@redhat.com, mszeredi@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] virtiofs: Use static const, not const static
Message-ID: <20191111113718.GG442334@stefanha-x1.localdomain>
References: <1573464401-4917-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1573464401-4917-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 05:26:41PM +0800, zhengbin wrote:
> Move the static keyword to the front of declarations.

Please mention why this change is necessary in the commit description.

>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  fs/fuse/virtio_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index b77acea..2ac6818 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -684,12 +684,12 @@ static int virtio_fs_restore(struct virtio_device *=
vdev)
>  }
>  #endif /* CONFIG_PM_SLEEP */
>=20
> -const static struct virtio_device_id id_table[] =3D {
> +static const struct virtio_device_id id_table[] =3D {
>  =09{ VIRTIO_ID_FS, VIRTIO_DEV_ANY_ID },
>  =09{},
>  };
>=20
> -const static unsigned int feature_table[] =3D {};
> +static const unsigned int feature_table[] =3D {};
>=20
>  static struct virtio_driver virtio_fs_driver =3D {
>  =09.driver.name=09=09=3D KBUILD_MODNAME,
> @@ -1026,7 +1026,7 @@ __releases(fiq->lock)
>  =09}
>  }
>=20
> -const static struct fuse_iqueue_ops virtio_fs_fiq_ops =3D {
> +static const struct fuse_iqueue_ops virtio_fs_fiq_ops =3D {
>  =09.wake_forget_and_unlock=09=09=3D virtio_fs_wake_forget_and_unlock,
>  =09.wake_interrupt_and_unlock=09=3D virtio_fs_wake_interrupt_and_unlock,
>  =09.wake_pending_and_unlock=09=3D virtio_fs_wake_pending_and_unlock,
> --
> 2.7.4
>=20

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3JR+4ACgkQnKSrs4Gr
c8gGrQgAiUk45Og7Sz14vxdo8xHlcsLPekKa5syDhdvKdMTEvk0+dTmW+FcE1N5M
EC7U13dTSLzKzBA5GWJ/3Wbj2nW5q38Kv8Ix4YDh+wX25e0DT+jrDDzpL9qQFUSq
hn06s6VJtwDVhDBh1B2Uflu6C8D+4B2nKgQJlNeHQArlvTCLMy50+kk6gVm+iJFu
Q71bIG7HEU7Hu3L/8xAPvQURVg9r5Mzcgq5ZXJI4Y/oMmfoYXdKSP5tvMzyyPaIh
rY1XYhsr6O3Jbv1cKAW1eg9lpbsH0kq6TnrtY2kKFDfzc3YWAPIWpN4nNxNJ1nPJ
LFU1K1nfHAr4Gl49rAPP1T36fImaxQ==
=bTfD
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--

