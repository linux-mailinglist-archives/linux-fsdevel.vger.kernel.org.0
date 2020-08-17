Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D999246E59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 19:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389522AbgHQR2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389566AbgHQRPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:15:30 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C26C061344
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 10:15:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so18300058ljj.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTKpRQCJHedRM3FbZvyYbTIR6de/XsGxhtwq6dwi9YM=;
        b=PMBxHujDdM06S7/LBYxWztuV9Qz9M9XMftYKfNncXrXEOWl8S9SfA8Rombi+0je/I0
         A84g6y4oncHBFuyCuaStiv1xllCcI1u554NplHzJl+AHhh3aSCdz63J8MUzhGeEWT8sx
         kXa9iLijsc9rTUTCiHyOc6bHkoxCbBHR8fr9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTKpRQCJHedRM3FbZvyYbTIR6de/XsGxhtwq6dwi9YM=;
        b=i5YoXjA1noAoFrrTtHwfYuVmgxfQrTs/QxmYUevu73QhIBT9LYur52yD3l803rXGKz
         2gdclqLbBLfgn5ZVuX6r9QpBqM1Lm0NGiupWs5fF1V+TZE2XOcmLqFfI8hXg4fWqskkC
         xpotmqDKnKoYv/KAk6yeIQTyMao96Q3Ot6m3y9luuENHZUIszJkqf/DsBM42CCUx6b8v
         B904kk9mLl6uGRU81p0u0Zrnp1pfr5mJ7oNE4GZAolj0ihj8jLtcP9DhkajYf4S1VPFV
         sJEyJOdHB/tWSAuWcOg7RMVlezEPAiRoms4d0vfr5UaX66EpPNElyedBLWxIwd0RDPBm
         UBwg==
X-Gm-Message-State: AOAM533vopS47//GrLkKdcU9wWlsWnu4g5ddaXTPObMotg8Qm5W6l2M2
        k0E7fG6QLE0ymNvo/mc0fut0/CffvrxyJQ==
X-Google-Smtp-Source: ABdhPJyMhghZIi5a6Q4II5mVKY1t9RevRj6iJxgrruTXIYQ3lN7hQWEbE7MgQTF8mAIZCJGVEtUPDQ==
X-Received: by 2002:a2e:9050:: with SMTP id n16mr7951364ljg.228.1597684525640;
        Mon, 17 Aug 2020 10:15:25 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id z21sm5142313ljm.30.2020.08.17.10.15.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 10:15:25 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 185so18299989ljj.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 10:15:25 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr8363984ljp.312.1597684524581;
 Mon, 17 Aug 2020 10:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com> <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
 <94f907f0-996e-0456-db8a-7823e2ef3d3f@redhat.com>
In-Reply-To: <94f907f0-996e-0456-db8a-7823e2ef3d3f@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 10:15:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
Message-ID: <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 4:33 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> That said, the overall aim here is to solve the problem and if there are
> better solutions available then I'm sure that everyone is very open to
> those. I agree very much that monitoring at kHz frequencies is not
> useful, but at the same time, there are cases which can generate large
> amounts of mount changes in a very short time period.

So the thing is, I absolutely believe in the kernel _notifying_ about
changes so that people don't need to poll. It's why I did merge the
notification queues, although I wanted to make sure that those worked.

> You recently requested some details of real users for the notifications,
> and (I assumed) by extension fsinfo too.

No, fsinfo wasn't on the table there. To me, notifications are a
completely separate issue, because you *can* get the information from
existing sources (ie things like /proc/mounts etc), and notification
seemed to be the much more fundamental issue.

If you poll for changes, parsing something like /proc/mounts is
obviously very heavy indeed. I don't find that particularly
controversial. Plus the notification queues had other uses, even if it
wasn't clear how many or who would use them.

But honestly, the actual fsinfo thing seems (a) overdesigned and (b)
broken. I've now had two different people say how they want to use it
to figure out whether a filesystem supports certain things that aren't
even per-filesystem things in the first place.

And this feature is clearly controversial, with actual discussion about it.

And I find the whole thing confusing and over-engineered. If this was
a better statfs(), that would be one thing. But it is designed to be
this monstoer thing that does many different things, and I find it
distasteful.  Yes, you can query "extended statfs" kind of data with
it and get the per-file attributes. I find it really annoying how the
vfs layer calls to the filesystems, that then call back to the vfs
layer to fill things in, but I guess we have that nasty pattern from
stat() already. I'd rather have the VFS layer just fill in all the
default values and the stuff it already knows about, and then maybe
have the filesystem callback fill in the ones the vfs *doesn't* know
about, but whatever.

But then you can *also* query odd things like mounts that aren't even
visible, and the topology, and completely random error state.

So it has this very complex "random structures of random things"
implementation. It's a huge sign of over-design and "I don't know what
the hell I want to expose, so I'll make this generic thing that can
expose anything, and then I start adding random fields".

Some things are per-file, some things are per-mount, and some things
are per-namespace and cross mount boundaries.

And honestly, the "random binary interfaces" just turns me off a lot.

A simple and straightforward struct? Sure. But this random "whatever
goes" thing? No.

                 Linus
