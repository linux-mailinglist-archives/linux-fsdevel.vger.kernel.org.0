Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C623967A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 20:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhEaSPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhEaSOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 14:14:51 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A7CC061574;
        Mon, 31 May 2021 11:13:11 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q7so6917031iob.4;
        Mon, 31 May 2021 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFCI40AjRp7xK4jAmmeZBTUYrshCOhFkOLR5Jq8ppK8=;
        b=Z7X9WsEZwKwNFoH072lzgnyzTLXoFJjLBT0uOrFTw9nG0REISt6lgy67NrlVlP0FFv
         jo5wBlsArRihU9wZcKnbYi/LfvhzHIJ2vAk+rjrRO8qEq9ZX4HoujmsO6j2AblrATvUn
         guiYR3bJfHNsSRjmwCeOpDbvN3VORniaRIkRFql1fVQ5S0GZfvj6vElP6oI5THGgToai
         TiMfZheObF8g3vmPewV2fTEb64f7F0wDAVbHy4waDLajr/sCuUYznxkHJk3wFccsykZn
         8ClW4pYc7Eq2JZiKDF39SYkudRWrAKwl0UdQsh6KnYdd5d4saoktBIwWO+PZ4/17qTym
         JA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFCI40AjRp7xK4jAmmeZBTUYrshCOhFkOLR5Jq8ppK8=;
        b=LUnE57csXG6mJXK6g2ZPrKPYnLpJ7UnEt4drURFtVrS9o/D34YcDrhLU8UV4QT3qdm
         WRPxvT0CJPXtZB2comlQhwhK2k4Pg/C7MZTaHpisZDJSACFO89V4ownn0RWbga/hd8Ij
         ecfTkkHkbNyqjYExuVLqDOBt06keHITWdFfFj4oKOVoPhkxuz/HcCbq5I7PBRi+IHaLM
         8VUNnCGEofNIwTazQWT8OiVMbH8hSzuJKPr4Rd+SqXfRWZpmcIlJfT6Tn4MiqdIig9rZ
         uMJMRximvYW2I6R65eAZNhqvJaDmEmzgiXksz2fh/CJPoeTsPjLnxwMGrawkWyb1HzSv
         ghUQ==
X-Gm-Message-State: AOAM531kYwsR4CVHzyPWPeJY2qkQqCQ7tKMSirnMQfpqlDWOaWzcI/47
        F/cayuXA5NY57DE3oBiStQ8u0l1yCjgRc3OnJrU=
X-Google-Smtp-Source: ABdhPJw0+6i76a5XAN1J6KWNlSZBRJgF3DAVEHGKG1V/y/KOsPL5Y22uLwnCx+BUMj/7july+2KHRrMwbrUpbJ3566U=
X-Received: by 2002:a6b:3119:: with SMTP id j25mr17360784ioa.64.1622484790608;
 Mon, 31 May 2021 11:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxgKr75J1YcuYAqRGC_C5H_mpCt01p5T9fHSuao_JnxcJA@mail.gmail.com>
 <CAJfpegviT38gja+-pE+5DCG0y9n3GUv4wWG_r3XmSWW6me88Cw@mail.gmail.com>
 <CAOQ4uxjNcWCfKLvdq2=TM5fE5RaBf+XvnsP6v_Q6u3b1_mxazw@mail.gmail.com> <CAJfpeguOLLV94Bzs7_JNOdZZ+6p-tcP7b1PXrQY4qWPxXKosnA@mail.gmail.com>
In-Reply-To: <CAJfpeguOLLV94Bzs7_JNOdZZ+6p-tcP7b1PXrQY4qWPxXKosnA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 31 May 2021 21:12:59 +0300
Message-ID: <CAOQ4uxiJRii2FQrX51ZDmw_kGWTNvL21J7=Ow_z6Th_O-aruDA@mail.gmail.com>
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

