Return-Path: <linux-fsdevel+bounces-74010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21899D288C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 21:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04B4C30268D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EBC3254A8;
	Thu, 15 Jan 2026 20:54:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021090.outbound.protection.outlook.com [52.101.100.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FF2E92C3;
	Thu, 15 Jan 2026 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510459; cv=fail; b=CbzuIYCFD9c4Y/r5N98mjh+QjMJ8frEykgY7ZhDkV9hOCsZuva4SnULnrS56M5EGSzZia5y9tpMXrTmthnJ1USxOeYrTPim0jjp77R4GjvdQK2r38aO9WrQpIqGavVlTd1dKGJkwAtIdBysEFTWbT06T1pAH5YQGxmr6iZw008I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510459; c=relaxed/simple;
	bh=G1/+Cmg+XOBdBJhdeaex2pqKofX6R4Y9Q6AEe8AYm7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UcjjxbfOUQfUx79ZbRGqRwE9dCx1oMoNUErfg45G+IAUKCWyym67XDFQqHSErx+BKQMS2tNr+6okx9SkkeOjz3k1eIITVj0iKtRvRXciHO0KXS/bH6wydysxyk05j0A+vZRvLbaGdv/Y/o1YHH9wGHt/wmsLi71OBIfUZA2aR2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaiNC/3dJ9ztXME6UM/DCaF7QSVPMuDRXGJDb+Qs9pVU7mHUtSP4uLEbdpdvdrR380EhOLKaJ9WQhvBgjhZY1qSph0k5g+QPumjFX9zD6pRpZe00c7KIq0Ko4zQQeuM8HQEdooBQCwyT3VZIX8Z1PwwXcGqygP56xkG+TVqX7uDaqlg/+Ktaidm7gbQxEct0Ghc1PGMNH7jChrIvetEsCVpgTs5z8lrXZD7BT4vx9gIXLnmLW4u7q+f8zHxyML7IWAGUjvcf3g4TOjfeFv7j7Pe8b0ezHMuZqzrWPuOi3Bw1YzIjn5ElB5x4NJnUnWtc92Y3bgj3vUHlImQMgrAq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4Xk3nE+QqhH7JM/TenPFhAxTYecLP++UKhJzrDJBj8=;
 b=j2qwISXmkFft/4xEJWTDkEtSBQeLQsV4cp0HtI4IJ0lZdXxxZz+GxWyro6eAzGTiKRxZSvKHyWBJrvy+HYpfX2H9BIx+UGK6B5zLFySgcueTpRTTjbLLTZuff2XpGwubu3YAlBjT2liwmcz6VlYpHikSswc/YHU/sjIEXAyIzBb4Cejbc9QPN5xZmpfULfYoGSWeQwk/azJkrtj+TZVMr1u20uwjejcSPEMG9OCGjGmZFGDbnMDATyxVGZA0ZNF2kTOTrl+vN7e2uEoHV0PDAr+X/Nf9hFqlTg2SbQp1aOX5e8pI38NHBI0Nkzk+AxfFIY2uSzkwoQGJd0yx9g3ZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOAP123MB8226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 20:54:16 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 20:54:16 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: oleg@redhat.com,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	david@kernel.org,
	brauner@kernel.org,
	mingo@kernel.org
Cc: neelx@suse.com,
	sean@ashe.io,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [v3 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Date: Thu, 15 Jan 2026 15:54:07 -0500
Message-ID: <20260115205407.3050262-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115205407.3050262-1-atomlin@atomlin.com>
References: <20260115205407.3050262-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:208:23c::32) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOAP123MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd1cd69-ee73-48fc-d5f8-08de54783eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UxxsZ59scPpfvTJhBsdy8YAEvFjMMlvvbyAgzZhyZgPdi+Olk/n7aYyRxMC5?=
 =?us-ascii?Q?zwQjnUHuqLPwFzMalOQzQZ9HiIn3lZq8d4qModPyyqEkU2o0T2UfB72L1NER?=
 =?us-ascii?Q?ROGTh8ehvkQqP/1EmlKrPoWaNUa4pU/BXu+X24T5Z09qWYzIOnuBGjuIout0?=
 =?us-ascii?Q?Xo/07FVgZ4ABB9oSmolozfRzQTHCycIiplFfk+GGLWj+ohJBfz2pMtuNyLgg?=
 =?us-ascii?Q?QK6/PUS4D6PtLc0oAvpexkTkKsudGAC1vS4MLkYFPZcI5CEBDH2zmSttxqEO?=
 =?us-ascii?Q?HgMwolII8vfD2Bc7OCnjtHgFvDA177Ck/S+OHw9W8dDcqXPgcN8i2XjXi2hf?=
 =?us-ascii?Q?zsGNXMUQkf/BsbvK8mKNuonPI8Fff00w/7XaTiaPutTpEfLaI41DKm54Qm5R?=
 =?us-ascii?Q?cgDX2b3oRtq7DrDpXtMqYRbqdU1Hkb2b++t9Y+k/29+l1p4P/dGaThpKhGR5?=
 =?us-ascii?Q?jwKWlb+8tEq3rDvpVmt+QLbKZ9mY/aXj9bQMZ9HJrG9q8EKki3iHQhJAj9mG?=
 =?us-ascii?Q?nj5QsHg4Gmix2HHZkknGjkv2VStZbJ9Iuh/Jgq8ZAEMWECI8nurWnajWNEj8?=
 =?us-ascii?Q?XbcXjNCmMSOmP45ku/ha0IJSpF/vEtLxxK5+KJkv7wOzlW/cS+A06AYxwfSK?=
 =?us-ascii?Q?h5IK/fUHiP7u73HcUoMsioKnHcpINQB/UYTz82tTCdUs0oEAi/sbvhlSdRcI?=
 =?us-ascii?Q?psz1rbamAslUq9g2xCz+upXAbuUuxl0wRoIp3X+gt7v4ETlTHoyVu8FbWPs+?=
 =?us-ascii?Q?7zhw8IJBaTg72BtsHcrqi6lvRGTJk5Vu+C/5vM5PfLNKldMgaIU9PQaqSxgF?=
 =?us-ascii?Q?1Jb7CIPm4K4e+7f2e+r2SHoLSJ0IJOUYcewr8/3M1n8rjyh6wb7kvNbxsk8H?=
 =?us-ascii?Q?g3rJCgoyMRNFEc61u3UoR44Bf2sNiY2jvPugcOR/KWbtY2kRMV8a5PGYn05V?=
 =?us-ascii?Q?KP1mdt7Dc2gzrJcmAa5VCX1NnIHCRj2Fo1SVEqH455lDwp0OAD2PZu0XIRTQ?=
 =?us-ascii?Q?/dJfZeKfzVLHZNj3e2/LDQcaLU8VVpc2HOZKAvG6LzSBg+XqB/hPUfmPFNN8?=
 =?us-ascii?Q?R9bR8DAnx7M2kJG2DpHnqkPaNAGfEVQRlpApHWkRMNZvtzAdN+urzE6RtI8C?=
 =?us-ascii?Q?AVCsQmVSBV59qCEQWuIYDRvMHTAsVsjhELTl5Eg4M+DJb0RNRHnrsMNq0HkI?=
 =?us-ascii?Q?041H0OuKXhR2vmhf9qfUZy8Giux7Fbk9OYEXNrms7afG0x7aEFGKiDwM5uU4?=
 =?us-ascii?Q?TaI0epz8rIheoOuRgj1chEOQ62T1MJoSks18rwNpLq7Ss1/V/nO6BUuSdYu6?=
 =?us-ascii?Q?YuAmDM8ZfGkqit0E3dWoaWnTa/9yqAUbAhcUDFy0zbybEbFi8JSLlgtnxI+b?=
 =?us-ascii?Q?k2FPT3fw54o9LrY1MfykLOwe+NQdPER1IgM4CcI7r6Awo2U4Na6KN/ZUEYPs?=
 =?us-ascii?Q?T3NMic8gO0bfWfU2qOTcsSK2MEsxJD66MuvrrMAebKdSUTSvnriDVjEYh0P2?=
 =?us-ascii?Q?dxxaq+lZRb6GQLF1+JbjqqeNtYLQLK0Gx/sWWlem1nX978UVYU8VkhTZ6exJ?=
 =?us-ascii?Q?Id8Tg8Wc8qMrKxIsZ24=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ox+NBXk0d5QeJt9t6yqNSu1OE6R/zgtDAAI+ew5KX/y5Kql+HE+owEDhbHw?=
 =?us-ascii?Q?JebPe8CdHOKZmgnHmyjNnl+y/DmhfL4Ur8sL4h1mTtRgBe7qES/vO1m9H3jv?=
 =?us-ascii?Q?FNMOqcV2DIA4Y2SpfOrTHULHe+KYuFIot3pqF2L14P4JQXy2imNg85dIINVL?=
 =?us-ascii?Q?0WCG9ljfDRQIqQm2fBxSRzq+VTc0WDpoRRzqEofAPT+rQa1frDR8pAWCWCDH?=
 =?us-ascii?Q?kG4SsD3niqgrO5Ql7SkQUYOqDkbcKA1C3eFO0gix+HXuoeUC5oyncla4y/0J?=
 =?us-ascii?Q?VJznKGdRhgBuzpoJiTPJWrcfc1TInbs+s3snYkZgzAOq3nP0sCyy1hPvl7dw?=
 =?us-ascii?Q?m7BDJwiTCzvbNy5eww/Imb/qVKdSJ7EaQFgRU2AA2pOdrNic3Qa7uKEFhWEu?=
 =?us-ascii?Q?ah1xxS7Nje2R3U0p6hCrBRaNGvPDLrfzioh+Fu40QujIflvTeqWH+YiAmoDW?=
 =?us-ascii?Q?2mzTIczjvOFVHVhCpBWdbJycviyBNbYRx4PdR9BwwW1LIx5nN52BorWJvbra?=
 =?us-ascii?Q?izx5mPTxoh9q6CfIXQY1fYJyei043uUJc4VwRniUPxc4udDUdSIdt6u/CTea?=
 =?us-ascii?Q?NjBUHg5/9Kw4cW1z2mJ8OS57L56RxWtND///5OSAik4A7dsDrKcbXh/Sf/Jj?=
 =?us-ascii?Q?7WbdEOwpOPjMxtF+XKU2RzJ/pm6FZWmetOCG550Prz+8Ef3Ia6a8NNNBqgat?=
 =?us-ascii?Q?b4Dp6MKa2C11jKY9msss0BWMnQ9xXFNIFhx8WaIpLa5VC0NbmvwWK4pj+7Eh?=
 =?us-ascii?Q?Hl2bFoorGEkvV7vxKfIQnyrPcl745Hgpj72dc0MdKz6Pb4dSbg/NDdTiUceT?=
 =?us-ascii?Q?Tjmdd+V4gMZl07mdkBusF2AfM2zHmNkKEW4HUXahqQqUIY7cTId8PpG81NwP?=
 =?us-ascii?Q?XZe0qegGqhqi6dqGSuJaGwxYK22aexxbmc7nLV3QSx8fVK+/QCkAVnnDOJ8z?=
 =?us-ascii?Q?LxV/sgODg2xxpZeP/KZwjmG6k8SC2RpUmZa0kGfObD8T5j5/FeKYZgMZe2sP?=
 =?us-ascii?Q?/9D9NNbKgb52c2t6xI8ahvSKCjxITHiHcSCb7RmXu+8irmC005GrdxWUjzdK?=
 =?us-ascii?Q?CjSk4XujOVFLAchw8g+cVcoUzsqlIuBwDfCAYVLlCUSdsjd0Nx2yUH2gvDBn?=
 =?us-ascii?Q?7W0heKbJMJx8w5AyU9Wk/7BIGMfnhFF4zJgKF0DmppvmAlNyMING6aIdy3JB?=
 =?us-ascii?Q?bcMor/rnkSUP0GSTYSr/86zN0uq7uAv0MRNjWjcUZZbNuzSe8GFCfozvOPlK?=
 =?us-ascii?Q?6X8evr/5hwL/uEOZogH+PlrcYAoDzBHUN0BX5Om3xu/gP+YG7tHHK8Jmx8nE?=
 =?us-ascii?Q?neE+Fkg7A/zszVCJaZgugiQrD5SVFze8Qm07WcgDQBLRAm8TMrba5RSgnHgB?=
 =?us-ascii?Q?horWaV9OnGO9U31vqRGTd9RBJY2wsSkrIB6W1Uugt/k4aa4oRRnMFRvUWarj?=
 =?us-ascii?Q?0Y/oC5u2GZxlLC+hJOjh4lou5aRIkRjfmnr1vmrobANDI3kC40kRJBHkn4iN?=
 =?us-ascii?Q?S4Myac8vN4H2nmUIa64veOtia/WtK+b5HZIEYqf6WXuHeGahFccqDxT7dkx+?=
 =?us-ascii?Q?clIrfAvGwMzNspdMKG8Sr7oPcCqwBcLp7Ar1pSacbHOM3XF9Vcveo+ZUTYKM?=
 =?us-ascii?Q?qIi4MKAeYiri1GZZ50+Ei+X2E2iDfgnZo6nV11r7jExE70YshntZDk1KXxt/?=
 =?us-ascii?Q?PQ1+6Fqd4EqJtG5r3yErub8ui89EpdYasDynkwI8U2TQ+NAF/LtQH1z9NKt3?=
 =?us-ascii?Q?e0YzgJWufg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd1cd69-ee73-48fc-d5f8-08de54783eb3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 20:54:16.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENLgsAmde2+uVzshPDwkeMvni7e1DVnS/dQ8GwqfWOxQB5aoRLkZwUcM8EK/+YBxAtTioEq5UimHiZcayez19A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8226

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

These fields are exposed only on architectures that explicitly opt-in
via CONFIG_ARCH_WANT_PROC_CPUS_ACTIVE_MM. This is necessary because
mm_cpumask semantics vary significantly across architectures; some
(e.g., x86) actively maintain the mask for coherency, while others may
never clear bits, rendering the data misleading for this specific use
case. x86 is updated to select this feature by default.

The implementation reads the mask directly without introducing additional
locks or snapshots. While this implies that the hex mask and list format
could theoretically observe slightly different states on a rapidly
changing system, this "best-effort" approach aligns with the standard
design philosophy of /proc and avoids imposing locking overhead on
critical memory management paths.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 Documentation/filesystems/proc.rst |  7 +++++++
 arch/x86/Kconfig                   |  1 +
 fs/proc/Kconfig                    | 14 ++++++++++++++
 fs/proc/array.c                    | 28 +++++++++++++++++++++++++++-
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8256e857e2d7..c6ced84c5c68 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -291,12 +291,19 @@ It's slow but very precise.
  SpeculationIndirectBranch   indirect branch speculation mode
  Cpus_allowed                mask of CPUs on which this process may run
  Cpus_allowed_list           Same as previous, but in "list format"
+ Cpus_active_mm              mask of CPUs on which this process has an active
+                             memory context
+ Cpus_active_mm_list         Same as previous, but in "list format"
  Mems_allowed                mask of memory nodes allowed to this process
  Mems_allowed_list           Same as previous, but in "list format"
  voluntary_ctxt_switches     number of voluntary context switches
  nonvoluntary_ctxt_switches  number of non voluntary context switches
  ==========================  ===================================================
 
+Note "Cpus_active_mm" is currently only supported on x86. Its semantics are
+architecture-dependent; on x86, it represents the set of CPUs that may hold
+stale TLB entries for the process and thus require IPI-based TLB shootdowns to
+maintain coherency.
 
 .. table:: Table 1-3: Contents of the statm fields (as of 2.6.8-rc3)
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80527299f859..f0997791dbdb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -152,6 +152,7 @@ config X86
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
+	select ARCH_WANT_PROC_CPUS_ACTIVE_MM
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_WATCHDOG
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 6ae966c561e7..952c40cf3baa 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -127,3 +127,17 @@ config PROC_PID_ARCH_STATUS
 config PROC_CPU_RESCTRL
 	def_bool n
 	depends on PROC_FS
+
+config ARCH_WANT_PROC_CPUS_ACTIVE_MM
+	bool
+	depends on PROC_FS
+	help
+	  Selected by architectures that reliably maintain mm_cpumask for TLB
+	  and cache synchronisation and wish to expose it in
+	  /proc/[pid]/status. Exposing this information allows userspace to
+	  easily describe the relationship between CPUs where a memory
+	  descriptor is "active" and the CPUs where the thread is allowed to
+	  execute. The primary intent is to provide visibility into the
+	  "memory footprint" across CPUs, which is invaluable for debugging
+	  performance issues related to IPI storms and TLB shootdowns in
+	  large-scale NUMA systems.
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 42932f88141a..c16aad59e0a7 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -409,6 +409,29 @@ static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
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
+#ifdef CONFIG_ARCH_WANT_PROC_CPUS_ACTIVE_MM
+static void task_cpus_active_mm(struct seq_file *m, struct mm_struct *mm)
+{
+	seq_printf(m, "Cpus_active_mm:\t%*pb\n",
+		   cpumask_pr_args(mm_cpumask(mm)));
+	seq_printf(m, "Cpus_active_mm_list:\t%*pbl\n",
+		   cpumask_pr_args(mm_cpumask(mm)));
+}
+#else
+static inline void task_cpus_active_mm(struct seq_file *m, struct mm_struct *mm)
+{
+}
+#endif
+
 static inline void task_core_dumping(struct seq_file *m, struct task_struct *task)
 {
 	seq_put_decimal_ull(m, "CoreDumping:\t", !!task->signal->core_state);
@@ -450,12 +473,15 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
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


