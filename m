Return-Path: <linux-fsdevel+bounces-25800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFD8950A56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC621F241A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDCB1A4F19;
	Tue, 13 Aug 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z9+9X0d3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wl8l/jWG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3891A4F02;
	Tue, 13 Aug 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567036; cv=fail; b=kurXv9GEfzXq8DXBSTMigIFJkSMse23ynKyVJu3iEuDuOJCSmsUWKQF8HHepFrlaJMrzkd7GIQJ5ueEDViozhh5pQ3PgZ4zWb8drIHD4GUuOz9mntJJl0rTn2OCxQOwoJ6qwS5nPRTEe75hGLE2eXmDeCpOKMBFQrMQnjpYzTWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567036; c=relaxed/simple;
	bh=deJFZJmQeTeQtt5bIB7R/BwktTAKm9MF1pqj4PFteDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jAwvVgYu7V5WFG9K97SEG1CuyfXH1m66HmIlZl2FXtAW9KVhoe47uObXYA2BzuxY5tCVvJ3BLW8mhBqCFXirPLRAwa5WWV00MhZkEWDSzU57oQPbdqb968dpXau3cGlKnAmDdb33i15W1i30CToLUbvGSPnxWNbGHHtjdvddWVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z9+9X0d3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wl8l/jWG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBTwA009743;
	Tue, 13 Aug 2024 16:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=HZ2MJ034kz/+yCHz77EDP8UVitUjCKn41Y0vvkTtB2s=; b=
	Z9+9X0d3CsMyw5A9sxHVtLPQfBOELSeIk7DZmOZcm4ZU1KGT7dQFRddyXWTSu8ss
	9tw85W61r/bisIUziyP9koh8tYc1HTjKjtEetKduDMVjB4pz8A+TWP2C3w6PzcR9
	fpw6JJ43h3Fm+JkNOZSWUPUYoeHxCHNSJSP2UASMdsvLrLHt1pjcRDoNHisYTA96
	/urzz4t7rYAfn1E5Jnux2Y3WSfQ87nnnaYRrCP0EORE+HJ647UibMbnpylHmJMq0
	0l0I7VRWQUUfqFbX+zcx+vg3gqxNtIteIamiFHX+TzpH2HncnggrJMWFH4kFQVOA
	1vjvRP5VgvXaLmrVg5P6HQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy02xg0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DGBTrc010640;
	Tue, 13 Aug 2024 16:37:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8s053-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHQgFHGH4rpLlQwNyDPCXiJne9WtfhKtQ9eK2t59k5o7VaxqbaO7pqYQ3jOkbfkj0YC1leK0Wt0Q5mZc3hRiLEXih4RZ+X2xlHmJLMw3GKM2V1YaGTmr61cFBzyuubbB1Bc3lullRlnxSOU3MUHlnXzoqzBVqnNKb/EyvfV6lAwBTS4H719Hkchr9a7mXjyyBEEtwpJSMtnoe+80lIYL3D/eYBAJH83xOOiFet+m53UHBlnefE6+BcWYghAgdEr/DoVtez1vwaNK4ld1gScXExFqxY6sjOS9mHuKzTYZoMMFdnoUMqE02z+lEEBJ8cj5/kCbeaaEXrGM3rQLl3+MHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ2MJ034kz/+yCHz77EDP8UVitUjCKn41Y0vvkTtB2s=;
 b=DJiqLFK/esoQuTwZaY/xd6sad8Tm6986OgkiH6rR8+po8cOicC2uYTzrwuh9kT+wUFQgCqPqCUboag3w72p6b3ufQvEbHwilDx2zvJLel4nHL9XSUExwqSqNEwWIRVa9CO3lUBZx4WyiG+j13bNyRjTkAdNKoMsfxmnngFI7Yvl6yRKkeu70+H7Mulo+sxwnumF/JBQ/owypXBPge0qv/nwfzRxTCgcjLinap/jtJ7gjIRcbXdjt4Ivv2+nERq4Nu0SL9w6wvNFuqr8TNLKVRooqQaAC59Wetwq+pSZg2UTK1ERkTIZIQ9IzP5r1fZYJgV5O5FxjX57VacBJ60UeDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ2MJ034kz/+yCHz77EDP8UVitUjCKn41Y0vvkTtB2s=;
 b=wl8l/jWGU0BUvssMZSRgisk3BPbpSF8OgUYLKg+qt+FO+mU/hpOjWJmmLfFXNo0LuVTiAIAd83l32QHRb/NXXKi3gPb8QPYOF3dPWGi5N+LEnKGWD4bz/f8y8qvFU/Jl/QZA/jRyE4svUBhKu3j4yQe2mnHFt7ZLiXD3haUB9b8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 16:36:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:36:57 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 05/14] xfs: introduce forced allocation alignment
