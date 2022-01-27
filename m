Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4FF49E7F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243940AbiA0Qs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiA0QsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:48:24 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09169C061714
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jan 2022 08:48:24 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q75so2731657pgq.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jan 2022 08:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas-edu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nosRojaWRtA9jVc9HpA0DkuLU5dvZGKl9sdgo49WiE=;
        b=262j/77YP8cXyaDVJlr1R79C2q8jGLht1a5id3s1QU8umVrJFqJnYWcSWnHW95M//S
         5lPRHgk1ZOGmZbEmPgvol1qCrD7SVRMHq2BtnYSdEIbciU+Wmsjdfy1VvZleVoaxhhX6
         aZICLlPN5BYmScJk+juu8wUDm4VGH1esbeNiuTaZElbte2u6gzD9byg3PYktv06WWfM3
         O03ujofzU9lJhc5a94nJa1Rs2XLdUhvOWaR0ri9gUSsE5WAFW7CytV8CBz/oDeci1y9T
         mDWezYWstKlYRAdUHvCCXWJj9mhClT1rXtWsQd14rSvqAZKcBWctf2NLar2iExD7uIf1
         cqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nosRojaWRtA9jVc9HpA0DkuLU5dvZGKl9sdgo49WiE=;
        b=5Y660aiTi/rHEa0/ZGSci1WbRWp0m8EVm94yCHYdIVK4brx6mbI1yI4ebJYDVOi2f7
         G41Zz84cDjghCIbK/l4BDqPfxqkFlVDJ4UHVWMq3hndn7/2ZmpvtkCqZvkFKHNPLOjMs
         UJPx1vB/aPlLDNDXgYyLbNNzQEPUMjrhrccXXtqfWjynMWWdZ+rQDa6fKaTlgTwllH+1
         0gs+1isi9+MR7W3P9uPBDjqXqbd+JZwVespY+e+wV2Zd0U3BewBlcAcB8GurG+/KEaUI
         2E5JQgyCfQ9TBNtp58hK5RHnJvSMi9G6C5JrGZz4/7eCrRGSQRE7NiTRg7RXlmIoG5qd
         Evlw==
X-Gm-Message-State: AOAM533A7OwARH0oO0C/tVBD0VOi6GmLrxXPK45IL/jm5Vg6snLfbOBi
        Zsjzc3wuV159OmWy/iTe7F6DqmD1lNAlLRTdWAOp/WD64wMAPSuD
X-Google-Smtp-Source: ABdhPJzyEOCjXnl0I9MXgUxOn+eWb+whngsaXv6/0DZ4OLW8b9iARwtg/3WUdF5q5PO3YMYnTuyi5nDD6/jTCC83p3I=
X-Received: by 2002:a63:e44b:: with SMTP id i11mr3318279pgk.207.1643302103139;
 Thu, 27 Jan 2022 08:48:23 -0800 (PST)
MIME-Version: 1.0
References: <CAFadYX5iw4pCJ2L4s5rtvJCs8mL+tqk=5+tLVjSLOWdDeo7+MQ@mail.gmail.com>
 <YfHMp+zhEjrMHizL@casper.infradead.org> <YfHU5/RrpJlRx5sO@casper.infradead.org>
 <CANiq72=fTTreGHn_-t1tBLKxMeCr4b0ENsHGAgWZL1OZ7sKhMA@mail.gmail.com>
In-Reply-To: <CANiq72=fTTreGHn_-t1tBLKxMeCr4b0ENsHGAgWZL1OZ7sKhMA@mail.gmail.com>
From:   Hayley Leblanc <hleblanc@utexas.edu>
Date:   Thu, 27 Jan 2022 10:48:12 -0600
Message-ID: <CAFadYX6oYC8Ncg7Ma3oO75mF3poKHB5adLBxKkDLLqt+xd64wQ@mail.gmail.com>
Subject: Re: Persistent memory file system development in Rust
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Vijay Chidambaram <vijayc@utexas.edu>,
        Samantha Miller <samantha.a.miller123@gmail.com>,
        austin.chase.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Matthew and Miguel for your responses, and thank you Matthew
for fixing my email address typo :)

On Thu, Jan 27, 2022 at 3:59 AM Matthew Wilcox <willy@infradead.org> wrote:
> In particular, the demands of academia (generate novel insights, write
> as many papers as possible, get your PhD) are at odds with the demands
> of a production filesystem (move slowly, don't break anything, DON'T
> LOSE USER DATA).  You wouldn't be the first person to try to do both,
> but I think you might be the first person to be successful.

This makes sense. Our goal is to make an effort throughout the project
to align it with
the community's interests and the trajectory of kernel development,
such that there's a potential
for some broader interest and longer-term support. Of course, that's
easy to say about a
file system that doesn't exist yet, and I'm sure we will neither be
the first nor last academics to
try to get the Linux community excited about our own project :)

It sounds like this will require us to be very serious and very
intentional about balancing the
expectations of academic conferences with the requirements of
production systems in
the kernel. My personal research interests center mostly on crash
consistency and
one of our big goals with this project is to address data
loss/consistency issues that we've
encountered in existing PM file systems, so I hope that focus will
help us target some of
those production requirements.

On Thu, Jan 27, 2022 at 8:10 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> For your reference: a RamFS port was posted last week. It uses the
> Rust for Linux support plus `cbindgen` to take an incremental
> approach, see:
>
>     https://lore.kernel.org/rust-for-linux/35d69719-2b02-62f2-7e2f-afa367ee684a@gmail.com/

Excellent, thank you! I'll check it out.

> > > Bento seems like a good approach (based on a 30 second scan of their
> > > git repo).  It wasn't on my radar before, so thanks for bringing it up.
> > > I think basing your work on Bento is a defensible choice; it might be
> > > wrong, but the only way to find out is to try.
>
> Side note: Bento is not using the Rust for Linux support (as far as I
> know / yet).

I have very limited experience with Bento, but I believe it is not. In
the interest of our goal of
keeping the project in line with the kernel, it sounds like we should
go with the existing Rust
for Linux support for now.

Thanks again for your help!

Thank you,
Hayley
