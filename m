Return-Path: <linux-fsdevel+bounces-7770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083DC82A738
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 06:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC172286DC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 05:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFFA20E0;
	Thu, 11 Jan 2024 05:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7BaiT2f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF6184D;
	Thu, 11 Jan 2024 05:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ACFC433C7;
	Thu, 11 Jan 2024 05:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704950284;
	bh=zAJour4QBsD/zVuqGxv0EQsM0Zdg6uFuTXhVmiC8+h8=;
	h=From:To:Cc:Subject:Date:From;
	b=k7BaiT2fMS1d0YNBsDDrNq/7VJtis+r7eIU60R172de0EltU8K5ClnQ0Eu8mZXRa+
	 CGlE/G57YEH+uEkLhb3bj2hyJ9nM6c/SxcyioquW2ez8wGk4Z/22gvpxS1UmFCs1Aq
	 C9xu3v7Ng6wWPNo5P8DN9Rpsu6r51NnZTaJt/+9NuwAD8QsSi2xp7vHBk2d97APu0a
	 KL2jAip3Ro8vvFs21MRoMhrc81ErxqpQBE1R0Ep05yUsqMUeZjPGKaQWrYA2BQBTdw
	 Zz8ZumYTiIPkS+rswydFf9dopvjCB4Rx70KzyzEDXVDIbTpNTp0+uZYiZyZwyIjHY+
	 fB/Pn9jVh22yA==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: djwong@kernel.org,hch@lst.de,linux-xfs@vger.kernel.org,linux-fsdevel@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to d61b40bf15ce
Date: Thu, 11 Jan 2024 10:46:14 +0530
Message-ID: <87a5pcmos8.fsf@debian-BULLSEYE-live-builder-AMD64>
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

d61b40bf15ce xfs: fix backwards logic in xfs_bmap_alloc_account

1 new commit:

Darrick J. Wong (1):
      [d61b40bf15ce] xfs: fix backwards logic in xfs_bmap_alloc_account

Code Diffstat:

 fs/xfs/libxfs/xfs_bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

