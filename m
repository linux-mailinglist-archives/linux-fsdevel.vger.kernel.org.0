Return-Path: <linux-fsdevel+bounces-21580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72246906064
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 03:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BED31F2242D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 01:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69825DDB1;
	Thu, 13 Jun 2024 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCyIle8Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D68F68;
	Thu, 13 Jun 2024 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242017; cv=none; b=cRnZaqST+ivo2ufg/A9IX1VWQ9xX7AhsdNdroQPzhnekzDoL/tnHUgwmXCx31g+gIzf7dlcGD0Yuxs79/WLQ8uE6wRhagJe8rDDD91knD2e9saokVaiN0f93uzOR2OR8m6YeK5mMRd8KwXHb0meObppW0KGeVBuqzAge4T3Zt9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242017; c=relaxed/simple;
	bh=2H5oJTv6w6kgHeAs/qhW+3Paxsuyj4tXw2D7jdW7oFc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tooCWCJ2DaEr4SHcoGigPBHjoico5MOA/SN7AELyR/8hNmdsuOdA0z+FUOxKNaR6McwxVMsJo5SWZ8g4YSXgGCWlJZKKUBTVf/9fOoHphDYJZurflBcDAf+BwMTMBrYJaEe9Gk4XrP1t7hnc9IKbmiDgNTcOdswe84JSCLa4DLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCyIle8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E68DC116B1;
	Thu, 13 Jun 2024 01:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718242017;
	bh=2H5oJTv6w6kgHeAs/qhW+3Paxsuyj4tXw2D7jdW7oFc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OCyIle8QG6V3dgBjJB5+/+1l72QgyKlWvVbW6uievPuvgWK2zQKbOEqfObD9nhYa9
	 c3EJ67CnIj0/+/p1ccPsCHi4buADlh8kupJsqggs1aVyS8J5YGiEyLan/9aeoCIizb
	 Wz6qKh19/N47zk1u/NdaI3Z7Pd7Y9c49fFJWfltbQuxVJCgRvH3n5EkaHi0Z//nCgm
	 KOzQTrmzpcXgUPhXrbCcMWmo9xtHrue10HqLdlyWpfBGndcffJqwvnr/pdmoMSgIY2
	 GE6yiGG+vhKtRZnNCZuihH9MdrMnVsOuvhzsYLwgIFLMhc8JyaFIJGjTfZQAi1iyem
	 KEgnCMvnbGQpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54FEDC43619;
	Thu, 13 Jun 2024 01:26:57 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <6pkst4l27qb7asdlg47jy6zycvvse45ienwiybqgjtc47fs4so@f6ahc5rwgv46>
References: <6pkst4l27qb7asdlg47jy6zycvvse45ienwiybqgjtc47fs4so@f6ahc5rwgv46>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <6pkst4l27qb7asdlg47jy6zycvvse45ienwiybqgjtc47fs4so@f6ahc5rwgv46>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-12
X-PR-Tracked-Commit-Id: f2736b9c791a126ecb9cfc1aef1c7b4152b66e2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b4989ebe8a608c68d5ec54d61078aba47baed22
Message-Id: <171824201733.11093.16315076541701337098.pr-tracker-bot@kernel.org>
Date: Thu, 13 Jun 2024 01:26:57 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 12 Jun 2024 16:21:22 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b4989ebe8a608c68d5ec54d61078aba47baed22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

