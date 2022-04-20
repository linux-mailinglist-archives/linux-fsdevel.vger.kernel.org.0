Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA2C507EA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358867AbiDTCIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358831AbiDTCIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:08:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C124011A24;
        Tue, 19 Apr 2022 19:05:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K1sp8K011972;
        Wed, 20 Apr 2022 02:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HxDuJ0/97JC2Vs/ddL0Wm6G+2GrhMusSSHuhGZHvn6o=;
 b=NnMatPT3uIb9QAJ6H3UOv9ZE1IRSeh2jC3BkLKhLI+vxTYOuoonq/varzf1QA+Qs1qYc
 EG0Y4XaDMwIexVgjcTYzSWqPGcil0BnlS3z35Jy7kg2Y1Odos9K1qdZAH75VJJ/PNMMl
 On2wt63Uj9/f9y1cmcgHT3HzYLI9kw9N1KWDojHgL9STG59As/mdZFb1O1p+P/zbbYF9
 u4iXU2RmuycbRCCSoKWtYe8Ay8KybJN+OKui7xKwGSy9UWwCfqzJABtnfvIavSwoYsia
 /nC9P8UtedhJ3E0DMJdwjQ35O+5pKj1gBfNqM9kKyE9YI9r6PZsrOgNUgdsiQWh6LkdD 4g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbv7qjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K20kEJ027909;
        Wed, 20 Apr 2022 02:05:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8960xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqEJOL1Pu7krdRXZbnG32M6mX4I1zzfHM1//fJ4aX6spFw6FarxbYuyWNHWNB/2SyO+AfDviRt6JaIQ5ypiKkxm0jpTK/5kFJkc4gEjBlLHT9UENzT1OUo0sn15U3CMCSaqC3gXisqtqIxnLdGqkJSajC/7uplDi1WVJIv93oaWmAjdTCIgyy4f7v5xNA+M8cy9EOTiCfIHJ3vtieIBuB45l/aXoQdhTCutQuB3DeLeMdSreJWeOSHD6Y9kAn0xQ+411sAjGEWc2+PX0a2Pxb9lZmlOe0YfurKs91zya/CTjuOibfbIhy8cadonXQngXYp0OPL8y4fjG9anpYKOo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxDuJ0/97JC2Vs/ddL0Wm6G+2GrhMusSSHuhGZHvn6o=;
 b=XkfzUZfPbm+ohEkjCA5yWg2zsn0iW32mI9OxAJ4uFqmdN0ojG2egSPZMm9RMxIzAIMQoTc/D+lf1tX6t1GCuelypBt0E3X+7fyCmyo9tZTjEGlhDo8eBDxVJjCXLDlmf5ameZPi+Ume07Iak7O/xe9oXGoul8m0Di7YGxf7kQdiXIJGb6WGF5lt4PvwsVvzpQSOdXNZOme+jGaGitk3dF/8iws3c3V2HcMEVdIZfX2zER5EsU5KpJUXANwD07nMnjQrh+c/MXMLC72OcnHPSH9ioPhsFDSPjKYu4ee6a74wCNR6GebHLQmrjF7K2JJ7HRAmYmbIsGlkI1msxxKtFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxDuJ0/97JC2Vs/ddL0Wm6G+2GrhMusSSHuhGZHvn6o=;
 b=ftdE5NA2nFuU/I21hTapbsBv07geKNDdYDAqPKZjr2FDV5shfJ6DvaX8IIh7RxGlrbJddWXwQO1uR7kVPRKyYH2enrG6aL4GqvOB19hOYLoLAVjrlB5T7S62TSeYCuCMYHBOKifWT5M/5iNP05/YvxUAWJsPMpo9mOvJpaPfbek=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MWHPR10MB1422.namprd10.prod.outlook.com (2603:10b6:300:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 02:05:20 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 02:05:20 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v8 7/7] pmem: implement pmem_recovery_write()
