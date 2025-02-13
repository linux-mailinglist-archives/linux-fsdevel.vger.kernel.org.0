Return-Path: <linux-fsdevel+bounces-41654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA7DA3411A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1235E188FCBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8024627128B;
	Thu, 13 Feb 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BQ6beFJA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FYoB6vq5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33CE26EFE9;
	Thu, 13 Feb 2025 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455049; cv=fail; b=TciIFaEyxH07HvrhzjkNlz/e9Ambpu3+7xB46XmTZABX3aU9jiLmm49LItLWr/UnF8gbSIK/ECl7l6y0SV2h+Dm9MB/5jcuvEXDHZYgv8+ej7G1TbI0/ccmePsudwzxnUaa2xztH2F+2eAU3Hg+gG/zQmMKiosniOI5vhPwb7ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455049; c=relaxed/simple;
	bh=yFkdszN+yIIf5ctuiED9NcL0bX3OSn2q1fKpfZuWILE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jNIYINtEPKY2LRfBBmbGWm5jsQWrnLM9ju2fnenS60ZqMtwbZT+BpkpItyKwKmkXQWcBWuHotQf8XVv/NWLDrLX55qnTE90+XWdQzWChDw69KET/f7zM19CcLbDxxYL7/DJFmV0g++kR39Ecr+IFFC0LrN/7zYjlk1kOhNxWn10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BQ6beFJA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FYoB6vq5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8feIO015121;
	Thu, 13 Feb 2025 13:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UUtsP8WRcUDVXSWlknRGpnfQgEmPdhrVCQYzTK0dFus=; b=
	BQ6beFJA08HLvKte8tXeaVR5+17LKuS6r9upmh4eltPV61rmBPptXnnEVoXherhu
	eF25/LyFjBW46Bkr38l/8XQBV52nfGFtpUKH/FJtDrffkh7Kzbc8IugEhXADp7ew
	KpdPXUhBTwkpQhRJNRxEy4aysczQ5gjLbCtTBUHqan9IDNkbJirOw6oBYK+1Av9w
	A8hJTVNcmSwGL9K1QaGP7JHfT7PhsqWYq7P9uUFomlx2u+7n/FC5S0zNQuMiptEJ
	C7rVuG6psEnC0lB7djU3MbQNUgQrMvn9nzF5p36YCWrsVvsjwenEq5uXaRknz7B6
	gwnvVFCa5c0xGXw8Je4NzA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2hnnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DDY8Aq026949;
	Thu, 13 Feb 2025 13:57:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbprav-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSd6dbhN4RHqzzWW0exgWIb9ObDwD0VtuO1caJo4yXVt9Q+U/7XeXSEZuczt+1rcveajwk7P83wn79ynOhilqJSZLWp+OCCEKi/NtKg7pUBypkwbcADj8P0tKjXZ6HEbyzkPAgHdRkfsDm+ivLYOEZKbw9VEyTGGmvvfX1WikmTvqccNy2UYjiTYExDW7SB10R0UmmhffFkM9zKRtgx/mFbsv6cN9ymIBOIa7HqUS3RsSfnHG1+36azqWqgODmn79kd88M3DYrdFRLaj5zlVZA4tz+wRHC7sVfP0F/92VKal+EuR060QXpKdFvIxq8nO7JuQAsA4jdOSb3Ixup4ILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUtsP8WRcUDVXSWlknRGpnfQgEmPdhrVCQYzTK0dFus=;
 b=mrhvDjx1+5xbuKSuva0ZAhNH40M1K6bk8K54IGcolIfAmzvwl1rNZTL476FTr03hOEW2RZprWeITD1wQSPo+yGkAs3eYrIpKNu9PAsoMg3tV2EXsuMSB8sDLujtM7QSqRcVh9yQCYxsPo9B2H138m+sSr51Ht4SdjLNKE5FQu4P3LnmX61SKFbHu1j1lkb0FI5gc5iBVk7dCoE8vwAguQgw1lpc8wUb1FJvTW586TQYvVyprShCeNR/8/CIEqBsLmz7k1Qk1xftiztpVwWvzQ5ocQmLaR21P+nVkpCZKXXjh1oY8KSqB9afBXY6LDidEDcNB83GTYrFRj5mWfYh/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUtsP8WRcUDVXSWlknRGpnfQgEmPdhrVCQYzTK0dFus=;
 b=FYoB6vq5O9v1pJ3bJLGgXITAgkO9VboeyS5jL9VxuF91qFtoNbzTc0Eu2zDAW0lZwGInrSu+42FRCar4htyCHibNBR3hdiqj1ZW92Smxh3UuGJq1e/hhLTDJd+YdqLfhg/aWVzt/H1bHuOF5R5zX6wt2zmfL+Jhye9QfwGSPvvc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 05/11] iomap: Lift blocksize restriction on atomic writes
