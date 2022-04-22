Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F71A50C503
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiDVXSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 19:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiDVXQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:16:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8187A1A8638;
        Fri, 22 Apr 2022 15:46:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MK5ruh024809;
        Fri, 22 Apr 2022 22:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=bGy+hL3VpQwyFjDqp7k0HE1+Sa45J4xFT+aUmE/87F8=;
 b=dlqQJumwPyfXq5EtWxw9EaDEqHUalVcnOhHO41mWFgh2qE+jZkaFPIW5UOFXOngCK2bJ
 KatTEaPkaqann5MGfbDBYpF77fcrZt5X+XQANlcyJzPzEaowRNkxw7QcTlBtVmd/8Gde
 3oxZknt8LNRYYHcysz+Dc9IdiBBF2p1/llph3nkrOQ0Diw6bD7QZwchlBvKCbLffG9Gc
 OP+V2RvIGocdjKZrcqF+YFR9kIB3kD4w2WMtNi0n91RiK0t/oBGXVcnQVChNeN7uNw2J
 SJOBRmfQronB0qrTLBdnd0jICO6ZwFdTRVgiPFt8Q1vXylsvLyXLW/xZemAYQfV/TbG4 sg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffnp9qdj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:46:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MMg0iZ008597;
        Fri, 22 Apr 2022 22:46:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8e9my2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:46:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0vbfwYWhkOT94or1nF224PonITrkzBydjkMOA8/hjTrMMsZ4TMZ9pm8wrQUJ8N8QEzH5A6m2gyqTNdMNokVKHNNjWi+uJ/TDQLfkuH+HFQwC69vicLoFRPV9FR1e+NReh59kl6kVr5p0uadTQPXguTtbg7V7r3xFLx+krksl9wjqKQyd9jRwXnQgokqYiFlQfbFRgJKhl7ug0iV4hWeIFsfV10HLDZpQoxJsj+qGnYFtnvpScdRbeLEcFbK6GLjfZD1Q4Ro08n5aBm6tckMiNmLGFJDwvm4cLXKwlD5r+6m4sOOQp2xgVnCKg0cwa0FD4tB304XyupFQmgnaIRSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGy+hL3VpQwyFjDqp7k0HE1+Sa45J4xFT+aUmE/87F8=;
 b=c8q7nhed3VaX/lANjgz3O7ctuZYsqu5F3vDcU62MRz6HoGXbf5lkL171JA2UPNQyMDDv7Y044vouTCPRvgL9aSPfE6CAX/VYoYtnFYBAmIrQPg8EOelY+s3mOigF0Fy2K9lw64ZyXCIuiklak1gAkKbXqsGBggLGf+kEU2FeBHWoBq4wSvCRwZNzzhMBWI3jOqeCrlZtlVtNui3wnRGGWlRdQsHYfjFn/+geC3dY+JghNWtNsABVJmQzHFMHK6mGC8sOXH3aE35wj6jwlQIYmljl5Pjvo8sOKsQLVZQGvcj7SnOjbNPSJBkS2KBEv44GXIxZsv+sV6MDy5/hbRU3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGy+hL3VpQwyFjDqp7k0HE1+Sa45J4xFT+aUmE/87F8=;
 b=XBkSjxrwLJSFtQTwgWY9DJBmHRu5Z0UA4LGfrExafaY3ysT+O3GCSuC4OsW5t8eHdT6GrkAno4i+cnXBzyTAPCv3NQBLPqJKyzRgJxeU/OEjP+93GL2cZI2voAs6fWK+/2LLfKZTAmKNXGsbOksBqANyx9oD7owDCwbNvg3jZmM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2550.namprd10.prod.outlook.com (2603:10b6:a02:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 22:46:15 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 22:46:15 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v9 5/7] dax: add .recovery_write dax_operation
