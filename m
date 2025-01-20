Return-Path: <linux-fsdevel+bounces-39719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A69A172E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D85316974D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398DB1F03E0;
	Mon, 20 Jan 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq1aUSqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978051F03D2;
	Mon, 20 Jan 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399568; cv=none; b=MoicH8zlqMl69QgjNKbv4ojY0VTvsqnm/gbDw0Qdy2Z4jNxvDaYTLU3oORLOm4mSl/it1q0VwcA7nBXjr3lQR3jJtJmaQC02fK2ADBLAthBHdoMWjxIQDrbG7IRMLuy4e30xGpKMyb8BtqDDBy1bIby1McTpQNTYSZFBcKEm2qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399568; c=relaxed/simple;
	bh=8Kondf1bLAEh6m6EiwrTrIYhkuWDhjSPNZZLQx4IQkI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n+HOHFecihmvzm31s1fcOdPNJYJI9F5Qb61lpwjV5veS0QDt+SLg1jACoPKKJPINLv7eppPhmSWhonWZnfPOzu6Y1ZpThlSf8jmC4SDaGBg6GqcslBANK1+GQXIf8AwZ/7OizibchmFEA7GB6SxCFoA8DRGiEi0RNlCI9FuL8lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq1aUSqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B0CC4CEE0;
	Mon, 20 Jan 2025 18:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737399568;
	bh=8Kondf1bLAEh6m6EiwrTrIYhkuWDhjSPNZZLQx4IQkI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Oq1aUSqrAYYY/COruJxs31LYO0UvDcFK8DQPWDTFWRPn6b9WjMpbuLWxE9muMTwht
	 pzsVAJUZrrIyg/AWiiUm91TQs+DVTPAjHXlkBBiiVCrHa0hwyxQY5QPskUcpr8lBol
	 VFEHBt3MuDgm8DxfG+rRq9NbKC6Vy46qjevEQ2x8WMe6yD76MR/Rlwx7uRwhtrKmTO
	 iugPp3WHPrIHSGlOVshZLWam7YZQTJ7D80ju8yFUm/oHzyht/kHXPfO3KnQoNNTVJN
	 lJKuGKSwShSydB/uEN+6RPiXn8h88sPnUUjtb7czHB7EtcOeStuLCul3uXYrCWfHEb
	 CLdUoO+otlQdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE87380AA62;
	Mon, 20 Jan 2025 18:59:53 +0000 (UTC)
Subject: Re: [GIT PULL] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250118-vfs-misc-84fb5265d102@brauner>
References: <20250118-vfs-misc-84fb5265d102@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250118-vfs-misc-84fb5265d102@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.misc
X-PR-Tracked-Commit-Id: c859df526b203497227b2b16c9bebcede67221e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b84a4c8d40dfbfe1becec13a6e373e871e103e9
Message-Id: <173739959231.3620259.1808567397606246581.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 18:59:52 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 13:58:51 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b84a4c8d40dfbfe1becec13a6e373e871e103e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

