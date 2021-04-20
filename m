Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1636544B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 10:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhDTIjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 04:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhDTIjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:39:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA87C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 01:39:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sd23so48366647ejb.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 01:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QIuUvofPDIxQ2Xnl6piPnzkNIqnBx7iSqqUtBV1i2j0=;
        b=Xnd6JnKSx5ncA48VE+FTvvtirGFWCchXMRV4SfEqivGWhjUvPdOZyS7rzr3hRLISKc
         weIsohPM6Wg51S1mW+tn3cfIa2s8u8yB9vUogpu+6KQmBSUbWT+KvqgBI6cu2VXCdsiO
         sotdRA0g5M5McqiCGqhvdJ7x/IDU+n1iO9xsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=QIuUvofPDIxQ2Xnl6piPnzkNIqnBx7iSqqUtBV1i2j0=;
        b=IQ/tnHLZmTVmj7DNZmvBMJbraSY0y6ZD2x9+cqp/y9FxjWUdLhPaClgNSHBgSIOypn
         7tQ+H3UPNyoy+GfUQpzZmpqt4v2CLMbd9VV010TbZoaU/YoLHnL11KPqKyZ+z2b8Q6qn
         vjHkshivr/gEt0bLmMbiVxFvKoLcDkQ9WQzT3oOxZacA2EhLaKJPTeLmRsVDzzQgl8Cs
         KlgFXcBnDylB/bpCgMYiDf1PDcSHJ6/1z8UWUhyt0bR4mG5bjW/2iz/k+zIAbsEILJxg
         uQBDGhzXwxPpsZ17brgPJn72EhRiEQLOABQp+2BvIkDKGZm8gJJEUjedPaqxxkJPlEiN
         drbw==
X-Gm-Message-State: AOAM532fJJsjLgCIS7DTkrcD8Gr/+oxpITxgoP4JPVj7+3ZQpJQyDmH6
        e6NZaeU0h5pttwQIaml4G7u2ug==
X-Google-Smtp-Source: ABdhPJzKnx+yvsmmawjlL/WEDsrn4hsPU7R8EEIXmiKkO0qNGO+CRRMLxdwpSEpKHtNvyrET6RvyuA==
X-Received: by 2002:a17:906:f949:: with SMTP id ld9mr26715530ejb.236.1618907948397;
        Tue, 20 Apr 2021 01:39:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d5sm10345824edt.49.2021.04.20.01.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 01:39:07 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:39:05 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Peter.Enderborg@sony.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sumit.semwal@linaro.org,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        mhocko@suse.com, neilb@suse.de, samitolvanen@google.com,
        rppt@kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        willy@infradead.org
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <YH6TKQQ9kAEIrJ3y@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Peter.Enderborg@sony.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sumit.semwal@linaro.org,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        mhocko@suse.com, neilb@suse.de, samitolvanen@google.com,
        rppt@kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        willy@infradead.org
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <d983aef9-3dde-54cc-59a0-d9d42130b513@amd.com>
 <d822adcc-2a3c-1923-0d1d-4ecabd76a0e5@sony.com>
 <2420ea7a-4746-b11a-3c0e-2f962059d071@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2420ea7a-4746-b11a-3c0e-2f962059d071@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 17, 2021 at 01:54:08PM +0200, Christian König wrote:
> Am 17.04.21 um 13:20 schrieb Peter.Enderborg@sony.com:
> > On 4/17/21 12:59 PM, Christian König wrote:
> > > Am 17.04.21 um 12:40 schrieb Peter Enderborg:
> > > > This adds a total used dma-buf memory. Details
> > > > can be found in debugfs, however it is not for everyone
> > > > and not always available. dma-buf are indirect allocated by
> > > > userspace. So with this value we can monitor and detect
> > > > userspace applications that have problems.
> > > > 
> > > > Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> > > Reviewed-by: Christian König <christian.koenig@amd.com>
> > > 
> > > How do you want to upstream this?
> > I don't understand that question. The patch applies on Torvalds 5.12-rc7,
> > but I guess 5.13 is what we work on right now.
> 
> Yeah, but how do you want to get it into Linus tree?
> 
> I can push it together with other DMA-buf patches through drm-misc-next and
> then Dave will send it to Linus for inclusion in 5.13.