Date:   Tue, 19 Apr 2022 20:04:35 -0600
Message-Id: <20220420020435.90326-8-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220420020435.90326-1-jane.chu@oracle.com>
References: <20220420020435.90326-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0112.namprd12.prod.outlook.com
 (2603:10b6:802:21::47) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a8ff09f-5721-4c81-de0f-08da227238f0
X-MS-TrafficTypeDiagnostic: MWHPR10MB1422:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1422AF653C5ABCA773FDA0B8F3F59@MWHPR10MB1422.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Bp8GRFDDkmwJdPIsVMpm9oyviC+1gPWmVhIICQ32GReuYtHSOKjJ6sXSRHxAhMHj0DUCSOhYs4bCf09/ok1QpzRkwPTksiTSYcViAdjyORQ56IxdJG73HslxX/xeHrRpLnNIZwsjCVHbSegzdPuTYqE3SdFgbp6GD2aZ+b2hl/fOmH9C3OxCpWxB9PCL9sbb6W2sX8YcPf5LzZ7ODmVrNMYr3pnEs1HcDHNfCRq8q/dXYijpmZOmbcWnKrQ85lH9ZMF4EgB0P/kvgwhH029w8noTubr4TWFdh/CZ07ZCCUtKRQgscYjMLhwdzJLOuLgG/gauABPSbp26PL/HmmG28OndxGAs3as3yEbQ00V4aB3JAPAR6fc07Wb/Ge9cLVDHhkUojTkMQjDyd4xaSuv4O/nK8RBfK1MXv2UpizffeqivMfpV6xVCHzaknTl/l7hiKHlVAgB7grYqDEngTdg0lRJYhmZFtqviTt+MjwgXZbH6d1cT/kitfeP5Rw6u1yrvQYKEgGLl95SbIXO4V6KYbW/s6QzoM0sjHeXlUoZbzqfmOGPfyRnXkN4yY+J9Oyfl+bqi7WiYbfHnfaBT0bJWJHhd63NRIHH6T1C3iFFCibBJ7kGlNwbVR6Sm1ZNhMLkrwJnKF9MPpDgrKus75SeVbfLi7Tt2LdbeZdzANGMtDlKzKfmUX/3NeeMNGO79wet
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(83380400001)(2616005)(66946007)(316002)(38100700002)(186003)(36756003)(921005)(66476007)(4326008)(66556008)(8936002)(2906002)(44832011)(5660300002)(7416002)(6666004)(52116002)(6506007)(6512007)(508600001)(8676002)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F8y3rS6mAWcLVToI9gl4i1tz1kVvBplaVmGOH1ntHI50G0bBTpsOEDPnk1kL?=
 =?us-ascii?Q?QdwWLWwwLR0pNL9RTIBuaFJBlLDquYm9nH8n0qZt1Yaztxb7BpUIw3Vw4GID?=
 =?us-ascii?Q?ncU/XaI8jh553XrcQ1awssRHpfcjCfXPnvCRqxSEIPEekI+YmrrjnNMBAgyG?=
 =?us-ascii?Q?4E+0Lf/7Vfy+xHeXylDRsRs4nlHi5Cnpy4GaKX4+3TwldRtdrIgE3Bg0xUJd?=
 =?us-ascii?Q?bUALwORNkBIKgD/Qn7JJgR5PUS+BW6DL7uZDWcEZEjhPJaZS4ytVYQW4rMQ1?=
 =?us-ascii?Q?klagbGpcuYtxjiJAhbJFoJ6KR2ZfC9Brg8WQWA8Aw86tS4r3fZnLtcvG5fmD?=
 =?us-ascii?Q?b7sWGRyfAl/Muyty+DvTeQEvI8HoMKcH7Ai9WD9GKnS5uxDaJ2fZldGiJusl?=
 =?us-ascii?Q?1npH0s7CShtHlovXzarRx9TaA3pJs/yZBQX9/ICW2nTo9y6sBPoH2uageI01?=
 =?us-ascii?Q?Qh3Zt3ibChOFYuRox/LdB3RZtueZIuK+SxcPvuxCFzpKyclgflc4bMvKtCfX?=
 =?us-ascii?Q?0qknGV4yY3wH5HViY4wAsiLBEeOPQxZydnoUHXjKfaNywxA+FHCz8WQe8r9D?=
 =?us-ascii?Q?HKU+CXAdaM632YqZ+s0cvoRWWu+EotsuMCfRXvjKyxkQdDd7pb8+V9JTc58O?=
 =?us-ascii?Q?2mo8jaKigCq+N+kKsXRYhNPgQtJ3M55/fWZFDZGBEV+43n4M/iGKZz3aJzY2?=
 =?us-ascii?Q?BuzExIJJWpbfxC4Bs97aODuUv9Pxtm7eFv1BZe8E8/O7Mgc2hTRVA+vEEW/O?=
 =?us-ascii?Q?mfSLgvCgZ7iE3jAaSQha5br8RFJNf6exyj+oFYTT/Uh4Av91D5KtWjdzLwwX?=
 =?us-ascii?Q?6q1eSg0VaXrH00u1BTAJKGXTgwhH43F5HyaI61DmwWW2foHJlPZVZQeCA6s1?=
 =?us-ascii?Q?cnnOwaGtL3j0ps87svUspzYGOXVx1LA6FCA9sLyydyGr7pW410lKMEDIBYP6?=
 =?us-ascii?Q?V1jL+nREODMkr57425s8QhWxCE4I5jBX011qTkuFtj4pezm3MELJ/dJXkLeK?=
 =?us-ascii?Q?eAeBbAisxpxrxV2akV66j1GCHZiFObOmdcjIBxmqF9omXoK9vYBhSWx9d6Jr?=
 =?us-ascii?Q?WkdGbGb74Ux9KLx+Ve165mh30hpqKtgGRsVpJ+fizSgnKM10DjbGPq4vJYC8?=
 =?us-ascii?Q?E+N/lSZqn70JUQKF6fCQZfyEpfhTCH+/ZjzMIroCINNOmCdDPMdquSxtW5NB?=
 =?us-ascii?Q?y/XQgJ4Jj0d3jaCQeEQo36URmDn5woSFjOTiAWwNK8FtIvwUA01HPuWZtHZ2?=
 =?us-ascii?Q?BmK9L5jblCWX3l3MjTG9UjFynEpdGJdYEGWRGA0jYCqpbK/aNpZ2Y6aVwhGv?=
 =?us-ascii?Q?HqrEaBu8QvOrv9wyhVlNYLJHo0wE/rs24iP6WhoA91FVYFO4nH6cCt1q/kKQ?=
 =?us-ascii?Q?ekAMQAgQj/jG8bSC2gncZ8zHBxDqROq5hO7gP8z4hYCXx2nDsWkCwFXwLQrg?=
 =?us-ascii?Q?fD/DKs/v90ycWYGQvfFkhZ1VqBfjTBZUIh4l3HejVCGajStQvCZ5Gf2o4RBG?=
 =?us-ascii?Q?lQ+kXOwun1osNbCDtg2WkMuOm9BYszHZPqsEBeCtgbIc0Sllko7d9e/cgQru?=
 =?us-ascii?Q?Dr9lJMvYzsDaEfRdSEeUVsWWDMmCOPnACg/FoedyC6een5c01j/t489LTv9f?=
 =?us-ascii?Q?QTXwzF8Aho6cUxVWFmt4NTZX+J5Y+ZAiDDpHoLQP+jiAms/UM2KNe5PebZEL?=
 =?us-ascii?Q?OXDfzo+3UvGV5OVD/4E7se0fm6I5lf5RQu2xI4hCnDf9Vi7en+bLTh1AyX5g?=
 =?us-ascii?Q?xBmgr5K8aSySPqVu3mcZtDRz721W4go=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8ff09f-5721-4c81-de0f-08da227238f0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 02:05:20.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vk9EpuLdgN4bWLsNNVK/vEdhD/OJkQ3/SZ/OhpSNWgAs3D1UmEN800LiKLi3lI0o2M4ZXTesz/ZzgigsRkKR4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1422
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200008
X-Proofpoint-GUID: zanx5o3i1mGmIddukr5ohjpRAcYjKz8S
X-Proofpoint-ORIG-GUID: zanx5o3i1mGmIddukr5ohjpRAcYjKz8S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The recovery write thread started out as a normal pwrite thread and
when the filesystem was told about potential media error in the
range, filesystem turns the normal pwrite to a dax_recovery_write.

