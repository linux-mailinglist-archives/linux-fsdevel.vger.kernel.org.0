Return-Path: <linux-fsdevel+bounces-395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199747CA723
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C3DB20E11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21D5266C0;
	Mon, 16 Oct 2023 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LiJ5cNlh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A26526298
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:54:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DE3110;
	Mon, 16 Oct 2023 04:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKcwyWaH2V5slCwu1GGmFquJCgC00MlxtwTDBxQMht8d4HTSepokAevx8dXXZyILw+er28ORyufFvlQ35Rc4sqm9O7Wz7stwZJ/hwcI2OBoQLDhTYgJCtZffTiA4erizcR+JrQ2Zh6t17K6eV+M9fXK3W6Ut5DsZvRxEALjYYKUn9O19PMg50k9MRooRVcWcJsGJsS7DCLTq+zh87JWo1+gtXdEss2wrXMR2ODD3F+cwbAVQv3wYsyz+zBqx6+DGeZc8jmBQwbI9zezLDqaN63iVi7+cbOPExQCRzMWBzZ/XLPV7srpQ67L2sRXXu4oCToobnULaM7gKM7rXr8vowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqORnrIgc6WOHMaUpeIdBg/NVRKwm737btzZB/8O3pI=;
 b=Qd2cuUozEyoDfVwHvXHG5bpvrqS0d0XIy36wD4LQzU+OGXpY7m4F7rY6Qg4uFewUprjBW5ERMriEkWAs27R1/MyxYCx+TBI0QcPubgsBwHG12eZ/KaMCnDFxFe3LnrygSgpMlFu0M/ZkZSLFLMEzaehsOt+UFybh5qLWFIdif3o48rsOaQiHgOt3guk3ZgYVVu/ynTg0Fu937lD7B2VcT8y212UiqwJheDlXUzkywYvnz4DlikykpbflgqVlet8A8fdfwvZ6JFvyHXP3X5sz5Y1p9mdLdHXveWD8Sld19SHRaCWP2JrUcal6lAVnrJUkMmtFdrbUTUhs3Szx2CuBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqORnrIgc6WOHMaUpeIdBg/NVRKwm737btzZB/8O3pI=;
 b=LiJ5cNlh3+is/cI08/167mFwE2E6ZSVvjgeq1bNTT+IY3IhgJx9eMLj4oGPR0IcrXHjCpqZI6lM1bQ4XFs2IzN9yk0Rnj8eWm0PDZXWHjQuMAjPMI6FOAIEWH9RJ+nX5dG/ZKNK0lcCj5puT3mQaKwbNFrJFvzlBa5zHT2v0DuI=
