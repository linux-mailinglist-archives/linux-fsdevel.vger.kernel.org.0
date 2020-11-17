Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6209F2B56B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 03:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgKQCWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 21:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgKQCV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 21:21:59 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7399AC0613CF;
        Mon, 16 Nov 2020 18:21:59 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id e18so20851241edy.6;
        Mon, 16 Nov 2020 18:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWYfLnaz7eMh4mk9Ol5H/DxPsxeYULGyXYIpX0n46ZY=;
        b=hm/6HF8AZx32MH6GUqGN22VPT+YjCqDtPQgDboGPJyisZ+iw8IDSJ4wdxa+ogCFOY4
         Bl5C6CPYjMTfSxv8c4GFXYCxNWO1/TGtpXlaciIEP6bShnWD9NwWmfpepAtxl3VOWQaT
         TPGE50sFAMXfrAOlUgGs4dHavEeMA8RASdW5VqlLfRmq6XnrXd7hShg3kTRK8SqPbC9Q
         AUmabIyuq5TIgbie7tQK+Sd1T7MMSoXswU7ofZOkVY3isDuCWNzlVkh/pUkzHElTzuxo
         EqsfxCZWY6uS8wkJLPE+KI18F00pX0MLhdpyPJC2w3i13SEQDkzdnziE4CzGGzNn/DOZ
         0iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWYfLnaz7eMh4mk9Ol5H/DxPsxeYULGyXYIpX0n46ZY=;
        b=doXybDVTMLF4qIHP4olKe16O45oVJSSKpr4zY0fcnL8W3uXKaF02px6Q4cCkGce+Sd
         8xopveedjYPlCcmI/gAV+ohRfUAf3H5a+7hPmXs21riPW6xn3I40t1W320TTpNUeh0Ot
         LUD9Dd5B/FWWfjjjIe53+cn07oW9kFBKNwRTQ+wdQr34tp8jDDM3VorG5+T+UZiaViXW
         Yq+02xPf3xrUsd8m4+7dGeOxZoMPPbdFrOa/t27mojUFHOhTLAlwqz2kJBr6bHIEEEpe
         X+qVqBmTFV+pGnQTHFpaR6InyPVmvk5D/z1w/X9kaPKkqm4CxmqyQdgl8BxJ7DCd4e7n
         bvlw==
X-Gm-Message-State: AOAM531P8JDcPre3s/eLsyz5daJbCrSt54dBjtha989M1OmMGdx/DVVP
        M1e4y6GUuQlQSxgiJsfgk/i8owgHSs0qRmj2kHA=
X-Google-Smtp-Source: ABdhPJzSZXbhNXs83jk0r2otHhgUsPbc2WydjS8m4+L0VpJzODtwqENSPE3ZC3wLDQFvMt8PSwY2ZBCQvr5WBW14NC4=
X-Received: by 2002:aa7:c713:: with SMTP id i19mr18366608edq.296.1605579718211;
 Mon, 16 Nov 2020 18:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
 <20201116120445.7359b0053778c1a4492d1057@linux-foundation.org>
 <CAF=yD-JJtAwse5keH5MxxtA1EY3nxV=Ormizzvd2FHOjWROk4A@mail.gmail.com>
 <CAF=yD-JFjoYEiqNLMqM-mTFQ1qYsw7Py5oggyVesHo7burwumA@mail.gmail.com> <20201116163754.ab6ff2ad8f797705db15cc1f@linux-foundation.org>
