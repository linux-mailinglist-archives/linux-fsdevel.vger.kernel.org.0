Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C57F1D068C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 07:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgEMFnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 01:43:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:28729 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbgEMFnf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 01:43:35 -0400
IronPort-SDR: 0NDnqg+bzE/iMMLaRXyDn2viLqZy08dOX04dgZ1lMOkIAWYwzBWybg/2uNQ9J6u1kzKtaKB5Rx
 a3ZbKtzyWy4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:34 -0700
IronPort-SDR: /7J2wgvlbA4JuFwXtFDpWIH4fynSgaRQnUJ8n65Npv3+9AnFcDm6osBNahWG9MM8WdhtUkcd/U
 SXsjxbLwd9EA==
X-IronPort-AV: E=Sophos;i="5.73,386,1583222400"; 
   d="scan'208";a="341142971"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 22:43:33 -0700
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
Subject: [PATCH 9/9] Documentation/dax: Update DAX enablement for ext4
Date:   Tue, 12 May 2020 22:43:24 -0700
Message-Id: <20200513054324.2138483-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200513054324.2138483-1-ira.weiny@intel.com>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
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

