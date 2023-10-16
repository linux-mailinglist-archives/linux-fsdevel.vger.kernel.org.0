Return-Path: <linux-fsdevel+bounces-391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609167CA707
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E741C20B1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA32262A8;
	Mon, 16 Oct 2023 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3k1PRWuD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06112374B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:52:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294A2ED;
	Mon, 16 Oct 2023 04:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdWqE1thXxGFfRkxhXJ28a4XP0cf9YYiXIusSkZQU80Ad2UGtKIJwMG+yKdQxqHQ9Q72X7kS9A4aoB0pCARQI8UndZW2f8ncInAmT4HI9DTpGXn1PBy0PW9DLSTMYt74kLWwP1ugPCmmmbq1XKfTezlW58hXLXlk5V1lvtzjEvR/cNgvNBx11y0y9A5SehCX7MYmKwfmK6WCEqrA84mtcPuj6bZX9b9Td5qj9cGuwOyJwdRL4KqR9PQYgtWCX3gmVPGE85aaPx4Ful7NwJIzDYond5XHlIk8zVrI9VCJwujiKSbO1bB3w1rI15LICaB2K7DFiGyCsDm04XrCOsrdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myaxqRX3xLPJ3eviVJraa3ck6aG2KJ+tPZVXN0+ejzE=;
 b=c3rqVGXrzBaazmwbnIyCKV0PFjg7Jc8TuW1ACP50TfTqtU2JIv4sKLDHZ9AxeocrHqgWFxcKPy4yodYYLHFyT/Iu8X9ddCsIJkEXbyaRnygMyqUzGwtdoOMI6OvrepBFZA4zTL5C4s8vDcfIFX3gBeuDjY7JxxwHsQmu38IbrPFiiwPlIwAEbYQILUOHw6ylboh+6K+zpSQltdJH7P4/JGm7nm7f60MFGAuLF6sfi4cK+5AukxRE3SxJ2428cwzwOyJd+DN31wckVxuHF8DIDEaQtqqU6q0fxjS+6hO6e55/1TFr002Azeyrs0LpI3cf57ZqUYFnTXpQFcIhXux2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myaxqRX3xLPJ3eviVJraa3ck6aG2KJ+tPZVXN0+ejzE=;
 b=3k1PRWuDUDkKPMFa/BhgH5GiUYoElydg2VQIrN0vPWW9Q5Rka4fHj8O/KIMt7kWO5EEFh+RHTqXXBknQH8e8ssF2r6unRpEL4YlwjDchRDo6eeYoWCITco0aH34QVit/STgdPtZ1fHd/Anav0cmkwLyxWhgHtVl99yp5zyOFBn8=
