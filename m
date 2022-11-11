Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A16F6254BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 08:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKKH44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 02:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiKKH4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:56:55 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EC765E5A
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 23:56:54 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id t26so1120676uaj.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 23:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bVtUTUxIORxg0j1Dh3mbwvAsJp79U/6uh+ncmLZ0vjU=;
        b=R9RqvxDuaYz5cqDnSkbda2xm9jImx05hDo/qNYmATlp9udmTtNCr6NN05mzh3dkmFH
         sme196P0ncE/t/O2+8Wp8os5Fir0kLB5agn8g+ipWXUWLZRMxiQIYG9FwOxCGqKNnxpV
         upgBPHP7ebUrlGm2n8lOp4e1dFFtQDM3TNBRUVeOkiqbba4XD8DQwNxlAgcH2m2h05Yx
         xXd1otmXIlH3E5OHEY02EGSHqpyrPpc3imcGRUBbGuD1a1nvNp83TcVh/f1uHr9gR0gK
         fJTN0MNb5OVMHnx9t6wTVo8A0lGLXnbICYhDk+Wg3zpW6zW0ACrDEW5ZdBEykCSqUzZ9
         deFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVtUTUxIORxg0j1Dh3mbwvAsJp79U/6uh+ncmLZ0vjU=;
        b=s5BMgVX8cZSGSI4jjDoFTtlKglZLyA5zcmDYWf0JtLjxjltr9nGTaw8KAWtgcwnDw9
         4GgyekmV7jv9P8eQQhB46tCvdOkxPJ3nqEY1f13O5zoqQwM2dLaKvlQczDNAbBcvVAUP
         ATMVaoft3c3kRzNjhfDwOWM6GiPYd6mCdgCR2lykhYf6ElK7Ah6YPotUL7YDhtI5+/sb
         5HGqfa4MlibJhFOM18iPtKl7/vj8UB10aTe6TMxmGqnPlgC52UldxkAXM8fORxuWIUkc
         dcojqHAkpqNXQZST8M/LjcSozGVYy/tNncTSn8zENRCXCSfLgHlJC+zK2a+jRy3KGA9k
         AT8g==
X-Gm-Message-State: ANoB5pnlWGZq8b1g0plApW2HRIeZGgEfryoVOP/Cb9G2x+6srH8MDaEO
        /9fUD8i5XBl1/2OtDj1GUtv+sHCysbqGTTQ8jQXta1Qz
X-Google-Smtp-Source: AA0mqf7yREi5PV7IUlKUEJ1niGtXSLQddtHlX+4buCSz+nLNhHXyM8cqfRP+ueKr7IEkXeq1FDkNNIxP+2X0WRw2myo=
X-Received: by 2002:ab0:5f9a:0:b0:411:dae:ee7d with SMTP id
 b26-20020ab05f9a000000b004110daeee7dmr207933uaj.9.1668153413850; Thu, 10 Nov
 2022 23:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com> <20221101175144.yu3l5qo5gfwfpatt@quack3>
 <877d0eh03t.fsf@oracle.com> <CAOQ4uxgG=E+3CwpQAE__YGt7vdW77n0nTe6cExPTERBNUN0a0g@mail.gmail.com>
 <87h6z6fuey.fsf@oracle.com> <CAOQ4uxjRVRjTNJ-2CSX9QwLVC9oQN9r4GHqCn=XZrisZo6DN2w@mail.gmail.com>
 <87eduafg6d.fsf@oracle.com>
In-Reply-To: <87eduafg6d.fsf@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 11 Nov 2022 09:56:42 +0200
Message-ID: <CAOQ4uxj--1nVsHxOCkZjQPRKetk6se99_6QGgBuC5NxP+rEzTA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] fsnotify: fix softlockups iterating over d_subdirs
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 11, 2022 at 3:12 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Thu, Nov 10, 2022, 10:25 PM Stephen Brennan <stephen.s.brennan@oracle.com>
> > wrote:
> >
> >> Amir Goldstein <amir73il@gmail.com> writes:
> >> [...]
> >> > IIUC, patches #1+#3 fix a reproducible softlock, so if Al approves them,
> >> > I see no reason to withhold.
> >> >
> >> > With patches #1+#3 applied, the penalty is restricted to adding or
> >> > removing/destroying multiple marks on very large dirs or dirs with
> >> > many negative dentries.
> >> >
> >> > I think that fixing the synthetic test case of multiple added marks
> >> > is rather easy even without DCACHE_FSNOTIFY_PARENT_WATCHED.
> >> > Something like the attached patch is what Jan had suggested in the
> >> > first place.
> >> >
> >> > The synthetic test case of concurrent add/remove watch on the same
> >> > dir may still result in multiple children iterations, but that will
> >> usually
> >> > not be avoided even with DCACHE_FSNOTIFY_PARENT_WATCHED
> >> > and probably not worth optimizing for.
> >> >
> >> > Thoughts?
> >>
> >> If I understand your train of thought, your below patch would take the
> >> place of my patch #2, since #3 requires we not hold a spinlock during
> >> fsnotify_update_children_dentry_flags().
> >>
> >> And since you fully rely on dentry accessors to lazily clear flags, you
> >> don't need to have the mutual exclusion provided by the inode lock.
> >>
> >
> > You don't need it to synchronize set and clear of all children, but inode
> > lock is still useful for the update of children.
> >
> >
> >> I like that a lot.
> >>
> >> However, the one thing I see here is that if we no longer hold the inode
> >> lock, patch #3 needs to be re-examined: it assumes that dentries can't
> >> be removed or moved around, and that assumption is only true with the
> >> inode lock held.
> >>
> >
> > I wasn't planning on dropping that assumption
> > I was assuming that another patch would replace the spinlock with inode
> > lock.
> > As you had planned to do to avoid softlocks
> > When adding marks.
>
> Ah, thanks for the clarity! I believe I was working to that conclusion
> myself too.
>
> I actually believe I can make patch #3 work even when inode lock is not
> held, using the d_parent+retry check, and ensuring we skip cursors

I believe that would be a textbook premature optimization.
With all the patches planned, what would be the problem solved by
not holding inode lock?

> before cond_resched(). I was hoping to have a tested series ready by the
> end of my workday, but alas, it wasn't in the cards. I've got some
> builds running, which I'll test on my LTP machine in the morning. The
> overall idea is:
>
> fsnotify: clear PARENT_WATCHED flags lazily
>   -> As you sent it, no changes
> fsnotify: Use d_find_any_alias to get dentry associated with inode
>   -> My patch #1, rebased
> dnotify: move fsnotify_recalc_mask() outside spinlock
>   -> New patch to ensure we don't sleep while holding dnotify spnilock
> fsnotify: allow sleepable child flag update
>   -> My patch #3, but working even without inode lock held
> fsnotify: require inode lock held during child flag update
>   -> An optional additional patch to require the inode lock to be held,
>      just like you described.
>      The main benefit of having this (assuming my changes to my patch #3
>      hold out under scrutiny/testing) would be that it prevents the
>      situation where another task can do an fsnotify_recalc_mask(), see
>      that the flags don't need an update, and return before a different
>      task actually finishes the child flag update.

Assuming that you figured out the lock ordering and fixed the
dnotify locking, I just don't see pros in letting go of inode lock
only cons.

At the most, you can defer getting rid of inode lock to a later time
after the dust has settled on the other changes, but again, not
sure for what purpose.

I cannot see how holding inode lock could in any way regress the
situation from the current state of holding the spinlock.

Thanks,
Amir.
