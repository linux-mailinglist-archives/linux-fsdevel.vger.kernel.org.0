Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3E539988
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 00:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348446AbiEaWag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 18:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348437AbiEaWaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 18:30:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD559E9DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 15:30:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso2031444wma.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEu3gHBtY6LLTOMN3MmTdHskW6p1TLc/vNEFmAzpufM=;
        b=Z/vr9xTfUXH4PiY9DvzHip/pwNhMr9h68esOIlIO56GV4apnXgFyOZ4UUCWBHKFYZ7
         bSlO6x88S/K07DYuXkhEDgxkak3mbCuynYvmAvAXkkyu9RUknWNtE/ln6j2mrNyLuTc5
         y2kXWbMYjjOt+3x4sRE1U/gdB5r5O5Tfo14sEXjhUruqZuTEWkC4yAUCH3NE/pXzFUPw
         fcm8OZUg5G1rNEGvLnnU212WcSUCBkBl8R2z71Jf6L3TOaXmoObbqn+VpxmBdRFwyFh3
         8+oZxQh7463u1FSg/43DMFwRTz9sD8ddsOzS8PXnl1bbUa8T5cgUAub2gGrw3E4Ub6pl
         LfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEu3gHBtY6LLTOMN3MmTdHskW6p1TLc/vNEFmAzpufM=;
        b=Efl2IOFkOfcuaveisHl6GNZz97vBMWlneiXUQWA+4E7ob3O8kDY6ztae0T1NLK+p/u
         DF4ebGN3MTU0lx4IuKFvj4RbYdU8eRATUoZ5JqM7uqD8n6gHZO6d8pARJ7aTjVjXtIxR
         osYB3J7rMvy3EyW3EStiO0fbXrwAe2764Fyl/1i7CxNkG9axaBNaTnWUG3e3F6k85L6j
         3ybUZlTMhBYokwqEWzI1pirccZvgxd9Y4TmA70Bb1fKhj0B2kgABHj201srgs5ODN/R8
         zjIaUoOsTBoBC+mKpfIKZRIhlju3j+2kHqIrbBLZGa46AykSLJkS2ZhFOkFw1PyeYy5N
         mOgg==
X-Gm-Message-State: AOAM531zRlj4uNAT8XFCUVK5qZ4US9eP4/XlNGVPjevLG7cC7PlQhOIB
        xJWA6kqHDG3M4XNYWgWImw2p30A72x1G0oLzLCKRWg==
X-Google-Smtp-Source: ABdhPJxFW3EN2npyN6sNyZol7XaWaELo+D3IYfrKRqzNhGnITUwP8Auj/XlGTdtQdX23iRAndR1ltYZz0vpFCwYSIZg=
X-Received: by 2002:a05:600c:4f90:b0:394:970a:71bd with SMTP id
 n16-20020a05600c4f9000b00394970a71bdmr26110197wmq.158.1654036225336; Tue, 31
 May 2022 15:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220531212521.1231133-1-kaleshsingh@google.com>
 <20220531212521.1231133-3-kaleshsingh@google.com> <14f85d24-a9de-9706-32f0-30be4999c71c@oracle.com>
In-Reply-To: <14f85d24-a9de-9706-32f0-30be4999c71c@oracle.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 31 May 2022 15:30:14 -0700
Message-ID: <CAC_TJveDzDaYQKmuLSkGWpnuCW+gvrqdVJqq=wbzoTRjw4OoFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] procfs: Add 'path' to /proc/<pid>/fdinfo/
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Ioannis Ilkos <ilkos@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Colin Cross <ccross@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 31, 2022 at 3:07 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> On 5/31/22 14:25, Kalesh Singh wrote:
> > In order to identify the type of memory a process has pinned through
> > its open fds, add the file path to fdinfo output. This allows
> > identifying memory types based on common prefixes. e.g. "/memfd...",
> > "/dmabuf...", "/dev/ashmem...".
> >
> > Access to /proc/<pid>/fdinfo is governed by PTRACE_MODE_READ_FSCREDS
> > the same as /proc/<pid>/maps which also exposes the file path of
> > mappings; so the security permissions for accessing path is consistent
> > with that of /proc/<pid>/maps.
>
> Hi Kalesh,

Hi Stephen,

Thanks for taking a look.

>
> I think I see the value in the size field, but I'm curious about path,
> which is available via readlink /proc/<pid>/fd/<n>, since those are
> symlinks to the file themselves.

This could work if we are root, but the file permissions wouldn't
allow us to do the readlink on other processes otherwise. We want to
be able to capture the system state in production environments from
some trusted process with ptrace read capability.

>
> File paths can contain fun characters like newlines or colons, which
> could make parsing out filenames in this text file... fun. How would your
> userspace parsing logic handle "/home/stephen/filename\nsize:\t4096"? The
> readlink(2) API makes that easy already.

