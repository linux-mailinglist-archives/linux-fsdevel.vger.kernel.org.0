Return-Path: <linux-fsdevel+bounces-63407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96916BB832C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83CF04EF501
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01B3283CB5;
	Fri,  3 Oct 2025 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/g1rOix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3427F16C
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527079; cv=none; b=e2bxlA83LvRv8AG1ncv9lRW3dwEE8F1er6GybhwINltf0o7Os+wSYnbqWtaNRP+eHBpgDepyV6tqGlkvd9Rb34fRQiqAwGukF0rGi8z6aLyLyXBi29oJSmku7J83ZJYOjF8GqoT45596K2UW0ky+qlEiEUFCFV+rb9vLSvfucR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527079; c=relaxed/simple;
	bh=k1ouQbeU/IEmp2Yd+CUF5+MeNrj37BHZKtit9rpWWXo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gPGfpE6qijtWJpuKVlyoAl11qW6l+Ijhgcn2IW7sf/9bprU5isi5z9j03J/mtpTR6fJBvXVWpRZo2viy68wruqnrdkA7AaAn7XB1dFAwhnLU/nh3KpYs7Mrtr9JVm0SCVqOBTVp2ZtqanYfmitOWHScKiyf6GO/A8FoZew9fbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/g1rOix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BC4C4CEFA;
	Fri,  3 Oct 2025 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527078;
	bh=k1ouQbeU/IEmp2Yd+CUF5+MeNrj37BHZKtit9rpWWXo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Z/g1rOixzNyax2+BBMTjbcEJk2zMadg8MQWlzsshW6LloM480Vezh3+OBaySUcs+R
	 E1lEnEhaanJUgJw9fBndN6YhezyJSe5XNS7nG/1fsK4sR2aCcz/Mt3WQXkLJrLpEqL
	 rlEbZyythfhChdbubtavGooieMZwdH3IkCmWRw+IO/w/9v++ErAUy45YORCuMVMgNf
	 aFZneX5okyuB4LC2UCQ72AQthcDzt3BjUCDeBR9OfJ2cgEAA9gE+PmEiwa7HfrHC7x
	 4hN2Ot+/gYtoAkHTZcq9tv/BEge/UhqupR/PbXnMBYnZI+YQHRdPC+zAQ12LFS0zs1
	 vfg07+v3hX4ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D1739D0C1A;
	Fri,  3 Oct 2025 21:31:11 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify changes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <j4byvkodakr7bqngrlz4tqvjxe4vzudrzjckqrheivtrd6tmqd@pale3juics2x>
References: <j4byvkodakr7bqngrlz4tqvjxe4vzudrzjckqrheivtrd6tmqd@pale3juics2x>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <j4byvkodakr7bqngrlz4tqvjxe4vzudrzjckqrheivtrd6tmqd@pale3juics2x>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.18-rc1
X-PR-Tracked-Commit-Id: b8cf8fda522d5a37f8948ad8a19a1113cc38710f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67f5f11cdf5081af9b592d8ab24d054a0d681b2f
Message-Id: <175952707021.82231.17416426136540201824.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:31:10 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 13:24:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67f5f11cdf5081af9b592d8ab24d054a0d681b2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

