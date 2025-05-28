Return-Path: <linux-fsdevel+bounces-49994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4CEAC71A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 21:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA6377AFA26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B64221721;
	Wed, 28 May 2025 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqI+xoLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC722156A;
	Wed, 28 May 2025 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461467; cv=none; b=D6gIQvaa8Y9bzxTh5JdiGB9eOFbpoSp7O7NFPObI+kOtYTsFjuHKda0AMJP/spuJy/n5gNZXiIlGNQDHQcYrXMrb1mYy04cyhNN7sdt76KY4RkDmPnk5NOHYaVs2lQye5fEPkvtwmPDmhIMiF6H8t1Id6FabDZmkguKa2StCpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461467; c=relaxed/simple;
	bh=32Xg1Yg4UeKVa/Otm8FkA4BCdw5ePRDgybfv6Yout+0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YrUXqWe75IHkqbocPCs20aVXxtLTYUiQyygaPXBHYhZgFiD72fZlQIPKmWXTJGwNwFv+5FXKgeDJ/Duqew98mM64SOSXtIQ1wmZvEKtYNN9n/kAr0S+YFV3CRzL1FN8lwi1W1RJUsDxE4+p32R4gb7GSUEo0lq5dntFGmQtSk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqI+xoLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF41C4CEE3;
	Wed, 28 May 2025 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748461467;
	bh=32Xg1Yg4UeKVa/Otm8FkA4BCdw5ePRDgybfv6Yout+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MqI+xoLm4Jit0CSGvF8Yec3RHVJKYIw9gf4s0qtzcnoTxAMt/lgA6CW9h0i3lY0sR
	 VJospUHqbxt++uLIMzDpeh406DKKfZeLYivKmO4nisenWV12IyHA44gUfI/LeBjIBR
	 K5UVwcr/TgoBAocYOfG66MeEO+u2f2uLWKAtyNSdY/S5mOW44T5u+lMwWfj2N+KnhY
	 mWYrU87am176lpekLI8g8U5gF30XfkGBb7duJlq3K6Jlk3e4neFA1BLY1wR4VEi3Ga
	 ADQHAOhCXwfJ+GB+sBYoWYd0DzFw88Kv5iRZrN7G5IaxZlQ+SgzUlLe+lRBJ8uXvnx
	 +HbanNz9oeKXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E633822D1A;
	Wed, 28 May 2025 19:45:02 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250527160246.6905-1-almaz.alexandrovich@paragon-software.com>
References: <20250527160246.6905-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250527160246.6905-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.16
X-PR-Tracked-Commit-Id: eeb0819318cc0c30161821d429ca022dfbedc6ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9d712653633a05ffff19c39809a7c1820edb2bf
Message-Id: <174846150091.2536722.734456989379141313.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 19:45:00 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 18:02:46 +0200:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9d712653633a05ffff19c39809a7c1820edb2bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

