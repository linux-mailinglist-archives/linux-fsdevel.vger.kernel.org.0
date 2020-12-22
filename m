Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755A62E0452
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 03:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLVCSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 21:18:41 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:56553 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgLVCSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 21:18:41 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id CE10BD40;
        Mon, 21 Dec 2020 21:17:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Dec 2020 21:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        nwp8SHfKsd3EIcU1TyMrSnM5bkN9Pqib1uB7QBhyeNs=; b=Wu7NxyZDElR4liuF
        4AnnegieD2s6ayML812K9/VgSP/o3O/3fs0vn22ompJOH6rZR5GRUg6qNuICJlpx
        OySBEF6vguDgrSQILQ3XF8JEf1VC1hMlBsLx75rSgLKgUm3kDWLMwtViSOGaI6bJ
        I+04d1nPTTtDk0RJndOOhUqGE1+WwFG7eUFKdZD6T8gm3yiY6NMESb3auNbNzdqA
        KMJqzcrK7G3kUUyt9UnR4wzhnOZ7pJODDLoQir7hRbqAOogawSo6AB6I5s5jCHuM
        sawejN6rGLxN3ifdPuDyHYdeq76Aoiw+o/Khpn2NehIqFeCcL0E+JAFJnN3ibZV1
        xzljuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=nwp8SHfKsd3EIcU1TyMrSnM5bkN9Pqib1uB7QBhye
        Ns=; b=FvIsz+PnPo59EEtiqve0hvjNrt240pCy4Gqmh8GZXb9lnK7Gx3k3G9ZNf
        kAjkapTyV/zlR6oF1/PwyYYoUZvLYDodLx+goO82XNqZfgJAIIQiVfuOTYrewYep
        y+DUlPtQgcrVmK7O+fhiIaB8OYSQqZvSMhSr0daap/VvhoM3z3oUO9f29f/M5H6h
        bv+20lF/iVUJ1pIzCo1vjkhYYeZZ+q0hbQ3uLxuILSJrz0NVBwZ/BbYnYvnLl0Xr
        Vn851QflWaPUvPv8cE6Wg+pG/MHrQ8dakvRIstNOWwQhkHO0EZrl7vfSln5Il7ka
        vGcBpBvCjLtzGrPmnF3unYqY4Gi8A==
X-ME-Sender: <xms:PFfhX0Nk1AFpr430dwYoXwOIkhQMVtNlcIsIanqDNM_KWqlufnU0oA>
    <xme:PFfhX6_-PGlHqR9Ma07LLDrv4Ig0MGnpzlByKoy4L5ZqkqHMQWB2UZR70jBD_6gr_
    PIvijT8D1G0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtfedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddtiedrieelrddvgeejrddvtdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:PFfhX7QCfh66sN17i6G2k9Cee2Z8mQqNxP9HFYCWQq2yOsTo6vuWjg>
    <xmx:PFfhX8tK6Aw0W8noU_U8p4UF0e2J7UtCnvd-PBKGiaT7PK98GBKvUQ>
    <xmx:PFfhX8f-gWs2-0IWIKdFUc2cPcaFcM8dDTwB2HDbCqJOQhiae8Ej3g>
    <xmx:PlfhX6uSLywm6P_5MlRxmpfYSvSGlr3AbgYQWi-tnXLo0OD3KtuFIGJprvI>
Received: from mickey.themaw.net (106-69-247-205.dyn.iinet.net.au [106.69.247.205])
        by mail.messagingengine.com (Postfix) with ESMTPA id 926DE240064;
        Mon, 21 Dec 2020 21:17:28 -0500 (EST)
Message-ID: <11f9633e2157450021de4886ed37d0b0cd3436c2.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, viro@zeniv.linux.org.uk
Date:   Tue, 22 Dec 2020 10:17:23 +0800
In-Reply-To: <CAC2o3DLYDRkDwMw1j9kwDfQRXFCdBGgAOR4eEsfjgm_LJJ9DNA@mail.gmail.com>
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
 <X9t1xVTZ/ApIvPMg@mtj.duckdns.org>     
 <67a3012a6a215001c8be9344aee1c99897ff8b7e.camel@themaw.net>    
 <CAC2o3DJhx+dJX-oMKSTNabWYyRB750VABib+OZ=7UX6rGJZD5g@mail.gmail.com>   
 <f21e92d683c609b14e559209a1a1bed2f7c3649e.camel@themaw.net>    
 <CAC2o3DKO_weLt2n6hOwU=hJ9J4fc3Qa3mUHP7rMzksJVuGnsJA@mail.gmail.com>   
 <ecf41abd583d5d2c775d9d385ea2a0af7b275037.camel@themaw.net>    
 <CAC2o3DLYDRkDwMw1j9kwDfQRXFCdBGgAOR4eEsfjgm_LJJ9DNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-12-19 at 15:47 +0800, Fox Chen wrote:
