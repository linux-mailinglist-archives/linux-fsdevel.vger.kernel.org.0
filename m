Return-Path: <linux-fsdevel+bounces-43656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AA8A5A32F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E73A9FF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD42356D4;
	Mon, 10 Mar 2025 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="izdGo5ej";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NZoxmZAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6517A2E8;
	Mon, 10 Mar 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632010; cv=fail; b=RZAnS6h02eS119jbTZe/8s6x+EaYoC2eFStEU08lfd51gXW22g+RMuQveO/ciS4ODzbRAbOVh1FYkmQGdq2gTFR9ttxKwH/Ro0poGlriERIk6yT1RaGqg1ycP/MfvdX/lGoGw0blFhnj7bAo3PwXm+VAlVlMMpzqB6mKoSQA+Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632010; c=relaxed/simple;
	bh=Gho0xa5rjgncTiWMcXaYgrWAm7m+kBOUZSgdLNvpGfE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=G7rcx+Ov3IltBRzDqXUESbwrdA6hPvwvDns6hSOBINhAJI+TXh+FHqIus3zRd2eTtSANtbUtrmr9GneVaMPDwXsVD7EvXa1hT6EA9JoNaCkP8ZOCsQVOKc4LU0Oe87DjDYG9lGHb7agd3SaqMZ1VlvJa49OONv9OZkV4JB19/7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=izdGo5ej; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NZoxmZAe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfrm8004211;
	Mon, 10 Mar 2025 18:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=Mr0VEdcGpUmeDO6n
	RtPqQZOKTWfVoSAErJbQ9nkP320=; b=izdGo5ejP/OhhH9vFGJEkrFA2KODxt5c
	Zwby1GqlZqxrVBseKS0EkgWxmJ2bnXpWUhq289AobqIAW6AZpNsm3rj0aBDh2NDU
	Z5wzcI5G/4kSNcoz2ZSzhWVoug48Cvp6qYGJzGLw4qYc3SGgRO+y9G9BuCeck56U
	dacXDB7Qw83LmILdxuLWg/0bE6TrS5ev2W4+Zvqmy8K7AB8GnV1Su1W1KLA44Lqc
	YKUP4Sb74Ojs7iOPrVJILqo71ELErvNqH21zjLz55Gi+LfR1ikrGF4hnl5/femIO
	F7Yjs+huepGTkWkspWMqzQDHu7LN2Y2GFnoHVZIdGqgnuQ/DFYR4BA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ctb3c61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AH9u74030661;
	Mon, 10 Mar 2025 18:40:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcmc12t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPtsIc4GBNtemgo2wBzO12uP3P5oMvLvlurVwmg5yh2swRjcUt8ihD1hrtj954Mp6bexX74Ddc5YeiQvz9K8fn/3ZsWuV20ElsItEjh7cqr8qFrq/zI9Mulh6kj50HB7V6IPdHwMkSWyNZNx/zGVHLbWszaUQ048SHKtxHXJLgfvLvqrPiE6js9IHrJW42opC5fIHbHORk2dSVhM0dJib0Bci6KpRjTqAS9ZZFimmJ+Zg67+Q1Q98TxhqzYOIe/yAroVmnLNbf2/OrkPT7gex0ZSjHOchp3ziw2JAOrT7ronwMvswnqsoRefj8l3z7Fe0hRBg1tM8B351/eIY+jQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr0VEdcGpUmeDO6nRtPqQZOKTWfVoSAErJbQ9nkP320=;
 b=BxiMYjmoTWNEKCe3wklf8/I/m7uL+WOVA43sE4WkyHJPJ9KeFOtqEPE3VgNwNYX973Bhcu1yfTpxYEWsAbxayoGGkYJBO6IXloQ3qD0WKkTtbWOWCcjC0jFsSNeDhCl31tBZPxJy3MRNvg/WPmY85ELG4HkihcK2uPLD7Tnupi6UNLqjxzLIOlmduermwi1W1E/f4UUSYXCv/hTuD6ZGlEcBhtwBjy2+xsV4QF86A7xW+DZ23uc+YfRDXNuJUgZoiNJhwIaupVfTzI9MQdZ7P9V1QJM1TKOQiTL5olBMU0kdVlh7yAhN5xrunDwT6eD2u+GSEjLU70xXbZUl3kIO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr0VEdcGpUmeDO6nRtPqQZOKTWfVoSAErJbQ9nkP320=;
 b=NZoxmZAeF9nVYsbaXhBY0q+lsZ9NpQlpDXA64L9bve2LNUZmbvnqgwKJu1bCpFUqokcvqZQEDnb+fB+i4HEDO7MNHv8AStbNE6RngIOn5h3z1vAR3z+zD6bfq7trL8xNGCj+E4tHsc00HkWSFOqDXbe6jjhHxnESuNSOZDc6mJ8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7953.namprd10.prod.outlook.com (2603:10b6:8:1a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:39:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:39:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 00/10] large atomic writes for xfs with CoW
