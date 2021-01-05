Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BD92EB0BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 17:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbhAEQ6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 11:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbhAEQ6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:58:14 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9C2C061574;
        Tue,  5 Jan 2021 08:57:34 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id 75so259674ilv.13;
        Tue, 05 Jan 2021 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHKfrdmGb3rVaABQiL4leDAaF/+A/efgwvhOJXFRbVk=;
        b=HKDcS9mVwumW7RGCDwgL/8xlq/yh30Kws6isB3iZo8AZXQaxL3fXTgqv6PZ5VH1JyM
         CM48/eYvX1//HtUqkuNk9+fhjLjPTXLX81zNbRCFmC87egaw2H6FX/mjfD4vYVP2eBEF
         mw0XbTE4rMHLxlhloPT/WThprcdYg8zlUijV9yt5S6WiLm/r9lAAfGK3ewZWWhz8B9DB
         KXt7Vsp7w8c5b1auYw1xHE8osUqNaKbivgqCm0lTLTsPsXLBfYiP74aA2OCk9XD5vRxj
         uCZLM4xopfufN+Pljhe4lmfR5UtLo5oHxcUE9YYo6RtjhSOS3HIZ7RKxuH3TxS3Hlpv4
         Acpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHKfrdmGb3rVaABQiL4leDAaF/+A/efgwvhOJXFRbVk=;
        b=YQnI+V61Kf24GX7WMIxXwLmlcSk4RoxfGPdLvnReRmiBsYex1/nSkwLYcNAzWL1YD0
         edCDz4Db6rbB2gOnOsWDYW+TAgJjwbEOIpC4E7nEJIK9ISRoXoNnucqrPjgC26xIiY53
         Uvlv5wQwM0O6ZtAH2fx+J3tfkxtkECYXH1riZKu5pdVLhSV4AzZ4W2k8ZADUn0VjBd0j
         aPukFYmXxa5emCButuWHbVqlk2KkiCIOetXvRoMgTfZ5WkCuzENv3B3mI2BKuT0G0nX2
         rYI0VTDqxvTy0nFqmaP6/ZlXKwaQ5Q198HEqDL44R/Uw3mXbVDHg7mKzkj2qhV4uwKS7
         NSUw==
X-Gm-Message-State: AOAM532D5yi0VsaNjEnsxy5fFui+BYRi0Nb75iEgreysuLkPeo/HKBWR
        Y3qaLaAhsioMYMlgbbCWSLNdEUrHdvU04kR9xFs=
X-Google-Smtp-Source: ABdhPJzuCW3490l+lOhN3qAu1MGnFOT4SHr+S1Gmhqb3GmTBAo2fQE0OSunOAXCYbd30Thg3v7Z5UqAfYMjerqBul34=
X-Received: by 2002:a92:6403:: with SMTP id y3mr565783ilb.72.1609865853320;
 Tue, 05 Jan 2021 08:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20201223200746.GR874@casper.infradead.org> <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org> <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20210104151424.GA63879@redhat.com> <CAOQ4uxgiC5Wm+QqD+vbmzkFvEqG6yvKYe_4sR7ZUVfu-=Ys9oQ@mail.gmail.com>
 <20210104154015.GA73873@redhat.com> <CAOQ4uxhYXeUt2iggM3oubdgr91QPNhUg2PdN128gRvR3rQoy1Q@mail.gmail.com>
 <20210104224447.GG63879@redhat.com> <CAOQ4uxh07Rqj88PDNVqzq9D28rp+Z2aRtPvNoapeaH5iZWJr4Q@mail.gmail.com>
 <20210105162646.GD3200@redhat.com>
