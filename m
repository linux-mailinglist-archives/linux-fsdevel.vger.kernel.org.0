Return-Path: <linux-fsdevel+bounces-50795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497BCACFAE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 03:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394CC3ADA69
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F891917F0;
	Fri,  6 Jun 2025 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U7QfUKNQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GoMD/+8v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC6125DF;
	Fri,  6 Jun 2025 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749174723; cv=fail; b=YdX6iLdPmlxBEJs0a5f2oR8oiiue+RRrhgg14DfJm9oMo+J7Pu4cK3eE8M+jlG6DcVeEXrFoRx5nObwyd+X/zoaPqWzqAketsxU2bBzP2NtearQEASnRP07Agx3ZAJv72Rt7u24Cktk+aQD8AmeJrmkYHHuFQzUrS+Y0EDqp5Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749174723; c=relaxed/simple;
	bh=Bwuq4/PT6UHPeQtOEFITeo9tIu98OnmiFzgKB7/6gkk=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=jIgZCDYMRK0Z9JDcyTmowFNzSV4Kz/EgP8HGYEDwy1TFvyig3i7jOBhriAcOo8mRdrEvhLAM1wLNsPrFdAIWvGtoWuta8WxcG1WInxp9zx7eBUX2xZaL5ZPM/H6GxpdtiuYGnWUllAdF/9Y04rXkEduloSYkjWf8V/gr9gDsJZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U7QfUKNQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GoMD/+8v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Kw2VZ012405;
	Fri, 6 Jun 2025 01:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zU5nhkyuGWbzaUcWwx
	FV5E6fusXzMuDhmAQvqcvV9/k=; b=U7QfUKNQbvP4yBc22N0qjXa8hoU4YBShMo
	/bGLemgL9xxFUPMnhYXt/6IwsnAG5w/jFI5x9uLj558s0VCJHtWxp3wX1fMjXqaw
	mMhe1UFBP8L8jFguE59K/6qO6T+EDjtevyaqVZTmQS+gbGFZv5upb77b2BN46cvr
	6wyVzLteMM1K+rZ57ZWTT5dCufSJolzZDO/rXbf84wwrXdatuBo+CKla/n4NdqGG
	jsuZ37bK8v3nYMjmPq2bHb76AqkKrYezpKihBHZU6X2qUSfQFStsj3zb2+OkGtOs
	4kvyMj2TA0CieFl91KYwwLFYyXe/e7zeTU7JguFhdELSwwE2cMhA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gf4cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 01:51:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555NU1lK030599;
	Fri, 6 Jun 2025 01:51:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7cs28n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 01:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyAGaUErwgK7LCnxJBJ3ptp2Tq+BuQAa4AsiC73itBD3zvSKwVjWJBuXf4ZeLG1Vaf/z8y0CswSEQbDNF3+TfxqWXlJHS0PJFdMtFK7wt351MTCJS9i3HOEZkzR4zQLICYfeDzYMImZhyYBWIFQ/CsQvnz8bBGo5sJrNSDiF2TH4ig5drnfikPEeWxuAe6j1KmyXjoQvtTJsT3bt5WG+5uxtTSJMOLYSX26Y67wMgwCAMwacN4oaf8WjO5cUXzD3TkrlzcfsbujTCy2xpoAthABDqvqqMO2WNzXHy8Fjnxa2CjURzTJFFsqQ66bdRsATiCxsyhn7qxIjcTmTKZXrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU5nhkyuGWbzaUcWwxFV5E6fusXzMuDhmAQvqcvV9/k=;
 b=MRMzsTkrSRN6b2SIs2kvYXt2AkIq0ERapUCZ4oI/8Xeb0BANXQBLqWkNvSJM0fB+m9rQXZVx0yZh+Aff0HEQXe9npZBduu3VutH/fkiDvqeIlSoonHt9V/TzWTVLZ5XLRNn3c8EBi3hSaJoAQWvoriG/F/tZKdU29KnkYREp9iJh2CgP7IRdP5ADZlJ72CxAa0+TVwkESForL6hKWHAmF+cN5gOPMrI9tsLUdqlCoCXHLvF42rB8zXkVXOAlbrpyFwHXRyxOHmm0TMBmjowtuhVYxsxO0o4krkXyO5UwCj3RpW0OPpw13ySRws/Hq58KJhbXcCVtHz0VQwLaWxQTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU5nhkyuGWbzaUcWwxFV5E6fusXzMuDhmAQvqcvV9/k=;
 b=GoMD/+8varnBrYzT/MTXkT4b/ZBVCTJB3dbwnatS2gWrV8P4o4x9zKC5r0ehR5o5TT1gCrBtVU5Gd98NQoGPQXkmdfasd9AldfjSRHw1iQzb8mat+Z2Giv9ZuMZlq0is1gZrv581jhwMSlgLWRCuWSvvL2UfMtr3wNG/n+RdhDA=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS4PPF94A902B17.namprd10.prod.outlook.com (2603:10b6:f:fc00::d34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Fri, 6 Jun
 2025 01:51:43 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 01:51:43 +0000
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
        axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
        hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
        adilger@dilger.ca, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH for-next v2 1/2] block: introduce pi_size field in
 blk_integrity
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250605150729.2730-2-anuj20.g@samsung.com> (Anuj Gupta's
	message of "Thu, 5 Jun 2025 20:37:28 +0530")
