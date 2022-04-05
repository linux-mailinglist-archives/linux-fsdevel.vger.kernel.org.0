Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC39D4F4D78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581640AbiDEXkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573710AbiDETut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:50:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6897D1B7AB;
        Tue,  5 Apr 2022 12:48:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235J49Ei006378;
        Tue, 5 Apr 2022 19:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=VeIv4a4P+grMHss49bYmNgCyeCaU1bT27mUIzBkYEqs=;
 b=JhW60NsUqtNCxKwxkX6xMoIVSczZt2WxBCmXZ004dHhRYhvwey/f3RdoMDa4YS8AZ4xP
 MXY+ZC2ayFO8aqDCKcokQ8Bmt4Hl5AAm/LB9q2bPEAsouFA4WNPyGP62xPGaywXhXkSh
 ytGtvT/qFkgoNlZCU79oqn5Y4MOD8pSCowx6cZLqbQBp8rLnMizcXl5mlUhjVzWkW+0q
 dVPSZTfsavBEf5n4I3tR8AC6wIjrMw1LxpPcSq8v3yW8LEp5KTLSe41GCzVFEm6/AR9I
 +J/ac/P/ThNPv7HLb5ZVkScqyGwsi9sPwHnhrkD9EvlEC1iZ8s0Ao9txvdJ6r0dkSIkM BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31f35a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 19:48:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 235JZbwk002108;
        Tue, 5 Apr 2022 19:48:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx3r4gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 19:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPfOuaCTzvF7kbCrP27Rh9dDrOd4ziBJSl9LtWdhg9duDPMAwF/APhzBjgcDW3zmYsCY9w1wxLyMtRGRdT+wh1sbCS6Us+px+O8JiuZcktfoEl7s/YgRKOGUgN4Y/x/dyp9MaCXEM6Pz2d0+70ORZqd6zfJ8RfdMxZmKMRPW6su/f7BSobPWFf7ThGG8Y9FTSLYiY4FstYuejGRyydkenGWFCTCJPVH1FQ2nlMw6bpZoh2DT+OyrGHKo9f9UusdxUCWsZTEqd5dz3pK6Ye2NFurdhn0koBE5Z3nXT9P6UkByjUxBLT1965bzc8CseoxuOFozDtOBwk9TkBP9u6htLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeIv4a4P+grMHss49bYmNgCyeCaU1bT27mUIzBkYEqs=;
 b=h0jLYwRhQsgMBr85TI78mNAzFhHbqZwdGFu/H82hM8nagcD4Zspzj+nyHw1A2zDdWs7VW2L5iDBAcVLZaFfAQxbFM/LSudk8p8SYjNm+6f+RkIzRLGz0uLWRDZneO2IxsskaLZpI38fRzVBfIOO+PXZinhCYl2tj7wp1vl/gKEfa8baVNDQy1EZADadJvtCgwqboAubiiK2MS63xXxVPJ/t5SuWG8rC/g01JruN7KGTd2xFyheAqAD/cxobnw1CC6DGAZOv8pGntpiQbhsxzwqyAcRs3ilV9lAj9oCWp00ztoiGVShiCIozAc8HD+JHNg3g3V8ARA7mKS88OorVX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeIv4a4P+grMHss49bYmNgCyeCaU1bT27mUIzBkYEqs=;
 b=YVNX7zLFA3bXljEsOSb+VzYO/qif3C/4qNsTZ8+kMlo2ylq1b76eysP8H0P1gwxTrYdhHOmZZzXbBoEXXl/WO8x1CBZ5+9xZR5QOyK9mOfUlGLQd1gPo6dT6TpNwO7zAW759vUty2O706qpat0FPXe08gMUpIkPB1UHI6qFPgoQ=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BN6PR10MB1425.namprd10.prod.outlook.com (2603:10b6:404:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 19:48:27 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%7]) with mapi id 15.20.5123.030; Tue, 5 Apr 2022
 19:48:26 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write dev_pgmap_ops
