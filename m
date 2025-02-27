Return-Path: <linux-fsdevel+bounces-42780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DACA48798
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F06B188597B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F330B1F583F;
	Thu, 27 Feb 2025 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V0bJ9lnc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZZOKo9Hx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E6927003F;
	Thu, 27 Feb 2025 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680185; cv=fail; b=bWmAWs7iO6/uCkJN9LXt9/s7b5posLcoKgi5VzYDuFBv1v8IPawYQB29MY9GScraiytc3d8ZmTJzDdKfdYCzqMm1UrBvgZOraBg4k0mbVe1FI7CTOXhd9+FkSOjax0p0YO2V2iitkQ54yr+DuYM+kHJ9OxrbBajX2eg65nqRRbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680185; c=relaxed/simple;
	bh=5h1WiVfMh5AdK2pVVXYb0nIlZ1jtFy5NbDsTruZUbPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=olkP+psBSrrAUn9LSzci1clBEr8H63k/bTp5eDoh7PVx9Lsa+PMzOgsAUhuvpgiGuTiS+FTRD/H36K31wlFPjBdKnTnCXlIvdSBTmmoN+lymcPx4hDuiw81NlZV4/VggNuAVuD295CJLgJaVeJdjYOg6gzInGk9+sDjGQ0tZW7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V0bJ9lnc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZZOKo9Hx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfkx7005600;
	Thu, 27 Feb 2025 18:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PMXRJdkS/Eozw4wIWvBmh+viAGrueKqy2FAqqUmxLoE=; b=
	V0bJ9lnc+07xYl0+rTH1mhShIIWoWCjqHs8SLh8UjDI7wXQkJx91FzvAbnyiGpld
	o0toe3m/pRUp2AjQC7zd9AUvGC0p0c/V6QXXCkUWxjDl8/G+aV4Ai2f3dIJWP/rt
	ht+pdXk+A4XLZ0yDgCdqC1Qi/SsdhBXJSeal24d0HiQaiv1f8rDmFJEZaRkBZQBy
	h02tSJvs0L93M3cve2xanb7tlpopgx0aPc9QKvU8entvDfpomirqWR3Sos9bhL/s
	cAFydoGRlIXsI5jKoaloanyFczhfzFDjYlx9aGOt87mPymrZj1VG4d6R5rbEFj82
	2VFftsG2se611fDVU8jhHQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf3yaj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:16:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHJ5Uc010036;
	Thu, 27 Feb 2025 18:08:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51c6sm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uL31lFjH9swEq6Wdg8JzzKiDLFiZeXDdPhIyAqru+tr6odyTDXQzn81xluG5+c/QM9ljlr8OaBBeN442i4m4u0WX4FJNTZP3Uln5JGM5UTP6NB59sOpkb07laws2rIT20yIowmBJwiwJ7+6+xSF+5StvkJ7nu3biR2SUFwJFALJ/8JofYklwTNWnE9zvIdHjvvvbeipT7nnTHl9jnNlq3OszLwcTJF5wyobfqeLZof+38z21P/6bs9/8eYjdDk51kVHoGeDc+7wtzNhyHSbb/c2Oz8mqJ0hGHpbaX+7efXeJv1lHk6mVDZo7W879z1kOUoDEWzto19lpSrkjQ39feA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMXRJdkS/Eozw4wIWvBmh+viAGrueKqy2FAqqUmxLoE=;
 b=u3+lLHiUiTQMJXLPDqV5Q2s/EmmO14ccub7+TBQFeuf+gVEIv7eRXPxTKQxQTRkZ6x7mSQoJKYXonYUSEr+G12JdWuKAWLpWGCJL27sP/6n/0TdyxbK+nhJLDqQmZsfhWl1++mAZQWe0XUDXoAM7m5uILWHZNSGxq+5hBJ4Ec+PEYYiDFvE9a6TeLKctQw4yVRK71qevHwTYbI41nQoDtJKq0l0QbjzGspWnS6FUd1hDec6hwpf1C+gNZGh5BkPgOjoXeZ6Hl4y3uerpgVQFLbWoFXgCU2riaeSlYm9LwVLZcvlHH/ZA5DNf1HQM+MZcokrWcMSCNltCrz01AJt35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMXRJdkS/Eozw4wIWvBmh+viAGrueKqy2FAqqUmxLoE=;
 b=ZZOKo9HxDPrtYsKgq9cQEhV6LGU36DaIYrq6s/54uXHDJUuwR9lAlU0y97feuWrudWeiLbg1enhN+wvXl2QZFCVp81tksoGC5FFX6cqiZp3yeYnx5BOFpI8amv3v5v8voGf7eeUapEwGvyDdJs7MFS2gGUWfRow+Qu8w1ct5nXE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:32 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 02/12] iomap: Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