Date: Mon, 10 Mar 2025 18:39:36 +0000
Message-Id: <20250310183946.932054-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7dafd3-d5c3-44ea-d0cf-08dd6002f5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UrQkGJJCYfSSS1DsOxiMBH+LRM0Vr9cdkVcdjv8TSNtkoeQvnOnrltw5KtEZ?=
 =?us-ascii?Q?rmH32lZvLUqDAYT6ae+SCacrkLZId9vSFr7/rn/ugTcdVtzfDrbNXY7EVEt7?=
 =?us-ascii?Q?s8x5XJ2A04XWcpihUNA37khn5/4Q0ejgeoYoMutfzmoylPH5ULjyxKYuAPqf?=
 =?us-ascii?Q?dgs9skLoAQFMfshzAk4MGtEEoHRoxaoeq2Rtiv8gPW6ImAH0QT4YLU7id1tA?=
 =?us-ascii?Q?c58Aqta2W51KSU5n88N7ACrw0x/nErIfQhmnjobur68oie3BamO1hu22czA9?=
 =?us-ascii?Q?cdnRJIlydMj7MCm228xb4mKofTkiPFLZd9Cjm6nia+dSUeyUCVsQEDSGw/fU?=
 =?us-ascii?Q?+BcrSIhAMTgb6cubV2e/6Ht32zB4HXDW/VfT6JOOyjcNyT+wxnJxXFSM+ojI?=
 =?us-ascii?Q?Sh5WQcbTIRZmYIstPfMGCe/hWKhDtSyFKgTUpcKMzejHvWevfpRMcQguLhsW?=
 =?us-ascii?Q?yYtmVSdKQYmq3i3l6AM8hngZhGwZyfBa4mE3YfNUFvsyLxdB0DdV34FHHiOw?=
 =?us-ascii?Q?85mTe62GyFBcPGUZ3mvnC9ISVxxW1F3VsrEhhpPG3zIVRLHPvrVbgN5IemSU?=
 =?us-ascii?Q?MHlWmGe8idoYYzGGCIL0xg6BGmlMVIVJ4z2wOddHhqu+73N+zmLSLjEy75nO?=
 =?us-ascii?Q?QFoDAglKXZTs/bzuQgj+3fGzXFwafx5+IdZBbVlIzjdVylTNLu+4iSymipET?=
 =?us-ascii?Q?X5nKsCf0lWUYh0FHuAyD5r/R7hVQhaFUwmj8XF8L5fjZSXlirLG4oM+PedRY?=
 =?us-ascii?Q?7CYPF0APU0R9EN0BPGDTNQhlqybx/6QoudU4MLQ+7Np82rAm967r0VGyiglE?=
 =?us-ascii?Q?vjvwgB+rDsn8clKVkz7fCHxV9I5qpFfM/gSfCcHhaCHOTOBZXL1MgImia1Z8?=
 =?us-ascii?Q?8hZPuxWWlOg8T48hPiVJypcO7jL84jgGXdWqeHVVZeOD9gy2zs/cSR8i5ll7?=
 =?us-ascii?Q?P2zhqNid3IPibEibGdTeiQznjvwIqcCMKEH8kF0ktOa3NnWEP+owyduC0cQI?=
 =?us-ascii?Q?5KHtLUiW6ef3yYjKo3h9vxkP2aUB3Hes4K6xufoLGhwQ9h3F3w8CpzqyhZB2?=
 =?us-ascii?Q?WxWAZRKYUe158GY2vOl7dRppFKePeiFdhkrASNyO15mFlpTqwOhOiBWAeFel?=
 =?us-ascii?Q?vSBIYst8JSCwX6pgBw19QSvzTxn29vvLl8+HSs7FgvKYvRgjMFyPZQxX7x5G?=
 =?us-ascii?Q?soh78O8NtAaKCv+ZsHFpSesfMffC/r+J1sV86mIMJIpG8up4ZxmdiwJlM4ne?=
 =?us-ascii?Q?F2V5VM+s+Hgtjxr7DP2C/NNMAycVX8prwZisKlEw3gAkkpQTz8lFLG9WDAfs?=
 =?us-ascii?Q?expq3PeJC6OLjjWTne+b0l+QHbAbTwQhRgO+2+s2qGzuW0/Nxf/EPvs5czV9?=
 =?us-ascii?Q?QflIAeiNwSkNg591hEIjgXP2ZaUD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kc5kJlnx9ytJUlgWQ8d5PNGqqxbiiMpDK82NMWrLZgTj2udUrkWpS8JtrpwK?=
 =?us-ascii?Q?JzK7wFiIvsIYy/ewcxDEc9zCEx1aijFx1zWkm9VnuunfAlzNODClrJ52xMsh?=
 =?us-ascii?Q?gKHffaJzHzQrIATE7fM2vxt4gecp2X6VWHs0BuIW9QT1sOCNL2KUlXFztYk5?=
 =?us-ascii?Q?9QosLQicKnceK3G6pLG5Axi+o+G6Kj0NMCJxsj3sxAcQXk+E1E+kJUTi8NOU?=
 =?us-ascii?Q?8fkvyNFeNemJ1vzQMXMgNrg4OBAWwG0yFAty/Z5tVBh1BzF9uGbYV9Em5HMu?=
 =?us-ascii?Q?+3VwVTa8vzvl2So8OxS1qfrr+jJQxoUs2UjWBD+2wDWN1+oC5Ev5S+YpOCVH?=
 =?us-ascii?Q?7dPF2igeuyvKRlk+BBRrrDtXdlkWBs/h2K4gHACsqvyfvrTpLY1vAUajl6ll?=
 =?us-ascii?Q?Ki4z3sF2psIT4obMmTpM/QWb6KuvDYppd3XdkgMYJzUMbwWXrxiQK/iXcXTa?=
 =?us-ascii?Q?bDpbdeDDnuq5217v+vjKDwNSA5zbBEmZDU/cnDdp0lmultec7yQZXLzmhMZ2?=
 =?us-ascii?Q?PCavG1YZyqad0gfA8DwNERvNt38Ji/ZYqHnKx8MvRKBc95RZthiraF6fmcTa?=
 =?us-ascii?Q?xUpeDSXdKceBIS33+vZqvpk7OWP5/feJxIHHPvI7cvdC1DpJCb5LoKXtnjj3?=
 =?us-ascii?Q?+fNeR/1lFDWHKb8OOVa0b4N27zSzNFn7M+znzDkHIIqNlhXtIrfwN0DP5Em5?=
 =?us-ascii?Q?cV+nLuUXquy1BQOlQBzj/ShVW7hNxsOJnDB4fURj2G5HucA0jMagzmMX6QNo?=
 =?us-ascii?Q?nfO6v7PA5qKrsonn11gIsy/lP9RDlEbbfy5AEQtECwl1Dd2+zDqioMijpTvk?=
 =?us-ascii?Q?Kiq+2IrGol7XGoGi8SRXYeD2W8SvPqVmWMuXLTTZGY5kjZIyRaG15Irxnbv3?=
 =?us-ascii?Q?PBRfS3C7lzizkVCH+RaX95Cgzv7o1WYy+Z9dTSGVf0hFLtYFcZ73N1aBcAzd?=
 =?us-ascii?Q?+dk+x8Fo4hR9YV/iAXpJYco9DAqjyUgEHGXsym2YfLgUGVsTeQUc0VHjI8+y?=
 =?us-ascii?Q?1c3M/uNamB14kSwIdCWcwCeA+BqZvu8rcsXV+0Ydlh9BHW5Pq6sIDo0CGRzc?=
 =?us-ascii?Q?pez/ZrVll/yus28cbMXatNTStN7kLUFoTYGnjkAO3+qMGFLPRuw5sHonv0rj?=
 =?us-ascii?Q?ROZ/13zyXT1FMsHECD3i5uiPGB7k4eNj1cWrqmyAKPyw7B3HQn1fvSeBJneq?=
 =?us-ascii?Q?NlUk/hrzr0xNHi4Ph6+1yon9mVSnr5Nt95+qi5cGMTobz10+ysBJzynYVSv0?=
 =?us-ascii?Q?85YEXblYEI6JhlxqanB4zJMs2bI8gWE/CxPQhu79Gu89gkPFpS0r49Jo+2RI?=
 =?us-ascii?Q?ric5U6omvQCO+8VHk1/0bxBuPaWuLf5s3Wa33e2j91qsQQDIeD5V6uYw0ZGx?=
 =?us-ascii?Q?A365HFqdH9TM5q1rEy2FGrSqXHaH9nw4IpiW73qEj4KUXXes+akDEWeh10BG?=
 =?us-ascii?Q?sVLH2vFaxN9o80612aCXhoz5qlBfam+I/QBNf4B2Sn5EZdTXE+LjMmyRDE0L?=
 =?us-ascii?Q?4qTSkwGTkQglLkNKK8QBEWltAEka5BxRbE76g7H2sDaYOHIV4IDXlf2nlNFi?=
 =?us-ascii?Q?fcd383WpUNkXqpyd2GGVEavXuJ6RmVkO/GUNQquMGio+GGADxOSopZHWQSHe?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KEqQjqWTCkHR0B9WF4P2BKnyzAs7ELFZq+qblLlZJ4uK3+1amYq0+QyP9lg2NOxgfyoxUDlk8Fqpj4ZZE+s0KM3E+Y8FOXW9wuP+tr5zQEmM5P1U8sv+Awo+Qi3pL5A21lgajYRWRYdqPH3i4Wnw/wphldJIqzXnpVky2huRO4idLkW25CXao1VVZ7sHWnohNWhArU2sW5YW3EoMUbJ17tomuVujCv6IEZ+BogYH+nLcjGopUbt998KaccQJgvyhiu5kjtu/9r8+xqx+pVAXZJIs/wRjtRz7OWBvr/IJHsLcdGGMpiTwiPjaiz1pLR5ZFd3LCCEePhaTmFHlEwFcwMqmwJ96d/GB+CV3USwRaIvogyMYeY2ydxjXQ7jgoU2f9UuYsi3g4NuL5qDyd4Vy8K6FmYjvNX62TPmDVklf9zXgyrDHlvsoKoTgzhtH7tA1tYjOOjjKaLC+6sCtgy+nQgyrAK8QF1jaFIXbZCATEtfwHmvUJw5ybRxqcIYLk+Dv+jQNCW/eqbtTOqQR0PUnv+ymanFwD4Uwer50VXYqehh2qUrVPLj8279j7W4e3vlC9pg04HswwGcyYFNgWER5Q/gUzGLaFyowUO6unZd5sh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7dafd3-d5c3-44ea-d0cf-08dd6002f5cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:39:58.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fmrZwM62xv5sti4hAFyN234awAc4v1WurvT/lSJf267COA9dfzuEcnu2OYi6LIhJq+gQVDHhfzk4Xy3ZUFr9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100145