Date:   Fri, 22 Apr 2022 16:45:06 -0600
Message-Id: <20220422224508.440670-6-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220422224508.440670-1-jane.chu@oracle.com>
References: <20220422224508.440670-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:802:20::28) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65cef020-ed96-499c-5d2c-08da24b1e8a9
X-MS-TrafficTypeDiagnostic: BYAPR10MB2550:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2550251655813FC57CC1F9C5F3F79@BYAPR10MB2550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8ytzmDG+MrIOpbJPVi6YDrNqSWsmcPkZwxZvz/WZ636pehQ5lezrKvuEU0W7ZUpeHelwZMclXN971XahMJ7IPwd43lPnzD3hjpo+4NVWKvdZ5lT5S2aLXPE189uJoNVgHTCCiJf/9yCPaWjawZtViEugaMBB2F7FT1x7QTeNDljsoEGCpkzuKlUN8nLlDqU7gpoqe5R6FxHy7Q9Ouxo8uYQWQWBbDaPNfsRFKToaGmC+sEEdFUVM8JYx3xdKbi243t42Jja4jP6G6ix4I2lbibtpmG/Pk6RPmFWiNSybT+V/0HuSscQC+aDRI0nrs2rFJAjxS5+SxOCKC2EqNlCrTjfsFXEWOe/ks9rfLZjwQw9ZJgSVD98J/cDshRKuV9xNClznSBHx+kBPJf8LLeP3YzRsWKhJpXo+7Ns9XsNvRbm04D3fGLxPEHyRmryAPchGacAnDHabOHJzXXgNyzeeBFqIPs5YuDFbKJ/CK+euRpGG2bFeKop8+OX3+LGNhKhEFFzlmWMzra1vYSKBb2GQwwHpUDxuD4i4hZGWWcAYvzw4FlUe8MVTkOKoOt7Zt+D5URJeai7zKebZmicQqpoidRsRC3Enk32jcgeZP3OC+CHK9Xa1iqFWIhySfS6BzpYycE9q/LsQncSxPysmKTvgEXLXvRCL1NuagSer/emzmYXJpi21+fFAw+E+Tz4nuRfVonpL5FPd+gwwD2bru7cme6iYYhTcnwBew24YpptqnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(6486002)(8936002)(508600001)(52116002)(83380400001)(36756003)(316002)(66556008)(66476007)(2906002)(8676002)(4326008)(66946007)(38100700002)(2616005)(86362001)(5660300002)(30864003)(44832011)(186003)(6512007)(1076003)(7416002)(921005)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3yYzgiBmJAPfBXidt6x+QNWyKzo2Q787ipcak7CR2fD240D7MShAPCTY7sgP?=
 =?us-ascii?Q?BS/3W0xZ8RSrJ+NxJvIfmGhCYH8m/HyiNLgU+rvDcDU10uz+SqrqKvaxRqhH?=
 =?us-ascii?Q?0+Yz0z11wRd+bHEA4CiHGjLMx0mdZtbUoQeyb7mZqLZyXn5UKQH+3zgfnARy?=
 =?us-ascii?Q?6eMXyua/RoIWR6xqF0mgmI0ehTwKGN8zvaszUK/n4QUSvTxPWgP/88ixJmmy?=
 =?us-ascii?Q?Hhos1tpK3dURl0Gi/KoC/F+cDVlBpJpX96FOTFW+8E64ztrDDtnZVHp5Z1KE?=
 =?us-ascii?Q?eaQL4imSsP4YuTkTIBt5emC25uPy7bgZDW3e+7VKnGoUlKOF6IsaD2kRIkPC?=
 =?us-ascii?Q?qCX7IWaEkxryjpuNfkRImUJpJY9j/RNWyBtpJdKTHTyHTQJXc9y7WJnpGPmw?=
 =?us-ascii?Q?6R126yrlpD60kU3iAw1kaHqW0/DmGFv+/taN1I18xtTbNGglAfeGROJ6bZOI?=
 =?us-ascii?Q?06x9qivKr9MXCooyjmTPjQ229HU3A3PaQI3CVG2+CaCwnmb/dVbejxWPvKGm?=
 =?us-ascii?Q?joOGY3435uf4BUBTd5oJfAmLljN0jSfIBL+o9BSHinQVEvKmbjTB4rAHLzEU?=
 =?us-ascii?Q?/Vzno7qKwQooLXkrTqtf+N9tqsuXrxsGZFqfw4taQbU3AgBxuDRdAwrqFCdR?=
 =?us-ascii?Q?cSNOidm7aqhkBklpyHKkaREhXqtCKJsX6xcUzZggiTfAKt+qvhYr5/JnQ9ty?=
 =?us-ascii?Q?jqInxUUQTIoxEmILAONCxZbnjvUpeWDHWYMrh7qiDCByilLR7VYkBm/y4mhV?=
 =?us-ascii?Q?BvKh0AsSaxQ40HdorY3/O+/IKYCAcftaP1qun2nSWp5fX7q9qkVCzCAV/m3d?=
 =?us-ascii?Q?1+d6ViSYkwilkEEYgtHtXoHBsf323Rbemkt/6LLjjne5WAI+1bPS1GwJgP/H?=
 =?us-ascii?Q?V0iKdWPobYWbimm3Xl4/oRtgYxH4HGNGq+CYPulkLIQSxVKovPobpCLDqDCb?=
 =?us-ascii?Q?ywc0ht6vMw7gcF1CLQoREXmD3xjxLDRBcaQGMjmtjlWlxzkrnJgbyc/ESlsc?=
 =?us-ascii?Q?57a71DQGiHX8eceDuaGOmGACg+3NyXwsmUYpW2QoyBJdRO3vSfsNWpg9BL1N?=
 =?us-ascii?Q?09iyWYFGoIpj+eqnaq38a2gcHHBMmrIaqAjd+eToGZhmBpBh7x5pslwgglt1?=
 =?us-ascii?Q?XJkCVxgoyW6l/YI31/aNR4OyWAXTfW2S5ufn+dGRtMnmGIwS+aBAx7qteFhM?=
 =?us-ascii?Q?Y0NVzsi0JNKWcUuPXGkmZkbMuZikFbkaWqa6kUHTZ2BUvBBXf3f/teNf1+Oz?=
 =?us-ascii?Q?HqlHdgAiZQOf4fzhzOt7qL63CYio2Xinfm51rH4NSGZWcv3kx3mXYAYHQoSW?=
 =?us-ascii?Q?QPwJfCp3RHWWxcblK699eUXz5J9awp2XwA1KOoU2K2qgOKHvkjEbDWRpEM2H?=
 =?us-ascii?Q?TfTBlJ6NQY2koKMzb2pJTcy7jU+4UbivYpOa9zEjg2XAnH//m+AfzCErOYNS?=
 =?us-ascii?Q?nXYAxOCKtylirq85vxQ//CItUb2rqJo1IXYzRS/qLb4P2irYRpVGgRNtcUTG?=
 =?us-ascii?Q?Ouyi513l7bmeSrNdTIoyCup57kwX7pCdciPekQizkFX+Y2HxKdQDtVVlax+r?=
 =?us-ascii?Q?yGgB7SMZAMle1s2FFKSiYr5Ru+NwuBoMhKIuETxi0du5MEDR9rcWO6Yi1bNU?=
 =?us-ascii?Q?yZXg4U8zanmZISkXckeY8mLtEAf5ByCV439f2s8iP3cPKzwEpu46GENTAsVx?=
 =?us-ascii?Q?Q6ViFjM2x40Y+dfR+yhKdbWjBBeRNsxHgNAFDHuTmxSAkJzuMTByXxWy/HNX?=
 =?us-ascii?Q?8jgC+pmvT/1ZJOf4IGrr2g2H4a6yFH8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cef020-ed96-499c-5d2c-08da24b1e8a9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 22:46:15.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9FcuQPvZMn3ztDf4vhTnuDXket5UbQipLiNnAlpqtL83n/iL5HXK4I/Q6XJ/Y7zCg493DLk+t/o+XjGVKrb0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_07:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204220095
