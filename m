Return-Path: <linux-fsdevel+bounces-56196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4B7B144D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBCD542D6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA44246771;
	Mon, 28 Jul 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEIT7X7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2326CE08;
	Mon, 28 Jul 2025 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746028; cv=none; b=PePbHOyNyJl8XLizX7vB2QjDDcqHTdPfKktEm6HA8Q7GEpkjIGS9vpg1/Q46fOjbdXXnsN01iL0xJKuFpo/shycYplHohIb4pGiuY9JyGcPxbXO5/Plu1AqlRf7rVvxSfE8IzjhVgVnXZ4xOYKlzDs/QTW5WPIn6W9r4azs8ebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746028; c=relaxed/simple;
	bh=jn7mE+a5MxmXuXt3NqfpgF0NBtcv3Os6FFtV/bE4vGc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JaxhF/5A6P783rrPJAlEdKFxHSf8eKodRMKnRCpH/BYhVnnaoT81q7UhNPBjL/mO4W/HqAh9eXKXhPEvADsxQkVOTcvV9g0xTf3QvUAVDArUpO7WENBgR7B40yiGgIFpTCHrvzcs6J59GbbNyfhL7iZQFXFDCsv6LX0SL6xUCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEIT7X7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D9AC4CEE7;
	Mon, 28 Jul 2025 23:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746028;
	bh=jn7mE+a5MxmXuXt3NqfpgF0NBtcv3Os6FFtV/bE4vGc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qEIT7X7ICpnd9SW72VOZCF5sNNSNRCf45KfQICK08nw4S63l4oEK3BMvAMRi3MD1f
	 NuG3WSFVcYHtSpBeJVbsC1CuMJiZHkwicSg4eZXtQ6EwZmguLpnqYwoXMHIUd8ff1+
	 NcO5aHQWCfWmPrHcVwygEmbNutj1m6bOj3/zDvR2qHdcnPyeElZKPEWXfI8nMYIQTb
	 Ml0jkE8RzGT4VOO/ErCw5QM/108Tk6TpjGi6kltHLCTcqJhwlCChzpDpzUmb0G6XDk
	 b3dGSfNpPMtDTQtKA56NtlYMEeJbpnUHTg3NnFIMv942YoTqPm+S7h8hRLlaKRYC5E
	 VAF7cF2iP+g5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B31383BF5F;
	Mon, 28 Jul 2025 23:40:46 +0000 (UTC)
Subject: Re: [GIT PULL 02/14 for v6.17] vfs coredump
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-coredump-6c7c0c4edd03@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-coredump-6c7c0c4edd03@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-coredump-6c7c0c4edd03@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.coredump
X-PR-Tracked-Commit-Id: 5c21c5f22d0701ac6c1cafc0e8de4bf42e5c53e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 117eab5c6e31815649d952f6da03f67aa247d29b
Message-Id: <175374604510.885311.17466325156856440401.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:45 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:16 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.coredump

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/117eab5c6e31815649d952f6da03f67aa247d29b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

