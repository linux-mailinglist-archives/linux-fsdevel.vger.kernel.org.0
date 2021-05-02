Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29F0370989
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 03:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhEBBXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 May 2021 21:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhEBBXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 May 2021 21:23:44 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB2C06138B;
        Sat,  1 May 2021 18:22:54 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ld0os-00A5mF-QU; Sun, 02 May 2021 01:22:50 +0000
Date:   Sun, 2 May 2021 01:22:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tyler Hicks <code@tyhicks.com>
Subject: [git pull] ecryptfs series
Message-ID: <YI3+6jfW+mEMgx3x@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	The interesting part here is (ecryptfs) lock_parent() fixes -
its treatment of ->d_parent had been very wrong.  The rest is trivial
cleanups.

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.ecryptfs

for you to fetch changes up to 9d786beb6fe5cf8fcc1ce5336a89401eaa444fb6:

  ecryptfs: ecryptfs_dentry_info->crypt_stat is never used (2021-03-20 17:46:44 -0400)

----------------------------------------------------------------
Al Viro (4):
      ecryptfs: get rid of pointless dget/dput in ->symlink() and ->link()
      ecryptfs: saner API for lock_parent()
      ecryptfs: get rid of unused accessors
      ecryptfs: ecryptfs_dentry_info->crypt_stat is never used

 fs/ecryptfs/ecryptfs_kernel.h |  17 +----
 fs/ecryptfs/inode.c           | 163 +++++++++++++++++++-----------------------
 2 files changed, 75 insertions(+), 105 deletions(-)
