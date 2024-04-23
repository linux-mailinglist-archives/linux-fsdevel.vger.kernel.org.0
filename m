Return-Path: <linux-fsdevel+bounces-17571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A668AFCFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 01:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21FC0B24972
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 23:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF5524B1;
	Tue, 23 Apr 2024 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxHRbGw3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47A44C89;
	Tue, 23 Apr 2024 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916710; cv=none; b=i6dN5rXK4qSNB60FD1Q4qWxtVPTZ5UcFGh7aU1tTJa1noRGH9RnPwWFKLPEDPzSGxmDNvWBQfXWc286wOPVJN77As/2J7BgobgEKDXsNKXfHsOk7iTHs3xLwSEG9PV/XyF0RWkmdzecaA/r7rnlpkk4On+omeRkJzL2REbDVdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916710; c=relaxed/simple;
	bh=3/Rx6u7DXGhpElwgLl6iYyBIIp761cKdsL6QZg3T8v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMIMkChfUO+uk6RdWsTbfbELiByJMOFz1nRLdi3mzZIibq0x6zxQLHEF20rEmBOTcr+ctL0LABLT8Y2FxhANE5eTsRsUhq00KgPIrXf++9xLfgRNTiMGh1sfDee9LYQNv+nZY8+RfQq1H91WWOuh+7hxi2vE0TFET3TyMXp5lEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxHRbGw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FACC3277B;
	Tue, 23 Apr 2024 23:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713916710;
	bh=3/Rx6u7DXGhpElwgLl6iYyBIIp761cKdsL6QZg3T8v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxHRbGw3e//ENDtVi5225pu+R/64GVdFF/6d43GQ5IljWDUzNBAZXa8rnOQOXcYAS
	 ATxmwn2qhQnVRhGFetpAplK0IuPEBxhzk11WHmwMCQIXCcnfM/PGK2OnKp/h2IjQVe
	 LXmHcaRJwtMqrVxghZlWNhb/1vKrfsVBvmGwPJp1HOh8Wppzbv/8dUr2fE9TuFUo5W
	 BmGb5lOuLUh0SkCwY9+00ezI7IOhS3NyQiJPczpZ+F+km7HYJr+zQ7xMP2jiiUCM+O
	 hzIkipr6Md7arRci1N3BT9U5VF+cgfM+fzJ7dWqojwovS/X06+6rci+2aZYVzRzNtZ
	 1oztpIFwNFNGA==
Date: Tue, 23 Apr 2024 16:58:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Chandan Babu R <chandanbabu@kernel.org>, dchinner@redhat.com,
	hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 6a94b1acda7e
Message-ID: <20240423235829.GA360919@frogsfrogsfrogs>
References: <87bk60z8lm.fsf@debian-BULLSEYE-live-builder-AMD64>
 <Zig6A632L9PDK6Qp@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zig6A632L9PDK6Qp@dread.disaster.area>

On Wed, Apr 24, 2024 at 08:45:23AM +1000, Dave Chinner wrote:
> On Tue, Apr 23, 2024 at 03:46:24PM +0530, Chandan Babu R wrote:
> > Hi folks,
> > 
> > The for-next branch of the xfs-linux repository at:
> > 
> > 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> > 
> > has just been updated.
> > 
> > Patches often get missed, so please check if your outstanding patches
> > were in this update. If they have not been in this update, please
> > resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> > the next update.
> > 
> > The new head of the for-next branch is commit:
> > 
> > 6a94b1acda7e xfs: reinstate delalloc for RT inodes (if sb_rextsize == 1)
> 
> I've just noticed a regression in for-next - it was there prior to
> this update, but I hadn't run a 1kB block size fstests run in a
> while so I've only just noticed it. It is 100% reproducable, and may
> well be a problem with the partial filter matches in the test rather
> than a kernel bug...
> 
> SECTION       -- xfs_1k
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 test1 6.9.0-rc5-dgc+ #219 SMP PREEMPT_DYNAMIC Wed Apr 24 08:30:50 AEST 2024
> MKFS_OPTIONS  -- -f -m rmapbt=1 -b size=1k /dev/vdb
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/vdb /mnt/scratch
> 
> xfs/348 19s ... - output mismatch (see /home/dave/src/xfstests-dev/results//xfs_1k/xfs/348.out.bad)
>     --- tests/xfs/348.out       2022-12-21 15:53:25.579041081 +1100
>     +++ /home/dave/src/xfstests-dev/results//xfs_1k/xfs/348.out.bad     2024-04-24 08:34:43.718525603 +1000
>     @@ -2,7 +2,7 @@
>      ===== Find inode by file type:
>      dt=1 => FIFO_INO
>      dt=2 => CHRDEV_INO
>     -dt=4 => DIR_INO
>     +dt=4 => PARENT_INO108928

Given:

pino=$(ls -id $testdir | awk '{print $1}')
echo "s/inode $pino/PARENT_INO/" >> $inode_filter

I'd say that pino=35 would then result in:

s/inode 35/PARENT_INO/

Which will then match and transform:

inode 35108928

into:

PARENT_INO108928

So yeah, I agree that the partial filter matches are a problem.

--D

>      dt=6 => BLKDEV_INO
>      dt=10 => DATA_INO
>     ...
>     (Run 'diff -u /home/dave/src/xfstests-dev/tests/xfs/348.out /home/dave/src/xfstests-dev/results//xfs_1k/xfs/348.out.bad'  to see the entire diff)
> Failures: xfs/348
> Failed 1 of 1 tests
> 
> xfsprogs version installed on this test VM is:
> 
> $ xfs_repair -V
> xfs_repair version 6.4.0
> $
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

