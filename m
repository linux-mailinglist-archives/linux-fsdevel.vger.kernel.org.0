Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5896C2DE1E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 12:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbgLRLWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 06:22:08 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:55409 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732738AbgLRLWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 06:22:08 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id C2BEF561;
        Fri, 18 Dec 2020 06:21:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 18 Dec 2020 06:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        SqyhWMi/PGkVyTI04ViuD8ZEuCxEARw0R2isPdSVH2w=; b=1ccZ4lDIrlYd+lJ8
        4Wf5bGYR2JaAc3T8qAthFM8muI64Ek3NzIS2wICFfPdV8gHbD4ou2vMHx07R7mAU
        F/BM3OP5ZjWEZFr+RD+SIKLcaOoOu12UtgQP/F8Z0HW+cC8BsXNBX7O+POnUOZwu
        NLtgvBtrmGPtLifhsj7QtW6mKWN+W/LakHmrhKbdGCil2M78w05gOLZHYqFO9QC3
        cpXZAng8CRqzxE8pNqHbpI0jYouG3fi9DJOuWGivAsx39drfsdnTkERGcwxmXC2K
        LCNv05K3rtYritXZDDpzxcks/2NKkARx+kcHcV0f/iQPUgWpwBbQxEoYzQZ9D2l0
        jVE84g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=SqyhWMi/PGkVyTI04ViuD8ZEuCxEARw0R2isPdSVH
        2w=; b=W3QpuwELxpYgES5lIBUaxxhCco7yiPweVtsIqUMoXcQnNlnFvMjuMenh2
        1rLOgBQTgwo/r+DgArNp5eAcGIkXg1U0cfdmBKyv1UEDQj47r9YQES+ESMBlzD+E
        k44P+8VuAuhbgZ8DtqUVl5/dCErsHD2gQZ2TwR3rF9qvsxeiAxiTFltq5rR2iSVf
        JywR7oapMJaH48jonulxYvz/XJViyQK61u6qABD4VWGzXJppss0htlKwuk+b8bUd
        7Bf+UO++Yp5/nMnWMEQhOZnSvMdRgVaCt2ydF2uFmKmfvPJzPpd2/5idL57JRMb1
        svguXRQ33ut65xvwNS7uHLg3bXaaA==
X-ME-Sender: <xms:r5DcXxs2-ZI1354qnb6JF_x09KjCiPtad_KWqPlcKhERhbgOa1k72g>
    <xme:r5DcX6dnkg1pYOOnj6_5JjwRONHfP_SHuZ2GK7iyBOYkh2QNwNkBFkbUzePOd7Twd
    n2caHi_h-ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeliedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddtiedrieelrddvgeejrddvtdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:r5DcX0yEyqc0bnj9vMHZqY_GrWq1tJLapVzEhH3moAvynQzs0FzwZA>
    <xmx:r5DcX4MICocVjsDTpqqIpWcVrQexiDf4NEi9dnqsYHaWZlzlM6qHkw>
    <xmx:r5DcXx8W8zFMFu8jt7009EdZn6gB17ASIZ90c2ujpCJvqQw3hh_PoQ>
    <xmx:sZDcX6MpESFgPsU5izZpIGusRlk6FuiqeyEGKkn5cmhFQolp0S4x-2UCkvA>
Received: from mickey.themaw.net (106-69-247-205.dyn.iinet.net.au [106.69.247.205])
        by mail.messagingengine.com (Postfix) with ESMTPA id 90049240062;
        Fri, 18 Dec 2020 06:21:15 -0500 (EST)
Message-ID: <f21e92d683c609b14e559209a1a1bed2f7c3649e.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, viro@zeniv.linux.org.uk
Date:   Fri, 18 Dec 2020 19:21:10 +0800
In-Reply-To: <CAC2o3DJhx+dJX-oMKSTNabWYyRB750VABib+OZ=7UX6rGJZD5g@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-12-18 at 16:01 +0800, Fox Chen wrote:
> On Fri, Dec 18, 2020 at 3:36 PM Ian Kent <raven@themaw.net> wrote:
> > On Thu, 2020-12-17 at 10:14 -0500, Tejun Heo wrote:
> > > Hello,
> > > 
> > > On Thu, Dec 17, 2020 at 07:48:49PM +0800, Ian Kent wrote:
> > > > > What could be done is to make the kernfs node attr_mutex
> > > > > a pointer and dynamically allocate it but even that is too
> > > > > costly a size addition to the kernfs node structure as
> > > > > Tejun has said.
> > > > 
> > > > I guess the question to ask is, is there really a need to
> > > > call kernfs_refresh_inode() from functions that are usually
> > > > reading/checking functions.
> > > > 
> > > > Would it be sufficient to refresh the inode in the write/set
> > > > operations in (if there's any) places where things like
> > > > setattr_copy() is not already called?
> > > > 
> > > > Perhaps GKH or Tejun could comment on this?
> > > 
> > > My memory is a bit hazy but invalidations on reads is how sysfs
> > > namespace is
> > > implemented, so I don't think there's an easy around that. The
> > > only
> > > thing I
> > > can think of is embedding the lock into attrs and doing xchg
> > > dance
> > > when
> > > attaching it.
> > 
> > Sounds like your saying it would be ok to add a lock to the
> > attrs structure, am I correct?
> > 
> > Assuming it is then, to keep things simple, use two locks.
> > 
> > One global lock for the allocation and an attrs lock for all the
> > attrs field updates including the kernfs_refresh_inode() update.
> > 
> > The critical section for the global lock could be reduced and it
> > changed to a spin lock.
> > 
> > In __kernfs_iattrs() we would have something like:
> > 
> > take the allocation lock
> > do the allocated checks
> >   assign if existing attrs
> >   release the allocation lock
> >   return existing if found
> > othewise
> >   release the allocation lock
> > 
> > allocate and initialize attrs
> > 
> > take the allocation lock
> > check if someone beat us to it
> >   free and grab exiting attrs
> > otherwise
> >   assign the new attrs
> > release the allocation lock
> > return attrs
> > 
> > Add a spinlock to the attrs struct and use it everywhere for
> > field updates.
> > 
> > Am I on the right track or can you see problems with this?
> > 
> > Ian
> > 
> 
> umm, we update the inode in kernfs_refresh_inode, right??  So I guess
> the problem is how can we protect the inode when kernfs_refresh_inode
> is called, not the attrs??

But the attrs (which is what's copied from) were protected by the
mutex lock (IIUC) so dealing with the inode attributes implies
dealing with the kernfs node attrs too.

For example in kernfs_iop_setattr() the call to setattr_copy() copies
the node attrs to the inode under the same mutex lock. So, if a read
lock is used the copy in kernfs_refresh_inode() is no longer protected,
it needs to be protected in a different way.

Ian

