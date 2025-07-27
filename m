Return-Path: <linux-fsdevel+bounces-56096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD51B12FA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 15:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770E37A9B8C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 13:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB2D2165EC;
	Sun, 27 Jul 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVJWTRgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792E11185;
	Sun, 27 Jul 2025 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753621805; cv=none; b=tTOR0QX7wWSBn62a7oyXc4xWH02FUliEhAZ5C/5Nucl8/y7/rQPb7L9Ji5c7oqwOPIjEsDQK2sB9Ecw7cD2t0NX7jmrPGyedks1Bux/Z7k/pquiDTjIVrsI7mhXypa/AesNO4IKHnXVH1nJlbYl1OgkUtTYoduvY2wYijd+TbWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753621805; c=relaxed/simple;
	bh=Y+6QxsoXEpzrUXDeHyzUwKuI33IwVMqc71T8uhrKvco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qv4Y1nW7jEQWwadz7cfM3TSaT8RsUV0a3dpMAmWOp3L8C5SyxIVIGCmEEkFFRVQgascVp4DkQqJId61L04B7S8EkGs/JvwtRh0FTz7GpawIqGBhbM5xjhS+Sco1tQQi5HhUk34QT88pznx66ZfJj7UEo7GMa0+om0Guf30su5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVJWTRgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEBCC4CEEB;
	Sun, 27 Jul 2025 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753621805;
	bh=Y+6QxsoXEpzrUXDeHyzUwKuI33IwVMqc71T8uhrKvco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVJWTRgO2CigYLAzc5cLRoeUHeRmEvu7Q9i1R/5fJ07opp309kq3ZT/iakcPg0vXw
	 uqIOba+TMKwe+Y3HJvG1NEqMwPTM8gaIeQiRSW9w4uY7wUTQcltGTtAHLrpJGTmWgu
	 my5XJtyhJ8JZVd04JDIMMt1UNGxsCvduvOp7zJ7TIQLZBpLvkKmyKA5UO0u6OvimkV
	 RM3mYWERZ2wCFb2xZ8xFT63IULJocIkR4tehF6NtBjpFgWMvMtW5O2SSWJq6ZomGBP
	 b+h9CeMRVbfBJZHhsHW1Tq9cTZ6c9D+QZAh+yWjvTPxbuv3yJmaFX1rIhjo1uOimem
	 ZSI9G2/8wPTLw==
Date: Sun, 27 Jul 2025 09:10:02 -0400
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 14/14 for v6.17] vfs iomap
Message-ID: <aIYlKgQZNF7-LgIp@lappy>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
 <20250725-vfs-iomap-e5f67758f577@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250725-vfs-iomap-e5f67758f577@brauner>

Hey Christian,

On Fri, Jul 25, 2025 at 01:27:20PM +0200, Christian Brauner wrote:
>Hey Linus,
>
>/* Summary */
>This contains the iomap updates for this cycle:
>
>- Refactor the iomap writeback code and split the generic and ioend/bio
>  based writeback code. There are two methods that define the split
>  between the generic writeback code, and the implemementation of it,
>  and all knowledge of ioends and bios now sits below that layer.
>
>- This series adds fuse iomap support for buffered writes and dirty
>  folio writeback. This is needed so that granular uptodate and dirty
>  tracking can be used in fuse when large folios are enabled. This has
>  two big advantages. For writes, instead of the entire folio needing to
>  be read into the page cache, only the relevant portions need to be.
>  For writeback, only the dirty portions need to be written back instead
>  of the entire folio.

While testing with the linus-next tree, it appears that LKFT can trigger
the following warning, but only on arm64 tests (both on real HW as well
as qemu):

