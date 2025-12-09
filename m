Return-Path: <linux-fsdevel+bounces-71024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 578EDCB0BAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 18:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08C03308CB48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76832ABC5;
	Tue,  9 Dec 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUrs/Ija"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE732ED32;
	Tue,  9 Dec 2025 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300916; cv=none; b=FY1Ts6wmKLk7QhIbhudxSMMUFFk6W1iyECw8FxhtBNnrBBZ6e8/MEI4t+we4Cypi8WkQpDaeVX49C83ygVJKGjd1z0/4iVR/ugwfQtJXBRs5dJO/XbLKzH7nGIDagFSavdSS+2b8UrtBJYkazzzsl2zib+hL2vTreKomJEP6WEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300916; c=relaxed/simple;
	bh=PUl+bzo4yhC3iWjPC3NSPKtGAECgAhIP3ifjJ4UzYaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZJ5N0MbgD2dOxoPGhIZmR+fOYcvCVwsJdPnuwoxUZ18erRV791LHBHjGpSk0VvHuCsYZ0eZkHGpxrDgNiNN4VvBUcAVdxX/omr4on0dvccIA+cAYbO1/VtEW5Z9Ly6OyBvy5LAow/H7/ehsI2E95Jn6Z+1LmGB2iLBjA+jfVzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUrs/Ija; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9394C4CEF5;
	Tue,  9 Dec 2025 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765300915;
	bh=PUl+bzo4yhC3iWjPC3NSPKtGAECgAhIP3ifjJ4UzYaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PUrs/IjauNwyVsMDc+ymhcYQT51M94CQqGOke7k5Er4egvIZUbili5cvXEwqIeg7t
	 AG0PVziN74DkqOlW41nha/1gAKYpOWWKnE2mKxhudWaA/ZopnjWFTyUKIG3efE2qpP
	 ImFr/lBzCNW+PxP5699xwlTN5YTctrKzXP6p3IhxXKz0cbKWn/JE3JKe7Pq/l2bMCi
	 ryUItZIzpuB6vOBazSjKT6T3DUbwhF5Eo/aLvY0kwrcPp+NkYQr0Ap1GudEku3LHlu
	 RjzKCbDkqXD/5QaUwsEoPJvb4BTTiC4r0AKhrrDhrg44I17SPMggcOkD0d76QcCEby
	 NRaWiXz8AjzQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F294B3808200;
	Tue,  9 Dec 2025 17:18:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/2] printk_ringbuffer: Fix regression in
 get_data() and clean up data size checks
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176530073052.4018985.7520755795094110884.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 17:18:50 +0000
References: <20251107194720.1231457-1-pmladek@suse.com>
In-Reply-To: <20251107194720.1231457-1-pmladek@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: john.ogness@linutronix.de, brauner@kernel.org, djwong@kernel.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, joannelkoong@gmail.com,
 amurray@thegoodpenguin.co.uk

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Petr Mladek <pmladek@suse.com>:

On Fri,  7 Nov 2025 20:47:18 +0100 you wrote:
> This is outcome of the long discussion about the regression caused
> by 67e1b0052f6bb82 ("printk_ringbuffer: don't needlessly wrap data blocks around"),
> see https://lore.kernel.org/all/69096836.a70a0220.88fb8.0006.GAE@google.com/
> 
> The 1st patch fixes the regression as agreed, see
> https://lore.kernel.org/all/87ecqb3qd0.fsf@jogness.linutronix.de/
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] printk_ringbuffer: Fix check of valid data size when blk_lpos overflows
    https://git.kernel.org/jaegeuk/f2fs/c/cc3bad11de6e
  - [f2fs-dev,2/2] printk_ringbuffer: Create a helper function to decide whether a more space is needed
    https://git.kernel.org/jaegeuk/f2fs/c/394aa576c0b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



