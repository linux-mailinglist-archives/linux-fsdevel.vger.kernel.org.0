Return-Path: <linux-fsdevel+bounces-44917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47FA6E50E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3343AF07C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED351F8697;
	Mon, 24 Mar 2025 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSps9Cso"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91B1F867F;
	Mon, 24 Mar 2025 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850047; cv=none; b=ETni1BS3wuYiC7PhEVLbY250wPsRFECJT1sh5Ht5lNh+/Nz2oz4tLUVjtVzECC6DqrT/gsbI96odpOp2xm7Wtr+vxKmK7dCGCfYDPAb/IA2BcTISXy7jbFHgKBWaNMdwtKe5Gf5gkyXEveWfP+B0nrp7LuuhpU7AOPr2CY7pT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850047; c=relaxed/simple;
	bh=v+1y+9lxZmvCcfEoMdBxNV73d4H4NNgvcIQhKpUs3eg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VKNUP7hJxNp2wAgkqcDd3evVkZr+swLBscod/WARiSVjX1rEC24HFx721nD03k6+E9+tf2i0+/WKvJYoh6UB5dQIJfbWAneBOTJXoS0DyEC9nZeMV19gPHfbpBq/AqsNWTbYiJDT8q70KyyG70WybfYWn4oNhImH76Vm0LkXkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSps9Cso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF63C4CEDD;
	Mon, 24 Mar 2025 21:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850047;
	bh=v+1y+9lxZmvCcfEoMdBxNV73d4H4NNgvcIQhKpUs3eg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hSps9CsoV07PM5n/vmw7J1VNKv4KVZ/0qpPFGyS9ZdiaeJnugNQxvRB3iKBlh+tT2
	 tq4fIKPo8DilOAFdfZao79clI9DWHwyh0+KyzRoF4PPpNV8CwGsFXePQXA+EuI6blw
	 IvT8NdVtI9IXVjdxfQmhR1iEqQHINuzDCftu29Bs0v7NnmegbwFgcvppTOtLQQbAU+
	 6XkTOeAw6sf4qx1LqKYPF67ZmlIQUBmA195izF8zenAqggK/JvHzceHVcQKrx/rCEU
	 gbdAA9aaRXMxXbmqO0A/DLAKyjDnt3FNLULAtKPqwLMPeZUQsjws3QT1/wyHDd1odJ
	 yixQ9tjeAJFTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF6D5380664D;
	Mon, 24 Mar 2025 21:01:24 +0000 (UTC)
Subject: Re: [GIT PULL] vfs orangefs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-orangefs-b012666207bd@brauner>
References: <20250322-vfs-orangefs-b012666207bd@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-orangefs-b012666207bd@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.orangefs
X-PR-Tracked-Commit-Id: 215434739c3b719882f0912a58d8d7294fd7ff71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d41066dd76eb86f7fab45cf19d0a04e97e5c339f
Message-Id: <174285008351.4171303.3004583269210780278.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:23 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:17:23 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.orangefs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d41066dd76eb86f7fab45cf19d0a04e97e5c339f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

