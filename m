Return-Path: <linux-fsdevel+bounces-58334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24704B2CA9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 19:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4840A5A6E3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7642A2E22BC;
	Tue, 19 Aug 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUyBlaIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D6255F31;
	Tue, 19 Aug 2025 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624818; cv=none; b=Ex5JJRY/07P5jA0/mRQSEmActxpVqvgC0cL5sfcb8aEqP/QWgLtPNSWm1vVOOAMdYI5InpQlLPBNG11Hycf7TDrCy6do7scCFHSYuLA+nsBPjwD0pJaXaCqjlaICZ9BvDkB6V+Fc9mUvXpFVRL15Cj638SckC8oyc4KCRA3bnuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624818; c=relaxed/simple;
	bh=L84S1KtXWdqA6M1nGKA5+wCQ5JD1fy2xx9oxSfrb390=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LpA1NadTZoSLX1w121sYq4P55gHpZ9noTCFQRgiWD2A5+LqdsP6A8Vkh2AGyGOSNQcr9mm4mdRCgwSpBkWwTuWshn929dvAXniKC5EGJA59vkUZclDDkxLEQOwRnRXRGKQsfMkqaeUupibMJ/knhAV7vUm0kiODGLz93DhnMF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUyBlaIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56121C4CEF1;
	Tue, 19 Aug 2025 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755624815;
	bh=L84S1KtXWdqA6M1nGKA5+wCQ5JD1fy2xx9oxSfrb390=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qUyBlaIMEQY0x3xHB45H/Dqjlmu5XJvq1+wV3ku+1CcjPdcl5uh7DFoR06xd6jRRO
	 kXhHv2Lu7Fh9u3wN18xhulxmANr/puKiwHeonqF0j6L1HgiqYdpdq5LjR6VB9q/hNb
	 gqT7NkL/tEytlqXykvBHpecWGpZ8FjEsIR6D8lB1x6OQqJUNsCfj86ES+qZKdfqL+N
	 g4VxfYTG2dQLU7KzPdn2lr/eL8N+W4AFP/tFhQ5ugT0A6qGVPNvN2+x1dKL3VeMK2X
	 aoT8nNhJKR6IL39Zs5PIBnDX22IzQMKJRAzl5c4eFuedsg4weaVkjU+9pF75Hi6b19
	 LkqP37gYUTNZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E69383BF58;
	Tue, 19 Aug 2025 17:33:46 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250819151933.681698-1-amir73il@gmail.com>
References: <20250819151933.681698-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250819151933.681698-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.17-rc1
X-PR-Tracked-Commit-Id: e8bd877fb76bb9f35253e8f41ce0c772269934dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cca555b94a2191d012837a37c891eca4e876c6b
Message-Id: <175562482502.3631675.18385180455259333540.pr-tracker-bot@kernel.org>
Date: Tue, 19 Aug 2025 17:33:45 +0000
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Aug 2025 17:19:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cca555b94a2191d012837a37c891eca4e876c6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

