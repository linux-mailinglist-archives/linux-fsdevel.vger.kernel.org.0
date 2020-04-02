Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A88319C331
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbgDBNwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 09:52:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33522 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387652AbgDBNwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:52:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id z65so4237467ede.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38tDIv0KNYRGjWQpLV5pSNvP7JpdlyIKdGeo6UD55p0=;
        b=mHf1i89rxwD/U2z1mjMQcSxAomeWc1se7NI0BXPkvalHMI/UmRHR8zxEzBwhHrRpie
         lfZPvoKsJex5e+99/6K6TY/U0Oi1q15Kr12GW6oIbLommTSuH7t+hSeQWFea4nTjlB3V
         95kmrieGk5HvIN6/0NbisdyXcDbd6kLMkqZLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38tDIv0KNYRGjWQpLV5pSNvP7JpdlyIKdGeo6UD55p0=;
        b=ghpd08Sl5fYuJsFkvGFQWTrjuNB9r4RhGRVcpxUNhkeM6fElamBKv0rSf0yryodhqZ
         L86awMWXQcfpcbbAkAbsWAYQuPjQppUzDZg6fPvc+4eG45NzeHxabjuLjHgB+OWYQL+X
         7vP3AxaDR4Yaj1uWKCD8iGQXC+DyEvVloH5h8WTC9EtWd03YfArEVjLAb4pjSSLPTMIK
         Rkr/4tKx8dju2eQn4b2WOJUVCqCAtKSCE3gfz+Sg03woHrt9TtQr0aw5cHKRp4QYBO3E
         gEY4O8XJBvlOES78Vra3IkA/VNMw42z9QXk+N5ZMYB7VNoBg77fhlbKIWZZbr1qpnxsj
         kpOg==
X-Gm-Message-State: AGi0PuYGKaIiCSK3RpBs9Ag3tLB/zo/17VBO6D+i+AJDUogmwoJlr58M
        s3TgSfRpBxOrbihD4e+O0uHcLE7TuKQUWfP9d3zLcmKp
X-Google-Smtp-Source: APiQypKo8OvyZ+/BkGsIAPV2v3O2scZTxPKXxe0JzG0Tp6kSAFDmG+B5Al7t8aLcLk3Z9HYXKLOkQwoo6oYOkZibBjQ=
X-Received: by 2002:a17:906:b351:: with SMTP id cd17mr3373636ejb.351.1585835548323;
 Thu, 02 Apr 2020 06:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login>
 <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
In-Reply-To: <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 Apr 2020 15:52:16 +0200
Message-ID: <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 2, 2020 at 4:52 AM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2020-04-01 at 18:40 +0200, Miklos Szeredi wrote:
> > On Wed, Apr 1, 2020 at 6:07 PM David Howells <dhowells@redhat.com>
> > wrote:
> > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > > I've still not heard a convincing argument in favor of a syscall.
> > >
> > > From your own results, scanning 10000 mounts through mountfs and
> > > reading just
> > > two values from each is an order of magnitude slower without the
> > > effect of the
> > > dentry/inode caches.  It gets faster on the second run because the
> > > mountfs
> > > dentries and inodes are cached - but at a cost of >205MiB of
> > > RAM.  And it's
> > > *still* slower than fsinfo().
> >
> > Already told you that we can just delete the dentry on dput_final, so
> > the memory argument is immaterial.
> >
> > And the speed argument also, because there's no use case where that
> > would make a difference.  You keep bringing up the notification queue
> > overrun when watching a subtree, but that's going to be painful with
> > fsinfo(2) as well.   If that's a relevant use case (not saying it's
> > true), might as well add a /mnt/MNT_ID/subtree_info (trivial again)
> > that contains all information for the subtree.  Have fun implementing
> > that with fsinfo(2).
>
> Forgive me for not trawling through your patch to work this out
> but how does a poll on a path get what's needed to get mount info.
>
> Or, more specifically, how does one get what's needed to go directly
> to the place to get mount info. when something in the tree under the
> polled path changes (mount/umount). IIUC poll alone won't do subtree
> change monitoring?

The mechanisms are basically the same as with fsinfo(2).   You can get
to the mountfs entry through the mount ID or through a proc/fd/ type
symlink.  So if you have a path, there are two options:

 - find out the mount ID belonging to that path and go to /mountfs/$mntid/
 - open the path with fd = open(path, O_PATH) and the go to
/proc/self/fdmount/$fd/

Currently the only way to find the mount id from a path is by parsing
/proc/self/fdinfo/$fd.  It is trivial, however, to extend statx(2) to
return it directly from a path.   Also the mount notification queue
that David implemented contains the mount ID of the changed mount.

> Don't get me wrong, neither the proc nor the fsinfo implementations
> deal with the notification storms that cause much of the problem we
> see now.
>
> IMHO that's a separate and very difficult problem in itself that
> can't even be considered until getting the information efficiently
> is resolved.

This mount notification storm issue got me thinking.   If I understand
correctly, systemd wants mount notifications so that it can do the
desktop pop-up thing.   Is that correct?

But that doesn't apply to automounts at all.  A new mount performed by
automount is uninteresting to to desktops, since it's triggered by
crossing the automount point (i.e. a normal path lookup), not an
external event like inserting a usb stick, etc...

Am I missing something?

Maybe the solution is to just allow filtering out such notifications
at the source, so automount triggers don't generate events for
systemd.

Thanks,
Miklos