Date: Thu, 27 Feb 2025 18:08:03 +0000
Message-Id: <20250227180813.1553404-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb06601-916e-4d80-205c-08dd5759beb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FYEd+q+0K1QCX1lLfbIgoH3xKqElZkZAC/aBfH/UJfg2t6YQPeSh9MuG3hJC?=
 =?us-ascii?Q?r8+ClRyk0VwGD0n4PmhNXWud2qO5VaMlj2lJ6l/7dwmDQ1zLV1nmCDXNpmzN?=
 =?us-ascii?Q?4V2VoKBxhpoStpZ8G1r0ymkAUx/z5u61dhNhMrnuxSpfrziaEeJpTTiY+7wW?=
 =?us-ascii?Q?O8iqeHs2JLB/bYnzEH32fupLgW/fJQZ8GqLNd7ozb7xG6rHCitk8vjzjy3xQ?=
 =?us-ascii?Q?Nnhsfqzq3nKyoJ4zWr0HWdNT4UGDscPOq1/WbeDJZ5RtQy/hGIxYKYXLDFCi?=
 =?us-ascii?Q?lxtavOVvoJt/CUxXLdZVC2jDks90avCQFbIZHUgF1fXMCdak6kpXwfjWDG8D?=
 =?us-ascii?Q?j6vFFbt9fkaRtQyJWHuiTzfu1WI/kUF2a3zmWB2RaX0hmIitWR1iewFTgCc8?=
 =?us-ascii?Q?M/Ls7uvN5YdxlyLVF0Q1gkSa23c213yskoHR6V3YR2E5Pmo/qO3nI4rKS9Gh?=
 =?us-ascii?Q?+zSZV+2fBTGSKnWiabVc71Gz9F49Y+mUHrHed9j0WxOFSwU3N098S1sIPuJk?=
 =?us-ascii?Q?w/oEFXI6WV88PZoknZRTZgfH1bacntomCn47lrYFjvHm1Kk3ZCjZIvCu82O3?=
 =?us-ascii?Q?WkGVa7V+74omETQ/BI8J6SqlAQms+MkfihusCmeREFq9D0sIQhU12W5N6fsZ?=
 =?us-ascii?Q?ap1W2mvhvfEVEV5CSpAY5Y4jEfXLmHjK1JEmPMWjM9KEP+MEMfrGauUWSr67?=
 =?us-ascii?Q?t4VdXJ2FNBKTcC8k4Nb4u66nRSJmmSA1T7CxiuCRymJql17DXaiJFlcBzPYK?=
 =?us-ascii?Q?yKM/Gjm1vZcLicSZr2zt+zQdomAkrH3eZB/IIUmjvBiqanRYZMLMi0Mnck4U?=
 =?us-ascii?Q?TC01D3y2ozGhxN3HaRGa9sz8c2fdrKsnq9E2tjDtSsyKtyvW1YyLJpaZfNLe?=
 =?us-ascii?Q?w0kvVyMbMzc7U4Mqy2IPUFb3y/EMr7JyuBLq5v0MtO5H1GStdVHNjzqQyxzQ?=
 =?us-ascii?Q?xyVzfr28oxSfBBWg7qcWbq8jlSd55FK390+K0Tr5FDZYzB2n0pRw4g5pINXX?=
 =?us-ascii?Q?uvBK2fRzZbCyQDxL3W3MUKhxkOg8f16JlHgvZ16T8hGF8Eg6DvufoF/wIqu7?=
 =?us-ascii?Q?kdh3x3LO/QRvZL0rFMLVqPvs+QWzVWHXxvQ8L7tqrOJw7hLT3DkRl6WbPJEi?=
 =?us-ascii?Q?r5Y7NG8x4+BTBB5W1mZm6bJFHD2JFZpROb4dzyggTP6JI0Ofu90GxxIKZUMm?=
 =?us-ascii?Q?U470vSeQjvBb2BBmbBVMX6Owi5AlTathfIIAAPivmWDclgLw9mfSvVU5FodD?=
 =?us-ascii?Q?PlEJjn4qU0ieaGylOFm7tUI7b3h/cy6N6cV/AOm6aDUCOcdKnpdKMXMkNYky?=
 =?us-ascii?Q?EozxPlqMDIqcUrdR+N1gL3Q2hngGAm1GvLMzVXeM7QZw/J1L7p+k8169lu69?=
 =?us-ascii?Q?Mc06irSnvAutZp+ahQXk/Itt4rC5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?01A7F1xxX8N7vO02IVALc1zf3BYprJxw/Ez5m4MWodPO6RBkL1a9QpDie0f/?=
 =?us-ascii?Q?1Um4OpKlqtg/QYVLOJD0UbkLZZqCYDRSxxFFzL3j0+44/LO4rZXIAQYkeQuF?=
 =?us-ascii?Q?213wxUPspGgTK/yk4mody1PGoL2/fVTN961d/KrogORF0eGnbCosts+Yc1BC?=
 =?us-ascii?Q?rUA1AuG+bE/QAM34Z4OvRsXY0Ubsrh+U0lKa7allyCkPHyDAI5A5CiQnKyn2?=
 =?us-ascii?Q?hp9dE8hDxXR+bSPB5sjJo11xfPHrAW4oYFiUIzrT05Vtw8pqCr0xZfj+cJQM?=
 =?us-ascii?Q?FgYMRVTyi8Jotd6R32q1Lz+7jdbnZhKZYivngxYyWtnXi3LVOKJiIzpEesMq?=
 =?us-ascii?Q?C5+ZOJUsb4Iqu1q70CjeNHITdnw0lNsAbX2/dv/z2TwMInGz2EuTTLE06FFB?=
 =?us-ascii?Q?1u5qQ8sHw4B2rOMlyUuA8AO6zNCsoj4YHxyHHmWvjmNcpLL29USrTMu5h+6k?=
 =?us-ascii?Q?5bBK6sA/7x5NytYvyyXMVnTMxUlTdjXLqNaPPbVktFLeiVi/XEcwXi4hH2dM?=
 =?us-ascii?Q?5VN9uDk8ujOZobRJ8SI9yO7MgpIlFjgkMUY/lsXorWA3pFLxKZkw7v51mL8L?=
 =?us-ascii?Q?WBwvT5jVvCSXjg7TZrv2325dU61iQjkrEEfPPqCEGZcFr/V72muQczobovlC?=
 =?us-ascii?Q?unAusxPH/PGp847Y8TM1id4GWqzPoIpxOMt34zIIHBxhuDWOlCOj8JcnL7jg?=
 =?us-ascii?Q?4H4PlmbboGjD9gbDS+N4sK6Rme+sqNTbqa2iqo/hwzdJXgWvZ0+hV1E/3i3E?=
 =?us-ascii?Q?+RWUEXctome7foSRrt19LiSZ12dWkmgMmidyNcU4UrzhYsIfljQ1lCVREgPY?=
 =?us-ascii?Q?9Cs/TLRSg5erNsg+TypH5DUsT8ewO+QBc/oZsd9FAWF5EK/+V8k2GES3nm0V?=
 =?us-ascii?Q?uxNTMGai+YTIB+01aK7cw8/8fmB2hNpi3G+xEzBY8gkl7D91RiMsH1Iol8Dy?=
 =?us-ascii?Q?46P1Yhdxwsa9w8GlXxRAaJj4AUrRif1Ne7Mvz+fcFExFbIMkIawPWlPP62o3?=
 =?us-ascii?Q?9GM7x4YhIS7pLcGRC3/Z8yT5nPXvufK16qNzaG/4ckoMmeUnnx7ytW2Rsnwp?=
 =?us-ascii?Q?/xo5Otst5JSe6f059DtvBtz6aTVYurxRqcI3cEdqfbm9AU43+7Rujj8mbHw6?=
 =?us-ascii?Q?byQOMqaX91nCm+2Hu/VcwMmL7WrnUhBETFWlqmugXni0FhrGkt7DJb7KeyGm?=
 =?us-ascii?Q?ozieGHD89U3r7XoFZMR08JzJAes2upC1JTiAmZp321JQybPVQG0tvAaKdQ+J?=
 =?us-ascii?Q?gbw1LngBdcucoRwhahAHE3YhVQRmpuqLL5A1z1D9P1AqsaWSOs941rUxYhDS?=
 =?us-ascii?Q?C4D4pvZoVitMzDMVDauW8SRyGkNSzGF0sZZKjw2Cbggy5hsCH1fIwD8ahpWV?=
 =?us-ascii?Q?Ms/dNeUomEJcPvBlZWdhACxjT4LtuGHuBide42/iiRy4gum/0zOzYUI80tzY?=
 =?us-ascii?Q?kH0ySRJMF0Ly5R/V+Xmy33ekUuchrrLFSYHRuEuMMDwyztXLjMNitCkO29L4?=
 =?us-ascii?Q?bSq8KadhQ4eEaAAajyUSX3SW5CymE3j3b6PGgsGOmKrkKAIvy0bDeNZcX5d6?=
 =?us-ascii?Q?cdD9zHCuowLGDS6cBa5Qjh7xPn6/i3o2+Ea4m8Lf0DgmJGd4qpyZtFnHHMOA?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XvNmG7U7nfyi7qx2gSh7rHUJfvKgZ7luRaJo2Cf0l0WFityMjVZoXSdBzv61dx/cADGmZYfxZz4Q8utOxRziQV0EsWfTJHp1BhYTNYWvPtb9k1gHX3xDWKOweyai2wYTvGpAIdMyUiIEeZMfT39imvaKKUAJ6AG4A8SG4/tNDVTePr2faIb3rkbcq0VQ6DpPa5LXwgcC2MkIMhCznOd81V402MoGW3zHWq8R8PO7SNhncYrjeN6vbxg3P7rNkzBgz2cyfvztdqJgMmskcWCOpTfpKf8yy/e3S912yUNNLTIJMuaN850M30PVI4WDrS5EzYWmQe6ywr8ZYWvOE9eu8bXOgqt3SQ9keR26+bv3H59UEFAglpttf0BeR3+uBkm47Hn+GSSo85dOy2Bfgm1fxtG+q12FiCaCRa/tQGVRe5vtCNci50nmij2cao0dLlOsn0CYjPt5FuAiqR/MSTm0dYTvP4zIqVi9n/BEpI/x85wcyFCLjmAWrHlrRrbZ+SiPDk4QDY02QSRLItDU2qkM6/BDuAnsixTJC0JZv/n/1WA10JrA8EDI5uQD1A2g4Y25vPzAUFD7MWiETtS1rEuyiIgcAQ8tvpAKP22el6I3Vaw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb06601-916e-4d80-205c-08dd5759beb1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:32.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qKZimb1ZFc9MDASvKSyWQOZzqYfSJIpPhmfiL+gXKe5vU3XaE2+3QQJs0LWrpNrC6zUO5fuWcDtNu01cM5FBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270134
