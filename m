Return-Path: <linux-fsdevel+bounces-31612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AFE998E56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6445282C97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA55519CD19;
	Thu, 10 Oct 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DplVWwMw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B0218950A;
	Thu, 10 Oct 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581447; cv=none; b=ezP9wpNaUhBgyP2ID6a/9dMhDVHgbbkc2m0ZnP3XARQ/tjxs09sdI6jmE2mK9pUvvL7U2v5SdUKDWusxx/R8bgIy9FaLjAhO22mIasHpDNslUfxI1YAz/xgq33I6VsveoTixhfyuFMzldTKZ0JX4tNZao5kG5YAuPRzqiqUbjvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581447; c=relaxed/simple;
	bh=/z1T9tIcpm4srMtYLMyoJeqAkRkNdxlrTcVmmgQYX74=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WVeyl4l6Gl8sbluILADAo+NLq9ynimNwLiTnpsGUtzLEn5xWjfug12Jb8JABkK/ZKQTNIqZHXXonLXVXbzsTvYGUm+tf5A8teuxEhpgDASv6O8kVeIsOQWqXaC3z96bNrrD3BBc+Vrty9nMMJ/VAUuD6XJgUWgEpnm1FQ/eKOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DplVWwMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169A8C4CEC5;
	Thu, 10 Oct 2024 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728581447;
	bh=/z1T9tIcpm4srMtYLMyoJeqAkRkNdxlrTcVmmgQYX74=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DplVWwMw8azmyDZQSSUR7ppZSQly3hAIBvc5smXbalb0D0xnoA8OKvSiSAPM17zec
	 GeT9WN48vluZ648fxK3szpwodId8Wf9lYdhFnbxTB3AT/7mNOZ2lPKOU4021jLY9gN
	 FEj1suMIwtHXdLM2UCMExRYtTLDb3DYvSfutmqskuuF1PtUzCyJkoyieury16bnni9
	 Uh+yWV9ZNqxiRNKl8blh51s9HJx/WvqLZVC7tK9DaF++8DaaKSIgUkOhxYREAy8rJr
	 Ce+S7uAeeUqpJJ97jkFgJ6HwMPyilEvTP1f3s8SvYi1TteEoEcpUZgHwAthaBM24dg
	 SEWRTSWJApGAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD003803263;
	Thu, 10 Oct 2024 17:30:52 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ftxj7acikfuwhh2spky4jlnqdob7vjxxxtoibq5ekiriirrxy2@uer37e2phsit>
References: <ftxj7acikfuwhh2spky4jlnqdob7vjxxxtoibq5ekiriirrxy2@uer37e2phsit>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <ftxj7acikfuwhh2spky4jlnqdob7vjxxxtoibq5ekiriirrxy2@uer37e2phsit>
X-PR-Tracked-Remote: git@gitolite.kernel.org:/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-3
X-PR-Tracked-Commit-Id: 77bfe1b11ea0c0c4b0ce19b742cd1aa82f60e45d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 825ec756afeeb082395ac6430e7b07e3a9997665
Message-Id: <172858145124.2105267.6284326128949184803.pr-tracker-bot@kernel.org>
Date: Thu, 10 Oct 2024 17:30:51 +0000
To: Carlos Maiolino <cem@kernel.org>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Oct 2024 13:35:47 +0200:

> git@gitolite.kernel.org:/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/825ec756afeeb082395ac6430e7b07e3a9997665

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

