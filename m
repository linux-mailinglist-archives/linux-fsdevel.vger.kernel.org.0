Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726FB444E60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 06:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhKDFcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 01:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhKDFcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:32:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAFEC06127A;
        Wed,  3 Nov 2021 22:29:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d70so4687695iof.7;
        Wed, 03 Nov 2021 22:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCzyf93QJNuKwifW+Nffo8te0nxMymfSTSoBlo601P0=;
        b=Tq4ABWi0eLIi+uMMQ2zAh3NtcSCzbrCCjBP+97a4kJuAOsZBpbT0Jsz8ZqSYRQV8pX
         JRE0V2pUUdeUsMYuVzDdpGNNh08NcdFnfA6hWOm3OFAPcitql7b54iUhtzsP8lDRcOZx
         qMG+Uz/9prIbxU8JatcU+DqPzgp6CZEDDdeSM8KFaO8MEuJxT65q4U3oZmoK+TIQBr08
         xCEOXit8pcgzQGHpPhpfc5Y3aMsdjGMi9Gc5swwzwYu+7G/Pjj4SEhFUnpUfjxCfvd9r
         lwu9zAhLDI2lgY0nwkwwwA0u/I1Xo5l6zK3lOdkfZ7xopxxoOqJuk6coXiIc9PJHTjbd
         E5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCzyf93QJNuKwifW+Nffo8te0nxMymfSTSoBlo601P0=;
        b=q9+3rAVH6sskyP35BK9Vb1WiGgfeSm4xp7RILMFgICqe6klZ3tUefaKVKwzCGJlSDX
         uzvumrXRm14Og0Hkn/L9C0Xq9cacwakRulVaONuxNAWO5yS5udANCttYY74p2ZGB4FFL
         JDUz1rdUg9bhWUDYSXBb6WoZrbskCr7J9n5xcLCX6d3cYb4wVdjpsQ2VQOGtm9og4NFG
         TdImu7fs49aDxeSSEoXBbX8ix2Pbh5wpApAAGtMU/Pc/L4gH1b0zAAkSbxLFxh+uCSLC
         H93D9//tf6id1YDI6he/bolYr7bfBkydYRlE+Z24VaDiP+iy8f8AD9h3rGLwLnzPkmqH
         5oDQ==
X-Gm-Message-State: AOAM532SZiZYhE5Ghah6kup3WNe4wRX+MNWv+ENfDyJCMoaEwSbWPfNy
        R0m8zSFoUYjZAxlpCZHfLyIP6RfGJGBS8BVHMgg=
X-Google-Smtp-Source: ABdhPJywDa8jsIgtGGwXf7g8AWAWDYNMQ+O3xmpQbu1jacEQgLYA2Qt+XfoJDnueSAyliXWf9lgBoI5xwxKz1F0gk9g=
X-Received: by 2002:a5d:804a:: with SMTP id b10mr32344378ior.197.1636003771181;
 Wed, 03 Nov 2021 22:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhpCKK2MYxSmRJYYMEWaHKy5ezyKgxaM+YAKtpjsZkD-g@mail.gmail.com>
 <YXhIm3mOvPsueWab@redhat.com> <CAO17o20sdKAWQN6w7Oe0Ze06qcK+J=6rrmA_aWGnY__MRVDCKw@mail.gmail.com>
 <CAOQ4uxhA+f-GZs-6SwNtSYZvSwfsYz4_=8_tWAUqt9s-49bqLw@mail.gmail.com>
 <20211027132319.GA7873@quack2.suse.cz> <YXm2tAMYwFFVR8g/@redhat.com>
 <20211102110931.GD12774@quack2.suse.cz> <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
 <20211103100900.GB20482@quack2.suse.cz> <CAOQ4uxjsULgLuOFUYkEePySx6iPXRczgCZMxx8E5ncw=oarLPg@mail.gmail.com>
 <YYMO1ip9ynXFXc8f@redhat.com>
In-Reply-To: <YYMO1ip9ynXFXc8f@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 4 Nov 2021 07:29:20 +0200
Message-ID: <CAOQ4uxioM+Tnm-rJ0ZJk=0JHrL31FSyZqYfx2wX9oU0tpGJT-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
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