Date:   Tue,  5 Apr 2022 13:47:45 -0600
Message-Id: <20220405194747.2386619-5-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220405194747.2386619-1-jane.chu@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:806:22::29) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db8b00c0-28f9-4186-a825-08da173d405b
X-MS-TrafficTypeDiagnostic: BN6PR10MB1425:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB142525DC679EF05FCA5ED317F3E49@BN6PR10MB1425.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8YU4jJc/f565rATBKP/KaxSC6wQMU9KYfKNgad09On2fVoZ1WqJUBP9K3bqgKrZQCtNeMJRgNj7zjpoFC04QN6oj1nubu/q1liW6CpG0N/n3JG+FnRxjfhF3DP6+AIWNxUjJtVY3c0xC57N8v8T6XUZqVZh+N99txNtkJBVwBfUZ3BPgav/T/z3L4tB6Q5b/gorbWgGBrLmV/GIAZMDYtCAKGF8z5DYYmd4DdU9k1Z1N4aaUP6S68mQyOP0QmZQTPJCJ9UGdgFEywOzFKRTe8q6YHQZAB1gH5jpMaidfcrEbQ5nPbw782yyF+ZrMGWIsP7AG7QP17TmKrgk4RUwqwpFC5QegazOTj90fg8ePAQfOU/YTupT61WEVO+GCVo9hriLJLj/GFH0PIY0aAAOujAlJgxi+sAJ97HYKk9F6gqiKbB1un1IimWj2LU3gsaUSgIOKRD9VtbBA3uSDoDMGmWs90T1Adl0FfQur78cs6QWGH4fveYHq5EOoL7b2v+GXUSh9fYIs2CqcSsLT1/zbNrrQVEUwenji0rsb1aZsFghtTo0UgJQIy/05jdGam6zfafMpBmM4TiM07DIqn1XLzeW7hqpA/n6fr4LT4mT/IFixwalzvjiafLZGFhOVmNiE1hdE4/DI3N+8cyJc48pOpis1naGJFcQlQqpeYWdJIfpc/wMCV91QcUXdi1baKYJE9XStFgVc32qM3TdUWxkRsQXu9VxE6NV7b0AB93p7PnXYboQgJHX9scu3I7C5wyQB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66946007)(5660300002)(86362001)(44832011)(36756003)(921005)(30864003)(83380400001)(6666004)(2906002)(38100700002)(66556008)(6506007)(2616005)(8676002)(508600001)(66476007)(186003)(7416002)(1076003)(6486002)(52116002)(6512007)(316002)(142923001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nD531rIW0tLqKkNxARgpu1T1bLu7k+W2rmLR7sDDHgiQ+eltE7ALxRmo5zuw?=
 =?us-ascii?Q?ioVMSxIfNzlLcbRHUemQY9zlbz+eQfbtdvhVBjd1n9cz5yCs9OabmyNUv9Fu?=
 =?us-ascii?Q?IPLGXxcsVyjserwiqd77+dED78WnYnyrVZckRScfkUnfPX9rDr9JvfpsNnXh?=
 =?us-ascii?Q?vZHGFXbNIj6AW7HgUc1yA24RQOlzHq8YHyKDQPMbpY6JejHN9zkKHZMOhaUA?=
 =?us-ascii?Q?gVbh7QXvECf9nVLyKc3fEwEF3691NWOwC3TsoScklRZg0LMQrCGKW/FkYF4K?=
 =?us-ascii?Q?mduTZTk3SRkE8s1Xs7kwFH5AkoAQko7jzKhIsKwYXJcLxkH6SO8T1UCvcIES?=
 =?us-ascii?Q?wwnKwgHvO+gIYSzO3lkvxmkWh96s3qgauLxAgv/TR/67AZ215JXMu49XB5u6?=
 =?us-ascii?Q?uCTw0rDhxRyODs+LPaX2A4OCxO/I+DVfTWa+KkLs+W+rBzUke+pICs2vQt5P?=
 =?us-ascii?Q?/arjrjnsB+VozCVw70jxQg0dT6EGp8gastJ7zjSZFkEA9l4VJ11o22tG9oaO?=
 =?us-ascii?Q?4U2SDMPWfuTHaTgToe5/dbzKy8pB14//jTgTqSZoyPrJftOeQHAHImVT28jD?=
 =?us-ascii?Q?K6qOlc8arKKDDTuyDxEptXzAh4ZhxM5GFv00+WQhemioWGTrTEX6pLhYRO6c?=
 =?us-ascii?Q?FnorYSrBzm6gddFdrR0VpG0tgGkq85O0LmSiPqOLySvWGiW1SCgsANziixoa?=
 =?us-ascii?Q?JbEUvVde9Wxdsgwrue0KWwjoXQPpgvqLm4fW28BgVeQFKxtiQOxbI3hhE8sg?=
 =?us-ascii?Q?f5Mv5lIqz4oVC507MaY+y9MOuFGlPaLeOaVayAUNZpAe077ncouze8myvbvL?=
 =?us-ascii?Q?azd85kClSuTKChx+3woZOt4ALWtdZWPN7S0/6foDepNFo4Imo21LsSKN+WGp?=
 =?us-ascii?Q?wE7ZbKoqdS0jUYp2wV8YtT1ABVtWT0F9cO+w00RD8mYc9xfOiwxij8kgf6ds?=
 =?us-ascii?Q?6BwZ0XFyM6F4Y5jegHRU99a2VI/QPSiW5FAEeqVlAZuicGW5vQkqWdIedJ0L?=
 =?us-ascii?Q?r/qNnzNgAPJndjduczAI8RidyzpCO4O3BmCHscmZkbjFrRVZCxKsjoVW18dY?=
 =?us-ascii?Q?SdfwIVprxlgGWaOj+OuWQz6K2op969LTKDpSRQLiuyoP8wHfZkg8DjZEvtd/?=
 =?us-ascii?Q?HIPckihQeq9Ajx0+8NIqjkLCMtxxKRWruB9nSHq1hlevl1XqR2aSPwZonrIT?=
 =?us-ascii?Q?TZmcRh8A0jBPehHmy2zv4/EUam5FuYUzdYVmnz0jpGtJgBeY3ECcDMt1Pnt1?=
 =?us-ascii?Q?xEd4x0T342eEBV58JMXVTou+Yjx8j2XRvDIYB27nGZtmQbfFQ7L+4quYy88y?=
 =?us-ascii?Q?I5Xg4bne7ivIyUsGs/sBKLSvkW8s/F2m6aLG6tkrXuJL+R04FHjTHQQsNjm+?=
 =?us-ascii?Q?doVgvH4ipZkPLhCPqjktGOErNa1qP95AZsMG0YcvanB4zVGon2B5I7bd5+Kj?=
 =?us-ascii?Q?bFCT9d8FM5rZVyQahmQoTieBNy2dYsePAqAkg7CHjIBLk6Xux6WSZvvYWfj4?=
 =?us-ascii?Q?V5lgQoHPKi9UDyczObMof72U4Cxkqjd7IbuGFMzhNVOdnbpk9xct3zRXddUa?=
 =?us-ascii?Q?e/cUA/jzq4KZqWUHwqt0gDYOhhJsx7fCX2OzCdCbqVxVVIRKBpTEZoKiE+iw?=
 =?us-ascii?Q?Bv0Ycf2iCNxtezV/gWGXYFmx/rzQhsuQ1zBnxwNSKONaFjaXDfjI+KZZJ/ba?=
 =?us-ascii?Q?BQqsIDWebX0LsYLbYnlc7MDIBgo9W4mjFS9ebe0cLGEErOpP0OFYc8G6RZeM?=
 =?us-ascii?Q?Q7zxe9epDV1T2shfzbUayGTwUYS72xU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8b00c0-28f9-4186-a825-08da173d405b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 19:48:26.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTExgBTa1grcrFUgx+ZcA84gLbEmSzxPFQk25lACcWxzzZVFGxy4tsggVeD9w+WSpVhvQ9o0npZ3/YsCI+kswA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1425
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_06:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204050110
X-Proofpoint-GUID: oFEuXjfNue4uWWYEf8PsdsXnNodalMdW
X-Proofpoint-ORIG-GUID: oFEuXjfNue4uWWYEf8PsdsXnNodalMdW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce DAX_RECOVERY flag to dax_direct_access(). The flag is
not set by default in dax_direct_access() such that the helper
does not translate a pmem range to kernel virtual address if the
range contains uncorrectable errors.  When the flag is set,
the helper ignores the UEs and return kernel virtual adderss so
that the caller may get on with data recovery via write.

Also introduce a new dev_pagemap_ops .recovery_write function.
The function is applicable to FSDAX device only. The device
page backend driver provides .recovery_write function if the
device has underlying mechanism to clear the uncorrectable
errors on the fly.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/dax/super.c             | 17 ++++++++--
 drivers/md/dm-linear.c          |  4 +--
 drivers/md/dm-log-writes.c      |  5 +--
 drivers/md/dm-stripe.c          |  4 +--
 drivers/md/dm-target.c          |  2 +-
 drivers/md/dm-writecache.c      |  5 +--
 drivers/md/dm.c                 |  5 +--
 drivers/nvdimm/pmem.c           | 57 +++++++++++++++++++++++++++------
 drivers/nvdimm/pmem.h           |  2 +-
 drivers/s390/block/dcssblk.c    |  4 +--
 fs/dax.c                        | 24 ++++++++++----
 fs/fuse/dax.c                   |  4 +--
 include/linux/dax.h             | 11 +++++--
 include/linux/device-mapper.h   |  2 +-
 include/linux/memremap.h        |  7 ++++
 tools/testing/nvdimm/pmem-dax.c |  2 +-
 16 files changed, 116 insertions(+), 39 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0211e6f7b47a..8252858cd25a 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -13,6 +13,7 @@
 #include <linux/uio.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
+#include <linux/memremap.h>
 #include "dax-private.h"
 
 /**
@@ -117,6 +118,7 @@ enum dax_device_flags {
  * @dax_dev: a dax_device instance representing the logical memory range
  * @pgoff: offset in pages from the start of the device to translate
  * @nr_pages: number of consecutive pages caller can handle relative to @pfn
+ * @flags: by default 0, set to DAX_RECOVERY to kick start dax recovery
  * @kaddr: output parameter that returns a virtual address mapping of pfn
  * @pfn: output parameter that returns an absolute pfn translation of @pgoff
  *
@@ -124,7 +126,7 @@ enum dax_device_flags {
  * pages accessible at the device relative @pgoff.
  */
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		void **kaddr, pfn_t *pfn)
+		int flags, void **kaddr, pfn_t *pfn)
 {
 	long avail;
 
@@ -137,7 +139,7 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 	if (nr_pages < 0)
 		return -EINVAL;
 
-	avail = dax_dev->ops->direct_access(dax_dev, pgoff, nr_pages,
+	avail = dax_dev->ops->direct_access(dax_dev, pgoff, nr_pages, flags,
 			kaddr, pfn);
 	if (!avail)
 		return -ERANGE;
@@ -194,6 +196,17 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		pfn_t pfn, void *addr, size_t bytes, struct iov_iter *iter)
+{
+	struct dev_pagemap *pgmap = get_dev_pagemap(pfn_t_to_pfn(pfn), NULL);
+
+	if (!pgmap || !pgmap->ops || !pgmap->ops->recovery_write)
+		return 0;
+	return pgmap->ops->recovery_write(pgmap, pgoff, addr, bytes, iter);
+}
+EXPORT_SYMBOL_GPL(dax_recovery_write);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 76b486e4d2be..9e6d8bdf3b2a 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -172,11 +172,11 @@ static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 }
 
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
 
