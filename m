Return-Path: <linux-fsdevel+bounces-78396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN18ErdEn2m5ZgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 19:51:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FC019C719
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 19:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 212C93069DF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 18:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE323EDAC8;
	Wed, 25 Feb 2026 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VckMRYY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ECD3ECBFC;
	Wed, 25 Feb 2026 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045486; cv=none; b=cHUcorSUGAD06t2kBriuL1D4b/OlSU+UVeAY3LorVs6+zs8WyVyf+tOCpirJx0rWGLSd6Els9MiOOLqxq13OqPHwBwQzpUnzjABMBQ81MykvCfTGHU+ro4xThItLJxWwHobS15lJszlVOGsqxNNDJxwnkM1gm6oI/buS3nv1eo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045486; c=relaxed/simple;
	bh=j8pvWYf8xL8apY8KT0JmruCJOJupu5DocL+OByziIQM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lHDiEGsih66c9C3++OiQEmTMZ9W+qsu51TfFt5gWBvL/ftM6QfgrSgyy8ydqqIsR4i6PGCAjSEDe9yjht1/z55w2EwSyP/IGvVj5R/VA8BLjTlnyby2v/i9wuktOIwfDEbNd9ep9pbAoAU5BkF8oXaU4kHPO3x/y5Ng6Evdumh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VckMRYY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F13C19421;
	Wed, 25 Feb 2026 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772045485;
	bh=j8pvWYf8xL8apY8KT0JmruCJOJupu5DocL+OByziIQM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VckMRYY7jvRU04ojnP6TZeP4SPD7EHCfu6COZOPdjoSZbxvf/di425E00iiSLise6
	 ZXChxjspmY6OEwVBo7NRChgfCEOPjWqAN/Ot3BwCd19m2E0NxMrzlxPHj19E2nZ72a
	 2VF1JcAdAyizg8I3yuz0uoJoFruQXanHrP/6E5nHE4+z0GuL6I7vNrYjc/cu3Z+YF2
	 yCGV114Ew0dzt7xw6Uuj5r1VmSbR67//vLuFR2yXhktamF/JzFTUQTy3ZsNNjynk7S
	 +SJShWttCA1IQKuovwJ9FIK330T0FdKQOtyaiM59IX1wNSIo9jTrzGPoluo4BO3Ypo
	 e5lM2J19sbKjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2713809A90;
	Wed, 25 Feb 2026 18:51:31 +0000 (UTC)
Subject: Re: [GIT PULL for v7.0] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260225-vfs-fixes-5b96f026f275@brauner>
References: <20260225-vfs-fixes-5b96f026f275@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260225-vfs-fixes-5b96f026f275@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc2.fixes
X-PR-Tracked-Commit-Id: 4a1ddb0f1c48c2b56f21d8b5200e2e29adf4c1df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e335a7745b0a3e0421d6b4fff718c0deeb130ee
Message-Id: <177204549019.869939.13125619992848926825.pr-tracker-bot@kernel.org>
Date: Wed, 25 Feb 2026 18:51:30 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78396-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2FC019C719
X-Rspamd-Action: no action

The pull request you sent on Wed, 25 Feb 2026 15:16:23 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc2.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e335a7745b0a3e0421d6b4fff718c0deeb130ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

