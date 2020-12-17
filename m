Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1652D2DCCCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 07:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgLQGz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 01:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgLQGz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 01:55:27 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A69C0617A7
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 22:54:47 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v3so14599865plz.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 22:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYkx9ybV2ueAWfRQVHDx3D5vcB/QAf7LUwizku++lx4=;
        b=R0gTUZ/+FhatN0Ola7XCwP06109oq3LSjiDLx745S1G4yZuUoGIKOIdEOfFNnMrxQe
         jIu36Ii/UWnyJrMJwV8/Cb8hef91r3E4XiUWyVhOZdHJOl5WdnKDs8fwvjq2wIihNj7Y
         Rx951XBU/s4mHFmnPyHjCFleq1NoZJ+xgzlJHgnpP9RF6X/OPreeu3W+YELbsOnRgC3X
         AUrlEEHRed6m+LTcbfmVz9akeJA9Cw8r0C/iJC1Wd3K4jjIkwHQvgz1GoMPzQBj41d8U
         rmisL0fl/QSjgMo8J1g3wDk6vnaRmE7v/rxG7ZQUtxbQYK7zW7Wpgf7WTQmeJdzhvWa8
         5RmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYkx9ybV2ueAWfRQVHDx3D5vcB/QAf7LUwizku++lx4=;
        b=cjfWyVNxfZyDKS5lLFWWyiehfKJte37oZ/5sEjyiMEumPtbJq2nfAzTlZoN3G4yZHq
         i0YZrH7+61dwCyUKWqAOQDnauGruEa8pkM4fyu9OaokiPe7/ML8I7wtiBuvDLZG0UD7S
         GBhRSSJ0NRM8p/oWzKv63DAOjzq29/C92D1wI8afgGIkUvDMWVw1rfVGBqTgkx266fyG
         kmZj8PlS1DoDzTuN1FvzSHxhb1jU/0z8s/zvkAgEqn1QnVIwIC+XL8S7JK2l7eCeUhMP
         /U+PLB3r9ZtoMOFR0DwaAdYooX7tPDX/7OmqcIZS1vjFDVhYoKWWKadPFvaqnjAM3M6N
         ZQ2g==
X-Gm-Message-State: AOAM530a9FB5xRVGnJKmvrQJI22y0Xdqj2rHTA7CGOtpSiMrAsWcS9wx
        1Y+/1Fnm5qkwhh6asTRY/KYshcwkPEA0T2jnbaOzpA==
X-Google-Smtp-Source: ABdhPJxIo3Bkh6if9eAbNjiecVSukBNUK6FsdvhRNKiiTT/IlqPDPu9KgseS7K+gDKV5spUiE1CR0WiMXQaInL/1jZE=
X-Received: by 2002:a17:902:8503:b029:dc:44f:62d8 with SMTP id
 bj3-20020a1709028503b02900dc044f62d8mr13771103plb.34.1608188086569; Wed, 16
 Dec 2020 22:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-4-songmuchun@bytedance.com> <5936a766-505a-eab0-42a6-59aab2585880@oracle.com>
 <20201216222549.GC3207@localhost.localdomain> <49f6a0f1-c6fa-4642-2db0-69f090e8a392@oracle.com>
In-Reply-To: <49f6a0f1-c6fa-4642-2db0-69f090e8a392@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 17 Dec 2020 14:54:10 +0800
Message-ID: <CAMZfGtXwU7LcTZw7iKFNksVTYx8Bhd=9Nct+zfNy_ibuFiF6ew@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 03/11] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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

On Thu, Dec 17, 2020 at 6:52 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/16/20 2:25 PM, Oscar Salvador wrote:
> > On Wed, Dec 16, 2020 at 02:08:30PM -0800, Mike Kravetz wrote:
> >>> + * vmemmap_rmap_walk - walk vmemmap page table
> >>> +
> >>> +static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> >>> +                         unsigned long end, struct vmemmap_rmap_walk *walk)
> >>> +{
> >>> +   pte_t *pte;
> >>> +
> >>> +   pte = pte_offset_kernel(pmd, addr);
> >>> +   do {
> >>> +           BUG_ON(pte_none(*pte));
> >>> +
> >>> +           if (!walk->reuse)
> >>> +                   walk->reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);
> >>
> >> It may be just me, but I don't like the pte[-1] here.  It certainly does work
> >> as designed because we want to remap all pages in the range to the page before
> >> the range (at offset -1).  But, we do not really validate this 'reuse' page.
> >> There is the BUG_ON(pte_none(*pte)) as a sanity check, but we do nothing similar
> >> for pte[-1].  Based on the usage for HugeTLB pages, we can be confident that
> >> pte[-1] is actually a pte.  In discussions with Oscar, you mentioned another
> >> possible use for these routines.
> >
> > Without giving it much of a thought, I guess we could duplicate the
> > BUG_ON for the pte outside the loop, and add a new one for pte[-1].
> > Also, since walk->reuse seems to not change once it is set, we can take
> > it outside the loop? e.g:
> >
> >       pte *pte;
> >
> >       pte = pte_offset_kernel(pmd, addr);
> >       BUG_ON(pte_none(*pte));
> >       BUG_ON(pte_none(pte[VMEMMAP_TAIL_PAGE_REUSE]));
> >       walk->reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);
> >       do {
> >               ....
> >       } while...
> >
> > Or I am not sure whether we want to keep it inside the loop in case
> > future cases change walk->reuse during the operation.
> > But to be honest, I do not think it is realistic of all future possible
> > uses of this, so I would rather keep it simple for now.
>
> I was thinking about possibly passing the 'reuse' address as another parameter
> to vmemmap_remap_reuse().  We could add this addr to the vmemmap_rmap_walk
> struct and set walk->reuse when we get to the pte for that address.  Of
> course this would imply that the addr would need to be part of the range.

Maybe adding another one parameter is unnecessary.  How about doing
this in the vmemmap_remap_reuse?

The 'reuse' address just is start + PAGE_SIZE.

void vmemmap_remap_free(unsigned long start, unsigned long size)
{
         unsigned long end = start + size;
         unsigned long reuse_addr = start + PAGE_SIZE;
         LIST_HEAD(vmemmap_pages);

         struct vmemmap_remap_walk walk = {
                  .remap_pte = vmemmap_remap_pte,
                  .vmemmap_pages = &vmemmap_pages,
                  .reuse_addr = reuse_addr.
         };

}

>
> Ideally, we would walk the page table to get to the reuse page.  My concern
> was not explicitly about adding the BUG_ON.  In more general use, *pte could
> be the first entry on a pte page.  And, then pte[-1] may not even be a pte.
>
> Again, I don't think this matters for the current HugeTLB use case.  Just a
> little concerned if code is put to use for other purposes.
> --
> Mike Kravetz



-- 
Yours,
Muchun
