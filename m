Return-Path: <linux-fsdevel+bounces-3811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8797F8AF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 13:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2E8B212B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019E10961;
	Sat, 25 Nov 2023 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv4LMBic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C60F9FE;
	Sat, 25 Nov 2023 12:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1F7C433C8;
	Sat, 25 Nov 2023 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700916872;
	bh=uwj+d7fEshZ9lZUyeodAsoUi2dZtB5p35AStykoLwvY=;
	h=From:To:Cc:Subject:Date:From;
	b=lv4LMBiczF1SzjGowPH4a3QDtOETx9/UMuFfIP26iWQNdGq2jFm/uimNnkfvD/gDO
	 HziGMOK75vJK2VhlsqOMn4AhPm548Yb6gQDNlPbJcqYCKVt5+eCav73F1zyuHJjt9M
	 w+XrtNfD6XsA+aa5yliV/dYXRFThxMrjKt18dhC0Fs70TNfaUMaKog+t6HH2iIaeK1
	 7JUI27J9fmmgwcLxOLyWf4nv21DRYaRcxVBbhgq/VclooWPuVbeopz1ccNs4ecMALg
	 QLY10ueVQEtVYDIIedndBHcGQdSDUV+pBPopWfxpXiEVwB156m6msRrZzjzhs3y/nX
	 QBn48jWLb12pw==
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: new code for 6.7
Date: Sat, 25 Nov 2023 18:17:49 +0530
Message-ID: <87fs0um1rw.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch with changes for xfs for 6.7-rc3. XFS now validates
quota records recovered from the log before writing them to the disk.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.7-fixes-3

for you to fetch changes up to 9c235dfc3d3f901fe22acb20f2ab37ff39f2ce02:

  xfs: dquot recovery does not validate the recovered dquot (2023-11-22 23:39:36 +0530)

----------------------------------------------------------------
Code changes for 6.7-rc2:

 * Validate quota records recovered from the log before writing them to the
   disk.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (2):
      xfs: clean up dqblk extraction
      xfs: dquot recovery does not validate the recovered dquot

 fs/xfs/xfs_dquot.c              |  5 +++--
 fs/xfs/xfs_dquot_item_recover.c | 21 ++++++++++++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

