Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC87113518
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 19:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfLDShX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 13:37:23 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38441 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfLDShW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:37:22 -0500
Received: by mail-yw1-f66.google.com with SMTP id 10so117372ywv.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 10:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qwm9Wn+8B0zxexhRahY9egqeumoLSSqLgVPttr5hWD4=;
        b=Ss5E2L1PnSz+zNV2a258CTN5SM7O/o18p5gPTKFM2TVCBMenicJyLCnHZXTId6kAcC
         957S0jKL6wOs6RR2PfnoBqE0bM3T78tq3kaViYckzo5UENNPXbU70aP8pGMw3HZEtTQ/
         Jq6zqjevkLyrJN08HHEPUMnxWmm38wKPlUgCg6M2xCuwausJthLZ5D9U+34CR6P/b6Qu
         /31hiRB9rjA7rgpON01PpwUWmA6cRKh3K1myy3tNRspmpmxWcrCwUmVQYwq95CZ9pMx1
         AV1yagnRrnHucgu7ngY6hgJ2QDhMfCFx9C6eW3Xg6HufDd5GOhgbA+AK2Z79neNwC7of
         u20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qwm9Wn+8B0zxexhRahY9egqeumoLSSqLgVPttr5hWD4=;
        b=m3a5aEeaUgUyFyB9QmZrwHGHpQTGMOT83PiPTkBLPxzu5V6hqS+tXifUjFlNFZR2Ou
         p55c4e8EXdHgCNi8L8DpVX5O8Ss0C09Cz694MxLdngxFPfQjojJ/+OYIVVd4I/Am364W
         uIlIt10G3NaHFC29e9rMHUfZu3AgJ+dw2DdZVrRrF0sYMzBBQMytdCIjcnEfbdqjHfGG
         WmgAKgOeZCNBxBTwzGlFSzWheDyrw46sVkM9DbRV9iXDsqEfBKyejk1hB946i5GUbmEo
         GHSOB1Y1C02+HIOyxBzxno69NcF5g1hFAiRlbAle/LYtVStZB6LoHNP3gTaeJelJk+sS
         R0Pg==
X-Gm-Message-State: APjAAAX+mKMgVJdaRta4FYl+2qxFlISLna7W8kiVoRsjk7gMKxx1k7Aa
        L3xwhzuFR7MtOqJcA5WVhLjjpJa2R/Tj52yYHe0=
X-Google-Smtp-Source: APXvYqwpvGDAf893zsuYATZF+nw5zGH67EFnc28e8bX3/yrMideMXD1H0n3SVD+SZoN6E9rNH8agGrKMl4mez3a/3OI=
X-Received: by 2002:a0d:f305:: with SMTP id c5mr3181411ywf.31.1575484641211;
 Wed, 04 Dec 2019 10:37:21 -0800 (PST)
MIME-Version: 1.0
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
 <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com> <20191204173455.GJ8206@quack2.suse.cz>
In-Reply-To: <20191204173455.GJ8206@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 Dec 2019 20:37:09 +0200
Message-ID: <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
Subject: Re: File monitor problem
To:     Jan Kara <jack@suse.cz>
Cc:     Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 4, 2019 at 7:34 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello Mohammad,
>
> On Wed 04-12-19 17:54:48, Mo Re Ra wrote:
> > On Wed, Dec 4, 2019 at 4:23 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Wed, Dec 4, 2019 at 12:03 PM Mo Re Ra <more7.rev@gmail.com> wrote:
> > > > I don`t know if this is the correct place to express my issue or not.
> > > > I have a big problem. For my project, a Directory Monitor, I`ve
> > > > researched about dnotify, inotify and fanotify.
> > > > dnotify is the worst choice.
> > > > inotify is a good choice but has a problem. It does not work
> > > > recursively. When you implement this feature by inotify, you would
> > > > miss immediately events after subdir creation.
> > > > fanotify is the last choice. It has a big change since Kernel 5.1. But
> > > > It does not meet my requirement.
> > > >
> > > > I need to monitor a directory with CREATE, DELETE, MOVE_TO, MOVE_FROM
> > > > and CLOSE_WRITE events would be happened in its subdirectories.
> > > > Filename of the events happened on that (without any miss) is
> > > > mandatory for me.
> > > >
> > > > I`ve searched and found a contribution from @amiril73 which
> > > > unfortunately has not been merged. Here is the link:
> > > > https://github.com/amir73il/fsnotify-utils/issues/1
> > > >
> > > > I`d really appreciate it If you could resolve this issue.
> > > >
> > >
> > > Hi Mohammad,
> > >
> > > Thanks for taking an interest in fanotify.
> > >
> > > Can you please elaborate about why filename in events are mandatory
> > > for your application.
> > >
> > > Could your application use the FID in FAN_DELETE_SELF and
> > > FAN_MOVE_SELF events to act on file deletion/rename instead of filename
> > > information in FAN_DELETE/FAN_MOVED_xxx events?
> > >
> > > Will it help if you could get a FAN_CREATE_SELF event with FID information
> > > of created file?
> > >
> > > Note that it is NOT guarantied that your application will be able to resolve
> > > those FID to file path, for example if file was already deleted and no open
> > > handles for this file exist or if file has a hardlink, you may resolve the path
> > > of that hardlink instead.
> > >
> > > Jan,
> > >
> > > I remember we discussed the optional FAN_REPORT_FILENAME [1] and
> > > you had some reservations, but I am not sure how strong they were.
> > > Please refresh my memory.
> > >

