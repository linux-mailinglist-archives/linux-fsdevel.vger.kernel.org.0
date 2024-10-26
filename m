Return-Path: <linux-fsdevel+bounces-33010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BF9B15D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 09:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099691F226C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E8B1922FE;
	Sat, 26 Oct 2024 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F+FsVWKc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HOxA+Xhi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53218C35A;
	Sat, 26 Oct 2024 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729927536; cv=fail; b=nF95M4X8PHyPpofMMJtDrzxBOXj8yrqTWK5otgz53Xdig7PyLx1IaftkccPld/ls1D4L6WGfYmVh22fl1g/OYH87qAF4ohx1YY1L/sfJjXbsyMamW9jncy57r0+1ik5R5yF8aFKKzNrL2Q5BMyL+h8zdOR4uC6n6jd+fbRU8rZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729927536; c=relaxed/simple;
	bh=W00G6NaGkmND6VOsteotB7KIi62ExguUjnDIHGW/07k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gdxRpq+6nYA1FBLiazmbyv+gECQA6mLHVXZRRSZJnNOednDh2OAQpJa8bErgXtbIJn+dswcSFsiErm8H4awE2NXnkyWagza/UF25Z7f7HdzLyDsZ+4RrXzn9BpwWDS+yyUcfy7gdcLxABChqzuOfRuXh01gOtodZKfb98/Vpfm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F+FsVWKc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HOxA+Xhi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q6XQ60009017;
	Sat, 26 Oct 2024 07:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=+ODKNLRXknsw/fzU
	ciAWVQgmpJpqBdi0njl3AOqN6E4=; b=F+FsVWKcsjpH/ORFupEztD/aKnuOtACn
	BA1IieQcnJekOmJhTzOFm8RUV6lf7Nq+iT99CYymAS8TgIXjBNtokNVhD9en84+l
	DwFzsOV66ixBDx/W5PU5Tt+onFHodqDNHZ2TIKNs9LzQT021TEC74sQS0SQ03Pv5
	zzGnzkfgh+KyeSnx8lEYMDmXi9CQ9IMD0cFKKfLsbR+s20+t8hrI7b0bp1waK3RL
	aAXYmTddG4cS8DM5xlSUx0zwWX7c9b3vP30W1z+EGLCsAaZ9LOc12RHRNyO2eET1
	tSqBB/HLyfIcBiDZKPuCiSfH4BJu5x7tVgcj/rbyNIRH0zIWalcu7Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys043n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q3DiQN018938;
	Sat, 26 Oct 2024 07:25:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42gpvacv8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohKV4WQnVO/JkfIDK7fP2+jGRgMOEjdqWJkx+SqoFYCo7bI+jaTcv9ShMD4IVYBN6T6++cL687qFMpHWeEtw2uRnGNgzHAVxOksWIVb+WZpXV3kXudgV4lif+HqTAvNwVxr8+bTUA45FAbrfG4+aBFGU1Bk+FkXooAYieI9cltb6IwWxuwRdsfH6vKzwU/hSMgOOox743sZ7F2x6kOrqwtJJAtJDzrkVRbWh+ZmbkHovyqQY0AWgH7kr78ZP/+cc5ttLAgse1Hy20stt9J/H7FDr4VmTNR79qDCyvqqhM3DwD6TL6M+Ci7OLWcix/wuZmgAKlBEJYkO05o22Y/KZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ODKNLRXknsw/fzUciAWVQgmpJpqBdi0njl3AOqN6E4=;
 b=gYyFssjPfHmEi9mh9+Xl1dBne9J+fO84Frt4wo1xhYEZdpR1WzOkgTnOjoOByc//QGnK6GpkPrnSDZ34a6pZ6GFKxIagttvsaRGCn87OnLg3SxyoYvE7c46Js/SmA9npG9BONja6gSGA5dbgvMrzaSt11SiYfiI2EuMLFqla+7w7+PamO+TwWCaQbe21ia/LUXXqdc61Hx43iUnQh/ZBJZPkg12g2xNBWtfmpZo16f4kJAVOpJi3lCtpWNWUjdGY3WnMGSMi+L0VKSkQbNsDG6EZdGYhZIrGEWTqTJQPTsDreHbzoBg2EWJuA5SFeAHwg5kKOyhU15Oeq8paERbDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ODKNLRXknsw/fzUciAWVQgmpJpqBdi0njl3AOqN6E4=;
 b=HOxA+XhipZN4uOwe1E6Wipu8N3nb9Ydr0uJgTrQdlZa0ozxisESztjDqrF6T/RhnhpbsdYkqvjRPlR1Gh3P4kFW9+xFkv/vaFDH0oyU3mjZaKnlHExZIa7Gtn1NnB2GFAhzwcNc6aBSdsPOiPBSZcXc5qMRl1fyZ2FkBxETjD3A=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 07:25:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Sat, 26 Oct 2024
 07:25:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v6 0/5]  introduce PIDFD_SELF* sentinels