X-Proofpoint-ORIG-GUID: AzwBVj0_VnkthZxxEALWhBkMZtmPFdzb
X-Proofpoint-GUID: AzwBVj0_VnkthZxxEALWhBkMZtmPFdzb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce dax_recovery_write() operation. The function is used to
recover a dax range that contains poison. Typical use case is when
a user process receives a SIGBUS with si_code BUS_MCEERR_AR
indicating poison(s) in a dax range, in response, the user process
issues a pwrite() to the page-aligned dax range, thus clears the
poison and puts valid data in the range.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/dax/super.c           |  9 +++++++++
 drivers/md/dm-linear.c        | 10 ++++++++++
 drivers/md/dm-log-writes.c    | 10 ++++++++++
 drivers/md/dm-stripe.c        | 10 ++++++++++
 drivers/md/dm.c               | 20 ++++++++++++++++++++
 drivers/nvdimm/pmem.c         |  7 +++++++
 fs/dax.c                      | 13 ++++++++++++-
 include/linux/dax.h           | 13 +++++++++++++
 include/linux/device-mapper.h |  9 +++++++++
 9 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 5405eb553430..50a08b2ec247 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -195,6 +195,15 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *iter)
+{
+	if (!dax_dev->ops->recovery_write)
+		return 0;
+	return dax_dev->ops->recovery_write(dax_dev, pgoff, addr, bytes, iter);
+}
+EXPORT_SYMBOL_GPL(dax_recovery_write);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 13e263299c9c..cdf48bc8c5b0 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -188,9 +188,18 @@ static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages);
 }
 
