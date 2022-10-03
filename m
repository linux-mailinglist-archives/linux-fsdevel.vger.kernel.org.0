Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05DC5F38D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJCWWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJCWWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:22:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20719.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::719])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348E54674;
        Mon,  3 Oct 2022 15:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI26nPRZa/d3jU2XAkHP6eL0Eb6B3qsa/f8suWH7PK7LyGdUUwKt3VeZs70uS8QkXdh/GKAgI6g54l1uxYoVdoVOvpoPbGd2xP6prlYdhC9OjxciXXGrw3WvVlTLsrdjR40D4/WI8tCYQxRVeTmUPh3XaOm+Bmrol3VaKD/ogrTBXDHLuA1a2sgzmQKy+lng/aNuKPC19kp9SiYGpnaFDlGmxXoo3/MAqkzO+7EGZ96/wjes0wWdvEtRJn0u71GO9m8u5uPiuFOIX0Zzcr3C1469h5+5FmFT8GN6aXrbzAEN/aKm8FVaOX5/ov9lj6ZJPX1VaedKNunaHo5zlbGttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+rPTf0CItss3USZRkJE/pNW3KYQAdNHkWJKYHQskio=;
 b=ed+6rKrmZL3m33FyIyBGTyll8WCUw9+8A8aW1BrzVof+0GFR8kmWJj18mDYP7F/kt8sbMTzDwgmI1POYI6gIRxdTBqTXfcgWO9Gu6TwfrgzHeLnlvOvcVbExNN8G/6YcBoCq6y/lOn7YYhnFri1vlgDmul4fhw81+mr5yOdnduGmpRyX5uqrS8b/tQoV1orIt2QCR5lUnj3HKToLsVwyONOGELWM+oNnMYJMd42gjSn/lxRf0yS6QNI5cil08tT5tordimD7hcUaoLEv0lphuhAHTVkLfLlGbjlu8rZEBf0AzMTkB9zw6asQHuiV6h9HW9wgq2tvgV2zVHkH5bj9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+rPTf0CItss3USZRkJE/pNW3KYQAdNHkWJKYHQskio=;
 b=FLXqIeMYrzo7gI5FBlloW2EC2CUnCxlaayYD78ar0xZftu605m5oOBuPkExMN7y3YI8WIls2oYz5svBXM+GIQ0zZdBCGyzRVg003lHVn95EJSlEraJ3gbF6iW/MH9fKGepnkE3a3Iaztf8V+cMZAxb6e19ZYcp/6RON2NwNT5VYSu1Kgk1BGyKF9uYF4zY4aS8iJP235r5WetwfESSd8q8w3PM+H1fQF42ZrCx6ijaGRnz5kQmHV8VQuMi/ey4uTaRyc9UjsCGFZQvuzNSAEuqcPjnKGgtJH0jcGSu8ERZHxg7QFSzuh2hQ7rhwuuvAlsE+w8y0NvVL7pRPvCwAVBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by MN2PR03MB4928.namprd03.prod.outlook.com (2603:10b6:208:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 22:21:59 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 22:21:59 +0000
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
Subject: [RFC UKL 04/10] x86/entry: Create alternate entry path for system calls
Date:   Mon,  3 Oct 2022 18:21:27 -0400
Message-Id: <20221003222133.20948-5-aliraza@bu.edu>
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
X-MS-Office365-Filtering-Correlation-Id: 6b01462e-0159-4720-c26e-08daa58dafd9
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yP+sKtyomkkUI7wByv+vozQS7Ex71VwmqPvYY5Kf1K29k25ZQuZuiBQjZykPtFF6NIAPIdgWzCLg+t0L3tHWaMcfloxAZ9yyTTNmziPn4GOCIsude84MmoecUzWveN+7GJZFqstO8s8asJr6YwaFkEZ6LvSrDCQbWMsWgWbTAFpIExNEfcRXS3Jp8QvcUt4PT6hjeq4HOFueyleWkAfxV5OQmofaACLrIVQVUFS9aG3/tGMbktM7TGg5xRVfOCsudPFoTplbcitmJhwcYbh82ZOI6N3ejThq7BVuys+Ot4jvPV4pwYGKvPd9E9fVtYjt+odnQeVMRenqkcFtKypOhgMl178GL1v94GhxkOTJCrLdUkZJdAeXNBjoNMuUSrs+yRId3Llm1YK2NUYKnZhveTb209+fAznq8s+FaYo8VY5Q0UgKlHptgxR6rIsdLLGaQDCzcbdTIaoqpD1sBaEz2uKmLXk8pO6g/CIouwbcs9PkJF0cCvB0vgpt9tTPPH57I77zyAVkBrcCEfJriqS0tW6td466X2YzMrg1/MUOQ465al0ABNY02yMGTk/weoJBy4Tg2RHV9uJzkBPPB4ut3nZlXw1r2qyFB4fpex08WiBc76kTUt61XWgdqLNJ1XPJEAbZptiQy6xoLUNHE485vBr4tWanz/UBeTw3l4Bu+d/DQpic1U/ezNESFDJUq19FAiuh/C77EGprMw+mDZcFw/uL8q+VMK52b6uDlTbP0lPZsC8BduA4ruoEVcJiaT2tVxveJNTVeTQ7iUK9SvadIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(8936002)(7406005)(41300700001)(6666004)(38350700002)(75432002)(66556008)(66476007)(4326008)(8676002)(1076003)(186003)(6512007)(2906002)(2616005)(66946007)(83380400001)(52116002)(6506007)(36756003)(5660300002)(7416002)(26005)(86362001)(41320700001)(6916009)(54906003)(38100700002)(316002)(6486002)(478600001)(786003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AvGYzfed5SZaETLXeWXSfsOMR7Hk3njLFxd60WeLCymuBqZu9KAr2ocA9/l3?=
 =?us-ascii?Q?p6dVEg+WzlfLThXq68WMcoxUInIRYQU2PsIRE8+1YZBdO0CmgoVBKLIuXjSG?=
 =?us-ascii?Q?jW/L5RJBLBBFEhCRWA1k0UoT+mrYFFUtGOcrwOg/5uBkViYiiPobnXEIyY/w?=
 =?us-ascii?Q?1ULQxVH+er3NMwjqtoH02GHiPSCe9z9KZ2RBV6zzWOcRN+/3j342mEUP65qo?=
 =?us-ascii?Q?MvXPJ3ENMLkLXVh0lONsYv53s/7nTIxNV2pJ+zueAEBcDX8RdBdQsXESVUBh?=
 =?us-ascii?Q?xUuF9C0NC7Mg3yInSHZQrunhpHuMvdmyIQjLlE/k/dhTSN+Oxv0iDtPxOpME?=
 =?us-ascii?Q?Vgvm0OXCn5qzcc9SxLD9EkssNgSyA+4b6PFUpYNaVQkRakmSpPJLBv7Powk5?=
 =?us-ascii?Q?GA10ouaZdK+9OdyBJfIJx/qm9Ncjw7y7NU1IOsA0tfljiY/QrsdKn/VcA7Nk?=
 =?us-ascii?Q?mSwrfjHGFx5fgbiG0PNUUCHyWAvfisT4ASexP8RICdWwEVbmECQ5nUodWxWH?=
 =?us-ascii?Q?FM8kz3GOHVEmjPml+uzSNlDMTTIQhcZVflhyatFqvzVTF6ofXE1m2/C+VcbC?=
 =?us-ascii?Q?W3NjZKSmheV6Rwj3kIEyzimWP1HZZBR6yFf8d7jQ5ZNUx+XzMfge8UZt+pdc?=
 =?us-ascii?Q?XrIbaGLqT7mQeqjI1dP8Vxqz8uAXGTK2I31jhAHIvM3DI/qEO4U/bP/YVsCQ?=
 =?us-ascii?Q?98XkJVt/1YNf+wLcaPN1paiaId3+ZwOC8U4UCLIdszF0aMqIDBG29af8HnkO?=
 =?us-ascii?Q?x8wDKT0aUcO3wm2XV0Xh0ndJ9OTne0WC+ExBH12ONCpUCxzyKxPuO+mjeXYF?=
 =?us-ascii?Q?w15+YYMeJoyJBcDrdlPvzYH3sLG/ubRn81ztXZSckc5IJsz81uqi5JsSbVXU?=
 =?us-ascii?Q?UpHBmfz/+5mHaa1dXpVLbokXft4SRcrVuRusGx1dHoPwBNQs9VRTTS6Xoyb2?=
 =?us-ascii?Q?Rw7bwuFpiZP+81eoYRTzT9+lrxidzU0OHh7LT3ez4fY0L/mSq8IgZhcRjUVu?=
 =?us-ascii?Q?EUJiVQYt+yp3pr8MYjpE2HEOCIFKVo133WACNbDnzrYrY9JCaaKLMNr5XJRF?=
 =?us-ascii?Q?BvOvpVpAhyX/rB9l3MNaAS7+nlGWIMiZrmrSjLKZqmwTAVmBvef6Zp4smm2+?=
 =?us-ascii?Q?NrIMiK67wqM/SqoEe8FXnefRxEH8P0eJftVin1VRN65Y5wMYv4gtKTPpMyXr?=
 =?us-ascii?Q?TmLJAzhHyDIzXWLmSA3+qDSOz6oZQn7alzf1ERkl/p2qUvozzatd35/2IYxa?=
 =?us-ascii?Q?U1+nRNWZO13oeI/Wm62cMc7Bpf9UU8lU3A7CS5rXLP0Uct6gRq1UV8CY55N4?=
 =?us-ascii?Q?NqvgdCLFrqYwZobgJaXKt7UgcpmM/U7EWJETyylIgRWOHTUM6h9ODwBMMVp4?=
 =?us-ascii?Q?oAvbyqwXblx98yaTSssIF2bXRDcuT4b/Xr5ZmtPum+wjoHP2Ng7PePkqaAhr?=
 =?us-ascii?Q?TyH0cGL/GtX7xr1X7OYySv/ozTmg7/rXOGVEGN1qm/rErrnmKAuiigAv9kA5?=
 =?us-ascii?Q?t7hVDRJ0JqL7A+C9VjGhly8KZComyuCJXIMN1sF5YyJK9woFUjg8jUiMQTpd?=
 =?us-ascii?Q?YlKw2jCajjMSjNPufpYzTX0g7P055jw4LUqRo/79?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b01462e-0159-4720-c26e-08daa58dafd9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 22:21:58.9195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cuD0F6EJHCz2hjRD0siivoKTlpYeVFB6mn3q/sCkmVhvU6bdua42fZZUF/cS/wp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4928
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a UKL application makes a system call, it won't go through with the
syscall assembly instruction. Instead, the application will use the call
instruction to go to the kernel entry point. Instead of adding checks to
the normal entry_SYSCALL_64 to see if we came here from a UKL task or a
normal application task, we create a totally new entry point called
ukl_entry_SYSCALL_64. This allows the normal entry point to be unchanged
and simplifies the UKL specific code as well.

ukl_entry_SYSCALL_64 is similar to entry_SYSCALL_64 except that it has to
populate %rcx with return address manually (syscall instruction does that
automatically for normal application tasks). This allows the pt_regs to be
correct. Also, we have to push the flags onto the user stack, because on
the return path, we first switch to user stack, then pop the flags and then
return. Popping the flags would restart interrupts, so we dont want to be
stuck on kernel stack when an interrupt hits. All this can be done with an
iret instruction, but call/iret pair performans way slower than a call/ret
pair.

Also, on the entry path, we make sure the context flag i.e., in_user is set
to 1 to indicate we are now in kernel context so any new interrupts dont
have to go through kernel entry code again. This is normally done with the
CS value on stack, but in UKL case that will always be a kernel value. On
the way back, the in_user is switched back to 2 to indicate that now
application context is being entered. All non-UKL tasks have the in_user
value set to 0.

The UKL application uses a slightly different value for CS, instead of
0x33, we use 0xC3. As most of the tests compare only the least significant
nibble, they behave as expected. The C value in the second nibble allows us
to distinguish between user space and UKL application code.

Rest of the code makes sure the above mentioned in_user context tracking is
done for all entry and exit cases i.e., for interrupts, exceptions etc.  If
its a UKL task, if in_user value is 2, we treat it as an application task,
and if it is 1, we treat it as coming from kernel context. We skip these
checks if in_user is 0.

swapgs_restore_regs_and_return_to_usermode changes also make sure that
in_user is correct and then we iret back.

Double fault handling is special case. Normally, if a user stack suffers a
page fault, hardware switches to a kernel stack and pushes a frame onto the
kernel stack. This switch only happens if the execution was in user
privilege level when the page fault occurred. For UKL, execution is always
in kernel level, so when the user stack suffers a page fault, no switch to
a pinned kernel stack happens, and hardware tries to push state on the
already faulting user stack. This generates a double fault. So we handle
this case in the double fault handler by assuming any double fault is
actually a user stack page fault. This can also be fixed by making all page
faults go through a pinned stack using the IST mechanism. We have tried and
tested that, but in the interest of touching as little code as possible, we
chose this option instead.

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
Co-developed-by: Thomas Unger <tommyu@bu.edu>
Signed-off-by: Thomas Unger <tommyu@bu.edu>
Co-developed-by: Ali Raza <aliraza@bu.edu>
Signed-off-by: Ali Raza <aliraza@bu.edu>
---
 arch/x86/entry/entry_64.S | 133 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9953d966d124..0194f43bc58e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -229,6 +229,80 @@ SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
 	int3
 SYM_CODE_END(entry_SYSCALL_64)
 
+#ifdef CONFIG_UNIKERNEL_LINUX
+SYM_CODE_START(ukl_entry_SYSCALL_64)
+	/*
+	 * syscalls will always come from user code so we dont need to
+	 * check stack cs value. We will leave that as 0x10, because
+	 * kernel entry and exit code will always run on syscall path,
+	 * no need to check cs on stack
+	 */
+	UNWIND_HINT_EMPTY
+
+	pushq	%rax
+	call	enter_ukl_kernel
+	popq	%rax
+
+	/* tss.sp2 is scratch space. */
+	movq	%rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+
+	/* Construct struct pt_regs on stack */
+	pushq	$__KERNEL_DS				/* pt_regs->ss */
+	pushq	PER_CPU_VAR(cpu_tss_rw + TSS_sp2)	/* pt_regs->sp */
+	/*
+	 * pushfq has correct flags because all instructions before it
+	 * don't touch the flags
+	 */
+	pushfq						/* pt_regs->flags */
+	pushq	$__KERNEL_CS				/* pt_regs->cs */
+	pushq	%rcx					/* pt_regs->ip */
+
+	pushq	%rax					/* pt_regs->orig_ax */
+
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
+
+	/*
+	 * Fixing up user rip because rcx contains garbage. That's
+	 * because we didn't come here through a syscall instruction,
+	 * we used call
+	 */
+	movq	RSP(%rsp), %rdi
+	movq	(%rdi), %rsi
+	movq	%rsi, RIP(%rsp)
+	subq	$8, %rdi
+	movq	EFLAGS(%rsp), %rsi	/* EFLAGS in rsi */
+	movq	%rsi, (%rdi)
+	movq	%rdi, RSP(%rsp)
+
+	/* IRQs are off. */
+	movq	%rsp, %rdi
+	/*
+	 * Sign extend the lower 32bit as syscall numbers are treated
+	 * as int
+	 */
+	movslq	%eax, %rsi
+	call	do_syscall_64		/* returns with IRQs disabled */
+
+	POP_REGS
+	/*
+	 * The stack is now user orig_ax, RIP, CS, EFLAGS, RSP, SS.
+	 * Save old stack pointer and switch to trampoline stack.
+	 */
+	addq	$8, %rsp
+
+	pushq	%rax
+	call	enter_ukl_user
+	popq	%rax
+
+	/* Swing to user stack and pop flags */
+	movq 	0x18(%rsp), %rsp
+	popfq
+	retq
+SYM_CODE_END(ukl_entry_SYSCALL_64)
+#endif
+
 /*
  * %rdi: prev task
  * %rsi: next task
@@ -465,6 +539,14 @@ SYM_CODE_START(\asmsym)
 	testb	$3, CS-ORIG_RAX(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
+#ifdef CONFIG_UNIKERNEL_LINUX
+	pushq	%rax		/* save RAX so its not overwritten on return */
+	call	is_ukl_thread	/* Check our execution context */
+	cmpq	$2, %rax
+	popq	%rax
+	je	.Lfrom_usermode_switch_stack_\@
+#endif
+
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
 
@@ -520,6 +602,14 @@ SYM_CODE_START(\asmsym)
 	testb	$3, CS-ORIG_RAX(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
+#ifdef CONFIG_UNIKERNEL_LINUX
+	pushq %rax		/* save RAX so its not overwritten on return */
+	call	is_ukl_thread	/* Check execution context */
+	cmpq	$2, %rax
+	popq	%rax
+	je	.Lfrom_usermode_switch_stack_\@
+#endif
+
 	/*
 	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
 	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
@@ -577,6 +667,11 @@ SYM_CODE_START(\asmsym)
 	ASM_CLAC
 	cld
 
+#ifdef CONFIG_UNIKERNEL_LINUX
+	movq	$0x2, (%rsp)
+	jmp	asm_exc_page_fault
+#endif
+
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
 	UNWIND_HINT_REGS
@@ -655,6 +750,19 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 
 	/* Restore RDI. */
 	popq	%rdi
+
+#ifdef CONFIG_UNIKERNEL_LINUX
+	cmpq	$0x33, 8(%rsp)
+	je	1f
+
+	pushq	%rax
+	call	enter_ukl_user
+	popq	%rax
+
+	jmp	.Lnative_iret
+1:
+#endif
+
 	swapgs
 	jmp	.Lnative_iret
 
@@ -1044,15 +1152,34 @@ SYM_CODE_START_LOCAL(error_entry)
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
+#ifdef CONFIG_UNIKERNEL_LINUX
+	testb	$3, CS+8(%rsp)
+	jnz	1f /* user threads */
+
+	pushq	%rax
+	call	is_ukl_thread
+	cmpq	$2, %rax
+	popq	%rax
+	jb	.Lerror_kernelspace
+
+	movq	$0xC3, CS+8(%rsp)
+	pushq	%rax
+	call	enter_ukl_kernel
+	popq	%rax
+	jmp	2f
+#else
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
+#endif
 
 	/*
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
 	 */
+1:
 	swapgs
 	FENCE_SWAPGS_USER_ENTRY
+2:
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	IBRS_ENTER
@@ -1129,6 +1256,12 @@ SYM_CODE_START_LOCAL(error_return)
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
 	testb	$3, CS(%rsp)
 	jz	restore_regs_and_return_to_kernel
+
+	cmpq	$0xC3, CS(%rsp)
+	jne	1f
+	movq	$0x10, CS(%rsp)
+1:
+
 	jmp	swapgs_restore_regs_and_return_to_usermode
 SYM_CODE_END(error_return)
 
-- 
2.21.3

