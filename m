Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A71560CC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 00:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiF2W4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 18:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiF2Wzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:55:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C331540E7A;
        Wed, 29 Jun 2022 15:55:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TM4BJX014124;
        Wed, 29 Jun 2022 22:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=bu6Kg8V6EURiP43d9/pn7l+bO/MiGGXeBd3HJz6VVj8=;
 b=D3/4oE1ECUbV+38oNcl25j+PmHel0RLAtMJLl542NeziuvLC3X8vtq263kX2AOVXTHkf
 DHjc6+HFDReojXyQC72NXEPjw5UbXZBQ4LtK+JjTPLvAMva1mwzIceUOf1LB6qzWXMS5
 DTlCRbAYgo+Yf+DHzx+fbO1uhTBV+PcF/WoAaAdVH+tGslDmGWcvLc0B2LcbvIqVjO0O
 3c5o52CiRcMu3r9+dr0waoT0PFiLMYY61jvQErvuZdFDrU7j+IA9fIFlXfc4CT5GynMJ
 Rhh6ZZ1stndSuaeQ1AF7/xE4t54J6sPOxt/R2geXbnkn6RwV9gtBzZo8jJyFAQpUeFzI bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsysjgue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TMf8oU003611;
        Wed, 29 Jun 2022 22:54:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt98nsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKwXqWZiZpZKbJ370CH/kqhj+/3jey5EtrdJfrFSTKM+fACjbD31ZU776Mb/mMZ3/GNkFv3bq8ZdFXou3CqmkwnaSIx+U7i++gYYnGqz/crS0bxeBxj/Y4lAy59wtTIxTUjySctaOlHsqVeweQqgYtGogtCJhU9CfCTiPFxdK6v8PRPP5qB59nwDCoIxO0lJce4D0i8fj6kCJTGgt/tBSvP3r/syis6w14gv4n7Eq0TsDkynFZxQRd4iBFWCuGDa8Ja1m5l8YxmTNrvDt99GXiyrz6AxuazViFrvsIS2N4xjds0Q4Evdpzhvb2wExkKhtRNu1mi+SQFyIwdZ1IHi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu6Kg8V6EURiP43d9/pn7l+bO/MiGGXeBd3HJz6VVj8=;
 b=XvuUy4i692zqDxNtpVl9tXde9R+yqJOnu3Zof2oXjADhMJ72MNcUXZ87GFvVSx/7qznZeH3iOxV970p/Oh66CCZrAiLT78ZqYHvV1Kn4tJPMw3b5SSCvZDI1dIzRWHl3AtioBPfR61F+bpum0aSGsXLzIZkLdE9kw5GyqdTzaptYMKrs1Hnm3HLoP0j3IQ+snQJJFiB2GyTSXXHKSM/f9DhTjCBjp3qA02kgf8uCMXqxRpHbkMHb7cRm5/apsHTFXZ+V6DVGuN9OmxGY9p/Bp7NZA/aub7PNsH1z7AQFoDwK9Fu12vlHOrsJhtAT75JLgEZov7NiUEflVKxG4BI7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu6Kg8V6EURiP43d9/pn7l+bO/MiGGXeBd3HJz6VVj8=;
 b=wjQIutiE6xIYA5qB7y1slmX77AVTExZOSOowTTHxvv5N8DEuaAdxORSmo7Mg8xOKVjuVBovpQFz3mRahzI9k+Ap1pHX3XIUA3usg8fxZ+0UU7hx8M0NQ3fec6NYujIN8uFvFTUfoX6e2QR09aYI8YHyrbA74ZF9l9Om0QzDNbf0=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1834.namprd10.prod.outlook.com (2603:10b6:3:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:54:24 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 22:54:24 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: [PATCH v2 4/9] mm/mshare: Add a read operation for msharefs files
Date:   Wed, 29 Jun 2022 16:53:55 -0600
Message-Id: <05649b455e2191642e85cc5522ef39ad49fdeca3.1656531090.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1656531090.git.khalid.aziz@oracle.com>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::6) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcbe23e5-7238-42f1-45d4-08da5a225003
X-MS-TrafficTypeDiagnostic: DM5PR10MB1834:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBMZGCd+K87z5P82rBeTvjdKzQmPVb6EGxZKAktrda2E1pBCVVykrTsEm1BjqY73i4xb0T7JySkF9PQyqFTDVjHoG4J+/xFurwBv/YNXs1LcQeqZkVdH1CU0NbAnWcpgsTVuUhr5opIjPJoEGOBqCYN9a0joziJDdzq5kqoAzxVzDtHi9dDGTJ6N1FmPcwBeRhHy7tGW2FqsONdmoSBplmykJIhZMp1l8SiqgvY9la3NcSTCp9pKKwAexYaQxADRauRkxxlA1rI4GNwuo5fbdKX+ZT2wAou/VQ1WHBVkO9QmgpT0S+C8Ji1K5AOBzQrCkhl7IDH6GTT3MUDpFHcDcTXYn+YASltk+m6GI+w77QIA1usAM3tvHgg3AKc0wNHzmSVammQ57OHokVRtYDkz6SUaCT8LmctP0mSpVdYgTr9vmXwpBYvufVjLZRej54WR4BrP7Klc8DOyuCxU4WHU5pLaZSM+m/NEPEckJ5AJZOOB2dt4BqJJsajz0WGNt/tprLZs657WbyD3AeQnbZag1yLWc3SfI69bWeiaKvWcpWR+45L6XEgPSbI/wAQ5VqiRf+Csy7p1gqIoiki7Zu1RdyP1lLeespRe8MoLBBdzkV5cnO0NVeUHbFVOBxCv2Sgys/d5ixw8QywaMuaE8jR0PeUI39LDhjJ99wLudNxxVsrQkh3WVXxA/E02nFbXx0YCgpBlLDMYQC0DHiA2+ntpYc2sKgNE8n9k/065frkpBQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(6666004)(52116002)(41300700001)(186003)(6506007)(8676002)(66556008)(2616005)(6512007)(66476007)(38100700002)(83380400001)(44832011)(7416002)(8936002)(316002)(36756003)(2906002)(86362001)(66946007)(6486002)(5660300002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ArbjledstvDtFehzXPhh1DPhMbcACud7ChR6p3vfIWCgqA79YIsiAOsWANBf?=
 =?us-ascii?Q?os/XNzuTOx3rGS/ZCRrjybjrGIcRj+RXHwKDeFHaFcz5N1VV0VffQyDUKesf?=
 =?us-ascii?Q?r7vFJF1afLvdKBLOe7JV/XWWwo2aB609TmuggZKbCeZt1ZSivoeRlB43N4nC?=
 =?us-ascii?Q?jRV2uLr5VV+lAeFcO9ZW9qMIIC3lXpoqly1+sJ+d5fsY0UkWdkSlmqlyu6Ms?=
 =?us-ascii?Q?/9sqRrYPUakQGasksARcCjLxmgm0BYUx6sba+TTnPF5zbOt3sPFylr43a/Gb?=
 =?us-ascii?Q?22LxeA8iLUCZFATsRVzx4rL+l4n/wy/oNwK+DnFNvp0uV4CtqT03K7hjDhh2?=
 =?us-ascii?Q?60tiKyw5rn6WnsAxeDv9OnCMY6zSEJceUVVq8lFquClQtCmhVNRXGb30BXCY?=
 =?us-ascii?Q?wfK5peTy0PvrCLtMF9gVE2wTEltJVoFr8Kn+858h+lVv6vdIg2F/bMjvlpij?=
 =?us-ascii?Q?PqvGxGXVsFh94cfNlINriiGgVd/wsUvztefQTnrMMYCoNdEduIK/8Qg+v368?=
 =?us-ascii?Q?H9atrbgky0k7cGDWU7Rpd0DVeKc1He9zTMeB0/S2Sd1UodUb2CJokvcfqkHr?=
 =?us-ascii?Q?m62SJOdom5n5Z1EUIxEgek5i6j6IC2CwYxY7hwRqSJl690+srnPfSHi86BCm?=
 =?us-ascii?Q?l4/D5/wc0RRIVj2sVFYJs665Puu9vbgpIDe2rmfjTekXnOhtu92Xmn1QPzi/?=
 =?us-ascii?Q?Qq1yms0WNafDp9nyn/kXaHMatpv3GnMNAgfL57o/m4mpsH1ScpKnihPQ20y9?=
 =?us-ascii?Q?NgC2puU7svz92HT6qOUrN3zR4KMXWmbV/R9/i7VyGPw7BEYo49qF3MTbGmWB?=
 =?us-ascii?Q?plJdVcrWREoHOpPutu4gA9R0BZO7ZHLOPc3Q0zX7BNTikSOP8+Z6sRuZC7H0?=
 =?us-ascii?Q?Uh9w7QbtoHxQR/4KMIyrkgHCVc8wdcMHzksFxnt9N9+JIyauVN96TSeLxsjA?=
 =?us-ascii?Q?9H/tssams01o66e4xdhtM2j2DGvj3URXnt9Z2yx/P17lcDF9cAwwVy+gxqKi?=
 =?us-ascii?Q?FsM4Fl5Y2rNP+2/J7d7o95cckmwyvPnb0tFfK6Voan9syxQ0UFmvIekka9mZ?=
 =?us-ascii?Q?lXOvdDeoK240Qdjrl8O9Q6zJh6cZaYptDy009CcA5Wdo8Zp62aJJ6rQqnblc?=
 =?us-ascii?Q?zLw23OlQHOf0bfd2z2v/1a94XWknLEgzepi/CHp722rretbtk9Vty1aLSJkM?=
 =?us-ascii?Q?DNwtxPku8kL2gySP3IempCYgkZNKFwBxUhOzIPU91IubSBlSiZg13XYw0R4H?=
 =?us-ascii?Q?kfOzUoGIsojtkmvn0fuJYvj/29kzEFGa0HSI133SewqTySjS9z8vX6oPMS6g?=
 =?us-ascii?Q?PxyF3bIjcqQ2rfAohIVUTBHcLco+6UUulmKecc7YFop7FtPnNGycVOpGLC7A?=
 =?us-ascii?Q?ONN2wQeCKzlH3x483gPYtja//Dw2oDP8dHsvOFjRBCNdjHDthKfTdSsJZv0S?=
 =?us-ascii?Q?AgiM4x/TGZD38LCrkA2N2La+TLDiCGKqW16vCaaQPRxdhCAJLjMn8o1XkjP9?=
 =?us-ascii?Q?p0Jb0Tn0ZujnSYV4Vy/qyaPruTQbkCjfYkR6bSvD6cKzHDFEWy5J29fXiYog?=
 =?us-ascii?Q?0n5Mgo7PlHpsAXyQhEklTKoexCI0PNG9ZqPVat1C8ISbWdbGmOhqL68gSqlp?=
 =?us-ascii?Q?pIINKoAqoFxso4ch9efh8FUCwcvrYEOAa7eNxF6oRUmh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbe23e5-7238-42f1-45d4-08da5a225003
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:54:24.6782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwa8HiflhXN1KEHupPOMSacFWcbUa4rbemKDZTEbY4PGl5AIQ8hrx0CFiFnpLRcQY/wDYZ04zeHNl7K2hew2fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1834
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290078
X-Proofpoint-ORIG-GUID: HCWQgYS3MvfQ3Qyt-YqwE_W-PqeTDxR3
X-Proofpoint-GUID: HCWQgYS3MvfQ3Qyt-YqwE_W-PqeTDxR3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a new file is created under msharefs, allocate a new mm_struct
that will hold the VMAs for mshare region. Also allocate structure
to defines the mshare region and add a read operation to the file
that returns this information about the mshare region. Currently
this information is returned as a struct:

struct mshare_info {
	unsigned long start;
	unsigned long size;
};

This gives the start address for mshare region and its size.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 include/uapi/linux/mman.h |  5 +++
 mm/mshare.c               | 64 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index f55bc680b5b0..56fe446e24b1 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -41,4 +41,9 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
 
+struct mshare_info {
+	unsigned long start;
+	unsigned long size;
+};
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/mm/mshare.c b/mm/mshare.c
index 2d5924d39221..d238b68b0576 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -22,8 +22,14 @@
 #include <uapi/linux/magic.h>
 #include <uapi/linux/limits.h>
 #include <uapi/linux/mman.h>
+#include <linux/sched/mm.h>
 
 static struct super_block *msharefs_sb;
+struct mshare_data {
+	struct mm_struct *mm;
+	refcount_t refcnt;
+	struct mshare_info *minfo;
+};
 
 static const struct inode_operations msharefs_dir_inode_ops;
 static const struct inode_operations msharefs_file_inode_ops;
@@ -34,8 +40,29 @@ msharefs_open(struct inode *inode, struct file *file)
 	return simple_open(inode, file);
 }
 
