Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB428A5BB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfIBRKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 13:10:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57994 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfIBRKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:10:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x82H4LO7084565;
        Mon, 2 Sep 2019 17:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=OYfkKyJOCabAG2XHEZA8aAXQkV8Yw8jkLwA/TlPJ+ho=;
 b=LBbq0xHwzfGDmFpJ9jPKIP76W02MTBI65E/ONscJbeKbIIL0w3AkT2QaKZhW9q0yGw/0
 JwQ7MruwSsl2mlCp8+zW2aKG+BBxc87pnREW7EuFrUxm+oC+pM6exnYHxpBjzZIweA8E
 6DCO2/UHHVKDJALd0hCbZB/z4RAlu/nAmjidDh7u4ubBPWjbKaxakqwZimeVoDT+O+vH
 lY3ikSI75wymSWC9nnc6II7tDbNG8cQTkHuRUv8xlYlTMdsEr5yzz70Q1a1DC7CKURyr
 lDveiSUHE619D7WdQnOZzlM4PKcEQZRcIRcekkdpB4JdF8EgsPnmr8UpYpV3OXOwIujS Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2us70s01gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 17:09:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x82H7b0p019056;
        Mon, 2 Sep 2019 17:09:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2urww6nu8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 17:09:17 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x82H9G1f010206;
        Mon, 2 Sep 2019 17:09:16 GMT
Received: from localhost (/10.159.145.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Sep 2019 10:09:16 -0700
Date:   Mon, 2 Sep 2019 10:09:16 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/15] iomap: Introduce CONFIG_FS_IOMAP_DEBUG
Message-ID: <20190902170916.GE568270@magnolia>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
 <20190901200836.14959-2-rgoldwyn@suse.de>
 <20190902162934.GA6263@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902162934.GA6263@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909020193
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909020192
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 06:29:34PM +0200, Christoph Hellwig wrote:
> On Sun, Sep 01, 2019 at 03:08:22PM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > To improve debugging abilities, especially invalid option
> > asserts.
> 
> Looking at the code I'd much rather have unconditional WARN_ON_ONCE
> statements in most places.  Including returning an error when we see
> something invalid in most cases.

Yeah, I was thinking something like this, which has the advantage that
the report format is familiar to XFS developers and will get picked up
by the automated error collection stuff I put in xfstests to complain
about any XFS assertion failures:

iomap: Introduce CONFIG_FS_IOMAP_DEBUG

To improve debugging abilities, especially invalid option
asserts.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
[darrick: restructure it to follow what xfs does]
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/Kconfig            |    3 +++
 fs/iomap/apply.c      |   10 ++++++++++
 include/linux/iomap.h |   14 ++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index bfb1c6095c7a..4bed5df9b55f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -19,6 +19,9 @@ if BLOCK
 
 config FS_IOMAP
 	bool
+config FS_IOMAP_DEBUG
+	bool "Debugging for the iomap code"
+	depends on FS_IOMAP
 
 source "fs/ext2/Kconfig"
 source "fs/ext4/Kconfig"
diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 54c02aecf3cd..95cc3a2cadd5 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -8,6 +8,16 @@
 #include <linux/fs.h>
 #include <linux/iomap.h>
 
+#ifdef CONFIG_FS_IOMAP_DEBUG
+void
+iomap_assertion_failed(const char *expr, const char *file, int line)
+{
+	printk(KERN_EMERG "IOMAP: Assertion failed: %s, file: %s, line: %d",
+	       expr, file, line);
+	WARN_ON_ONCE(1);
+}
+#endif
+
 /*
  * Execute a iomap write on a segment of the mapping that spans a
  * contiguous range of pages that have identical block mapping state.
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 834d3923e2f2..b3d5d6f323cf 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -20,6 +20,20 @@ struct page;
 struct vm_area_struct;
 struct vm_fault;
 
+#ifdef CONFIG_FS_IOMAP_DEBUG
+
+extern void iomap_assertion_failed(const char *expr, const char *f, int l);
+
+#define IOMAP_ASSERT(expr) \
+	do { \
+		if (unlikely(!(expr))) \
+			iomap_assertion_failed(#expr, __FILE__, __LINE__); \
+	} while(0)
+
+#else
+#define IOMAP_ASSERT(expr)	((void)0)
+#endif
+
 /*
  * Types of block ranges for iomap mappings:
  */
