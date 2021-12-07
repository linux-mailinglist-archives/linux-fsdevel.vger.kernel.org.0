Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC35546B37F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 08:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhLGHSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 02:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhLGHSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:18:42 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465B0C061748
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Dec 2021 23:15:12 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id p8so25694973ljo.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Dec 2021 23:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JeLlEalXSQHW4pH2trtzzJDx6YYnAF08ckO/i6n2PyA=;
        b=SYj34d/hxJKfq8EbSGQE2cpAxSibC6df+us5qeCDougZMKek8E4/t6ldI2shF2MZnF
         6UIphA+wzSY8hgwgCCx+mMA3w25N7z7n+oQyDpJZNdQcGSjsmHMCgcYOQ3j4mF/lfrCt
         W7KKBRZUT1Ar3N0hizzhJr/8MleLpp4BXs+ikkCrJCiyaMrs5lhP3g+lBjvokFFdVO0D
         zliqi/bBTOtRB5FRrsiF0rtcMzmG5/6skvbYHndDnafnzaybiBkG73gNYZVy9rBkIJYK
         P4A+pVYqf6oZ4vnzOgoTmyellVvHpgzEV4i2Hod3I75Q9hjkKLPSRj3chdCa4hLVp6AT
         La1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeLlEalXSQHW4pH2trtzzJDx6YYnAF08ckO/i6n2PyA=;
        b=FbZwZ9ZzjkoqmupmUkRzc0ywhXEu7P5QYTOJtVoOMe0wG0OcsVSnSTKERwRTcK86hB
         acsn/Q8+CS0R9qaWCykkPp/lsPbT53FcAKf89fWkCuJz++TFgEw1TQMwuCoQ5oK7MY2W
         t/OBTUHRXeLoZJv3tjuOGyJIUIz8bNip0OPesU+ge1bzxmP6C0PJSs1KqHfMVJff1GZd
         ybkcbvAwGlPIxkQ1UziGGmYrfxZUxFITi5bGM0GA/L2x9Bi9h62awWzIAi0sAz59dgVe
         hulGqGdGn9apW4JG40HIBCYjju/hDuMpPH1cjb/C48XeFQUU1b4LcuYtxl0nFE4iCQO+
         eM7w==
X-Gm-Message-State: AOAM533oldt72XgkSUT8meDA/4Mj8wfYOjRAulMST4Bz7ardewpEENpI
        UxIwXbh8RAXJdL+YtKof2qSdQ3hQWKA90PwUGiQrDTC+uzuRSA==
X-Google-Smtp-Source: ABdhPJwD7St5XCs0KtsZ7B4kQrin00YT33yrHoQP8SuXlTurcS6UiF5SVM2kIX/jVUXjXi6ZmXrY/VK8VWLJc333RG4=
X-Received: by 2002:a05:651c:1790:: with SMTP id bn16mr40860622ljb.475.1638861310287;
 Mon, 06 Dec 2021 23:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <CALvZod6am_QrZCSf_de6eyzbOtKnWuL1CQZVn+srQVt20cnpFg@mail.gmail.com>
 <20211202165220.GZ3366@techsingularity.net> <CALvZod5tiDgEz4JwxMHQvkzLxYeV0OtNGGsX5ZdT5mTQdUdUUA@mail.gmail.com>
 <20211203090137.GA3366@techsingularity.net> <CALvZod46SFiNvUSLCJWEVccsXKx=NwT4=gk9wS6Nt8cZd0WOgg@mail.gmail.com>
 <20211203190807.GE3366@techsingularity.net> <CALvZod5BmFVdosG=e2NcEzeuzv0W9WifSBmeD48xnn1k+SNRKg@mail.gmail.com>
 <20211206112545.GF3366@techsingularity.net>
In-Reply-To: <20211206112545.GF3366@techsingularity.net>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 6 Dec 2021 23:14:58 -0800
Message-ID: <CALvZod6NPzzD=rzvmgLNsudCDVNJWgwviijB1LztRAhCX7jQBA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 6, 2021 at 3:25 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Sun, Dec 05, 2021 at 10:06:27PM -0800, Shakeel Butt wrote:
> > On Fri, Dec 3, 2021 at 11:08 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > [...]
> > > > I am in agreement with the motivation of the whole series. I am just
> > > > making sure that the motivation of VMSCAN_THROTTLE_NOPROGRESS based
> > > > throttle is more than just the congestion_wait of
> > > > mem_cgroup_force_empty_write.
> > > >
> > >
> > > The commit that primarily targets congestion_wait is 8cd7c588decf
> > > ("mm/vmscan: throttle reclaim until some writeback completes if
> > > congested"). The series recognises that there are other reasons why
> > > reclaim can fail to make progress that is not directly writeback related.
> > >
> >
> > I agree with throttling for VMSCAN_THROTTLE_[WRITEBACK|ISOLATED]
> > reasons. Please explain why we should throttle for
> > VMSCAN_THROTTLE_NOPROGRESS? Also 69392a403f49 claims "Direct reclaim
> > primarily is throttled in the page allocator if it is failing to make
> > progress.", can you please explain how?
>
> It could happen if the pages on the LRU are being reactivated continually
> or holding an elevated reference count for some reason (e.g. gup,
> page migration etc). The event is probably transient, hence the short
> throttling.
>

What's the worst that can happen if the kernel doesn't throttle at all
for these transient scenarios? Premature oom-kills? The kernel already
has some protection against such situations with retries i.e.
consecutive 16 unsuccessful reclaim tries have to fail to give up the
reclaim.

Anyways, I have shared my view which is 'no need to throttle at all
for no-progress reclaims for now and course correct if there are
complaints in future' but will not block the patch.

thanks,
Shakeel
