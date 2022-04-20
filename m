Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06186507EA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354862AbiDTCIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358821AbiDTCIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:08:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC4CFD2F;
        Tue, 19 Apr 2022 19:05:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JN1ncb024789;
        Wed, 20 Apr 2022 02:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=j1VqMOjm+o4iwOTbJ0DG3ZmUH9ShXkvOMZ3W8w6MKuM=;
 b=VVzELZKby7kk0mrh+A2IUyEiZ8o6r/9EP9w7U0ec2uW9D6U2EttVpGSVAwzgJJ1ZmCx1
 jPEORHdkxKF8A7eTIiMVIxLogc5/w56HEVpYHjAuMAn6K6bc09cokObG/0uU8Pzdiqkr
 Pn0Y5Pd/3bjzrKmGKOq91Xfrpy4DMhLHZa2bdmSiX6PLg0eytMGRzGc52l6nIh6A6YXo
 YGl1qm6NQ1+dyEMySDxfeJCZVGh4sif2zvEreZm4QC2KjRBjQKyHkfWNYa/jvC6LpT8+
 ym7sZEC7Ib+4ZAMeAw2Eb5SCkuxZkt629zbk5t3bkbvvliPdWjnyYIsiNxaZidiNLmvu jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffnp9ffrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K20Wh3038030;
        Wed, 20 Apr 2022 02:05:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88mv94-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyy818xS7N0xR5iV5LbzkSNa1019XMTXnLR9nHgF9RmDQe/dUQw73++BkunCYlW4eHiHbyXtCr4uq1s+FKwrMN1NSnB0lz8TBig+N39rQmS/4/BXiVEcPPKmeRD8awLw37880IuqnUBimRi7PbLAAr5o9dsxOJTe2NWhyoRz3D0tEEAUyidckhkTBk2lkEF8PGJ5/k7lrsT7CoS3WdGHsPYWIzUE1lNYOXNHnHjt+aG7BVDMhkeVg6rBdPiOa6vuGQVka2FIjIkzJLqe07rf7JCjnRy8PCHmS7FIPuoBbqE4bxTHbUIYOzI2/YDjimfTrAKJ0GLZ29vCZQWClEEQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1VqMOjm+o4iwOTbJ0DG3ZmUH9ShXkvOMZ3W8w6MKuM=;
 b=BCSQXiV/sPHyDW2681bOBFVR6SkjpNkvpXniRSr1qYb3c8BBh78eilnDzb8mNQ0DQ8sGkr2bx0KufZ03R5wqQNWtD/tt31E/es0ddmX5VMglzBeD1MRM9Snd0hNQwggZXYzET7TxE9+tA1CVPjJS2Jrz6th8B8rVo5w/dl7ZxOjcKZJWcr6JKteehh997W98ReWwInUUSnKlJkQy2MsU3Ox0/QuAApL117jdOj9NhTZGAh1V454LKybagTsyBhjgfDilXGBotwZh2Jo2YEh2tctmZUhiF2uSyOroBqie+Mt8axZN2eV4yqEU/BC4+sYaM0tordVOb5M+InHEta4kVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1VqMOjm+o4iwOTbJ0DG3ZmUH9ShXkvOMZ3W8w6MKuM=;
 b=qVljAY91KGqoDrxmaBC8uMFml4+TlcQKNPd4Ol0ZIKyMZ5kdZaZJcSBOHZO/rGHEuFsE/nq3GdvsTfvj33SjSAzzxtT5VS7HVVC5u3uJcCmQVeDRqZHg5xBQ9ZZ2gD5dvfrEbXGrSaQbpJ7KieloNUOT7UUn2mqmcIghrqgOJjA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 02:05:17 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 02:05:17 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v8 6/7] pmem: refactor pmem_clear_poison()
