Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BFD3DDB37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 16:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhHBOin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 10:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhHBOim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:38:42 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F768C06175F;
        Mon,  2 Aug 2021 07:38:32 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i13so4712128ilm.11;
        Mon, 02 Aug 2021 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyvSu8hXlGrXjo383HRHntv30MzfTiguiDMp7shBOGQ=;
        b=AIrI+WLnKK42kyNt+p8/JA3eJIjYSDP+B0quHPZZLPYe+ipn0kxU2HIIpR5hwTmNvl
         dvxB2LhakC5V1xnykDBNu84pJbRZTN6JL2P3sOAohW4Km8irQhvSCu4+0ygTQ+u+UnAg
         g9RbJf/+eVC/9EHVj0T7pNKL6aiX0y2aqkDSHfVio5mcTfLM3Rgn7GyXx9irwJ688Ceg
         M3n6x3ZjNxklckzUIbmnHIIPAmNKsoylyUdtxJ+TprFAwrDrhajlUIh6Fs3Q3nQTGWr6
         7zfyOHWD/5xpBTVosPjAq+8Q/CxNapplxI+ZbIaXRUPisrgjyQEpVphwlEKzwsP/g2hZ
         oyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyvSu8hXlGrXjo383HRHntv30MzfTiguiDMp7shBOGQ=;
        b=fOacwD04QfkO4Oj/nAuQCg7H5eMBX20Y94jUcR183roEofPx/wal29Pox8U7LmS4db
         1tAAkP/RBf8eDsRLwOp2BCLgSYuYzrtDhQWaz0ng0upNHIWD15v/jm2QhUVVjBhCC2kn
         MW8fy+SNL6G87FODuQz1ZJM+VgZdcHjdQEJQSSWStPrRdAUm97SuZKZ6fvddPMZyJY6f
         YR9T73Wp6NoMNo0aLPiDUY4Z7Ixb7yzWEwgVUal7zBv+0qZiUsn77yMQmGum20d8zqBW
         yQ/DQ7/fNynwx3I0P7lYpylied8WzOKpuIpsnoPnVimBaTUdfQTS7bwx7n6peZiLGqKp
         cFLQ==
X-Gm-Message-State: AOAM532Q1UFOyx4JCLYiObp8BSUfG3PrKb1pv9U1KCE1kZQsJvYjuEw/
        S6ti3CGEuY9Cb34UeEJX71+LwfpcGhN2Sw1XPZA=
X-Google-Smtp-Source: ABdhPJwU7SusTT5nH81Jvghcw5aTFyoSW2d3mfog1Iry1tcSCN8OfZvxrWB9ocKNajHR4IvMPgbahuc2wY8MimRAQjc=
X-Received: by 2002:a05:6e02:1c2d:: with SMTP id m13mr1205436ilh.137.1627915111964;
 Mon, 02 Aug 2021 07:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626845287.git.repnop@google.com> <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
 <20210729133953.GL29619@quack2.suse.cz> <CAOQ4uxi70KXGwpcBnRiyPXZCjFQfifaWaYVSDK2chaaZSyXXhQ@mail.gmail.com>
 <CAOQ4uxgFLqO5_vPTb5hkfO1Fb27H-h0TqHsB6owZxrZw4YLoEA@mail.gmail.com> <20210802123428.GB28745@quack2.suse.cz>
