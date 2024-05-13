Return-Path: <linux-fsdevel+bounces-19389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E38C4795
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 21:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F119B283008
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 19:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7207978297;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5ISLnfj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31447580A;
	Mon, 13 May 2024 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629080; cv=none; b=jiDDMi2Rdx4yyY00ur6QAEgmQUai4oWS8b1r0P9IYmKS4JdOfo8Fug1QxIH28UAZk2nkYfVBOOb5Cj/vLBmnge3kqe37QyBv4An5VgtiFClMtpTo4r0lTsx0+ObMWGzXjol8BKiMT8PTzDpL4PsXyUiyjh1sGCO/aUU/najHXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629080; c=relaxed/simple;
	bh=H3eH8eIOKHsXeIUp/9M3ET4Tpdz6Tr5eA8zdxl0tt38=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VS832YbIzxckaV69/B1amizannNSYir/PFiVqzBTFmahc3DkVyReGjoAQZ3Fb9imud5v3a6jhjfqmYrGfvSQ1EI9tDTTsa4INVX5EroTwZrQSlgLnUpvw5xHKoqRqILK8ovVHZ9mq+KS2IsGQp8asqtrVq0fkPafPuBT4pX80sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5ISLnfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8686C113CC;
	Mon, 13 May 2024 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715629080;
	bh=H3eH8eIOKHsXeIUp/9M3ET4Tpdz6Tr5eA8zdxl0tt38=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M5ISLnfjgOn+2Su77p+EFZcsshnjd8qpZaETb3sy5xDO6PJb4Ihh0TVHkqkg4quId
	 u77edU9pwUj6kpANluDsGgpeAYAZt0oFUx/Yl//b4oraUY7K00rz/jsad6JvxDqtvA
	 a/EsAFcsD4ZaYnCYL1xJvrP9jChRIpUGbJ7RxhA6qBecw4n42TViUOKnBiAibQ7HoQ
	 ltuJe6zVM8ZdJPInbbHsDL/i+JWwREz0FXXseDHCSg0lbuWoejO4QN498WQsVRzqB1
	 mtvuXiyZvbeJADsmEjE7RR3Q2vkj52q15P3t1BO78uGMZqwOA7NVMs1f/YGw5w4Duv
	 4rgkDKYeoezOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB043C433E9;
	Mon, 13 May 2024 19:38:00 +0000 (UTC)
Subject: Re: [GIT PULL] vfs iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240510-vfs-iomap-eec693bccb02@brauner>
References: <20240510-vfs-iomap-eec693bccb02@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240510-vfs-iomap-eec693bccb02@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.iomap
X-PR-Tracked-Commit-Id: e1f453d4336d5d7fbbd1910532201b4a07a20a5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c117a437f25db7d88831816cb3a40ee556535ce2
Message-Id: <171562908069.8710.6374733792373055380.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 19:38:00 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 13:45:49 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c117a437f25db7d88831816cb3a40ee556535ce2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

