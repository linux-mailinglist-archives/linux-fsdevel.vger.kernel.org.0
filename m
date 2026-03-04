Return-Path: <linux-fsdevel+bounces-79448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKdBK+HCqGkIxAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 00:40:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B22BC209016
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 00:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C201303CD9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 23:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F837F015;
	Wed,  4 Mar 2026 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpCRteLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805D52765FF;
	Wed,  4 Mar 2026 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667611; cv=none; b=K13r2QVIu/I69MX33jUjPH94m+M1wziAEO027JzkEYLDvfg1ut/eFb0CY9GtPmtBeoeesmGzPTqNqtcJFwe/M9tw4yQgd9Z0Nlqj/jmxftyLxlNAguxcWc1/qEsqsvKyiyoqorRhw4YsfJzNegy5T/JLt6sji8duxx8/9ijxD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667611; c=relaxed/simple;
	bh=JNC4f4gcF35gohdZc4parIrHTv0ZnIJ8RGRMLQxWDT4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u3xY3czQ6VQcRZLpoclebDBGHHev/qsaSZPEoH9idhwsDicKAYr0DxTICAXEKtOO+S6EHJu9ESSP2hbmoGc59GR5T2zRNlttlUQjLDOi4rwi6V6psh29qND9YToNYCOL6GcuI5ajf7P3ntx2EVI+xmDiZHX2b94nCgbtr8w606A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpCRteLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5296BC4CEF7;
	Wed,  4 Mar 2026 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772667611;
	bh=JNC4f4gcF35gohdZc4parIrHTv0ZnIJ8RGRMLQxWDT4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CpCRteLm5SBP2OefcpltLAwq7cTfI/JVe6nKpTCpgOYtkyOvUiYSj2HcHw3CviXVC
	 RPMZGYalcxKRNeKbpUKVMMarsZ/ki+SJignupq+LQMI0TPx86T3C/Mn/A4d+DkdRih
	 mIoJYr+0dlQZApY+QS5Mzyeh6E2F98ihoPOdURBa+mrdlloBlOcr59wfUDkOIpo505
	 dfw3dKykqpYlAKwWm1Zg3hkZTR8yPWpt9QKDHptiMj4z/7dsUswADfIsFmFmN61JuQ
	 QbqeOY0rDX2bgSqlK7LREaSaeCi99bSCBivFuftxfWQRF5mXoYRAEokWTE+PFSw0Vo
	 U+e0qC0VKWh6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030A93808200;
	Wed,  4 Mar 2026 23:40:13 +0000 (UTC)
Subject: Re: [GIT PULL for v7.0] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260304-vfs-fixes-af2573b1092b@brauner>
References: <20260304-vfs-fixes-af2573b1092b@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260304-vfs-fixes-af2573b1092b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc3.fixes
X-PR-Tracked-Commit-Id: d320f160aa5ff36cdf83c645cca52b615e866e32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b3bb205808195159be633a8cefb602670e856fb
Message-Id: <177266761165.2440518.13529293691839650400.pr-tracker-bot@kernel.org>
Date: Wed, 04 Mar 2026 23:40:11 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B22BC209016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79448-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

The pull request you sent on Wed,  4 Mar 2026 23:19:50 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b3bb205808195159be633a8cefb602670e856fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

