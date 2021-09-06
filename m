Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE13401834
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 10:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbhIFIsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241498AbhIFIrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:47:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8824CC06175F
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Sep 2021 01:46:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id t19so12005747ejr.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LAmaSyJa7xIkRyWmQFQLPdtTpPfl6cF8N/0UDdi5JQ=;
        b=ftFDUtejRaca7/VzbCnbdEqwMSB1qRj0J5JYAYxPmAajPt03iJ9JCXESud9TiTSFw/
         I7SEgZbb5lKtt2/bzhJSqptGgf4gIGPXHdpEN+PqnzoJCwe5G6zw1nZV5r1mHhS2Uj6u
         Ma3WF0jXLDn+f7ZSOT3zf1nrVt/O+3Hz8nT/Xs9Zrojfwv8wZrnspilhtE7WoyICjPFF
         /BMAycSuJw9hbx4I4PL//aQpMrxhcaD/FCjz3yn0AM8kK11PIo9D4z2JpAZFfyn00OAF
         XAOQbuFOpM72i24Kdf2NjGDkRC54nedjfG1Hhy3fsWsggeuCs9rfuR4xMpV0zJe/P+Dq
         iNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LAmaSyJa7xIkRyWmQFQLPdtTpPfl6cF8N/0UDdi5JQ=;
        b=GYhhucb9zWGKYfWXbCR/ROBHwGNzGXsLbFdpakSGZT0npYlJDBtxvYSU6dGLhScvEo
         63yGwm4pZXmZ9SERKHmYj4NNxPp+qG2aRzT0byNpWqmD1yBFzGYDP5tfP7w0CK4f3WnS
         LWQ1V1w0SSW5LGYMrkdcSv9bDBAAfLPvQ0b7YUlP6wHsyb3o2RsTpWtqbfoPFSnPBiOt
         TbPFCziay+p2a305aYLvQLkYLnsq89OcZED8od5Qb7IvrzFyvWoD2O091+PBGlWvOLwg
         kGYSIGHAXgEdy2uSozUYqYMZtdWJ8QoEYw7lVY9J0dDsSIkNu3YDaJhGuqKnLCTWGvAj
         8rzQ==
X-Gm-Message-State: AOAM533xT9zxg6P/ckZS38T8Vh/sZM27ruPhdd4mBhelHkDvJR0qLx/x
        4Xbl0wG2iOjEItexPtlzkJp09DIDBnZrXF1b/r7k
X-Google-Smtp-Source: ABdhPJxRcevb7Cx9lFr/uLNuGUc45WhioHM0KmVHs1F8bqTkXfZVuaNxvzm/8iuqiAHlOvgz0eipWdPdNONQLdXkGV8=
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr12529737ejc.504.1630917966948;
 Mon, 06 Sep 2021 01:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210831103634.33-1-xieyongji@bytedance.com> <20210831103634.33-6-xieyongji@bytedance.com>
 <20210906015524-mutt-send-email-mst@kernel.org> <CACycT3v4ZVnh7DGe_RtAOx4Vvau0km=HWyCM=KzKhD+ahYKafQ@mail.gmail.com>
 <20210906023131-mutt-send-email-mst@kernel.org> <CACycT3ssC1bhNzY9Pk=LPvKjMrFFavTfCKTJtR2XEiVYqDxT1Q@mail.gmail.com>
 <20210906035338-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210906035338-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 6 Sep 2021 16:45:55 +0800
Message-ID: <CACycT3vQHRsJ_j5f4T9RoB4MQzBoYO5ts3egVe9K6TcCVfLOFQ@mail.gmail.com>
Subject: Re: [PATCH v13 05/13] vdpa: Add reset callback in vdpa_config_ops
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>,
        He Zhe <zhe.he@windriver.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Joe Perches <joe@perches.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 6, 2021 at 4:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 06, 2021 at 03:06:44PM +0800, Yongji Xie wrote:
