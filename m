Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890D842B2DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 04:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhJMCu4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 22:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhJMCuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 22:50:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BCEC061570;
        Tue, 12 Oct 2021 19:48:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g8so3842800edt.7;
        Tue, 12 Oct 2021 19:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUR/mGvYPsKPEVw6jC+FILMezuz/OqDM8KSj68qp0LY=;
        b=Yd7IDzDBhs1jYzqUmRgWTj0v0Cnn8J7FLaaZ2l6VmBUNzCK8QG1NW4v9hK40WDpe00
         saC8+xJ1jSYUK5r0CY4FFwbvodFXwfYR8/Bms20ZkJDcmI3gwQNyvsuxqWQxQoSfIF8K
         BdI6g/y1ttyMHQWTL+xpRnrTeR26bZF116KpKf1vFwYvDSS0dWcOr111q34shL817go/
         beFOxa0TXvsVHQqecyLXW1ZTUNRlhDj52ZYeyvwLyzHW8ATTtOlhZ4DX0S+HNmVjXm9V
         OtzZ2rnbqSoGm+qffj80VdSlCvIOMOP6l3+53d4c/gDekgXWfLTUS9uHjGyUNxa2ylO1
         8DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUR/mGvYPsKPEVw6jC+FILMezuz/OqDM8KSj68qp0LY=;
        b=uEVZtY7ivV1hLv87MdrKAQBl4hhh/lIuUrv/pagwa7gvYx565jw8r0vyDd+OaaEbnN
         n0JiG1FuxjBNrneeNVBHNCbPc8oU+JU2ZyHuwbkJuXI4URA+LGl4guJ2DDJlB1hPlfPW
         bQiDBO0Xgw3RbdgiLQLsar4gBBnu7ObBK2Mrvz1c5MApTY9SWXfObQzeMUgssOhadEf6
         eE4wyJYr54DJbkviCn/kcIVHQklzeO/3DDCLG7cWaH2tWFZpW/LU1zDoyf+ariCI4mmc
         6n8Q5zf+z16ebqqXT0Vn/ILL3j1ihDqfqRWl44WFGrDU702wgmw/5J4jN2P18t6/3GUm
         h2Hg==
X-Gm-Message-State: AOAM531hBvLeWHWcvESnx7d74Mt7V7FazUa0k3AWMq/nM+LVvw3wUMkt
        iqANBZayJHbKVLNK8uJUivs8YrJmgYpDdxgUa4TIpQgU
X-Google-Smtp-Source: ABdhPJx0ADpL3IeCPgiQs+btp6hskCDISm/c40aR79xLjBbigm8sdFG+AmdFBaN76EVqmlE6VUa2c///RnYPJ92xsEs=
X-Received: by 2002:a05:6402:16d2:: with SMTP id r18mr5591511edx.363.1634093331672;
 Tue, 12 Oct 2021 19:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s> <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
 <YWTc/n4r6CJdvPpt@t490s> <YWTobPkBc3TDtMGd@t490s> <CAHbLzkrOsNygu5x8vbMHedv+P3dEqOxOC6=O6ACSm1qKzmoCng@mail.gmail.com>
 <YWYHukJIo8Ol2sHN@t490s>
In-Reply-To: <YWYHukJIo8Ol2sHN@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 12 Oct 2021 19:48:39 -0700
Message-ID: <CAHbLzkp3UXKs_NP9XD_ws=CSSFzUPk7jRxj0K=gvOqoi+GotmA@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 3:10 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 11:02:09AM -0700, Yang Shi wrote:
> > On Mon, Oct 11, 2021 at 6:44 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 08:55:26PM -0400, Peter Xu wrote:
> > > > Another thing is I noticed soft_offline_in_use_page() will still ignore file
> > > > backed split.  I'm not sure whether it means we'd better also handle that case
> > > > as well, so shmem thp can be split there too?
> > >
> > > Please ignore this paragraph - I somehow read "!PageHuge(page)" as
> > > "PageAnon(page)"...  So I think patch 5 handles soft offline too.
> >
> > Yes, exactly. And even though the split is failed (or file THP didn't
> > get split before patch 5/5), soft offline would just return -EBUSY
> > instead of calling __soft_offline_page->page_handle_poison(). So
> > page_handle_poison() should not see THP at all.
>
> I see, so I'm trying to summarize myself on what I see now with the new logic..
>
> I think the offline code handles hwpoison differently as it sets PageHWPoison
> at the end of the process, IOW if anything failed during the offline process
> the hwpoison bit is not set.
>
> That's different from how the memory failure path is handling this, as in that
> case the hwpoison bit on the subpage is set firstly, e.g. before split thp.  I
> believe that's also why memory failure requires the extra sub-page-hwpoison bit
> while offline code shouldn't need to: because for soft offline split happens
> before setting hwpoison so we just won't ever see a "poisoned file thp", while
> for memory failure it could happen, and the sub-page-hwpoison will be a temp
> bit anyway only exist for a very short period right after we set hwpoison on
> the small page but before we split the thp.
>
> Am I right above?

Yeah, you are right. I noticed this too, only successfully migrated
page is marked as hwpoison. But TBH I'm not sure why it does this way.
Naoya may know. Anyway, THP doesn't get migrated if it can't be split,
so PageHasHWPoisoned doesn't apply, right?

>
> I feel like __soft_offline_page() still has some code that assumes "thp can be
> there", e.g. iiuc after your change to allow file thp split, "hpage" will
> always be the same as "page" then in that function, and isolate_page() does not
> need to pass in a pagelist pointer too as it'll always be handling a small page
> anyway.  But maybe they're fine to be there for now as they'll just work as
> before, I think, so just raise it up.

That compound_head() call seems to be for hugetlb since isolating
hugetlb needs to pass in the head page IIUC. For the pagelist, I think
it is just because migrate_pages() requires a list as the second
parameter.

>
> --
> Peter Xu
>
