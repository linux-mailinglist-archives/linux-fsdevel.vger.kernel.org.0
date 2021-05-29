Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805A5394D13
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 May 2021 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhE2QGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 May 2021 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhE2QGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 May 2021 12:06:52 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A693C061574;
        Sat, 29 May 2021 09:05:15 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id j30so6065583ila.5;
        Sat, 29 May 2021 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeCTtwbtJUiWSQAeIGeQfdmWGqZFg8Y6F6ODdUcAxyQ=;
        b=NfLMvDaTnZVbpmuFivIg/42Em+xIjAQ6JEDx1caupZNeLa4nEXUXKhRggGayEUxJsC
         KDNOqZXkXcha8IKsR2lRWmtQX2enI8P7PGmclb4tFcL53QqEyGgA8T3dQ4HM6DZzEzD5
         vOwWYTFNJEdDU7Dvblw/sz6v2cx/+RQ/v8UuOETJzpOydOvoaeDBNaic5b0WPxbpjMsF
         +3puNnMHxjeI/PGW1ZBhwhb+E2msn7iiwWYWVzIQrvhxro4EPn4Yh4y7EeYMM1Zw3RI1
         7rZ3yWdgCSU4JTo+vrvgiupz7OqPVw50pM1qlLFL0sv5QzRqhWBOd4Wx/A9eeS4u/Umm
         1WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeCTtwbtJUiWSQAeIGeQfdmWGqZFg8Y6F6ODdUcAxyQ=;
        b=hrQx8VlDuabFLGdZm8sp6G9Qu1Eamh1GeAn273pPCagzgu2BqFK3nnojOHwq9k67qH
         drYayS2KXIQGAUY9vSyOwutDtPzf7FLv0fiis34UZEKvALEx3gBVyTQu8ICk2HZX8ewQ
         MFzdT3jfQtr07C2YwKViMsbOwn4ee0ciYubWl8zt8bLa24et4kjZ4sDAzVVWA5J3fxKx
         yGaJLRXcDJsGwV6GiHsbz/szvDmskN01fGZEsSiV0aIodaU6D2i4MzOUshWkvtCqeXQL
         newRn67QhAjvHZvxD/fb8Ma4ibxCmvpBgN5Xr9EMNsiviaoRM9UhUfMcx9V3jkcSZdYN
         HPAA==
X-Gm-Message-State: AOAM530QC0qt7lkbOP108ADudlxhyN/UeCjL9S+AQkMvZ4noiP7Z0Zig
        gjpRULAM/xK3Lo/SJPOjjQtO67UcuZJFwpTg6H1YE0P9eTo=
X-Google-Smtp-Source: ABdhPJzYfqm88FcV5qakZY1eh0A74PUChsz2A7bm6WNQlE9GniDhfI5RcYYqUTRGEUAgv0EDJSL8WAYyxhL6wI8gMU8=
X-Received: by 2002:a92:cc43:: with SMTP id t3mr11751892ilq.250.1622304314595;
 Sat, 29 May 2021 09:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxgKr75J1YcuYAqRGC_C5H_mpCt01p5T9fHSuao_JnxcJA@mail.gmail.com> <CAJfpegviT38gja+-pE+5DCG0y9n3GUv4wWG_r3XmSWW6me88Cw@mail.gmail.com>
In-Reply-To: <CAJfpegviT38gja+-pE+5DCG0y9n3GUv4wWG_r3XmSWW6me88Cw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 29 May 2021 19:05:03 +0300
Message-ID: <CAOQ4uxjNcWCfKLvdq2=TM5fE5RaBf+XvnsP6v_Q6u3b1_mxazw@mail.gmail.com>
Subject: Re: virtiofs uuid and file handles
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 2:12 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Sep 23, 2020 at 11:57 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Wed, Sep 23, 2020 at 4:49 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > > I think that the proper was to implement reliable persistent file
> > > > handles in fuse/virtiofs would be to add ENCODE/DECODE to
> > > > FUSE protocol and allow the server to handle this.
> > >
> > > Max Reitz (Cc-d) is currently looking into this.
> > >
> > > One proposal was to add  LOOKUP_HANDLE operation that is similar to
> > > LOOKUP except it takes a {variable length handle, name} as input and
> > > returns a variable length handle *and* a u64 node_id that can be used
> > > normally for all other operations.
> > >

Miklos, Max,

Any updates on LOOKUP_HANDLE work?

> > > The advantage of such a scheme for virtio-fs (and possibly other fuse
> > > based fs) would be that userspace need not keep a refcounted object
> > > around until the kernel sends a FORGET, but can prune its node ID
> > > based cache at any time.   If that happens and a request from the
> > > client (kernel) comes in with a stale node ID, the server will return
> > > -ESTALE and the client can ask for a new node ID with a special
> > > lookup_handle(fh, NULL).
> > >
> > > Disadvantages being:
> > >
> > >  - cost of generating a file handle on all lookups
> >
> > I never ran into a local fs implementation where this was expensive.
> >
> > >  - cost of storing file handle in kernel icache
> > >
> > > I don't think either of those are problematic in the virtiofs case.
> > > The cost of having to keep fds open while the client has them in its
> > > cache is much higher.
> > >
> >
> > Sounds good.
> > I suppose flock() does need to keep the open fd on server.
>
> Open files are a separate issue and do need an active object in the server.
>
> The issue this solves  is synchronizing "released" and "evicted"
> states of objects between  server and client.  I.e. when a file is
> closed (and no more open files exist referencing the same object) the
> dentry refcount goes to zero but it remains in the cache.   In this
> state the server could really evict it's own cached object, but can't
> because the client can gain an active reference at any time  via
> cached path lookup.
>
> One other solution would be for the server to send a notification
> (NOTIFY_EVICT) that would try to clean out the object from the server
> cache and respond with a FORGET if successful.   But I sort of like
> the file handle one better, since it solves multiple problems.
>

Even with LOOKUP_HANDLE, I am struggling to understand how we
intend to invalidate all fuse dentries referring to ino X in case the server
replies with reused ino X with a different generation that the one stored
in fuse inode cache.

This is an issue that I encountered when running the passthrough_hp test,
on my filesystem. In tst_readdir_big() for example, underlying files are being
unlinked and new files created reusing the old inode numbers.

This creates a situation where server gets a lookup request
for file B that uses the reused inode number X, while old file A is
still in fuse dentry cache using the older generation of real inode
number X which is still in fuse inode cache.

Now the server knows that the real inode has been rused, because
the server caches the old generation value, but it cannot reply to
the lookup request before the old fuse inode has been invalidated.
IIUC, fuse_lowlevel_notify_inval_inode() is not enough(?).
We would also need to change fuse_dentry_revalidate() to
detect the case of reused/invalidated inode.

The straightforward way I can think of is to store inode generation
in fuse_dentry. It won't even grow the size of the struct.

Am I over complicating this?

Thanks,
Amir.
