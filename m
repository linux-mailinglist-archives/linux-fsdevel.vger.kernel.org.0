Return-Path: <linux-fsdevel+bounces-49864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BB3AC43C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 20:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71703BC023
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE3F23F431;
	Mon, 26 May 2025 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUOWFS8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEFD23E354;
	Mon, 26 May 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284520; cv=none; b=bCbbggQnVHLmDp/iW30s8KRtaWhhxKYP271zD2qXM2yfld28R65P7tyrJgIOLg+LahuZ6Re2vanSXSLPZj/QTtIHk8ZnY8aer0STgBwRsKWmTog5JFkG7g3gZup50eiKsy/6gD9/2tme0DpIRruKhbqfI3QsPYrBHmkuWj+rrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284520; c=relaxed/simple;
	bh=DpDsx2uBDNaKeE3BL/EQ+cuuTivWz5SCUNq1T0wqkLU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ULmfkcJFkXhDbyrSsU1R/TwJu9VpGQZJeP2/3xCfgnDq2qSrBWF/Lz7ggwrezAJtQIzaL4HJCNhIBVHl4Pz9AllKEsWC9nOatfaxx6qz9Erc6TI0AyRffNbGLu/W95nAwT+Na+BwOMmQI4X9OquhJ1r5J8ZxBcgjxStCZF2Ofi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUOWFS8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCDEC4CEED;
	Mon, 26 May 2025 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748284520;
	bh=DpDsx2uBDNaKeE3BL/EQ+cuuTivWz5SCUNq1T0wqkLU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oUOWFS8B1Xu/hndh61WKobjae3MYfN6CN2knnQoAEhgTwpUSafUfQ+69glkBshs7h
	 iAeYLYjKU3H4rv2kA7gezMOHNuYB3AZcy0UhlT/dN+ot6uf9urGrjt7J2BRIRqqnWM
	 /ZTBqy+u7E/lFoS5EoNd/IrOAFDwoQh+fcGwpPT5XBdZnX6ZI3WXzCPz5nqKAk0HBR
	 p51zbu3pD3Ps5r7eN4QGptseLuXR+N/vFyZvXsm9VUdjT+0JB/NPMxQPHhP0fhFnRk
	 H0119ElDmz/cJUMh9JTFB0SxGZj0I8Iaqaji3ldw/wA05wiGvV/1Tviq2fzrXubP+O
	 88EIEPOiMrHEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C473805D8E;
	Mon, 26 May 2025 18:35:56 +0000 (UTC)
Subject: Re: [GIT PULL for v6.16] vfs mount api
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250523-vfs-mount-api-7c425ef2eee6@brauner>
References: <20250523-vfs-mount-api-7c425ef2eee6@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250523-vfs-mount-api-7c425ef2eee6@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.mount.api
X-PR-Tracked-Commit-Id: 759cfedc5ee7e5a34fd53a4412a4645204bf7f8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1ae8ce78bb2600490d49a8f1ee88767b0e64381
Message-Id: <174828455510.1005018.6054696352566227101.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 18:35:55 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 14:39:17 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.mount.api

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1ae8ce78bb2600490d49a8f1ee88767b0e64381

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

