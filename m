Return-Path: <linux-fsdevel+bounces-17647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE938B0D63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFCF1C249CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCB215EFB8;
	Wed, 24 Apr 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wdgwd8d0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85115B15C;
	Wed, 24 Apr 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970700; cv=none; b=jG9ASXYWyRXs9JQw4R1fvE7XZnAZ3pklXaAHKvA0rLzYBNECNgiK/awWXs1Kjs3Yc/pvI/RVczCyteCLe+LN08aiqZ/grKvzJTWqH2ORkB/wElHOrIH9MXjl7xKWv4EfY4Tu6yJ4T0mvt4Q72gUxCkCCK+P2ONwnhGPwkuPN0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970700; c=relaxed/simple;
	bh=YV+9GI/ieu7Q3hqRSONAS5/3IIe3dHs8IVjcw8TKwBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSSXNZ1sk+za1ReKByLlo07mPY4Qjmv18vosOb8lYhL2AVw5TQGF+DaJHZf9FJU8/eOP5QveYNssnnXDFYChozYDN9xVjMsNgtPpcgnWSh2WJyeECPazpzaj/sahrrVi1Jav7ivw/+HPzIXhBvnaX6GthHZsLqrjf5xqci/tJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wdgwd8d0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3214C113CE;
	Wed, 24 Apr 2024 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970699;
	bh=YV+9GI/ieu7Q3hqRSONAS5/3IIe3dHs8IVjcw8TKwBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wdgwd8d0kmNgYEApT8v50fyk3qNQMS1LTPg63DLd9uuVSkfsheX89fQ0ITmQy5Rhd
	 /VX1rWa/J8C8HdEkfQt2VVThwf95QTbuhQ49yiDSHy8cIXXVyhRj/+fJz93dj00SiG
	 L6BVgXOBLUssKTBm8eeqCppaDd7NI1dzmG9aQ/nTUWr3zwbpge/pEqHqi6VT7/M/Yi
	 KUBLZjNAzGQ10icxp9pD9/Y/69bED8Wvco8JG5IpOYqM4NvwiKmm3P/pXBBZ0kXv+M
	 ZpMZHSwVR6kcZH8/7+j7pki7/YhfXdjqENLo2xD1+IWKmBI9PUjLmSmYio0P0ducT+
	 zPwpbf26hntHA==
Date: Wed, 24 Apr 2024 07:58:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, dchinner@redhat.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 6a94b1acda7e
Message-ID: <20240424145819.GF360919@frogsfrogsfrogs>
References: <87bk60z8lm.fsf@debian-BULLSEYE-live-builder-AMD64>
 <Zig6A632L9PDK6Qp@dread.disaster.area>
 <87wmonib6s.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmonib6s.fsf@debian-BULLSEYE-live-builder-AMD64>

On Wed, Apr 24, 2024 at 10:49:29AM +0530, Chandan Babu R wrote:
> On Wed, Apr 24, 2024 at 08:45:23 AM +1000, Dave Chinner wrote:
> > On Tue, Apr 23, 2024 at 03:46:24PM +0530, Chandan Babu R wrote:
> >> Hi folks,
> >> 
> >> The for-next branch of the xfs-linux repository at:
> >> 
> >> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> >> 
> >> has just been updated.
> >> 
> >> Patches often get missed, so please check if your outstanding patches
> >> were in this update. If they have not been in this update, please
> >> resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> >> the next update.
> >> 
> >> The new head of the for-next branch is commit:
> >> 
> >> 6a94b1acda7e xfs: reinstate delalloc for RT inodes (if sb_rextsize == 1)
> >
> > I've just noticed a regression in for-next - it was there prior to
> > this update, but I hadn't run a 1kB block size fstests run in a
> > while so I've only just noticed it. It is 100% reproducable, and may
> > well be a problem with the partial filter matches in the test rather
> > than a kernel bug...
> >
> > SECTION       -- xfs_1k
> > FSTYP         -- xfs (debug)
> > PLATFORM      -- Linux/x86_64 test1 6.9.0-rc5-dgc+ #219 SMP PREEMPT_DYNAMIC Wed Apr 24 08:30:50 AEST 2024
> > MKFS_OPTIONS  -- -f -m rmapbt=1 -b size=1k /dev/vdb
> > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/vdb /mnt/scratch
> >
> > xfs/348 19s ... - output mismatch (see /home/dave/src/xfstests-dev/results//xfs_1k/xfs/348.out.bad)
> >     --- tests/xfs/348.out       2022-12-21 15:53:25.579041081 +1100
> >     +++ /home/dave/src/xfstests-dev/results//xfs_1k/xfs/348.out.bad     2024-04-24 08:34:43.718525603 +1000
> >     @@ -2,7 +2,7 @@
> >      ===== Find inode by file type:
> >      dt=1 => FIFO_INO
> >      dt=2 => CHRDEV_INO
> >     -dt=4 => DIR_INO
> >     +dt=4 => PARENT_INO108928
> >      dt=6 => BLKDEV_INO
> >      dt=10 => DATA_INO
> >     ...
> >     (Run 'diff -u /home/dave/src/xfstests-dev/tests/xfs/348.out /home/dave/src/xfstests-dev/results//xfs_1k/xfs/348.out.bad'  to see the entire diff)
> > Failures: xfs/348
> > Failed 1 of 1 tests
> >
> > xfsprogs version installed on this test VM is:
> >
> > $ xfs_repair -V
> > xfs_repair version 6.4.0
> > $
> 
> That is weird. I am unable to recreate this bug on my cloud instance. I am
> using fstests version v2024.04.14 and Xfsprogs version 6.7.0.
> 
> # ./check xfs/348
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 fstest 6.9.0-rc4-00122-g6a94b1acda7e #13 SMP PREEMPT_DYNAMIC Wed Apr 24 09:48:36 IST 2024
> MKFS_OPTIONS  -- -f -m rmapbt=1 -b size=1k /dev/loop1
> MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch
> 
> xfs/348 7s ...  8s
> Ran: xfs/348
> Passed all 1 tests

Same here -- I checked all of yesterday's runs and none of them tripped
over that.  sed \b perhaps?

--D

> -- 
> Chandan
> 