-	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, flags, kaddr, pfn);
 }
 
 static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index c9d036d6bb2e..e23f062ade5f 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -889,11 +889,12 @@ static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
 }
 
 static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-					 long nr_pages, void **kaddr, pfn_t *pfn)
+					 long nr_pages, int flags,
+					 void **kaddr, pfn_t *pfn)
 {
 	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 
-	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, flags, kaddr, pfn);
 }
 
 static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index c81d331d1afe..b89339c78702 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -315,11 +315,11 @@ static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 }
 
 static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
-	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, flags, kaddr, pfn);
 }
 
 static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 64dd0b34fcf4..24b1e5628f3a 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -142,7 +142,7 @@ static void io_err_release_clone_rq(struct request *clone,
 }
 
 static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	return -EIO;
 }
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 5630b470ba42..180ca8fa383e 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -286,7 +286,8 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 
 	id = dax_read_lock();
 
-	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, &wc->memory_map, &pfn);
+	da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, 0,
+			&wc->memory_map, &pfn);
 	if (da < 0) {
 		wc->memory_map = NULL;
 		r = da;
@@ -309,7 +310,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 		do {
 			long daa;
 			daa = dax_direct_access(wc->ssd_dev->dax_dev, offset + i, p - i,
-						NULL, &pfn);
+						0, NULL, &pfn);
 			if (daa <= 0) {
 				r = daa ? daa : -EINVAL;
 				goto err3;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ad2e0bbeb559..a8c697bb6603 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1087,7 +1087,8 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
 }
 
 static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-				 long nr_pages, void **kaddr, pfn_t *pfn)
