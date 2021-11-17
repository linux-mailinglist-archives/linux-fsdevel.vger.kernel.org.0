Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33697453E61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 03:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhKQCWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 21:22:53 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48463 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232716AbhKQCWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:22:53 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 39A185C025E;
        Tue, 16 Nov 2021 21:19:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 16 Nov 2021 21:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        M4FKKcTT/ML1XAuZ1GKscw1aefj/Z27iEFUKiEJ1d9k=; b=jWPAuU5IPa4GrhBx
        BTHX5Td6KQ3yG8u0YIHAZLTDZBgeemzN9G8qVbCaou5zS66oMD4a3+2JCGx6Sks5
        IJ/odbVD7dnQuzEdts+odDCyNepHtMdZLkxJQUzN/nw6Rq9W8lkjoncPZ6qSIR7d
        2+mhlLxtZRr7JK8U2Ci6LtrTqXyhMFvkcZRqLeMgtnNuEacymIjIg4wgpBnmyTip
        uaefi0TI7MzMIG1C0og2MwmdBjx56cGI+GtJiATk4pWi3Lis+txFN8UKQl8w51N4
        5DHc613nVJgyRY2Y0yya+7JTlqJlYGpfs5IYfN/N8Vse+YDuTByOPbq1i4icn90L
        xODooA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=M4FKKcTT/ML1XAuZ1GKscw1aefj/Z27iEFUKiEJ1d
        9k=; b=d4I/HzLQZYIbWwYX41y+Xkpa12IPXjkZphM19jSO6BspcxDkT6YuxSYs2
        fteESyFtuC06+27bnZVHyZEXU02EFzKhP61KB/92wnkSiPU8nkMGCnMZfJoudS+I
        ptFfRxdXXzH9eK6KDBNV3uZIs6/m41FueVoGcpjHqLelPYQ2+eGAB6YCENsSQFbL
        Q0SazXmfeX1fyBNW8GXKNvUWi8rjCgLhFH3adGnQqc1vFJUbyx7gUOSoSNAxYLNb
        LnwxvoqHV6+pru4Ghp0MuE5tDfvGH98coy6w3fVdGbzwE7nMR7HTxIMrgQHfEylJ
        VqJqRFajRNmgzKRpokSkNcQ5SYcng==
X-ME-Sender: <xms:ymaUYVK3Fo6YRmekWBj4vo7ue-8i_DRGqFi-cWEfENH2o30jRrD8Ag>
    <xme:ymaUYRLW7UtyQ2QbPq7rq-43J4KZNAuxis4ynencI_-dbSwEhX7JHDz9wwFxAY01M
    iT0q2-E-CjN>
X-ME-Received: <xmr:ymaUYdupkO4rRkmFCsY6CQhUxtWyQcSv-eSTUOfyD2AwJLuXBpH4P-euvUZUFSI56NjRoHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeefgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepgf
    elleekteehleegheeujeeuudfhueffgfelhefgvedthefhhffhhfdtudfgfeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:ymaUYWaA-lBtsN635-3XXxh7J4bo3avTJRBHV4CjHP_0OVS_Rh7ovQ>
    <xmx:ymaUYcYTUJh-_JIVbPiGgq_vC_fM9_jcaHjylNmxSLvrIqtar_GXJg>
    <xmx:ymaUYaDrSjurvHpHtpuSrOtT62V9Xqza9jJkYdx6lPJdO_hUfd7auA>
    <xmx:y2aUYROVyL2KXJ_VPKMp7oWDUFEqn1rj6adIGRWucTEEycWOtLI9Gw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Nov 2021 21:19:51 -0500 (EST)
Message-ID: <4253c446d98f9800b43d5966636bddabb3c6b1a0.camel@themaw.net>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
From:   Ian Kent <raven@themaw.net>
To:     Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Nov 2021 10:19:46 +0800
In-Reply-To: <20211117002251.GR449541@dread.disaster.area>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
         <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
         <20211112003249.GL449541@dread.disaster.area>
         <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
         <20211114231834.GM449541@dread.disaster.area>
         <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
         <20211115222417.GO449541@dread.disaster.area>
         <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
         <20211116030120.GQ449541@dread.disaster.area> <YZPVSTDIWroHNvFS@bfoster>
         <20211117002251.GR449541@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-11-17 at 11:22 +1100, Dave Chinner wrote:
