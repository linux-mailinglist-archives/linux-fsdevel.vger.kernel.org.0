Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB69F2FCB2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 07:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbhATGsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 01:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbhATGr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 01:47:28 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C02C061757
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 22:46:47 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id dj23so21869446edb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 22:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g4lhhRzpUykCcRXCg/W7T7JNzcLSoefS0TeqhIEaN/8=;
        b=rPRydcGzNYYD4jdcx6cs91TNqFu4h+kQ6v/HhigV9C1h7tO7mVRQ/4RKNOl68YWW8e
         D61o4I2b1sWwltWA+6h5JB2vxbbrsgxCEYvue5eyWZSt6egTWDii7fFu+uGwP9JV8nTM
         fcRZ2Evekiu+eVFCPn3tXkOurhrsRuUKQcCAmhFApSsm+kxOxJMcGy4VdKB3cqWGLmv/
         fnD654WAKlTvQA6+kmR1Y/YAx9QBZdZEzr08NWdJfLILFIN4Bi0gwQo3k11e1W0OyQAS
         oPREr7i2f1QuS+Crpshk5/7gaSE6RjKb5886HveDOq1DcYYFFQXJE3/4R3PrQg/aQtdz
         YwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g4lhhRzpUykCcRXCg/W7T7JNzcLSoefS0TeqhIEaN/8=;
        b=QyYxHxP4+NSCFSG18bYRwHm6hTSC3D3vy0+yK+6X10Y7YGZ+JsFB57AzWak5QTnjfs
         ECR/oU0aFr9qB5h6I/zFy/gaCzmrgrh4NFqW98hjMf4aBnAwxiqf9KcjZax3LJk8MOPj
         dfH7yqF7Z4EjU5gmHBxg0kq5WyrrJyg79iP2i+8sWFc4C4zNWyMM5Kad5oFcLm3YS7RE
         UWF9CxtZUq/XGUpn1gPbNLYSF+kxvSfJ86MIn4SGEyzcLxqNF/pSnKP8/mGnjRUwQ4Aw
         qRB2PL/0BrRDjdqPNX7Hj6LRGXno1ejpfhcW9ea82IvqHRIcpZwRumo0CIhZ7D2R3qwG
         iTjw==
X-Gm-Message-State: AOAM5325djgAAQXsyoVBm9Yfjfa6SI61moAFsmUS/GM3FMtDbDF4MKSx
        6Mx9mcvcmtjhhVgUQZsB8om2O2gEMZDqX/TIYfTX
X-Google-Smtp-Source: ABdhPJzS0Fmnn19Dv/j0SuEVertO84A9c+rb/SpMABBdKYWrAbeYpyc0LC9NhIq1vhkOeDgZsTngL/MrfQWeGGE/14o=
X-Received: by 2002:a05:6402:228a:: with SMTP id cw10mr6032506edb.195.1611125206521;
 Tue, 19 Jan 2021 22:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20210119045920.447-1-xieyongji@bytedance.com> <20210119045920.447-4-xieyongji@bytedance.com>
 <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
In-Reply-To: <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 20 Jan 2021 14:46:35 +0800
Message-ID: <CACycT3satwmXVn4_J_x0s1E7GvzL5moovx0jssyVY0iXa_NQ9Q@mail.gmail.com>
Subject: Re: Re: [RFC v3 03/11] vdpa: Remove the restriction that only
 supports virtio-net devices
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, sgarzare@redhat.com,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, bcrl@kvack.org, Jonathan Corbet <corbet@lwn.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:47 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/1/19 =E4=B8=8B=E5=8D=8812:59, Xie Yongji wrote:
> > With VDUSE, we should be able to support all kinds of virtio devices.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/vhost/vdpa.c | 29 +++--------------------------
> >   1 file changed, 3 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 29ed4173f04e..448be7875b6d 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -22,6 +22,7 @@
> >   #include <linux/nospec.h>
> >   #include <linux/vhost.h>
> >   #include <linux/virtio_net.h>
> > +#include <linux/virtio_blk.h>
> >
> >   #include "vhost.h"
> >
> > @@ -185,26 +186,6 @@ static long vhost_vdpa_set_status(struct vhost_vdp=
a *v, u8 __user *statusp)
> >       return 0;
> >   }
> >
> > -static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
> > -                                   struct vhost_vdpa_config *c)
> > -{
> > -     long size =3D 0;
> > -
> > -     switch (v->virtio_id) {
> > -     case VIRTIO_ID_NET:
> > -             size =3D sizeof(struct virtio_net_config);
> > -             break;
> > -     }
> > -
> > -     if (c->len =3D=3D 0)
> > -             return -EINVAL;
> > -
> > -     if (c->len > size - c->off)
> > -             return -E2BIG;
> > -
> > -     return 0;
> > -}
>
>
> I think we should use a separate patch for this.
>

Will do it.

Thanks,
Yongji
