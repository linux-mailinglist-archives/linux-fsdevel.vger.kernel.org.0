Return-Path: <linux-fsdevel+bounces-29444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D7979C5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 10:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D89B2844BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 08:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17E1487F6;
	Mon, 16 Sep 2024 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp+dsXY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E961442F2;
	Mon, 16 Sep 2024 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473572; cv=none; b=uyAr1m6z4fm4xWDMWhP7DgXfclD7H0Yc9Ay2IvzrPlIv7YBLNEFp4Ja1cfm5JQ60muwn9K4geiSY6wWoHublnUpLUNhJ3duDDwsBvll6Vb5FIGiyd77OE2iTmaR5M13j+tZwinMwL5zIS2I0SEs65ptUvf3Q8qURLZEkdtpZ7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473572; c=relaxed/simple;
	bh=Kai7yGzRk1kalKFjbleOTr3nacGI277pRpqJPjQW0Zw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RFE75ccHwSBk8W1K33rajrNERS1PsOk/Y/VvcdwdzkcjF/Xr3mEUVdGu8R0eIvY+hJov+cFCDKdjHpSIouIblgs0Z2D/+vvqrhZ8jvnMSX4V8fcqWmGQX8/GPwJaoZn+pB42c8zomXp5XXM+bN4uUa87elkq4W/K3ecRpVClz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp+dsXY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A345FC4CECE;
	Mon, 16 Sep 2024 07:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726473571;
	bh=Kai7yGzRk1kalKFjbleOTr3nacGI277pRpqJPjQW0Zw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zp+dsXY7iLW7q9yEUtCy9ZB9KBdDt3CQh5/GXH5gZBxzk/Zd18DtPWVTaUNIH5j5z
	 9cTIr3cR+43PkPycQVKk2ze0mVIqdbIfaqAO+C7sCfjJOMPkox9RG5JCQcS5KUcbVd
	 P/s4AaSj+yGqTrZacKqPBhueF1dToJ9VX6/ZCogzgIBoOs5ldOV0OAXhmkdFlxwTlZ
	 kam2fyKL7/DlX0LRv+fHEG/n6jjpO/UZv95vh6BSIFAjW/13F73d1ZZnGqg6nRRZYI
	 4zYP32nNUO74DVDmfZkK+kDIpwOXQn2Ress1OZb0BikcfeebY6DcuP27pUJwjDLJa8
	 k7t2Mkptu577w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B6D3809A80;
	Mon, 16 Sep 2024 07:59:34 +0000 (UTC)
Subject: Re: [GIT PULL] vfs procfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240913-vfs-procfs-f4fc141daed2@brauner>
References: <20240913-vfs-procfs-f4fc141daed2@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240913-vfs-procfs-f4fc141daed2@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.procfs
X-PR-Tracked-Commit-Id: 4ad5f9a021bd7e3a48a8d11c52cef36d5e05ffcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8fc317dfca9021f0ea9ed77061d8df677e47a9f
Message-Id: <172647357311.3298317.6638597681199595753.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 07:59:33 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 16:44:47 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.procfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8fc317dfca9021f0ea9ed77061d8df677e47a9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