Hi Jan!

Ah, so it was a human engineering issue mostly that concerns you.
Let's see if I can argue against that ...

> > > [1] https://github.com/amir73il/linux/commit/d3e2fec74f6814cecb91148e6b9984a56132590f
> >
>
> > Fanotify project had a big change since Kernel 5.1 but did not meet
> > some primiry needs.
> > For example in my application, I`m watching on a specific directory to
> > sync it (through a socket connection and considering some policies)
> > with a directory in a remote system which a user working on that. Some
> > subdirectoires may contain two milions of files or more. I need these
> > two directoires be synced completely as soon as possible without any
> > missed notification.
> > So, I need a syscall with complete set of flags to help to watch on a
> > directory and all of its subdirectories recuresively without any
> > missed notification.
> >
> > Unfortuantely, in current version of Fanotify, the notification just
> > expresses a change has been occured in a directory but dot not
> > specifiy which file! I could not iterate over millions of file to
> > determine which file was that. That would not be helpful.
>
> The problem is there's no better reliable way. For example even if fanotify
> event provided a name as in the Amir's commit you reference, this name is
> not very useful. Because by the time your application gets to processing
> that fanotify event, the file under that name need not exist anymore, or

For DELETE event, file is not expected to exist, the filename in event is
always "reliable" (i.e. this name was unlinked).

> there may be a different file under that name already. That is my main
> objection to providing file names with fanotify events - they are not
> reliable but they are reliable enough that application developers will use
> them as a reliable thing which then leads to hard to debug bugs. Also
> fanotify was never designed to guarantee event ordering so it is impossible
> to reconstruct exact state of a directory in userspace just by knowing some
> past directory state and then "replaying" changes as reported by fanotify.
>
> I could imagine fanotify events would provide FID information of the target
> file e.g. on create so you could then use that with open_by_handle() to
> open the file and get reliable access to file data (provided the file still
> exists). However there still remains the problem that you don't know the
> file name and the problem that directory changes while you are looking...
>

IMO, there are two distinct issues you raise:
1. Filenames are not reliable to describe the current state of fs.
2. Application developers may use unreliable information to write bugs.

The problem I see with that argument is that for 99% of the cases,
filename is events are going to be useful information for app developers
and allow for much more efficient implementations.
We are punishing the common case for the rare case.

The fact that developers can ignore documentation and write bugs
should not be a show stopper for proving very useful information which
cannot be obtained efficiently otherwise.

Even if we decide that we want to provide only FID and let users use
open_by_handle_at() to try and resolve that FID to a path, what actually
happens in the kernel in the slow path is a readdir on parent looking for
the inode - not very efficient way of finding a path.

The most efficient way to deliver path information to user IMO, which
does not involve ambiguity in face of hardlinks and rename races is to
provide: parent FID; child FID; child name

The user application needs to:
- Open parent by FID
- Do name_to_handle_at(parent_fd, child_name)
- Compare the child handle with event child FID

That will cover the 99% of cases where event does represent the current
state and be 100% reliable.

In the 1% where one of the steps fail, application needs to fall back to
slow path and lookup the file using open_by_handle_at(), do the
readdir implementation itself or whatever.

About the human engineering factor, I am not sure what to say to that.
Your concern is valid, but all we can do is document properly and provide
correct demo code.

In the end, I think kernel fsnotify events should be handled by an "expert"
system daemon (fsnotifyd), similar to MacOS fseventsd that was build
on top of kevent.  This deamon would be able to handle subscribe
request by subtree, as so many people want, and may be able to provide
persistent notification streams to some extent.

But even this envisioned daemon won't be able to provide the information
of an unlinked hardlink (for example) correctly without the filename
information in the event.

Thoughts?

Thanks,
Amir.
