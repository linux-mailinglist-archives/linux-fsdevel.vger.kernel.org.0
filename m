Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7822050C519
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiDVXSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 19:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiDVXQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:16:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D443B174A31;
        Fri, 22 Apr 2022 15:46:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MKCxRk009531;
        Fri, 22 Apr 2022 22:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=euu/6zi3HJi+so0p84tl62liECR+yv7a3vF73FxYsBM=;
 b=q8HXBrJbjIr168CrxVZKWKA+g7ObxPmoryyKmPbK4WArSdfZTb5OUsMjKqN8lLpSh0k4
 G5WQGWpyPjjbLR1a4rq0EqtRGgouRoF1j3NVlo2nlMjzZfkc8Hnk7K9WJTw7/8akDh3z
 2UV0FAdXum8SakfFGGqd7kqHvja0iGg1zABhP0aP8QuFz0yU9hDZoO3eadoCG0P3NeVB
 NgGqOszhp2P+lfgHp06PVCRUadIlj9UlMJass0WDOfouSGYp6saic7cUJy15Y8NrnPZS
 12bcNMeL20fKNGqQDBsg6Q/NSS40u2R61TNw+8EKtLxeNiO3GmGlxVUQnurYqtDOBtfu RQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2yvfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:46:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MMg0fU008607;
        Fri, 22 Apr 2022 22:46:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8e9nby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:46:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEIpVrxCoefF+0YH068vTqGJImqD5xd/z5LRpFO1SDXaWrFwx/6UzxQmUg79VVPLLClCGCuiUIqeitE7dokaVK8eUR43vhzLKLqF/TOffyjqWCVjMKhnAih9Kx6/fWTtKgc9Ww1PZhvFecLRzzRUUz1zL8zSeQJMPJUBEiivmSSXwk9HLlhSUBGXa+XjzZOml9VNjzwPr8QF9/ecGwCd/XeltD58VymhB5oyKCkY5WfhwLbCpQ6sKxhmABsHqm6Sj4U2LykU99fSM18cxlENKPkAffQQF3UCkEXs9z3/0gxi9Xq3MLw2gW+LBMDWx37rFPhO7gf0NL84k5mcmpwFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euu/6zi3HJi+so0p84tl62liECR+yv7a3vF73FxYsBM=;
 b=WPuVjFeyPYuEyJ8rZ/AU1dwCZOf1dZYAA5n/CtBRYwyuiHrDSKtlUKkU/E8rxxRBTtiQhFkz3ugkt8NFK5Yfp8vVVSdm+BphR1aIWZo/IERbGBM+Mdw/1B7fh4pfJkhIdwXmMZ+pA9f4Kz7TSFbDUqtCwryV5hHdhn1tjghFqMBV1piun4Etz+A5lfsIMVrb85kGcFNncfYRbaTo+eVTWAzsqulro8C6IzPnv8sXh2qjelJPZAvVfPKdCCpWnlgdBqf1pEycYUcmAGGD5BUnYUeD3W9rzOs3LtIx8y/1J8Mpb+5FoBm30dNsU7EhFnnONk9rnq/QIJqkfDHIsMDpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euu/6zi3HJi+so0p84tl62liECR+yv7a3vF73FxYsBM=;
 b=yj9T1BQpiCP+LI0cy2ZnyaXPNZh/eYuE1Pq09WhcCweApGTuXUuk6gVMKVFvs1MPvmR1OXRyAwoBeN5ynIOmOV8IPg3Xo1YtSq5BMZarpcXQSzNztNcwDBq8Kr+NKS8iwgxFxcMWvGc+GPj1w9qz39u8Yd/vAbJjEF6r99R+4fE=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2550.namprd10.prod.outlook.com (2603:10b6:a02:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 22:46:20 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 22:46:20 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v9 6/7] pmem: refactor pmem_clear_poison()
