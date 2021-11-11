Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E6644DE5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 00:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhKKXNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 18:13:19 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42595 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234490AbhKKXNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 18:13:16 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1FD595C03EF;
        Thu, 11 Nov 2021 18:10:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 11 Nov 2021 18:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        0LqIWS4O3DydITXetq+WKFIgCf1rSBSnps7r+v5iadY=; b=g9VpwIem8STql5vD
        rOtE3ZlRbK8bEqz6UePDD+0MFK9hqMBSTOKs81XirJGroiBkxfXXZyV+YpcA3bj8
        1bZwIIFdKQcKBRqSWmWyKE1X/1ZSJW0T2uaH0zzvaG+ng2OJeTje8CPmS0xHAWNE
        aM5eBiMmtpbIm8UUBjP2BZhyawvqoynxgrl4zlpGQ8o1KZQdtf2pu8CftoX/csA0
        QZ2cusxLv2nqJKnKcgJf2R90IEFYA7pazoAwrertjKklWjIBUS3muUVz+7o9OlAh
        MApG6Ly1xpfKP048JWbuXY+QD1WMApzZiGnmf/pTrYJVVX2KztY2bQ8RfkZPz5vY
        ktkd7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=0LqIWS4O3DydITXetq+WKFIgCf1rSBSnps7r+v5ia
        dY=; b=iP/pMnkfKUDEij8anwOL+8Wha+C7a5o8898KQFETITOiiQWPyvRtNY7U6
        uc6x1Ag/5i6BFegfaxCiQ9YYgjIdIqzxWrC0oPC2DygwuMUVetMI7v352sJ94+RZ
        fO3i+0DorqlFXD+49ididtxthApNjV1zfD/+lHt9BxQt9DJB4xy1Dy1jgrRuuT6l
        8InGtNsEa0ofYz3qCBNxHy/iBawVXoAlbb9Dt/8rlcZgniAwnamG8/2Bxwt8sV2v
        FZkWTeQLvnOuGqwkXHdAS0XiiVonk5eP8awhK2hNJBpVxd3KV6Yr0iDdfDGhgOyM
        DyQv4G2CbB0lRuJuxtmWBTllAgo4Q==
X-ME-Sender: <xms:4aKNYdKM1wpwLi79nXcKihl2f968Hjm9pk4vv-vB8wUuj4_RuYC7dg>
    <xme:4aKNYZK92XsBcIeYiiTycnM3d_lo9p5VraqI97H44Zr0GwsLG2TSeAtaltqDsnCyI
    r6zPlKasEHW>
X-ME-Received: <xmr:4aKNYVs7_7ESaKB11C0H7OcqKvvG2zB-dttdayzbzssu7UflAgMWrNRJJl0Lpfnd0wkw6Ho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvddvgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepgf
    elleekteehleegheeujeeuudfhueffgfelhefgvedthefhhffhhfdtudfgfeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:4aKNYeZzx_8vcL8cYx8JOVmb1dAAudr_G51Xyrvkr5zSGmhjWAUdng>
    <xmx:4aKNYUbBWKLuD6Z1ejgLTwBo0nw12H5BVyA4NPdkhKDzdmw05b7IRw>
    <xmx:4aKNYSDL3T7ViwmqHQzfQlzq2NHdwbJxAq10-Tb8xkWTrK9T1AtZHA>
    <xmx:4qKNYTyAP6exPbj4tCwe9kDuZ6DT9huTCf5glPhZYb9xVAUbrP9cpA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Nov 2021 18:10:22 -0500 (EST)
Message-ID: <ed30a482ce8404de7974bc86b4c9fc98a5ae9060.camel@themaw.net>
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
Date:   Fri, 12 Nov 2021 07:10:19 +0800
In-Reply-To: <YY1AEaHRLe+P4IYr@bfoster>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
         <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
         <YY1AEaHRLe+P4IYr@bfoster>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-11-11 at 11:08 -0500, Brian Foster wrote:

Hi Brian,

> On Thu, Nov 11, 2021 at 11:39:30AM +0800, Ian Kent wrote:
> > When following a trailing symlink in rcu-walk mode it's possible to
> > succeed in getting the ->get_link() method pointer but the link
> > path
> > string be deallocated while it's being used.
> > 
> > Utilize the rcu mechanism to mitigate this risk.
> > 
> > Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/xfs/kmem.h      |    4 ++++
> >  fs/xfs/xfs_inode.c |    4 ++--
> >  fs/xfs/xfs_iops.c  |   10 ++++++++--
> >  3 files changed, 14 insertions(+), 4 deletions(-)
> > 
> ...
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index a607d6aca5c4..2977e19da7b7 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -524,11 +524,17 @@ xfs_vn_get_link_inline(
> >  
> >         /*
> >          * The VFS crashes on a NULL pointer, so return -
> > EFSCORRUPTED if
> > -        * if_data is junk.
> > +        * if_data is junk. Also, if the path walk is in rcu-walk
> > mode
> > +        * and the inode link path has gone away due inode re-use
> > we have
> > +        * no choice but to tell the VFS to redo the lookup.
> >          */
> > -       link = ip->i_df.if_u1.if_data;
> > +       link = rcu_dereference(ip->i_df.if_u1.if_data);
> > +       if (!dentry && !link)
> > +               return ERR_PTR(-ECHILD);
> > +
> 
> One thing that concerns me slightly about this approach is that inode
> reuse does not necessarily guarantee that if_data is NULL. It seems
> technically just as possible (even if exceedingly unlikely) for link
> to
> point at newly allocated memory since the previous sequence count
> validation check. The inode could be reused as another inline symlink
> for example, though it's not clear to me if that is really a problem
> for
> the vfs (assuming a restart would just land on the new link
> anyways?).
> But the inode could also be reallocated as something like a shortform
> directory, which means passing directory header data or whatever that
> it
> stores in if_data back to pick_link(), which is then further
> processed
> as a string.

This is the sort of feedback I was hoping for.

This sounds related to the life-cycle of xfs inodes and re-use.
Hopefully someone here on the list can enlighten me on this.

The thing that comes to mind is that the inode re-use would
need to occur between the VFS check that validates the inode
is still ok and the use of link string. I think that can still
go away even with the above check.

Hopefully someone can clarify what happens here.

> 
> With that, I wonder why we wouldn't just return -ECHILD here like we
> do
> for the non-inline case to address the immediate problem, and then
> perhaps separately consider if we can rework bits of the
> reuse/reclaim
> code to allow rcu lookup of inline symlinks under certain conditions.

Always switching to ref-walk mode would certainly resolve the
problem too, yes, perhaps we have no choice ...

Ian
> 
> FWIW, I'm also a little curious why we don't set i_link for inline
> symlinks. I don't think that addresses this validation problem, but
> perhaps might allow rcu lookups in the inline symlink common case
> where
> things don't change during the lookup (and maybe even eliminate the
> need
> for this custom inline callback)..?
> 
> Brian
> 
> >         if (XFS_IS_CORRUPT(ip->i_mount, !link))
> >                 return ERR_PTR(-EFSCORRUPTED);
> > +
> >         return link;
> >  }
> >  
> > 
> > 
> 


