Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0DBAF920
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfIKJjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 05:39:32 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:43853 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbfIKJjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:39:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 80E0B614;
        Wed, 11 Sep 2019 05:39:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 11 Sep 2019 05:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mvzKeifSnTSILTn0qraq+rN4Cry
        GTOsIEYJQEQ6OnYg=; b=mtiyobYXM4j9EFSIKWpelWpgZOm+amyEdDeS0EUXrQI
        Dr0Gjx7szmVtnduulUVe3O6G9B/UhKhaeTGAU24JR8WcsrwcdUfodTMHaj+pj++b
        JxqwoCNsMr4xy3pxI6ewV6CcL2UbOFSEBRgxQv90tZqs6Bqln4/D7Zl8jXpyjki3
        iZIaoGsBbkcWJbdo/wlOnO+k2OrkprPrRM6TZqlqvKNeUrC0X4GIV7fwr0LYlkrB
        eybjaBdLKN4LXUJQY6nhVPvF0cP0VOACC1LgVeII6B0YqSvVFgwsfqvh0Vy1/Hr+
        qiTFfwY4QjLy3hkLKplwva/42/wK9CCTaZ2r/cLROTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mvzKei
        fSnTSILTn0qraq+rN4CryGTOsIEYJQEQ6OnYg=; b=k5SckXFxB6PoUTEitBhdke
        SomEjIEWYKhC9eJGnnHcLsihzDA6TTEPgFNZxqdrbW0LQ7g5IJVRoLT0nHfSMunH
        YHB0yZzjViLeZXMx7HVyNyK3QD0LvjInmNX0KJ0Y1MjRL5HBkNu0sd28Kwq3aJC6
        ReUfbuvPshNdoCpzAeh7zV/O61lWLHUtx1Jw+7NKlda7PE/brwHXFG4jUooiHJAm
        wGaBut55D2tCZ/ky0okQNzJZXVSDO/ENtn4Edn+rrxQLp8miV4T8a0xqvLOtsuc3
        0Q9IRtnvSHs106V5mK+ujB3P2U0jwcs4EiKqX/T8Bv1yC3VpqLr0f4AEHLqoDj4g
        ==
X-ME-Sender: <xms:0MB4XcggKqjOEYVJZd9qevP_wUbxPncN_tBAWi6-Fg0PqZClExk1ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtddvgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecukfhppeduge
    ekrdeiledrkeehrdefkeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegr
    nhgrrhgriigvlhdruggvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:0MB4XRpJpoY7c-KRT-ghH_eG4kEn_6fgDEkd0OK8br23501TAjiBSw>
    <xmx:0MB4XVGmwottXAZ-O2b07rrASsS8h2xpuOWgU6TE044_p6rIXVcopA>
    <xmx:0MB4XZPdbMNAKKH1rn1JYLUGjXKSbhslMId2-QvU1f7ug0CD0uthzQ>
    <xmx:0cB4XfDWFcyGBy2d-xOSQdZbxxMjaKqwUXHgqpQHGNcAAkWhylQ-MA>
Received: from intern.anarazel.de (unknown [148.69.85.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2563CD60062;
        Wed, 11 Sep 2019 05:39:28 -0400 (EDT)
Date:   Wed, 11 Sep 2019 02:39:26 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Dave Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: Odd locking pattern introduced as part of "nowait aio support"
Message-ID: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
References: <20190910223327.mnegfoggopwqqy33@alap3.anarazel.de>
 <20190911040420.GB27547@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911040420.GB27547@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2019-09-11 14:04:20 +1000, Dave Chinner wrote:
> On Tue, Sep 10, 2019 at 03:33:27PM -0700, Andres Freund wrote:
> > Hi,
> > 
> > Especially with buffered io it's fairly easy to hit contention on the
> > inode lock, during writes. With something like io_uring, it's even
> > easier, because it currently (but see [1]) farms out buffered writes to
> > workers, which then can easily contend on the inode lock, even if only
> > one process submits writes.  But I've seen it in plenty other cases too.
> > 
> > Looking at the code I noticed that several parts of the "nowait aio
> > support" (cf 728fbc0e10b7f3) series introduced code like:
> > 
> > static ssize_t
> > ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > {
> > ...
> > 	if (!inode_trylock(inode)) {
> > 		if (iocb->ki_flags & IOCB_NOWAIT)
> > 			return -EAGAIN;
> > 		inode_lock(inode);
> > 	}
> 
> The ext4 code is just buggy here - we don't support RWF_NOWAIT on
> buffered writes.

But both buffered and non-buffered writes go through
ext4_file_write_iter(). And there's a preceding check, at least these
days, preventing IOCB_NOWAIT to apply to buffered writes:

	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
		return -EOPNOTSUPP;


I do really wish buffered NOWAIT was supported... The overhead of having
to do async buffered writes through the workqueue in io_uring, even if
an already existing page is targeted, is quite noticable. Even if it
failed with EAGAIN as soon as the buffered write's target isn't in the
page cache, it'd be worthwhile.


> > isn't trylocking and then locking in a blocking fashion an inefficient
> > pattern? I.e. I think this should be
> > 
> > 	if (iocb->ki_flags & IOCB_NOWAIT) {
> > 		if (!inode_trylock(inode))
> > 			return -EAGAIN;
> > 	}
> >         else
> >         	inode_lock(inode);
> 
> Yes, you are right.
> 
> History: commit 91f9943e1c7b ("fs: support RWF_NOWAIT
> for buffered reads") which introduced the first locking pattern
> you describe in XFS.

Seems, as part of the nowait work, the pattern was introduced in ext4,
xfs and btrfs. And fixed in xfs.


> That was followed soon after by:
> 
> commit 942491c9e6d631c012f3c4ea8e7777b0b02edeab
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Oct 23 18:31:50 2017 -0700
> 
>     xfs: fix AIM7 regression
>     
>     Apparently our current rwsem code doesn't like doing the trylock, then
>     lock for real scheme.  So change our read/write methods to just do the
>     trylock for the RWF_NOWAIT case.  This fixes a ~25% regression in
>     AIM7.
>     
>     Fixes: 91f9943e ("fs: support RWF_NOWAIT for buffered reads")
>     Reported-by: kernel test robot <xiaolong.ye@intel.com>
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
>     Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Which changed all the trylock/eagain/lock patterns to the second
> form you quote. None of the other filesystems had AIM7 regressions
> reported against them, so nobody changed them....

:(


> > Obviously this isn't going to improve scalability to a very significant
> > degree. But not unnecessarily doing two atomic ops on a contended lock
> > can't hurt scalability either. Also, the current code just seems
> > confusing.
> > 
> > Am I missing something?
> 
> Just that the sort of performance regression testing that uncovers
> this sort of thing isn't widely done, and most filesystems are
> concurrency limited in some way before they hit inode lock
> scalability issues. Hence filesystem concurrency foccussed
> benchmarks that could uncover it (like aim7) won't because the inode
> locks don't end up stressed enough to make a difference to
> benchmark performance.

Ok.  Goldwyn, do you want to write a patch, or do you want me to write
one up?


Greetings,

Andres Freund