Received: from SA0PR11CA0140.namprd11.prod.outlook.com (2603:10b6:806:131::25)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 11:52:45 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:131:cafe::34) by SA0PR11CA0140.outlook.office365.com
 (2603:10b6:806:131::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:52:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:52:44 -0500
From: Michael Roth <michael.roth@amd.com>
To: <kvm@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <isaku.yamahata@intel.com>,
	<ackerleytng@google.com>, <vbabka@suse.cz>, <ashish.kalra@amd.com>,
	<nikunj.dadhania@amd.com>, <jroedel@suse.de>, <pankaj.gupta@amd.com>
Subject: [PATCH RFC gmem v1 3/8] KVM: x86: Add gmem hook for initializing memory
Date: Mon, 16 Oct 2023 06:50:23 -0500
Message-ID: <20231016115028.996656-4-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: a9010232-301f-44db-cfff-08dbce3e696f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2RFk8QZpR5yLnAalGBWGJE/kqNFJNqTnlKfS+FsLvRr820WRw/VCQ0AYvsOzlF7Tc6odA9wlHhaLrLgG+0EEgGgqbFHwEQNubWiTv7V/efgoQnC5QOfW5PMXql8c65SL2TA2tvHQWm7U9qWCGWLG+6qNdQ+3FcZ8C5EwbY6WNrsLFN8f03yHhcMjmEGYNwFm0tRda9vrfmIvUcegK5RTbJXEDZl2Gka/J4vPMRc43WFwTsLwOi+lhFAGJvVLIMx3FcxAly7Umf+DUJvw0P0r5dsfmdDhKp4IhXENEMdtsxipVEI9uxmMPsBwWEUjd/gQ+EhJEcJmFBZhjKaQkMSrrQKk96/lssvNDfSVXyiccwG1eaTaKw4Iqx62l6rAj73Ct1/dmoRShDSQ5JcEj4q+HNxqRmVgcC8MIy79oXVy0hVxvjUuw8Ib7jV+qTWXuszpQbqpKdiX9JawFwo98LdhOb7llB/lsBcHLoqZnBfkZLDFVdZVSXIFqLw8u0P95O6xm2fAHJUL7XE+LLyevhmuffTCFeI5KDsVLVuL48c6IN3KgcBffTfoJRBZ8QcwA9v3noSuM+wC6yLr1bV+HSwXbYVNaoIyff68tRHEjLF2biveAlODBE+xGt8QZ4uz+4sXrIsip9pOL1oloz6PiOD3D8ybxk5wshUbaAT8WQfRCmDmu/YabQvhhN+IyW5ZWJWrwNAVE8670XQpQvwEAk2NMOvWv8gSKyVmYOmCCjOrveqTIvc9YeuSA/+9lGjBhn7SJY6LFs63ADcGKdH9phU93g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(36756003)(40480700001)(86362001)(40460700003)(41300700001)(316002)(6916009)(54906003)(70206006)(70586007)(81166007)(82740400003)(336012)(356005)(16526019)(966005)(426003)(47076005)(36860700001)(83380400001)(2906002)(1076003)(6666004)(26005)(2616005)(8676002)(4326008)(478600001)(5660300002)(7416002)(44832011)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:52:45.4661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9010232-301f-44db-cfff-08dbce3e696f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

guest_memfd pages are generally expected to be in some arch-defined
initial state prior to using them for guest memory. For SEV-SNP this
initial state is 'private', or 'guest-owned', and requires additional
operations to move these pages into a 'private' state by updating the
corresponding entries the RMP table.

Allow for an arch-defined hook to handle updates of this sort, and go
ahead and implement one for x86 so KVM implementations like AMD SVM can
register a kvm_x86_ops callback to handle these updates for SEV-SNP
guests.

The preparation callback is always called when allocating/grabbing
folios via gmem, and it is up to the architecture to keep track of
whether or not the pages are already in the expected state (e.g. the RMP
table in the case of SEV-SNP).

In some cases, it is necessary to defer the preparation of the pages to
handle things like in-place encryption of initial guest memory payloads
before marking these pages as 'private'/'guest-owned', so also add a
helper that performs the same function as kvm_gmem_get_pfn(), but allows
for the preparation callback to be bypassed to allow for pages to be
accessed beforehand.

Link: https://lore.kernel.org/lkml/ZLqVdvsF11Ddo7Dq@google.com/
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  2 ++
 arch/x86/kvm/x86.c                 |  6 ++++
 include/linux/kvm_host.h           | 14 ++++++++
 virt/kvm/Kconfig                   |  4 +++
 virt/kvm/guest_memfd.c             | 56 +++++++++++++++++++++++++++---
 6 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e3054e3e46d5..0c113f42d5c7 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -134,6 +134,7 @@ KVM_X86_OP(msr_filter_changed)
 KVM_X86_OP(complete_emulated_msr)
 KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
+KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
 
 #undef KVM_X86_OP
 #undef KVM_X86_OP_OPTIONAL
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 95018cc653f5..66fc89d1858f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1752,6 +1752,8 @@ struct kvm_x86_ops {
 	 * Returns vCPU specific APICv inhibit reasons
 	 */
 	unsigned long (*vcpu_get_apicv_inhibit_reasons)(struct kvm_vcpu *vcpu);
+
+	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
 };
 
 struct kvm_x86_nested_ops {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 767236b4d771..33a4cc33d86d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13301,6 +13301,12 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_arch_no_poll);
 
+#ifdef CONFIG_HAVE_KVM_GMEM_PREPARE
+int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
+{
+	return static_call(kvm_x86_gmem_prepare)(kvm, pfn, gfn, max_order);
+}
+#endif
 
 int kvm_spec_ctrl_test_value(u64 value)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 8c5c017ab4e9..c7f82c2f1bcf 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2403,9 +2403,19 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
 
 #ifdef CONFIG_KVM_PRIVATE_MEM
+int __kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
+		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prep);
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 			      gfn_t gfn, kvm_pfn_t *pfn, int *max_order);
 #else
