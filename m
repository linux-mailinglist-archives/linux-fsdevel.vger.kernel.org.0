Return-Path: <linux-fsdevel+bounces-44899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AEBA6E4E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E05E189747C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BCE1EDA03;
	Mon, 24 Mar 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4LyujHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5F61E2852;
	Mon, 24 Mar 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850021; cv=none; b=EG8hwU5RXqgjOGVOZWHRpIVobFoKvb4c0FPGWZLU/Re0A39KQsqL+KfDuvUxECOALRvTWbioW+Eg0N1OlPOWSgNxE+TZeXzZKHRL2CAv2tf0hyIO0mMxjlW7ZKWnxCc1Iw4y4//0AfhGW93A11b+8g/5kCE39PsVg7GmzItqYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850021; c=relaxed/simple;
	bh=CsAXHQveFTs/0UYbSYdoNAGN5x9PsIhHFTX3rueaxEM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OKHvEtNW/IZnJrYFJgv+nMidRcJb3JkoJvo77vNhnU53RHamtcCoZj6kjAm6HzEQmMQxWGDIJiWl3xVNTyl5eySwiR6KR/gJ0AqRGJlzCi3Yu95c2Qcf+sCn1TpA5jRGjBwYV3hFPkQfR9502KnvsC5vJB0Wjfx503DkBkn6SUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4LyujHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FADAC4CEE4;
	Mon, 24 Mar 2025 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850021;
	bh=CsAXHQveFTs/0UYbSYdoNAGN5x9PsIhHFTX3rueaxEM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s4LyujHrviCrAJxgfiBvy2FqBC9dcVolbEvIDTrzn7QHa7PM1tJgjUoTrVOUFs5vZ
	 N09HJXOoBTXX48XbyRPQb956As3n5wOjGzkUpQj2hy8w6ql8dtBWn1LwM+tH6m1CzW
	 0ORFWCFu2yF6bWkCkdh0Zp2FG8sGvw8+P/JPtfkFr67hQ9a1789WtvShUAruO/pEyV
	 wURiCkqj6gmy8l3fSlQRrznPdJ+TlkJOgw5a4fA9w+ennFbvPCILebqYB13ojMlX1W
	 hWcwPkJ27sbQ65VjumRMWv9cT8I2Co9IQMlatpMb6m+hMUH5z9behx5ysmLeu4QUaf
	 dCHZMjwDfrCCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2B49380664F;
	Mon, 24 Mar 2025 21:00:58 +0000 (UTC)
Subject: Re: [GIT PULL] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250321-vfs-misc-77bd9633b854@brauner>
References: <20250321-vfs-misc-77bd9633b854@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250321-vfs-misc-77bd9633b854@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.misc
X-PR-Tracked-Commit-Id: 4dec4f91359c456a5eea26817ea151b42953432e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99c21beaab2db53d1ba17102b7cedc7a584dfe23
Message-Id: <174285005773.4171303.7791354323608380268.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:00:57 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:12:49 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99c21beaab2db53d1ba17102b7cedc7a584dfe23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

