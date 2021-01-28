Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F83306CA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 06:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhA1FN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 00:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhA1FNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 00:13:22 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E85C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 21:12:41 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id d2so5163344edz.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 21:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w7bUuFkBOqiFGHoWpYP/8lza5MlN1CX7f/Y5G0iwmRU=;
        b=j2hEU/KWkXGVVH+ch0cS5cyOHjtPOSbDfzGE8B81uihUhUuS3Js5J5C7O7MtepZY1D
         w1n1WJJkcAZTYlbkRtHYfJR/eu4mzpi2Lkg1H3fFSnOBdt39Z9JGnUOg0/svpWfB8bYG
         nAf5m93CN3CcIdGLFoETwqhQapm8zs+8NQmliIlOnyFbnvAtWYnhb+qtw2oHps3jtcHw
         EvYRz7R5Jia+uihrVVv7R3JSQrlTm2zXkGMATauvZ3APpi506fMIgZXoCMarZl4WNSEF
         dAZqCHHIHg1SVyEWrq4X3sKeXTMhLEX5i/ATaZWfr+IfuWRCGs5CemifQk4fKulxAqx0
         cP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w7bUuFkBOqiFGHoWpYP/8lza5MlN1CX7f/Y5G0iwmRU=;
        b=KGBVpK9RPIuFX8mX9gpMF9uwVazJov995wQ+T6sJAO7yhySViDjOjXUpCrlw8d2QlM
         iArxtXLFPsshm4/LogOxc0KZqoA4gJhcmHQk4sZwLWEBODaZXpC+dcmjURHlE+sQy1dT
         kF6LJt4QhXSwX+wOSWbfrrOTGgMIW60t8II3/lQqYzOpNIDu7AweM2tHj+fdRf/wXuw0
         rF818wyxzNEYa0g2HuarMZlIVty7B6yafS6fTqSoGWLmP9fBsPnlrHW2sXkLOndPws5F
         aUsAo/Q2TpNgdTVwSiTxrjIEsxQWLbk0118xPRFbJq/7lzjputyYC59CrdeFoGVjECvk
         KhIw==
X-Gm-Message-State: AOAM530ComtLnZm0Y3eGzsOf9adzYX4ORXoJhUIvs7QBHO+3u22ZUPLS
        j1hvtjd5VbmX2j7uMZWYaxaZ9Semejk2xrk5vTcY
X-Google-Smtp-Source: ABdhPJwr3+ZJm/6huSh5k/rIH9fxlwkVCiX9PiNhFux7J7cGSiziy85qtSbmXbkpsMhQD3vp1/3P++ZTLayN+RnwQSo=
X-Received: by 2002:a05:6402:228a:: with SMTP id cw10mr11831605edb.195.1611810760599;
 Wed, 27 Jan 2021 21:12:40 -0800 (PST)
MIME-Version: 1.0
References: <20210119045920.447-1-xieyongji@bytedance.com> <20210119045920.447-2-xieyongji@bytedance.com>
 <e8a2cc15-80f5-01e0-75ec-ea6281fda0eb@redhat.com> <CACycT3sN0+dg-NubAK+N-DWf3UDXwWh=RyRX-qC9fwdg3QaLWA@mail.gmail.com>
 <6a5f0186-c2e3-4603-9826-50d5c68a3fda@redhat.com> <CACycT3sqDgccOfNcY_FNcHDqJ2DeMbigdFuHYm9DxWWMjkL7CQ@mail.gmail.com>
 <b5c9f2d4-5b95-4552-3886-f5cbcb7de232@redhat.com> <4e482f00-163a-f957-4665-141502cf4dff@kernel.dk>
In-Reply-To: <4e482f00-163a-f957-4665-141502cf4dff@kernel.dk>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 28 Jan 2021 13:12:29 +0800
Message-ID: <CACycT3sdPHCCv9_SpK2xWAsSxrfiRg0Xu0ifrdLusrZuwMOHig@mail.gmail.com>
Subject: Re: Re: [RFC v3 01/11] eventfd: track eventfd_signal() recursion
 depth separately in different cases
To:     Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org, Jonathan Corbet <corbet@lwn.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:08 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/27/21 8:04 PM, Jason Wang wrote:
> >
> > On 2021/1/27 =E4=B8=8B=E5=8D=885:11, Yongji Xie wrote:
> >> On Wed, Jan 27, 2021 at 11:38 AM Jason Wang <jasowang@redhat.com> wrot=
e:
> >>>
> >>> On 2021/1/20 =E4=B8=8B=E5=8D=882:52, Yongji Xie wrote:
> >>>> On Wed, Jan 20, 2021 at 12:24 PM Jason Wang <jasowang@redhat.com> wr=
ote:
> >>>>> On 2021/1/19 =E4=B8=8B=E5=8D=8812:59, Xie Yongji wrote:
> >>>>>> Now we have a global percpu counter to limit the recursion depth
> >>>>>> of eventfd_signal(). This can avoid deadlock or stack overflow.
> >>>>>> But in stack overflow case, it should be OK to increase the
> >>>>>> recursion depth if needed. So we add a percpu counter in eventfd_c=
tx
> >>>>>> to limit the recursion depth for deadlock case. Then it could be
> >>>>>> fine to increase the global percpu counter later.
> >>>>> I wonder whether or not it's worth to introduce percpu for each eve=
ntfd.
> >>>>>
> >>>>> How about simply check if eventfd_signal_count() is greater than 2?
> >>>>>
> >>>> It can't avoid deadlock in this way.
> >>>
> >>> I may miss something but the count is to avoid recursive eventfd call=
.
> >>> So for VDUSE what we suffers is e.g the interrupt injection path:
> >>>
> >>> userspace write IRQFD -> vq->cb() -> another IRQFD.
> >>>
> >>> It looks like increasing EVENTFD_WAKEUP_DEPTH should be sufficient?
> >>>
> >> Actually I mean the deadlock described in commit f0b493e ("io_uring:
> >> prevent potential eventfd recursion on poll"). It can break this bug
> >> fix if we just increase EVENTFD_WAKEUP_DEPTH.
> >
> >
> > Ok, so can wait do something similar in that commit? (using async stuff=
s
> > like wq).
>
> io_uring should be fine in current kernels, but aio would still be
> affected by this. But just in terms of recursion, bumping it one more
> should probably still be fine.
>

OK, I see. It should be easy to avoid the A-A deadlock during coding.

Thanks,
Yongji