> On Tue, Nov 16, 2021 at 10:59:05AM -0500, Brian Foster wrote:
> > On Tue, Nov 16, 2021 at 02:01:20PM +1100, Dave Chinner wrote:
> > > On Tue, Nov 16, 2021 at 09:03:31AM +0800, Ian Kent wrote:
> > > > On Tue, 2021-11-16 at 09:24 +1100, Dave Chinner wrote:
> > > > > If it isn't safe for ext4 to do that, then we have a general
> > > > > pathwalk problem, not an XFS issue. But, as you say, it is
> > > > > safe
> > > > > to do this zeroing, so the fix to xfs_ifree() is to zero the
> > > > > link buffer instead of freeing it, just like ext4 does.
> > > > > 
> > > > > As a side issue, we really don't want to move what XFS does
> > > > > in
> > > > > .destroy_inode to .free_inode because that then means we need
> > > > > to
> > > > > add synchronise_rcu() calls everywhere in XFS that might need
> > > > > to
> > > > > wait on inodes being inactivated and/or reclaimed. And
> > > > > because
> > > > > inode reclaim uses lockless rcu lookups, there's substantial
> > > > > danger of adding rcu callback related deadlocks to XFS here.
> > > > > That's just not a direction we should be moving in.
> > > > 
> > > > Another reason I decided to use the ECHILD return instead is
> > > > that
> > > > I thought synchronise_rcu() might add an unexpected delay.
> > > 
> > > It depends where you put the synchronise_rcu() call. :)
> > > 
> > > > Since synchronise_rcu() will only wait for processes that
> > > > currently have the rcu read lock do you think that could
> > > > actually
> > > > be a problem in this code path?
> > > 
> > > No, I don't think it will.  The inode recycle case in XFS inode
> > > lookup can trigger in two cases:
> > > 
> > > 1. VFS cache eviction followed by immediate lookup
> > > 2. Inode has been unlinked and evicted, then free and reallocated
> > > by
> > > the filesytsem.
> > > 
> > > In case #1, that's a cold cache lookup and hence delays are
> > > acceptible (e.g. a slightly longer delay might result in having
> > > to
> > > fetch the inode from disk again). Calling synchronise_rcu() in
> > > this
> > > case is not going to be any different from having to fetch the
> > > inode
> > > from disk...
> > > 
> > > In case #2, there's a *lot* of CPU work being done to modify
> > > metadata (inode btree updates, etc), and so the operations can
> > > block
> > > on journal space, metadata IO, etc. Delays are acceptible, and
> > > could
> > > be in the order of hundreds of milliseconds if the transaction
> > > subsystem is bottlenecked. waiting for an RCU grace period when
> > > we
> > > reallocate an indoe immediately after freeing it isn't a big
> > > deal.
> > > 
> > > IOWs, if synchronize_rcu() turns out to be a problem, we can
> > > optimise that separately - we need to correct the inode reuse
> > > behaviour w.r.t. VFS RCU expectations, then we can optimise the
> > > result if there are perf problems stemming from correct
> > > behaviour.
> > > 
> > 
> > FWIW, with a fairly crude test on a high cpu count system, it's not
> > that
> > difficult to reproduce an observable degradation in inode
> > allocation
> > rate with a synchronous grace period in the inode reuse path,
> > caused
> > purely by a lookup heavy workload on a completely separate
> > filesystem.
> > 
> > The following is a 5m snapshot of the iget stats from a filesystem
> > doing
> > allocs/frees with an external/heavy lookup workload (which not
> > included
> > in the stats), with and without a sync grace period wait in the
> > reuse
> > path:
> > 
> > baseline:       ig 1337026 1331541 4 5485 0 5541 1337026
> > sync_rcu_test:  ig 2955 2588 0 367 0 383 2955
> 
> The alloc/free part of the workload is a single threaded
> create/unlink in a tight loop, yes?
> 
> This smells like a side effect of agressive reallocation of
> just-freed XFS_IRECLAIMABLE inodes from the finobt that haven't had
> their unlink state written back to disk yet. i.e. this is a corner
> case in #2 above where a small set of inodes is being repeated
> allocated and freed by userspace and hence being agressively reused
> and never needing to wait for IO. i.e. a tempfile workload
> optimisation...
> 
> > I think this is kind of the nature of RCU and why I'm not sure it's
> > a
> > great idea to rely on update side synchronization in a codepath
> > that
> > might want to scale/perform in certain workloads.
> 
> The problem here is not update side synchronisation. Root cause is
> aggressive reallocation of recently freed VFS inodes via physical
> inode allocation algorithms. Unfortunately, the RCU grace period
> requirements of the VFS inode life cycle dictate that we can't
> aggressively re-allocate and reuse freed inodes like this. i.e.
> reallocation of a just-freed inode also has to wait for an RCU grace
> period to pass before the in memory inode can be re-instantiated as
> a newly allocated inode.
> 
> (Hmmmm - I wonder if of the other filesystems might have similar
> problems with physical inode reallocation inside a RCU grace period?
> i.e. without inode instance re-use, the VFS could potentially see
> multiple in-memory instances of the same physical inode at the same
> time.)
> 
> > I'm not totally sure
> > if this will be a problem for real users running real workloads or
> > not,
> > or if this can be easily mitigated, whether it's all rcu or a
> > cascading
> > effect, etc. This is just a quick test so that all probably
> > requires
> > more test and analysis to discern.
> 
> This looks like a similar problem to what busy extents address - we
> can't reuse a newly freed extent until the transaction containing
> the EFI/EFD hit stable storage (and the discard operation on the
> range is complete). Hence while a newly freed extent is
> marked free in the allocbt, they can't be reused until they are
> released from the busy extent tree.
> 
> I can think of several ways to address this, but let me think on it
> a bit more.  I suspect there's a trick we can use to avoid needing
> synchronise_rcu() completely by using the spare radix tree tag and
> rcu grace period state checks with get_state_synchronize_rcu() and
> poll_state_synchronize_rcu() to clear the radix tree tags via a
> periodic radix tree tag walk (i.e. allocation side polling for "can
> we use this inode" rather than waiting for the grace period to
> expire once an inode has been selected and allocated.)

