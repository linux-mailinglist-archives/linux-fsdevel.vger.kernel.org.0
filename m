Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D676A452A17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 06:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbhKPFzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 00:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238187AbhKPFzE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:55:04 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A81C0AD858
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 21:09:52 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id r130so17063771pfc.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 21:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=antUMEgQu5AN/kNJmEOtbmAwcQ7siqDvZ8GUdsP/QaE=;
        b=oRohn4uzfqM7ljesaWe15EzZ29DQbBVWYe/kd/L9PcExIDhgg6IApC+3B6TQCDFj86
         sYzKiyN4YHLYSTOLzdc2048h0vsCuN6KYMmddq7+u78U8vgbjAbNvPbuZzlUbwkd5JHZ
         P+h5EVCgq831tpCY/JkjBH5INoaoNYL9W3g2gcGFbk80C5fkwIHkV1VGa1P2oy+4sdf1
         u4dgL+rhc8DSigypuKf7b6xIsrwoN5z5oxLDHKchrgWyOqrtJKwxhXkF9KOsCyDUaMGP
         G+AhAqecpQ08MxDmmiZorZuIFXrCCDbfQ0K2bcWRi7h+WFsInpycIiEBcOfuS5gsdTGx
         FD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=antUMEgQu5AN/kNJmEOtbmAwcQ7siqDvZ8GUdsP/QaE=;
        b=WsRESdJaGvnZsMno0k04OqeCLtMrj/YAiGApiayBhT3/8zBNZZn0uiI47+sZA+Pex9
         scjGKYqbm13/jP2aYhXB9ZcpBi0cnjZZjLdBTyiY0DCl8/pcQryJHto6hncCxWipr6cp
         we5n+ezx+uOs8LF5OoOqMghM22dDmNkgYixVw6LP/5sbK3LlvgutGdwfv3Sjv1MlHXSG
         gzfeWTN6x3BOd5PLSRfmJgu1K49qTHKpdyShMFYPETcR+AT6EpvhBCXYbr1C3WEc9yEU
         Ys/ndLwIuEXVFzRF9QGrIQ80J98ABhg0G0vKJCWcxELjIDhTdNJMeDwGgFhh7h63sonv
         TdWw==
X-Gm-Message-State: AOAM5322okl0PPoBUo/197ej0wyesbWHSJ3TUXvU6W96oLi0HPmcC+o9
        ysJ506u0Uw+fkU/l2Gr4APWCMKQJo8Za4RR+Rw==
X-Google-Smtp-Source: ABdhPJws5yn6lSJc4FfQJuEe5rOckquUr+M2W424QMko7Q7VUFSo3Lz1xBTnq/QRgIjCGTGLwEOV+QTdFL9Pc/TgdF4=
X-Received: by 2002:a63:8c5c:: with SMTP id q28mr3144050pgn.244.1637039392434;
 Mon, 15 Nov 2021 21:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20211027132319.GA7873@quack2.suse.cz> <YXm2tAMYwFFVR8g/@redhat.com>
 <20211102110931.GD12774@quack2.suse.cz> <CAOQ4uxiYQYG8Ta=MNJKpa_0pAPd0MS9PL2r_0ZRD+_TKOw6C7g@mail.gmail.com>
 <20211103100900.GB20482@quack2.suse.cz> <CAOQ4uxjsULgLuOFUYkEePySx6iPXRczgCZMxx8E5ncw=oarLPg@mail.gmail.com>
 <YYMO1ip9ynXFXc8f@redhat.com> <20211104100316.GA10060@quack2.suse.cz>
 <YYU/7269JX2neLjz@redhat.com> <CAOQ4uxiM_i+6Zs+ewg8mfA5aKs-gY7yj3kdrmPLO8Zn+bz4DbA@mail.gmail.com>
 <20211111173043.GB25491@quack2.suse.cz> <CAOQ4uxiOUM6=190w4018w4nJRnqi+9gzzfQTsLh5gGwbQH_HgQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiOUM6=190w4018w4nJRnqi+9gzzfQTsLh5gGwbQH_HgQ@mail.gmail.com>
From:   Stef Bon <stefbon@gmail.com>
Date:   Tue, 16 Nov 2021 06:09:41 +0100
Message-ID: <CANXojcy9JzXeLQ6bz9+UOekkpqo8NkgQbhugmGmPE+x3+_=h3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Vivek Goyal <vgoyal@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ioannis,

I see that you have been working on making fsnotify work on virtiofs.
Earlier you contacted me since I've written this:

https://github.com/libfuse/libfuse/wiki/Fsnotify-and-FUSE

and send you my patches on 23 june.
I want to mention first that I would have appreciated it if you would
have reacted to me after I've sent you my patches. I did not get any
reaction from you. Maybe these patches (which differ from what you
propose now, but there is also a lot in common) have been an
inspiration for you.

Second, what I've written about is that with network filesystems (eg a
backend shared with other systems) fsnotify support in FUSE has some
drawbacks.
In a network environment, where a network fs is part of making people
collaborate, it's very useful to have information on who did what on
which host, and also when. Simply a message "a file has been created
in the folder you watch" is not enough. For example, if you are part
of a team, and assigned to your team is a directory on a server where
you can work on some shared documents. Now in this example there is a
planning, and some documents have to be written. In that case you want
to be informed that someone in your team has started a document (by
creating it) by the system.

This "extended" information will never get through fsnotify.

Other info useful to you as team member:

-  you have become member of another team: sbon@anotherteam.example.org
-  diskspace and/or quota shortage reported by networksystem
-  new teammember, teammember left
-  your "rights" or role in the network/team have been changed (for
example from reader to reader and writer to some documents)

What I want to say is that in a network where lots of people work
together in teams/projects, (and I want Linux to play a role there, as
desktop/workstation) communication is very important, and all these
messages should be supported by the system. My idea is the support of
watching fs events with FUSE filesystems should go through userspace,
and not via the kernel (cause fs events are part of your setup in the
network, together with all other tools to make people collaborate like
chat/call/text, and because mentioned above extended info about the
who on what host etc is not supported by fsnotify).
There should be a fs event watcher which takes care of all watches on
behalf of applications during a session, similar to gamin and FAM once
did (not used anymore?).
When receiving a request from one of the applications this fsevent
watcher will use inotify and/or fanotify for local fs's only. With a
FUSE fs, it should contact (via a socket) this fs that a watch has
been set on an inode with a certain mask.
If the FUSE fs does not support this, fallback on normal inotify/fanotify.
This way extended info is possible.

Is this extended information also useful for virtiofs?

Stef Bon
