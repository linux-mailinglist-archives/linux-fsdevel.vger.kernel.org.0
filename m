Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193B332E2D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 08:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCEHNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 02:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhCEHNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 02:13:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB22C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 23:13:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hs11so1474682ejc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Mar 2021 23:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k1GfTiPAP3QZiMezcecwZbftT/v+/+G0GQNlw9iF1Ak=;
        b=pmG1VLEtzCTKjfxq4dvRG0atKEQugo8UZglmPbqC81gK/Fr5g+VGvMy/76JrfwSnLK
         07ykIzzTOuFoepQPKk7p6Vj60RBlJY5qtREhe65ZTSPOPXv+H0w2jsT7w5UNGiztkQmd
         g4Q084P94zp8sphtPlgEA/utS/O8oWOpcIf0wPlScxsYpEw1uyCLibdZhxGlMopSPC2z
         oKYKzDN3Q66GasHigeCt/lsKGTEWYksz7jqB8MHG8X17DkgLsJlVJB8hTyLWMVw+YXyb
         Y1c6B2Y8L5ohzyyhTMVcbATDQqRvHZngtO6lKd/sJssMJ1Z+yu81kIuNa39NFTD5lEIe
         wH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k1GfTiPAP3QZiMezcecwZbftT/v+/+G0GQNlw9iF1Ak=;
        b=slec1gaAxXd7Cxylzl66X6oWMq7cZqlbeRR9yoQNAaBf2ViwKRwZ4ZHLMC4+ViD/gB
         TKgG8nEi+QpVEo5iD8IrrWraerfvcGZQL9DdJLqa3HJ65a0u7bZ85+aqh2EwO7IcJne0
         oh5pLMx3MZzJtmUMXwAcdEkhRNJXaOju15XRz0f8jtSVQ+KkUkprmLNt1i563Kky4xxL
         PZGZKleFMOw9HX+UEav3FuacJj0ocTZhzCsMQcDNOlTEUFmupF3N4QhKki5xML5YD6iR
         6RhJRV7EjSOhPqV/CRe4QF8f4tu8jAkRYsSe/wnV3Ltmm3GMIuk7IDwXV7j0hZGwxGEx
         6hgw==
X-Gm-Message-State: AOAM530MfMVdxNXuo9fKw54eMwE9ke8fJXdaQ38dquzbGDd1x1RbNTm9
        MYhAJTewVHBF+J2mZ2Ufm53gM0sQskFm3FbI0D6o
X-Google-Smtp-Source: ABdhPJwOgBKbc0p5luilLmC4G89tHxGpyiaJAx9UN/RKh/4o9Q+xxcmiIznAZfnEymjZhfuQfBa9Zffil+Sryg0rgOA=
X-Received: by 2002:a17:906:311a:: with SMTP id 26mr1076610ejx.395.1614928418569;
 Thu, 04 Mar 2021 23:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20210223115048.435-1-xieyongji@bytedance.com> <20210223115048.435-7-xieyongji@bytedance.com>
 <573ab913-55ce-045a-478f-1200bd78cf7b@redhat.com> <CACycT3sVhDKKu4zGbt1Lw-uWfKDAWs=O=C7kXXcuSnePohmBdQ@mail.gmail.com>
 <c173b7ec-8c90-d0e3-7272-a56aa8935e64@redhat.com> <CACycT3vb=WyrMpiOOdVDGEh8cEDb-xaj1esQx2UEQpJnOOWhmw@mail.gmail.com>
 <4db35f8c-ee3a-90fb-8d14-5d6014b4f6fa@redhat.com>
In-Reply-To: <4db35f8c-ee3a-90fb-8d14-5d6014b4f6fa@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 5 Mar 2021 15:13:27 +0800
Message-ID: <CACycT3sUJNmi2BdLsi3W72+qTKQaCo_nQYu-fdxg9y4pAvBMow@mail.gmail.com>
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

On Fri, Mar 5, 2021 at 2:52 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/3/5 2:15 =E4=B8=8B=E5=8D=88, Yongji Xie wrote:
>
> Sorry if I've asked this before.
>
> But what's the reason for maintaing a dedicated IOTLB here? I think we
> could reuse vduse_dev->iommu since the device can not be used by both
> virtio and vhost in the same time or use vduse_iova_domain->iotlb for
> set_map().
>
> The main difference between domain->iotlb and dev->iotlb is the way to
> deal with bounce buffer. In the domain->iotlb case, bounce buffer
> needs to be mapped each DMA transfer because we need to get the bounce
> pages by an IOVA during DMA unmapping. In the dev->iotlb case, bounce
> buffer only needs to be mapped once during initialization, which will
> be used to tell userspace how to do mmap().
>
> Also, since vhost IOTLB support per mapping token (opauqe), can we use
> that instead of the bounce_pages *?
>
> Sorry, I didn't get you here. Which value do you mean to store in the
> opaque pointer=EF=BC=9F
>
> So I would like to have a way to use a single IOTLB for manage all kinds
> of mappings. Two possible ideas:
>
> 1) map bounce page one by one in vduse_dev_map_page(), in
> VDUSE_IOTLB_GET_FD, try to merge the result if we had the same fd. Then
> for bounce pages, userspace still only need to map it once and we can
> maintain the actual mapping by storing the page or pa in the opaque
> field of IOTLB entry.
>
> Looks like userspace still needs to unmap the old region and map a new
> region (size is changed) with the fd in each VDUSE_IOTLB_GET_FD ioctl.
>
>
> I don't get here. Can you give an example?
>

For example, userspace needs to process two I/O requests (one page per
request). To process the first request, userspace uses
VDUSE_IOTLB_GET_FD ioctl to query the iova region (0 ~ 4096) and mmap
it. To process the second request, userspace uses VDUSE_IOTLB_GET_FD
ioctl to query the new iova region and map a new region (0 ~ 8192).
Then userspace needs to traverse the list of iova regions and unmap
the old region (0 ~ 4096). Looks like this is a little complex.

Thanks,
Yongji