Date:   Fri, 22 Apr 2022 16:45:07 -0600
Message-Id: <20220422224508.440670-7-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220422224508.440670-1-jane.chu@oracle.com>
References: <20220422224508.440670-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:802:20::28) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69c9a4c8-6450-44ec-1462-08da24b1eb58
X-MS-TrafficTypeDiagnostic: BYAPR10MB2550:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2550432949E7B64B765942B2F3F79@BYAPR10MB2550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRfdYfj2xRTdl+0P4S12zNC15GON3VjK3AAyS6cZ2IH1/1oRQdRKLNhEtXisO6EB9lHU1EniKuAM/lXfH51LZ2QaXUf5QopSeqNjbI0FAU+APbXZjOyzSafAIaIgOLG0qU+FZWjIxRXsVo7NEZN5rKgaNzi+pXZ1g7Em+zrFW2oB2ZqPv5C2DnvwTsHAXVToEuc+QMjHTOIUqyEH2GQPPYFZKzycd1hQxjVivKSOKiB3f3ZZwiG+4HDStL71oRJjwVz4vGXsDk5NB+y+bGrQFg29HSK5oxB5HFT87RbqIo6nQw23s0sgtEqmJWYZcQ3jQk9MOhE7vWqdDbyd3j1Kd0TCx0KjNuOBjN4zjPITjertTWiiQJIVzQTFzJW8CLZ4ElXy3mK8O08OAsYtKl0XvIm3ojJ9j4yj0tFgekGXBo18h3JCHIReEwl+unV3FYxmOvBFzK0ghwJ+0ABh7IXvCwpRvE0LUxaReAimLLjhXA20dh02jzOhjQw0oFljeXQhuZwPJgi+6j8T0noh0uHyNzLgjHZ2ER8LU1HGtcbqHmZxR652nmmsJygtJnNfA75+2+nDdkLiYBNwWS6wD1ReKHtIu/XDE1+PW4RQgWYVkOMkbtbJWYIRKSkwHz82QRgVb2CLd/KXCXlCXr7XLmR9oU6Yw7Q9dsh9+52WJIeJLdmM3XHZRKOMpcR5A0J5TcdP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(6486002)(8936002)(508600001)(52116002)(83380400001)(36756003)(316002)(66556008)(66476007)(2906002)(8676002)(4326008)(66946007)(38100700002)(2616005)(86362001)(5660300002)(44832011)(186003)(6512007)(1076003)(7416002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A6gJWyor6kSPBn7cT2M5kU0w9eHXoSTMWdAg+FYu+44RuimmwxKVV7BglxP+?=
 =?us-ascii?Q?DqksY5OLTcZWkoNNLwO5ub/arecoQfNGxOLjbL8Z78wSAg9c+tl2eDGFMj/7?=
 =?us-ascii?Q?dE44yup4qCVMzFBUAk2rR+tHVif44IezDhanVw1aPHzFUjpZlfTFJNsBkB0U?=
 =?us-ascii?Q?OnT9m3r5MMXtp9k3FVcAvbVVehnPXk7AcuI+B8W2Dq5Ch0k1cgt/LmHQrdXq?=
 =?us-ascii?Q?YSEyxX6yAC3ttOyKTNEM4MIL6tqo5D5Y+Xh/MkHAZaTbjZ+LBz62vCgD3OEv?=
 =?us-ascii?Q?v7H4zqEOdcqNXF0Z+FNeJAtAEIbfHUe4vs2Os1qO09buHPhoYR3wzBx+sJpm?=
 =?us-ascii?Q?eVnJhxB3Qx/zadpmIDKH6reMz1WJDO1sTRAk35vtG+Urllcw2Vve91uC0BMJ?=
 =?us-ascii?Q?NkZJE44pWFmQVd+/Sc6wc5KE/VGdh1myoiTMIJAU8DFu1qW15/9tBlwHrrk0?=
 =?us-ascii?Q?wtzDIR8KEhadVidH2E1AQ9haUzpAZVNs9Wug0+5tQRjkTr7eMt4PCJGXERzW?=
 =?us-ascii?Q?PBQskBh/1sRdsy5noZBUBVcBvD7jCkeZwXnHHOezRBn+gkJMyHjzFwNrzvp1?=
 =?us-ascii?Q?F9ND1U7ybhtgwzmi3D0C09kuNrooPZ+BZ4mgrBEXQHJLQXWlTLMtJReTnFO8?=
 =?us-ascii?Q?ZV5xOGPANAzuYJ2zV8cY8OfD2jEBsMT8mL8UZW6RzpNc0hB86n+9xV+xHqV1?=
 =?us-ascii?Q?Ap15vdD3L7wt1alA1946G3BtJ5yKPAL9vQ3aJGOOkA9LiivpwopybJnxiq+1?=
 =?us-ascii?Q?roZMPVb+H2T9tXJO2dHWKOK9LTevPa4uZ9oMhQHtf4Itc/wZaemLZ5pZOjXO?=
 =?us-ascii?Q?+h3D6xI2f1mEL8BjznCOscnxCdmGcDlXuX/QEAFpqskAQr/I8SGSTxmMn10f?=
 =?us-ascii?Q?UYQ8I849dL7bgRCje4mJKO9yDlOpZSgMMNwF7lar9NftYtWXivfeCspj0PKW?=
 =?us-ascii?Q?pU1y++VJZw4LYP6YJ04EqaRIcZcsOwgCk50hIyP5cf5J26zMzVPkRSd88/Pf?=
 =?us-ascii?Q?Mch2x46XS6rR+xU5om0legREeQUT6HZB9ti7L92PUAYwEcFlscGwoOwdgRk8?=
 =?us-ascii?Q?c8eUH3BLc/JNoV9FE+T+j/OR/RZNg26iY3myiN9pNlfKd0fuNPQ+fQCXElax?=
 =?us-ascii?Q?UlkdUobjVGyPZtEvx3wf9ofsGKpaia5btubZQNe+SoNLvHNT9ceV9B0nETTb?=
 =?us-ascii?Q?B+xBPgQ5KPSUdlYwUCibJtFtZfi+chu8rJleirYr71D82esEGMS1v4GwyWpk?=
 =?us-ascii?Q?3b0jyPlP1mC3vMvdGx37Xit2dGCKSaym5+CNMrg5JIeQioUkdltMR+2xHbWA?=
 =?us-ascii?Q?1ieqyWr+kcb74VdHFj/sHotfvQnN4iwLmEgBM2YBd2qe9Pe2NvEEtoEy26Iv?=
 =?us-ascii?Q?YAN4viQlHFPMagf6xB9lgaOROKT8TKEKB6fqGy9K8XArCsiJ7WYzF7kfjbE9?=
 =?us-ascii?Q?cYEuX59DtgsAm4QyN9AgVuniFWaqyZduQYpX+1gcz1motCriKmKTnOZJC7iw?=
 =?us-ascii?Q?LF5t7+lhHYIL7aJ9e6XcDIo1J6bJ47mrQpeFHmfqx2viqE209wNGCx9pAOYV?=
 =?us-ascii?Q?VFPivQxqbAKllLWiDF0fLmTcHDOebLZwxqa/ZPHros3scbVRTu2JCym+933s?=
 =?us-ascii?Q?9Sq6GHVRwUHT4ty7DrLWaE/f35EKTU19OTWDW92/UCu7Kqp0iRR9tabMc0yL?=
 =?us-ascii?Q?YKU6X8szUtqubognnMizpcZn1R4eRDSYAfLG71gPEfZWM232mCLoXtv3vHGp?=
 =?us-ascii?Q?GVoskvs5eesA+QoOcTAYbFOd7sxOMJI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c9a4c8-6450-44ec-1462-08da24b1eb58
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 22:46:20.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLLzXUWY7uu8I5YjPFe7TLVb6c5RuyGr/ccfrGr0lI2tfPt70mgqHRtMrqT1nLYV5IgG7T+LXeElXgtKDnFMhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_07:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204220095
X-Proofpoint-GUID: zT3EP53qVeuwS7X29LISdzp6MV5I4y-H
X-Proofpoint-ORIG-GUID: zT3EP53qVeuwS7X29LISdzp6MV5I4y-H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor the pmem_clear_poison() function such that the common
shared code between the typical write path and the recovery write
path is factored out.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c | 73 ++++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index e5e288135af7..0961625dfa05 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -45,9 +45,25 @@ static struct nd_region *to_region(struct pmem_device *pmem)
 	return to_nd_region(to_dev(pmem)->parent);
 }
 
