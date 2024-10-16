Return-Path: <linux-fsdevel+bounces-32099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA19A0702
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C8F1C21759
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B412076CD;
	Wed, 16 Oct 2024 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MysW88e+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ufN+7XIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D665F207209;
	Wed, 16 Oct 2024 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074069; cv=fail; b=t6P6Dzd7x/LIYllRnIc8kYA67XOT6tG+aqynmXZL8ukGqZaG5J1azeXZ0ieHEQF27vRR8kRYCebO7A36EBxkh5mjXGPGxrmlEZQ+c1JbsP7PJOaED5OasHb0HiyfUdm94yG/bHesXecxItZEs0KZdMCoDEMcHZKZ6fgFE2d4FgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074069; c=relaxed/simple;
	bh=GPlOhKIanY5W96v7RGBGpX8RJziFA1dUbaLUGsBPIm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZoC9/rKvvNHTdNpZFUqeqiU8t8UfDJtozNQgEeeUpogpAyHoB45ZreQbIQmMH9UNTH7UkOFrWSf0KEF7LxeWaJJVOwXhhIY7zeanHlTWdNre7vvp6jXKp0aDCy5a+b8jnwEIt6Ll3stP/80h15zvu1dIx8wGf0RcoQ/AKdOD+V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MysW88e+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ufN+7XIc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9tbo1012919;
	Wed, 16 Oct 2024 10:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8nWoDMl5VOvjzc4SgroRs1FM4zRRVAwaOsTS/I20V4M=; b=
	MysW88e+HNI+h6lG219aPoawrP4ud9/NiRLhCqSmqoGhWBAgViBdD1g09bSYCG8V
	N9hdIs6eRGGyBg78umVTUjGt/QucaK7Ge85VHqmGP2K53gtPp9Z3FZBqmUy39AvD
	+lXjmff1AcM9260Y4JVnN1z0zGEekSW9IrgzcnhV3z1ZPI226TSTtthoDQBbfazG
	hXghnVLfdy0wymXfTmzHiGqa7DC3RhnpTjCBGBUj2otoM+9vUNOJTLdbLx/3Gu5G
	IpzIo+s1JQ/cn41qBHX+EFsRf+AHjcQZ4ug/lgTZx/A2Yez00jgK1z+Mwi5vJijH
	Oqffg+p0mHsIikb6N2J2eg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2kg7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:20:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8w0Zh026232;
	Wed, 16 Oct 2024 10:20:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8n3k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:20:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvWVO2XSdGhB9JY1xd7yX6Wf+ix1sVKJc+seT+BtTpn2ggRn2GId9FgOunB9y7USg0CQX84876iebEMFtYjnio2y+vZPUTa1qGGvzd6kXQtY/Ei2H6GrYz5jt2o/FFnri751kZVo7cWtxlKo90c/6i6DpYD8QiQPu7v3xdSBw3B8U5CinS0btIB4xnI2kBc8Nmw9ffO/4prxIgyn/n1NLykbFExfzYY/NS8Rp5/NlXTlRwx4Ts6yC+3vrhz1VEqjyF5o7UH940+b0YhJsJwVcN47fkRX8o9Xi3eJs8xLRZfkhpC7nWZqZxd9bgN2mL3EIQvolSuGPMtuWR1hWm5qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nWoDMl5VOvjzc4SgroRs1FM4zRRVAwaOsTS/I20V4M=;
 b=nsUGb8+ubeYpuitSjliwc4VmOH40V3wGpGxf2qn/gTRyyjwBqEInU/ygf/mwoUMcWOrVA6DA8iZO/boQmbFm+R/Xi62f9ieBMnanrNEsiAr4E7TKzdywJEpqpQvYfnBtYHpuq0rkV0Bm0WbPOkEjsscgexLjhNSy31Ts50Fto/c2hDxMZ9xrSrr4TNyFnI/NYGODfxh8RnNXs2CvrrF4LepiW36cTfgl3Sk4QM/gxLD5x1Tl4AGIHZlXO+LiHSpYG52sgDXMaxK8a3j//lZI0tGCtquNZRo1dD928imGP7Q8rrxPUkC9/eqJpNj69BXk/lBJpKZRaYAAeYS98vuDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nWoDMl5VOvjzc4SgroRs1FM4zRRVAwaOsTS/I20V4M=;
 b=ufN+7XIcYMaIFn/s+HRG6pZxOVu+Fz35mxo0oXNJyOQrhdF0fGf+Y5C+pjoiaYBBNDY7wCBHjng3eOAZbWpw1IIOKPLU3XNjR2QXMFJlfg71fV/PtR+mwEYflhXZiJH3HsZjUpHRXTwtxWKoKvVlDA7g2v2DWui2KPl3EFx0h6s=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 10:20:49 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:20:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 2/3] pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