Organization: Oracle Corporation
Message-ID: <yq1frgdbpt0.fsf@ca-mkp.ca.oracle.com>
References: <20250605150729.2730-1-anuj20.g@samsung.com>
	<CGME20250605150743epcas5p11a40e74bba0b8a8f9c24c3ff31051665@epcas5p1.samsung.com>
	<20250605150729.2730-2-anuj20.g@samsung.com>
Date: Thu, 05 Jun 2025 21:51:38 -0400
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS4PPF94A902B17:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad9e562-8c85-4d87-4287-08dda49cafba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rD28xybhn/Y2AKyTOcyHGQeK7EWMajsHeixvek1WWM12npkn+5myl5q7bf7V?=
 =?us-ascii?Q?9Y9hm5pm6tYgqFgU1vhbuKRk5OUBOKvnJlIAHLdnDwLA8Xp13xojsEq5V7kj?=
 =?us-ascii?Q?QniafTpMye9Ea45+SZcJPw70IB5U4hSdsGVPLBJ//5/NrG+ahXQDOHawu2Pc?=
 =?us-ascii?Q?0dUYbSLFugKRO1D7WnkzIqfNfotbWIKgSHp4fLaOkeTdmqSWr8Zl8iabTvY2?=
 =?us-ascii?Q?+I6ApSKH4sDDKR8g1dB9tkNIBkeMIZzqQJi67Mx/JMoYOvrnRqa8mwdSwkBP?=
 =?us-ascii?Q?AaRYDrKeqzysiZlTERARCmKECkuwm+FYvDeFbEKQFvliaoh4JLT2VCEsZfkK?=
 =?us-ascii?Q?puZ78B6j/aVMbnJuPQx0c2MBxriT/60snWuBOrewzvcFh2BRIiS+EuuyChe1?=
 =?us-ascii?Q?0wHDg03+RPDis44ps/rJ8zoiYYFAPCbrZKzUh6prG8tykolRALb1l1m6vNky?=
 =?us-ascii?Q?6Uf7EWoc8YV3FoAmuHPvLGZf2pAcvwSAiidxbNBkmFVNgplY74TZuGOfwdsS?=
 =?us-ascii?Q?8uomicuGj1S+Caif+0bQ+NrnWB+tuZ4m1vxk8xsrf18HVHPZoK9WzEXbZRpQ?=
 =?us-ascii?Q?DsUgiKbeRowv+NLL0gePUObj5mHy0y7/B31WG3PD3IrVVrqIAfsaL9Q/CnC3?=
 =?us-ascii?Q?OVxu7ruxG+Wc9ZjiFDHWpMEnNmu5uIhHQwaL9MWV4Da70douucnAug+Mi6CT?=
 =?us-ascii?Q?yZY4kfS7LTaBB0IAW/LHd7Tw91dC6N1ze+Dh+/CqTSMzCqCl7/lpSkMGSos6?=
 =?us-ascii?Q?r6wpLI9WcmcBZtMO8M5o3IBTmqYml35YeiDZ75oxD49TWl3KPcrnWWyRn5kn?=
 =?us-ascii?Q?se9aFWKq0V6bZRjiTFRrW8Doi9srwxRYp4ZBoCi6vwXUy4oU2TdXgQ3Rnzik?=
 =?us-ascii?Q?bClfZCkIJFe/ZjkjY7T7ZkNAqVvWXXmTj106pbZGjIvL0lPHvrF16cboYgux?=
 =?us-ascii?Q?GH0BeNqYcKf+a5l+FW1DOB+AvKEikoBPnbLPjiQUhzkbZsrnUb68YaYnKIy/?=
 =?us-ascii?Q?JqytbtUAvBxtuRWPYNHseDvng1Xk34rrd0099sQkuJ4M1Vzk1VZhXoYTadxa?=
 =?us-ascii?Q?X4anhrO3eAYWgjfijrHUvGWWeiSzq8bO7w78Uepv7EvAs0Yvs9ARIr33FQ1+?=
 =?us-ascii?Q?UqLnyMrG3FyyeqKrCM4KJqgLEQlmoscYBomRmVx05Ea6NLt8A/fLzsr/WXfo?=
 =?us-ascii?Q?tk2u92yG8FI2hmrXUOmDQ72fuiPXaRShknQMJtPY58hylsiW2E0+a0bxPlZP?=
 =?us-ascii?Q?lFwG+v2NGyqPT/qy5HSLiRxIF3LD1Cw/cDiresh2lOqMFt/ajhVHhHytxA0t?=
 =?us-ascii?Q?YwN1ilFQgiRv2cLfgp0Cu1+Osi6sLNW3PUvvl0vZb5Oc5bC3LKteWihd6iZj?=
 =?us-ascii?Q?YJmetevQx6aY55JdeO5l8U+oVvbxAGt77XTk58pAv4MTbEnBHmqn0MQzj/O7?=
 =?us-ascii?Q?v0zaU+ARs/8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z6bCuuPpvRSmQHw42L778TZPHKBPQ3DHxoiDY7kJmQ0p1vjr7+e/2cD4aeIk?=
 =?us-ascii?Q?7mBsLT6sqg4DdLSC4JuOYdnQo7CZ1Tzbx1m+OX7y389oxqPVIOKLSps0oNDn?=
 =?us-ascii?Q?byyvVvOOMwU4jZ+26glTqqVqzPG1SvFVtGCNNXkFYkR4l7TUTG90N3MCSqQN?=
 =?us-ascii?Q?+8RsKXce3tvPU/etQ6L+8qOSjA9htuLlWxUs86zL30QpVrqoW08I6UlgniuZ?=
 =?us-ascii?Q?0pOjo9vtsPQW09KYP/s2pTEgzSnlFyB0L8Gvv7HzEAlziXulvNnAGe9UHesq?=
 =?us-ascii?Q?pF08ZorCyJ9z5MQ2CXWc1hYn5B7du8RR/QTKwH+cAoQ/QXxLiW1x8a7aPOrX?=
 =?us-ascii?Q?kHHbtvnvBGJKz57WeneUx0VeFHvP/W0F5y3DC/WG4JOLvu0sggmBUXhDLgtp?=
 =?us-ascii?Q?ioxSKEbYqDs5N+a+bDnQe7aFgDoaRrMRUfYssoVChbeLhIYm8cWxY3vQp77V?=
 =?us-ascii?Q?ZGilRuKTNQE3eIAKm8uli64VpXaBmdvCk0fwtRRExOuoaKpW5WrL5B7I6eLU?=
 =?us-ascii?Q?slPb7Jp+YozZogPx2ZXhX/9Wu70ryMaNQ8ISDpV42AehOhmCgXR3fAP0fuwT?=
 =?us-ascii?Q?wTe4LFBXvpszYen8S6h6nMSxxEXDU4+XmFHWD9vdBIBTPPAWCuJ/pDUqwjcA?=
 =?us-ascii?Q?JMBtbiJfZz5JMb7/aONHORkqKY3rQ8MnAuuzQg9/eEoJq1+GRRmVa+7zSwqa?=
 =?us-ascii?Q?xrS2tynWqooERtxmWB9cVUI3AJtDwJzCXJuun1EF+bF5sT/7SmhTm1QW8wg1?=
 =?us-ascii?Q?jWiywgTe1qP0nM9LFnhMl6sYVufNsEbiTjTGId2CD97pEy2MpGuA0SQboQXD?=
 =?us-ascii?Q?I8/RfeVykPzJwsdZHrDbINhranlZ6cA/XuUjDd8JgVKisntWJNJFJoaOS8pS?=
 =?us-ascii?Q?S+qb/0ILa5tbEBz7W8IMVXjsPFUxZEbRU1UwkTseQ7WxXsdrcIr1/nMofSY6?=
 =?us-ascii?Q?l7AlPCvFgH2XmQ+KAWerJr+lEa4sebZ+MO3u3cZMuxobG6FpHYmeDeS9Wa46?=
 =?us-ascii?Q?caVTy0w6UCJW01/b7Ej8ppwgg2sDilB4C1c2ABJLE/OE6UA1FjFVp3efG1/6?=
 =?us-ascii?Q?44cEcHm3bOf+kEUYxL9YR2TacgCUOH5W/wx4tflSNnPwBPo9qrM3e/p0oLDy?=
 =?us-ascii?Q?rIXuE9t8/JHZx5p9QPWf4e+zzkgwtYIDhfLOblvRmqiodIyc2HLeyC2c1qxS?=
 =?us-ascii?Q?13Uml6NXPFGD8dJfu8NVyixCx5EXrircUlcifpGIXSASxnZNmBeJxk3CNzCe?=
 =?us-ascii?Q?CQ2PFl6GgySWpZBMV2ORpNZRrUqvDDUwi6Pja4+38mt4mWXPSO47I68xh1GD?=
 =?us-ascii?Q?E7dd7x54sUVBrfsSMb9hP36jUn8J+6/MHMHT7Of2gb53ZPHXE1Rdz/rbCVk/?=
 =?us-ascii?Q?K0C0FV+xASEm8n4gzVJRk0Hccw58wtN5A4JX8V3KtyI8KWwdF8nowLMFKDeR?=
 =?us-ascii?Q?31bpzdfrm3SKmp1ucIjGAxLGTEPJG/6nBJ6tVJ35XC+xlBbT7/XkdI0RorU+?=
 =?us-ascii?Q?4OJeUS82xXWkld30DenSgAvs6GqWGhRrSme1e37WSyfjzjJ1JdCcSFH2pUQH?=
 =?us-ascii?Q?obmAfqM8D2cgnKpldS2MCbYLLMUW+Gk+uI+CFm7ExtMSCLy5yaUyJschoq1R?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yxs+2PBQiHo703osmiMW0EDoL0zxTEaKmAsJiKU2PtwAu5yceN1z6kiQPKuAIDJwFIsYzbQ5OaYTbStqP6fDCoE4O/LWdeHSY649VIqkWHCLjblUdgMmh+o3MxSjk1FRQLqC6hHmiPkSFIyp6A6WB8nOvkgTWIQ3nX9QLOx+2Q/E/AidQ9bbWMP4P+45K1ko3KgcsYoRme0kf7ptIV1ux4ZB2E3T6K0zfXjhTBHFXcYVkni2k7XgLvvLuyF2+NQ3GFAKNiPxh9QHhuTu5zXp9MaUIHIwBY1RxA+ByEWFDdBvae93V6eF6wRzo1SEcPg4H2AKGkrR8vS7THOdY6Jj4v1Gu8561zgJF6+Y2sL6JoxWcgR8AWjqdPVPW6rvz1Q+HlEFYYKUHqxYUWJXw/jF0bkDBr2epHf8URIwZ/N0KNWYGSWExM+Hu8h/Jq/QjciF/vo4PVYQV+MD7PoA51F4Yr1UV4DByDv+i5CmXMlR4QK7ZpobPe59MqqMjvID3pdHsvDa3fzmdvimwwXOLGVVavK4YpHpQFAuDBOVugeArargML9ERdjHzgS58BndgJt1za1NtPDUHmmX1N2tYWwt8Uj6c+fcrBYLL1ukWmt2hII=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad9e562-8c85-4d87-4287-08dda49cafba
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 01:51:42.9009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+q9Q4RZbobMRO8v5QltECWK1JmxJPPGGqnjuFhTfcSnmwvJv93wNtZZaEU4GF581Y+L1H/CGymAF14hp77X/DEY68tI5Wd/OURG8Q6FPDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF94A902B17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_08,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506060016
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDAxNiBTYWx0ZWRfXzO58wuZPZmqO a45DmNfjtaac1Fqp3YtRbB8aNWHflvz6JAQeN7nOmgkqcE0wj513bVPFJd281xAi3EipmnOrOB1 OTGQMO7NTeQdTqwcdX0sz+okHWVGoKH9YP21eC45KH+ZwoT56z7TrgfXguzs3Fj2QffNkFjn2FN
 4o9SMLjHLvGGq3j4D1PzLEVAJiEx35iDl4wQWdjqv0lcCzlK57wRG+3CHlp9FZTSv00727tr2Y/ vU1XwINFX4iGqA7mE9ckAwU+0pM+5diDDvl4VXUft1i0PMnhYAO9ahZefEni8Er6kg5QaJAI3dy +qWZHll+L0h8fZD4g2HwPSI80b5gynuZTaCbe/ncIHSTciIoaBV7Jf1bQ9rULv+H28GQbqomrf1
 gvFJzBjJSiNpm08QfzxXFi2xI4+Bi3WVrDDWH81A0HkcVxRplF6hgZdBy10Uns22qgMKY9i9
X-Proofpoint-GUID: I84n3I0PXDgHkEIU1vfNJQhMFLubeDeD
X-Proofpoint-ORIG-GUID: I84n3I0PXDgHkEIU1vfNJQhMFLubeDeD
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=684249b3 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=H6_HBJHk608_68Q0peMA:9 a=MTAcVbZMd_8A:10 cc=ntf awl=host:14714


Anuj,

> Introduce a new pi_size field in struct blk_integrity to explicitly
> represent the size (in bytes) of the protection information (PI) tuple.
> This is a prep patch.

LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