On Thu, Nov 4, 2021 at 12:36 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Nov 03, 2021 at 01:17:36PM +0200, Amir Goldstein wrote:
> > > > > > Hi Jan,
> > > > > >
> > > > > > Agreed. That's what Ioannis is trying to say. That some of the remote events
> > > > > > can be lost if fuse/guest local inode is unlinked. I think problem exists
> > > > > > both for shared and non-shared directory case.
> > > > > >
> > > > > > With local filesystems we have a control that we can first queue up
> > > > > > the event in buffer before we remove local watches. With events travelling
> > > > > > from a remote server, there is no such control/synchronization. It can
> > > > > > very well happen that events got delayed in the communication path
> > > > > > somewhere and local watches went away and now there is no way to
> > > > > > deliver those events to the application.
> > > > >
> > > > > So after thinking for some time about this I have the following question
> > > > > about the architecture of this solution: Why do you actually have local
> > > > > fsnotify watches at all? They seem to cause quite some trouble... I mean
> > > > > cannot we have fsnotify marks only on FUSE server and generate all events
> > > > > there? When e.g. file is created from the client, client tells the server
> > > > > about creation, the server performs the creation which generates the
> > > > > fsnotify event, that is received by the server and forwared back to the
> > > > > client which just queues it into notification group's queue for userspace
> > > > > to read it.
> > > > >
> > > > > Now with this architecture there's no problem with duplicate events for
> > > > > local & server notification marks, similarly there's no problem with lost
> > > > > events after inode deletion because events received by the client are
> > > > > directly queued into notification queue without any checking whether inode
> > > > > is still alive etc. Would this work or am I missing something?
> > > > >
> > > >
> > > > What about group #1 that wants mask A and group #2 that wants mask B
> > > > events?
> > > >
> > > > Do you propose to maintain separate event queues over the protocol?
> > > > Attach a "recipient list" to each event?
> > >
> > > Yes, that was my idea. Essentially when we see group A creates mark on FUSE
> > > for path P, we notify server, it will create notification group A on the
> > > server (if not already existing - there we need some notification group
> > > identifier unique among all clients), and place mark for it on path P. Then
> > > the full stream of notification events generated for group A on the server
> > > will just be forwarded to the client and inserted into the A's notification
> > > queue. IMO this is very simple solution to implement - you just need to
> > > forward mark addition / removal events from the client to the server and you
> > > forward event stream from the server to the client. Everything else is
> > > handled by the fsnotify infrastructure on the server.
> > >
> > > > I just don't see how this can scale other than:
> > > > - Local marks and connectors manage the subscriptions on local machine
> > > > - Protocol updates the server with the combined masks for watched objects
> > >
> > > I agree that depending on the usecase and particular FUSE filesystem
> > > performance of this solution may be a concern. OTOH the only additional
> > > cost of this solution I can see (compared to all those processes just
> > > watching files locally) is the passing of the events from the server to the
> > > client. For local FUSE filesystems such as virtiofs this should be rather
> > > cheap since you have to do very little processing for each generated event.
> > > For filesystems such as sshfs, I can imagine this would be a bigger deal.
> > >
> > > Also one problem I can see with my proposal is that it will have problems
> > > with stuff such as leases - i.e., if the client does not notify the server
> > > of the changes quickly but rather batches local operations and tells the
> > > server about them only on special occasions. I don't know enough about FUSE
> > > filesystems to tell whether this is a frequent problem or not.
> > >
> > > > I think that the "post-mortem events" issue could be solved by keeping an
> > > > S_DEAD fuse inode object in limbo just for the mark.
> > > > When a remote server sends FS_IN_IGNORED or FS_DELETE_SELF for
> > > > an inode, the fuse client inode can be finally evicted.
> > > > I haven't tried to see how hard that would be to implement.
> > >
> > > Sure, there can be other solutions to this particular problem. I just
> > > want to discuss the other architecture to see why we cannot to it in a
> > > simple way :).
> > >
> >
> > Fair enough.
> >
> > Beyond the scalability aspects, I think that a design that exposes the group
> > to the remote server and allows to "inject" events to the group queue
> > will prevent
> > users from useful features going forward.
> >
> > For example, fanotify ignored_mask could be added to a group, even on
> > a mount mark, even if the remote server only supports inode marks and it
> > would just work.
> >
> > Another point of view for the post-mortem events:
> > As Miklos once noted and as you wrote above, for cache coherency and leases,
> > an async notification queue is not adequate and synchronous notifications are
> > too costly, so there needs to be some shared memory solution involving guest
> > cache invalidation by host.
>
> Any shared memory solution works only limited setup. If server is remote
> on other machine, there is no sharing. I am hoping that this can be
> generic enough to support other remote filesystems down the line.
>

I do too :)

> >
> > Suppose said cache invalidation solution would be able to set a variety of
> > "dirty" flags, not just one type of dirty or to call in another way -
> > an "event mask".
> > If that is available, then when a fuse inode gets evicted, the events from the
> > "event mask" can be queued before destroying the inode and mark -
> > post mortem event issue averted...
>
> This is assuming that that server itself got the "IN_DELETE_SELF" event
> when fuse is destroying its inode. But if inode might be alive due to
> other client having fd open.
>
> Even if other client does not have fd open, this still sounds racy. By
> the time we set inode event_mask (using shared memory, instead of
> sending an event notifiation), fuse might have cleaned up its inode.
>

There is no escape from some sort of leases design for a reliable
and efficient shared remote fs.
Unless the client has an exclusive lease on the inode, it must provide
enough grace period before cleaning the inode to wait for an update
from the server if the client cares about getting all events on inode.

> There is a good chance I completely misunderstood what you are suggesting
> here. :-)
>

There is a good chance that I am talking nonsense :-)

Thanks,
Amir.
