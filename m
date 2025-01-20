Return-Path: <linux-fsdevel+bounces-39724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7D0A172EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE853AA631
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0B81F1524;
	Mon, 20 Jan 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boXwC6V3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D11F0E5E;
	Mon, 20 Jan 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399576; cv=none; b=SbPwZeVgS9lsPpv8WfuQb76LCyz1muCmKFxdIepPp975SVATubu0p9/P4LBeI+1pUghYegRxcKV4H+zzcLv6mjj+ww1aGcTW/hGoDZE4Lp3ONiJVzZnRDXNgWsEQEUyL7+KVaEVIHifRqXvIetNtQX5zwqp+imI3X1rjIL+jb90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399576; c=relaxed/simple;
	bh=7xYLf1PH5/U+A7bstfqWoxc1PuW1puLr/0Fyy0ignzY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P6dfXGLFz1iGlfDptmoocPMVEwPIUQ2/RBiATyX4Hk45mmkuLrtPnVjD4Akuj4toq3FudQ6+cE0pd2nLTQUkqIx2GueCz1Zx4yICVlUSJlp0ct6RP0r6WR5pbDz6BQgdHloGxPHkFhwP1JqDYnNXJwMm4UrkAbI41LYOI8QnJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boXwC6V3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724C2C4CEE0;
	Mon, 20 Jan 2025 18:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737399576;
	bh=7xYLf1PH5/U+A7bstfqWoxc1PuW1puLr/0Fyy0ignzY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=boXwC6V30MkUkGosbyZvslAQqgf2vED4cBxI+3PptcoXOko8myQLmyr1W0HaswPVL
	 KPj0xCJWL3CT3hzIsK5+15//WvShXjnMMKwU0zy7ZMioDfZidNnsPhPq5MC/3NSdEH
	 9IedZwXHh1qj5MWmxYpby1HROiR+S1bIP+KovooYyY5QTfK2vTjaBAXKEm0E4Hot3F
	 4fHxAApyxt5ScdCCw3KnkR+Nqzjn2DjAAnd2jd4zB/VKlzWBn9KIZS8IBaGOGFpY0l
	 ciHpOCamEyZB0wCthKyK8UuyNtVlMjxYJpR15tmHHNzAsqWQDTUkjm1ZXFkvN5Aui2
	 NNB41TNu1wFVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE606380AA62;
	Mon, 20 Jan 2025 19:00:01 +0000 (UTC)
Subject: Re: [GIT PULL] vfs mount v2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250120-vfs-mount-9c3c337e453d@brauner>
References: <20250120-erahnen-sticken-b925f5490f46@brauner> <20250120-vfs-mount-9c3c337e453d@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250120-vfs-mount-9c3c337e453d@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.mount.v2
X-PR-Tracked-Commit-Id: 68e6b7d98bc64bbf1a54d963ca85111432f3a0b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 100ceb4817a2ac650e29f107cf97161ce3e2289a
Message-Id: <173739960029.3620259.9232027926387711378.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 19:00:00 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 13:26:39 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.mount.v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/100ceb4817a2ac650e29f107cf97161ce3e2289a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

