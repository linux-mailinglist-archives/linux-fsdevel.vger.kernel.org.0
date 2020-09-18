Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F79C2706FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 22:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIRUZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 16:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRUZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:25:48 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE31C0613CE;
        Fri, 18 Sep 2020 13:25:48 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id m7so8551765oie.0;
        Fri, 18 Sep 2020 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ng2U6mdXwg5oUQzr5tep0pxAlnA9X2z29zc5CYUC5h8=;
        b=YXPn12YtsGND8HFGuG+ORPMnXZy5sTj7NMDDRSypyn+GjGEHnoQPc1v4ZA8zpEXpxG
         bVwbYw13n1Uav8CYp0T8sC+vWeSgJbtotnF4LGxiAQE0gVaig72vXL3/60xGsVIaQiAr
         3mgb+GwTufp5WMscU2U4HZLPUjSHCsgEARANQMOjCuM58nwlyCbZQvQHIQm8lTPuyw4F
         5sZvRLVXY083360btrolOgiy5PHaYJyFnDq0zm5lxMrx1HEOH50I4muiIly5GJYAAjFZ
         8g/TkSGgGUwILNs0OJmhVq/LB27UWyYNAL94uNnGp8j9Tp+UqWWcOVdFyT/ImZOQGRPj
         Vx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ng2U6mdXwg5oUQzr5tep0pxAlnA9X2z29zc5CYUC5h8=;
        b=YPwV5cXI/YZ0t6oUm4YvIm8vqNV/P23qy+H5dMEcqoFgb/dYoXe7i1lkL0u55OsnH0
         7OfM8mMgCky2TxuI31wKjAjfj6TCFlhQ6Fc/2U4XWZVzNpHIK83zd77qPM6PePOaVvPq
         zyVSeW+xKxvEIUWA8kviiTAvw5xKFnKbBEJxhMm7JyLBZjYKyu9b8D7LPdoDZKS3B1wq
         eoUA19m6Ayg2B5qWaa5OJTMCsOzO8jg+tNpcBhPA8Ic1eETGpKlEbGf7s8llE5J8ZfPW
         jl/vxQjqieD78ubIvnNFtq6u2xIdbxMVFU4WJ2T3+7708QL2F2qTQpJrLLfg0Dg8zoYJ
         yp0g==
X-Gm-Message-State: AOAM531NU7t+LoxapqF2evcZCB60jlEfUKo5PP4eRVQaBB8Ayib8wdG3
        kUF8XBKQdexoa0vKxDnJGklNVxAKy0lXXO+f+rI=
X-Google-Smtp-Source: ABdhPJypXCuBPDCH59cX+WundW0WffPWkCREI4CeHg6hS9bMZWcPWLUoR2URfm80CbkStzGJlJ0TuGbmyCpbTQDQfGA=
X-Received: by 2002:aca:d409:: with SMTP id l9mr9870530oig.70.1600460747452;
 Fri, 18 Sep 2020 13:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org> <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org> <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
 <20200917192707.GW5449@casper.infradead.org> <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
 <CA+icZUWVRordvPzJ=pYnQb1HiPFGxL6Acunkjfwx5YtgUw+wuA@mail.gmail.com> <CA+icZUUUkuV-sSEtb6F5Gk=yJ0efKUzEfE-_ko_b8BE3C7PTvQ@mail.gmail.com>
In-Reply-To: <CA+icZUUUkuV-sSEtb6F5Gk=yJ0efKUzEfE-_ko_b8BE3C7PTvQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 18 Sep 2020 22:25:36 +0200
Message-ID: <CA+icZUWoktdNKpdgBiojy=ofXhHP+y6Y4tPWm1Y3n4Yi_adjPQ@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 2:40 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Sep 18, 2020 at 2:39 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Thu, Sep 17, 2020 at 10:00 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Thu, Sep 17, 2020 at 12:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > Ah, I see what you mean.  Hold the i_mmap_rwsem for write across,
> > > > basically, the entirety of truncate_inode_pages_range().
> > >
> > > I really suspect that will be entirely unacceptable for latency
> > > reasons, but who knows. In practice, nobody actually truncates a file
> > > _while_ it's mapped, that's just crazy talk.
> > >
> > > But almost every time I go "nobody actually does this", I tend to be
> > > surprised by just how crazy some loads are, and it turns out that
> > > _somebody_ does it, and has a really good reason for doing odd things,
> > > and has been doing it for years because it worked really well and
> > > solved some odd problem.
> > >
> > > So the "hold it for the entirety of truncate_inode_pages_range()"
> > > thing seems to be a really simple approach, and nice and clean, but it
> > > makes me go "*somebody* is going to do bad things and complain about
> > > page fault latencies".
> > >
> >
> > Hi,
> >
> > I followed this thread a bit and see there is now a...
> >
> > commit 5ef64cc8987a9211d3f3667331ba3411a94ddc79
> > "mm: allow a controlled amount of unfairness in the page lock"
> >
> > By first reading I saw...
> >
> > + *  (a) no special bits set:
> > ...
> > + *  (b) WQ_FLAG_EXCLUSIVE:
> > ...
> > + *  (b) WQ_FLAG_EXCLUSIVE | WQ_FLAG_CUSTOM:
> >
> > The last one should be (c).
> >
> > There was a second typo I cannot remember when you sent your patch
> > without a commit message.
> >
> > Will look again.
> >
> > Thanks and Greetings,
> > - Sedat -
>
> Ah I see...
>
> + * we have multiple different kinds of waits, not just he usual "exclusive"
>
> ... *t*he usual ...
>

Hi Linus,

do you want me to send a patch for the above typos or do you want to
do that yourself?

Thanks.

Regards,
- Sedat -
