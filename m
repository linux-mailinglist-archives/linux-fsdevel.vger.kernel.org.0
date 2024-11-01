Return-Path: <linux-fsdevel+bounces-33493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307FD9B96CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 18:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88B2281CC2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708691D131F;
	Fri,  1 Nov 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM6TTfEd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC21D0DE8;
	Fri,  1 Nov 2024 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483298; cv=none; b=UUVPiUXU1u/pfyWPzPxRZVgPgBghX5uUpN3O+mLyvUP6JB2gm9nCf/vuyDvFUQp/APSclJ4IIhG6VSGtkOHufp3z/8y7qFmn6SQsL+9P3CI4dclmLE02Ak38j3ZoHJZg0Z3z+KbzCG3/2xXXW2yBMo+fgNwE+0rURFSXkq8odTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483298; c=relaxed/simple;
	bh=+B5mikgYCxiUqhCo+qMVBh0JTbrKegWxEW1vcxoZq9w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X3HqO1jzobQLZg9i0NhFYvIt5jaUvCDvxRTK00mIFsxejW8XWH/+EhLAknla24+8NQP2rYCypWJ/L5Ga8FNRqnpaimhBDvmdFMQDDOxfEFPmDpgNzL3pBXJwbB83kcAfqmNsa1xLnhj5UMcFaYa5BInmjgMqiHNWEZNTR+MsENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM6TTfEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8870C4CECD;
	Fri,  1 Nov 2024 17:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730483298;
	bh=+B5mikgYCxiUqhCo+qMVBh0JTbrKegWxEW1vcxoZq9w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jM6TTfEdwnEHyQNWH1usFIN2wYqQpXPj+EM48xGxeCVaGdM4zABalSK63IY/1Exsb
	 yRDHf3u+9Wkl4Ltzt02QBbPerRhn7CDbiLnshJU5EBO2yamNfPw2Gah8sny2PAQrle
	 6xBUwXCStbfVBOMLAf4U8cGd534cKhX7/fS22GQuXrJWe+gjG6EzhU0v7tcMwXm9ol
	 fyxzYEJ5Qu5qithPy6S+nLGV9LPZuzDub4e7LXJoIjIt2b63APAPb9NbzMWDoieXmK
	 kkLgyFa5F13YQyu+pgToJQ7mHRldFteR43wplIigzu9qPMdT+5815OXdWQAPH/ocYD
	 o3pDLFRsidxKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC43AB8975;
	Fri,  1 Nov 2024 17:48:27 +0000 (UTC)
Subject: Re: [GIT PULL] vfs iomap fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241101-vfs-iomap-fixes-6ef0e93508fe@brauner>
References: <20241101-vfs-iomap-fixes-6ef0e93508fe@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241101-vfs-iomap-fixes-6ef0e93508fe@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc6.iomap
X-PR-Tracked-Commit-Id: 6db388585e486c0261aeef55f8bc63a9b45756c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17fa6a5f93fcd5dd936e07aee61c014d401df4ae
Message-Id: <173048330652.2762608.12301901832160234887.pr-tracker-bot@kernel.org>
Date: Fri, 01 Nov 2024 17:48:26 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Nov 2024 13:43:33 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc6.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17fa6a5f93fcd5dd936e07aee61c014d401df4ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

