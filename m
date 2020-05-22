Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A351DED51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 18:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgEVQdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 12:33:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730474AbgEVQdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 12:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590165192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4sy0ib9KEdvEVMUccLs1iu3r+olJXF2ra9ooHBixRc=;
        b=jIclSPKARplo1dy+Jy0Vm9JVduZEagBLKBOdPqJ1CgyAoj6kdGRpuatse7fE36Fspg6xdQ
        OeGdO9rMqbdwv33pKOY0ewE+iEC2IOfs761xqzboF8krJ7/5YQ51a3uHnVGYJDBv4kCIj9
        h24Oaxv7O/Xj89BG+fNIB2mQKXmYWtY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-jEnzPK0mN9mGw2RadyWqUQ-1; Fri, 22 May 2020 12:33:10 -0400
X-MC-Unique: jEnzPK0mN9mGw2RadyWqUQ-1
Received: by mail-qk1-f199.google.com with SMTP id p126so11636345qke.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 09:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4sy0ib9KEdvEVMUccLs1iu3r+olJXF2ra9ooHBixRc=;
        b=cacxWe5yUE+fpDukjgKqWtmloudmlJjR4r9JLybLUvrZDuMr5Yo6ytNagVrwb0PqMp
         5jrQYYuvR8YNr4pIDwpc6xBxChc4hyHyGYsXyhIIrwo+D6hTJ9Uj9qFiI1rF75QCeU0Y
         Q6630Mg9tbH/JtlnKFBBywGyu3jsLskGpIXLttZdwd2O8brCLfGNcaLpf8U3n6o9gj+g
         C2uKnXuzfcOyutbZ3u2MMiiNAek32nq0iketTrpOad6aBRR2y+d6Wwir/2kRyNDDiTMd
         taGIxE6BtuHshvLjqrIR18Ga68Bthk4D0zKzxXauU8LWSrwoTJzgvSaSWasaqaYyshxz
         wSaA==
X-Gm-Message-State: AOAM532S5Dyu4lUqxJydjRSaUeNHfW4jozva/ceeK1+y6nHKTCb867VL
        k1pu1dxKRAX7r3I4dzUCZ9IzPenOvhiiJ/QyyZ/rsQg996onICXhtWfsgIUId1j+U/jmo0SKZ4U
        7KjYGEKzLO8+rcgpAh/kNd1ENZcjN2WUH9G6TJrXkuA==
X-Received: by 2002:a37:8187:: with SMTP id c129mr15675242qkd.211.1590165190420;
        Fri, 22 May 2020 09:33:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwan68PpwoXP+D6L8Pi8mUQ11pMuHqUW7nq4FeZkfYH5C3xdBN7yioropShBDXxBxctjj/0oxtD9IHE2Fx9vMw=
X-Received: by 2002:a37:8187:: with SMTP id c129mr15675212qkd.211.1590165190105;
 Fri, 22 May 2020 09:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200522085723.29007-1-mszeredi@redhat.com> <20200522160815.GT23230@ZenIV.linux.org.uk>
In-Reply-To: <20200522160815.GT23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 22 May 2020 18:32:59 +0200
Message-ID: <CAOssrKcpQwYh39JpcNmV3JiuH2aPDJxgT5MADQ9cZMboPa9QaQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: make private mounts longterm
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 6:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, May 22, 2020 at 10:57:23AM +0200, Miklos Szeredi wrote:
> > Overlayfs is using clone_private_mount() to create internal mounts for
> > underlying layers.  These are used for operations requiring a path, such as
> > dentry_open().
> >
> > Since these private mounts are not in any namespace they are treated as
> > short term, "detached" mounts and mntput() involves taking the global
> > mount_lock, which can result in serious cacheline pingpong.
> >
> > Make these private mounts longterm instead, which trade the penalty on
> > mntput() for a slightly longer shutdown time due to an added RCU grace
> > period when putting these mounts.
> >
> > Introduce a new helper kern_unmount_many() that can take care of multiple
> > longterm mounts with a single RCU grace period.
>
> Umm...
>
> 1) Documentation/filesystems/porting - something along the lines
> of "clone_private_mount() returns a longterm mount now, so the proper
> destructor of its result is kern_unmount()"
>
> 2) the name kern_unmount_many() has an unfortunate clash with
> fput_many(), with arguments that look similar and mean something
> entirely different.  How about kern_unmount_array()?
>
> 3)
> > -     mntput(ofs->upper_mnt);
> > -     for (i = 1; i < ofs->numlayer; i++) {
> > -             iput(ofs->layers[i].trap);
> > -             mntput(ofs->layers[i].mnt);
> > +
> > +     if (!ofs->layers) {
> > +             /* Deal with partial setup */
> > +             kern_unmount(ofs->upper_mnt);
> > +     } else {
> > +             /* Hack!  Reuse ofs->layers as a mounts array */
> > +             struct vfsmount **mounts = (struct vfsmount **) ofs->layers;
> > +
> > +             for (i = 0; i < ofs->numlayer; i++) {
> > +                     iput(ofs->layers[i].trap);
> > +                     mounts[i] = ofs->layers[i].mnt;
> > +             }
> > +             kern_unmount_many(mounts, ofs->numlayer);
> > +             kfree(ofs->layers);
>
> That's _way_ too subtle.  AFAICS, you rely upon ->upper_mnt == ->layers[0].mnt,
> ->layers[0].trap == NULL, without even mentioning that.  And the hack you do
> mention...  Yecchhh...  How many layers are possible, again?

500, mounts array would fit inside a page and a page can be allocated
with __GFP_NOFAIL. But why bother?  It's not all that bad, is it?

Thanks,
Miklos

