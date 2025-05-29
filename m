Return-Path: <linux-fsdevel+bounces-50090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31754AC81D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1C41C01D5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1A722F772;
	Thu, 29 May 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToTG1O+h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4422D4FA;
	Thu, 29 May 2025 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748540909; cv=none; b=l5vZ30mWAX/5llkeTF/bUNqmgn+VzyBH1a/pgrgaTiMlRm/wDOMC3sxjDuz96hlARMaVn0wyGPyondRMWediAweHQ+cUldztUl4fHcmh6mBGenJz0qwB3y/oDbk7y3QqJM24o+F6A70tr7EuiKlJnTyWS6zBg5Vsau/iiuTfsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748540909; c=relaxed/simple;
	bh=yA9lhWhllEaVtrNaAuj5oo4awRC+Uw++PEQyw1gQ/1c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YoJWRDdEvzDYX13p6qv6AP7+rtSLT0ymuY7F2aiVoCoglnCLJ25WR+7eVluZMQJJ2ETEA+AVv4OIVnXM4+rG6YEZAuUHTmQuJTdjvBXuemJtpHyE2ocs0M9Aw+XOd18YV8IdQQOYRApcSEaVJXRpuF7kAy0KR1xupz4rkaHNXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToTG1O+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C4BC4CEE7;
	Thu, 29 May 2025 17:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748540909;
	bh=yA9lhWhllEaVtrNaAuj5oo4awRC+Uw++PEQyw1gQ/1c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ToTG1O+hOD7rGMtQ9jzYYIROsLdEiwOW1x2g9q5v0mppwdzQpSk0kKBbutHgK8tRq
	 2D1rhmEm6w2x5ITUIG1ZgmR6n4Yr2yirkeONQsH1TCbaINu0lAwgmRYZxkDw6RxxXc
	 X9frGahlRXxUxEZv/4jPEeLo9fvukFkoY0vQYKBigrqoP8eqUzIvX/sdORQqS/+0QY
	 eSqoygdqnp0ha0PErhPdaFiq00BM8cK2NIm+5tBF0PHRReOGbOFNV6ZXKfB6rOG0Gf
	 uuk1/634/ibp7wc5CqfIvvvo0wWlwqcTIIGMfCN//2KxSNbrN7+aHf8yusCd6G+Tme
	 YFgiiriPZ4XoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34108380664F;
	Thu, 29 May 2025 17:49:04 +0000 (UTC)
Subject: Re: [GIT PULL] ext2 and isofs changes for 6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ovi7jizxdqmr35quwevkzwiltahrewq5mrpmhnfe65gllynqod@ji6zewdluxyx>
References: <ovi7jizxdqmr35quwevkzwiltahrewq5mrpmhnfe65gllynqod@ji6zewdluxyx>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <ovi7jizxdqmr35quwevkzwiltahrewq5mrpmhnfe65gllynqod@ji6zewdluxyx>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.16-rc1
X-PR-Tracked-Commit-Id: d5a2693f93e497589637bb746ef19ac8aecb6fb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0797d3b91de75b6c95b4a0e0649ebd4aac1d9d1
Message-Id: <174854094290.3342178.1126635289442493238.pr-tracker-bot@kernel.org>
Date: Thu, 29 May 2025 17:49:02 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 29 May 2025 17:01:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0797d3b91de75b6c95b4a0e0649ebd4aac1d9d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

