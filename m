Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846C922E094
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 17:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgGZPUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 11:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgGZPUi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:20:38 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919E2C0619D2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2020 08:20:38 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id g19so2368883ioh.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2020 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3GZ/SQjAGtV4Bs6LbKMJPnkX0UO9aVXCKd4XWA4ZkQ=;
        b=oTF3/86dUCEneTb7VGkIT/ihnGhNhhxB5TpC7qtuRaJkgXyiKtYlSc+dAJNDqyZ3IA
         1sbvPMo/Wgg1wG91HfqGArId6ZuZfikMpcUTHanFRsOkrG4HBKoiWRz8re9daEimYtVK
         eLSyIcNXVNR6owXnd1DsHSLbIFsn7s8/UrEe1H4Rco3Y2vlYIAP8OYoXrLepWK4bB8/H
         IU3ufjjKdfsofJGdxhAaSP2gx+TGnzHpOTS8mRUTztJWYg4WTI3Q5c7bHuko3vOkyLJg
         07hZpWz2zvos5X22GXwSe9HqO+F7QW2D+TEaSwlCrvl1Ep1nbjx7ivUGiop4Y0Chu74y
         hxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3GZ/SQjAGtV4Bs6LbKMJPnkX0UO9aVXCKd4XWA4ZkQ=;
        b=Rj8Amv+F/2pKM9KpgKelCK6U/gl5mqb2ELS0zH1oWKr7KIDlXJvYKFcqEpVPoVmAfk
         ZkhE9C6fXt412N7mtuAOlu7bXMJx9CSN/gtQhKNlzXiSmNDit66Ixe0jI6kBRh6qve6B
         smgYSq4k1fvbzNedKKC2criPrp+pV58Tcbsv6ycYshCLT697pQ8rspiXjzDVhQnlTSM+
         /tP0ueDlxLe6L/m38VyKXBI420E6H5lFT1gV5NDp+0IUfp+Zsfgpla7sKQJbDU9+2p9M
         uaKq3fbBhUrGYYTB7qhZi5II/5h6HKXIMHrUsTIPUADGOY0UNytSWO+itZpcoTrjIZcc
         vSKg==
X-Gm-Message-State: AOAM5313RmH8a28ZnhtgEc5hhIGTu0o7anTTG5eTPdQOs2SCLgEWRxe0
        uvln/bJUE5kNn52y21prITYnmQXugv3gVxWUbl6dq8jm
X-Google-Smtp-Source: ABdhPJxY+9/BuOLrycbPXC8VUUoBs/xcjjDm2+Mn7yAw6L+OtWdT5H4qrevsx9TyYqPAvcRWuAxw4U0oFIfrXL/p4Pw=
X-Received: by 2002:a6b:be81:: with SMTP id o123mr6168040iof.64.1595776837833;
 Sun, 26 Jul 2020 08:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200612093343.5669-1-amir73il@gmail.com> <20200612093343.5669-2-amir73il@gmail.com>
 <20200703140342.GD21364@quack2.suse.cz> <CAOQ4uxgJkmSgt6nSO3C4y2Mc=T92ky5K5eis0f1Ofr-wDq7Wrw@mail.gmail.com>
 <20200706110526.GA3913@quack2.suse.cz> <CAOQ4uxi5Zpp7rCKdOkdw9Nkd=uGC-K2AuLqOFc0WQc_CgJQP2Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxi5Zpp7rCKdOkdw9Nkd=uGC-K2AuLqOFc0WQc_CgJQP2Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 26 Jul 2020 18:20:26 +0300
Message-ID: <CAOQ4uxgYpufPyhivOQyEhUQ0g+atKLwAAuefkSwaWXYAyMgw5Q@mail.gmail.com>
Subject: Re: fsnotify: minimise overhead when there are no marks related to sb
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 9, 2020 at 8:56 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > Otherwise the patch looks good. One observation though: The (mask &
> > > > FS_MODIFY) check means that all vfs_write() calls end up going through the
> > > > "slower" path iterating all mark types and checking whether there are marks
> > > > anyway. That could be relatively simply optimized using a hidden mask flag
> > > > like FS_ALWAYS_RECEIVE_MODIFY which would be set when there's some mark
> > > > needing special handling of FS_MODIFY... Not sure if we care enough at this
> > > > point...
> > >
> > > Yeh that sounds low hanging.
> > > Actually, I Don't think we need to define a flag for that.
> > > __fsnotify_recalc_mask() can add FS_MODIFY to the object's mask if needed.
> >
> > Yes, that would be even more elegant.
> >
> > > I will take a look at that as part of FS_PRE_MODIFY work.
> > > But in general, we should fight the urge to optimize theoretic
> > > performance issues...
> >
> > Agreed. I just suspect this may bring measurable benefit for hackbench pipe
> > or tiny tmpfs writes after seeing Mel's results. But as I wrote this is a
> > separate idea and without some numbers confirming my suspicion I don't
> > think the complication is worth it so I don't want you to burn time on this
> > unless you're really interested :).
> >
>
> You know me ;-)
> FS_MODIFY optimization pushed to fsnotify_pre_modify branch.
> Only tested that LTP tests pass.
>
> Note that this is only expected to improve performance in case there *are*
> marks, but not marks with ignore mask, because there is an earlier
> optimization in fsnotify() for the no marks case.
>

Hi Mel,

After following up on Jan's suggestion above, I realized there is another
low hanging optimization we can make.

As you may remember, one of the solutions we considered was to exclude
special or internal sb's from notifications based on some SB flag, but making
assumptions about which sb are expected to provide notifications turned out
to be a risky game.

We can however, keep a counter on sb to *know* there are no watches
on any object in this sb, so the test:

        if (!sb->s_fsnotify_marks &&
            (!mnt || !mnt->mnt_fsnotify_marks) &&
            (!inode || !inode->i_fsnotify_marks))
                return 0;

Which is not so nice for inlining, can be summarized as:

        if (atomic_long_read(&inode->i_sb->s_fsnotify_obj_refs) == 0)
                return 0;

Which is nicer for inlining.

I am not sure if you had a concrete reason for:
"fs: Do not check if there is a fsnotify watcher on pseudo inodes"
or if you did it for the sport.

I have made the change above for the sport and for now I do not
intend to post it for review unless a good reason comes up.

If you are interested or curious to queue this code to Suse perf testing,
I pushed it to branch fsnotify-perf [1]. It may be interesting to see if it
won back the cpu cycles lost in the revert of your patch.

This branch is based on some changes already in Jan's tree and some
changes in my development tree (fsnotify_pre_modify), but you already
fed this development branch to perf test machine once and reported back
that there was no significant degradation.

I can also provide the optimization patches based on Linus' tree if needed.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fsnotify-perf
