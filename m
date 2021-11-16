Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEE44532F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 14:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhKPNlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 08:41:24 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54661 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232201AbhKPNlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:41:22 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 25F723201C9B;
        Tue, 16 Nov 2021 08:38:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 16 Nov 2021 08:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        7Jjr5ukXlwDW5Tw8k0Q0sV7tsthe0z5djAVFAB3mnAw=; b=DQm6EMBPlBm1kFXM
        BzuEdY25PY9h2Ylu4lhNDtqW5cPGfcHD8/cvftWgXlxczAzWRARt9oeY5HjeL3IX
        G1/ZJWyC4D3vQAugr9EcVh2v+37Qx6fbMMXzZ2MqS0xyNRKdu1vxRiFgZq+m6Wac
        un1ugc+y/NZ4GqMobbiwlmA63p+aFpAMhQkjlKpdAeS4jwiPjcmnxT0TBYEB7KgM
        WxGc9mhXI2Zbam8zKDPTujQOZfodVnq0I3+5LX3Mj/uFb5kQtmAj0+dkjIJrQTbM
        zm0EsFHwhFRkRumHGMpOTjhrmokm8h3SJyDDIzUMoNlPq87llro/S72klVUivfpz
        i9wT4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=7Jjr5ukXlwDW5Tw8k0Q0sV7tsthe0z5djAVFAB3mn
        Aw=; b=XPGlNcd3MlzNhLSxakAlEwVYLQ693TRhbXrc3YX7ju0fKkiOkBJuelagH
        PUz+9mAMee3H4UTvVgkB2mDMQrK86eOwgK+S0+L1kL7Zo+dmLH+SVQKhuCezFyYN
        WFI/QBy+BqC1YN0eJFDc7W1tpC3to1f7kZ+CjSHANmFaCASqUlsyuboc1mnWsR1B
        beWRmwspRKNWI0FFJ6wCu1HzCN5BIUZzHTzr3B0bnHWBsmt6mXuVVbUxzoltDG9P
        4vKM/eBKGmSbRLbaSAgGsfHRDnNb/RzF8/qqqucSYm08gmcEOfNYxy1dbEtIC+YU
        i5iOT3kbgfilWdUSrYfri9E08TLFA==
X-ME-Sender: <xms:T7STYfXq_IPMxm7_mk2X-V0SpxYBIErbM0nP6zKrOMmOq-szV4eiZA>
    <xme:T7STYXlEmsUpH_zUPFTo50JXvbHpMg_r6GdUuUoLfeJW5_d5dWrfmB9SPaU3rnO9M
    bbJ2-5pVW7h>
X-ME-Received: <xmr:T7STYbY1IME5EgpZy3x16I3NKHwHTx7OgKm-QlN198Y3EmCFQO-CmO96fB0pO8-ouF0wLs0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedvgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepgf
    elleekteehleegheeujeeuudfhueffgfelhefgvedthefhhffhhfdtudfgfeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:T7STYaXOo8fGs-YurHekLlP_wsEVTPkXEDV8woyX8Qq40xiH7LWQcg>
    <xmx:T7STYZn-xv4u6aXdQd9VHyt-jvGfVG4Q2H_L6fSB1wWHHV-CdHKyiw>
    <xmx:T7STYXd5aicVD1FtDI79t0nxfla7MpsrVDGoe5NrqIeXdUCMxN0sSg>
    <xmx:T7STYXb3fn-HXk3A9SWzUO0ykzudFssVOs9gyDESyq8JYMMSrbH7Uw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Nov 2021 08:38:19 -0500 (EST)
Message-ID: <06b5d7bc6feb5a011929bb26112fda7a8529bbd4.camel@themaw.net>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
From:   Ian Kent <raven@themaw.net>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Nov 2021 21:38:16 +0800
In-Reply-To: <20211116030120.GQ449541@dread.disaster.area>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
         <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
         <20211112003249.GL449541@dread.disaster.area>
         <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
         <20211114231834.GM449541@dread.disaster.area>
         <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
         <20211115222417.GO449541@dread.disaster.area>
         <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
         <20211116030120.GQ449541@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-11-16 at 14:01 +1100, Dave Chinner wrote:
