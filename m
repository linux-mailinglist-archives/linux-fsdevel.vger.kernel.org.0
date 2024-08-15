Return-Path: <linux-fsdevel+bounces-26016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA26095282E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 05:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66000286537
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 03:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265E3A268;
	Thu, 15 Aug 2024 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo93k7H2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4339FCE;
	Thu, 15 Aug 2024 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691646; cv=none; b=D2g5jYYUk3xQdoqu5ihvmA2p0LoRrvwfpzX7GTqkOLS3Q9rB/NC8zn2O5KFgOflPwkVowQj8VSitmQdYOE31qi/g2oQ+XPQR+fOom4KrKuxdrelAYFTxpnr4ApvdrLG7onzw+a1TyMmbnXS4WU8g6Ox9X5yPfC/OnBAQNU6gNaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691646; c=relaxed/simple;
	bh=thhEBcc+3s9aaOhrpQtbTz50JQitSQ9kwBCCU59JHGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQ4au/2jKkOaDVuMwNiZaeRH6valGfRvO5eRgI+wc9SVJ6uif2IjAV28Tb9Eb/sw6jN2TEzsdxK1r2EsI2kOah2VCWoe0JtOVjZPx49MQUf9zjbcEubaT2Dz6w23gh0BT+obgGkdqNgGlQZg8xs1J7SOjcN3fsaIQQ2Ud8gFHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo93k7H2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD6BC4AF0A;
	Thu, 15 Aug 2024 03:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723691645;
	bh=thhEBcc+3s9aaOhrpQtbTz50JQitSQ9kwBCCU59JHGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mo93k7H2+aCk19skjUTNXnj468E5y2LZ4iPU9qDz5E7OA7D46F/WakuedQ+zH2iWC
	 etmuoCMseoOB491BUq6QpBr/6ul+PjaGP9FlTMhidepqRWY+OeGlWZKKDIQWEjpISu
	 E+I6aFyMgnEexbpsJobO+LMSWpV8/3xGg6wBUVAURyF/BaXVTFoik+F6rbdi0gJ6YY
	 aYiIe+xxeeqev7Z8i6zUkKjvgumXfII0JfvFmRVLsMAXWUEb6ZT2VSk8X+c8cBXyQ3
	 g8SaavzqwMWv9URrbaM/NZ1fi9m31iX84UKlf1UDq2fmYQ7RwTVo11/WHCngYwCD/+
	 TEM6llSaYGBTw==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 8d16762047c6
Date: Thu, 15 Aug 2024 08:41:25 +0530
Message-ID: <875xs2scjp.fsf@debian-BULLSEYE-live-builder-AMD64>
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

8d16762047c6 xfs: conditionally allow FS_XFLAG_REALTIME changes if S_DAX is set

3 new commits:

Darrick J. Wong (3):
      [73c34b0b85d4] xfs: attr forks require attr, not attr2
      [04d6dbb55301] xfs: revert AIL TASK_KILLABLE threshold
      [8d16762047c6] xfs: conditionally allow FS_XFLAG_REALTIME changes if S_DAX is set

Please note that I have now dropped the following two commits from for-next,

xfs: fix handling of RCU freed inodes from other AGs in  xrep_iunlink_mark_incore (4813305c621d)
xfs: fix handling of RCU freed inodes from other AGs in xfs_icwalk_ag (681a1601ec07)

Code Diffstat:

 fs/xfs/scrub/bmap.c    |  8 +++++++-
 fs/xfs/xfs_ioctl.c     | 11 +++++++++++
 fs/xfs/xfs_trans_ail.c |  7 ++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)

-- 
Chandan

