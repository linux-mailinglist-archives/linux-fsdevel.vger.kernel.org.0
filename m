Return-Path: <linux-fsdevel+bounces-33009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F57B9B15D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 09:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259E01F2215F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 07:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBDC189910;
	Sat, 26 Oct 2024 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GAGewO8t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ziQTk4gS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4F13BAE7;
	Sat, 26 Oct 2024 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729927530; cv=fail; b=fmlmMOOXzShgEgIb2Da2NAikQAjfhyjI2ThZIdtnE2l/n0h6fagc1cXZ8acqc4WlXPHWdyTYPA6WeJXbieyKcuPhouqv0HZso0WXycULWxEgb51TF0R1ma2VWOVfeFRyaIuTgEaCyLo4hILmNyX2q5S2KBxSZ0+Cd/O3/AfJFNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729927530; c=relaxed/simple;
	bh=1GpvADSqsq4tnlLFx3u4o6Wwyrnin5JiXLi20OUiVgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z87dMTvZciOKunQfUXN840bacnbllGTPNFLeAIfuVKxXSMW+U4FjYM4LH1EAZXNFcWDQ4GHf/Xx8th+2kPv7IARN9e5ehQV7rlX0YS02GYwf4Bcel0ZolY046fz3o6q/ZatqCJu6kb42bYoJ6uUvVlQJPR0saFFPNU9OVkrO1sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GAGewO8t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ziQTk4gS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q3JgJP012970;
	Sat, 26 Oct 2024 07:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ysaPi8DTdXVgT7KKevj+tCObGLJIis9xvmd4QhwzTz8=; b=
	GAGewO8tTWzaTK//HW+fhgGnno7PPrGkRb/kIAtH3lM3prIfv+LYUFTwZmcilNVf
	iI8fhCkgWeEQ4nmakKDBzdHK7QZ2A44/Zur4jVTXKGCPaTUkkklVkeARvLxbuOxf
	v0xjBONKp4B1MDc6bJt8TliUTu1Am+JbxDPpkOFHdvPgklHXzFLAeC4IvYDxoEOA
	jnzfcgycvgJA5mhtY1WZwOr5Kb5NO+/oFv7VaES8Fu4rPekFwuHsjACUD6SeWcRW
	YLK8cVuyED+vv97WVZjUagDTFWxtTuglgSbcq1aUXHmFkByx1bfkpB0CWcs2371P
	IPAl3Ln3mU9nZ6YyeLhMrg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdq84m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q3DnSq004393;
	Sat, 26 Oct 2024 07:25:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42gpvaddaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIZIYXgoEWDtreLmcjhbLHDJeWYiDxCiTiVWwQgRdDF3IgML6fW65byngz1Pu7lejA+3wkG1WuYTEb1RZ+QHldbAZ7kvQ3He51Jjaml3ATWAmUylOFS0RHTBrWX3DN+STQOVr1HSRFEOCmknJO2TC07f7DR2tGnj9qQeb7WoTGZBO1TCTGlYYY+xYSNY9kBP0WB8BJIOYnL9djipoWS72DrFe/ZAZj3JLmNiOmHeJnF1MzQCJQDH3MusdAw6i4k7n/CThPATMktUvCweloZB1agaCrwIPnkNg5Q7+Wi7/yjSmsNEBXeOEpu3xTIM918D/eZsN8PH0vfPA7VOoyR+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysaPi8DTdXVgT7KKevj+tCObGLJIis9xvmd4QhwzTz8=;
 b=Rj4ttO5m1couZ0t757d4YIKH1inbhju5RBz0Ljszk5cUF+kXh0Oj8amOruaHWx7D6DpRCjo31FUxmIyh801Ft0fJUYPkCXe+E5RSzp+9DhtLivA7Ribn+6oNe6FPKwEvKpxIVmdSH3pragbHuW9Mom7GTka1N8zaV/jUT7NHlSucBEVNx127aWrWQeu2DrnQL9KO8mhTtKLJN3U6ZuxL4HVcTlR2n7KoL8tAt4UF/z2Wp/9unx465NwCajYLED83P62rqjrcd3rghKvVUtbWeADmkexYqxXjJu2kuVSkH9B7fiN/kcdefcVLEkrb6cjLJJXJTUpqnGOzGftauZxItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysaPi8DTdXVgT7KKevj+tCObGLJIis9xvmd4QhwzTz8=;
 b=ziQTk4gSeO9xtNFwiRkSJjuP7Yo7O25I9Nq6vkRCkqOgM/fVG6V06MbCKCFHWSTXcp3yFHMRWQVc5ms5kHcA0rnhGGGNHb7YNz8WbpaUt+VeaVxLCbxpmFzxAVvz+N+K5WKJKZ5ZYe0q05TUmC5gna7h8sQEzriA4JtT+IviTRA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 07:25:10 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Sat, 26 Oct 2024
 07:25:10 +0000
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
Subject: [PATCH v6 1/5] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
Date: Sat, 26 Oct 2024 08:24:57 +0100
Message-ID: <fda2b217caafeccb1f3e7f20a29dc003a3d475a5.1729926229.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::27) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: c05217eb-4440-417a-ad7f-08dcf58f5329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oZ3SFKdHgje5eXDvuQbRKET7S3nY+TkEX3a560LEjgiy/SD6zib8F4JvjHK7?=
 =?us-ascii?Q?bOF+m6B+zVIfulr6TFwE/WrrU5cR0yIqBzuuJOnKfMt0CX/wRV6HD53S5Im8?=
 =?us-ascii?Q?+bvXsiLT1t4O8PswYxpT21cjtp3RFo9U8RqkV7werDouagJpucA+bFVIXK46?=
 =?us-ascii?Q?7ae3DoSG33Fffqsx1/eSK1jMtg7EmI69zLOepFlV8dVEUlEFSRU3gAfk9rOS?=
 =?us-ascii?Q?9m9igetjknQM8MTzfHnw8t0nZnUaDTk2ELK6fQNvFq6Ph1Tw30mR6WuGWQU1?=
 =?us-ascii?Q?Rdh4dk9j1xosPDzADScgVXj6e4f53r2G4W5pukjC57YjJAomlCdX3d0Yp3dl?=
 =?us-ascii?Q?hFtdkp0fP+4DlbyS6OD4GIx00ShUTd0XueZWjfHZBz5XJFvcJgijp+FspWlF?=
 =?us-ascii?Q?hp8ZJskeJpuKHXj/YpvNLNSNwBWl3yfDn+klKhIXZcDA7734zKd71P/8WeD+?=
 =?us-ascii?Q?qjqRFElJq60/V6ewjlAxZR8xyiCFLhLfipGpTSBuK2c7oBZB+3LMwiXdDbpf?=
 =?us-ascii?Q?zLTfac0qlyzodjmwReqFj4S/pV3EZfTes1qLn0Z48Us+IHqUrDgpvuqA+ApT?=
 =?us-ascii?Q?3byBu7oyzVWqspCig5ddyS38RLcyOCNEG98sSou1c6pdI0LI7PVRN5m+cKob?=
 =?us-ascii?Q?AOzLm6TmK76WR7r//cuEVlzJ2dmtet9UDJn9v0e5k8XZHY18er/zYdx8RVGc?=
 =?us-ascii?Q?96Je3uyxwka+sjM5vj1HsOICLyYPTduJLzEzwypHuQClX2H1ouyfxL8GV6cb?=
 =?us-ascii?Q?TfdaRIcm3ilMptOaBj2ycNzFzxGcfqhn+Y7JdKrqhBtqEFdumVducDEUK2Y7?=
 =?us-ascii?Q?dI8xk7yfUCI9JNhqcY2GHuSYHyl0ERDSBCX2V8b1DR2hX67gAfuBLdzE2yXr?=
 =?us-ascii?Q?fA0oHa9HEkovw/ZWFJE9nwR7D/KtBRLLDPZQHCTkxcLIhQFHMkj2+Ao0KZyo?=
 =?us-ascii?Q?gKpgTtRWjA6H2GDOHxt70YodajD1cs7FzCGcDM9ELWUIMNa04UYUhd44vFsH?=
 =?us-ascii?Q?6awbyf6Nyie831XZjKnx5yD3tzNbDi58vO6+ce+q79p2BE/DWwvHXCT6YeUl?=
 =?us-ascii?Q?ZgFuOQmCC/f04/HLz3iJgGcgXm+t7dJKWP3qU7JCGH2LfvrEAlvTQDW7vNJi?=
 =?us-ascii?Q?ehyxExKIQqYSFYH7iavuMexs1JNlZEjJWq8Rn+TUxI2Qjy4exBrzUL2Ae+Wo?=
 =?us-ascii?Q?RwO1NP3+IUrmnomE+aQqdGhicNjADg4fbt2TMIhJ37OHoJv4ELJGW+MJyZG6?=
 =?us-ascii?Q?fGc42KmyJK0OfSFm7ra6OriuLq5Rwss39f+gZIkR4PUi+Ese4F0dFGKgBkHa?=
 =?us-ascii?Q?KxhuAKVDEik0qhvr2nmxguyB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P/3Zavcpy2gEwkMgPP3lUr+J9oCG8jXJ08G0xT8SZyF1OcaGg7AFLxmNBTcx?=
 =?us-ascii?Q?/z537CbRcYffdVio3fIKGR2oCUGeLD85kp2kYYR4kBLLSisPQZ59mDIYW5a5?=
 =?us-ascii?Q?N2bBF7HprH7/bnDrVYrlFLvauv9G0zM7coTCTLZXYdJDcA/PyCTaoWMqKUuZ?=
 =?us-ascii?Q?gozQ/7zAnZAKi1fTR3fOlTU2Me+nroofcjUiO8xXOcEiIqq2whjcVNXRf8uD?=
 =?us-ascii?Q?hNTj2Yly+wchbH6YMT+1AFPqRL3q8ReyrLBLtQAE4rIkH4UycC6CQLQBZsPU?=
 =?us-ascii?Q?efBSsvSjAcfu522TgN8Ei5+Cl5fZRc9JVZmERGMEFpNc/vAN3O/QyTetSimE?=
 =?us-ascii?Q?bCKjbNFkxOXiSZUC1JS87wmVLVGvTRQaCrU7b9jGQMe58osaHZb4awGeBd9M?=
 =?us-ascii?Q?r6VIYTCX+sivZn0pxIX9CMBmn53obDKkWbOXYzTmyb3S5l13A6AFzVCBQI4X?=
 =?us-ascii?Q?6aOj5d7Q6iZd/Cn9zm2Yv8lf0HjNWt54hqCQ/alz5V4g5XbYIpuT1qP7vj8X?=
 =?us-ascii?Q?PRxSXezF8J/SLzhFVB8Q6mccQWfWko7pHYi1yetBrjaDD1Ol8oI3INUQiaxm?=
 =?us-ascii?Q?L/xNq60HetPGw0Y4XSPZkPj+0mtHjYI1MzMe87t7c1Y+Iprqw/NoQ1B1biDk?=
 =?us-ascii?Q?sS71cXrUPjkcZrA4/ow4M+OrTaigtNreaWT9Gnm4Zf2Z1rmzn9xA+AJMys49?=
 =?us-ascii?Q?pdrj5eYk+jnMxFtnQR08WWbJwmMXlEe+uWwpAUdDMYS3YGTFHmUfLBIKI8Bi?=
 =?us-ascii?Q?7Ti0eVILV5TgSJoASpkWHjGb/AvZLIwtiZlthbP30cLrhFbjcBnahgB7Js7y?=
 =?us-ascii?Q?XuytjflzBCCixiwczMGdBR2hU/7aij5It+978CG0DD+HE4BZZBPPJBFn/6kP?=
 =?us-ascii?Q?Pl+CSboLyDa6tpi4FGDgqTs2nere6xzSPgxbDVcNsOKbmeQFxQQ9fSKqu1Q7?=
 =?us-ascii?Q?L4EUHaY23WMVTnSdQyeFuIFvjXEZswJnimF9flzmh+BIYK3sxG0xfDSETCsV?=
 =?us-ascii?Q?8EuzeTtYw7HBt/nJ3f3sPJB2xjxy4bmbaasihKXehLh8vB0oSo5JM/rv0+sS?=
 =?us-ascii?Q?0jp+OBekq2PFWWfyoprejGnmF1GEj0C37H71HljvDv2hKg4K9yZ7ZcLuKiqJ?=
 =?us-ascii?Q?M2ZIM6xrIU/tWe+Ta+UjTrNPSDQinCEuW+RQO4QIiUGCvNd5coCJN5dpJ/bP?=
 =?us-ascii?Q?XIpNSqJqaF9g3weq38Aowc+83mO9feHpcT6wGlfjf/JtEGucT83CJhbBclsf?=
 =?us-ascii?Q?cHvQjFY6kamDpT9Y8bD41tCxEVyo/L1FMzTeVAT7KgBtOrrXm0Mi91CnWsgX?=
 =?us-ascii?Q?TJky5oaYkp+pfhFi1D0PFg6+JeOqIBTKJbJCe0pSMtxtxFBzzVXqueIFA62N?=
 =?us-ascii?Q?UFRymPNemjdtyYD90zcxbRT8GFqQTCEnyZs+vcDRV6jzkSOqyF+lfs93z8gD?=
 =?us-ascii?Q?nqALeaD0cYnjGgwtMsr8X5bxSyofBC08MPm8jAGAD93jxql5I/1wXZQJIpcw?=
 =?us-ascii?Q?TdPjTFKlJgDODEZ3H8NE5JQuzDxKDghiiQg7Mu+6w7OTocBCJr/oG2vLYfmR?=
 =?us-ascii?Q?5JuD0lZ+keRmzTROtM3MTvUfKSpXBcMEOSXgvL/JJHUC8uxaiZDGuR3cnZc1?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wVarTsIb5VcyVYIrDGFHSBKOf+w8qKLwHtY8eP3Q7QpCvDefcTULPwnsn3vSZysO88iiQ8YwojWu3qM+Ph+jxjT6wVG/gmrlIgcHIYol6n3Fs3GP5Lsijgw3R1nZTZcQCYu9AzLcm+wulgLybGCuok7y4rbw1J84L90H3m+Hhtp5VVYZ3P5P7usSKgdsljkxyI4WSBKcUpAP4O3tyF3BnfnngkIWDjyxBQes9dcN0txTxRfaKNwtaTANVZtsDzODESbjKHLcBTrIKICqaQ3RvIWlTX6OSquQm8L2Ko43mqw4qf9BMdthfgj3iYi1vmNj6HYLvZWcpTqATiXeIleJVMCtve3NfR0fE34AiERzQt3Lfdkkl56744eQYELu2ortV6w3q9IV4dVOIbPdmlYuzs+031I2Dapb8DS082CJKrr0Qk8CQFDEFnLV2eiqvIN+tLFuCkHssI7IVTn0iK8BtyIem91yA7Dj7ahKZmxspER25qxM+Axh942MGcAnTuGON0S+Nzk5kIouZQhdKSgnWhgXYjnesKu7RW9jPKXM+WThuF0lo5SEJVs66xBzGFEXbStETtyz+Ho+XZGvB/nPtT+6TILgZpdyDD4E/nvGhOo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05217eb-4440-417a-ad7f-08dcf58f5329
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 07:25:10.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2JItDQRoB4Nw1G0Xl+VIjGtGBb53CxFCxNaxlBqd/sZpd8W1lEz1wURzlp/FnuMFU4m5/vOG0atlW8m4iaNLTu8dqPxxBTQKDj0FCNvZxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410260060
X-Proofpoint-GUID: 4VBHUktliZglGhPqbtwc-fvR6CZ04yP4
X-Proofpoint-ORIG-GUID: 4VBHUktliZglGhPqbtwc-fvR6CZ04yP4

