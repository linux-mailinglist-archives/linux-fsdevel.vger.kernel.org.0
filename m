Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A289A44F15A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Nov 2021 06:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhKMFUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Nov 2021 00:20:31 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59517 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhKMFUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Nov 2021 00:20:30 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F62B5C0187;
        Sat, 13 Nov 2021 00:17:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 13 Nov 2021 00:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        EMFXt56XgkIM+6uzmaJKNay8yGXjJ2lMsP116bCZSDs=; b=PMiWSuxjhHQfia45
        PpKrnze6bK1eU+4vO6UdyR1ya41t/smtnZ2gQFT333oFVu7KrZ1lwIiVrG4mDsRE
        AZe8BTaF0MwniP3hLbud/IEDKxXUxdBazutOJV2zQcmJNmC3IGFe24KD5pjREKoj
        hna8tWBkkTQHtjbv8HWsUG0XIcf9uY/4AXi170yPVNz0bCaQgHzsK1W80A3v5jEN
        qDR5QolQws+ISlKEsVGyPinYYvlAU39UBBjCLcJdsR7J3shKG/3oevtW+wqTtzny
        qaq12uG5+RzkLYIJNAs998TJ7rBemoZu+awzZmmCAxxJiKTwX6XDVrYhFB2E4ovo
        Dxvfnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=EMFXt56XgkIM+6uzmaJKNay8yGXjJ2lMsP116bCZS
        Ds=; b=maUcf73arKJ3GwgLT8ZELNPu/6gt7HyLNbrmYbHy6QBaWZ2pWsYrl0MyJ
        17+uqjKs/kuciuo3o/I7SrWkD2GiRagv7HfI/pl+7vx8PcJvTHd64jZFUB2unWsc
        wQQlWkCEvfRtoV+WzkSWzVTR3zZ6ijb5/9mdzhaB2g4pMeehPiXI2eQMFh39Rwmm
        sFOzyEowZjtIWG3QxdA27JrWBwHG0OH6pYeKSx0fHV36jlR0lHB6LozMEXH2sR0A
        aecvO02/ObS7s9txnipCHRfrCMIVNJ5PwUkkkgSvxlF5+j8YMMTbmCmgYf0B/bcs
        2ee7F6+nT/PojV8gOZimkL1u2FmoA==
X-ME-Sender: <xms:cUqPYSqGxYvC_SJPsWk8dKZ0CSNpdac7yC27fSDImuYeFJGxEXRtMg>
    <xme:cUqPYQr4UVwWvtoeQZtJs3fRlWfrAKRVd-95LTpqN0F9zOnCI6znt6JNtutoIjCkH
    lpmcAHZ_vtW>
X-ME-Received: <xmr:cUqPYXPwV0DTrmmgdMKAPzTkihZ-Q2WpnA0_HQJV2s3NSWuh9iEAzX5n7YfxGlYO8ujjqck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdeggdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepgf
    elleekteehleegheeujeeuudfhueffgfelhefgvedthefhhffhhfdtudfgfeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:cUqPYR4fYBCG3qDghIMUco5A_zJmbYD0NvutLyBKINInmvPV7eD1BA>
    <xmx:cUqPYR74zUTi-uImRJyB70VhwGKutMK1oNwB_KXHCxdh9CI0myb1qw>
    <xmx:cUqPYRg1LJl6TDVPHfcfpWEItskTL2hkk4y7DAYBAEASaiT-ubvwRw>
    <xmx:ckqPYfTF1ZOZjXv4OhnpRa7wf4AA2eh34K7pFK5iVQqThAvSK-2t9Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Nov 2021 00:17:34 -0500 (EST)
Message-ID: <4d05efe9917a2c7fff8294e2951e0468b5e178fe.camel@themaw.net>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
From:   Ian Kent <raven@themaw.net>
To:     Brian Foster <bfoster@redhat.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 13 Nov 2021 13:17:29 +0800
In-Reply-To: <YY5UYitVcs7pPklb@bfoster>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
         <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
         <YY1AEaHRLe+P4IYr@bfoster>
         <ed30a482ce8404de7974bc86b4c9fc98a5ae9060.camel@themaw.net>
         <YY5UYitVcs7pPklb@bfoster>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-11-12 at 06:47 -0500, Brian Foster wrote:
