Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECE82DA939
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 09:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgLOIeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 03:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgLOIdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:33:50 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF472C06179C;
        Tue, 15 Dec 2020 00:33:20 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id y19so37116367lfa.13;
        Tue, 15 Dec 2020 00:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KseJ7LVd2OoVBgeqXpzpPG6piqpbGfIk9+Fb83PIcLM=;
        b=ucC6NmbIYshphT+gw6Da9sJvXV94kqJJPYdpQG6cJnBdk8A9E8jAO/VriMRR0tZZ/d
         m4qtcHjoJat95nKO6METQ4B+HrwIZA+yY/jiY7MAaQGzEIsdyrva/235rZUAcxm8DQJC
         HbZeGuM0JgPXJ5G/F0JXd8u9xbhFQKlFKbvnG9BXw4UiiXNTCto904ufNvPopxJnA3Gp
         T9qw03Fw2XCK9gtWrQP7CKR60G+Cn5jXxHgc40upKhYZ6cKREP7f3rZBNN/kAXhMMApf
         DT169djzELwrsujLuHKT5/3xLkxKMNUFDEwwdwYKOVYcF8y7hjVHPp4sgjU8333SIp94
         qsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KseJ7LVd2OoVBgeqXpzpPG6piqpbGfIk9+Fb83PIcLM=;
        b=cXNTXFm6RSQ4e2gyIlMSPqg2VbnVtdtTUCbxfJiwDO2e/w4A0j662adEug/kw8stWu
         emk3oEreHvKWTKB/d16DcSscFf4hMBh6zV8eeLwlK9jrFHMR9cbjjWfm2dZTVm7dmCpx
         Jul2T+0l8H1xsSCUIJ+JyZFM8pvbj4TdCOON6bYs5h89/eNHN2YbqLGCKrgEmjYA45jf
         m8vylhdr3S14hlSjuZV+DS/c5sSKKp4PZNQm0zQMzhtnpkWrid7he+Mo73pe4kF4UJGL
         sQkknJI/jp9/iqZ7QC4Up7hieQexBvddTIG1HyGyF97uHruhCdonzI+S6qHvqtjSdYlL
         bdOw==
X-Gm-Message-State: AOAM532Dd+lyLEBk74tAj9uWyOB/I/SKgIcAa4ZOSs+9wQIpvMF0FyYc
        oOCnl+0UXMj9gk0ODj1opJq2yQ2t0Xh3650e2dM=
X-Google-Smtp-Source: ABdhPJx7UWgFJJuwcTNhgg+U6Q/+BpzmoTcPUt0fHBrcQlRZcX9j5h/Iq+fqOGrVHH8NxxhoCmqpaJECmNW8SA++we0=
X-Received: by 2002:a2e:b1d4:: with SMTP id e20mr11652518lja.304.1608021199094;
 Tue, 15 Dec 2020 00:33:19 -0800 (PST)
MIME-Version: 1.0
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20201210164423.9084-1-foxhlchen@gmail.com> <822f02508d495ee7398450774eb13e5116ec82ac.camel@themaw.net>
 <13e21e4c9a5841243c8d130cf9324f6cfc4dc2e1.camel@themaw.net>
 <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
 <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com> <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
In-Reply-To: <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Tue, 15 Dec 2020 16:33:06 +0800
Message-ID: <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency improvement
To:     Ian Kent <raven@themaw.net>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, Tejun Heo <tj@kernel.org>,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 9:30 PM Ian Kent <raven@themaw.net> wrote:
>
> On Mon, 2020-12-14 at 14:14 +0800, Fox Chen wrote:
> > On Sun, Dec 13, 2020 at 11:46 AM Ian Kent <raven@themaw.net> wrote:
> > > On Fri, 2020-12-11 at 10:17 +0800, Ian Kent wrote:
> > > > On Fri, 2020-12-11 at 10:01 +0800, Ian Kent wrote:
> > > > > > For the patches, there is a mutex_lock in kn->attr_mutex, as
> > > > > > Tejun
> > > > > > mentioned here
> > > > > > (
> > > > > > https://lore.kernel.org/lkml/X8fe0cmu+aq1gi7O@mtj.duckdns.org/
> > > > > > ),
> > > > > > maybe a global
> > > > > > rwsem for kn->iattr will be better??
> > > > >
> > > > > I wasn't sure about that, IIRC a spin lock could be used around
> > > > > the
> > > > > initial check and checked again at the end which would probably
> > > > > have
> > > > > been much faster but much less conservative and a bit more ugly
> > > > > so
> > > > > I just went the conservative path since there was so much
> > > > > change
> > > > > already.
> > > >
> > > > Sorry, I hadn't looked at Tejun's reply yet and TBH didn't
> > > > remember
> > > > it.
> > > >
> > > > Based on what Tejun said it sounds like that needs work.
> > >
> > > Those attribute handling patches were meant to allow taking the rw
> > > sem read lock instead of the write lock for kernfs_refresh_inode()
> > > updates, with the added locking to protect the inode attributes
> > > update since it's called from the VFS both with and without the
> > > inode lock.
> >
> > Oh, understood. I was asking also because lock on kn->attr_mutex
> > drags
> > concurrent performance.
> >
> > > Looking around it looks like kernfs_iattrs() is called from
> > > multiple
> > > places without a node database lock at all.
> > >
> > > I'm thinking that, to keep my proposed change straight forward
> > > and on topic, I should just leave kernfs_refresh_inode() taking
> > > the node db write lock for now and consider the attributes handling
> > > as a separate change. Once that's done we could reconsider what's
> > > needed to use the node db read lock in kernfs_refresh_inode().
> >
> > You meant taking write lock of kernfs_rwsem for
> > kernfs_refresh_inode()??
> > It may be a lot slower in my benchmark, let me test it.
>
> Yes, but make sure the write lock of kernfs_rwsem is being taken
> not the read lock.
>
> That's a mistake I had initially?
>
> Still, that attributes handling is, I think, sufficient to warrant
> a separate change since it looks like it might need work, the kernfs
> node db probably should be kept stable for those attribute updates
> but equally the existence of an instantiated dentry might mitigate
> the it.
>
> Some people might just know whether it's ok or not but I would like
> to check the callers to work out what's going on.
>
> In any case it's academic if GCH isn't willing to consider the series
> for review and possible merge.
>
Hi Ian

I removed kn->attr_mutex and changed read lock to write lock for
kernfs_refresh_inode

down_write(&kernfs_rwsem);
kernfs_refresh_inode(kn, inode);
up_write(&kernfs_rwsem);


Unfortunate, changes in this way make things worse,  my benchmark runs
100% slower than upstream sysfs.  :(
open+read+close a sysfs file concurrently took 1000us. (Currently,
sysfs with a big mutex kernfs_mutex only takes ~500us
for one open+read+close operation concurrently)

|--45.93%--kernfs_iop_permission
                                  |                                |
                  |          |          |          |
                                  |                                |
                  |          |          |
|--22.55%--down_write
                                  |                                |
                  |          |          |          |          |
                                  |                                |
                  |          |          |          |
--20.69%--rwsem_down_write_slowpath
                                  |                                |
                  |          |          |          |
  |
                                  |                                |
                  |          |          |          |
  |--8.89%--schedule

perf showed most of the time had been spent on kernfs_iop_permission


thanks,
fox
