Return-Path: <linux-fsdevel+bounces-49780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9119AC25B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 16:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FDE3A3248
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFD8296FAC;
	Fri, 23 May 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAtM1nOv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7708643AA8;
	Fri, 23 May 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012162; cv=none; b=mQf5TR35ZaTnNLY7SoM+kcBnLO/mPrFuzsVZxIOqSHWF8F+jzpRDtLbCvoUiO96P5hd6bFV6ENB0iAqIpUA0tOZKcF1LRJXC8Kri9rOHv+0RkDTYROES8ZeUCgwcYcnJi3P67NketG8pYONsXs3cvCF/uvNhqhDj7RghGNfYuPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012162; c=relaxed/simple;
	bh=PeWk+MQVeG53tGAL4Uq80Knoe2YpQyKuGq7ZK3BcF6w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d5CLs3Vdt6DXJdfONq1M9LF+RiVNxNnQmT4NThgceZImIl/C5ImY6BTnq6WffvyqEJZjvtPTTCfmPFTVAnDjgzhvmjxnO5iNXXciUYzeOgQfgeDwwDSCjqPIo4AsaD1dZiuFBcBlKzG899aApsMyfUfVJRPS+aovjzUxTs4EgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAtM1nOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F24CC4CEE9;
	Fri, 23 May 2025 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748012162;
	bh=PeWk+MQVeG53tGAL4Uq80Knoe2YpQyKuGq7ZK3BcF6w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eAtM1nOvx1qob4CQ4Kyuix3UqHSo4NrBBO8pbAPs3CEwp7O4h53rQtswimJ2PcRrQ
	 fv2OrggVfEluYNCUG3xSyXAhgIBx7G+NdVTVmUo0QwDZAeBIP56PeXCfB9qrkuRlYq
	 5lUBz+wzXfYH9x635qaWPQXUNhwjluN4RM9LVvNUa4B1bupyASnAHsuaEa7Pzm4v9W
	 Pdg5aTKRO9ZljXi02Ltk+/8SaczvvKUxpCtztJfNTA4UzqEBib4V+DKvi0gxtWBpLl
	 Ea40qXHlJI3wjVYN77e4ZVgsFOl7bbizviJJlEbHsgY1b7yMacFueXSlknoyQxt8dH
	 D3Y9QgNIoAkgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD693810902;
	Fri, 23 May 2025 14:56:38 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250523-vfs-fixes-187d59638114@brauner>
References: <20250523-vfs-fixes-187d59638114@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250523-vfs-fixes-187d59638114@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc8.fixes
X-PR-Tracked-Commit-Id: 7e69dd62bcda256709895e82e1bb77511e2f844b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eccf6f2f6ab9688b0fc113aeb8391998c11b5d49
Message-Id: <174801219742.3623503.125900860612362159.pr-tracker-bot@kernel.org>
Date: Fri, 23 May 2025 14:56:37 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 12:26:22 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc8.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eccf6f2f6ab9688b0fc113aeb8391998c11b5d49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

