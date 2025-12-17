Return-Path: <linux-fsdevel+bounces-71505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C891CC5D00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 03:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53DB23030DBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 02:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8658E2737F6;
	Wed, 17 Dec 2025 02:46:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021132.outbound.protection.outlook.com [52.101.100.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949A275AE1;
	Wed, 17 Dec 2025 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765939576; cv=fail; b=XqdE+aexemwYKOSiJQolC1b/99vApsZRXBZ2w5qRzOaWLjlisKSqtalDwK6nAis3pSGBTIKXNu65+3x7bLKQnPhrPSxjGik03uu3lHLNEfZij1Z2SLMPh4lvOg6aC2g/PbiWA6mMKlyauS76IpNje7m6bNdvxy9Yo/5PfUQ2X5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765939576; c=relaxed/simple;
	bh=UuaUCOfitZBGQ034WU3nNW+CJXIgd4bzFWb9wew+t8M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=if2zmZAEUb57FXt6pzbixhzJCQotofTC8cNBVg9xpPmDDu5xMGy+J3bbHXPxeQA8kJhS2aF8cef/DrZxCAsAowlrwBzS1S1XxJA+cVQSnKrbfjqMepk9PGoE2HHwnmY6tyRsNQgZwrOYemkziGFngF1iHVPF95k3kg1i1uz4+L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWCdtaXpg7Q99zBVCI+MDavg5p4fJ8R2ELrjZit3zUVwj/f19x/wsZMzvOIrQq4uqmDPCSk7Q5gzOg/jCp6VkFSlz+qQStPBCSwptlALeLEWJNuNdVebiqpehY08s2omTb27jBvtjuS4/t3ShiUbfsJPnhHiVGsPqLyIVoWjygj2Is/E98MR5i+9i/U1A/pmBrio6H1N53msORFlETGjXGH1UAIsyXH/k8/aWV2lWMiBIvuaSndk8lrAmriuuqxK+YgWqVujhTDiM1mQ/cn/JbFNqjGHSGpVzyWtdjGvPhzngAWZ/K6ij3GY415RmNA7GkvrNrnfWYGDtqjHELEnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge24WTCGWNjCqUx76DmLh+rTi+AwJ8cMhfNs35uhFm4=;
 b=xAdyE8HElBTS4edYQHb5w9yfvwFSCmhFl2JI4U3tQkx2vmXqBCBfC7Q9MIXIZntTmvLuKXNfvtVTmBFkcrAtHtuvuwKJ3v61afVNWWn7yMLivMz5ni8w9wVsDLiK1c49CNV5ErlZqz0dyOTkR5jtmPib+jU8lgBc/h0za23GjE2svbYlt13CF6Y3+eFQbG0VSD4lumppUQWKlbB8xv2serYns7MVjh9fIumr2CXWSpdzKJm8PqCSc5/o+zPxQv7nWMGWW+GAZNgMs3UhbqV2jzpOodcnHvpsyj/tVgiGZQcFOAUQnQqU4h5iKGAiqyDu6u6AdF9vZAHFTLBSCsVqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB2911.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 02:46:09 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9412.011; Wed, 17 Dec 2025
 02:46:07 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: oleg@redhat.com,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	david@kernel.org,
	brauner@kernel.org,
	mingo@kernel.org
Cc: sean@ashe.io,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Date: Tue, 16 Dec 2025 21:46:03 -0500
Message-ID: <20251217024603.1846651-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0808.namprd03.prod.outlook.com
 (2603:10b6:408:13f::33) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB2911:EE_
X-MS-Office365-Filtering-Correlation-Id: df0094b3-13e1-43c0-3620-08de3d166d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vjrwja7ma7NuOMnjpfbFj+zXBdNj2LRegp3Q/LHhg3wwsEFPso1qXHmGr60O?=
 =?us-ascii?Q?RwOE8jI4ywfZAmImwH9CXY2p2rmiF/eC26ekSUGO+blefriPEDlYqPZphkXq?=
 =?us-ascii?Q?FdTtjjeO2wCUct5GP1BfgyfuwojDX3XftloUHVYNl/QuYIR3uKfkbGG7/zTy?=
 =?us-ascii?Q?NQa/O1a4kcM7V+32A2v6g3uBPYlHEYPaXQO2/eS7WV8/mjkoes3fXIvxTs4T?=
 =?us-ascii?Q?uL+7x7CBJDCL3O/P62W7BS9z2aNtedWMHMeY/pfhF7kOx8p20FxXOdcg4RW9?=
 =?us-ascii?Q?RNpAVjyuDExpDTsf1sszfkTkmbp7Djil1K7xbGzNWCgJmiTO63s9qdBkniet?=
 =?us-ascii?Q?ZRvXwct1oZF8oEatPvOe0bYPVeU5adgGbQHqkxcQNk8zFD4tYh9v4No7ZRph?=
 =?us-ascii?Q?Pcrk8ILQ8y5gqWEXfv5/vIbczx1sSbGKkBngmsinGIvAazWNeNcPynRFcgeD?=
 =?us-ascii?Q?Afk4FpNZ6DT7RljzLYC6UNZiLMDFJYIxgwDwMBGcTsplYJhdizliorOE9Q+2?=
 =?us-ascii?Q?2aKIvlpQVuT7bAEm1LRQS6tNZxivL52oxdzNXoo2Xis2mmIILijgbm/gfdHe?=
 =?us-ascii?Q?k/B1VIx1xgJ4fxKyiVlu2AjDx1z7XUu/+OMGs6hEjVLevZIDSGQJP59S2Rxv?=
 =?us-ascii?Q?D2RlGa8rhrV6zRk42vWscoz0YPEeq9tGwUPlWWovqYTTfastanNxV2pgLfLX?=
 =?us-ascii?Q?BA3J/Fw6+L6T7thHrT4XgIDkEBy/e2CjnBfKvsUIPoJmLow+qIUDLJbKwPpd?=
 =?us-ascii?Q?N88UD/suSduGl6BSqs0IG/r5tcjwmNVLmX77kvgkAVFDthh54KB37oDcNdgp?=
 =?us-ascii?Q?WKj7uIDfXKu2fRW9y3dSvCQbV3N+AOIJ28OA5bLsrnF1HXtJaAm8AzZ+vbAj?=
 =?us-ascii?Q?keHwUr4bsq7UPNeYLqJ0J0DzwM+yZRLiAdU8j2SQGwYm/tdqXqVK6475yaEF?=
 =?us-ascii?Q?Cum4OgmOQozbrwgBl7mtF+1m07LuVXDYOa3kBhzGG8gRBSALX0K5eqYtxN+o?=
 =?us-ascii?Q?q6+UWbEJernCmsiu/650c2jLhvlIkv+H768Z/0jM+dGIdmKHiVql+PlDdbiu?=
 =?us-ascii?Q?uk1qWpv3XQUIMrCmvJDAWaUawkysisY7FbKG5Xn2ZUX7CGE21AbNYetQYmQ5?=
 =?us-ascii?Q?kMs5b4OML5E9SbdnsN2OaTylg3znyEVf53EpE7lULVj7d67V4VtQFRUt6PcX?=
 =?us-ascii?Q?palT6/fKJ77p71fQJUOqQ5r2OUbxJm+zaPayc2+QJcsc1a+/f3wrmgqpcDl4?=
 =?us-ascii?Q?GdwS+YqxSctYBv4OpTvyZIbRq4qArXs77rmHj0X6U430UH5gdWhWB8qd8KEP?=
 =?us-ascii?Q?oMGp4rWjAdYypswE7lLW4fu14yH3OyhBsdEovqbSI7Ezd/8fldbgK7VX/vpY?=
 =?us-ascii?Q?gBJ8lgjz6vCoMbBM2x2c8fs/hHQXzO16WhkeZPZtljdeu5mHSBN4uYPaE2XY?=
 =?us-ascii?Q?Ov7Qdh7djLBuUlsZjPd3ubNyiIAdX+/k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jm0lXp10NsNgeMfRIilVPBcl1OkzD9K4ntR18F8WDQWpqefI8dM73cr+yUXf?=
 =?us-ascii?Q?FpLyPUw4wkI/Nx2H49ECr0Fzr8lKUUPf6V4yznT+vEN1KWWPuN4U8BGG7drV?=
 =?us-ascii?Q?uAdH7qRDjvm3EV55+/nLZIP1mje4dCSdoMfpV+PQo5fLUy7x+V+B9kcgQ9Ae?=
 =?us-ascii?Q?AZGzAWNiKbsCAKF7XQBv+9jckvgEuA4cu09aPn/sreH3iVgtLlrB9F21Zx4B?=
 =?us-ascii?Q?7KNQfLMbChZSIb8WuDkpE0A2Xw8qxFla4y2J9FBcvY1MzsYNWlMZpzBMok4L?=
 =?us-ascii?Q?X9uoLUE01LDnK8+akcVbZhqPjt3Q1vXNvr8Th7PtoYBW8sHbQNBJyFvyyidt?=
 =?us-ascii?Q?1WrJM/13YHgzImB9FLtd4wZrGciu4w/p6mbkWCCY8MK8RHTjA+YrOIg0uDum?=
 =?us-ascii?Q?EY3ax9XoVeCm88+5vdfnQnjbKKIuNp+mHBl1q73rIVu9/zYDHHxgzEdVzoYd?=
 =?us-ascii?Q?Y6yYBqd3bZHdciNQsRA2UtBfEkd+jJPE0mJIjuoCPpyi75AMod2aHRNUqVpl?=
 =?us-ascii?Q?UOOmcTWmhbJPIBPVCLgVzmL4awPFsJ0fQ7a4orEkRrvu5q9LTEMioxzeGDo4?=
 =?us-ascii?Q?PaWvsIekN1CmToM8gkTRRtbtlMXhxQ9ftQWDwdntrsYkuBmfga9ZHWBpKf7k?=
 =?us-ascii?Q?L0k4Kvdk62TvIFvc6wBBEh4xo+IVV+HafqYNx0PimyBpWI3JPa0bUwbMsdAq?=
 =?us-ascii?Q?mK+MtYW5P3Kj+5U28VWy0vwSfvd/BWrj4ti4K4pqPdeQHdxMIGuWuY3UxRO0?=
 =?us-ascii?Q?AgBROtk9kaUga+dnk/VCd+xRoKqkgnR7fpvapMbj/cWonJ2wyes/QyRtMx0j?=
 =?us-ascii?Q?jsUqfZQRbb3dQmYTu9dfrff4Z9Q/C7BCWz83kvMi3rsM/v2nD21YhbHKtCfx?=
 =?us-ascii?Q?q3edMN7S05dx0CdF2nSgATBhOPjccaHQTdrefUWntzcfaFK8G3Te4oEKhLcY?=
 =?us-ascii?Q?riJ0eJ2+qBvNNc5bExS5OT+S4xodH42yKP43d/3X+qkqxk749adYiO9xlyHK?=
 =?us-ascii?Q?aDX51/0xUHlkpNc+XO9jYdHXWuhardllLZfJLfgNmSp0w/xhPJSAKXleo3MG?=
 =?us-ascii?Q?jEgo3t+nb8mt2ZBvAl/YBPXo3TB4/WB25cV2lNCwT5ayFyZreY9i9WrJ/cn/?=
 =?us-ascii?Q?weHMrQFDyGqLJ9ZjIUjBAJ6iY0uasSYuHkPKfXSL5ACF3iAbnyHPn2kk2ThI?=
 =?us-ascii?Q?zyJM7B8AOt/lESQS/+1uEMoTEmI7yb1sPQLxsijBeIeTM+FnuPAjc6j8ALWd?=
 =?us-ascii?Q?x6TQQkHHgEBetKn10Uj99+s3sKgvZj0g0cyD8Y1P5zNOmifakh9PAWA1/iBY?=
 =?us-ascii?Q?efLODKONwyG/vvECbH2koYBJnAYm6EL9/MytrsLfbxtkAkz+b2KhvZS+KNJn?=
 =?us-ascii?Q?Xq2vOfcAcV7MzxmcwCO17XScJogD3+SpQzgeF6APTnfz1bxKmwT0qXscA6V4?=
 =?us-ascii?Q?XD6dv5Pl/Ech7h8S1eui7nKKE25JEVNwgmcf+beK2aKV8CiDbDmD6+bI/R+J?=
 =?us-ascii?Q?Cw/hAL6WafmatX2tkkaq+RPZm8oUj10Wjriufq5nGcGbwJcc9m8HTKRR0+Uj?=
 =?us-ascii?Q?pqoCSIiGR8OwQPkFZIG98GHO0pS97B0szCje3nHo?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0094b3-13e1-43c0-3620-08de3d166d97
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 02:46:07.3337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0IfwPRr8/ChH0DEfdaqMIxQzaL8LCclznjoWzilpX4s/1iqhKgsBCTxFh0uRfOxmF1o/kxqBSNLK00fR9jBOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2911

This patch introduces two new fields to /proc/[pid]/status to display the
set of CPUs, representing the CPU affinity of the process's active
memory context, in both mask and list format: "Cpus_active_mm" and
"Cpus_active_mm_list". The mm_cpumask is primarily used for TLB and
cache synchronisation.

Exposing this information allows userspace to easily identify
memory-task affinity, insight to NUMA alignment, CPU isolation and
real-time workload placement.

Frequent mm_cpumask changes may indicate instability in placement
policies or excessive task migration overhead.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 fs/proc/array.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 42932f88141a..8887c5e38e51 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -409,6 +409,23 @@ static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
 		   cpumask_pr_args(&task->cpus_mask));
 }
 
