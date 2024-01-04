Return-Path: <linux-fsdevel+bounces-7420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3A8249DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 21:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA4F287BDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB922C6B7;
	Thu,  4 Jan 2024 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUQX98GG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F602C69B;
	Thu,  4 Jan 2024 20:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC40C433CC;
	Thu,  4 Jan 2024 20:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704401721;
	bh=KZbc8Q5RKRBLuFQLLAArkLnYJylCz+McEzIg/qh9a+8=;
	h=Subject:From:To:Cc:Date:From;
	b=NUQX98GGLv1MAB2gI65zXpXowIPIm1lx9WS/nBYddWz6PdmFXOGw/gq05zZiVxEPz
	 CPSLoMXkyf9GfbOjEWmqJqIakIN7bTCJnCnEhD1VpmJXq6ZyWK9z+fP3MHqcR3s4ot
	 78TCwM3Fi5UhJ0xW1697hI9+yg5j1vd0Hn5h7jrSstQCJncKI6tl9b3yvOClzfLfXR
	 lNlfvvamn4RtBjGMDHq06tkW3bxFsiIT5ZTi27ztB98e3eg220QDqF/P0SX5iU80FN
	 xLJ84hhrFiPmKZYb0Ux7VLC1fiBQ5kUTNUVviR77LFGs0mt5U6Eg+JVRg/7flPeByk
	 G4/VLvyVlXoDA==
Subject: [PATCH v4 0/2] fix the fallback implementation of get_name
From: Chuck Lever <cel@kernel.org>
To: jlayton@redhat.com, amir73il@gmail.com
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 trondmy@hammerspace.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Date: Thu, 04 Jan 2024 15:55:19 -0500
Message-ID: 
 <170440153940.204613.6839922871340228115.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Topic branch for fs/exportfs:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
branch: exportfs-next

Changes since v3:
- is_dot_dotdot() now checks that the file name length > 0

Changes since v2:
- Capture the open-coded "is_dot_dotdot" implementation in
  lookup_one_common()

Changes since v1:
- Fixes: was dropped from 1/2
- Added a patch to hoist is_dot_dotdot() into linux/fs.h

---

Chuck Lever (1):
      fs: Create a generic is_dot_dotdot() utility

Trond Myklebust (1):
      exportfs: fix the fallback implementation of the get_name export operation


 fs/crypto/fname.c    |  8 +-------
 fs/ecryptfs/crypto.c | 10 ----------
 fs/exportfs/expfs.c  |  2 +-
 fs/f2fs/f2fs.h       | 11 -----------
 fs/namei.c           |  6 ++----
 include/linux/fs.h   | 13 +++++++++++++
 6 files changed, 17 insertions(+), 33 deletions(-)

--
Chuck Lever


