Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C3B2F0E67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 09:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbhAKInO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 03:43:14 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:60243 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728025AbhAKInN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:43:13 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AC7CA2553;
        Mon, 11 Jan 2021 03:42:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 11 Jan 2021 03:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        9JEwuLfvTioeURWKNd+C45ZSiM7Ca0SztZo3zOefeW8=; b=J4fABZOznYk7wsm5
        nrsHJjBy1vAIp/JPLpVyVM5mCFueSNK2owlJK35QWpPv2DPEyMUp82SknAc06Qx/
        DjSkWSQO/xwiFUgoWXQkKGhLwvoVhtmw9yS3vgWrw7BpqKD3WNcoqKJzJshFMUjT
        5YxByrCvM1+ozTrafFyosobTNf8C6Ei3HIpVRsSUoMlMS6GvYkgM/SfsYqT4UFd9
        TjpYvua90kYoUS1PNgwJ1HMk4Ev/PrmpUI8www/AHeQy1H/pLkrEGFOFihRLEpAB
        ETfz5VO6UOo/rSsV782UaU+UIsWqIp6Ss+j8HhZLk7wcO949dH38iAaWZfRqU/Zi
        IR39Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=9JEwuLfvTioeURWKNd+C45ZSiM7Ca0SztZo3zOefe
        W8=; b=Bu8ZHiXPlm4GAs+KTzAemRJtY27MqUxU5iyWx2BavBKVnIz0g3SkH4yQm
        awUlk+4sq42taBx5UoeuKdZvghsRbHPK4Tvs8RHh+oI03cLTBo0wvWEpQ2J9bfT/
        tWtzZh1ajOgdblp3yfXRbIAsaKk2gPAxxzCJN0qD0GX2yOl0cTIz3NCKrBX+AonA
        yuJLRA1ywUubDwTeWVm0VfeNvcqRraECQJcrcKEZkr/AmikF/F3tGhYvAykLRQfL
        uqXNS+nqtg7p2hNDEjBVRKAQcsF/CybD++T7Mc1ddVwdbm0FskHBHyOmOadQQoao
        tcsnYZuQugMnKGi1XeUlnCv/SaSVw==
X-ME-Sender: <xms:cg_8Xwyqq6bTudOblU8ZFDJv9z1xzsNwym6B2DyErZYuV-CwOUISHw>
    <xme:cg_8X0RL5KSdopOMeFJ7ymL85ndklGbFPkOUuzVzcsjS4HJwdAcU96sXpfmPgpNRF
    3fI39gWp92Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epieekgeeguedvvefgfeeihfdukeekgeehieeljeevteehudetvdevheduffejvedunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvuddrgeegrddufedurddvfe
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghv
    vghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:cg_8XyV846Ir_WhMeeTyB9GYn3QLx0lOCUBPcNIGka7f_wLq6SXpjg>
    <xmx:cg_8X-iFZIlXl1s9BjJmyPDjnv4hgeSvUV5HZ6vXf7Ns8ul4Qfs_ug>
    <xmx:cg_8XyA4P66oIw0F_Rnzz2mOpov7zxBFc4BhxkB7a2M67aZmhBIp2g>
    <xmx:cw_8X19Cgxpe6DFG4SdN9qUVNavI9lEsu4UkjI2GndJ_hLG0_Y00OA>
Received: from mickey.themaw.net (unknown [121.44.131.23])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A9F2240057;
        Mon, 11 Jan 2021 03:42:22 -0500 (EST)
