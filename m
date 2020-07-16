Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD154221CAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 08:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGPGiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 02:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgGPGiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:38:13 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FC8C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 23:38:13 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c16so4856908ioi.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 23:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=405MEk0thD5homIHnbMeKKdn1LZhGC95KcOAqfwv9aI=;
        b=GeXKvO11rFDMh5rciNBIDS7ufg5DaMA6Q/5U+KUasaVCS2XAfcnBpyPRFXVwaarHIV
         ItiqbgUAa3gsVIMsivLc+H1nCwtXEsNR8cvMfzcGlBymzlcQhAor0triJqiBuC33gER0
         X97fqauCE1xN2QRkZAbUz9mS/5Ub31ffOq4i3IUuwDnSIsWIvnLc1+Ok2gqkQTex7Tgt
         c11qF4Pik7UnM1EFkiO46btxbpCPhh0r+a6h3wXvErEX1CKxUNTBbfqKKx1R0k0wuS+V
         wYFBhLZa0SpN4FQ4lrRtAxLFV0vpATlbOm9416xngKpXCl6mG8CEBGhzRZ9/i5AX782v
         Myrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=405MEk0thD5homIHnbMeKKdn1LZhGC95KcOAqfwv9aI=;
        b=IIbJIuJSfzTOXp8SGF4M6lbysIXvO3ycAAtCGxHi4kzKr3gYjqvzSq2DQVyTnLShrp
         r3sntCYVYSOj2xAy7a8rtyD8CqsEPW65cgZLYRFvwqD0GIunEMF69UhGALOS5cAFY9ow
         KiRELTrJNsMAP9EQoBoBuekBgM6db4/z01O4IuNJBqx9PJy0//D5IqeSAuEVM38RPewP
         bKvmnqJbEv1+iHt8K+UURrUg61If1pajIxnPupn81osEs/SXzbtJPwSeEXnUrJnLPvUA
         7fQvW8RRupqodQX2qfPInPHA0xdnUdtxqlB3+c+ZDAuJXGUiD0w/nF5neXrhuEskCKHr
         v+Bw==
X-Gm-Message-State: AOAM5309D7qw2U1dwrnNGFe0hiJOrDT40q0bbbtt0r838vHwU37ZA7kH
        5Yz9/nConLtB44zKqxJ7ELoRWk8Mm+U56Ii8rEKf3wF6
X-Google-Smtp-Source: ABdhPJwEKAck9EfVCtkWsE/O6WAuxgGgm+Ikh3SkEma8+NMALuLM/eLJ6QbDA4MhkWI8MRwK7uZZd+qb1de0zlH5gzE=
X-Received: by 2002:a6b:f012:: with SMTP id w18mr3062339ioc.5.1594881492984;
 Wed, 15 Jul 2020 23:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200702125744.10535-1-amir73il@gmail.com> <20200702125744.10535-4-amir73il@gmail.com>
 <20200714103455.GD23073@quack2.suse.cz> <CAOQ4uxi7oGHC5HJGWgF+PO3359CpbpzSC=pPhp=RPCczHHdv3g@mail.gmail.com>
 <20200715170937.GQ23073@quack2.suse.cz> <CAOQ4uxj_SoOvG1ozC8tSc7VYeYwOyS30TL=9-+T6J_++-q8qXg@mail.gmail.com>
In-Reply-To: <CAOQ4uxj_SoOvG1ozC8tSc7VYeYwOyS30TL=9-+T6J_++-q8qXg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 09:38:01 +0300
Message-ID: <CAOQ4uxi0c7ii7bzAomqpFMxRcLwaAUbsxPtUxzFpR=bAnQU80w@mail.gmail.com>
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

On Wed, Jul 15, 2020 at 8:42 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Jul 15, 2020 at 8:09 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 14-07-20 14:54:44, Amir Goldstein wrote:
> > > On Tue, Jul 14, 2020 at 1:34 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Thu 02-07-20 15:57:37, Amir Goldstein wrote:
> > > > > Instead of calling fsnotify() twice, once with parent inode and once
> > > > > with child inode, if event should be sent to parent inode, send it
> > > > > with both parent and child inodes marks in object type iterator and call
> > > > > the backend handle_event() callback only once.
> > > > >
> > > > > The parent inode is assigned to the standard "inode" iterator type and
> > > > > the child inode is assigned to the special "child" iterator type.
> > > > >
> > > > > In that case, the bit FS_EVENT_ON_CHILD will be set in the event mask,
> > > > > the dir argment to handle_event will be the parent inode, the file_name
> > > > > argument to handle_event is non NULL and refers to the name of the child
> > > > > and the child inode can be accessed with fsnotify_data_inode().
> > > > >
> > > > > This will allow fanotify to make decisions based on child or parent's
> > > > > ignored mask.  For example, when a parent is interested in a specific
> > > > > event on its children, but a specific child wishes to ignore this event,
> > > > > the event will not be reported.  This is not what happens with current
> > > > > code, but according to man page, it is the expected behavior.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > I like the direction where this is going. But can't we push it even a bit
> > > > further? I like the fact that we now have "one fs event" -> "one fsnotify()
> > > > call". Ideally I'd like to get rid of FS_EVENT_ON_CHILD in the event mask
> > > > because it's purpose seems very weak now and it complicates code (and now
> > >
> > > Can you give an example where it complicates the code?
> > > Don't confuse this with the code in fanotify_user.c that subscribes for
> > > events on child/with name.
> >
> > I refer mostly to the stuff like:
> >
> >         /* An event "on child" is not intended for a mount/sb mark */
> >         if (mask & FS_EVENT_ON_CHILD)
> >                 ...
> >

