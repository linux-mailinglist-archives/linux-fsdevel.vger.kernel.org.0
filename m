Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884EC2AE734
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 04:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKKDq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 22:46:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:16366 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgKKDq4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:46:56 -0500
IronPort-SDR: 4aNLvMq3/w+BhB8EUxanMtsT4WtUGmyBF5B30CiACV4RK9QotnkSyHWttftsF2X0M9EyTOQhl3
 LaeiCQrvtupQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170246927"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="170246927"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 19:46:55 -0800
IronPort-SDR: YfFFQjDPAh90ga182X7MrQpki8Yjhzz8IFioJVXD6Afsn4RKOe/e0b/sPJelaKT7NRYjei0qAm
 S9rAsckC+yOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="354724136"
Received: from lkp-server02.sh.intel.com (HELO 14a21f3b7a6a) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2020 19:46:53 -0800
Received: from kbuild by 14a21f3b7a6a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kch5w-000023-Pm; Wed, 11 Nov 2020 03:46:52 +0000
Date:   Wed, 11 Nov 2020 11:46:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     kbuild-all@lists.01.org, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [RFC PATCH] btrfs: extract_ordered_extent() can be static
Message-ID: <20201111034642.GA12169@6cb56d714dfd>
References: <4c6d82729e000c4552fceae4a64b2a869c93eb8c.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c6d82729e000c4552fceae4a64b2a869c93eb8c.1605007036.git.naohiro.aota@wdc.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 inode.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index df85d8dea37c9e..ee3f3ab1b964b6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2158,8 +2158,8 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 }
 
-int extract_ordered_extent(struct inode *inode, struct bio *bio,
-			   loff_t file_offset)
+static int extract_ordered_extent(struct inode *inode, struct bio *bio,
+				  loff_t file_offset)
 {
 	struct btrfs_ordered_extent *ordered;
 	struct extent_map *em = NULL, *em_new = NULL;