> > On Mon, Sep 6, 2021 at 2:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 06, 2021 at 02:09:25PM +0800, Yongji Xie wrote:
> > > > On Mon, Sep 6, 2021 at 1:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Aug 31, 2021 at 06:36:26PM +0800, Xie Yongji wrote:
> > > > > > This adds a new callback to support device specific reset
> > > > > > behavior. The vdpa bus driver will call the reset function
> > > > > > instead of setting status to zero during resetting.
> > > > > >
> > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > >
> > > > >
> > > > > This does gloss over a significant change though:
> > > > >
> > > > >
> > > > > > ---
> > > > > > @@ -348,12 +352,12 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
> > > > > >       return vdev->dma_dev;
> > > > > >  }
> > > > > >
> > > > > > -static inline void vdpa_reset(struct vdpa_device *vdev)
> > > > > > +static inline int vdpa_reset(struct vdpa_device *vdev)
> > > > > >  {
> > > > > >       const struct vdpa_config_ops *ops = vdev->config;
> > > > > >
> > > > > >       vdev->features_valid = false;
> > > > > > -     ops->set_status(vdev, 0);
> > > > > > +     return ops->reset(vdev);
> > > > > >  }
> > > > > >
> > > > > >  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > > > >
> > > > >
> > > > > Unfortunately this breaks virtio_vdpa:
> > > > >
> > > > >
> > > > > static void virtio_vdpa_reset(struct virtio_device *vdev)
> > > > > {
> > > > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > > > >
> > > > >         vdpa_reset(vdpa);
> > > > > }
> > > > >
> > > > >
> > > > > and there's no easy way to fix this, kernel can't recover
> > > > > from a reset failure e.g. during driver unbind.
> > > > >
> > > >
> > > > Yes, but it should be safe with the protection of software IOTLB even
> > > > if the reset() fails during driver unbind.
> > > >
> > > > Thanks,
> > > > Yongji
> > >
> > > Hmm. I don't see it.
> > > What exactly will happen? What prevents device from poking at
> > > memory after reset? Note that dma unmap in e.g. del_vqs happens
> > > too late.
> >
> > But I didn't see any problems with touching the memory for virtqueues.
>
> Drivers make the assumption that after reset returns no new
> buffers will be consumed. For example a bunch of drivers
> call virtqueue_detach_unused_buf.

I'm not sure if I get your point. But it looks like
virtqueue_detach_unused_buf() will check the driver's metadata first
rather than read the memory from virtqueue.

> I can't say whether block makes this assumption anywhere.
> Needs careful auditing.
>
> > The memory should not be freed after dma unmap?
>
> But unmap does not happen until after the reset.
>

I mean the memory is totally allocated and controlled by the VDUSE
driver. The VDUSE driver will not return them to the buddy system
unless userspace unmap it.

>
> > And the memory for the bounce buffer should also be safe to be
> > accessed by userspace in this case.
> >
> > > And what about e.g. interrupts?
> > > E.g. we have this:
> > >
> > >         /* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
> > >         vblk->vdev = NULL;
> > >
> > > and this is no longer true at this point.
> > >
> >
> > You're right. But I didn't see where the interrupt handler will use
> > the vblk->vdev.
>
> static void virtblk_done(struct virtqueue *vq)
> {
>         struct virtio_blk *vblk = vq->vdev->priv;
>
> vq->vdev is the same as vblk->vdev.
>

We will test the vq->ready (will be set to false in del_vqs()) before
injecting an interrupt in the VDUSE driver. So it should be OK?

>
> > So it seems to be not too late to fix it:
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> > b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index 5c25ff6483ad..ea41a7389a26 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -665,13 +665,13 @@ static void vduse_vdpa_set_config(struct
> > vdpa_device *vdpa, unsigned int offset,
> >  static int vduse_vdpa_reset(struct vdpa_device *vdpa)
> >  {
> >         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> > +       int ret;
> >
> > -       if (vduse_dev_set_status(dev, 0))
> > -               return -EIO;
> > +       ret = vduse_dev_set_status(dev, 0);
> >
> >         vduse_dev_reset(dev);
> >
> > -       return 0;
> > +       return ret;
> >  }
> >
> >  static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
> >
> > Thanks,
> > Yongji
>
> Needs some comments to explain why it's done like this.
>

This is used to make sure the userspace can't not inject the interrupt
any more after reset. The vduse_dev_reset() will clear the interrupt
callback and flush the irq kworker.

> BTW device is generally wedged at this point right?
> E.g. if reset during initialization fails, userspace
> will still get the reset at some later point and be
> confused ...
>

Sorry, I don't get why userspace will get the reset at some later point?

Thanks,
Yongji