I think since we have escaped the "\n" (seq_file_path(m, file, "\n")),
then user space might parse this line like:

if (strncmp(line, "path:\t", 6) == 0)
        char* path = line + 6;


Thanks,
Kalesh

>
> Is the goal avoiding races (e.g. file descriptor 3 is closed and reopened
> to a different path between reading fdinfo and stating the fd)?
>
> Stephen
>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >
> > Changes from rfc:
> >   - Split adding 'size' and 'path' into a separate patches, per Christian
> >   - Fix indentation (use tabs) in documentaion, per Randy
> >
> >  Documentation/filesystems/proc.rst | 14 ++++++++++++--
> >  fs/proc/fd.c                       |  4 ++++
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 779c05528e87..591f12d30d97 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1886,14 +1886,16 @@ if precise results are needed.
> >  3.8  /proc/<pid>/fdinfo/<fd> - Information about opened file
> >  ---------------------------------------------------------------
> >  This file provides information associated with an opened file. The regular
> > -files have at least five fields -- 'pos', 'flags', 'mnt_id', 'ino', and 'size'.
> > +files have at least six fields -- 'pos', 'flags', 'mnt_id', 'ino', 'size',
> > +and 'path'.
> >
> >  The 'pos' represents the current offset of the opened file in decimal
> >  form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
> >  file has been created with [see open(2) for details] and 'mnt_id' represents
> >  mount ID of the file system containing the opened file [see 3.5
> >  /proc/<pid>/mountinfo for details]. 'ino' represents the inode number of
> > -the file, and 'size' represents the size of the file in bytes.
> > +the file, 'size' represents the size of the file in bytes, and 'path'
> > +represents the file path.
> >
> >  A typical output is::
> >
> > @@ -1902,6 +1904,7 @@ A typical output is::
> >       mnt_id: 19
> >       ino:    63107
> >       size:   0
> > +     path:   /dev/null
> >
> >  All locks associated with a file descriptor are shown in its fdinfo too::
> >
> > @@ -1920,6 +1923,7 @@ Eventfd files
> >       mnt_id: 9
> >       ino:    63107
> >       size:   0
> > +     path:   anon_inode:[eventfd]
> >       eventfd-count:  5a
> >
> >  where 'eventfd-count' is hex value of a counter.
> > @@ -1934,6 +1938,7 @@ Signalfd files
> >       mnt_id: 9
> >       ino:    63107
> >       size:   0
> > +     path:   anon_inode:[signalfd]
> >       sigmask:        0000000000000200
> >
> >  where 'sigmask' is hex value of the signal mask associated
> > @@ -1949,6 +1954,7 @@ Epoll files
> >       mnt_id: 9
> >       ino:    63107
> >       size:   0
> > +     path:   anon_inode:[eventpoll]
> >       tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
> >
> >  where 'tfd' is a target file descriptor number in decimal form,
> > @@ -1968,6 +1974,7 @@ For inotify files the format is the following::
> >       mnt_id: 9
> >       ino:    63107
> >       size:   0
> > +     path:   anon_inode:inotify
> >       inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
> >
> >  where 'wd' is a watch descriptor in decimal form, i.e. a target file
> > @@ -1992,6 +1999,7 @@ For fanotify files the format is::
> >       mnt_id: 9
> >       ino:    63107
> >       size:   0
> > +     path:   anon_inode:[fanotify]
> >       fanotify flags:10 event-flags:0
> >       fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
> >       fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
> > @@ -2018,6 +2026,7 @@ Timerfd files
> >       mnt_id: 9
> >       ino:    63107
> >       size:   0
> > +     path:   anon_inode:[timerfd]
> >       clockid: 0
> >       ticks: 0
> >       settime flags: 01
> > @@ -2042,6 +2051,7 @@ DMA Buffer files
> >       mnt_id: 9
> >       ino:    63107
> >       size:   32768
> > +     path:   /dmabuf:
> >       count:  2
> >       exp_name:  system-heap
> >
> > diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> > index 464bc3f55759..8889a8ba09d4 100644
> > --- a/fs/proc/fd.c
> > +++ b/fs/proc/fd.c
> > @@ -60,6 +60,10 @@ static int seq_show(struct seq_file *m, void *v)
> >       seq_printf(m, "ino:\t%lu\n", file_inode(file)->i_ino);
> >       seq_printf(m, "size:\t%lli\n", (long long)file_inode(file)->i_size);
> >
> > +     seq_puts(m, "path:\t");
> > +     seq_file_path(m, file, "\n");
> > +     seq_putc(m, '\n');
> > +
> >       /* show_fd_locks() never deferences files so a stale value is safe */
> >       show_fd_locks(m, file, files);
> >       if (seq_has_overflowed(m))
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
