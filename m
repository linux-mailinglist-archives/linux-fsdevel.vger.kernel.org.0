Return-Path: <linux-fsdevel+bounces-43923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC55A5FD46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB42A19C3963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FB926B2C5;
	Thu, 13 Mar 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kKUbULgr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bPU07LUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A126A1C9;
	Thu, 13 Mar 2025 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886029; cv=fail; b=bLIcudxS66zIfNXUHHB/+Qg1NrX8ghGekCe5sTgyPKtfIuPbSffbF2cAvVN7Wvwys8bKPsFH0ZJAaFiD0r7/DS4/7dN90N04M6EvwbHS1Ax1AhKTlqt1Cj/2mkdYWJfqOBeVJoByTB9+Fm1RLDZFLtl11TP71+XDipt3aLjToSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886029; c=relaxed/simple;
	bh=Q7KykwLAEuLmYP2Up71J9UeWb6tqK9n6j4BVsDRVR/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4fKaHbvmOyzK/5Zs8QpVuevWHOOta47BCfIwZjjR8ZCLkAQzPs+bHuv5i2S5lkau0x2hshd8ySf+BARRtcCRt3DDEFWLj6U3MGGkEOYgNJcap+aRZPcGl+XqwRvVJlxlE8UwZlqhSRijlaUD2FzDtxnwq3ouLZpZ1GhVU50gX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kKUbULgr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bPU07LUh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtnvk013910;
	Thu, 13 Mar 2025 17:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OTQGt5M0E2ksDnv254NYw0B+QnOglruFPrPRM+BPiG0=; b=
	kKUbULgr8YHbJuZmd+KOA2MK7+PpHslNQnG+nXaxE8SQuqN3VkplupSk3RNZOZ91
	+I4IhhMCHqqojMc2nUL71c9KdWQTEeaxm/wnmHOL2dVGRviG5/h8v5yhQJ5aMYoH
	jSN/Igwgwj1suXpv0yecnkVef1kzlw3fSxVZeOKwyXpRE1SN9hvnwM90xc+7UJRx
	YQ46Ho0YLmeJj31hbt++7I3MgVjPJFhtCgTGtIcWKkT3PAKuYR6Cg5IKJlVbI1pA
	htq5Le720SndXrE68XxILltr5ESMVyZN+rRsL783f69mT382W+QNgvnG4GaoTIQR
	mSsLPh6mkbHmH7juPlmQIA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vmrch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DG50Lp019547;
	Thu, 13 Mar 2025 17:13:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn26mpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP6jt5NFPc+Dx8crPJZI3lxdn0ziJ5q8QFO1cEPknQtFh23p1USnK+aJ/5hdEXisVlJOdsWkF6IvT/PpMX/qy9byDIuYz7zg8xpUZRMbdqMial8iaizDKb8bGLWfzKykduRPUm7yfWl8LcM4WnEcBEEgfi5hyIA8ITrwjoC3lZVCJkHGRB7SXfRr+oYus4lwr7CtcTRAjxrb3MCX9x+5BvxvJh5/FnuasWFZ1ojALRpmiS54M697NVRz7baPJAnGdD4UGeUfUKFxRanCUhjp3bkOmVGr6FQhtHP2mWi3IS/I53zBWyd5I0PKv7owDILt3g4NwNxbMQBvc6ZlsVemKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTQGt5M0E2ksDnv254NYw0B+QnOglruFPrPRM+BPiG0=;
 b=EIE1zxE647nPZxiac4HNEX0gmtl1f3gG7w2q/XK2EZsIngt9RpjOfE2MsnO8Z6JuZcmjGk1me4f/urybnJ6jmpHjRYUAFV+bs3XPKWoKHbqyHOUjZk0X7vfdSW4oBOPvcBHEdLplowEPoSwXXfXR472j3mUeRlp1yo4cwx/ovI3hSCGYzo2FemdDqYyDm0tlhZ4eQ3200ZzwYQOTTDj7sYKyxV9gpG9VgLAXdA8ZvmU6+dff8H0W6p7OdNb1PI733Jqx8OGDJYkxMtjn825Xk3Kr4KF/mVqQK8XlcnWM4Jws9fj2T4Rh4lLe++B6oT8aT8mHWHWvSn7epIv/fSF3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTQGt5M0E2ksDnv254NYw0B+QnOglruFPrPRM+BPiG0=;
 b=bPU07LUhXGMIOudKUzwux6wScJtuaPmm5P5EsxSevsjpgbAe8sstPwog9byt4t5bvZuzIb4J2KHl3X7XHk5fbGtds0ZfQnDzkqfuBrdpBSAqqKjJn1QkQLOBewR7lRo4e5YMi5QtQmSHn0rUUAwJFp5ZCTUwOyU9E9+pnfSzUcY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:13:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:32 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 05/13] xfs: allow block allocator to take an alignment hint