The recovery write consists of clearing media poison, clearing page
HWPoison bit, reenable page-wide read-write permission, flush the
caches and finally write.  A competing pread thread will be held
off during the recovery process since data read back might not be
valid, and this is achieved by clearing the badblock records after
the recovery write is complete. Competing recovery write threads
are serialized by pmem device level .recovery_lock.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c | 56 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvdimm/pmem.h |  1 +
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index c3772304d417..134f8909eb65 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -332,10 +332,63 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
 	return __pmem_direct_access(pmem, pgoff, nr_pages, mode, kaddr, pfn);
 }
 
+/*
+ * The recovery write thread started out as a normal pwrite thread and
+ * when the filesystem was told about potential media error in the
+ * range, filesystem turns the normal pwrite to a dax_recovery_write.
+ *
+ * The recovery write consists of clearing media poison, clearing page
+ * HWPoison bit, reenable page-wide read-write permission, flush the
+ * caches and finally write.  A competing pread thread will be held
+ * off during the recovery process since data read back might not be
+ * valid, and this is achieved by clearing the badblock records after
+ * the recovery write is complete. Competing recovery write threads
+ * are serialized by pmem device level .recovery_lock.
+ */
 static size_t pmem_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i)
 {
-	return 0;
+	struct pmem_device *pmem = dax_get_private(dax_dev);
+	size_t olen, len, off;
+	phys_addr_t pmem_off;
+	struct device *dev = pmem->bb.dev;
+	long cleared;
+
+	off = offset_in_page(addr);
+	len = PFN_PHYS(PFN_UP(off + bytes));
+	if (!is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) >> SECTOR_SHIFT, len))
+		return _copy_from_iter_flushcache(addr, bytes, i);
+
+	/*
+	 * Not page-aligned range cannot be recovered. This should not
+	 * happen unless something else went wrong.
+	 */
+	if (off || !PAGE_ALIGNED(bytes)) {
+		dev_warn(dev, "Found poison, but addr(%p) or bytes(%#lx) not page aligned\n",
+			addr, bytes);
+		return 0;
+	}
+
+	mutex_lock(&pmem->recovery_lock);
+	pmem_off = PFN_PHYS(pgoff) + pmem->data_offset;
+	cleared = __pmem_clear_poison(pmem, pmem_off, len);
+	if (cleared > 0 && cleared < len) {
+		dev_warn(dev, "poison cleared only %ld out of %lu bytes\n",
+			cleared, len);
+		mutex_unlock(&pmem->recovery_lock);
+		return 0;
+	}
+	if (cleared < 0) {
+		dev_warn(dev, "poison clear failed: %ld\n", cleared);
+		mutex_unlock(&pmem->recovery_lock);
+		return 0;
+	}
+
+	olen = _copy_from_iter_flushcache(addr, bytes, i);
+	pmem_clear_bb(pmem, to_sect(pmem, pmem_off), cleared >> SECTOR_SHIFT);
+
+	mutex_unlock(&pmem->recovery_lock);
+	return olen;
 }
 
 static const struct dax_operations pmem_dax_ops = {
@@ -525,6 +578,7 @@ static int pmem_attach_disk(struct device *dev,
 	if (rc)
 		goto out_cleanup_dax;
 	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
+	mutex_init(&pmem->recovery_lock);
 	pmem->dax_dev = dax_dev;
 
 	rc = device_add_disk(dev, disk, pmem_attribute_groups);
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 392b0b38acb9..91e40f5e3c0e 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -27,6 +27,7 @@ struct pmem_device {
 	struct dax_device	*dax_dev;
 	struct gendisk		*disk;
 	struct dev_pagemap	pgmap;
+	struct mutex		recovery_lock;
 };
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-- 
2.18.4

