Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19951E652D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404047AbgE1PAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:00:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:59623 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403933AbgE1PAW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:00:22 -0400
IronPort-SDR: 9IrUsf65/sxCy5Ek2tAmnuyh/LxlvysYoajdIoZuvU4dfGROnHmXqG7hHCm091PJQyDVyDhNVB
 ZBNtzgD0imSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:00:12 -0700
IronPort-SDR: IQoaQF4QNlijXhTZVhp1aYk63DUWeazbrKW1+FmpERrzKf06zIFbwvfXh4HNE9QTzKQQ2+hECt
 X+dUJ9l3ULZA==
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="345927916"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:00:11 -0700
From:   ira.weiny@intel.com
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 9/9] Documentation/dax: Update DAX enablement for ext4
Date:   Thu, 28 May 2020 08:00:03 -0700
Message-Id: <20200528150003.828793-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528150003.828793-1-ira.weiny@intel.com>
References: <20200528150003.828793-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Update the document to reflect ext4 and xfs now behave the same.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC:
	Update with ext2 text...
---
 Documentation/filesystems/dax.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
index 735fb4b54117..265c4f808dbf 100644
--- a/Documentation/filesystems/dax.txt
+++ b/Documentation/filesystems/dax.txt
@@ -25,7 +25,7 @@ size when creating the filesystem.
 Currently 3 filesystems support DAX: ext2, ext4 and xfs.  Enabling DAX on them
 is different.
 
-Enabling DAX on ext4 and ext2
+Enabling DAX on ext2
 -----------------------------
 
 When mounting the filesystem, use the "-o dax" option on the command line or
@@ -33,8 +33,8 @@ add 'dax' to the options in /etc/fstab.  This works to enable DAX on all files
 within the filesystem.  It is equivalent to the '-o dax=always' behavior below.
 
 
-Enabling DAX on xfs
--------------------
+Enabling DAX on xfs and ext4
+----------------------------
 
 Summary
 -------
-- 
2.25.1

