Return-Path: <linux-fsdevel+bounces-49872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A80AC43D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 20:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257CE17A573
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB922472BF;
	Mon, 26 May 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixm9YRfP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146BD2472A5;
	Mon, 26 May 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284533; cv=none; b=q3V6MbWbYsjmLMYnL1pbhqJubIFKZfnFXK1Gqm17Vj5rnNz9a0HXi7k4vACpNmb9ROO2CFr/OFU3mXPVOKNIiEbiveeUSuHlRltCzMQuc5R8/YZ8qW35Qxydk4ncH73Dp8FxZ9ZugW4DhdmoEwMfbtkwtRaM5TkZTt1hVZRhE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284533; c=relaxed/simple;
	bh=cA6nrWrpPdmb6O9jtq9PuVWDbCLXGN/URo7TkHdA+A4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VV7mYoW+xtt+n7whstMoNwczyrp9z3buAeq269cqCdCtD5qGT22DEdIqyeJwJ9wn4UPo4uwIeVxIVHydIkpfsJn0xNPN/kMHgtv/jqX2Nn2kaux1CndoDK3WTJhQKBxymUtjk+A79sIxf2k8/fWg0r08IQTNVXFBCJbMu5BiN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ixm9YRfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED470C4CEE7;
	Mon, 26 May 2025 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748284533;
	bh=cA6nrWrpPdmb6O9jtq9PuVWDbCLXGN/URo7TkHdA+A4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ixm9YRfPf2m0ZB63QMHE+Bxvf5BEvCL3h+nwJ61NiuvZEIg1PLN5h34nJdpnpnOuq
	 kS5U0HB0W7P1oIeraa/igIZ38vbbH3D/N4K15Zc2hp7KeAShOwGudq8n78XhpMOH19
	 tU36f7OhJmofpDah4VPvsHNwentM+n8mBXlkpSmsiI0ZmAheWuwYFVF09HpqJs2W9I
	 j80FU51lt7cisTS5ryfdup/ITn/WfqKwmGUUdJhMUlmKZ1/jnf1ci/q17HLGHgAevO
	 C3tvF/QDfUEaWy1YXIpMXcjsQp2zVoxSGGNBis1dQEfQd/SetwAy/tbNJ+kzNOHKT6
	 cTmTW4RLNCNQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBF53805D8E;
	Mon, 26 May 2025 18:36:08 +0000 (UTC)
Subject: Re: [GIT PULL for v6.16] vfs selftests
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250523-vfs-selftests-0c172b9ac74f@brauner>
References: <20250523-vfs-selftests-0c172b9ac74f@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250523-vfs-selftests-0c172b9ac74f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.selftests
X-PR-Tracked-Commit-Id: 7ec091c55986423b6460604a6921e441e23d68c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e406741b19890c3d8a2ed126aa7c23b106ca9e1
Message-Id: <174828456711.1005018.16684453085555724779.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 18:36:07 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 14:49:41 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.selftests

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e406741b19890c3d8a2ed126aa7c23b106ca9e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