The means by which a pid is determined from a pidfd is duplicated, with
some callers holding a reference to the (pid)fd, and others explicitly
pinning the pid.

Introduce __pidfd_get_pid() which narrows this to one approach of pinning
the pid, with an optional output parameters for file->f_flags to avoid the
need to hold onto a file to retrieve this.

Additionally, allow the ability to open a pidfd by opening a /proc/<pid>
directory, utilised by the pidfd_send_signal() system call, providing a
pidfd_get_pid_proc() helper function to do so.

Doing this allows us to eliminate open-coded pidfd pid lookup and to
consistently handle this in one place.

This lays the groundwork for a subsequent patch which adds a new sentinel
pidfd to explicitly reference the current process (i.e. thread group
leader) without the need for a pidfd.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h | 30 +++++++++++++++++++++++++++++-
 kernel/pid.c        | 42 ++++++++++++++++++++++++------------------
 kernel/signal.c     | 29 ++++++-----------------------
 3 files changed, 59 insertions(+), 42 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index a3aad9b4074c..d466890e1b35 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+#include <linux/file.h>
 #include <linux/pid_types.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -72,8 +73,35 @@ extern struct pid init_struct_pid;
 
 struct file;
 
+
+/**
+ * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
+ *
+ * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
+ *              @alloc_proc is also set.
+ * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
+ *              of a pidfd, and this will be used to determine the pid.
+ * @flags:      Output variable, if non-NULL, then the file->f_flags of the
+ *              pidfd will be set here.
+ *
+ * Returns: If successful, the pid associated with the pidfd, otherwise an
+ *          error.
+ */
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
+			    unsigned int *flags);
+
+static inline struct pid *pidfd_get_pid(unsigned int pidfd, unsigned int *flags)
+{
+	return __pidfd_get_pid(pidfd, /* allow_proc = */ false, flags);
+}
+
+static inline struct pid *pidfd_get_pid_proc(unsigned int pidfd,
+					     unsigned int *flags)
+{
+	return __pidfd_get_pid(pidfd, /* allow_proc = */ true, flags);
+}
+
 struct pid *pidfd_pid(const struct file *file);
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 void do_notify_pidfd(struct task_struct *task);
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..94c97559e5c5 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -36,6 +36,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/init_task.h>
 #include <linux/syscalls.h>
