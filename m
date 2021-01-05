Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A762EA5BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 08:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbhAEHMQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 02:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbhAEHMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:12:15 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D01C061793;
        Mon,  4 Jan 2021 23:11:35 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id x15so27729678ilq.1;
        Mon, 04 Jan 2021 23:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fDC7QQ+tqOU87CZCpxb1J4dIdKIq1eloIxFZr+S9xg=;
        b=ghlTMQ1faXr+h0xbllew/KvAL1OnHTMjCybq7tQz5gvGYuraYjThdZP7lfJXOP12QQ
         3lD7Qc7mBbUIzJ5GTsGJfF4UsrXsh9+rp80wd8MZhkY83qZo2MvrLTLIHZeK+vFDp5m8
         Kq90a8PQwNBsK925Q18Uq5s8dJYLRmw/CQMCZGPlEvhnrxjR7Fw/6l3W0fKV0r2F57gb
         Jbb0gF4U28W3bHpCjuEgvHznt31WZeskQbYvErCKxYeoZyaLXOxJ8pN0Xwei7qMb+CBX
         7w5pQqkXVlqrkHrSMj6KZQwa2wwR6o7UQirzMJV1/VgxWyhgXB9B8PUlucVmYSfzeDjl
         nAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fDC7QQ+tqOU87CZCpxb1J4dIdKIq1eloIxFZr+S9xg=;
        b=PtHhDg8rTDXt8CbJfn34fdh4+Fqm50lsoiOobQ4z5EZJTJgR9Ypx0cIdPyqaYI/ttq
         m1RNkWf546dpAS90vFgAte7BQVfcnVoLJZko66WitfV722Ab6RBAAWWSPqq+pywHvr3C
         8Ev3zcnml8uSZStpn7SzUUHOGnUj8kGAMQXUG3PUH6WQ/ec4XXCXJHYWLHcK9Xr79wBN
         s2oUn4mOHbx+j4gSFPSX6Cewu0CU5VdYcHSN6GhtnwuR9Fpkc+Verb49EZykeFP++hoX
         h9Xl22m5Wi5cZhiSQfu+D1tyRjS6LkHZ+gzq74OiW3dH9rvuZeth5aSws/MX1bNpnqYS
         lDJg==
X-Gm-Message-State: AOAM533rIuE+fLdOw3kH8l12VZ7tkXlgbXH3LpljaXX444BKpoZkUL+K
        jjYj1w+kpFjLe9QseQO72o02sQwmJDtkZmjiCrtGEJYT1MQ=
X-Google-Smtp-Source: ABdhPJypOXb4AHmuNXG9iPA0yHFBbz9rXRi6gaK8jfGwkwT3HQTNnqjmxwK96QwnlboERsoGKLQRvILb3zjOY3r3RaU=
X-Received: by 2002:a05:6e02:1a8e:: with SMTP id k14mr76152018ilv.275.1609830694924;
 Mon, 04 Jan 2021 23:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20201223185044.GQ874@casper.infradead.org> <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org> <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org> <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20210104151424.GA63879@redhat.com> <CAOQ4uxgiC5Wm+QqD+vbmzkFvEqG6yvKYe_4sR7ZUVfu-=Ys9oQ@mail.gmail.com>
 <20210104154015.GA73873@redhat.com> <CAOQ4uxhYXeUt2iggM3oubdgr91QPNhUg2PdN128gRvR3rQoy1Q@mail.gmail.com>
 <20210104224447.GG63879@redhat.com>
In-Reply-To: <20210104224447.GG63879@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Jan 2021 09:11:23 +0200
Message-ID: <CAOQ4uxh07Rqj88PDNVqzq9D28rp+Z2aRtPvNoapeaH5iZWJr4Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >
> > What I would rather see is:
> > - Non-volatile: first syncfs in every container gets an error (nice to have)
>
> I am not sure why are we making this behavior per container. This should
> be no different from current semantics we have for syncfs() on regular
> filesystem. And that will provide what you are looking for. If you
> want single error to be reported in all ovleray mounts, then make
> sure you have one fd open in each mount after mount, then call syncfs()
> on that fd.
>

Ok.

> Not sure why overlayfs behavior/semantics should be any differnt
> than what regular filessytems like ext4/xfs are offering. Once we
> get page cache sharing sorted out with xfs reflink, then people
> will not even need overlayfs and be able to launch containers
> just using xfs reflink and share base image. In that case also
> they will need to keep an fd open per container they want to
> see an error in.
>
> So my patches exactly provide that. syncfs() behavior is same with
> overlayfs as application gets it on other filesystems. And to me
> its important to keep behavior same.
>
> > - Volatile: every syncfs and every fsync in every container gets an error
> >   (important IMO)
>
> For volatile mounts, I agree that we need to fail overlayfs instance
> as soon as first error is detected since mount. And this applies to
> not only syncfs()/fsync() but to read/write and other operations too.
>
> For that we will need additional patches which are floating around
> to keep errseq sample in overlay and check for errors in all
> paths syncfs/fsync/read/write/.... and fail fs.

> But these patches build on top of my patches.

Here we disagree.

I don't see how Jeff's patch is "building on top of your patches"
seeing that it is perfectly well contained and does not in fact depend
on your patches.

And I do insist that the fix for volatile mounts syncfs/fsync error
reporting should be applied before your patches or at the very least
not heavily depend on them.

volatile mount was introduced in fresh new v5.10, which is also an
LTS kernel. It would be inconsiderate of volatile mount users and developers
to make backporting that fix to v5.10.y any harder than it should be.

> My patches don't solve this problem of failing overlay mount for
> the volatile mount case.
>

Here we agree.

> >
> > This is why I prefer to sample upper sb error on mount and propagate
> > new errors to overlayfs sb (Jeff's patch).
>
> Ok, I think this is one of the key points of the whole discussion. What
> mechanism should be used to propagate writeback errors through overlayfs.
>
> A. Propagate errors from upper sb to overlay sb.
> B. Leave overlay sb alone and use upper sb for error checks.
>
> We don't have good model to propagate errors between super blocks,
> so Jeff preferred not to do error propagation between super blocks
> for regular mounts.
>
> https://lore.kernel.org/linux-fsdevel/bff90dfee3a3392d67a4f3516ab28989e87fa25f.camel@kernel.org/
>
> If we are not defining new semantics for syncfs() for overlayfs, then
> I can't see what's the advantage of coming up with new mechanism to
> propagate errors to overlay sb. Approach B should work just fine and
> provide the syncfs() semantics we want for overlayfs (Same semantics
> as other filesystems).
>

Ok. I am on board with B.

Philosophically. overlayfs model is somewhere between "passthrough"
and "proxy" when handling pure upper files and as overlayfs evolves,
it steadily moves towards the "proxy" model, with page cache and
writeback being the largest remaining piece to convert.

So I concede that as long as overlayfs writeback is mostly passthrough,
syncfs might as well be passthrough to upper fs as well.

Thanks,
Amir.
