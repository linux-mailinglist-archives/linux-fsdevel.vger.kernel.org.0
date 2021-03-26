Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9564B34A998
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 15:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhCZOW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCZOWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:22:53 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A1AC0613AA
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Mar 2021 07:22:52 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c4so5345826qkg.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Mar 2021 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVTm5TJ1nk7HkS3puWyXBBm2NlZ0XsJiAAIDaevzvYk=;
        b=W6ZLH0U18oGO+yKD+Bvtjh12EmNxzUdJh7nrcT8rgJ2vKW6cX1Y97H0GVOJ6VPmzIT
         9OdZg29K/6XoFdAPIcDFx8AZ26GNiSJ9cR/p+EwwHjUQ1UZPmDuD7F1Sly03N3XE8+Td
         YIInw8q+XvH7RcvsOpbGBoszIfIJeGcw/uTeCGK5JOhDT8ZNC4hTmIlviCZqkRvjee5Y
         28DMvf7C/kPKALfSg2rlXlixnP6NyqGO/OIhjUXzYnFOWMbbKxpI9gSu1ZmH+HKbpI9Q
         /AGcNRbRPpzvDJkP9fbHgVXOc+PQu/K5c4GPH1Tn073UOBmDvEHkW9WsCnORFdSR/Ixi
         6d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVTm5TJ1nk7HkS3puWyXBBm2NlZ0XsJiAAIDaevzvYk=;
        b=RKxnUIWgVWFkthF8L84bA0K3Xu0ixPB6x5IGamd6Zr4ev03t/RoJw+XTUwZG+7Mq/r
         EoApmnGbmxVgHU6qvzN4AneUq3HOMTAyhZejpK73fURONNFbCoDmvK1CP3Z8xTdtmbFx
         Pjg5Ut+M2BwtRqnM0fQ/TZN7Z+vbJu4s6Jq0Yr9OrbYRHJ8Luc8DjfgVGd+ovOI8TAKK
         FLD/GeZfJQvDDbgvIFBs9JuehFzRx0Cfv3xtoicK/dgVpDDst99+O1KpiTp7m5PHwVPa
         nUH9iCsaWjyA1WITaOnJtIkXhwK9lE+yvOyGGI7UK/Nk0j4Pi5eonQiBMKiP7/dYRe5X
         puWA==
X-Gm-Message-State: AOAM532Ts3bnzuMSVYZ9Uj1HcFzAYHKBkqgXCxV/I7ysYacwdmAyTdVN
        PAISg/I4y02Rm3DmsrJbYeCN5zzZhfnnfG+XewwsCoeNRQA=
X-Google-Smtp-Source: ABdhPJzsXgFANtbPOr9dMtL/Myw2Wp5Dr7q2aRxAu7MS8gMgnkhYefXSD06Ad5BIAPAipFBXOuiqESj1kJDkMQMKAFY=
X-Received: by 2002:a37:6658:: with SMTP id a85mr2020532qkc.424.1616768570474;
 Fri, 26 Mar 2021 07:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069c40405be6bdad4@google.com> <CACT4Y+baP24jKmj-trhF8bG_d_zkz8jN7L1kYBnUR=EAY6hOaA@mail.gmail.com>
 <20210326091207.5si6knxs7tn6rmod@wittgenstein> <CACT4Y+atQdf_fe3BPFRGVCzT1Ba3V_XjAo6XsRciL8nwt4wasw@mail.gmail.com>
 <CAHrFyr7iUpMh4sicxrMWwaUHKteU=qHt-1O-3hojAAX3d5879Q@mail.gmail.com> <20210326135011.wscs4pxal7vvsmmw@wittgenstein>