> On Tue, Nov 16, 2021 at 09:03:31AM +0800, Ian Kent wrote:
> > On Tue, 2021-11-16 at 09:24 +1100, Dave Chinner wrote:
> > > On Mon, Nov 15, 2021 at 10:21:03AM +0100, Miklos Szeredi wrote:
> > > > On Mon, 15 Nov 2021 at 00:18, Dave Chinner
> > > > <david@fromorbit.com>
> > > > wrote:
> > > > > I just can't see how this race condition is XFS specific and
> > > > > why
> > > > > fixing it requires XFS to sepcifically handle it while we
> > > > > ignore
> > > > > similar theoretical issues in other filesystems...
> > > > 
> > > > It is XFS specific, because all other filesystems RCU free the
> > > > in-
> > > > core
> > > > inode after eviction.
> > > > 
> > > > XFS is the only one that reuses the in-core inode object and
> > > > that
> > > > is
> > > > very much different from anything the other filesystems do and
> > > > what
> > > > the VFS expects.
> > > 
> > > Sure, but I was refering to the xfs_ifree issue that the patch
> > > addressed, not the re-use issue that the *first patch addressed*.
> > > 
> > > > I don't see how clearing the quick link buffer in
> > > > ext4_evict_inode()
> > > > could do anything bad.  The contents are irrelevant, the lookup
> > > > will
> > > > be restarted anyway, the important thing is that the buffer is
> > > > not
> > > > freed and that it's null terminated, and both hold for the
> > > > ext4,
> > > > AFAICS.
> > > 
> > > You miss the point (which, admittedly, probably wasn't clear).
> > > 
> > > I suggested just zeroing the buffer in xfs_ifree instead of
> > > zeroing
> > > it, which you seemed to suggest wouldn't work and we should move
> > > the
> > > XFS functionality to .free_inode. That's what I was refering to
> > > as
> > > "not being XFS specific" - if it is safe for ext4 to zero the
> > > link
> > > buffer in .evict while lockless lookups can still be accessing
> > > the
> > > link buffer, it is safe for XFS to do the same thing in .destroy
> > > context.
> > 
> > I'll need to think about that for a while.
> > 
> > Zeroing the buffer while it's being used seems like a problem to
> > me and was what this patch was trying to avoid.
> 
> *nod*
> 
> That was my reading of the situation when I saw what ext4 was doing.
> But Miklos says that this is fine, and I don't know the code well
> enough to say he's wrong. So if it's ok for ext4, it's OK for XFS.
> If it's not OK for XFS, then it isn't OK for ext4 either, and we
> have more bugs to fix than just in XFS.
> 
> > I thought all that would be needed for this to happen is for a
> > dentry drop to occur while the link walk was happening after
> > ->get_link() had returned the pointer.
> > 
> > What have I got wrong in that thinking?
> 
> Nothing that I can see, but see my previous statement above.
> 
> I *think* that just zeroing the buffer means the race condition
> means the link resolves as either wholly intact, partially zeroed
> with trailing zeros in the length, wholly zeroed or zero length.
> Nothing will crash, the link string is always null terminated even
> if the length is wrong, and so nothing bad should happen as a result
> of zeroing the symlink buffer when it gets evicted from the VFS
> inode cache after unlink.

Oh, of course (sound of penny dropping), the walk will loop around
and an empty link string will essentially end the walk. What's
needed then is to look at what would be returned in that case.

So, there shouldn't be a crash then, and assuming a sensible walk
failure in this case ENOENT (dentry now negative) or similar is
most likely (need to check that).

> 
> > > If it isn't safe for ext4 to do that, then we have a general
> > > pathwalk problem, not an XFS issue. But, as you say, it is safe
> > > to do this zeroing, so the fix to xfs_ifree() is to zero the
> > > link buffer instead of freeing it, just like ext4 does.
> > > 
> > > As a side issue, we really don't want to move what XFS does in
> > > .destroy_inode to .free_inode because that then means we need to
> > > add synchronise_rcu() calls everywhere in XFS that might need to
> > > wait on inodes being inactivated and/or reclaimed. And because
> > > inode reclaim uses lockless rcu lookups, there's substantial
> > > danger of adding rcu callback related deadlocks to XFS here.
> > > That's just not a direction we should be moving in.
> > 
> > Another reason I decided to use the ECHILD return instead is that
> > I thought synchronise_rcu() might add an unexpected delay.
> 
> It depends where you put the synchronise_rcu() call. :)
> 
> > Since synchronise_rcu() will only wait for processes that
> > currently have the rcu read lock do you think that could actually
> > be a problem in this code path?
> 
> No, I don't think it will.  The inode recycle case in XFS inode
> lookup can trigger in two cases:
> 
> 1. VFS cache eviction followed by immediate lookup
> 2. Inode has been unlinked and evicted, then free and reallocated by
> the filesytsem.
> 
> In case #1, that's a cold cache lookup and hence delays are
> acceptible (e.g. a slightly longer delay might result in having to
> fetch the inode from disk again). Calling synchronise_rcu() in this
> case is not going to be any different from having to fetch the inode
> from disk...
> 
> In case #2, there's a *lot* of CPU work being done to modify
> metadata (inode btree updates, etc), and so the operations can block
> on journal space, metadata IO, etc. Delays are acceptible, and could
> be in the order of hundreds of milliseconds if the transaction
> subsystem is bottlenecked. waiting for an RCU grace period when we
> reallocate an indoe immediately after freeing it isn't a big deal.
> 
> IOWs, if synchronize_rcu() turns out to be a problem, we can
> optimise that separately - we need to correct the inode reuse
> behaviour w.r.t. VFS RCU expectations, then we can optimise the
> result if there are perf problems stemming from correct behaviour.