X-Proofpoint-GUID: 0VmKA1NWWNyyWtqiWFW_q_Ub5E1UmBkM
X-Proofpoint-ORIG-GUID: 0VmKA1NWWNyyWtqiWFW_q_Ub5E1UmBkM

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a software
emulated method.

The software emulated method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

For XFS, this support is based on CoW.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Based on 32f6987f9384 (xfs/for-next) Merge branch 'xfs-6.15-merge' into for-next

[0] https://lore.kernel.org/linux-xfs/20250102140411.14617-1-john.g.garry@oracle.com/

Differences to v4:
- Omit iomap patches which have already been queued
- Add () in xfs_bmap_compute_alignments() (Dave)
- Rename awu_max -> m_awu_max (Carlos)
- Add RFC to change IOMAP flag names
- Rebase

Differences to v3:
- Error !reflink in xfs_atomic_write_sw_iomap_begin() (Darrick)
- Fix unused variable (kbuild bot)
- Add RB tags from Darrick (Thanks!)

Differences to v2:
(all from Darrick)
- Add dedicated function for xfs iomap sw-based atomic write
- Don't ignore xfs_reflink_end_atomic_cow() -> xfs_trans_commit() return
  value
- Pass flags for reflink alloc functions
- Rename IOMAP_ATOMIC_COW -> IOMAP_ATOMIC_SW
- Coding style corrections and comment improvements
- Add RB tags (thanks!)

