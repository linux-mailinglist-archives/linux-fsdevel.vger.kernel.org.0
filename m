Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21D83308A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 08:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhCHHJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 02:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCHHI7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:08:59 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E62C06175F
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Mar 2021 23:08:58 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lr13so18120834ejb.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Mar 2021 23:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jg9JCtFPk8LTcFKoLUjntv/IHAXfla9oZY8ieho81DI=;
        b=yP18pRe640+Ha021yb77DdyFJ8YpC7Lw87+oFVslfg5dKJH0PDDTT/zTAI1/93SM1J
         B39JlICd9dOYipufEBxYSh12n9VnBtVUU+M7eBQEPnzYAqkAfeZj/GK9zztaTLICWh0U
         eOrMffW7JFtQOA0B6H/zkcTDGkvGAVTBagAatqRN2PbJq9184p/zpyLAwE7d6FWzCFD4
         DJCxT6zrFiHzgPOO8yfK8ZJOK6aUWlD/8/0KZ90CIG251WlR7gszuAGNox4QyBYiw/eF
         m66rkLqUbipugSQueclGdEcwYJ3j7PQ9nF1Z/YfClT1a+LWOojRvurhmchHOYBc91cNm
         j27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jg9JCtFPk8LTcFKoLUjntv/IHAXfla9oZY8ieho81DI=;
        b=J33q8j8B2N2AwTlH7qj7rqpvgF9jfFbRKxb3czFEsEjozdJeMYtw6v6u+2yvmp8Gjn
         vegRnO9yzva00Hh66JrGyaD3X6i9Y4dthpP6HdhgGsoo6/piLuaTpnlbw0RCZ0qm3z9s
         1bFyYJRJuB9pHIBgeWQszWkuxDYArZ0ulBqaV23U4Rdt/ZvHl5KT9USN9lcanU9cF45P
         xtn+c21N4rUzpUwkSfV/tcQsZo/cGo6dPxgJKpZbhCe9ZPbZ1v/LMuQog3vbkK84Ej+y
         PnWNdPI9AkJRdhG4q13/ee9w8zQfXqTC4mVkKa+xj8ZcvG8MX+6je5gUFa9q45vEGeiB
         MZUA==
X-Gm-Message-State: AOAM532OQnulfYLxyx33wn8n7KkE9SpIH9FawGvQQu7I4E+XRbr00YQl
        07l57nZkfJlGtgMzTtVBz1R2hdFOxE9sKOkxXgR4
X-Google-Smtp-Source: ABdhPJxporhAFiyZx0kychbSwmpepgFGJlXjqUDAnKzrAzmIC/579hB2tN6tndkjlicQc5PsTqef257IaOYOCS2SDbs=
X-Received: by 2002:a17:906:311a:: with SMTP id 26mr13678563ejx.395.1615187337315;
 Sun, 07 Mar 2021 23:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20210223115048.435-1-xieyongji@bytedance.com> <20210223115048.435-7-xieyongji@bytedance.com>
 <573ab913-55ce-045a-478f-1200bd78cf7b@redhat.com> <CACycT3sVhDKKu4zGbt1Lw-uWfKDAWs=O=C7kXXcuSnePohmBdQ@mail.gmail.com>
 <c173b7ec-8c90-d0e3-7272-a56aa8935e64@redhat.com> <CACycT3vb=WyrMpiOOdVDGEh8cEDb-xaj1esQx2UEQpJnOOWhmw@mail.gmail.com>
 <4db35f8c-ee3a-90fb-8d14-5d6014b4f6fa@redhat.com> <CACycT3sUJNmi2BdLsi3W72+qTKQaCo_nQYu-fdxg9y4pAvBMow@mail.gmail.com>
 <2652f696-faf7-26eb-a8b2-c4cfe3aaed15@redhat.com> <CACycT3uMV9wg5yVKmEJpbZrs3x0b4+b9eNcUTh3+CjxsG7x2LA@mail.gmail.com>
 <d4681614-bd1e-8fe7-3b03-72eb2011c3c2@redhat.com> <CACycT3uA5y=jcKPwu6rZ83Lqf1ytuPhnxWLCeMpDYrvRodHFVg@mail.gmail.com>
 <0b671aef-f2b2-6162-f407-7ca5178dbebb@redhat.com> <CACycT3tnd0SziHVpH=yUZFYpeG3c0V+vcGRNT19cp0q9b1GH2Q@mail.gmail.com>
 <48d0a363-4f55-bf99-3653-315458643317@redhat.com>
In-Reply-To: <48d0a363-4f55-bf99-3653-315458643317@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 8 Mar 2021 15:08:46 +0800
Message-ID: <CACycT3v8GXBT0sChJ-k=89FeUnP7-U2ksJyLMHEng2xn97f3dw@mail.gmail.com>
Subject: Re: Re: [RFC v4 06/11] vduse: Implement an MMU-based IOMMU driver
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

