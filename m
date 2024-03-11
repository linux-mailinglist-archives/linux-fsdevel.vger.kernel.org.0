Return-Path: <linux-fsdevel+bounces-14152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795AE87875B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 19:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3487A2829A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 18:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E509154FA5;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8myZ9i2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7C39AFF;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182028; cv=none; b=J1NL5AywK8SSGiX2FHw6aVraC/9FDTp0XNl837xXtriSIdrvhIfQdYFYABUz5xXFt6H96FvrOy/FgOD9RDBcDvl5A0oypabAzAO8ERvzsmxjsG/xPXsmpQlc7+WYxhcRvmOvdvTP05C3N+dX5zRHuO8hrJjywspDuwGoaY48yxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182028; c=relaxed/simple;
	bh=E2PgYkFp0PjpfXwFCvELdflLi+Sc5bzg9d7bo+nm+pE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XtO2snPVgG1VOH7bXohiVIErFwEURhyUY/d1rMX3CGmRQjyHG+fRKC2bIUl4dVd9i+cjnXAIjFHrLXXikIsd/lZnxtfLVuoSucAIbxMBQeoNRK26nPYoCN4EmQ2fNAPSz5G93YncNbBS7qD4mkmnUhA5PvDi+S7r8YYA5t6khYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8myZ9i2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2729BC433A6;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182028;
	bh=E2PgYkFp0PjpfXwFCvELdflLi+Sc5bzg9d7bo+nm+pE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r8myZ9i2bVRtQOIQU0ADv2tYfOyvfvHFtkSlLod/1aHU8OKvMA7MjLP8u1T2QuQR8
	 yIncs/RHvoCUKJDALbhyZEFOWOejYi18hhkdMJFHLIwPW+uu44OUHmeyIFlJxGa1Gt
	 KR9CT2BaOkC9RiN6BFke4loiCEOkRS1TncAdQmAnxjV+HKI/SFHFInIBUKnGZeuNc5
	 hE1PF/6FWD7dPJOEdHFkDKZOrjqmSejOWF6BIJnQYF2g7vq1Vo7b/fo0Bm71tTw9DS
	 K8YbajHHjVlB0a4iWUYF91CMC9uT8oRetmkXRj9i89EjByMoRWEcxF8bTxd2hvC0S+
	 wQEbwIONjh8QA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C495D95055;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Subject: Re: [GIT PULL] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240308-vfs-misc-a4e7c50ce769@brauner>
References: <20240308-vfs-misc-a4e7c50ce769@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240308-vfs-misc-a4e7c50ce769@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.misc
X-PR-Tracked-Commit-Id: 09406ad8e5105729291a7639160e0cd51c9e0c6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ea65c89d864f1e9aa892eec85625a96fa9acee6
Message-Id: <171018202804.4685.16993564841860122496.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 18:33:48 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Mar 2024 11:09:08 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ea65c89d864f1e9aa892eec85625a96fa9acee6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