[ 333.129662] WARNING: CPU: 1 PID: 2580 at fs/fuse/file.c:2158 fuse_iomap_writeback_range+0x478/0x558 fuse
[  333.132010] Modules linked in: btrfs blake2b_generic xor xor_neon raid6_pq zstd_compress sm3_ce sha3_ce sha512_ce fuse drm backlight ip_tables x_tables
[  333.133982] CPU: 1 UID: 0 PID: 2580 Comm: msync04 Tainted: G        W           6.16.0-rc7 #1 PREEMPT
[  333.134997] Tainted: [W]=WARN
[  333.135497] Hardware name: linux,dummy-virt (DT)
[  333.136114] pstate: 03402009 (nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
WARNING! No debugging info in module fuse, rebuild with DEBUG_KERNEL and DEBUG_INFO
[ 333.137090] pc : fuse_iomap_writeback_range+0x478/0x558 fuse
[ 333.138009] lr : iomap_writeback_folio (fs/iomap/buffered-io.c:1586 fs/iomap/buffered-io.c:1710)
[  333.138510] sp : ffff80008be8f8c0
[  333.138653] x29: ffff80008be8f8c0 x28: fff00000c5198c00 x27: 0000000000000000
[  333.138975] x26: fff00000d32b8c00 x25: 0000000000000000 x24: 0000000000000000
[  333.139309] x23: 0000000000000000 x22: fffffc1fc039ba40 x21: 0000000000001000
[  333.139600] x20: ffff80008be8f9f0 x19: 0000000000000000 x18: 0000000000000000
[  333.139917] x17: 0000000000000000 x16: ffffbb40f61c3a48 x15: 0000000000000000
[  333.142199] x14: ffffbb40f6924788 x13: 0000ffff8e8effff x12: 0000000000000000
[  333.142739] x11: 1ffe0000199a9241 x10: fff00000ccd4920c x9 : ffffbb40f50bba18
[  333.143466] x8 : ffff80008be8f778 x7 : ffffbb40ee180b68 x6 : ffffbb40f76c9000
[  333.143718] x5 : 0000000000000000 x4 : 000000000000000a x3 : 0000000000001000
[  333.143957] x2 : fff00000c0b6e600 x1 : 000000000000ffff x0 : 0bfffe000000400b
[  333.144993] Call trace:
WARNING! No debugging info in module fuse, rebuild with DEBUG_KERNEL and DEBUG_INFO
[ 333.145466] fuse_iomap_writeback_range+0x478/0x558 fuse (P)
[ 333.146136] iomap_writeback_folio (fs/iomap/buffered-io.c:1586 fs/iomap/buffered-io.c:1710)
[ 333.146444] iomap_writepages (fs/iomap/buffered-io.c:1762)
WARNING! No debugging info in module fuse, rebuild with DEBUG_KERNEL and DEBUG_INFO
[ 333.146590] fuse_writepages+0xa0/0xe8 fuse
[ 333.146774] do_writepages (mm/page-writeback.c:2636)
[ 333.146915] filemap_fdatawrite_wbc (mm/filemap.c:386 mm/filemap.c:376)
[ 333.147788] __filemap_fdatawrite_range (mm/filemap.c:420)
[ 333.148440] file_write_and_wait_range (mm/filemap.c:794)
WARNING! No debugging info in module fuse, rebuild with DEBUG_KERNEL and DEBUG_INFO
[ 333.149054] fuse_fsync+0x6c/0x138 fuse
[ 333.149578] vfs_fsync_range (fs/sync.c:188)
[ 333.149892] __arm64_sys_msync (mm/msync.c:96 mm/msync.c:32 mm/msync.c:32)
[ 333.150095] invoke_syscall.constprop.0 (arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
[ 333.150330] do_el0_svc (include/linux/thread_info.h:135 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2) arch/arm64/kernel/syscall.c:151 (discriminator 2))
[ 333.150461] el0_svc (arch/arm64/include/asm/irqflags.h:82 (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1) arch/arm64/kernel/entry-common.c:165 (discriminator 1) arch/arm64/kernel/entry-common.c:178 (discriminator 1) arch/arm64/kernel/entry-common.c:768 (discriminator 1))
[ 333.150583] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:787)
[ 333.150729] el0t_64_sync (arch/arm64/kernel/entry.S:600)
[  333.150862] ---[ end trace 0000000000000000 ]---

I think that this is because the arm64 tests run on
CONFIG_PAGE_SIZE_64KB=y build, but I'm not sure why we don't see it with
4KB pages at all.

An example link to a failing test that has the full log and more
information: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-44385-g8a03a07bad83/testrun/29269158/suite/log-parser-test/test/exception-warning-cpu-pid-at-fsfusefile-fuse_iomap_writeback_range/details/

-- 
Thanks,
Sasha

