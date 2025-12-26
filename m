Return-Path: <linux-fsdevel+bounces-72121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9ACCDF040
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 22:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 511873003BDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9D30EF9A;
	Fri, 26 Dec 2025 21:14:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020116.outbound.protection.outlook.com [52.101.195.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533C74BE1;
	Fri, 26 Dec 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766783658; cv=fail; b=sb2k8afWDhSvhM0sCNLLUvHCQUWSM+0sh4m9yDpyHRphcp2OVj+adzFgXGjxJJwOZ98aWEub3yi/BnokJqzevcQhRrJYZv5xqEJ+1FSEBjN4EmwTBwEk1JAVGz7NOmBQZteF4c5DzeIHjCwMzTBd8DW1OFCB/ojdoqP/ubFihsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766783658; c=relaxed/simple;
	bh=DVjoDEW6StF5HSMuRFRcQVbekKO7fNyMm/41LoEzxzE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AEGgNxkyAejSAHh+amoY/KW4dMzfHAOBOH/qv/zVaaIeKEqAZSFl0b8SvPxEuFw7N5TmIkRP/r37hIXaYsAnt7iJjlkBrx/g+TiTXuQ6Q/0cEyRH+LKpulLgf1j0G2BP22EfmZggfmh6+gKOSRS9C1pWYZM2NAWil9oHAPI5KsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO47RtI2fxfV2UCNH0i7dX2q6s5G+QmqjxD7hQLfbdfVSQ6se1EprCsbh70irnf3QCUw4KYIFIPJDNI3QTbs50Nj5HyLFXKR8FoAaNid6+Pb63llSCJgSr0vQsq4HIPZPuLKqx0n2ysB9omwhPr2Wr1ZK3dEBwQoaNoxdg06XgSHDWRF9tzDcVzrXVUe2Sv5b+7oHcT0s/kAlQ3AEoA0fb9jCA2BURAsvy1KFqaeyiKz7UEZ8uOpw9/8XSfKR6HrFQVEqLDLPsB2dn35gX6AmaYE/6To0y5CLB+bE+0Q2ZySfHkj212lbxi0fDt+U2/YprWl8Og2+NrzhHJ8Bk/HGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwLURjPT+/uynz8Q4f8SFa9KxXMGnD0H1liLjEUAYgs=;
 b=UhCSOb+Xkp7hv0M/EcHzWvrZaZMYtDrRPPu1orY+B2gp8gNTS3tEZq5PkCRLWQOyPdFRVbNtvE0m1rm1eNM+kg+Rwr0QFZlISSC62WJedK4N91yR5iwAgn32flEr32SDIrRe+8SxD6MlJCkU0xZ+evu5CPC94cvEf0PJ2FpyzBhei4mCwFQl+GicOdBVdL4Tb1FYg2RYTSPb0B5D5duPLs2keELPMKCqQ1R7VbGvqKR/dQ2+8o5R0E6enSIGdIIJXej1aiRJy8a1sZkPSCKstWOcQ/CR7Z+oKJatrR6edFr6vPrhuWcnBGkXXhGD0Kt7XLyptZTuM2kHGuiEmU7+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB4236.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Fri, 26 Dec
 2025 21:14:12 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 21:14:12 +0000
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
Subject: [v2 PATCH 0/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Date: Fri, 26 Dec 2025 16:14:06 -0500
Message-ID: <20251226211407.2252573-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:408:fc::23) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab75c30-810f-4e5e-4728-08de44c3b7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KkENt914bbU9McdnnCM1cUfWEoJGYqa56FamoCnEGH2sAwDxAZTXEPVvTl2z?=
 =?us-ascii?Q?uB7cmT/N3e1DBEwHUkN+sNSOTpCtMdUZaFrb4ex+FBEVAdxQtU+2jl7ra0HH?=
 =?us-ascii?Q?eLyzt8Mg470th9B18XqNlX1tbcNU7Ci4eVBw3LXSCXc+72Ue3keaERZm9Rhw?=
 =?us-ascii?Q?FhoFOoIAsy04kN8PRKnWxWBSeN3tBEwdPQae284kHCcJdzEDQ7dBikBz3T2u?=
 =?us-ascii?Q?fRcqM0nSfVsenXYZbCSZ2yu+994CGuMi9qHQOKixJ9AkbZByuzrBPBpmybsz?=
 =?us-ascii?Q?fIxwhMFc3HEG8g3lGESgRhaILyuSYSTEDQDeJghwu+GifkSxOXxOLPsqBj51?=
 =?us-ascii?Q?S/PI32nAdjG6uK9sQDaEHSCOVZcpKFERq+Zv82RrYSdprBfPnmTXXxkxGCG1?=
 =?us-ascii?Q?sVe0N63k1HewGKZdukMl7fSNpZ9wfiyD57vPRHagz+G+5DIpA+UwoyNIovL8?=
 =?us-ascii?Q?wSZvMmQtjaUx3Vy+aWfFmkWFcAFomoJEKeNjE94KFzdBWWuqA9hHBmZ0K/N7?=
 =?us-ascii?Q?fNpNSQKeu3/lp41iGLMxgHdzGpvci8TNgX984MfDGcLvPGRPB5QINS3BdSVp?=
 =?us-ascii?Q?dALRdFXkOJf8y8ZOCrm+LbWKRD9F3qwbYXNm76yARjKqH2QTHzvqtQs8JJv/?=
 =?us-ascii?Q?6udwleBCw25xyATzXjc5IrPNlFYtI3X+9eaV22LlluD99NGvTSsF01DByBU0?=
 =?us-ascii?Q?VzWSqNBBUNAaUYJNi0pfEJiswdC85tVeLN9+kZf5M+hVAGiaTO/MlbRFGkK8?=
 =?us-ascii?Q?FYB2jzcZACXDOwn/EoN8YBdEE4XuGxPsQfFB7SVKu1w9DnO1ZVyiWbTH39cf?=
 =?us-ascii?Q?PFhlSgGo8teZnGfH7CzVk550S06wjS0VOJSAKxaIPbSbIY2twKJ5La3HkanJ?=
 =?us-ascii?Q?01Un3tytRoXPxmOo8nlrHYLK4XqVE6NUuNSHxGFYNOMMThN9v5AbLeV2WDmN?=
 =?us-ascii?Q?o0SllMoF4EBqNjnLzvra3wcR6vNsUZT/BrFubaRR4ZIcUodehqPkqbAlo9Gf?=
 =?us-ascii?Q?0v/Mtl4CAFzHHOg0BlFZpczXJAufAFR/ZnIF/Q6j/ePEeOXWaVxP1JQYxjjs?=
 =?us-ascii?Q?IL/1czlMUlXOWnHk90nzLcU9al4CqY7URMd4K7llrwZ0wWryBk+5OxZqGfsR?=
 =?us-ascii?Q?lYqPelm9JCJ8Kc5TlcXgLm+xO6JR+HZbrirXipEiYOZaQO0Beo0hW+YvuKYd?=
 =?us-ascii?Q?J01q3zjBIisFS5QcKpoxDK4MlOzvv6wYeNqSH9WyfijB8qwGVZdjMcfWzXgQ?=
 =?us-ascii?Q?VXHYn/8lqB2lRDxE5icF0Mxzzt4qGYR+SEbenMKvDBjWiFjbmgyPFvNSuZaM?=
 =?us-ascii?Q?Qb6NIwqEveQYyaoQPOfzmRVs8UFGHty1q9OZAtxzL6KzYhO0Jj9bjBZnmS9U?=
 =?us-ascii?Q?/O4TcnACSGo83ffD0khu/EXuxw6VmRGn4BEdL+FixzmQGOi4V8Aqw46xEp7v?=
 =?us-ascii?Q?cJWGZjIfCY8RFDWfJjDoJiAHAG4VsHRSMKYzC2BOxiIFvAjFyw2THg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wwFAE6UIA8gFGiBP/bqJcGWuTBr7nWxk0cH5ki/Omfn0rMhWC4+PMrxqqXvb?=
 =?us-ascii?Q?SBIO6+AV+iNbh7qv9YcvKD3bDNmA8pFRStjb2WOpiJ53UTu4Dn3/Q9UH3LS0?=
 =?us-ascii?Q?eoTphgsJY7+vN7ABRpIcsoIpHc4EOTUWANYIvqs/UXHniOIGyuA+pPolQgzr?=
 =?us-ascii?Q?gtQH9YCLxWVAKfI/dSNoixzqefPollWlIMbWeehqkm70pYz0UQvuAPRd6UFU?=
 =?us-ascii?Q?eA/XID9YRIW/wPMkpTPymik6rvmvmKF8ThqoKHwMrV/wLW+Qre0d600BzEIa?=
 =?us-ascii?Q?uvfhwBE0Cgh+xxOgegylEEHSNuYG+LM4OUUSOBv1LKhgcoQ1HcHQiTS1uY3j?=
 =?us-ascii?Q?KChXU744w/zcsJmIVucruwlkDHBhucip8EGF5u9gpM5wVVPg+TSWQJRTqg5p?=
 =?us-ascii?Q?d0H4HJ7Xf/ayM2LaY0lvI4aPTCUl7Xn4zkk9wpK+lTFetRb0G3XpDhlZV7q6?=
 =?us-ascii?Q?LDEF+BFA0JPvPi0efeSZE63yPvT5RxkmkDNrStr7HYUX0dvWuKFDeHTZtZdK?=
 =?us-ascii?Q?OxgrrlnQ7Q+zv0v90BlsTbBqV8adsISo6D75osMWWPYo/THpuqLX5xwGMkWY?=
 =?us-ascii?Q?XpqOON6geXzSuOwlj3n+Iv54sriAMntPRIT6a8qY5TQArh2BkV/QLGGZ0wY3?=
 =?us-ascii?Q?35JeF9FxY/ga3PE35inVFBNjVTRqvt/dyaRRF3iM+zNXdrMehCM1XLeOx9LG?=
 =?us-ascii?Q?whgkTOwVJ/lJ/FEAJ4SqLz/KyqpSrOQTCYhqToLAiD1m5agxTiIfndNT8XAn?=
 =?us-ascii?Q?lSkCUM7+7RxA85YF2tN00vrw+WGhrG2iyAH4HOVJ+HN5MO33vQC6qxRbfqoL?=
 =?us-ascii?Q?ugoQlcB/YCrIAZWG6/Him4ZUV4XFj+HpN+0/QitVgB66V9ZiZdVS03kwCnhh?=
 =?us-ascii?Q?Pu3hFlZY1myNVO9NPI0GREU6JuVqHalgulqUSohq7DiUTte44H2PzoK2lPMK?=
 =?us-ascii?Q?lrGU0buvCvxn01mXYLXBch0v+Psev9rbvJTHTynBkAmCqZTbxJTh1a9I6qjy?=
 =?us-ascii?Q?uHlrTzV71rXJ/GRev/X/ahPxpzcLuMJqGoZsyE1qGiKqb+1ySz2sDtj3cWNa?=
 =?us-ascii?Q?mGBIxbJdpQgNr12H1vbK0mOAZD4uQm0VaAX0prGLuU4HDrXvbglKhq7WQZ79?=
 =?us-ascii?Q?L06Vh8TgOWQbsst055cs56xl/TnKPJoDSNkjSlQD5YFmlUjIYa3mjQTLbpU3?=
 =?us-ascii?Q?6MZGlITFvc+wWlioHvlPNC4vGIZ2rhPJdlSc+CM75CEVL5WY9HjzKSvQ21nK?=
 =?us-ascii?Q?UbhSd5PhGV4aF37Wb7o3KOM6y1wYxpjrCs6J9BDcdinFjRmEblrQSf/CJejS?=
 =?us-ascii?Q?4RaU78Vqf61q84LEkjCfopRBLli7aUk5YvMhJw4paIV2AksTrdEsSJcutCmZ?=
 =?us-ascii?Q?G5ME65WNCvfrPVZnRfi/OTgD5oAtqf6ktUuhMPsFG29Tg2QdBbTrb57LFz9D?=
 =?us-ascii?Q?n5ADXrazbn3obvWJUXz1b82P3yrWQBdh7zmYdsFVgIkUKmQGLPL3q7hg45zv?=
 =?us-ascii?Q?6E2zitwxxwuhGvdPYYc9pLgDc1/z6+ifr6xsYELzSdK14bmfQ2KHRYMnMDvh?=
 =?us-ascii?Q?3qd7WtS5jeDcCSLn4LFhvYw8KwE9tKpRxm7BwEdPx84GiNQLHTJS/bYZN879?=
 =?us-ascii?Q?GCFU3tBUXQpQ4N46zBJJMiHWhcSHWZTZo44aBTNgomJuUd4sxN1SiMn0jpPL?=
 =?us-ascii?Q?eLGCtt9lbHipexJx8YDJd9fvWj0GtJNiQ0UiV+Xvl+BHch9BF8ofc0XmH9Cv?=
 =?us-ascii?Q?FglknU8Oog=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab75c30-810f-4e5e-4728-08de44c3b7a5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 21:14:12.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wENp/7CWGDy42TiBJ+iJYNmkAYh+kHPPAe019Ej8TIrvL+WEY2TSmjD73FPJplWVuNhbsubuUx9cGugDWPutbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4236

Hi Oleg, David, Greg, Andrew,

This patch introduces two new fields to /proc/[pid]/status to display the
set of CPUs, representing the CPU affinity of the process's active memory
context, in both mask and list format: "Cpus_active_mm" and
"Cpus_active_mm_list". The mm_cpumask is primarily used for TLB and cache
synchronisation.
    
Exposing this information allows userspace to easily describe the
relationship between CPUs where a memory descriptor is "active" and the
CPUs where the thread is allowed to execute. The primary intent is to
provide visibility into the "memory footprint" across CPUs, which is
invaluable for debugging performance issues related to IPI storms and TLB
shootdowns in large-scale NUMA systems. The CPU-affinity sets the boundary;
the mm_cpumask records the arrival; they complement each other.
    
Frequent mm_cpumask changes may indicate instability in placement policies
or excessive task migration overhead.


Changes since v1:
 - Document new Cpus_active_mm and Cpus_active_mm_list entries in
   /proc/[pid]/status (Oleg Nesterov)

[1]: https://lore.kernel.org/lkml/20251217024603.1846651-1-atomlin@atomlin.com/

Aaron Tomlin (1):
  fs/proc: Expose mm_cpumask in /proc/[pid]/status

 Documentation/filesystems/proc.rst |  3 +++
 fs/proc/array.c                    | 22 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.51.0


