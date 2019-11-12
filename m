Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9DF8CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 11:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfKLKdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 05:33:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37978 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbfKLKdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573554816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UbdqnUvJyxjVktur7YbB/k1R6NmF4aLu8y6RDMWAoTY=;
        b=KHeo7L4zJbbUVXzpkkEnfGWKq7kstmTJJUOjz6JmeptqOmQQOjJZvhBTZ0MOZDMcJ1n7J8
        i9rwXDdfX6oRmC89InKqjMcolsEVA0HuiQsybyLdbhwRrGR132YAe+I+6we8N8i2yG/pKL
        SJo12lnwaATx/HUiNU/74YpySiEyFlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-gzBh0wV8OMqbISFucOXYSA-1; Tue, 12 Nov 2019 05:33:35 -0500
X-MC-Unique: gzBh0wV8OMqbISFucOXYSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C77E4DB62;
        Tue, 12 Nov 2019 10:33:33 +0000 (UTC)
Received: from localhost (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BE7A9F5C;
        Tue, 12 Nov 2019 10:33:32 +0000 (UTC)
Date:   Tue, 12 Nov 2019 10:33:31 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     vgoyal@redhat.com, mszeredi@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] virtiofs: Use static const, not const static
Message-ID: <20191112103331.GE463128@stefanha-x1.localdomain>
References: <1573474545-37037-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1573474545-37037-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 08:15:45PM +0800, zhengbin wrote:
> Move the static keyword to the front of declarations, which resolves
> compiler warnings when building with "W=3D1":
>=20
> fs/fuse/virtio_fs.c:687:1: warning: =E2=80=98static=E2=80=99 is not at be=
ginning of declaration [-Wold-style-declaration]
>  const static struct virtio_device_id id_table[] =3D {
>  ^
> fs/fuse/virtio_fs.c:692:1: warning: =E2=80=98static=E2=80=99 is not at be=
ginning of declaration [-Wold-style-declaration]
>  const static unsigned int feature_table[] =3D {};
>  ^
> fs/fuse/virtio_fs.c:1029:1: warning: =E2=80=98static=E2=80=99 is not at b=
eginning of declaration [-Wold-style-declaration]
>  const static struct fuse_iqueue_ops virtio_fs_fiq_ops =3D {
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
> v1->v2: modify comment
>  fs/fuse/virtio_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3KinsACgkQnKSrs4Gr
c8iVvAf+KcM0juc41tqI7xOrSt9zxcuq5KCxeQURRRWcUAPCKs2XgqNswQfg7yzx
ZDfiOV0zS9TJpfNDffpeZl9GiGMNHOZdsvOiJWMJIlydpZA5TrgWoRlrM+z/42iY
04Junb5gUk7sMeOPKU/HRHyMyoPUd2mbaxET+Zv2fPvWt3u2QTmW3R2puEHFiFo/
aG1ijnb2XYCWjolOS3wzDuhIhi4O+UMh9utzwYjlDV9GJH+7av4NBPS0DF5yUJfS
d062MA39xdIsNZdrliamIvrBV1QKpY7a+GaT7wAQvOcUbLf8YF6uNDyiRrVvj8K9
SRDgt9Kbr4GpQ8R6cJSnEIBe6mof+g==
=hbuN
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--