> On Sat, Dec 19, 2020 at 8:53 AM Ian Kent <raven@themaw.net> wrote:
> > On Fri, 2020-12-18 at 21:20 +0800, Fox Chen wrote:
> > > On Fri, Dec 18, 2020 at 7:21 PM Ian Kent <raven@themaw.net>
> > > wrote:
> > > > On Fri, 2020-12-18 at 16:01 +0800, Fox Chen wrote:
> > > > > On Fri, Dec 18, 2020 at 3:36 PM Ian Kent <raven@themaw.net>
> > > > > wrote:
> > > > > > On Thu, 2020-12-17 at 10:14 -0500, Tejun Heo wrote:
> > > > > > > Hello,
> > > > > > > 
> > > > > > > On Thu, Dec 17, 2020 at 07:48:49PM +0800, Ian Kent wrote:
> > > > > > > > > What could be done is to make the kernfs node
> > > > > > > > > attr_mutex
> > > > > > > > > a pointer and dynamically allocate it but even that
> > > > > > > > > is
> > > > > > > > > too
> > > > > > > > > costly a size addition to the kernfs node structure
> > > > > > > > > as
> > > > > > > > > Tejun has said.
> > > > > > > > 
> > > > > > > > I guess the question to ask is, is there really a need
> > > > > > > > to
> > > > > > > > call kernfs_refresh_inode() from functions that are
> > > > > > > > usually
> > > > > > > > reading/checking functions.
> > > > > > > > 
> > > > > > > > Would it be sufficient to refresh the inode in the
> > > > > > > > write/set
> > > > > > > > operations in (if there's any) places where things like
> > > > > > > > setattr_copy() is not already called?
> > > > > > > > 
> > > > > > > > Perhaps GKH or Tejun could comment on this?
> > > > > > > 
> > > > > > > My memory is a bit hazy but invalidations on reads is how
> > > > > > > sysfs
> > > > > > > namespace is
> > > > > > > implemented, so I don't think there's an easy around
> > > > > > > that.
> > > > > > > The
> > > > > > > only
> > > > > > > thing I
> > > > > > > can think of is embedding the lock into attrs and doing
> > > > > > > xchg
> > > > > > > dance
> > > > > > > when
> > > > > > > attaching it.
> > > > > > 
> > > > > > Sounds like your saying it would be ok to add a lock to the
> > > > > > attrs structure, am I correct?
> > > > > > 
> > > > > > Assuming it is then, to keep things simple, use two locks.
> > > > > > 
> > > > > > One global lock for the allocation and an attrs lock for
> > > > > > all
> > > > > > the
> > > > > > attrs field updates including the kernfs_refresh_inode()
> > > > > > update.
> > > > > > 
> > > > > > The critical section for the global lock could be reduced
> > > > > > and
> > > > > > it
> > > > > > changed to a spin lock.
> > > > > > 
> > > > > > In __kernfs_iattrs() we would have something like:
> > > > > > 
> > > > > > take the allocation lock
> > > > > > do the allocated checks
> > > > > >   assign if existing attrs
> > > > > >   release the allocation lock
> > > > > >   return existing if found
> > > > > > othewise
> > > > > >   release the allocation lock
> > > > > > 
> > > > > > allocate and initialize attrs
> > > > > > 
> > > > > > take the allocation lock
> > > > > > check if someone beat us to it
> > > > > >   free and grab exiting attrs
> > > > > > otherwise
> > > > > >   assign the new attrs
> > > > > > release the allocation lock
> > > > > > return attrs
> > > > > > 
> > > > > > Add a spinlock to the attrs struct and use it everywhere
> > > > > > for
> > > > > > field updates.
> > > > > > 
> > > > > > Am I on the right track or can you see problems with this?
> > > > > > 
> > > > > > Ian
> > > > > > 
> > > > > 
> > > > > umm, we update the inode in kernfs_refresh_inode, right??  So
> > > > > I
> > > > > guess
> > > > > the problem is how can we protect the inode when
> > > > > kernfs_refresh_inode
> > > > > is called, not the attrs??
> > > > 
> > > > But the attrs (which is what's copied from) were protected by
> > > > the
> > > > mutex lock (IIUC) so dealing with the inode attributes implies
> > > > dealing with the kernfs node attrs too.
> > > > 
> > > > For example in kernfs_iop_setattr() the call to setattr_copy()
> > > > copies
> > > > the node attrs to the inode under the same mutex lock. So, if a
> > > > read
> > > > lock is used the copy in kernfs_refresh_inode() is no longer
> > > > protected,
> > > > it needs to be protected in a different way.
> > > > 
> > > 
> > > Ok, I'm actually wondering why the VFS holds exclusive i_rwsem
> > > for
> > > .setattr but
> > >  no lock for .getattr (misdocumented?? sometimes they have as
> > > you've
> > > found out)?
> > > What does it protect against?? Because .permission does a similar
> > > thing
> > > here -- updating inode attributes, the goal is to provide the
> > > same
> > > protection level
> > > for .permission as for .setattr, am I right???
> > 
> > As far as the documentation goes that's probably my
> > misunderstanding
> > of it.
> > 
> > It does happen that the VFS makes assumptions about how call backs
> > are meant to be used.
> > 
> > Read like call backs, like .getattr() and .permission() are meant
> > to
> > be used, well, like read like functions so the VFS should be ok to
> > take locks or not based on the operation context at hand.
> > 
> > So it's not about the locking for these call backs per se, it's
> > about
> > the context in which they are called.
> > 
> > For example, in link_path_walk(), at the beginning of the component
> > lookup loop (essentially for the containing directory at that
> > point),
> > may_lookup() is called which leads to a call to .permission()
> > without
> > any inode lock held at that point.
> > 
> > But file opens (possibly following a path walk to resolve a path)
> > are different.
> > 
> > For example, do_filp_open() calls path_openat() which leads to a
> > call to open_last_lookups(), which leads to a call to .permission()
> > along the way. And in this case there are two contexts, an open()
> > create or one without create, the former needing the exclusive
> > inode
> > lock and the later able to use the shared lock.
> > 
> > So it's about the locking needed for the encompassing operation
> > that
> > is being done not about those functions specifically.
> > 
> > TBH the VFS is very complex and Al has a much, much better
> > understanding of it than I do so he would need to be the one to
> > answer
> > whether it's the file systems responsibility to use these calls in
> > the
> > way the VFS expects.
> > 
> > My belief is that if a file system needs to use a call back in a
> > way
> > that's in conflict with what the VFS expects it's the file systems'
> > responsibility to deal with the side effects.
> > 
> 
> Thanks for clarifying. Ian.
> 
> Yeah, it's complex and confusing and it's very hard to spot lock
> context by reading VFS code.
> 
> I put code like this:
>         if (lockdep_is_held_type(&inode->i_rwsem, -1)) {
>                 if (lockdep_is_held_type(&inode->i_rwsem, 0)) {
>                         pr_warn("kernfs iop_permission inode WRITE
> lock is held");
>                 } else if (lockdep_is_held_type(&inode->i_rwsem, 1))
> {
>                         pr_warn("kernfs iop_permission inode READ
> lock
> is held");
>                 }
>         } else {
>                 pr_warn("kernfs iop_permission inode lock is NOT
> held");
>         }
> 
> in both .permission & .getattr. Then I do some open/read/write/close
> to /sys, interestingly, all log outputs suggest they are in WRITE
> lock
> context.

The thing is in open_last_lookups() called from path_openat() we
have:
	if (open_flag & O_CREAT)
        	        inode_lock(dir->d_inode);
	        else
        	        inode_lock_shared(dir->d_inode);

and from there it's - lookup_open() and possibly may_o_create() which
calls inode_permission() and onto .permission().

So, strictly speaking, it should be taken exclusive because you would
expect may_o_create() to be called only on O_CREATE.

But all the possible cases would need to be checked and if it is taken
shared anywhere we are in trouble.

Another example is in link_path_walk() we have a call to may_lookup()
which leads to a call to .permission() without the lock being held.

So there are a bunch of cases to check and knowing you are the owner
of the lock if it is held is at least risky when concurrency is high
and there's a possibility the lock can be taken shared.

Ian

