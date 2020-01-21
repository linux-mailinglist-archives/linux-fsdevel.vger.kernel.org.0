Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44314383E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 09:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAUIa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 03:30:58 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37329 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgAUIa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:30:58 -0500
Received: by mail-il1-f195.google.com with SMTP id t8so1714474iln.4;
        Tue, 21 Jan 2020 00:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lmYZA0xagCNpKIKxnr8C27kUmnLdAKn/OTbkn0CFX/U=;
        b=Et9c6PWnnBiw+t3+vwjYJioRYKMX5K/LHeHA+QdUm6jwsMmxkx5DkoZpFvltAgckcK
         5tLBpdreal7Sgh25xCh4o1j4J5GM32RFtbwWcZ+/Vk4nD4ozs3HpRajulGQhjbj1Vgmq
         vCtDwDQr7H4Wg8eIZKxcE/7atF/Mh9IpjUZkRPU+kV4W5e4drzQzLUOubaRCtSqBEIZY
         637vyUCzdNePQHmTEFzOxj0qEYISZ+mCYf5K+Mb/gkVozpS04GPETGm/1f/Py8UaOOFl
         hqdj02wkV3PbKUPhttnNuTVWWc1Hk1L04gY1doushBJV0Q4s9MWTw9c16fJ7ICvvR+hU
         gprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmYZA0xagCNpKIKxnr8C27kUmnLdAKn/OTbkn0CFX/U=;
        b=k/rfUAUP28bZm7yN/tPWAPnrTctzCYMNetNIdi9pJYei5zvF9G0Lr5pXe6EoQ7gP63
         TCNsUU1pFmo7Bzon5pXuPazF/eL3unSjZ87V2I5eb4ssF8crbnYEN3m0NVawEa85C7vV
         WQ3bpUhuTw7JQAIM247AbBquqerV+PpPYU7FmgwH+ROQG+iHp5tQgXhmYvpQyZriO4l4
         Lsjfcff+Sjp1xm7ZMXZqU0N365ULCfAXmlcZCY4dWYiltoeg1h2jzj8GTG5k/JGYhGj6
         3J2+P6AKW5rht6IUEYKdsmWUTjzzUPG7GSDea0Ftkr6SGZZnXkX1d+EhitTmJt4GGOUk
         i3MQ==
X-Gm-Message-State: APjAAAUPu4XNNuGAyVCmk0QKy5hFgTQOTwTSnmbiRU4GEmvJYBaALqmI
        poSTN8Pj9S9BXwGttbdaVPiDJAIaJD6vGcmYvkjM5Q==
X-Google-Smtp-Source: APXvYqwCqtWTPNjVv9vureQtYBXjkX/ot+vJ9y7f9T+ySw23uFSRbyKmenNIgO2Y5AOhIhUVoiktBF4yUgnseUzNU4E=
X-Received: by 2002:a92:5b49:: with SMTP id p70mr454103ilb.209.1579595457634;
 Tue, 21 Jan 2020 00:30:57 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mvUmZca8TRVsyZvrB_Loeeo4Kd8T7rHw5s6iaN=yC+O_Q@mail.gmail.com>
 <CAOQ4uxipauh1UXHSFt=WsiaDexqecjm4eDkVfnQXN8eYofdg2A@mail.gmail.com>
In-Reply-To: <CAOQ4uxipauh1UXHSFt=WsiaDexqecjm4eDkVfnQXN8eYofdg2A@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Tue, 21 Jan 2020 18:30:46 +1000
Message-ID: <CAN05THQeUs1ksOv5sRTx7Dvr0=WKxSguw+gWpw2KpX3byEJagw@mail.gmail.com>
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

On Tue, Jan 21, 2020 at 5:48 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Jan 21, 2020 at 5:55 AM Steve French <smfrench@gmail.com> wrote:
> >
> > Currently the inotify interface in the kernel can only be used for
> > local file systems (unlike the previous change notify API used years
> > ago, and the change notify interface in Windows and other OS which is
> > primarily of interest for network file systems).
> >
> > I wanted to discuss the VFS changes needed to allow inotify requests
> > to be passed into file systems so network and cluster file systems (as
> > an example in the SMB3 case this simply means sending a
> > SMB3_CHANGE_NOTIFY request to the server, whether Samba or Cloud
> > (Azure) or Mac or Windows or Network Appliance - all support the API
> > on the server side, the problem is that the network or cluster fs
> > client isn't told about the request to wait on the inotify event).
> > Although user space tools can use file system specific ioctls to wait
> > on events, it is obviously preferable to allow network and cluster
> > file systems to wait on events using the calls which current Linux
> > GUIs use.
> >
> > This would allow gnome file manager GUI for example to be
> > automatically updated when a file is added to an open directory window
> > from another remote client.
> >
> > It would also fix the embarrassing problem noted in the inotify man page:
> >
> > "Inotify  reports  only events that a user-space program triggers
> > through the filesystem
> >        API.  As a result, it does not catch remote events that occur
> > on  network  filesystems."
> >
> > but that is precisely the types of notifications that are most useful
> > ... users often are aware of updates to local directories from the
> > same system, but ... automatic notifications that allow GUIs to be
> > updated on changes from **other** clients is of more value (and this
> > is exactly what the equivalent API allows on other OS).
> >
> > The changes to the Linux VFS are small.
> >
> >
>
> Miklos has already posted an RFC patch:
> https://lore.kernel.org/linux-fsdevel/20190507085707.GD30899@veci.piliscsaba.redhat.com/
>
> Did you try it?
>
> You also did not answer Miklos' question:
> does the smb protocol support whole filesystem (or subtree) notifications?
> (or just per-directory notifications)?

SMB can do both. There is a flag that specifies if you want to just
get notified about the directory itself
or whether  you want notifications from the whole subtree.

>
> Thanks,
> Amir.
