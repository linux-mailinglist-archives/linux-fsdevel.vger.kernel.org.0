Return-Path: <linux-fsdevel+bounces-7788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A6482ABDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 11:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD6B1F230BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB10212E74;
	Thu, 11 Jan 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iezwpXSy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342112E60
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+jp1vG/zeND1IZ92CH70K8zdB1rRzElQ7QrQlZrZFC0=; b=iezwpXSyFYjTHHT/WCjN4xreS9
	CifTUwR/yomFD+QfS/v49jprpXqzk5RJRxFcut01ZD77dPTAbx5E4j6Bn8QaMmZaPiiIealT4FRS9
	tONxU1utOXaL5S7yK4YzDR5/aQL2bIkpPLQ9aynXiVwt5GrpY4oWrJpiFb2NqQh++LGN9qXyn5SFh
	kxWZz21PnOq8XALzhU1mvsyq45vACqiGwb83NtFXqqaLxR0s8w5g1kc+6cOiz53OHM+I0TSkKpAer
	COtbTWeY74slHQFWzaokaxY/tFhPWDHTzKMyGL80TnM+ZOmLH75wKc2+8cgJzGZDBeH26/GotuWEw
	wlioOmiA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNsBx-00CAUT-0Q;
	Thu, 11 Jan 2024 10:21:41 +0000
Date: Thu, 11 Jan 2024 10:21:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git misc pile
Message-ID: <20240111102141.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

for you to fetch changes up to c5f3fd21789cff8fa1120e802dd1390d34e3eec0:

  apparmorfs: don't duplicate kfree_link() (2023-12-21 12:53:43 -0500)

----------------------------------------------------------------
misc cleanups (the part that hadn't been picked by individual fs trees)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (17):
      zonefs: d_splice_alias() will do the right thing on ERR_PTR() inode
      nilfs2: d_obtain_alias(ERR_PTR(...)) will do the right thing...
      bfs_add_entry(): get rid of pointless ->d_name.len checks
      nfsd: kill stale comment about simple_fill_super() requirements
      udf: d_splice_alias() will do the right thing on ERR_PTR() inode
      udf: d_obtain_alias(ERR_PTR(...)) will do the right thing...
      udf_fiiter_add_entry(): check for zero ->d_name.len is bogus...
      hostfs: use d_splice_alias() calling conventions to simplify failure exits
      /proc/sys: use d_splice_alias() calling conventions to simplify failure exits
      affs: d_obtain_alias(ERR_PTR(...)) will do the right thing
      befs: d_obtain_alias(ERR_PTR(...)) will do the right thing
      ext4_add_entry(): ->d_name.len is never 0
      __ocfs2_add_entry(), ocfs2_prepare_dir_for_insert(): namelen checks
      reiserfs_add_entry(): get rid of pointless namelen checks
      ocfs2_find_match(): there's no such thing as NULL or negative ->d_parent
      orangefs: saner arguments passing in readdir guts
      apparmorfs: don't duplicate kfree_link()

 fs/affs/namei.c                |  3 ---
 fs/befs/linuxvfs.c             |  3 ---
 fs/bfs/dir.c                   |  5 -----
 fs/ext4/namei.c                |  2 --
 fs/hostfs/hostfs_kern.c        |  8 ++------
 fs/nfsd/nfsctl.c               |  4 ----
 fs/nilfs2/namei.c              |  7 +------
 fs/ocfs2/dcache.c              |  7 -------
 fs/ocfs2/dir.c                 |  9 ---------
 fs/orangefs/dir.c              | 32 ++++++++++++--------------------
 fs/proc/proc_sysctl.c          | 14 ++------------
 fs/reiserfs/namei.c            |  7 -------
 fs/udf/namei.c                 | 11 +----------
 fs/zonefs/super.c              |  2 --
 security/apparmor/apparmorfs.c |  7 +------
 15 files changed, 19 insertions(+), 102 deletions(-)

