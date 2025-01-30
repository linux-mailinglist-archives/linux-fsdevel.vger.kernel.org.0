Return-Path: <linux-fsdevel+bounces-40418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCC8A23352
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF2C7A2ED2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12B1F03F7;
	Thu, 30 Jan 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDJoU5q3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FA81ACA;
	Thu, 30 Jan 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259148; cv=none; b=XooO/f3h7O78xO4ntDocOBGs3eaGOZXaHtPS3m1GNAsYKKYQj11NfTQZE0vc4/RI74t5YiiZxUQQIGjnmDds/AX/8MoNDpm1lczJawaRi60PiUb94Zii3U1GmX7XbWSq7GnIca/Zniz82Fmwtdapv0fheCd1LOjAnFjR60SXFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259148; c=relaxed/simple;
	bh=AtFBlw57FiyoZuCXXhIoipMt5i1Qp4/EPk8oHH4MFyI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PfAcZRi0f3SXpGBpQuoLK3wge0/v4ABlK1J95WdRUUKoes8vvpiguNzhYyMKgPoAV7trmrU2KCJTQgUknAE1CEOjdOfqbKB2Ry0tqssbho6aAUySYuh0sq7o+JqrDXOW9HybMOfeYOXkDypr1gxuDi1EXcC7LE4lWprzx058+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDJoU5q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BA1C4CEE0;
	Thu, 30 Jan 2025 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738259148;
	bh=AtFBlw57FiyoZuCXXhIoipMt5i1Qp4/EPk8oHH4MFyI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kDJoU5q3XGVbWaz5gDojTIJ/4qHcCIuL2rposdC0fTHnO0a0Abxx+qk6/WrliYF5a
	 1TGCjurYX9W0pEQirvJgHgjfyPYE8GGzq2axAIKQNR6e5oVWI4tZCQBGehe3mJKxtP
	 VzgSgex1gkTqZeDheBzw8G6D2JDuBqZQY9PwFGZ8S/4FIqr1SsAyRvW57kZyZneLHY
	 X1glRG+uERE943ZARAMKkHceceM4qeGODaqN5kh3jk38/4Z7ZPCsqU5TuklriECP3t
	 mez4bQXlMRQXNJKXUVWawrSbZB1IdhTbKhFgWEWwlZXn+XU1LwiDE4UlQSLHeWsAev
	 Z3YBpLmb6twZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71303380AA66;
	Thu, 30 Jan 2025 17:46:15 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <uez7twvxdrdam2uoatpvtaeph2vkfru57r5oh33j2zjov2vqwq@2gtoztjt2p3d>
References: <uez7twvxdrdam2uoatpvtaeph2vkfru57r5oh33j2zjov2vqwq@2gtoztjt2p3d>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <uez7twvxdrdam2uoatpvtaeph2vkfru57r5oh33j2zjov2vqwq@2gtoztjt2p3d>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-01-29
X-PR-Tracked-Commit-Id: 5d9ccda9ba7e80893cd67905882315a4a7ab6ec1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8080ff5ac656b9ca6c282e4044be19d2b8a837df
Message-Id: <173825917414.1032810.5988836974219854304.pr-tracker-bot@kernel.org>
Date: Thu, 30 Jan 2025 17:46:14 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 29 Jan 2025 15:17:38 -0500:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-01-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8080ff5ac656b9ca6c282e4044be19d2b8a837df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

