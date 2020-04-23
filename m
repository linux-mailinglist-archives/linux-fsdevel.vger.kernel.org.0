Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644951B599D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDWKsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 06:48:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727111AbgDWKsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:48:50 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NAaIDq107756
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:48:48 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghu8x9cc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:48:48 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 23 Apr 2020 11:48:10 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Apr 2020 11:48:05 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03NAmedZ59113688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 10:48:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2788411C04A;
        Thu, 23 Apr 2020 10:48:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FBBD11C064;
        Thu, 23 Apr 2020 10:48:37 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.60.18])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Apr 2020 10:48:36 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        darrick.wong@oracle.com, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 3/5] vfs: EXPORT_SYMBOL for fiemap_check_ranges()
Date:   Thu, 23 Apr 2020 16:17:55 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1587555962.git.riteshh@linux.ibm.com>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042310-0008-0000-0000-00000375F52C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042310-0009-0000-0000-00004A97C1E4
Message-Id: <58eee51755bb15c312c9d5935655a89466bd34ca.1587555962.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_07:2020-04-22,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=990
 suspectscore=1 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230078
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

1. fiemap_check_ranges() is needed by ovl_fiemap() to check for ranges
before calling underlying inode's ->fiemap() call.
2. With this change even ext4 can use generic fiemap_check_ranges() instead of
having a duplicate copy of it.

So make this EXPORT_SYMBOL for use by overlayfs.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ioctl.c         | 5 +++--
 include/linux/fs.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 282d45be6f45..f1d93263186c 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -166,8 +166,8 @@ int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags)
 }
 EXPORT_SYMBOL(fiemap_check_flags);
 
-static int fiemap_check_ranges(struct super_block *sb,
-			       u64 start, u64 len, u64 *new_len)
+int fiemap_check_ranges(struct super_block *sb, u64 start, u64 len,
+			u64 *new_len)
 {
 	u64 maxbytes = (u64) sb->s_maxbytes;
 
@@ -187,6 +187,7 @@ static int fiemap_check_ranges(struct super_block *sb,
 
 	return 0;
 }
+EXPORT_SYMBOL(fiemap_check_ranges);
 
 static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..1ea70fe07618 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1759,6 +1759,8 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
 			    u64 phys, u64 len, u32 flags);
 int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
 
+int fiemap_check_ranges(struct super_block *sb, u64 start, u64 len,
+			u64 *new_len);
 /*
  * This is the "filldir" function type, used by readdir() to let
  * the kernel specify what kind of dirent layout it wants to have.
-- 
2.21.0

