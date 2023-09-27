Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AB77B061C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjI0OEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjI0OEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:04:35 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F08136;
        Wed, 27 Sep 2023 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+3d3WtjAj0lDEjDiJ9PNllFhSy1ZGobjrU0fW3T0h4=;
 b=NF4nDok96mezm8R785usgKxZHS7MG/awe60vazpE6Q9E/PKbZcu3tKy2uBSeJt9EF9Xi0o2GVF2xAAuMrEktIo3ga6ol/LjaFYuJ6OorFTmVY42EhaTRXRA8m8H+X3nXoQ8CFdxInNNFmdfe2nl0hg3ibBBqa7u3BFtdnrvmA+E=
Received: from DUZPR01CA0309.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::9) by AM9PR08MB5890.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:04:24 +0000
Received: from DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4ba:cafe::77) by DUZPR01CA0309.outlook.office365.com
 (2603:10a6:10:4ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 14:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT012.mail.protection.outlook.com (100.127.142.126) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 27 Sep 2023 14:04:24 +0000
Received: ("Tessian outbound fdf44c93bd44:v211"); Wed, 27 Sep 2023 14:04:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 822792b906cea6e3
X-CR-MTA-TID: 64aa7808
Received: from f403f3766230.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 33AC8932-DDD8-4D7F-82A1-6681C690C1F6.1;
        Wed, 27 Sep 2023 14:01:59 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f403f3766230.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Sep 2023 14:01:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEg8SAGOL1fSKBKlLfGkoy24Ylg0N1c8yeh+6EeGDgdP1hRIMEsSyW6gzXYflw/YCzeDTcAoqkNugW3FzrTrxtnxI+lOXhG5KWuVVRDxnPrYerYzOfPBQUPSCh4lgKBPT0nf/lumps7GuTdiuemmEx7Vuir35J6eNTlZSTZ+u6t2+uoyOYuqbJ+/bvFtnbfL8W11HLtuj1b3XHHjoTK6BY5wL+rjKhjuK9O0aL+PUhrJ5SPcPlHB3H4bky0w0MKMNiBNaVv8TTixgD5Q/MX8DxnEZHAanoObD1ErTFhMpunLSzZdX190vLBw+IroV3/tjn0SaxI8vsh0Whb95I7+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+3d3WtjAj0lDEjDiJ9PNllFhSy1ZGobjrU0fW3T0h4=;
 b=HIBl56U+JwZ7glWeZ6ENESWAtKC/ORP/aY4byODAUKJmhyYsEiiZ5NnRogjs4KhoNxDxbCE/7QExVdDAKpCyDFsoOdyhTNQFz4oxf0vdGFqqOurGI+/m7oGesXqDxsGLK04wZmMTCUqcDL89sHdTGAcjzwPnAcI42DI0x5O5gmeRh6AOGhcIiabRLgJ8Emy1GLJOSbNj3VAwqSrS4BYKfAHzTmEdqpTtdSmfQPLYAA7YcTdWBGiSSZp8o8LHha5Q/zcbLiuaWX9C+A/RncviSNe/uuBv0rnVKtTccvIUxIz+75PnoIjw8Pz8XBWFdI5ZF3DMxHi7bebbRnoFN2Li2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+3d3WtjAj0lDEjDiJ9PNllFhSy1ZGobjrU0fW3T0h4=;
 b=NF4nDok96mezm8R785usgKxZHS7MG/awe60vazpE6Q9E/PKbZcu3tKy2uBSeJt9EF9Xi0o2GVF2xAAuMrEktIo3ga6ol/LjaFYuJ6OorFTmVY42EhaTRXRA8m8H+X3nXoQ8CFdxInNNFmdfe2nl0hg3ibBBqa7u3BFtdnrvmA+E=
Received: from AS9P194CA0028.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::18)
 by PAVPR08MB9844.eurprd08.prod.outlook.com (2603:10a6:102:2f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:01:57 +0000
Received: from AM7EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:46d:cafe::72) by AS9P194CA0028.outlook.office365.com
 (2603:10a6:20b:46d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT013.mail.protection.outlook.com (100.127.140.191) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 14:01:57 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 14:01:43 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 14:01:43 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <nd@arm.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <catalin.marinas@arm.com>,
        <dave.hansen@linux.intel.com>, <joey.gouly@arm.com>,
        <maz@kernel.org>, <oliver.upton@linux.dev>, <shuah@kernel.org>,
        <will@kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 20/20] selftests: mm: make protection_keys test work on arm64
