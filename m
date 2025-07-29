Return-Path: <linux-fsdevel+bounces-56219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EACB1453D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 02:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66ED11AA1A4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 00:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C594A01;
	Tue, 29 Jul 2025 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7tES9MV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E4186A
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753747988; cv=none; b=dajA6EkFiSLPNZn9YFWuxpliDmScNqGy1oH4v39dvF4cq8/aMZSy2VdwbYcmyIZ/txmMwtwLgavxrbMFeXxsPVW1UMksGjqp441Qt0TUU3IXiLpG6FXu+WCkZvm8F5lkLz4XPuovoWZVeb13feRKXiNw3HBfb8qcDU4y2zPP7ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753747988; c=relaxed/simple;
	bh=5dcQszTp5daNPlW8oxItogC4ubCjvGCOlPXLtQb94/E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d8o69CIEBJXDW4X6+gm9q8BoqGxqY4SC3Zun0FN+M7pFzWgeiUNaygYTs1AgKI9SQv5DSwgaulW330QmgCIeG4UAlabFSMXTQiZKOpAFGHUSyiWlV6hDVPsVJAJMxpqKaPtmtXD7RsNrYbn7dRfRiLKicMGTzBnZuWqarHxKe64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7tES9MV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38F7C4CEE7;
	Tue, 29 Jul 2025 00:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753747988;
	bh=5dcQszTp5daNPlW8oxItogC4ubCjvGCOlPXLtQb94/E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k7tES9MVVDYXcgtkbBp9VrizcVAWX7oeeDrQnwihACnqZd7SXikPBEoGI3yn4kr2A
	 +UbHsLar72U4pyP74cX+2Vhz1RLiLIYLTqkEKYFBUG0Eqeutcoize+ksrvSJBniyko
	 2myZNXn7SBm7Xkg1bSdKKyPGhb4tIa3qegEam7aA+3sN6B9KejjsIYVOZySgJ0bXvx
	 ynUO7CIlBF+34nBWXs6QHSZz+74gHm9NG9tShEn/+QeWcEtR1VkhRqxDeAtLiMDXuq
	 Iqa3N1gH2tr8fOahh7ycBBmuCNJerJQNYtTZf8T244l7KjxDmqguR4T56wF7tT6JZb
	 +U/V0vS1/+7kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC0B383BF5F;
	Tue, 29 Jul 2025 00:13:25 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs changes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728053459.78340-1-dlemoal@kernel.org>
References: <20250728053459.78340-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250728053459.78340-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.17-rc1
X-PR-Tracked-Commit-Id: 6982100bb8297c46122cac4f684dcf44cb7d0d8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e268c230c0e9f00680c929389324cf45acf76599
Message-Id: <175374800432.902610.2788923958056967665.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 00:13:24 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 14:34:59 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e268c230c0e9f00680c929389324cf45acf76599

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