Date: Sat, 26 Oct 2024 08:24:56 +0100
Message-ID: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::31) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e7ab37-8770-4f7b-b4ad-08dcf58f5172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/1pzv0Od61fSVqrCixdnx1LWe/olKnEzgfBMq7ooiwTGsVUqoomgzVHTFn8?=
 =?us-ascii?Q?sI8PEWeDM8rRQSAJfNg33nTOWuJqC0Nbr0Yi27Qb7hKy9vfi114havMrIC7B?=
 =?us-ascii?Q?updEqBt/ZBYzJNNcewRDadsszNbN0VNKG2o4jHKO3wrlrMHQSiMxjKGp2Iv9?=
 =?us-ascii?Q?tvFVIWNl0P5JSZQ6s6iNkseJ50glT053mb8/wB+CJYTnBR7ngMS+275NqHdJ?=
 =?us-ascii?Q?MCUFeCaLIilr3Gi5zcc5fURUsKgt1ZfrRrKUuNYZBqoFMGwdx32zK92U0YiC?=
 =?us-ascii?Q?MJPa9r8ZrCadygau4E1IG2ohwusimKB89StzJn97RJAGMM095d+52bZfp6o6?=
 =?us-ascii?Q?C/VAo4rx0RWU86w6fC71xgb23fzpSmQgEv24HJnqwpISOymMsXa+F+6TIbnS?=
 =?us-ascii?Q?P8gZ7A32YnIJZVxgwXx58fZ8lDl/APSdazMTRAN9vTxnT1XA+aDIjU7E28ef?=
 =?us-ascii?Q?Kyq71KT2ZzWtplFpyOTmJM/e5svPO0gcslZ90jGCZViyV4zK+sK1Ds1hZ2e3?=
 =?us-ascii?Q?eK+iOcdP749zG4A7sthjVQhAWspjrFJ64Vf2GRiSS1san1GhrAEFn80fzgUv?=
 =?us-ascii?Q?2cL+NlUvmPE2AsWAFqJg7R2hYydGAgtN38A+KZRh38j3fgf6GlFb35dJrmYG?=
 =?us-ascii?Q?zlVmrPmwk7ZrZAnwsbBpaz9CQ1LFoBHYO4NRNBi4at9lQKZM2gBjcdXdGrqW?=
 =?us-ascii?Q?9IKiG5s9AuamyAfyS7c9mNAV7sRD6aLzhOchmUH5GiJPn7fO/burV6Sud4lI?=
 =?us-ascii?Q?bVkIBBKLwSQCT0MyVuv3SlJI6FXPAF/7MTGls2ROR6Wzz4sxKfRrfxChdOOA?=
 =?us-ascii?Q?9kSel+R9K2PSDgFbpURlrl4K1MWsOzFkJLZcy7RvbjpbJOAodEJVHOkjW02s?=
 =?us-ascii?Q?vPgUNz3b5dgSTYUAdNFmGTPTkK7IzCmVZW+L1r24YnxzEMh1TDKXWqzjldSd?=
 =?us-ascii?Q?obN92C6NCQ7bzCk+SeJyevfTFL5MOdtf4Gm2daxQQZ6zNrvJrT3FYgiBOrsZ?=
 =?us-ascii?Q?AjlzVxLAbMWWSyMRY++ZVU65ojNE1vTOgEb4shZ9NUHz8LbLWUWQ+1Yrohxn?=
 =?us-ascii?Q?viW9kRCieXzQYagg47CuPArJvjLskBn0iPJIQ1bszEdkxU0erCA+1fgQhr/E?=
 =?us-ascii?Q?A4f0KBfHXwgN1pkcI1Ea3IXXNVjftstxW3GtC/ZT1xODYiElQtRbH2WSlCaQ?=
 =?us-ascii?Q?6aa9zdPQaCz58kmmnhYaUiDDPVQK0afaDlFbV0Yq+WYaTqp96UrHOJhRuGD4?=
 =?us-ascii?Q?o/u6Z5T17x7mYRJjB1GcC+yeqr9btCipxCcgE+h9c6XE2OoetlieossS8shp?=
 =?us-ascii?Q?RHbZQCItexSvfJHmM0bCXgmv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WPfG5iyeQDr6HwIhD8Jzzt6AZ0et6B+X2phgQP8ZFekCUaTbpsXO7ZZSofI7?=
 =?us-ascii?Q?hVSRk7nMOA1yE5kTLKaioUNnxURhQFwq87/z1VsLY+yYvsLlgy58TYP/uQbp?=
 =?us-ascii?Q?xhK/cTEaDKeFyPXN+07QQqwg42Qkaf/yFTASus8Iow0HuOHJtIVCCSptacHK?=
 =?us-ascii?Q?c65Dv/cTBvC0qSbornJ4VsrQhW44tIapRsabHXXfdAyn7ZiyOWpZ4Zhzr9Cp?=
 =?us-ascii?Q?VFoegpbDcAB+62ntHuFhpbQHFP1qocgkuE8IgR2yeNUKJ2zLX3uLbMM761nH?=
 =?us-ascii?Q?JlRdwdZ7QNm6Ds1DuiUocHMqaPpUDi8UHTIg9I7GsDqzF9Xr+DeurD2Px6Mo?=
 =?us-ascii?Q?LBK6lsqoMriovCgrJKExPibvtds+gra4neVmJ7kQTm4OGBOdff0qbn3oCtkj?=
 =?us-ascii?Q?T/7usJdNwD4a7x8HIA+38PxLF+3unKdxI9YQNJQ6IXw7PztXUEoBeUDUZ1yq?=
 =?us-ascii?Q?IoYiRQ5m3A/RVbo2+8hl4hWYIGy3Ka+sgm45rkKbsNyLNWMwgMy6E6hIRQyz?=
 =?us-ascii?Q?wzx+k7XS95ujLiWiRQptMkqXw1HqtnRUfC6x8XzHZ34PfdqKt8PfkdsbNYJc?=
 =?us-ascii?Q?x7mr2S6pnQT/9vpMVzGUvebVAd6J6B8U0dAoafKxOY7CbVxSrKmP5g5b5P56?=
 =?us-ascii?Q?mdI83JLjX7NsZBe80g9raK/hlLk19K7hSyULeme1cPK1JSAahDKwap5lWFjc?=
 =?us-ascii?Q?qyIatIjPlDv6aSlCh6QiU0bWPXoZGnZOJqVrh7Q0H/SrujXGuNbr9R7qY3JY?=
 =?us-ascii?Q?IyyqiqkSpaoTFIA4qwjgMx/TgMZjN3DPC3Iaf0vWc64rkSo0yEwoN4BHaGWB?=
 =?us-ascii?Q?JXQWNqekQWm8/txmv1lMwHBcS/iMNJtJUeKlQ5qDdky6HgGL8y7pOvkC5pW2?=
 =?us-ascii?Q?ZaqKyjLJ6UdAJE7a5t+/w4kkQ12xhGpvUgNFHzLO/luFpBST9Mznn7S12asd?=
 =?us-ascii?Q?5Cz9x+oQ0T3R4ec5CrGybGbUIYum6MEQ+BL7pzEuKN7D1BijVJ/7uvBx1IxH?=
 =?us-ascii?Q?QkMl5+hh8yn+WLGI7VpvVKphJ86kXcAAKMqHuj0vYIZLwAwOyPQDNdKXOtA1?=
 =?us-ascii?Q?H6NoTCWVgha1tVtSWLfmIGRz47+GjJ8qVvz1x2UhIQa94cBEiUc4QAhPrCKg?=
 =?us-ascii?Q?j0wCuyQVf636A2v0HnC5FM6e/3KtCMlKOO+5Kt0HDcT64a70Fgh5wuc/P+R2?=
 =?us-ascii?Q?XcSB6oVMJc/6uzaQYQOaRAshm+BnXy2e7eoO0Y3IWf2x0IXM/BFzzbhA1U/S?=
 =?us-ascii?Q?FJIL4gAVGpd08iUcLhi1KvGglNIN48b2LntElaCtae13c8UkziiRYF0N8Xb9?=
 =?us-ascii?Q?eHlPb2mreYE4vQzCLvC0W/iIdoJsCs/uH6m66AsfbJ/NzjKB/GWEG+DpA3uv?=
 =?us-ascii?Q?IFzCCuMtko2gOmHI4pQZzMb060iEITSBU5ktwA/+yW7sbIo+TOzpEa/hJ17Q?=
 =?us-ascii?Q?2FYeGdkuIHSUGX1wfJgI3+noMsrD5y0uDZJDfc2WRv81Xn6iSK1RQc5Gfjg1?=
 =?us-ascii?Q?T94uIZ1QombZe3Fw6pn8EOpellS0zVB/Cs79oPuIVw7CkwgB4y5hmbzsHr2J?=
 =?us-ascii?Q?2Dw46SohjB0YI8SlondbjLU6W3YOzvbVbgzXXtTHAeUZH92fbLn7yyVvqe1O?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZzmRHzcJfTmA2Hc/b6ABjb/zrGz2QBnAjgt+qxgybLKmo/m7Gkk9Tin9igDrDNhu6Yw3oRsCvEAO1pS734Wuc/SMxY0HE8HfRMYmNf8iwlHHlElVHbaXp6gcwlBUSE27UYtxGXeoWecpIj9ujMe56lWEmO65/A/Yr80EAiEbk8SieyvX/NO/SYG2R+EwPvdD401SivjwFnchTm/5mANPayvpxenLPo/CzrXIXtgbnOXcc3WJMIrLnxQ2us+Z3CZPolPaknFALZMiAEJDquJ7n0a+GneBkGaf7MKB3Zy4N3HveKL4PpkVzQ34xL2xXi8IW9Wrxg7UbEaB5J21GusasbVY6NrAzL4QIzvkHk8XYLbjlYYC/Rb/SiXOj25YDx6O+a8mEVMIqDhOKKCfx2ojwWW0Z4sUKorVaRr/WqRQnwX+UGh2fPzJzal0y68d56s/p3VaUJWDjfXZ6sqcsfOkP3x0LhZedMmnFd2xcty2YJXVI/r9WE+yYnx5UbHSFLWykKF7UT5dcgC+4aEUFhY30gV28vrp9uBoHLo30XkYxk0E+trRI3oBBHribQFCkUuLtlw62RGskrvjERtAqpwoP6Zcichx+GCh+f5kiZcQk0Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e7ab37-8770-4f7b-b4ad-08dcf58f5172
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 07:25:07.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5iTyXXdfTg2l0yjE82V5C15hQIy2tBSOZX5p0PK5IoUc4ZjGo0LC5prvX49a2lCPbilJq9zbSAaySyoQd9UHwy2cjixpgxjV+M+4ETmpMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410260060
X-Proofpoint-ORIG-GUID: iSIvAlQlWHybOwrwFk7TUjZAeSXuMYWI
X-Proofpoint-GUID: iSIvAlQlWHybOwrwFk7TUjZAeSXuMYWI

