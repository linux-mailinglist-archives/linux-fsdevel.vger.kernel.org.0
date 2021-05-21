Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6DA38D209
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 01:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhEUXjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 19:39:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47322 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhEUXjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 19:39:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LNa96v057757;
        Fri, 21 May 2021 23:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=wpvkevZanTpX2drdomuyEkoPw+Lt8J8Mayg99waAqcs=;
 b=Z+NLv5aVammpLdScRx1UBafuKo/Yaov7fWoXlEIiqFx0cYsteAhCnHqYejUWfLzORndO
 Ko76Mfduf358j12wIoPJ7crwBByfpBDP8pvgin/SWJ5iVlgzXaGdp128ZzzFg8i3h/+y
 Z353oop6sDjCacj2y5ZVKo86GVcOktXKX/soUtV1TL2A1rLZsJ+KZZGLQn6tSBCM/hJw
 3+G4P/+xJYrW5ACc1U91VDmvAqQSosDCp7uIENqg/neN+Fz0U224zIYVJp2IvIQ4k/6t
 LdS16eAobm6tkhnYyBSfoeJjvLLL+KZHXqGOEE8kiYfVNJ+pGzMgstHL6/YIzUhCEdeq fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38j68mrvxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 23:38:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LNUaE9171046;
        Fri, 21 May 2021 23:38:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by userp3030.oracle.com with ESMTP id 38megp08a4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 23:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOPftVVyuAFJsc4qkLHSWq4WQkMDl1LCEmKBJ5DEgVeYhHoImLKrft2/P3SdNFoCK+4pmAlEmngkf2livv+yrYeF0Kyhplrm5dAKaZO2nOSFE4lJQFSpsAcI3LwA3PlLewydfymFudS6/K+mEvXFEM2sJNcTU/Gei7rt833mkbmFZ867KOJB5RIsIR3nZuPtltqZskKbwbn728rNRH/Pd3YpJGUVYywQSDb3EE9CECbOYfo0k/LO0uzN7SfoOcf/HKYY8R412QaamKrpeA06Nx2CMfa9XQyRkwixljKSFK/p/5si8/BvN2FgtA26OGghRtgrYDNdNUJJLrrMugV9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpvkevZanTpX2drdomuyEkoPw+Lt8J8Mayg99waAqcs=;
 b=jnUTy2vBPAyqmi6UYBD8DxhgPdbELp0MW4aLsNy13xgdvP/FbHKQA2DBkKHqlOlzYSOcYRHNnGyUBNAw2fzWbuc63HEIP05mQ8fQ2wcb6Kj8ozZ3M6GiktzJl+QTYyT3hcLaoyGcocxYk/Cstiq77ycSGqr/rcl+sVcEyo2zSdW91ZxtGJ0gv0/8gGGDbX3Jhxm294SdS7tvJDc0dJXAVTS5cAxz+eSdYreBr605fYQ9kk28bVQTV0qR6ualEOjBFnrUxnGsHdIcFInuBiwqWf9Q9rLYPWFlYZgsOexn9ZcF4d1pLrmeM2vrm4Nfb2BWM36at7SduDfIrvJyl6Qkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpvkevZanTpX2drdomuyEkoPw+Lt8J8Mayg99waAqcs=;
 b=MMmIGNZtNcc+i2TJTZ1i2WQABZQ7OUVbMWHDamqn0MGWw1W77evpQB8OtqjcWmN1cAexKx6n+9FMk2O7wx05WUIC0LOK/M+nxQhmFySc6eUfIm3CMcUMiBz1E5SQiCqnutZLaf2u+x7jhkMCi9hRL4XtU+01EmjDKZHrjsFv4Xs=
Authentication-Results: oss.oracle.com; dkim=none (message not signed)
 header.d=none;oss.oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SJ0PR10MB4414.namprd10.prod.outlook.com (2603:10b6:a03:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 23:37:58 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9%5]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 23:37:58 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     ocfs2-devel@oss.oracle.com
