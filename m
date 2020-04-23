Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437E21B599B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 12:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgDWKsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 06:48:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727111AbgDWKsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:48:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NAVdNG059028
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:48:42 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmv1v7k8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:48:42 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 23 Apr 2020 11:47:44 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Apr 2020 11:47:40 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03NAmXSV63635682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 10:48:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A65B311C050;
        Thu, 23 Apr 2020 10:48:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 990FE11C04A;
        Thu, 23 Apr 2020 10:48:30 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.60.18])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Apr 2020 10:48:30 +0000 (GMT)
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
Subject: [PATCH 2/5] ext4: Rename fiemap_check_ranges() to make it ext4 specific
Date:   Thu, 23 Apr 2020 16:17:54 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1587555962.git.riteshh@linux.ibm.com>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042310-0020-0000-0000-000003CD1B86
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042310-0021-0000-0000-000022261BDF
Message-Id: <64ab9d5449f6fb96bb8633f1a40cff14ddb5614e.1587555962.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_07:2020-04-22,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=1 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230078
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This renames the fiemap_check_ranges() copy of function
within ext4/ioctl.c to become ext4_fiemap_check_ranges().
This is required so that we can finally get rid of this
duplicate version.
Since overlayfs anyways need to use this in it's
ovl_fiemap() function, so later patches make it
available for use by others via EXPORT_SYMBOL.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index bfc1281fc4cb..76a2b5200ba3 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -734,7 +734,7 @@ static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
 }
 
 /* copied from fs/ioctl.c */
-static int fiemap_check_ranges(struct super_block *sb,
+static int ext4_fiemap_check_ranges(struct super_block *sb,
 			       u64 start, u64 len, u64 *new_len)
 {
 	u64 maxbytes = (u64) sb->s_maxbytes;
@@ -775,7 +775,7 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
 		return -EINVAL;
 
-	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
+	error = ext4_fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
 				    &len);
 	if (error)
 		return error;
-- 
2.21.0

