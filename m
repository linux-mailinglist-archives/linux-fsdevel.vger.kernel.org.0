Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B239556A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhEaG0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 02:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhEaG0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 02:26:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013C5C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 May 2021 23:24:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s6so12132922edu.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 May 2021 23:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0hJJlqD132Gd7EhaPbNawTUnqR5c6+hfcFXnrzFsVn8=;
        b=FKwFOp8ttm3sshCHVWJF3mXce1SkYUyCTdpubyXfVw4Vdxd9zSRbWxl2VbemEftOqC
         4a7bZaFVxg0xV1GjttoXXwCpKmHsflUna4ZBhRLjy6a+ufEt5wSAUNa8yXMPFUAlq2Od
         nt9CTEta328XTYb9lHNHZmIXYFPO95YCqwKlDlhTqlbucuu6u8OtsnDPPUVWzb7wwdZp
         /0Q9S3H8r68Hs0axjzJISSXBu9M1voTx+4FOBRxgctyRanv7C+XJu6kGMKo/DKYptPFi
         ulr6qY2e2i1VKtWopRtIP/SZv5TPurKLn9ugSDMcdmbjNEbv570LIUH+uD/dNYx6rvKl
         Be1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0hJJlqD132Gd7EhaPbNawTUnqR5c6+hfcFXnrzFsVn8=;
        b=p2oD6aC140GL8E5hEjtpn9XihNXEfeoW6y+90dhmhfTWevNTdyf7XOe7N9ZXy+KnEg
         ZheIU9NU/UxcAY9MfKx7Ycf2Wl5vA3w3f8F3ssfwb5qpz+8Q0L4vggxrFaE5U2il/bMB
         cSJEJISw/NyqGmWtZilux/GA9Nlh8MNba99mUj8sAwsNmnJJhCTiVD5Yk1G3DFZfsQLT
         0ngIAIvw3Yva0u2I5ifjKHDcsupTT26wsMyNI1Ey0z3CElP4WDrDwAqRMJInua284/uJ
         2voWP6PcUvsFgtXMpjf0Ml7B0V/duAOToB+lap5N1dg9gaG9jscAF5OaqifaD+wDJCO4
         TUmA==
X-Gm-Message-State: AOAM531XY/3d6iAMLqIEyHpapcEOROWTG+pqM7ASm5S1ibACTAzhWsxn
        raSvnvfqUrquEr5+UyIkVAEWkN+c3mxPaXDpnf9d
X-Google-Smtp-Source: ABdhPJzr9U6IJxkX3CjW6XL3YRmAlPx7Z1RYgpf9NqF6B8TujBwb5JRcKa7caDMlSPK4EFfPI854o9/vK3kdjzVU40o=
X-Received: by 2002:a05:6402:4252:: with SMTP id g18mr23281321edb.195.1622442280586;
 Sun, 30 May 2021 23:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com> <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com> <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com> <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
 <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com> <CACycT3ufok97cKpk47NjUBTc0QAyfauFUyuFvhWKmuqCGJ7zZw@mail.gmail.com>
 <00ded99f-91b6-ba92-5d92-2366b163f129@redhat.com> <CACycT3uK_Fuade-b8FVYkGCKZnne_UGGbYRFwv7WOH2oKCsXSg@mail.gmail.com>
 <f20edd55-20cb-c016-b347-dd71c5406ed8@redhat.com> <CACycT3tLj6a7-tbqO9SzCLStwYrOALdkfnt1jxQBv3s0VzD6AQ@mail.gmail.com>
 <ea9fd2d2-870f-c4e2-d7a5-af759985c462@redhat.com>
