Return-Path: <linux-fsdevel+bounces-24366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C31593E15A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 00:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBF71C20DEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC4145026;
	Sat, 27 Jul 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeHUrouO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F73B784;
	Sat, 27 Jul 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722119877; cv=none; b=pbcMt93U9/4TGGI/lXHSiHq39sqYLQtrN3OUynVX3ZMDEMZh7bTmRO6rJ63QmpiYC03LgTBZHT25EJFVthNO/DJ9O2s7d4MzbznsBz5DmG8xXGGDNWUYk1fTIFtMhji83A5uOwEchwSPNBNdF3p2xCZfWLzwasWxggEp981ZJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722119877; c=relaxed/simple;
	bh=E+oVJrxJEtpD2oHK9jchMIaCk8lAgoG6o+eTemwg/Ms=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LZ4fp9UYxniAvx5pqY3HkI4RNCCNLQXzqYp9fwFQ+0M6sI5i2Tbvz5t5iSAi7OzRQ1BA+U1xzpWp/NeHhFdiQG3qwjxZY8mchROthE7iBRSHAOBCZJo7dGMayZTQUkHen8TujBJRxiJkv6dicznjqj7CmQ9RflmH3ohAbg2LPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeHUrouO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14B7DC32781;
	Sat, 27 Jul 2024 22:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722119877;
	bh=E+oVJrxJEtpD2oHK9jchMIaCk8lAgoG6o+eTemwg/Ms=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JeHUrouOMJpKQtMgI8UIa99KFJ7JNvzFew/P5m9C0E3qcWMlCaoZnxS0S/ZI3ioap
	 aTPH7CqMFKecn7kHftCProJrVTQ/YYAgluzUDqCbx5yyIHuPJHEsNeYHJZ9xLummfj
	 E2O0/2YPG/XL58qrP4K5gDnuY4lx5rqIkEJYmhMx3xKx3dnRl/+SsSkyp4gLfPh+HK
	 IlBw7wEoUs8z4e0A4KwIgLWeuziMa/UB2UhnwxN/MXzEa8jFiZ3INX8irvZGFLdSCV
	 LaBDZjND+4LYCLPGggWFS5CqKh8KlfUGDHmqu6tDHRayWY7yqxFW+S7D7000Pifa+E
	 xwuOTyqy3RZWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02AAEC4332F;
	Sat, 27 Jul 2024 22:37:57 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240727-vfs-fixes-c054317e0d77@brauner>
References: <20240727-vfs-fixes-c054317e0d77@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240727-vfs-fixes-c054317e0d77@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc1.fixes.3
X-PR-Tracked-Commit-Id: ef9ca17ca458ac7253ae71b552e601e49311fc48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc4eee85ca6ce5335efe314215841712b5531449
Message-Id: <172211987700.30387.17407863243512322569.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 22:37:57 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jul 2024 11:05:08 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc1.fixes.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc4eee85ca6ce5335efe314215841712b5531449

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