Cc:     jack@suse.cz, joseph.qi@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, junxiao.bi@oracle.com
Subject: [PATCH v2] ocfs2: fix data corruption by fallocate
Date:   Fri, 21 May 2021 16:36:12 -0700
Message-Id: <20210521233612.75185-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-150-81.vpn.oracle.com (73.231.9.254) by SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Fri, 21 May 2021 23:37:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b65fc93-e05e-4115-6851-08d91cb17739
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4414B21B88AEB0C59B249938E8299@SJ0PR10MB4414.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJ11DBedkAO540LTjQC5g75rbo9zMke8YMTtYY3CwDRfOw86a98SA0HE0iJXoMRo1OAFJmK+ft5sbMXFC6xGUP+RKFFNwlPAdHtXKkJylWRh0GuryuWm9v3d+m6h97hBcvO0vwxTLAMPhYzrD8pt4Jn/rtQHS8JypaWCr5tCccDvAsot62S/a2ZC+/tji1uHEMDo6luMWvQ1r7n/vblr9EkzmYJ4iIzT9t9dgUgycmNIW1cByxrciF86VJI1vV+RHm/KMYiyiWzDsx0p/Lj6PEPCmGMUY+GyIj8nZuo7gQlrtcHMcHFwX8a71SrolRRMayUGTNO3zLEQ4Slbrxvpdh9VD+8HjllcD5I0C1hy32Enk0BODgg05OuP9ircO7ebtt1Tyd42jsvkBxmAgGpGxV059mz5Z1urq4PC67yhLG3ykUJmdKA+nwGKp1GIMqd0dIrsJali/iBXe6J+lgU0rXU0vcJ30gqNXiaru24JGQZ2uoG8eW7KHU4SvAqGqdP5cS40iXq4kFy13EgOWjqMukppnK9fnURkIzBZnERbe9t/IFMhwO8g0eV/cw/6qp8vUnpJfpiixPY3QMWUFmBmDROeKk2kPCcxBojzhMNjAjV0JVtva/Fn66HPt/5qBsvQxVglUmAqzsV4SjNukDfBOD+LMSZpNiPunLoGgzhY+KCIQCxvg9V+r00PbgxZRiKa2Svp7nlrDpDPaF4qsE8AJc0fzM+7iw/O42yn2peiVpb/dtvQLoSLYO3ium+w2BikrnO5t22WBSPwnoLLdIDHUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(316002)(38100700002)(66556008)(6486002)(8936002)(26005)(66946007)(86362001)(66476007)(2906002)(8676002)(966005)(7696005)(52116002)(83380400001)(478600001)(38350700002)(4326008)(107886003)(186003)(34206002)(6666004)(956004)(36756003)(44832011)(5660300002)(16526019)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ngt126p4/MPzcTj7btt7crjXnp+JlEpp/FtQ3Te+GH5WzqCyGoRxffZP9f8E?=
 =?us-ascii?Q?Bor35EyhIRCGPkd1IL60k7m5RMBTJ6BwtmE52kxd/Wgtzw6DDyaWErD++RVh?=
 =?us-ascii?Q?DG4eGDpZRvxqAn7DivOwTZmL90BFtwTHp3vdqNoOqHKK58sYchV1hkk9mqwO?=
 =?us-ascii?Q?CPJxfO6wHcoyNYwf+2yMkiiTBqMAeao+X8Va5r+sJnTisWBAMQMFTqBrOi1f?=
 =?us-ascii?Q?+Kl3wPTBvRyv27tn0bMsMLrCrFCU8cfzL9fCrh3DnXhYVtpNE21N0FIsn/Y1?=
 =?us-ascii?Q?IxrfmEtZLCff+ypa3yPpCh5ie9bZrwGShLcDosrwIs8HsQm/BAeIT58XIi/V?=
 =?us-ascii?Q?RitEdS3d1LFS8eHUFrM1d7Po4697iDnABB9ew8xD/t8oHe1Ps05jsqa8jbLS?=
 =?us-ascii?Q?UbFbgF+YNLkxENN8bMvJdQxk0vdKtrPZBh3o7wbwwDlbO2uCI6bVN+vNifWL?=
 =?us-ascii?Q?KgW57Zdd1obfDPX6Q7xqF3jwHpBs6Dpt9SgRkVdBWjXpU01xjMyOMdm3Tqde?=
 =?us-ascii?Q?NQfp2scJue/WEIQpsMencb5Cd4pbH+YQtuUpC0q24c0wp28mq0kOYHW+ivTG?=
 =?us-ascii?Q?LlFX84A+0et481GFtt9RvEmS15hnWJsEr9IZJBhbn+c4ZTZ/+NOQ3fJy9xlw?=
 =?us-ascii?Q?z2VPrLSS7V62spJa2+ZD9ETmfcL87b45QBRNWM2H6lL2BA2ezjVG5S/E3P/t?=
 =?us-ascii?Q?u0lqmb771+5ygecbJ/r6R/YvJeLq3K+p2iPNrlb5Nz+c3MvW2NUOFBDDz2v2?=
 =?us-ascii?Q?zfPZvnKBTrC3PLvAP5dIyuUwq1kyhJr55a8y4oYXBP6yEXNQSqaEmVLsbcyD?=
 =?us-ascii?Q?wt5EB4uM3tt2K1iQdKQRKTtum9SVeFIAXEILyRRhcb1MrzcwcRqS4wQb+H0l?=
 =?us-ascii?Q?9x+w+GDizwo0F0+dq59NFLseAN9vYL9rlz3+2eT0VqrNadcWXuaWYrW3uGyq?=
 =?us-ascii?Q?8U+dfbWmJt3GbAluWYz/UROnyCGXe8V95x17jBpQ83QpcSZBO5EmJqjLMWV4?=
 =?us-ascii?Q?KhJbNraXtbN+PDjP3RR6+wVuzKa7CQe+GEM9hxXTbip3gX9GQ9EBszUCO+vr?=
 =?us-ascii?Q?7dok8Mb8M3PTeymNbw8NY25sgaGfSLIKpV3IwXVNOh0dWsww8m6X6WN3fkHS?=
 =?us-ascii?Q?CDcUnYcoTUejeGeeFwkGqAk1Vtpg0b1jQxC9cJisrBvuN2DQiNLskHTksB11?=
 =?us-ascii?Q?Ty7fYzJFjEfPO/TqSfbWYvPf/GLplprtvVQpaSdIBHh6jBcBcCuxQxO5IXtI?=
 =?us-ascii?Q?7yyUPqepk26z4NsbyfM2D1HptwX/KOrLear6BAuFrEkUElbkiWDft15MUXZE?=
 =?us-ascii?Q?YjkRplpxoEet9bLOth3P/L+m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b65fc93-e05e-4115-6851-08d91cb17739
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 23:37:58.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeqMnXUE5X/Hfv6QZmrT7pxpqAuJjC3ZHqFh2Zp5FOFr7DKMMyJCHdSN6jx0uIBC8cGWBDq0thZq3gqhzkFrNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4414
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210134
X-Proofpoint-ORIG-GUID: 9DGwehWHjf4_Pax0wD1lzbJfZhLnh1-i
X-Proofpoint-GUID: 9DGwehWHjf4_Pax0wD1lzbJfZhLnh1-i
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210134
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When fallocate punches holes out of inode size, if original isize is in
the middle of last cluster, then the part from isize to the end of the
cluster will be zeroed with buffer write, at that time isize is not
yet updated to match the new size, if writeback is kicked in, it will
invoke ocfs2_writepage()->block_write_full_page() where the pages out
of inode size will be dropped. That will cause file corruption. Fix
this by zero out eof blocks when extending the inode size.

