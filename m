Return-Path: <linux-fsdevel+bounces-40149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EB8A1DB28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 18:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9F03A4EFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5D18A6C1;
	Mon, 27 Jan 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="karK3ybi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208418A6A9;
	Mon, 27 Jan 2025 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998396; cv=none; b=f3lKYR4xu/YftqEiitRsi4ur+IkK/awtKeq3LsBDXPAaci5QuL+Mh0rwy4ATBAREC8J+w9w8c7Db5TGNoGpbefEqxzlyBZtpJl6KNK/hd+jWvRKOAW4upaHUsklaxoTDRDToTbH6GWw6kK85/BYkSOXZI0TXZsPj3HH6iV1BOBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998396; c=relaxed/simple;
	bh=PPuVm5iqXgCC+CCHxuaTuqVzBe+G9i8rsvk4NZjU2ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOM4wL/MWnJO5ZrzZ2+LzwrTZ0LC2qao1WuVaYaBr8f8nftCPx7ATMHS5tVAK4zZBA0YiElPSIiboNfKnX/GO7JUUwrfYLspgobtpZ1BzQ2VCk0eEJemVVVBM8vt8TOEaro4uChXn49ALoYhuMpss6bFBvPkfc43JwPMfRroFQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=karK3ybi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DF0C4CED2;
	Mon, 27 Jan 2025 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737998395;
	bh=PPuVm5iqXgCC+CCHxuaTuqVzBe+G9i8rsvk4NZjU2ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=karK3ybiX18sZMYT7Z/J4ytZgHabC0takYIJozK06KAcHesPBSgCJ+BveW7GlvSqC
	 Z6lSCf5xqV4tYiwRVG+5LIMAHOmg/H285BYRtNwOEj1Ta5RUatrvBxrPc2tVXHMKUx
	 H+NcTbeS2Nobknyd6PLelWIekhP6okSFr+MnOXzipiH9Q3VtXj/ZZj55EpAtOIONTK
	 Kn0GeDYfrGoFQVvvwg0zhOSAfGN4SRPMr36G1Qs/hXlcUf251Sy+iyqpV1gbRRdCFf
	 /uBmRBVGA+btTyeEWSmmKpRUMULia8DC5CXEf9FjtIy+NIh/WqTOmlQ51xN7Rk7g65
	 sbpxAYU6rjenw==
Date: Mon, 27 Jan 2025 12:19:54 -0500
From: Sasha Levin <sashal@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <Z5fAOpnFoXMgpCWb@lappy>
References: <20250127044721.GD1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250127044721.GD1977892@ZenIV>

On Mon, Jan 27, 2025 at 04:47:21AM +0000, Al Viro wrote:
>->d_revalidate() series, along with ->d_iname preliminary work.
>One trivial conflict in fs/afs/dir.c - afs_do_lookup_one() has lost
>one argument in mainline and switched another from dentry to qstr
>in this series.
>
>The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:
>
>  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)
>
>are available in the Git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-revalidate
>
>for you to fetch changes up to a8ea90bfec66b239dad9a478fc444aa32d3961bc:
>
>  9p: fix ->rename_sem exclusion (2025-01-25 11:51:57 -0500)
>
>----------------------------------------------------------------
>Provide stable parent and name to ->d_revalidate() instances
>
>Most of the filesystem methods where we care about dentry name
>and parent have their stability guaranteed by the callers;
>->d_revalidate() is the major exception.
>
>It's easy enough for callers to supply stable values for
>expected name and expected parent of the dentry being
>validated.  That kills quite a bit of boilerplate in
>->d_revalidate() instances, along with a bunch of races
>where they used to access ->d_name without sufficient
>precautions.
>
>Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Hey Al,

With this pulled on top of Linus's tree, LKFT is managing to trigger
kfence warnings:

<3>[   62.180289] BUG: KFENCE: out-of-bounds read in d_same_name+0x4c/0xd0
<3>[   62.180289]
<3>[   62.182647] Out-of-bounds read at 0x00000000eedd4b55 (64B right of kfence-#174):
<4>[   62.184178]  d_same_name+0x4c/0xd0
<4>[   62.184717]  d_lookup+0x40/0x78
<4>[   62.185378]  lookup_dcache+0x34/0xb0
<4>[   62.185980]  lookup_one_qstr_excl+0x2c/0xe0
<4>[   62.186523]  do_renameat2+0x324/0x568
<4>[   62.186948]  __arm64_sys_renameat+0x58/0x78
<4>[   62.187484]  invoke_syscall+0x50/0x120
<4>[   62.188220]  el0_svc_common.constprop.0+0x48/0xf0
<4>[   62.189031]  do_el0_svc_compat+0x24/0x48
<4>[   62.189635]  el0_svc_compat+0x34/0xd0
<4>[   62.190018]  el0t_32_sync_handler+0xb0/0x138
<4>[   62.190537]  el0t_32_sync+0x19c/0x1a0
<3>[   62.190946]
<4>[   62.191399] kfence-#174: 0x0000000012d508d5-0x0000000023355f7e, size=64, cache=kmalloc-rcl-64
<4>[   62.191399]
<4>[   62.192260] allocated by task 1 on cpu 0 at 62.177313s (0.014839s ago):
<4>[   62.193504]  __d_alloc+0x15c/0x1d0
<4>[   62.193925]  d_alloc+0x24/0x90
<4>[   62.194204]  lookup_one_qstr_excl+0x68/0xe0
<4>[   62.194741]  filename_create+0xc0/0x1b0
<4>[   62.195129]  do_symlinkat+0x68/0x150
<4>[   62.195657]  __arm64_sys_symlinkat+0x50/0x70
<4>[   62.195954]  invoke_syscall+0x50/0x120
<4>[   62.196461]  el0_svc_common.constprop.0+0x48/0xf0
<4>[   62.197053]  do_el0_svc_compat+0x24/0x48
<4>[   62.197411]  el0_svc_compat+0x34/0xd0
<4>[   62.197849]  el0t_32_sync_handler+0xb0/0x138
<4>[   62.198422]  el0t_32_sync+0x19c/0x1a0
<3>[   62.198857]
<3>[   62.199577] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.13.0 #1
<3>[   62.200435] Hardware name: linux,dummy-virt (DT)

The full log is at: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-8584-gd4639f3659ae/testrun/27028572/suite/log-parser-test/test/kfence-bug-kfence-out-of-bounds-read-in-d_same_name/log

LMK if I should attempt a bisection.

-- 
Thanks,
Sasha

