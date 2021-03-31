Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350C53501E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhCaOH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhCaOHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:07:00 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0492C061574;
        Wed, 31 Mar 2021 07:06:59 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e186so2699053iof.7;
        Wed, 31 Mar 2021 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3E9Z8eKJ8Vq9NuKJrOX7KbEBV7YVGmqZNK1yfgNnDQ=;
        b=K0joCmQURSlzwnSuZ7WZ4LYmbYs58zuzxchKTjWYQINq8iUkY99sWq5wVOp3nBzxgJ
         /2xLGyjGVz6LosBwrssf9pOV+gPJc0jTJF2JyaCYbH2Xg9f9g5u2IvqpZuw4Ul4f4let
         HRMnOZBSrI3O0yp3UDDRmU4oIN3uT3ZeWBOsKgkQJPUKe1Ttjn3IeGxp9qVGM7oVYTRE
         fc7krXOdPdLAb9sDWGa+3h+bR6uIXY6qE42a5NnMLevIXQJmvZdLYrDKayaU21wDBvQS
         C0GEVFd4vIxpNvO8mnI69LqdzedvtvIBAEGw4tnulLjrn8wWMWfRif2rhSANHNMcTa4G
         kAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3E9Z8eKJ8Vq9NuKJrOX7KbEBV7YVGmqZNK1yfgNnDQ=;
        b=bj+ix/9+QKzcBBTqyzPtQlcq1NDUrSk5i6hT/kMXiGhy3gt3a/rcGG1bNjmlgc8AbN
         ug7kIZBdfgCBtZv+JcDXesD8YxJwI9KKVYK8DWhgeAkjK7AaHrIW+0Qe89HC0ncsZ6oZ
         djjwUGHJ48GI8BN7jmzbTmaJ7dYQy2jIZ7YRwGxRmhgn+qlBXUOlOKDApKwgOqlJLP/6
         l/HgAqIg66e+EdLGJ/P3Ohi4Qf9rTUylo+tyNNzgwGbbtrW3ELFYW7+CRhx5hHYmVv/O
         uywQX+9GURYDY3ffIPjQlUkXp3V9kina2warHGDxKK/g3VzjJcqx0A1nbSYCn5zQ4mpD
         /FLA==
X-Gm-Message-State: AOAM530BXUBRos8SjOOQlrzr59pJ0oAwDLzoTidI9eeRTcxGmpJsIyUC
        IOATqCxC6q7EyzQ2qjkBnl4cCg6z6Ve5rL1xrO8=
X-Google-Smtp-Source: ABdhPJxeJuuHGA/1fyNd762cgDnteA9qBX1t2x8MxUn2jQN2imxu/E7iX2u91cSUDihIDA3nSKsqJYbKDIPOZD+wfuk=
X-Received: by 2002:a05:6638:218b:: with SMTP id s11mr3132366jaj.81.1617199619426;
 Wed, 31 Mar 2021 07:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
 <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein> <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein> <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz>
In-Reply-To: <20210331125412.GI30749@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 31 Mar 2021 17:06:47 +0300
Message-ID: <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark mask
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > As long as "exp_export: export of idmapped mounts not yet supported.\n"
> > I don't think it matters much.
> > It feels like adding idmapped mounts to nfsd is on your roadmap.
> > When you get to that we can discuss adding fsnotify path hooks to nfsd
> > if Jan agrees to the fsnotify path hooks concept.
>
> I was looking at the patch and thinking about it for a few days already. I
> think that generating fsnotify event later (higher up the stack where we
> have mount information) is fine and a neat idea. I just dislike the hackery
> with dentry flags.

Me as well. I used this hack for fast POC.

If we stick with the dual hooks approach, we will have to either pass a new
argument to vfs helpers or use another trick:

Convert all the many calls sites that were converted by Christian to:
   vfs_XXX(&init_user_ns, ...
because they do not have mount context, to:
   vfs_XXX(NULL, ...

Inside the vfs helpers, use init_user_ns when mnt_userns is NULL,
but pass the original mnt_userns argument to fsnotify_ns_XXX hooks.
A non-NULL mnt_userns arg means "path_notify" context.
I have already POC code for passing mnt_userns to fsnotify hooks [1].

I did not check if this assumption always works, but there seems to
be a large overlap between idmapped aware callers and use cases
that will require sending events to a mount mark.

> Also I'm somewhat uneasy that it is random (from
> userspace POV) when path event is generated and when not (at least that's
> my impression from the patch - maybe I'm wrong). How difficult would it be
> to get rid of it? I mean what if we just moved say fsnotify_create() call
> wholly up the stack? It would mean more explicit calls to fsnotify_create()
> from filesystems - as far as I'm looking nfsd, overlayfs, cachefiles,
> ecryptfs. But that would seem to be manageable.  Also, to maintain sanity,

1. I don't think we can do that for all the fsnotify_create() hooks, such as
    debugfs for example
2. It is useless to pass the mount from overlayfs to fsnotify, its a private
    mount that users cannot set a mark on anyway and Christian has
    promised to propose the same change for cachefiles and ecryptfs,
    so I think it's not worth the churn in those call sites
3. I am uneasy with removing the fsnotify hooks from vfs helpers and
    trusting that new callers of vfs_create() will remember to add the high
    level hooks, so I prefer the existing behavior remains for such callers

> we would probably have to lift generation of all directory events like
> that. That would be already notable churn but maybe doable... I know you've
> been looking at similar things in the past so if you are aware why this
> won't fly, please tell me.

I agree with that and since I posted this RFC patch, I have already added
support for FAN_DELETE and FAN_MOVE_SELF [2].
This was easy - not much churn at all.

FAN_MOVED_FROM I dropped because of the old name snapshot.
FAN_MOVED_TO I dropped because it needs the cookie to be in sync with
that of the FAN_MOVED_FROM event.

Besides, this event pair is "inotify legacy" as far as I am concerned.
FAN_MOVE_SELF can provide most of the needed functionality.
The rest of the functionality should be provided by a new event pair
IMO, FAN_LINK/FAN_UNLINK, as described in this proposal [3].

Which leaves us with two events: FAN_DELETE_SELF and FAN_ATTRIB.
FAN_DELETE_SELF is not appropriate for a mount mark IMO.
FAN_ATTRIB would be useful on mount mark IMO.
It would incur a bit more churn to add it, but I think it's certainly doable.

Just need to decide if we stay with the "dual hooks" approach and if so
on the technique to pass the "notify_path" state into vfs helpers and
existing fsnotify hooks.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_in_userns
[2] https://github.com/amir73il/linux/commits/fsnotify_path_hooks
[3] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhEsbfA5+sW4XPnUKgCkXtwoDA-BR3iRO34Nx5c4y7Nug@mail.gmail.com/