Running the following command with qemu-image 4.2.1 can get a corrupted
coverted image file easily.

    qemu-img convert -p -t none -T none -f qcow2 $qcow_image \
             -O qcow2 -o compat=1.1 $qcow_image.conv

The usage of fallocate in qemu is like this, it first punches holes out of
inode size, then extend the inode size.

    fallocate(11, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 2276196352, 65536) = 0
    fallocate(11, 0, 2276196352, 65536) = 0

v1: https://www.spinics.net/lists/linux-fsdevel/msg193999.html

Cc: <stable@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---

Changes in v2:
- suggested by Jan Kara, using sb_issue_zeroout to zero eof blocks in disk directly.

 fs/ocfs2/file.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index f17c3d33fb18..17469fc7b20e 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1855,6 +1855,45 @@ int ocfs2_remove_inode_range(struct inode *inode,
 	return ret;
 }
 
+/*
+ * zero out partial blocks of one cluster.
+ *
+ * start: file offset where zero starts, will be made upper block aligned.
+ * len: it will be trimmed to the end of current cluster if "start + len"
+ *      is bigger than it.
+ */
+static int ocfs2_zeroout_partial_cluster(struct inode *inode,
+					u64 start, u64 len)
+{
+	int ret;
+	u64 start_block, end_block, nr_blocks;
+	u64 p_block, offset;
+	u32 cluster, p_cluster, nr_clusters;
+	struct super_block *sb = inode->i_sb;
+	u64 end = ocfs2_align_bytes_to_clusters(sb, start);
+
+	if (start + len < end)
+		end = start + len;
+
+	start_block = ocfs2_blocks_for_bytes(sb, start);
+	end_block = ocfs2_blocks_for_bytes(sb, end);
+	nr_blocks = end_block - start_block;
+	if (!nr_blocks)
+		return 0;
+
+	cluster = ocfs2_bytes_to_clusters(sb, start);
+	ret = ocfs2_get_clusters(inode, cluster, &p_cluster,
+				&nr_clusters, NULL);
+	if (ret)
+		return ret;
+	if (!p_cluster)
+		return 0;
+
+	offset = start_block - ocfs2_clusters_to_blocks(sb, cluster);
+	p_block = ocfs2_clusters_to_blocks(sb, p_cluster) + offset;
+	return sb_issue_zeroout(sb, p_block, nr_blocks, GFP_NOFS);
+}
+
 /*
  * Parts of this function taken from xfs_change_file_space()
  */
@@ -1865,7 +1904,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 {
 	int ret;
 	s64 llen;
-	loff_t size;
+	loff_t size, orig_isize;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 	struct buffer_head *di_bh = NULL;
 	handle_t *handle;
@@ -1896,6 +1935,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 		goto out_inode_unlock;
 	}
 
+	orig_isize = i_size_read(inode);
 	switch (sr->l_whence) {
 	case 0: /*SEEK_SET*/
 		break;
@@ -1903,7 +1943,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 		sr->l_start += f_pos;
 		break;
 	case 2: /*SEEK_END*/
-		sr->l_start += i_size_read(inode);
+		sr->l_start += orig_isize;
 		break;
 	default:
 		ret = -EINVAL;
@@ -1957,6 +1997,11 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 	default:
 		ret = -EINVAL;
 	}
+
+	/* zeroout eof blocks in the cluster. */
+	if (!ret && change_size && orig_isize < size)
+		ret = ocfs2_zeroout_partial_cluster(inode, orig_isize,
+					size - orig_isize);
 	up_write(&OCFS2_I(inode)->ip_alloc_sem);
 	if (ret) {
 		mlog_errno(ret);
-- 
2.24.3 (Apple Git-128)

