Return-Path: <linux-fsdevel+bounces-9203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C1183ECE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 12:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989CFB22C2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8797D200D4;
	Sat, 27 Jan 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8Wss0m3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E3945A;
	Sat, 27 Jan 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706354736; cv=none; b=bpFN3mQV62opa+eOeO/M2KmG6ZbvO4abfEBQN6NSW3RFUXhzzSJ2CohU8UcuTgPkyHIeWfMHMbAmYFeU3aIM7OcSyuvRuxiNkN3j14yxswTW3uoR9X0JnjWO7DS7tMpJOFuaWG9yuQq7sGkS9BnCQcp5QKZ8KgrbnspzbfMEpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706354736; c=relaxed/simple;
	bh=lAIfxFhMZFCIt1yI8I3udsvsY5cvr81yAp3bNPPzT6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RLlBtnd5UXXw6ucmcRxC1VHbFw0IKA5qQBd6sPyiqEOuqRYe+NnivX0TpjaTUpyNU0PJN53Q4iytIHyJGfSXYHcXmppzAALcIfZH1/obsprBmV0Jt/eBv7xbib6ZVxBz8R9BjtwxBtl99OnQXbU+n2fVSXaojcQExeTV6qfB9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8Wss0m3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A901CC433F1;
	Sat, 27 Jan 2024 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706354735;
	bh=lAIfxFhMZFCIt1yI8I3udsvsY5cvr81yAp3bNPPzT6U=;
	h=From:To:Cc:Subject:Date:From;
	b=t8Wss0m31siF7mm091aNs942o9SNF0+Br7XdP++89yKNC/LUEf9TTKaOXGH1sjXIc
	 u8hmdl6T8Z3XAYylLBqWxwjybbPtqmIUsXTORhIh/RojeW+7GuKCr8ancg5eNqc9Vg
	 ySzMobYvpnK5HVb1BvtttECj+kchAyvIJjsqZJSLsg69RGU5/9a9c6Qh+HpJF+8SNJ
	 rOAKBNnemUsQGQwzsglUyqKPC6n4Ju6e8hMgxoojxf1Y8UGx+ZqR1xpWmoje3qJ8/u
	 7ez+HN8D9w9wEAB1pilP1VCeSId5tVirKWjoxrc7gfI0KAXWR3h7uyGk3SFBouLejH
	 KT8eVv6uMxa3w==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.8
Date: Sat, 27 Jan 2024 16:52:58 +0530
Message-ID: <87sf2j2f2t.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch with changes for xfs for 6.8-rc2. The changes are
limited to just one bug fix.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-fixes-1

for you to fetch changes up to d8d222e09dab84a17bb65dda4b94d01c565f5327:

  xfs: read only mounts with fsopen mount API are busted (2024-01-22 11:33:57 +0530)

----------------------------------------------------------------
Bug fixes for 6.8-rc2:

 * Fix read only mounts when using fsopen mount API

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Dave Chinner (1):
      xfs: read only mounts with fsopen mount API are busted

 fs/xfs/xfs_super.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

