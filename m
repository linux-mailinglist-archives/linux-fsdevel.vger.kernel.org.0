Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA26E463A05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 16:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhK3PbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 10:31:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229865AbhK3PbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638286080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dw/oP72sHv9szIz5JPOY6jUf181p82iKf63/uK1E0P0=;
        b=bJyjqcLjQvLrmdLU1iA0mkMAR0AR43lVMHXLqd45zDCS+jERFJdzslO/ZKBCEqWFQUNLMU
        vVbJNUZdhHgzFK+B7H3vPZFhxE4Hqj3UyRWMV/4oi8CwQYeK+wmqCKFS/Nifq9GAUe/SVc
        Iatvrf14ERCS+eP2NWpKmQO8nf7hj/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-CvhVKRusNx-Hr-VMfD7IRA-1; Tue, 30 Nov 2021 10:27:57 -0500
X-MC-Unique: CvhVKRusNx-Hr-VMfD7IRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EF82839A46;
        Tue, 30 Nov 2021 15:27:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EDCD60854;
        Tue, 30 Nov 2021 15:27:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 024C7225F5D; Tue, 30 Nov 2021 10:27:53 -0500 (EST)
Date:   Tue, 30 Nov 2021 10:27:53 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        Stef Bon <stefbon@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>,
        Nathan Youngman <git@nathany.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <YaZC+R7xpGimBrD1@redhat.com>
References: <CAOQ4uxjsULgLuOFUYkEePySx6iPXRczgCZMxx8E5ncw=oarLPg@mail.gmail.com>
 <YYMO1ip9ynXFXc8f@redhat.com>
 <20211104100316.GA10060@quack2.suse.cz>
 <YYU/7269JX2neLjz@redhat.com>
 <CAOQ4uxiM_i+6Zs+ewg8mfA5aKs-gY7yj3kdrmPLO8Zn+bz4DbA@mail.gmail.com>
 <20211111173043.GB25491@quack2.suse.cz>
 <CAOQ4uxiOUM6=190w4018w4nJRnqi+9gzzfQTsLh5gGwbQH_HgQ@mail.gmail.com>
 <CANXojcy9JzXeLQ6bz9+UOekkpqo8NkgQbhugmGmPE+x3+_=h3Q@mail.gmail.com>
 <CAO17o21YVczE2-BTAVg-0HJU6gjSUkzUSqJVs9k-_t7mYFNHaA@mail.gmail.com>
 <CAOQ4uxjpGMYZrq74S=EaSO2nvss4hm1WZ_k+Xxgrj2k9pngJgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjpGMYZrq74S=EaSO2nvss4hm1WZ_k+Xxgrj2k9pngJgg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 08:40:57AM +0200, Amir Goldstein wrote:
