Return-Path: <linux-fsdevel+bounces-63055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB2BAA798
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6515A1924016
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF292EA47C;
	Mon, 29 Sep 2025 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBehqTIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F572D63E8;
	Mon, 29 Sep 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174287; cv=none; b=YpRDzvzSh6oYGjrOhbFDQ45W7S8Dq2AE5RuAQsrs6eODXiEJqbgiTPgN3EAjlrhpp1QgB4Nor4jqHC35pe9cPy0Bq6EikmT+OPM1jEMhLvYhjeX35fwWMA8GAFIfl/237Bb7n2Xwcb1TKJA2sUnO6CThiRZ4ddfB1DJSuYlW8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174287; c=relaxed/simple;
	bh=RVtk7cvsOuyPxhoaOLZd/zh1KRH9OM2rvVOekIpf4oU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KCw82Z85M89nfT6MQzfx+L8aHQL8zQ0yMOIHknKfx3vz4zFztfHt/jSObg2bIRYDA5NvRGKaEiHpQRfdPNk4XWywO1jV96i8fediH+i1Chwj7o9PKhE671HhicgcBNFHvFAMIJDGRPhIfDI88BsgjdLY8ngUGlN1VKSNNDanoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBehqTIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60432C4CEF4;
	Mon, 29 Sep 2025 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174287;
	bh=RVtk7cvsOuyPxhoaOLZd/zh1KRH9OM2rvVOekIpf4oU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eBehqTIVqqCjrFgQtjNeA7JWL/Zf/lrxxtvyEhkAwwhH2VYxVyrDfh08tV1o+lRnO
	 Mq8voMhnwQdIu3qsfekMzC3YsXHDTyU3j0sJ2GOvGHcQ1Pke3cfeMWgstsQG53Dyb+
	 6e6ID4tID8UuAORzN/UviSZg6ub97VJ82b17mtg0I2/Vkeur/dZqNIETNTkhPIQp6M
	 WP4qQ5aHemWspIDbsXRXiJhQkdOYzz9qM0UkPdL6z/V0Fzukkf746pUvpO41rFtzoA
	 SI6o5qGL5IC6tsQE7/+OytPv4c3ktWsCnJhnOVGeCU8eGohmxzlV4KdDm8RFWLrPyE
	 +Gi2cTsNEz9og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5B39D0C1A;
	Mon, 29 Sep 2025 19:31:22 +0000 (UTC)
Subject: Re: [GIT PULL 10/12 for v6.18] namespaces
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-namespaces-aaa270353fd5@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-namespaces-aaa270353fd5@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-namespaces-aaa270353fd5@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespace-6.18-rc1
X-PR-Tracked-Commit-Id: 6e65f4e8fc5b02f7a60ebb5b1b83772df0b86663
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18b19abc3709b109676ffd1f48dcd332c2e477d4
Message-Id: <175917428079.1690083.17195121480242240696.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:20 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:19:04 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespace-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18b19abc3709b109676ffd1f48dcd332c2e477d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

