Return-Path: <linux-fsdevel+bounces-70386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24575C99587
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7ABF7346CB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50592868A9;
	Mon,  1 Dec 2025 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg3hB9pk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680C2DFF3F;
	Mon,  1 Dec 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627083; cv=none; b=P/JGlYqhdJ5OMC69PLZ6c5pkNPM6p+0PcxP+0hEiOMO0VtKOuxPCD977CJbAzL4RSDZx6jbBVRKxy4AXBCPg/JHfx9oEbb0MTuOwOop8WrV1qETAySZAc9dF+DT2rXTEfqUDtqC4ga6FXUZKB6D+fgVLIiJxeIQRdZJi4204bo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627083; c=relaxed/simple;
	bh=uliAKuSP/aOfcBNngqPOq76f5eXr0kFe6Iujl7ZHv+o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WOrpdHMj9kDl4gWH5kAxOX4XYBOE7Fe0JbXTibsLE9SSbcyRtuNrKdviTlpQ2oHHXiX2WpTyx6s7H6XmcmQ5IFlJc39GOENfsfaHkKJo8aK8Zi9a2CJrexYPIjRuiOPTVxDLz59LJWb+0D7aiCAaQ6EhsXsSvUUS9iIkKHu7xYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg3hB9pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC66C4CEF1;
	Mon,  1 Dec 2025 22:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627081;
	bh=uliAKuSP/aOfcBNngqPOq76f5eXr0kFe6Iujl7ZHv+o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pg3hB9pkTQvx75rzgsZvzCkWQyrVTpzgl6Pf9vjRrnbTq93yXLCagRIFIXASaUF04
	 4v5vqsbnMe2ToDUInCdNEz8DKd+OBEjWJyGa0oDZxh3DL1pvGB7p4YEUWp8G6uae8X
	 TqZjDyXDGk+R5N+wjOps/hlDPqyrq8RVk2nICXzBDUGESnrzZ3eyO23bYOZqUEGw1y
	 2jvlnF9qs1GWlEp1bBeKQKyhdYT39qXAdGITxCxSJ2/IQjoCMwSVdg2v/sH7nRzPIc
	 pgM4vctWYbu+WcCaddSiCFO+eRzuPP8mp8O03MMw7UYZuQVlDbIKdOEVLq//8xbOnd
	 ARElSxbM8XuQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A8D381196A;
	Mon,  1 Dec 2025 22:08:22 +0000 (UTC)
Subject: Re: [GIT PULL 02/17 for v6.19] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-misc-v619-0a57215a07b7@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-misc-v619-0a57215a07b7@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-misc-v619-0a57215a07b7@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.misc
X-PR-Tracked-Commit-Id: ebf8538979101ef879742dcfaf04b684f5461e12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b04b2e7a61830cabd00c6f95308a8e2f5d82fa52
Message-Id: <176462690157.2567508.6058495227817146168.pr-tracker-bot@kernel.org>
Date: Mon, 01 Dec 2025 22:08:21 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:13 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b04b2e7a61830cabd00c6f95308a8e2f5d82fa52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