Date:   Wed, 27 Sep 2023 15:01:23 +0100
Message-ID: <20230927140123.5283-21-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927140123.5283-1-joey.gouly@arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT013:EE_|PAVPR08MB9844:EE_|DBAEUR03FT012:EE_|AM9PR08MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ecbd38-442f-4204-ad9d-08dbbf62a7e2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EyOb/jb0Hqa5tSs21w/DbkrIQCGyFnNctzUo39KD5+XShfSSt+ZjHlpspexjwT4Q9Nx1b9eDNoSrQRI6RNW5vRIzjxeFHVmyEcUSJrsQRqU+3zSGofvyO7KA+aMheZ+xnJw3DwS9stEOyG3rgww1FZgA335Tvv/lIBrVMMHCDovsXxTNK8zHEJzwwILY9/XcDdKUHxnHvTPdgLxKRvkP6sq0485qAgKNCoGP8wQumtkuglm+KHk1GEyOfRgsJvRRmlFdPGrQxTBkMiZw5+iCXEalN2Qir+2W07qeQXDCRDOxgctCFfaVABUE6UUOxP4WEABvZcwELdshKWDs6TnBg6NBy//YEbG3eBcSMtWK4edxwhtWZrX1eFjXfAFa0uqGEksuXkp/V6OrTu8dqMUfBzvcJ5VUF721uySLf3hHKpUdpF0Gal7NL0nH7PvebUs+Yij/VTSyS8ruBBPOiCPvzS6YhCqquB/qG7bMk9f5A/QMYmcxnurbbFaUJwKhLxhJ0ElI4EhiFGlJ6HKTdLY99GaQE17pzazKvKttDJSHL8PfClD3C0GzZHC2pJaqVWySGSCH7LBSvsk1ml6vuGLM3fKdigWGtNTo3DoCCPODy2PSuHMa9xjbXDe/8LoImQpJ7veR4TR+qoG0tiEFmPGJBQaWvuMm3q28DoeZd0bs/PkjSuZ0mEVksdffJMGgnkP1CgAeSjJMvoLoZJpifeyfNXMnBh+Q7q0at8Qzr4dKm/BJg58BPCUpPQ+3bOfLNqpiJkhnmlWBo5objh8Yl9V3+g==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(83380400001)(70206006)(47076005)(40460700003)(426003)(336012)(1076003)(26005)(86362001)(2616005)(6916009)(44832011)(5660300002)(316002)(41300700001)(2906002)(478600001)(36756003)(54906003)(30864003)(82740400003)(70586007)(7416002)(4326008)(6666004)(8936002)(81166007)(8676002)(356005)(7696005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9844
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4d771c20-b065-41e0-8932-08dbbf624ffa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z99jhEPNVX3wQqkcqUtSSRJ2I7s8ga1kmDvNOsfVzJ5PnbmZzXJtZ7zlh1P1duoMxbKYmzRLUPjvqXWKyhqkbleYGrXPHxf9vZT8Rix8LtrvnZ+d39GXh0DVTv7crYQvQhwyv2cdJTjAiU8bzukQQejPAIP7hTsX2YzljOKfqswQtFYILQXvL6V1NewKrtzNSqCw0SA47K//Imal4/9NxM/hkLCWIgmZ2HNflhcXtRoZ83aqD0WdlEqjbrv7x9w/94AbQ+tRiBfoYU7+K7Wx4i0cE4ECrnMuiTUbkHU/koAtoXx0UVLQfuqJnGS9hVAFif8j6IOxAcy1jKrmikU6H0uoPV3lwUrkCyyDIpC/JnXITNyIqNWDwCmtyvWlDlV4JrKayrld33MhgaB0aGAlUMVJoVg08sl+clHCKEcSp2vTJvN5vskRfyol1G349LTAg1phFzCM6AkTraE9jlgg3qp8sgzY+ORjolrJTBp7jeU4GV2gysOcRI24qPG8TzQCMdv5wAuPw8diPPMJZQnDmxE3Z7t7nTb9arCCPXJJX4qQO/qK2F/97xxzSyb8qzNf77o0HfbdvSnk/ylJeeS9iD46fKB/tJSDE/lqxfenE+zCO/Il6XeDYoi3UcmoBqNuui+0ZErV8BVd4oqiViG2jCZ8kmEh2iQovk//+Timdb4v6HA0ubuuubZBZPBak5wUQ46xz5vxN/uW4s+nrgezAnN7udbSdT2aOdhTOmaaTsExjG0nF6VZfF7+ZwNdyBSH
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(316002)(5660300002)(44832011)(450100002)(36860700001)(8936002)(40480700001)(4326008)(8676002)(41300700001)(54906003)(6862004)(70206006)(70586007)(30864003)(40460700003)(2906002)(2616005)(7696005)(81166007)(36756003)(47076005)(478600001)(1076003)(26005)(83380400001)(86362001)(336012)(426003)(82740400003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:04:24.6783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ecbd38-442f-4204-ad9d-08dbbf62a7e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5890
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The encoding of the pkey register differs on arm64, than on x86/ppc. On those
platforms, a bit in the register is used to disable permissions, for arm64, a
bit enabled in the register indicates that the permission is allowed.

This drops two asserts of the form:
	 assert(read_pkey_reg() <= orig_pkey_reg);
Because on arm64 this doesn't hold, due to the encoding.

The pkey must be reset to both access allow and write allow in the signal
handler. pkey_access_allow() works currently for PowerPC as the
PKEY_DISABLE_ACCESS and PKEY_DISABLE_WRITE have overlapping bits set.

Access to the uc_mcontext is abstracted, as arm64 has a different structure.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 .../arm64/signal/testcases/testcases.h        |   3 +
 tools/testing/selftests/mm/Makefile           |   2 +-
 tools/testing/selftests/mm/pkey-arm64.h       | 138 ++++++++++++++++++
 tools/testing/selftests/mm/pkey-helpers.h     |   8 +
 tools/testing/selftests/mm/pkey-powerpc.h     |   2 +
 tools/testing/selftests/mm/pkey-x86.h         |   2 +
 tools/testing/selftests/mm/protection_keys.c  |  23 +--
 7 files changed, 167 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey-arm64.h

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index c9bd18e7c538..b6c591117d07 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -25,6 +25,9 @@
 #define HDR_SZ \
 	sizeof(struct _aarch64_ctx)
 
+#define GET_UC_RESV_HEAD(uc) \
+	(struct _aarch64_ctx *)(&(uc->uc_mcontext.__reserved))
+
 #define GET_SF_RESV_HEAD(sf) \
 	(struct _aarch64_ctx *)(&(sf).uc.uc_mcontext.__reserved)
 
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 6a9fc5693145..f50987233f55 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -95,7 +95,7 @@ TEST_GEN_FILES += $(BINARIES_64)
 endif
 else
 
-ifneq (,$(findstring $(ARCH),ppc64))
+ifneq (,$(filter $(ARCH),arm64 ppc64))
 TEST_GEN_FILES += protection_keys
 endif
 
diff --git a/tools/testing/selftests/mm/pkey-arm64.h b/tools/testing/selftests/mm/pkey-arm64.h
new file mode 100644
index 000000000000..3a5d8ba69bb7
--- /dev/null
+++ b/tools/testing/selftests/mm/pkey-arm64.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Arm Ltd.
+*/
+
+#ifndef _PKEYS_ARM64_H
+#define _PKEYS_ARM64_H
+
+#include "vm_util.h"
+/* for signal frame parsing */
+#include "../arm64/signal/testcases/testcases.h"
+
+#ifndef SYS_mprotect_key
+# define SYS_mprotect_key	288
+#endif
+#ifndef SYS_pkey_alloc
+# define SYS_pkey_alloc		289
+# define SYS_pkey_free		290
+#endif
+#define MCONTEXT_IP(mc)		mc.pc
+#define MCONTEXT_TRAPNO(mc)	-1
+
+#define PKEY_MASK		0xf
+
+#define POE_X			0x2
+#define POE_RX			0x3
+#define POE_RWX			0x7
+
+#define NR_PKEYS		7
+#define NR_RESERVED_PKEYS	1 /* pkey-0 */
+
+#define PKEY_ALLOW_ALL		0x77777777
+
+#define PKEY_BITS_PER_PKEY	4
+#define PAGE_SIZE		sysconf(_SC_PAGESIZE)
+#undef HPAGE_SIZE
+#define HPAGE_SIZE		default_huge_page_size()
+
+/* 4-byte instructions * 16384 = 64K page */
+#define __page_o_noops() asm(".rept 16384 ; nop; .endr")
+
+static inline u64 __read_pkey_reg(void)
+{
+	u64 pkey_reg = 0;
+
+	// POR_EL0
+	asm volatile("mrs %0, S3_3_c10_c2_4" : "=r" (pkey_reg));
+
+	return pkey_reg;
+}
+
+static inline void __write_pkey_reg(u64 pkey_reg)
+{
+	u64 por = pkey_reg;
+
+	dprintf4("%s() changing %016llx to %016llx\n",
+			 __func__, __read_pkey_reg(), pkey_reg);
+
+	// POR_EL0
+	asm volatile("msr S3_3_c10_c2_4, %0\nisb" :: "r" (por) :);
+
+	dprintf4("%s() pkey register after changing %016llx to %016llx\n",
+			__func__, __read_pkey_reg(), pkey_reg);
+}
+
+static inline int cpu_has_pkeys(void)
+{
+	/* No simple way to determine this */
+	return 1;
+}
+
+static inline u32 pkey_bit_position(int pkey)
+{
+	return pkey * PKEY_BITS_PER_PKEY;
+}
+
+static inline int get_arch_reserved_keys(void)
+{
+	return NR_RESERVED_PKEYS;
+}
+
+void expect_fault_on_read_execonly_key(void *p1, int pkey)
+{
+}
+
+void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+{
+	return PTR_ERR_ENOTSUP;
+}
+
+#define set_pkey_bits	set_pkey_bits
+static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
+{
+	u32 shift = pkey_bit_position(pkey);
+	u64 new_val = POE_RWX;
+
+	/* mask out bits from pkey in old value */
+	reg &= ~((u64)PKEY_MASK << shift);
+
+	if (flags & PKEY_DISABLE_ACCESS)
+		new_val = POE_X;
+	else if (flags & PKEY_DISABLE_WRITE)
+		new_val = POE_RX;
+
+	/* OR in new bits for pkey */
+	reg |= new_val << shift;
+
+	return reg;
+}
+
+#define get_pkey_bits	get_pkey_bits
+static inline u64 get_pkey_bits(u64 reg, int pkey)
+{
+	u32 shift = pkey_bit_position(pkey);
+	/*
+	 * shift down the relevant bits to the lowest two, then
+	 * mask off all the other higher bits
+	 */
+	u32 perm = (reg >> shift) & PKEY_MASK;
+
+	if (perm == POE_X)
+		return PKEY_DISABLE_ACCESS;
+	if (perm == POE_RX)
+		return PKEY_DISABLE_WRITE;
+	return 0;
+}
+
+static void aarch64_write_signal_pkey(ucontext_t *uctxt, u64 pkey)
+{
+	struct _aarch64_ctx *ctx = GET_UC_RESV_HEAD(uctxt);
+	struct poe_context *poe_ctx =
+		(struct poe_context *) get_header(ctx, POE_MAGIC,
+						sizeof(uctxt->uc_mcontext), NULL);
+	if (poe_ctx)
+		poe_ctx->por_el0 = pkey;
+}
+
+#endif /* _PKEYS_ARM64_H */
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 92f3be3dd8e5..07d131f98043 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -91,12 +91,17 @@ void record_pkey_malloc(void *ptr, long size, int prot);
 #include "pkey-x86.h"
 #elif defined(__powerpc64__) /* arch */
 #include "pkey-powerpc.h"
+#elif defined(__aarch64__) /* arch */
+#include "pkey-arm64.h"
 #else /* arch */
 #error Architecture not supported
 #endif /* arch */
 
+#ifndef PKEY_MASK
 #define PKEY_MASK	(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
+#endif
 
+#ifndef set_pkey_bits
 static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
 {
 	u32 shift = pkey_bit_position(pkey);
@@ -106,7 +111,9 @@ static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
 	reg |= (flags & PKEY_MASK) << shift;
 	return reg;
 }
+#endif
 
+#ifndef get_pkey_bits
 static inline u64 get_pkey_bits(u64 reg, int pkey)
 {
 	u32 shift = pkey_bit_position(pkey);
@@ -116,6 +123,7 @@ static inline u64 get_pkey_bits(u64 reg, int pkey)
 	 */
 	return ((reg >> shift) & PKEY_MASK);
 }
+#endif
 
 extern u64 shadow_pkey_reg;
 
diff --git a/tools/testing/selftests/mm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
index 6275d0f474b3..3d0c0bdae5bc 100644
--- a/tools/testing/selftests/mm/pkey-powerpc.h
+++ b/tools/testing/selftests/mm/pkey-powerpc.h
@@ -8,6 +8,8 @@
 # define SYS_pkey_free		385
 #endif
 #define REG_IP_IDX		PT_NIP
+#define MCONTEXT_IP(mc)		mc.gp_regs[REG_IP_IDX]
+#define MCONTEXT_TRAPNO(mc)	mc.gp_regs[REG_TRAPNO]
 #define REG_TRAPNO		PT_TRAP
 #define MCONTEXT_FPREGS
 #define gregs			gp_regs
diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index b9170a26bfcb..5f28e26a2511 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -15,6 +15,8 @@
 
 #endif
 
+#define MCONTEXT_IP(mc)		mc.gregs[REG_IP_IDX]
+#define MCONTEXT_TRAPNO(mc)	mc.gregs[REG_TRAPNO]
 #define MCONTEXT_FPREGS
 
 #ifndef PKEY_DISABLE_ACCESS
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index b3dbd76ea27c..14883d551531 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -147,7 +147,7 @@ void abort_hooks(void)
  * will then fault, which makes sure that the fault code handles
  * execute-only memory properly.
  */
-#ifdef __powerpc64__
+#if defined(__powerpc64__) || defined(__aarch64__)
 /* This way, both 4K and 64K alignment are maintained */
 __attribute__((__aligned__(65536)))
 #else
@@ -212,7 +212,6 @@ void pkey_disable_set(int pkey, int flags)
 	unsigned long syscall_flags = 0;
 	int ret;
 	int pkey_rights;
-	u64 orig_pkey_reg = read_pkey_reg();
 
 	dprintf1("START->%s(%d, 0x%x)\n", __func__,
 		pkey, flags);
@@ -242,8 +241,6 @@ void pkey_disable_set(int pkey, int flags)
 
 	dprintf1("%s(%d) pkey_reg: 0x%016llx\n",
 		__func__, pkey, read_pkey_reg());
-	if (flags)
-		pkey_assert(read_pkey_reg() >= orig_pkey_reg);
 	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
 		pkey, flags);
 }
