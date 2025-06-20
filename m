Return-Path: <linux-fsdevel+bounces-52316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A91AE1B30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 14:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8846A18852C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 12:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4304B28C2B4;
	Fri, 20 Jun 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KIuOYUE0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gaGp9Oxp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5E28B408;
	Fri, 20 Jun 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423729; cv=fail; b=YQGI1i0ySnt4FRqiKUAbCQSiAwS6lr74aAL89UOkd51L/isIdl17BN7KIGUQ/ZnlSTYVDAI4OSmv45Pe8d3nmenDXnYSfew9JPOEafo8RyXPsppQ2RlbSv+K+3YlBGBGtk3ebGugdT8hnK5cUChxnay9MpbAS94FyusUKeKMrj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423729; c=relaxed/simple;
	bh=yC+Q0sxdpo5OceNNGWjIl6Wt2CRfHnofKiql4/lQA/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSxC+lycC7gsnMzVg8YtGg68mVrO6x7wGoPKqV1bxzrjWMl/dGUScti3staTx2dQ4sWOf0ri7jIjAT0e8rbu7wrih2btj65Ad1k/6aIJfqdlY62vFF9yIqU31y/Jiw2EfRHDmrFZBW0xdToHNMEWa/EJq4pYEGAk1wHTmNFmsQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KIuOYUE0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gaGp9Oxp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K7fa8B000876;
	Fri, 20 Jun 2025 12:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9MzxAYHepZ2vvz4MYh
	3hXaPXb7TVkJrIcCnQB6ghk+I=; b=KIuOYUE0/eqebJTs+kwDv2lMUrV1yHP9gu
	SfVERe9JaX0nt3/q2Dj9vCUPVapMndS6cRUu6QMhIMncnTCwyKtou6YLp9gfV4zp
	/HcYMwr252OeSMQr3yHoR4x27Cz+kgLtjbk0a8fVdaZ3Z9c5vqm3OFMlhLBgYZeD
	F7gGUxX9MlGL2NTsVdFbS4qouniIVF/U/bkFwApM0PB1Rd1pydzdw6904+UAH/Y0
	+zKZjB6WxXrNQQXwnYZG/GLmUpsCZwfDet6HLHSCKdMixSboQ7qyHO4Jy0+hEscT
	PeQc/9K7I7pYonIPjFUhg31XCSMNu6E39dKdVR1RvzYlHPhq6ApQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvnayns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 12:48:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55KCSCKE021547;
	Fri, 20 Jun 2025 12:48:22 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012000.outbound.protection.outlook.com [40.93.195.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhcn6dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 12:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDu4xOBR3r1foFyifu1felk4hefPm7S3o2FzKW1QMrF7avTmRzd3sKes5ZkNtrQnxa7YvEo3JS51OXhNCBsXtBoETmo4OE9WEFk3bUeoUY9Q05xUuLRxM6xE18AZikpwCTuu3J1jefXL+MlHmC3l7xtpNM/gxUjRa1ZWSs/PnYeVMFSYw91DVSsLyy1b8iuuFgQaiSzqB2PE80re5Bl12ssCr7draSVCVoI25xeFMZiPyjEaVO/UTetzoX5pji+9uOdjgr7MOSab7JPuyu8GIM1rv4dE6mtHiG3bq5xe1+DBazHV6tCnW2K3p9xMR6jB44Z5+HqfAlADFO64s0Q6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MzxAYHepZ2vvz4MYh3hXaPXb7TVkJrIcCnQB6ghk+I=;
 b=M6u4VTR9M72HraRSZLsrQIzZ8CGExQZ99B0YtOvQp1RmSNkTktfLAPfe76KIt6Ai34nb8xzO5ZzUvk6PalvLFfhuhzKXAiCpz6oeuUKL/uthog9CB31ALeA78S/OcqgnDNCNU8ZZrUjKnTzeticnsrsg5NQojoL5+nFUuHRhL49sn7S6lx5HTHpU7uMZ0NZHgFLEoq67RtZrgVDf/1WPz+/xmSo1djW+QBT0VvilQo8szyws7+wuCWdlg0knghZMS9atSH9uzxR7Z2miJVtWsuAtZussZXsmAbDB053IF4P0kEYlaD9milAStLpsOXwh2fqW9cfbIdlAA2yzpfZL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MzxAYHepZ2vvz4MYh3hXaPXb7TVkJrIcCnQB6ghk+I=;
 b=gaGp9OxpG2lEP5YiDRAVB7b0rYZ7de8qSEBwFq+DTyDwaER2j1KddHxV2jMARpqGO4kww7a976X31nHc7xq2s+/t0RQWE59Xj+Aw2HunH8gaZESMlp8ZDv5OK5mncKLL/o3S5wZREdkBTobv4e/qqa7WLJH35UzjwqKvzgD+/wo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7301.namprd10.prod.outlook.com (2603:10b6:208:404::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 12:48:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Fri, 20 Jun 2025
 12:48:11 +0000
Date: Fri, 20 Jun 2025 13:48:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: Re: [PATCH v3 3/4] mm: prevent KSM from breaking VMA merging for new
 VMAs
Message-ID: <5861f8f6-cf5a-4d82-a062-139fb3f9cddb@lucifer.local>
References: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
 <3ba660af716d87a18ca5b4e635f2101edeb56340.1748537921.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ba660af716d87a18ca5b4e635f2101edeb56340.1748537921.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: b1379999-e224-423b-5192-08ddaff8b6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4rXvFcIs9IpEre7qczD4D4OFyrMkWDrS+Raz8pjt4dkfFiRBL+g+VZBLSrA5?=
 =?us-ascii?Q?baVBvwI0R6oVQL8FPOY929+aFGyBUCaS0ii7Ot7yPBVFzWc5FrLeproBiKOk?=
 =?us-ascii?Q?a6kevYprQMNxXbsTZJmSRo9AAB/ufqIKljpH4WzcxbstJsAcO26lpA9T/arm?=
 =?us-ascii?Q?US2e13w8p2lr95VTsi9k0z9uZpRKEkwf0ul1ufTPO1QR/bLbZjwxXF6yffm9?=
 =?us-ascii?Q?6W+34ToMzkugsnEHs1n3k355Zyqe8rdZoGs3T+2Lzt1gPIlEcPISD8JoT5My?=
 =?us-ascii?Q?IxBq26yb613eQYi1u2Q4lQBV3vdP+ueGzDRFenxcx3gh8uo6Y81ZAbZUb8cG?=
 =?us-ascii?Q?nPNgvP5sVa2wNQBixUEwHR0wyWy39YvExLGaQRODaTF4u1dIuiq8FpVXo/RQ?=
 =?us-ascii?Q?z4PEHu3v+77fX2QcLNLhWQHVTJRzTwQbfsOkAgv4HANPweI1aoSi63zNXANe?=
 =?us-ascii?Q?piTpcvEvX8/j/wz12WTVnp1Y+EwuHSwZaXNFNDVfC4nO1JPnl8/IY+/WJ0q4?=
 =?us-ascii?Q?HsRQIuTG1BxeRfhvJfDHld3OLkYM+tzBcHIeHbKDDMr7zA0SeyLgoiULCv0l?=
 =?us-ascii?Q?l4vRXxxj74kPYe8lpb7YW1XIzICH1jO4dnVPlvlGiqxeHf6l7g5pGTB+JB48?=
 =?us-ascii?Q?lM5L1QwJ0f/HonzGWk2au8oLg0BR1uum2wXxxxeD6bcCvgY+3G8tpFJ/AIrP?=
 =?us-ascii?Q?5A3baHvvyffufDuP7XjWocD2X+NAQrAD+2YceYJ0/m6MSi9+kfEhCNBtoqDt?=
 =?us-ascii?Q?Zzf3arRz2f8W9D1oB8eHqJORJQt+4VQDXPpC1H0d24G5dLTBOSSshKsrL6Jm?=
 =?us-ascii?Q?IIswhf/sqqzjUH4eH5ysWdo4HGh//9ULwy0wpt8EcfcXKN8JekBO/uXRkXv4?=
 =?us-ascii?Q?60xRl8j+l8fn6cqn4waW52LzbIfMkfwrObOBM2/oxq3rMJCH03lMAIwE8mhk?=
 =?us-ascii?Q?cHeaeo9llJDqBTSlcCU5GLZEdXvbP5liRuRFEO3hCtVApAvrs/AJyGVB0+Am?=
 =?us-ascii?Q?LjKg3FoECggHC5lVyN5U7jvtnnQftZHH0F9IuDGGXVITvy+BVYJ/k1GzAURk?=
 =?us-ascii?Q?mg2sHExjyPqxyKi5ncapoMPOKM3gjFjnK2lb0Y/UqWK1Q8xaCafUvicQQh83?=
 =?us-ascii?Q?P0EpSeZYnzCUjjnhL5fVWQlguYxQCkJzHRY047P1YTvBIZxONqt0F5x6cP2b?=
 =?us-ascii?Q?peVu0Ix3yH4O4aMVAvGAt8Jf24J3xvFLbkWmDTRfm1AOZzQkLUEgeA9SmjNU?=
 =?us-ascii?Q?yp8Q8N/M5lDosimPncX9NX19U+Fj+JarLC3hPq64bhr4XmostF83kXV8vdOq?=
 =?us-ascii?Q?HWAxVK08mR4cqxwc2GHNzFb0wuRE4glWsniaPuv+PtWbKNJKijzCM4sRQw3Z?=
 =?us-ascii?Q?YkOU12xlGTE/YVxrEu3psaN4wYiC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wpdH7J/kn8T/xgQu65QNFOsOjfD8f3nW049Cp4T+8H6xsX4DGwD+hRXNYmS7?=
 =?us-ascii?Q?D5W75qnmAPG1horkGRZ+RP+0yTl6VATynaOA5Xi17H8b6dE2Ysyv95WKOV4a?=
 =?us-ascii?Q?TK7foteYgp1y3LzVED5/efeA7upqN9Ymck1dVfUU4f91u4/YWuuUBhOOpWwV?=
 =?us-ascii?Q?O2s6I/8jp3c1KK7uz996fX25VAoE5mI0k4UZPUJW8PmPsGN22CmUWYvYHd1U?=
 =?us-ascii?Q?v70Fma8HJRQmgmyzeWYQgAOviLaMRy7d//s2OQszj0Rc8TbX8PXJKqtIKJ7z?=
 =?us-ascii?Q?SbEKruQXL/B0y7+QV2PyUPp5Plwln1IZWR+BSEcgDMg89c9Y5gHxj+mBje11?=
 =?us-ascii?Q?YwXbwyw2fGccYei1jv+jXjpM6isEvh2Nqz7EC8df16xs4Dfrws6MOn7dt3o6?=
 =?us-ascii?Q?HrGLccTcDSMLfXJAKQN9aA/GHQzBVdmogsuSq1B8NlTJSkCkxjFU32PAMcmq?=
 =?us-ascii?Q?aCntDRJbxETpk7t/ss3A+BHVRuXnQGWH+fkfVi9pO6tT/YTVvbAxALt7gZP+?=
 =?us-ascii?Q?o2IYxodZdT73qc7Y1VlVRgxeFJErigRIh80/X0MeDiA7X6fPSuwCWa61UBT6?=
 =?us-ascii?Q?0f1CsizOaDECM4ppiWkS60PaGCfjPnTIsUwghIsd3UtWJC2Qy2nBAIFgCYVm?=
 =?us-ascii?Q?IY7O8zcJsN4IwTo6W9nkAYPtSSdnb42uDJqirrelOjfwmyVZo9T+FWDuXZGs?=
 =?us-ascii?Q?Pyayb7jhYK6ttfpTsd3psfQ7+Hy/OsS7ab6hTZuLjGgGPC/f6Lm5o7Ux2FjG?=
 =?us-ascii?Q?mTpKk4LguiRvSqSWxnteJOAMKZ54+o8E8zG4wZ7inQEPO3bsNx2+HhBytcBm?=
 =?us-ascii?Q?H3/ilw3BGEILd7/FYods3+feA2l7/Op5Gq2cmm697d4gxST3K20zrGQkbr7Y?=
 =?us-ascii?Q?YxIYfvIixMT6xxYw30ixaDxgBb5WA1szd7mVOEdqQ7ej5I0jikvKrPM90U4d?=
 =?us-ascii?Q?aX/nXVyCz4bQyz4l5X785Lb1h79lNezx+rThE5z75WbXfJqtZ88570400hL+?=
 =?us-ascii?Q?oIQKv2S7uNNXLVJ/eQusPt/s7GIRTgIB/1+X4KY2uqxeMCMg2Xklfz/AO9Cm?=
 =?us-ascii?Q?i1qzlJWRS6bCg3CHwpY/xKu3O1rLMZczc68vBCDs4I7f85S9xMhhb5v27v+k?=
 =?us-ascii?Q?TBoPbv0kjGXfUA1JwsKYnglY4ZSv3D7Tu32kPueWGWysow0Y030mKU/mTJwP?=
 =?us-ascii?Q?y1RjJ8ulkgusYMcih6F0kdMzLihUKpc/yIH3AVfCUsqzwkh9IuFuwrGfDxrb?=
 =?us-ascii?Q?dknSBbsIx4VA6hDCZ0bB0l6unY2atMLa/oGB1barTgtKIJ3i7beV7OPs7MeD?=
 =?us-ascii?Q?k1nPDPECPyzhSAvINJwzfh75YbuDj0aGc7Ik6TlyNoyTQzAIh9tAtud/KAUB?=
 =?us-ascii?Q?NuYk/FYFHJrVNo7hKc8RpxNNDCi+P2NSoFMRt7s/OJXSqk8v/fiD6XPLqCeR?=
 =?us-ascii?Q?R702fxefPm9tr9AF1uxtIuTxIYo8N3gYHVV7WGokZwRytF7QhtclYgMAIDTj?=
 =?us-ascii?Q?wOWO+srUrhgFF2Nf5d5emBCbkJSxIl+xG3vlE+qv64HFqlH3H1AiuyNDPI3a?=
 =?us-ascii?Q?2eqniPyyiaG4EfK0KO03AKYxMhmzL/AjLmBjchcH42GjL/W4x3bTzBf7lNMG?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ivOeUxrqtahnw27KdYjqjgPyuAyUZpkVqad8/cC7BWQBCFvhP10ZBH9daJbizza5bB+GN4J25GN6c+oJjsVmNYusADftXGfJEFuBHmkWz7QzEZ3PZmw9HMQCsSmtTs+2OaYhv9zEH/vbAGL4VN8Lh2AALGIEzqH2rczMkDQvI+IydJy7KwnUqqui1/wz6HKVaTe831am8HEBMv6qYvhkCSwC1w7/QW6P5vxW5iZWF/UzFfTCLlhW7k/SDRYpsHFgABo+Gs00RvVL1IXpDzfKlEFVqQLJHaf83eUo8SZauIcvCNBySEGzK5cYbHwaG6ytHswzPadllQwakFxouX8w5lii3qxD5uXX2sFDzyom3XTNHfqjzN/Da74munOjQtbB0gywrZpajbmXtP8rnmJbbazAkq0DWV3h23eQU7pgtE/MKt2uAGaiqmUzKRQ9PTDYsoUhdkLjcbI13AIeX/ol4L7bIgt53As8nOI2DsBG8e0GSFL6aLkpRu34XIknoHHRvITjP4ZQGaCdZeRk6cQuvHu6u+7GLPcl3B4Ek3yrOvoBpIdXk3yhjMUio1i9wGplNnGqmWMMksYhmQT4woFSzHCI8sgNTogLQ+FBInRZbHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1379999-e224-423b-5192-08ddaff8b6f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 12:48:11.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8oQO5BK/1sWA78409N3KQ1gk09E47Nh0Dt098lSzgNPRl3a1nylAxgcZndA46LbpG4rACH8vI/vltSYXscPI0dKbNPp/Ho0fAIyYBZZuqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506200091
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=68555897 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=hSkVLCK3AAAA:8 a=TN86Xnex78Rq4h9SjA8A:9 a=CjuIK1q_8ugA:10 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: 4NMylTT3-O6NQaPlqhc3Cz_lJg1vUk82
X-Proofpoint-GUID: 4NMylTT3-O6NQaPlqhc3Cz_lJg1vUk82
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA5MSBTYWx0ZWRfXy9lETSITATmq LTNt5zmZ6jheWls3BuH1Ai3R2pHkbvX9MCtbWNY3zIwZSaxZNwfD0nOtSF9d2buTVo3If2Xg5HU rUU0CybNytWkQcp+I77Q9T7ScvSdmxA9y+HP4gGJ+r40l5rO6/KpDMT+ZPxbylzKysArPjfw7YF
 oeLzSWLMaXmlEM3i4EikyQZqi/tOFbu7Si1z+PKiimmG0xRZgkAZoM/z2ykQ7LSdUuERWODyEBn L9M9Ep95M2TPb3TXsEmCjamKBwOIjWL5w9n3gBO6XEK+KKyhfaVaVDnPVLrIPHR6e6P21GNxOv1 Q4L/OW522tyQtA9pQ2YRRi7hwLpIMyBzcznoWvCAtlC2AXCrRbyQdGszcWIAbdXK+JkaTSTsboF
 dofK+fpt5fcp3XeipVB33q/rZVun7MS+ZWYo6tYvZZ+FFe0OxupzR8B4C97tjAfkNAmvq+gd

Hi Andrew,

Sending a fix-patch for this commit due to a reported syzbot issue which
highlighted a bug in the implementation.

I discuss the syzbot report at [0].

[0]: https://lore.kernel.org/all/a55beb72-4288-4356-9642-76ab35a2a07c@lucifer.local/

There's a very minor conflict around the map->vm_flags vs. map->flags change,
easily resolvable, but if you need a respin let me know.

I ran through all mm self tests included the newly introduced one in 4/4 and all
good.

Thanks, Lorenzo

----8<----
From 4d9dde3013837595d733b5059c2d6474261654d6 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 20 Jun 2025 13:21:03 +0100
Subject: [PATCH] mm/vma: correctly invoke late KSM check after mmap hook

Previously we erroneously checked whether KSM was applicable prior to
invoking the f_op->mmap() hook in the case of not being able to perform
this check early.

This is problematic, as filesystems such as hugetlb, which use anonymous
memory and might otherwise get KSM'd, set VM_HUGETLB in the f_op->mmap()
hook.

Correct this by checking at the appropriate time.

Reported-by: syzbot+a74a028d848147bc5931@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6853fc57.a00a0220.137b3.0009.GAE@google.com/
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 4abed296d882..eccc4e0b4d32 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -32,6 +32,9 @@ struct mmap_state {
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
 	struct maple_tree mt_detach;
+
+	/* Determine if we can check KSM flags early in mmap() logic. */
+	bool check_ksm_early;
 };

 #define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, vm_flags_, file_) \
@@ -2334,6 +2337,11 @@ static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
 	vms_complete_munmap_vmas(vms, mas_detach);
 }

+static void update_ksm_flags(struct mmap_state *map)
+{
+	map->vm_flags = ksm_vma_flags(map->mm, map->file, map->vm_flags);
+}
+
 /*
  * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
  * unmapped once the map operation is completed, check limits, account mapping
@@ -2438,6 +2446,7 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 			!(map->vm_flags & VM_MAYWRITE) &&
 			(vma->vm_flags & VM_MAYWRITE));

+	map->file = vma->vm_file;
 	map->vm_flags = vma->vm_flags;

 	return 0;
@@ -2487,6 +2496,11 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	if (error)
 		goto free_iter_vma;

+	if (!map->check_ksm_early) {
+		update_ksm_flags(map);
+		vm_flags_init(vma, map->vm_flags);
+	}
+
 #ifdef CONFIG_SPARC64
 	/* TODO: Fix SPARC ADI! */
 	WARN_ON_ONCE(!arch_validate_flags(map->vm_flags));
@@ -2606,11 +2620,6 @@ static void set_vma_user_defined_fields(struct vm_area_struct *vma,
 	vma->vm_private_data = map->vm_private_data;
 }

-static void update_ksm_flags(struct mmap_state *map)
-{
-	map->vm_flags = ksm_vma_flags(map->mm, map->file, map->vm_flags);
-}
-
 /*
  * Are we guaranteed no driver can change state such as to preclude KSM merging?
  * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
@@ -2650,7 +2659,8 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
-	bool check_ksm_early = can_set_ksm_flags_early(&map);
+
+	map.check_ksm_early = can_set_ksm_flags_early(&map);

 	error = __mmap_prepare(&map, uf);
 	if (!error && have_mmap_prepare)
@@ -2658,7 +2668,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	if (error)
 		goto abort_munmap;

-	if (check_ksm_early)
+	if (map.check_ksm_early)
 		update_ksm_flags(&map);

 	/* Attempt to merge with adjacent VMAs... */
@@ -2670,9 +2680,6 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,

 	/* ...but if we can't, allocate a new VMA. */
 	if (!vma) {
-		if (!check_ksm_early)
-			update_ksm_flags(&map);
-
 		error = __mmap_new_vma(&map, &vma);
 		if (error)
 			goto unacct_error;
--
2.49.0

