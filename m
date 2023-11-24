Return-Path: <linux-fsdevel+bounces-3773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278617F80F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595701C21674
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6AA364A5;
	Fri, 24 Nov 2023 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieaLaiFu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611C33CC2
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 18:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BC9BC433C8;
	Fri, 24 Nov 2023 18:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700852053;
	bh=664Y8MA/0B47W1i3on5LKRuCh4LThPWg5J+MHY1/lOs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ieaLaiFuuzuZQlgVuhEwYB2Xqlwd7Lw5YxWMC/ZXzBul4rPGR1AhOcO0D6EyQeB6a
	 JHjxKkI7Gqei6izM7IfNQchrfpiFus/zJNuM1ZeD9pPhcHU9u/rQsEnLxyXHJxHxlG
	 A1G5/B9Qr5PfHk6keJy8yxTJshulcVb/yoAmZfKXOo20+ak+zkcauwBIZiqQtq9SRo
	 usoNWBqxj0AtSBpsK7eJ1umQsQNfBsKaA9UGs7tlGx1cOo9q3UexKVFrvaKq4xeQuc
	 58wjlwVc5/JAhKB0pfgf8P+mxfkKREF5+pvnfZNvk4Kg29iRn3pNlKJxl0fJAcsAH2
	 KbAIa0QTc+nZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47619EAA95E;
	Fri, 24 Nov 2023 18:54:13 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <1205248.1700841140@warthog.procyon.org.uk>
References: <1205248.1700841140@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1205248.1700841140@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20231124
X-PR-Tracked-Commit-Id: 68516f60c1d8b0a71e516d630f66b99cb50e0150
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b7ad877e4d81f8904ce83982b1ba5c6e83deccb
Message-Id: <170085205328.28485.6142612157773740209.pr-tracker-bot@kernel.org>
Date: Fri, 24 Nov 2023 18:54:13 +0000
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Nov 2023 15:52:20 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20231124

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b7ad877e4d81f8904ce83982b1ba5c6e83deccb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

