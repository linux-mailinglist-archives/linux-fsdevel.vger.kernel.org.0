Return-Path: <linux-fsdevel+bounces-17934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1508B3EE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 20:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B092284C49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B570616EC12;
	Fri, 26 Apr 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRA9/m3p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3881EB5E;
	Fri, 26 Apr 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155000; cv=none; b=kusgN2VUzGAIFEUuZHfNzOjVMH5uhKfm+zjm0yPfgEOkrL1N8NPJWPJjoDzOK3KKfd9eBU/ZbIwZ1m2GobzpCX6v8D1gCOMar8yg6LnaJuVEWK8sNVzlbKz59AtElz0hmXLHDzaMwJkrD9fd353IC4R+ZZumyhFVHko/dccG0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155000; c=relaxed/simple;
	bh=sSnYg6mwgrP1noDvEXQPZYS7lBjYgri5Ic/dR1LTyXw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c6wEgusJ5G0U1qZ8SxRN/GkwiEI78rzdOnT6BRU8ZOoX8ozlhiY00YVWkN1tmhlxOJ3yEfzhex+sACU9D6MHF2Qj19X3vkLkHUFAVl6v1oMEmZB2SUPq+P8YmkRo5P5cOL7EhM8ERcP/WfZuizw7lBwotlplXr8VVkMiJDBPUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRA9/m3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF444C113CE;
	Fri, 26 Apr 2024 18:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714155000;
	bh=sSnYg6mwgrP1noDvEXQPZYS7lBjYgri5Ic/dR1LTyXw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bRA9/m3pe5vSZQEMlGadPbLQceJpNliM1290V3jJsb64xVP0v9ANRxVJKhg6Zih2Q
	 dk0KqBCi1fkcsBI0DwkPdE1Wb00PjI8u5ubg0mm8/YYJi465jQe+BLfu/VaepAUmSM
	 BUHZowMJMnx7ZGAqvZhAzUXtD5vHEm4dHw7UF1KX+LOMDrHEGuXUuvfoVa0IbIL11J
	 ii8jlJtHoBvNFK6Wd9zjQK2G0aifnH0axpd9A3fOJ74f3EZHG7pwM6800G8b2ESzmg
	 QZMo3ciK7HHyoSj8lHHHU6k5UmFs1yPRbDupD/i+QDg5jCeljhLzCn8CBRNIQeyMIN
	 nXgr5hGI+2Dzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFC4CDF3C9D;
	Fri, 26 Apr 2024 18:09:59 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240426-vfs-fixes-20b3a0dd3821@brauner>
References: <20240426-vfs-fixes-20b3a0dd3821@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240426-vfs-fixes-20b3a0dd3821@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9-rc6.fixes
X-PR-Tracked-Commit-Id: c97f59e276d4e93480f29a70accbd0d7273cf3f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52034cae0207d4942eefea5ab0d5d15e5a4342e1
Message-Id: <171415499991.9216.5389017277272252008.pr-tracker-bot@kernel.org>
Date: Fri, 26 Apr 2024 18:09:59 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Apr 2024 16:59:29 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9-rc6.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52034cae0207d4942eefea5ab0d5d15e5a4342e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