Message-ID: <aa193477213228daf85acdae7c31e1bfff3d694c.camel@themaw.net>
Subject: Re: [PATCH 0/6] kernfs: proposed locking and concurrency improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 11 Jan 2021 16:42:19 +0800
In-Reply-To: <CAC2o3D+W70pzEd0MQ1Osxnin=j2mxwH4KdAYwR1mB67LyLbf5Q@mail.gmail.com>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
         <CAC2o3DJqK0ECrRnO0oArgHV=_S7o35UzfP4DSSXZLJmtLbvrKg@mail.gmail.com>
         <04675888088a088146e3ca00ca53099c95fbbad7.camel@themaw.net>
         <CAC2o3D+qsH3suFk4ZX9jbSOy3WbMHdb9j6dWUhWuvt1RdLOODA@mail.gmail.com>
         <75de66869bd584903055996fb0e0bab2b57acd68.camel@themaw.net>
         <42efbb86327c2f5a8378d734edc231e3c5a34053.camel@themaw.net>
         <CAC2o3D+W70pzEd0MQ1Osxnin=j2mxwH4KdAYwR1mB67LyLbf5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-01-11 at 15:04 +0800, Fox Chen wrote:
> On Mon, Jan 11, 2021 at 12:20 PM Ian Kent <raven@themaw.net> wrote:
> > On Mon, 2021-01-11 at 11:19 +0800, Ian Kent wrote:
> > > On Wed, 2021-01-06 at 10:38 +0800, Fox Chen wrote:
> > > > Hi Ian,
> > > > 
> > > > I am rethinking this problem. Can we simply use a global lock?
> > > > 
> > > >  In your original patch 5, you have a global mutex attr_mutex
> > > > to
> > > > protect attr, if we change it to a rwsem, is it enough to
> > > > protect
> > > > both
> > > > inode and attr while having the concurrent read ability?
> > > > 
> > > > like this patch I submitted. ( clearly, I missed
> > > > __kernfs_iattrs
> > > > part,
> > > > but just about that idea )
> > > > https://lore.kernel.org/lkml/20201207084333.179132-1-foxhlchen@gmail.com/
> > > 
> > > I don't think so.
> > > 
> > > kernfs_refresh_inode() writes to the inode so taking a read lock
> > > will allow multiple processes to concurrently update it which is
> > > what we need to avoid.
> 
> Oh, got it. I missed the inode part. my bad. :(
> 
> > > It's possibly even more interesting.
> > > 
> > > For example, kernfs_iop_rmdir() and kernfs_iop_mkdir() might
> > > alter
> > > the inode link count (I don't know if that would be the sort of
> > > thing
> > > they would do but kernfs can't possibly know either). Both of
> > > these
> > > functions rely on the VFS locking for exclusion but the inode
> > > link
> > > count is updated in kernfs_refresh_inode() too.
> > > 
> > > That's the case now, without any patches.
> > 
> > So it's not so easy to get the inode from just the kernfs object
> > so these probably aren't a problem ...
> 
> IIUC only when dop->revalidate, iop->lookup being called, the result
> of rmdir/mkdir will be sync with vfs.

Don't quite get what you mean here?

Do you mean something like, VFS objects are created on user access
to the file system. Given that user access generally means path
resolution possibly followed by some operation.

I guess those VFS objects will go away some time after the access
but even thought the code looks like that should happen pretty
quickly after I've observed that these objects stay around longer
than expected. There wouldn't be any use in maintaining a least
recently used list of dentry candidates eligible to discard.

> 
> kernfs_node is detached from vfs inode/dentry to save ram.
> 
> > > I'm not entirely sure what's going on in kernfs_refresh_inode().
> > > 
> > > It could be as simple as being called with a NULL inode because
> > > the dentry concerned is negative at that point. I haven't had
> > > time to look closely at it TBH but I have been thinking about it.
> 
> um, It shouldn't be called with a NULL inode, right?
> 
> inode->i_mode = kn->mode;
> 
> otherwise will crash.

Yes, you're right about that.

> 
> > Certainly this can be called without a struct iattr having been
> > allocated ... and given it probably needs to remain a pointer
> > rather than embedded in the node the inode link count update
> > can't easily be protected from concurrent updates.
> > 
> > If it was ok to do the allocation at inode creation the problem
> > becomes much simpler to resolve but I thought there were concerns
> > about ram consumption (although I don't think that was exactly what
> > was said?).
> > 
> 
> you meant iattr to be allocated at inode creation time??
> yes, I think so. it's due to ram consumption.

I did, yes.

The actual problem is dealing with multiple concurrent updates to
the inode link count, the rest can work.

Ian