If you wish to utilise a pidfd interface to refer to the current process or
thread it is rather cumbersome, requiring something like:

	int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);

	...

	close(pidfd);

Or the equivalent call opening /proc/self. It is more convenient to use a
sentinel value to indicate to an interface that accepts a pidfd that we
simply wish to refer to the current process thread.

This series introduces sentinels for this purposes which can be passed as
the pidfd in this instance rather than having to establish a dummy fd for
this purpose.

It is useful to refer to both the current thread from the userland's
perspective for which we use PIDFD_SELF, and the current process from the
userland's perspective, for which we use PIDFD_SELF_PROCESS.

There is unfortunately some confusion between the kernel and userland as to
what constitutes a process - a thread from the userland perspective is a
process in userland, and a userland process is a thread group (more
specifically the thread group leader from the kernel perspective). We
therefore alias things thusly:

* PIDFD_SELF_THREAD aliased by PIDFD_SELF - use PIDTYPE_PID.
* PIDFD_SELF_THREAD_GROUP alised by PIDFD_SELF_PROCESS - use PIDTYPE_TGID.

In all of the kernel code we refer to PIDFD_SELF_THREAD and
PIDFD_SELF_THREAD_GROUP. However we expect users to use PIDFD_SELF and
PIDFD_SELF_PROCESS.