Received: from PA7P264CA0067.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2de::12)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 11:54:12 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10a6:102:2de:cafe::39) by PA7P264CA0067.outlook.office365.com
 (2603:10a6:102:2de::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:54:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:54:08 -0500
From: Michael Roth <michael.roth@amd.com>
To: <kvm@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <isaku.yamahata@intel.com>,
	<ackerleytng@google.com>, <vbabka@suse.cz>, <ashish.kalra@amd.com>,
	<nikunj.dadhania@amd.com>, <jroedel@suse.de>, <pankaj.gupta@amd.com>,
	"Brijesh Singh" <brijesh.singh@amd.com>
Subject: [PATCH RFC gmem v1 7/8] KVM: x86: Define RMP page fault error bits for #NPF
Date: Mon, 16 Oct 2023 06:50:27 -0500
Message-ID: <20231016115028.996656-8-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016115028.996656-1-michael.roth@amd.com>
References: <20231016115028.996656-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e6cf73-ee29-40e9-93b8-08dbce3e9bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iQcCogIWGLFkVA9HrVhZpShcHnKlbXPqqnBqggNIn7hSjOjxLLrcr88J4XQNSiTMzcLPkD2FUx0dxTpV1/24OlVLhDlKiNQoA/XbDbSlaJ8/6Bi+MdKg/tSnchyTZC/5DwKyc9CNKP+DTp9MsN7jWVi7kuSnQub+rsrkKQsM3Lr7r9Sl5jgRTupzXOOy+K+Qu5cBWxn1idvaShNIk7OCbD7jfyKC+LKit5PMQUkxcUglJn9cVKVtBKTxBPh+w5V9VVrCBHn9ADCArALvZ/TP/+kGriHoHq00WAXK5AJM7f2SfBXW1J63XyYL3CvxfNBYi07buc61RHLjGsw1fxuCcuixoaEQGPiHPa2fqjLDt/OfPWxan+DbcFoX+/YOylnx3+ZUKGQt7vmBz5gD86hJXzdqgMSwNMK+nBu7ZuWFPHPKVW8eOMfG8CGEwcuPIkYqoVdRMCWOzgmy1ffR9qA0hbannD2lvkdoBqnqPpPozQFRRY7HownAshd1GCcE+JQnejJ0is1kAK+2W5abotqEFNa30YfoFqAOZlDLX/zYOfGYrFuNKBASuhG6mBKG95fV3WF6UUE3Oaiak1CSWrLBXFeOG1o6nMKBQC7OJ4S3A3wolMhQHaAgIgi/wo5xox6nkND1cBoUZfoUsc4uxfRJb3AHsxxLsr4zXtyXqLCRUJmARdkGctRhwSTXewMoT/xCI8JKUrTl32TyiSkmgrHXSVGB/DbEvsFOTddlBtB51gaD2JpSAxJY8MXUScFoylX1pvk+0HO+/gnFgMc9YnxORw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(82310400011)(40470700004)(36840700001)(46966006)(47076005)(40460700003)(36860700001)(6916009)(54906003)(316002)(70206006)(478600001)(70586007)(5660300002)(8936002)(8676002)(4326008)(6666004)(2616005)(7416002)(86362001)(41300700001)(44832011)(2906002)(40480700001)(26005)(82740400003)(16526019)(81166007)(1076003)(426003)(336012)(83380400001)(356005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:54:09.9758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e6cf73-ee29-40e9-93b8-08dbce3e9bcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Brijesh Singh <brijesh.singh@amd.com>

When SEV-SNP is enabled globally, the hardware places restrictions on all
memory accesses based on the RMP entry, whether the hypervisor or a VM,
performs the accesses. When hardware encounters an RMP access violation
during a guest access, it will cause a #VMEXIT(NPF) with a number of
additional bits set to indicate the reasons for the #NPF. Define those
here.

See APM2 section 16.36.10 for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
[mdr: add some additional details to commit message]
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/include/asm/kvm_host.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cdc235277a6f..fa401cb1a552 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -253,9 +253,13 @@ enum x86_intercept_stage;
 #define PFERR_FETCH_BIT 4
 #define PFERR_PK_BIT 5
 #define PFERR_SGX_BIT 15
+#define PFERR_GUEST_RMP_BIT 31
 #define PFERR_GUEST_FINAL_BIT 32
 #define PFERR_GUEST_PAGE_BIT 33
 #define PFERR_IMPLICIT_ACCESS_BIT 48
+#define PFERR_GUEST_ENC_BIT 34
+#define PFERR_GUEST_SIZEM_BIT 35
+#define PFERR_GUEST_VMPL_BIT 36
 
 #define PFERR_PRESENT_MASK	BIT(PFERR_PRESENT_BIT)
 #define PFERR_WRITE_MASK	BIT(PFERR_WRITE_BIT)
@@ -267,6 +271,10 @@ enum x86_intercept_stage;
 #define PFERR_GUEST_FINAL_MASK	BIT_ULL(PFERR_GUEST_FINAL_BIT)
 #define PFERR_GUEST_PAGE_MASK	BIT_ULL(PFERR_GUEST_PAGE_BIT)
 #define PFERR_IMPLICIT_ACCESS	BIT_ULL(PFERR_IMPLICIT_ACCESS_BIT)
+#define PFERR_GUEST_RMP_MASK	BIT_ULL(PFERR_GUEST_RMP_BIT)
+#define PFERR_GUEST_ENC_MASK	BIT_ULL(PFERR_GUEST_ENC_BIT)
+#define PFERR_GUEST_SIZEM_MASK	BIT_ULL(PFERR_GUEST_SIZEM_BIT)
+#define PFERR_GUEST_VMPL_MASK	BIT_ULL(PFERR_GUEST_VMPL_BIT)
 
 #define PFERR_NESTED_GUEST_PAGE (PFERR_GUEST_PAGE_MASK |	\
 				 PFERR_WRITE_MASK |		\
-- 
2.25.1


