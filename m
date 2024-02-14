Return-Path: <linux-fsdevel+bounces-11570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B30854D5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E3C28B242
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE875EE76;
	Wed, 14 Feb 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="oJgKmevx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A125C615;
	Wed, 14 Feb 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925893; cv=none; b=EpM/6hQ6m+BDddHDOepKmlcY+/aNo0PgSpDk1PpibvPV5prI1rigGSu00cxkxuOIVF2aWw1OusZ5IB9Crr/UmQJFDvsUKZQqFbG2gZC977Leto7AxqutQ7TQG3JGOUxec7JDcKkQgpQWQuTDn6gCab5Vszh00ZS/EvJZX7iBX9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925893; c=relaxed/simple;
	bh=bRaUsM+Uzf09nnHuj5/m679j6WW4bIQ9LC1jJ0hClJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO/uX8IJGXNg+BxwTri+7dMySgXLrw8wsGkbVK2ramTJ2IU0HhCsZsvbryzAwaSBJfXQ6pVvIPs7yyjCAFoocNM7oU8vL03BTceqYBpUBwo2sVA5zc+q8eIX4VkM4gWXVguiwskYq/xXf7gqwRYTpB/GmmDWb5JrW02RuZW7FwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=oJgKmevx; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TZjNZ5Zyjz9sZZ;
	Wed, 14 Feb 2024 16:51:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707925886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uvRxRUirHGWYGjoW5odKQxfL8aAW2NExn/9k0sqlsuY=;
	b=oJgKmevxuE6YOihKJil5WtpmnnL/lRWqZVwijXduz8jb+QWVrPdGzO5ngbvtLp+WXXMwEu
	NpxC3Zfg1ABJsNEgxncesLhI3dWYoLPhegT8D/FHjc3+5TquElV7jzzw7sbvfcFO9OBe7X
	XqIpdaIRlR0PpWsIvJdQNn7UoDyuwXzAb1UQVeaEd5qwdvlTDZ0EDjNKBLu9ihP8I/3U/T
	mQVY7dtXXTAOVF2omkKDbwIwT/aFGM6shr7XuPd8qSj7gjae7cQ12mvGH2ERjRTON5+wW7
	VJSCo+ClN6RbgWei3lr/BJZsL2aXFWMQRiv38m7CnG0YyKXz4yYflriN8N8VrQ==
Date: Wed, 14 Feb 2024 16:51:22 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com, 
	akpm@linux-foundation.org, kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 12/14] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <2h5ikaxcij2rpekaenf2fnlh4dquwpnkjy7eaqfwk75tbkkmuw@ehbfsjjumgdp>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-13-kernel@pankajraghav.com>
 <20240213162611.GP6184@frogsfrogsfrogs>
 <loupixsa7jfjuhry2vm7o6j4k3qsdq6yvupcrbbum2m3hpuxau@5n72zpj5vrjh>
 <Zcvw1rrE4CiVzkmc@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcvw1rrE4CiVzkmc@dread.disaster.area>

> > I was thinking of possibility of an overflow but at the moment the 
> > blocklog is capped at 16 (65536 bytes) right? mkfs refuses any block
> > sizes more than 64k. And we have check for this in xfs_validate_sb_common()
> > in the kernel, which will catch it before this happens?
> 
> The sb_blocklog is checked in the superblock verifier when we first read in the
> superblock:
> 
> 	    sbp->sb_blocksize < XFS_MIN_BLOCKSIZE                       ||
>             sbp->sb_blocksize > XFS_MAX_BLOCKSIZE                       ||
>             sbp->sb_blocklog < XFS_MIN_BLOCKSIZE_LOG                    ||
>             sbp->sb_blocklog > XFS_MAX_BLOCKSIZE_LOG                    ||
>             sbp->sb_blocksize != (1 << sbp->sb_blocklog)                ||
> 
> #define XFS_MAX_BLOCKSIZE_LOG 16
> 
> However, we pass mp->m_sb.sb_dblocks or m_sb.sb_rblocks to this
> function, and they are validated by the same verifier as invalid
> if:
> 
> 	    sbp->sb_dblocks > XFS_MAX_DBLOCKS(sbp)
> 
> #define XFS_MAX_DBLOCKS(s) ((xfs_rfsblock_t)(s)->sb_agcount *
>                                              (s)->sb_agblocks)
> 
> Which means as long as someone can corrupt some combination of
> sb_dblocks, sb_agcount and sb_agblocks that allows sb_dblocks to be
> greater than 2^48 on a 64kB fsb fs, then that the above code:
> 
> 	uint64_t bytes = nblocks << sbp->sb_blocklog;
> 
> will overflow.
> 
> I also suspect that we can feed a huge rtdev to this new code
> and have it overflow without needing to corrupt the superblock in
> any way....

So we could use the check_mul_overflow to detect these cases:

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 596aa2cdefbc..23faa993fb80 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -132,8 +132,12 @@ xfs_sb_validate_fsb_count(
        uint64_t        nblocks)
 {
        ASSERT(sbp->sb_blocklog >= BBSHIFT);
-       unsigned long mapping_count;
-       uint64_t bytes = nblocks << sbp->sb_blocklog;
+       uint64_t mapping_count;
+       uint64_t bytes;
+
+       if (check_mul_overflow(nblocks, (1 << sbp->sb_blocklog), &bytes))
+               return -EFBIG;
 
        if (!IS_ENABLED(CONFIG_XFS_LBS))
                ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

