Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ABF5F38D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJCWWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJCWWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:22:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20719.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::719])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B452E70;
        Mon,  3 Oct 2022 15:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEE53YJ5kYmxd8rsjV6ZkpKLi/EyQVjAlODnvvehz1n5Px5BCDrIpAK/ohIFrUKFyI6x6axzJ8b0tq7fnBY25WtVNccJyI02+6cpI8B/H+BtVKEoxcgMUPBaJmWyfXROLGZ8AZn9itTkzO4u3tREcxy/LD2g3E9a8/HwgO8nVCa1D9KvnLWyfo6QZEsbmKQqqkpa9bz3DuRH0Mc66HVmnSGkGPbxj2H52dmgKGtcGrtFweBN5KSrl+dFlEeFG88hXmw9g4dqNLO6l4rJ1TIzEZtPKuFzdbdAXy7CAty+MDHSEPkaZwlAvUzKWMYe9h/ZxiwLolwxGUxGhYJ173G4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZTIAXW3PIYT2vnKgz/NB6QKRzbYwk7TXNTYR7IO2XI=;
 b=E2CEEQQc/EreV/q+mwSKwcDL43tp787xFZL0THkeSu/F+qBnv5SX3Fhm8WsOrohgHSVBlhCgeISvgzNjNffj9H6OuYvIaucL25pnvC4L8pA8chrq83x36tcKqhdZKIlauz8PBwJeRDewuC3Ede9NMi254HLUuFQm/UDSepHoHPdBz4oo5j/LCS/AxDqbhXOBX4JjwHGswUZ/C7I7sD1kBrLknFxBXtqJIOEMb36pUWrVbUuuWuZ/AhiLdyS9zvPjlydT5Hgji4ShZNMg+qbwqoJnaOs0rQajYyBDK5wR24WPLOBteePA0NOzXzGxk5NJeBD6IdJ7h3GLrAnRTEk11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZTIAXW3PIYT2vnKgz/NB6QKRzbYwk7TXNTYR7IO2XI=;
 b=sNFDzkgxRGYu/Ac/deVfqkjVVAvj9EMO7hsGbREtAm2VexlzUHxe4d3jZd6Ue/39wN+mfCaV3NQNk9aELVqPIC3cd31oPhIYPWC1ZZUAefIeuROAV3Pz8Wjtor5fTEaa+kNeCkqsufS6VG68AvXbwix3S0aOMaG6P2DJzcQ0r+4T4xB7GejUKd7lRHySImSw9ZZAHLF/pCovtplgFn7nXM41PKTHTsC8+5CFNGvtiju/5kXL4tAqIB4dMYd6oCBto3Lc02Eb4AixeJgiTNaypqyT6agmS2PQPWX1LUMiV/ZJsh82LQvoPzv87E3SDuseNAslWMj4hpbOXDwQ84ZBZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by MN2PR03MB4928.namprd03.prod.outlook.com (2603:10b6:208:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 22:21:57 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 22:21:57 +0000
From:   Ali Raza <aliraza@bu.edu>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        pbonzini@redhat.com, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org, rjones@redhat.com,
        munsoner@bu.edu, tommyu@bu.edu, drepper@redhat.com,
        lwoodman@redhat.com, mboydmcse@gmail.com, okrieg@bu.edu,
        rmancuso@bu.edu, Ali Raza <aliraza@bu.edu>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [RFC UKL 03/10] sched: Add task_struct tracking of kernel or application execution
Date:   Mon,  3 Oct 2022 18:21:26 -0400
Message-Id: <20221003222133.20948-4-aliraza@bu.edu>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003222133.20948-1-aliraza@bu.edu>
References: <20221003222133.20948-1-aliraza@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:208:d4::44) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|MN2PR03MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 24145433-6598-43c4-d244-08daa58daee1
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOOEsiurEVHVZPTgyLZHoiALIhwmwQ/3hcPPn/BBLpsFkqCP+lp4XS9yLCwLyFSBx1k/eOKnaqwoaeKBPGLilSG34EZ59ioJRRP/H+Vmj9VDnX+D936CVI17gd+L7xKT2Nu3kFg+no5sQoJV11m3B6duceVWyklNo+XfHpmcgevqgFs+gxl9BlCJG1Jy45kLANWqEZykc/OlWcmbHcS8wFLWdlFysxQGMzbYbXfv0wO0V0RA6rKnFbg+1CQn1rmH1kgsPZQefDcvkiUjmRpAy2CKmUxWsO5sWj6cC8/U+gSOTM6R9qIiEstYyaCmjiTNGgIFyzyTO+YFuNL6E09adqoiSKoV1dXbLENRYGQlPNdbwl33dOyZ6S3KfojdzeijCUjokkU0wjVywpwR1oSMhE01QChkTeHyAAdwUAihji9jv45/V6F3hEIoRJoodJTmCo37CawIUmuQpSgonqrHEjGVClMqwMSyV8MMAnPki+P9b5DWBx+iESYyi2iPGEoSNCGsr3kUKTzUyrACNmzy/5dXJZj+cXnVE+slkI2mFSrQpeCACSFL5MKGlieTmEzl2rwMblCP2seAKeurd8IW86b+cT8BVhe7wAsq0zzAYjF63LgToZVHwOCzwJOOOx4pwClWSGJItyFFLkCmYYJEupKlP0W2+k/nC2msMYiSp1/WkWS7UqHuE0+VWxcm1lBCBlobFBEyDemP8SLc50nH6biwP4kq5wqOVaNTGOfO3EM4rNW9Z687f2FWmPJrdssEO+sy3u/S5tUtreAyJqXpyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(8936002)(7406005)(41300700001)(6666004)(38350700002)(75432002)(66556008)(66476007)(4326008)(8676002)(1076003)(186003)(6512007)(2906002)(2616005)(66946007)(52116002)(6506007)(36756003)(5660300002)(7416002)(26005)(86362001)(41320700001)(6916009)(54906003)(38100700002)(316002)(6486002)(478600001)(786003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tpN28o5aaoXqE4QPVDjmZQvWwEwRt/hl6t6pe5o4Av9Pe8nIS/ivtFHMeGTy?=
 =?us-ascii?Q?wLL2TR5uc54wu2f6dlzi8Cdp+3bamXXwixJAjUTnJgtx25aj0ewisrAeYSCo?=
 =?us-ascii?Q?fFf0CSn1bDWlfJP9B3kAqhYNTYBKBN0Bp4XwFgrRRFh+Fz4k0nsn7VjmGezL?=
 =?us-ascii?Q?Eiyf6g1U5Nl8kyvqyWpxIGr5uMZ8G0H8ata5sdpga833dnr+Tx2C6mKET59e?=
 =?us-ascii?Q?uTuKR5Wgk4Qd/KaumJ0j5IdGiSkWZgp0fNLkJ/YLOsLadCG+0NoqBpZQrg8/?=
 =?us-ascii?Q?MQjw7eNc7JQs6XgITlN0quDKJixGYcmCWYTESNY5yeRPX7GUWiJLLxc/wwK8?=
 =?us-ascii?Q?NsC0DdHMZRl6gfpml+QbkhN06AcONV5IKa+5tM0JO2jplQ4FCfTTaLohLmyV?=
 =?us-ascii?Q?Z9yTXkiQwlgpJc4HHb3tydtGm89MxOlhlBowzrFwCHg/rZiRBKb4JfBz6OoD?=
 =?us-ascii?Q?lVFi0k8tSUse0hP6RmimC0gfAL1RW0p4LiJQTMu5okvS0EV5f6+5U6SeN8Lj?=
 =?us-ascii?Q?wX76E/qIOb4nDsCUi4sQTSQ3dLMEGlwAn1O9PpN3X5lISPXnuMY7Itm/3Zll?=
 =?us-ascii?Q?Wo/ntjb07Iwu7f3dJ138aEoRLgRuErHAvlWjC2HJU1cB370mj9UokoOKK5U6?=
 =?us-ascii?Q?CQE7WSD1jy1EnqR2Cuih/1leJ1WNrxeJIjAMIHJkWxsXCWEDiQ6ZmUX6sRmn?=
 =?us-ascii?Q?+fP4uCaBeb8Ln7fyyLfhhKmbUcPIBN4HPuMvaEhHhXBeZczw3/4aGPuYXbW4?=
 =?us-ascii?Q?j5mpb1Mq0LR+g0QI72iyx6p95X0yksQfqGR6VkT/88agGjz6rMmP2Lqsan4A?=
 =?us-ascii?Q?/WMBekIJmEcEb/marQJCItskROtfJNBm22DfDGQ6XQLmJ9MltcHflw5jEZWM?=
 =?us-ascii?Q?it/lgNIC3rzqCDdFXb3qcHiAl/I2C1AC7f5s2T3Q7/Fzgl/2BtFtjpUmhvuF?=
 =?us-ascii?Q?z9Zi4Ke28bW/8BkyvDSaxTDenQ4g6TqQ2JSeSdb4rKRMU1QKx8I3bse4J6gK?=
 =?us-ascii?Q?6t7NRcWX3D721SW/COrCVw/MIZi2fSsjbtGTjHe4BF5b84Hg25jdMTXQ8/Lf?=
 =?us-ascii?Q?yzLpAiIRqFlxlnu/wfaxiWy0YZLuPPfO9veLgGBUQBRqcKZFB9xotr0Jtica?=
 =?us-ascii?Q?z1fEh/xTM7NPAqPYmOY4oCHmGR463Ch0yrgzKMbg5FZFtm0jtC/5o7la1inH?=
 =?us-ascii?Q?avonBOpewjZXgPRkpObTBQVGbSZe/no/Po68jMHUo7HPI0WyvUI6rNnCJU4m?=
 =?us-ascii?Q?BgHCW9p7CLJ8rcNlOuVLvKE6zofubWACyWNUf6i/ke15QsTA+4bXypMbt/hZ?=
 =?us-ascii?Q?dnnsOoUoEPPFhg00ALgjZDK6NJwy2kQKIehDguZSJqyfyffieV5XsMZZ2TmX?=
 =?us-ascii?Q?M3IbrPSZzy7vS/SJa+BC7V38BLdHvMAxNxiDVk7n3KIXglR/hVfpSwiKnBDJ?=
 =?us-ascii?Q?1SCrBHzmQEK/ERrTru07tg5j+uw6HkjMFH4YGTFXp7Cg+vzRAChGcOgQCnMN?=
 =?us-ascii?Q?gb/JAoK3swfGYZFgWmAKopeMRxVVaDtV/e6PC3unq8zSIdFSMqF7EilZtAwu?=
 =?us-ascii?Q?+NIoxnBAh4NJQDswI3Pip0UYn4pTx1bwnv75rI+C?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 24145433-6598-43c4-d244-08daa58daee1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 22:21:57.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ff8u7t47tT+cHI7Uzv+saWmkINimrz8m7lftvladVsrm0ZjzohA4Q8XwHGFVOBoF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4928
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because UKL removes the barrier between kernel and user space, we need to
track if we are executing application code or kernel code to ensure that we
take the appropriate actions on transitions. When we transition to kernel
code, we need to handle RCU and on the way to user code we need to check if
scheduling needs to happen, etc.  We cannot use the CS value from the stack
because it will always be set to the kernel value.  These functions will be
used in a later change to entry_64.S to identify the execution context for
the current thread.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>

Co-developed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Co-developed-by: Ali Raza <aliraza@bu.edu>
Signed-off-by: Ali Raza <aliraza@bu.edu>
---
 arch/x86/kernel/process_64.c | 22 ++++++++++++++++++++++
 include/linux/sched.h        | 26 ++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 1962008fe743..e9e4a2946452 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -501,6 +501,28 @@ void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
 	task->thread.gsbase = gsbase;
 }
 