Date: Thu, 13 Feb 2025 13:56:13 +0000
Message-Id: <20250213135619.1148432-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:408:ea::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: c5db8126-4406-4279-6744-08dd4c364da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4U9vKtLan05ts2Qsu2k9EfOKXqjxgViTJ+hVtSbSo1NdAtd1Fr8HypdV1Qaw?=
 =?us-ascii?Q?/v9smD197cMxmDUihn6P+3NdwpNm+Ac54hloMakkzmz7ee6G8Jx87A2RJIsl?=
 =?us-ascii?Q?AVxFtjIP6aCMUxBN9mgx/+co/MWfAtHUrK11A/egzwH3uuR5n1gvb+wZUuk8?=
 =?us-ascii?Q?zLx8r5dGWXCokH/acO60C7k/ZTh+7+of1xrFUZhQxB8NJqa8j+/52HJgkYRD?=
 =?us-ascii?Q?QOMqz8cVjzMOaov6NBEJimg+sh17GbijAETQj5PmGglSwCoDcgaBKdz1nlFa?=
 =?us-ascii?Q?HSEHsjxjgIhPmE5hjBfgrPD8yePSe86D3WERIFAY8ng2KPW4g7lqRRswVCbb?=
 =?us-ascii?Q?nYcoCd2+nWRT9d/J9N0d0XGIgHrwER2mQNZqBiAMrdLJ6OJlJMNd5BkkNbxs?=
 =?us-ascii?Q?oh1C2PWgsln2zp7ZZrRcqBChzVmfGCbrTykK6Gi4kGUe0e1GIq9C4M4IWixu?=
 =?us-ascii?Q?M1c59UzHvtd2frn7dx0O45Y0GYcejmiF77o5HO/eF+Du3aj10FpYdgepS3x/?=
 =?us-ascii?Q?GbD+et05RmHtpkfAqYYjTGU3HOdoGRgeJJTvsH8yuTpByQWTOYjy/5e2xgbU?=
 =?us-ascii?Q?BoFFqx5GesNhHQ7w/v8zqLf2fqAvIQFX7yHUR+DetOFiK2kD9hOx1W43iDpS?=
 =?us-ascii?Q?ruAVPG3v+8OKX8bkCuy3ZAVzEqCHyye+okEBiq88vr4rZvA+mK20q1EwFPYC?=
 =?us-ascii?Q?LCMK+Bzt0eSv9eG8g55+4ASdv4wsu6bMFB/oLglQb9LM/o91lfINjnj4W90J?=
 =?us-ascii?Q?gwMpBhFxU+B4AnypXX1TMKoLrWI4MN5rUajvm1dLLERnhY0tSAeJkaE73W34?=
 =?us-ascii?Q?CiEgIp5dLDrC/aTXMLv9PIeN0sn6taFfDf+Agmi/aMkzqgPQ7mjCfHkxuL3v?=
 =?us-ascii?Q?HPkYhiZxdaT9m51DNPUpa+TNVY+S0HdAAsTu8vnesC+xbI4Rk/UY6NbeMJYI?=
 =?us-ascii?Q?RYzc0ylQ9LLaCZn1qjjhixp+akb5hjDQXNCAq90F+pOkyk3lAmGkh1pzDgIo?=
 =?us-ascii?Q?267df6FGVgGiZJIbKWQTxF31rwNhngwy5ygbBBsHgTwXmrIAB/VQSazMrpbK?=
 =?us-ascii?Q?qqBV1Pz34oN7IsZM+yB+jEsDVTbesKbpZgvsW0MvFRnhZuFyxqfwRRuIRgFb?=
 =?us-ascii?Q?Oz6/HJBBo8QuM8uqT3SBH8PViw2g8qLAtJwCpjrSn14/lB1V2uj1jGV9IxZe?=
 =?us-ascii?Q?V+GCgITITmMSJXiL/S5rzrSWZEQF0Hsds1CDeF7EUrrZ8O9z3wX++WHRRrEY?=
 =?us-ascii?Q?XXbhel7kpuENmEzIlOKc8VHLKn38XuvQBpLUFaI64zOI6gYmNmNX6xzIFJwl?=
 =?us-ascii?Q?i2ROYYG4d5CVJnuX7Sht062mNOD0M5M8UHHU+bb9BuKO/7GZbMIbJ0zqjode?=
 =?us-ascii?Q?JRUazn1krn04PSVQ0REcrwQ+/F9k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2+TqDqjIniKrtwN8DOl6uprXo8QOpBF5oFq8y4rGno8wRX4yj9GOD5AP/MXc?=
 =?us-ascii?Q?RrU3SIy8HAtk+Yj/5KEec/GOfJbO5z1rwPQxUS/1BK9V8ITHUk8NwkUQhTXg?=
 =?us-ascii?Q?CfRUbaUadyO9Z9oi3KD1++avJ/jW3dHweTBZtQfwGb8st7ymrQ7sxn5bzlkF?=
 =?us-ascii?Q?cnha3a2rtvaKEaLVr05aa46G18EYQ04Bppm92mP5L0qTgGOzXLHNr4LcyRIc?=
 =?us-ascii?Q?EcZgODgd7aAE/GlXyFOGX8bTxT5GPZ34AVQt+0ygDvek0zmuZd01YpPiybnI?=
 =?us-ascii?Q?k0j0y+bpDn4l+LiGaolF0gN2kVbMbiba/5+0juDyZKAgqenjUtRfsNR2PFe9?=
 =?us-ascii?Q?orGsy6lFXBko1MZ/ieZ7vfw4AaS4E7XOh7WYSOhSV2iPR55NKGqeXT03UL9s?=
 =?us-ascii?Q?84sVD/dCH9WjtD/BItmyvj0bfynxpxd1YAjKSe08TD541UhNCVIl1D6MM5dz?=
 =?us-ascii?Q?iitYWYr+pLbknlp4hMRjTOtZFfHMemtNXG9XXKhlAQjWGNKsk78tKKsWyCcM?=
 =?us-ascii?Q?41HcJ/S29Np1EngLBI2DSqAd7aQc8yItQMUK1PUx7aGj4aM0RKRLBI3drHzf?=
 =?us-ascii?Q?KccOXMimfVNJfW88EjNtq0chwRc/XKyoxPE5HPI7VwsSloeXEZzBOcRdnOO9?=
 =?us-ascii?Q?g5098dda3gM3dGbiSIBD895Vn9iRYo1ng3KkVZU1ou/wYgdHqQuFkUii6gFk?=
 =?us-ascii?Q?YrrxfLLpjEXRl1/3OHXMSq/7rO1Bqg9Loq4B91ob021soJrzYHloD9jbBCSo?=
 =?us-ascii?Q?9ZUaiR55Ebe2GCaZ8SA3uQ0491nrEU7YdN1j5Ma3MWjFqZZhEkVJU14E4tRA?=
 =?us-ascii?Q?aumqqBvrlSHsUbVBRKaxr7TaPf3cBTs3AraiOAH1+GRpsPPXcTsgQE/1CnW5?=
 =?us-ascii?Q?qt1Vmjq1+MH7OuDdtGq0VMmHh68xAUYwR8MDAUdGqz3XQGR9m6Gu8gaFY7VS?=
 =?us-ascii?Q?LbHmDcqQ3u8BSxG2GfjMGlM+Rcy3FL29vCxvyOhFm4hEIholHMU54RkYgiE4?=
 =?us-ascii?Q?I2qHRyp0mXr3jzEgLSJ8MEzmYBwGy8EXZWko+2gMLvyTqMnn6stq0A+wmC7/?=
 =?us-ascii?Q?qhzOxqTUxAAFWMcxmQgSv9f5Ee7qMY7vbF+eBXTVmA2t9RguUqzwWlyi5SbQ?=
 =?us-ascii?Q?qHYqev8aFzinM1CRJIc8liFsb5TpRc/hoEE5pgrvBdyOYfp+NqyN/nUFREP0?=
 =?us-ascii?Q?onJwDXN8jW3gB2E8ybuWxkXY33JWUe6Fbar5/OQLEKi+7foSKIzhM4UACop0?=
 =?us-ascii?Q?5Jmrs9tytnHKlTTutfV2y9OGbKKUWUe4aN2aheEMqcDqk8f2mmBT3kkX0VmS?=
 =?us-ascii?Q?WPUjf6jnvNQyk9gTB9z6Cq6JE4hdDUkgDMXCo2L5euDSxz5SSlTgZBxWBQ35?=
 =?us-ascii?Q?MIIzoZsTke4NePToz6YmxdVfJt8r7DM3umz2ZikhfC7jAwzV9H6hLqYavXPZ?=
 =?us-ascii?Q?rH2NVDqbMrJIPCph4eGXjthamJtRx6XFIPywJOhYo77ee1jYxJpyT6VT4wnq?=
 =?us-ascii?Q?TxNRgirJuLkUqf/ec6k/bKO1W+E3KNVGtl+fWlbRrVg6F+f11ai1lhfsEAf6?=
 =?us-ascii?Q?BrrJa+Etaq5CruLeXARauYAQif7vle2xoSooRYGwHgFjw4ByFenei6JlxHxm?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bN6djErtDwhsdZ4PaTyyQ3CSjgwc4yZL4DCuSzC8ZRJIP9/hBuzHzOYwP5a1U9tMm8qNFYwvIZ3vN6xnDex1iLbxfLehK+eBRSWVbSzS1pTu/j9yiW0UCDw9AlXFC3KD1ZPebr6ZTF/UmLTkiHj026Ksgd6pFgRSul4Acj0dwLG7p4Ucg+l6qbRNZ4S0YMNa98zlMkJDr4pV8N+FbogYFg84rnxYgleMPDEbNFUeufgNfWaQR1vgms6eR/qIu4BBcNUkDIWZgd8Y9mZjEybpFofJPeHklfeQN0fozmOPMB/D/DL1BQZekhSdgtKrjBbMXPW0la3Br0BCcBfT4XvikjjZM1SzWfNPjXCVlwQc70HZfZVZNqk6dLWCZOF/TV5LsXQickJrEvWeWWyR/DAnEdXMQE3K3PADPXndCMnavcQ32mCvtrSqGntoD0hiKjBn0+qVkXDC+jkrAe2VYBk6A4BdCVTz6s8TxlxYUxehK3aYqJyWDlUy98jBPNXQdjck3qSad2ItZ06M0jCiLBme0Gy8LQGtt05yr1iUmrixFpH73O9v2QoEwi76pn16upgeliWPF0RysEurtOpDxHMFEMRgfOC1IsEyDzIn0qKuzvM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5db8126-4406-4279-6744-08dd4c364da5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:07.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoBCVyjaVR4hCRXxGzghcL0afS5FZost9r42Unk8lYD1o6V9+HgE0qq9f6iy8Yj2UG+cF899aaeeLSp1KS0bNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-GUID: 4XK2YzF1KqIGaLtPDnCDjuOWGIYrUdOD
X-Proofpoint-ORIG-GUID: 4XK2YzF1KqIGaLtPDnCDjuOWGIYrUdOD

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Filesystems like ext4 can submit writes in multiples of blocksizes.
But we still can't allow the writes to be split. Hence let's check if
the iomap_length() is same as iter->len or not.

It is the role of the FS to ensure that a single mapping may be created
for an atomic write. The FS will also continue to check size and alignment
legality.

Signed-off-by: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
jpg: Tweak commit message
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 076338397daa..aeee84eccecf 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if (atomic_hw && length != fs_block_size)
+	if (atomic_hw && length != iter->len)
 		return -EINVAL;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-- 
2.31.1


