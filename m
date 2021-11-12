Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB044DFB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 02:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhKLB3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 20:29:12 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:47677 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233817AbhKLB3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 20:29:11 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E8FA13201FAA;
        Thu, 11 Nov 2021 20:26:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Nov 2021 20:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        C6DIL1g4ocp+GSZWoR5IeaYCSZ+yaLz2mMkIgIsKz8c=; b=A5E6eafq3NSM05uU
        /gfKXpW/x2uHebzko+yqgzpYrRzzXVbNPFxuyLh7b2qSScXxLUdyhM/K7iUf2iWq
        nBL3KwC8GmjmDWRFWHxEW32U3/ydLbVKEwbsgOmOAwfrwl//ckF8VxL1FLZj2IG2
        vEw/kBMDRCCFihQBdHWJTh8dxVsXMb3flSNo5ujlFDg6WrQmifgIB1oWT7JSIVy8
        InySUALgINCiI91DqS4Z/J1FO+rcEo6huVmBK89F/K9hlErvs9+FVQCnddlxEC63
        sPJff88P2fSTNTO6XzMIl/q3YoaCMg+DeuyTHniO61+fTPI9p6+lpBlrvxWUQdpP
        SbDCOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=C6DIL1g4ocp+GSZWoR5IeaYCSZ+yaLz2mMkIgIsKz
        8c=; b=EVJsqCPemi4p0KJJing/TRfJIkpiIo0sVZfrCORVR3x2hxeFx2N3NEmf9
        F8ujuAgL8jAP+hvBgp3DM6gHrO9WlBy6JU6pEAgRWfG5k9FXWKr1rR0X7u1uAbEh
        z0WX/lrzEQNoYuYi72JNn9cUXbVb6YUF+LIXNfB7yDxTQNm7nsQ/WVdYIHX2tw4e
        6iX+10AcMm5dWEpfFpZCC65Tg/OWep1vAVmHeZctORUp40e+aXa+dHavV8jVITtw
        N3rsVoOeQd4OSvq7HINEizhc0UFtR717G5cvDBEvEC0p55tFzqTYP60taYzfhJci
        fiCRBWQk+8268nZTq5eYLEqzrHLcA==
X-ME-Sender: <xms:vMKNYVMTDnlHM1BhHplPBt9CTwreqA2B7tjLYypyA_S5SD2Gy7lasQ>
    <xme:vMKNYX_o1ELILZ059MjoQ4D06SYM1Md2wepYFsOoeisI2ZFSqpCmvKcj9VIa__GUB
    opwqxtcNetI>
X-ME-Received: <xmr:vMKNYURw_StqwuoG5PEZuOU0kWw30o1F6ZUYm7N46EU4FoLSQbL5Ak8p8ilagtu_1lQ4knU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvddvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepgf
    elleekteehleegheeujeeuudfhueffgfelhefgvedthefhhffhhfdtudfgfeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:vMKNYRtRWSn0AYH1aAXcwXYqqaO9sOCci_zbZhaFMXUCa7GUqC18wQ>
    <xmx:vMKNYdeODUXzIxGh0GJhFXkBN9ZDCKKP6gzrmdri8HYnXplfZD4I3A>
    <xmx:vMKNYd2XNTZO2Ixfb8ilU28vfu5kfu9qE31dP8iN4MICa2Phhz7G7w>
    <xmx:vMKNYVTzwmV5aRFT0Qs-RJRy1R14YMjgLgpNxUnZImXcEU8AAa63gA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Nov 2021 20:26:16 -0500 (EST)
Message-ID: <d4fa793505fe264295152950fa31a915d2ba0384.camel@themaw.net>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
From:   Ian Kent <raven@themaw.net>
To:     Dave Chinner <david@fromorbit.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Nov 2021 09:26:11 +0800
In-Reply-To: <20211112003249.GL449541@dread.disaster.area>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
         <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
         <20211112003249.GL449541@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-11-12 at 11:32 +1100, Dave Chinner wrote:
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
> > diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
> > index 54da6d717a06..c1bd1103b340 100644
> > --- a/fs/xfs/kmem.h
> > +++ b/fs/xfs/kmem.h
> > @@ -61,6 +61,10 @@ static inline void  kmem_free(const void *ptr)
> >  {
> >         kvfree(ptr);
> >  }
> > +static inline void  kmem_free_rcu(const void *ptr)
> > +{
> > +       kvfree_rcu(ptr);
> > +}
> >  
> >  
> >  static inline void *
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index a4f6f034fb81..aaa1911e61ed 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -2650,8 +2650,8 @@ xfs_ifree(
> >          * already been freed by xfs_attr_inactive.
> >          */
> >         if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
> > -               kmem_free(ip->i_df.if_u1.if_data);
> > -               ip->i_df.if_u1.if_data = NULL;
> > +               kmem_free_rcu(ip->i_df.if_u1.if_data);
> > +               RCU_INIT_POINTER(ip->i_df.if_u1.if_data, NULL);
> >                 ip->i_df.if_bytes = 0;
> >         }
> 
> How do we get here in a way that the VFS will walk into this inode
> during a lookup?
> 
> I mean, the dentry has to be validated and held during the RCU path
> walk, so if we are running a transaction to mark the inode as free
> here it has already been unlinked and the dentry turned
> negative. So anything that is doing a lockless pathwalk onto that
> dentry *should* see that it is a negative dentry at this point and
> hence nothing should be walking any further or trying to access the
> link that was shared from ->get_link().
> 
> AFAICT, that's what the sequence check bug you fixed in the previous
> patch guarantees. It makes no difference if the unlinked inode has
> been recycled or not, the lookup race condition is the same in that
> the inode has gone through ->destroy_inode and is now owned by the
> filesystem and not the VFS.

That's right.

The concern is that the process that's doing the release is different
so ->destroy_inode() can be called at "any" time during an rcu-mode
walk (since its not holding references). Like just after the sequence
check and ->get_link() pointer read racing with a concurrent unlink
of the symlink.

The race window must be very small indeed but I thought it was
possible.

Your right, the first question to answer is whether this is in fact
needed at all.

Ian
> 
> Otherwise, it might just be best to memset the buffer to zero here
> rather than free it, and leave it to be freed when the inode is
> freed from the RCU callback in xfs_inode_free_callback() as per
> normal.
> 
> Cheers,
> 
> Dave.