Date: Tue, 13 Aug 2024 16:36:29 +0000
Message-Id: <20240813163638.3751939-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0193.namprd05.prod.outlook.com
 (2603:10b6:a03:330::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 285dfb27-b2e2-4dd6-ed12-08dcbbb625a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YLNSP6T2A5KHw8CosCBxFDOBA3MX1co9tfl0/5mgPq6JTEIxQ6fkmLv8DzPf?=
 =?us-ascii?Q?66nX1Nx5EN/e3q5VmknCDnTQBXncxThQJYCsZpJyySpZfxLpT0fRovQT7ZSk?=
 =?us-ascii?Q?MfjRKhVOXoxzwD5n9MnrW2sWwcJdiVFBLaQw9eWynQlUATcIdvkz1eT+UUx6?=
 =?us-ascii?Q?nMOD9cQLwiarDqLznRWQoEwAv5gJEUu0CSsqj3cMfLR45aU1uR5Ofx5izMTF?=
 =?us-ascii?Q?Bi04LRLBwlzkI+vonw9Kyrk/852MAlf82qIpPDNOHwVSr2ruqEruPq8YkNMS?=
 =?us-ascii?Q?n5q5uMF5icPTIE9S/1oRnf1ODkL4e/qk+zX8+zs8G+ungB1/ZzG7cGON9dze?=
 =?us-ascii?Q?dPM97jmKQWDlgeSWB8QDGOFwpQoP4m4Q/39wY/1aeNR3Eavw53c6aO8yv/0+?=
 =?us-ascii?Q?PwSySvwWZfEs5PpT3q7vEHNAADQa4VOjNHBqkCjKDQk8QiFPdm1yWj7g5bep?=
 =?us-ascii?Q?YSr83suTD5UAJbyYeglQp5JWFRXL6GF4ZCKlwc9sgV4YEgkSmrlqTCUB0WEY?=
 =?us-ascii?Q?XcHCz2n6TfNVCxSB+PwEtRKF4LRupQH+mnVuXF73EhpBOsHy35zIOchZNTat?=
 =?us-ascii?Q?rDMQAmd1gV1Rp90xeiOEKxIwAAZ/jBbF+fiwJhvJzvhIX4UWbPio9gX4zG3N?=
 =?us-ascii?Q?Mpe45JIihnd1UAf0isx4AIBfaglRPZGMxBzrFpFmu8t3eUzq1erECzQHGhMJ?=
 =?us-ascii?Q?fLgHYTf0jWd7vFOHSshs9DDKCn8DQvpW0Tft6mjhjbCFqxvqXkrhuqNb7fOH?=
 =?us-ascii?Q?AzrdVSuaYgLV2Hss/fuvW0vJqkQjzCOnnA66pytii2AVetG+r6tjoFAAazs+?=
 =?us-ascii?Q?WC7gn1c4IjB349BRZxVw2e2wiU+QzmthaHYYyUHT8GBGNS1Los1u/WH1I+de?=
 =?us-ascii?Q?BmKwerGkXt8xrFnwvke3zIzD6ZTbJO8bM8mxrmrPOTpu5D0iW17tzbsrEI1C?=
 =?us-ascii?Q?7brocL2R2S3QqNI+L4AiCNvUDan6xCGoXFliER06noIn7APGfx2QDAVJzZ9M?=
 =?us-ascii?Q?0J1a/7FI7uvsceSt1kQNcgeqAI+WHGIMRJWPop8ugM0wNL1FR45hg4IxhESc?=
 =?us-ascii?Q?V93eqYznaq3JzCsbgi1rWXw/H99WBdHCz1cdd0WYlIEilqNAZAsd8A7tOuce?=
 =?us-ascii?Q?3gOkS15ZG4Hd9kKa+l8LGD6O9oV4kqex4OIX+a5JStEr0mBVLtRR2FQM1Fe+?=
 =?us-ascii?Q?YGJhuLygJFKBnYE9aBlrqW+k9qdupCiU001K194D9EhZW+9N7Xv6AEhWo+sC?=
 =?us-ascii?Q?uup1xdn0CAIambphWl/SW2HjPIBCDRBs7BLtGEFslD6sfouAbLS9yoQld5y+?=
 =?us-ascii?Q?U4Rl59v4EsfDuYY8IbN5DXi8ob1zsGrN/PXV8AEvd5idXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RJIaXLh3tRaJjftoZaMOc4EeGudtckyxCSVym9CcquTC58Q7bzDveOc6FUL8?=
 =?us-ascii?Q?bu409r2USwzqbu8HdbCgAZvDHFyxc6AvU3dmkHJQwf3CQXogTIFpt8mwfQe8?=
 =?us-ascii?Q?RMZ2tcS8bycJAfcfvaBqB2OrJgYcJwffBT511U1tkEI2gHosQUs0fo/hKW7z?=
 =?us-ascii?Q?13Bn7/m3PRDoKipsmHaH1JG6/ybcjLP8dAFvzMYsglVgrjxnaLA7tf9Ayk33?=
 =?us-ascii?Q?x2NgMQZ7k/CuxYf4mXm30iuqwuHOolnWs0Xnlx584QkvgIFgw3i7/RxN++JY?=
 =?us-ascii?Q?N/6HNUFocLzVhV1oEutUy/sT+G1FN70atsQJR2PPGB3gAJgIS/b7udivb4fE?=
 =?us-ascii?Q?gxEJ61WZQbaa7Mns8249xtn3eWRdWpg+5KprtZsqIU2W36HLybmbQQo/1/2Z?=
 =?us-ascii?Q?au/mSgPCyvkpJa5Fd8yiSztGrne2xzyPLkpYHdOYTHQrU6fV1ZqMXjPpXXFv?=
 =?us-ascii?Q?ONbCV10D6L7dkXFU08bjSjza2iyLGYjG1OgG51QA926Z5mJNGyiHPKsIntWh?=
 =?us-ascii?Q?GmvjO6ROZYN/QAW2vU1Q8qcrlLUUAdrImx19Lcc8KQkBwQuoIpeIVIzmqWRk?=
 =?us-ascii?Q?QTHExmyH+4pjovwD3muYSlBH00/h2EPffqEuqv5G66M0ScQljbLLBA/ic+Xc?=
 =?us-ascii?Q?12gETZTH3b8xHv6QHMaX9GqNsIP7sYGG8QT1OKgUetMTBwHv8DGa/3qgzgYw?=
 =?us-ascii?Q?ipuBbsDIYZsSSoHR2HLIn+dkDt+QbPRTYoZUU0Ln3cPizQMC3GImWyIu6VFh?=
 =?us-ascii?Q?hPo+1ej9KgcKwXJK9PfBYKpjVolVrZN+D0cl26hoHWS9PfutT73dFkLNXpbC?=
 =?us-ascii?Q?imQUOqvj0VUkYHVJeiMbLeoFm7r4HXu66b5HwKm0xJv8xbvd+YEeF6/rrxyr?=
 =?us-ascii?Q?b6gABSV6O0vyoC1um11Rmu+UziiaUG7ZlagwY0MeaGJklLbM0ZSosG8sQR5Z?=
 =?us-ascii?Q?/iggozGpqepelJfV0v5Gk2JZA0gv8qFQJAlfZWmmzsmtyqrx318hWyt6mXs0?=
 =?us-ascii?Q?3Id2sApbHw1+Dc+k7tE2X4wroXbETst4gTTLR4T7+b/GcMNAwv6jL3Sv7CKZ?=
 =?us-ascii?Q?G6vE0dXIcBvwoNI185ikjzG9mh2KTgYt0YK9wEM0n5bbYRGavsRwwiT8ypI4?=
 =?us-ascii?Q?Qap9a2rBk3sckseMjZ5TWGrInRHT5FzVzASiNxrb7CxC46RPFUaeuOTQ4pGa?=
 =?us-ascii?Q?awin+JLPjpKE9Ae+sPxX5IAjluWVU/VylLPZFHv5BZk7IZJqDkvutbjuLoIQ?=
 =?us-ascii?Q?5ocoEvVAD5XO0wxp5WXm3e4ewiF0Qz02mSHRgndlbWfskSoQmRqptIQD/182?=
 =?us-ascii?Q?3p+6PmGq9eiKGCA2HrwIGqm4tSTgi2dczlvfDgOUX8Jy9Hrs9MjgQ2gvu1Gm?=
 =?us-ascii?Q?y8QFH/KeSxH/3Dggh91gfn7R3Xfg9aOYRO/SFFmQP5iyE4Kz/V/y1C8B3qXQ?=
 =?us-ascii?Q?L9OqYJBJtv5ctnt8XkMSw0iFDo77V8866ys5uNNWqEdOVEj/+33dYGovL3Vl?=
 =?us-ascii?Q?jYN91kX568cD0kjD+QF/1DfJzHitKFNNTz8/fomnTiHIRPuQVuJVun9dZCv0?=
 =?us-ascii?Q?F2NxHBHetxZAZFCbGTjQkv8cuGhLbmWcJ9s/noSB/+WaUSZU8J1iw93VFHHz?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nQ4qvxgpr2z+mBcJtGejNb90sbmsVhqfTGrr6QcLc9hhHlicNga3mIGBQkxk1bH8kuW8EX3C1HnCMdDHLYjHwNUah4vf7P1HDdzOdyLutMeZjatf4lsuvCzpJBDf5MGlwB19WVwy4coLe+u/z4gs+P/wM3DOhyTn+qxNSgy5Ay9EmHmRtjizDtbJgArEhR/HTpcrfhKiYHILPmbohDiRQqwiUj59TngVZgWxxA0BfwWDWtNuS6CM5S1Is2bBrIgSOLlIeURTv4DUjfwpvqGk3SYxhRwzthRnZVp2xSVZL9mt0iqStGJLcIyk2vFCWxaevN0IKcaLzs83MyXFP+gsSu532pQFf7oPOveZ1919zE1T7N6nb7/bRcIibyOhEnBjIpXkmxJZ1UI0ngP+HcTI/lS5roKgpp5Nssq1IJfz7o3XnuQvOmIdjnevE0ac1v0rqhm0QuevEEJ0Zh9k6RMr/xyx8N/Tht3/O6aBqdyC0dWzCte1lYdTEopxpvhTZNjJekNcoDI5+YBk6MWsOohC7alwsdgMwa+4WLCyGArapJ34dBLHPe3aeRHv+CbT0bWQRv95IrAin+1QqwcoKJUS1hTx/hbaQVWg1PUHtjahy+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285dfb27-b2e2-4dd6-ed12-08dcbbb625a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:36:57.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkQxW+AdkWzN7MfGmFqe7cnARjj0Dp54xqmgUde5dnMUuN+CrHSmJamzSOJh0g97kGf03l9sLbnPN9n/xd80sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130120
X-Proofpoint-GUID: TYohKN7o0sRyVUHEiMbW8-aH6slHKEQh
X-Proofpoint-ORIG-GUID: TYohKN7o0sRyVUHEiMbW8-aH6slHKEQh

From: Dave Chinner <dchinner@redhat.com>

When forced allocation alignment is specified, the extent will
be aligned to the extent size hint size rather than stripe
alignment. If aligned allocation cannot be done, then the allocation
is failed rather than attempting non-aligned fallbacks.

Note: none of the per-inode force align configuration is present
yet, so this just triggers off an "always false" wrapper function
for the moment.

[jpg: Set XFS_ALLOC_FORCEALIGN in xfs_bmap_alloc_userdata(), rather than
      xfs_bmap_compute_alignments()]

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.h |  1 +
 fs/xfs/libxfs/xfs_bmap.c  | 28 +++++++++++++++++++++++-----
 fs/xfs/xfs_inode.h        |  5 +++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index 473822a5d4e9..17b062e8b925 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -66,6 +66,7 @@ typedef struct xfs_alloc_arg {
 #define XFS_ALLOC_USERDATA		(1 << 0)/* allocation is for user data*/
 #define XFS_ALLOC_INITIAL_USER_DATA	(1 << 1)/* special case start of file */
 #define XFS_ALLOC_NOBUSY		(1 << 2)/* Busy extents not allowed */
+#define XFS_ALLOC_FORCEALIGN		(1 << 3)/* forced extent alignment */
 
 /* freespace limit calculations */
 unsigned int xfs_alloc_set_aside(struct xfs_mount *mp);
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 42a75d257b35..602a5a50bcca 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3401,9 +3401,10 @@ xfs_bmap_alloc_account(
  * Calculate the extent start alignment and the extent length adjustments that
  * constrain this allocation.
  *
- * Extent start alignment is currently determined by stripe configuration and is
- * carried in args->alignment, whilst extent length adjustment is determined by
- * extent size hints and is carried by args->prod and args->mod.
+ * Extent start alignment is currently determined by forced inode alignment or
+ * stripe configuration and is carried in args->alignment, whilst extent length
+ * adjustment is determined by extent size hints and is carried by args->prod
+ * and args->mod.
  *
  * Low level allocation code is free to either ignore or override these values
  * as required.
@@ -3416,8 +3417,13 @@ xfs_bmap_compute_alignments(
 	struct xfs_mount	*mp = args->mp;
 	xfs_extlen_t		align = 0; /* minimum allocation alignment */
 
-	/* stripe alignment for allocation is determined by mount parameters */
-	if (mp->m_swidth && xfs_has_swalloc(mp))
+	/*
+	 * Forced inode alignment takes preference over stripe alignment.
+	 * Stripe alignment for allocation is determined by mount parameters.
+	 */
+	if (xfs_inode_has_forcealign(ap->ip))
+		args->alignment = xfs_get_extsz_hint(ap->ip);
+	else if (mp->m_swidth && xfs_has_swalloc(mp))
 		args->alignment = mp->m_swidth;
 	else if (mp->m_dalign)
 		args->alignment = mp->m_dalign;
@@ -3607,6 +3613,11 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	if (args->alignment > 1 && (args->datatype & XFS_ALLOC_FORCEALIGN)) {
+		args->fsbno = NULLFSBLOCK;
+		return 0;
+	}
+
 	args->alignment = 1;
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
@@ -3658,6 +3669,8 @@ xfs_bmap_btalloc_filestreams(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 	}
@@ -3716,6 +3729,8 @@ xfs_bmap_btalloc_best_length(
 
 	/* Attempt non-aligned allocation if we haven't already. */
 	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		if (args->datatype & XFS_ALLOC_FORCEALIGN)
+			return error;
 		args->alignment = 1;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
@@ -4151,6 +4166,9 @@ xfs_bmap_alloc_userdata(
 		if (bma->offset == 0)
 			bma->datatype |= XFS_ALLOC_INITIAL_USER_DATA;
 
+		if (xfs_inode_has_forcealign(bma->ip))
+			bma->datatype |= XFS_ALLOC_FORCEALIGN;
+
 		if (mp->m_dalign && bma->length >= mp->m_dalign) {
 			error = xfs_bmap_isaeof(bma, whichfork);
 			if (error)
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 51defdebef30..bf0f4f8b9e64 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -310,6 +310,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
 }
 
+static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
+{
+	return false;
+}
+
 /*
  * Decide if this file is a realtime file whose data allocation unit is larger
  * than a single filesystem block.
-- 
2.31.1


