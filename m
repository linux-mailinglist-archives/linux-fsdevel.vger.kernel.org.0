Return-Path: <linux-fsdevel+bounces-47848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7ACAA61F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F6F17C337
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3266224B0F;
	Thu,  1 May 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RESDq3A8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sxdDotMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194EB1E9B2F;
	Thu,  1 May 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118851; cv=fail; b=jz58aEFQRGUmiaTxG1Czq12WACbBDSBLY93d4jTs/Mcu230Scjpf5Vx7LDrhtBqU3yIEbXJ9x7VDplz0ML0AkJ41fyx5Kx8yNSAHrPTBe6gnhPPSOFx6Ubv643wn+pVaDJYiHGjFynVuyQPJv2FjW0iQfueX/8tt6QINIoDWQzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118851; c=relaxed/simple;
	bh=lESyKXmcD/WIInZy1ooaRbLsrQrEG0WmZvzyJ3JgkqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SLwLcxlICL9Va4ErSDCbEuaCaQ8WxUilnX8n3zI+zK+4lITz2p0rWDhoTtfBIjZDeiimPNCYH3IGNK3iC8P2+UifJnDTSlXCxRAT7S0fsEu264lbci5SMBWrfDbVoDCcatSPlbkT3kyNwOPN61V9gPcflHkQoB+TTHdoo/F1uSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RESDq3A8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sxdDotMp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541GkAhB028746;
	Thu, 1 May 2025 16:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ditZR8XzZpGzgHP6gzZd9TEojSztMv1kem5aHGLO5UM=; b=
	RESDq3A8QqLQxN5GovRIYn3gvoe6YJ8lQcsi6zDmhHwREGvHoxV7EW+lK7xpVIK+
	i5cOZ7MbXvj/XhVaM4bwPc5PP1eofxgVTMplA+uKb4BvOiIx+qLSizbMU9V0tL//
	ThBBuf3unbLU80EsxQ9M86orVXj744O4oXx5jyNOlGXsumqZ9BldNpnqxwqnHbWd
	DhYOFU/TMpqzCb9oZm5oUU1PFhwFpj4b3UyHlUGxgN1LpDtjVHK2JBGcxW6NusqT
	5/qFU69/GbU0ixqGNZaa96+6aczNmV9OgFhv4NEJT5uHAW8z29XDy1oLIoEIdflF
	fS4khNVag5zv4PIe1SWRaA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uckg1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541G5RKS001499;
	Thu, 1 May 2025 16:58:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxcrfys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWSgMQqpR6Kidvj/D8tcU8ceRepz809s53BCZ6PiHzawLwA+xfwqaoRgrIG8sTJBh/sN6PuP1KxEFnW/LG8eRVEJOEIStNXkD8ywLpVWFQve7Igev7/H7LbFHYsHrZryF4DD9y2MJetYv2uqRqTh1OnPSMzzkGc345L5oHjmk8ojCCD/vtmoQak4s4ZFK2S5Qq1wsjaSDS9yYPMr63TGwtuiJvdzucOBgGBEvYJIW/DcgwV/tLV/A2yZpBuKKQuCQwK8zNPfTBiuBmZzKcaFQ/0jiPZq0krBqBeLL5qvuhJoc2MgUyflDG4LrGE90bxDWy4rzMHtyABPwE3spOHm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ditZR8XzZpGzgHP6gzZd9TEojSztMv1kem5aHGLO5UM=;
 b=OuYHqPYCxTx1c8qQCoXdmBAbA9GxdQu55s0v4X4Y8QGM3zzeG2504H9F1OblC+FA+RVfD9BwGH49lxkD4zBsiUP6BMYqzbt2Gfk08nSqd8dA2e7mCyyA/LIOhVTVfLdeIzSJ9wT+kxnL1hig+Qy6qPy472aPYIXCUlb5n3XHNsS7ycJvZbTzTa4oeasW0EOuNfxXXjKYIyMPoYnvXEgnVPOUBcw1Qg2Xe6+qtyYQ6I7/F4TpKWTIvu/WpPjC+v3n5ex79dx6+HkAW7dTMhRo+ew24KLdoeIM98dCjY/zGom5sKgJWv9fhSPJ09ZsaeIRJqE4Qgt/7t/ipBEAlh1Pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ditZR8XzZpGzgHP6gzZd9TEojSztMv1kem5aHGLO5UM=;
 b=sxdDotMp4mbopVb6bdMpYNh+m+zTZhnhJ1c4hPZFlLfheYcx7cvA8iy1+C4XZVpYxToO0fLBTKOxqGVkss4m/+R9v5sUjnkO6wz9Pr4M+xdDPgABmWBO7KUXUA5ZWPjfEsoxe3voeMyGfyC5xR88HpqeHB/hIMzP7MZxwOdThp0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 16:58:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:58:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 11/15] xfs: commit CoW-based atomic writes atomically
