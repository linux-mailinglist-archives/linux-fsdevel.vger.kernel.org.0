Return-Path: <linux-fsdevel+bounces-39736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 395BBA17353
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5551889B1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86E21EEA51;
	Mon, 20 Jan 2025 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFAM2srW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4A1EE007;
	Mon, 20 Jan 2025 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402658; cv=none; b=BaItqmSoHd1RA/zIlnBjhHkTk+ziNMFhBi02uSo8uJ1HZ1Jz5TXkdMdMMXOylxHiC20FYHVrKpGR/BhjRNAXqN4cgrIrWRGxtqlIqv2vsGvBTN+bqyts6mqMm0zwt8J16e3qI3d7u4UTx71if0r6G7mX7pVeAa7Yk9f7fdGyzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402658; c=relaxed/simple;
	bh=diSgZAVrWj1CrBhmrx1aGmkMbpua0/iCb7cVyANPeTg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MmEl9VgBk/6wTR9KFZMIFrNwY3IlAJlHMALLdfI8PZ7YDEOKIRJWuNpxakolzoTh0yCOKWnzDkh91F9fLF/onaCwi6xjm3BG02EO6jrE67cBeuwXfAQKTJZgog8E/nF3Xl/pirE/JO0AEvvOVdf9ZKPiwTmjGdSXUmjeyOOYSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFAM2srW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D35C4CEDD;
	Mon, 20 Jan 2025 19:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737402658;
	bh=diSgZAVrWj1CrBhmrx1aGmkMbpua0/iCb7cVyANPeTg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IFAM2srWHgaIwbMPPREPzGZlzimv3j5w/jVqa7vj8UztRkmPmFU8C+uIHiHb216Wc
	 DFJYd3LdoUXL3NomF9NjV32mTvnb00dBR8q4RP+Dy/QxOxyK9swC+KxaJ3oOKNHBvn
	 aJeMRipyDoWpT5kMKbxKUlzd0+ge5Zn32KBrQN9teXAA7Y0NTAxMD4/4Dx7T/n9vme
	 0TmfmSxMPuOe7s2/myvNWFGJGfPbhl/Kip544QCTXqfKZLkbB3kNEOBbwnZGbvyiXP
	 0OoUKzoy/8B1o/EuvY7RjMGOGlDzub8ABnEkEqaLJNoQOgAiRN3gwdqJa5CkFjDvUo
	 QiOCHToDkI1+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340ED380AA62;
	Mon, 20 Jan 2025 19:51:23 +0000 (UTC)
Subject: Re: [GIT PULL] vfs libfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250118-vfs-libfs-675d6c542bcc@brauner>
References: <20250118-vfs-libfs-675d6c542bcc@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250118-vfs-libfs-675d6c542bcc@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.libfs
X-PR-Tracked-Commit-Id: a0634b457eca16b21a4525bc40cd2db80f52dadc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e587c20adab5b8da4c7b5573e711a8c808e0a2d
Message-Id: <173740268189.3634157.10054246238991878576.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 19:51:21 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 14:08:14 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.libfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e587c20adab5b8da4c7b5573e711a8c808e0a2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