+static ssize_t
+msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
+{
+	struct mshare_data *info = iocb->ki_filp->private_data;
+	size_t ret;
+	struct mshare_info m_info;
+
+	if (info->minfo != NULL) {
+		m_info.start = info->minfo->start;
+		m_info.size = info->minfo->size;
+	} else {
+		m_info.start = 0;
+		m_info.size = 0;
+	}
+	ret = copy_to_iter(&m_info, sizeof(m_info), iov);
+	if (!ret)
+		return -EFAULT;
+	return ret;
+}
+
 static const struct file_operations msharefs_file_operations = {
 	.open		= msharefs_open,
+	.read_iter	= msharefs_read,
 	.llseek		= no_llseek,
 };
 
@@ -73,12 +100,43 @@ static struct dentry
 	return ERR_PTR(-ENOMEM);
 }
 
+static int
+msharefs_fill_mm(struct inode *inode)
+{
+	struct mm_struct *mm;
+	struct mshare_data *info = NULL;
+	int retval = 0;
+
+	mm = mm_alloc();
+	if (!mm) {
+		retval = -ENOMEM;
+		goto err_free;
+	}
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		retval = -ENOMEM;
+		goto err_free;
+	}
+	info->mm = mm;
+	info->minfo = NULL;
+	refcount_set(&info->refcnt, 1);
+	inode->i_private = info;
+
+	return 0;
+
+err_free:
+	if (mm)
+		mmput(mm);
+	kfree(info);
+	return retval;
+}
+
 static struct inode
 *msharefs_get_inode(struct super_block *sb, const struct inode *dir,
 			umode_t mode)
 {
 	struct inode *inode = new_inode(sb);
-
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode_init_owner(&init_user_ns, inode, dir, mode);
@@ -89,6 +147,10 @@ static struct inode
 		case S_IFREG:
 			inode->i_op = &msharefs_file_inode_ops;
 			inode->i_fop = &msharefs_file_operations;
+			if (msharefs_fill_mm(inode) != 0) {
+				discard_new_inode(inode);
+				inode = ERR_PTR(-ENOMEM);
+			}
 			break;
 		case S_IFDIR:
 			inode->i_op = &msharefs_dir_inode_ops;
-- 
2.32.0