Date: Wed, 16 Oct 2024 11:20:38 +0100
Message-ID: <92f2d057b2861b837f37fae31ccb1d64712539ef.1729073310.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0485.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: db10af17-3078-4c5e-d758-08dcedcc34ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1LZeJ3GXQ7nTjt6PnuyCuOlsb+x1l+yLFkgX8kpPjAbH+wwG7Xp/8UC+1YYC?=
 =?us-ascii?Q?mxWHOYeDj6XLSujuhRhFHvF+PTgc5Jxky8ACOB0fCdvP2s22woDaUVsTR5ji?=
 =?us-ascii?Q?BLhbCeX+b9bo83qPGtQi0KS7E4QSHZwT5Y2h780MHNf07I0WPRLaczjT54MH?=
 =?us-ascii?Q?Vf7V3GmgOWu4CtgJlsEIc/Wy4jec8MjHQVbNtlPO2X4GF24xRjEqPyrbLEyT?=
 =?us-ascii?Q?bMqTAT+6w4DEHGAE7VIQGZAZVHHx+vxp2yJSijxj3I9Rp2zEL5qhy5+3wokH?=
 =?us-ascii?Q?2u/gceerqizb4LFahZJqSHN9jUcGwzs1C+cn21yU5lZDRFqinzt6burrIE3d?=
 =?us-ascii?Q?Ou1gAmQk8bY1y9/PDCaJKpsuD6fX2R2chtxeIEzAI5BZR8dfmcKlk/B4iIlk?=
 =?us-ascii?Q?DpAZIiOFPGyc0oOIVmnaiFMPAN37+KwDUnRGWd9imaGR6I4Ke8wHMg4uTvKv?=
 =?us-ascii?Q?/Gn2ymU/jNOJhrQ9GkOOFBQtUizPznBKCgk8TWSdiBiAJ3ZWyxufYd72mjnq?=
 =?us-ascii?Q?meYUzshijViQ5cay1R45rWf0suaY/b3yZv65RZPYWr6cmj80FL1TCpetg9PT?=
 =?us-ascii?Q?4/iLptQ2O8DMpRatDsdq2hejc1c/Itw85anrl9Skfz4Lq6dRWkJt53Co/YSq?=
 =?us-ascii?Q?qQioe9EzRfGy1rOmkVrYcPEkxuLthLqeqz/aUd1O7mpSFMxcnHEl725X1wak?=
 =?us-ascii?Q?BEReOxAmTllpqptJgUqKDYW1zFdmpQkKq38XiOJypKIZ4El2aPnW0ZaNEpKw?=
 =?us-ascii?Q?bJ83uINjQcFU5sco0yNIZnbH3QtYYFouBkJ4TAfr6FAg96nFZwuaEIlEFLNh?=
 =?us-ascii?Q?PMVzibMcWurtGGek4CsgfE/3F5KrGOlzVrRpJdB1DF3fiByVtpEAIV6ORxg8?=
 =?us-ascii?Q?vvpdM+wuc1pc01+Nc6PmWqrLI2SxGBqYDfnxy0zqT79G5nEafip5A9b2WqBt?=
 =?us-ascii?Q?bYT6TkM2BlnbomQYBZh0WZffHbL3NCqr5+p2eo3x2ZkGQM/vuUGfQxLcr5wG?=
 =?us-ascii?Q?aRBF80HQaiGIlkorSPiClRqAlT3bFosb3UknubvJJj5xI3ByvsX56PnvSWX0?=
 =?us-ascii?Q?OWeTrWbiGBdAEYHPdjoEO78c7kTaSZw4U4ICrHaoC0hglhQNvJDK1vehQGap?=
 =?us-ascii?Q?Nc9M/OrBM0HsLLkydBRoYRY8cbO+QjGmE9gUlaFMVcQfYhYjcr6ElbuPJJwM?=
 =?us-ascii?Q?yINx67BxK6/6WYrzhTZO3jgT9j3itXdbzeYqeaDpFr39L0EnQU7zNAb8iVOZ?=
 =?us-ascii?Q?an8jYx8evdVlSW1yMZhZKB8BRDACqwLW4ASOpb83sQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EyRGdDa9RdSc4LJvWDmoA36aRU7S1sWVlrYm85z6Yw+P++oOPAERsNJskEei?=
 =?us-ascii?Q?oWZHb9n4lls9oS5zmsMQOi4OCCLL+arnvAPHPMXVvGWZ0aglgNtPp4Ny4Fu5?=
 =?us-ascii?Q?vavvXPEiy5zh0BAuNv19aJq5kHtdUQ78xOE0hrso509OVjtu36dKdzRdKVnZ?=
 =?us-ascii?Q?cQZ7dNt6ge5gZEX1ri8Zxp/xo2J1leT6frT7zg918lN919Z2rALAzAtaq3NA?=
 =?us-ascii?Q?7j4tkpJcdv2CnngAfCfXDfLHY2kYD0CihbCJbKzP/ooPKVQM2Ixd6B+XH7dn?=
 =?us-ascii?Q?wnuFqhSnZzRHKmoZEpa3EBze7/0nc/1buhUKzfY2I+Yjk4/XMA9f0TApez8U?=
 =?us-ascii?Q?+0aHnTSbXuSnNr7rydt1mLo2A2m4q9WjIurtgszq2r2TgDGyfpZgydvEkpbw?=
 =?us-ascii?Q?6aRgnBBBZymWKCd0FGB/v95vw2LOARGjGFft32kCJ0PEn8RV6H0lOAiBvsHw?=
 =?us-ascii?Q?RmPd5zCywOuAqAFZ1P8MtDP6e8hpTsmNn6DEfMk19ijkdDBAH/rynz77Rg8F?=
 =?us-ascii?Q?BYoeXufrDBSy0C5ilxxKMVyA7U9y3S3BTjYwkWd5bexnF1RkPymab2umLPX7?=
 =?us-ascii?Q?wCEjK+tT4a8I57btIyaqtsFAy6z9CuhAv6Wz0euaauejV3n3h619BeaO1gO+?=
 =?us-ascii?Q?7/P2kGxuKodudi+IeoO39h8S1cWJK5nrGuXYgKxkGOswM6rwN5nDhckWHp5o?=
 =?us-ascii?Q?SiY2fVRENqCmpqCb1w1gN3xokNS1rdDO3pM4g4Cbhu4XFXPGoxjBa680TU4S?=
 =?us-ascii?Q?LqEi15uvgU34o9tWjaftj3dcLOu1YtxIzuyb/FAL3LPMFzcowzqPah92kRs1?=
 =?us-ascii?Q?a8LGNvCCET6KLv+BnwWyTgWm6fBXg9hy6UNuCiWmFDk33NFNRgV4k2VwSERt?=
 =?us-ascii?Q?SJM7QG6Hpo1IPHKmL/QMRnQsmvDncJzV/juskZqkBzLlDXgaAJfDZr2ilJSm?=
 =?us-ascii?Q?nlyu3pExQ96nCwfMr0GffPmDnz3kpdHeGqenQlJEX68WMdk2Eds8iPBSr3QH?=
 =?us-ascii?Q?jE/nYM4rFD5ngMjag0Gm3f0Vu6WkWIQNJCt+VrK5F/Lz2eHn/mWkBOrpM3aA?=
 =?us-ascii?Q?GJ+TITPgSpBuddjSES48Yvv+sJEDSAJGDjFC86DNAb6nt9HqoxnPR+6UkIli?=
 =?us-ascii?Q?rJCH/+qi+DKTJqcMchwc+9U5w1RAX9goixvhkR5OQnqI+uY+mvT/mrpj0hpI?=
 =?us-ascii?Q?vIuAll0LDhbNteJSFlw9Kw1cOwduIacNWcW5vz5uB4lpqnvLuwrA7At4akrM?=
 =?us-ascii?Q?CGUJsw9wSalQoTGFdALo0jvmxKujE9J7RQ5b3Nt0XedG52q+RQzSBHZ0aiAX?=
 =?us-ascii?Q?OAR4vFSuilZe321Ab8hClmGMdmlz0LmBE6GsQJ4z/wfcmTs5G+zqM3v+axN+?=
 =?us-ascii?Q?ZUEFh5pkRoE1luzu55enSVxivCm4JmHZyRAFAcofR1ZCuJi/11l5NI4YN2mH?=
 =?us-ascii?Q?IoN8+GzzcI6L+XFlT71X3vJmr2Hfmwxl+iMrtyPiOlZJN4lIZgb3DXiWElLZ?=
 =?us-ascii?Q?5pOI6gfc7+w/Tj2ntp9ErtGysYPC9BnpcOgIDkgzczYxJk3N1JbswVqjzKju?=
 =?us-ascii?Q?OZHH+shlwxqQecAksZJ8EYKsT3aOS7RryrpClqFj+6atSeR8BYrLisFe0CuS?=
 =?us-ascii?Q?Zw+32IucMzmXaIY89/vmojknGPVtDzLqyuLmDwItlwrQAxbHRe5wFjfCEbUg?=
 =?us-ascii?Q?FJpbhw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NFW9RW06UW2breua/BD1wNbj7b7yaRdUf+5ge/Fc3Eq3pTMaWZvdAMwZEQMDESBG/y+FK+tdUoNwpDAFFudmmK2JgMiMjlJFvoaxuuAqlwvY0c3ytSoPrUhKXGP5ZUXFXKkBLcF0OTHWcjnOB5j1/DRF1KCbweVL6oKTLnAB5MICu++BbP2n567Kt3jbFbUJKjrEgC+CzE4wb5lEORva7z6WQj+R92RjmrLdPprKWYMYpOkA2+iSAzXpnmhT1hxaLylI+btGYZIWpp+qAIpadcJv42b8VvmGEkPFm9FmTY+O2snh48ccGQTUINGYYn0dYOmUjLM6UwHqq2j5SbhC7iIfF0u8ptxr4gXLyy8TLXVQf0Aw1vSEFy9Mu9WGzdiuNNBee2r86OV9lS7A5YMNhqioehXEsA3nO3Jat+NesmInndf3jsx1JUp6w0oWO1+yphx+FJxOmH+Q+YZShW1l28h+p5ASJ5GCNWXzbtbI5BpI33e/BD1MfDHG77QUUe8b2UmRgfj47NyZvjld+5zlWr1MheL1q0oFIeIHCXMgUVVeXRK7XvF84SsaHgkB/AqMQPv4Vy4L20Tz6NeKVU3TD5jcEwIy+ZaNpxVAA5ICDJQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db10af17-3078-4c5e-d758-08dcedcc34ad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:20:49.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGsuK6CknPrB13Hb9yLo2clemJsGU8Bni8w69SsK/wQpCm2BT7Se3A6glzbzAe+0cBGZLDFIfUgBiMABLIkjv6Ia7/uT1gArdC/TM/TzH64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_08,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160064
