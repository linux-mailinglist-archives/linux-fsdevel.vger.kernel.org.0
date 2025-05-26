Return-Path: <linux-fsdevel+bounces-49865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA56BAC43C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 20:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B73D189B4C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F319D24166A;
	Mon, 26 May 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcBovhB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAEF241116;
	Mon, 26 May 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284522; cv=none; b=NjqbcI7o3jaRrayZEKPv3iXMlbSxZWMnT+5HodifJDo+M+huBfPPmb5yZErnfENTGzz4iVJ+uQjYG1qDA2FSIcghGIHjjpARML1sUzyybGNucMP7KlOoWeQ/jzW61ACe7rry1OaGPyZxl4eQIZ7yqab3wqXyWcSr0oSpc2qOe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284522; c=relaxed/simple;
	bh=/sFtDUQ2LtYGAjDOYUcR/0ywZwK0QAf5jZIoYCSHnVI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dxitQzHS4q1VLCHtVsKBKzjhiA0+ZivLEJyzBkQThuxgStpT5MZKuND59qr9OT8Lh1MsMwDOAZjcND5EN3Y2QIbWSGMkEGxpNNoNg99fdDVx3dMrvw1XodOr0Y+IQYbICpO/TGFoxEnupBNDsssS5ZKcCpxObVXul2+/AZwL+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcBovhB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36914C4CEE7;
	Mon, 26 May 2025 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748284522;
	bh=/sFtDUQ2LtYGAjDOYUcR/0ywZwK0QAf5jZIoYCSHnVI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UcBovhB5Taw6Av+jntsqNfTN8zroNMfWE4YBwf5P3qyL8yAj9iPNUUpbK3pOXif2N
	 S3i8uxpQMIZhRy1EHZ3n2nt5T2Pb8ZWTlwMDSD9BbKIFY1qCT8GsAXpRGc44F+SpSU
	 LTbQ3j3McobK6z5CMjKDA4lVmaB4dHBiI1MFpJtcJJ0h3AoTBg0ugwkDRXnbZJcq65
	 dcQ33vXWGxU04KfPp7ci/0dFdIeEJrNw+m/bWlUZOpuEIP/9JGUcc5dIVX8+YeR1rW
	 qUfv8dErd8xI8q+gue1zP4iWK5liH8hJfXtF+HQdlylQRX4bK5CcMZjtir4VPJ13Je
	 zFhSPKGvixRWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC5B3805D8E;
	Mon, 26 May 2025 18:35:57 +0000 (UTC)
Subject: Re: [GIT PULL for v6.16] vfs writepages
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250523-vfs-writepages-edcd7e528060@brauner>
References: <20250523-vfs-writepages-edcd7e528060@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250523-vfs-writepages-edcd7e528060@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.writepage
X-PR-Tracked-Commit-Id: fb5a381d624bf6ad3dc2541387feb5d835e1f377
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc762851444b32057709cb40e7cdb3054e60b646
Message-Id: <174828455660.1005018.10129203099378466009.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 18:35:56 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 14:39:39 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.writepage

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc762851444b32057709cb40e7cdb3054e60b646

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

