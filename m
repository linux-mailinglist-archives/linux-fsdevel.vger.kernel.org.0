Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A683452218
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 02:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245237AbhKPBJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 20:09:56 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33415 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351651AbhKPBGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 20:06:37 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0DBC75C0293;
        Mon, 15 Nov 2021 20:03:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Nov 2021 20:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        MHqYZ+/pY21LiNPsE1W8Nl4Z9s0SLcvd4Wu8FaBLrTY=; b=h9gQawdtob5PGFAi
        FkIgJPgPZyLSs/NIcbuyTXdDb3y/ue1B4yXkmcOzTe/hzey2WEc8MFzcGIhVuBIt
        FpZby1+BTyJrQV6yWVwxtII0ACj1xjp4t9PAA5/UnvlvYk7meKQYckiavuqv9yez
        edjlPMigtFWm0++8ivSaZrewqk1FnHNg/NckZo4FTokBUAwNs50yAJL878bVZaaH
        8F1CaeIrPirdOYFFclBH19tczBFEvzHxg+ZcDxxh+C20DJGqN/WNzOVC0haPInQY
        1eui5pl9busojVtCrn5k7GbYh21ivlxsMTtvtlQ1YOxhdpWyDQhZFHzJNWcuHDhJ
        3+m+Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=MHqYZ+/pY21LiNPsE1W8Nl4Z9s0SLcvd4Wu8FaBLr
        TY=; b=Aw9s2+9jw0Ct6Ia2acnXc7ubFLYaapwmRhkvRs0bCGciemwl5AEvqblS8
        pmhvbCXKlU0u1HXBzaTy2ql4KSszriCdwVv7ky6wEs5K6+1UfbTzP2KMMC5YoUA+
        5240p0iDkdXcLvdq5NalOP1qKUAB/6eXtDOPCldG92Hr8f75zAx83vd2/rwOrWJM
        ta1wjMehu6Kdq6rQxfHzsNJTNVlpyY7seJ6hNuhE7dAte9h2cUNeMg+5CAjd06UN
        5qmA89/jBjFmhUUNbJUmNfK2iS/4ph7nF0rbaHcyqkJ/7FSUyiaN+7J//Btm9gyL
        p1zFxh3yI3T+sAcgjrzkF8qLIsdUw==
X-ME-Sender: <xms:awOTYVRQzyRkFjOxUvDk4IGu79tIsdBVhykQkxek_VC6KFplLTUl3w>
    <xme:awOTYezH1hvHWOJSypV3xPJ6jmR54gswKM9LY41qQlPe1-XZQZrBs0TzXCDrCxRkG
    61XGwxymBSo>
X-ME-Received: <xmr:awOTYa1_Ab-9Bt2g0JDqPPShIxkyCPcbNkHOCi5puN2X61tvW3RL6px0I-pCDDg8J0LAxGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedugddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepgf
    elleekteehleegheeujeeuudfhueffgfelhefgvedthefhhffhhfdtudfgfeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:awOTYdA2uKoAWLp7GJ4rGgJibbBT0XFh55X05sXgJmdpdZRMuK5S3Q>
    <xmx:awOTYej6sVUiyWNdrRWwfXERg28S92ki_Bg_9d7jA7Fobrw3r4yJdA>
    <xmx:awOTYRrh-mKG6D_fISCcgCGV3IBx4xdnr-a-But6jZGy04nkPAZ5WA>
    <xmx:bAOTYZVywYgqj5qXJlqGRbVwpwhyPshTMr7c0Mp5Ocnm26WHqQjtPQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Nov 2021 20:03:36 -0500 (EST)
Message-ID: <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
From:   Ian Kent <raven@themaw.net>
To:     Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Nov 2021 09:03:31 +0800
In-Reply-To: <20211115222417.GO449541@dread.disaster.area>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
         <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
         <20211112003249.GL449541@dread.disaster.area>
         <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
         <20211114231834.GM449541@dread.disaster.area>
         <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
         <20211115222417.GO449541@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-11-16 at 09:24 +1100, Dave Chinner wrote:
