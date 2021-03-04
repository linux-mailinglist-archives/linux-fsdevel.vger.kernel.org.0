Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108C032CC2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 06:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhCDFvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 00:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhCDFvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 00:51:42 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A53C061574
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Mar 2021 21:51:01 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l18so6093473pji.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Mar 2021 21:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHh6MdEXNUKZrwB9uZw23/DqWC2TOmpTX2HUQ2q/364=;
        b=HxQdXk52IXdtRkHu1/R6yxMuIjlbC3nn+FxxvSbrxxeQkNtjI5EB0s2Fhv3TvjIpKT
         qGGTY/1RU0C+gG/bxx0ujod2ciyhPCkICtGZyWHQPhKopE/dlptNwaZ1b2/Q7UAuHnX2
         iCAdy9e7isLGXsJkHM7IL/+azvhPqg2dfhBTjDaduRklCTQ7/unUXVmDiLRP3yk6r4Ju
         uuy0+YvACY5utD8X1Up2mqX16SoGsBssE2YlD5+QEma2aVgClTi/XC5/Rh3roeTObTTW
         n6QlOv0fHJDhqUvh2ihs9fgHCllPXss2OIdHe2a6gTtXCOA/19tjxqG0GnYd9VvlNzT4
         LQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHh6MdEXNUKZrwB9uZw23/DqWC2TOmpTX2HUQ2q/364=;
        b=HncJqo/BnaizzaHTdcKBRXhe/I+Nu2WMgdLgkpKkmu+gAFHBRmw1aOEjYS3BRx1tOA
         fGb6Q26hvj00GEIdp2n4tktviT78vkwjfbZBOgbOuijyjfoRzsCJwteuyBQPIxXlYJDc
         oUrSEduRSeOxgdWMlddZYqbt2ACj/sTz1lloB7uti6AKDmXaTGvUHBDsVVxrPx2quruh
         l62wqz5kzq8qSoBj/cWUa8RdJiNhxOwt5SqFaFLnMtpEdEv85iYKyo0r/LzkhUCHtsov
         4HE3KAI9+O8m2vwbS7ga/l22Nqw3qWh7dgmO42XAWRgC6ObQENy+WvCtlTvgtL8UmoZs
         xv0w==
X-Gm-Message-State: AOAM53184tOma3XMJHXz1sliDGkFEyDk7Ay/FSzYnlbQVR6za/8NOIjP
        D6qYHABvqEFko6821jah/Mtbe7eG/curwd1vNk5Frw==
X-Google-Smtp-Source: ABdhPJyRe1Ska4Dpb+winDsksPNhnJKDFerdQjWU0fCZIDmkpQO4lSqg3V4NY2A8paKorMfdEXogGQht1yFEAQ+TICg=
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr2679820pjk.229.1614837061472;
 Wed, 03 Mar 2021 21:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <20210225132130.26451-2-songmuchun@bytedance.com> <baa8e9af-69f5-c301-6735-f8eedc1929c7@gmail.com>
 <20210304042617.GB1223287@balbir-desktop>
In-Reply-To: <20210304042617.GB1223287@balbir-desktop>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 4 Mar 2021 13:50:23 +0800
Message-ID: <CAMZfGtUBsUH6ntfXBCPKT_5cZ_xxhW90=yU_KxBn-198k0wCwA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v17 1/9] mm: memory_hotplug: factor out
 bootmem core functions to bootmem_info.c
To:     Balbir Singh <bsingharora@gmail.com>
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
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 4, 2021 at 12:26 PM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Wed, Mar 03, 2021 at 01:45:00PM +1100, Singh, Balbir wrote:
> > On 26/2/21 12:21 am, Muchun Song wrote:
> > > Move bootmem info registration common API to individual bootmem_info.c.
> > > And we will use {get,put}_page_bootmem() to initialize the page for the
> > > vmemmap pages or free the vmemmap pages to buddy in the later patch.
> > > So move them out of CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code
> > > movement without any functional change.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > ...
> >
> > > diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> > > new file mode 100644
> > > index 000000000000..fcab5a3f8cc0
> > > --- /dev/null
> > > +++ b/mm/bootmem_info.c
> > > @@ -0,0 +1,124 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + *  linux/mm/bootmem_info.c
> > > + *
> > > + *  Copyright (C)
> >
> > Looks like incomplete
> >
> Not that my comment was, I should have said
>
> The copyright looks very incomplete

Yes. Just copied from mm/memory_hotplug.c.
I can improve it in the next version. Thanks.

>
> Balbir Singh.