X-Proofpoint-ORIG-GUID: PlTolD0MMtieqOOujTaTzQt48SQrinFu
X-Proofpoint-GUID: PlTolD0MMtieqOOujTaTzQt48SQrinFu

In future xfs will support a SW-based atomic write, so rename
IOMAP_ATOMIC -> IOMAP_ATOMIC_HW to be clear which mode is being used.

Also relocate setting of IOMAP_ATOMIC_HW to the write path in
__iomap_dio_rw(), to be clear that this flag is only relevant to writes.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/filesystems/iomap/operations.rst |  4 ++--
 fs/ext4/inode.c                                |  2 +-
 fs/iomap/direct-io.c                           | 18 +++++++++---------
 fs/iomap/trace.h                               |  2 +-
 include/linux/iomap.h                          |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 2c7f5df9d8b0..82bfe0e8c08e 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -513,8 +513,8 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    if the mapping is unwritten and the filesystem cannot handle zeroing
    the unaligned regions without exposing stale contents.
 
- * ``IOMAP_ATOMIC``: This write is being issued with torn-write
-   protection.
+ * ``IOMAP_ATOMIC_HW``: This write is being issued with torn-write
+   protection based on HW-offload support.
    Only a single bio can be created for the write, and the write must
    not be split into multiple I/O requests, i.e. flag REQ_ATOMIC must be
    set.
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5fcbd4..ba2f1e3db7c7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3467,7 +3467,7 @@ static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
 		return false;
 
 	/* atomic writes are all-or-nothing */
