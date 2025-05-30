Return-Path: <linux-fsdevel+bounces-50250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E156AC980E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 01:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F9C1BA7EF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 23:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D928C86C;
	Fri, 30 May 2025 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN1Dl0iz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0428CF4A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646993; cv=none; b=sghjzLU83nKTn561Nod6TUYLXvDMrD4sDhyV1waq0owQ3locaMImtpTONzD7lvkLweaoXfaViIkzF3cIlsHa+i5L8CqePrIrgmhkHgCnP8uZzJ5TmfB6wEZ6/q3kMax8TPSscBnHkjEF55YXumKV8ldTlzDCtTY+hIfxFpwO6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646993; c=relaxed/simple;
	bh=lMgec3DNRUHu8Zz5kcQjUiQIlaJLnLzgGgr91v6BfPw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ggp1RUCdx5o0exa7OKlAo9QRDXeI0wj5WWDMqrGIDhsuWmh46UfNZ98ci0/Pv0I+S2lp5B2jtOzszFtPmih8baQNv5bZ7Xx1Lm0P8953m/tbIcwP4oqfXdZ/98IWfi1Zyku/ajtIXc6K81juilcQNubeRfvtuFCyJvnVcEhphXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN1Dl0iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EABC4CEE9;
	Fri, 30 May 2025 23:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748646991;
	bh=lMgec3DNRUHu8Zz5kcQjUiQIlaJLnLzgGgr91v6BfPw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PN1Dl0izWXzGTGT4mBWP3EzfRjqU9FlO37feNMOE0mFeuRD/ZL26o/xleeRvea1TG
	 pW01V6IAwHQ4EzatfVECRhIMEYA/ts2/YpSLf4d5dVF3/pvrR59F0NhnjkvmpNBACe
	 gEKDdvBJ8abZHP7mpl8cGzxWx8DHDSyfrDOfIekY2eQWKFu/veiynE7k3gICZ5M5AD
	 2QnCNvTp82Qu3ZUw+6H6vQSpHLw09JUl86NAjx/Sy9tRNx2HO/3i3WB04t0nGwl2FN
	 7gdsmGM6slRN0jDQiTI/lCmdkJx6IfpxjK4xcE6dBR36hww7oQdfWOLw8ucLHk+WGm
	 poztEtxc+j7xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E4739F1DF2;
	Fri, 30 May 2025 23:17:06 +0000 (UTC)
Subject: Re: [git pull] ->d_automount() pile
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250530205630.GC3574388@ZenIV>
References: <20250530205630.GC3574388@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250530205630.GC3574388@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-automount
X-PR-Tracked-Commit-Id: 2dbf6e0df447d1542f8fd158b17a06d2e8ede15e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f70f5b08a47a3bc1a252e5f451a137cde7c98ce
Message-Id: <174864702488.4165071.105129911764547494.pr-tracker-bot@kernel.org>
Date: Fri, 30 May 2025 23:17:04 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>, Paulo Alcantara <pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 May 2025 21:56:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-automount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f70f5b08a47a3bc1a252e5f451a137cde7c98ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

