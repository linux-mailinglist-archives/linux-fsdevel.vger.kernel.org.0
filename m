Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5BD4C722F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 18:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiB1RHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 12:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbiB1RHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:07:19 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3880D86E3B;
        Mon, 28 Feb 2022 09:06:40 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id x14so5357619ill.12;
        Mon, 28 Feb 2022 09:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yT9BO7LqspGlgx3scrJFgyOokQFAFM+2onJaMqMrNjE=;
        b=Bpl2eRg4BgweC31FKgffeUd8dsL6IerPbWlBrrVCKLBbwk1V/6ikK0M7pGR2Y/VbSj
         9DPu/Q8TYPtZ1lP7a93N0KQ8SsqtsgMC97AlnKFNyKm/fLmqoQ+IemSeyyjcPzlWCCq/
         V02RniZo0X6ig3Y68VUjJ8mnRtbNCWuWDbg/Q3GvXVc4UHPGed3yQGx+oYkdaxT044+P
         gPLo+dQ3qs/ugDaFcyCqT8B0ZdY5OvNuMSOoiYzks0taetWL42eyzzTpmlAKsQHNt5B3
         ypK1hLM6G67O018DkvGprtZfj5Iw6DXgjrhPXLNEdic4lLbPpiYm0rGdnxmWUoDZa48Y
         SGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yT9BO7LqspGlgx3scrJFgyOokQFAFM+2onJaMqMrNjE=;
        b=h/keihPvUhm2kZ4VgUFukjSJGORUuROWR8k4Ns8udqSXNBjW45jWWGXn890jGBR4U1
         s1UFy5ijWxby4caBB4cr0kPL2gn7DFSa9T3RO6ObV5Pi4bw6IzS37oHsUHKNnzfIQ+Vt
         +2fDiaY3OAhgBZ5NG6XveQkk3oyVCGk7lOkT7kHpCcvLTvjm7YjapJT6uKOEqJI5UDwB
         tMaVDXrp8vdCkk3qRkjcRRXgHoEtOeoYZEClYYLUQpc2d3EhbxN7FdJ7AymJOoH7e/fD
         zKtwDrs64wQjL3IFdY87l/NgSDqzsEnXjp06kIR+kpIIMbDrcIkpWmlegnjMyqw9rq8r
         lwhw==
X-Gm-Message-State: AOAM532w7PJ+gfPQ+r5f2c+bI0xj+qPzXc/rMEyQlaL+zWKzblGL1vWB
        VMgTkjskYpWP9i7wcZ7fHnEb3yPsIyAtYv0cgGA=
X-Google-Smtp-Source: ABdhPJwDpld2f9g1ZZXYohkpFIF6uRCef8rrTTHtPcfwwLiC8YFIFot+3c9vivaxwDrxHo6DtETDh48hlWwRbxXA6SE=
X-Received: by 2002:a05:6e02:214a:b0:2bf:a442:cbff with SMTP id
 d10-20020a056e02214a00b002bfa442cbffmr20398650ilv.107.1646067999554; Mon, 28
 Feb 2022 09:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20220228113910.1727819-1-amir73il@gmail.com> <20220228113910.1727819-5-amir73il@gmail.com>
 <CAJfpegvZefGp9NChm_69Km0FgpxwUs+og-uc2mpMAbH6mZ2azQ@mail.gmail.com>
 <CAOQ4uxgg8PDweNvkhXE20Gbb+=OGBbwLXjR6Yffc4ZkiKzGM0w@mail.gmail.com> <CAJfpegvnhsBB_Ym3VGs7xBQM3OWsXCsqBZncBVNFCDJXka_AwA@mail.gmail.com>
In-Reply-To: <CAJfpegvnhsBB_Ym3VGs7xBQM3OWsXCsqBZncBVNFCDJXka_AwA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 28 Feb 2022 19:06:28 +0200
Message-ID: <CAOQ4uxh=VEsspfEyxc8c6V72LJX9_nU1NSfaptsig=k8z7NOkg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] fs: report per-mount io stats
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        containers@lists.linux.dev,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 6:31 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 28 Feb 2022 at 17:19, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Feb 28, 2022 at 5:06 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Mon, 28 Feb 2022 at 12:39, Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > Show optional collected per-mount io stats in /proc/<pid>/mountstats
> > > > for filesystems that do not implement their own show_stats() method
> > > > and opted-in to generic per-mount stats with FS_MOUNT_STATS flag.
> > >
> > > This would allow some filesystems to report per-mount I/O stats, while
> > > leaving CIFS and NFS reporting a different set of per-sb stats.  This
> > > doesn't sound very clean.
> > >
> > > There was an effort to create saner and more efficient interfaces for
> > > per-mount info.  IMO this should be part of that effort instead of
> > > overloading the old interface.
> > >
> >
> > That's fair, but actually, I have no much need for per-mount I/O stats
> > in overlayfs/fuse use cases, so I could amend the patches to collect and
> > show per-sb I/O stats.
> >
> > Then, the generic show_stats() will not be "overloading the old interface".
> > Instead, it will be creating a common implementation to share among different
> > filesystems and using an existing vfs interface as it was intended.
> >
> > Would you be willing to accept adding per-sb I/O stats to overlayfs
> > and/or fuse via /proc/<pid>/mountstats?
>
> Yes, that would certainly be more sane.   But I'm also wondering if
> there could be some commonality with the stats provided by NFS...
>

hmm, maybe, but look:

device genesis:/shares/media mounted on /mnt/nfs with fstype nfs4 statvers=1.1
opts: rw,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,acregmin=3,acregmax=60,acdirmin=30,acdirmax=60,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.122.1,local_lock=none
age: 38
impl_id: name='',domain='',date='0,0'
caps: caps=0x3ffbffff,wtmult=512,dtsize=32768,bsize=0,namlen=255
nfsv4: bm0=0xfdffbfff,bm1=0xf9be3e,bm2=0x68800,acl=0x3,sessions,pnfs=not
configured,lease_time=90,lease_expired=0
sec: flavor=1,pseudoflavor=1
events: 0 0 0 0 0 2 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
bytes: 0 0 0 0 0 0 0 0
RPC iostats version: 1.1  p/v: 100003/4 (nfs)
xprt: tcp 0 0 2 0 38 27 27 0 27 0 2 0 0
per-op statistics
       NULL: 1 1 0 44 24 0 0 0 0
       READ: 0 0 0 0 0 0 0 0 0
       WRITE: 0 0 0 0 0 0 0 0 0
       COMMIT: 0 0 0 0 0 0 0 0 0
       OPEN: 0 0 0 0 0 0 0 0 0
       OPEN_CONFIRM: 0 0 0 0 0 0 0 0 0
       OPEN_NOATTR: 0 0 0 0 0 0 0 0 0
       OPEN_DOWNGRADE: 0 0 0 0 0 0 0 0 0
       CLOSE: 0 0 0 0 0 0 0 0 0
       ...

Those stats are pretty specific to NFS.
Most of it is RPC protocol stats, not including cached /I/O stats,
so in fact the generic collected io stats could be added to nfs_show_stats()
and they will not break the <tag>:<value> format.

I used the same output format as /proc/<pid>/io for a reason.
The iotop utility parses /proc/<pid>/io to display io per task and
also displays total io stats for block devices.

I am envisioning an extended version of iotop (-m ?) that also
displays total iostats per mount/sb, when available.

Thanks,
Amir.
