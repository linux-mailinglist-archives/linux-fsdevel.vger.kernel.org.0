Return-Path: <linux-fsdevel+bounces-31945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3692999E203
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA534283F26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E711E00BF;
	Tue, 15 Oct 2024 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XofeCrBu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WTiJXtUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD911DD54B;
	Tue, 15 Oct 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982938; cv=fail; b=SJeu/A7Y32cYo9uIoMvgGy/KYqHLM/ouS9mNX9rlNPNn0UgKN0+uWvdpuBbomvLODab71+2WIvCPcOf9nNza41hrgMqQFOY0vtKi+qbTdUvUf+1zEk0qqGRN5bxp4UKjsnZay573duzqZgZp0JDIu2b0/6be4tBnP+1G3UOMo6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982938; c=relaxed/simple;
	bh=DyEQh7TJksNDFD5Q6ZoydjOuWIB7+nKug/iMT6X/Bmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ex07aJqkLzuXnTOx932ru6DMyvNKWMh6oagXOKGtIRf3cb+571ImNsuci4YAIa4lhKyN7/9Oj6sCzR2/QSTorkEyyzUeee8wiasuPmpjQZ3yo+w8wTSqzwqLjX4ZGQEJv3B0M+GMHHAOmPVm3qPFvuEV1bxv6aI3F/bQiw5MRsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XofeCrBu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WTiJXtUs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6F3HB010191;
	Tue, 15 Oct 2024 09:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0/Dp0FpxB/g12r+FsHa6wK6cib685ZOsysK1B1ETDNg=; b=
	XofeCrBuDe/jSLATHzZRAgEzqGZRg8xCV1+5/ljHy8/kVX4o58T0634jZaBUCjt4
	h28iTrT7+KfbKJwtupotT/nSb1mjhT5QeyQBwI+FlsYZXkW0p1oTUso3pMisAre4
	wtUrmMLuvqQrnZawLCmHYYvvuE9X0GpvzCha5HjcrRMzoWaSro0OR+oKOiE/FDZb
	QF8JEauAHXtiPRCW58DgG0f3jsKZNVZZ4CT6tCNcKkI4FuV8z1KKoHNOEFKG+ezc
	KsWnYksKCzXo6GcAhxELZwj/BFN8u9BeyHyTqo7vkSXC4mCHrv22zGjBx1bJzomt
	SMa7n4JffDuufUHSkNGBiw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt05g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:02:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7XxY0026388;
	Tue, 15 Oct 2024 09:02:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj754ms-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC9+7wndVr8+Up9RG/W59vkT1kCYrTmP0fy/mAOZDg5EP/N5L6uyf3s7oxalHzDWa8ycMHoXfHIBHaOLUApZ5ZInaUftiiCuXk9tMSb4U25LHg5T5HrTqFoGm6QJ4pES1C21DGblQHDYofbTM2OUI3u5MWhUmhwmDhAtUZ5lMd7eLlOp2U4ew9rbVySwm+eKak1uifXvbtlaUzaxqA0iFxPWHh7A1CXfr1WqFWjUep1xuK50pOBteUUvGynX+1EQO0d+uY/4Djf6em0D0uLl3oAwq6Owx7sILYFM+7M999/O04/mlimtboXP5zt12VExQG4xBweZDMxCWcgbCsEnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/Dp0FpxB/g12r+FsHa6wK6cib685ZOsysK1B1ETDNg=;
 b=uqD5H/AcSjMMXVpUmqAKmAOJvUfVF8VD6dzyUQIElZzvn3sZW4CGG60wk0RHDN2Q8zBtTlNsy5jC18NO6+G2t181A0oTM2tQMU38UC0C/3d60LFE9/PI0aw5EHIGnu1Jhej9OBeJVilIGA/lkn66rwYLHgy722d9CfZOajy7CeTQ70pNvfHDrlQBhpOKFILoNFspAa1IuFBBCvbk5HCCLoK3VHT/E3Wwy9wyFtm9JiUbMk4Nw0qdcEbuD8plCKffCQsHHEVxfBmUHpFPWuPDxjYNGfi071E5ENTxvEAVVDGz8j/wDpeQQteyKDJTpk3v43LaayopE72Sfprlua4ZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/Dp0FpxB/g12r+FsHa6wK6cib685ZOsysK1B1ETDNg=;
 b=WTiJXtUs41lVBdkpv7YMdGAjvAPQ5EzfuzSUAzCJ+77+RvA4n2u2oELD1c8WUOlc+T5IHtff98Im4GJM7vdcZJnYucn6NDAA/Oz5VxSppydda0Wzm7YT5t1EbsZPZSAe14iNDrApsX83dRuzdQ6mLY1Rmr7y77gGiVir12OsToo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 09:02:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:02:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 7/7] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Tue, 15 Oct 2024 09:01:42 +0000