+#ifdef CONFIG_UNIKERNEL_LINUX
+/*
+ * 0 = Non UKL thread
+ * 1 = UKL thread - in kernel code
+ * 2 = UKL thread - in application code
+ */
+int is_ukl_thread(void)
+{
+	return current->ukl_thread;
+}
+
+void enter_ukl_user(void)
+{
+	current->ukl_thread = UKL_APPLICATION;
+}
+
+void enter_ukl_kernel(void)
+{
+	current->ukl_thread = UKL_KERNEL;
+}
+#endif
+
 static void
 start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		    unsigned long new_sp,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a5c711..b8bf50ae0fda 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -746,6 +746,13 @@ struct task_struct {
 	randomized_struct_fields_start
 
 	void				*stack;
+#ifdef CONFIG_UNIKERNEL_LINUX
+	/*
+	 * Indicator used for threads in a UKL application, 0 means non-UKL thread, 1 is UKL thread
+	 * in kernel text, 2 is UKL thread in application text
+	 */
+	int				ukl_thread;
+#endif
 	refcount_t			usage;
 	/* Per task flags (PF_*), defined further below: */
 	unsigned int			flags;
@@ -1529,6 +1536,25 @@ struct task_struct {
 	 */
 };
 
+/*
+ * 0 = Non UKL thread
+ * 1 = UKL thread - in kernel code
+ * 2 = UKL thread - in application code
+ */
+#define NON_UKL_THREAD 0
+#define UKL_KERNEL 1
+#define UKL_APPLICATION 2
+
+#ifdef CONFIG_UNIKERNEL_LINUX
+int is_ukl_thread(void);
+void enter_ukl_user(void);
+void enter_ukl_kernel(void);
+#else
+static inline int is_ukl_thread(void) { return NON_UKL_THREAD; }
+static inline void enter_ukl_user(void) {}
+static inline void enter_ukl_kernel(void) {}
+#endif
+
 static inline struct pid *task_pid(struct task_struct *task)
 {
 	return task->thread_pid;
-- 
2.21.3

