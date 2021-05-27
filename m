Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A323926C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 07:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhE0FKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 01:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbhE0FKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 01:10:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3BEC061760
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 22:08:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t15so4185116edr.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 22:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OSXVSdir/DQunBxCaZTpvHNoZRd/zQTm4r2dtcDMWtM=;
        b=Vvbum0ssCd8+XnEyC968VOahIXXgmU4IKNsN1jaAy3Xi/Zyluk86fXwOUkXVv5q7x/
         ozlOvBIfzB1Q0EnDWElPBUftNOhIElGXoPronS67+OqjMPJRl5M5HthQ16NOU+QVXTGl
         d06nj18jqbGi2FvwgruGJ5TDg5/5zzS4OhkjCOMPT0BW+QvZJONn/jHhKOjEitB/g9un
         uZ4zKJUR2lpgON/Vp7ZjI079lUM8BeSNTciJ42C49qtM/axt9XR+CcVSZ0458FatAO0r
         rAWLRS7Md7dgEprNMklW4zdtk0vbgfXqf5n3KcD2/HLY5Qk7sOX9RIcXkfOmt4k6eLvn
         ntFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OSXVSdir/DQunBxCaZTpvHNoZRd/zQTm4r2dtcDMWtM=;
        b=HMd9l2+bXxCLWjVSyeWOJYifkN1kxSak/CEThdlghkvCuo3gqU5F5ph9CBAjoNiOz/
         gIl0BFqd02HSGCuas/NM44se69Z7wzrKT6H7rRMbh7M7q3/a3hLB2PDrqv2dFIRdReSd
         UPCwEtDvSYcEBle7AJsqLmYvIJ4h5qTwA9DLN4ojQlsZtpFw+hPsathrnQqJegJlCTq8
         BPsekiK2Mi7ncBtqGnu98EGi27fnlJj9Hqebnod6WJiKYT2LxHYZ1gOyicjk1odaq0q3
         fgeUuFbsfCqZ6lUxNrKhZq8ZUPdeDUVcUaZQZQg6b1dW0ZHGGDH6XB9XbgZSj+UFca91
         KYRQ==
X-Gm-Message-State: AOAM532nsL02VofHkvnC2log1NB4IkhNhVSXaz7loHvVbCGBlskm+ejA
        l2TMWFEQJw2ByngtoeYhuNEALc+mQrPa6V6FhTSW
X-Google-Smtp-Source: ABdhPJytcepFP+t2llkhnOjy77FXDbUbzl/ELg4KeaSs2pPDgpTzNqnNIXgN4Trhj3Sx1RCi2B01qTSVklc5dH0EiY8=
X-Received: by 2002:a05:6402:22fa:: with SMTP id dn26mr2005986edb.5.1622092123094;
 Wed, 26 May 2021 22:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com> <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com> <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
In-Reply-To: <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 27 May 2021 13:08:32 +0800
Message-ID: <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
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

On Thu, May 27, 2021 at 1:00 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/5/27 =E4=B8=8B=E5=8D=8812:57, Yongji Xie =E5=86=99=E9=81=
=93:
> > On Thu, May 27, 2021 at 12:13 PM Jason Wang <jasowang@redhat.com> wrote=
:
> >>
> >> =E5=9C=A8 2021/5/17 =E4=B8=8B=E5=8D=885:55, Xie Yongji =E5=86=99=E9=81=
=93:
> >>> +
> >>> +static int vduse_dev_msg_sync(struct vduse_dev *dev,
> >>> +                           struct vduse_dev_msg *msg)
> >>> +{
> >>> +     init_waitqueue_head(&msg->waitq);
> >>> +     spin_lock(&dev->msg_lock);
> >>> +     vduse_enqueue_msg(&dev->send_list, msg);
> >>> +     wake_up(&dev->waitq);
> >>> +     spin_unlock(&dev->msg_lock);
> >>> +     wait_event_killable(msg->waitq, msg->completed);
> >>
> >> What happens if the userspace(malicous) doesn't give a response foreve=
r?
> >>
> >> It looks like a DOS. If yes, we need to consider a way to fix that.
> >>
> > How about using wait_event_killable_timeout() instead?
>
>
> Probably, and then we need choose a suitable timeout and more important,
> need to report the failure to virtio.
>

Makes sense to me. But it looks like some
vdpa_config_ops/virtio_config_ops such as set_status() didn't have a
return value.  Now I add a WARN_ON() for the failure. Do you mean we
need to add some change for virtio core to handle the failure?

Thanks,
Yongji