+				 long nr_pages, int flags, void **kaddr,
+				 pfn_t *pfn)
 {
 	struct mapped_device *md = dax_get_private(dax_dev);
 	sector_t sector = pgoff * PAGE_SECTORS;
@@ -1105,7 +1106,7 @@ static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (len < 1)
 		goto out;
 	nr_pages = min(len, nr_pages);
-	ret = ti->type->direct_access(ti, pgoff, nr_pages, kaddr, pfn);
+	ret = ti->type->direct_access(ti, pgoff, nr_pages, flags, kaddr, pfn);
 
  out:
 	dm_put_live_table(md, srcu_idx);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 30c71a68175b..0400c5a7ba39 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -238,12 +238,23 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
+	sector_t sector = PFN_PHYS(pgoff) >> SECTOR_SHIFT;
+	unsigned int num = PFN_PHYS(nr_pages) >> SECTOR_SHIFT;
+	struct badblocks *bb = &pmem->bb;
+	sector_t first_bad;
+	int num_bad;
+	bool bad_in_range;
+	long actual_nr;
+
+	if (!bb->count)
+		bad_in_range = false;
+	else
+		bad_in_range = !!badblocks_check(bb, sector, num, &first_bad, &num_bad);
 
-	if (unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
-					PFN_PHYS(nr_pages))))
+	if (bad_in_range && !(flags & DAX_RECOVERY))
 		return -EIO;
 
 	if (kaddr)
