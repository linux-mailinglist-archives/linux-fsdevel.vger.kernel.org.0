Return-Path: <linux-fsdevel+bounces-14751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AFF87EDE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 17:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0924B229E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916A5578D;
	Mon, 18 Mar 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmXzLAgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DBC55762;
	Mon, 18 Mar 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780482; cv=none; b=DKFAcOYz25vrjA3eZuXwUdMhWq4gUJsccIBSv6tuVJ1f3tWJooaGw0RjK68eA8l+NMRg/j7tiS+g4AgmNr3+lAb9O0DMdNM2iBag33QHArr/Nc3yoS8+pUCNikD9rVqDr72q2dptxwLOsP70u2bFvjZCSfo0Xtl5xn9ExsxuTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780482; c=relaxed/simple;
	bh=tuCJC2sQxKIp3jJ5QacXYqe+VxcQS8pGWCBSAYdNC1k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FWx4UPMNR8/v/86EsuuMWSCjyVBMGXluXGIhSh7ESMbXq9/IzViJx6lHguePoqJ0UV0xNu7aXySQnN007nMR+uZWR/uPRmDYG2PszvJVoTm2A3jWfWZJcgADX1zvGtvtJyQk57hdy8coC/2IfAGklQmexofDLB/y+otdfkL9FVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmXzLAgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77635C433F1;
	Mon, 18 Mar 2024 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710780482;
	bh=tuCJC2sQxKIp3jJ5QacXYqe+VxcQS8pGWCBSAYdNC1k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fmXzLAgue1wYAIJ6bMAQ6y4qb1r+ArIU4yZM7276RdXoAEc4tzBEKeZjvkn5ogOet
	 jO23lStXv6/2TEwMJUkHjqMorzM6oy5tdrSyMybm/mVvxM6p3wpLm2mlueiZXpbv7p
	 Tt0R9VxaAplrc5kG5jEs4Aw1bobPbcfyx3VjYkYUEbWyVJvrO/4Hj2EbZGhmGA3ajq
	 boW2+drwtuQU8D/8fVNSmKgicJsJrhDyl8gHVGz+mXaNawXRpEtHeYG4xj8K2oIDhW
	 59Vrl53LRnwvYxQmAyqaeIgc0MCdLFim5fXYoCJxPjXHwxCDQdyn91MxY6A2eT3n6t
	 8ORYboxD6nELw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E604D84BA7;
	Mon, 18 Mar 2024 16:48:02 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240318-vfs-fixes-e0e7e114b1d1@brauner>
References: <20240318-vfs-fixes-e0e7e114b1d1@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240318-vfs-fixes-e0e7e114b1d1@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9-rc1.fixes
X-PR-Tracked-Commit-Id: 449ac5514631dd9b9b66dd708dd5beb1428e2812
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a7b0acecea273c8816f4f5b0e189989470404cf
Message-Id: <171078048238.4121.17032827791250760520.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 16:48:02 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 13:19:54 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9-rc1.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a7b0acecea273c8816f4f5b0e189989470404cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

