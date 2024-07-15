Return-Path: <linux-fsdevel+bounces-23723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24EF931BF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB7D1C21E0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64255144D20;
	Mon, 15 Jul 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSwgKQy+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F31013D24C;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075684; cv=none; b=BAGV/cpd2eZyO+GGID/9o3hYgueuM0cyF/TrkxC9CD+YwGNvNO8j+U3XsoTr7FPlLL1u9Mf+gegl3ue/ERpX/MLZL0QPpY2Zshs7DhzG08giXJuXG9d4he5BI6UZxQB0eqzUUVwJcwnt/CyzdCI5XvN7AmzFpsCprBMH961sveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075684; c=relaxed/simple;
	bh=XZ9Eq/FEIwF32mmw11/4ohjeLkHn97fcGylf/Nq2kOc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GzWFQYNBlP7yGUHZkce9amf1O5bs2Uc5PUeZm4b8mCYgd14ANEWHvLMoTdYYC5kGlaTyNntL7DQfEQFXYcFLNTj/xp+iWEf08hETOPvl/WBl7OgQIF8yH3t3kY7crwVNg0cig2j8vRO39r2okLWZHdNGkDjYAd1CfqnPxnLjkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSwgKQy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D16CC4AF18;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721075684;
	bh=XZ9Eq/FEIwF32mmw11/4ohjeLkHn97fcGylf/Nq2kOc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hSwgKQy+4yz5lN0JXF2QwxPzQojDYZb0LthzD3KhRcB2sGzCn2y5NhNE/Kr04f3Sq
	 JhHPw+1L53F7xICMIuv/JkM50IvQM88jtWs/OvZFdBxj8iJ3J6mVyZ5R1w7PYpj1Hs
	 wr88zoXV3n+WLthZGi22PO464fjNswkzls+7xR+27uCpaiClKM4Manbot+g58EFVN3
	 KPoUi4zxo2QlqRnZBIUWl5JVS4cBoqye2VPwG02o4Zh8F/gKLiwDhNn0ZBVqC7EW2H
	 HeKsO40qPdZwDBeoxKtdArNcXNlk2fNIQK39nkXmJqptCiE90Eju1SFp0f31/rF9nm
	 VS5GNNlSyr4Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AB63C433E9;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Subject: Re: [GIT PULL for v6.11] vfs pidfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712-vfs-pidfs-18bf3ec8bde5@brauner>
References: <20240712-vfs-pidfs-18bf3ec8bde5@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712-vfs-pidfs-18bf3ec8bde5@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.pidfs
X-PR-Tracked-Commit-Id: 5b08bd408534bfb3a7cf5778da5b27d4e4fffe12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98f3a9a4fd449641010c77abca16aebb0b8d4419
Message-Id: <172107568423.4128.3158959887165771303.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 20:34:44 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 16:01:45 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.pidfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98f3a9a4fd449641010c77abca16aebb0b8d4419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

