Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA52D5FAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 16:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391106AbgLJP2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 10:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391693AbgLJP2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:28:22 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60981C0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:27:33 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id f9so4382349pfc.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rv3LvUpmaExydeU0HNZ3WNQ4lNYDnwxvurxewj7Gioo=;
        b=CUI3InpdCk2b2qqbrlYU3I+TKx8C7/x/zITj4+e6UHPTi4CztI5YFI6b6e4TYyB0zk
         9GLSher1TjZWn3r++BtKviRXg9ASZRVOQ7hmDkSj9C+1ncPbu/rUkZGMkmForJvjvhR4
         MPNgAfMF+W8VZQPCqhT99ceerjgW9inWSvOUSQbhtPq4XzPK/ZpJGUjqcp47FhLNS6Ce
         r+zPhxFsaUvhZ2nPGfUCZqYqrlEJCoMVzqzWr0qzrlK8ohEP3ptB6noQdCO6S3nDyRhM
         jkqD4svVWzg+/xae1eraU+L/DiJvBw3y01dqEZqp1D+OtXsez8UyLOrZX33W1QdCUK9r
         J2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rv3LvUpmaExydeU0HNZ3WNQ4lNYDnwxvurxewj7Gioo=;
        b=QQ1eVcjiArMl89hzP1x08o/741acgmI7lXbDoWU8DZmr8GBaEowgfIcncwY9gCJauY
         icft05PvzTOkY2XZNNP1tOMZnl5+uwEhbdPzCN/RQzmk6vs5Zc9iD4OVtqScqtp/AHkB
         +2mwlasWauzdg3p26p73RQIslrTygAqNNeQmD39cQniUbm2m+7/4jx3LiH4eRH7TLrpm
         /7qhHmzQRtBmfMr1cUtmxsbMtOyoa6OxgMsKL9M08vvk7TqUDnb5UK4nbCyp+PKMpQO8
         62S2eMnYymKCxjrJKBk4YecOe2U8iwvan2mvAzROxs1V2FORXl9EF5T71dTiW6Q9h9vD
         roFg==
X-Gm-Message-State: AOAM532TEL2LD0K2OAKRr16QcudcVloIvrtS4kH579PKS1w3hHXbrDVF
        nKW3lxZaAN96Vx7D2rCzQJAU9W+MD/fC/cR9QmeVSg==
X-Google-Smtp-Source: ABdhPJyPxcHvN6IYlzC4n1GyRsUIJzjup9DkstN1YuVZ6rDsyWbcahJr0nfkJmjvBlP92tLmyVuV8gEVjalWAMva4PE=
X-Received: by 2002:a62:4e4e:0:b029:19e:aaab:8be with SMTP id
 c75-20020a624e4e0000b029019eaaab08bemr5090266pfb.59.1607614052909; Thu, 10
 Dec 2020 07:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-4-songmuchun@bytedance.com> <20201210141547.GA8538@localhost.localdomain>
 <CAMZfGtW6yJPR2yUR0h11=QxY8G6V8oZAnArYh4SQPn370cBLpQ@mail.gmail.com>
In-Reply-To: <CAMZfGtW6yJPR2yUR0h11=QxY8G6V8oZAnArYh4SQPn370cBLpQ@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Dec 2020 23:26:56 +0800
Message-ID: <CAMZfGtUyiTnktzwqnGyw2wrgkj23U4g3BF04J+2okN2uQRjqTA@mail.gmail.com>
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

On Thu, Dec 10, 2020 at 11:22 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Thu, Dec 10, 2020 at 10:16 PM Oscar Salvador <osalvador@suse.de> wrote:
> >
> > On Thu, Dec 10, 2020 at 11:55:17AM +0800, Muchun Song wrote:
> > > Any memory allocated via the memblock allocator and not via the buddy
> > > will be makred reserved already in the memmap. For those pages, we can
> >          marked
>
> Thanks.
>
> > > call free_bootmem_page() to free it to buddy allocator.
> > >
> > > Becasue we wan to free some vmemmap pages of the HugeTLB to the buddy
> > Because     want
> > > allocator, we can use this helper to do that in the later patchs.
> >                                                            patches
> >
>
> Thanks.
>
> > To be honest, I think if would be best to introduce this along with
> > patch#4, so we get to see where it gets used.
> >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  include/linux/bootmem_info.h | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> > > index 4ed6dee1adc9..20a8b0df0c39 100644
> > > --- a/include/linux/bootmem_info.h
> > > +++ b/include/linux/bootmem_info.h
> > > @@ -3,6 +3,7 @@
> > >  #define __LINUX_BOOTMEM_INFO_H
> > >
> > >  #include <linux/mmzone.h>
> > > +#include <linux/mm.h>
> >
> > <linux/mm.h> already includes <linux/mmzone.h>
>
> Yeah. Can remove this.
>
> >
> > > +static inline void free_bootmem_page(struct page *page)
> > > +{
> > > +     unsigned long magic = (unsigned long)page->freelist;
> > > +
> > > +     /* bootmem page has reserved flag in the reserve_bootmem_region */
> > reserve_bootmem_region sets the reserved flag on bootmem pages?
>
> Right.
>
> >
> > > +     VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);
> >
> > We do check for PageReserved in patch#4 before calling in here.
> > Do we need yet another check here? IOW, do we need to be this paranoid?
>
> Yeah, do not need to check again. We can remove it.
>
> >
> > > +     if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
> > > +             put_page_bootmem(page);
> > > +     else
> > > +             WARN_ON(1);
> >
> > Lately, some people have been complaining about using WARN_ON as some
> > systems come with panic_on_warn set.
> >
> > I would say that in this case it does not matter much as if the vmemmap
> > pages are not either SECTION_INFO or MIX_SECTION_INFO it means that a
> > larger corruption happened elsewhere.
> >
> > But I think I would align the checks here.
> > It does not make sense to me to only scream under DEBUG_VM if page's
> > refcount differs from 2, and have a WARN_ON if the page we are trying
> > to free was not used for the memmap array.
> > Both things imply a corruption, so I would set the checks under the same
> > configurations.
>
> Do you suggest changing them all to VM_DEBUG_ON?

Or VM_WARN_ON?

>
> >
> > --
> > Oscar Salvador
> > SUSE L3
>
>
>
> --
> Yours,
> Muchun



-- 
Yours,
Muchun
