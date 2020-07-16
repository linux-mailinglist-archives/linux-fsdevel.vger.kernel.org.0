Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E217922200B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGPJzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 05:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGPJzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:55:38 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65BCC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 02:55:37 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so4519943ilk.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/bRiPDsHauqBGP1ATYjPRtDBCKh6iAEgpa6uaPXeBU=;
        b=HP/iKEdMa2XXMjwHWw2u+SHY34rOL/aipQ85Mx5nYGGeuwKWSktsGNzN8yWnwcJmwm
         wo7C5k3Qp/sq0PpbgM7+w4tuZr0JNb3g4SVe13vfPcW++teHydXbYP6SiFH5OiChRAho
         TBvy/tZx2WqcNIojSyvm5cXQXPJG0IFUoQkDEKI7NkLl8sBMkmAQqaEFPtVC8kToc5jQ
         w88ZnHEH9Zed21tcjalcVmpQL3A/Xg50X5goDe24LfT1TKeFodfJDzJgQVu23Wn1KDa0
         G8qOp9xEre4cIzLUag7numyuRWzVgBUq6ttq5xCA09cFRoD2VHtsnZIC+i64uWhijxTw
         8ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/bRiPDsHauqBGP1ATYjPRtDBCKh6iAEgpa6uaPXeBU=;
        b=OO205U97H0mVpJ60o/IXCn1Ts5GvlrfTaPNel1OMjdYRhMA+qBwLDKZHJOfPK6JxL4
         M5kJOT5hbuiWSEPg9RL3Y6smz3TXC+fyU2lNyXDDQeI+qKE7Ojy/DkC9VJW3NFGzTt9X
         09qfuxgXkaY3aRBQvGN7P+1XBFsOznJV0AE+mypA0eu0Z3wbSLOIcwjmuNz8j0nNrhKn
         0CQFtqdKeAotmn73e7rEK/aiiUdSe+0dfUpWs7BQ2/KSz6weJ1DzhkqJ7mmhi0rTSKHw
         FwDDv23BANsXt0nR5sjbjBxfFbcQMTTfa4E8obzhVL0MNI4E6XVrmv0P+xMO6N9Do+Gi
         //kA==
X-Gm-Message-State: AOAM531foGb+/gUgeeJkpgD0tO3Mo4iZMVbL4XVPlDVegqyOTW4BbxvR
        Yy2YoLOTG5UtAxnlhSHaR39xufMxebRcagykz/yzjqVS
X-Google-Smtp-Source: ABdhPJyOoL2KCTYSjVqltf6Z+9E1Y/LxHiEy3emLcKRggeADnV+F3faX5lmY+peq69vZdep2//prTYr+F+gzocDN9lY=
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr3869453ilj.9.1594893337002;
 Thu, 16 Jul 2020 02:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200702125744.10535-1-amir73il@gmail.com> <20200702125744.10535-4-amir73il@gmail.com>
 <20200714103455.GD23073@quack2.suse.cz> <CAOQ4uxi7oGHC5HJGWgF+PO3359CpbpzSC=pPhp=RPCczHHdv3g@mail.gmail.com>
 <20200715170937.GQ23073@quack2.suse.cz> <CAOQ4uxj_SoOvG1ozC8tSc7VYeYwOyS30TL=9-+T6J_++-q8qXg@mail.gmail.com>
 <CAOQ4uxi0c7ii7bzAomqpFMxRcLwaAUbsxPtUxzFpR=bAnQU80w@mail.gmail.com> <CAOQ4uxgN4XF5_WBEHr1o+4yQUXGCXFhJRd9adM4thUWt-pDYcQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgN4XF5_WBEHr1o+4yQUXGCXFhJRd9adM4thUWt-pDYcQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 12:55:25 +0300
