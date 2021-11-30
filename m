Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699B0463A41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 16:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhK3PmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 10:42:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232311AbhK3PmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638286737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jb2BdxrVb6FxRWxbn5d/ICV/u1irRx/LO4kb2wPxu5I=;
        b=VU6FzFvKrSvN1IyIv+ibdxk9INNDJQarpkFXi8GxpTgNwnGjblY7j8NnJDrG1JkRSEFCrL
        I6Mjw/2hiI9SRVRSi3ZzwHXPPil2dCFVjPLAxiBQpAjq+kAgfukH5XsT23P/3vHI6LGTXG
        N09P7RnBpqScqEUaUyGGCMIchKY4aUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-Zcaupja1Obqp7pKeKuCsfw-1; Tue, 30 Nov 2021 10:38:51 -0500
X-MC-Unique: Zcaupja1Obqp7pKeKuCsfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5231A14C5C8;
        Tue, 30 Nov 2021 15:37:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 649C145D61;
        Tue, 30 Nov 2021 15:36:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id F1410225F5D; Tue, 30 Nov 2021 10:36:45 -0500 (EST)
Date:   Tue, 30 Nov 2021 10:36:45 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stef Bon <stefbon@gmail.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <YaZFDS2u5PBoUvkl@redhat.com>
References: <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
 <20211103100900.GB20482@quack2.suse.cz>
 <CAOQ4uxjsULgLuOFUYkEePySx6iPXRczgCZMxx8E5ncw=oarLPg@mail.gmail.com>
 <YYMO1ip9ynXFXc8f@redhat.com>
 <20211104100316.GA10060@quack2.suse.cz>
 <YYU/7269JX2neLjz@redhat.com>
 <CAOQ4uxiM_i+6Zs+ewg8mfA5aKs-gY7yj3kdrmPLO8Zn+bz4DbA@mail.gmail.com>
 <20211111173043.GB25491@quack2.suse.cz>
 <CAOQ4uxiOUM6=190w4018w4nJRnqi+9gzzfQTsLh5gGwbQH_HgQ@mail.gmail.com>
 <CANXojcy9JzXeLQ6bz9+UOekkpqo8NkgQbhugmGmPE+x3+_=h3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXojcy9JzXeLQ6bz9+UOekkpqo8NkgQbhugmGmPE+x3+_=h3Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 06:09:41AM +0100, Stef Bon wrote:
> Hi Ioannis,
> 
> I see that you have been working on making fsnotify work on virtiofs.
> Earlier you contacted me since I've written this:
> 
> https://github.com/libfuse/libfuse/wiki/Fsnotify-and-FUSE
> 
> and send you my patches on 23 june.
> I want to mention first that I would have appreciated it if you would
> have reacted to me after I've sent you my patches. I did not get any
> reaction from you. Maybe these patches (which differ from what you
> propose now, but there is also a lot in common) have been an
> inspiration for you.

Hi Stef,

Sorry about not giving you the credit you deserved. We definitely made
a mistake here. We will be more careful in future and not repeat such
things.

> 
> Second, what I've written about is that with network filesystems (eg a
> backend shared with other systems) fsnotify support in FUSE has some
> drawbacks.
> In a network environment, where a network fs is part of making people
> collaborate, it's very useful to have information on who did what on
> which host, and also when. Simply a message "a file has been created
> in the folder you watch" is not enough. For example, if you are part
> of a team, and assigned to your team is a directory on a server where
> you can work on some shared documents. Now in this example there is a
> planning, and some documents have to be written. In that case you want
> to be informed that someone in your team has started a document (by
> creating it) by the system.
> 
> This "extended" information will never get through fsnotify.

Wondering fsnotify can be extended to carry this info when available.

> 
> Other info useful to you as team member:
> 
> -  you have become member of another team: sbon@anotherteam.example.org
> -  diskspace and/or quota shortage reported by networksystem
> -  new teammember, teammember left
> -  your "rights" or role in the network/team have been changed (for
> example from reader to reader and writer to some documents)

All these sound useful. Some of them like change of team/group or
change of rights/role seem outside the scope of filesystem notificaitons
as such.  Some sort of notifications for diskspace/quota could be
applicable to local filesystems too.

> 
> What I want to say is that in a network where lots of people work
> together in teams/projects, (and I want Linux to play a role there, as
> desktop/workstation) communication is very important, and all these
> messages should be supported by the system. My idea is the support of
> watching fs events with FUSE filesystems should go through userspace,
> and not via the kernel (cause fs events are part of your setup in the
> network, together with all other tools to make people collaborate like
> chat/call/text, and because mentioned above extended info about the
> who on what host etc is not supported by fsnotify).

> There should be a fs event watcher which takes care of all watches on
> behalf of applications during a session, similar to gamin and FAM once
> did (not used anymore?).

So how does the API look like for this OOB channel? Have you published
it somewhere.

Thanks
Vivek

> When receiving a request from one of the applications this fsevent
> watcher will use inotify and/or fanotify for local fs's only. With a
> FUSE fs, it should contact (via a socket) this fs that a watch has
> been set on an inode with a certain mask.
> If the FUSE fs does not support this, fallback on normal inotify/fanotify.
> This way extended info is possible.
> 
> Is this extended information also useful for virtiofs?
> 
> Stef Bon
> 

