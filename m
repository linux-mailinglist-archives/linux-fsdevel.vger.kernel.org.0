Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E36F9F70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 01:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKMAmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 19:42:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:39806 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfKMAmw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:42:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 16:42:51 -0800
X-IronPort-AV: E=Sophos;i="5.68,298,1569308400"; 
   d="scan'208";a="198274341"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 16:42:47 -0800
From:   ira.weiny@intel.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH V2 0/2] Move swap functions out of address space operations
Date:   Tue, 12 Nov 2019 16:42:42 -0800
Message-Id: <20191113004244.9981-1-ira.weiny@intel.com>
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

I'm not sure if this should go through Al Viro or Andrew Morton so I'm sending
it to both of you.  Sorry if this is a problem.  Let me know if there is
something else I should do.

Ira Weiny (2):
  fs: Clean up mapping variable
  fs: Move swap_[de]activate to file_operations

 fs/btrfs/file.c     | 341 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/inode.c    | 340 -------------------------------------------
 fs/f2fs/data.c      | 123 ----------------
 fs/f2fs/file.c      | 122 ++++++++++++++++
 fs/iomap/swapfile.c |   3 +-
 fs/nfs/file.c       |   4 +-
 fs/xfs/xfs_aops.c   |  13 --
 fs/xfs/xfs_file.c   |  12 ++
 include/linux/fs.h  |  10 +-
 mm/swapfile.c       |  12 +-
 10 files changed, 488 insertions(+), 492 deletions(-)

-- 
2.21.0

