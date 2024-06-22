Return-Path: <linux-fsdevel+bounces-22181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B99239134F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1781F229BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815DB16FF3F;
	Sat, 22 Jun 2024 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRe8k3Ru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31714B078;
	Sat, 22 Jun 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719072060; cv=none; b=jgIARetz9GtxNv6K3+T7ME+P2wc5WaSutne7YXkokkm//ud7LsCwcyWnx0945zKiQTdyxnFDiEbRlyCxtSJbKUy2fHarMHFPqQTY5HNqinGCrNngzEH1mmqzI4IAglfYMBEmQtpSQbIafffg+Oqe8MqSgSZGzm4perBmi+yA7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719072060; c=relaxed/simple;
	bh=Cqft6o4pJm38G9E48IRUjh5mW5myfKbq0sUEt0bKQH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk5DRUSgC0bEwXTDJVztj9FPqYhlpJXAbWiNcRuTqC8/vrz+p7fHbyYCYbTF5BUU6CqO0V8E9LWxbZg2QkI318W/KiO0OsRui1deuWCQxE4w7SqMMjpfrVh5j7T1ee/uVbtj6tHsh8IgFdveQnC+bwITJA6WR39Uy6FMD+/xf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRe8k3Ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F455C3277B;
	Sat, 22 Jun 2024 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719072059;
	bh=Cqft6o4pJm38G9E48IRUjh5mW5myfKbq0sUEt0bKQH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRe8k3Ru1gvdsT5/n80kpNafErHY/F4Di7B5bA2HAXW7Y9zCjmE8M9hB0y7F7Vtfs
	 AuqkhZdvz8s0eqVa/XBU9pTSgPWN/QPycDBGV4mcjVT1jVA/RGt4qvb2PBH4FD18Gz
	 gwOp69M4sA9ueEiHxLFRsnSpvYx5oKJVT+M/G9lCbxEaqTHkQ38TcwhF/ndqoksJic
	 DZm8oVL0Odem0MKcGWeNUu0uZaZ0vLoyBu9T+586V7MsxwOPO5PF3HbyadC9P9iPiQ
	 Kr5hMGSyOX5WBRo90vwExBC0RowVO0otdOF/vw8Wt1IF12FZ6hM/q08IViIsga0Elh
	 4YBqneEaLhmLQ==
Date: Sat, 22 Jun 2024 09:00:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [GIT PULL] xfs: bug fix for 6.10
Message-ID: <20240622160058.GZ3058325@frogsfrogsfrogs>
References: <87r0cpw104.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0cpw104.fsf@debian-BULLSEYE-live-builder-AMD64>

On Sat, Jun 22, 2024 at 07:05:49PM +0530, Chandan Babu R wrote:
> Hi Linus,

Drat, I ran the wrong script, please ignore this email, Linus.
I guess I now have weekend work to go figure out why this happened.

> Please pull this branch which contains an XFS bug fix for 6.10-rc5. A brief
> description of the bug fix is provided below.

Chandan: Would _you_ mind pulling this branch with 6.10 fixes and
sending them on to Linus?

--D

> 
> I did a test-merge with the main upstream branch as of a few minutes ago and
> didn't see any conflicts.  Please let me know if you encounter any problems.
> 
> The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:
> 
>   Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-fixes-4
> 
> for you to fetch changes up to 348a1983cf4cf5099fc398438a968443af4c9f65:
> 
>   xfs: fix unlink vs cluster buffer instantiation race (2024-06-17 11:17:09 +0530)
> 
> ----------------------------------------------------------------
> Bug fixes for 6.10-rc5:
> 
>   * Fix assertion failure due to a race between unlink and cluster buffer
>     instantiation.
> 
> Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
> 
> ----------------------------------------------------------------
> Dave Chinner (1):
>       xfs: fix unlink vs cluster buffer instantiation race
> 
>  fs/xfs/xfs_inode.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 

