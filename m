Return-Path: <linux-fsdevel+bounces-39737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D4A17356
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B57A048D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4086D1F03DF;
	Mon, 20 Jan 2025 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ4XQ2w/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AA1F03C9;
	Mon, 20 Jan 2025 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402659; cv=none; b=E2F9yMhjk5YNfqKvoF92jp/czTKeWd9prHhRUfy8R6FkvDCwdJwb96zvrHu4Ey+DrxsxDAbvDsS+lwLaREn/I089VOVme+wM0Zynb4dp6MDvF73XSiSeGBB3pl3cpLhZNf3CpSRL9nHK+jCOmyhoz0vfY2cp2Fh5Vt0Qj5uIods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402659; c=relaxed/simple;
	bh=4qSQMxf6la+0v85LsLuo44gZ1XR5gFRuZ1W+6i2u3Jo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fzZa/fBddhbMcVFI1OoYdeEDj+ia7qidwwhQrfoLaiaIRhzlaX8zeNro7N0yMNYzEwe2OQ0R1EybpuvGlWPoF0LQKCb+OeRVzoqI+6fUlTPeXRQIPva4GSSa1Vyox8OqDOIDSdalKd9pf2UB3L7Ql9ZEv/qMpDwhFsjd5vjHHxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ4XQ2w/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F05BC4CEDD;
	Mon, 20 Jan 2025 19:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737402659;
	bh=4qSQMxf6la+0v85LsLuo44gZ1XR5gFRuZ1W+6i2u3Jo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mZ4XQ2w//ZDDi66IO3KFGdZ9oAe6XSCet6sIDGAHdDLPf4a4twZFRpwVVGyXwsVRp
	 nk7qtHFaU4DlARJrQ79rXt2pOtiPLessQ9gbITcushZyCjbEig9/MGMbeHqPkGDHYm
	 eZR9LHw5NP5JcfaWkPkEQWyE2go4vrP8LKAHPlIEv00xdbxSP5MlND8jaNOkMOSOE4
	 5cbL7LEEAIvSvCi9HVD8dNpX/cMN52vgTreMhQ7Z/QkjsoSJ47ngLy6bIoVYDPUxTN
	 CKLxKm0Rg4VNjp1aUmxjWBRpGLMwroJ4wnvvRNpkiglnmGEjDLMhTSk9au4Xd6V23i
	 UvV3Bg2UAmOmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9F380AA62;
	Mon, 20 Jan 2025 19:51:24 +0000 (UTC)
Subject: Re: [GIT PULL] vfs dio
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250118-vfs-dio-3ca805947186@brauner>
References: <20250118-vfs-dio-3ca805947186@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250118-vfs-dio-3ca805947186@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.statx.dio
X-PR-Tracked-Commit-Id: cf40ebb2ed9fde24195260637e00e47a6f0e7c15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47c9f2b3c838a33552dbd41db6c5d93377842fcd
Message-Id: <173740268331.3634157.61326954291380127.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 19:51:23 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 14:09:26 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.statx.dio

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47c9f2b3c838a33552dbd41db6c5d93377842fcd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

