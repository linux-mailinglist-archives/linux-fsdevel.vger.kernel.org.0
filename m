Return-Path: <linux-fsdevel+bounces-23722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B3B931BF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A831C21DD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A765144D18;
	Mon, 15 Jul 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAk3PWD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0B13CFA5;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075684; cv=none; b=FqDA18Lvhse+uE/IGOAFJn2PzA4uJFhJ5OvVdCP4xme+m0pOZWGukda45tMSxdjZKb4rA/ashArgcd/Ge/wWU2NE4dyIine1RWx1xWhzpC+H/ngZWbQorp+0ejZ7qp4GwQTLNwmKlDBsTV2Q1v/meVdx/bRQFcnzS+mygWn6WGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075684; c=relaxed/simple;
	bh=BaJFmf/0IromNC8vf1H9BKnUXGSTvwI7XMYwFzZ29x8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YJa0pNUb2KdWXb5n07va0Tp+rUzw7v0rBCJTE1sqomoA2AG+kCSjt4cQzcqqRBQe7gUBLtPafe54FtW3d7z/5+T1G2SNkR0MeLqlA78jPcDPLgoLSKBxZ2wTF1lBxlkMu2zdFi90VK6CfcPb5WL8dOX12uzTQjtpGKLt//hpMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAk3PWD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFB53C4AF14;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721075684;
	bh=BaJFmf/0IromNC8vf1H9BKnUXGSTvwI7XMYwFzZ29x8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iAk3PWD2EdmvOQWN/2xWrYagAQfAuLU6rgix9DdcS1OYgpxuGzzUtHtRYgDgQMSZE
	 5ccnSh1f/EySAqtVyRzHEZDCGLOs5Gx2qmHrbqPG2Nb86YisDYGDnMPqxmVbSisqF8
	 tOgc0A1bsMkld5ODPN7I4SbnJN4gcrLGxVmTBv7aXN5njf2ACpEf7wp7G5v9jcsqmn
	 /J7d1X83CviVVzqUPkIXS4YWFmHgqRjSL+PretAvrxu+v7DSZiSqdput7t3CW1Bx6V
	 zTiEOql9QRd7fL1nMq8vJEUXZLSl5yzlubmEtoc09XJPAIia4FaVPXro8ynpQFZfhL
	 zmtUp9SaO6oyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5A8EC4332E;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
Subject: Re: [GIT PULL for v6.11] vfs inode
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712-vfs-inode-224711153dd2@brauner>
References: <20240712-vfs-inode-224711153dd2@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712-vfs-inode-224711153dd2@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.inode
X-PR-Tracked-Commit-Id: dc99c0ff53f588bb210b1e8b3314c7581cde68a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2aae1d67fd1d9070f8f23a6e7d9a7a093cf35fbb
Message-Id: <172107568386.4128.9795547648247251339.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 20:34:43 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 15:58:04 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.inode

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2aae1d67fd1d9070f8f23a6e7d9a7a093cf35fbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

