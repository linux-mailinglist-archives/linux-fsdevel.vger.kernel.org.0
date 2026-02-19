Return-Path: <linux-fsdevel+bounces-77671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKW2ExOplmmTiQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:09:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C6815C50A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 848AB300C269
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 06:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5518F2E6CC0;
	Thu, 19 Feb 2026 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSChKKia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9097238C16;
	Thu, 19 Feb 2026 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771481356; cv=none; b=uQTikPstcz7ZiCeP+yNBWFM0bEDoGzpqXRR4fOswUTxGEmPA7qLmHroyJFTwPlMzkn5ZC1b6ENHOc4P3RaZnMmKoVR5ak+6czY5fCRxk3WTopHx+KTtMEZX8u+4xMEiddvpf/N0gmSMN/EDjIAKcqj8UCWqkCyz+akIFQg1ql+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771481356; c=relaxed/simple;
	bh=nE5aXNzRUS3BruGnYSE/bvVT1StFUOHL+l6VB/rRyBo=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=sM+qAp278sla81s9dO9WbRweXpPQFMDV2c/Gw1iXK3AgBfkDbFYtQxmPxXnM7qaSA3gpYJYcaRDw5QNNcrXXG70/W6MEsGaWblWfBsTv529wcdzG+GiFI6oF1Lcr6pD9XxmIvnesRuATDr5L4K7vKwe4qgC/0B3rq0vfR1bq/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSChKKia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D33C4CEF7;
	Thu, 19 Feb 2026 06:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771481356;
	bh=nE5aXNzRUS3BruGnYSE/bvVT1StFUOHL+l6VB/rRyBo=;
	h=Date:Subject:From:To:Cc:From;
	b=RSChKKiaUMn6QFDLSd+/mN1XDPsDae4mgeAGK1VaVCAD1zuZ5qn1Zf6Xd8bqcAntD
	 HArW3R5shG6/ybJMpLE1qz5NPi73CMbBx/9gu9z3BNnNmem+iiueObw4V/5ZkJ3FVB
	 fsGu85eXpBLu9VIbxKC6UnPtELXMc7mVRb8vo6U75yDE41QiipLIVBl7TMmGCtrm9e
	 RuLjFPM2Fz3VV4Seh0QlzzQ+QkBaJSbriIBBh4BGfj+FtVfdJwtSA+NVoPIro9Wq8g
	 ZUFi0O1I0MMw7RLUONmzB661/ULiwE/hsKxo2Eh7ILBRHczNuQ9WLo2dEfXPzga50i
	 Lr1jsQoYrRASQ==
Date: Wed, 18 Feb 2026 22:09:15 -0800
Subject: [PATCHSET] fs: bug fixes for 7.0
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: hch@infradead.org, amir73il@gmail.com, jack@suse.cz, brauner@kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <177148129514.716249.10889194125495783768.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,suse.cz,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77671-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1C6815C50A
X-Rspamd-Action: no action

Hi all,

Bug fixes for 7.0.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=vfs-fixes-7.0
---
Commits in this patchset:
 * fsnotify: drop unused helper
 * fserror: fix lockdep complaint when igrabbing inode
---
 include/linux/fsnotify.h |   13 -------------
 fs/iomap/ioend.c         |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 13 deletions(-)


