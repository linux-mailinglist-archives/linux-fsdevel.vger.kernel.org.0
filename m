Return-Path: <linux-fsdevel+bounces-16294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB5D89AAC8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 14:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2401C20F2C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6302D03D;
	Sat,  6 Apr 2024 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPzVL3DR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4AE546;
	Sat,  6 Apr 2024 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712406969; cv=none; b=V8m7SJolcpF1qEiEH9U4kbUoNb3KsJgWw+Qjx5ohM6NFXiiqsIR+AmvN6P5i0MRza6tqEOweX4SbY9qYqYekqt7/j+Eq4D0likxT04RkS+bonZWycB6ZSMtjwuJ/i+nLQlsvABE3X49y+NonY2miS5iYg2BKzM6raclCKkcgTFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712406969; c=relaxed/simple;
	bh=cEYndfbvw9bPlpW+QT4N4+8WTIz9UEcA8coJzqYDKfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y6VOsX5TQI46Vv2fhAQGMQt7zu5bpUT2qIjJau4OJtD8MCVz7kYHTVdlc+0AN1N/Mp5JeDVJ1OjNNgXTZ23HbcxGpp9RflJbLA2Kfgs492j4eFC4jLlB5e6UpILbHdg4z591AGinEa+CA3+RiZIB8oIc0sP+rcPyAXH86VHAs5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPzVL3DR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E234C433C7;
	Sat,  6 Apr 2024 12:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712406968;
	bh=cEYndfbvw9bPlpW+QT4N4+8WTIz9UEcA8coJzqYDKfI=;
	h=From:To:Cc:Subject:Date:From;
	b=vPzVL3DRtAe8wC38itNZGUVzP00ocl6DlXXRu0UJhUL8a+9cWOOvfhJiOSoukTUrf
	 93xw7wEh1T22yOqh+iezeNLXLBTYnyXFLcBhlGSNcfokKZHsPR/3cAi0gOcNC97Edt
	 dXs67mFHIpIj1nirJhXdSASj4DMOikW+P6we4xBa9ALi4Yf7VEFoQ7xk3Ixuy6kaQO
	 DaLitrxTtEtL4I9UJ8DFBkw8p0Q2RF7s7/Ujp45KxeG+RwMor1n3ABdfvjpLPKVXp5
	 AN1oZctr0Ut82NFHpxuhDyK0cwROaSKO//hwJgv1E/Xrs4CqKlCZZe2i7mObqkhhE3
	 NYxkTmKLPFFAg==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,aalbersh@redhat.com,djwong@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.9
Date: Sat, 06 Apr 2024 18:02:40 +0530
Message-ID: <878r1q3byi.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch which contains an XFS bug fix for 6.9-rc3. A brief
summary of the bug fix is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.9-fixes-2

for you to fetch changes up to e23d7e82b707d1d0a627e334fb46370e4f772c11:

  xfs: allow cross-linking special files without project quota (2024-04-01 11:55:49 +0530)

----------------------------------------------------------------
Bug fixes for 6.9-rc3:

 * Allow creating new links to special files which were not associated with a
   project quota.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Andrey Albershteyn (1):
      xfs: allow cross-linking special files without project quota

 fs/xfs/xfs_inode.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

