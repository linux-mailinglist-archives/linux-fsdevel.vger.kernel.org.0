Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446FF42B37A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 05:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbhJMD30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 23:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbhJMD3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:29:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99009C061762;
        Tue, 12 Oct 2021 20:27:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d3so4188918edp.3;
        Tue, 12 Oct 2021 20:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZPCHO08AgD6KyH1rx1SWGoXCYetQowI2VzSUfaOOSc=;
        b=lKR0XBaIHxm83dVSXfHQCA70xM/6/2WQeaJToudLFNEHzMNhDzxVWeSuWXzqlBkD8B
         clSTpJwTxH4kaZQfOVcH0uRuszz+5GvOUBn/XuBvdl6htLLtC8U5L7iTsroKsojrfKGX
         VkJ2EfTR43GZvXaGJ+TQK0F4h7NrsoW4muZNnvpuP0ifJzdw0HewwDwIWXSDxXjegU98
         DBU/6q4g6SUClgZOrN11FuSm4kNhzlOhaNwigmKnvLM2eoE0gowQYtfzK7UcoVUI7F9X
         6W8USiDUPgauhb13SsV0+m3V2NI4ZPQzrAbfz22sStFF5satXBYcTYwDL3e2zWVCMntU
         MMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZPCHO08AgD6KyH1rx1SWGoXCYetQowI2VzSUfaOOSc=;
        b=xAGXjNSmmcxA52pxSCnHMvJbJPprb/4TPh01T7u8kJdOhScOboeHFq8ocjscdnkt3I
         nAAuCdfji/nTetNnq+6mu5kSl02z9DyZHVFWDxX3BiPzIIk4pByO5IrXNB9kfNCeoXIn
         CYqq9cfrWNXYysyfRladqcDt8PAXWw57MDmyxp4yWFpu7eyN4nHcHllblci+sgIxwOru
         tDg+KnwSDaErhrL+CKz87pmTl9Bqx0aunICRaSn2UO2mmeJWFW3gNJ8T+IMUUP1rnkc3
         z44GJBQpEyoh8PwLJS2SNZ8s1KoRZe1aSsTWBWkFTM86DV8FYoGpRwRApk/pjaNU6qlt
         KemA==
X-Gm-Message-State: AOAM532cYsl1+SSjR87N0t/j8B1G9AmeDmshLpgr+mG2KXXxZV+rBGRg
        lczkEG7ZZ/VyNH6zIbXYAfmeCgR6bVtaJJmc0Nk=
X-Google-Smtp-Source: ABdhPJwS2I4xw4R+aJkqSQJ6ILBD1QJdX4FaKxy0F3AcXfxmln2prvB5TFVbaSR3E8T6ogUVsn8dWurShg+Y2jaC1MU=
X-Received: by 2002:a05:6402:10da:: with SMTP id p26mr5733821edu.283.1634095638697;
 Tue, 12 Oct 2021 20:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s> <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
 <YWTc/n4r6CJdvPpt@t490s> <YWTobPkBc3TDtMGd@t490s> <CAHbLzkrOsNygu5x8vbMHedv+P3dEqOxOC6=O6ACSm1qKzmoCng@mail.gmail.com>
 <YWYHukJIo8Ol2sHN@t490s> <CAHbLzkp3UXKs_NP9XD_ws=CSSFzUPk7jRxj0K=gvOqoi+GotmA@mail.gmail.com>
 <YWZMDTwCCZWX5/sQ@t490s>
