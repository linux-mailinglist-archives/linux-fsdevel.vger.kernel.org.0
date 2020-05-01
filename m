Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5191C0E28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgEAGax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728342AbgEAGaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:52 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04162Emo164481;
        Fri, 1 May 2020 02:30:44 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r84m8qyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:44 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416Avul030115;
        Fri, 1 May 2020 06:30:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 30mcu5baet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416UdYP50462972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86DD9A405B;
        Fri,  1 May 2020 06:30:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED1C5A405F;
        Fri,  1 May 2020 06:30:37 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:37 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 15/20] ext4: Use BIT() macro for BH_** state bits
Date:   Fri,  1 May 2020 11:59:57 +0530
Message-Id: <bf38d9194eed951b67ae91524d242e7585ae0afa.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588313626.git.riteshh@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=1
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010040
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simply use BIT() macro for all BH_** state bits instead of open
coding it.

There should be no functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h  | 8 ++++----
 fs/ext4/inode.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index db4fb62c1169..214102f84a10 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -169,10 +169,10 @@ struct ext4_allocation_request {
  * well as to store the information returned by ext4_map_blocks().  It
  * takes less room on the stack than a struct buffer_head.
  */
-#define EXT4_MAP_NEW		(1 << BH_New)
-#define EXT4_MAP_MAPPED		(1 << BH_Mapped)
-#define EXT4_MAP_UNWRITTEN	(1 << BH_Unwritten)
-#define EXT4_MAP_BOUNDARY	(1 << BH_Boundary)
+#define EXT4_MAP_NEW		BIT(BH_New)
+#define EXT4_MAP_MAPPED		BIT(BH_Mapped)
+#define EXT4_MAP_UNWRITTEN	BIT(BH_Unwritten)
+#define EXT4_MAP_BOUNDARY	BIT(BH_Boundary)
 #define EXT4_MAP_FLAGS		(EXT4_MAP_NEW | EXT4_MAP_MAPPED |\
 				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY)
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a4aae6acdcb..e294abeb7f03 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2078,7 +2078,7 @@ static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
 	return err;
 }
 
-#define BH_FLAGS ((1 << BH_Unwritten) | (1 << BH_Delay))
+#define BH_FLAGS (BIT(BH_Unwritten) | BIT(BH_Delay))
 
 /*
  * mballoc gives us at most this number of blocks...
@@ -2358,7 +2358,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	dioread_nolock = ext4_should_dioread_nolock(inode);
 	if (dioread_nolock)
 		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
-	if (map->m_flags & (1 << BH_Delay))
+	if (map->m_flags & BIT(BH_Delay))
 		get_blocks_flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
 
 	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
-- 
2.21.0

