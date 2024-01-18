Return-Path: <linux-fsdevel+bounces-8231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A9E83129C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 07:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE741C22187
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 06:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483A8F74;
	Thu, 18 Jan 2024 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvvVjzaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3C8F40;
	Thu, 18 Jan 2024 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558136; cv=none; b=sjP2ubGsdqOJPT3vUD7aZuzhVo/BNgLZf8iUDLf+EcnsiM4vMjH39vDkL3EvRvIjEHXo7JpyjVcVRmMmzuwDsqAecW9nfZt3Rp/zy9VDubw1GP6exI02Xij9d2xtScTGkqonyQmUaUbWnQ7x76/RuShyrk5T6FzanTYyomwFJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558136; c=relaxed/simple;
	bh=W3aog60rKa8IPc/l5TIJr+0GDigsZfySAphHqcpDA8k=;
	h=Received:DKIM-Signature:User-agent:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type; b=hCllR2NPJsnMTYoVg1OXWyQtOkbc7RedRTTAnmm6GG2JVmDtppZvGk5ixFc/TpLfzZLdUTDx8ToijkPQTJNWW4BZ7/lCbZ2f1rS0yDYSbKPEAQCNlM6CuISp5XsxXERsOPhz6UQyle7DsaMQ9LwPwGKHBRlOw/cuugH6JfClxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvvVjzaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10815C433F1;
	Thu, 18 Jan 2024 06:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558135;
	bh=W3aog60rKa8IPc/l5TIJr+0GDigsZfySAphHqcpDA8k=;
	h=From:To:Cc:Subject:Date:From;
	b=VvvVjzazijSIH5WRxQh3kE3phya7uVhAhc+gcOYZyUYJOsOlCcJ2/aaE6neN5BBtn
	 P2D6zNOdHmorgS/l34HpZYLy87gFOrWqMsuwEkroVir3whc66wlMJr+3bsaY2CwWKY
	 z4S3xqIzuHJrjA3NoVp93X5EiLDklqUiY5O0aRyAao/3f3mnHXv8AL5wErjApULiGI
	 Pba3F4y3j4tPxVZLHDi0khgd9VbDURMe4NnD9fR0E53Y+d5CuCCXeiMNgu/HYONOro
	 kFUQXSZiWBVkT5nPbdEt/cSv5WKu7p/hpJsAlS6VZn7NRUFxbqs0d3fpI/nROk3tHD
	 oD9uYpYe8H5EQ==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org, djwong@kernel.org, hch@lst.de,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] xfs: More code changes for 6.8
Date: Thu, 18 Jan 2024 11:31:40 +0530
Message-ID: <87zfx3i363.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch containing a bug fix for xfs for 6.8-rc1.

The following changes since commit bcdfae6ee520b665385020fa3e47633a8af84f12:

  xfs: use the op name in trace_xlog_intent_recovery_failed (2023-12-29 13:37:05 +0530)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.8-merge-4

for you to fetch changes up to d61b40bf15ce453f3aa71f6b423938e239e7f8f8:

  xfs: fix backwards logic in xfs_bmap_alloc_account (2024-01-11 10:34:01 +0530)

----------------------------------------------------------------
Bug fixes for 6.8:

** Bug fixes
   1. Fix per-inode space accounting bug.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: fix backwards logic in xfs_bmap_alloc_account

 fs/xfs/libxfs/xfs_bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