+/**
+ * task_cpus_active_mm - Show the mm_cpumask for a process
+ * @m: The seq_file structure for the /proc/PID/status output
+ * @mm: The memory descriptor of the process
+ *
+ * Prints the set of CPUs, representing the CPU affinity of the process's
+ * active memory context, in both mask and list format. This mask is
+ * primarily used for TLB and cache synchronisation.
+ */
+static void task_cpus_active_mm(struct seq_file *m, struct mm_struct *mm)
+{
+	seq_printf(m, "Cpus_active_mm:\t%*pb\n",
+		   cpumask_pr_args(mm_cpumask(mm)));
+	seq_printf(m, "Cpus_active_mm_list:\t%*pbl\n",
+		   cpumask_pr_args(mm_cpumask(mm)));
+}
+
 static inline void task_core_dumping(struct seq_file *m, struct task_struct *task)
 {
 	seq_put_decimal_ull(m, "CoreDumping:\t", !!task->signal->core_state);
@@ -450,12 +467,15 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 		task_core_dumping(m, task);
 		task_thp_status(m, mm);
 		task_untag_mask(m, mm);
-		mmput(mm);
 	}
 	task_sig(m, task);
 	task_cap(m, task);
 	task_seccomp(m, task);
 	task_cpus_allowed(m, task);
+	if (mm) {
+		task_cpus_active_mm(m, mm);
+		mmput(mm);
+	}
 	cpuset_task_status_allowed(m, task);
 	task_context_switch_counts(m, task);
 	arch_proc_pid_thread_features(m, task);
-- 
2.51.0