In-Reply-To: <20210326135011.wscs4pxal7vvsmmw@wittgenstein>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 26 Mar 2021 15:22:39 +0100
Message-ID: <CACT4Y+bHe2BG_DiVE9Bg3Vq60xqivpE=qRda+Ti20FJnWUqCDQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 2:50 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Mar 26, 2021 at 10:34:28AM +0100, Christian Brauner wrote:
> > On Fri, Mar 26, 2021, 10:21 Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > > On Fri, Mar 26, 2021 at 10:12 AM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > >
> > > > On Fri, Mar 26, 2021 at 09:02:08AM +0100, Dmitry Vyukov wrote:
> > > > > On Fri, Mar 26, 2021 at 8:55 AM syzbot
> > > > > <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    5ee96fa9 Merge tag 'irq-urgent-2021-03-21' of git://
> > > git.ke..
> > > > > > git tree:       upstream
> > > > > > console output:
> > > https://syzkaller.appspot.com/x/log.txt?x=17fb84bed00000
> > > > > > kernel config:
> > > https://syzkaller.appspot.com/x/.config?x=6abda3336c698a07
> > > > > > dashboard link:
> > > https://syzkaller.appspot.com/bug?extid=283ce5a46486d6acdbaf
> > > > > >
> > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag to the
> > > commit:
> > > > > > Reported-by: syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com
> > > > >
> > > > > I was able to reproduce this with the following C program:
> > > > >
> > > https://gist.githubusercontent.com/dvyukov/00fb7aae489f22c60b4e64b45ef14d60/raw/cb368ca523d01986c2917f4414add0893b8f4243/gistfile1.txt
> > > > >
> > > > > +Christian
> > > > > The repro also contains close_range as the previous similar crash:
> > > > >
> > > https://syzkaller.appspot.com/bug?id=1bef50bdd9622a1969608d1090b2b4a588d0c6ac
> > > > > I don't know if it's related or not in this case, but looks suspicious.
> > > >
> > > > Hm, I fail to reproduce this with your repro. Do you need to have it run
> > > > for a long time?
> > > > One thing that strucky my eye is that binfmt_misc gets setup which made
> > > > me go huh and I see commit
> > > >
> > > > commit e7850f4d844e0acfac7e570af611d89deade3146
> > > > Author: Lior Ribak <liorribak@gmail.com>
> > > > Date:   Fri Mar 12 21:07:41 2021 -0800
> > > >
> > > >     binfmt_misc: fix possible deadlock in bm_register_write
> > > >
> > > > which uses filp_close() after having called open_exec() on the
> > > > interpreter which makes me wonder why this doesn't have to use fput()
> > > > like in all other codepaths for binfmnt_*.
> > > >
> > > > Can you revert this commit and see if you can reproduce this issue.
> > > > Maybe this is a complete red herring but worth a try.
> > >
> > >
> > > This program reproduces the crash for me almost immediately. Are you
> > > sure you used the right commit/config?
> > >
> >
> > I was trying to reproduce on v5.12-rc3 with all KASAN, KCSAN, KFENCE etc.
> > turned on.
> > I have an appointment I need to go to but will try to reproduce with commit
> > and config you provided when I get home.
> > I really hope it's not reproducible with v5.12-rc3 and only later commits
> > since that would allow easier bisection.
>
> Ok, I think I know what's going on. This fixes it for me. Can you test
> too, please? I tried the #syz test way but syzbot doesn't have the
> reproducer you gave me:


The crash does not happen with this patch.

Tested-by: Dmitry Vyukov <dvyukov@google.com>

Thanks for the quick fix!



> Thank you!
> Christian
>
> From eeb120d02f40b15a925f54ebcf2b4c747c741ad0 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Fri, 26 Mar 2021 13:33:03 +0100
> Subject: [PATCH] file: fix close_range() for unshare+cloexec
>
> syzbot reported a bug when putting the last reference to a tasks file
> descriptor table. Debugging this showed we didn't recalculate the
> current maximum fd number for CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC
> after we unshared the file descriptors table. So max_fd could exceed the
> current fdtable maximum causing us to set excessive bits. As a concrete
> example, let's say the user requested everything from fd 4 to ~0UL to be
> closed and their current fdtable size is 256 with their highest open fd
> being 4.  With CLOSE_RANGE_UNSHARE the caller will end up with a new
> fdtable which has room for 64 file descriptors since that is the lowest
> fdtable size we accept. But now max_fd will still point to 255 and needs
> to be adjusted. Fix this by retrieving the correct maximum fd value in
> __range_cloexec().
>
> Reported-by: syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  fs/file.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/file.c b/fs/file.c
> index f3a4bac2cbe9..5ef62377d924 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -632,6 +632,7 @@ EXPORT_SYMBOL(close_fd); /* for ksys_close() */
>  static inline void __range_cloexec(struct files_struct *cur_fds,
>                                    unsigned int fd, unsigned int max_fd)
>  {
> +       unsigned int cur_max;
>         struct fdtable *fdt;
>
>         if (fd > max_fd)
> @@ -639,7 +640,12 @@ static inline void __range_cloexec(struct files_struct *cur_fds,
>
>         spin_lock(&cur_fds->file_lock);
>         fdt = files_fdtable(cur_fds);
> -       bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1);
> +       /* make very sure we're using the correct maximum value */
> +       cur_max = fdt->max_fds;
> +       cur_max--;
> +       cur_max = min(max_fd, cur_max);
> +       if (fd <= cur_max)
> +               bitmap_set(fdt->close_on_exec, fd, cur_max - fd + 1);
>         spin_unlock(&cur_fds->file_lock);
>  }
>
> --
> 2.27.0
>