I need to explain something that was not an obvious decision for me.

When sending the same event on two inodes marks I considered a few options:

1. TYPE_INODE is the mark on the object referred to in data
    TYPE_PARENT is the mark on the parent if event is sent to a watching
                               parent or to sb/mnt/child with parent/name info
2. TYPE_CHILD is the mark on the object referred to in data
    TYPE_INODE is the mark on the fsnotify to_tell inode if not same as data
3. TYPE_INODE is the mark on the fsnotify to_tell inode
    TYPE_CHILD is the mark on the object referred to in data if it is
not to_tell

The first option with TYPE_PARENT  would require changing audit
and dnotify to look at TYPE_PARENT mark in addition to TYPE_INODE
mark, so it adds more friction and I ruled it out.

I think you had option #2 in mind when reading the code, but I went
for option #3.
There is a minor difference between them related to how we deal with the case
that the parent is watching and the case that only the child is watching.

If the parent is not watching (and child/sb/mnt not interested in name) we do
not snapshot the name and do not set the ON_CHILD flag in the mask.
In that case, should we add the child mark as TYPE_INODE or TYPE_CHILD?

I chose TYPE_INODE because this meant I did not have to change audit/dnotify
for that case. I didn't even care to look if they needed to be changed or not,
just wanted to keep things as they were.

Looking now, I see that dnotify would have needed to check TYPE_CHILD to
get FS_ATTRIB event on self.

It looks like audit would not have needed to change because although they set
FS_EVENT_ON_CHILD in mask, none of the events they care about are
"possible on child":
 #define AUDIT_FS_WATCH (FS_MOVE | FS_CREATE | FS_DELETE | FS_DELETE_SELF |\
                        FS_MOVE_SELF | FS_EVENT_ON_CHILD | FS_UNMOUNT)
#define AUDIT_FS_EVENTS (FS_MOVE | FS_CREATE | FS_DELETE | FS_DELETE_SELF |\
                         FS_MOVE_SELF | FS_EVENT_ON_CHILD)

Having written that decision process down made me realize there is a bug in
my unified inotify event handler implementation - it does not clear
FS_EVENT_ON_CHILD when reporting without name.

It is interesting to note that the result of sending FS_OPEN only to a watching
child to inotify_handle_event() is the same for design choices #2 and #3 above.
But the bug fix of clearing FS_EVENT_ON_CHILD when reporting without name
would look different depending on said choice.

Since I had to change inotify handler anyway, I prefer to stick with my choice
and fix inotify handler using goto notify_child which is a bit uglier,
instead of
having to adapt dnotify to choice #2.

> > They are not big complications. But it would be nice to get rid of special
> > cases like this. Basically my thinking was like: Now that we generate each
> > event exactly once (i.e., no event duplication once with FS_EVENT_ON_CHILD
> > and once without it), we should just be able to deliver all events to sb,
> > mnt, parent, child and they'll just ignore it if they don't care. No
> > special cases needed. But I understand I'm omitting a lot of detail in this
> > highlevel "feeling" and these details may make this impractical.
> >
>
[...]
> > > > passed sb, mnt, parent, child so it should have all the info to decide
> > > > where the event should be reported and I don't see a need for
> > > > FS_EVENT_ON_CHILD flag.
> > >
> > > Do you mean something like this?
> > >
> > >         const struct path *inode = fsnotify_data_inode(data, data_type);
> > >         bool event_on_child = !!file_name && dir != inode;
> >
> > Not quite. E.g. in fanotify_group_event_mask() we could replace the
> > FS_EVENT_ON_CHILD usage with something like:
> >
> >         /* If parent isn't interested in events on child, skip adding its mask */
> >         if (type == FSNOTIFY_OBJ_TYPE_INODE &&
> >             !(mark->mask & FS_EVENT_ON_CHILD))
> >                 continue;
> >

That looks wrong. FAN_CREATE does not have the ON_CHILD flag and
should very well be reported to inode mark.
Trying to special case as little as possible the different types of events
(on child/dirent/self) is what drove my choices here, but if we can find
ways to further simplify the code all the better.

Thanks,
Amir.
