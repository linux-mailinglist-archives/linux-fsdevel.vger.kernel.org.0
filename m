Return-Path: <linux-fsdevel+bounces-29441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79B5979C15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 09:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8801F23C38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C026F1442F2;
	Mon, 16 Sep 2024 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7LHMieU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF213DDDF;
	Mon, 16 Sep 2024 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472078; cv=none; b=d63foD+zJfMohitt5TDbzWEG0YexzmDJlXGlYXcrlsXuU+doGt93BpIXvswgCVCIatI3EJw4u9/nRLUxJueOkDHwN7/3J9dahWjo9iMmYO+cE1TSrNGG3UjkN6gfPFRJoGNAnD5DKI/YiEFT/rJRx8Q/uxRWlCACG/lG4fCPW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472078; c=relaxed/simple;
	bh=Wz1dQJclHGv1Te71syaNM7Q5vubxqdGW1c2bWXJw9As=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Hf+VRdBowoC3d7gVGOV1Uu1M+GzHNItNbewhazboBM8PgZyqTnqFiiEg3YMb4rk+wYN4Pa/aEbgn54XaJuUW82TmTlpATqWKdXSMR4LzIgaZNL6+Or7kebUt4T10sbN9p/3e4/9b/oDAtrhq0e/am9+NFaMuDZBtREvnW3f7FVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7LHMieU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22E6C4CEC4;
	Mon, 16 Sep 2024 07:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726472077;
	bh=Wz1dQJclHGv1Te71syaNM7Q5vubxqdGW1c2bWXJw9As=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K7LHMieU1qYEIckU4y6aeiMeuVB6Xtrgwmi826/s6yTk8/3bp54Ol6aM/3ug3uw6w
	 Rv6ut6yfWo94spTQm7tuHBzmS9asU5EWfPlgutYBiaYQI7SuTlBObCOkJov4+Fu2eM
	 RJX+gOOcJX/URz1BuGPcGKZZ/jRsADOsENV7kELJyWttblBxJgsSvnzXum/1fdZCx3
	 4c1irjRR0PSfHMp4dyow+NlYZl7tHa0YtZKQOLbhczMCH7YJkVJeFB7gXJeBt98MBC
	 LGeSIhHiXzZuGbFEOEafJYpZwpq4EGswIz5NnkiZQI9316XlEegCv95MkoZi9LXDgY
	 syyzG/1JPGYQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC313809A80;
	Mon, 16 Sep 2024 07:34:40 +0000 (UTC)
Subject: Re: [GIT PULL] vfs folio
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240913-vfs-folio-b8a42a052abc@brauner>
References: <20240913-vfs-folio-b8a42a052abc@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240913-vfs-folio-b8a42a052abc@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.folio
X-PR-Tracked-Commit-Id: 84e0e03b308816a48c67f6da2168fcea6d49eda8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2775df6e5e324be9dc375f7db2c8d3042df72bbf
Message-Id: <172647207939.3286942.5510774935404338522.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 07:34:39 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 16:42:31 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.folio

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2775df6e5e324be9dc375f7db2c8d3042df72bbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