Message-Id: <20241015090142.3189518-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241015090142.3189518-1-john.g.garry@oracle.com>
References: <20241015090142.3189518-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:408:4c::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: bd82e121-cb40-409a-a0b4-08dcecf808e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fYSjUomuDFGMKXFn5M7k1MIBtminB6CEhilhOCvEYe6opCJY8KMeV1Ge9tXZ?=
 =?us-ascii?Q?ECj4owRPS1WFNwB8v1Tb9564JO+zYSRXt1RYmwowu7ym+v1TP+bdZSDzytt2?=
 =?us-ascii?Q?JgFLyYCZ6+N5X1Qbkofbt6o1otSMgGOYEss2ApavO4eIF5Yn+wS0XJ3BwzXD?=
 =?us-ascii?Q?PnYaC5YTaEdtM1ODazdeD4l0o43cB8TQIaPp0XOZT9oDcuEaZK6jlD15EzVH?=
 =?us-ascii?Q?rBEjVYnkD1amRHCACEri988rFJMN1xsPkUNCaOiBFq8H3e7pJF1pvFKMUz+w?=
 =?us-ascii?Q?XtqkLjwMUeK1awVJ+SHzsrZee+Ugz9KjbOyCgSvh3XQpDKTYJNF4wtzO/lhs?=
 =?us-ascii?Q?PwckGG+VtOw8EZtBtC4U9XaD3NNchy2A3YMZQbhQx2nfdhvqICHxyOCQAxRv?=
 =?us-ascii?Q?yJzxpJaTTBPq79Olr8L0wEtPhd5YJXMu9hqhvH52h8p8QATynxzJveFsGdPV?=
 =?us-ascii?Q?kers9kWYhktPmYNzJ8tivd4y/tNPb53qxg3JkqJsDocUt8T4cU3wwWEr3alC?=
 =?us-ascii?Q?T2/D+atyNOEsydxtKWFwb1vuhrUPlX8E4u4JSNg8yo6+dfXUhM0gDYVzSrog?=
 =?us-ascii?Q?9/hOVyGD7rVtBwfYx31W98Lu0Vs4h4GBQ9EVHtZRrSRWtmfoXf7HjYTTPtbn?=
 =?us-ascii?Q?VgLv/lYyPAowifU00DPe3lKnjyhOD1DSEexXJicQkzxAUktckVVF5+BGCJiC?=
 =?us-ascii?Q?jgAgXWca9PetoAh6rEYjR7PROrxj6AziipsXoOfmVidKQLHDNv99ecRaP9c9?=
 =?us-ascii?Q?G+R5NUCo6BaDlreVFp+2TYS8rIwGQJkjSgxQxMtlVrpIO2whJQk2eqStNUEy?=
 =?us-ascii?Q?9+llzdPXBfRP2BTfUja8AAkES8zHG1MSYQbET1o2yxFocnawxaD9NwBCIhXv?=
 =?us-ascii?Q?GX+nkk97RQRTmSsnWt2gTFQD7esx1O76YwmWM9YHTGGc9sJz9KTqSQ8BBF5N?=
 =?us-ascii?Q?M0J4azKFZ33jTbMjRAz6e5aSRu4kMyOOTN73jl5H7OHyYMBY9FbLycU1fDK0?=
 =?us-ascii?Q?kZooX/KZgj6e4jrgy6ByJBzpDD6vfsGnfdvcdqcjJMGkh4Q/3CB5hcl3ZfP7?=
 =?us-ascii?Q?btKAvgsYu2wN+3GCC1o4tHjdsfJD3VfZyJTxdUSlIHG/AQMOlU4mlDHY1xga?=
 =?us-ascii?Q?kctSbbwCAvoLnUjCvX0pzu0943b9e3lExRWGQbxZX3WEZhpfRtnM0zIn/wdT?=
 =?us-ascii?Q?wPgV2o+nAPqb8ReuGOlc7ZyHSq8zp+ZS/xZp6tepgufJN/7nYovqxwWMiIzd?=
 =?us-ascii?Q?JqbVj/x8nTVeZlAzGKHkiU7EMx2EYKOQyvmD32c23w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n7FMb6I+W8OHLLtjZoCmU0Sh1fiZZznXORU7VNkFCOYAAfkEtczXJGPZTtyR?=
 =?us-ascii?Q?by1UG4mmmfxA9wyNqx3gM9uKzYl883mVpw2/vipT6OOqVJ1AjUrdkYK8Pwxi?=
 =?us-ascii?Q?ZDCqM7CcVzdh4Mve8LIvPC6vfP47HCWluwC01+0P9Sex9yPZG0onqYr/Is9Q?=
 =?us-ascii?Q?7iNd7FYFWqEsdzeXyTQGpe4RZani/s3IWav8flge7DG1g//rRVBW34YoCB98?=
 =?us-ascii?Q?jcTwTA/xZQ6Q0oOUMBQPbaS0Pe6SqlPs+uNITL6hv5HDrSQ4A0kkEq3WkIXu?=
 =?us-ascii?Q?eSRoe1rrVAw1lF5dMV/jnGjMPfqJfIJJbFbYgFkz1pkbay4NHxJhtpAKsgDP?=
 =?us-ascii?Q?rzmzhK+vl/XgdoM3BzoDrevy+xjj2DiKhXjcc0iGdxZzoIQr9Ka9KOTr54Ox?=
 =?us-ascii?Q?jpC6gap5Ai2mNOvcdlIWvD+2rLW7KeOJ7RUkaf+9C+vzqOHzQVHBe7AM3ldP?=
 =?us-ascii?Q?dG0Kb48Kal6cS5Fdz38JS/J5KZcq33ouhSC48pu6vxJVW0UtxMGZ8lXeqJTM?=
 =?us-ascii?Q?suW25bjlGTvddo15wNj5jwFSS/iGG0Dq0eHe6Hf/cyHIxjkrhD3YDP+fjtzo?=
 =?us-ascii?Q?1vaxyJZfY1+R1zylFGYJjhZoiMw6kooGzycg6/2oJJ/219SPeCKdXsZR5Tq5?=
 =?us-ascii?Q?hZzXTyOtPlsK3wUcgX8H6hrGxQXYVuFzI5DtQLWObqmq+Yug/zhi1D/f07ri?=
 =?us-ascii?Q?nM5kXsltBFuCo3vuRmvMf/UtFWI6veeDF7fI3zNvJEiWjyZxJfLrz35R2JgA?=
 =?us-ascii?Q?r5lFiiZvhPVupA8BjWYRj2AWOVOLKpDYLltvKqqqIporobBznK5Jmm705LEW?=
 =?us-ascii?Q?yZsXPdy/KgU1dr2JDLy9+Jtbvb8gjl8Om1IQWRUQe5zpD6sd34DmE1MKFvZx?=
 =?us-ascii?Q?lhUlB7+vSEQmMWXI9NvdPgqlvGn+hZEQhHrNwoFhKiOVIkANc+uMwRqxMhQe?=
 =?us-ascii?Q?l/GJ27Pcjf3zBhaG4X1vfkfuE/H9FE1BTu22R0DCNJ7aWQ+ASwCeQIHuoJzP?=
 =?us-ascii?Q?uoCQn4K9WLVNPWv69l/WuxP4txKv/9+odGVV7E5Z5eXXR19vwl0dqKjYGP70?=
 =?us-ascii?Q?vq8VwlQHkzHUWn7wpxb2hu4cQb5cxVIunJ4ZO8tQjs9VwtI7XdvLaBQFlpks?=
 =?us-ascii?Q?Unx263yOohjLubcyC3MZjDzNZIcOkaXSCwpL+yvf+Le4Pir7cQ7t+H+SdYrZ?=
 =?us-ascii?Q?z3+ih4IaOEvpFDebuCCJg+tzr1vn4iZ+EpXkp6QZTzf1T4OBfMxU8iStdMhU?=
 =?us-ascii?Q?n9rft+uNWU6gupcMuZ6EcrPWt7a7qprz030aMlx3x/tn0MsZUCOP1brBAC3Z?=
 =?us-ascii?Q?mBuZuzV08aFLCVCsQtszPMPCMbvdKZxu1UFd1KLHSIY10ewLsBho6WdRaCOO?=
 =?us-ascii?Q?Yheb6sjw+f0YLTbMN9RpF58mCqVf3DTFPrm13QwLe1niNFnNF0PTO8FGwTFO?=
 =?us-ascii?Q?jtqp/eVfWtdi0oSzgLp9UG0gMt5PszXm8U1S9kcPd6Z+3FvzZ/hnZ9Th7521?=
 =?us-ascii?Q?IimmbrbHV6eLlvAEZCs44QeQvPpsXX2mMAzr7PYUIhjoZhMCbap1GqVuUQJq?=
 =?us-ascii?Q?rhM3JBPHUpFTYLcRKIM+RPaYeokXP/K5apvDdSZvsv4UCLnmS6mcugrVuSFn?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7cfDkRmhqmpZR+AA7zFTwjtHd6/WMuZn5i+Wmg6x0owEOeDYqErWsDHWgOEkiPwbLIUK+9uhoVLlzkGx9JPEuLDNBXEzC07V7nYWYTqkUUSfLIibZ7232n8a3AdT6ukZh8d4yqpY2+wchFQYTu8FS8RY6ojODSkyCO3nniboGYthYCQgDIkgZScz4WM8ZT8Cjx4gVob6P1odPWkZOkf76iP6vJs8Awe5J2yfujK+kAwevuwsT0iqdlmo+Uz44/1jOJj5VyhJLwIqCMLy9ZNR4trpeRMouLqA+smqJYulDRyAXe5qRBY6D6iT9fls5rBUVOuF2nipoBprLrVhbPicmmh5R1bxtB79Ks6flqLyXYbnb8PVvtgpQ3lMt47WlFw6DXPEldvqzQpwPs/QnEGN/x4Jjp3Htedye2jyMML4Ki5c7BzZLmLknQb8c1YSa/LJWAhgEUec2ag6FVCqgl6zT3EHi6vfNJIONlyQk7ThkO7oFPvdIhhW0Nm1BAD2xuBB4IxKL28tuqNOWI5RbvY/wb2+tM+Nr8PnZR9jYDCO85rEzFvs+2YWUL4vxY9mHWnLjv96T7PnpXHtrZqIKGSDa32+I+3R2DLl4cYOO5J+Ifk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd82e121-cb40-409a-a0b4-08dcecf808e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:02:02.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifLDX2t5t25izRp8P0+RDoRHwsXs4yKtm+FHGpW0fi4Pk6kNV/qpniGIqIV1+/VaVylKtYIjdGChZq7UrhfmJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150060
X-Proofpoint-GUID: KN1EVtYJJ_bJYYj3DyB2GIXQyeGWWsCK
X-Proofpoint-ORIG-GUID: KN1EVtYJJ_bJYYj3DyB2GIXQyeGWWsCK

Set FMODE_CAN_ATOMIC_WRITE flag if we can atomic write for that inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 3a0a35e7826a..e4a3a9882b0a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1217,6 +1217,8 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
 
-- 
2.31.1


