Return-Path: <linux-fsdevel+bounces-48796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C57AB4A2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 05:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9721714F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 03:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15941E00B4;
	Tue, 13 May 2025 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h15KSTTa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DC1DF982
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747107164; cv=none; b=j2CPem+EUrNBn12iAN4i6MHoG/hREgfoRilt92/3dcShw4sMWOkctosEQ50Zi36oJDwEsznDAzsTWKMeh8tO9N3dK+cJa3iRHHbhDb5Z3oTWrYvLhZlwfb9VBBTkTprPi9xg7L0d6D/Uaa4LvDrhACCmmAgf4o0qnNiTzWMeYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747107164; c=relaxed/simple;
	bh=R6nwcexzXLeQx6ucm7zEU1VMX6WScaGgBL/FzGoZzs8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sUo96ZcaGbA2sRZrXB31MPjzmNq8sLObHcuecQ7XqgcVa9Opa3qihblf4UwI+yOnaNf/FcWyHxXDdSlG4eY48XGg+v8MWK5Aov8XCirWMUYglbPbUQ3h0zgTQuppQJlxizW865kMDB/Su26Rkn1xpOfa22HYHb9AkBC2GKy4arI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h15KSTTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF37AC4CEEE;
	Tue, 13 May 2025 03:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747107163;
	bh=R6nwcexzXLeQx6ucm7zEU1VMX6WScaGgBL/FzGoZzs8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h15KSTTaolXylRtDsc6A6cnpsYox1QKuqokE9Df+vjxRc0Io2I+DVgiGxpAx97MbU
	 ffuAhMPk/gIWKmS4kDZ7KiHCfTNPmNhnkpYlpuEJLEk+jF2Kx1NbXwVLQ0X2sHkn1F
	 /AUO2jwn07TO/hc33HwhNPNZV4YDIEaD+n9PvaPvVYYzE61/MF1RX64ra8jHyzUZj8
	 2RlYl+5uyGe588baMnldruNbwz8EFH1fJ9+TGwBRQs5Yz9Yql863TdzZZnLvv9Xeit
	 UHaHJ5qfh0H7jJ7uYsx8BM0rzLQwiHQ1DC4P4IbOzvhqzmNSNoKUi8oS7CqaLFJGrb
	 DItilCl9hgbGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8A39D6541;
	Tue, 13 May 2025 03:33:22 +0000 (UTC)
Subject: Re: [GIT PULL] UDF fix for 6.15-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <6jk27t5taxgcylrgmh7hx646ztw47jc4ctwteiqh7xqmgj3dbj@hxeksvncb2mr>
References: <6jk27t5taxgcylrgmh7hx646ztw47jc4ctwteiqh7xqmgj3dbj@hxeksvncb2mr>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6jk27t5taxgcylrgmh7hx646ztw47jc4ctwteiqh7xqmgj3dbj@hxeksvncb2mr>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git udf_for_v6.15-rc7
X-PR-Tracked-Commit-Id: 55dd5b4db3bf04cf077a8d1712f6295d4517c337
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b64199a7f4fc71d2b8d9fccaab32303a7b6d753
Message-Id: <174710720130.1163096.1875929523321621964.pr-tracker-bot@kernel.org>
Date: Tue, 13 May 2025 03:33:21 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 May 2025 18:32:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git udf_for_v6.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b64199a7f4fc71d2b8d9fccaab32303a7b6d753

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

