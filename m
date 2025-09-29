Return-Path: <linux-fsdevel+bounces-63051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DA6BAA780
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041B81C6AA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A23A29992A;
	Mon, 29 Sep 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9PIe7Kq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FA28D836;
	Mon, 29 Sep 2025 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174281; cv=none; b=q2opDr10luMcMsVYQLq9JvZA0j0ngVwVLuatoafMIkKOFXq0WqHtJFj6kybE/OrOQqKJVzHaWHZPqptCLSpTcyISgyLk5oBWfIEtwKWatzqfNdHc2nXdBlKjz5nyLJyniAr7Tian1nafAkV/dHxJNro4YFpmfbXoPu9nvV+zIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174281; c=relaxed/simple;
	bh=KCZnYVUowbQrhuldri+e7jQcERVxsxuSX/KeU6/e2Nw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O+igN9hxiURJYX3zqPsXbVuSsU8ptt9Jgp08EmwqvcbvpwBpsLg6KejOfg1q2B9S9M0he+NkHSnkpkUSp4sitlKXxc5mUG9wfeFeY9a2nJ84MJzWXXrm+VdCeibvfzngh00zUlm/emxoXHwzXnR8nNQlupkBY+/wUkFJOxYokCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9PIe7Kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69268C4CEF5;
	Mon, 29 Sep 2025 19:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174281;
	bh=KCZnYVUowbQrhuldri+e7jQcERVxsxuSX/KeU6/e2Nw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k9PIe7KqJ7fXNXo36hrDEKITiAjCYfWc6uFGhZfL9tW8B0COAACpKoNPTTaR2zDXn
	 JEtgpfHfzJgptsdcZr31bUL/6rwyiVtKAtiKi+WCNpcL2BUwImHFJ+JR0tKQ8/IgC/
	 n6KV1Pd/KjXB3DQYJtWko435P4DeC4Cl5HgfDIX3hVa5Xfpvjni8IBaO//Ww8+rdqR
	 EY2G2HuBgQML6hGhO+vpEWd22M4zpvp0vZN8BuKTS5ROioFolyQeskEILUpY5moWQO
	 Tz33ykYOBH5FZCrtbnR4Pjr5PfhZf8gCLxSWaaZMWTdqObHqXILwNqGLCfGJqO+Ayd
	 R9j0gowMo3YcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6739D0C1A;
	Mon, 29 Sep 2025 19:31:16 +0000 (UTC)
Subject: Re: [GIT PULL 08/12 for v6.18] core kernel
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-core-kernel-eab0f97f9342@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-core-kernel-eab0f97f9342@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-core-kernel-eab0f97f9342@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.18-rc1.clone3
X-PR-Tracked-Commit-Id: 76cea30ad520238160bf8f5e2f2803fcd7a08d22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 722df25ddf4f13e303dcc4cd65b3df5b197a79e6
Message-Id: <175917427480.1690083.7359468199537491058.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:14 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:19:02 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.18-rc1.clone3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/722df25ddf4f13e303dcc4cd65b3df5b197a79e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