Sounds good, so a synchronize_rcu() in that particular location
would allow some time to rail the walk before the inode is re-used.
That should be quick enough to avoid any possible re-use races ...

Interesting ... 

OTOH ext4 is not a problem because the inode is going away not
being re-used so there's no potential race from filling in the
inode fields afresh.

I think that's the concern Miklos is alluding to.

> 
> > > I'll also point out that this would require XFS inodes to pass
> > > through *two* rcu grace periods before the memory they hold could
> > > be
> > > freed because, as I mentioned, xfs inode reclaim uses rcu
> > > protected
> > > inode lookups and so relies on inodes to be freed by rcu
> > > callback...
> > > 
> > > > I tend to agree with Brian and Ian at this point: return -
> > > > ECHILD
> > > > from
> > > > xfs_vn_get_link_inline() until xfs's inode resue vs. rcu walk
> > > > implications are fully dealt with.  No way to fix this from VFS
> > > > alone.
> > > 
> > > I disagree from a fundamental process POV - this is just sweeping
> > > the issue under the table and leaving it for someone else to
> > > solve
> > > because the root cause of the inode re-use issue has not been
> > > identified. But to the person who architected the lockless XFS
> > > inode
> > > cache 15 years ago, it's pretty obvious, so let's just solve it
> > > now.
> > 
> > Sorry, I don't understand what you mean by the root cause not
> > being identified?
> 
> The whole approach of "we don't know how to fix the inode reuse case
> so disable it" implies that nobody has understood where in the reuse
> case the problem lies. i.e. "inode reuse" by itself is not the root
> cause of the problem.

Right, not strictly no.

> 
> The root cause is "allowing an inode to be reused without waiting
> for an RCU grace period to expire". This might seem pedantic, but
> "without waiting for an rcu grace period to expire" is the important
> part of the problem (i.e. the bug), not the "allowing an inode to be
> reused" bit.

Pedantic is good, it's needed in this case for sure.

Provided handling of the dentry (and indirectly the inode) is
done quickly. And zeroing the field should do just that. Trying
to preserve the old link path string isn't feasible, it could
take too long to resolve the path and possibly switch path walk
modes introducing side effects related to the rcu-grace expiring.
But the truth is the link is gone so failing the walk should be
a perfectly valid result.

> 
> Once the RCU part of the problem is pointed out, the solution
> becomes obvious. As nobody had seen the obvious (wait for an RCU
> grace period when recycling an inode) it stands to reason that
> nobody really understood what the root cause of the inode reuse
> problem.

Well, I guess, not completely, yes ...

I'll think about what's been discussed and wait for any further
contributions before doing anything else on this. In any case
there's a few things to look at resulting from the discussion.

Thanks for your patience with this,
Ian

> 
> > > With the xfs_ifree() problem solved by zeroing rather than
> > > freeing,
> > > then the only other problem is inode reuse *within an rcu grace
> > > period*. Immediate inode reuse tends to be rare, (we can actually
> > > trace occurrences to validate this assertion), and implementation
> > > wise reuse is isolated to a single function: xfs_iget_recycle().
> > > 
> > > xfs_iget_recycle() drops the rcu_read_lock() inode lookup context
> > > that found the inode marks it as being reclaimed (preventing
> > > other
> > > lookups from finding it), then re-initialises the inode. This is
> > > what makes .get_link change in the middle of pathwalk - we're
> > > reinitialising the inode without waiting for the RCU grace period
> > > to
> > > expire.
> > 
> > Ok, good to know that, there's a lot of icache code to look
> > through, ;)
> 
> My point precisely. :)
> 
> Cheers,
> 
> Dave.


