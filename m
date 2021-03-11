Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BC8336A48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 03:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCKC7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 21:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhCKC64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 21:58:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B00FC061760
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 18:58:45 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g25so389438wmh.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 18:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRM9zMw9cONpV3FPTOs+yqjYIo2ZpevTzYckbkAXLwQ=;
        b=Cnwj1JgoXGJEI1UB44KCDg0G/iPkB97ChLiwZXSc7SGMq/dWa0QyuLMXKMCUIxGaOH
         ItTaIc3lGmgfbHSbK1AY3fk/FD7iloS2NCnboWriNBG0SVU/vWyZxIInBWmq2R7X0Wxc
         kBLy5p1MzlIGdrtNf4dV+a/5kmSlHsrDNZYElujlbCjzgwf7Rrg2iK6lOq99qvFlbcVZ
         KGFjkwCawTLS0XTxHCmxC/j0J1rdGVfFqFb9F9cN6L28+HKDwmlOoRWVaNnqWefwPm6+
         5Ug7SJUfL5h037uhRzXrP4mH7/nw44sQwU/OEU+tjGqt8drUSPtEtQlH3Fcz6BZZEQK1
         1sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRM9zMw9cONpV3FPTOs+yqjYIo2ZpevTzYckbkAXLwQ=;
        b=DntobD1yTO5zTabtqw1DK8MRdRon3QkLLmLk4JoP/MKMI5mc3zhEfE4rPCn/gE6c8R
         ndQASkZ20HImzTUSYeUkDAe1T7qU822DCTFzVBAQEh/K+qNVIIdEKGxC/Ia1s7NqD+H6
         HhXYr32mfKKNKUWiVN3bQSqWn5BNx0N+u5BgbCkd9JLamQne5VfpKWHmk9Tt81jJWiGT
         6VzbHAsWSUIhXlQoM1avhO4qgBLarDUTdhhBBFZ+rFlcJspR5zI1sH5jwEjvRN+2s4HP
         qP6EX7Olkn6TdXSsKgNB+QXfADwJwvyCRmt9UCs9VH+4yzyAqXCIW7BPiTJ71FEH94r1
         dJFA==
X-Gm-Message-State: AOAM533DtepIFD/sykdX5BS8Ee6KD6alTu0GCDNDMgO3yQY8tLIReUQf
        KfTkbdFnhEfsac9bOlMtcdbyGH70JBluxUMDM2kTng==
X-Google-Smtp-Source: ABdhPJxp5FRGwwb/+YpsrWUrU3Vq6fcoiitqZQLceHJQwTGgs34sWTNe0Nu7XmZOhhqlvJ2FvmXomaRxAk4sOigOwvw=
X-Received: by 2002:a1c:a916:: with SMTP id s22mr6202421wme.82.1615431523833;
 Wed, 10 Mar 2021 18:58:43 -0800 (PST)
MIME-Version: 1.0
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-2-songmuchun@bytedance.com> <YEjUYOIJb2kYoQIA@dhcp22.suse.cz>
In-Reply-To: <YEjUYOIJb2kYoQIA@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 10:58:07 +0800
Message-ID: <CAMZfGtUj9vcVrSjT8Tk12jfkVE127Vkdkx6Js1JXzL+=rmu7Qw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v18 1/9] mm: memory_hotplug: factor out
 bootmem core functions to bootmem_info.c
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:14 PM Michal Hocko <mhocko@suse.com> wrote:
>
> [I am sorry for a late review]

Thanks for your review.

>
> On Mon 08-03-21 18:27:59, Muchun Song wrote:
> > Move bootmem info registration common API to individual bootmem_info.c.
> > And we will use {get,put}_page_bootmem() to initialize the page for the
> > vmemmap pages or free the vmemmap pages to buddy in the later patch.
> > So move them out of CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code
> > movement without any functional change.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > Tested-by: Chen Huang <chenhuang5@huawei.com>
> > Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
>
> Separation from memory_hotplug.c is definitely a right step. I am
> wondering about the config dependency though
> [...]
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 72227b24a616..daabf86d7da8 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -83,6 +83,7 @@ obj-$(CONFIG_SLUB) += slub.o
> >  obj-$(CONFIG_KASAN)  += kasan/
> >  obj-$(CONFIG_KFENCE) += kfence/
> >  obj-$(CONFIG_FAILSLAB) += failslab.o
> > +obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
>
> I would have expected this would depend on CONFIG_SPARSE.
> BOOTMEM_INFO_NODE is really an odd thing to depend on here. There is
> some functionality which requires the node info but that can be gated
> specifically. Or what is the thinking behind?

At first my idea was to free vmemmap pages through the bootmem
interface. My first instinct is to rely on BOOTMEM_INFO_NODE.
It makes sense to me to depend on CONFIG_SPARSE. I will
update this in the next version.

Thanks.

>
> This doesn't matter right now because it seems that the *_page_bootmem
> is only used by x86 outside of the memory hotplug.
>
> Other than that looks good to me.
> --
> Michal Hocko
> SUSE Labs