Date: Thu, 13 Mar 2025 17:13:02 +0000
Message-Id: <20250313171310.1886394-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:408:ec::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: ad657acd-743d-463d-2ba0-08dd625261c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F7X2GvkbtSkIrQ88tqXmLiVVfiCkHWc8TnpORuDqmHDCE3o3UrkrxDVFAULf?=
 =?us-ascii?Q?0lxowl4QX3TU9QLiRsnCoyH+Oij50i/yjIXR4T63RExQqOoPDre7f4qvAUhC?=
 =?us-ascii?Q?gNsXd/G+hswsJyuThiTwGOQf40gHbhpEfNY9f+zpWkezcrH0aPTqcVanHIJL?=
 =?us-ascii?Q?hnkt8pJCafVfMTEieQMt9polZ+lQcOPEjmJDSdoXH81IOpdr3pFoZy62R2mp?=
 =?us-ascii?Q?okDzjiuWsuHuMAqYMX7wZ7tb9jJFYjL3QLY4Z5vOae5tZupT4fuhMldPZTyW?=
 =?us-ascii?Q?DxyJIEPGWYb8YG8A25OBcpE4fWeLgTfY5DQ++DUfeDsq8azf2p1uJjQY3EHq?=
 =?us-ascii?Q?50P1zPE1e+1bpgg5mUefyH+x0ST1Ak7vBgUZoHtf3bc8lmqU5DCEqUvv58Wf?=
 =?us-ascii?Q?+lXYpRvi+ju60nueNzCOw+CaL0EvDh9yWRNpJ9PfYdrZ81Z0mpS88cxHT58O?=
 =?us-ascii?Q?wOXxFvmzMT2/Ueud95v5h1kobUlch3aUNFnGIMIKZrZbHbxABNVxurX5phY2?=
 =?us-ascii?Q?AWJTHAuG8eiskdG60Ft14eJ4iTbfWnoCX6gdM4cGYjlS6mSu49FJLPZXXPFt?=
 =?us-ascii?Q?GcdN8leeVQyGfxfk1xYebuy7GItM/m9jwbqceRTcbYpEQmajWCswsmek97xB?=
 =?us-ascii?Q?YmcJreaAuxdYF+nKPTNkPEO1VPu0VMriEeA0ayMzac46/IbQhOGmJ/9D0+Ln?=
 =?us-ascii?Q?ON/YEa9X4KcdgE6ClskWIxNisNf05RTFN1uimjyCYZh998L2cQ8p+W/Ywn46?=
 =?us-ascii?Q?+G5A5xUyhUayBtlD9pA99Lta6auk3JrX7HOjagPGDPaY4GSV3LU68CP5hzKr?=
 =?us-ascii?Q?oCvkzcwVnq6q4RCF2kdyRu/qtYnpgX/GiU6d2bbR4VU3KTnIGpWi66PF7O83?=
 =?us-ascii?Q?kPE/IxK+FFbtFWy5Tp7/m9nZ5aHw5buJ8Loz9yJH1Wemeot9LtWZLkM2CWDS?=
 =?us-ascii?Q?JFnqVqK+gqTRZ1MmKr0MST3CNT/lnMz4b5w7UEGjylb6aARMaCkA9PTAQGEC?=
 =?us-ascii?Q?PBTeHxbyW9GeawfOVuLy2RFArQKElJVOgPChUQJzHH6yVwfieZggYIBNhgFP?=
 =?us-ascii?Q?jpoAGHHhrrZPBGfQNChPHOEVROhsjb97NV3uTB4I7aB/OwN9lp+YVN+TM68Y?=
 =?us-ascii?Q?SnIhpyG1ilMXUkYDJw7JPmiV3nnXOk6CPdkm1IOaozA2zS2GoPybx8/5RkY3?=
 =?us-ascii?Q?HTDaBau3m+oOeXmu8yYo4OCtM5otuuzVgqfsZJGpr1ZZw68eSTVwsi0vRQGk?=
 =?us-ascii?Q?LT5u2CLTQXQChNKXCqpEvHQiwY9ZcLky7FzNJvLbphJYhWAeanp5kEn2nnjY?=
 =?us-ascii?Q?S8gqT5pzmzRm03665w+yUGsJ48WQ5842GT3u91AHNk0qutueJk04IlxEeAFf?=
 =?us-ascii?Q?ITyw1pr2aoCBIUs5FRjCyAwpugkD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qq2hNZAkADA3KgPYbXR3uackGOsX6mmzp5w8urnr0dD4vDsvE7muealan9IA?=
 =?us-ascii?Q?pKS/Ujnq0qHHLwDKB9G4sRd597/QTzcsxiXh2QqpQsnoDa7dwK96+jLcLvJU?=
 =?us-ascii?Q?hWnzlMPf/5eZwGis/eb9Ae0iLROhV5G7pZV0yNgdIRCq26pDw5xetJMhTKJ/?=
 =?us-ascii?Q?ZGwhGVPEt5xOGoF3OGDe2iChBb1CNgehG1sXhezytw3+ukagF0Oj8ridF/gD?=
 =?us-ascii?Q?Z0SXdQx77P3rxkRHtmx8iYyPVAMGQxfcqBV8e5xURBag+NGehKspkxLbbMZL?=
 =?us-ascii?Q?GselCQoJjnrV4vlf0q6VamvLorcgtHZZixoh6oWEOKWeznJTXmSIQSn+cc/v?=
 =?us-ascii?Q?7wR2RXpQbWwD9OluFPJetu5YrZ8RWU8n5zTe+8977RGLlbBlHnePlZpjfXv/?=
 =?us-ascii?Q?9n49HNG/75gorvc1RDqiVn4DM9ZjS4NRlZUznQehMA1LP2OfgXI2sQ8ybE1D?=
 =?us-ascii?Q?n8pmisb4Gvgf8vZrnojvzJIbLMDakFuCB6hcr/39ST3e/fhvXcPrCT6uajTb?=
 =?us-ascii?Q?8Rq8jTKt+gkkVEr/RYoPbm0Bg/ib/8x0vd1frAqu5zrj2eVTNAhjly7oa1/u?=
 =?us-ascii?Q?TkDsaS6HfZ6GX1BmgOk0q+nS12zPUDSeL3tmxLfsr9o9IwZcf31nemybOFAB?=
 =?us-ascii?Q?TVFEtSSiWKnIeC1YB2xH3xgNCyqlw86GHUqlojNbbf7gXXKd/PtfgYmFC8eE?=
 =?us-ascii?Q?aMw8roLbVmrCTtsGEcY0aL9Omm52ePczRNclHJteb8YQIKQ1EqvlJPNRNUme?=
 =?us-ascii?Q?lmGqcxBp01x54lWz3sOr443t5s4Yq/J/iVmbshUpUGo5a2SXFLFFKoNhp5FV?=
 =?us-ascii?Q?kwbIfjbeD0hUTaQDKUW5PwAhLjEOiRAQYSnKkCfZOnoPCoyjEL/nHngUMG4c?=
 =?us-ascii?Q?WaOV6cYPU8EiOVUnibpaydVEVdaL9eXCUP5sfwR2pT7tdGeh14WhZ3w9HeWG?=
 =?us-ascii?Q?KYmG48z8lIWFO6/tfq0hA/xJlyFFAg3VS+Of2lVO1/XSN8levKOt3WyofRGv?=
 =?us-ascii?Q?zEBr7qaw4xFabteTE9WPOGeGQq5DRuTgaUXBe4coNZ5bR7Jo+692lkEGczjQ?=
 =?us-ascii?Q?PS6sWVy987XvYiXgCxb1FUh9PJmxDdAjrcu+C0WzUBgFZDt3M6HaGXV7j8pd?=
 =?us-ascii?Q?uDS24K1m3jWGEErtjNL89XqbXXsid5q43KC9t5CXdl4+hkFuP5+OyExX/85j?=
 =?us-ascii?Q?wxYzjMDcYMnCQumUVyCZIEXNcqlY6MXOxaAK7ASz18gRTQiWKUhK9FzWTwEF?=
 =?us-ascii?Q?eLmWw1CeSwSFhxjDqDCKyayK0Ts/rGibzMTXOzPiyJYER6vj9JKbqF2jcGCs?=
 =?us-ascii?Q?aXL7QAklSpKNp4B7hmyq+y3xlihWTc3jME+TOV00qZD21PL7IYx68wCeVqU6?=
 =?us-ascii?Q?ouQ0ASuFStoiZyqSgAdQpYzpjmx6EWzP9NrRwa2iiXJ8FpF+bMz7yPNq2orM?=
 =?us-ascii?Q?DtRRPsk08+On7LMwKULprs784ceokcmpKK99rCAdnu2IBsJX1+LsZTcyI4l0?=
 =?us-ascii?Q?e7t9xf3F+DYYI2+XR4O7lx4Ig00Kk/0HxyTFgNtPnzgce1Cdqe2h0m87YeE5?=
 =?us-ascii?Q?2u4ltUhcNacJEwVDP5IEcbyhSnDZpH2zTUJpm9b4fwTEOGUGP/qnrhdz1oc4?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lho6jQavFahc76YM5gp9vEhysJsfCKhT6FDRUh+z3JQv9W9AgxJy7bBs+iVPlBHW8W3y/vZ82OQPq17eZ+1MW5XH9q5F9Akrrnr0KMV2g5IYopGuFdYZ/WFDAM/SJwegT0SJ5ZiHWfCLkEMvh3s5pQfmHOCzUBPEMKdHMmyU91VoD/oiCaUlYA6tBuVBYTc5LPye2AtF+OHQSlCRTHNleR+BTARqLUwZXhbIoSNls0Eh4YjURXPT5s1sBqfnJAzAXrvJFBlvTOa0bRGTBM1ifEHBSjCUvDXazIItzWUvJwaJBlkMeXUiG9aYLV8o1SQiRb9F5TPnfdwuYrCm7Qkz6289ssyB6wgxhWFysj8Zb8IXBxr7CSbDbltaQTaUtQ7XWkFjEi/Z/l7yc1Alvrj6QArBoXpzeG3dRcodNnOrC6iIqQkHEFTNhUM0xRMnqYvQfzCfMok6uO40HcKhEvE0ME64pUv2tdW/TJ16MveK40+UsjzLfWXI2CejZEXM2CyqO/lOLd79A1Uh1pgl1Re985vfvHI5Hxv6WavvoUiK51gida9LEw/kjIj6Ok6aLM9U4AyMn1Vy1Kab3OlZz+0ueuEy0feX3vklh/KJCpxA71o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad657acd-743d-463d-2ba0-08dd625261c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:32.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zztAHlaVYklpEbFk1NoPgcL46jIJ/pF7uRzEBjRenLWLMk5nE6bnGnD1B6xVjnzUFRXXFsUbaGtGDkBD9sC2kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130131
X-Proofpoint-GUID: 3-s_hjoLShe1qtnuT-_5EdNOfgte2IIY
X-Proofpoint-ORIG-GUID: 3-s_hjoLShe1qtnuT-_5EdNOfgte2IIY

Add a BMAPI flag to provide a hint to the block allocator to align extents
according to the extszhint.

This will be useful for atomic writes to ensure that we are not being
allocated extents which are not suitable (for atomic writes).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 5 +++++
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 63255820b58a..d954f9b8071f 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3312,6 +3312,11 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	/* Try to align start block to any minimum allocation alignment */
+	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
+		args->alignment = align;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index b4d9c6e0f3f9..d5f2729305fa 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to align allocations to the extent size hint */
+#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.31.1


