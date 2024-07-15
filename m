Return-Path: <linux-fsdevel+bounces-23725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E4E931BFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01485B2349A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E12144D3F;
	Mon, 15 Jul 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXjCPzY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510313D53F;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075684; cv=none; b=dUAS/CNK1fEEblGnYDWckDqz1MTfp5vt2Ao6Eh1pSZHX8AE6dpKd6nexTBLA43UmT6WZUk+rnvB8nve7bPryZ9mjek6miyhSEJ6I9SyD91bij0g8BmYgwW2PCR2IH8SpMsxjb2KuKj4bQxpwvV+4OWbOeHKdV3HNecqCx5zwAyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075684; c=relaxed/simple;
	bh=/ELGHlvbrg7OQzWh7ShApCja04aoh2uzSelh0gkAkqQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CJ/v0YlRvxNy7SATluolyBLowM7+6vO7b4UN2zGfbvRYyCYIgD/axJET2/5rt1OMpDUS5wiPZNIy1DAlnhzEi7mx9sNNvHfuY/n1wo9IAx4x0yAqVcIozSRIliNPyBydYZRz4gGxRMcKTB6t7WHj9CcFIpq5XAENlGgXul9kLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXjCPzY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69C73C4AF0F;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721075684;
	bh=/ELGHlvbrg7OQzWh7ShApCja04aoh2uzSelh0gkAkqQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MXjCPzY7HFaEB8pxYIxwmkFHVnm1yzaRBOBF3LpC8ltTwfqQjhPSoww6/NjzwIXCq
	 Tv2Q05whXILW0KdRJJ0rZzaeqijp6B5SLyBG4Psyq2WlPoyFLvDG/blj4ZWoTPuEfI
	 pFglvRiTlSmCjs7SUQqPq3/FGaFisnZk+ChNzhaJY2JYZU2ZflpYeVzQIG+0FJ9A9J
	 Qq7hPxyqo3OptL569cXg39X+gqI7iZy5slLC2oE1iVRJYm1HlFPjokrUJ7yDj1gymx
	 aC/w7Ov1KrvldtCmjSjmeHUCrrYntS5zjzXMGxncSZVlzodnNWe01FE/TngBwkBEHH
	 MoTkQfarQMxQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 516E7C43443;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Subject: Re: [GIT PULL for v6.11] vfs iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712-vfs-iomap-8b6a04cb891d@brauner>
References: <20240712-vfs-iomap-8b6a04cb891d@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712-vfs-iomap-8b6a04cb891d@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.iomap
X-PR-Tracked-Commit-Id: 602f09f4029c7b5e1a2f44a7651ac8922a904a1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f5e249ec0ea8872e1644df23cffffbe28007188
Message-Id: <172107568432.4128.3325077186088294238.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 20:34:44 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 16:03:24 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f5e249ec0ea8872e1644df23cffffbe28007188

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