Message-ID: <CAOQ4uxjOBJSYDNcGWCZiNjhdmz9kUxzW8Mms-zHeU3=3fogk8A@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] fsnotify: send event to parent and child with
 single callback
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:39 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jul 16, 2020 at 9:38 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Jul 15, 2020 at 8:42 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Wed, Jul 15, 2020 at 8:09 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Tue 14-07-20 14:54:44, Amir Goldstein wrote:
> > > > > On Tue, Jul 14, 2020 at 1:34 PM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > On Thu 02-07-20 15:57:37, Amir Goldstein wrote:
> > > > > > > Instead of calling fsnotify() twice, once with parent inode and once
> > > > > > > with child inode, if event should be sent to parent inode, send it
> > > > > > > with both parent and child inodes marks in object type iterator and call
> > > > > > > the backend handle_event() callback only once.
> > > > > > >
> > > > > > > The parent inode is assigned to the standard "inode" iterator type and
> > > > > > > the child inode is assigned to the special "child" iterator type.
> > > > > > >
> > > > > > > In that case, the bit FS_EVENT_ON_CHILD will be set in the event mask,
> > > > > > > the dir argment to handle_event will be the parent inode, the file_name
> > > > > > > argument to handle_event is non NULL and refers to the name of the child
> > > > > > > and the child inode can be accessed with fsnotify_data_inode().
> > > > > > >
> > > > > > > This will allow fanotify to make decisions based on child or parent's
> > > > > > > ignored mask.  For example, when a parent is interested in a specific
> > > > > > > event on its children, but a specific child wishes to ignore this event,
> > > > > > > the event will not be reported.  This is not what happens with current
> > > > > > > code, but according to man page, it is the expected behavior.
> > > > > > >
> > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > >
> > > > > > I like the direction where this is going. But can't we push it even a bit
> > > > > > further? I like the fact that we now have "one fs event" -> "one fsnotify()
> > > > > > call". Ideally I'd like to get rid of FS_EVENT_ON_CHILD in the event mask
> > > > > > because it's purpose seems very weak now and it complicates code (and now
> > > > >
> > > > > Can you give an example where it complicates the code?
> > > > > Don't confuse this with the code in fanotify_user.c that subscribes for
> > > > > events on child/with name.
> > > >
> > > > I refer mostly to the stuff like:
> > > >
> > > >         /* An event "on child" is not intended for a mount/sb mark */
> > > >         if (mask & FS_EVENT_ON_CHILD)
> > > >                 ...
> > > >
> >
> > I need to explain something that was not an obvious decision for me.
> >
> > When sending the same event on two inodes marks I considered a few options:
> >
> > 1. TYPE_INODE is the mark on the object referred to in data
> >     TYPE_PARENT is the mark on the parent if event is sent to a watching
> >                                parent or to sb/mnt/child with parent/name info
> > 2. TYPE_CHILD is the mark on the object referred to in data
> >     TYPE_INODE is the mark on the fsnotify to_tell inode if not same as data
> > 3. TYPE_INODE is the mark on the fsnotify to_tell inode
> >     TYPE_CHILD is the mark on the object referred to in data if it is
> > not to_tell
> >
> > The first option with TYPE_PARENT  would require changing audit
> > and dnotify to look at TYPE_PARENT mark in addition to TYPE_INODE
> > mark, so it adds more friction and I ruled it out.
> >
> > I think you had option #2 in mind when reading the code, but I went
> > for option #3.
> > There is a minor difference between them related to how we deal with the case
> > that the parent is watching and the case that only the child is watching.
> >
> > If the parent is not watching (and child/sb/mnt not interested in name) we do
> > not snapshot the name and do not set the ON_CHILD flag in the mask.
> > In that case, should we add the child mark as TYPE_INODE or TYPE_CHILD?
> >
> > I chose TYPE_INODE because this meant I did not have to change audit/dnotify
> > for that case. I didn't even care to look if they needed to be changed or not,
> > just wanted to keep things as they were.
> >
> > Looking now, I see that dnotify would have needed to check TYPE_CHILD to
> > get FS_ATTRIB event on self.
> >
> > It looks like audit would not have needed to change because although they set
> > FS_EVENT_ON_CHILD in mask, none of the events they care about are
> > "possible on child":
> >  #define AUDIT_FS_WATCH (FS_MOVE | FS_CREATE | FS_DELETE | FS_DELETE_SELF |\
> >                         FS_MOVE_SELF | FS_EVENT_ON_CHILD | FS_UNMOUNT)
> > #define AUDIT_FS_EVENTS (FS_MOVE | FS_CREATE | FS_DELETE | FS_DELETE_SELF |\
> >                          FS_MOVE_SELF | FS_EVENT_ON_CHILD)
> >
> > Having written that decision process down made me realize there is a bug in
> > my unified inotify event handler implementation - it does not clear
> > FS_EVENT_ON_CHILD when reporting without name.
> >
> > It is interesting to note that the result of sending FS_OPEN only to a watching
> > child to inotify_handle_event() is the same for design choices #2 and #3 above.
> > But the bug fix of clearing FS_EVENT_ON_CHILD when reporting without name
> > would look different depending on said choice.
> >
> > Since I had to change inotify handler anyway, I prefer to stick with my choice
> > and fix inotify handler using goto notify_child which is a bit uglier,
> > instead of
> > having to adapt dnotify to choice #2.
> >
>
> It turns out it's the other way around.
> inotify handler has no bug (FS_EVENT_ON_CHILD is not exposed to the user)
> just a confusing comment, so I will fix that.
> But dnotify does have a bug - it also needs to be taught about the unified event
> so that DN_ATTRIB event can be reported twice on both parent dir and child
> subdir if both are watching.
> Alas, we have no test coverage for dnotify in LTP...

FYI I verified this dnotify regression and fix manually after adding
DN_ATTRIB to
tools/testing/selftests/filesystems/dnotify_test.c:

$ cd dir/
$ dnotify_test &
$ cd subdir/
$ dnotify_test &
$ chmod 777 .
Got event on fd=3
Got event on fd=3

I will write an LTP test to cover this and see if we have similar
tests for inotify
and fanotify.

Thanks,
Amir.
