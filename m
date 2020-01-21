Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388821437DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 08:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgAUHtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 02:49:21 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:43976 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAUHtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:49:20 -0500
Received: by mail-il1-f196.google.com with SMTP id v69so1600052ili.10;
        Mon, 20 Jan 2020 23:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZADz/FNfyrk8GhdpCwj0XUkKM1g47IFDaAtucTO16qc=;
        b=jNz9Ohc565qRzVXzSYzlKqNVNNEULA0EkVEYSEyawvPa0vDsLlZfWkDXzizX8wcb5D
         oSAu0czMTxQG/8MECY8NjpkTUxA08oJM85rckS9SaxQxlj4AoxlHLUt7OTUmDselV/RV
         C2e80KMbsAHEGULaI+Bz3M5CmLgRk1ECCKwOvC+lcWsbhRTh4XgrRqIdp5AKdTEHgnpH
         x0lNSPczqLOeOZwj9wyzGS0yXt7zX+LYVmdncO5miJz6urpSgztp1zz43hPJpLAPoT7t
         OINVyyd98RhIuAAsXVbm4b2LqDcSOJKbS3iVWZp2Let/bZ0peflKujWRhYEXgi0VvLWT
         WKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZADz/FNfyrk8GhdpCwj0XUkKM1g47IFDaAtucTO16qc=;
        b=i+Qx23UxVPceIg1bwWWS2BKyIp57kAaHBnq2l1R+uPklmvqfN5gcRkPEmjSl4ocbLu
         KAVNR9+SnHK1gsTrSyPZF9V0dm0OrhshY0DbTd/rhHY0mfgdPhTgiTdBOPfItf8N0b75
         TSJmKD7Au4MnMt0huispT1+u4aQ801xfSbYJ4XhtpQ3H7qKd9nujgSGc1F41c/biORxp
         sOnyjaQZ2oIifOUOgwkng7JU6WfKpkIRh9nShp1XJJk5bATu5YKsp9xkCIY6FhJU7mwL
         GGdMgkvvJqSVA0Vbo4xLK8hPDNuo3Ua6baBKO+mZPt+VTri08QIj1phDGtM9u5CzQ+jR
         p9bA==
X-Gm-Message-State: APjAAAWtRSHJMQGl6GO6GS56cvF+10/uGjcQhvXmy9ECTjo0dSHkiAhK
        u9Gyhnodhlt2sL7qinYWCCH3IaRqWdcW/D1ehyImGA==
X-Google-Smtp-Source: APXvYqyscUHi4/FZylWVcSxo7TKDBIOKpQNTLHgUP8nf1eAm36zAv5zDgQqMEvdHljx48bvDMaFT1Sg5ajsaBgYhLgM=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr2696893ili.72.1579592960046;
 Mon, 20 Jan 2020 23:49:20 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mvUmZca8TRVsyZvrB_Loeeo4Kd8T7rHw5s6iaN=yC+O_Q@mail.gmail.com>
 <CAOQ4uxipauh1UXHSFt=WsiaDexqecjm4eDkVfnQXN8eYofdg2A@mail.gmail.com>
In-Reply-To: <CAOQ4uxipauh1UXHSFt=WsiaDexqecjm4eDkVfnQXN8eYofdg2A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Jan 2020 09:49:09 +0200
Message-ID: <CAOQ4uxjFof3GWX3gncJgbaynsmQ2+4A3hGuSOhGDQsGguJu-Vw@mail.gmail.com>
Subject: Re: [LFS/MM TOPIC] Enabling file and directory change notification
 for network and cluster file systems
To:     Steve French <smfrench@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CC: lsf-pc

On Tue, Jan 21, 2020 at 9:47 AM Amir Goldstein <amir73il@gmail.com> wrote:
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
>
> Thanks,
> Amir.
