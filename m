Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACFB5F38EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiJCWWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJCWWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:22:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1409454CB6;
        Mon,  3 Oct 2022 15:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNYzKMiZLBowEZhp5Zyo5pLJN3D1XOwPd1UJSJhxBZLLXRTvdqXxQyDMDjcoKvo8PZv4s5o9FWSO3oKgs9GDl+7NzXFkqVVH/S2E38D2Lwpgzdqahpv1m/P3rEKrjzBH4bO4cFnjZFOAr+3UG2hpyfE5fbiTcudXFcG9JqUJkLx+/b2fZDS2BN2eMyIxnDrUqlj96Ax4TXFj7y6jwki2g49Sy06ufy+RXMo+DeDP7vcx4uQdfC99mZWCGWa3tPjmDbIFmN5R/Tu9iEp+DizHVarue3FQMUJ33mjjqZcetKg1W0x7S6CMgFgGNze1z5frMY0bPfD9xpaNfU9AAPpozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSSEi+Z8pjovztuE0JjVuUgeA63L/vWd9g721uVaUfM=;
 b=ITWS11IqZUFkfU+VXeLSfRQUMYSS6Wy+eVZksNLLnStjeBaJ+8y31AIGVJKGuPEJRdAVx2Dy+4goFayQml7Dmy8WISh+FAuisMg6f8sjx7KC+rbuJ1mKrzcYyvLKQwWcOiPuECZMkyefJAEbCLzy0/Iny+MiYPNNxIkXr6a+MIsDvEFzS9lcnKVOcFCEMZeGyvJWzCMgRsrhrfcr89zUHGw2QKBmvS4Pf24bQCFP9sO0PDj5+qKAxTtVKBFhO3LGRDlkC1pSqdbk4mX5S8+lqmDHGTRb4D4CXv1eHUo4g/VlWXk2NbWxU5ocuCK931KMr3GKH4SBd33VlhivtIwcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSSEi+Z8pjovztuE0JjVuUgeA63L/vWd9g721uVaUfM=;
 b=Bc3fiGVEzzFk7YqrjM9qo6zL4uIL1eZ/NPi/qwUnGcTV600nAnPylIaC/csv7gWEqS9ErhyXLIzOQjwYNcV9eQcOkxfdDRO+Pte7mGzMtlIZCR3gRXz6XOvQT1SYSvFcd4N/4nBFsZU8KE7bJ4sB211Co4F/F333OuyIhsg2Xib8O1y3Yd2aPX3oz7rayJrk0rdqwbj300vyQ4Gq/8Rx3IYxSPGY5wCrThO4azyZEKuUV3rjXwK1dGIBUcy+vRio/dzoj5Gl9jWGHpzRUCZDQDBDdb7SxdFlXjbSUfqBN3poLzLbJI5cOs86ne81S/rPoYXI/IcETzmil8eDDTxsog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by SJ0PR03MB6270.namprd03.prod.outlook.com (2603:10b6:a03:3ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 3 Oct
 2022 22:22:04 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 22:22:04 +0000
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
        rmancuso@bu.edu, Ali Raza <aliraza@bu.edu>
Subject: [RFC UKL 09/10] exec: Give userspace a method for starting UKL process
Date:   Mon,  3 Oct 2022 18:21:32 -0400
Message-Id: <20221003222133.20948-10-aliraza@bu.edu>
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
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|SJ0PR03MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efbe912-440e-4608-90e6-08daa58db2e0
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Paw6iN7LmA6aFMWiR0SmT27rIuO+PKneqOSbulbH0Up5sql0ID1Y7Fh503HWtP7/2rGGr5Rt25ztUXnw4vFVwNt6CQ0rVLMF5S2UyyauBw0pM9l7PPsCqveWO2+SeBNAR0HLHhA+ODvhSSJFf3f6jKjorYesDVzhFPYW3er7ICWxgnqcz7JR6Df9aeIuaRUwtgbt2MBDUmnu3DKMH223uyZMhiIpFIVjPNzHb437FO5jnop0zDPl3Z/7fMQSmzfF2aAIrxKWCB30w5MPjbBCcD3Kc2WUCRYPAV3hdyrDrWw7T0/VPD3/AJiH8OUFlUSZPW/uJ6ePFBbEdW7j8wqV4cI2o29Ne/k+fLal3XOoLjReTPfkyxYmTXbIdLOf0byBXkyywRMipHKuo3/aGRGuC2EOvxiEkm+pL34EdZz1FVQO283wHeNPFOUfV6S3QBs4YVxzLW9dHOTbILlj/BEzlj7k82hgR8+xIwjgUpLFHSDnM/cshDFFziLjYxIF5rN7umLW+obS1R4G9qQavILPsentSVLNmIxq3KhnSCNf0kT5ZSXWd+b4kAvKgcW/1qf7OWyqiXxq3H8Ig2Iu7SyCAYrw5ayQxHHUOFyas8FWDSxbxcTQdhXcLm7BSnwnJnjXlnQUKN8vqTqx55oZhTUq1gp1xL05L5TYZWqVI1cGto675dvquQgWihdzBUTc7IWEB8tSGl4Z5OUohgFnJO/OSW5AxvTwhdEn90YkC60sPWAxJZPpNNRP3i0P4IqeVMcj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199015)(52116002)(186003)(41320700001)(38100700002)(38350700002)(8676002)(4326008)(66476007)(66556008)(316002)(786003)(6916009)(2906002)(7406005)(41300700001)(8936002)(5660300002)(7416002)(2616005)(1076003)(6486002)(478600001)(26005)(6512007)(6666004)(83380400001)(6506007)(66946007)(86362001)(36756003)(75432002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?moJLYLwKgIlwulhtLj860vxZH+dljt2Eyg9vgl/yyrUUbbMbPx98pPJeospK?=
 =?us-ascii?Q?yxmt4WPYiCTzT7evpyxLI1EPUfHYhSNKViHW+pgVKBKP3dvPnrzzOPR6gxpF?=
 =?us-ascii?Q?mBrZODeDa6VQTRTAScuGxl2zEI8SkHYwaE7ejeFE1CNWjViaBY63MwZNv/Sw?=
 =?us-ascii?Q?zKdYjrTUzmfsWzH54ej+my28dffeYMYmq0ZKLh7RFT+MebKA4IJCYdmTKz40?=
 =?us-ascii?Q?phpkHp0d+Mk8ApeMG3NqKrz/6xpOouKERzUb+N/E9aFR3E/fctR/Flf0rqrM?=
 =?us-ascii?Q?AwlfHJRE8T+8ml9o7shGak31TmsYskZvNThKhqcSgpEunvhjxEHzqykZryv1?=
 =?us-ascii?Q?XZLUPoaOBdtQz3atbVHbYA6i52XAcFQB4a/H6jnGXi9Otxwmiy2ZAzNSZNht?=
 =?us-ascii?Q?33/dS/6LZ+/c4moshu+GTJ7w1FPacML/QZv2ulczioE10I+U0YZCOR9yskHS?=
 =?us-ascii?Q?q4E2vlB1zp7V6+kc2sm0mNj0jglXQ4dkGMXuXt/QjCaLsXpvjx8lFzFpndvr?=
 =?us-ascii?Q?7FQg5HFOB649S/ZPkuZsXBpQnvxLM3MKZ2olDYgoKx8OIQDhmr42HFHNjlIy?=
 =?us-ascii?Q?MiKgUIrtprD5yMQq0mSv9cN+bO1pLs8TM1CfuSYvt52EnGYS6XXHlWGoiI6a?=
 =?us-ascii?Q?ySCt5ylAZrypzF7GYiUJVjbUDbs8GTffF6bhnRQ9l0y/Vq2Jly3LeNhXWYqY?=
 =?us-ascii?Q?irVinQ5r5OTp6E6wBg4z0FnTgRGmXxzUemcKbSYw+aZQkUP4XnoNxIapCu4I?=
 =?us-ascii?Q?0T5Cqqc9KaSuog7VwgKMTI4s1y/KWldZiG5U/1ltT13ksFH4aahsVboSDxOM?=
 =?us-ascii?Q?THc0K1bwdeXtcIyIK0DHbecDVqzLpgBQwu7FHLWROdv/mafiuLjl6pw202CX?=
 =?us-ascii?Q?GqHwMYQtA1Qg5IEYQkBj7TUsyQ2NGXzUFvK/0SE3+87sUHJ43GXvF/2skWzK?=
 =?us-ascii?Q?kKwkek3++xnBvzDH0mQ9I2yEY1lZT88WJ9sbTF4YY2k7cL9dzqX6aeEUpxo3?=
 =?us-ascii?Q?zZKhTpwWJu0T8YPw6BfL06z+/P+9PFeoEfDLzskf08d7NrFI1DHQ5O+PIHTC?=
 =?us-ascii?Q?q/50jhFFk9YUfTiHoM2USMrCNMYP44sZmvqlXl5Yo1UVFKweYhNJczpxDuPI?=
 =?us-ascii?Q?h0AYpYO0iNrCLp+syPXWTr3+0CsfUz52sm0ZhMjo3e/E7iG+zb6+1L11LUm8?=
 =?us-ascii?Q?OaP/3hDccMF3QC6qeQsQonm0Gu8PgY5a2APQZg6+QiOSi+GMqPQUWxpFUcSb?=
 =?us-ascii?Q?SGxWvii3lhQgk8/ckh/Pry0+rWnvxMThEGR/sk2O+p2yh9u4AxHAemIKabbB?=
 =?us-ascii?Q?syp/4gnC2Zko0O5n0JgJogYXPOUffoVRWHJdPtUfGnksWbf0AQsi1cbiGzeS?=
 =?us-ascii?Q?I0T0pDJ+mTXKLlswQ5z47NucPAnK7MqOqWgFndbU4rsX87eULiiZMisIyRrM?=
 =?us-ascii?Q?zKqr2tNBBuDpog5HK0is5/rYEqAzLFZDNiUQ8PG78LPE+m2A1cg6zscxI9hs?=
 =?us-ascii?Q?ZXYP8KrUDayMQxUR2ufGoVO+Guj0Yvr1JW0brJ0ljb7eL9hbj+rW5wtw0pXe?=
 =?us-ascii?Q?tIONnh5BPv0n1vQoEfGthweWN20qBy5lObWS+6Rc?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efbe912-440e-4608-90e6-08daa58db2e0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 22:22:03.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thdLbDBKZ58fw729glVUbZyuphni/KqGDSfFx8uLm+NaroLivIjkWmb5cQtdE/cI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric B Munson <munsoner@bu.edu>

From: Eric B Munson <munsoner@bu.edu>

The UKL process might depend on setup that is to be done by user space
prior to its initialization.  We need a way to let userspace signal that it
is ready for the UKL process to run. We will have setup a special name for
this process in the kernel config and if this name is passed to exec that
will start the UKL process. This way, if user space setup is required we
can be sure that the process doesn't run until explicitly started.

If a more traditional unikernel execution is desired, set the init= boot
param to the UKL process name.

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

Suggested-by: Thomas Unger <tommyu@bu.edu>
Signed-off-by: Eric B Munson <munsoner@bu.edu>
Signed-off-by: Ali Raza <aliraza@bu.edu>
---
 fs/exec.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 4ae06fcf7436..e30c6beb209b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1888,6 +1888,22 @@ static int bprm_execve(struct linux_binprm *bprm,
 	return retval;
 }
 
+#ifdef CONFIG_UNIKERNEL_LINUX
+static void check_ukl_exec(const char *name)
+{
+	if (!strcmp(name, CONFIG_UKL_NAME)) {
+		pr_debug("In PID %d and current->ukl_thread is %d\nGoing to create UKL here.\n",
+				current->pid, is_ukl_thread());
+		enter_ukl_kernel();
+	}
+}
+#else
+static void check_ukl_exec(const char *name)
+{
+	(void)name;
+}
+#endif
+
 static int do_execveat_common(int fd, struct filename *filename,
 			      struct user_arg_ptr argv,
 			      struct user_arg_ptr envp,
@@ -1899,6 +1915,8 @@ static int do_execveat_common(int fd, struct filename *filename,
 	if (IS_ERR(filename))
 		return PTR_ERR(filename);
 
+	check_ukl_exec(filename->name);
+
 	/*
 	 * We move the actual failure in case of RLIMIT_NPROC excess from
 	 * set*uid() to execve() because too many poorly written programs
@@ -1985,6 +2003,8 @@ int kernel_execve(const char *kernel_filename,
 	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
 		return -EINVAL;
 
+	check_ukl_exec(kernel_filename);
+
 	filename = getname_kernel(kernel_filename);
 	if (IS_ERR(filename))
 		return PTR_ERR(filename);
-- 
2.21.3

