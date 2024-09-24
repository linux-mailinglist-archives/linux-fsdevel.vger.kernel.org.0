Return-Path: <linux-fsdevel+bounces-30012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2111984E1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 00:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9771F2462C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 22:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648217BEAC;
	Tue, 24 Sep 2024 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KioeQCnj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B4417966F;
	Tue, 24 Sep 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218206; cv=none; b=anZzMNdD4xoyfTQ7mM0OQQbPCoi+poBedwOXuBJCG6HHFKCwUg7e+uSDHXWCbdftnKIvQrnMBEJg+jAKb0tBkaUssDiscKRVHcFfas+grQ0lAb/3lm+qNf1GIx8LrvcSbL/4QUwWXISPQCNcnSL2zE+qveZolx0bG8F7Y+HijKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218206; c=relaxed/simple;
	bh=psPeoO0rCCnxW/v9R+0Jcvuzi4vkQj+OCsMLY96ea6g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C4wDBHYqOhubRAVtGX7pqOCTerNUCNwcAVa38irS/+JepoX7o+FuX7wqM4bb0pawpN2Qt90i9fSnsJWRVKI1w8EDNFw57pxwD/9LmL39jqoGTk6FKLQEXEXY4iUlsZjWVjjmfg5lL7lRNEEpljNIhlS4F0uhOD3sKrkPYosbSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KioeQCnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44AAC4CECD;
	Tue, 24 Sep 2024 22:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727218205;
	bh=psPeoO0rCCnxW/v9R+0Jcvuzi4vkQj+OCsMLY96ea6g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KioeQCnj1HHsb/WDB3VQi5VQ4tKX8r54olsBRW+2kbCbjfsTwh3rJ5J6NEaoaMtAM
	 Q70KpCrrqo8qddyF0CnuXPaCfOOmcvEeF7OrGAZxhixbrNJkoKFCjyOC1z5b1efjU2
	 j2BFwmChOW55MJFdk8148Flec7thBXeeorvzndTluW8u2+qACpBNUbTumaByELqkvc
	 AbZHxn87oXcHkpVZpEW1XyiqQNKaxnZ+BkaCWJfi4uKxijRynDSCLYCI835GgR4lCC
	 sIQIBucD8jYxpDxJBeqt6xFW03K4BBoxcXtJyir8PDUUjFOeV089qq6KH24j4hsaNL
	 PGrpVD+oiYKKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8ACE33806657;
	Tue, 24 Sep 2024 22:50:09 +0000 (UTC)
Subject: Re: [GIT PULL] BPF struct_fd changes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240924163423.76635-1-alexei.starovoitov@gmail.com>
References: <20240924163423.76635-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240924163423.76635-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.12-struct-fd
X-PR-Tracked-Commit-Id: 37d3dd663f7485bf3e444f40abee3c68f53158cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa8380a06bd0523e51f826520aac1beb8c585521
Message-Id: <172721820839.30034.899688400394554863.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 22:50:08 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, linux-fsdevel@vger.kernel.org, brauner@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Sep 2024 18:34:23 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.12-struct-fd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa8380a06bd0523e51f826520aac1beb8c585521

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

