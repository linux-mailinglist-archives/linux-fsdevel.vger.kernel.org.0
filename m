Return-Path: <linux-fsdevel+bounces-71689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85409CCD9BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 21:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CA5E30DB89E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 20:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2D3329C6A;
	Thu, 18 Dec 2025 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfpBQZaO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926522E1C7C
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090577; cv=none; b=tsIMUMOaPfShZEzhZMYyaILfCr5hO8/o4bM5m+QnwpWQiax5Pe3bzUqyrh2FLLrDhPTkDCveLNM+DFqR5J7RlvhwzVgDdm4nXZxI1NbP7ZrLynMsS+HQTac6Fy6TO3VfwceZsqRr4YCLDjf6K2+cvX1/U+/HGcet2Rx5NuPt6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090577; c=relaxed/simple;
	bh=j7Gjmq7ZK7hub2aQrVzsRyRT7LERd7/w4sNbl4dxIac=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=acVoWUnnS13TYxhbCbMItvse+im1rLNmELYMs4en2nNg1l8uP4xz7HUnCY7CxxTdMwWp1+ULgQbdaNLQUr8OlQ9//pasieWFjBf7q5cYzVD29lih2x0u9DGSWHIfTjQ+Cemv1rOwuYr9ltaAHEdMGo41Om49XCh8xP5P8UeCzgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfpBQZaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B51C113D0;
	Thu, 18 Dec 2025 20:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090577;
	bh=j7Gjmq7ZK7hub2aQrVzsRyRT7LERd7/w4sNbl4dxIac=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UfpBQZaONkXQMdXrp/kmpxQtpNLN7kPpMtu6+7HqSgx9NopOCmlzzVbzEHZ7RedTj
	 gQ9nehmtrykjCacQldPqHSvfz037tna3T6niUxtNHLG0zbQp/AfOTUFM3GNCxvH8xO
	 pH/3iezYVf7gbRi2UJyzPF7V5Kw2y7egNNivmLj54ybYyhDde6VU4m8WOfvgYe6JTF
	 9Ffed53LFz1g3XcJ37Igplwn139fNMQlabops3aORKie5pc9jJfLQsDxz7GlDzAnb8
	 yK5gOnrkpbPh4hZQpRHOQFAEWMOEq6e+mJB91A+bRunF2P4poFw9E8xNmz144ooE7q
	 SIyz77Wh0Zjgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2C94380AA41;
	Thu, 18 Dec 2025 20:39:47 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify fixes for 6.19-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <27rvclbkoz52xjo4m5zmigtcoke4nbr3lfvfnnqr6pemxulsac@a3lngmry2dy4>
References: <27rvclbkoz52xjo4m5zmigtcoke4nbr3lfvfnnqr6pemxulsac@a3lngmry2dy4>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <27rvclbkoz52xjo4m5zmigtcoke4nbr3lfvfnnqr6pemxulsac@a3lngmry2dy4>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.19-rc2
X-PR-Tracked-Commit-Id: 6f7c877cc397ba3c6d8ba44d4a604df3d4182eec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a903e6d9649e45cee9a8588fa3793fdfc5408ee
Message-Id: <176609038646.3123765.16769054178157082648.pr-tracker-bot@kernel.org>
Date: Thu, 18 Dec 2025 20:39:46 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Dec 2025 17:18:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a903e6d9649e45cee9a8588fa3793fdfc5408ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

