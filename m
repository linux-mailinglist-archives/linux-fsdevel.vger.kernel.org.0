Return-Path: <linux-fsdevel+bounces-56201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE6B144DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F20018825BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCBE283121;
	Mon, 28 Jul 2025 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h45RLV2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89B428134C;
	Mon, 28 Jul 2025 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746034; cv=none; b=QsGkXsqjNnNGXPkhWdxbQ0hWa3fZSgr7U2u+zNfNHt+khnUPKxhwXHts6mVV/d/BwcMxPo0wJ4mn7QuYXoc45kLPGGYDU7fGVgF5upqt4AGrVCuTaBVNGE6W8s5B437hdXdgqrkJdoOLk41RQHExDPn8G3Myj6rcNx4QYiqHQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746034; c=relaxed/simple;
	bh=HdGlgc8n5/3B1orgMGNuVqOsT7eJ86fhzl6URDkPEcM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cceoj/r8iWjfjp7fT+gww+eDpz4hqXTb9dAE5ei85n6kYF9w5Bo+O4RMHumZoHNXhEnxv4F6p/L6TxRKlyhlRPKviHP3JzQSOPow7csZrNLLQdyNfWsBOFeUwgPfuRapYPG4se8kmNg1tgIBT0mwDHK3/pqYFJhEHUmfF9/JYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h45RLV2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3D2C4CEF8;
	Mon, 28 Jul 2025 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746034;
	bh=HdGlgc8n5/3B1orgMGNuVqOsT7eJ86fhzl6URDkPEcM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h45RLV2bzEVjeoTAJXH7bdQzzIJ1vCBFM3KkmXaDDeXrAP8/cMErrf9nHb0NgWW+Z
	 +U1eziWumDwJdhOaC7IWN284h/SQZAP/0j2jWviqCPINivZT8bmlVQeRlahh9MZy0R
	 jeMtoQzEsyOUD8nv0h6Vy8fPx/UqiMMCaATsnx6gHA8IUJV7bVgJ1sVqcSvAIg4AhC
	 yQwiVyi0k+yLRwn17pQ6rzl30XILJO3y5p3JRWvpYSv+d3EQdX1t4HaTryf2AX5xph
	 YQFpx49hQYwuNA8ibOhUMMQhpodpz/mcwsVhO+rQc6xBVJO92B9h+sxATsdrIShIqk
	 piPH8juFtGsXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8B754383BF60;
	Mon, 28 Jul 2025 23:40:52 +0000 (UTC)
Subject: Re: [GIT PULL 01/14 for v6.17] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-misc-599b4aef8eaa@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-misc-599b4aef8eaa@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-misc-599b4aef8eaa@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.misc
X-PR-Tracked-Commit-Id: 4e8fc4f7208b032674ef8a4977b96484c328515c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7879d7aff0ffd969fcb1a59e3f87ebb353e47b7f
Message-Id: <175374605151.885311.2023720828045315827.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:51 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:21 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7879d7aff0ffd969fcb1a59e3f87ebb353e47b7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

