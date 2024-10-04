Return-Path: <linux-fsdevel+bounces-31002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1081990A66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6738D280A4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C35C1DAC9D;
	Fri,  4 Oct 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e87SIrOf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBEC1DAC8D
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064229; cv=none; b=czJ572DOH02gQ7Rx+AHqiR3OzXIBV/bXc7+Kx9Q8JTxtx4D4VG3mD9HBo1uTiWfUZTOF5AVl83X8Gd1clvSgH5QnoZ6+pAqcayQ90gAAbHbaolgFkVf4UPDBvT1un9s29NDQWWFEd5iawQdliwAzMfIZ1lqPR0S83pizlZ20uPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064229; c=relaxed/simple;
	bh=MyDm12iJSOB3d0vCS9GTrZi0dQuJdh2E6nlurB7ak44=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=peFcckT77aCwfrZ2BpciA3NfBBc9DEOzxkBjLBukG7wmd2CRg0zMnWbAbM10/TpoShsTqJYVjHXmythPL6UvKv/+GaQ+crZAM1VTiIjBQ86rPU8EX0uVHIuo3eS5GzKh9CE5n7U/nras3g5wYfkZzg8vnoLi08ZiyuqvWTU1ZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e87SIrOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1339C4CECD;
	Fri,  4 Oct 2024 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728064228;
	bh=MyDm12iJSOB3d0vCS9GTrZi0dQuJdh2E6nlurB7ak44=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e87SIrOfeVeKGVcUhW7xzcn7VDV00LINjxGoRjaUyxVCT9HjTfeVyucWeZUvFAqzr
	 3Cw2p0qHQqTw3H58MTCwCwhVZzCUr6q9B/64o9xMXEp7Q0EA0CfPQOM4adgxkmDQui
	 hW9m9IjEuJ/tD3yySZnSNjtelsmsQ1l6xaHyuVoAiAjvEMr+okItcaWZb+2zhsXrpU
	 qDluRIoasHdSPyXzaWAH5XCA5yS/fsBzhFhRfMlxG3ZJwoE9arps1OvnDyhDdn4PWU
	 qmlc8Pl5lMkpKfSAZzOyGn+b0W4gYjoo8xz6yLvHytm9Pd36eXkZRUQ8KAnnCYx8i7
	 RxJ9FuKk+d8SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF6D33ACF641;
	Fri,  4 Oct 2024 17:50:33 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify fixes for 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241004143602.jttrziwhqylh5ugo@quack3>
References: <20241004143602.jttrziwhqylh5ugo@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241004143602.jttrziwhqylh5ugo@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.12-rc2
X-PR-Tracked-Commit-Id: cad3f4a22cfa4081cc2d465d1118cf31708fd82b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e02f08e217165500a9500e0db1b2da9f4db4e964
Message-Id: <172806423239.2676932.591194620666977524.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 17:50:32 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 16:36:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e02f08e217165500a9500e0db1b2da9f4db4e964

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

