Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74817F906B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 14:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfKLNSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 08:18:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57120 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725847AbfKLNSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573564727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DifWWZ3nxpQ7N+G4DC3RqHsKEjQ6VCW7kyonEbc0we4=;
        b=BdBKy4yCIKQOUZ2fGCM6EW3YV9KsYXcNK5iKVC7VCgIho0OF4uyHQLCd4rsuqCcPNiOYZ/
        m8hc6Dq7eJ0QqiZmoj1lyQLad4o53gFGbPd7/RQtcniD/Z+N0PcMIlJOWUmM4esqhxQR+f
        hyVZ2GL/NPVQpfuRgP7GqeE9dBYii7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-cxkwwec0OZC1FrpEEqBZ5g-1; Tue, 12 Nov 2019 08:18:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0A82800C61;
        Tue, 12 Nov 2019 13:18:44 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE201171FF;
        Tue, 12 Nov 2019 13:18:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 46C21220463; Tue, 12 Nov 2019 08:18:41 -0500 (EST)
Date:   Tue, 12 Nov 2019 08:18:41 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     stefanha@redhat.com, mszeredi@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] virtiofs: Use static const, not const static
Message-ID: <20191112131841.GA5501@redhat.com>
References: <1573474545-37037-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1573474545-37037-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: cxkwwec0OZC1FrpEEqBZ5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek
> ---
> v1->v2: modify comment
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

