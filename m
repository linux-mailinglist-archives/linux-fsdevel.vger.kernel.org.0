Return-Path: <linux-fsdevel+bounces-39717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D27AA172E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD903AA22D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1F41EF081;
	Mon, 20 Jan 2025 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk/kCvkk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AB7DA82;
	Mon, 20 Jan 2025 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399565; cv=none; b=gJ2VZ27lNaimEfZDC5iGa+m/do0DEXYJ9Xh09p0/LxWoLFmn4Woiu8CPoRRfBdOeXYwK9ToFBMq6vKqvI/xcjhYSO+pBqeEjdIrLBMySsh8XR9tYnMAr88TUGBtAVEoNv0xgMYvbQldNhtJ+NMAcT6HJGKjpVIkjvaCsIiwZUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399565; c=relaxed/simple;
	bh=XV13gKlZKkt6Gr+ZGtBZEnrALjX08Iwe1c8c1+ySoqE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f+Cc1vtH5SwnuW2l94J1Xu8ZtzFPUKN2nYGRoE2fBWmciDr35Q6G7EPJN9sep30eqMGOgFZYqWfBgp17cEUdU0N85/GWzHY8jQwCs9QiboNFSpncEe66p/okzX/1FWbATWuge9sxCiJe01fRZRySFi9KxuS51rqtWfTY0t2AzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk/kCvkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D16C4CEDD;
	Mon, 20 Jan 2025 18:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737399565;
	bh=XV13gKlZKkt6Gr+ZGtBZEnrALjX08Iwe1c8c1+ySoqE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Fk/kCvkkVoLFKvRkocR1NXdPVXUdRtURCwt9DtoNcPv0HSnl0EqFT8jWmNPn+kAL7
	 qUVnKibe3dm5D/7V1FQ9NabY+Vga15T9S2n4x8pVtiMg9ogd8Rh0970S1Z5HArrXGH
	 yezuWLpuWXaqhbbbZqTwuzO/2OQjPhgs/yZyfGvE0keBHQWm/hIDkZG49hUQk9jkua
	 n2J/tIM7TwPfjbT91TbdVX3Pt44LEOIw2nNcUHrFAgFJb3LAuZzZBi5cpvLztrcXrr
	 gZk5aAKbQk7rT5ZxaF0kNklmAivu2uWFNpSH8rw4mPFAh3px81IME/b6/JJg6AJByY
	 4TXVkuPzpozhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF777380AA62;
	Mon, 20 Jan 2025 18:59:50 +0000 (UTC)
Subject: Re: [GIT PULL] vfs netfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250118-vfs-netfs-ba988c7b2167@brauner>
References: <20250118-vfs-netfs-ba988c7b2167@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250118-vfs-netfs-ba988c7b2167@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.netfs
X-PR-Tracked-Commit-Id: 7a47db23a9f003614e15c687d2a5425c175a9ca8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca56a74a31e26d81a481304ed2f631e65883372b
Message-Id: <173739958917.3620259.2803950428975101163.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 18:59:49 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 13:55:28 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.netfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca56a74a31e26d81a481304ed2f631e65883372b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