@@ -251,13 +262,26 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	if (pfn)
 		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
 
+	if (!bad_in_range) {
+		/*
+		 * If badblock is present but not in the range, limit known good range
+		 * to the requested range.
+		 */
+		if (bb->count)
+			return nr_pages;
+		return PHYS_PFN(pmem->size - pmem->pfn_pad - offset);
+	}
+
 	/*
-	 * If badblocks are present, limit known good range to the
-	 * requested range.
+	 * In case poison is found in the given range and DAX_RECOVERY flag is set,
+	 * recovery stride is set to kernel page size because the underlying driver and
+	 * firmware clear poison functions don't appear to handle large chunk (such as
+	 * 2MiB) reliably.
 	 */
-	if (unlikely(pmem->bb.count))
-		return nr_pages;
-	return PHYS_PFN(pmem->size - pmem->pfn_pad - offset);
+	actual_nr = PHYS_PFN(PAGE_ALIGN((first_bad - sector) << SECTOR_SHIFT));
+	dev_dbg(pmem->bb.dev, "start sector(%llu), nr_pages(%ld), first_bad(%llu), actual_nr(%ld)\n",
+			sector, nr_pages, first_bad, actual_nr);
+	return (actual_nr == 0) ? 1 : actual_nr;
 }
 
 static const struct block_device_operations pmem_fops = {
@@ -277,11 +301,12 @@ static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
-		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
+		pgoff_t pgoff, long nr_pages, int flags, void **kaddr,
+		pfn_t *pfn)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
 
