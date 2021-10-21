Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0479D4357CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 02:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhJUAbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 20:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhJUAa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:30:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1543FC0612EB;
        Wed, 20 Oct 2021 17:24:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g8so767012edb.12;
        Wed, 20 Oct 2021 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eloQCKXWTUiSmbR1X0jGe1q/eCl2wqdQA20kDdwT2s=;
        b=HriyKME2zazNoiZB+Rtlfps5OGDS+h+N7t3UADf3lQxb8AUY8f3zKkI8hr8iOHIA7q
         3gCYNUKF8GYy9qYUjhvtgwkiYJ95UIJk2knGl+yYRnu+C6BAGWV7sizMOfbbCP75Mtcu
         6ehgGtADVpi0zAE47LBah0SnJqlttdyF9UzNuVKVG+KPv1qJk1uaLe5YOEOI9RV+WIhX
         uhz4YudgvdCLfEVT8CAtP0J1brGnKC4nFvbpx4h6DXuHoNkJHFMo71PA/wU0z/pExdSR
         W8m8ltWRUW3Rb7sUxyPeBH8Ucf4WCBsAR9Zx3dI9PVdq/bWoR2Bni5zKJP5xpbqphCuj
         2lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eloQCKXWTUiSmbR1X0jGe1q/eCl2wqdQA20kDdwT2s=;
        b=McUIgGHDRRY+LNBJH6JudGGgWI3UPFOehENqaWftU6q+w8/51mYd0GjX75UqTeRBYL
         BhPXysDkgxZaWk98wByAuyf578um/zeXkQpHcwW3NEVhBMaNWLD+aK5AuDOsBKnC0sp1
         /CFWoKqgBiHCaGw0hSQKADIEPhDhGKgMfOqsFJSbb4uAfo9PaeYsfRom8veUYBJm1uSm
         uCimYHKMVN4zKN03DzNQh+a6XE+I/zls11VJR9X9Ap8leOl+iEEYp8SIIpUYBrPXSk/z
         u11uLM6CdLMy28rqDJ1XoaHeqeTDonOKWHFj9PuxjN2XnhFZf0JC7cGicsSH6UDd6xeb
         PihQ==
X-Gm-Message-State: AOAM531lAwE5dTRH/AOgpmJ36FuU0fQKg9Fo7t9jHIu2bgyblLh8tChU
        Ied21Xud1wU41ebycY9FBpigxNKFs5G/pEr2gtc=
X-Google-Smtp-Source: ABdhPJz4auadneCMTX46lZNSc9u6L0br4Hz0RPmrMr25TW9yJWn3zd+4jos22jkGtsn+dhh4tVpy00ywBQs5nFwbTmg=
X-Received: by 2002:a05:6402:1e8c:: with SMTP id f12mr2919700edf.71.1634775861767;
 Wed, 20 Oct 2021 17:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210917205731.262693-1-shy828301@gmail.com> <CAHbLzkqmooOJ0A6JmGD+y5w_BcFtSAJtKBXpXxYNcYrzbpCrNQ@mail.gmail.com>
 <YUdL3lFLFHzC80Wt@casper.infradead.org> <CAHbLzkrPDDoOsPXQD3Y3Kbmex4ptYH+Ad_P1Ds_ateWb+65Rng@mail.gmail.com>
 <YUkCI2I085Sos/64@casper.infradead.org> <CAHbLzkoXrVJOfOrNhd8nQFRPHhRVYfVYSgLAO3DO7ZmvaZtDVw@mail.gmail.com>
 <CAHbLzkrdXQfcudeeDHx8uUD55Rr=Aogi0pnQbBbP8bEZca8-7w@mail.gmail.com>
 <CAHbLzkq2v+xpBweO-XG+uZiF3kvOFodKi4ioX=dzXpBYLtoZcw@mail.gmail.com> <YXCrHxMF3ADO0n2x@casper.infradead.org>
In-Reply-To: <YXCrHxMF3ADO0n2x@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 20 Oct 2021 17:24:09 -0700
Message-ID: <CAHbLzkqHx=RRXAEjOunVOiJobkvQg0p005-ggSpLgcAn75QkOA@mail.gmail.com>
Subject: Re: [PATCH] fs: buffer: check huge page size instead of single page
 for invalidatepage
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hao Sun <sunhao.th@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 4:51 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Oct 20, 2021 at 04:38:49PM -0700, Yang Shi wrote:
> > > However, it still doesn't make too much sense to have thp_size passed
> > > to do_invalidatepage(), then have PAGE_SIZE hardcoded in a BUG
> > > assertion IMHO. So it seems this patch is still useful because
> > > block_invalidatepage() is called by a few filesystems as well, for
> > > example, ext4. Or I'm wondering whether we should call
> > > do_invalidatepage() for each subpage of THP in truncate_cleanup_page()
> > > since private is for each subpage IIUC.
> >
> > Seems no interest?
>
> No.  I have changes in this area as part of the folio patchset (where
> we end up converting this to invalidate_folio).  I'm not really
> interested in doing anything before that, since this shouldn't be
> reachable today.

Understood. But this is definitely reachable unless Hugh's patch
(skipping non-regular file) is applied.

>
> > Anyway the more I was staring at the code the more I thought calling
> > do_invalidatepage() for each subpage made more sense. So, something
> > like the below makes sense?
>
> Definitely not.  We want to invalidate the entire folio at once.

I didn't look at the folio patch (on each individual patch level), but
I'm supposed it still needs to invalidate buffer for each subpage,
right?
