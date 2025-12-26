Return-Path: <linux-fsdevel+bounces-72122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BC2CDF04F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 22:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0971A3008885
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 21:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737830F554;
	Fri, 26 Dec 2025 21:14:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020116.outbound.protection.outlook.com [52.101.195.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFB30EF92;
	Fri, 26 Dec 2025 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766783660; cv=fail; b=lQJ5t/C0y9DFrWvXQl389EuzMVRyjdMqnAyfjXwxWs6tsGhBbdcpSPQUwCZ+YBxrt3ZoGCQd0Gwr0DBXBHq0BK26jQJlsLV8f7yc0qStJT2JOSkjMbysYXI1mmMcIazoiSuFntY508fTkBVBYyT2XhDBDO5FlITR+EiFzG1XcoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766783660; c=relaxed/simple;
	bh=uc7IGK98MsEu9NKftWuEHMpgxe54L3vPBWhrzJR08oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m89RKKhon5kTjBsIiVnv5EKWzcjXR7toKPwUEPTuI6c9zaEk4VJLcE7j3H6Cu/2h+VKzuYVSmgXgK73O1gskoo4Vog/P4I3xrFdvajwcZLeJ3NRjk1aJ8C4Q3Kq4j0lNbbSms7PIUvZo/FhNCvRhfeAErntunE64S0vCpg26Ehs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lF9AP9dyMsSYf4OCDOmLldQPQkVcZ3BUh7imKS+6iOwvkLwVAnaKUJoX/jhJNqGA7ykZ1zY+IZjZQDVeWFiIK4xi2Z0TSW9Mzypz5AzZs2XEWJ2/+7W/HLJ050gYF+0a7Gt54hH7YMcZPV7Sng2CS4XgCDZe7VEeVb7YUKOsRWIaFcSLcRFcwPjeETK3fxj5fFxtaNESN/7AVP/8ycjcWQXvZOc2Tac0zS1SLVOTH4DRPtetI0GJazGQ0uI2htS/lChz0xnRUmeJ7PjDsxgSrO/1TxIqFgGqY7nbjyuHeuHgNgiShpxZsVtxJG+o9TB1aHWuG+ZPAX+Memby71DlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1YAkOdlA9tW8sphY8sJ5wnRTrUwR70pcDi3PJ4+QN0=;
 b=JwHdeU6curHswQ3UfOud+4FFAurwnB2vG4G9/UHAAoQFu4ZLqnSc3jLLnGgYMDx23OrXBdZhaulnM3amvdRBtWv3vc3zFPgm2rJ+QfJ38Gc+UBZ6zKdhSldXx6c7L5jBmBq50s0w/AoAmb+c+9N/SVYxf4NyDcLqPqjMs9hbBnLewDcduQIRdgLxqD8tTbZtL4vjHVdwODU0jY0aYUqKgWvwcsOWOmraL0wdD/Y+PZVAWSk7WUoVfRoOZMIzUyA/pAZ6vycnaWuJOZVC4jiE+PY7RK6bk3iXtjgLB2iQkhqVmDaERL5tkUxIqN1fc7gO7pPa813NX8dwR1i7HcoCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB4236.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Fri, 26 Dec
 2025 21:14:16 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 21:14:16 +0000
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
Subject: [v2 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Date: Fri, 26 Dec 2025 16:14:07 -0500
Message-ID: <20251226211407.2252573-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211407.2252573-1-atomlin@atomlin.com>
References: <20251226211407.2252573-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:408:fc::26) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: b3282f15-800a-4bcb-5d1d-08de44c3b9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mkrxTGXMmLCCMvez6o3B0faSoJufaRyDpV76yxL1hFTxr71lQUsQ2BlyAQnw?=
 =?us-ascii?Q?mRQUQhyNI52n3mPMtELNLHxX4uKk+oJL56Hba1ymnQjj6GSB/Wtpb+4v6ox3?=
 =?us-ascii?Q?ys918/heKbuD+TGeXY32h+Sb9yIq9PrH51oNGs1bHCdG3XA8Gahr2ZmobaAV?=
 =?us-ascii?Q?nEo9NlGCS2RDYAxQ1wntieSQkP7ivkRPkjd/UFggazBEqeu3TalU8xPN/i62?=
 =?us-ascii?Q?jp5gJZWItD7gzZwtwNJjbPzNvGAwynwuciyINk4mLyNfUlm3LZN0Ga+aNipH?=
 =?us-ascii?Q?xOlqxc3kXCmYQ0P6IVooCKVEkBL9SaNhdvFPG+khY77WgnvSYthoSQH4Jcel?=
 =?us-ascii?Q?xT16KyMddruMa5JCtpVHhwRx90wv9bFZSkjtodHUUHtEyxhjF8DZZPPhYGK8?=
 =?us-ascii?Q?QYo5bMHZDrqOkqz0w0Z44WwvXcjaa3RTBKdP6CcKfe2LZo1CZqe4QugXjTq9?=
 =?us-ascii?Q?OHV6odoObT1TtU2BrT9bltmMepzWNpQ5Hjp/kdKKfjJtbApxh7oqD8mHuDIJ?=
 =?us-ascii?Q?W7tW+vlPE4OTLphzl6wODyo9cRkzcIlL9pZMbjbtIp6ihXhp2XlOAwFkjUoJ?=
 =?us-ascii?Q?mznGAIL0+DQxSKmfkSPkoE++iZ+U4suaNRijRbFqP9r1bfi4NH5A6GttVhKt?=
 =?us-ascii?Q?DgeZxphWq3IqQmiGZVy1dY55YicWYb1OTA1IAYTEEdFmSL1tUHXmRAC+ZLt6?=
 =?us-ascii?Q?xQQS3Q1gEBDmOf2F6K0dWecvdHWNxopbSGLZNV3n6ZagOGlaN3juB6FL+bXE?=
 =?us-ascii?Q?s3CxZbBt4rPJSKTp5oW/NNlErDm4IoZ+y1kFI0NTr6BCztQdPCuAH/3G/+D2?=
 =?us-ascii?Q?6CkjT6Z19pNG+vpcTSiR6n3IowGLGTyxBXD2eVv9iLJsP9cJToC7L/ZYOF9k?=
 =?us-ascii?Q?D+eeLNHTbDxPQmB7+ESA5/Zv/osvKz5hTuoPNQFeRnb9PiLkLPH/Ks8ox2mQ?=
 =?us-ascii?Q?UZGPm37UET7BTB1NokRx1olc0lYbG8xWtfdO3mSTxi6ARJNLOXJ93zBDzgWx?=
 =?us-ascii?Q?xz0VDSAVCWgmujtTOzILRUiWOguwwN3oOuhBK8AGNCPA9XZEthcpcfv2z9q5?=
 =?us-ascii?Q?j4UzWi7gZk7S4zRBKyI7XghixsvhDOEcIdr83pYUEJWf3WpMHfMC/zIwkOrV?=
 =?us-ascii?Q?BnPPDxBKNAX9Z+nqzjG5RzD7YziPs7oXJHmgxNbWNJSc4SZc8zZ7u8ZU3KzH?=
 =?us-ascii?Q?jEJ6lJFs1nFWUJpAyVsr5scnjN0yNYi7oH36idYiWVMM58ZRY9wh0z1vBuDg?=
 =?us-ascii?Q?Q1b4fLtnbX9HQXBMC+yZdcpzNSNjcUOHt2zPrDXYQjZRFyf6OVmMZb6ni6v3?=
 =?us-ascii?Q?98+IieX4bdXX5MRkolAh0CXVKMC8DJNvwwj61mbGc8b1N+MdfYu1gVqAxXno?=
 =?us-ascii?Q?A1FKljU+SxZNZSIffh/64OvRxh9hESLc2l771Mlkrh/CNmYn9+dU1Fcdx9bn?=
 =?us-ascii?Q?oUy7k5BgVe1rH4Pc27rr+FRsD4PZUCAg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qPAJ6bTWfQajy0CZhXO6FoL/5scwmEzY0IH/5Fj1x0a+Vuf08HhDl2l6AAdC?=
 =?us-ascii?Q?xQ7vhYOg/WEjph7yhIsFbCPDpob7orp5/abMx875dJu6i7Da2cotV1sjzRhX?=
 =?us-ascii?Q?D+XVJDijIkUH7/u3KPumRcH5SviUWSfqv0yhWcae3A/gmvwELtqkyw0qVrHT?=
 =?us-ascii?Q?qlSYCHwsSVMdNLOPIlb8zDTa0CiH7nXWmMNiPJ6rclPMLBp/qOCNWCdq37J9?=
 =?us-ascii?Q?X/9gNH50hROSUBJWxQQMV4ipLmqRvgaX8jLnrD/2l0z/eQtPOj05Fn458NgE?=
 =?us-ascii?Q?bwC6CeGYWp1Mjuej+Bk/GBHHevhUFwneLtYOcookdJJjGIuICWlAAP9vBIBW?=
 =?us-ascii?Q?q3cEweJTG7eCfHFXp3BQnMdJDZyXC99SGE9bfnxalAtYzwMRc6tB9XHA8Vqk?=
 =?us-ascii?Q?0d3+bBfSnJy5G2z2vHlhNsOP61qrLrf96wTwpPeVgToqNH0n/RXJmA2gm8jP?=
 =?us-ascii?Q?xFPdF7RQ3xcQC5e7wZZi/doQRnx4rC3pAA9sAWmHkVZBHNcgEO7EO/zX12ai?=
 =?us-ascii?Q?3hiH0r4dUFht+p3ssJnioxlmIG1goHibkncOg6H/k3/cTeTgYfficIKzYfjE?=
 =?us-ascii?Q?D6c/YwQ3xRk/4qt/p9xJ/5utTO4Umerarw4hOcNjzFTJHrdKn0TJF2rDwjzk?=
 =?us-ascii?Q?ionOuFavnhYR2svbnm9oDPPaq5jILrKJtiTvWJ8S6r9I/6IPr4JAmFdTqlRY?=
 =?us-ascii?Q?+seH5Tu3dZ3bJa7grICzJ+zX62k3F0ydpN7HhoNlCj9dbs16041Q2bbqQCEQ?=
 =?us-ascii?Q?TmSws586XAAC5o0sX+EqiUbcNIOmIoHpBjaANJOhYWImCe28vkkSmz0Z03Gi?=
 =?us-ascii?Q?kgjb10yUr3ZgfFA7+NXBLFkybqqRiP+n3RZvz2iB0bRFvlzVvYcMumxun8Gs?=
 =?us-ascii?Q?qFveVwgE1VD39A19pAGcEWfPGab6NgBhKbvwzcaHuwoS51AygjPy6podG05f?=
 =?us-ascii?Q?B3FFSf6yqG6iZSpRM5sPqKii74qqVjx3bSUcPCexkGk25NUMJ7BU7X4mriQc?=
 =?us-ascii?Q?g3r38+HeCT4pkgfIueesgInqst0abJKrEWLVW0LWuFqB9k2H9qNSQTVV0jFb?=
 =?us-ascii?Q?kF+7Ssgoo8yKppIK9G1UDjiB/VTXWoGe609tWV5Rw8ay4fMYhYY2IrXQXe6M?=
 =?us-ascii?Q?XUVsQVxlPWHUZyW+99P9+On4iFSwPTI+7vXnmK1SpQREfFRsTvMRh1hgija5?=
 =?us-ascii?Q?hO9wjx1OqOLuFEpjDefDbpGdJSFOUHVun4eyh0zu7gAlZ3DGCFx/mox/4xVv?=
 =?us-ascii?Q?Yz/5zKbTAkEJ8aLSf7choh06aeNJIIN9oN1vZQGVOCqnpWPuIZUUgv9EPFfN?=
 =?us-ascii?Q?nvTo631LRe44VC3e1pAfi3nyrKsdM4T3/Q31HYPUtDz94VXOXwceV6Djduvu?=
 =?us-ascii?Q?GYUXeNPsnc638W8yzE+3yvKs6ciOeWvyg7oPOomPKDOGWpRng1gEbJCBapao?=
 =?us-ascii?Q?vZzOvUn04fDP3d4Q8DjfBvSGn06f26LBoHc+xgRnqeOUFibvEf6cUYChtO7f?=
 =?us-ascii?Q?KILSZ96uSuInzaHWGuHlRpThY9RErMoEPuKNlocZgItGZEb/SG2+vloN1l0C?=
 =?us-ascii?Q?UysTeohEg2TEfu+QNU0c7EDG8SKBwIZcLutdxuwOCjWgoi2TE2k4aTq+lk0Y?=
 =?us-ascii?Q?xjner5mFAm2c62Eyof0V97+bYtiVsZfvJNqtiKut/dbFhBrS4+F6wY7yCnAR?=
 =?us-ascii?Q?i/DbsLE+hivqtGtdDp4aF6xWExPyLb11ZovfUQhdmb/e0cTaie8CZUc7cuqp?=
 =?us-ascii?Q?JfxuluB+6g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3282f15-800a-4bcb-5d1d-08de44c3b9d7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 21:14:16.2676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HD9sV0cJ/qYN9As+UVYlyMFuoT9cIlJIrbkgktK8wL5M+7i3fVEVm1DL+mzFgH5imsOSJLDUT2FFqmN6EMIndQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4236

This patch introduces two new fields to /proc/[pid]/status to display the
set of CPUs, representing the CPU affinity of the process's active
memory context, in both mask and list format: "Cpus_active_mm" and
"Cpus_active_mm_list". The mm_cpumask is primarily used for TLB and
cache synchronisation.

Exposing this information allows userspace to easily describe the
relationship between CPUs where a memory descriptor is "active" and the
CPUs where the thread is allowed to execute. The primary intent is to
provide visibility into the "memory footprint" across CPUs, which is
invaluable for debugging performance issues related to IPI storms and
TLB shootdowns in large-scale NUMA systems. The CPU-affinity sets the
boundary; the mm_cpumask records the arrival; they complement each
other.

Frequent mm_cpumask changes may indicate instability in placement
policies or excessive task migration overhead.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 Documentation/filesystems/proc.rst |  3 +++
 fs/proc/array.c                    | 22 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8256e857e2d7..c92e95e28047 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -291,6 +291,9 @@ It's slow but very precise.
  SpeculationIndirectBranch   indirect branch speculation mode
  Cpus_allowed                mask of CPUs on which this process may run
  Cpus_allowed_list           Same as previous, but in "list format"
+ Cpus_active_mm              mask of CPUs on which this process has an active
+                             memory context
+ Cpus_active_mm_list         Same as previous, but in "list format"
  Mems_allowed                mask of memory nodes allowed to this process
  Mems_allowed_list           Same as previous, but in "list format"
  voluntary_ctxt_switches     number of voluntary context switches
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


