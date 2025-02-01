Return-Path: <linux-fsdevel+bounces-40542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09327A24C23
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 00:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEAF188500A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 23:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400D1C32FE;
	Sat,  1 Feb 2025 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkFOQY0m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD6147C86
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Feb 2025 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738452289; cv=none; b=bdRJRaJjAM8FhGQpDi31NEzMzYGlF/tkh/mzbi7KE20M7guOx1UECRqMrwYzxJMvhMwHbcFCxMHUBwuAn89iMZs5XQn0f0ErqCqGN7ihGVtXmuUg8PiPVbXrt/EftXx5YhxdIzYpjHksx5PoEZ2QJ8P1qj5O+inMJbC4iMeQOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738452289; c=relaxed/simple;
	bh=BbZN86kcXIVCff1sJfypdEBGu0T/mbJbgMGGFOcTqp4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VM03NS3FNoDCRGdsxpVn/cQNPliYab0HsbwfVlliNJ2rU5DHVocDjT/HY7YJ4/880hgRsLLv6DoafzG+UymYFiZ6yFXMZpyta49+ktOLxtgiHDhHVTSVlEBLiOK2sCB6aZjHlFBSyPgljTgqaodlVBui2hNCrB33m8v2Fc32fFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkFOQY0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F278C4CED3;
	Sat,  1 Feb 2025 23:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738452289;
	bh=BbZN86kcXIVCff1sJfypdEBGu0T/mbJbgMGGFOcTqp4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JkFOQY0mHxww3yYGwD4ODe1KzCY2GBqo7NU2xxZkU1bPDD2JtR3Gafupo9QDcM55j
	 sPbEX4O3GbUpQfglF9uIFvIDyQetw40Z+MQdJ6d9ReQn2wbhXreviJedg3ek9xOizr
	 k4Mbg5qa733C+qus7oE83dJtn3YJX0/30pKG8UKPqVxzz7EM79khS6s4mnDn1afWK3
	 SavdblNyfAyumlCJxChf/K0/nbhTgxdU2ZZh3rqA8Z/73EWt2w90W2yG7bsMp4HkFm
	 k80r1OgGlSdE6EJr59U5+mM0ESOF4aYT5U7z92QqTkqxjTRJUm3KbKlb+sz5ntc414
	 +bMPAYwXJK4CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34597380AA68;
	Sat,  1 Feb 2025 23:25:17 +0000 (UTC)
Subject: Re: [git pull] a couple of misc vfs patches
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250201225651.GZ1977892@ZenIV>
References: <20250201225651.GZ1977892@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250201225651.GZ1977892@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc
X-PR-Tracked-Commit-Id: c1feab95e0b2e9fce7e4f4b2739baf40d84543af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a86bf2283d2c9769205407e2b54777c03d012939
Message-Id: <173845231580.2011566.5476457243107589549.pr-tracker-bot@kernel.org>
Date: Sat, 01 Feb 2025 23:25:15 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 1 Feb 2025 22:56:51 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a86bf2283d2c9769205407e2b54777c03d012939

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

