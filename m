Return-Path: <linux-fsdevel+bounces-3456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B777F4F30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 19:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1171C20A81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 18:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123E35ABB7;
	Wed, 22 Nov 2023 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ijr6Ew54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B15ABA7
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 18:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AE3C433C7;
	Wed, 22 Nov 2023 18:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700677248;
	bh=cxoLuIy+DxzxtA/AcQKa1sqUbjSKg+q3pX+reb+600U=;
	h=From:To:Cc:Subject:Date:From;
	b=Ijr6Ew540auwut2nI/Ml7kQhVlE4D5F+zSopJazWgtltcfDi7JNRXYGdb8IMRlmv2
	 MqF+R46SqI6dbJD8pwspPv1yqRr5t5YrclshSVhm6egN7xjVa7efed0M9elatowc3b
	 j55kdqDtzn/gZnO3WI9rc89MdJjERSkvGTL8BfMMQ3yOgaPRKPpsw1j4Zhq2pagKlW
	 /USaSY2vimrMOiT1ij+/M01YIOLLYZPyWj1NmRqCE87Lgv7HUEmStAqGrfx3b8AHYD
	 Ls/CVtNw6zGAhmZEYx9cQnj7ekViW6ZA8lz0owzzNU0HOYbM+OLAv/hLPjNklW0bKj
	 45wYHolrTU87g==
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: xfs-linux: for-next updated to 9c235dfc3d3f
Date: Wed, 22 Nov 2023 23:49:31 +0530
Message-ID: <87zfz5hcoz.fsf@debian-BULLSEYE-live-builder-AMD64>
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

9c235dfc3d3f xfs: dquot recovery does not validate the recovered dquot

2 new commits:

Darrick J. Wong (2):
      [ed17f7da5f0c] xfs: clean up dqblk extraction
      [9c235dfc3d3f] xfs: dquot recovery does not validate the recovered dquot

Code Diffstat:

 fs/xfs/xfs_dquot.c              |  5 +++--
 fs/xfs/xfs_dquot_item_recover.c | 21 ++++++++++++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

