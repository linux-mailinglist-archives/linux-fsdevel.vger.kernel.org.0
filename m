Return-Path: <linux-fsdevel+bounces-34925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE329CEED8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69779B31BBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEE51D4612;
	Fri, 15 Nov 2024 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="glIS0q9K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28ED1B395F;
	Fri, 15 Nov 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683471; cv=none; b=pdqV29XBDAdSc4Wr+1iZBCTceYQjUquSd2Nb7mmdOiOlx2TY2EySlImaEOFFBnDYM0vm18/7/BnBxsJD5BARrrPff+ruq8XNagaYLxg+gPWequQWswnPBn+nv6shjIZbqTIRCi+SeUG5yxTb5sx78LI+BtCXhvPA88j6UOUnGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683471; c=relaxed/simple;
	bh=hud0JYmElCCPRBVEtM0rGWZLObUxIAmftvC8O2MR1Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VU1jy+tYogNs46oW1FVR3+RhAi60ri0rouF0e7OW0xP7aI4oOGQPXbbxkz4e9JixUr3aQnDibu7TEX6VrCuKCyqDy7cJgd5oO+pOvdR4rvWSTeL7qbNm9Z/MeNnMDTfJwuP2NQX4zYOVyXOwUwclI9Ln9DL4QcrhN93k08AiZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=glIS0q9K; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UbxntHEjxWIKxNGGLDRTMQ6Ue5XZwjMLXKIitt3BbX8=; b=glIS0q9KUrlgfCtkmapojys1J/
	XUIYCfM4quCS90pgOdlAn2+fMmkPD9k6sUrtlRL7Q2iNnh2DY/1TFD0xBaib1SIRrYBJvJ8o0kZ9R
	F68YztgwCvAo2+mbnPHUgPszN8c2VIiS3kO++ItOiTCEPTfsDGSV4+ZYS16WqZFj95QHtpOm49k9/
	nWOxBv6XlmMTbvWTreqdaHbc7fmIaAjObsC1flZMN7Cqlvg2ZFz9Xen3OfCu55THAd9K9c4cA9k/1
	N1w7qBsGArH9BVQVOkBx2Ujz+EnDKpw0lbZ9f125Ius3OpNMByC2ZDjqielMzYxENNXLbp4nUN1Ln
	lssLMgwg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBxyW-0000000FTcC-0Wyt;
	Fri, 15 Nov 2024 15:11:08 +0000
Date: Fri, 15 Nov 2024 15:11:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] ufs stuff
Message-ID: <20241115151108.GV3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ufs

for you to fetch changes up to 6cfe56fbad32c8c5b50e82d9109413566d691569:

  ufs: ufs_sb_private_info: remove unused s_{2,3}apb fields (2024-11-12 19:02:12 -0500)

----------------------------------------------------------------
ufs cleanups, fixes and folio conversion

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Agathe Porte (1):
      ufs: ufs_sb_private_info: remove unused s_{2,3}apb fields

Al Viro (12):
      ufs: fix handling of delete_entry and set_link failures
      ufs: missing ->splice_write()
      ufs: fix ufs_read_cylinder() failure handling
      ufs: untangle ubh_...block...() macros, part 1
      ufs: untangle ubh_...block...(), part 2
      ufs: untangle ubh_...block...(), part 3
      ufs_clusteracct(): switch to passing fragment number
      ufs_free_fragments(): fix the braino in sanity check
      ufs_inode_getfrag(): remove junk comment
      ufs: get rid of ubh_{ubhcpymem,memcpyubh}()
      clean ufs_trunc_direct() up a bit...
      ufs: take the handling of free block counters into a helper

Matthew Wilcox (Oracle) (5):
      ufs: Convert ufs_inode_getblock() to take a folio
      ufs: Convert ufs_extend_tail() to take a folio
      ufs: Convert ufs_inode_getfrag() to take a folio
      ufs: Pass a folio to ufs_new_fragments()
      ufs: Convert ufs_change_blocknr() to take a folio

 fs/ufs/balloc.c   | 107 ++++++++++++++------------------
 fs/ufs/cylinder.c |  31 ++++++----
 fs/ufs/dir.c      |  29 +++++----
 fs/ufs/file.c     |   1 +
 fs/ufs/inode.c    | 179 +++++++++++++++++++++++-------------------------------
 fs/ufs/namei.c    |  39 ++++++------
 fs/ufs/super.c    |  49 ++++++---------
 fs/ufs/ufs.h      |  12 ++--
 fs/ufs/ufs_fs.h   |   4 --
 fs/ufs/util.c     |  46 --------------
 fs/ufs/util.h     |  61 +++++++++----------
 11 files changed, 222 insertions(+), 336 deletions(-)

