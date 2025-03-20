Return-Path: <linux-fsdevel+bounces-44647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7010BA6AFC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C984A189C881
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AB522ACDB;
	Thu, 20 Mar 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epKzaLr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3321EA7DE;
	Thu, 20 Mar 2025 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742505657; cv=none; b=gZBXhV/Wfk06VXuhWs/LhVPQen87fK4enxIcjx/kWmahTyVGLbpOrwDf81n8a3Js8tFQPzmfX2o3cOLZq+g4puSj7daWeytOQ6de/V9YfKdwVLAjPi+VioW0Bc7yQ/mW/cGS5B4Fw/9EnJomJJXGTSO4wds+XnJIZsvFsZHZM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742505657; c=relaxed/simple;
	bh=0CBbTIoBBF4aAI0D3E8y1fxPrPQ0h84mwobccsofjrc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kd/wIbzuUP+8cvYE+Fqhw+NmftVt6M0k6vT1DbEFYv4zKmBoxJT1U/hY2TR8sEdkI+k4O/3XZcxgUZ2lE2DtBZumOWQTHetwxqmWzmaceHyC+bVsp230cPcOwdFHLOeA9wmXbTXhKroq3jnEQ5cCuNgyMUzkeQRITvVZtMDNTk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epKzaLr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9928AC4CEDD;
	Thu, 20 Mar 2025 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742505657;
	bh=0CBbTIoBBF4aAI0D3E8y1fxPrPQ0h84mwobccsofjrc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=epKzaLr9sJf6CcPTfJpI0mBfIKcat7jBdTGFGqqRXlKmcevgg6o5O4IHBi2Varx+r
	 wotaiXTY2G678YN0WbI6UiZJEzkYV6HK2XDnf3tsS5snvbqAS6BeHZ8AfDkJ0jFlvC
	 jVhCE7I9VI7DG8sraQZUHhCFMNwPZHknmQc1VoeWoUR6GnbtlxGMKq+ngKIDyYGqx7
	 g14MPIycXAzwkJV3rv7OBiPhq3vh+wtfY9NmXWsd+rLzCDCovNIbUtXW5asIoD7wHP
	 4g2cHD5faYXGC2bxuSOMwL0pOgIYbwlHRBTPtP5mEfeNbt3LcssCnHr5Dwd33snMir
	 cNw8OqvwzlaOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD843806654;
	Thu, 20 Mar 2025 21:21:34 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250320-vfs-fixes-35ad42f81f73@brauner>
References: <20250320-vfs-fixes-35ad42f81f73@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250320-vfs-fixes-35ad42f81f73@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-final.fixes
X-PR-Tracked-Commit-Id: f70681e9e6066ab7b102e6b46a336a8ed67812ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5329d5a35582abbef57562f9fb6cb26a643f252
Message-Id: <174250569334.1915575.7434340460098271366.pr-tracker-bot@kernel.org>
Date: Thu, 20 Mar 2025 21:21:33 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Mar 2025 16:22:48 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-final.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5329d5a35582abbef57562f9fb6cb26a643f252

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

