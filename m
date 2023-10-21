Return-Path: <linux-fsdevel+bounces-867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B62377D1B52
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 08:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6F0B215AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 06:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1033F3FEF;
	Sat, 21 Oct 2023 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU4mGNdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F9EBC
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 06:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFACEC433C7;
	Sat, 21 Oct 2023 06:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697869664;
	bh=a8DE6UK4DP5vgQrAGmOW66RQUqEFOYmULPq9SLYXDB0=;
	h=Date:From:To:Cc:Subject:From;
	b=NU4mGNdW9XJUCNRCiojALB8XVqg9Eh3+gUggRjHHAT0zlP9FiQuIlmbMBnREqAI0V
	 Zl3j6Nwm0OzklL8DRmd4UlxEFL9hBqo2LrwOs51QmD/M97/je4IjB/mAJ1ldxWjufW
	 OyIbwbi6G83X5PVyI93oFDVlVm8MEYYJ6RIHl8IjgjtPO7rRK5FyxbpgxInS03rgNs
	 Co0GXIJOaJnb5Ah3Mg06ams+IkJ/sO4SJfurtVFBdp0NtMtP1yZtCFsDC+8jPuKvlH
	 +vxaEqkVkUUD3AIuRgV6bLuoCPSSxyjA+203lOCGp7Nx/RiVIj2+majYaElmjgwQip
	 U7UUefiEf5zMA==
Date: Fri, 20 Oct 2023 23:27:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, torvalds@linux-foundation.org
Cc: hch@lst.de, jstancek@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [GIT PULL] iomap: bug fixes for 6.6-rc7
Message-ID: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this branch with changes for iomap for 6.6-rc7.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 684f7e6d28e8087502fc8efdb6c9fe82400479dd:

iomap: Spelling s/preceeding/preceding/g (2023-09-28 09:26:58 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git iomap-6.6-fixes-5

for you to fetch changes up to 3ac974796e5d94509b85a403449132ea660127c2:

iomap: fix short copy in iomap_write_iter() (2023-10-19 09:41:36 -0700)

----------------------------------------------------------------
Bug fixes for 6.6-rc6:

* Fix a bug where a writev consisting of a bunch of sub-fsblock writes
where the last buffer address is invalid could lead to an infinite
loop.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Jan Stancek (1):
iomap: fix short copy in iomap_write_iter()

fs/iomap/buffered-io.c | 10 +++++++---
1 file changed, 7 insertions(+), 3 deletions(-)

