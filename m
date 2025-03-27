Return-Path: <linux-fsdevel+bounces-45167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF03A73F80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 21:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B7E1782A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 20:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928FD13633F;
	Thu, 27 Mar 2025 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQTLljMx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901C2BB15
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743108551; cv=none; b=So7/Mbd6C02pplHIU5NnXf/sv2+SFGm+0GTyW3jvE5ljsNKVsMiyT3uMnm0w/HbDZM3b9GIO59AKGusGJbVJkJ+M6Bd0vP8noo0hfIIleU1WWHIzPov7DUreqpivdzRVe/eOiz06PKKrh1kFF/fYXjMYHRKVwergZ2+9yc32rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743108551; c=relaxed/simple;
	bh=yFH4eLZQ6gSCpiKHJLEbHbmZX9q5HZfl9b4r3uS/quU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M5P7S7qv57cjRYpUacpM9ddiflXWC5BXLL18hBoNvZa6euukSxE1Dfnfzl+++8O+UhMB4EIdDST9mdHWHT+JcgH7r+iZ7817urPcanpk8G8T4Mi3tFN0o5FtQe0BSm8qJJyX1I/PrRxCK3bgvWQ49vu1qCal0CFrWQteICes3xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQTLljMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC00C4CEDD;
	Thu, 27 Mar 2025 20:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743108549;
	bh=yFH4eLZQ6gSCpiKHJLEbHbmZX9q5HZfl9b4r3uS/quU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OQTLljMxjUYbvBy9JNIHzRcNrCeoZ3+aofGJJbyPKLFylH74wqKDz6ZeqS8yz/dLf
	 EqALpJ6Ymy9XnE75Tnj6KMT/vF/wtlfXzxmlZ2GI/MBmW5wuc0997QaX+4dlo2Gdw2
	 Ktin6dDYt/hdCaoSsylVYjH0bZbpUdUIYdbz8nOMZaDlIebG8a5hWVpnJV/pfTJNT6
	 0Ff6PmL2vNAzI+pQ7nS1JShtbf5LecDEIH58tQqGTp3nMPps2jnauE9ldeoirOThF4
	 qhMPqe5jVnT87na3AtVvz06HLJaWwxVn6HjsD2LZwqNm5ugvY/sN75iExcS5RH/LrO
	 +49m/n4zcsl8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD51380AAFD;
	Thu, 27 Mar 2025 20:49:46 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs updates for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSQm_2=gAhyqUHjbK6pqedxH6n6Wd5Zq5opdZ0gjHMKsTQ@mail.gmail.com>
References: <CAOg9mSQm_2=gAhyqUHjbK6pqedxH6n6Wd5Zq5opdZ0gjHMKsTQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSQm_2=gAhyqUHjbK6pqedxH6n6Wd5Zq5opdZ0gjHMKsTQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.15-ofs1
X-PR-Tracked-Commit-Id: 121a83ce6fe69d3024dfc24fee48b7a2b5386f4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fde05627a2d5cb85a2bded96d11f493e6671ecaa
Message-Id: <174310858563.2212788.7666304263068468305.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 20:49:45 +0000
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 14:38:57 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.15-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fde05627a2d5cb85a2bded96d11f493e6671ecaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

