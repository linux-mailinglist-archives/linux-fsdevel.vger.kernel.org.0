Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991A72D7DAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 19:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgLKSIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 13:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbgLKSIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:08:15 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786CFC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 10:07:29 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so14565247lfh.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 10:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lhNAhTnpUy7aN6yOWsBRae0uCNBlueZz32LznFEKnc=;
        b=G+fi77bW5dkGmi6Wu0pHGL+26xF2y2ZcBAR2UWz6A1fbwMuWJ61jNFTRdHdb+537DR
         8+wNoBREyssJFBKmwMzCjvp3WELiSZ1P5KkjZOtz9LUvIdaQSSP75GxRYDyHH+XyUfVf
         1VMOEa1ebV5H7m5Zvljzk27E9YsOVmlsX5yU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lhNAhTnpUy7aN6yOWsBRae0uCNBlueZz32LznFEKnc=;
        b=IQ9zBLmysVC+HYCk2aqml7c9lGoZrcOf9wNHgF2V7Bk8nkA/hU0kf9c04mPF2fJ4eb
         Ce7quTjAMAyOOmZQ0MC/5gFNB2cE0rh54s0BfrXOAvzJ+Pk6NJkl1RmK6K3Y7/UKcOp6
         VHtxyS/o8oUtZXHKGHHpQX4Yaln0BDjPHhRfwLK/MLvda3liQusY+N4mAM+kTiM1Wlqv
         i2Jj7QEiMnmWdTOZBL7vLjgwbsmKwOd7x0dwjj/QZeMe5JbwzkaOhw9iYz4aedn6y8VL
         4kZGJKbNPn/5fjQxx2S+t+6eX7oIgBVWkXFVSGZY/s/fAwh5VRAKgdPhrve8OfXt57Nh
         DTlw==
X-Gm-Message-State: AOAM530pVL7lV3hTJilBzkThoQVNz0oAtMfaPYa+o02LKi8hkUBkFgMK
        myvm2+x7UdBwAp6dNVAZJbTldafwCSKo1w==
X-Google-Smtp-Source: ABdhPJzZg68+FPfuvios+CrzReaeNWXz8wjCuTkIgm6BIP8BqRqSXWgrq5vz1pk9a83IO94yM9VX7w==
X-Received: by 2002:a19:a57:: with SMTP id 84mr5160112lfk.327.1607710047583;
        Fri, 11 Dec 2020 10:07:27 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id m8sm1105842ljp.54.2020.12.11.10.07.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 10:07:26 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 23so14542592lfg.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 10:07:26 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr4708706lfd.201.1607710045669;
 Fri, 11 Dec 2020 10:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20201210200114.525026-1-axboe@kernel.dk> <20201210200114.525026-3-axboe@kernel.dk>
 <20201210222934.GI4170059@dread.disaster.area> <CAHk-=wiee7xKitbX74NvjcKDHLiE21=SbO9_urWBnvm=nSZAFQ@mail.gmail.com>
 <20201211005830.GD3913616@dread.disaster.area> <CAHk-=whQTK74ZwP7W9oMZFYZH=_t-1po75ajxQQAf-R945zhRA@mail.gmail.com>
 <20201211034541.GE3913616@dread.disaster.area>
In-Reply-To: <20201211034541.GE3913616@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Dec 2020 10:07:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjyquiZzQ9ws7s_NPREts=FgGO3oY26da77Eva4MRsuyQ@mail.gmail.com>
Message-ID: <CAHk-=wjyquiZzQ9ws7s_NPREts=FgGO3oY26da77Eva4MRsuyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: expose LOOKUP_NONBLOCK through openat2() RESOLVE_NONBLOCK
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 7:45 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Part of the problem we have with the non-blocking behaviour is that
> the user interfaces have been under specified, poorly reviewed and
> targetted a single specific use case on a single filesystem rather
> than generic behaviour. And mostly they lack the necessary test
> coverage to ensure all filesystems behave the same way and to inform
> us of a regression that *would break userspace applications*.

Fair enough. I just didn't really see much a concern here, exactly
because this ends up not being a hard guarantee in the first place
(but the reason I suggested then adding that RESOLVE_NONBLOCK is so
that it could be tested without having to rely on timing and io_uring
that _should_ get the same result regardless in the end).

But the second reason I don't see much concern is exactly because it
wouldn't affect individual filesystems. There's nothing new going on
as far as  filesystem is concerned.

> Yes, I recognise and accept that some of the problems are partially
> my fault. I also have a habit of trying to learn from the mistakes
> I've made and then take steps to ensure that *we do not make those
> same mistakes again*.

So the third reason I reacted was because we have a history, and you
have traditionally not ever really cared unless it's about xfs and IO.
Which this thing would very explicitly not be about. The low-level
filesystem would never see the semantics at all, and could never get
it wrong.

Well, a filesystem could "get it wrong" in the same sense that it can
get the current LOOKUP_RCU wrong, of course.

But that would be either an outright bug and a correctness problem -
sleeping in RCU context - or be a performance problem - returning
ECHILD very easily due to other reasons. And it would be entirely
unrelated to the nonblocking path open, because it would be a
performance issue even _normally_, just not visible as semantics.

And that's the second reason I like this, and would like to see this,
and see RESOLVE_NONBLOCK: exactly because we have _had_ those subtle
issues that aren't actually correctness issues, but only "oh, this
situation always takes us out of RCU lookup, and it's a very subtle
performance problem".

For example, it used to be that whenever we saw a symlink, we'd throw
up our hands and say "we can't do this in RCU lookup" and give up.
That wasn't a low-level filesystem problem, it was literally at the
VFS layer, because the RCU lookup was fairly limited.

Or some of the security models (well, _all_ of them) used to just say
"oh, I can't do this check in RCU mode" and forced the slow path.

It was very noticeable from a performance angle under certain loads,
because RCU lookup is just _so_ much faster when you otherwise get
locking and reference counting cache conflicts. Yes, yes, Al fixed the
symlinks long ago, but we know RCU lookup still gives up fairly easily
in other circumstances.

And RCU lookup giving up eagerly is fine, of course. The whole point
is that it's an optimistic "let's see if we can do this really
quickly" interface that just works _most_ of the time.

But that also makes it easy to miss things, because it's so hard to
test when it's purely about latency and all the operations will retry
and get the right result in the end. The "noticeable performance
issues" are generally not very noticeable at the level of an
individual operation - you need to do a lot of them, and often in
parallel, to see the _big_ benefits.

So RESOLVE_NONBLOCK would be a nice way to perhaps add automated
testing for "did we screw up RCU pathname lookup", in addition to
perhaps making it easier to find the cases where we currently give up
too quickly just because it was _fairly_ rare and nobody had much
visibility into that case.

And we have had that "oh, RCU lookup broke" a couple of times by
mistake - and then it takes a while to notice, because it's purely
visible as a performance bug and not necessarily all _that_ obvious -
exactly because it's purely about performance, and the semantic end
result is the same.

           Linus