In-Reply-To: <20201116163754.ab6ff2ad8f797705db15cc1f@linux-foundation.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 16 Nov 2020 21:21:20 -0500
Message-ID: <CAF=yD-+Wrr6F78k-cEANo2JeYR9daTj7UjxUbL_vy4u-PJo1xg@mail.gmail.com>
Subject: Re: [PATCH v2] epoll: add nsec timeout support
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 7:37 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 16 Nov 2020 18:51:16 -0500 Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
>
> > On Mon, Nov 16, 2020 at 6:36 PM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > On Mon, Nov 16, 2020 at 3:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Mon, 16 Nov 2020 11:10:01 -0500 Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > > From: Willem de Bruijn <willemb@google.com>
> > > > >
> > > > > Add epoll_create1 flag EPOLL_NSTIMEO. When passed, this changes the
> > > > > interpretation of argument timeout in epoll_wait from msec to nsec.
> > > > >
> > > > > Use cases such as datacenter networking operate on timescales well
> > > > > below milliseconds. Shorter timeouts bounds their tail latency.
> > > > > The underlying hrtimer is already programmed with nsec resolution.
> > > >
> > > > hm, maybe.  It's not very nice to be using one syscall to alter the
> > > > interpretation of another syscall's argument in this fashion.  For
> > > > example, one wonders how strace(1) is to properly interpret & display
> > > > this argument?
> > > >
> > > > Did you consider adding epoll_wait2()/epoll_pwait2() syscalls which
> > > > take a nsec timeout?  Seems simpler.
> > >
> > > I took a first stab. The patch does become quite a bit more complex.
> >
> > Not complex in terms of timeout logic. Just a bigger patch, taking as
> > example the recent commit ecb8ac8b1f14 that added process_madvise.
>
> That's OK - it's mainly syscall table patchery.  The fs/ changes are
> what matters.  And the interface.
>
> > > I was not aware of how uncommon syscall argument interpretation
> > > contingent on internal object state really is. Yes, that can
> > > complicate inspection with strace, seccomp, ... This particular case
> > > seems benign to me. But perhaps it sets a precedent.
> > >
> > > A new nsec resolution epoll syscall would be analogous to pselect and
> > > ppoll, both of which switched to nsec resolution timespec.
> > >
> > > Since creating new syscalls is rare, add a flags argument at the same time?
>
> Adding a syscall is pretty cheap - it's just a table entry.

Okay. Then I won't add a flags argument now.

> > >
> > > Then I would split the change in two: (1) add the new syscall with
> > > extra flags argument, (2) define flag EPOLL_WAIT_NSTIMEO to explicitly
> > > change the time scale of the timeout argument. To avoid easy mistakes
> > > by callers in absence of stronger typing.
>
> I don't understand this.  You're proposing that the new epoll_pwait2() be
> able to take either msec or nsec, based on the flags argument?

It wasn't elegant. Superseded by the below alternative to add a timespec.

> With a
> longer-term plan to deprecate the old epoll_pwait()?

> If so, that's not likely to be viable - how can we ever know that the
> whole world stopped using the old syscall?

I don't mean to deprecate it. I noticed that epoll_wait was removed
from asm-generic/unistd.h in favor of epoll_pwait on the argument that
this should list the minimally needed syscall set. Removed in commit
a0673fdbcd42 ("asm-generic: clean up asm/unistd.h"), a descriptive
comment was earlier added in commit e64a1617eca3 ("asm-generic: add a
generic unistd.h"). If the same argument still holds, when adding
epoll_pwait2 there, I should remove epoll_pwait. But I'm admittedly
not very familiar with the implications of touching this uapi file.
Will read up.

> > Come to think of it, better to convert to timespec to both have actual
> > typing and consistency with ppoll/pselect.
>
> Sure.
>
> > > epoll_wait is missing from include/uapi/asm-generic/unistd.h as it is
> > > superseded by epoll_pwait. Following the same rationale, add
> > > epoll_pwait2 (only).
>
> Sure.
>
> > A separate RFC patch against manpages/master sent at the same time?
>
> That's the common approach - a followup saying "here's what I'll send
> to the manpages people if this gets merged".
>
> And something under tools/testing/sefltests/ would be nice, if only so
> that the various arch maintainers can verify that their new syscall is
> working correctly.  Perhaps by adding a please-use-epoll_pwait2 arg to
> the existing
> tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c, if that
> looks like a suitable testcase.

Will do both. Thanks!
