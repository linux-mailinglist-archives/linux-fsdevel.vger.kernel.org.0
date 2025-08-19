Return-Path: <linux-fsdevel+bounces-58333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E39B2CAA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 19:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7798F3BFE15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F63305046;
	Tue, 19 Aug 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb8hJwxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4E253934;
	Tue, 19 Aug 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624814; cv=none; b=uIvS+vWG+K4JHN0xjrai7FHmvJatJqT2dOyhrlguf7+ee1PKzrf/wHv/Jh6/PvXqadsmRr5Yq4xfmOx3u4nbO3lZGNLQKGtB01abFNhtKN8Sr7gOrXRl//Pkv7+b91y5AaCZQOls3vrZWZMFInDh9e2Smsr2EsbPUmkPkchNJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624814; c=relaxed/simple;
	bh=ypptO4J1y8T7upJ9+zLpFetg6FpWTLsV6ZeTplm9wvw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lTKM1z8C+2FoOZK+M4img89P4x8OF02Ng5Yb3j1IUC+P+P3CPsXe+qJJ7EyuTD/j/xntq+2KLPkwrgfg+lId5280W0SruqQJdXwUrKgIpTIzzBf9fSaaBWKwTLIsVMJDGjH1xpbb6YMXuPZ6Qft1M90e0hoBTMyCcjQ0CcRK9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb8hJwxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C64C4CEF1;
	Tue, 19 Aug 2025 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755624813;
	bh=ypptO4J1y8T7upJ9+zLpFetg6FpWTLsV6ZeTplm9wvw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Fb8hJwxj6nYlcyQ+PL5n038b1hGl4XVcV37FeRtTV8aQGEpGFmNRT1eeZjPvEJY+f
	 VfK3s++ZSfeUWZSW566ybeUb5qtU6mCVYVL/qUWiiQlXWAbe7YJAbdRsMLkzHbth9L
	 UNkNAx4H9LxRrkFOhc3rn8fS+c7M7F1/ImTvGjycmu/cGJukjP+pxI7fKFTqs7ES1L
	 Uf1OXUEwSbX2Z5vqRjoPzmUjpAc0FB80tI6k8vQmJ61lBjfyoB4DR8lC/ZBp/Cac8K
	 kh4ONK25zvfhjd9yLEw9ap7l0dTW/xiwCr+t9sjgenB8slx14sVGHl26dhx75RCU38
	 b8LOMBo/mughg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1D5383BF58;
	Tue, 19 Aug 2025 17:33:44 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250819-vfs-fixes-69c14bc8543f@brauner>
References: <20250819-vfs-fixes-69c14bc8543f@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250819-vfs-fixes-69c14bc8543f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc3.fixes
X-PR-Tracked-Commit-Id: a2c1f82618b0b65f1ef615aa9cfdac8122537d69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 055f213075fbfa8e950bed8f2c50d01ac71bbf37
Message-Id: <175562482354.3631675.13770449482436834097.pr-tracker-bot@kernel.org>
Date: Tue, 19 Aug 2025 17:33:43 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Aug 2025 14:46:16 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/055f213075fbfa8e950bed8f2c50d01ac71bbf37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

