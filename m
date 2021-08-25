Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A9C3F6EDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 07:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhHYFiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 01:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhHYFiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:38:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DC4C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 22:37:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id q3so35203700edt.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 22:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yeuD/AKt6duI6f+LLwvmXj5/7qzqoMz+rmo5sVDYrk=;
        b=Vp7EsjbsKk4CbMZuzoUYLzrpydiTBr1zHF+HyG9J/wtoW8bsVHI746U+1hvWAKn7pY
         S2KGD1hdXhYpvRVmdQ6WR1fQxGII47CoeOMGBaYQ/Mi4TolUM5hV7u25ftgsXF0RWGh/
         oyRF1xadCZb6aP6wOK20F7wxGFstAZ7BuyRbsRE+aDrQ7ch+4LllkUaJdROcaj8x+KAj
         ZOy85WB4jyz34slTJHHU6QuKku6j+KC19AfzueBsMNFAdKQmlECIKMC6wJ+DZ7prxUj4
         ddL12p3dIBF+Z7rYjgciVlV8upMbYsRSCOxkj2pFlsJcMFqU9/31/TAQO6ln7+ZPJcon
         AYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yeuD/AKt6duI6f+LLwvmXj5/7qzqoMz+rmo5sVDYrk=;
        b=Lfu0ElG0/kba+FJEAIYHOOiUhs2h3dFwfhS0hmvsRqnwDLybOgqetO/mdDE8eyHxyJ
         aXJxplIIZU+vETuX3664WIGyqDqgXSFvXVrCQZUoOBGhq296YIvGiHLr2ZSiyCeYfhsA
         4PoRF3yuWIZ3dmHk53HyhEQDrbXYKip5wEWmclsx/uFVWk5TO4ZhkfLxxjZAewj7GLG7
         B3JmrkgAh5wzQOg+7zTvJzt8e/LD8FPcIEXutSWUa7DXViY/rY6uvt8NWxrE6z+rVDvb
         5GP9cp42L65rJRAzLtrYnfvUPjVEMc6iRvdqzlnxWMOhLuSjZ4N95L/QF1WIWv8Q+RUr
         z6PQ==
X-Gm-Message-State: AOAM533Qbh15pn304cBg2EfM6WRtpmG1Kxs8OIL5MCt/lAGBW2/g9q9U
        YXTgepcIGFQJsllIoNz/DM0jwF0nHEQ19OeBZj3B
X-Google-Smtp-Source: ABdhPJyZTxYAJpwJ1zytuFP4isC6BozsaW7fwdKwUj6HuqFf6QhFlF2KyJtLZvCBCv/uMpGPvMvKn/tLFmS1aI89w14=
X-Received: by 2002:a50:fd86:: with SMTP id o6mr6104183edt.312.1629869841320;
 Tue, 24 Aug 2021 22:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210818120642.165-1-xieyongji@bytedance.com> <20210818120642.165-12-xieyongji@bytedance.com>
 <20210824140945-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210824140945-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 25 Aug 2021 13:37:10 +0800
Message-ID: <CACycT3s0Pp+LOD2h_vocPUMEqMhYioJmRPFYGL=Su-eL2p2O3w@mail.gmail.com>
Subject: Re: [PATCH v11 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
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
        Robin Murphy <robin.murphy@arm.com>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 25, 2021 at 2:10 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Aug 18, 2021 at 08:06:41PM +0800, Xie Yongji wrote:
> > This VDUSE driver enables implementing software-emulated vDPA
> > devices in userspace. The vDPA device is created by
> > ioctl(VDUSE_CREATE_DEV) on /dev/vduse/control. Then a char device
> > interface (/dev/vduse/$NAME) is exported to userspace for device
> > emulation.
> >
> > In order to make the device emulation more secure, the device's
> > control path is handled in kernel. A message mechnism is introduced
> > to forward some dataplane related control messages to userspace.
> >
> > And in the data path, the DMA buffer will be mapped into userspace
> > address space through different ways depending on the vDPA bus to
> > which the vDPA device is attached. In virtio-vdpa case, the MMU-based
> > software IOTLB is used to achieve that. And in vhost-vdpa case, the
> > DMA buffer is reside in a userspace memory region which can be shared
> > to the VDUSE userspace processs via transferring the shmfd.
> >
> > For more details on VDUSE design and usage, please see the follow-on
> > Documentation commit.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
> Build bot seems unhappy with this patch.
>

Yes, this is because the series relies on the unmerged patch:

https://lore.kernel.org/lkml/20210705071910.31965-1-jasowang@redhat.com/

Do I need to remove this dependency in the next version?

Thanks,
Yongji
