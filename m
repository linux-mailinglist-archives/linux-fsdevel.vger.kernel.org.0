Return-Path: <linux-fsdevel+bounces-32515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2AA9A7245
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 20:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38EA1C22806
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AB41FA258;
	Mon, 21 Oct 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltBY0z3Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB61F9428;
	Mon, 21 Oct 2024 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535243; cv=none; b=T2W04Rm6extXzpGQerV1wtj/WS9oslz29NMbdxtruLCEcKoCZs0PC9JNJOfti9Rk2369wtzN5Z3QDfsj4VhQA/4DC8OmBQcpec7WtZ4wqweVUvUwYSOMFGluxVquH/3a23Hdlu07vQ4zDQUVWD3quR6dBtYFATzAiZN0ma2Qg1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535243; c=relaxed/simple;
	bh=pLgA05KguI6zXJF/H2j4K/6vQs1izx35Nc+2W7HBzpA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GNMKsxyZX0++B+0a2bLJYxPzziQL1FudnX/trjlpKbh2K1uhKuvEV/7EJYl/LzvniRS/z7SFaAtuSGNDchhZNsUc9sOOM1i+NJk/s4cEaFd8rmH0hIDgaicJpjeNUbG5gGgoW24Hcrcmx3/x6+ii44WPMoBltaXPbn/wniZHzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltBY0z3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA73C4CEC3;
	Mon, 21 Oct 2024 18:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729535242;
	bh=pLgA05KguI6zXJF/H2j4K/6vQs1izx35Nc+2W7HBzpA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ltBY0z3QYCPQsbPJNdNc2KPXBjKib1ivjFp85IZYnIdSGp39n/wme6V8fnVLxnQfC
	 4EAIngZYPUpV7cgalV5RqFZRhTUsTHH3RRESmeeTEwR3sn3ALoRGklYLF5yJjzp279
	 SMuNIDrX5fq6fBMGi1xCfZ+AybFhotEhl/eZz5c1WK2MssCiTsJSY2wgEwsGQn720u
	 G4xCXY8fJJJQka7MXBOaLHmAw+6DAFNMOl9Ozy+9/7CTEb6IosrDfGIeQslfCuVCke
	 M5eb4mnPDHwabPf/XXK2Mc6Q4Z8K56CDSMqrGzY+NniRSrXD576qd/eOaZ0Qb+BKqc
	 TOHLOpuSHpipA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2053809A8A;
	Mon, 21 Oct 2024 18:27:29 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241021-vfs-fixes-cf708029ec67@brauner>
References: <20241021-vfs-fixes-cf708029ec67@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241021-vfs-fixes-cf708029ec67@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc5.fixes
X-PR-Tracked-Commit-Id: 197231da7f6a2e9884f84a4a463f53f9f491d920
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7166c32651fa2a5712215980d1b54d4b9ccca6b5
Message-Id: <172953524848.401524.10743114212363286636.pr-tracker-bot@kernel.org>
Date: Mon, 21 Oct 2024 18:27:28 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 21 Oct 2024 13:46:37 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc5.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7166c32651fa2a5712215980d1b54d4b9ccca6b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