Date: Thu,  1 May 2025 16:57:29 +0000
Message-Id: <20250501165733.1025207-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1157e8-ae31-4029-9cf6-08dd88d1565d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dV0XwqjPDL7vGZjXxZzFyPr9kP4C10OQlkoT0oyqZxE7tCICQ1d4CNQEwi+m?=
 =?us-ascii?Q?PPF53owwyWs9QgTuf47IgvzR/oKjuX5GmBz3wiwJ2CfTmo7ANVqgAhgHhnZi?=
 =?us-ascii?Q?QefF2Ijz44ZwfIDBPtS1GcSL6RzYCN0ECsF0MOrM83hflw6lrb+snFnTSUxU?=
 =?us-ascii?Q?pb/r3UNWGf13xfx9deddaaK3CR+bIZ1C8tvW0es1rxNR1K8twD9wKGPfvyrt?=
 =?us-ascii?Q?iuwHSv7QjXUbGyLD5Vu/R8x/B6XEjZ/svQ8zdjcoHG7yv97V038P317QKWq4?=
 =?us-ascii?Q?ywQ9+Qr/fCg6gZPqGE5o7k/JX+AA6emzXIiB3LrC7AW/am1304Mnoeuee3d3?=
 =?us-ascii?Q?EwJWwQsLGhllWHkVRAJYmGIyg/Rnc3gJe4Ng7ApmmDpynw7Fd3YUwGbIO7Bb?=
 =?us-ascii?Q?qi9OBzWGwJMnfa3lqyNtxTd0IGMQdWe+EKq/0U036kDSvI3+2bB7MHMk42jm?=
 =?us-ascii?Q?fLI1fx63oWSTeI95cedQ8YdYcFlouOSA+BWMEcrbeuTm5LrKhcVja5Hsomc0?=
 =?us-ascii?Q?hJ2Ge8b/m3GJJvqbr6e1Qz8AoVgner8zPMaKajV59yPhCGzakabsimPtAtSW?=
 =?us-ascii?Q?le7mYKL2r3QunlxMz6P8rIOeLqGChqRZxfEYM7rbsA6svUF0RMWUlFSMWSkI?=
 =?us-ascii?Q?m8EuzPyaejYbphX8hf3iTo6Op4dKMgDVhUgmxofG5NUsbfNGf78zM6KffRHm?=
 =?us-ascii?Q?mFCPsiIUtgwYGN4smmZhE4LgkTtmsbiv17wJmuF61ksHHEUcAPKgO9mOany2?=
 =?us-ascii?Q?JZjz0ursbhfTyYX/uuGZIqaBQLC3Akyp34QDZhk1myb6qwG2XBXqeX5oRu/I?=
 =?us-ascii?Q?H0oAgWBRmGpQI1AkDD7H4LybCkXxFelf9gyrO6KqBrwi8PqIEIcWWmJA4v3m?=
 =?us-ascii?Q?sCb71GEVwaLAiBe0XcsWqk48qLbwjFioarhAsnk7lZ6ffm4gpCPVt3QlYRg6?=
 =?us-ascii?Q?hQ5JT5XG+KWwyCh9zIGRaAG0UgPgRS6YzgxRz3K9+C7yg5OW5dZmykEfAsLf?=
 =?us-ascii?Q?Gv92FUAYfxuZ9fyavmqH+e4eL8P/3CxkUcK2FG/tF/gFKey9jvDKLAFEXCcm?=
 =?us-ascii?Q?yEb1F4BKHXyv3pwkteMIMZJnv6p3yUEriiHTembTHvDBe/9TaXF4eqZYUO79?=
 =?us-ascii?Q?s3Sq0CyIUx2IW6NIuF9N2aOXrktR5/rvbbFANmb3Pc/CqZaWsHyDQi5q6ZRZ?=
 =?us-ascii?Q?dYBIykAJIMzke6v0Zycxnq2wt7oNRuvrAoJvmM0s4O22jhcHfRIj31E6lE3r?=
 =?us-ascii?Q?nvJf6f1fX41x3fODh98ta8bsLb2fGJhQ9EkhrcY2Po21ybzBLVS+EX/KGuOa?=
 =?us-ascii?Q?MJarkl1B6f2Rh4ajBeHdpQujdYnHDipWBiXPgymI7lZJBD1EDiWGFMjuPLRs?=
 =?us-ascii?Q?rCvWdNGunSLXwW9h6jeMCKFZare8yqsfBYidH/MKCCs8BcM1n3lmQqFZsGvw?=
 =?us-ascii?Q?VTQQUM1KI9k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?STdwKtApo/uwz2obynAEZejScZpSsfj4ztuyi39mP0mol2Vb5b53lj7kmFaW?=
 =?us-ascii?Q?pD3ClPu/DhUERXOjD624Xz2Xv5DHg6UrK6LDieSAbEoWwaWGcrPl71hPTs6G?=
 =?us-ascii?Q?sZA0A8SORodgG2WFEgAhzRSV12xv6KCQvm/ujSSk242/tpT1MHvVZSwVrKcC?=
 =?us-ascii?Q?lExFbA3Z3WnlgPURS9MLAonYAsQBqXOqhm1Vzw+004ELwQLAGAIskydL201M?=
 =?us-ascii?Q?/yj6wqADjEzj1jm6Z6LOMaZTwJX/MOVzsCVYZHiZc01HVwpj4IcL6BKSLqQE?=
 =?us-ascii?Q?ehdH8IDB/pmTY9CRhVB8VQRK6nVx9SmOtEpPcDNyqGfcxjOv9NTXHgS/3VC1?=
 =?us-ascii?Q?lMcV3SJi5CWnBLFc7JY6c1f5p4JlWYZzTu/kfHFPDMVDibZfkXhe+9K5N5dU?=
 =?us-ascii?Q?K27yphfh2QYjigfQ3tYFSEmDMi74m6I4I+efk4brxFG5YI6K7LTo5z9afOiy?=
 =?us-ascii?Q?kPxrVezG7OToC+V4WGLZm5yx4SNgXAgFCHs3PCLy5v5ijJG1k4ANaBSGVhxo?=
 =?us-ascii?Q?jk9HPSfSQykmUDbGE5siR46d9+cgHWlMk0vGkTIj1vsoB17cyw5T68eahjNp?=
 =?us-ascii?Q?9WdhrDhQOlSpS+sUs98Q+azd6mX0OWKVmDZliUr1DTau+dZDhExi0T6sTpwh?=
 =?us-ascii?Q?1XXvrAPckq89CsaBgmy0lCvJ4IXxZrz3yItmrJgxSJb4oiFK0IA/SNfXaQlR?=
 =?us-ascii?Q?YR0dm8xulVWg1aoNUKgh5C0I/1tMw2LM+wNm3WF1GROQqSgPyPJHol9rG1IB?=
 =?us-ascii?Q?4LHzBPUPzCsyvoo+47N5CNZwOakkGQkwwqC2jjF/PhO3M5wd5mPfhZVDrJVk?=
 =?us-ascii?Q?uUUvN3GrHcE16VxEUGm12de91tzvwdWLhgXjCmK+9nIQM7eyHyXSqNdQPSo6?=
 =?us-ascii?Q?v6K1zLMNQ0zvXdjy5PHWN2kizyH2XLrv3Z4FJQriflplrD15yrmE8oqcfWlA?=
 =?us-ascii?Q?tbbD3Y46Era9AsQ24x0WTXF60zFElOwxl3yJMbB5L/zx0SpKE9m576juyDFf?=
 =?us-ascii?Q?+plfYsD9WUd1WBQQbFallAfoUfquA9DlgbittsgPipYcffsR6ARUr+hWcXWV?=
 =?us-ascii?Q?LDd9Nkmhr85zocjNdfgf0mw1Zlg8Pl2jdLzFkflpTibYMsP67z8C3yZj0gYA?=
 =?us-ascii?Q?kEO+GwF2OWAepa+/xc9zRQH0vgE5i4SJWHy18JS0RdTYAXUSK7prxBLHXk0e?=
 =?us-ascii?Q?/JDPCaLDjykKKxOYH76U5tu4IVsQ/gdA9hgL5DSvW/L1OMFf/SnS4t/jhbtW?=
 =?us-ascii?Q?7yUcHCMAEmPjMXso13FkngigZQSTOKDmRa3aj3XqwBQ45Vqfs6yN/tvcmayI?=
 =?us-ascii?Q?y1iuh22dz9/Om9Kon/iuK60oL3kjqY2IOV7P+91VFAb/TaVLFVsY64Ng0QbM?=
 =?us-ascii?Q?n5DsLciKCes6ZOM1jnBcLjjA/CmkGQyzzEu0oZELvzi5zEzUPmRH8Gyevuxq?=
 =?us-ascii?Q?eQSWE6kW/j/t9VvskyHig8irS3l9ZIzntNl2e3ok6bLpz9tQmdFqi92CyE0o?=
 =?us-ascii?Q?59BA/KeLp6A0vtNIXicFZqHi4c+ilTKutHWWg3IrzyzQ7qaKGBISiMy5VzMq?=
 =?us-ascii?Q?t9qgAxRpxNCSrwy0qsHnROzaOByGw6o3IUv8VXkjrE4AWNYS9pRb6yRPw+tA?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d/b2SE5RmcQLpShTxwPpBJweu1TRqEeCDKOhhqPmLHDTy3JbfU7j3BEIzE0vT4haWFe3jbK5ktqqOJsKeGR8KEMqmO1RT82Z3O/7NDkp+QJEs+Prc9DscOwHw7c2n2j9FU7WO3G+2zD1cykV9vU8Z5g5LsS01TNNDgVq1it+9vg96VaNITwAjAJdXckHJc++Gqxrv7Hp81tsqmD0bfn9V377eU5ZXznaIrIk+odRFV1XyjCoWYYRw3NddhpWoOYHUzuCQiVLwZpX8jnkZAasXFj+JxbkjSRDGHgLykDSdn5d5ybg9z66Vt5jFX0F6u/7BlUIODmSM8WvhuR5zMWRkhIs2WYk79mKge3Ms+ANBh8n8NX1Q+LMk7eNb8Nq57N5SbyW9wLxMa3kP+MeuLnGuGRto/c5nHMea9XJVqbYkwOihNdyb6Be53a7QAyFbyjxVDxEAtQlnlcrcSty+fOXB3lmGvdsbeHXcbgBWSWotRxgb3/GA5ly86qmlxJxPEqDQIF9uI6vbPBfn5GbFFXc5nfdn/I0BnKyfNhcwIWz4vg+SWxgV5uAYMOPYk3KYbVL2XLrkaL9gH4ahwPqyLfC1lOLYXc2sq8zKkUp5oCVNZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1157e8-ae31-4029-9cf6-08dd88d1565d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:58:03.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mS45+YcDDJvTnqBaaOy3dhG+3XGbH59d/F8GD1OwyYqPq3VMmScZ4DhYn0gU7s29verBSJp+Tb6C8OB73+rxTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505010129
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=6813a83a b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=psqDkX_6r_7HCtZpQ-8A:9 cc=ntf awl=host:13129
X-Proofpoint-ORIG-GUID: or2wQRNuA492swQyf-uKubzuqFcATeZM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfX2V7CDYpptHzv Wxqr8Y+wVCA9luhS2QX5B0oQEjOPl1s1mI5slcXzwhZ6KdzoPSQeyNlHUNcizUmx0fzF42lGE1i z1Or9SzUb0+iNjuvTwGsm35AbjFjdj8ZUymWsYx0vmUssFOHnCFmEreAbAqivLyCwkiEGsb93/U
 Q9UVr1arbtrRHW5hmAhlHLBk2yo5vS/ARC2n8TOltEOfGeCZD9qqOfZCxFZypmzx0p44ckZDMBI YOhJ43LwpACRWu/OMRZ9YAkaZ4fjGJ/yC1Mxrva9Pvf0SrAWOwewsAF+qDGj+JvWcqzSj2UYrQC JVPAimaTTdIiKxI7Gb4aGKpvnFnkCFh+ccZKz0TB3fVKpsMO8XOic4fqXR8uRakP3g1PVphK9yl
 gWDjwxX6oAxxWohow6Zwt3XCVrhZ+uGugGHrJHDDvxNL8mofzR0rlOC42PlmSMC0QjDrgBvb