+static inline int __kvm_gmem_get_pfn(struct kvm *kvm,
+				     struct kvm_memory_slot *slot, gfn_t gfn,
+				     kvm_pfn_t *pfn, int *max_order)
+{
+	KVM_BUG_ON(1, kvm);
+	return -EIO;
+}
+
 static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 				   struct kvm_memory_slot *slot, gfn_t gfn,
 				   kvm_pfn_t *pfn, int *max_order)
@@ -2415,4 +2425,8 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_PRIVATE_MEM */
 
+#ifdef CONFIG_HAVE_KVM_GMEM_PREPARE
+int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
+#endif
+
 #endif
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 2c964586aa14..992cf6ed86ef 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -109,3 +109,7 @@ config KVM_GENERIC_PRIVATE_MEM
        select KVM_GENERIC_MEMORY_ATTRIBUTES
        select KVM_PRIVATE_MEM
        bool
+
+config HAVE_KVM_GMEM_PREPARE
+       bool
+       depends on KVM_PRIVATE_MEM
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f6f1b17a319c..72ff8b7b31d5 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -44,7 +44,40 @@ static struct folio *kvm_gmem_get_huge_folio(struct inode *inode, pgoff_t index)
 #endif
 }
 
-static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
+static int kvm_gmem_prepare_folio(struct inode *inode, pgoff_t index, struct folio *folio)
+{
+#ifdef CONFIG_HAVE_KVM_GMEM_PREPARE
+	struct list_head *gmem_list = &inode->i_mapping->private_list;
+	struct kvm_gmem *gmem;
+
+	list_for_each_entry(gmem, gmem_list, entry) {
+		struct kvm_memory_slot *slot;
+		struct kvm *kvm = gmem->kvm;
+		struct page *page;
+		kvm_pfn_t pfn;
+		gfn_t gfn;
+		int rc;
+
+		slot = xa_load(&gmem->bindings, index);
+		if (!slot)
+			continue;
+
+		page = folio_file_page(folio, index);
+		pfn = page_to_pfn(page);
+		gfn = slot->base_gfn + index - slot->gmem.pgoff;
+		rc = kvm_arch_gmem_prepare(kvm, gfn, pfn, compound_order(compound_head(page)));
+		if (rc) {
+			pr_warn_ratelimited("gmem: Failed to prepare folio for index %lx, error %d.\n",
+					    index, rc);
+			return rc;
+		}
+	}
+
+#endif
+	return 0;
+}
+
+static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index, bool prep)
 {
 	struct folio *folio;
 
@@ -74,6 +107,12 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 		folio_mark_uptodate(folio);
 	}
 
+	if (prep && kvm_gmem_prepare_folio(inode, index, folio)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return NULL;
+	}
+
 	/*
 	 * Ignore accessed, referenced, and dirty flags.  The memory is
 	 * unevictable and there is no storage to write back to.
@@ -178,7 +217,7 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 			break;
 		}
 
-		folio = kvm_gmem_get_folio(inode, index);
+		folio = kvm_gmem_get_folio(inode, index, true);
 		if (!folio) {
 			r = -ENOMEM;
 			break;
@@ -537,8 +576,8 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 	fput(file);
 }
 
-int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
-		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
+int __kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
+		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prep)
 {
 	pgoff_t index, huge_index;
 	struct kvm_gmem *gmem;
@@ -559,7 +598,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		goto out_fput;
 	}
 
-	folio = kvm_gmem_get_folio(file_inode(file), index);
+	folio = kvm_gmem_get_folio(file_inode(file), index, prep);
 	if (!folio) {
 		r = -ENOMEM;
 		goto out_fput;
@@ -600,4 +639,11 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	return r;
 }
+EXPORT_SYMBOL_GPL(__kvm_gmem_get_pfn);
+
+int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
+		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
+{
+	return __kvm_gmem_get_pfn(kvm, slot, gfn, pfn, max_order, true);
+}
 EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
-- 
2.25.1