On Mon, May 31, 2021 at 5:11 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Sat, 29 May 2021 at 18:05, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Sep 23, 2020 at 2:12 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Wed, Sep 23, 2020 at 11:57 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > On Wed, Sep 23, 2020 at 4:49 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > > I think that the proper was to implement reliable persistent file
> > > > > > handles in fuse/virtiofs would be to add ENCODE/DECODE to
> > > > > > FUSE protocol and allow the server to handle this.
> > > > >
> > > > > Max Reitz (Cc-d) is currently looking into this.
> > > > >
> > > > > One proposal was to add  LOOKUP_HANDLE operation that is similar to
> > > > > LOOKUP except it takes a {variable length handle, name} as input and
> > > > > returns a variable length handle *and* a u64 node_id that can be used
> > > > > normally for all other operations.
> > > > >
> >
> > Miklos, Max,
> >
> > Any updates on LOOKUP_HANDLE work?
> >
> > > > > The advantage of such a scheme for virtio-fs (and possibly other fuse
> > > > > based fs) would be that userspace need not keep a refcounted object
> > > > > around until the kernel sends a FORGET, but can prune its node ID
> > > > > based cache at any time.   If that happens and a request from the
> > > > > client (kernel) comes in with a stale node ID, the server will return
> > > > > -ESTALE and the client can ask for a new node ID with a special
> > > > > lookup_handle(fh, NULL).
> > > > >
> > > > > Disadvantages being:
> > > > >
> > > > >  - cost of generating a file handle on all lookups
> > > >
> > > > I never ran into a local fs implementation where this was expensive.
> > > >
> > > > >  - cost of storing file handle in kernel icache
> > > > >
> > > > > I don't think either of those are problematic in the virtiofs case.
> > > > > The cost of having to keep fds open while the client has them in its
> > > > > cache is much higher.
> > > > >
> > > >
> > > > Sounds good.
> > > > I suppose flock() does need to keep the open fd on server.
> > >
> > > Open files are a separate issue and do need an active object in the server.
> > >
> > > The issue this solves  is synchronizing "released" and "evicted"
> > > states of objects between  server and client.  I.e. when a file is
> > > closed (and no more open files exist referencing the same object) the
> > > dentry refcount goes to zero but it remains in the cache.   In this
> > > state the server could really evict it's own cached object, but can't
> > > because the client can gain an active reference at any time  via
> > > cached path lookup.
> > >
> > > One other solution would be for the server to send a notification
> > > (NOTIFY_EVICT) that would try to clean out the object from the server
> > > cache and respond with a FORGET if successful.   But I sort of like
> > > the file handle one better, since it solves multiple problems.
> > >
> >
> > Even with LOOKUP_HANDLE, I am struggling to understand how we
> > intend to invalidate all fuse dentries referring to ino X in case the server
> > replies with reused ino X with a different generation that the one stored
> > in fuse inode cache.
> >
> > This is an issue that I encountered when running the passthrough_hp test,
> > on my filesystem. In tst_readdir_big() for example, underlying files are being
> > unlinked and new files created reusing the old inode numbers.
> >
> > This creates a situation where server gets a lookup request
> > for file B that uses the reused inode number X, while old file A is
> > still in fuse dentry cache using the older generation of real inode
> > number X which is still in fuse inode cache.
> >
> > Now the server knows that the real inode has been rused, because
> > the server caches the old generation value, but it cannot reply to
> > the lookup request before the old fuse inode has been invalidated.
> > IIUC, fuse_lowlevel_notify_inval_inode() is not enough(?).
> > We would also need to change fuse_dentry_revalidate() to
> > detect the case of reused/invalidated inode.
> >
> > The straightforward way I can think of is to store inode generation
> > in fuse_dentry. It won't even grow the size of the struct.
> >
> > Am I over complicating this?
>
> In this scheme the generation number is already embedded in the file
> handle.  If LOOKUP_HANDLE returns a nodeid that can be found in the
> icache, but which doesn't match the new file handle, then the old
> inode will be marked bad and a new one allocated.
>
> Does that answer your worries?  Or am I missing something?

It affirms my understanding of the future implementation, but
does not help my implementation without protocol changes.
I thought I could get away without LOOKUP_HANDLE for
underlying fs that is able to resolve by ino, but seems that I still have an
unhandled corner case, so will need to add some kernel patch.
Unless there is already a way to signal from server to make the
inode bad in a synchronous manner (I did not find any) before
replying to LOOKUP with a new generation of the same ino.

Any idea about the timeline for LOOKUP_HANDLE?
I may be able to pick this up myself if there is no one actively
working on it or plans for anyone to make this happen.

Thanks,
Amir.