X-Proofpoint-GUID: trbmcBb_Qmwwh1SdZsMn3avQT4-amXZx
X-Proofpoint-ORIG-GUID: trbmcBb_Qmwwh1SdZsMn3avQT4-amXZx

It is useful to be able to utilise pidfd mechanisms to reference the
current thread or process (from a userland point of view - thread group
leader from the kernel's point of view).

Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.

For convenience and to avoid confusion from userland's perspective we alias
these:

* PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
  the user will want to use, as they would find it surprising if for
  instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
  and that failed.

* PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
  have no concept of thread groups or what a thread group leader is, and
  from userland's perspective and nomenclature this is what userland
  considers to be a process.

Due to the refactoring of the central __pidfd_get_pid() function we can
implement this functionality centrally, providing the use of this sentinel
in most functionality which utilises pidfd's.

We need to explicitly adjust kernel_waitid_prepare() to permit this (though
it wouldn't really make sense to use this there, we provide the ability for
consistency).

We explicitly disallow use of this in setns(), which would otherwise have
required explicit custom handling, as it doesn't make sense to set the
current calling thread to join the namespace of itself.

As the callers of pidfd_get_pid() expect an increased reference count on
the pid we do so in the self case, reducing churn and avoiding any breakage
from existing logic which decrements this reference count.

In the pidfd_send_signal() system call, we can continue to fdput() the
struct fd output by pidfs_to_pid_proc() even if PIDFD_SELF_* is specified,
as this will be empty and the invocation will be a no-op.

This change implicitly provides PIDFD_SELF_* support in the waitid(P_PIDFS,
...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
pidfd_getfd() system calls.

Things such as polling a pidfs and general fd operations are not supported,
this strictly provides the sentinel for APIs which explicitly accept a
pidfd.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h        |  9 +++---
 include/uapi/linux/pidfd.h | 15 +++++++++
 kernel/exit.c              |  3 +-
 kernel/nsproxy.c           |  1 +
 kernel/pid.c               | 65 +++++++++++++++++++++++---------------
 5 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 68b02eab7509..7c9ed1b5d16f 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -77,18 +77,19 @@ struct file;
 /**
  * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
  *
- * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
- *              @alloc_proc is also set.
+ * @pidfd:      The pidfd whose pid we want, the fd of a /proc/<pid> file if
+ *              @alloc_proc is also set, or PIDFD_SELF_* to refer to the current
+ *              thread or thread group leader.
  * @pin_pid:    If set, then the reference counter of the returned pid is
  *              incremented. If not set, then @fd should be provided to pin the
  *              pidfd.
  * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
  *              of a pidfd, and this will be used to determine the pid.
  * @flags:      Output variable, if non-NULL, then the file->f_flags of the
- *              pidfd will be set here.
+ *              pidfd will be set here. If PIDFD_SELF_* set, this is zero.
  * @fd:         Output variable, if non-NULL, then the pidfd reference will
  *              remain elevated and the caller will need to decrement it
- *              themselves.
+ *              themselves. If PIDFD_SELF_* set, this is empty.
  *
  * Returns: If successful, the pid associated with the pidfd, otherwise an
  *          error.
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 565fc0629fff..f4db20d76f4b 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -29,4 +29,19 @@
 #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
 
+/*
+ * Special sentinel values which can be used to refer to the current thread or
+ * thread group leader (which from a userland perspective is the process).
+ */
+#define PIDFD_SELF		PIDFD_SELF_THREAD
+#define PIDFD_SELF_PROCESS	PIDFD_SELF_THREAD_GROUP
+
+#define PIDFD_SELF_THREAD	-100 /* Current thread. */
+#define PIDFD_SELF_THREAD_GROUP	-200 /* Current thread group leader. */
+
+static inline bool pidfd_is_self_sentinel(pid_t pid)
+{
+	return pid == PIDFD_SELF_THREAD || pid == PIDFD_SELF_THREAD_GROUP;
+}
+
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 619f0014c33b..3eb20f8252ee 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -71,6 +71,7 @@
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
 
+#include <uapi/linux/pidfd.h>
 #include <uapi/linux/wait.h>
 
 #include <asm/unistd.h>
@@ -1739,7 +1740,7 @@ int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
 		break;
 	case P_PIDFD:
 		type = PIDTYPE_PID;
-		if (upid < 0)
+		if (upid < 0 && !pidfd_is_self_sentinel(upid))
 			return -EINVAL;
 
 		pid = pidfd_get_pid(upid, &f_flags);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index dc952c3b05af..d239f7eeaa1f 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -550,6 +550,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	struct nsset nsset = {};
 	int err = 0;
 
+	/* If fd is PIDFD_SELF_*, implicitly fail here, as invalid. */
 	if (!fd_file(f))
 		return -EBADF;
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 25cc1c36a1b1..0f8943ecc471 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -539,22 +539,31 @@ struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
 			    bool allow_proc, unsigned int *flags,
 			    struct fd *fd)
 {
-	struct file *file;
+	struct file *file = NULL;
 	struct pid *pid;
-	struct fd f = fdget(pidfd);
-
-	file = fd_file(f);
-	if (!file)
-		return ERR_PTR(-EBADF);
-
-	pid = pidfd_pid(file);
-	/* If we allow opening a pidfd via /proc/<pid>, do so. */
-	if (IS_ERR(pid) && allow_proc)
-		pid = tgid_pidfd_to_pid(file);
-
-	if (IS_ERR(pid)) {
-		fdput(f);
-		return pid;
+	unsigned int f_flags = 0;
+	struct fd f = {};
+
+	if (pidfd == PIDFD_SELF_THREAD) {
+		pid = *task_pid_ptr(current, PIDTYPE_PID);
+		f_flags = PIDFD_THREAD;
+	} else if (pidfd == PIDFD_SELF_THREAD_GROUP) {
+		pid = *task_pid_ptr(current, PIDTYPE_TGID);
+	} else {
+		f = fdget(pidfd);
+		file = fd_file(f);
+		if (!file)
+			return ERR_PTR(-EBADF);
+
+		pid = pidfd_pid(file);
+		/* If we allow opening a pidfd via /proc/<pid>, do so. */
+		if (IS_ERR(pid) && allow_proc)
+			pid = tgid_pidfd_to_pid(file);
+
+		if (IS_ERR(pid)) {
+			fdput(f);
+			return pid;
+		}
 	}
 
 	if (pin_pid)
@@ -562,18 +571,22 @@ struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
 	else
 		WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd around? */
 
-	if (flags)
-		*flags = file->f_flags;
+	if (file) {
+		f_flags = file->f_flags;
 
-	/*
-	 * If the user provides an fd output then it will handle decrementing
-	 * its reference counter.
-	 */
-	if (fd)
-		*fd = f;
-	else
-		/* Otherwise we release it. */
-		fdput(f);
+		/*
+		 * If the user provides an fd output then it will handle decrementing
+		 * its reference counter.
+		 */
+		if (fd)
+			*fd = f;
+		else
+			/* Otherwise we release it. */
+			fdput(f);
+	}
+
+	if (flags)
+		*flags = f_flags;
 
 	return pid;
 }
-- 
2.46.2


