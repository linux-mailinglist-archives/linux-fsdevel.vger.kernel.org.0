Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 174EDA338C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 11:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfH3JSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 05:18:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725780AbfH3JSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:18:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7U9AILt085828
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 05:18:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uq0xd096r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 05:18:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 30 Aug 2019 10:17:59 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Aug 2019 10:17:57 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7U9HtZZ15597734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 09:17:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA9B411C05B;
        Fri, 30 Aug 2019 09:17:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37DF811C04A;
        Fri, 30 Aug 2019 09:17:55 +0000 (GMT)
Received: from dhcp-9-199-158-229.in.ibm.com (unknown [9.124.31.57])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 09:17:55 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     riteshh@linux.ibm.com
Subject: [RFC 2/2] Doc: vfs: Update few inode specific super_operations methods
Date:   Fri, 30 Aug 2019 14:47:51 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830091751.10284-1-riteshh@linux.ibm.com>
References: <20190830091751.10284-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19083009-0008-0000-0000-0000030EF52D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083009-0009-0000-0000-00004A2D3C24
Message-Id: <20190830091751.10284-3-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=22 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=22
 clxscore=1015 lowpriorityscore=0 mlxscore=22 impostorscore=0
 mlxlogscore=56 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300099
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove delete_inode & clear_inode method from super_operations
as these are no more present.
Also add documentation about free_inode & evict_inode methods.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 Documentation/filesystems/vfs.rst | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 0f85ab21c2ca..f5e8a0133e1f 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -229,18 +229,18 @@ filesystem.  As of kernel 2.6.22, the following members are defined:
 	struct super_operations {
 		struct inode *(*alloc_inode)(struct super_block *sb);
 		void (*destroy_inode)(struct inode *);
+		void (*free_inode)(struct inode *);
 
 		void (*dirty_inode) (struct inode *, int flags);
 		int (*write_inode) (struct inode *, int);
 		void (*drop_inode) (struct inode *);
-		void (*delete_inode) (struct inode *);
+		void (*evict_inode) (struct inode *);
 		void (*put_super) (struct super_block *);
 		int (*sync_fs)(struct super_block *sb, int wait);
 		int (*freeze_fs) (struct super_block *);
 		int (*unfreeze_fs) (struct super_block *);
 		int (*statfs) (struct dentry *, struct kstatfs *);
 		int (*remount_fs) (struct super_block *, int *, char *);
-		void (*clear_inode) (struct inode *);
 		void (*umount_begin) (struct super_block *);
 
 		int (*show_options)(struct seq_file *, struct dentry *);
@@ -269,6 +269,12 @@ or bottom half).
 	->alloc_inode was defined and simply undoes anything done by
 	->alloc_inode.
 
+``free_inode``
+	This is the last part of resource freeing for inode done
+	in RCU-delayed way. This is called at the end by
+	destroy_inode method using call_rcu, mostly to free FS specific
+	inodep cache object.
+
 ``dirty_inode``
 	this method is called by the VFS to mark an inode dirty.
 
@@ -283,15 +289,22 @@ or bottom half).
 
 	This method should be either NULL (normal UNIX filesystem
 	semantics) or "generic_delete_inode" (for filesystems that do
-	not want to cache inodes - causing "delete_inode" to always be
+	not want to cache inodes - causing "evict_inode" to always be
 	called regardless of the value of i_nlink)
 
 	The "generic_delete_inode()" behavior is equivalent to the old
 	practice of using "force_delete" in the put_inode() case, but
 	does not have the races that the "force_delete()" approach had.
 
-``delete_inode``
-	called when the VFS wants to delete an inode
+``evict_inode``
+	Called by iput_final when the inode reference count reaches
+	zero and the inode is not in lru list. Method is used to clean anything
+	by FS that needs to be, before the inode is completely destroyed and
+	put on the free list.
+	For stacked filesystems, this is the place where the reference of
+	lower inodes are dropped.
+	For local filesystems, this is the place to truncate all pages
+	before inode dies and also to perform necessary cleanup.
 
 ``put_super``
 	called when the VFS wishes to free the superblock
@@ -318,9 +331,6 @@ or bottom half).
 	called when the filesystem is remounted.  This is called with
 	the kernel lock held
 
-``clear_inode``
-	called then the VFS clears the inode.  Optional
-
 ``umount_begin``
 	called when the VFS is unmounting a filesystem.
 
-- 
2.21.0

