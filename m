Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB77A2DEDBC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 08:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgLSHsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 02:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgLSHsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 02:48:13 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CCFC0617B0;
        Fri, 18 Dec 2020 23:47:32 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o19so11475232lfo.1;
        Fri, 18 Dec 2020 23:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkoQjEWZ1yC+aEXsvc9viYCZySUYOvw5G76gbeIqnPU=;
        b=DRIINf7LP3hPkOzp0UilchbM2mT9R641DUpiujfqSmQnjgG/6/yBVYiR7yC8viPLhg
         mHiQsP7Pt/7ZPvlzRnUa6AnWZkJ9aQd1z/S+yvDotb2UssSq0cMndxOZcMo+J9/Ic5MJ
         Idn+IszTvapj0aMYci4RLgfNB17jw33j67e3HadK7Yx3rrX4RONMfnBM47eLhSZHAWwC
         k8jGjHkGM3JOP4Xj2dNqC9u9vWgCMrfrQQMPMK8ehQT2z55PQf929+LJJiMi8SN5AGX2
         JvQFbagjpBMRKkCtqFWruGgDWkHOPW8YGHQaPXVph3y/b/FwDYdGjtYkZfKWp6qr5Avr
         ZQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkoQjEWZ1yC+aEXsvc9viYCZySUYOvw5G76gbeIqnPU=;
        b=ZYJkDpagG4FIXso3i9pW5mkCn5wT2SnCzq8LBbmezQ5rY9U1yialZkPUJk8cwP9sMj
         Vg18O+ElP9YlK5aV8M62b32hoNqe6DTJ810UH94Hd2BaSbWwb6QKu02o3YQOGzyXUssa
         ZyTqUrKQPcUBSxdGbwedRSSple2eoXX16njp0FSpwTkWASKpnMpC26haCK5c+ze8FxSi
         BuzAGNHFiKZT+9jYagw9odw/wY0QOlzYBN5VxabMwL7DULrFHESilfmprE0VEp53O4Ev
         p7Xi7BN5Nx4EnP7i6jmyFTE6O7qkKK6Mq4SjrSMsRZpPPARGEXgiMTqEhz/CCS2Q1J4n
         Iw4Q==
X-Gm-Message-State: AOAM532bzCjIeTn7hswRkPf/7CDrmE3Q6ia2nR2DWyWJo662WYVsuLov
        3fG+zpMYy1IsfAoaAVv/u1Z8SvMjx0gbswpE5xA=
X-Google-Smtp-Source: ABdhPJzgHUVNLkCiqGiL4n40nLeLw/GOm3OLO7DT18T+fw4xnEQa7A19eNgjYj0krhQ11KW2rrIkpheNFARNFmVc+ek=
X-Received: by 2002:ac2:5dd1:: with SMTP id x17mr2661121lfq.252.1608364051099;
 Fri, 18 Dec 2020 23:47:31 -0800 (PST)
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
 <CAC2o3DJhx+dJX-oMKSTNabWYyRB750VABib+OZ=7UX6rGJZD5g@mail.gmail.com>
 <f21e92d683c609b14e559209a1a1bed2f7c3649e.camel@themaw.net>
 <CAC2o3DKO_weLt2n6hOwU=hJ9J4fc3Qa3mUHP7rMzksJVuGnsJA@mail.gmail.com> <ecf41abd583d5d2c775d9d385ea2a0af7b275037.camel@themaw.net>
In-Reply-To: <ecf41abd583d5d2c775d9d385ea2a0af7b275037.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Sat, 19 Dec 2020 15:47:19 +0800
Message-ID: <CAC2o3DLYDRkDwMw1j9kwDfQRXFCdBGgAOR4eEsfjgm_LJJ9DNA@mail.gmail.com>
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