The synchronise_rcu() seems like it's too broad a brush.

It sounds like there are relatively simple ways to avoid the link
path race which I won't go into again but there's still a chance
inode re-use can cause confusion if done at the wrong time.

So it sounds like per-object (inode) granularity is needed for the
wait and that means answering the question "how do we know when it's
ok to re-use the inode" when we come to alloc the inode and want to
re-use one.

I don't know the answer to that question but introducing an XFS flag
to indicate the inode is in transition (or altering the meaning of an
an existing one) so we know to wait should be straight forward.

Perhaps the start of the rcu grace period for the object is a
suitable beginning then we just need to know if the grace period
for the object has expired to complete the wait ... possibly via
an xfs owned rcu call back on free to update the xfs flags ...

But I'm just thinking out loud here ...

There'd be a need to know when not to wait at all too ... mmm.

Ian
> 
> > > > 
> > > > Sorry, I don't understand what you mean by the root cause not
> > > > being identified?
> > > 
> > > The whole approach of "we don't know how to fix the inode reuse
> > > case
> > > so disable it" implies that nobody has understood where in the
> > > reuse
> > > case the problem lies. i.e. "inode reuse" by itself is not the
> > > root
> > > cause of the problem.
> > > 
> > 
> > I don't think anybody suggested to disable inode reuse.
> 
> Nobody did, so that's not what I was refering to. I was refering to
> the patches for and comments advocating disabling .get_link for RCU
> pathwalk because of the apparently unsolved problems stemming from
> inode reuse...
> 
> > > The root cause is "allowing an inode to be reused without waiting
> > > for an RCU grace period to expire". This might seem pedantic, but
> > > "without waiting for an rcu grace period to expire" is the
> > > important
> > > part of the problem (i.e. the bug), not the "allowing an inode to
> > > be
> > > reused" bit.
> > > 
> > > Once the RCU part of the problem is pointed out, the solution
> > > becomes obvious. As nobody had seen the obvious (wait for an RCU
> > > grace period when recycling an inode) it stands to reason that
> > > nobody really understood what the root cause of the inode reuse
> > > problem.
> > > 
> > 
> > The synchronize_rcu() approach was one of the first options
> > discussed in
> > the bug report once a reproducer was available.
> 
> What bug report would that be? :/
> 
> It's not one that I've read, and I don't recall seeing a pointer to
> it anywhere in the path posting. IOWs, whatever discussion happened
> in a private distro bug report can't be assumed as "general
> knowledge" in an upstream discussion...
> 
> > AIUI, this is not currently a reproducible problem even before
> > patch 1,
> > which reduces the race window even further. Given that and the nak
> > on
> > the current patch (the justification for which I don't really
> > understand), I'm starting to agree with Ian's earlier statement
> > that
> > perhaps it is best to separate this one so we can (hopefully) move
> > patch
> > 1 along on its own merit..
> 
> *nod*
> 
> The problem seems pretty rare, the pathwalk patch makes it
> even rarer, so I think they can be separated just fine.
> 
> Cheers,
> 
> Dave.


