Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3A344DCBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 21:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhKKUz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 15:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhKKUzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:55:25 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3067C061766;
        Thu, 11 Nov 2021 12:52:35 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id v23so8536537iom.12;
        Thu, 11 Nov 2021 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTKj4bfiFeRtWwVxCSDbUoMTJAH7c1/P9uhrrjBnL0E=;
        b=lXd/r96pIj5ikr8XlMfLPudg1q1h8nBdvXNJbUWZH9XWv44VovKA/HWaufx6PCZZby
         FPBkuQ/2eWUiq6FHJrss6RHvIxkYpuRBf6NMMdgPPFUNRo4qCa9q/lBCAzXTj801iZKx
         VXVRUGPx5M9aQMOYp/b/qq7gfQR2fDy9c9wyvPg9kbdWotSujcRS8gtz317M4GdP9u6A
         8zLMOfuQG4VtAEsJDznP7Aw1MWtWZ2MkKA+bkL+sdWQqUMDSgsYimHXKjjSHpkmhslQu
         QjiXBEKesovw3J/XUNmtEpoIuQgA+YEa3B/M0xW/an+EopGhi/Y7hl11woHk5nr9oPmR
         CpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTKj4bfiFeRtWwVxCSDbUoMTJAH7c1/P9uhrrjBnL0E=;
        b=xDgRASWt8rOvytv0YDdKz2+bhyV3Kmxd4CSNYVzfSUdSyIhM0Q8lSEXRezD7lwBx+E
         xoseGrMsCZV8+4FEdfK1EBvxbn/xtulYYNwAbzigR5ZKVxgzJHXs3OIuGeaoaOimDTwM
         XBHmuMeaQXjtXzDiM7BFON7bgdlI7Nfx6ZLhTtIRDMuB9BlucbfSn5rIc5/uMJHRCBUK
         wNEgmly7l2dLJzXxn04R0PWgGZd3eTjzETfReZFOENsnQTfZHU4AZd47cyLAWKm+82Dw
         mRmZ7RwLdcY5p8QQbNSHnjalShY9kVaV3Xz9cEdF1MVQjgf+1w1v0PINK2Xo1xNP35bi
         lzRA==
X-Gm-Message-State: AOAM530YPLY6dvrqH9FBotZNDfN9gnr3Hw0QDGkjjRJvi8VAWGAdCJ0g
        Dzutwc1+zZNZfxpG98IhqVsex1N9WPegj9+mhQM=
X-Google-Smtp-Source: ABdhPJxZ4nvSgUne0Ov36+8VD76arEKPivkjOXBW+9fsk+nllLlEbdHnlUK0B+NRnCR/6CLAmCWIcBQZ7y7OI8fBHPM=
X-Received: by 2002:a02:c78e:: with SMTP id n14mr7439580jao.40.1636663955236;
 Thu, 11 Nov 2021 12:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20211027132319.GA7873@quack2.suse.cz> <YXm2tAMYwFFVR8g/@redhat.com>
 <20211102110931.GD12774@quack2.suse.cz> <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
 <20211103100900.GB20482@quack2.suse.cz> <CAOQ4uxjsULgLuOFUYkEePySx6iPXRczgCZMxx8E5ncw=oarLPg@mail.gmail.com>
 <YYMO1ip9ynXFXc8f@redhat.com> <20211104100316.GA10060@quack2.suse.cz>
 <YYU/7269JX2neLjz@redhat.com> <CAOQ4uxiM_i+6Zs+ewg8mfA5aKs-gY7yj3kdrmPLO8Zn+bz4DbA@mail.gmail.com>
 <20211111173043.GB25491@quack2.suse.cz>
In-Reply-To: <20211111173043.GB25491@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 11 Nov 2021 22:52:23 +0200
Message-ID: <CAOQ4uxiOUM6=190w4018w4nJRnqi+9gzzfQTsLh5gGwbQH_HgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Jan Kara <jack@suse.cz>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 11, 2021 at 7:30 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 10-11-21 08:28:13, Amir Goldstein wrote:
> > > > OK, so do I understand both you and Amir correctly that you think that
> > > > always relying on the FUSE server for generating the events and just piping
> > > > them to the client is not long-term viable design for FUSE? Mostly because
> > > > caching of modifications on the client is essentially inevitable and hence
> > > > generating events from the server would be unreliable (delayed too much)?
> >
> > This is one aspect, but we do not have to tie remote notifications to
> > the cache coherency problem that is more complicated.
> >
> > OTOH, if virtiofs take the route of "remote groups", why not take it one step
> > further and implement "remote event queue".
> > Then, it does not need to push event notifications from the server
> > into fsnotify at all.
> > Instead, FUSE client can communicate with the server using ioctl or a new
> > command to implement new_group() that returns a special FUSE file and
> > use FUSE POLL/READ to check/read the server's event queue.
>
> Yes, that could work. But I don't see how you want to avoid pushing events
> to fsnotify on the client side. Suppose app creates fanotify group G, it
> adds mark for some filesystem F1 to it, then in adds marks for another
> filesystem F2 - this time it is FUSE based fs. App wants to receive events
> for both F1 and F2 but events for F2 are actually coming from the server
> and somehow they have to get into G's queue for an app to read them.
>
> > There is already a precedent of this model with CIFS_IOC_NOTIFY
> > and SMB2_CHANGE_NOTIFY - SMB protocol, samba server and Windows server
> > support watching a directory or a subtree. I think it is a "oneshot" watch, so
> > there is no polling nor queue involved.
>
> OK, are you aiming at completely separate notification API for userspace
> for FUSE-based filesystems?

