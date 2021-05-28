Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB72394824
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 23:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhE1VKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 17:10:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60054 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE1VKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 17:10:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SL0IUO157093;
        Fri, 28 May 2021 21:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=xHwxLDpO0pfhkR2iBQMc6ATfCHVLWrbIrgqq40Sq8Zg=;
 b=JvFFg98FN0k3vLDRVRKLjZEM0hYiZ8ak0quIm/hi5ATMDYw2XfzbzFz4sH0oBQR3iugI
 opxyhEHORpCvF4NBJsCxejbgduX9B/IKSIR3zg7LePEjy0QBAFb8OtjYMSf5orCAOabj
 Cuxi2WnIQTM/9YdMLIYHOMsXr7JZz7yW3DpBGk5r/OCcV7l8B6bJY7hrsdRjSnKvdsL1
 Lel9nqxZWRJDePFXII2GGdyWS6Iipen3UkygHOzRu9b5FwaoCvbqSrqdXtcZweluLPp2
 Van+559DNz6/sz4zioTjN6eEjqjKaCEGvNehtWUBvVSYEUOtVd6tczvvuBgtDdHCKOPr SA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 38rne4bnxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 21:08:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SL6Hue188784;
        Fri, 28 May 2021 21:08:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by aserp3030.oracle.com with ESMTP id 38pr0evxw2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 21:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy7reBpE3zoVGqctQ4llYtIHqHDN0GOCALcVDxJh1ZMMDK+swQ9BprvkVPvfwXmnP5vmaC72nlb+Q3qBW6/shpUe5LHrSOS26PGr/QccstkZEXyK/m5R0oDihX0soVXlhHkanL+7y/zTgCLuTRe3ssgYCb5O33oOJ6S9NgiqziE58PFkfKgRvSZyXG58Om0nTuv3xMUHFeFdBxHQQOudtCzKZ6eydLsiv75IZFnvcY3KLmD0/M0UXnx1Qw+sB7TXirPuKuBYtsh9HhgdRHuNaLB1RvgMefKmVn7bohilLyOJL6T/f6lJzKCRNMIH9PQhMcl7I1dUaVQW1QZDZKjuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHwxLDpO0pfhkR2iBQMc6ATfCHVLWrbIrgqq40Sq8Zg=;
 b=Ler1JcWgJON2NgoNVWU9Eqxr+u3302hSeyglSwl98Ocv1Si5H896uNVYisZbFKto/IUO/mrlaB1Am6pvUdjx5iPlWlQY421n3NflRoT6E1fCNxWGcnlirA/ZpvrDcfixWaVCAnkOwms3vXa0C9nT9hOYzqLJo3zOfB7nKLiv+FQmc32wE2qMTp2uz+EVUgmmpnPJG5FL36CAh6x+ZQFIVSK/g8mpHECZIUXJcvHfmdTeXCkpHAnWhUR8schzgOJGLYbG9X/jHxqNTT2KVpMEXQ+LUbOdCCVqcrK+mIFJ8P86+zIvoHVbNAEP71PvOK6+jowwNBJjfp5Upj+NsL4I5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHwxLDpO0pfhkR2iBQMc6ATfCHVLWrbIrgqq40Sq8Zg=;
 b=c9zP/2sfYp88iRiHtjxczb2RSVVRiswuoU53tjPY/A/634wo8tONKM6gbcYkH5NScgPcvt9HrHbdXcu85DHcxDG91nFFuZtltDXDpyOTd9h6DsktNZW1Syp9QTjjEJl3r8O74pVtYO6dUZ2+dp2G5Zisv6b6YKicpdKmZB7V6M4=
Authentication-Results: oss.oracle.com; dkim=none (message not signed)
 header.d=none;oss.oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SJ0PR10MB4431.namprd10.prod.outlook.com (2603:10b6:a03:2dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 21:08:41 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9%5]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 21:08:41 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     ocfs2-devel@oss.oracle.com
Cc:     joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
        junxiao.bi@oracle.com