Small correction, we've already frozen for the merge window so this will
land in 5.14.
-Daniel

> 
> But could be that you are pushing multiple changes towards Linus through
> some other branch. In this case I'm fine if you pick that way instead if you
> want to keep your patches together for some reason.
> 
> Christian.
> 
> > 
> > > > ---
> > > >    drivers/dma-buf/dma-buf.c | 13 +++++++++++++
> > > >    fs/proc/meminfo.c         |  5 ++++-
> > > >    include/linux/dma-buf.h   |  1 +
> > > >    3 files changed, 18 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > > index f264b70c383e..197e5c45dd26 100644
> > > > --- a/drivers/dma-buf/dma-buf.c
> > > > +++ b/drivers/dma-buf/dma-buf.c
> > > > @@ -37,6 +37,7 @@ struct dma_buf_list {
> > > >    };
> > > >      static struct dma_buf_list db_list;
> > > > +static atomic_long_t dma_buf_global_allocated;
> > > >      static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
> > > >    {
> > > > @@ -79,6 +80,7 @@ static void dma_buf_release(struct dentry *dentry)
> > > >        if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
> > > >            dma_resv_fini(dmabuf->resv);
> > > >    +    atomic_long_sub(dmabuf->size, &dma_buf_global_allocated);
> > > >        module_put(dmabuf->owner);
> > > >        kfree(dmabuf->name);
> > > >        kfree(dmabuf);
> > > > @@ -586,6 +588,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
> > > >        mutex_lock(&db_list.lock);
> > > >        list_add(&dmabuf->list_node, &db_list.head);
> > > >        mutex_unlock(&db_list.lock);
> > > > +    atomic_long_add(dmabuf->size, &dma_buf_global_allocated);
> > > >          return dmabuf;
> > > >    @@ -1346,6 +1349,16 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
> > > >    }
> > > >    EXPORT_SYMBOL_GPL(dma_buf_vunmap);
> > > >    +/**
> > > > + * dma_buf_allocated_pages - Return the used nr of pages
> > > > + * allocated for dma-buf
> > > > + */
> > > > +long dma_buf_allocated_pages(void)
> > > > +{
> > > > +    return atomic_long_read(&dma_buf_global_allocated) >> PAGE_SHIFT;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dma_buf_allocated_pages);
> > > > +
> > > >    #ifdef CONFIG_DEBUG_FS
> > > >    static int dma_buf_debug_show(struct seq_file *s, void *unused)
> > > >    {
> > > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > > index 6fa761c9cc78..ccc7c40c8db7 100644
> > > > --- a/fs/proc/meminfo.c
> > > > +++ b/fs/proc/meminfo.c
> > > > @@ -16,6 +16,7 @@
> > > >    #ifdef CONFIG_CMA
> > > >    #include <linux/cma.h>
> > > >    #endif
> > > > +#include <linux/dma-buf.h>
> > > >    #include <asm/page.h>
> > > >    #include "internal.h"
> > > >    @@ -145,7 +146,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > > >        show_val_kb(m, "CmaFree:        ",
> > > >                global_zone_page_state(NR_FREE_CMA_PAGES));
> > > >    #endif
> > > > -
> > > > +#ifdef CONFIG_DMA_SHARED_BUFFER
> > > > +    show_val_kb(m, "DmaBufTotal:    ", dma_buf_allocated_pages());
> > > > +#endif
> > > >        hugetlb_report_meminfo(m);
> > > >          arch_report_meminfo(m);
> > > > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > > > index efdc56b9d95f..5b05816bd2cd 100644
> > > > --- a/include/linux/dma-buf.h
> > > > +++ b/include/linux/dma-buf.h
> > > > @@ -507,4 +507,5 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
> > > >             unsigned long);
> > > >    int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
> > > >    void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
> > > > +long dma_buf_allocated_pages(void);
> > > >    #endif /* __DMA_BUF_H__ */
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
