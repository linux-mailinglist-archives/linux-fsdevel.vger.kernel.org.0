Return-Path: <linux-fsdevel+bounces-25934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A8D951FE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD681F221D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296651B8EAA;
	Wed, 14 Aug 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvZheXxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852781B86E7;
	Wed, 14 Aug 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652833; cv=none; b=ObB2Qy1uNK3Uh5QhFCJrv/bWS5Np0U0qfZ230FdTgIkPllGAGxQIQBeJ5UaDcodZ1pMPUiogPqMJ42KeLaQ4Ewhu/jGk1qz+0NiZNGthDhvt9ne3IjLhsmtZJWDWX2C33cGLaoc0oabLcIPFuuTLp+XsNRSKf2P7MTIqmSCOS/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652833; c=relaxed/simple;
	bh=ll/brjl6RwxBRUS7b5aUiBHUxsvXok6TITbXL7iYzpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ibPdqqsQODFuiZyWHGR8+FvyPM6yIRzTvlpsI5+XXTqez2XJ8+26yV/OQz8o0adbXkTB3FgVjppyHDvwcJTZH5K79ypa3YhZojmz02suHRnF3hbosNUCOJRRuvmFQag7tlG/irGZ/kyfYH8awoqQGCyvhsc8eljRXxpukXsCCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvZheXxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B186C116B1;
	Wed, 14 Aug 2024 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723652833;
	bh=ll/brjl6RwxBRUS7b5aUiBHUxsvXok6TITbXL7iYzpA=;
	h=From:To:Cc:Subject:Date:From;
	b=HvZheXxXhlzckBHBCBuqON+6ofWYKCdU9PSctEq8Gh3JHzXGI25nAFRUDLgh74Ah0
	 MkNo5SKPBp9pnUmiqJtzhHQel8rUwFIQShN4W81rPGXe0XWQF27wPKQV/YqtbGkmtV
	 MnFQBXx6cF3MIIN2NEgpxHs/j37ecJXMt9TVohubZhYCdYO3xYDoYvZ6QG18CKA071
	 BTaeu9s397T3jqR5F74pH3jYoU1/+JWdtpdAIWqbFcTiv2Cb1Q/4zkZATYNGnQ5zC8
	 PpxDTmZfITcnYxTgrkWz+ZucrjQgf8Ei+zmEf4I415BK5tg1LMpfuzLbDxwCflQ+Dl
	 ZGmbXDYikRLJQ==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 4813305c621d
Date: Wed, 14 Aug 2024 21:56:11 +0530
Message-ID: <871q2rqdcy.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi folks,

The for-next branch of the xfs-linux repository at:

	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

4813305c621d xfs: fix handling of RCU freed inodes from other AGs in xrep_iunlink_mark_incore

5 new commits:

Christoph Hellwig (2):
      [681a1601ec07] xfs: fix handling of RCU freed inodes from other AGs in xfs_icwalk_ag
      [4813305c621d] xfs: fix handling of RCU freed inodes from other AGs in xrep_iunlink_mark_incore

Darrick J. Wong (3):
      [73c34b0b85d4] xfs: attr forks require attr, not attr2
      [04d6dbb55301] xfs: revert AIL TASK_KILLABLE threshold
      [8d16762047c6] xfs: conditionally allow FS_XFLAG_REALTIME changes if S_DAX is set

Code Diffstat:

 fs/xfs/scrub/agheader_repair.c | 28 +++++++---------------------
 fs/xfs/scrub/bmap.c            |  8 +++++++-
 fs/xfs/xfs_icache.c            | 11 +++++++----
 fs/xfs/xfs_ioctl.c             | 11 +++++++++++
 fs/xfs/xfs_trans_ail.c         |  7 ++++++-
 5 files changed, 38 insertions(+), 27 deletions(-)

