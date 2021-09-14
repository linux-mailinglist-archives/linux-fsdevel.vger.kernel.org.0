Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD140BC3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 01:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhINXds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 19:33:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5534 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235834AbhINXdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:33:47 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EL04wx011635;
        Tue, 14 Sep 2021 23:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=2tBXA9Uh3lTdHXRUc61H0CY1PM/tJaanzmGHlrAge/U=;
 b=kxgb+xTtutmrEIJ9IKY4Xs2MaZScf+NlN2tqlFNflQgZavYpmVY4ALIH4CLMei14YXRq
 YcZM5wDETY6h3l18kRMukyXGrLl2wnxKFoL72+ji/rGUiv94AcC2IDQRVnjT/tbJxdGY
 KtnhTnYSwLBDQ82N2fk/GY/+CZCQ43bvLUPXqLc64R8cIWudeDcTKfIE+qQFKJVh1vCo
 uWca5uLsDy3IZ2WLia3jWk7JQmoMJ53n03u+H4oYwWgFX37qbRYX0nSkpEcWRVlBdxfA
 Ai2rgSABnorKXjxf5IvMoVWTX3AN5uDB5Dn9kv0dcFFi/oQ3zrnpkutrD3DzzxnLbzmZ tg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=2tBXA9Uh3lTdHXRUc61H0CY1PM/tJaanzmGHlrAge/U=;
 b=tq2qB00kCO99kPUZTCvQQgBdBy1ZStYmxtj/jLoNpw/MBED+u+Bkz8wBidUdpYLdcY0t
 U67fmpO2OHq/kIfayc64eDIkYyPIhChVo9WD/ILA+Fj74T4dRZkW71no+JDVxUYxYg2f
 sTsWOBU54n54sOkBcg8J9/l0qjIHRfT0s42xkwsgB9veX1L1qvHv7ydb7/b441ttlbb6
 9U0jrbXJOFHI1B+qq/ryNRvE0MjlXT/wXTu9cwS+53yM9XVDTR7Z9ed8WXvo57DZRXIX
 //yiIuGP4y4l9wJdGQWBevpaF6j9NJQSm55j91aqSkNwR0TVatxXyoUSZIxc5FTs1yQu ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2pygavgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 23:32:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ENUnOh024949;
        Tue, 14 Sep 2021 23:32:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3030.oracle.com with ESMTP id 3b0jgdt4kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 23:32:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rn+fJytbPCD9/Sywf2QiZk1EqzS9ToKaqhXwvMt0ltOgO+rJ0VCo8I5/vaq7g2F9y2FU18jFSEvw5jFnLm+HbLtsc5dwlgrAPst5wBaFtBAzJlIvMTAG0qTzLLKjEMHHDq4m7PySpFF29lnMEtl8bv+cxgfj9zTFe8fj4byABho/Hsxn8XtPvEZMS6zJUD+RTvw908kcIBoq0npsIYk+I7Ol4luYn4bcv0CFobw/pTQI9o5Jd8UteF8KH6aTKXBTOg+7oSZj6p51L8m8ou8VQP4wJAcadohcyU6/DPjEjWFZ02jXd9KLGL/44NA8pwG5sYx1GopjOtLibv+wgDp27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2tBXA9Uh3lTdHXRUc61H0CY1PM/tJaanzmGHlrAge/U=;
 b=iPDDWShnA0rM6vKEwkLVl6+7hMftJMF55xIKy+9p80A8jq5NGZogZ+dpkQv4S6/hFLTt4ELXf+W0hmecGm9j9u4/e1l5FMw6Y05coRuQ6TRH6VNeX29wKFCfpQy5mVg0aguw6mctyjeTjhqvRomZMv3QFWrVg1wRg/iylaRHBYdtT+1S0HDRXxkY6Hnm3xebviQ7k1KXTFfy6yxHx/sqBqrSAGXgeoXtD6N0id2b2MNf84pqeTHveiv65fl9hnzw6EeCyhwObpZHzLwE8Urt3hJrbTPkZUh2lekRWv5FiqgdfrtMyqk7T0i+DHGtArQPXaQIltAgls7BdfklTE2LkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tBXA9Uh3lTdHXRUc61H0CY1PM/tJaanzmGHlrAge/U=;
 b=Rc8iY5zhCFLf0vEoiAqtl3+RssWXe2vK+6zif1T79JR8a5rAfDp2D2T/xrmbUiX9CYlNGKqR1qkfhHuzlkNOpXH+Oi0syOMSUaz4DlJDzseKPlKKZ7OtO6rWUbGvg77k3QDDKz8EoF5yi8ofkUxc/c8GUdKMTIRF83pxiWXrLmQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4035.namprd10.prod.outlook.com (2603:10b6:a03:1f8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 23:32:02 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 23:32:02 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, jack@suse.cz, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] dax: introduce dax_operation dax_clear_poison
