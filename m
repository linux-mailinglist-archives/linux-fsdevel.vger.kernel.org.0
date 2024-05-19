Return-Path: <linux-fsdevel+bounces-19727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2588C96BC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 23:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8171B20A7D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81EE71B40;
	Sun, 19 May 2024 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrF2eR3o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCBE70CC9;
	Sun, 19 May 2024 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716153468; cv=none; b=ZNOKynT8m4CmiHXxIQwxJDJnqk4TtyKi8TEvcOBiN1V9yvXMDkNV9S5aCBm1JsRMvlqGD6EnMjUNN6l6xxf0zqbaKzV6nCsn2eoLqTduR9YGFHgJ9cVdZ+d4xWdmFj78xu1CJlJ5SBLWnG70yiSKAVU0KG8jsilgF6qlqotVOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716153468; c=relaxed/simple;
	bh=L9EV97sPt9xWQQld3xm0ssIxE9A+ASUKZG/lw+C6kNA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=thp2xgdIpLKehnAuDWYtKVLt2FK0/lra6IczKtRXq8pb6NAtJ/nZPQsyxzsHTLe7bCnBhxZaL5Bvn7D3/LkQBtfDchkBdan1cHYF3Owg8P0dZjxLY8QTpHUKZ5vvtLqwCHvggbzEp/lR0SMZvqScGjpoyX6Ij3Q1wWFzu6J/0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrF2eR3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E196C32781;
	Sun, 19 May 2024 21:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716153468;
	bh=L9EV97sPt9xWQQld3xm0ssIxE9A+ASUKZG/lw+C6kNA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hrF2eR3oMjIfn2eWQIXWjbCXqh6PGkVLyVdcLzv1A1icDk7umwb8gvZPLvaZPDK34
	 eF/d+ltuZwtqeRkQ7p647x9WGWhIgrjhOxP6ZtnenxlDdnkkrw6zzi88rMeEur4iHO
	 aRCYArfdyESUibgk8GnRs07dQ/HfapNgSg6CXzrMr5f94PPMjW8/1dMAMrIYTtaj7o
	 RdGIzCs17VxijH18uzQzCL0PxnrzVPixUX6FxU5a/gjI1DcI62rGRHvKf7ZlCUpeKt
	 szntOI4OjZvfYNjqc4OSjA/umjZSbMFT3EMwUSHJPUgqVUkeF2aue/SyCnLxTohWjU
	 QBxNCqIYQR5/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 060A3C54BB7;
	Sun, 19 May 2024 21:17:48 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs updates fro 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>
References: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-05-19
X-PR-Tracked-Commit-Id: 07f9a27f1969764d11374942961d51fee0ab628f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16dbfae867cdeb32f3d24cea81193793d5decc61
Message-Id: <171615346802.27435.6337486479236696488.pr-tracker-bot@kernel.org>
Date: Sun, 19 May 2024 21:17:48 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 19 May 2024 12:14:34 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-05-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16dbfae867cdeb32f3d24cea81193793d5decc61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