-static void hwpoison_clear(struct pmem_device *pmem,
-		phys_addr_t phys, unsigned int len)
+static phys_addr_t to_phys(struct pmem_device *pmem, phys_addr_t offset)
 {
+	return pmem->phys_addr + offset;
+}
+
+static sector_t to_sect(struct pmem_device *pmem, phys_addr_t offset)
+{
+	return (offset - pmem->data_offset) >> SECTOR_SHIFT;
+}
+
+static phys_addr_t to_offset(struct pmem_device *pmem, sector_t sector)
+{
+	return (sector << SECTOR_SHIFT) + pmem->data_offset;
+}
+
+static void pmem_mkpage_present(struct pmem_device *pmem, phys_addr_t offset,
+		unsigned int len)
+{
+	phys_addr_t phys = to_phys(pmem, offset);
 	unsigned long pfn_start, pfn_end, pfn;
 
 	/* only pmem in the linear map supports HWPoison */
@@ -69,33 +85,40 @@ static void hwpoison_clear(struct pmem_device *pmem,
 	}
 }
 
-static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
-		phys_addr_t offset, unsigned int len)
+static void pmem_clear_bb(struct pmem_device *pmem, sector_t sector, long blks)
 {
-	struct device *dev = to_dev(pmem);
-	sector_t sector;
-	long cleared;
-	blk_status_t rc = BLK_STS_OK;
+	if (blks == 0)
+		return;
+	badblocks_clear(&pmem->bb, sector, blks);
+	if (pmem->bb_state)
+		sysfs_notify_dirent(pmem->bb_state);
+}
 
