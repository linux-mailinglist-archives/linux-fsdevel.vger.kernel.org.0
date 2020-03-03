Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B47517788C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 15:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgCCONy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 09:13:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47095 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgCCONy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:13:54 -0500
Received: by mail-ot1-f66.google.com with SMTP id g96so3058125otb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rR9D2f+H/e0fSVL00Hp9urV4+rGAWYmYmqAOeH9QiI=;
        b=jFnI/p5sGaE8Le8fiAMY42PMLKHkTRTf1QlMJPXMCzYAPy8+oJUNnB2h44tAjiv4WG
         E9NYrTbliI2We1ehAL0n+Hp9Uz00HJzBmAhv3SsJrGYr5I8MUaiLc9NcTAhanR5CacZG
         4nZqO6O/Nw1BwSiM3dynOT07TZhRVAMtw54DqT2ZNy6GlXhYvAgYGea/T1S+AWSkeBn5
         fgGolr4CvH475/Z9IH+BEEgzi9UE3ij4Bo4SOMnhHoU4hSdxHnlbdOQmD4hKG1hAgPND
         qG4XEhYVHTYOSDJvJtAYMaKtgNWLtGbBsegtIJruZParsVY787NBAVWV/6XtuB4GAc+v
         D2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rR9D2f+H/e0fSVL00Hp9urV4+rGAWYmYmqAOeH9QiI=;
        b=uhQ7t+1iKc4vFIW078NDKBAbmWfS2WsSYiGlL1IU6xNdvKHmXNeTsLO5nMrcD6wgYi
         DgArBoUINIADenPcHGFSjW2HPPG3s4egjlFjb7DJiUWRfeehSWjL3xbsw9gvdTKNJT2y
         Abmooba6orVLZHxG/AUL3/tQ1Npypaq3WuIY6+NSGiowBegfa7PWQyCd3hRUCD3tmXXT
         39B+OD5/3bPNCCJ0JVyogjlRrdZ7INtYbJZIXdbCTBtPPoiwtk1/4/fSDrdb/3Gzk8Hp
         K/tVWeylu1fxLxCb6bSzNvaqTksKhVwz/8SwBC3Pv2hRsSLORXjWC62BlHUnxE65sm+A
         9YOQ==
X-Gm-Message-State: ANhLgQ308F9XoUpZGOB811Ca5p6Xkfybc8oTIdZq/2s/2BHV8ByqX4zC
        SMpEGUlpuD6/UJfJpI0zsy3sFyl5gOXFrnxl7xxaRw==
X-Google-Smtp-Source: ADFU+vufO6VrHobavK+ZbGNW4cEy5kqvLT7wd3WR4i93yBzOJEjSq9F6npSTRWuvRj2vM5/2ga1joTBYwWqaeS0xT0I=
X-Received: by 2002:a9d:7358:: with SMTP id l24mr837663otk.228.1583244833306;
 Tue, 03 Mar 2020 06:13:53 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk> <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home> <20200303130347.GA2302029@kroah.com>
 <20200303131434.GA2373427@kroah.com> <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com> <20200303141030.GA2811@kroah.com>
In-Reply-To: <20200303141030.GA2811@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 3 Mar 2020 15:13:26 +0100
Message-ID: <CAG48ez3Z2V8J7dpO6t8nw7O2cMJ6z8vwLZXLAoKGH3OnCb-7JQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 3, 2020 at 3:10 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 03, 2020 at 02:43:16PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> > > On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > >
> > > > > Unlimited beers for a 21-line kernel patch?  Sign me up!
> > > > >
> > > > > Totally untested, barely compiled patch below.
> > > >
> > > > Ok, that didn't even build, let me try this for real now...
> > >
> > > Some comments on the interface:
> >
> > Ok, hey, let's do this proper :)
>
> Alright, how about this patch.
>
> Actually tested with some simple sysfs files.
>
> If people don't strongly object, I'll add "real" tests to it, hook it up
> to all arches, write a manpage, and all the fun fluff a new syscall
> deserves and submit it "for real".

Just FYI, io_uring is moving towards the same kind of thing... IIRC
you can already use it to batch a bunch of open() calls, then batch a
bunch of read() calls on all the new fds and close them at the same
time. And I think they're planning to add support for doing
open()+read()+close() all in one go, too, except that it's a bit
complicated because passing forward the file descriptor in a generic
way is a bit complicated.

> It feels like I'm doing something wrong in that the actuall syscall
> logic is just so small.  Maybe I'll benchmark this thing to see if it
> makes any real difference...
>
> thanks,
>
> greg k-h
>
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Subject: [PATCH] readfile: implement readfile syscall
>
> It's a tiny syscall, meant to allow a user to do a single "open this
> file, read into this buffer, and close the file" all in a single shot.
>
> Should be good for reading "tiny" files like sysfs, procfs, and other
> "small" files.
>
> There is no restarting the syscall, am trying to keep it simple.  At
> least for now.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[...]
> +SYSCALL_DEFINE5(readfile, int, dfd, const char __user *, filename,
> +               char __user *, buffer, size_t, bufsize, int, flags)
> +{
> +       int retval;
> +       int fd;
> +
> +       /* Mask off all O_ flags as we only want to read from the file */
> +       flags &= ~(VALID_OPEN_FLAGS);
> +       flags |= O_RDONLY | O_LARGEFILE;
> +
> +       fd = do_sys_open(dfd, filename, flags, 0000);
> +       if (fd <= 0)
> +               return fd;
> +
> +       retval = ksys_read(fd, buffer, bufsize);
> +
> +       __close_fd(current->files, fd);
> +
> +       return retval;
> +}

If you're gonna do something like that, wouldn't you want to also
elide the use of the file descriptor table completely? do_sys_open()
will have to do atomic operations in the fd table and stuff, which is
probably moderately bad in terms of cacheline bouncing if this is used
in a multithreaded context; and as a side effect, the fd would be
inherited by anyone who calls fork() concurrently. You'll probably
want to use APIs like do_filp_open() and filp_close(), or something
like that, instead.