@@ -253,7 +250,6 @@ void pkey_disable_clear(int pkey, int flags)
 	unsigned long syscall_flags = 0;
 	int ret;
 	int pkey_rights = hw_pkey_get(pkey, syscall_flags);
-	u64 orig_pkey_reg = read_pkey_reg();
 
 	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
 
@@ -273,8 +269,6 @@ void pkey_disable_clear(int pkey, int flags)
 
 	dprintf1("%s(%d) pkey_reg: 0x%016llx\n", __func__,
 			pkey, read_pkey_reg());
-	if (flags)
-		assert(read_pkey_reg() <= orig_pkey_reg);
 }
 
 void pkey_write_allow(int pkey)
@@ -330,8 +324,8 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 			__func__, __LINE__,
 			__read_pkey_reg(), shadow_pkey_reg);
 
-	trapno = uctxt->uc_mcontext.gregs[REG_TRAPNO];
-	ip = uctxt->uc_mcontext.gregs[REG_IP_IDX];
+	trapno = MCONTEXT_TRAPNO(uctxt->uc_mcontext);
+	ip = MCONTEXT_IP(uctxt->uc_mcontext);
 #ifdef MCONTEXT_FPREGS
 	fpregs = (char *) uctxt->uc_mcontext.fpregs;
 #endif
