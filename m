Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB49E1439B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 10:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAUJnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 04:43:17 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34070 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgAUJnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:43:17 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so2195747iof.1;
        Tue, 21 Jan 2020 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSC80w1hqN7I9WREwEfl+koEvmU+Z7Kf4VwNXG3N+/I=;
        b=iDhWr5DHulz2CjWIl8UqyGsfO41PP0v73orZ/uai7miM82+1XtTvcibof1v+wK9bBP
         hQVdNCdkXPXZsOsJj4pScBZoswTrzpnKzTTkhr3TewxaGxbfNspR5HDYGjRhtKfaNhrf
         K41KxmOKXz8LCI+qrHqkVId+gCHH7TXkKZIHWaYrr/WTykCarUHwXgcZNQUimBEHk/1C
         eE9/RiX8+2JY8NMkul1WXNwD670pE6n/O/pjOGSLpeaJc2VuX40VPdfmTePtioCynHdw
         xFGITUoqM4LagiBBPu79msqCSow4sSJTs9sjH7xyXrGT1Yg0EQyYFwpW33tIMd8pcx6B
         CvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSC80w1hqN7I9WREwEfl+koEvmU+Z7Kf4VwNXG3N+/I=;
        b=Y/hmFciQuK02T13gLrivtWTUFaTvV77i7GfCxVeWA0G/q1TFu8fM75uc97i6j2+muR
         mrJ6mdULRoxv1hIdWT1firTtRaPenNrR7LaDOEVg/Os4YXknZc4S0NPboeWHeGpRvmp+
         ue9eoouAIYqzE+0EOQb9BNsQvkkA7oZaHxGfpKyONSaAhCBkr92aQFG8FnhzUjjzlj/g
         /zxogQFmiKw+SKbbzXOUenGsR3jL6uLyq30PFkP6xlt/Q+4bbYdvPetbrClnEDiTMOUq
         dMBeBijZ1lGQhMWjYqDoUxd57pRcRRxs+fpS3BueL2wes3CmIpAPcdxiKcVSKH2z73h3
         Ga3g==
X-Gm-Message-State: APjAAAWbi37qjijh2tkI6ZBMuylHsUaVAXrq81KFN9t37XNc7UJGBRKA
        Qv+Za4fRRroXYQXU942gxDNwn0VjfAtDsF2H+rw=
X-Google-Smtp-Source: APXvYqyC3Q2o+FEXJZs0Ii3xtV0ucBq9A76dblPtJcymujCucsXIJDoVrpoFepmICsakC+pFR+N+rX0JwR8T6ovFrrQ=
X-Received: by 2002:a6b:f214:: with SMTP id q20mr2520410ioh.137.1579599796371;
 Tue, 21 Jan 2020 01:43:16 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mvUmZca8TRVsyZvrB_Loeeo4Kd8T7rHw5s6iaN=yC+O_Q@mail.gmail.com>
 <CAOQ4uxipauh1UXHSFt=WsiaDexqecjm4eDkVfnQXN8eYofdg2A@mail.gmail.com> <CAN05THQeUs1ksOv5sRTx7Dvr0=WKxSguw+gWpw2KpX3byEJagw@mail.gmail.com>
In-Reply-To: <CAN05THQeUs1ksOv5sRTx7Dvr0=WKxSguw+gWpw2KpX3byEJagw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Jan 2020 11:43:05 +0200
Message-ID: <CAOQ4uxgNEoO-NHb9V=Nqho5dBz2U034Q6wa_Gw=sKmYj2uUJMQ@mail.gmail.com>
Subject: Re: [LFS/MM TOPIC] Enabling file and directory change notification
 for network and cluster file systems
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
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

On Tue, Jan 21, 2020 at 10:30 AM ronnie sahlberg
<ronniesahlberg@gmail.com> wrote:
>
> On Tue, Jan 21, 2020 at 5:48 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Jan 21, 2020 at 5:55 AM Steve French <smfrench@gmail.com> wrote:
> > >
> > > Currently the inotify interface in the kernel can only be used for
> > > local file systems (unlike the previous change notify API used years
> > > ago, and the change notify interface in Windows and other OS which is
> > > primarily of interest for network file systems).
> > >
> > > I wanted to discuss the VFS changes needed to allow inotify requests
> > > to be passed into file systems so network and cluster file systems (as
> > > an example in the SMB3 case this simply means sending a
> > > SMB3_CHANGE_NOTIFY request to the server, whether Samba or Cloud
> > > (Azure) or Mac or Windows or Network Appliance - all support the API
> > > on the server side, the problem is that the network or cluster fs
> > > client isn't told about the request to wait on the inotify event).
> > > Although user space tools can use file system specific ioctls to wait
> > > on events, it is obviously preferable to allow network and cluster
> > > file systems to wait on events using the calls which current Linux
> > > GUIs use.
> > >
> > > This would allow gnome file manager GUI for example to be
> > > automatically updated when a file is added to an open directory window
> > > from another remote client.
> > >
> > > It would also fix the embarrassing problem noted in the inotify man page:
> > >
> > > "Inotify  reports  only events that a user-space program triggers
> > > through the filesystem
> > >        API.  As a result, it does not catch remote events that occur
> > > on  network  filesystems."
> > >
> > > but that is precisely the types of notifications that are most useful
> > > ... users often are aware of updates to local directories from the
> > > same system, but ... automatic notifications that allow GUIs to be
> > > updated on changes from **other** clients is of more value (and this
> > > is exactly what the equivalent API allows on other OS).
> > >
> > > The changes to the Linux VFS are small.
> > >
> > >
> >
> > Miklos has already posted an RFC patch:
> > https://lore.kernel.org/linux-fsdevel/20190507085707.GD30899@veci.piliscsaba.redhat.com/
> >
> > Did you try it?
> >
> > You also did not answer Miklos' question:
> > does the smb protocol support whole filesystem (or subtree) notifications?
> > (or just per-directory notifications)?
>
> SMB can do both. There is a flag that specifies if you want to just
> get notified about the directory itself
> or whether  you want notifications from the whole subtree.
>

I see. There is no user API in Linux to request a "subtree" watch.
For the private case that the user requests a FAN_MARK_FILESYSTEM,
cifs may translate that into a SMB2_WATCH_TREE for the share root dir.

For that, Miklos' RFC of vfs interface inode->i_op->notify_update(inode)
should be enriched with sb->s_op->notify_update(sb).

Thanks,
Amir.
