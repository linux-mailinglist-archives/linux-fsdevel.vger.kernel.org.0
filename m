Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663DB1A53A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Apr 2020 22:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDKUcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 16:32:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDKUcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 16:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=E2e+YYhaC2wd0AmTXzvFYru0B8SxNJ2IKpZtWqZz3sI=; b=l3DJLYM9iZAjntrH22/R0S21gI
        IM+X+ViFE8ICxDOL9amy75/03oE1FZ1F3Qu/evXw0HN/0wVQVnfupCmV3UAOQuWF+p8ROZW4N0iog
        mIbK1SuwvBniz/4Jit/a+1NcjTczdkviveZnAKNVPhGva7y3NCfN73DBRxlTQIrdYT/ImckJe53WQ
        L81Am5oRRPcxTWnLQJuWp/9h74PdEti1eWk65LcFFXQwJ2wFBc6hY+PVR1HpDOiEKrv407aFy/CI7
        LveZYL+W4sRb0byixWEKWDaQTa7Xvj6d4CXTtTo+QsPAAV0xsSJDSOGJMSDyEfqD7KDGRfvU8dpMo
        UOuRJEkQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNMnc-00065k-V8; Sat, 11 Apr 2020 20:32:20 +0000
Date:   Sat, 11 Apr 2020 13:32:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rename page_offset() to page_pos()
Message-ID: <20200411203220.GG21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

We've had some trouble recently with page_offset() being confusingly
named.  To minimise conflicts, I automatically generated these two rename
patches just now so you can merge it right before -rc1.  I included
the coccinelle scripts in the commit messages so you can generate the
patches yourself if you'd rather do that.

The following changes since commit b032227c62939b5481bcd45442b36dfa263f4a7c:

  Merge tag 'nios2-v5.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2 (2020-04-11 11:38:44 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git tags/page_pos

for you to fetch changes up to d80f6dd912904b261010b14928b8ba89d8dd88bd:

  fs: Rename page_file_offset() to page_file_pos() (2020-04-11 16:17:34 -0400)

----------------------------------------------------------------
Rename page_offset to page_pos

----------------------------------------------------------------
Matthew Wilcox (Oracle) (2):
      fs: Rename page_offset() to page_pos()
      fs: Rename page_file_offset() to page_file_pos()

 fs/9p/vfs_addr.c        |  4 ++--
 fs/afs/dir.c            |  2 +-
 fs/btrfs/compression.c  |  8 ++++----
 fs/btrfs/disk-io.c      |  4 ++--
 fs/btrfs/extent_io.c    | 28 ++++++++++++++--------------
 fs/btrfs/file-item.c    |  4 ++--
 fs/btrfs/inode.c        | 22 +++++++++++-----------
 fs/btrfs/ioctl.c        |  6 +++---
 fs/btrfs/relocation.c   |  2 +-
 fs/buffer.c             |  2 +-
 fs/ceph/addr.c          | 26 +++++++++++++-------------
 fs/cifs/cifssmb.c       |  2 +-
 fs/cifs/file.c          |  8 ++++----
 fs/erofs/zdata.c        |  2 +-
 fs/ext2/dir.c           |  6 +++---
 fs/ext4/inode.c         |  2 +-
 fs/f2fs/file.c          |  2 +-
 fs/fuse/file.c          | 10 +++++-----
 fs/gfs2/file.c          |  4 ++--
 fs/hostfs/hostfs_kern.c |  4 ++--
 fs/iomap/buffered-io.c  | 22 +++++++++++-----------
 fs/iomap/seek.c         |  4 ++--
 fs/isofs/compress.c     |  2 +-
 fs/minix/dir.c          |  6 +++---
 fs/nfs/file.c           |  4 ++--
 fs/nfs/write.c          |  6 +++---
 fs/nilfs2/dir.c         |  4 ++--
 fs/nilfs2/file.c        |  2 +-
 fs/nilfs2/page.c        |  2 +-
 fs/ocfs2/aops.c         |  6 +++---
 fs/ocfs2/mmap.c         |  4 ++--
 fs/orangefs/inode.c     | 48 ++++++++++++++++++++++++------------------------
 fs/romfs/super.c        |  2 +-
 fs/sysv/dir.c           |  6 +++---
 fs/ubifs/file.c         |  2 +-
 fs/ufs/dir.c            |  6 +++---
 fs/vboxsf/file.c        |  4 ++--
 fs/xfs/xfs_aops.c       |  2 +-
 include/linux/pagemap.h |  4 ++--
 mm/page_io.c            |  4 ++--
 40 files changed, 144 insertions(+), 144 deletions(-)