In-Reply-To: <20210802123428.GB28745@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 2 Aug 2021 17:38:20 +0300
Message-ID: <CAOQ4uxhk-vTOFvpuh81A2V5H0nfAJW6y3qBi9TgnZxAkRDSeKQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
To:     Jan Kara <jack@suse.cz>
Cc:     Jann Horn <jannh@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 2, 2021 at 3:34 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 30-07-21 08:03:01, Amir Goldstein wrote:
> > On Thu, Jul 29, 2021 at 6:13 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Thu, Jul 29, 2021 at 4:39 PM Jan Kara <jack@suse.cz> wrote:
> > > > Well, but pidfd also makes sure that /proc/<pid>/ keeps belonging to the
> > > > same process while you read various data from it. And you cannot achieve
> > > > that with pid+generation thing you've suggested. Plus the additional
> > > > concept and its complexity is non-trivial So I tend to agree with
> > > > Christian that we really want to return pidfd.
> > > >
> > > > Given returning pidfd is CAP_SYS_ADMIN priviledged operation I'm undecided
> > > > whether it is worth the trouble to come up with some other mechanism how to
> > > > return pidfd with the event. We could return some cookie which could be
> > > > then (by some ioctl or so) either transformed into real pidfd or released
> > > > (so that we can release pid handle in the kernel) but it looks ugly and
> > > > complicates things for everybody without bringing significant security
> > > > improvement (we already can pass fd with the event). So I'm pondering
> > > > whether there's some other way how we could make the interface safer - e.g.
> > > > so that the process receiving the event (not the one creating the group)
> > > > would also need to opt in for getting fds created in its file table.
> > > >
> > > > But so far nothing bright has come to my mind. :-|
> > > >
> > >
> > > There is a way, it is not bright, but it is pretty simple -
> > > store an optional pid in group->fanotify_data.fd_reader.
> > >
> > > With flag FAN_REPORT_PIDFD, both pidfd and event->fd reporting
> > > will be disabled to any process other than fd_reader.
> > > Without FAN_REPORT_PIDFD, event->fd reporting will be disabled
> > > if fd_reaader is set to a process other than the reader.
> > >
> > > A process can call ioctl START_FD_READER to set fd_reader to itself.
> > > With FAN_REPORT_PIDFD, if reaader_fd is NULL and the reader
> > > process has CAP_SYS_ADMIN, read() sets fd_reader to itself.
> > >
> > > Permission wise, START_FD_READER is allowed with
> > > CAP_SYS_ADMIN or if fd_reader is not owned by another process.
> > > We may consider YIELD_FD_READER ioctl if needed.
> > >
> > > I think that this is a pretty cheap price for implementation
> > > and maybe acceptable overhead for complicating the API?
> > > Note that without passing fd, there is no need for any ioctl.
> > >
> > > An added security benefit is that the ioctl adds is a way for the
> > > caller of fanotify_init() to make sure that even if the fanotify_fd is
> > > leaked, that event->fd will not be leaked, regardless of flag
> > > FAN_REPORT_PIDFD.
> > >
> > > So the START_FD_READER ioctl feature could be implemented
> > > and documented first.
> > > And then FAN_REPORT_PIDFD could use the feature with a
> > > very minor API difference:
> > > - Without the flag, other processes can read fds by default and
> > >   group initiator can opt-out
> > > - With the flag, other processes cannot read fds by default and
> > >   need to opt-in
> >
> > Or maybe something even simpler... fanotify_init() flag
> > FAN_PRIVATE (or FAN_PROTECTED) that limits event reading
> > to the initiator process (not only fd reading).
> >
> > FAN_REPORT_PIDFD requires FAN_PRIVATE.
> > If we do not know there is a use case for passing fanotify_fd
> > that reports pidfds to another process why implement the ioctl.
> > We can always implement it later if the need arises.
> > If we contemplate this future change, though, maybe the name
> > FAN_PROTECTED is better to start with.
>
> Good ideas. I think we are fine with returning pidfd only to the process
> creating the fanotify group. Later we can add an ioctl which would indicate
> that the process is also prepared to have fds created in its file table.
> But I have still some open questions:
> Do we want threads of the same process to still be able to receive fds?

I don't see why not.
They will be bloating the same fd table as the thread that called
fanotify_init().

> Also pids can be recycled so they are probably not completely reliable
> identifiers?

Not sure I follow. The group hold a refcount on struct pid of the process that
called fanotify_init() - I think that can used to check if reader process is
the same process, but not sure. Maybe there is another way (Christian?).

> What if someone wants to process events from fanotify group by
> multiple processes / threads (fd can be inherited also through fork(2)...)?
>

That's the same as passing fd between processes, no?
If users want to do that, we will need to implement the ioctl or
fanotify_init() flag FAN_SHARED.

> I'm currently undecided whether explicit FAN_PROTECTED flag (and impact on
> receiving / not receiving whole event) makes this better.
>

Yeh, I'm not sure either. You usually tell me not to overload different
meanings on one flag, which I always found to be good advice :-)

Thanks,
Amir.
