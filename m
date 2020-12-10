Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E82D5F8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 16:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391576AbgLJPXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 10:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgLJPXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:23:32 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A645C0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:22:52 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id p6so2926284plr.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxwaAAILNdApGCqxRJD9MVfeDiL8SXyh6Su+yDRYLEY=;
        b=QnoSqYI6BQegxydBg15IBI7iVTrqsyX2nwVstbgi36h5JjuBDHy6haihOTgQPZa+o/
         1yxnr4OQ/AALgpYahJAXoZbt4JUutdj+fUCov7bCnyFyUbT7+c/THaDFLaDoTpb1QK61
         jWHvckQX5gIYElzlGNzB0vaIB5NkfvvfbZjSeyeCLKHFEZkbo18BBUlj3klO4wNUIS/0
         pAxMtBuBQTvqYGVruXyESkrojUQyhsFh8vxlzMqt6nSBw1QW6bZYhzaMPXVdBoIhz5gA
         ePxLiKuZhjpYpKA2eZ+YpKlZT5tx/gScIM9Y3vrWiUkC6u8iaXwzp/IFfpL1pCaRl8wS
         VlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxwaAAILNdApGCqxRJD9MVfeDiL8SXyh6Su+yDRYLEY=;
        b=OcJHMSH2xPj0zuTJeADDEefSMV+xNe+QTvDx/7sHgClaHBx1S57FjPIyvRe/l8HdqV
         LsjYZ/vrmhKvtIJo5LWMApD52XynoyRfLQ2iQpAXib6AfVeD4hz9ZoOZCFVAwy8diUEa
         23pm9hT+SgiVHa1jOFruk1M8VZFPUss+JwlBh1xo7O4Gfw7PAsisNq8PTdf3oBv5S3Qm
         pDd8U5kh8WmH0uac+U4ZhgRCMcXG3s0e/zqiD6mCtetf45p1/xtUaITUtjBVb9pQ5jiY
         OygKr8NQidxje/p2EpRH0QSBS2WdcoENJdCqIly2A7fslQn2XgtLzuVJfnBUbH4xQIOa
         WNzA==
X-Gm-Message-State: AOAM532KrL7l8RN7VHHl6HwKmLYqKEG55c4woND6/I8llkXmnDJxxIu2
        ZY9PuLvKjmkVI01tH6Ty/IqCSaofRG0OhBhyp3n/3w==
X-Google-Smtp-Source: ABdhPJzd1hC7caLHiFO1MtPobpcg3nJcwuDHdu6A/DYS21xLZ+5VYCN0bNhx+AKBnGVZ2k4x3VtNhB8mvu9qpHmTREA=
X-Received: by 2002:a17:902:ed0d:b029:da:c83b:5f40 with SMTP id
 b13-20020a170902ed0db02900dac83b5f40mr7004443pld.20.1607613772004; Thu, 10
 Dec 2020 07:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-4-songmuchun@bytedance.com> <20201210141547.GA8538@localhost.localdomain>
In-Reply-To: <20201210141547.GA8538@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Dec 2020 23:22:15 +0800
Message-ID: <CAMZfGtW6yJPR2yUR0h11=QxY8G6V8oZAnArYh4SQPn370cBLpQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 03/12] mm/bootmem_info: Introduce
 free_bootmem_page helper
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 10:16 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 10, 2020 at 11:55:17AM +0800, Muchun Song wrote:
> > Any memory allocated via the memblock allocator and not via the buddy
> > will be makred reserved already in the memmap. For those pages, we can
>          marked

Thanks.

> > call free_bootmem_page() to free it to buddy allocator.
> >
> > Becasue we wan to free some vmemmap pages of the HugeTLB to the buddy
> Because     want
> > allocator, we can use this helper to do that in the later patchs.
>                                                            patches
>

Thanks.

> To be honest, I think if would be best to introduce this along with
> patch#4, so we get to see where it gets used.
>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/bootmem_info.h | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> > index 4ed6dee1adc9..20a8b0df0c39 100644
> > --- a/include/linux/bootmem_info.h
> > +++ b/include/linux/bootmem_info.h
> > @@ -3,6 +3,7 @@
> >  #define __LINUX_BOOTMEM_INFO_H
> >
> >  #include <linux/mmzone.h>
> > +#include <linux/mm.h>
>
> <linux/mm.h> already includes <linux/mmzone.h>

Yeah. Can remove this.

>
> > +static inline void free_bootmem_page(struct page *page)
> > +{
> > +     unsigned long magic = (unsigned long)page->freelist;
> > +
> > +     /* bootmem page has reserved flag in the reserve_bootmem_region */
> reserve_bootmem_region sets the reserved flag on bootmem pages?

Right.

>
> > +     VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);
>
> We do check for PageReserved in patch#4 before calling in here.
> Do we need yet another check here? IOW, do we need to be this paranoid?

Yeah, do not need to check again. We can remove it.

>
> > +     if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
> > +             put_page_bootmem(page);
> > +     else
> > +             WARN_ON(1);
>
> Lately, some people have been complaining about using WARN_ON as some
> systems come with panic_on_warn set.
>
> I would say that in this case it does not matter much as if the vmemmap
> pages are not either SECTION_INFO or MIX_SECTION_INFO it means that a
> larger corruption happened elsewhere.
>
> But I think I would align the checks here.
> It does not make sense to me to only scream under DEBUG_VM if page's
> refcount differs from 2, and have a WARN_ON if the page we are trying
> to free was not used for the memmap array.
> Both things imply a corruption, so I would set the checks under the same
> configurations.

Do you suggest changing them all to VM_DEBUG_ON?

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