-	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
+	return __pmem_direct_access(pmem, pgoff, nr_pages, flags, kaddr, pfn);
 }
 
 static const struct dax_operations pmem_dax_ops = {
@@ -289,6 +314,12 @@ static const struct dax_operations pmem_dax_ops = {
 	.zero_page_range = pmem_dax_zero_page_range,
 };
 
+static size_t pmem_recovery_write(struct dev_pagemap *pgmap, pgoff_t pgoff,
+		void *addr, size_t bytes, void *iter)
+{
+	return 0;
+}
+
 static ssize_t write_cache_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -349,6 +380,10 @@ static void pmem_release_disk(void *__pmem)
 	blk_cleanup_disk(pmem->disk);
 }
 
+static const struct dev_pagemap_ops pmem_pgmap_ops = {
+	.recovery_write = pmem_recovery_write,
+};
+
 static int pmem_attach_disk(struct device *dev,
 		struct nd_namespace_common *ndns)
 {
@@ -380,6 +415,8 @@ static int pmem_attach_disk(struct device *dev,
 		rc = nvdimm_setup_pfn(nd_pfn, &pmem->pgmap);
 		if (rc)
 			return rc;
+		if (nd_pfn->mode == PFN_MODE_PMEM)
+			pmem->pgmap.ops = &pmem_pgmap_ops;
 	}
 
 	/* we're attaching a block device, disable raw namespace access */
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 1f51a2361429..e9c53d42c488 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -28,7 +28,7 @@ struct pmem_device {
 };
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+		long nr_pages, int flag, void **kaddr, pfn_t *pfn);
 
 #ifdef CONFIG_MEMORY_FAILURE
 static inline bool test_and_clear_pmem_poison(struct page *page)
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index d614843caf6c..c3fbf500868f 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -32,7 +32,7 @@ static int dcssblk_open(struct block_device *bdev, fmode_t mode);
 static void dcssblk_release(struct gendisk *disk, fmode_t mode);
 static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn);
 
 static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
 
@@ -927,7 +927,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 
 static long
 dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	struct dcssblk_dev_info *dev_info = dax_get_private(dax_dev);
 
diff --git a/fs/dax.c b/fs/dax.c
index 67a08a32fccb..e8900e92990b 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -721,7 +721,7 @@ static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter
 	int id;
 
 	id = dax_read_lock();
-	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
+	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, 0, &kaddr, NULL);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
@@ -1012,7 +1012,7 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 	long length;
 
 	id = dax_read_lock();