This matters for cases where, for instance, a user unshare()'s FDs or does
thread-specific signal handling and where the user would be hugely confused
if the FDs referenced or signal processed referred to the thread group
leader rather than the individual thread.

We ensure that pidfd_send_signal() and pidfd_getfd() work correctly, and
assert as much in selftests. All other interfaces except setns() will work
implicitly with this new interface, however it doesn't make sense to test
waitid(P_PIDFD, ...) as waiting on ourselves is a blocking operation.

In the case of setns() we explicitly disallow use of PIDFD_SELF* as it
doesn't make sense to obtain the namespaces of our own process, and it
would require work to implement this functionality there that would be of
no use.

We also do not provide the ability to utilise PIDFD_SELF* in ordinary fd
operations such as open() or poll(), as this would require extensive work
and be of no real use.

v6:
* Avoid static inline in UAPI header as suggested by Pedro.
* Place PIDFD_SELF values out of range of errors and any other sentinel as
  suggested by Pedro.

v5:
* Fixup self test dependencies on pidfd/pidfd.h.
https://lore.kernel.org/linux-mm/cover.1729848252.git.lorenzo.stoakes@oracle.com/

v4:
* Avoid returning an fd in the __pidfd_get_pid() function as pointed out by
  Christian, instead simply always pin the pid and maintain fd scope in the
  helper alone.
