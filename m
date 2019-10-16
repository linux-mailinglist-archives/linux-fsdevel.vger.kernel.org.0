Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C37BD89DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 09:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbfJPHh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 03:37:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728135AbfJPHhY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:37:24 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G7bFRc112296
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vnxnqgqu3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 03:37:22 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 16 Oct 2019 08:37:21 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 08:37:19 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G7alMD28967244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 07:36:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8912AE058;
        Wed, 16 Oct 2019 07:37:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92020AE04D;
        Wed, 16 Oct 2019 07:37:16 +0000 (GMT)
Received: from dhcp-9-199-158-105.in.ibm.com (unknown [9.199.158.105])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 07:37:16 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [RFC 1/5] ext4: keep uniform naming convention for io & io_end variables
Date:   Wed, 16 Oct 2019 13:07:07 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016073711.4141-1-riteshh@linux.ibm.com>
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101607-0008-0000-0000-000003227AA2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101607-0009-0000-0000-00004A4192EE
Message-Id: <20191016073711.4141-2-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=808 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160071
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's keep uniform naming convention for ext4_submit_io (io)
& ext4_end_io_t (io_end) structures, to avoid any confusion.
No functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/page-io.c | 55 ++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 12ceadef32c5..d9b96fc976a3 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -136,19 +136,19 @@ static void ext4_release_io_end(ext4_io_end_t *io_end)
  * cannot get to ext4_ext_truncate() before all IOs overlapping that range are
  * completed (happens from ext4_free_ioend()).
  */
-static int ext4_end_io(ext4_io_end_t *io)
+static int ext4_end_io_end(ext4_io_end_t *io_end)
 {
-	struct inode *inode = io->inode;
-	loff_t offset = io->offset;
-	ssize_t size = io->size;
-	handle_t *handle = io->handle;
+	struct inode *inode = io_end->inode;
+	loff_t offset = io_end->offset;
+	ssize_t size = io_end->size;
+	handle_t *handle = io_end->handle;
 	int ret = 0;
 
-	ext4_debug("ext4_end_io_nolock: io 0x%p from inode %lu,list->next 0x%p,"
+	ext4_debug("ext4_end_io_nolock: io_end 0x%p from inode %lu,list->next 0x%p,"
 		   "list->prev 0x%p\n",
-		   io, inode->i_ino, io->list.next, io->list.prev);
+		   io_end, inode->i_ino, io_end->list.next, io_end->list.prev);
 
-	io->handle = NULL;	/* Following call will use up the handle */
+	io_end->handle = NULL;	/* Following call will use up the handle */
 	ret = ext4_convert_unwritten_extents(handle, inode, offset, size);
 	if (ret < 0 && !ext4_forced_shutdown(EXT4_SB(inode->i_sb))) {
 		ext4_msg(inode->i_sb, KERN_EMERG,
@@ -157,8 +157,8 @@ static int ext4_end_io(ext4_io_end_t *io)
 			 "(inode %lu, offset %llu, size %zd, error %d)",
 			 inode->i_ino, offset, size, ret);
 	}
-	ext4_clear_io_unwritten_flag(io);
-	ext4_release_io_end(io);
+	ext4_clear_io_unwritten_flag(io_end);
+	ext4_release_io_end(io_end);
 	return ret;
 }
 
@@ -166,21 +166,21 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
 {
 #ifdef	EXT4FS_DEBUG
 	struct list_head *cur, *before, *after;
-	ext4_io_end_t *io, *io0, *io1;
+	ext4_io_end_t *io_end, *io_end0, *io_end1;
 
 	if (list_empty(head))
 		return;
 
 	ext4_debug("Dump inode %lu completed io list\n", inode->i_ino);
-	list_for_each_entry(io, head, list) {
-		cur = &io->list;
+	list_for_each_entry(io_end, head, list) {
+		cur = &io_end->list;
 		before = cur->prev;
-		io0 = container_of(before, ext4_io_end_t, list);
+		io_end0 = container_of(before, ext4_io_end_t, list);
 		after = cur->next;
-		io1 = container_of(after, ext4_io_end_t, list);
+		io_end1 = container_of(after, ext4_io_end_t, list);
 
 		ext4_debug("io 0x%p from inode %lu,prev 0x%p,next 0x%p\n",
-			    io, inode->i_ino, io0, io1);
+			    io_end, inode->i_ino, io_end0, io_end1);
 	}
 #endif
 }
@@ -207,7 +207,7 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
 static int ext4_do_flush_completed_IO(struct inode *inode,
 				      struct list_head *head)
 {
-	ext4_io_end_t *io;
+	ext4_io_end_t *io_end;
 	struct list_head unwritten;
 	unsigned long flags;
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -219,11 +219,11 @@ static int ext4_do_flush_completed_IO(struct inode *inode,
 	spin_unlock_irqrestore(&ei->i_completed_io_lock, flags);
 
 	while (!list_empty(&unwritten)) {
-		io = list_entry(unwritten.next, ext4_io_end_t, list);
-		BUG_ON(!(io->flag & EXT4_IO_END_UNWRITTEN));
-		list_del_init(&io->list);
+		io_end = list_entry(unwritten.next, ext4_io_end_t, list);
+		BUG_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
+		list_del_init(&io_end->list);
 
-		err = ext4_end_io(io);
+		err = ext4_end_io_end(io_end);
 		if (unlikely(!ret && err))
 			ret = err;
 	}
@@ -242,13 +242,14 @@ void ext4_end_io_rsv_work(struct work_struct *work)
 
 ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
 {
-	ext4_io_end_t *io = kmem_cache_zalloc(io_end_cachep, flags);
-	if (io) {
-		io->inode = inode;
-		INIT_LIST_HEAD(&io->list);
-		atomic_set(&io->count, 1);
+	ext4_io_end_t *io_end = kmem_cache_zalloc(io_end_cachep, flags);
+
+	if (io_end) {
+		io_end->inode = inode;
+		INIT_LIST_HEAD(&io_end->list);
+		atomic_set(&io_end->count, 1);
 	}
-	return io;
+	return io_end;
 }
 
 void ext4_put_io_end_defer(ext4_io_end_t *io_end)
-- 
2.21.0

