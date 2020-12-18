Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA2B2DE339
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 14:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgLRNV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 08:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgLRNV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:21:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F3DC0617A7;
        Fri, 18 Dec 2020 05:20:46 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a9so5410059lfh.2;
        Fri, 18 Dec 2020 05:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGRVW3Zib+bLKNC+Amev3v1cKadH0SToLHNOIADvq2o=;
        b=pkvKvgjlTYrU0/rcHyKjHlh90stI5sOSKLqGgQy9GEpaW9fC2vF8hJQnOIt5c8SBdh
         7On4XSt9s2ahIXDe/XUoBWn6cfWjgfCdXS4QjYXKcRgzTwdLxVEfxv9olmHEGjbZsywP
         LYVkZAnsmZT+WJTkGNNZXB+Xa3ckIxvo8Gq4VG0KuSwnNlIhmE00z4HLFTX2FR8EronV
         6FxqB3D2LyUlsmqSUBEpjlqc1AWMQ2FXzKZe2M4yJCz/qDh8HDKcvRnbDWKBg97PHhGf
         3EZE7XSx/qAxFqVumF0TklBSIE4cHG0OS9qjDAVG24JPlQAjXxMUHACej1ioVnzM7P8I
         L0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGRVW3Zib+bLKNC+Amev3v1cKadH0SToLHNOIADvq2o=;
        b=DFE/d82pSAvaotvC5mZXFGiU45HPk2/SkwT9YZ6TTKkqBs9zZd9e7h7Ffov8BVgmDu
         PsF55/mLarLY52Nw+UfzvNIbJVG3i3jZ3ny3PRxqz+Jveya+sRB9mvD3BPM0pftK1Nr+
         TWTYjNq7K4YVOWBjBp0nbdSpb2iQQ0wiURFxMWybRFON+rlZYAb8ateQIJTeIpx48Fug
         ucvi5IyG05TvUS42MBzkyQgOjlpRXA2pGmd/AGJtNpY5K/97WauXHOZHXaMNGLH3vlZV
         hRnR2o283dovc2GR7qAbVIw6acTfDlDaaLTZTibMHpPF/k3FnqMi6KMO6QroePVhL1q7
         Vi8A==
X-Gm-Message-State: AOAM533dB/amjyNFD4wiSBgcYJPvhvvQae5JxNNcoRUkWfZdBy1qRn5F
        u7xQXRt/SO/3m1A0D1wBd8gLaReFwiwkey6ayHg=
X-Google-Smtp-Source: ABdhPJxNcBHYhpRK17C/zCYLKYTsInrzKiwsE3Gb5ARV2jH3e53ufX/o2xYcH8K0vfq/NOoWOttiMQWagPYmE+O1BBw=
X-Received: by 2002:a2e:874d:: with SMTP id q13mr1791068ljj.323.1608297645213;
 Fri, 18 Dec 2020 05:20:45 -0800 (PST)
MIME-Version: 1.0
References: <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
 <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com>
 <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
 <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
 <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
 <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
 <CAC2o3DJsvB6kj=S6D3q+_OBjgez9Q9B5s3-_gjUjaKmb2MkTHQ@mail.gmail.com>
 <c4002127c72c07a00e8ba0fae6b0ebf5ba8e08e7.camel@themaw.net>
 <a39b73a53778094279522f1665be01ce15fb21f4.camel@themaw.net>
 <c8a6c9adc3651e64cf694f580a8cb3d87d7cb893.camel@themaw.net>
 <X9t1xVTZ/ApIvPMg@mtj.duckdns.org> <67a3012a6a215001c8be9344aee1c99897ff8b7e.camel@themaw.net>
 <CAC2o3DJhx+dJX-oMKSTNabWYyRB750VABib+OZ=7UX6rGJZD5g@mail.gmail.com> <f21e92d683c609b14e559209a1a1bed2f7c3649e.camel@themaw.net>
