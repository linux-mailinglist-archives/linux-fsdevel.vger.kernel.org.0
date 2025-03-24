Return-Path: <linux-fsdevel+bounces-44907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A91A7A6E4EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3913716C025
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB41F3D44;
	Mon, 24 Mar 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q661r0cS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B41E8351;
	Mon, 24 Mar 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850033; cv=none; b=HaoQLXWgQVs0O5E/yCgL1XT0iXI5yGOwBhgWr1jUx7XemlcwseM4VJ81ef4mOehIJRGXy5eH5hEdH8Cl/45g2VemN3OAB/i5xmiurNSTID3so4l6DdgGbT1wQdnudru6p498hdYjiibq7n99ve63g1UMtN2W3SfIVCgSB5Yv8hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850033; c=relaxed/simple;
	bh=eQ1za9eM0lsaTJ0+UEz9mLb5VdVyLhvctOdi7WymWhY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qXVstk6J/3nrqSQfLpgnfEbvi9+vfjlgQqS/Psldmp7VKeTt0weMbNnEfQAPND0bxIb0MoffSO3fvoh/zClefZ2/Ziq6Qei2Y6lSgWdqwiaqRPVrPLm4VFfZ//brnvD3TXsbA61wpbgVC31C1f9UMwaDgct2z4gz5BQqrKUQxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q661r0cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D22C4CEE4;
	Mon, 24 Mar 2025 21:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850033;
	bh=eQ1za9eM0lsaTJ0+UEz9mLb5VdVyLhvctOdi7WymWhY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q661r0cS6g+l2X7qwvT8PRKKAeVHEUnLNdqiRiOZeEQTN/iyPdjOghNm2+gMmK74L
	 WLsxtlc0rIG19yThoZZgubdEi1Hn9UHIv5Y2NuDcKdiOUhS2tu1WrAh465UPhiN503
	 CbjSh2qVGUVg0G9rdR88zakEOutIncbAXNGVTPUp9OZF1JMMzL4GvLIfFyiK14mAON
	 EiuEQXJ8rbQ3Bki7eA6sCI3Rt6OXZKyS6wrR0OkdrXlAhZvHsiYYAtXs4/ebboXv10
	 Ws/ioOFmSIpiaLF82xAfkqPo90hMFc2tpUJAEhE/JXMByOPdM0zZSWiBJLYgItQPLX
	 x0MDnG8REI+eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BAA0380664F;
	Mon, 24 Mar 2025 21:01:10 +0000 (UTC)
Subject: Re: [GIT PULL] vfs overlayfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-overlayfs-fd5f08e77ed3@brauner>
References: <20250322-vfs-overlayfs-fd5f08e77ed3@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-overlayfs-fd5f08e77ed3@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.overlayfs
X-PR-Tracked-Commit-Id: 9c27e5cc39bb7848051c42500207aa3a7f63558c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 804382d59b81b331735d37a18149ea0d36d5936a
Message-Id: <174285006951.4171303.5670885998087643823.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:09 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:15:17 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.overlayfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/804382d59b81b331735d37a18149ea0d36d5936a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

