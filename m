Return-Path: <linux-fsdevel+bounces-7238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3180C823061
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 16:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2C4284C26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930F71B267;
	Wed,  3 Jan 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kugt6KIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D561A726;
	Wed,  3 Jan 2024 15:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C822BC433C8;
	Wed,  3 Jan 2024 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704295172;
	bh=vgFckl7sis6cgkqsmIhf+TxrHwPjTfuBkdunPtTkBz0=;
	h=Subject:From:To:Cc:Date:From;
	b=Kugt6KIA2BaOflKwArKk0JMHW9V7hRS9sNl98bb0qEWaupRf3DK29g1U9YkS1bQt5
	 0+Ymgnj535kF7E5Mo9sJkSnpX/3XEEuf9WiBnsrzOUOxhOABxeKub+gDqCzD+nH5+B
	 1sZQkLZXSrop8TLe+cpF6m2NVHg1a59JaaUv3tspb9tVCGiW4OD0DTDn/XBMA6kyl9
	 yjZalvXoPiqdbHn6msd2pA8FoDlFVrf2il7InIzihoi7m/m0A7bnLEb/dAQIhB64dC
	 B6Q5qvm8XaoymiuQ3hLWENX1jVQFGAuZRSlArT8xE+0pjhdrCZdpIRuAU8RRBGMRls
	 WhXe1C+CQkscQ==
Subject: [PATCH v2 0/2] fix the fallback implementation of get_name
From: Chuck Lever <cel@kernel.org>
To: jlayton@redhat.com, amir73il@gmail.com
Cc: Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org
Date: Wed, 03 Jan 2024 10:19:30 -0500
Message-ID: 
 <170429478711.50646.12675561629884992953.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

I've set up a testing topic branch for exportfs in my kernel.org git
repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

But IIRC, Christian wants exportfs changes to go through the VFS
tree. Please correct me if I'm wrong.

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
 include/linux/fs.h   |  9 +++++++++
 5 files changed, 11 insertions(+), 29 deletions(-)

--
Chuck Lever


