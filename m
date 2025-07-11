Return-Path: <linux-fsdevel+bounces-54671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F357B021CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5193B3102
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B3C2EFD9D;
	Fri, 11 Jul 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG4kxYHH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EDA2ED161
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251386; cv=none; b=MxTEWv21Qv9ODqxJ5ObwFqH1OVGv4thj8BpF5PJI+rrgy5Zma2e+b/HXWXmwQB57lR2XVQ/lnGYp0TTVQUIv65bfeEMojIQU0Zy/HrXJHLHNRchbjRR6OTlIJFybAg8UHpvQj2+Mk3B3lCkRpmqKucP6RtFsyBeG+cxyUi28FmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251386; c=relaxed/simple;
	bh=incKL2zc0l+sFdNc3xEoLvkCgWmIEiVGwblLyaSzneg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P1AhEHsC9/UfyZxJXTyhYZl3X/zCy//V7KV2/HzxHn4aUIsCLS2t9/ka8kTG4dp4We/ZX5VUzB4gaWaFYk+OwY53alFUXb232wfDgpXllk9+4DPQpFeUJFkdNVquyyfUxAqWz5aGvvLrP1N7iiopFRsJvxezuGf9qfoWXIPo8is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG4kxYHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0415EC4CEED;
	Fri, 11 Jul 2025 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752251386;
	bh=incKL2zc0l+sFdNc3xEoLvkCgWmIEiVGwblLyaSzneg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kG4kxYHHIISUREQL+FSJUpJQWkjFU51Cg+MHi/9q6CrWSeUOqBQsslL3l4oF8hiGU
	 APpE/gmOOg52TAExukNyNEMYtZfMys887+06OmiFk83zoRUzoVlPHU4FC5IMZLi/qB
	 HsHHCj75KnCQeKU2FCTiwXprY0VliSZJcR+YJdXyG0D86hKEDNtWQH+Q1qXFgYquGH
	 E2YCALtQeiz4cwzw2W5sIUMuqRwUlbAu65N3QdVQuFf7d/l2FsID9ZGjf3bLg09gEe
	 rU1MoQsosbi6g0cFRM8ChLhTJ4KacOWl3MqzdNmTDxsfZ5xa01/1wGmvoPGHs8w1jD
	 fx4r2k/voYocg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8F383B275;
	Fri, 11 Jul 2025 16:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v5 0/7] f2fs: new mount API conversion
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175225140803.2328592.14468679828174241013.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 16:30:08 +0000
References: <20250710121415.628398-1-lihongbo22@huawei.com>
In-Reply-To: <20250710121415.628398-1-lihongbo22@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-fsdevel@vger.kernel.org,
 sandeen@redhat.com, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 10 Jul 2025 12:14:08 +0000 you wrote:
> In this version, we have finished the issues pointed in v4.
> First, I'd like to express my sincere thanks to Jaegeuk and Chao
> for reviewing this patch series and providing corrections. I also
> appreciate Eric for rebasing the patches onto the latest branch to
> ensure forward compatibility.
> 
> The latest patch series has addressed all the issues mentioned in
> the previous set. For modified patches, I've re-added Signed-off-by
> tags (SOB) and uniformly removed all Reviewed-by tags.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5,1/7] f2fs: Add fs parameter specifications for mount options
    https://git.kernel.org/jaegeuk/f2fs/c/a3277c98b64f
  - [f2fs-dev,v5,2/7] f2fs: move the option parser into handle_mount_opt
    https://git.kernel.org/jaegeuk/f2fs/c/b03e9e44e135
  - [f2fs-dev,v5,3/7] f2fs: Allow sbi to be NULL in f2fs_printk
    https://git.kernel.org/jaegeuk/f2fs/c/405e5e00bfee
  - [f2fs-dev,v5,4/7] f2fs: Add f2fs_fs_context to record the mount options
    https://git.kernel.org/jaegeuk/f2fs/c/d870b85ae2de
  - [f2fs-dev,v5,5/7] f2fs: separate the options parsing and options checking
    https://git.kernel.org/jaegeuk/f2fs/c/85d2da63b8a5
  - [f2fs-dev,v5,6/7] f2fs: introduce fs_context_operation structure
    https://git.kernel.org/jaegeuk/f2fs/c/54e12a4e0209
  - [f2fs-dev,v5,7/7] f2fs: switch to the new mount api
    https://git.kernel.org/jaegeuk/f2fs/c/a0512c55d7f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



