Return-Path: <linux-fsdevel+bounces-56215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4BB144EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDDF3B0045
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A2228981B;
	Mon, 28 Jul 2025 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtuaYSMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A82459FB;
	Mon, 28 Jul 2025 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746053; cv=none; b=QUUcZ/SPxhbQ7q9tnS905xPAdSSal5AFViyNrMcJdxC1+QzDyIZtJxcxFG2U/SjWirbFTECLUaaxIQaf8Zkm8hHC642nuO2nXxsi8VvgoQFfuw38pOw36exjvYpkwxS8jdw7+n7+9XpAp3rE7p/VvzWKo9YybXCi6oerW9e29ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746053; c=relaxed/simple;
	bh=7EtMfIonVA4ygPkf9GP/w+5SgZerqqzYw8v/JFBzi1I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=vEk4D66+Y+v39WEhe9xvLoRFtBfT8PWUZJu0iQ/fSo0AhRxQfOQ8Yc6R7qtpDDnefhhPwuWbg8P89gxk0BA7rlUEp6aUhAvahZtRhJx5OVbs88btlw73/dyVTGSMLg0QG+rRhqJfRDrB5rFDJj/QsMyuOI6Zyby//lFyrSt6GmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtuaYSMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62DFC4CEF6;
	Mon, 28 Jul 2025 23:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746052;
	bh=7EtMfIonVA4ygPkf9GP/w+5SgZerqqzYw8v/JFBzi1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CtuaYSMNpWTbaLbscHo1PvgLMA5GRivxrEGSDhueeoS8CdoQev7dyJWcMz02Q7CQW
	 +M9L4FxE8vEkTQ2gZw8GKbCQrS8HOtPy7Z199jUZEo45XVBzjT4A/5bT10wlIJl1eB
	 zE2PccAEbEEIzHAY99wOxx0zeiWWfy6up4BlnrNitXh88X/Wz6cUZbF9bh4lt6kccR
	 RsocoYv0j15up3PmSIS6XIki6/U715s6k5bwSfvO1fD8OFOKfug/9al3gEd/Nwda62
	 4jArpQ1TtGAKjSy6lirDk/Ooi2Jz41HY+UAkRhgsHUdZ/mxINz1mR9NVIwamhSk8Nr
	 A/YLjyqj8i/Aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 998AA383BF60;
	Mon, 28 Jul 2025 23:41:10 +0000 (UTC)
Subject: Re: [git pull][6.17] vfs.git 7/9: ceph d_name fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250726080805.GF1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV> <20250726080805.GF1456602@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250726080805.GF1456602@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ceph-d_name-fixes
X-PR-Tracked-Commit-Id: 0d2da2561bdeb459b6c540c2417a15c1f8732e6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 815d3c16280ce289c558255acc4296b36383d1a4
Message-Id: <175374606955.885311.4809090447449390422.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:09 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, ceph-devel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 09:08:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ceph-d_name-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/815d3c16280ce289c558255acc4296b36383d1a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