Date:   Tue, 19 Apr 2022 20:04:34 -0600
Message-Id: <20220420020435.90326-7-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220420020435.90326-1-jane.chu@oracle.com>
References: <20220420020435.90326-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0112.namprd12.prod.outlook.com
 (2603:10b6:802:21::47) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33aab6a2-bb3f-4a87-8f8b-08da227236cc
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4557:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4557F24456B91B4900F92D1DF3F59@SJ0PR10MB4557.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 343Tav4piJKX4Ldt/QMUKIImYWtDnifyqs2e4N7OU5Hgh2DjDwBla5oqI6TiX4ura0REhot381dg1DZKEV9RaK0cEL1+k+c+94cifytJb+Y7Wnp82048SwM2IZVwllrr4If2tU9eS4x1oyGo0Shh/bThcJ1Z2NFqdrbcAuyfgph3gUeZBbJ+ktWs5by361I5YkQK6Ebr5FWvpa4WMTwM+NllCYDf/g+Hjl5WuxOsz090eOwm8jiQL9+Pr9NfDdAm8oAdzXnQzR8Bnq7bdjoIS22q1WAy1vKtkSBsfKxDaXFar5z59bo4qed6Ta33zlZWYl8YemSEMWWi3FO/vONADllinYhOJRDTe17vF1ZWKQIzDv/Vgk7n3yOZI2zyEQa802R15/TAO5P1Zv1yY73HrzFTL63Kp+W3uKcq0c4yRQR+v3A9BAvNc2Bm5sLBgKHrQwcg4l20WZHruaKlV5yEs5X0IVDa3LGsFaUq9wLCpnZkRS3R87s5aSIEIuYuRZ2FOMKvG3JVsaBmJKBDLG9hXlIrb+m+U/zwY8oJRH09PboWUIg5QdZVS3L42DS19Rw2RYp1/CxG2J19wWb/XbJU0CRcmwSqSAXlEJGKZm1bFoBHvh8gk21VgGaqOTg2yi3Kua2QMXWgbXgdWwQor0sRg7u7weEBdf708YJvNIkt33e8ElPQngjC19w5pM3kpRi6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(5660300002)(83380400001)(86362001)(4326008)(66556008)(316002)(2906002)(508600001)(1076003)(36756003)(66946007)(186003)(44832011)(6486002)(6512007)(8676002)(2616005)(921005)(7416002)(6666004)(52116002)(38100700002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QXqXqYeKjQ+wqgh/op4NU2IWB+fi6HYgTy7K1EnBMkD2FkvuEEbH00/g7iTQ?=
 =?us-ascii?Q?V9XBau0zlku51EqEFkewO/v3FcZNBLQ7LoWPV+wUeYC0BFxO0y3pMiA3hq41?=
 =?us-ascii?Q?LLJMaP8Bke8JILeN0ByIzQyvIj930Jo9iVcmL6tB+7Hp1MbWuWDFhIUIOgCW?=
 =?us-ascii?Q?SRB6xTlErJzmkdU7SLqI3yqef3H6qGEKrgDMb+ibBS9gTqWItuGLJUgueFdY?=
 =?us-ascii?Q?i6BUiM5EeT7LQBLHCKieAFAsuQeY5zTNIiBkrEyFw2iESgHagPIQLySLxu44?=
 =?us-ascii?Q?B8j655Mp8ooBNM7QDjbBQGo0qLqvq02VDbfuqL/1PgYAjED3Rs98kb5WhD/R?=
 =?us-ascii?Q?DavhEcb4+l6Js4gkByWxQwiEdLHOCM27eS69NPh4rrdyy2VT99s5wsAK4vvg?=
 =?us-ascii?Q?mu4gbn3A8xa7d24p2Ei9f52GKxhPf9G0dckwapOg94DbaBjMVr7SV2PeXu7w?=
 =?us-ascii?Q?uOGvVqTiV9jGXQkE7ljklAXrekAjavGL/saTqNU17EV8UYyLbpURkmts8BzQ?=
 =?us-ascii?Q?uCbZJDXzCw+H6HTG1kisQyLRR9CGmcRGX+ZEAL5XrP3ZSAh0i40vNUHDfCnY?=
 =?us-ascii?Q?Oy6Gnp6gw0qUjxEn4hPlX8BB9862BvZ2tv0tnY3XAR6AHxa10RUUAgnsALYb?=
 =?us-ascii?Q?DScDlo5Q1/XGZRFcLreTIkIM6pDpsI5Afd1JceWgSsOSLcvYmp8d+q0gLLfh?=
 =?us-ascii?Q?vlin1q8+qscrUjv3o4P4elmRAjdu9s9+J7D1LouCp8yvzlcHMSPo35S7LP8a?=
 =?us-ascii?Q?3SH1M7Tu7HxAZS9t40o9CI1Hki6LS95uMCF9DAjRLRv3uuyEzXlSVYz8iEb0?=
 =?us-ascii?Q?2GrBnePc8OWjGWJ2ikgBGyMr16sqEjEjZ53gcbdp0bkKhFUprI1eKCHavipt?=
 =?us-ascii?Q?gvlIVYjP7p9quD/lo1jd56FOJwN5g5VABNalffc+IO4RGdd2yuJGdFKNP+Tx?=
 =?us-ascii?Q?L/7ia2GH567oG2sI3CVe5u1xJkZZHwtpfusMjfdV1WwBoo6x2Q1OcDpi7BxN?=
 =?us-ascii?Q?OHafoAGKlYhC2sfIxJOssYIXBU8rY9FFpGQ8osP7OlWpYa1SDO1mylzI9xTj?=
 =?us-ascii?Q?v2S7HoBiTSTnnRBSevOfDMeJqZuZCFjF+MJXEmHTdgA6RxXXJxvVraIGWHOf?=
 =?us-ascii?Q?8+oYEU2pG8sS/98a/qN6e5GVSGrCVE4zRN7foRpRHdzrNYFTcNP3NLKVuRx+?=
 =?us-ascii?Q?GaFVcMTgzkdosLENsn91jka/MldCmQ0iJtoPpFGSFgK2Q+I7AZijR4jXfhfk?=
 =?us-ascii?Q?Z1o10ERnDJLDm00C0RvDyafj//7TPhRtGTNmRhaBtv9TKNCN6hX2CXEHPn2j?=
 =?us-ascii?Q?QvQ1mABHADTTpth8aGg0lGN4WD6RywoG4b7xLe2Lo8hQcLxfyiwqyFYfxqwl?=
 =?us-ascii?Q?kb7IonB/YfEPjpvuxs7YkLm3iR04POwR7Y2o/2o0zJanfUgEl+Q0iYS4/sh2?=
 =?us-ascii?Q?iHE+nS3KOPLR/aSph3Gc7ON0j1VhAf2LgSxYJyPj4XgP+Ng3HRzbsTV85pw4?=
 =?us-ascii?Q?ma5V+hwDQf6U/Nbrl685KXCNjRCbEpqYcoKc2dkbfE1BsfX11AsFvC7pi2cY?=
 =?us-ascii?Q?/sWYVrJX+M8eBiClCdC+oGUo14viHKTq8i3UM+GT7CN5DU/6VqUMxMDGnCvj?=
 =?us-ascii?Q?8Ajorp7s0GPEkiuiqAi64TKTCbTSjRAcF5fqQ2NUVJsx2HjNNkucdnRAGaxz?=
 =?us-ascii?Q?0Za0A4GA/Jg8QbsbtQ2ZeCcrGkYFkzgoU2TTNmmIwMABFUPSimeVwwQMJgTP?=
 =?us-ascii?Q?GDUtXzF8rAyX9Sb0CBaCUbCxEHmIMSY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aab6a2-bb3f-4a87-8f8b-08da227236cc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 02:05:16.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jddx3wJJXdKgrbK29UmEG4r9JObWmBsQJlfWJkBkNbD0X0depAsQDGi4G1ZVdySHpvehx8w/pUO2lyEahUukcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200008
X-Proofpoint-ORIG-GUID: OCIxosSu9ZTHBUlCCzKaGrGDxuGlae60
X-Proofpoint-GUID: OCIxosSu9ZTHBUlCCzKaGrGDxuGlae60
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 3c0cad38ec33..c3772304d417 100644
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

