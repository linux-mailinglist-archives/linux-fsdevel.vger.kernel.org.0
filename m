Return-Path: <linux-fsdevel+bounces-9642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA32843F72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA49B25F24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C817079DC2;
	Wed, 31 Jan 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih4LIz7x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2944205B;
	Wed, 31 Jan 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704217; cv=none; b=rTJwQVADpinC/0yWKMxoJWMP+rmrRJO2xQdKBo1J+MxVxf4GeNd8rmBzbPRHIvap109h/sNO6viU25F4Km1VD+8e+3t+f6xpjzKzhz3o9NkM/Lc5k7EMBsav4fhOMChmEQB3PXDcBDeBEh/symIBUnJwGrmxbGcAYX2YAypyBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704217; c=relaxed/simple;
	bh=NPi7zz7PJo9gTy4fg6gLi7yEQ66mtXZn+OPCucOxUQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sn8wXH+pTQLSLH1e1VVLeNwsyo0ZPc22Y18f8bByMyzUzyz3EMgswsX7NH+Lj3cpCPixmGlDAo2iFBr5q/ym2+vPEke65mkp2ZRINGs0PuDsJGc7WgaKVBkazzXNZ9QKwf5ydUiWN/vaLVSRKQEQAFOaKCMD7rDUYrjtSR1JFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih4LIz7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B817C433F1;
	Wed, 31 Jan 2024 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706704216;
	bh=NPi7zz7PJo9gTy4fg6gLi7yEQ66mtXZn+OPCucOxUQI=;
	h=From:To:Cc:Subject:Date:From;
	b=Ih4LIz7xDOy6oPzSqXwWsNMVjnqP0tQEvQCiZEFCDcqlwy9X4CyJpH0ge/4B+VP6y
	 MYN+A8UvycbwmjBxlxnQ6bfAmks/BOi83+X0AdiIMCfImiS0MJKxwD3xtfjLWXOshN
	 DSIcl0LtoKwCPNjfRSPSgFVyjPNKmUVSnwafdDf6YxwKoOYNNDM5Pp3bcp67mmZEny
	 lkZFvWdEMdU7N2GmJrgShk2De0vCVJksYJ6BBdhB3mKVIzusvfgcf7C7RmJ6Vpr1E2
	 kNvR6T3GDcsh8RLEYMvG0Klr8T+XE5eTb5O+Kg3KsDq9Do5uJc9+Jivr4B/xxQ90Sb
	 TiwAzadEB/dWA==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: aalbersh@redhat.com,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 881f78f47255
Date: Wed, 31 Jan 2024 17:58:32 +0530
Message-ID: <87eddxn0rz.fsf@debian-BULLSEYE-live-builder-AMD64>
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

881f78f47255 xfs: remove conditional building of rt geometry validator functions

2 new commits:

Andrey Albershteyn (1):
      [82ef1a535657] xfs: reset XFS_ATTR_INCOMPLETE filter on node removal

Darrick J. Wong (1):
      [881f78f47255] xfs: remove conditional building of rt geometry validator functions

Code Diffstat:

 fs/xfs/libxfs/xfs_attr.c     |  6 +++---
 fs/xfs/libxfs/xfs_rtbitmap.c | 14 --------------
 fs/xfs/libxfs/xfs_rtbitmap.h | 16 ----------------
 fs/xfs/libxfs/xfs_sb.c       | 14 ++++++++++++++
 fs/xfs/libxfs/xfs_sb.h       |  2 ++
 fs/xfs/libxfs/xfs_types.h    | 12 ++++++++++++
 fs/xfs/scrub/rtbitmap.c      |  1 +
 fs/xfs/scrub/rtsummary.c     |  1 +
 8 files changed, 33 insertions(+), 33 deletions(-)