@@ -395,6 +389,8 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 #elif defined(__powerpc64__) /* arch */
 	/* restore access and let the faulting instruction continue */
 	pkey_access_allow(siginfo_pkey);
+#elif defined(__aarch64__)
+	aarch64_write_signal_pkey(uctxt, PKEY_ALLOW_ALL);
 #endif /* arch */
 	pkey_faults++;
 	dprintf1("<<<<==================================================\n");
@@ -908,7 +904,9 @@ void expected_pkey_fault(int pkey)
 	 * test program continue.  We now have to restore it.
 	 */
 	if (__read_pkey_reg() != 0)
-#else /* arch */
+#elif defined(__aarch64__)
+	if (__read_pkey_reg() != PKEY_ALLOW_ALL)
+#else
 	if (__read_pkey_reg() != shadow_pkey_reg)
 #endif /* arch */
 		pkey_assert(0);
@@ -1498,6 +1496,11 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	lots_o_noops_around_write(&scratch);
 	do_not_expect_pkey_fault("executing on PROT_EXEC memory");
 	expect_fault_on_read_execonly_key(p1, pkey);
+
+	// Reset back to PROT_EXEC | PROT_READ for architectures that support
+	// non-PKEY execute-only permissions.
+	ret = mprotect_pkey(p1, PAGE_SIZE, PROT_EXEC | PROT_READ, (u64)pkey);
+	pkey_assert(!ret);
 }
 
 void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
-- 
2.25.1

