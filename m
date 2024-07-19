Return-Path: <linux-fsdevel+bounces-23981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606799371C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 03:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924981C21614
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 01:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB384A3E;
	Fri, 19 Jul 2024 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRYHyRxl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDC2566;
	Fri, 19 Jul 2024 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721351068; cv=none; b=laecTvVkjKKvZJl6ERIIfwIHtck4c8OfBQPgRVMec2wFt3C8v+DYX8kqJu2jRHgYuEU0qdTJcTKE9Z66Lw8rXlR6/wPo7K/1j2zxPHzvnNy5Rpl4OoD3R9uoK4cpRl+rC77YWue1CD8H4XyWYUoEwyEa/KSidVIat3EMCjkEALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721351068; c=relaxed/simple;
	bh=s798piAQNM2Bc1yHhap6eSETjKc865eteOVR8y8wUa0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Lcn0PUQ+tHgyhVBpzVTiAcIrvdscvjZrQ7q9OD9giAJWMe7cjaRQ3WAHy2jy5CE1Ih79BhNqqZJBh6dlata3Ype6Q1uDdqSIJcatV4oQ4PvVzqZ8KyKozuXMUFNqSBIRhrBcaJMuQkZH531iijOPVrkPnpehOx0njJg8sFCw7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRYHyRxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5B36C116B1;
	Fri, 19 Jul 2024 01:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721351067;
	bh=s798piAQNM2Bc1yHhap6eSETjKc865eteOVR8y8wUa0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sRYHyRxlDlG2ZwJInOoO0oc790Bcmgg+F9FJ2COTkKRBJ2a5mtYNiyStqexpYn0ud
	 dMw2uP34s2G5X3U0EhmD1Lo6TTgARZL73KwLekGwV9C7fCoaUBE3/gqkCHQhHsDiYY
	 V6Du0x7TsOtlQ9tqf/RepH+pK/epjX5JIjgQZtlOT7Xqsc54Y49xtLLNwh9lN02q/7
	 7BurZ23YXFbbhlxW2goC6OUQ0HBTQ76BrsU2hOxNPpf7JeMPMnr0qNPeFHJh14pXPI
	 k2amaKnfUFViP0/Uuw87FrEpDkfLymXtfv8EFmfGYCpqLLhgTQYjYulnh5mJg3O8oR
	 ooSOS7xKEk9mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC9DCC43443;
	Fri, 19 Jul 2024 01:04:27 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs changes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-14
X-PR-Tracked-Commit-Id: efb2018e4d238cc205690ac62c0917d60d291e66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e118ba36d56acf78084518dfb7cb53b1d417da0
Message-Id: <172135106776.16878.16159462005463558263.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 01:04:27 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 21:26:30 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e118ba36d56acf78084518dfb7cb53b1d417da0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

