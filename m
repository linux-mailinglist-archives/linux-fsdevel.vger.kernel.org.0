Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8B6C2712
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjCUBNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCUBNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:13:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE8724729
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUbIapaBPE0ZKndZqPHlVdnG9IkH6gHuik3WUG4LTPmNndKQNfPcyu6nQTWJ8ge7AFezAXSrf7DzhIzwTX8b8akBbjjThieuMWooEoZu9puHmgjTBh2EK4Hm+1xlzg4OitAiS6OT6zGPYB+vk0284xcJ/u1pSBmulfyOWxFdpZiEhsPLq86hEcz7PRgXtHW4TCDrH/iZ+qCU/Q/yzzREoCy7QX020gcAwvkIeDFcRxqnwr3loXysHWJyrWTxU/a0AEKQK0VR4lVSYaHv2VSp91Gju0D6B+FBHjXZvxsLwSqDWUlnFdJZN9eFd31efTa9JkLjWkJ6Uw8uPkg7Ny5atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TDD3Ew+jZxBSW/Rj2HP/zioj6WWLWDSMMK4me5hYQ8=;
 b=Hd1e/QI7ednz/xnQolwvXCj6jCZIrsSP6WmRq9dzeqPundW2/zM9V1uYSf55fhCvlYEYaqBl9IFS/BhFgqaOBgiuhWtt2UzehVJqm6ETg1DvhJ3QKvomKwF5GSkwbvfNXcP1mkfmlRNBcVlv5xNsZxkTzPfcb3Vyv2O8iHov19Y/aICJ0hYfH2RmTEFargPXEerCN73zPjlq61zMxv1668ySURgtuW6bGRluybN2kMCaVT90I5drL56MKAq9+nyrjxGvdRj18Upd0RN8sUB+ueN9Ajpw06rS+q3YGlJB6xxmlaI2xok6ITCGzs/nYnFY7IqsTAcWlFRrXHXKqZrGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TDD3Ew+jZxBSW/Rj2HP/zioj6WWLWDSMMK4me5hYQ8=;
 b=YnTZ3c/BcJ/BKniqPZbeEto9scvL3qSK/JYGPIxC768IGOI+66vyXxK27OTn1e+ChbvNc4nsJP1v0Zitrenb+USRNgZAnYyAXhuxVDdzQmQRh1ZSZJJ1Oh8GAupJP0/syx8fI+KSaGyRTP7Jo6xfcQNvMu8MsWP+Jkv8JFa4kUU=