-	sector = (offset - pmem->data_offset) / 512;
+static long __pmem_clear_poison(struct pmem_device *pmem,
+		phys_addr_t offset, unsigned int len)
+{
+	phys_addr_t phys = to_phys(pmem, offset);
+	long cleared = nvdimm_clear_poison(to_dev(pmem), phys, len);
 
-	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + offset, len);
-	if (cleared < len)
-		rc = BLK_STS_IOERR;
-	if (cleared > 0 && cleared / 512) {
-		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
-		cleared /= 512;
-		dev_dbg(dev, "%#llx clear %ld sector%s\n",
-				(unsigned long long) sector, cleared,
-				cleared > 1 ? "s" : "");
-		badblocks_clear(&pmem->bb, sector, cleared);
-		if (pmem->bb_state)
-			sysfs_notify_dirent(pmem->bb_state);
+	if (cleared > 0) {
+		pmem_mkpage_present(pmem, offset, cleared);
+		arch_invalidate_pmem(pmem->virt_addr + offset, len);
 	}
+	return cleared;
+}
 
-	arch_invalidate_pmem(pmem->virt_addr + offset, len);
+static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
+		phys_addr_t offset, unsigned int len)
+{
+	long cleared = __pmem_clear_poison(pmem, offset, len);
 
-	return rc;
+	if (cleared < 0)
+		return BLK_STS_IOERR;
+
+	pmem_clear_bb(pmem, to_sect(pmem, offset), cleared >> SECTOR_SHIFT);
+	if (cleared < len)
+		return BLK_STS_IOERR;
+	return BLK_STS_OK;
 }
 
 static void write_pmem(void *pmem_addr, struct page *page,
@@ -143,7 +166,7 @@ static blk_status_t pmem_do_read(struct pmem_device *pmem,
 			sector_t sector, unsigned int len)
 {
 	blk_status_t rc;
-	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
+	phys_addr_t pmem_off = to_offset(pmem, sector);
 	void *pmem_addr = pmem->virt_addr + pmem_off;
 
 	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
@@ -158,7 +181,7 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 			struct page *page, unsigned int page_off,
 			sector_t sector, unsigned int len)
 {
-	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
+	phys_addr_t pmem_off = to_offset(pmem, sector);
 	void *pmem_addr = pmem->virt_addr + pmem_off;
 
 	if (unlikely(is_bad_pmem(&pmem->bb, sector, len))) {
-- 
2.18.4

