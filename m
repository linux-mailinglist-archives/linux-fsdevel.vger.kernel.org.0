Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4804A306D70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 07:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhA1GJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 01:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhA1GJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 01:09:50 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BD5C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 22:09:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id rv9so6009506ejb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 22:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NXx/P5FvUFVwAVEpEYoOu8rkcAlVKobDmGNLoF5KiOU=;
        b=jIBTPPGalLdY3HXcOP+rfjSY5WznmUO79VKsxCm0y1wmSWpTvm6KvOYqgqefWMxF8X
         AcWL0X5iYkozog2GDDKRyiWhGyK5eSVbCNzsK6o0M7W10Gjhw+8vZcl4Vn8Q4myta4of
         TDg+ijaxGWaASsOuNjJV9AlF8EO6ixnaYbKUo9ZiQ0yAmWe1vFViJWwRkV16488g/4YW
         lPoRUWRuYpc8QiZTyUiXCttDixCM3+s7KAIkArNW5ZFOS1f5n7wf/Rh7Llw4GiCYBejV
         J1LTqSXZ9MqLHNqudhDU7PPK9l0uAzMO/BR2bBOQjs1GvZYgo7oOFUgqB+JNrgMI3K7J
         fO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NXx/P5FvUFVwAVEpEYoOu8rkcAlVKobDmGNLoF5KiOU=;
        b=KWBw8WNGIL6/ucYEi4ngCTsgE4W9cJzHz7xE727X11lXibDotuO5IceeawgVFyQFkq
         O/+izN5+YQ0EaEYpgCr0Et1BlDdjpBMf81hFoND9wmvBixSi7AEFznOcKf7dFiEnoaJ4
         lpqHrmklP8q5IO7TCj3ZAVKFYPtJItZp0IhvZrMeVe2ERVA5PgixuMXn+BRZK8yOhspn
         6lktF7p5UM1IE2DQrcfGWlsgKdL2amYKh+gIV1fqmbTs7RZf4ZcaO9oOWgoMiRRetoyi
         dwzj5YFaNqZgs5TEj5lzJW8gVnjJAM1JQ91VLBgwUhNrUxCf82IJQg+gF5BCewjD70JB
         brrw==
X-Gm-Message-State: AOAM531d/3sOIXFdNXWYjjNiKa4sHbEq07XUjJ/hvfCUxox8iBV3fvJJ
        EEFqXzlWMOWndCxq9IToTBvyL51BHGeVWh3Q0wET
X-Google-Smtp-Source: ABdhPJwRLxibLx2jLqCot26i8quCjBcjfUCZIgtFqFpvohK4E372M12RGU/B+JzdoSjdhG8E5eqP5h50me1mUxqp9A4=
X-Received: by 2002:a17:906:5795:: with SMTP id k21mr2096988ejq.174.1611814149063;
 Wed, 27 Jan 2021 22:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20210119045920.447-1-xieyongji@bytedance.com> <20210119045920.447-2-xieyongji@bytedance.com>
 <e8a2cc15-80f5-01e0-75ec-ea6281fda0eb@redhat.com> <CACycT3sN0+dg-NubAK+N-DWf3UDXwWh=RyRX-qC9fwdg3QaLWA@mail.gmail.com>
 <6a5f0186-c2e3-4603-9826-50d5c68a3fda@redhat.com> <CACycT3sqDgccOfNcY_FNcHDqJ2DeMbigdFuHYm9DxWWMjkL7CQ@mail.gmail.com>
 <b5c9f2d4-5b95-4552-3886-f5cbcb7de232@redhat.com> <CACycT3u6Ayf_X8Mv4EvF+B=B4OzFSK8ygvJMRnO6CDgYF13Qnw@mail.gmail.com>
 <9226c594-e045-544d-4e46-c4c3c9c573a9@redhat.com>
In-Reply-To: <9226c594-e045-544d-4e46-c4c3c9c573a9@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 28 Jan 2021 14:08:58 +0800
Message-ID: <CACycT3ukfPjnD+o0_xkq9Y9cwDxQUj1dmuuwuVdQvKywjQhRjA@mail.gmail.com>
Subject: Re: Re: [RFC v3 01/11] eventfd: track eventfd_signal() recursion
 depth separately in different cases
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 12:31 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/1/28 =E4=B8=8A=E5=8D=8811:52, Yongji Xie wrote:
> > On Thu, Jan 28, 2021 at 11:05 AM Jason Wang <jasowang@redhat.com> wrote=
:
> >>
> >> On 2021/1/27 =E4=B8=8B=E5=8D=885:11, Yongji Xie wrote:
> >>> On Wed, Jan 27, 2021 at 11:38 AM Jason Wang <jasowang@redhat.com> wro=
te:
> >>>> On 2021/1/20 =E4=B8=8B=E5=8D=882:52, Yongji Xie wrote:
> >>>>> On Wed, Jan 20, 2021 at 12:24 PM Jason Wang <jasowang@redhat.com> w=
rote:
> >>>>>> On 2021/1/19 =E4=B8=8B=E5=8D=8812:59, Xie Yongji wrote:
> >>>>>>> Now we have a global percpu counter to limit the recursion depth
> >>>>>>> of eventfd_signal(). This can avoid deadlock or stack overflow.
> >>>>>>> But in stack overflow case, it should be OK to increase the
> >>>>>>> recursion depth if needed. So we add a percpu counter in eventfd_=
ctx
> >>>>>>> to limit the recursion depth for deadlock case. Then it could be
> >>>>>>> fine to increase the global percpu counter later.
> >>>>>> I wonder whether or not it's worth to introduce percpu for each ev=
entfd.
> >>>>>>
> >>>>>> How about simply check if eventfd_signal_count() is greater than 2=
?
> >>>>>>
> >>>>> It can't avoid deadlock in this way.
> >>>> I may miss something but the count is to avoid recursive eventfd cal=
l.
> >>>> So for VDUSE what we suffers is e.g the interrupt injection path:
> >>>>
> >>>> userspace write IRQFD -> vq->cb() -> another IRQFD.
> >>>>
> >>>> It looks like increasing EVENTFD_WAKEUP_DEPTH should be sufficient?
> >>>>
> >>> Actually I mean the deadlock described in commit f0b493e ("io_uring:
> >>> prevent potential eventfd recursion on poll"). It can break this bug
> >>> fix if we just increase EVENTFD_WAKEUP_DEPTH.
> >>
> >> Ok, so can wait do something similar in that commit? (using async stuf=
fs
> >> like wq).
> >>
> > We can do that. But it will reduce the performance. Because the
> > eventfd recursion will be triggered every time kvm kick eventfd in
> > vhost-vdpa cases:
> >
> > KVM write KICKFD -> ops->kick_vq -> VDUSE write KICKFD
> >
> > Thanks,
> > Yongji
>
>
> Right, I think in the future we need to find a way to let KVM to wakeup
> VDUSE directly.
>

Yes, this would be better.

Thanks,
Yongji
