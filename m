Return-Path: <linux-fsdevel+bounces-49870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D549AC43D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB53188AB1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA624634F;
	Mon, 26 May 2025 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HekVOTMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF32459D1;
	Mon, 26 May 2025 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284529; cv=none; b=T4YxvXt/i8u6rrYsnc5UKgGJYENZby47iqYYxC6aEZ9/4+cs+9WOfjlCdmjwQR1NvHhxwKOw8gzijxnHcTGQ0KqHuZ6KDcOKv6p8vOmnQGWZ+a2NGZzDkHd2er6hC2uSSsakgZ5dYFi8u5T27fB7ENQKCn0vr4ubkbISOxjyoJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284529; c=relaxed/simple;
	bh=GMu9X/Fb9Dh/z1dvIgzU5XfClxVIFtnjjEv0PiwSDBw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Nm/g3SIaqfNbUI8ctuLJ1CD3t1FCr8lp3VR+3XpBkQGyVpkJAnWADI1Ml0tLy0T0iJ0kCG39PSkCIvMOIJ0XnwR7tRUFPI7VMitAq0DAPBA7KjYon5wCxMiNLd2bRGwlkeXlt7LSeagbgUPb9+WoFTlgyyZsLMznKv4E+Ih/xLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HekVOTMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFB0C4CEE7;
	Mon, 26 May 2025 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748284529;
	bh=GMu9X/Fb9Dh/z1dvIgzU5XfClxVIFtnjjEv0PiwSDBw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HekVOTMTeC0syfV9RPSs32Sobd95PdkMreNHBInf6fjPMzRA+OZQ9mXXbZcbcDl43
	 DoGBERXgV4jaxNqk60BKRYvzu9BKdnUYh8zKn0xds/95Ch/tpzsgwCUOmHWaUCRkn8
	 J8RKYmbbmxi77kzGl2Qpv5QgtP/pvJeXEOLhFz2XiuGQmHetuoep4c1OH303jKToZZ
	 fSYSwm7tYGymOr0ULRO/xi/VJCF7SkYqv32GUZbLCwT3w/MmxNf01SIlN2VnGJ5ER0
	 /ZL2npLTAYwljIQkVSbOSD1JzetqBBMMZQqjboZOsECDiO4l+3Nvt9LqNA6Jj1eaYD
	 P3iKzXnan4zig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F8C3805D8E;
	Mon, 26 May 2025 18:36:05 +0000 (UTC)
Subject: Re: [GIT PULL for v6.16] vfs coredump
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250523-vfs-coredump-66643655f2fe@brauner>
References: <20250523-vfs-pidfs-aa1d59a1e9b3@brauner> <20250523-vfs-coredump-66643655f2fe@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250523-vfs-coredump-66643655f2fe@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.coredump
X-PR-Tracked-Commit-Id: 4e83ae6ec87dddac070ba349d3b839589b1bb957
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5bfc48d5472fc60abafb510668d7bc3b5ecb401
Message-Id: <174828456411.1005018.17428802507562867096.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 18:36:04 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 14:42:11 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.coredump

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5bfc48d5472fc60abafb510668d7bc3b5ecb401

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