John Garry (10):
  xfs: Pass flags to xfs_reflink_allocate_cow()
  xfs: Switch atomic write size check in xfs_file_write_iter()
  xfs: Refactor xfs_reflink_end_cow_extent()
  xfs: Reflink CoW-based atomic write support
  xfs: Iomap SW-based atomic write support
  xfs: Add xfs_file_dio_write_atomic()
  xfs: Commit CoW-based atomic writes atomically
  xfs: Update atomic write max size
  xfs: Allow block allocator to take an alignment hint
  iomap: Rename ATOMIC flags again

 .../filesystems/iomap/operations.rst          |   6 +-
 fs/ext4/inode.c                               |   2 +-
 fs/iomap/direct-io.c                          |  18 +--
 fs/iomap/trace.h                              |   3 +-
 fs/xfs/libxfs/xfs_bmap.c                      |   4 +
 fs/xfs/libxfs/xfs_bmap.h                      |   6 +-
 fs/xfs/xfs_file.c                             |  61 +++++++-
 fs/xfs/xfs_iomap.c                            | 144 ++++++++++++++++-
 fs/xfs/xfs_iomap.h                            |   1 +
 fs/xfs/xfs_iops.c                             |  32 +++-
 fs/xfs/xfs_iops.h                             |   2 +
 fs/xfs/xfs_mount.c                            |  28 ++++
 fs/xfs/xfs_mount.h                            |   1 +
 fs/xfs/xfs_reflink.c                          | 145 +++++++++++++-----
 fs/xfs/xfs_reflink.h                          |  11 +-
 include/linux/iomap.h                         |  10 +-
 16 files changed, 400 insertions(+), 74 deletions(-)

-- 
2.31.1


