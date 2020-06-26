Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68AC20AF68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 12:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgFZKG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgFZKG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:06:56 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4B6C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2020 03:06:54 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i25so9252149iog.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2020 03:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qsCO3JjMsnPjYgnOGxijLDFhku8q4Nk3BqoorCtqX2M=;
        b=Ufo5j6mrCP1VDXOogNN3XqDHXGQJ5ui7JDpr1qWtZ1GO10OuYp0fdPF18xtlphV91b
         Fy6z0LoIWYLguH5d5OWrv++r8p330EHe7zEi4pdaRcci0766txBdUWJJIWyJ4rPRVKHj
         vvMFcbdlj9y1aHRPWD28bvgy028fOo5tnxJvJ6eFu54eoKoh9luarZX/HM9pm4R8UbAB
         2NYNlU/ArXDLWuzymI8rk4ETe1xwbnPSnX1HjwK8RMsz6w1HSnPvcY3Bgzhc9OCFLKy1
         qdAmUWlT5+ZI57tnCrs/VSXIlQMiQiEHw3hPdEmubJXEZM+J4VQQ9V157FAnubMfpmb/
         3WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsCO3JjMsnPjYgnOGxijLDFhku8q4Nk3BqoorCtqX2M=;
        b=AWdVDCv8rBRV5q6Ac2FshFuEQKkTb8CrLVtbhgOojeDD6eg8b9BWKCzVLsaHPuyqMQ
         pJP0xHRyXdu1Ovh34/srR3t4gzLsfhI/+I+yimuvqGpJx9VGmIk+TMTc205MWA+f75+n
         dMVID0OI47ijIHpgEJN5OOFGzK7ZwP4dvlyp3E5DX6txrb4aaA+VpgX/krVaPp1fCmbM
         eS65/yQnRLYLNw0OY+zTmiXiZ+jFEalSFQInTxoZJAXanR3Q5UPvP50UW3GrnCCvl8tl
         ATpe06RB5ghoELqlBZdcx8gP97nVM5alXNzxSxK8aHAE+TMO/kkAJkRrJUEHrbw5FWLL
         V9KA==
X-Gm-Message-State: AOAM532qFNgT/TS/9L0eVFaWCOeE8BcWue6wlvaSM0oD53PHLtXcF/L4
        ndUy45g8rXIz6fh4GTcxgXC+ItFk2CkD/TWwEAVkl9hT
X-Google-Smtp-Source: ABdhPJxc/8HvNXpKWCYqi2lHi3R7YBaedFAIThuVxKtcYIIeK+ee2golfQQCAxB+CZAGH0re/Zt8Za0HAs69LlUxLFM=
X-Received: by 2002:a05:6602:14d0:: with SMTP id b16mr2606429iow.5.1593166013962;
 Fri, 26 Jun 2020 03:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200625181948.GF17788@quack2.suse.cz> <CAHk-=wj8XGkaPe1+ROAMUPK3Gfcx_tQY+RzUuSwksJepz8pQkQ@mail.gmail.com>
 <20200626094959.GB26507@quack2.suse.cz>
In-Reply-To: <20200626094959.GB26507@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 26 Jun 2020 13:06:42 +0300
Message-ID: <CAOQ4uxh6EXDsBN2TGY6zB5ApxhrfE64Pn49MUpEQ5ig=76QK=Q@mail.gmail.com>
Subject: Re: [GIT PULL] fsnotify speedup for 5.8-rc3
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:49 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 25-06-20 13:12:34, Linus Torvalds wrote:
> > On Thu, Jun 25, 2020 at 11:19 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.8-rc3
> > >
> > > to get a performance improvement to reduce impact of fsnotify for inodes
> > > where it isn't used.
> >
> > Pulled.
>
> Thanks.
>
> > I do note that there's some commonality here with commit ef1548adada5
> > ("proc: Use new_inode not new_inode_pseudo") and the discussion there
> > around "maybe new_inode_pseudo should disable fsnotify instead".
> >
> > See
> >
> >     https://lore.kernel.org/lkml/CAHk-=wh7nZNf81QPcgpDh-0jzt2sOF3rdUEB0UcZvYFHDiMNkw@mail.gmail.com/
> >
> > and in particular the comment there:
> >
> >         I do wonder if we should have kept the new_inode_pseudo(),
> >     and instead just make fsnotify say "you can't notify on an inode that
> >     isn't on the superblock list"
> >
> >  which is kind of similar to this alloc_file_pseudo() change..
> >
> > There it wasn't so much about performance, as about an actual bug
> > (quoting from that commit):
> >
> >     Recently syzbot reported that unmounting proc when there is an ongoing
> >     inotify watch on the root directory of proc could result in a use
> >     after free when the watch is removed after the unmount of proc
> >     when the watcher exits.
> >
> > but the fnsotify connection and the "pseudo files/inodes can't be
> > notified about" is the same.
>
> Thanks for notification. I think I've seen the original syzbot report but
> then lost track of how Eric solved it. Ideally I'd just forbid fsnotify on
> every virtual fs (proc, sysfs, sockets, ...) because it is not very useful
> and only causes issues - besides current issues, there were also issues in
> the past which resulted in 0b3b094ac9a7 "fanotify: Disallow permission
> events for proc filesystem". The only events that get reliably generated
> for these virtual filesystems are FS_OPEN / FS_CLOSE ones - and that's why
> I didn't yet disable fsnotify on the large scale for the virtual
> filesystems. Also I'm slightly concerned that someone might be mistakenly
> putting notification marks on virtual inodes where they don't generate any
> events but if we started to disallow such marks, the app would break
> because it doesn't expect error. But maybe we could try doing this a see
> whether someone complains...

As I wrote in review for v1 I think that would be preferred.
I just wasn't sure what characterizes the inodes that should be
blacklisted for setting watches, because I was thinking only of the
performance aspect. The sb list sounds like a good criteria to blacklist by.

>
> WRT "you can't notify on an inode that isn't on the superblock list" -
> that's certainly a requirement for fsnotify to work reliably but because we
> can add notification marks not only for inodes but also for mountpoint or
> superblock, I'd rather go for a superblock flag or file_system_type flag
> like I did in above mentioned 0b3b094ac9a7 because that seems more robust
> and I don't see a need for finer grained control of whether fsnotify makes
> sence or not.
>

If you want to be able to distinguish between tmpfs and the shm_mnt
kern_mount, it would need to be a sb flag, although smem inodes are all on
the sb list, so it would just be for performance.

Thanks,
Amir.