+static size_t linear_dax_recovery_write(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
+
+	return dax_recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+
 #else
 #define linear_dax_direct_access NULL
 #define linear_dax_zero_page_range NULL
+#define linear_dax_recovery_write NULL
 #endif
 
 static struct target_type linear_target = {
@@ -208,6 +217,7 @@ static struct target_type linear_target = {
 	.iterate_devices = linear_iterate_devices,
 	.direct_access = linear_dax_direct_access,
 	.dax_zero_page_range = linear_dax_zero_page_range,
+	.dax_recovery_write = linear_dax_recovery_write,
 };
 
 int __init dm_linear_init(void)
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 06bdbed65eb1..22739dccdd17 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -905,9 +905,18 @@ static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages << PAGE_SHIFT);
 }
 
+static size_t log_writes_dax_recovery_write(struct dm_target *ti,
+		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
+
+	return dax_recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+
 #else
 #define log_writes_dax_direct_access NULL
 #define log_writes_dax_zero_page_range NULL
+#define log_writes_dax_recovery_write NULL
 #endif
 
 static struct target_type log_writes_target = {
@@ -925,6 +934,7 @@ static struct target_type log_writes_target = {
 	.io_hints = log_writes_io_hints,
 	.direct_access = log_writes_dax_direct_access,
 	.dax_zero_page_range = log_writes_dax_zero_page_range,
+	.dax_recovery_write = log_writes_dax_recovery_write,
 };
 
 static int __init dm_log_writes_init(void)
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 77d72900e997..baa085cc67bd 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -331,9 +331,18 @@ static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages);
 }
 
+static size_t stripe_dax_recovery_write(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
+
+	return dax_recovery_write(dax_dev, pgoff, addr, bytes, i);
+}
+
 #else
 #define stripe_dax_direct_access NULL
 #define stripe_dax_zero_page_range NULL