X-Proofpoint-GUID: or2wQRNuA492swQyf-uKubzuqFcATeZM

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Note that there is a limit on the amount of log intent items which can be
fit into a single transaction, but this is being ignored for now since
the count of items for a typical atomic write would be much less than is
typically supported. A typical atomic write would be expected to be 64KB
or less, which means only 16 possible extents unmaps, which is quite
small.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add tr_atomic_ioend]
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_log_rlimit.c |  4 +++
 fs/xfs/libxfs/xfs_trans_resv.c | 15 +++++++++
 fs/xfs/libxfs/xfs_trans_resv.h |  1 +
 fs/xfs/xfs_file.c              |  5 ++-
 fs/xfs/xfs_reflink.c           | 56 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h           |  2 ++
 6 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_log_rlimit.c b/fs/xfs/libxfs/xfs_log_rlimit.c
index d3bd6a86c8fe..34bba96d30ca 100644
--- a/fs/xfs/libxfs/xfs_log_rlimit.c
+++ b/fs/xfs/libxfs/xfs_log_rlimit.c
@@ -91,6 +91,7 @@ xfs_log_calc_trans_resv_for_minlogblocks(
 	 */
 	if (xfs_want_minlogsize_fixes(&mp->m_sb)) {
 		xfs_trans_resv_calc(mp, resv);
+		resv->tr_atomic_ioend = M_RES(mp)->tr_atomic_ioend;
 		return;
 	}
 
@@ -107,6 +108,9 @@ xfs_log_calc_trans_resv_for_minlogblocks(
 
 	xfs_trans_resv_calc(mp, resv);
 
+	/* Copy the dynamic transaction reservation types from the running fs */
+	resv->tr_atomic_ioend = M_RES(mp)->tr_atomic_ioend;
+
 	if (xfs_has_reflink(mp)) {
 		/*
 		 * In the early days of reflink, typical log operation counts
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 580d00ae2857..a841432abf83 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1284,6 +1284,15 @@ xfs_calc_namespace_reservations(
 	resp->tr_mkdir.tr_logflags |= XFS_TRANS_PERM_LOG_RES;
 }
 
+STATIC void
+xfs_calc_default_atomic_ioend_reservation(
+	struct xfs_mount	*mp,
+	struct xfs_trans_resv	*resp)
+{
+	/* Pick a default that will scale reasonably for the log size. */
+	resp->tr_atomic_ioend = resp->tr_itruncate;
+}
+
 void
 xfs_trans_resv_calc(
 	struct xfs_mount	*mp,
@@ -1378,4 +1387,10 @@ xfs_trans_resv_calc(
 	resp->tr_itruncate.tr_logcount += logcount_adj;
 	resp->tr_write.tr_logcount += logcount_adj;
 	resp->tr_qm_dqalloc.tr_logcount += logcount_adj;
+
+	/*
+	 * Now that we've finished computing the static reservations, we can
+	 * compute the dynamic reservation for atomic writes.
+	 */
+	xfs_calc_default_atomic_ioend_reservation(mp, resp);
 }
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index d9d0032cbbc5..670045d417a6 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -48,6 +48,7 @@ struct xfs_trans_resv {
 	struct xfs_trans_res	tr_qm_dqalloc;	/* allocate quota on disk */
 	struct xfs_trans_res	tr_sb;		/* modify superblock */
 	struct xfs_trans_res	tr_fsyncts;	/* update timestamps on fsync */
+	struct xfs_trans_res	tr_atomic_ioend; /* untorn write completion */
 };
 
 /* shorthand way of accessing reservation structure */
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e8acd6ca8f27..32883ec8ca2e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -576,7 +576,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f5d338916098..218dee76768b 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -984,6 +984,62 @@ xfs_reflink_end_cow(
 	return error;
 }
 
+/*
+ * Fully remap all of the file's data fork at once, which is the critical part
+ * in achieving atomic behaviour.
+ * The regular CoW end path does not use function as to keep the block
+ * reservation per transaction as low as possible.
+ */
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	end_fsb = XFS_B_TO_FSB(mp, offset + count);
+
+	/*
+	 * Each remapping operation could cause a btree split, so in the worst
+	 * case that's one for each block.
+	 */
+	resblks = (end_fsb - offset_fsb) *
+			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_atomic_ioend, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error) {
+		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
+				end_fsb);
+	}
+	if (error) {
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
  * metadata.  The ondisk metadata does not track which inode created the
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 379619f24247..412e9b6f2082 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -45,6 +45,8 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1