> On Wed, Nov 17, 2021 at 12:12 AM Ioannis Angelakopoulos
> <iangelak@redhat.com> wrote:
> >
> >
> >
> > On Tue, Nov 16, 2021 at 12:10 AM Stef Bon <stefbon@gmail.com> wrote:
> >>
> >> Hi Ioannis,
> >>
> >> I see that you have been working on making fsnotify work on virtiofs.
> >> Earlier you contacted me since I've written this:
> >>
> >> https://github.com/libfuse/libfuse/wiki/Fsnotify-and-FUSE
> >>
> >> and send you my patches on 23 june.
> >> I want to mention first that I would have appreciated it if you would
> >> have reacted to me after I've sent you my patches. I did not get any
> >> reaction from you. Maybe these patches (which differ from what you
> >> propose now, but there is also a lot in common) have been an
> >> inspiration for you.
> >>
> >> Second, what I've written about is that with network filesystems (eg a
> >> backend shared with other systems) fsnotify support in FUSE has some
> >> drawbacks.
> >> In a network environment, where a network fs is part of making people
> >> collaborate, it's very useful to have information on who did what on
> >> which host, and also when. Simply a message "a file has been created
> >> in the folder you watch" is not enough. For example, if you are part
> >> of a team, and assigned to your team is a directory on a server where
> >> you can work on some shared documents. Now in this example there is a
> >> planning, and some documents have to be written. In that case you want
> >> to be informed that someone in your team has started a document (by
> >> creating it) by the system.
> >>
> > I agree that the out of band approach you propose is actually more powerful, since it can
> > provide the client with more information than remote fsnotify. However, in the virtiofs setup
> > your approach might not be as efficient.
> >
> > Specifically, the information on who did what might not make sense to the guest within QEMU, since all the
> > virtiofs filesystem operations are handled by viritofsd on the host and the guest does not know about the
> > server or any other guests. Vivek, correct me here if I am wrong.
> >
> > Thus, for now at least, it might be sufficient for the guest to know that just a remote event
> > occurred.
> >
> >> This "extended" information will never get through fsnotify.
> >>
> >> Other info useful to you as team member:
> >>
> >> -  you have become member of another team: sbon@anotherteam.example.org
> >> -  diskspace and/or quota shortage reported by networksystem
> >> -  new teammember, teammember left
> >> -  your "rights" or role in the network/team have been changed (for
> >> example from reader to reader and writer to some documents)
> >>
> >> What I want to say is that in a network where lots of people work
> >> together in teams/projects, (and I want Linux to play a role there, as
> >> desktop/workstation) communication is very important, and all these
> >> messages should be supported by the system. My idea is the support of
> >> watching fs events with FUSE filesystems should go through userspace,
> >> and not via the kernel (cause fs events are part of your setup in the
> >> network, together with all other tools to make people collaborate like
> >> chat/call/text, and because mentioned above extended info about the
> >> who on what host etc is not supported by fsnotify).
> >> There should be a fs event watcher which takes care of all watches on
> >> behalf of applications during a session, similar to gamin and FAM once
> >> did (not used anymore?).
> >> When receiving a request from one of the applications this fsevent
> >> watcher will use inotify and/or fanotify for local fs's only. With a
> >> FUSE fs, it should contact (via a socket) this fs that a watch has
> >> been set on an inode with a certain mask.
> >> If the FUSE fs does not support this, fallback on normal inotify/fanotify.
> >> This way extended info is possible.
> >>
> >> Is this extended information also useful for virtiofs?
> >>
> > Also based on your explanation, your out of band approach is specific to FUSE filesystems.
> > Granted, with your approach there is less complexity in the kernel and more flexibility since
> > the event notification occurs solely in user-space.
> > However, during the discussion with Amir and Jan about potential routes we could take to support the remote
> > fanotify/inotify/fsnotify one important concern was that the API should be able to support other
> > network/remote filesystems if needed and not only FUSE filesystems.
> > It seems that your approach would require a lot of work (correct me if I am wrong) to be adopted
> > by other network filesystems.
> >
> > Finally, user-space applications should also be aware of your new API, which will probably result in a non-negligible effort by app developers to adopt it or change their existing apps. The remote inotify/fsnotify ( the current implementation) even though it has many limitations, relies on the existing API and should require less modifications in user space apps. That is why we chose the remote inotify/fsnotify route.
> >
> 
> The way you depict the options seems like either applications are not
> aware of the UAPI
> changes or they need to be modified to adapt to the changes.
> 
> I actually think that the much better approach would be to deal with
> most of the UAPI
> complexity in a library, so applications may need to be rebuilt or
> adapted to use a new
> library, but going forward, the library would abstract most of the
> complexity from the
> applications.
> 
> The holy grail would be a portable library, such as this go library [1].
> It is quite hard to design an API that would abstract all the
> different capabilities
> on Linux-inotify/Linux-fanotify/MacOS-fsevents/Win-USNJournal and more.
> 
> The second best would be a library to abstract the ever growing complexity
> of Linux inotify/fanotify UAPI from applications.
> I had already made the first step with adapting libinotifytools to fanotify [2].
> We could continue down that path or start creating/improving a
> different library.
> 
> The point is that abstracting different capabilities of remote fs notifications
> (i.e. cifs, virtiofs, generic FUSE) is going to be challenging, so starting the
> design from a user library API and deriving the needed pieces from the
> kernel UAPI is the right way to go IMO.
> 
> The library approach will have the advantage that some remote fs capabilities
> (e.g. for cifs) will be available for old kernels as well and in
> theory, the library
> could also use some standardized OOB notifications channel to get changed
> made on the host from VM guest tools as Stef proposed.
> 
> > That said, I do not see a reason why both implementations cannot co-exist
> > and have the user-space applications choose which approach they want.
> >
> 
> True, an OOB channel and kernel generic remote fs support can both exist,
> but it would be best if the application was not aware of either.
> The library would pick the facility based on the requested functionality,
> availability of the facilities in the filesystem and sysadmin/user policy.

Sure. A library will be nice to abstract kernel generic remote fs and OOB
channel. This sounds like another project for somebody to work on.

IIUC, it looks like that both the approaches can make progress in
parallel. Advantange of OOB channel approach seems that it will be easier to
make changes in user space and add more events and send extra information.

While advantage of remote fsnotify is that its a known existing events
API and it makes it easier for applications to use same API for remote
fs (however limited it might be).

Thanks
Vivek

> Thanks,
> Amir.
> 
> [1] https://github.com/fsnotify/fsnotify
> [2] https://github.com/inotify-tools/inotify-tools/pull/134
> 