+#define stripe_dax_recovery_write NULL
 #endif
 
 /*
@@ -470,6 +479,7 @@ static struct target_type stripe_target = {
 	.io_hints = stripe_io_hints,
 	.direct_access = stripe_dax_direct_access,
 	.dax_zero_page_range = stripe_dax_zero_page_range,
+	.dax_recovery_write = stripe_dax_recovery_write,
 };
 
 int __init dm_stripe_init(void)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8258676a352f..5374c8aba2d6 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1147,6 +1147,25 @@ static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 	return ret;
 }
 
+static size_t dm_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	struct mapped_device *md = dax_get_private(dax_dev);
+	sector_t sector = pgoff * PAGE_SECTORS;
+	struct dm_target *ti;
+	int srcu_idx;
+	long ret = 0;
+
+	ti = dm_dax_get_live_target(md, sector, &srcu_idx);
+	if (!ti || !ti->type->dax_recovery_write)
+		goto out;
+
+	ret = ti->type->dax_recovery_write(ti, pgoff, addr, bytes, i);
+out:
+	dm_put_live_table(md, srcu_idx);
+	return ret;
+}
+
 /*
  * A target may call dm_accept_partial_bio only from the map routine.  It is
  * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_* zone management
@@ -3151,6 +3170,7 @@ static const struct block_device_operations dm_rq_blk_dops = {
 static const struct dax_operations dm_dax_ops = {
 	.direct_access = dm_dax_direct_access,
 	.zero_page_range = dm_dax_zero_page_range,
+	.recovery_write = dm_dax_recovery_write,
 };
 
 /*
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 47f34c50f944..e5e288135af7 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -287,9 +287,16 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
 	return __pmem_direct_access(pmem, pgoff, nr_pages, mode, kaddr, pfn);
 }
 
+static size_t pmem_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	return 0;
+}
+
 static const struct dax_operations pmem_dax_ops = {
 	.direct_access = pmem_dax_direct_access,
 	.zero_page_range = pmem_dax_zero_page_range,
+	.recovery_write = pmem_recovery_write,
 };
 
 static ssize_t write_cache_show(struct device *dev,
diff --git a/fs/dax.c b/fs/dax.c
index ef3103107104..a1e4b45cbf55 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1240,6 +1240,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		const size_t size = ALIGN(length + offset, PAGE_SIZE);
 		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 		ssize_t map_len;
+		bool recovery = false;
 		void *kaddr;
 
 		if (fatal_signal_pending(current)) {
@@ -1249,6 +1250,13 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
 				DAX_ACCESS, &kaddr, NULL);
+		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
+			map_len = dax_direct_access(dax_dev, pgoff,
+					PHYS_PFN(size), DAX_RECOVERY_WRITE,
+					&kaddr, NULL);
+			if (map_len > 0)
+				recovery = true;
+		}
 		if (map_len < 0) {
 			ret = map_len;
 			break;
@@ -1260,7 +1268,10 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (map_len > end - pos)
 			map_len = end - pos;
 
-		if (iov_iter_rw(iter) == WRITE)
+		if (recovery)
+			xfer = dax_recovery_write(dax_dev, pgoff, kaddr,
+					map_len, iter);
+		else if (iov_iter_rw(iter) == WRITE)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 3f1339bce3c0..e7b81634c52a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -35,6 +35,12 @@ struct dax_operations {
 			sector_t, sector_t);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
+	/*
+	 * recovery_write: recover a poisoned range by DAX device driver
+	 * capable of clearing poison.
+	 */
+	size_t (*recovery_write)(struct dax_device *dax_dev, pgoff_t pgoff,
+			void *addr, size_t bytes, struct iov_iter *iter);
 };
 
 #if IS_ENABLED(CONFIG_DAX)
@@ -45,6 +51,8 @@ void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
 void set_dax_synchronous(struct dax_device *dax_dev);
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i);
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
@@ -92,6 +100,11 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 {
 	return !(vma->vm_flags & VM_SYNC);
 }
+static inline size_t dax_recovery_write(struct dax_device *dax_dev,
+		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
+{
+	return 0;
+}
 #endif
 
 void set_dax_nocache(struct dax_device *dax_dev);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index acdedda0d12b..47a01c7cffdf 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -152,6 +152,14 @@ typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
+/*
+ * Returns:
+ * != 0 : number of bytes transferred
+ * 0    : recovery write failed
+ */
+typedef size_t (*dm_dax_recovery_write_fn)(struct dm_target *ti, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i);
+
 void dm_error(const char *message);
 
 struct dm_dev {
@@ -201,6 +209,7 @@ struct target_type {
 	dm_io_hints_fn io_hints;
 	dm_dax_direct_access_fn direct_access;
 	dm_dax_zero_page_range_fn dax_zero_page_range;
+	dm_dax_recovery_write_fn dax_recovery_write;
 
 	/* For internal device-mapper use. */
 	struct list_head list;
-- 
2.18.4

