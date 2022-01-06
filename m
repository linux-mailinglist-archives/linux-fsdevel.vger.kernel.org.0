Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707D2486DDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 00:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245577AbiAFXhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 18:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbiAFXhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:37:46 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56518C061245
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jan 2022 15:37:45 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p13so9274764lfh.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jan 2022 15:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQgaHCAz+4zHANZcp3Rs7RBfJqdzxQQmeo6/berIQ9U=;
        b=HuagXbpCAiQyDWw6Sas35jYs1AreAg+q+bw0innkNvPZ9FTVYFQis70MSlQY+FrtCv
         l4xJ/tZRqOCKKn63jqe0sh7mAAVyTibFPLIq4EWeM6zRH0vW28MWiHGIEo5OEWB6ZEDZ
         pW0GYMO6VPLMcORxvhj6lhXNx94ku/x58AEYrLla/a6xneiNXMC/qRTxO7G3t6H2iMjj
         E91J2yGrNUnu96G82iBZy/zjd7JrxxzqSn16qterd7h+SQ8o6uiMiHAQzwF14UXDY4Eb
         edvntcGUa98ECEBO8N3M4JhSpckhuCAi6au5FCqMSlz8bXvWytuXSzZvFSmxBZ9a1P6c
         qJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQgaHCAz+4zHANZcp3Rs7RBfJqdzxQQmeo6/berIQ9U=;
        b=8EupNbBonThP/3EGGRqRxilEIXWDTZTHDKpSq2AFGH4mq3o1zLqO/9FfQB7ZptwEL6
         YEeqJtfnwV433IhnYvCXsI2nzw3bD76ep8qOpvdsLNExWggTaxQawmVP3RfgNj2oq4dY
         v2Kn9BkdZDFkplKCDNZkkoY37oBRqVIzfIFIaocPSgpAETXotDPpYxRuTDN5r6njJWaA
         azeoUiZ+I4zLpvX7GyUeU6E36mC6i21Y8eIpmnHLtY5qReUR73jkrznfcHoSPm5/RWiG
         +PyCt55XeaGruoyQHx53J+FFcfmvbegsdBQK8yEz4wwiBpj30QOPP7It3s5k+RH6V0FJ
         9VwA==
X-Gm-Message-State: AOAM533v2lpINodnozB8G3LXouoz7JCxjnNUo1tUpqFenQbmRXmG0eqO
        RItlDPjyeCg7/8R0vANS1L/1k8/Kseut35/3Gtpm5KYnxqY=
X-Google-Smtp-Source: ABdhPJwGjywM76++RnCkRqRPDuCKzo2hz/E9jmJx/FdymSiau6Fq4p6vhHdIFGtSRlQrZVWeq+NmvzHx5b30eyMmTU0=
X-Received: by 2002:a05:6512:2083:: with SMTP id t3mr53063993lfr.595.1641512263562;
 Thu, 06 Jan 2022 15:37:43 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjsULgLuOFUYkEePySx6iPXRczgCZMxx8E5ncw=oarLPg@mail.gmail.com>
 <YYMO1ip9ynXFXc8f@redhat.com> <20211104100316.GA10060@quack2.suse.cz>
 <YYU/7269JX2neLjz@redhat.com> <CAOQ4uxiM_i+6Zs+ewg8mfA5aKs-gY7yj3kdrmPLO8Zn+bz4DbA@mail.gmail.com>
 <20211111173043.GB25491@quack2.suse.cz> <CAOQ4uxiOUM6=190w4018w4nJRnqi+9gzzfQTsLh5gGwbQH_HgQ@mail.gmail.com>
 <CANXojcy9JzXeLQ6bz9+UOekkpqo8NkgQbhugmGmPE+x3+_=h3Q@mail.gmail.com>
 <CAO17o21YVczE2-BTAVg-0HJU6gjSUkzUSqJVs9k-_t7mYFNHaA@mail.gmail.com>
 <CAOQ4uxjpGMYZrq74S=EaSO2nvss4hm1WZ_k+Xxgrj2k9pngJgg@mail.gmail.com> <YaZC+R7xpGimBrD1@redhat.com>
In-Reply-To: <YaZC+R7xpGimBrD1@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 6 Jan 2022 17:37:32 -0600
Message-ID: <CAH2r5mv1x9J0uR4x=D3hApNbaZpoYrQdifSQqdu3nBHrkOaxgg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>,
        Stef Bon <stefbon@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>,
        Nathan Youngman <git@nathany.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 1, 2021 at 9:06 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Nov 17, 2021 at 08:40:57AM +0200, Amir Goldstein wrote:
> > On Wed, Nov 17, 2021 at 12:12 AM Ioannis Angelakopoulos
> > <iangelak@redhat.com> wrote:
> > >
> > >
> > >
> > > On Tue, Nov 16, 2021 at 12:10 AM Stef Bon <stefbon@gmail.com> wrote:
> > >>
> > >> Hi Ioannis,
> > >>
> > >> I see that you have been working on making fsnotify work on virtiofs.
> > >> Earlier you contacted me since I've written this:
> > >>
> > >> https://github.com/libfuse/libfuse/wiki/Fsnotify-and-FUSE
> > >>

We had a few customer requests recently to fix inotify for network fs
which reminded me of Miklos's earlier patch to fix the VFS layer, but
if changes to extend inotify in userspace were also done it would be
important to tie them in with network/cluster filesystems that expose
change notification over their network API.    Most or all major SMB
servers support change notification today so it is extremely common
over SMB3.1.1 (and earlier dialects as well).    If you have userspace
inotify libraries while we wait for changes to the VFS layer to enable
remote change notification - in the interim you can use an existing
fsspecific ioctl for some filesystems like cifs.ko. See
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/cifs/ioctl.c?id=d26c2ddd33569667e3eeb577c4c1d966ca9192e2
