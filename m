Return-Path: <linux-fsdevel+bounces-39721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4D2A172E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F667169FF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA31F0E50;
	Mon, 20 Jan 2025 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="escUd2Pc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C361F0E3E;
	Mon, 20 Jan 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399571; cv=none; b=rw5Y141viHoQOtR3L7eqfdzwMlX//E7IKtkx72/k6a3Bt3GoW7vaWY/38JQY7tG5Cf9miolJ+VvGTFFGzdf/Wn7QaMEbNsexrv2gVv3VMZ6EwYiRH3foyE3qWoR0OmhnOsEEDbQbKsJ7rL0GiJOcwLydho0zKSgM610j3wBqWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399571; c=relaxed/simple;
	bh=+IWyxCugzFWSgwMoGKU0pRiTFTs9sMTfbhz7JprgOZQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SGepEzwSgZDE4KDUzAp/UzGeLesWp13q6atgzk+hAtgfkc5PwrYP9zMDcLyHuNnzcXQWp9KnK0pDikH7Z59i/FZl226Ym6Ilvbl69zzcF5V1VuWH9i1QWs0367K7jURH4AnvtuL82p86JLdku4k9DwgJJczsLnVtEkKS/ryRzoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=escUd2Pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F3FC4CEDD;
	Mon, 20 Jan 2025 18:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737399571;
	bh=+IWyxCugzFWSgwMoGKU0pRiTFTs9sMTfbhz7JprgOZQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=escUd2Pc7zrpk3yKNX9J2VKHuj1S7YHKMijgw66Hnz+qFYLcj46bkL8vyVakbYA7i
	 nHVyPZUufUdh0nYrgJtYuWKTPltWo1SGMsDVsoHl7qgzMBnb+cdtjRYo54SxTt4dfR
	 pmy99u47EVxb4MILEEiWHbp3BFHhXJd8RdpjsqVNwO/cT2Mg5+1ZnRSL7lwwx1Q7hJ
	 VwPakGN1eDANW3FUMYiYfcZxhNpi/I+tytKv0yBrV/Zi/D3KMW8HzoJ1IWn1kx2ocN
	 eLaoL4z8Y04NhRKyg8ozIqDTAfDLz+BXaDsOm+eJ8jvS45IZJsr8rg8E5uN+PmdcJ7
	 SbQezKYzbusGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE26D380AA62;
	Mon, 20 Jan 2025 18:59:56 +0000 (UTC)
Subject: Re: [GIT PULL] cred
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250118-kernel-cred-bfe8c6c428d4@brauner>
References: <20250118-kernel-cred-bfe8c6c428d4@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250118-kernel-cred-bfe8c6c428d4@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.14-rc1.cred
X-PR-Tracked-Commit-Id: a6babf4cbeaaa1c97a205382cdc958571f668ea8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37c12fcb3c8e356825bbffb64c0158ccf8a7de94
Message-Id: <173739959532.3620259.6500496609809442214.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 18:59:55 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 14:03:33 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.14-rc1.cred

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37c12fcb3c8e356825bbffb64c0158ccf8a7de94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

