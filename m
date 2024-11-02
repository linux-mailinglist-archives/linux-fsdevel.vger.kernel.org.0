Return-Path: <linux-fsdevel+bounces-33556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F69B9DBE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 08:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B81283F36
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 07:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D201155C96;
	Sat,  2 Nov 2024 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayt4Yf/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C4945016;
	Sat,  2 Nov 2024 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730533068; cv=none; b=gJn0MqrNa+2NnKuyWfqMI4zrh233tQRNo5OxeZWvmv//yWAETnW9Ycw7mObAcCeXWwhE/QvlqftIaVyA42nIFuZkkdy3ht1envqax60kGQZmU2/xOCW2A5dNLC4sOCwrQweB/uFnvYqZAc5h2BXIAenSy8MCfzb5m/vwzBn4RKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730533068; c=relaxed/simple;
	bh=fdJx1ZcRekZyXkxIsiin10FBlx2tYxNRlS2b5X6v70I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IihzYydgCRzl9RNpO6Z643bH7XmFJNN8ICruutnnN43k8XuXoUr9+4KbRofMxvvMgcExa/ResSYerE88FYt7vUGxokK/xbDLWcG4YlXjmQA2AzCvd+dpFXmlFfjBD/3404XntTrMkCar689ZEo9eYX95lCRtNH55YGvu79Zw0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayt4Yf/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB84C4CEC3;
	Sat,  2 Nov 2024 07:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730533067;
	bh=fdJx1ZcRekZyXkxIsiin10FBlx2tYxNRlS2b5X6v70I=;
	h=Date:From:To:Cc:Subject:From;
	b=ayt4Yf/rzowUDR/BCNzVZ/Q5O9engB1wy46bHTXIkyc4N5VvnnAs08jWMp0b992JG
	 cKA/trZl2XDrLTraHDBB33pCST3rmk5HdPZ3KNnOcN7RVGrapb1++r7N9e1xjoU83D
	 uAYuy88CgHrkuU6OgO+vXgkZPBWjFCb+a9DknFUTlM3iXB21i6JBaTMV3hMzT1OPQ3
	 kl7ZILQrgagto1PDezyFbvQ+cxLU9pdqyuuYzG/gh14EC1BOg3gjaeSGlIG/e7CvP4
	 0J/pGoPSNWacdrZqDOvATKyAiMfP0IGvk/sFiEvg6M6pPBH7zbJVusg1+VEDMd3SFR
	 xg4Iy25QH8pvg==
Date: Sat, 2 Nov 2024 08:37:43 +0100
From: Carlos Maiolino <cem@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] xfs: fixes for 6.12-rc6
Message-ID: <p6nyyqtmlqnkmfkikvughdqbgusnvf2gaohrmkmhbm7x6zccts@vfcbxfefbtzf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

could you please pull the patches below?

I just did a quick merge attempt against your ToT and no merge conflicts have
been found.
As usual, these patches are already if linux-next for a few days.

Thanks,
Carlos


The following changes since commit 4a201dcfa1ff0dcfe4348c40f3ad8bd68b97eb6c:

  xfs: update the pag for the last AG at recovery time (2024-10-22 13:37:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-6

for you to fetch changes up to 81a1e1c32ef474c20ccb9f730afe1ac25b1c62a4:

  xfs: streamline xfs_filestream_pick_ag (2024-10-30 11:27:18 +0100)

----------------------------------------------------------------
XFS bug fies for 6.12-rc6

* fix a sysbot reported crash on filestreams
* Reduce cpu time spent searching for extents in
  a very fragmented FS
* Check for delayed allocations before setting extsize

Signed-off-by: Carlos Maiolino <cem@kernel.org>

----------------------------------------------------------------
Chi Zhiling (1):
      xfs: Reduce unnecessary searches when searching for the best extents

Christoph Hellwig (2):
      xfs: fix finding a last resort AG in xfs_filestream_pick_ag
      xfs: streamline xfs_filestream_pick_ag

Ojaswin Mujoo (1):
      xfs: Check for delayed allocations before setting extsize

 fs/xfs/libxfs/xfs_alloc.c |  2 +-
 fs/xfs/xfs_filestream.c   | 99 +++++++++++++++++++++++------------------------
 fs/xfs/xfs_inode.c        |  2 +-
 fs/xfs/xfs_inode.h        |  5 +++
 fs/xfs/xfs_ioctl.c        |  4 +-
 fs/xfs/xfs_trace.h        | 15 +++----
 6 files changed, 62 insertions(+), 65 deletions(-)