-	if (flags & IOMAP_ATOMIC)
+	if (flags & IOMAP_ATOMIC_HW)
 		return false;
 
 	/* can only try again if we wrote nothing */
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b521eb15759e..f87c4277e738 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua, bool atomic)
+		const struct iomap *iomap, bool use_fua, bool atomic_hw)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -283,7 +283,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
-	if (atomic)
+	if (atomic_hw)
 		opflags |= REQ_ATOMIC;
 
 	return opflags;
@@ -295,8 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
+	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
 	const loff_t length = iomap_length(iter);
-	bool atomic = iter->flags & IOMAP_ATOMIC;
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
@@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if (atomic && length != fs_block_size)
+	if (atomic_hw && length != fs_block_size)
 		return -EINVAL;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
@@ -383,7 +383,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 			goto out;
 	}
 
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -416,7 +416,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
-		if (WARN_ON_ONCE(atomic && n != length)) {
+		if (WARN_ON_ONCE(atomic_hw && n != length)) {
 			/*
 			 * This bio should have covered the complete length,
 			 * which it doesn't, so error. We may need to zero out
@@ -610,9 +610,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	if (iocb->ki_flags & IOCB_ATOMIC)
-		iomi.flags |= IOMAP_ATOMIC;
-
 	if (iov_iter_rw(iter) == READ) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
@@ -647,6 +644,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iomi.flags |= IOMAP_OVERWRITE_ONLY;
 		}
 
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			iomi.flags |= IOMAP_ATOMIC_HW;
+
 		/* for data sync or sync, we need sync completion processing */
 		if (iocb_is_dsync(iocb)) {
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 4118a42cdab0..0c73d91c0485 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -99,7 +99,7 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
 	{ IOMAP_NOWAIT,		"NOWAIT" }, \
-	{ IOMAP_ATOMIC,		"ATOMIC" }
+	{ IOMAP_ATOMIC_HW,	"ATOMIC_HW" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 75bf54e76f3b..e7aa05503763 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -182,7 +182,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
-#define IOMAP_ATOMIC		(1 << 9)
+#define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
 
 struct iomap_ops {
 	/*
-- 
2.31.1


