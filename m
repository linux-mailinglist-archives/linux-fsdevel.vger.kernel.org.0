Return-Path: <linux-fsdevel+bounces-50392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EDBACBD8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 00:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A714E164867
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 22:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1C92522B6;
	Mon,  2 Jun 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnpY90ZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6B2C3254;
	Mon,  2 Jun 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905067; cv=none; b=H/z0bX0sR2TdgxqaAGK2Qy+eruOcaDCF+ch+niTidU58QWUEyXzA2C96Ya+vjR9e47dxw99HSX5/81o6hS+xn4PXXd6DAAoXrZKh0zaOpSEGeAsySvqwceloKHA8B3qYD9A34OKneZfDS/+q4HX6JQUNmZIr/1mPsrejIGCnu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905067; c=relaxed/simple;
	bh=VdLze6ax2Rv9G2T1IEhfUPYg5sSeUPrVmsz8BlPJnCQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m0iv1gtoNlR8lLdcXeAtHmZH9widajHY5RUBCKpqxjakhEv7Ti4Wv3y1i09K9Eop/EvWu/RNyQG5FXe280y4+z90qRUypgqulEfjdkuES21I//4iDajPc3aNH/uxOD/1BFFI4qo7oiNM7Dnjeem2cBK1aJK0hhXz1PjwlcbBnus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnpY90ZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C30C4CEEB;
	Mon,  2 Jun 2025 22:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748905066;
	bh=VdLze6ax2Rv9G2T1IEhfUPYg5sSeUPrVmsz8BlPJnCQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CnpY90ZQtunIdUOsuLIIqcfZYqsg+vQKz5WSQ3vmrVvhbnC+Tu2Uf4pnEYVWSx+u5
	 jqHeSzF9NgS8sxgwG3Q5xO7IlvILl8yCzpx3Nadv/W7dgPurdLAoaKWw2UBXntNPj3
	 NXC3y8N/z8eL/udrUT7w0u3leyQO1hsWU1Cmha0cxWTRZokqwO6CQV6ptNYtIQw1Dt
	 I9jLboiLoDIAKvofMRpr2+d4vcXwUcqTI0nEXXub3GxIAOJ2TZlKfRDVpLtqTyKVpQ
	 QLRc2sTp3AbF5TlEJBEHxIwl4TLLopyLtMFRKeDlBgQdYxdM3/6MLc6amsKNhMs0jM
	 r+FHOaMemZWOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEA1380AAD0;
	Mon,  2 Jun 2025 22:58:20 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250602-vfs-fixes-257460b833e1@brauner>
References: <20250602-vfs-fixes-257460b833e1@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250602-vfs-fixes-257460b833e1@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc2.fixes
X-PR-Tracked-Commit-Id: 5402c4d4d2000a9baa30c1157c97152ec6383733
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcd0bb8e99f7f5fbe6979b8633ed86502d822203
Message-Id: <174890509921.939710.505657697034508321.pr-tracker-bot@kernel.org>
Date: Mon, 02 Jun 2025 22:58:19 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  2 Jun 2025 11:02:42 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc2.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcd0bb8e99f7f5fbe6979b8633ed86502d822203

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

