Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C032143A3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 11:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgAUKDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 05:03:08 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38061 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAUKDI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:03:08 -0500
Received: by mail-io1-f66.google.com with SMTP id i7so2230448ioo.5;
        Tue, 21 Jan 2020 02:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRLVY0ayDDdLTY8PY27WBbkZWTqTTISM+W1lZC8rwFw=;
        b=DVh8CqzIeJJCqf5lPCo5fml9z41h0s45Lfl19jzzHrciveokpsxw7VW7fTTioI29IB
         TJviJ2WeJFbjyw/16aezwF10+mby0r/igGmygy98Ayh/qHA6/y8UjimBFTMzYrEeBIes
         eofkvD99ixwuArs+n6WicBKTYUh1n7hZsA6Ptrvj+DEdP/feNKBqMVfp7kE5Wsyus/VG
         NtJW4Ety1aQ2WMMfX7L/VS9KJINaXUy6SKYcaLj2gWrUN3W9b9eeteQZ4syX7rFN73bN
         3UPOaVn4B68rlZaUcnI3ZTSaWE696jPhWItmAlFWH7gsY792e2Ne4qvYCq06DtsdQUif
         IT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRLVY0ayDDdLTY8PY27WBbkZWTqTTISM+W1lZC8rwFw=;
        b=UzU+reaj/m9rDebajOrOjm1oG2PHX1AgZTFIGsVWIuXE+T0MUsy5yU/jDt9c1RmE5l
         QNEBawWWcnhbJLwf8uSt7PXPJ1YCTG3Rp/v6pwAkFU1D325BRGneBARbNVdhk0sHNbQO
         80oHTlefzKxppxFLCuJH3r00ZF3RUUIYE4rmflNf6ZuUspVdVhT96+wGNZPNEF4NyHlW
         a55TxTEO/Pz4jMa53Vfoap2MNy2zpPyzwWzxNIo1//5lvjfsFtFiDdCjuf4xctX3GpEU
         PTi2W3UCvQ0+HVv9I+N4vUBH+NfhFJ9ONTRZo+zawtYMlznJNbZimi8Y3J+i3S6oiex8
         t56g==
X-Gm-Message-State: APjAAAVCEKU+J1OcEY/UmaT4+ChHnLioUTH5Fc6W5Z6XpUI43rZJjf3G
        zZn28t3RCzSVf52h41t2xvJb4lFLkeCyTvuWFgSrsfbd
X-Google-Smtp-Source: APXvYqzdOeESSnZVuwRJTueioQY/+cJkRvgsK9YbBYEH2ehmz0OoLGmo5Er8u4bnQhrPYdvAfN0uy9vXJg71sUzjV8U=
X-Received: by 2002:a6b:e506:: with SMTP id y6mr2340288ioc.209.1579600987362;
 Tue, 21 Jan 2020 02:03:07 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mvUmZca8TRVsyZvrB_Loeeo4Kd8T7rHw5s6iaN=yC+O_Q@mail.gmail.com>
 <CAOQ4uxipauh1UXHSFt=WsiaDexqecjm4eDkVfnQXN8eYofdg2A@mail.gmail.com>
 <CAN05THQeUs1ksOv5sRTx7Dvr0=WKxSguw+gWpw2KpX3byEJagw@mail.gmail.com> <CAOQ4uxgNEoO-NHb9V=Nqho5dBz2U034Q6wa_Gw=sKmYj2uUJMQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgNEoO-NHb9V=Nqho5dBz2U034Q6wa_Gw=sKmYj2uUJMQ@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Tue, 21 Jan 2020 20:02:56 +1000
Message-ID: <CAN05THSwSMji9CHM=x6oKzRmD2XO9TUShBO-ExT07vom8fRdoA@mail.gmail.com>
Subject: Re: [LFS/MM TOPIC] Enabling file and directory change notification
 for network and cluster file systems
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 7:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Jan 21, 2020 at 10:30 AM ronnie sahlberg
> <ronniesahlberg@gmail.com> wrote:
> >
> > On Tue, Jan 21, 2020 at 5:48 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Tue, Jan 21, 2020 at 5:55 AM Steve French <smfrench@gmail.com> wrote:
> > > >
> > > > Currently the inotify interface in the kernel can only be used for
> > > > local file systems (unlike the previous change notify API used years
> > > > ago, and the change notify interface in Windows and other OS which is
> > > > primarily of interest for network file systems).
> > > >
> > > > I wanted to discuss the VFS changes needed to allow inotify requests
> > > > to be passed into file systems so network and cluster file systems (as
> > > > an example in the SMB3 case this simply means sending a
> > > > SMB3_CHANGE_NOTIFY request to the server, whether Samba or Cloud
> > > > (Azure) or Mac or Windows or Network Appliance - all support the API
> > > > on the server side, the problem is that the network or cluster fs
> > > > client isn't told about the request to wait on the inotify event).
> > > > Although user space tools can use file system specific ioctls to wait
> > > > on events, it is obviously preferable to allow network and cluster
> > > > file systems to wait on events using the calls which current Linux
> > > > GUIs use.
> > > >
> > > > This would allow gnome file manager GUI for example to be
> > > > automatically updated when a file is added to an open directory window
> > > > from another remote client.
> > > >
> > > > It would also fix the embarrassing problem noted in the inotify man page:
> > > >
> > > > "Inotify  reports  only events that a user-space program triggers
> > > > through the filesystem
> > > >        API.  As a result, it does not catch remote events that occur
> > > > on  network  filesystems."
> > > >
> > > > but that is precisely the types of notifications that are most useful
> > > > ... users often are aware of updates to local directories from the
> > > > same system, but ... automatic notifications that allow GUIs to be
> > > > updated on changes from **other** clients is of more value (and this
> > > > is exactly what the equivalent API allows on other OS).
> > > >
> > > > The changes to the Linux VFS are small.
> > > >
> > > >
> > >
> > > Miklos has already posted an RFC patch:
> > > https://lore.kernel.org/linux-fsdevel/20190507085707.GD30899@veci.piliscsaba.redhat.com/
> > >
> > > Did you try it?
> > >
> > > You also did not answer Miklos' question:
> > > does the smb protocol support whole filesystem (or subtree) notifications?
> > > (or just per-directory notifications)?
> >
> > SMB can do both. There is a flag that specifies if you want to just
> > get notified about the directory itself
> > or whether  you want notifications from the whole subtree.
> >
>
> I see. There is no user API in Linux to request a "subtree" watch.
> For the private case that the user requests a FAN_MARK_FILESYSTEM,
> cifs may translate that into a SMB2_WATCH_TREE for the share root dir.
>
> For that, Miklos' RFC of vfs interface inode->i_op->notify_update(inode)
> should be enriched with sb->s_op->notify_update(sb).

It all depends on what actual linux applications want/need.

On windows, things like the windows explorer file manager only uses
"this directory only" watches.
I imagine that linux gui filemanagers would do the same and be fine
with this directory only watches.

On windows you also have a large class of applications that does file
caching in the userspace application itself. Like IIS or other
applications
such as indexing services or things that keep track of changes to know
what to backup at a later stage.
They always use "watch the whole subtree" version of notifications.
I don't think there are any linux native applications that would
depend on this as the functionality was never present. Maybe an
exception would be windows applications running under wine, but surely
no currently existing linux native applications.

If we do get an API that would allow to watch an entire subtree then
that would make it possible for future backup applications to become
much more effective for incremental backups.  Things like "git status"
would likely also benefit greatly from such an api if it became
available.

>
> Thanks,
> Amir.
