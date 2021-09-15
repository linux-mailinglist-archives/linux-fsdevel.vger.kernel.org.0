Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2840C3C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 12:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhIOKqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 06:46:46 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34577 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232454AbhIOKqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:46:43 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AdNspu6/CCYdB067sQ0AWDrUD+3+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUomhTAOnGNNXm6BPa6MYmukc9p2aoux8h4F6sPVyNNjQVdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4EfwWlTdhSMkj/jQF+OhULW?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OaefSXm4JTJlyUqdFOpmZ2CFnoeMYQG++pfD3t?=
 =?us-ascii?q?J8PsCIjERKBuEgoqe37O/TvhEh8ItNsDnMYoT/HZ6wlnxAf8gB5KFXKTO4d5R2?=
 =?us-ascii?q?SwYh8ZSEPKYbM0cARJjbgvHZRJnOVoNDp862uCyiRHXdSNUqVeQja42+HTIigh?=
 =?us-ascii?q?w1qX9dtbYZLSiRc5VtkKDuiTK8gzRGB4dMNCA2Dyt6W+3i6nDkEvTXIMUCa39+?=
 =?us-ascii?q?OVmjUOewkQNBxAME1i2u/+0jgi5Qd03A0gV/Dc+6Ks/7kqmSvHjUBCi5n2JpBg?=
 =?us-ascii?q?RX5xXCeJSwAWMzLfEphaXHUAaQTNbLt8rrsk7QXotzFDht83oHztHorCTSGzb8?=
 =?us-ascii?q?raSsCP0PjIaa3IBDRLo5yNtD8LL+dl110yQCI04VvPdszE8IhmoqxjikcT0r+5?=
 =?us-ascii?q?7YRY36piG?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AT1LFY6vUGxgwx6ZYvnY7dTQd7skDE9V00zEX?=
 =?us-ascii?q?/kB9WHVpm62j9/xG88536faZslwssRIb+OxoWpPufZq0z/ccirX5VY3SPzUO01?=
 =?us-ascii?q?HFEGgN1+Xf/wE=3D?=
X-IronPort-AV: E=Sophos;i="5.85,295,1624291200"; 
   d="scan'208";a="114519020"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Sep 2021 18:45:21 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id F14DA4D0D9D2;
        Wed, 15 Sep 2021 18:45:14 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 15 Sep 2021 18:45:04 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 15 Sep 2021 18:45:03 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>
Subject: [PATCH v9 0/8] fsdax,xfs: Add reflink&dedupe support for fsdax
Date:   Wed, 15 Sep 2021 18:44:53 +0800
Message-ID: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: F14DA4D0D9D2.A142D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is attempt to add CoW support for fsdax, and take XFS,
which has both reflink and fsdax feature, as an example.

Changes from V8:
 - Rebased on v5.15-rc1
 - Patch 4: Add a pre patch to convert dax_iomap_zero to iter model[1]
 - Patch 6&7: Remove EXPORT_SYMBOL
 - Patch 8: Solve the conflict caused by rebase
 - Fix code style problems, add comment

One of the key mechanism need to be implemented in fsdax is CoW.  Copy
the data from srcmap before we actually write data to the destance
iomap.  And we just copy range in which data won't be changed.

Another mechanism is range comparison.  In page cache case, readpage()
is used to load data on disk to page cache in order to be able to
compare data.  In fsdax case, readpage() does not work.  So, we need
another compare data with direct access support.

With the two mechanisms implemented in fsdax, we are able to make reflink
and fsdax work together in XFS.

(Rebased on v5.15-rc1)
==

Shiyang Ruan (8):
  fsdax: Output address in dax_iomap_pfn() and rename it
  fsdax: Introduce dax_iomap_cow_copy()
  fsdax: Replace mmap entry in case of CoW
  fsdax: Convert dax_iomap_zero to iter model
  fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
  fsdax: Dedup file range to use a compare function
  xfs: support CoW in fsdax mode
  xfs: Add dax dedupe support

 fs/dax.c               | 284 +++++++++++++++++++++++++++++++++--------
 fs/iomap/buffered-io.c |   3 +-
 fs/remap_range.c       |  31 ++++-
 fs/xfs/xfs_bmap_util.c |   3 +-
 fs/xfs/xfs_file.c      |   8 +-
 fs/xfs/xfs_inode.c     |  80 +++++++++++-
 fs/xfs/xfs_inode.h     |   1 +
 fs/xfs/xfs_iomap.c     |  38 +++++-
 fs/xfs/xfs_iomap.h     |  30 +++++
 fs/xfs/xfs_iops.c      |   7 +-
 fs/xfs/xfs_reflink.c   |  15 ++-
 include/linux/dax.h    |  11 +-
 include/linux/fs.h     |  12 +-
 13 files changed, 438 insertions(+), 85 deletions(-)

-- 
2.33.0



