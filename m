Return-Path: <linux-fsdevel+bounces-35125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AAA9D1937
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D84928342C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153B71E8851;
	Mon, 18 Nov 2024 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXRokp5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042B1E8834;
	Mon, 18 Nov 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959336; cv=none; b=k5iGhem2tyNH7DdQW9CIUpnHq7EACwq/ZIT+YDWipjJQqRIsB5nPYmDx8tCz9w4yLvsL8LFKEQlbMF4njFJ9jyyka+ny9/4GBq+iMaiv5rwNrqW1MnUQn18ZiiccqdsrQCJmuMmrQw5Aq0GulfVTEiO2AZdVMLlZDS5WFBJB8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959336; c=relaxed/simple;
	bh=ENDYSqpBTMgGiO2KjE5eE3IqUQwEUt9bMfV/mDITwEw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IG2GkHS1pewnvoWM4mnC9JBprixw0GJlnaTD3He4qor3fX+dV4PTc3drru2EVQqx4BP+cQdxNsESaKY3bK+Gps4IgUwaeyazSAn/LW/9YyykpBKqlpRTjgFge1F00HOofEPloXhoGB4hf0f8ANXMy4k6m8HVqCR6wVSpNzTmRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXRokp5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C4DC4CED1;
	Mon, 18 Nov 2024 19:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959336;
	bh=ENDYSqpBTMgGiO2KjE5eE3IqUQwEUt9bMfV/mDITwEw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tXRokp5hs0bv4ElHT+ZJnT/ZX604MnxUhc4miGX5wZWjTY5gvVlLHHH4s1Xvhw7MA
	 BgIIKs9sn0nzdlGV04gPrb3DhG2WaMlq19EfhpkoTtwjT8ImNQoVlFZrm304nL61G9
	 70vXxDHYh0JAv6VtkjS6AluBIqcwiCoGBc9WSCzX/pHLNK3k8sY/3WJaJg9D1HVL4L
	 Yuk4lcl3KXFLgCdXPy7R2m8zoj+fCPgOs2WJZzubemjc5wcpdJdwAwEMeLE3uxcO3Q
	 QYc79rPVL/n4IJO0bn/NYrxAu83AEmSv9hlZEYkoKo5m90bYv7skgbNiyZ/7VPCdAT
	 RrczidHAwcxzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC93809A80;
	Mon, 18 Nov 2024 19:49:08 +0000 (UTC)
Subject: Re: [GIT PULL] vfs rust file
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-rust-file-c79423c56dcc@brauner>
References: <20241115-vfs-rust-file-c79423c56dcc@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-rust-file-c79423c56dcc@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.rust.file
X-PR-Tracked-Commit-Id: fe95f58320e6c8dcea3bcb01336b9a7fdd7f684b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bb6ba448fe3598a7668838942db1f008beb581b
Message-Id: <173195934753.4157972.7393641062788663683.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:07 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 14:57:25 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.rust.file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bb6ba448fe3598a7668838942db1f008beb581b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