Date:   Tue, 14 Sep 2021 17:31:29 -0600
Message-Id: <20210914233132.3680546-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914233132.3680546-1-jane.chu@oracle.com>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0601CA0008.namprd06.prod.outlook.com
 (2603:10b6:803:2f::18) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1b) by SN4PR0601CA0008.namprd06.prod.outlook.com (2603:10b6:803:2f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Tue, 14 Sep 2021 23:32:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50597918-d137-4a9e-c65a-08d977d7da89
X-MS-TrafficTypeDiagnostic: BY5PR10MB4035:
X-Microsoft-Antispam-PRVS: <BY5PR10MB403598AE916C3A6B3C8E2DF2F3DA9@BY5PR10MB4035.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQ0hzQYDIQkpCyPyu8nUwfu7dNe2kgmKf0lueY93ePgrmLqlmaAFnL/LtjB31DhHtSjahKGUthGAxJC95cTxui1V4lhCGPlyWa4xEBFUXrMHu4uTNwX1kjxA0jUKVdk9xGKPnCjrII989XSfHd1+CINJOEZ24CmdeJmrR0wz2VcTiXO0gE0JPdBm8Uw9bESQgVXuqOpbcPYBHm+ibp1xA1Cg7K+zNlLorxDu8nF4O2UAFBe65vDNgLy4f2LEWuSDHeUSDkAAPWv8Bfb6MiW8SZfFuhqaFeyA2G4UySz194LJMVMDdhPGK5tu2osL0aWtEbCsywQ7JpihkrXFroNeX7FK/jUgH9xya83Bhzun9IaxEk/u3fFHUkrP5+jAa64B2oXg1cmoXAHP+5Wr9T/Ge0XJA6jJGV6FcIIOQnRp3TNTSBrqsUoznZQDeg6GKtIrqcx7imUW+puSfWRjXHDzAfah0FNyYx1vDx1og6YHE9vxgJQITwNnRAB6enmk4Zp542Hd+BCn0mZydITVrJAGGIxegJ6JD+1YfFPMiXdxXpIEZSX3IfXlZqS2DQbvkuRi+LYUuZqFAriP8m24N1YU7epfsfUx8qGHz7jwfgFW8WJPsycqccL3fit3vMut+gERD5STw3PDKdFyQB/pqagXzIAzVQ4VNGZOXqNuedPyM7Wvn30Y+3rPQlzkxQArnr8y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(39850400004)(346002)(66946007)(66476007)(921005)(1076003)(7416002)(66556008)(52116002)(7696005)(36756003)(316002)(5660300002)(186003)(8676002)(38100700002)(8936002)(2906002)(83380400001)(2616005)(6666004)(44832011)(478600001)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0trnjnlgmfEoRwINUmGWJGEGFRHsRVf7lAKjCW1ITJl/iR6U4kRpnaG5/vQX?=
 =?us-ascii?Q?LzYnlS55ZyXlAzS1iOdLpiWuGyvsERo8oUyEtIlfhbK8EfGjURfW5zFXt1F/?=
 =?us-ascii?Q?NrMYY+v5X6sTRPlr8sYEchBshsYf9eNM2vwV1SmAdzROqDFiBYH8c5Zv2Zs9?=
 =?us-ascii?Q?3FX2ZCuZaxpcVMGmO7uRvqP9VsrwP7KAeKB0x9p9dMraJRUzmh8AZBHPTexb?=
 =?us-ascii?Q?hHKe5g49rih5DJQnCuwAsBUApuk1WCrKQxBy2hg3L3D131dyoHYVSs9x83ez?=
 =?us-ascii?Q?qXyuT2O3DtD+OqwhY7o3BvDW3XiXEnmKj1zoLQGP/GIGX56CBTd25YOw/5Cd?=
 =?us-ascii?Q?zwxkHlKNsYEEFHWoPbHypMMUMmH4wZtMEf5+ibQ5QR9fAx83q3Wpuozov0Xu?=
 =?us-ascii?Q?+fsLgFEROZv1JAipzhlsMB3mYTNZ5Mw9lw0wE6YRHKUJPgjMVuIfiHgNYxNB?=
 =?us-ascii?Q?/v/NHbbHu8ohTd2aCoKfb2LycBUtKF9Xqhvt7qBzrF7Xg2mUWiA7suBpsldp?=
 =?us-ascii?Q?D2OUtPu3AxlvJyZ7W06pzofkp0/y1PSFEP7DBxbbDvGU9ZFO8Zhc6RuFPGX4?=
 =?us-ascii?Q?L5NqK+dXcrFYobBIyJyGdNtE9x9rpVhnv1l5BnMIboUydV9IXzIqVCkfVfmB?=
 =?us-ascii?Q?aHT0eVhu6j3OqaJEOHm0MdZO2G8cD8f8A1GKyGVRoPvp/hEucl1Q1Y5XPShl?=
 =?us-ascii?Q?0IGynqJ1CErUq5O9IGbadFjeainIJYXnklbO9/1Fzkx5bqH2VKAsT+8Jm3Dm?=
 =?us-ascii?Q?5ga/8wxbOffwemcgFkj7GwvyxpR048mvBU4iUzuevWktisEcus8En0bJpLCE?=
 =?us-ascii?Q?q4s0GzGxCIH45PHqydJ9uQS62xmzUJ3ax+JNLJM0Hdp2pI+8mjtHye0w7105?=
 =?us-ascii?Q?3CLvG4gQs8gc+Yng9ZXIoJ4kfnkQX47uJpt6+kKoolKb0ZenCOMUQ77cV2u4?=
 =?us-ascii?Q?IwTwEzW/rJxzErAyYwUcIS/v25Ni3N1msH7dq8PczIt93afB6dl4xxkz/M3L?=
 =?us-ascii?Q?JmF7Or9k0Z92s6hwNFwI9AhzYO0YGy1F6agjlheA6r8SpuaLJnQ+bCKjrfed?=
 =?us-ascii?Q?i4KaG9hKWwFDF70+yVeFnOjFGGV3DjdigWEc0mic+VlbJblvHeOsGTSvbPcC?=
 =?us-ascii?Q?X1GGb5gmRyJ/3W9zHyWjZUTSF+5SuRe6BxEd/4OzenjYvvk0y8kjwAmUKTRr?=
 =?us-ascii?Q?YU9nRNBObN+KdWv8/h7KKMhQcQeFqgXnKhpDyXxVskaNXaafzYTfcyIFFXpW?=
 =?us-ascii?Q?xAcXkaYEkXSzwe1MPqq89ZTCyqaOICX0puq0B2zEHzTcEMw56dlOlhhpH4zn?=
 =?us-ascii?Q?Wkm9hd9d+7Egb+w+i9CrBfaWasL453TpXOmLD0FfsfLTZA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50597918-d137-4a9e-c65a-08d977d7da89
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 23:32:01.9494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2XulIQv9v2bYQktZei17w0bsK5wgeAmRmUmI0+dj7DJhnjMIkDj6nyJgH3Gzol9wO2zJKJOUvU2u3xqO5QHJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4035
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140134
X-Proofpoint-GUID: qWFLTsIyJOG2QaOVWQ2WLTG53j12M2nX
X-Proofpoint-ORIG-GUID: qWFLTsIyJOG2QaOVWQ2WLTG53j12M2nX
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Though not all dax backend hardware has the capability of clearing
poison on the fly, but dax backed by Intel DCPMEM has such capability,
and it's desirable to, first, speed up repairing by means of it;
second, maintain backend continuity instead of fragmenting it in
search for clean blocks.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/dax/super.c | 13 +++++++++++++
 include/linux/dax.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 44736cbd446e..935d496fa7db 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -373,6 +373,19 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
+int dax_clear_poison(struct dax_device *dax_dev, pgoff_t pgoff,
+			size_t nr_pages)
+{
+	if (!dax_alive(dax_dev))
+		return -ENXIO;
+
+	if (!dax_dev->ops->clear_poison)
+		return -EOPNOTSUPP;
+
+	return dax_dev->ops->clear_poison(dax_dev, pgoff, nr_pages);
+}
+EXPORT_SYMBOL_GPL(dax_clear_poison);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b52f084aa643..c54c1087ece1 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -36,6 +36,11 @@ struct dax_operations {
 			struct iov_iter *);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
+	/*
+	 * clear_poison: clear media error in the given page aligned range via
+	 * vendor appropriate method. Optional operation.
+	 */
+	int (*clear_poison)(struct dax_device *, pgoff_t, size_t);
 };
 
 extern struct attribute_group dax_attribute_group;
@@ -226,6 +231,7 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
+int dax_clear_poison(struct dax_device *dax_dev, pgoff_t pgoff, size_t nr_pages);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.18.4