In-Reply-To: <20210105162646.GD3200@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Jan 2021 18:57:21 +0200
Message-ID: <CAOQ4uxgA96sDca3YWAqXjkMS8YKmFv259cFS7aWNvhfC6MtL6w@mail.gmail.com>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 5, 2021 at 6:26 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Jan 05, 2021 at 09:11:23AM +0200, Amir Goldstein wrote:
> > > >
> > > > What I would rather see is:
> > > > - Non-volatile: first syncfs in every container gets an error (nice to have)
> > >
> > > I am not sure why are we making this behavior per container. This should
> > > be no different from current semantics we have for syncfs() on regular
> > > filesystem. And that will provide what you are looking for. If you
> > > want single error to be reported in all ovleray mounts, then make
> > > sure you have one fd open in each mount after mount, then call syncfs()
> > > on that fd.
> > >
> >
> > Ok.
> >
> > > Not sure why overlayfs behavior/semantics should be any differnt
> > > than what regular filessytems like ext4/xfs are offering. Once we
> > > get page cache sharing sorted out with xfs reflink, then people
> > > will not even need overlayfs and be able to launch containers
> > > just using xfs reflink and share base image. In that case also
> > > they will need to keep an fd open per container they want to
> > > see an error in.
> > >
> > > So my patches exactly provide that. syncfs() behavior is same with
> > > overlayfs as application gets it on other filesystems. And to me
> > > its important to keep behavior same.
> > >
> > > > - Volatile: every syncfs and every fsync in every container gets an error
> > > >   (important IMO)
> > >
> > > For volatile mounts, I agree that we need to fail overlayfs instance
> > > as soon as first error is detected since mount. And this applies to
> > > not only syncfs()/fsync() but to read/write and other operations too.
> > >
> > > For that we will need additional patches which are floating around
> > > to keep errseq sample in overlay and check for errors in all
> > > paths syncfs/fsync/read/write/.... and fail fs.
> >
> > > But these patches build on top of my patches.
> >
> > Here we disagree.
> >
> > I don't see how Jeff's patch is "building on top of your patches"
> > seeing that it is perfectly well contained and does not in fact depend
> > on your patches.
>
> Jeff's patches are solving problem only for volatile mounts and they
> are propagating error to overlayfs sb.
>
> My patches are solving the issue both for volatile mount as well as
> non-volatile mounts and solve it using same method so there is no
> confusion.
>
> So there are multiple pieces to this puzzle and IMHO, it probably
> should be fixed in this order.
>
> A. First fix the syncfs() path to return error both for volatile as
>    as well non-volatile mounts.
>
> B. And then add patches to fail filesystem for volatile mount as soon
>    as first error is detected (either in syncfs path or in other paths
>    like read/write/...). This probably will require to save errseq
>    in ovl_fs, and then compare with upper_sb in critical paths and fail
>    filesystem as soon as error is detected.
>
> C. Finally fix the issues related to mount/remount error detection which
>    Sargun is wanting to fix. This will be largerly solved by B except
>    saving errseq on disk.
>
> My patches should fix the first problem. And more patches can be
> applied on top to fix issue B and issue C.
>
> Now if we agree with this, in this context I see that fixing problem
> B and C is building on top of my patches which fixes problem A.
>

That order is fine by me.

> >
> > And I do insist that the fix for volatile mounts syncfs/fsync error
> > reporting should be applied before your patches or at the very least
> > not heavily depend on them.
>
> I still don't understand that why volatile syncfs() error reporting
> is more important than non-volatile syncfs(). But I will stop harping
> on this point now.
>
> My issue with Jeff's patches is that syncfs() error reporting should
> be dealt in same way both for volatile and non-volatile mount. That
> is compare file->f_sb_err and upper_sb->s_wb_err to figure out if
> there is an error to report to user space. Currently this patches
> only solve the problem for volatile mounts and use propagation to
> overlay sb which is conflicting for non-volatile mounts.
>
> IIUC, your primary concern with volatile mount is that you want to
> detect as soon as writeback error happens, and flag it to container
> manager so that container manager can stop container, throw away
> upper layer and restart from scratch. If yes, what you want can
> be solved by solving problem B and backporting it to LTS kernel.
> I think patches for that will be well contained within overlayfs
> (And no VFS) changes and should be relatively easy to backport.
>
> IOW, backportability to LTS kernel should not be a concern/blocker
> for my patch series which fixes syncfs() issue for overlayfs.
>

That's all I wanted to know.

Thanks,
Amir.
