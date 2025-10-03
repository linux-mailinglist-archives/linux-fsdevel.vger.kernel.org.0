Return-Path: <linux-fsdevel+bounces-63393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E40BB7E6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 20:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363FB19E6B1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 18:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337252DF133;
	Fri,  3 Oct 2025 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk//eNLY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A52DC761
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516917; cv=none; b=MPGJrNFHpCOmA5V4KRhSIM81yx54uO/aXg7hnDhtKWWiAGPw+D5d9NZMvxPFF+Ds9VHgxXbdJtr1x/RgQSosqLOIODffI22THFpdDsIP6UNzWwtS9PKsDUcam5OjKH9+pN+ZpQDfEQM0N8gyP7cQ6NtXJwarrxHA1kiMJoiQy4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516917; c=relaxed/simple;
	bh=2BVfuWlcXBXlEf3kTjZuz7I3b5axjiu7KuF+e41yCeQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sfyxK5wZ/rdyhkyh1rPpfgr7bw+D0v4bmaZQ4/ebIGmPiJfPn/AoeFlOwpM27wylNpnRoJMjgxY9qy8aYA1yVD6XJkmde9l0JBKs5QcErzHdMEZCYVrbXkRr9Ya9hVdlEIS+flaS3ZqtbtW/zINlil0Q5MuTgqI3R4zQ04lfAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk//eNLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693E3C4CEF5;
	Fri,  3 Oct 2025 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759516917;
	bh=2BVfuWlcXBXlEf3kTjZuz7I3b5axjiu7KuF+e41yCeQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nk//eNLYx28NQKASGdZi99y6Av+z72OoxaBSfHSG/DiAA0gs2LVD90CTyzwR92OvY
	 m6aaHa5UJ+w5N99iphfnD1Av8N4HPSVQVrBLK3xZ6a2reUDihQ9gl9/O7N52Lnip3A
	 0uY+0kc/BHMqRsb22RuC+daMLXBtW6IUDl8sOurD8IXMDs7cPKS9fXJgHhbB3EVB7U
	 BJ4UiBbTvcAaahZ5LrDDnnk3D40UhpwHhc5Dv0/SVXu8KXtzhI0PG29nwEiMZy3uhM
	 j6b2j7bw5WkOeSfTrCyZVoACV5tWD7czsFYA0ZlPnE3Zfc+ivfIO/XWC2RTJWBhx7W
	 yWZAKz+F4y1GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD5939D0C1A;
	Fri,  3 Oct 2025 18:41:49 +0000 (UTC)
Subject: Re: [git pull] pile 4: finish_no_open()
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251002060228.GJ39973@ZenIV>
References: <20251002060228.GJ39973@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251002060228.GJ39973@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-finish_no_open
X-PR-Tracked-Commit-Id: 2944ebee9a96c9d2ddb9c9cb99df6105f2de62ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 829745b75a1af25bfb0c7dc36640548c98c57169
Message-Id: <175951690851.32703.12402869736242342314.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 18:41:48 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 Oct 2025 07:02:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-finish_no_open

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/829745b75a1af25bfb0c7dc36640548c98c57169

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

