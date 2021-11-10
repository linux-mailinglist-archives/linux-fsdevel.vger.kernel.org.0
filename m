Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F1844BBAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 07:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhKJGbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 01:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhKJGbM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:31:12 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6826C061766;
        Tue,  9 Nov 2021 22:28:25 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id w15so1394775ill.2;
        Tue, 09 Nov 2021 22:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omPGHcZQOamvxruFWJbitibaFxtFGC3+SEZUecILkcU=;
        b=JRRgF2gWZl43etxwl1b8rEI6btrcMR3sK2fTidwaWvnPbgpHDPxyPSi30GoGNoacF/
         swnNC5X7ZCBk6dDUJ+ZWfYHUbPZLD6twOoRqiBjVX0KnQot/BPVzBcfNmwVHfZVjkl8D
         NwjUe9gJ/2nZNPVRW1G2WfThaWcNKwkWltg/NCAGXR9Nc3Vb0BH3MhVakQCEBYylClyD
         Sl0ciRhdutKxTwc6tksCj3yKaf9lbFvyxQIKb5JKP2vcQVTfZblGbvWZ25XGNhR0oh+j
         nKa7LOKQdf6kcDxwDDRoA4C01yoymNtuzxj1Itd+qR2/S1EBlBZac8WHw4hjD7QMEppg
         eksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omPGHcZQOamvxruFWJbitibaFxtFGC3+SEZUecILkcU=;
        b=nTF3I41zrfdnPL+XcYUIr4KtTt+UQgbuiKuUXkw704Jh3/yNKbAWvWqwPes8sgFZLh
         OLt+xCqJYNTxk0sfo2YUwY799AtQ3OJ522Pb3iu80NG4exZNWQY1YUEMWn1d9ssjNsEv
         kbLVAGhF4P7UOJOjZvzqOUxc5vo/Pwxe4ZddUt7vi3iVaLbLJMv2gGfC8Xvd+KOvww2T
         hNS2yj2zN4kV4K923P5a7bh16uTXPH0fJGX97XSK81MLzsDaoh3u4FIeOkXOr+lsFOGr
         9a9c7b6tbbh4ly4fFxHjQBg6HtPmPcjPfm0ohIx+L5SV8/Qw0RNw786HEpJTFBLPXswS
         fJ9g==
X-Gm-Message-State: AOAM533wOE9R892hCs8X5A1Riv/T2wvoQ6JBjx5Qwau6acU7WIuXAjV0
        5edjx8ipQhus8BwMS1GNImEQNjCYLsgtLNyKrY+DymO4JtA=
X-Google-Smtp-Source: ABdhPJw5pbrPBfbD+ayrQMfm/BHFfoAHtBzYjB9hqeArPQ0M2yp8AC6lTgBUqQnl41qcTSZ3+3xC+QD46xjnBY08kWc=
X-Received: by 2002:a05:6e02:19ca:: with SMTP id r10mr10252891ill.319.1636525705204;
 Tue, 09 Nov 2021 22:28:25 -0800 (PST)
MIME-Version: 1.0
References: <CAO17o20sdKAWQN6w7Oe0Ze06qcK+J=6rrmA_aWGnY__MRVDCKw@mail.gmail.com>
 <CAOQ4uxhA+f-GZs-6SwNtSYZvSwfsYz4_=8_tWAUqt9s-49bqLw@mail.gmail.com>
 <20211027132319.GA7873@quack2.suse.cz> <YXm2tAMYwFFVR8g/@redhat.com>
 <20211102110931.GD12774@quack2.suse.cz> <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
 <20211103100900.GB20482@quack2.suse.cz> <CAOQ4uxjsULgLuOFUYkEePySx6iPXRczgCZMxx8E5ncw=oarLPg@mail.gmail.com>
 <YYMO1ip9ynXFXc8f@redhat.com> <20211104100316.GA10060@quack2.suse.cz> <YYU/7269JX2neLjz@redhat.com>
In-Reply-To: <YYU/7269JX2neLjz@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 10 Nov 2021 08:28:13 +0200
Message-ID: <CAOQ4uxiM_i+6Zs+ewg8mfA5aKs-gY7yj3kdrmPLO8Zn+bz4DbA@mail.gmail.com>
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

> > OK, so do I understand both you and Amir correctly that you think that
> > always relying on the FUSE server for generating the events and just piping
> > them to the client is not long-term viable design for FUSE? Mostly because
> > caching of modifications on the client is essentially inevitable and hence
> > generating events from the server would be unreliable (delayed too much)?

This is one aspect, but we do not have to tie remote notifications to
the cache coherency problem that is more complicated.

OTOH, if virtiofs take the route of "remote groups", why not take it one step
further and implement "remote event queue".
Then, it does not need to push event notifications from the server
into fsnotify at all.
Instead, FUSE client can communicate with the server using ioctl or a new
command to implement new_group() that returns a special FUSE file and
use FUSE POLL/READ to check/read the server's event queue.

There is already a precedent of this model with CIFS_IOC_NOTIFY
and SMB2_CHANGE_NOTIFY - SMB protocol, samba server and Windows server
support watching a directory or a subtree. I think it is a "oneshot" watch, so
there is no polling nor queue involved.

>
> So initial implementation could be about, application either get local
> events or remote events (based on filesystem). Down the line more
> complicated modes can emerge where some combination of local and remote
> events could be generated and applications could specify it. That
> probably will be extension of fanotiy/inotify API.
>

There is one more problem with this approach.
We cannot silently change the behavior of existing FUSE filesystems.
What if a system has antivirus configured to scan access to virtiofs mounts?
Do you consider it reasonable that on system upgrade, the capability of
adding local watches would go away?

I understand the desire to have existing inotify applications work out of
the box to get remote notifications, but I have doubts if this goal is even
worth pursuing. Considering that the existing known use case described in this
thread is already using polling to identify changes to config files on the host,
it could just as well be using a new API to get the job done.

If we had to plan an interface without considering existing applications,
I think it would look something like:

#define FAN_MARK_INODE                                 0x00000000
#define FAN_MARK_MOUNT                               0x00000010
#define FAN_MARK_FILESYSTEM                      0x00000100
#define FAN_MARK_REMOTE_INODE                0x00001000
#define FAN_MARK_REMOTE_FILESYSTEM     0x00001100

Then, the application can choose to add a remote mark with a certain
event mask and a local mark with a different event mask without any ambiguity.
The remote events could be tagged with a flag (turn reserved member of
fanotify_event_metadata into flags).

We have made a lot of effort to make fanotify a super set of inotify
functionality removing old UAPI mistakes and baggage along the way,
so I'd really hate to see us going down the path of ambiguous UAPI
again.

IMO, the work that Ioannis has already done to support remote
notifications with virtiofsd is perfectly valid as a private functionality
of virtiofs, just like cifs CIFS_IOC_NOTIFY.

If we want to go further and implement a "remote notification subsystem"
then I think we should take other fs (e.g.cifs) into consideration and think
about functionality beyond the plain remote watch and create an UAPI
that can be used to extend the functionality further.

Thanks,
Amir.
