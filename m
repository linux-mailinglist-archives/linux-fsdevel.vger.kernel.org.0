Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578BC1DAA36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 07:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETF6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 01:58:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:8978 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgETF6A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 01:58:00 -0400
IronPort-SDR: K14IyiOmJzVhlrqLOukidtQTnRqG5Or8CoqNsevPdc2jVqaT+uMxr7VK8q1DoRhveQ+oITPsPM
 W3zJwjo74rrw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 22:58:00 -0700
IronPort-SDR: xXYnmRw3m6jRMzmWHNZoBCoKtn1QHyLc+jV+O6Wdhc52zQag5Kn91rPtyvEnGm8svMCNppcIBR
 TdYWA8n1xq6A==
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="411901829"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 22:57:59 -0700
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
Subject: [PATCH V3 8/8] Documentation/dax: Update DAX enablement for ext4
Date:   Tue, 19 May 2020 22:57:53 -0700
Message-Id: <20200520055753.3733520-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200520055753.3733520-1-ira.weiny@intel.com>
References: <20200520055753.3733520-1-ira.weiny@intel.com>
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