-	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
+	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size), 0,
 				   NULL, pfnp);
 	if (length < 0) {
 		rc = length;
@@ -1122,7 +1122,7 @@ static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
 	void *kaddr;
 	long ret;
 
-	ret = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	ret = dax_direct_access(dax_dev, pgoff, 1, 0, &kaddr, NULL);
 	if (ret > 0) {
 		memset(kaddr + offset, 0, size);
 		dax_flush(dax_dev, kaddr + offset, size);
@@ -1239,15 +1239,24 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		const size_t size = ALIGN(length + offset, PAGE_SIZE);
 		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 		ssize_t map_len;
+		bool recovery = false;
 		void *kaddr;
+		long nrpg;
+		pfn_t pfn;
 
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
 			break;
 		}
 
-		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
-				&kaddr, NULL);
+		nrpg = PHYS_PFN(size);
+		map_len = dax_direct_access(dax_dev, pgoff, nrpg, 0, &kaddr, NULL);
+		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
+			map_len = dax_direct_access(dax_dev, pgoff, nrpg,
+						DAX_RECOVERY, &kaddr, &pfn);
+			if (map_len > 0)
+				recovery = true;
+		}
 		if (map_len < 0) {
 			ret = map_len;
 			break;
@@ -1259,7 +1268,10 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (map_len > end - pos)
 			map_len = end - pos;
 
-		if (iov_iter_rw(iter) == WRITE)
+		if (recovery)
+			xfer = dax_recovery_write(dax_dev, pgoff, pfn, kaddr,
+					map_len, iter);
+		else if (iov_iter_rw(iter) == WRITE)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index d7d3a7f06862..bf5e40a0707b 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1241,8 +1241,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
 	INIT_DELAYED_WORK(&fcd->free_work, fuse_dax_free_mem_worker);
 
 	id = dax_read_lock();
-	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), NULL,
-				     NULL);
+	nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), 0,
+				NULL, NULL);
 	dax_read_unlock(id);
 	if (nr_pages < 0) {
 		pr_debug("dax_direct_access() returned %ld\n", nr_pages);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9fc5f99a0ae2..fc9ee886de89 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -14,14 +14,17 @@ struct iomap_ops;
 struct iomap_iter;
 struct iomap;
 
+/* Flag to communicate for DAX recovery operation */
+#define	DAX_RECOVERY	0x1
+
 struct dax_operations {
 	/*
 	 * direct_access: translate a device-relative
 	 * logical-page-offset into an absolute physical pfn. Return the
 	 * number of pages available for DAX at that pfn.
 	 */
-	long (*direct_access)(struct dax_device *, pgoff_t, long,
-			void **, pfn_t *);
+	long (*direct_access)(struct dax_device *dax_dev, pgoff_t pgoff,
+			long nr_pages, int flags, void **kaddr, pfn_t *pfn);
 	/*
 	 * Validate whether this device is usable as an fsdax backing
 	 * device.
@@ -40,6 +43,8 @@ void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
 void set_dax_synchronous(struct dax_device *dax_dev);
+size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff, pfn_t pfn,
+		void *addr, size_t bytes, struct iov_iter *i);
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
@@ -178,7 +183,7 @@ static inline void dax_read_unlock(int id)
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		void **kaddr, pfn_t *pfn);
+		int flags, void **kaddr, pfn_t *pfn);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index c2a3758c4aaa..45ad013294a3 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -146,7 +146,7 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
  * >= 0 : the number of bytes accessible at the address
  */
 typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 8af304f6b504..79a170cb49ef 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -79,6 +79,13 @@ struct dev_pagemap_ops {
 	 * the page back to a CPU accessible page.
 	 */
 	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
+
+	/*
+	 * Used for FS DAX device only. For synchronous recovery from DAX media
+	 * encountering Uncorrectable Error.
+	 */
+	size_t (*recovery_write)(struct dev_pagemap *pgmap, pgoff_t pgoff,
+			void *addr, size_t bytes, void *iter);
 };
 
 #define PGMAP_ALTMAP_VALID	(1 << 0)
diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index af19c85558e7..287db5e3e293 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -8,7 +8,7 @@
 #include <nd.h>
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, int flags, void **kaddr, pfn_t *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
-- 
2.18.4

