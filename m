Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556D1347EEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 18:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbhCXRKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 13:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbhCXRJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:09:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA7C0613E1;
        Wed, 24 Mar 2021 10:07:30 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id v26so22289171iox.11;
        Wed, 24 Mar 2021 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0HScdr4ewSi65s4eWc9NLpm007AJP3TbYRGLM0meqg=;
        b=ta2m4T0dt/+G1+KpSue7QoIu0m5m3YMCWjhwfaLdwjHWZOW1taRheTYTrFrB/Pnt5j
         IlFdxRB2yZk1DtK9U79RAZPr4js80mcLxAdsA0fdprPufqcXegZkikKgzRgPitYlUyOh
         bmxadj3Q72JeXajekfsiJP3C3vfW7FKNDfKBMGQF7o6nkWeLSBVgG9kY5t6ZglA9p7+f
         RD28B+HicjX3qn5jt6x9Vd6T1RHc5qcenzqdewiMKsuYetO/DjluLRR8ZOeX9C5htLdr
         lzsYiFdQVqOECnvTKbXGMFAyResISFTgIdGCiWYpYxf2gVcjtd04InmEnt8gKZb3LvZB
         Q/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0HScdr4ewSi65s4eWc9NLpm007AJP3TbYRGLM0meqg=;
        b=fluJxT0CPMzfYDaFrsCisr4GdPhFnF1+MWCY1ey4w2l3FvOqSwkR7H93MaGdLI8wTT
         Ikhuz5MdCGYJToD8rdUOH0tcnnSPma/CyqdzirfcTv9oW5nlcJ3xj+FdqLD4HX+7KXGv
         kc0gl5aLyKPMrUL4tnK4ZSFxIU9PHGgJbxnoW9yNa2lg6Bq2sAlLopyy3qJMKazstX9E
         yz9lMDA7QHYLlBSHVxrxY6csPGyQskvKrR6yQbgvWStXOtaHjLwO6U1aAJsfjIKdb1WK
         wV2txNxm1S4/Yut2yMtVUX6gag6Eh8fI7GrVZaq0cl7FI5bajV41AX9prZFdACqZjMh8
         XHfg==
X-Gm-Message-State: AOAM532GuYJhUSnorVBnKlQaa8S+HsZup/JfctWIaflsrAzXp8L8qBcU
        AtFOPAd5rc6xci4L2LiCgqdSa2tzb1TbUHZ13kwAwjwqoZU=
X-Google-Smtp-Source: ABdhPJziQSLJrSNUwvMqeflSMtZSCEVd45+jLqUZ5NUunCnCrvqPo83wVQFRQYev4mQdCuVCdP97ypgApL+MWzhPziI=
X-Received: by 2002:a6b:4411:: with SMTP id r17mr3121204ioa.64.1616605648893;
 Wed, 24 Mar 2021 10:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein> <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein> <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
 <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
 <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
 <CAOQ4uxhFU=H8db35JMhfR+A5qDkmohQ01AWH995xeBAKuuPhzA@mail.gmail.com>
 <20210324143230.y36hga35xvpdb3ct@wittgenstein> <CAOQ4uxiPYbEk1N_7nxXMP7kz+KMnyH+0GqpJS36FR+-v9sHrcg@mail.gmail.com>
 <20210324162838.spy7qotef3kxm3l4@wittgenstein>
In-Reply-To: <20210324162838.spy7qotef3kxm3l4@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 19:07:17 +0200
Message-ID: <CAOQ4uxjcCEtuqyawNo7kCkb3213=vrstMupZt-KnGyanqKv=9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Well there is another way.
> > It is demonstrated in my demo with intoifywatch --fanotify --recursive.
> > It involved userspace iterating a subtree of interest to create fid->path
> > map.
>
> Ok, so this seems to be
>
> inotifytools_filename_from_fid()
> -> if (fanotify_mark_type != FAN_MARK_FILESYSTEM)
>            watch_from_fid()
>    -> read_path_from(/proc/self/fd/w->dirfd)
>

Yes.

> >
> > The fanotify recursive watch is similar but not exactly the same as the
> > old intoify recursive watch, because with inotify recursive watch you
> > can miss events.
> >
> > With fanotify recursive watch, the listener (if capable) can setup a
> > filesystem mark so events will not be missed. They will be recorded
> > by fid with an unknown path and the path information can be found later
> > by the crawler and updated in the map before the final report.
> >
> > Events on fid that were not found by the crawler need not be reported.
> > That's essentially a subtree watch for the poor implemented in userspace.
>
> This is already a good improvement.
> Honestly, having FAN_MARK_INODE workable unprivileged is already pretty

I'm not so sure why you say that, because unprivileged FAN_MARK_INODE
watches are pretty close in functionality to inotify.
There are only subtle differences.

> great. In addition having FAN_MARK_MOUNT workable with idmapped mounts
> will likely get us what most users care about, afaict that is the POC
> in:
> https://github.com/amir73il/linux/commit/f0d5d462c5baeb82a658944c6df80704434f09a1
>

Hmm, the problem is the limited set of events you can get from
FAN_MARK_MOUNT which does not include FAN_CREATE.

> (I'm reading the source correctly that FAN_MARK_MOUNT works with
> FAN_REPORT_FID as long as no inode event set in FANOTIFY_INODE_EVENTS is
> set? I'm asking because my manpage - probably too old - seems to imply
> that FAN_REPORT_FID can't be used with FAN_MARK_MOUNT although I might
> just be stumbling over the phrasing.)
>

commit d71c9b4a5c6fbc7164007b52dba1de410d018292
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Mon Apr 20 21:42:56 2020 +0300

    fanotify_mark.2: Clarification about FAN_MARK_MOUNT and FAN_REPORT_FID

    It is not true that FAN_MARK_MOUNT cannot be used with a group
    that was initialized with flag FAN_REPORT_FID.
 ...

IOW, no FAN_CREATE, FAN_DELETE, FAN_MOVE

The technical reason for that is Al's objection to pass the mnt context
into vfs helpers (and then fsnotify hooks).

> I think FAN_MARK_FILESYSTEM should simply stay under the s_userns_s
> capable requirement. That's imho the cleanest semantics for this, i.e.
> I'd drop:
> https://github.com/amir73il/linux/commit/bd20e273f3c3a650805b3da32e493f01cc2a4763
> This is neither an urgent use-case nor am I feeling very comfortable
> with it.
>

The purpose of this commit is to provide FAN_CREATE, FAN_DELETE
FAN_MOVE events filtered by (an idmapped) mount.
I don't like it so much myself, but I have not had any better idea how to
achieve that goal so far.

There is another way though.
We can create a new set of hooks outside the vfs helpers that do have
the mnt context.

I have already created such a set for another POC [1].
In this POC I introduced three new events FS_MODIFY_INTENT,
FS_NAME_INTENT, FS_MOVE_INTENT, which I had no plans of
exposing to fanotify. Nor did I need the granularity of CREATE,
DELETE, RENAME event types (all collapsed into NAME_INTENT).

But if we hit a dead end, we can resort to this strategy.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fsnotify_pre_modify