In-Reply-To: <ea9fd2d2-870f-c4e2-d7a5-af759985c462@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 31 May 2021 14:24:29 +0800
Message-ID: <CACycT3ucaY-QYq14BHf5oqLjQ0Nc9ZTQ0DA0ATu8=-KkaU5b3Q@mail.gmail.com>
Subject: Re: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 31, 2021 at 12:39 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/5/31 =E4=B8=8B=E5=8D=8812:27, Yongji Xie =E5=86=99=E9=81=
=93:
> > On Fri, May 28, 2021 at 10:31 AM Jason Wang <jasowang@redhat.com> wrote=
:
> >>
> >> =E5=9C=A8 2021/5/27 =E4=B8=8B=E5=8D=889:17, Yongji Xie =E5=86=99=E9=81=
=93:
> >>> On Thu, May 27, 2021 at 4:41 PM Jason Wang <jasowang@redhat.com> wrot=
e:
> >>>> =E5=9C=A8 2021/5/27 =E4=B8=8B=E5=8D=883:34, Yongji Xie =E5=86=99=E9=
=81=93:
> >>>>> On Thu, May 27, 2021 at 1:40 PM Jason Wang <jasowang@redhat.com> wr=
ote:
> >>>>>> =E5=9C=A8 2021/5/27 =E4=B8=8B=E5=8D=881:08, Yongji Xie =E5=86=99=
=E9=81=93:
> >>>>>>> On Thu, May 27, 2021 at 1:00 PM Jason Wang <jasowang@redhat.com> =
wrote:
> >>>>>>>> =E5=9C=A8 2021/5/27 =E4=B8=8B=E5=8D=8812:57, Yongji Xie =E5=86=
=99=E9=81=93:
> >>>>>>>>> On Thu, May 27, 2021 at 12:13 PM Jason Wang <jasowang@redhat.co=
m> wrote:
> >>>>>>>>>> =E5=9C=A8 2021/5/17 =E4=B8=8B=E5=8D=885:55, Xie Yongji =E5=86=
=99=E9=81=93:
> >>>>>>>>>>> +
> >>>>>>>>>>> +static int vduse_dev_msg_sync(struct vduse_dev *dev,
> >>>>>>>>>>> +                           struct vduse_dev_msg *msg)
> >>>>>>>>>>> +{
> >>>>>>>>>>> +     init_waitqueue_head(&msg->waitq);
> >>>>>>>>>>> +     spin_lock(&dev->msg_lock);
> >>>>>>>>>>> +     vduse_enqueue_msg(&dev->send_list, msg);
> >>>>>>>>>>> +     wake_up(&dev->waitq);
> >>>>>>>>>>> +     spin_unlock(&dev->msg_lock);
> >>>>>>>>>>> +     wait_event_killable(msg->waitq, msg->completed);
> >>>>>>>>>> What happens if the userspace(malicous) doesn't give a respons=
e forever?
> >>>>>>>>>>
> >>>>>>>>>> It looks like a DOS. If yes, we need to consider a way to fix =
that.
> >>>>>>>>>>
> >>>>>>>>> How about using wait_event_killable_timeout() instead?
> >>>>>>>> Probably, and then we need choose a suitable timeout and more im=
portant,
> >>>>>>>> need to report the failure to virtio.
> >>>>>>>>
> >>>>>>> Makes sense to me. But it looks like some
> >>>>>>> vdpa_config_ops/virtio_config_ops such as set_status() didn't hav=
e a
> >>>>>>> return value.  Now I add a WARN_ON() for the failure. Do you mean=
 we
> >>>>>>> need to add some change for virtio core to handle the failure?
> >>>>>> Maybe, but I'm not sure how hard we can do that.
> >>>>>>
> >>>>> We need to change all virtio device drivers in this way.
> >>>> Probably.
> >>>>
> >>>>
> >>>>>> We had NEEDS_RESET but it looks we don't implement it.
> >>>>>>
> >>>>> Could it handle the failure of get_feature() and get/set_config()?
> >>>> Looks not:
> >>>>
> >>>> "
> >>>>
> >>>> The device SHOULD set DEVICE_NEEDS_RESET when it enters an error sta=
te
> >>>> that a reset is needed. If DRIVER_OK is set, after it sets
> >>>> DEVICE_NEEDS_RESET, the device MUST send a device configuration chan=
ge
> >>>> notification to the driver.
> >>>>
> >>>> "
> >>>>
> >>>> This looks implies that NEEDS_RESET may only work after device is
> >>>> probed. But in the current design, even the reset() is not reliable.
> >>>>
> >>>>
> >>>>>> Or a rough idea is that maybe need some relaxing to be coupled loo=
sely
> >>>>>> with userspace. E.g the device (control path) is implemented in th=
e
> >>>>>> kernel but the datapath is implemented in the userspace like TUN/T=
AP.
> >>>>>>
> >>>>> I think it can work for most cases. One problem is that the set_con=
fig
> >>>>> might change the behavior of the data path at runtime, e.g.
> >>>>> virtnet_set_mac_address() in the virtio-net driver and
> >>>>> cache_type_store() in the virtio-blk driver. Not sure if this path =
is
> >>>>> able to return before the datapath is aware of this change.
> >>>> Good point.
> >>>>
> >>>> But set_config() should be rare:
> >>>>
> >>>> E.g in the case of virtio-net with VERSION_1, config space is read o=
nly,
> >>>> and it was set via control vq.
> >>>>
> >>>> For block, we can
> >>>>
> >>>> 1) start from without WCE or
> >>>> 2) we add a config change notification to userspace or
> >>> I prefer this way. And I think we also need to do similar things for
> >>> set/get_vq_state().
> >>
> >> Yes, I agree.
> >>
> > Hi Jason,
> >
> > Now I'm working on this. But I found the config change notification
> > must be synchronous in the virtio-blk case, which means the kernel
> > still needs to wait for the response from userspace in set_config().
> > Otherwise, some I/Os might still run the old way after we change the
> > cache_type in sysfs.
> >
> > The simple ways to solve this problem are:
> >
> > 1. Only support read-only config space, disable WCE as you suggested
> > 2. Add a return value to set_config() and handle the failure only in
> > virtio-blk driver
> > 3. Print some warnings after timeout since it only affects the
> > dataplane which is under userspace's control
> >
> > Any suggestions?
>
>
> Let's go without WCE first and make VDUSE work first. We can then think
> of a solution for WCE on top.
>

It's fine with me.

Thanks,
Yongji
