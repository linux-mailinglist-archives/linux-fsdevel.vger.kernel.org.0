Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BF11D2845
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 08:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgENGx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 02:53:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:60192 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgENGxZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 02:53:25 -0400
IronPort-SDR: dfafrfPfAQYfj8xhCoRqd2CmrsrJ3EwHxSFR7jhcg+/VTn+FAL4/yM6WAszt0MVkNWftafypuP
 VIvIX0v+dvgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:53:24 -0700
IronPort-SDR: oi1LFRnSZHG0FKAwTJER7HsvYD3Mw8saY2OA7VH2bga/VhYsCcjgEIJ0XRqYkhpthYZ9bdvPr9
 ok48CgMNTvcQ==
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="266144719"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 23:53:24 -0700
From:   ira.weiny@intel.com
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 9/9] Documentation/dax: Update DAX enablement for ext4
Date:   Wed, 13 May 2020 23:53:15 -0700
Message-Id: <20200514065316.2500078-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514065316.2500078-1-ira.weiny@intel.com>
References: <20200514065316.2500078-1-ira.weiny@intel.com>
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

