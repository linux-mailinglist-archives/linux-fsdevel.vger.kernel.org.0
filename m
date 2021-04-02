Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98087352761
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhDBIUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBIUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:20:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28081C0613E6;
        Fri,  2 Apr 2021 01:20:53 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z136so4669057iof.10;
        Fri, 02 Apr 2021 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJl75nhg6bSonre9Y9Cr7mLKaSkxWxSNyXNl5KneNuk=;
        b=CSETIM8JMIfF9yIxZnyIs8R58vGrVKfTl9qeYIPCUoXP0csSm4RSTEZh6Ylwqy3nxD
         Jq5rMeOsQ7N7jIRHQEVNbBj/9ZT3m4qo/nEnK2AURsXIMVCYvIITKx10OVBZ2kPpHC/K
         BhY0QU18yJHHWaf4dywjyQzHXjXiQ876k2EqygzG9qdsbfA8NXxavj2DY595iz6a6T8N
         7PQIPthV/1bWErCcDYytLRvdYy1dgOtsT5XrgVw7m+fkuOn43QjcNrGd/z1GpvdyuwSF
         HL+IY6p0Qf8r3Os9qs/5JOXE6nZLD/15i53IbyqMTiWd0l87PGo9jGzJwc917Bx1gTD+
         wvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJl75nhg6bSonre9Y9Cr7mLKaSkxWxSNyXNl5KneNuk=;
        b=TqBk3+jdgbt13kENOOb7gl2tpujItn3rJMQdkdBw+F9rF4m8qa0oKe1cNJOCJBK7DX
         6N+qnMHkZFvKYNZtJL0sP1FfeptyL6BPb/B2q88mNySr5Ei1tLU1UnB5U5I3cCXQK05o
         YoZGqYxH7+86oH8S6p70ZNvJi40mPiaUlv1Y7rVPEdT9dYTIog/jAxdxrkDjaDB/E80d
         US+4t6u27X58BK+PT/wN/3s2QeCutcqNAktFoYo9bhg3Ajvjo1p3JqYHQTh3Nt3IAW5H
         CU2BE/+/kg1cVtnEFq4sWwilw+piE3tg/d/el094kLLxRiro/x6Djlf7mycZXnyamvSE
         kcAQ==
X-Gm-Message-State: AOAM533SREy+r2+8XbPrBHuLaeZZp7k3jisGo6nzvu6QxqSsDW/qrq5M
        jhHnF0Y6JR0wWn8v11DLIcuAULk/ca/t8cySE6o=
X-Google-Smtp-Source: ABdhPJxSKzpx7r/92aVr0/DtAKqnXnbbRhz/vuvoKiwu2CV+xEGBOV2syNbc9R7IAswNggC7TyJ+l/gLiFZ4hPyT7c8=
X-Received: by 2002:a05:6638:218b:: with SMTP id s11mr11736595jaj.81.1617351652502;
 Fri, 02 Apr 2021 01:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein> <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein> <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 2 Apr 2021 11:20:41 +0300
Message-ID: <CAOQ4uxgE_bCK_URCe=_4mBq4_72bazM86D859Kzs_ZoWyKJRhw@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tyler Hicks <code@tyhicks.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This is not the case with nfsd IMO.
> With nfsd, when "exporting" a path to clients, nfsd is really exporting
> a specific mount (and keeping that mount busy too).
> It can even export whole mount topologies.
>
> But then again, getting the mount context in every nfsd operation
> is easy, there is an export context to client requests and the export
> context has the exported path.
>
> Therefore, nfsd is my only user using the vfs helpers that is expected
> to call the fsnotify path hooks (other than syscalls).
>
[...]
>
> I've done something similar to that. I think it's a bit cleaner,
> but we can debate on the details later.
> Pushed POC to branch fsnotify_path_hooks.
>
> At the moment, create, delete, move and move_self are supported
> for syscalls and helpers are ready for nfsd.
>
> The method I used for rename hook is a bit different than
> for other hooks, because other hooks are very easy to open code
> while rename is complex so I create a helper for nfsd to call.
>

I pushed the nfsd example code as well (only compile tested):

https://github.com/amir73il/linux/commits/fsnotify_path_hooks

Now all that is left is dealing with notify_change() and with
vfs_{set,remove}xattr().

Nice thing about vfs_{set,remove}xattr() is that they already have
several levels of __vfs_ helpers and nfsd already calls those, so
we can hoist fsnotify_xattr() hooks hooks up from the __vfs_xxx
helpers to the common vfs_xxx helpers and add fsnotify hooks to
the very few callers of __vfs_ helpers.

nfsd is consistently calling __vfs_{set,remove}xattr_locked() which
do generate events, but ecryptfs mixes __vfs_setxattr_locked() with
__vfs_removexattr(), which does not generate event and does not
check permissions - it looks like an oversight.

The thing is, right now __vfs_setxattr_noperm() generates events,
but looking at all the security/* callers, it feels to me like those are
very internal operations and that "noperm" should also imply "nonotify".

To prove my point, all those callers call __vfs_removexattr() which
does NOT generate an event.

Also, I *think* the EVM setxattr is something that usually follows
another file data/metadata change, so some event would have been
generated by the original change anyway.

Mimi,

Do you have an opinion on that?

The question is if you think it is important for an inotify/fanotify watcher
that subscribed to IN_ATTRIB/FAN_ATTRIB events on a file to get an
event when the IMA security blob changes.

Thanks,
Amir.
