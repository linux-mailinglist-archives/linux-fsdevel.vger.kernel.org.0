Return-Path: <linux-fsdevel+bounces-35131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D6B9D1945
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52AC5B23F47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1F01EE017;
	Mon, 18 Nov 2024 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGMHKyiX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661F1EE006;
	Mon, 18 Nov 2024 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959345; cv=none; b=bXCAZvc0B77APVuJzh+/s+fFSurnwHc18NtB9rkttiXv2MSCNEuzEsuWA2ZvgzJe23s+Pfll3QGjWkvU9FVBqjye+wkoBYvGrrkzXV9XYf+hZbM7RuIWTHqoNrNZHp7xHfs3LTHL+5+U9PSXhwbYKaK1OQ6oINsZLivC05NcXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959345; c=relaxed/simple;
	bh=HKTf4uDrj/QysyZM1e7Fv7mIP0cWOCO534Zya2qPBJ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TlYKXOqo5RAPt3LjyzWc0WHB/CfOCP+sy5DCEOwGLZgRLVdoo6ZzIkzCiSt9u163h5MwH5o4odyKokNJ216Go9Zx0/7u35AwK9/UvT+Wxj2by16Kq/bk3hYacScx1sOOJebwHH+W28ZXGhAnRa1SbQY8DW5FJyxHGdtb9d/sSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGMHKyiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CE2C4CED1;
	Mon, 18 Nov 2024 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959345;
	bh=HKTf4uDrj/QysyZM1e7Fv7mIP0cWOCO534Zya2qPBJ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RGMHKyiXPTW7BsRZ9s/g1Cen8upqcfbq15lvSMIP+ZnyyTPsCzDhjmy1ZfmTTE5tD
	 sUAUjCAFoLzuep7UGTwCOzRHSrzZlArtnhiJ4eTXUJWjZvGQlrQeF1zzIF6rq0BZfs
	 kJadq9shhuiEuOcGQNZMhfjmuEcBcwE46VTn7fQJSOQ64alXAjxSxKlEx4rTR+bhfo
	 ncDrvbwYiYwS7h4vFur0RxdWPlWoFXcZ8g3xs2qOlImIe6nV6y4FJ5nk1QWXan5Rae
	 0GYWYWlDWd/yYVxJMMvo2iT4/pFHHpZVegczX8hSZUchGlparpa9VKHZ6G0twyyqZn
	 KZlBJA8bs/aKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8823809A80;
	Mon, 18 Nov 2024 19:49:17 +0000 (UTC)
Subject: Re: [GIT PULL] vfs copy_struct_to_user()
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-usercopy-82de2c4b92b7@brauner>
References: <20241115-vfs-usercopy-82de2c4b92b7@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-usercopy-82de2c4b92b7@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.usercopy
X-PR-Tracked-Commit-Id: 112cca098a7010c02a4d535a253af72e4e5bbd06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5ca57479656f2562f164d650c6646debbe2f99b
Message-Id: <173195935631.4157972.13322311610044582992.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:16 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 15:05:46 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.usercopy

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5ca57479656f2562f164d650c6646debbe2f99b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