On Sat, Dec 19, 2020 at 8:53 AM Ian Kent <raven@themaw.net> wrote:
>
> On Fri, 2020-12-18 at 21:20 +0800, Fox Chen wrote:
> > On Fri, Dec 18, 2020 at 7:21 PM Ian Kent <raven@themaw.net> wrote:
> > > On Fri, 2020-12-18 at 16:01 +0800, Fox Chen wrote:
> > > > On Fri, Dec 18, 2020 at 3:36 PM Ian Kent <raven@themaw.net>
> > > > wrote:
> > > > > On Thu, 2020-12-17 at 10:14 -0500, Tejun Heo wrote:
> > > > > > Hello,
> > > > > >
> > > > > > On Thu, Dec 17, 2020 at 07:48:49PM +0800, Ian Kent wrote:
> > > > > > > > What could be done is to make the kernfs node attr_mutex
> > > > > > > > a pointer and dynamically allocate it but even that is
> > > > > > > > too
> > > > > > > > costly a size addition to the kernfs node structure as
> > > > > > > > Tejun has said.
> > > > > > >
> > > > > > > I guess the question to ask is, is there really a need to
> > > > > > > call kernfs_refresh_inode() from functions that are usually
> > > > > > > reading/checking functions.
> > > > > > >
> > > > > > > Would it be sufficient to refresh the inode in the
> > > > > > > write/set
> > > > > > > operations in (if there's any) places where things like
> > > > > > > setattr_copy() is not already called?
> > > > > > >
> > > > > > > Perhaps GKH or Tejun could comment on this?
> > > > > >
> > > > > > My memory is a bit hazy but invalidations on reads is how
> > > > > > sysfs
> > > > > > namespace is
> > > > > > implemented, so I don't think there's an easy around that.
> > > > > > The
> > > > > > only
> > > > > > thing I
> > > > > > can think of is embedding the lock into attrs and doing xchg
> > > > > > dance
> > > > > > when
> > > > > > attaching it.
> > > > >
> > > > > Sounds like your saying it would be ok to add a lock to the
> > > > > attrs structure, am I correct?
> > > > >
> > > > > Assuming it is then, to keep things simple, use two locks.
> > > > >
> > > > > One global lock for the allocation and an attrs lock for all
> > > > > the
> > > > > attrs field updates including the kernfs_refresh_inode()
> > > > > update.
> > > > >
> > > > > The critical section for the global lock could be reduced and
> > > > > it
> > > > > changed to a spin lock.
> > > > >
> > > > > In __kernfs_iattrs() we would have something like:
> > > > >
> > > > > take the allocation lock
> > > > > do the allocated checks
> > > > >   assign if existing attrs
> > > > >   release the allocation lock
> > > > >   return existing if found
> > > > > othewise
> > > > >   release the allocation lock
> > > > >
> > > > > allocate and initialize attrs
> > > > >
> > > > > take the allocation lock
> > > > > check if someone beat us to it
> > > > >   free and grab exiting attrs
> > > > > otherwise
> > > > >   assign the new attrs
> > > > > release the allocation lock
> > > > > return attrs
> > > > >
> > > > > Add a spinlock to the attrs struct and use it everywhere for
> > > > > field updates.
> > > > >
> > > > > Am I on the right track or can you see problems with this?
> > > > >
> > > > > Ian
> > > > >
> > > >
> > > > umm, we update the inode in kernfs_refresh_inode, right??  So I
> > > > guess
> > > > the problem is how can we protect the inode when
> > > > kernfs_refresh_inode
> > > > is called, not the attrs??
> > >
> > > But the attrs (which is what's copied from) were protected by the
> > > mutex lock (IIUC) so dealing with the inode attributes implies
> > > dealing with the kernfs node attrs too.
> > >
> > > For example in kernfs_iop_setattr() the call to setattr_copy()
> > > copies
> > > the node attrs to the inode under the same mutex lock. So, if a
> > > read
> > > lock is used the copy in kernfs_refresh_inode() is no longer
> > > protected,
> > > it needs to be protected in a different way.
> > >
> >
> > Ok, I'm actually wondering why the VFS holds exclusive i_rwsem for
> > .setattr but
> >  no lock for .getattr (misdocumented?? sometimes they have as you've
> > found out)?
> > What does it protect against?? Because .permission does a similar
> > thing
> > here -- updating inode attributes, the goal is to provide the same
> > protection level
> > for .permission as for .setattr, am I right???
>
> As far as the documentation goes that's probably my misunderstanding
> of it.
>
> It does happen that the VFS makes assumptions about how call backs
> are meant to be used.
>
> Read like call backs, like .getattr() and .permission() are meant to
> be used, well, like read like functions so the VFS should be ok to
> take locks or not based on the operation context at hand.
>
> So it's not about the locking for these call backs per se, it's about
> the context in which they are called.
>
> For example, in link_path_walk(), at the beginning of the component
> lookup loop (essentially for the containing directory at that point),
> may_lookup() is called which leads to a call to .permission() without
> any inode lock held at that point.
>
> But file opens (possibly following a path walk to resolve a path)
> are different.
>
> For example, do_filp_open() calls path_openat() which leads to a
> call to open_last_lookups(), which leads to a call to .permission()
> along the way. And in this case there are two contexts, an open()
> create or one without create, the former needing the exclusive inode
> lock and the later able to use the shared lock.
>
> So it's about the locking needed for the encompassing operation that
> is being done not about those functions specifically.
>
> TBH the VFS is very complex and Al has a much, much better
> understanding of it than I do so he would need to be the one to answer
> whether it's the file systems responsibility to use these calls in the
> way the VFS expects.
>
> My belief is that if a file system needs to use a call back in a way
> that's in conflict with what the VFS expects it's the file systems'
> responsibility to deal with the side effects.
>

Thanks for clarifying. Ian.

Yeah, it's complex and confusing and it's very hard to spot lock
context by reading VFS code.

I put code like this:
        if (lockdep_is_held_type(&inode->i_rwsem, -1)) {
                if (lockdep_is_held_type(&inode->i_rwsem, 0)) {
                        pr_warn("kernfs iop_permission inode WRITE
lock is held");
                } else if (lockdep_is_held_type(&inode->i_rwsem, 1)) {
                        pr_warn("kernfs iop_permission inode READ lock
is held");
                }
        } else {
                pr_warn("kernfs iop_permission inode lock is NOT held");
        }

in both .permission & .getattr. Then I do some open/read/write/close
to /sys, interestingly, all log outputs suggest they are in WRITE lock
context.

and I put dump_stack() to the lock-is-held if branch, it prints a lot
of following context:

[  481.795445] CPU: 0 PID: 1 Comm: systemd Not tainted 5.10.0-dirty #25
[  481.795446] Hardware name: Parallels Software International Inc.
Parallels Virtual Platform/Parallels Virtual Platform, BIOS 15.1.5
(47309) 09/26/2020
[  481.795446] Call Trace:
[  481.795448] dump_stack (lib/dump_stack.c:120)
[  481.795450] kernfs_iop_permission (fs/kernfs/inode.c:295)
[  481.795452] inode_permission.part.0 (fs/namei.c:398 fs/namei.c:463)
[  481.795454] may_open (fs/namei.c:2875)
[  481.795456] path_openat (fs/namei.c:3250 fs/namei.c:3369)
[  481.795458] ? ___sys_sendmsg (net/socket.c:2411)
[  481.795460] ? preempt_count_add (./include/linux/ftrace.h:821
kernel/sched/core.c:4166 kernel/sched/core.c:4163
kernel/sched/core.c:4191)
[  481.795461] ? sock_poll (net/socket.c:1265)
[  481.795463] do_filp_open (fs/namei.c:3396)
[  481.795466] ? __check_object_size (mm/usercopy.c:240
mm/usercopy.c:286 mm/usercopy.c:256)
[  481.795469] ? _raw_spin_unlock
(./arch/x86/include/asm/preempt.h:102
./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:183)
[  481.795470] do_sys_openat2 (fs/open.c:1168)
[  481.795472] __x64_sys_openat (fs/open.c:1195)
[  481.795473] do_syscall_64 (arch/x86/entry/common.c:46)
[  481.795475] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:127)
[  481.795476] RIP: 0033:0x7f6b31d69c94

Surprisingly, I didn't see the lock holding code along the path.


thanks,
fox
