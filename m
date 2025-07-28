Return-Path: <linux-fsdevel+bounces-56213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2EB144ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0191F3A7D66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01544288CB1;
	Mon, 28 Jul 2025 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrQSduQB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F58288CAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746050; cv=none; b=K4NasaXTltkKAU9fEw1KXA8g6PObtb29VcyTyW21rFLx8x0BUbKXdGX6nPZwvmTDce1qSENCkL9JbwN4i4v/v4gfHr5HyMoVTB5ZTiEnPDJ98RmaBJ05+khLRqutaJjf7Y871abF/vB1sAZpCY6zCOmZLxCPhZsaRAgxYFWBaPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746050; c=relaxed/simple;
	bh=Iw1EotByz2+MxVTb6VSNT4+TOMCyoP062hqhvMXMo34=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qOUG8xYFQK/BH/MzydXJCRq6SfWhJf295E/fp5QX/nTNxUB6C6xDM5nE2F0bcM9DvRsvFHsK8FXFikvg+dsKS4tNy3uwemFp9my3O9qvezneSp9j8056s8Rg61MgD+gMdm8aCXhic4FmLiy0rF2txIThlTJzgy9wp9wkm/kRpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrQSduQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4840CC4CEF7;
	Mon, 28 Jul 2025 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746050;
	bh=Iw1EotByz2+MxVTb6VSNT4+TOMCyoP062hqhvMXMo34=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OrQSduQBwP1smifxj1NmzAKUfEPIKfclBSy8kAavFVNx3qMZi1KjKl4pwgqnek1Ei
	 aRTKyASPcaBH+9d0WwMSIQkTj2uvYFQO7By+ForP4LydvtJ/TsUGgKR/s8xlS+Zegn
	 3Fdeoo8ND20spRCFkP5lQBxhuBQDqrGmF1UtP8nC4X0eYorSBaoIaWO3B9LcFz0LMH
	 8ITHVlTBMo5Bk1uMLIlZaRwHCrImbCHkEff9UNb245HQVJhsZsDIaPYyv8XUU+27MR
	 7NujKGpw3GyYkQdQJZTB/oiUCloDkOPJ0hoBNO5iTCCk2J2iLWeo4jQMv+DXNL9yp8
	 h/Z5RJiKf+ErQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 18D36383BF60;
	Mon, 28 Jul 2025 23:41:08 +0000 (UTC)
Subject: Re: [git pull][6.17] vfs.git 5/9: securityfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250726080513.GD1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV> <20250726080513.GD1456602@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250726080513.GD1456602@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-securityfs
X-PR-Tracked-Commit-Id: f42b8d78dee77107245ec5beee3eb01915bcae7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8297b790c65d17544d8298cb81a46f67348c6267
Message-Id: <175374606688.885311.13944544117912898370.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:06 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 09:05:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-securityfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8297b790c65d17544d8298cb81a46f67348c6267

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

