Return-Path: <linux-fsdevel+bounces-74009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C9DD288A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 21:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1958030150CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 20:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995F2EBDDE;
	Thu, 15 Jan 2026 20:54:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021090.outbound.protection.outlook.com [52.101.100.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC429B8C7;
	Thu, 15 Jan 2026 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510457; cv=fail; b=eg6BeXnIwINmWalj4EZN0G9hrEJMhcqglg1G6KH8cpQRng2F88bNDIGbV5MoDhMlBlrGAs15VSMJ3pSnw1lghMig/Dqst9/IYgAyp+rBL7aBV6VKB4ZkmDdynJVRCmg09R4K+zsOq7QCgNH7PWi1VY1IYSqRBt4jKAxMiNiSBqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510457; c=relaxed/simple;
	bh=jASLQCKE1/1Oty4EGocuPugpRyRS7BGKQRj8AchLeVY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TQvErRDQKq1rd8JY2hy/oj8fY68tggX1K0igZQo7X4y2sVcIZdbK7d69QLmDbvUudfz1jdx92Nq2S396QHkspa63bJfHCxuoPKt8GYDavg3D2AP4UVcvHTHtizYF0cjpVv1KxV8uL2PmgGLJx5d0QotWclcJWgghdbsU51wBqU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/G8aBQH7idU2OCX+nNCB6iRraR1QLuYztUH/BfcB+lQvSXwy4JvNjZ8rR5VqxRmXYczh2ResW7FRkvmfvWYRSQy7gT1hyRBiToECcsbCkQCk9oDcVPvblSg6mBITchRYaM1o7Qzk0F0Z/Rq84+T5Hq6jQh3wiAY/uYAJ0rpn8lCIjBtdaO6sVDriQxm89bZJ3BVQrt87Hq0PIE61ipT6bNImDU7IuB2OfLagidUXIfmO1PRIHor1KmjSUmn20G6u9nCPyK51TOeiYdvKll5doMwdkiZ1UGNd0Yy6CHC4jcrvCIaNiAdc6DWCBz4ui1R5wD94xC4PJmfgI7bmTTPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzMZsnYeiN57MIawJMIU4W7CiF+N4UDLU4y5riFicDs=;
 b=ykwEKO6jmnQPpBW7PpWBdL1dsITUpwBf6Za2jHxSIDhkdZLyaFdA7aB+zBmksdQ1T3UBJEOzhyshberoc1Qphc5ghADL/NoEqeNcKEDJ/G5eEc7Mj7Xzdlx4GTt9p0nVVnNoWUcxZ3exgVRAUl5zLLa3FhkwzjslPv8FkGtQaW/Tom7auuT046HKg/KEh0awRcYO95ebpKV7osqYueYnYD1GCssv2xiKezM4aFrGOa0n4FrV3J6OHtrpHwaUqScdui8qvhdDssYWbONalB2BVvS7uARoqG/vAKoDDMXC/oXBBRFO28pPtbxVRQ8iEBKvWE/K6WPm6RXh0psDHzLxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOAP123MB8226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 20:54:12 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 20:54:12 +0000
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
Subject: [v3 PATCH 0/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Date: Thu, 15 Jan 2026 15:54:06 -0500
Message-ID: <20260115205407.3050262-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0040.namprd15.prod.outlook.com
 (2603:10b6:208:237::9) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOAP123MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afeaf59-beb6-4711-071d-08de54783c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z/a/aYORTCn3FXsDZ8YCJJGHNRroRJlZWsNll7YJ5ORe6dd2wi4iJyFnwO1h?=
 =?us-ascii?Q?6aK4yO8ljyMTNRnzIO4Fn+/KQQRh+E/3PAz2IuN7J5H3SLDsdZF61+FFardy?=
 =?us-ascii?Q?I+5pkoI646QwGDLt8WGQXuFOVek0GXLSQdPpJc1ONu+/dxMl4ZjIniBhxP1t?=
 =?us-ascii?Q?lNLGgfXxYgIWtby5HGilMuWGvs3Fce94hjwXOR6d2dV2caayCehjlcr3CoRi?=
 =?us-ascii?Q?QqBR5Z8hK8HtF1UIOIUWsdGrTVoO0ZP2+OrBJQdbeiJEblkyjlreH+2Xi3fL?=
 =?us-ascii?Q?FfoBsHpUcWIXzLH3RSBOAUUKw5K4ZrGty3B2AWPsSfRnE83aDKwH2NJr2xcZ?=
 =?us-ascii?Q?MaUAWLR+vhq1laeqBH0y1QyXRoAjjXIdSpzASpj2PnlhUDRrs7KNfMTnm1q5?=
 =?us-ascii?Q?qx52r2mEOuZRRTgRDv3/d8ZAA7gWSunbd1TLAL1Ax/L6b8K1kPmTmG2MfLkz?=
 =?us-ascii?Q?UTq009pcjMlfM+FIwTtsfz1bGvXsN0KH/dpES+Kvmf0+rl63FN72I+8UQHGv?=
 =?us-ascii?Q?Tgw03OV24LCXwkf9cedWawkmkVrp8S/DqRlq9swmFCowlwhetxF0EOGbQ9QW?=
 =?us-ascii?Q?aDE7fX00n9O5iEAosRkEQzJSgvdfA0fbYfckm8Jao4BPoNoQmySl1tg/etlT?=
 =?us-ascii?Q?EOkVLs001hRY2ycOeAw1ef8olG5PREuzu1kxnJHr3T02DAFgGKDLEpCeuhp2?=
 =?us-ascii?Q?VlT9gSrXGtPrNc36Dx5tnB7HtgCPTOfccw8CKFW2MYqIsXiRWqwVQFeN/6um?=
 =?us-ascii?Q?Vgdb155ijcHxWmBiD2RWMnFxUlRrIVPsiV8KndbfYk5Fe3QLejEJIrmyE0XA?=
 =?us-ascii?Q?jY1+wrHXIbmFgeacSwvBJDlRprQotEtnXPBSiw3bngjToO9+VvsUKoy27ZXh?=
 =?us-ascii?Q?pHa3xIuaWQazbb0ZeYcNW9nz1woAwl20iilZy9DxMXUtEwsIcVsnhJNilTDC?=
 =?us-ascii?Q?ZResN5Eo+ihotwzly72XeVn9nj9K2KoqijWmcnr8zLt2/rQUGSBhCfu61AKs?=
 =?us-ascii?Q?XBRr7bq/Xqvr3EVaU/LMGr065X2M73xxntR8enY9s11xi1ghkLf8jcsfM1Mb?=
 =?us-ascii?Q?4Mv94FQzo2aaV7UJQyhoWWh2zr2AquKBg9EtTVW7tmBbs4opRHTPeEuT5lao?=
 =?us-ascii?Q?8/MuvauzhTiZZp5jk64H329j/+Trjty/rWD3Tcs/fOkLVIINRRMOrS+VMBr7?=
 =?us-ascii?Q?4FOQJGTNpVNpbG4LwiMVVxnX2LjYmEhWK71sejioAQVTwcZCo9EDjUg4vsuP?=
 =?us-ascii?Q?1wF/BAWwgy6TCqhaFAbQb76ja7EXAZ8Do/w7GHXtNx2f6eGI1OXDtnjUWrM5?=
 =?us-ascii?Q?0SJGZCqe1yw6utfrY+NiK0kIRQLqux3FnkwWpwqjodk8FQFuqE418u3ROC58?=
 =?us-ascii?Q?0E+yHCunhQgfyBvF/Hco5WOljUIPSG9XoowgWmQGuWi6cGvfqXFg6W6Tn3vx?=
 =?us-ascii?Q?zuHYIJ1rFjG/wzmhY/2c9KcivNnCZWDnkTxLJv9IQCncpvSnO+utdjDROpSi?=
 =?us-ascii?Q?Th1xtX45C4Dknn6W5vlxA9h9ZP8+sGhAuxyBUkEGPemZqOB1ROtZSoceODtz?=
 =?us-ascii?Q?mswkUI67NB+zxR3+fiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PQoUFim360+Aajta87v9w/WeMgK99k9c+pcmsnMxlIFVkRzruqX2UIiI5cL?=
 =?us-ascii?Q?3LLvd1nc0IbKITcvpBKLnbBIvArZH5M77GE9MkaCZsg9CB4sLV06KhqLFBRi?=
 =?us-ascii?Q?M5AxziXPxkE4FW1jTkEcBdUQPe6+WQPlfsAh53Wcmfsizo4tdOa+SNizbALF?=
 =?us-ascii?Q?rFajzD3coNaGjWnRIOC+iCyi011ukwdbq8Azx4NNerdhRZK59v93reThdSYB?=
 =?us-ascii?Q?Oh9dxmbXQjuhjp3x/+lUtQNC8njBKoMpXZAM6t4yJEViV62vo8bAVc8tF14D?=
 =?us-ascii?Q?IebL+hq9ue8jt3wWyEzfKIfQFwqtmP+DpXxEnpgpSYGwqeKIiIlEgZuKPblt?=
 =?us-ascii?Q?U5RiLO57qjanFTcIU4DbIMFoOk6X/wtbBOW0jdL12Ssc44Xj4sI4A15JQ9F2?=
 =?us-ascii?Q?AlJCz+Abp3MlUWul1igrQ//ppeo43utR8qJYyoNh6Q1IqcbchkJYlCbyv6iz?=
 =?us-ascii?Q?Uc7y0NY24Auk+wyK65Cdlcy9tfUDULXDQI+FJmj5+xdqikKh3LzFnxJANeW+?=
 =?us-ascii?Q?NmuX1FldHarlU0ccEQl8Cd+4i2qDLCpcBT1kXOWtsAOE34Uv0yKXWVSmz/pE?=
 =?us-ascii?Q?4sOCxa/9YPQ6dU6HZGxazZzdE1W8/32/9+X/iWLIJ2lOqVbn9zPUGsUnhJP3?=
 =?us-ascii?Q?XwmQzqCN7gdLDEK8jb5R0NY28SqmjB1kTzzz74x7E4xp6zkSM7Ey2UWxxZeV?=
 =?us-ascii?Q?dqT56DD1nywxLWAUbmZslh7dwI+SO2QYOSOtOmfuGBW/04lCuM+kQZEEsW2t?=
 =?us-ascii?Q?Imm46Qi1Gd57Rt1d5sVXpC7RrKLIEAgLUXYIabAipcLRDYvNVwF5r0/pMeJk?=
 =?us-ascii?Q?9Hf6ySiqddBHnZy54XOQJzVnACWuIS4DCctJAdrzZrLafaGS3IIAsBdwh90F?=
 =?us-ascii?Q?qVcQX2SLxyhyRCFN4Zo+8Zh2xff6vssjoNHdteQ/frhvfmDg2AoN7G71IQzm?=
 =?us-ascii?Q?x8EfKKldZjswu7AD42ehi2hgUbWoUi5tfYQu4R9yUZbsZrTCCYUE6lair0UO?=
 =?us-ascii?Q?r9aVI8gxoM2/7F5cVBscorin/c7si7c4SSA02qaBvsItemX59PvkqYmnTiif?=
 =?us-ascii?Q?gvXNcoq9D+ZjiKYxaFzvtXHGgX0/BavdAif85c/kOG2LldzmHcixbpKBr0vs?=
 =?us-ascii?Q?cCHgjzCbcfRFSvhZ+BPldf8jJwLyg/QxljUMGI+goOutS6h4mEMGZjap//dO?=
 =?us-ascii?Q?6UNYRFlONl+SPiphm0pTyQ0EDWM6Ke50oLyfv3osoMInr6BfDBCiUcplQOyv?=
 =?us-ascii?Q?Hn7c9Ukp58IY9L/3YhKVdPIdM9k/4oh9EbxIFerCXQlMzSIlVDsfGJrrTLvf?=
 =?us-ascii?Q?8NNMyzd7Vo3solpjgO9fkW0UB/Ow+al4JURDZ84MsjjFM19GT5hHTHAdsrNv?=
 =?us-ascii?Q?Trui7tLt0iDhB3ByV2l237NdYmZyLz9KFx1Yu3/yrpLZBFvTb+FM/XybWs7c?=
 =?us-ascii?Q?HlLqKP4CjrjHpAD3E+lRLq8vOAycjfG7SD5LkiT0cGmXUfh4TAWvYcZH9l/A?=
 =?us-ascii?Q?ECUjOG55RNyHXDrPttVJOB/OSo0I/9ahY5rb2owwiCOUgyGmT+Rxb6ZmR5su?=
 =?us-ascii?Q?fg/uSxPNZZOLe1RjSBYkuHT+vwNdZVNuW/YfxGE+keSaZ/vl9BqJh/gbucMl?=
 =?us-ascii?Q?evN8O9uYgWr13UCZfPlgytCTTV33+QXElcPz6t4a5EUNxO2m9iEbkuNbPzsD?=
 =?us-ascii?Q?b/7rgjs2GsaBV7ZyU4x8rJrjl+0yFjLxGO7p7fa8p2RJfWJMbZMvMhR/Rb5t?=
 =?us-ascii?Q?ewY4/aapLQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afeaf59-beb6-4711-071d-08de54783c2d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 20:54:11.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cDtz1ygCie1Q/NnJ/HAVdtesZGntBbnZAXA6E0QD4MkQf1tC9r761vJs6tfNJCwsUblxu1IUDNW2D7T4UpKQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8226

Hi Oleg, David, Greg, Andrew,

This patch introduces a mechanism to expose the mm_cpumask of a process via
the /proc/[pid]/status interface.

In high-performance and large-scale NUMA environments, diagnosing latency
spikes attributed to Inter-Processor Interrupts (IPIs) can be particularly
challenging. While cpus_allowed describes where a thread may execute, it
does not describe the "memory footprint" - specifically, the set of CPUs
that may hold stale Translation Lookaside Buffer (TLB) entries for the
process.

It is this footprint (mm_cpumask) that dictates the target destination for
TLB flush IPIs. Discrepancies between a process's scheduling affinity and
its memory footprint are a common source of system noise and performance
degradation. By exposing this mask, we provide userspace with the
visibility required to debug these "invisible" sources of latency.

These fields are exposed only on architectures that explicitly opt-in
via CONFIG_ARCH_WANT_PROC_CPUS_ACTIVE_MM. This is necessary because
mm_cpumask semantics vary significantly across architectures; some
(e.g., x86) actively maintain the mask for coherency, while others may
never clear bits, rendering the data misleading for this specific use
case. x86 is updated to select this feature by default.

For example, outside x86:

    # make fs/proc/array.i
    # grep task_cpus_active_mm -B 1 -A 3 --max-count 1 fs/proc/array.i
    # 430 "fs/proc/array.c"
    static inline __attribute__((__gnu_inline__)) __attribute__((__unused__)) __attribute__((no_instrument_function)) void task_cpus_active_mm(struct seq_file *m, struct mm_struct *mm)
    {
    }

The implementation reads the mask directly without introducing additional
locks or snapshots. While this implies that the hex mask and list format
could theoretically observe slightly different states on a rapidly
changing system, this "best-effort" approach aligns with the standard
design philosophy of /proc and avoids imposing locking overhead on
critical memory management paths.


Changes since v2 [1]:
 - Introduce new configuration ARCH_WANT_PROC_CPUS_ACTIVE_MM. The x86
   architecture now explicitly selects this feature, ensuring that the
   field is only exposed where the mm_cpumask semantics are meaningful for
   TLB coherency (David Hildenbrand)

Changes since v1 [2]:
 - Document new Cpus_active_mm and Cpus_active_mm_list entries in
   /proc/[pid]/status (Oleg Nesterov)

[1]: https://lore.kernel.org/lkml/20251226211407.2252573-1-atomlin@atomlin.com/ 
[2]: https://lore.kernel.org/lkml/20251217024603.1846651-1-atomlin@atomlin.com/

Aaron Tomlin (1):
  fs/proc: Expose mm_cpumask in /proc/[pid]/status

 Documentation/filesystems/proc.rst |  7 +++++++
 arch/x86/Kconfig                   |  1 +
 fs/proc/Kconfig                    | 14 ++++++++++++++
 fs/proc/array.c                    | 28 +++++++++++++++++++++++++++-
 4 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.51.0


