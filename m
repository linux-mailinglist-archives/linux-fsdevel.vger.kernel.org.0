Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B526EA00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 02:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgIRAkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 20:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIRAkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:40:02 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41918C06174A;
        Thu, 17 Sep 2020 17:40:02 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x69so4822573oia.8;
        Thu, 17 Sep 2020 17:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=CzppbtQsL85qMBjIyO3ILzgWWOkJo7YW7JiID+Mn6O4=;
        b=CeVLSlp8Jp0FKb14W80roF8i0+Y00ejK0Q/yGLoyg/yElKVf7tMHDWgz0KBbC7P5hH
         0MXsik4Z2SOYU9uh+mlCvFLFpiJ9o95xBhD//yT51idnSunhamD6cT9NHgfSe5b0OBWj
         A7quZe+ITSyUhPsqKbtaOrHYxjEGRpDgdXAbBlk6Twq3q8QpNdybwi3kGxiYKyQ+Axin
         g+U/GJLKzOWx6WmbMAw+F2YVyk8f+Z13WcaE3OJuAZwHCK4VRgcAUvKTkNT2LmKHJASe
         Jtv5jqWAz+AGAsB/iAeG3v9qW9fI5/WnSnoOqqvEwLE97c7GWUKkskHwpNYLC25Ng8WR
         doow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=CzppbtQsL85qMBjIyO3ILzgWWOkJo7YW7JiID+Mn6O4=;
        b=l9NYaRuCPArDvJRgzbEkHVzL4E1os0hT/K3vHKmAERchDRjIUmcZIuT9C1nQiMA8B+
         Ihc4y5R9RPuue9H2cgIkjkJJjgoF/F9IUPtXMbJHpiGFTRqP/UMZ1rHSGCS1++CYJLMy
         br6hpvpdk2xbNLYy08xMS5RQKzyGnncHuS9u05hok8jGbJSnbtAuq2EHHHcc2H/dnEzq
         bPsgYgKjPGnoMyhpdPZOHBJpu7A7voh22+uxqEPADrK9/CeVo6JFFlir5HnCpNmNiyNJ
         Z74z5Lg2DIWPYOE+X078TFOl0qXod+RtFH/ZMFYwf2/4OyZ7bpBXshim96tzZVoEhv8H
         MhNA==
X-Gm-Message-State: AOAM530CmW+w//3lG2SYuT/KsaXMExlnc3fNB3ejcIXleEv3+//xgAlq
        +thbYBeVUR1hEdH/sqcPAcO2uypT5dm3vDHn++g=
X-Google-Smtp-Source: ABdhPJzjVwFsJGo4t5J0C0uULjTOnE+yrLYpDzNAa+dPZPVjf4ISWY4g20PNTkwbGCIkmXjBSxCDRt6LwNYIfrWyTgs=
X-Received: by 2002:aca:ec50:: with SMTP id k77mr7919497oih.35.1600389601582;
 Thu, 17 Sep 2020 17:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org> <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org> <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
 <20200917192707.GW5449@casper.infradead.org> <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
In-Reply-To: <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 18 Sep 2020 02:39:50 +0200
Message-ID: <CA+icZUWVRordvPzJ=pYnQb1HiPFGxL6Acunkjfwx5YtgUw+wuA@mail.gmail.com>
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

On Thu, Sep 17, 2020 at 10:00 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Sep 17, 2020 at 12:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Ah, I see what you mean.  Hold the i_mmap_rwsem for write across,
> > basically, the entirety of truncate_inode_pages_range().
>
> I really suspect that will be entirely unacceptable for latency
> reasons, but who knows. In practice, nobody actually truncates a file
> _while_ it's mapped, that's just crazy talk.
>
> But almost every time I go "nobody actually does this", I tend to be
> surprised by just how crazy some loads are, and it turns out that
> _somebody_ does it, and has a really good reason for doing odd things,
> and has been doing it for years because it worked really well and
> solved some odd problem.
>
> So the "hold it for the entirety of truncate_inode_pages_range()"
> thing seems to be a really simple approach, and nice and clean, but it
> makes me go "*somebody* is going to do bad things and complain about
> page fault latencies".
>

Hi,

I followed this thread a bit and see there is now a...

commit 5ef64cc8987a9211d3f3667331ba3411a94ddc79
"mm: allow a controlled amount of unfairness in the page lock"

By first reading I saw...

+ *  (a) no special bits set:
...
+ *  (b) WQ_FLAG_EXCLUSIVE:
...
+ *  (b) WQ_FLAG_EXCLUSIVE | WQ_FLAG_CUSTOM:

The last one should be (c).

There was a second typo I cannot remember when you sent your patch
without a commit message.

Will look again.

Thanks and Greetings,
- Sedat -
