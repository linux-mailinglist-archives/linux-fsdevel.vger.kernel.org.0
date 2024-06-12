Return-Path: <linux-fsdevel+bounces-21523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FBA905159
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 13:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABCE2877AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A124F16F0EF;
	Wed, 12 Jun 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwUGJtCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575416F0C3;
	Wed, 12 Jun 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718191512; cv=none; b=kZSHM0JtVAMzLEZ4ZUGJeaQVQ2fVsVA1iCr3VB+l0htd2TGdT7y7ZiLP9xR6MN9jxpGaTR3xqgk28fAYvoyRi2U3n94gT7jnvXfK8EFpq0ValSyvfqjXyLw0PmqZwDJ+Ehfw0Y1OCGLW/NzbPUGZdfdqSeL4Wg/k2E51ANWltCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718191512; c=relaxed/simple;
	bh=/ZAo2DVsd+WeBWhmKYOCVsT3ZqZZs9Sle4+mvcJ8Bfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+sTuJ/IpI0OVSElx+MiE1PooIv4eaGPcuo/3vmn5rcM+6hQtRpd0RWayxaYYAOXoBNDCIZgFqrNefQpF4kM/4rfHiRnMJJRCBWu4kGyS1S8S2fCKB81p8aSLXAalARgNx/oJvNEF4bPc5TVTYWWHhYScAJMvmj77idtFiO1Vss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwUGJtCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1518EC32789;
	Wed, 12 Jun 2024 11:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718191511;
	bh=/ZAo2DVsd+WeBWhmKYOCVsT3ZqZZs9Sle4+mvcJ8Bfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwUGJtCzgaZhb6D49YaEZKEY7jrqV0DMulZ90kEF0zRvwgoLPsqvQ3T5xFCK564Vp
	 BABidUdDT5408f1tTbPO/aOu7rXJ7fpBzGpcbb5oWvA0ayXfuWlPS/yAB4GuHDHW6B
	 +I+/oH13IhbPcpTNqnUqmyp+YsKHJOYNRkDEVlR+UqLRYvS1og9XO15a1opuWBghwg
	 D7CqESBEmHhmoCAsvT9s3TvKOSO4xmAl4+rK3jfbgicR/FnLgsAVZ4o4ERw+d6bsOx
	 uYcWmIE0V491kdGlYCq9lBZaOP+40rJsGq3TZEvgOrhhsQKQ9hMS/NSes4cx2AuC4h
	 UfHblGxVe+q8A==
Date: Wed, 12 Jun 2024 13:25:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, linux-block@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: Flaky test: generic/085
Message-ID: <20240612-abdrehen-popkultur-80006c9e4c8d@brauner>
References: <20240611085210.GA1838544@mit.edu>
 <20240611163701.GK52977@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240611163701.GK52977@frogsfrogsfrogs>

On Tue, Jun 11, 2024 at 09:37:01AM -0700, Darrick J. Wong wrote:
> On Tue, Jun 11, 2024 at 09:52:10AM +0100, Theodore Ts'o wrote:
> > Hi, I've recently found a flaky test, generic/085 on 6.10-rc2 and
> > fs-next.  It's failing on both ext4 and xfs, and it reproduces more
> > easiy with the dax config:
> > 
> > xfs/4k: 20 tests, 1 failures, 137 seconds
> >   Flaky: generic/085:  5% (1/20)
> > xfs/dax: 20 tests, 11 failures, 71 seconds
> >   Flaky: generic/085: 55% (11/20)
> > ext4/4k: 20 tests, 111 seconds
> > ext4/dax: 20 tests, 8 failures, 69 seconds
> >   Flaky: generic/085: 40% (8/20)
> > Totals: 80 tests, 0 skipped, 20 failures, 0 errors, 388s
> > 
> > The failure is caused by a WARN_ON in fs_bdev_thaw() in fs/super.c:
> > 
> > static int fs_bdev_thaw(struct block_device *bdev)
> > {
> > 	...
> > 	sb = get_bdev_super(bdev);
> > 	if (WARN_ON_ONCE(!sb))
> > 		return -EINVAL;
> > 
> > 
> > The generic/085 test which exercises races between the fs
> > freeze/unfeeze and mount/umount code paths, so this appears to be
> > either a VFS-level or block device layer bug.  Modulo the warning, it
> > looks relatively harmless, so I'll just exclude generic/085 from my
> > test appliance, at least for now.  Hopefully someone will have a
> > chance to take a look at it?
> 
> I think this can happen if fs_bdev_thaw races with unmount?
> 
> Let's say that the _umount $lvdev in the second loop in generic/085
> starts the unmount process, which clears SB_ACTIVE from the super_block.
> Then the first loop tries to freeze the bdev (and fails), and
> immediately tries to thaw the bdev.  The thaw code calls fs_bdev_thaw
> because the unmount process is still running & so the fs is still
> holding the bdev.  But get_bdev_super sees that SB_ACTIVE has been
> cleared from the super_block so it returns NULL, which trips the
> warning.
> 
> If that's correct, then I think the WARN_ON_ONCE should go away.

I've been trying to reproduce this with pmem yesterday and wasn't able to.

SB_ACTIVE is cleared in generic_shutdown_super(). If we're in there we
know that there are no active references to the superblock anymore. That
includes freeze requests:

* Freezes are nestable from kernel and userspace but all
  nested freezers share a single active reference in sb->s_active.
* The nested freeze requests are counted in
  sb->s_writers.freeze_{kcount,ucount}.
* The last thaw request (sb->s_writers.freeze_kcount +
  sb->s_writers.freeze_ucount == 0) releases the sb->s_active reference.
* Nested freezes from the block layer via bdev_freeze() are
  additionally counted in bdev->bd_fsfreeze_count protected by
  bdev->bd_fsfreeze_mutex.

The device mapper suspend logic that generic/085 uses relies on
bdev_freeze() and bdev_thaw() from the block layer. So all those dm
freezes should be counted in bdev->bd_fsfreeze_count. And device mapper
has logic to ensure that only a single freeze request is ever made. So
bdev->bd_fsfreeze_count in that test should be 1. So when a bdev_thaw()
request comes via dm_suspend():

* bdev_thaw() is called and encounters bdev->bd_fsfreeze_count == 1.
  * As there aren't any fs initiated freezes we know that
  sb->s_writers.kcount == 0 and sb->s_writer.ucount == 1 ==
  bdev->bd_fsfreeze_count.
* When fs_bdev_thaw() the superblock is still valid and we've got at
  least one active reference taken during the bdev_freeze()
    request.
* get_bdev_super() tries to grab an active reference to the
  superblock but fails.

That can indeed happen because SB_ACTIVE is cleared. But for that to be
the case we must've dropped the last active reference, forgot to take it
during the original freeze, miscounted bdev->bd_fsfreeze_count, or
missed a nested sb->s_writers.freeze_{kcount,ucount}.

What's the kernel config and test config that's used?