Subject: [PATCH V3] ocfs2: fix data corruption by fallocate
Date:   Fri, 28 May 2021 14:06:48 -0700
Message-Id: <20210528210648.9124-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-129-251.vpn.oracle.com (73.231.9.254) by SJ0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:2c0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Fri, 28 May 2021 21:08:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a7a93c-862a-4175-78fc-08d9221cc554
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44317D595EDD416A54B8C78BE8229@SJ0PR10MB4431.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:272;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4USP7psa/lDc/30RWIYTwSuoFttN86xuPzxiovtUNSXJHdEpZveMx6HNpOHmyagH2zp+DLf1P9vreVRB4eyKjAYx2tenxf+MGqUcEmzxlaTohd0X8ijGrm1A3D7Tu4lxpXgYLfqY2pyxYteqAc5Mr0vJYGw6u7z0YuWIgCd14ZFPLsLNCi/H7/YadvLkO8yzMfGVlYfkXpGZ/5EKODyImhYSHtVbBATtcmGBY9oleBpGIfBNGgjNQXEGzQd4hToInFzjiesB2LT0t+EcIDu4HWRsyfymtovd5Ey3yzBSE0zdeDBt1pP3O72pYYgi0DbnNoQI8AfT/K2wL5XSJt5+pRO1jXBMQiTHP0KACpYjlIDldn0+nu2KSmImBpAWtF6KWEFW3OxCdbzn8SHrbdr1+VYFiL1VqfXirC1TZt0ggMHxmQnY6ymeZ0x7qX7J+wbFKYq/bv6MCr6ntYPrNnaV/NAGSAd2onBrLiIR4Fp8QAo8zItAxfa/ehIJAPe27ru+q62GZ3W728MfU9vFxfUjE6bhxKVWIUPbdYkhh+XGcsADgRAmey5zhOb6WJq56A2jmoUC7hT9fik0xUSv201IDj3Ge5mJd9EAmjh9uNjb0yBShpy5fuH4C3nv78ISRAgWpaBOTAKOfJ4cegb4De1txVOr8NuSb3juWU0bJ9cPiWFlzaRoxRwO1EsTejTzmiOkygNz9B/CA0edrBoTGTMU0BCsKNeAqonE80HvPxgbIieAldwlbpBv7nseCkVUrxedYlUo/UTmzMqLwY9q3yQXmSyxv7UEkWFRj13+Hn178GsZ+nr0Tyz7RuTQzWsgaLK4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(376002)(346002)(66476007)(66556008)(1076003)(66946007)(316002)(52116002)(36756003)(107886003)(966005)(5660300002)(7696005)(478600001)(8676002)(956004)(2616005)(38100700002)(2906002)(16526019)(186003)(44832011)(26005)(83380400001)(34206002)(6486002)(4326008)(8936002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bXPoqWVJv8xzLdl68wxYDlcrqI7E+lMIJS387DDkupIQBL2LseiZ/MKn+oOr?=
 =?us-ascii?Q?W+kUsPjsZx3/+sduyxLJTQlVE0Vgk9UcP2yQ9S8zqypkp57vha8lfmBfcf27?=
 =?us-ascii?Q?aZn59Gis2r/Yjr5h7a07PR2iPMMucMbQBECqH63zyMCCooCTaIgTc/O5fv3C?=
 =?us-ascii?Q?0S4MdqRLo62e8l4t2k5udatbnyV5rxnVABV9cwTZLBD02WLqTWq88gNfSSEu?=
 =?us-ascii?Q?3iOFfvm5WoRhTDARtOO0Zi8kPGC2Y2luEXiIwAns2CK/jfAVw7GlAfJqMxen?=
 =?us-ascii?Q?BeiY+XJwyrBnQGhO8QrhxGRqmoh1uKFIcrMV1U8FuW8kIbu9a3pVJ80BIY0N?=
 =?us-ascii?Q?6y0stxr0Oqqhn6gcgQOOLL/OEWr9U92td5y0DdDvpAnYxQMwO8zhoPxZjOp0?=
 =?us-ascii?Q?DcnHnUdBk70SIhdbTg54XGqPHXeowMs9acRlJ0k52IsEZcxh62TRf1vuE8sQ?=
 =?us-ascii?Q?Sv9pVgVUwXsUh5kq4CKuIlU4nm03XX8c8HLBxg8boMNNVE0EeHt8Zb8/NmS8?=
 =?us-ascii?Q?n0FUrgIVz8/CJYOJsE6qoo97xw+VtF/u/9gHWe6vYaX0eFLQ2vI8uPIXAx3Y?=
 =?us-ascii?Q?3LOvSd5apj9DTttlHa78QEur19dJ6Lgkg2aGfNkl2SLRKGpXcXgULoLIba0g?=
 =?us-ascii?Q?qYbY7KcTRCJxmacNc/T1N1j+iEf0gYnwYzgp1DOgOuf0kXRRoNoB0tOHySWo?=
 =?us-ascii?Q?QjY5wndtDjRNB4caKSrjGLg14qjmV677ti4ICjuijPBd0g0eTMq4X9ZSsK2m?=
 =?us-ascii?Q?OXJmRepfvgdiIQ7D0SjN+yYE88aUbOFjRSBirSYSBS9UsB4NJIPW4LuWz1+q?=
 =?us-ascii?Q?mChEyW6tRGywAPsEnSYG87FW2CKF/3plDDWLVOM/QrroE2qRelnrIIuiWo8G?=
 =?us-ascii?Q?zvS+HTE94glsDN7eWAAbd1hPrVQeBKCeR09XyFzTnCfjWw40x25+10ynEf/Z?=
 =?us-ascii?Q?i2RmzbbT2ItH15IO0TSx5NmyBkG7WaIGor822lfh7pq6yicG6mdDe22Ng9w2?=
 =?us-ascii?Q?+sqbaa86Wz0N399yG4/Qu3WpUbvMO4GaPW/ASvxDksuUKoFOTlE6YyTJ3aMK?=
 =?us-ascii?Q?RFlBYZA5IA/cUaB/bBU06YU+f5jEEMMPGfvqbItzFfy8m/SMI/fK/zDTJ3EN?=
 =?us-ascii?Q?JO6NKT9K5E/O7Pezir2kcWTGOCagg4nBYT2c+F98k49LlcCouA8z9cT3Xf3z?=
 =?us-ascii?Q?eC5LauqM1N/vRv5+rgNuh8m++CYYuf59CvSni/LlZDSvoMLnBNmQQA0ws/83?=
 =?us-ascii?Q?f5UiXfQ/0FJR7hAfUn7Q/i8Q2vLoiQj5nZt8IgZeT08h1o9pEVa6WwLY2LA6?=
 =?us-ascii?Q?CRn73Uj0WQxGIvO17/mrT98L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a7a93c-862a-4175-78fc-08d9221cc554
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 21:08:41.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oE7wnJ+/wDAI4vkqRgCo46Nlpw11zgYzOQnwSB+a455YzujD0yorE4MuTXo9NCtckRKDZNMo7hmc8gPnviXSCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4431
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280140
X-Proofpoint-ORIG-GUID: ujP-RCDvc12xgCVHFkEdAhA7OCvyTsNd
X-Proofpoint-GUID: ujP-RCDvc12xgCVHFkEdAhA7OCvyTsNd
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280139
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
v2: https://lore.kernel.org/linux-fsdevel/20210525093034.GB4112@quack2.suse.cz/T/

Cc: <stable@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---

Changes in v3:
- move i_size_write after zeroout done, this can remove duplicated code and kill possible race.

Changes in v2:
- suggested by Jan Kara, using sb_issue_zeroout to zero eof blocks in disk directly.

 fs/ocfs2/file.c | 55 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index f17c3d33fb18..775657943057 100644
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
@@ -1957,6 +1997,14 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 	default:
 		ret = -EINVAL;
 	}
+
+	/* zeroout eof blocks in the cluster. */
+	if (!ret && change_size && orig_isize < size) {
+		ret = ocfs2_zeroout_partial_cluster(inode, orig_isize,
+					size - orig_isize);
+		if (!ret)
+			i_size_write(inode, size);
+	}
 	up_write(&OCFS2_I(inode)->ip_alloc_sem);
 	if (ret) {
 		mlog_errno(ret);
@@ -1973,9 +2021,6 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 		goto out_inode_unlock;
 	}
 
-	if (change_size && i_size_read(inode) < size)
-		i_size_write(inode, size);
-
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	ret = ocfs2_mark_inode_dirty(handle, inode, di_bh);
 	if (ret < 0)
-- 
2.24.3 (Apple Git-128)

