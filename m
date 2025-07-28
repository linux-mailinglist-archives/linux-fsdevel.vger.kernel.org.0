Return-Path: <linux-fsdevel+bounces-56202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD0EB144DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34361886029
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2403285043;
	Mon, 28 Jul 2025 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayNKVRGo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5AF28467D;
	Mon, 28 Jul 2025 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746036; cv=none; b=XQGSWrrSxPuEDd+LJM1x3ux+8oi5V3qygwzC5Oc/MWucCV2QYlOn/0sowDmZsOk/CA4fzvydG5UiKKTFlxfuHCcD4vIaVXMugdzvaf8GgTL2aL0MwzfXqsf5gd1UlsqcmqxpL0MU1/1kMlhTF7FIpvzIcB29n3cAMbGD3MiBuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746036; c=relaxed/simple;
	bh=n1I/Tu09X/AetOjfj86uzyE9z7C83yRhTYetuxHt0Vk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kKyFbIKEGDq9oHFo9rn1MtNmmrw+3kAYcyQubghZjOIetfMB7okP/ch0Q9/P5qcEZvzndMjmtPUUHHL7CEDEWyfLkVyiLue3cJs+jeeptux/NpxHU9lWRodRfQekaCVQ/wCzsBa2J71MqLzOCL2nZz74cF6YgM1h6YDOYDFpQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayNKVRGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A9FC4CEF7;
	Mon, 28 Jul 2025 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746036;
	bh=n1I/Tu09X/AetOjfj86uzyE9z7C83yRhTYetuxHt0Vk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ayNKVRGoa5iYIFsoWhqrnGwObLHmkaXdMIPnxdWNBCHVXD2A3qS5w6ZzohUbPaNvM
	 OOjx6An+BTwhwCvdao/R2ioHleFrtgEWu5+F10TVtJZW2OpI3bVjbBzq9rWbUEhtCH
	 cSnUukvELAoKlvGUAlQt+c4W/udR1lzpB+v4XX/UT3GSJhva0addq75gMOdwm4calN
	 IoQ6LVXKQC+XpoG+Lt0UvVjOyFtPkV2OZXUIVI8976hwVhGT4SRWLdytl/BJ8OB4Uy
	 3nwKuErLDXhrX5WOCbdGJevfT545VMCA9An9yxM5+dJ+kqBq355mTj1m3yoTiE4Gbx
	 +teKvBbkhfU+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E78A9383BF60;
	Mon, 28 Jul 2025 23:40:53 +0000 (UTC)
Subject: Re: [GIT PULL 07/14 for v6.17] vfs mmap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-mmap-f49018b134e1@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-mmap-f49018b134e1@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-mmap-f49018b134e1@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.mmap_prepare
X-PR-Tracked-Commit-Id: 425c8bb39b032bfb338857476eff5bbee324343e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7031769e102b768b3fa0c4c726faf532cb31e973
Message-Id: <175374605273.885311.2369932551718736750.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:52 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:22 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.mmap_prepare

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7031769e102b768b3fa0c4c726faf532cb31e973

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