On Mon, Mar 8, 2021 at 3:04 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/3/8 1:05 =E4=B8=8B=E5=8D=88, Yongji Xie wrote:
> > On Mon, Mar 8, 2021 at 11:52 AM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> On 2021/3/8 11:45 =E4=B8=8A=E5=8D=88, Yongji Xie wrote:
> >>> On Mon, Mar 8, 2021 at 11:17 AM Jason Wang <jasowang@redhat.com> wrot=
e:
> >>>> On 2021/3/5 3:59 =E4=B8=8B=E5=8D=88, Yongji Xie wrote:
> >>>>> On Fri, Mar 5, 2021 at 3:27 PM Jason Wang <jasowang@redhat.com> wro=
te:
> >>>>>> On 2021/3/5 3:13 =E4=B8=8B=E5=8D=88, Yongji Xie wrote:
> >>>>>>> On Fri, Mar 5, 2021 at 2:52 PM Jason Wang <jasowang@redhat.com> w=
rote:
> >>>>>>>> On 2021/3/5 2:15 =E4=B8=8B=E5=8D=88, Yongji Xie wrote:
> >>>>>>>>
> >>>>>>>> Sorry if I've asked this before.
> >>>>>>>>
> >>>>>>>> But what's the reason for maintaing a dedicated IOTLB here? I th=
ink we
> >>>>>>>> could reuse vduse_dev->iommu since the device can not be used by=
 both
> >>>>>>>> virtio and vhost in the same time or use vduse_iova_domain->iotl=
b for
> >>>>>>>> set_map().
> >>>>>>>>
> >>>>>>>> The main difference between domain->iotlb and dev->iotlb is the =
way to
> >>>>>>>> deal with bounce buffer. In the domain->iotlb case, bounce buffe=
r
> >>>>>>>> needs to be mapped each DMA transfer because we need to get the =
bounce
> >>>>>>>> pages by an IOVA during DMA unmapping. In the dev->iotlb case, b=
ounce
> >>>>>>>> buffer only needs to be mapped once during initialization, which=
 will
> >>>>>>>> be used to tell userspace how to do mmap().
> >>>>>>>>
> >>>>>>>> Also, since vhost IOTLB support per mapping token (opauqe), can =
we use
> >>>>>>>> that instead of the bounce_pages *?
> >>>>>>>>
> >>>>>>>> Sorry, I didn't get you here. Which value do you mean to store i=
n the
> >>>>>>>> opaque pointer=EF=BC=9F
> >>>>>>>>
> >>>>>>>> So I would like to have a way to use a single IOTLB for manage a=
ll kinds
> >>>>>>>> of mappings. Two possible ideas:
> >>>>>>>>
> >>>>>>>> 1) map bounce page one by one in vduse_dev_map_page(), in
> >>>>>>>> VDUSE_IOTLB_GET_FD, try to merge the result if we had the same f=
d. Then
> >>>>>>>> for bounce pages, userspace still only need to map it once and w=
e can
> >>>>>>>> maintain the actual mapping by storing the page or pa in the opa=
que
> >>>>>>>> field of IOTLB entry.
> >>>>>>>>
> >>>>>>>> Looks like userspace still needs to unmap the old region and map=
 a new
> >>>>>>>> region (size is changed) with the fd in each VDUSE_IOTLB_GET_FD =
ioctl.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> I don't get here. Can you give an example?
> >>>>>>>>
> >>>>>>> For example, userspace needs to process two I/O requests (one pag=
e per
> >>>>>>> request). To process the first request, userspace uses
> >>>>>>> VDUSE_IOTLB_GET_FD ioctl to query the iova region (0 ~ 4096) and =
mmap
> >>>>>>> it.
> >>>>>> I think in this case we should let VDUSE_IOTLB_GET_FD return the m=
aximum
> >>>>>> range as far as they are backed by the same fd.
> >>>>>>
> >>>>> But now the bounce page is mapped one by one. The second page (4096=
 ~
> >>>>> 8192) might not be mapped when userspace is processing the first
> >>>>> request. So the maximum range is 0 ~ 4096 at that time.
> >>>>>
> >>>>> Thanks,
> >>>>> Yongji
> >>>> A question, if I read the code correctly, VDUSE_IOTLB_GET_FD will re=
turn
> >>>> the whole bounce map range which is setup in vduse_dev_map_page()? S=
o my
> >>>> understanding is that usersapce may choose to map all its range via =
mmap().
> >>>>
> >>> Yes.
> >>>
> >>>> So if we 'map' bounce page one by one in vduse_dev_map_page(). (Here
> >>>> 'map' means using multiple itree entries instead of a single one). T=
hen
> >>>> in the VDUSE_IOTLB_GET_FD we can keep traversing itree (dev->iommu)
> >>>> until the range is backed by a different file.
> >>>>
> >>>> With this, there's no userspace visible changes and there's no need =
for
> >>>> the domain->iotlb?
> >>>>
> >>> In this case, I wonder what range can be obtained if userspace calls
> >>> VDUSE_IOTLB_GET_FD when the first I/O (e.g. 4K) occurs. [0, 4K] or [0=
,
> >>> 64M]? In current implementation, userspace will map [0, 64M].
> >>
> >> It should still be [0, 64M). Do you see any issue?
> >>
> > Does it mean we still need to map the whole bounce buffer into itree
> > (dev->iommu) at initialization?
>
>
> It's your choice I think, the point is to use a single IOTLB for
> maintaining mappings of all types of pages (bounce, coherent, or shared).
>

OK, got it.

Thanks,
Yongji
