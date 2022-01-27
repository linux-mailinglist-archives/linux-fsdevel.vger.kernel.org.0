Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C4B49E27B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 13:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiA0MlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 07:41:04 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49987 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241186AbiA0MlE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:41:04 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A7op5waJWE0AXQMIYFE+RupQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDo0jhz12QFnWoXWGHSa/aKYDSmeNp0YN6w8kpVuMLVn4NqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkjPvXHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToy+UltZq2ZNDs4esY?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQcoO6eeiLi4KR/yGWDKRMA2c5GAEgoPIEw9PxwBGZ?=
 =?us-ascii?q?U//0EbjsKa3irh+m26LO9RPNliskqII/sJox3kn1py3fbS+knRZTCSqDRzd5ew?=
 =?us-ascii?q?Do0wMtJGJ72a8gGbjxgRBfNeRtCPhEQEp1WtOOpgGTvNjhdgFGLrKE0pW/Jw2R?=
 =?us-ascii?q?Z1qbhMd/QUtiLXtlO2EKZoH/WuWj0HHkyNtWZxHyO8m+EgfXGlif2HokVEdWQ8?=
 =?us-ascii?q?v9snU3WyHcfBQMbUXOlrvSjzE2zQdRSLwoT4CVGhawz8lG7C9rwRRu1pFaasRM?=
 =?us-ascii?q?GHdldCes37EeK0KW8ywKYAHUUCy5Pc/Q4u8IsAz8nzFmEm5XuHzMHjVE/YRpx7?=
 =?us-ascii?q?Z/N9XXrZ3dTdjREOEc5ocI+y4GLiOkOYtjnF76PyJKIs+A=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A2AjC+a2EZlq+c3kS2RMuSAqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="120913259"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Jan 2022 20:41:01 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id ED70A4D169C7;
        Thu, 27 Jan 2022 20:40:59 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 27 Jan 2022 20:41:01 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 27 Jan 2022 20:40:57 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v10 0/9] fsdax: introduce fs query to support reflink
Date:   Thu, 27 Jan 2022 20:40:49 +0800
Message-ID: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: ED70A4D169C7.A1DE6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is aimed to support shared pages tracking for fsdax.

Changes since V9:
  - Remove dax write/read lock patch
  - Remove dax_lock_entry() in dax_lock_mapping_entry() and rename it to
      dax_load_page()
  - Wrap dax code in memory-failure.c with #if IS_ENABLED(CONFIG_FS_DAX)
  - Wrap xfs_dax_failure_fn() with #if IS_ENABLED(CONFIG_MEMORY_FAILURE)
  - Move PAGE_MAPPING_DAX_COW into page-flags.h

This patchset moves owner tracking from dax_assocaite_entry() to pmem
device driver, by introducing an interface ->memory_failure() for struct
pagemap.  This interface is called by memory_failure() in mm, and
implemented by pmem device.

Then call holder operations to find the filesystem which the corrupted
data located in, and call filesystem handler to track files or metadata
associated with this page.

Finally we are able to try to fix the corrupted data in filesystem and
do other necessary processing, such as killing processes who are using
the files affected.

The call trace is like this:
memory_failure()
|* fsdax case
|------------
|pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
| dax_holder_notify_failure()      =>
|  dax_device->holder_ops->notify_failure() =>
|                                     - xfs_dax_notify_failure()
|  |* xfs_dax_notify_failure()
|  |--------------------------
|  |   xfs_rmap_query_range()
|  |    xfs_dax_failure_fn()
|  |    * corrupted on metadata
|  |       try to recover data, call xfs_force_shutdown()
|  |    * corrupted on file data
|  |       try to recover data, call mf_dax_kill_procs()
|* normal case
|-------------
|mf_generic_kill_procs()

==
Shiyang Ruan (9):
  dax: Introduce holder for dax_device
  mm: factor helpers for memory_failure_dev_pagemap
  pagemap,pmem: Introduce ->memory_failure()
  fsdax: fix function description
  fsdax: Introduce dax_load_page()
  mm: move pgoff_address() to vma_pgoff_address()
  mm: Introduce mf_dax_kill_procs() for fsdax case
  xfs: Implement ->notify_failure() for XFS
  fsdax: set a CoW flag when associate reflink mappings

 drivers/dax/super.c         |  62 ++++++++++
 drivers/nvdimm/pmem.c       |  16 +++
 fs/dax.c                    | 123 +++++++++++++++----
 fs/xfs/Makefile             |   1 +
 fs/xfs/xfs_buf.c            |  12 ++
 fs/xfs/xfs_fsops.c          |   3 +
 fs/xfs/xfs_mount.h          |   1 +
 fs/xfs/xfs_notify_failure.c | 222 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_notify_failure.h |  10 ++
 include/linux/dax.h         |  37 ++++++
 include/linux/memremap.h    |  12 ++
 include/linux/mm.h          |  17 +++
 include/linux/page-flags.h  |   6 +
 mm/memory-failure.c         | 234 +++++++++++++++++++++++++-----------
 14 files changed, 666 insertions(+), 90 deletions(-)
 create mode 100644 fs/xfs/xfs_notify_failure.c
 create mode 100644 fs/xfs/xfs_notify_failure.h

-- 
2.34.1



