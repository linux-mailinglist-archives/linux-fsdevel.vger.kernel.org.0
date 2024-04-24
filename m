Return-Path: <linux-fsdevel+bounces-17605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931528B00FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 07:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89682B2357C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7115533F;
	Wed, 24 Apr 2024 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMOVTDkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344E1552F7;
	Wed, 24 Apr 2024 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936351; cv=none; b=tdnJKTE8O9AzJcutalVHd6KLS/8phLUt7f1RyYPntw/qXCkjWkh+01jaKoqBatZykYZwQOk+vy6ZaRnHCFmnXDOPnPLGBAa/vsA3J/t/Fsw/Un4gm40Sbw1wy9LZJj2A3fpk/KA4HIscp1Ejrsw0Y9hh8jske2EssR3Zdm8bc/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936351; c=relaxed/simple;
	bh=ZrEoiWUGTqWTDdfXjBA93UXyO9HM0evbwAmIM3ft2r8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=pjXgwJLodhqdISCJtu4HMZMYjnM24o8RK+JMa67sPNjwExzmmMGK3siGx+DV/AiwrzdIc1kd2ZQVG/o03yg2m0t+Tv4lXtrNFA0Cbd6/w7Jc7YO+hS8hovXUUQXaGil2NWSqVCdgc9iaSySta5zncVUU+lFYf9QQrBgl2US3slM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMOVTDkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC29C113CE;
	Wed, 24 Apr 2024 05:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713936351;
	bh=ZrEoiWUGTqWTDdfXjBA93UXyO9HM0evbwAmIM3ft2r8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=hMOVTDkQagwJuLynXFXX35n+sWmhg+Hc4WEwuAcytT5bJLMSwFcHTs/KOGO7DzpwX
	 R3ygRBcGrmEpwD8r0a1OC13nH/R5c0YU5tqHH1HrvKYqUqHzz4AEz4AdDTf73d45Id
	 8QcFQ/MnOxBBX9aB4K9i+VJmMiCeADnpoKIgcNBeR523lgJHTtU/Q70fabaeUJrqbf
	 YaYQfwcAsWwkoRtWIH4KyuFxTl0/rREBOrFHvmNfNozrlD2hA0wCW4rNqA/Vn/qP3M
	 gIhR8N85xlgrveUH8++lt3XonVxJ3Pk8+aEyEiswQb+JKeRYoEQaEC6NMzYWDB8gk8
	 CP80HCVDmDPew==
References: <87bk60z8lm.fsf@debian-BULLSEYE-live-builder-AMD64>
 <Zig6A632L9PDK6Qp@dread.disaster.area>
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 6a94b1acda7e
Date: Wed, 24 Apr 2024 10:49:29 +0530
In-reply-to: <Zig6A632L9PDK6Qp@dread.disaster.area>
Message-ID: <87wmonib6s.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 24, 2024 at 08:45:23 AM +1000, Dave Chinner wrote:
> On Tue, Apr 23, 2024 at 03:46:24PM +0530, Chandan Babu R wrote:
>> Hi folks,
>> 
>> The for-next branch of the xfs-linux repository at:
>> 
>> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>> 
>> has just been updated.
>> 
>> Patches often get missed, so please check if your outstanding patches
>> were in this update. If they have not been in this update, please
>> resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
>> the next update.
>> 
>> The new head of the for-next branch is commit:
>> 
>> 6a94b1acda7e xfs: reinstate delalloc for RT inodes (if sb_rextsize == 1)
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

That is weird. I am unable to recreate this bug on my cloud instance. I am
using fstests version v2024.04.14 and Xfsprogs version 6.7.0.

# ./check xfs/348
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 fstest 6.9.0-rc4-00122-g6a94b1acda7e #13 SMP PREEMPT_DYNAMIC Wed Apr 24 09:48:36 IST 2024
MKFS_OPTIONS  -- -f -m rmapbt=1 -b size=1k /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

xfs/348 7s ...  8s
Ran: xfs/348
Passed all 1 tests

-- 
Chandan