+#include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/refcount.h>
 #include <linux/anon_inodes.h>
@@ -534,22 +535,32 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 }
 EXPORT_SYMBOL_GPL(find_ge_pid);
 
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
+			    unsigned int *flags)
 {
-	struct fd f;
 	struct pid *pid;
+	struct fd f = fdget(pidfd);
+	struct file *file = fd_file(f);
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	if (!file)
 		return ERR_PTR(-EBADF);
 
-	pid = pidfd_pid(fd_file(f));
-	if (!IS_ERR(pid)) {
-		get_pid(pid);
-		*flags = fd_file(f)->f_flags;
+	pid = pidfd_pid(file);
+	/* If we allow opening a pidfd via /proc/<pid>, do so. */
+	if (IS_ERR(pid) && allow_proc)
+		pid = tgid_pidfd_to_pid(file);
+
+	if (IS_ERR(pid)) {
+		fdput(f);
+		return pid;
 	}
 
+	/* Pin pid before we release fd. */
+	get_pid(pid);
+	if (flags)
+		*flags = file->f_flags;
 	fdput(f);
+
 	return pid;
 }
 
@@ -747,23 +758,18 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
 		unsigned int, flags)
 {
 	struct pid *pid;
-	struct fd f;
 	int ret;
 
 	/* flags is currently unused - make sure it's unset */
 	if (flags)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
-	pid = pidfd_pid(fd_file(f));
+	pid = pidfd_get_pid(pidfd, NULL);
 	if (IS_ERR(pid))
-		ret = PTR_ERR(pid);
-	else
-		ret = pidfd_getfd(pid, fd);
+		return PTR_ERR(pid);
 
-	fdput(f);
+	ret = pidfd_getfd(pid, fd);
+
+	put_pid(pid);
 	return ret;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 4344860ffcac..9a35b1cf40ad 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3875,17 +3875,6 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
 	return copy_siginfo_from_user(kinfo, info);
 }
 