Yes, if the group is "remote" then all the marks are "remote" and event
queue is also remote.

> Then I see why you don't need to push events
> to fsnotify but I don't quite like that for a few reasons:
>
> 1) Application has to be aware whether the filesystem it operates on is
> FUSE based or not. That is IMO unnecessary burden for the applications.
>
> 2) If application wants to watch for several paths potentially on multiple
> filesystems, it would now need to somehow merge the event streams from FUSE
> API and {fa/i}notify API.
>
> 3) It would potentially duplicate quite some parts of fsnotify API
> handling.
>

I don't like so much either, but virtiofs developers are free to pursue this
direction without involving the fsnotify subsystem (like cifs).
One can even implement userspace wrappers for inotify library functions
that know how to utilize remote cifs/fuse watches...

> > > So initial implementation could be about, application either get local
> > > events or remote events (based on filesystem). Down the line more
> > > complicated modes can emerge where some combination of local and remote
> > > events could be generated and applications could specify it. That
> > > probably will be extension of fanotiy/inotify API.
> >
> > There is one more problem with this approach.
> > We cannot silently change the behavior of existing FUSE filesystems.
> > What if a system has antivirus configured to scan access to virtiofs mounts?
> > Do you consider it reasonable that on system upgrade, the capability of
> > adding local watches would go away?
>
> I agree we have to be careful there. If fanotify / inotify is currently
> usable with virtiofs, just missing events coming from host changes (which
> are presumably rare for lots of setups), it is likely used by someone and
> we should not regress it.
>

I don't see why it wouldn't be usable.
I think we have to assume that someone is using inotify/fanotify
on virtiofs.

> > I understand the desire to have existing inotify applications work out of
> > the box to get remote notifications, but I have doubts if this goal is even
> > worth pursuing. Considering that the existing known use case described in this
> > thread is already using polling to identify changes to config files on the host,
> > it could just as well be using a new API to get the job done.
> >
> > If we had to plan an interface without considering existing applications,
> > I think it would look something like:
> >
> > #define FAN_MARK_INODE                                 0x00000000
> > #define FAN_MARK_MOUNT                               0x00000010
> > #define FAN_MARK_FILESYSTEM                      0x00000100
> > #define FAN_MARK_REMOTE_INODE                0x00001000
> > #define FAN_MARK_REMOTE_FILESYSTEM     0x00001100
> >
> > Then, the application can choose to add a remote mark with a certain
> > event mask and a local mark with a different event mask without any ambiguity.
> > The remote events could be tagged with a flag (turn reserved member of
> > fanotify_event_metadata into flags).
> >
> > We have made a lot of effort to make fanotify a super set of inotify
> > functionality removing old UAPI mistakes and baggage along the way,
> > so I'd really hate to see us going down the path of ambiguous UAPI
> > again.
>
> So there's a question: Does application care whether the event comes from
> local or remote side? I'd say generally no - a file change is simply a file
> change and it does not matter who did it. Also again this API implies the
> application has to be aware it runs on a filesystem that may generate
> remote events to ask for them. But presumably knowledgeable app can always
> ask for local & remote events and if that fails (fs does not support remote
> events), ask only for local. That's not a big burden.
>
> The question is why would we make remote events explicit (and thus
> complicate the API and usage) when generally apps cannot be bothered who
> did the change. I suppose it makes implementation and some of the
> consequences on the stream of events more obvious. Also it allows
> functionality such as permission or mount events which are only local when
> the server does not support them which could be useful for "mostly local"
> filesystems. Hum...
>

Yeh, it is not clear at all what's the best approach.
Maybe the application would just need to specify FAN_REMOTE_EVENTS
in fanotify_init() to opt-in for any new behavior to avoid surprises and not
be any more explicit than that for the common use case.

Thanks,
Amir.