In-Reply-To: <f21e92d683c609b14e559209a1a1bed2f7c3649e.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Fri, 18 Dec 2020 21:20:33 +0800
Message-ID: <CAC2o3DKO_weLt2n6hOwU=hJ9J4fc3Qa3mUHP7rMzksJVuGnsJA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency improvement
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 18, 2020 at 7:21 PM Ian Kent <raven@themaw.net> wrote:
>
> On Fri, 2020-12-18 at 16:01 +0800, Fox Chen wrote:
> > On Fri, Dec 18, 2020 at 3:36 PM Ian Kent <raven@themaw.net> wrote:
> > > On Thu, 2020-12-17 at 10:14 -0500, Tejun Heo wrote:
> > > > Hello,
> > > >
> > > > On Thu, Dec 17, 2020 at 07:48:49PM +0800, Ian Kent wrote:
> > > > > > What could be done is to make the kernfs node attr_mutex
> > > > > > a pointer and dynamically allocate it but even that is too
> > > > > > costly a size addition to the kernfs node structure as
> > > > > > Tejun has said.
> > > > >
> > > > > I guess the question to ask is, is there really a need to
> > > > > call kernfs_refresh_inode() from functions that are usually
> > > > > reading/checking functions.
> > > > >
> > > > > Would it be sufficient to refresh the inode in the write/set
> > > > > operations in (if there's any) places where things like
> > > > > setattr_copy() is not already called?
> > > > >
> > > > > Perhaps GKH or Tejun could comment on this?
> > > >
> > > > My memory is a bit hazy but invalidations on reads is how sysfs
> > > > namespace is
> > > > implemented, so I don't think there's an easy around that. The
> > > > only
> > > > thing I
> > > > can think of is embedding the lock into attrs and doing xchg
> > > > dance
> > > > when
> > > > attaching it.
> > >
> > > Sounds like your saying it would be ok to add a lock to the
> > > attrs structure, am I correct?
> > >
> > > Assuming it is then, to keep things simple, use two locks.
> > >
> > > One global lock for the allocation and an attrs lock for all the
> > > attrs field updates including the kernfs_refresh_inode() update.
> > >
> > > The critical section for the global lock could be reduced and it
> > > changed to a spin lock.
> > >
> > > In __kernfs_iattrs() we would have something like:
> > >
> > > take the allocation lock
> > > do the allocated checks
> > >   assign if existing attrs
> > >   release the allocation lock
> > >   return existing if found
> > > othewise
> > >   release the allocation lock
> > >
> > > allocate and initialize attrs
> > >
> > > take the allocation lock
> > > check if someone beat us to it
> > >   free and grab exiting attrs
> > > otherwise
> > >   assign the new attrs
> > > release the allocation lock
> > > return attrs
> > >
> > > Add a spinlock to the attrs struct and use it everywhere for
> > > field updates.
> > >
> > > Am I on the right track or can you see problems with this?
> > >
> > > Ian
> > >
> >
> > umm, we update the inode in kernfs_refresh_inode, right??  So I guess
> > the problem is how can we protect the inode when kernfs_refresh_inode
> > is called, not the attrs??
>
> But the attrs (which is what's copied from) were protected by the
> mutex lock (IIUC) so dealing with the inode attributes implies
> dealing with the kernfs node attrs too.
>
> For example in kernfs_iop_setattr() the call to setattr_copy() copies
> the node attrs to the inode under the same mutex lock. So, if a read
> lock is used the copy in kernfs_refresh_inode() is no longer protected,
> it needs to be protected in a different way.
>

Ok, I'm actually wondering why the VFS holds exclusive i_rwsem for .setattr but
 no lock for .getattr (misdocumented?? sometimes they have as you've found out)?
What does it protect against?? Because .permission does a similar thing
here -- updating inode attributes, the goal is to provide the same
protection level
for .permission as for .setattr, am I right???


thanks,
fox
