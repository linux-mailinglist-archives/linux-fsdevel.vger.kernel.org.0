Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18410D88E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 17:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfK2QdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 11:33:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:43095 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfK2QdG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:33:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 08:33:06 -0800
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="234751020"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 08:33:05 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH V3 0/3] Move swap functions out of address space operations
Date:   Fri, 29 Nov 2019 08:32:57 -0800
Message-Id: <20191129163300.14749-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

As suggested by Jan Kara, move swap_[de]activate to file_operations to simplify
address space operations for coming changes.

For this version (V3):
	1) updated to the latest linux-next
	2) added documentation patch to the series
	3) add reviews/acks
	4) fixed up a slight conflict in btrfs pointed out by David

Ira Weiny (3):
  fs: Clean up mapping variable
  fs: Move swap_[de]activate to file_operations
  Documentation/fs: Move swap_[de]activate() to file_operations

 Documentation/filesystems/vfs.rst |  24 +--
 fs/btrfs/file.c                   | 341 ++++++++++++++++++++++++++++++
 fs/btrfs/inode.c                  | 340 -----------------------------
 fs/f2fs/data.c                    | 123 -----------
 fs/f2fs/file.c                    | 122 +++++++++++
 fs/iomap/swapfile.c               |   3 +-
 fs/nfs/file.c                     |   4 +-
 fs/xfs/xfs_aops.c                 |  13 --
 fs/xfs/xfs_file.c                 |  12 ++
 include/linux/fs.h                |  10 +-
 mm/swapfile.c                     |  12 +-
 11 files changed, 500 insertions(+), 504 deletions(-)

-- 
2.21.0

