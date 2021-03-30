Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654BB34EB52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhC3O5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbhC3O47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:56:59 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F129C0613DA;
        Tue, 30 Mar 2021 07:56:37 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n21so16731865ioa.7;
        Tue, 30 Mar 2021 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwUx1+LkWctBpaozvKqMfw2ss6qsxcv4/PUE+SqxW1U=;
        b=Gnfl/3eaAEqpUPrqr3+bokmGp67qU1MUKDq+TQVmKhAE7PDry1HwPp1jIIYKjnwQYV
         6poKGd4XDDK45/LKNKhxhSpz9lrjP+stsJG7hnvurdnteFj4TAOQ5I8ccajkTdkRcJsU
         SNc132CAQpR8+R6EQnBkZvPJyi4P4fHZAhIM3YNLmq+O8+IT1Gf8t4WCwEX/KMZuvrz9
         npo16jcZZXhozTSm+YQnh3Zbb/yElkT6gbQpWA39CbpNfMqHxcc9QX+pb+F9r02vRNWI
         oJqgSHvokdobX4EIMQ8ZYNqFiJVr7Jy4dVYY8kymaAKR0ziAvCiPgpmteL/sy/dANccK
         G3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwUx1+LkWctBpaozvKqMfw2ss6qsxcv4/PUE+SqxW1U=;
        b=EerkxTxRZUQrTE9LnvQ+/aQeTOO5IL4mQ/b7lkbWc6zMEFIwK+eecJUFzIi9uBJoAW
         hQroZ+CknWynBSRihxxfjevhUInScV7E4x/Vpvtuz8ZE0dSUrtznIe/JsP84o5bNNAX1
         +Ywwpz1rE+LQ+AcyDFywEoO5bOXkt7hh+bpync6j9mHqpXIbdi7w+bdRu3H8AXEjDbaK
         imq3zkw31hLgu12B+/kL0CxYlF542eB7CZPORfyg4vLO3exn97Qq4/wwJlCuMSu408Xx
         Eilgwv4s/BkMPwiYwe2V4uWLitIpTM4rS1UbDC5av4Y7wC9ExAjrbyoMt6rC0xBbei+E
         YS8Q==
X-Gm-Message-State: AOAM531oJM8fFRflDdiap3MqSacoo9Skq+wU0ng6uxu3LOGYjFkR0OTl
        ktz/HJ2LGSrrBSkyHbEH5MbgzM6iXLpfgqWJ8bc=
X-Google-Smtp-Source: ABdhPJy7cqczeXSriXXbWyEqNUZsJlykvwAxAiuHWiVDWlXkT+/7t0xGHB/Km/udA8UX/ICE2kIcFkO+qwe/Xv8DVVY=
X-Received: by 2002:a02:ccb2:: with SMTP id t18mr29640629jap.123.1617116196763;
 Tue, 30 Mar 2021 07:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
 <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein> <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein>
In-Reply-To: <20210330141703.lkttbuflr5z5ia7f@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Mar 2021 17:56:25 +0300
Message-ID: <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark mask
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > My example probably would be something like:
> > >
> > > mount -t ext4 /dev/sdb /A
> > >
> > > 1. FAN_MARK_MOUNT(/A)
> > >
> > > mount --bind /A /B
> > >
> > > 2. FAN_MARK_MOUNT(/B)
> > >
> > > mount -t ecryptfs /B /C
> > >
> > > 3. FAN_MARK_MOUNT(/C)
> > >
> > > let's say I now do
> > >
> > > touch /C/bla
> > >
> > > I may be way off here but intuitively it seems both 1. and 2. should get
> > > a creation event but not 3., right?
> > >
> >
> > Why not 3?
> > You explicitly set a mark on /C requesting to be notified when
> > objects are created via /C.
>
> Sorry, that was a typo. I meant to write, both 2. and 3. should get a
> creation event but not 1.
>
> >
> > > But with your proposal would both 1. and 2. still get a creation event?
> > >
>
> Same obvious typo. The correct question would be: with your proposal do
> 2. and 3. both get an event?
>
> Because it feels like they both should since /C is mounted on top of /B
> and ecryptfs acts as a shim. Both FAN_MARK_MOUNT(/B) and
> FAN_MARK_MOUNT(/C) should get a creation event after all both will have
> mnt->mnt_fsnotify_marks set.
>

Right.

There are two ways to address this inconsistency:
1. Change internal callers of vfs_ helpers to use a private mount,
    as you yourself suggested for ecryptfs and cachefiles
2. Add fsnotify_path_ hooks at caller site - that would be the
    correct thing to do for nfsd IMO

> >
> > They would not get an event, because fsnotify() looks for CREATE event
> > subscribers on inode->i_fsnotify_marks and inode->i_sb_s_fsnotify_marks
> > and does not find any.
>
> Well yes, but my example has FAN_MARK_MOUNT(/B) set. So fanotify
> _should_ look at
>             (!mnt || !mnt->mnt_fsnotify_marks) &&
> and see that there are subscribers and should notify the subscribers in
> /B even if the file is created through /C.
>
> My point is with your solution this can't be handled and I want to make
> sure that this is ok. Because right now you'd not be notified about a
> new file having been created in /B even though mnt->mnt_fsnotify_marks
> is set and the creation went through /B via /C.
>

If you are referring to the ecryptfs use case specifically, then I think it is
ok. After all, whether ecryptfs uses a private mount clone or not is not
something the user can know.

> _Unless_ we switch to an argument like overlayfs and say "This is a
> private mount which is opaque and so we don't need to generate events.".
> Overlayfs handles this cleanly due to clone_private_mount() which will
> shed all mnt->mnt_fsnotify_marks and ecryptfs should too if that is the
> argument we follow, no?
>

There is simply no way that the user can infer from the documentation
of FAN_MARK_MOUNT that the event on /B is expected when /B is
underlying layer of ecryptfs or overlayfs.
It requires deep internal knowledge of the stacked fs implementation.
In best case, the user can infer that she MAY get an event on /B.
Some users MAY also expect to get an event on /A because they do not
understand the concept of bind mounts...
Clone a mount ns and you will get more lost users...

> >
> > The vfs_create() -> fsnotify_create() hook passes data_type inode to
> > fsnotify() so there is no fsnotify_data_path() to extract mnt event
> > subscribers from.
>
> Right, that was my point. You don't have the mnt context for the
> underlying fs at a time when e.g. call vfs_link() which ultimately calls
> fsnotify_create/link() which I'm saying might be a problem.
>

It's a problem. If it wasn't a problem I wouldn't need to work around it ;-)

It would be a problem if people think that the FAN_MOUNT_MARK
is a subtree mark, which it certainly is not. And I have no doubt that
as Jan said, people really do want a subtree mark.

My question to you with this RFC is: Does the ability to subscribe to
CREATE/DELETE/MOVE events on a mount help any of your use
cases? With or without the property that mount marks are allowed
inside userns for idmapped mounts.

Note that if we think the semantics of this are useful for container
managers, but too complex for most mortals, we may decide to
restrict the ability to subscribe to those events to idmapped mounts(?).

Thanks,
Amir.