In-Reply-To: <YWZMDTwCCZWX5/sQ@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 12 Oct 2021 20:27:06 -0700
Message-ID: <CAHbLzkp8QkORXK_y8hnrg=2kTRFyoZpJcXbkyj6eyCdcYSbZTw@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Peter Xu <peterx@redhat.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 8:01 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 07:48:39PM -0700, Yang Shi wrote:
> > On Tue, Oct 12, 2021 at 3:10 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Tue, Oct 12, 2021 at 11:02:09AM -0700, Yang Shi wrote:
> > > > On Mon, Oct 11, 2021 at 6:44 PM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > On Mon, Oct 11, 2021 at 08:55:26PM -0400, Peter Xu wrote:
> > > > > > Another thing is I noticed soft_offline_in_use_page() will still ignore file
> > > > > > backed split.  I'm not sure whether it means we'd better also handle that case
> > > > > > as well, so shmem thp can be split there too?
> > > > >
> > > > > Please ignore this paragraph - I somehow read "!PageHuge(page)" as
> > > > > "PageAnon(page)"...  So I think patch 5 handles soft offline too.
> > > >
> > > > Yes, exactly. And even though the split is failed (or file THP didn't
> > > > get split before patch 5/5), soft offline would just return -EBUSY
> > > > instead of calling __soft_offline_page->page_handle_poison(). So
> > > > page_handle_poison() should not see THP at all.
> > >
> > > I see, so I'm trying to summarize myself on what I see now with the new logic..
> > >
> > > I think the offline code handles hwpoison differently as it sets PageHWPoison
> > > at the end of the process, IOW if anything failed during the offline process
> > > the hwpoison bit is not set.
> > >
> > > That's different from how the memory failure path is handling this, as in that
> > > case the hwpoison bit on the subpage is set firstly, e.g. before split thp.  I
> > > believe that's also why memory failure requires the extra sub-page-hwpoison bit
> > > while offline code shouldn't need to: because for soft offline split happens
> > > before setting hwpoison so we just won't ever see a "poisoned file thp", while
> > > for memory failure it could happen, and the sub-page-hwpoison will be a temp
> > > bit anyway only exist for a very short period right after we set hwpoison on
> > > the small page but before we split the thp.
> > >
> > > Am I right above?
> >
> > Yeah, you are right. I noticed this too, only successfully migrated
> > page is marked as hwpoison. But TBH I'm not sure why it does this way.
>
> My wild guess is that unlike memory failures, soft offline is best-effort. Say,
> the data on the page is still consistent, so even if offline failed for some
> reason we shouldn't stop the program from execution.  That's not true for
> memory failures via MCEs, afaict, as the execution could read/write wrong data
> and that'll be a serious mistake, so we set hwpoison 1st there first before
> doing anything else, making sure "this page is broken" message delivered and
> user app won't run with risk.

Makes sense to me.

>
> But yeah it'll be great if Naoya could help confirm that.
>
> > Naoya may know. Anyway, THP doesn't get migrated if it can't be split,
> > so PageHasHWPoisoned doesn't apply, right?
>
> Right, that matches my current understanding of the code, so the extra bit is
> perhaps not useful for soft offline case.
>
> But this also reminded me that shouldn't we be with the page lock already
> during the process of "setting hwpoison-subpage bit, split thp, clear
> hwpoison-subpage bit"?  If it's only the small window that needs protection,
> while when looking up the shmem pagecache we always need to take the page lock
> too, then it seems already safe even without the extra bit?  Hmm?

I don't quite get your point. Do you mean memory_failure()? If so the
answer is no, outside the page lock. And the window may be indefinite
since file THP doesn't get split before this series and the split may
fail even after this series.

>
> >
> > >
> > > I feel like __soft_offline_page() still has some code that assumes "thp can be
> > > there", e.g. iiuc after your change to allow file thp split, "hpage" will
> > > always be the same as "page" then in that function, and isolate_page() does not
> > > need to pass in a pagelist pointer too as it'll always be handling a small page
> > > anyway.  But maybe they're fine to be there for now as they'll just work as
> > > before, I think, so just raise it up.
> >
> > That compound_head() call seems to be for hugetlb since isolating
> > hugetlb needs to pass in the head page IIUC. For the pagelist, I think
> > it is just because migrate_pages() requires a list as the second
> > parameter.
>
> Fair enough.
>
> Thanks,
>
> --
> Peter Xu
>