-static struct pid *pidfd_to_pid(const struct file *file)
-{
-	struct pid *pid;
-
-	pid = pidfd_pid(file);
-	if (!IS_ERR(pid))
-		return pid;
-
-	return tgid_pidfd_to_pid(file);
-}
-
 #define PIDFD_SEND_SIGNAL_FLAGS                            \
 	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
 	 PIDFD_SIGNAL_PROCESS_GROUP)
@@ -3908,10 +3897,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		siginfo_t __user *, info, unsigned int, flags)
 {
 	int ret;
-	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 	enum pid_type type;
+	unsigned int f_flags;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
@@ -3921,16 +3910,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
 	/* Is this a pidfd? */
-	pid = pidfd_to_pid(fd_file(f));
-	if (IS_ERR(pid)) {
-		ret = PTR_ERR(pid);
-		goto err;
-	}
+	pid = pidfd_get_pid_proc(pidfd, &f_flags);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
 
 	ret = -EINVAL;
 	if (!access_pidfd_pidns(pid))
@@ -3939,7 +3922,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	switch (flags) {
 	case 0:
 		/* Infer scope from the type of pidfd. */
-		if (fd_file(f)->f_flags & PIDFD_THREAD)
+		if (f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
@@ -3978,7 +3961,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	else
 		ret = kill_pid_info_type(sig, &kinfo, pid, type);
 err:
-	fdput(f);
+	put_pid(pid);
 	return ret;
 }
 
-- 
2.47.0


