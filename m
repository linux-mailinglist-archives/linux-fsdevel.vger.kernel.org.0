Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC133056C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 10:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhA0JWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 04:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbhA0JGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:06:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1D9C061786
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 01:05:27 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bl23so1578150ejb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 01:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1cKX8iM9GfIwp3iWhIP0IMjvaZHjaGZCSMrVEhD7T88=;
        b=1jMds5YokoSy+mP/C2h/9hc2WV5cnHoR6ZD2ppQeqWqiAK997Riz8FhDmu+DGDechp
         gjnqmgc1cnQgZF/WUkK2FR29t7kAXmGtEYXp5+rufhwYJ8Xf2WEVhCP4LrMJY13E/Do8
         aYHhERM77qyzqmt8n7wTLPJTaDNjHdwbt+OvfSJpyIgArSUqqcubq2OcZZHVptseesUi
         OTDubONbN710b58DXVm+XIQp4kW/ETH5HJsitq0Uu3a9cFaitNOsgCg/FlzNBSU5ygTq
         BJJcMG8zmI0HJdIkvuILgRALkIOXsSWQdHvU/XA5npR/zyoTKpOIG2CjQLLnRw3dpai7
         SGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cKX8iM9GfIwp3iWhIP0IMjvaZHjaGZCSMrVEhD7T88=;
        b=nt0DBD1ZFvscd1ho0IY48Fg9NtUhOG1h/l4zrqb+2beA41TZMrM8RWS0rZGwrhBw7S
         f3+JPyn9cpVCbhwF+DZH+/+HEpQuphtMM4hxFVonyI8ljZFzo1YCjpQWfFEt9jSX5kCo
         ouZsKtjWN0/N+UYOkEWSFBPDzaDOgAQ3zK3hrEZQ9PXz/Sn1F7ssBeT8i9Gt9cdRi5Gb
         3BklkC45b2uSRQiakW0dbvrJIqjJbMte3whsmVGZCk194Szj8ptp3XkRLjoOJLO7IzlG
         wc/zoorq33XlvE+vj8pDwdkRXJyq9xeZDJq2/J3gdOvRKRyCFACbbo86CLM0SiBYLP6W
         RSQg==
X-Gm-Message-State: AOAM533CeVbtbtXsdf+mUclMVVrAxMaxEkXIToMpChAua/Fz8Rn4n5XC
        XOuja8NTVJMA9KR73TYcJ/7sl7lw9yK6QO2N694g
X-Google-Smtp-Source: ABdhPJw/027lJPRpOGbG/CRbPbAoFxXfwKa4AyPatLdEfg8mNIIO5XeJfOtECi9zTDVojiBvT2wO7RJ8cv2A/fhON3I=
X-Received: by 2002:a17:907:1629:: with SMTP id hb41mr5832257ejc.197.1611738326022;
 Wed, 27 Jan 2021 01:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20210119045920.447-1-xieyongji@bytedance.com> <20210119045920.447-4-xieyongji@bytedance.com>
 <20210127085924.ktgmsgn6k3zegd67@steredhat>
In-Reply-To: <20210127085924.ktgmsgn6k3zegd67@steredhat>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 27 Jan 2021 17:05:14 +0800
Message-ID: <CACycT3vE57-ac7vSmyxO_E_BAPSnwEHGuoX=B7UWHn5uxzPJNg@mail.gmail.com>
Subject: Re: Re: [RFC v3 03/11] vdpa: Remove the restriction that only
 supports virtio-net devices
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, bcrl@kvack.org, Jonathan Corbet <corbet@lwn.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 4:59 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Tue, Jan 19, 2021 at 12:59:12PM +0800, Xie Yongji wrote:
> >With VDUSE, we should be able to support all kinds of virtio devices.
> >
> >Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> >---
> > drivers/vhost/vdpa.c | 29 +++--------------------------
> > 1 file changed, 3 insertions(+), 26 deletions(-)
> >
> >diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >index 29ed4173f04e..448be7875b6d 100644
> >--- a/drivers/vhost/vdpa.c
> >+++ b/drivers/vhost/vdpa.c
> >@@ -22,6 +22,7 @@
> > #include <linux/nospec.h>
> > #include <linux/vhost.h>
> > #include <linux/virtio_net.h>
> >+#include <linux/virtio_blk.h>
>
> Is this inclusion necessary?
>

My mistake...

> Maybe we can remove virtio_net.h as well.
>

Agree.

Thanks,
Yongji
