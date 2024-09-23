Return-Path: <linux-fsdevel+bounces-29892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47D597F111
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 21:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5918EB22C96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230451A2579;
	Mon, 23 Sep 2024 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGGc7zoR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA91A00E7;
	Mon, 23 Sep 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118376; cv=none; b=G7UwElorTa19G4rTFTdbWTmz1tQa18i4Yl7gWFL35iPEV6BLPnrafusD7NHPCspgrYDyWrYNg8pFc0K9SBG6Bsvo1+DsFnVgGE7l7zm8+S+6cxjucVZdwiUnJVAcDkO3UroWWBBAhDpOIRAt17Iq8bH8peZPV174Bw5udzkcLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118376; c=relaxed/simple;
	bh=y+8gamuc4xg+JyHdtciIiP3Ete7/iFKZZQsSjGWvjJA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JyQ2aHyRKZZaaDdYM8cP0VSclarKuWP2yiczxh9ohvG6CHSMWZkbqOhGkdVI0etiks0krTk4B2H94eMTSB+dXowa/C7JyghlsBnT6k0Pbjvq/DFFbtYg6OPIakM6it05WfnaRYZ9L3jNjIpCCf6TvMjS5xlqajSNIa9cU9HBf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGGc7zoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0D2C4CECE;
	Mon, 23 Sep 2024 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118376;
	bh=y+8gamuc4xg+JyHdtciIiP3Ete7/iFKZZQsSjGWvjJA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JGGc7zoRk4Z3yvebc10e30CUsGO/Vd1efApRswxcs2kh/pZxB/3KlLDHReNtZDTd6
	 SMemw5G6zd2l8eJfAmUNp6X0Ice7RcjpFAnS7TH05j0v2asdMFuw0J119pIlF1JDPv
	 A0fhVsX9xOrWCHbeyMcz3jK2DZhmvTTs2Stz9Qf4ly9odFz0cDB1MJl3V5neiCtTzr
	 +a8nxhnorO6eUowgf+2fzQ2ktwe9inuyWqVagjCoL6yG5PvlqyAsdwkpWMUmtQ/vGE
	 85c0ConLIFugctbSa1hSL2i0Ac5wBrep2sOhx+85xtEItIna4iUysRV6abBeepHRM0
	 8DiH9fy5mnrZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2833809A8F;
	Mon, 23 Sep 2024 19:06:19 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-09-21
X-PR-Tracked-Commit-Id: 025c55a4c7f11ea38521c6e797f3192ad8768c93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3f391fddf3cfaadda59ec8da8fd17f4520bbf42
Message-Id: <172711837863.3454481.15520403556154046954.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 19:06:18 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 21 Sep 2024 15:27:58 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-09-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3f391fddf3cfaadda59ec8da8fd17f4520bbf42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

