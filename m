Return-Path: <linux-fsdevel+bounces-19837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48D8CA34D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 22:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE731F22516
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 20:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20211139CEE;
	Mon, 20 May 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY3tqqED"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF9136E28
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237029; cv=none; b=uf7F+kPIUxSHjsw4OWo5gIYKVMgSewREErNipHDlfTEjRQWgxemYQGE2pXWWr1QExh2zRuIOd8g8xfyn56dSc9HAqWZGxa/L+9GQIcATTNJ3N34YynDYl2i39lN8wf+qR3T97vf1xsyk1Zhhna3MolXBhAQhwBED4pzVK1qbpIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237029; c=relaxed/simple;
	bh=gvnpxUZqYN5VBZJj5hif1zQL9wKSeCfl0wttCBfDnbo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NvFsGaeJ+20EwzeFZ1yLcSsogaC1ZfN7fbTYSxW7lN4KPLFtug4dWd027cUJXVHxkDuvCEzP3q0GeHLbldPp2lIB7acgFRXCPGZT2YCQIdnfVVhntmtUSzwSt+VmaQofPvOpHe2MuoEBPiBahphox9saXFwFaJUDhm/av1NAtu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY3tqqED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 695CAC4AF07;
	Mon, 20 May 2024 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716237029;
	bh=gvnpxUZqYN5VBZJj5hif1zQL9wKSeCfl0wttCBfDnbo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DY3tqqEDlvIOuvMP0mypzFlYOi03eQE/MBKUcuAEp+x7JH6QqLoiiVuL4U8KXQzsW
	 Ocz0Po2WpGHUE2eFmlrFFd1XgAeimIFW+U+FZ3+Tb1vElEN8Ca0UDRxvKLslCNW/Me
	 PjfFaLsDB5xCqfa0ryU1J1awAGFnyGKcQ7McX8rc8y//kr38bEa9BVK4wZxdaIQ6o5
	 ZtAj4RfZJmuB2yPy2fq5USproRjTZXkAC0Z6x6qIz5dcxjFF4BCRBFoyrCDHCg8KtH
	 ezUmJ9xo5CwMCJlT2joQRhhEb2y6lBoE9VZuYYgdotJSph5GYViL0+Liqc+exHLaC2
	 qLGbV5VDJ1bWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F485C54BB0;
	Mon, 20 May 2024 20:30:29 +0000 (UTC)
Subject: Re: [GIT PULL] isofs, udf, quota, ext2, reiserfs changes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240520113428.ckwzn5kh75mmjxo3@quack3>
References: <20240520113428.ckwzn5kh75mmjxo3@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240520113428.ckwzn5kh75mmjxo3@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.10-rc1
X-PR-Tracked-Commit-Id: 1dd719a959794467c2a75b3813df86cc6f55f5e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb6b206216f599cd5d4362394c6704a36e14f1ff
Message-Id: <171623702938.8142.7359181192821173528.pr-tracker-bot@kernel.org>
Date: Mon, 20 May 2024 20:30:29 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 13:34:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb6b206216f599cd5d4362394c6704a36e14f1ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