Received: from BN9PR03CA0079.namprd03.prod.outlook.com (2603:10b6:408:fc::24)
 by SJ0PR19MB4542.namprd19.prod.outlook.com (2603:10b6:a03:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 01:11:20 +0000
Received: from BN8NAM04FT035.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::b7) by BN9PR03CA0079.outlook.office365.com
 (2603:10b6:408:fc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT035.mail.protection.outlook.com (10.13.160.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Tue, 21 Mar 2023 01:11:19 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 896042073544;
        Mon, 20 Mar 2023 19:12:26 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 04/13] Add a vmalloc_node_user function
Date:   Tue, 21 Mar 2023 02:10:38 +0100
Message-Id: <20230321011047.3425786-5-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT035:EE_|SJ0PR19MB4542:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 999a3d5f-b92b-4db4-c4e8-08db29a92d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3Rpr/N0YE5Zk0Z2K6VMKO7PBHxpD1465Vt2KMCbOOvlbTGoIlMm8Ft7TGJoyrzhkgOp9yhR7GRlgy2md9cZu8XkT/Vh63AznSM7kkzLcFTXWSLrz60v+p4e4YCyTx3TAjBSbq/pZBQXsBaQJW/aF9e0u4/eJ4w4Z/dRwFQxlpx9SvRexnP/jpvsP4jUl96cbiTf/228QV1ZGBktIu05MdliD60Neg+wVbUdIkbBgo8g31YCdOtOuna74LbwsGZtGVRV6oc+O4m2qfm1rhtyH6jwqqUSyhPEr7g7MOhbyuvZ+KI2QIiF/ygnw054T6NhdqVLNA1Nh+B3rqEjhABFtzShRU/9JucBwhTZPxzD2/doPFO76tPK6dXY7FmbC2NgE8apobhsC8LamVU2mW66kV6/hoV3WCR3x1gihDrqHA1PCRjhc/r9nBGd1/FUoGLxKqGB/Kjd6VfzdhPDWNQEOZFry+Bzij1q4uN0Lha57fsQ53MHsphEh9OgM1kABY32ZzSLX4cg4qvTRfB7G/ILKj2v3+z9OO/cCiR4PNOj/PFM6iSzkNHZ3l5yMXbqOhnwCsb6RNg3TFh5lJV619ab5uFcW2ZZI07wS+FYdj0vKxa1u+N/uZ5WSsGl+t/D1heL6yrwFJQpiqU1+IWLzbSObTWKJdkBA8sWwvGJHHb0E6xR6YFPUk2rvygZFyZM6cBcUIAIVm2fbIUO0XKO1VnTrg==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(136003)(396003)(376002)(346002)(451199018)(36840700001)(46966006)(54906003)(186003)(6916009)(70206006)(70586007)(8676002)(36860700001)(4326008)(478600001)(316002)(41300700001)(82740400003)(5660300002)(8936002)(83380400001)(6666004)(86362001)(6266002)(1076003)(356005)(26005)(2906002)(82310400005)(40480700001)(36756003)(336012)(2616005)(47076005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:19.2128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999a3d5f-b92b-4db4-c4e8-08db29a92d8d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT035.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4542
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is to have a numa aware vmalloc function for memory exposed to
userspace. Fuse uring will allocate queue memory using this
new function.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Uladzislau Rezki <urezki@gmail.com>
cc: Christoph Hellwig <hch@infradead.org>
cc: linux-mm@kvack.org
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 include/linux/vmalloc.h |  1 +
 mm/nommu.c              |  6 ++++++
 mm/vmalloc.c            | 41 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48aa3437..e4e6f8f220b9 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -142,6 +142,7 @@ static inline unsigned long vmalloc_nr_pages(void) { return 0; }
 extern void *vmalloc(unsigned long size) __alloc_size(1);
 extern void *vzalloc(unsigned long size) __alloc_size(1);
 extern void *vmalloc_user(unsigned long size) __alloc_size(1);
+extern void *vmalloc_node_user(unsigned long size, int node) __alloc_size(1);
 extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
 extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
 extern void *vmalloc_32(unsigned long size) __alloc_size(1);
diff --git a/mm/nommu.c b/mm/nommu.c
index 5b83938ecb67..a7710c90447a 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -186,6 +186,12 @@ void *vmalloc_user(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc_user);
 
+void *vmalloc_node_user(unsigned long size, int node)
+{
+	return __vmalloc_user_flags(size, GFP_KERNEL | __GFP_ZERO);
+}
+EXPORT_SYMBOL(vmalloc_node_user);
+
 struct page *vmalloc_to_page(const void *addr)
 {
 	return virt_to_page(addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ca71de7c9d77..9ad98e6c5e59 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3367,6 +3367,25 @@ void *vzalloc(unsigned long size)
 }
 EXPORT_SYMBOL(vzalloc);
 
+/**
+ * _vmalloc_node_user - allocate zeroed virtually contiguous memory for userspace
+ * on the given numa node
+ * @size: allocation size
+ * @node: numa node
+ *
+ * The resulting memory area is zeroed so it can be mapped to userspace
+ * without leaking data.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+static void *_vmalloc_node_user(unsigned long size, int node)
+{
+	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
+				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
+				    VM_USERMAP, node,
+				    __builtin_return_address(0));
+}
+
 /**
  * vmalloc_user - allocate zeroed virtually contiguous memory for userspace
  * @size: allocation size
@@ -3378,13 +3397,27 @@ EXPORT_SYMBOL(vzalloc);
  */
 void *vmalloc_user(unsigned long size)
 {
-	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
-				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
-				    VM_USERMAP, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+	return _vmalloc_node_user(size, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL(vmalloc_user);
 
+/**
+ * vmalloc_user - allocate zeroed virtually contiguous memory for userspace on
+ *                a numa node
+ * @size: allocation size
+ * @node: numa node
+ *
+ * The resulting memory area is zeroed so it can be mapped to userspace
+ * without leaking data.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+void *vmalloc_node_user(unsigned long size, int node)
+{
+	return _vmalloc_node_user(size, node);
+}
+EXPORT_SYMBOL(vmalloc_node_user);
+
 /**
  * vmalloc_node - allocate memory on a specific node
  * @size:	  allocation size
-- 
2.37.2

