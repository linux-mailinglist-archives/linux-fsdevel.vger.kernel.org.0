Return-Path: <linux-fsdevel+bounces-56203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1629B144DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A35163D2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF4D2857FC;
	Mon, 28 Jul 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF0EMWjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4E2853F1;
	Mon, 28 Jul 2025 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746037; cv=none; b=MeU9eBFO35Kfla14VglFP/rzr0gXIUUTaLfnXaqx4VjyftFRAXaGtu2hgOvKXOC5i9st8NgRBeMGOlH5aOEp2CyTC2vZ/5RIdYHyphGWnjOjJW0ZRSucCaiz1jd+MBHUJ+oo/z+a4xcNlTIPl1ZXTBEEN8cTMIab7wY5tN2mUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746037; c=relaxed/simple;
	bh=P1y25kq6VXNiu7f5ihZqrlkD/lmRnVFtln1BoPxP61E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cq+Vid2TJgPLRQUGS8EpbvcrbpfF6jJiCTHSzMfy1DVsfUPYhDHDomVf4qCIp1CUreRNljP9h1dJT5aosYd6sX4jM3o9dCg7+OwTxK5QMC5dMnjF/Z/0oUrNRCTnvZuY6LPJj5gjgOMfL5y0jU3XpsE8npzHk8vPy+5+eukY72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF0EMWjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF78C4CEF7;
	Mon, 28 Jul 2025 23:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746037;
	bh=P1y25kq6VXNiu7f5ihZqrlkD/lmRnVFtln1BoPxP61E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bF0EMWjJUzAS3pOkMXEW0W0uSLVFAE6tVRNQ1JqcvMWimBuGWXl9KS8wWhe/rFTol
	 DeeafmfIHQeGMZj2hYvAAIO/aiZj4WUfpX4xe7q+i4nMzNlIoYsgQD6U/f43rYdRNG
	 x4DuCS59vygdVsvIbB+BQYFvzW4RobDMm/TDeOmNFT7Kh1dOrum+T2DNdAhGd8ILvC
	 3nLJb+SkBL+romZhvS9p/UOytkBZa0wtuzy8U5TVv39qChyQf1hz+vbncOb/VnYKXM
	 3nvhnVZJ9JKdo/jpNqe4oSGNlOcDH/oMzYq+TSEcNpWG+1uLoS1A6nHNwUvwjPz/KH
	 OI2J4vX3QUZyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2C103383BF60;
	Mon, 28 Jul 2025 23:40:55 +0000 (UTC)
Subject: Re: [GIT PULL 04/14 for v6.17] namespace updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-nsfs-8b26651e63b9@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-nsfs-8b26651e63b9@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-nsfs-8b26651e63b9@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.nsfs
X-PR-Tracked-Commit-Id: 76fdb7eb4e1c91086ce9c3db6972c2ed48c96afb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f70d24c230bcaa1e95f66252133068a98c895200
Message-Id: <175374605410.885311.8191301251988279272.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:54 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:23 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.nsfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f70d24c230bcaa1e95f66252133068a98c895200

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