* Add wrapper header file in tools/include/linux to allow for import of
  UAPI pidfd.h header without encountering the collision between system
  fcntl.h and linux/fcntl.h as discussed with Shuah and John.
* Fixup tests to import the UAPI pidfd.h header working around conflicts
  between system fcntl.h and linux/fcntl.h which the UAPI pidfd.h imports,
  as reported by Shuah.
* Use an int for pidfd_is_self_sentinel() to avoid any dependency on
  stdbool.h in userland.
https://lore.kernel.org/linux-mm/cover.1729198898.git.lorenzo.stoakes@oracle.com/

v3:
* Do not fput() an invalid fd as reported by kernel test bot.
* Fix unintended churn from moving variable declaration.
https://lore.kernel.org/linux-mm/cover.1729073310.git.lorenzo.stoakes@oracle.com/

v2:
* Fix tests as reported by Shuah.
* Correct RFC version lore link.
https://lore.kernel.org/linux-mm/cover.1728643714.git.lorenzo.stoakes@oracle.com/

Non-RFC v1:
* Removed RFC tag - there seems to be general consensus that this change is
  a good idea, but perhaps some debate to be had on implementation. It
  seems sensible then to move forward with the RFC flag removed.
* Introduced PIDFD_SELF_THREAD, PIDFD_SELF_THREAD_GROUP and their aliases
  PIDFD_SELF and PIDFD_SELF_PROCESS respectively.
* Updated testing accordingly.
https://lore.kernel.org/linux-mm/cover.1728578231.git.lorenzo.stoakes@oracle.com/

RFC version:
https://lore.kernel.org/linux-mm/cover.1727644404.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (5):
  pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
  pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
  tools: testing: separate out wait_for_pid() into helper header
  selftests: pidfd: add pidfd.h UAPI wrapper
  selftests: pidfd: add tests for PIDFD_SELF_*

 include/linux/pid.h                           |  34 ++++-
 include/uapi/linux/pidfd.h                    |  10 ++
 kernel/exit.c                                 |   4 +-
 kernel/nsproxy.c                              |   1 +
 kernel/pid.c                                  |  65 +++++---
 kernel/signal.c                               |  29 +---
 tools/include/linux/pidfd.h                   |  14 ++
 tools/testing/selftests/cgroup/test_kill.c    |   2 +-
 .../pid_namespace/regression_enomem.c         |   2 +-
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 tools/testing/selftests/pidfd/pidfd.h         |  28 +---
 .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_helpers.h |  39 +++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
 15 files changed, 371 insertions(+), 88 deletions(-)
 create mode 100644 tools/include/linux/pidfd.h
 create mode 100644 tools/testing/selftests/pidfd/pidfd_helpers.h

--
2.47.0