> On Fri, Nov 12, 2021 at 07:10:19AM +0800, Ian Kent wrote:
> > On Thu, 2021-11-11 at 11:08 -0500, Brian Foster wrote:
> > 
> > Hi Brian,
> > 
> > > On Thu, Nov 11, 2021 at 11:39:30AM +0800, Ian Kent wrote:
> > > > When following a trailing symlink in rcu-walk mode it's
> > > > possible to
> > > > succeed in getting the ->get_link() method pointer but the link
> > > > path
> > > > string be deallocated while it's being used.
> > > > 
> > > > Utilize the rcu mechanism to mitigate this risk.
> > > > 
> > > > Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> > > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > > ---
> > > >  fs/xfs/kmem.h      |    4 ++++
> > > >  fs/xfs/xfs_inode.c |    4 ++--
> > > >  fs/xfs/xfs_iops.c  |   10 ++++++++--
> > > >  3 files changed, 14 insertions(+), 4 deletions(-)
> > > > 
> > > ...
> > > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > > index a607d6aca5c4..2977e19da7b7 100644
> > > > --- a/fs/xfs/xfs_iops.c
> > > > +++ b/fs/xfs/xfs_iops.c
> > > > @@ -524,11 +524,17 @@ xfs_vn_get_link_inline(
> > > >  
> > > >         /*
> > > >          * The VFS crashes on a NULL pointer, so return -
> > > > EFSCORRUPTED if
> > > > -        * if_data is junk.
> > > > +        * if_data is junk. Also, if the path walk is in rcu-
> > > > walk
> > > > mode
> > > > +        * and the inode link path has gone away due inode re-
> > > > use
> > > > we have
> > > > +        * no choice but to tell the VFS to redo the lookup.
> > > >          */
> > > > -       link = ip->i_df.if_u1.if_data;
> > > > +       link = rcu_dereference(ip->i_df.if_u1.if_data);
> > > > +       if (!dentry && !link)
> > > > +               return ERR_PTR(-ECHILD);
> > > > +
> > > 
> > > One thing that concerns me slightly about this approach is that
> > > inode
> > > reuse does not necessarily guarantee that if_data is NULL. It
> > > seems
> > > technically just as possible (even if exceedingly unlikely) for
> > > link
> > > to
> > > point at newly allocated memory since the previous sequence count
> > > validation check. The inode could be reused as another inline
> > > symlink
> > > for example, though it's not clear to me if that is really a
> > > problem
> > > for
> > > the vfs (assuming a restart would just land on the new link
> > > anyways?).
> > > But the inode could also be reallocated as something like a
> > > shortform
> > > directory, which means passing directory header data or whatever
> > > that
> > > it
> > > stores in if_data back to pick_link(), which is then further
> > > processed
> > > as a string.
> > 
> > This is the sort of feedback I was hoping for.
> > 
> > This sounds related to the life-cycle of xfs inodes and re-use.
> > Hopefully someone here on the list can enlighten me on this.
> > 
> > The thing that comes to mind is that the inode re-use would
> > need to occur between the VFS check that validates the inode
> > is still ok and the use of link string. I think that can still
> > go away even with the above check.
> > 
> 
> Yeah... The original NULL ->get_link() problem was replicated with a
> small delay in the lookup path (specifically in the symlink
> processing
> path). This essentially widens the race window and allows a separate
> task to invalidate the dentry between the time the last dentry
> sequence
> validation occurred (and passed) and the attempt to call ->get_link()
> becomes imminent. I think patch 1 largely addresses this issue
> because
> we'll have revalidated the previous read of the function pointer
> before
> we attempt to call it.
> 
> That leads to this patch, which suggests that even after the
> validation
> fix a small race window still technically exists with the -
> >get_link()
> code and inode teardown. In fact, it's not that hard to show that
> this
> is true by modifying the original reproducer to push the delay out
> beyond the check added by patch 1 (or into the ->get_link()
> callback).
> Playing around with that a bit, it's possible to induce a -
> >get_link()
> call to an inode that was reallocated as a shortform directory and
> returns a non-NULL if_data fork of that dir back to the vfs (to be
> interpreted as a symlink string). Nothing seems to explode on my
> quick
> test, fortunately, but I don't think that's an interaction we want to
> maintain.
> 
> Of course one caveat to all of that is that after patch 1, the race
> window for that one might be so small as to make this impossible to
> reproduce in practice (whereas the problem fixed by patch 1 has been
> reproduced by users)...
> 
> > Hopefully someone can clarify what happens here.
> > 
> > > 
> > > With that, I wonder why we wouldn't just return -ECHILD here like
> > > we
> > > do
> > > for the non-inline case to address the immediate problem, and
> > > then
> > > perhaps separately consider if we can rework bits of the
> > > reuse/reclaim
> > > code to allow rcu lookup of inline symlinks under certain
> > > conditions.
> > 
> > Always switching to ref-walk mode would certainly resolve the
> > problem too, yes, perhaps we have no choice ...
> > 
> 
> Oh I don't think it's the only choice. I think Miklos' suggestion to
> use
> ->free_inode() is probably the right general approach. I just think a
> switch to ref-walk mode might be a good incremental step to fix this
> problem in a backportable way (s_op->free_inode() is newer relative
> to
> the introduction of _get_link_inline()). We can always re-enable rcu
> symlink processing once we get our inode teardown/reuse bits fixed up
> accordingly.. Just my .02.

Yes, I've had a change of heart on this too.

I think returning -ECHILD from xfs_vn_get_link_inline() is the
best solution.

There are a couple of reasons for that, the main one being the
link string can still go away while the VFS is using it, but
also Al has said more than once that switching to ref-walk mode
is not a big deal and that makes the problems vanish completely.
In any case references are taken at successful walk completion
anyway.

If it's found staying rcu-walk mode whenever possible is worth
while in cases like this then there's probably a lot more to do
to do this properly. The lockless stuff is tricky and error prone
(certainly it is for me) and side effects are almost always hiding
in unexpected places.

So as you say, that's something for another day.
I'll update the patch and post an update.

Ian 
> 
> Brian
> 
> > Ian
> > > 
> > > FWIW, I'm also a little curious why we don't set i_link for
> > > inline
> > > symlinks. I don't think that addresses this validation problem,
> > > but
> > > perhaps might allow rcu lookups in the inline symlink common case
> > > where
> > > things don't change during the lookup (and maybe even eliminate
> > > the
> > > need
> > > for this custom inline callback)..?
> > > 
> > > Brian
> > > 
> > > >         if (XFS_IS_CORRUPT(ip->i_mount, !link))
> > > >                 return ERR_PTR(-EFSCORRUPTED);
> > > > +
> > > >         return link;
> > > >  }
> > > >  
> > > > 
> > > > 
> > > 
> > 
> > 
> 


