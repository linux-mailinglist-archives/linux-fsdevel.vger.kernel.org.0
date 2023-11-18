Return-Path: <linux-fsdevel+bounces-3125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC7A7F02BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 20:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AD2280EEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 19:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7430A1A5AF;
	Sat, 18 Nov 2023 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctTXpXvL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E39134B5
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 19:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73007C433C7;
	Sat, 18 Nov 2023 19:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700336702;
	bh=9e3eBP7cjzbVZa6uTDZMrsdlkh2e3SYO3z+2ij30YyE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ctTXpXvLlL/7Q+A0vwMShn2V9G4rSC5w51KsZgNAzANY6uFutAj7a7Kc9T+xS27Sy
	 2fkvI+LiP84gkH1CKeZTl4PiXnY6qs4GaBWSW5yM2w6rREMLaoZ5TYMRfSu/4ANnt+
	 F0Ss0B9fV/G01o6QXZY+uTFGbqjyfABbAhC86YPAf48RfTgOgo9FcnDsOVPoPjExE2
	 hAjXQJ7q2v3ykqv8ZX8M1/vSrEQ/pS6vEbxtPyRb8qFlUSbzMbEeEK44jumO7tZLKG
	 GB5tThLpjq9vJ/zISQ2EvE+z/1cug+Hg7nlM5T5vJL8FBqtM+9G2It5gQ35RqSHxpm
	 c1EBeZHItn6tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EA66EA6303;
	Sat, 18 Nov 2023 19:45:02 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <87zfzb31yl.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87zfzb31yl.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zfzb31yl.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.7-fixes-1
X-PR-Tracked-Commit-Id: 7930d9e103700cde15833638855b750715c12091
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8f1fa2419c19c81bc386a6b350879ba54a573e1
Message-Id: <170033670238.17055.1005866990569291348.pr-tracker-bot@kernel.org>
Date: Sat, 18 Nov 2023 19:45:02 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, ailiop@suse.com, chandanbabu@kernel.org, dchinner@redhat.com, djwong@kernel.org, hch@lst.de, holger@applied-asynchrony.com, leah.rumancik@gmail.com, leo.lilong@huawei.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, osandov@fb.com, willy@infradead.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Nov 2023 13:46:27 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.7-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8f1fa2419c19c81bc386a6b350879ba54a573e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

