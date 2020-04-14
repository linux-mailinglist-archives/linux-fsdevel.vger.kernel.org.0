Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F311A7221
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgDNEBD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:01:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:10170 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgDNEA4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:00:56 -0400
IronPort-SDR: j9ZXsUHp/+ZSLVxp+F1S4XzdNCxtvNcan8jqtQaMFjpkTXD2nXbZwytOIiq1HhIyu88VssSYXA
 0LdfSgm19aSA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:56 -0700
IronPort-SDR: 0hJsumdI/7fzzMAB9Zl7n0RHAY8Vpjn4lt3tjMyg0RKAMFnE4RvbWaBQSdWrwygOLJj++GBdAL
 fXze5GANiKVg==
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="332053898"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:00:55 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 8/8] Documentation/dax: Update DAX enablement for ext4
Date:   Mon, 13 Apr 2020 21:00:30 -0700
Message-Id: <20200414040030.1802884-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414040030.1802884-1-ira.weiny@intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Update the document to reflect ext4 and xfs now behave the same.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/filesystems/dax.txt | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
index af14c1b330a9..5f28b22d2815 100644
--- a/Documentation/filesystems/dax.txt
+++ b/Documentation/filesystems/dax.txt
@@ -22,18 +22,7 @@ on it as usual.  The DAX code currently only supports files with a block
 size equal to your kernel's PAGE_SIZE, so you may need to specify a block
 size when creating the file system.
 
-Currently 2 filesystems support DAX, ext4 and xfs.  Enabling DAX on them is
-different at this time.
-
-Enabling DAX on ext4
---------------------
-
-When mounting the filesystem, use the "-o dax" option on the command line or
-add 'dax' to the options in /etc/fstab.
-
-
-Enabling DAX on xfs
--------------------
+Currently 2 filesystems support DAX, ext4 and xfs.
 
 Summary
 -------
-- 
2.25.1