> On Mon, Nov 15, 2021 at 10:21:03AM +0100, Miklos Szeredi wrote:
> > On Mon, 15 Nov 2021 at 00:18, Dave Chinner <david@fromorbit.com>
> > wrote:
> > > I just can't see how this race condition is XFS specific and why
> > > fixing it requires XFS to sepcifically handle it while we ignore
> > > similar theoretical issues in other filesystems...
> > 
> > It is XFS specific, because all other filesystems RCU free the in-
> > core
> > inode after eviction.
> > 
> > XFS is the only one that reuses the in-core inode object and that
> > is
> > very much different from anything the other filesystems do and what
> > the VFS expects.
> 
> Sure, but I was refering to the xfs_ifree issue that the patch
> addressed, not the re-use issue that the *first patch addressed*.
> 
> > I don't see how clearing the quick link buffer in
> > ext4_evict_inode()
> > could do anything bad.  The contents are irrelevant, the lookup
> > will
> > be restarted anyway, the important thing is that the buffer is not
> > freed and that it's null terminated, and both hold for the ext4,
> > AFAICS.
> 
> You miss the point (which, admittedly, probably wasn't clear).
> 
> I suggested just zeroing the buffer in xfs_ifree instead of zeroing
> it, which you seemed to suggest wouldn't work and we should move the
> XFS functionality to .free_inode. That's what I was refering to as
> "not being XFS specific" - if it is safe for ext4 to zero the link
> buffer in .evict while lockless lookups can still be accessing the
> link buffer, it is safe for XFS to do the same thing in .destroy
> context.

I'll need to think about that for a while.

Zeroing the buffer while it's being used seems like a problem to
me and was what this patch was trying to avoid.

I thought all that would be needed for this to happen is for a
dentry drop to occur while the link walk was happening after
->get_link() had returned the pointer.

What have I got wrong in that thinking?

> 
> If it isn't safe for ext4 to do that, then we have a general
> pathwalk problem, not an XFS issue. But, as you say, it is safe to
> do this zeroing, so the fix to xfs_ifree() is to zero the link
> buffer instead of freeing it, just like ext4 does.
> 
> As a side issue, we really don't want to move what XFS does in
> .destroy_inode to .free_inode because that then means we need to add
> synchronise_rcu() calls everywhere in XFS that might need to wait on
> inodes being inactivated and/or reclaimed. And because inode reclaim
> uses lockless rcu lookups, there's substantial danger of adding rcu
> callback related deadlocks to XFS here. That's just not a direction
> we should be moving in.

Another reason I decided to use the ECHILD return instead is that
I thought synchronise_rcu() might add an unexpected delay.

Since synchronise_rcu() will only wait for processes that currently
have the rcu read lock do you think that could actually be a problem
in this code path?

> 
> I'll also point out that this would require XFS inodes to pass
> through *two* rcu grace periods before the memory they hold could be
> freed because, as I mentioned, xfs inode reclaim uses rcu protected
> inode lookups and so relies on inodes to be freed by rcu callback...
> 
> > I tend to agree with Brian and Ian at this point: return -ECHILD
> > from
> > xfs_vn_get_link_inline() until xfs's inode resue vs. rcu walk
> > implications are fully dealt with.  No way to fix this from VFS
> > alone.
> 
> I disagree from a fundamental process POV - this is just sweeping
> the issue under the table and leaving it for someone else to solve
> because the root cause of the inode re-use issue has not been
> identified. But to the person who architected the lockless XFS inode
> cache 15 years ago, it's pretty obvious, so let's just solve it now.

Sorry, I don't understand what you mean by the root cause not
being identified?

Until lockless path walking was introduced this wasn't a problem
because references were held during walks so there could never be
a final dput() to trigger freeing process during a walk. And a lot
of code probably still makes that assumption. And code that does
make that assumption should return -ECHILD in cases like this so
that the VFS can either legitimize the struct path (by taking
references) or restart the walk in ref-walk mode.

Can you elaborate please?

> 
> With the xfs_ifree() problem solved by zeroing rather than freeing,
> then the only other problem is inode reuse *within an rcu grace
> period*. Immediate inode reuse tends to be rare, (we can actually
> trace occurrences to validate this assertion), and implementation
> wise reuse is isolated to a single function: xfs_iget_recycle().
> 
> xfs_iget_recycle() drops the rcu_read_lock() inode lookup context
> that found the inode marks it as being reclaimed (preventing other
> lookups from finding it), then re-initialises the inode. This is
> what makes .get_link change in the middle of pathwalk - we're
> reinitialising the inode without waiting for the RCU grace period to
> expire.

Ok, good to know that, there's a lot of icache code to look
through, ;)

At this point I come back to thinking the original patch might
be sufficient. But then that's only for xfs and excludes
potential problems with other file systems so I'll not go
there.

> 
> The obvious thing to do here is that after we drop the RCU read
> context, we simply call synchronize_rcu() before we start
> re-initialising the inode to wait for the current grace period to
> expire. This ensures that any pathwalk that may have found that
> inode has seen the sequence number change and droppped out of
> lockless mode and is no longer trying to access that inode.  Then we
> can safely reinitialise the inode as it has passed through a RCU
> grace period just like it would have if it was freed and
> reallocated.

Sounds right to me, as long as it is ok to call synchronize_rcu()
here.

> 
> This completely removes the entire class of "reused inodes race with
> VFS level RCU walks" bugs from the XFS inode cache implementation,
> hence XFS inodes behave the same as all other filesystems w.r.t RCU
> grace period expiry needing to occur before a VFS inode is reused.
> 
> So, it looks like three patches to fix this entirely:
> 
> 1. the pathwalk link sequence check fix
> 2. zeroing the inline link buffer in xfs_ifree()

I'm sorry but I'm really having trouble understanding how this is
ok. If some process is using the buffer to walk a link path how
can zeroing the contents of the buffer be ok?

> 3. adding synchronize_rcu() (or some variant) to xfs_iget_recycle()
> 
> Cheers,
> 
> Dave.


