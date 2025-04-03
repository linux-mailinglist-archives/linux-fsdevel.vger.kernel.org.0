Return-Path: <linux-fsdevel+bounces-45584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939C8A79948
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 02:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB0B3B3444
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 00:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19C342A92;
	Thu,  3 Apr 2025 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMvcRpmh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B661862;
	Thu,  3 Apr 2025 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743639066; cv=none; b=lmzmtzqJloLx4JalBYExdALndWTd74x8fpr6uz2O+Vz8O2UoMSd5XoWa+vB1Vwx0cYewmrk9gECr7xc1NJ7q9SzonmTSIHztH3EvWVMIb3BWseYS0XzCD7DqetJMcYgEbooFs7PcyzrGq9Hp+u1b7knfTerkGZeC/fg7OwpHlU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743639066; c=relaxed/simple;
	bh=k2DAayWk2ELHrGWUuUv05V8c3ddqCSDdQEkUZ5TDy+4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CoOUdaJCd9W7BGYDj/gyxC/qN3ZlQ/Lef7LFqfusuYOzgmS8x6AMskwWPi7xxtHZJxc0UEx9BQWlkRAPzKCVr/frRuANJkc0x2dr1WCvQea7E+m5hEbUIZC++613+S+hKt7IQK+sPRU8HOS+UTMhjWsluWBf9XLMtp0IurJk9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMvcRpmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C35BC4CEDD;
	Thu,  3 Apr 2025 00:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743639066;
	bh=k2DAayWk2ELHrGWUuUv05V8c3ddqCSDdQEkUZ5TDy+4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SMvcRpmhGlfaGDPFvKiWJJ6WBBHK0B8DxSVAvhdbm60F4ovQwuunFQMe9ww+oVeCB
	 mgrG7ondsgOVIlmpqW3EDGmK5MKkqnjy4KxK8BVoslnLaOYVCVOM003WL4Kg2TfZvB
	 asRyMJ9cJ0bu5uwwvvyzM3MMNaOUyAReKa/ydfTwOfI2dx/ttY1Kts+XtkzMNMYBaN
	 ZT2HpQ7lq6qotAborf2AKZEFthuy0CUM03wCtcMsBOOnI1qVq4ClnehABmdvQWxI23
	 zlJ9vOu52Dzb7SKr2T768XOu9cCgM5H8w75j/NQfwdkuriB48VHe+htr9l+Gz+J+8s
	 TiF41yw1LwHFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B36380CEE3;
	Thu,  3 Apr 2025 00:11:44 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250402-vfs-fixes-a079545d90a9@brauner>
References: <20250402-vfs-fixes-a079545d90a9@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250402-vfs-fixes-a079545d90a9@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.fixes
X-PR-Tracked-Commit-Id: 923936efeb74b3f42e5ad283a0b9110bda102601
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b06c990c106d0341357175b229277a90da6583e
Message-Id: <174363910281.1725867.5514045611770489063.pr-tracker-bot@kernel.org>
Date: Thu, 03 Apr 2025 00:11:42 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  2 Apr 2025 17:46:12 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b06c990c106d0341357175b229277a90da6583e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

