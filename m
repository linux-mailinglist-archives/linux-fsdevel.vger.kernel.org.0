Return-Path: <linux-fsdevel+bounces-36843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D3C9E9BDD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 17:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07ED1167151
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5388314A0AA;
	Mon,  9 Dec 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jj4s9Div";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mu97yj84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F2BA3D;
	Mon,  9 Dec 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762175; cv=fail; b=CNEBC5gxWN08XDDuawPPvMkwK6/+TgYE5kPikWhoU0dDcZ64LnNN08IQSrM92qmdnpobzmuqBazzpPbUPRrrG1B/MUJFZmln4pDrVBgv2JzkmyF2ZeVSOFvt4cCSd0xYzE+reWPZT1sP11gM4FJspALZZM/q+7KO9ISgiy4GSmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762175; c=relaxed/simple;
	bh=/DLdR52L7De1X9+/GFBBHQS9koKBW9VR0A70j/KopcQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LCQCHv9Dg8RvY+lCJEsJsttjqC69T9nizD5/jVXHAkzxMThRcpf6u4L9klQx5X3N9i6rz0c9hiPvAj1SNoNJF38ST+KlMPCbY7UbzbwqLOD3v+VvSuJFgksLT88vC3tcBXgDKJ6wNmVYYPsUXATqSI8V4SY1YCqGo4DOaEKN6nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jj4s9Div; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mu97yj84; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99hD6u004408;
	Mon, 9 Dec 2024 16:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IavNWKk/lcPT02WVfqua3mY5ycie870tVPrGn4o919A=; b=
	jj4s9DivGDkPMxS5WPf8doIWLRpy2lfyoFKy+SNulnumt0CIR9+rLaXlgFyj0uO3
	2DEuRtK5CMmq+tyyRacEpCCuhA6yNQinscOnMt9zq1gvjLQBnSLKEb3jA3AGFxPo
	FWhus4SlLoIeC1ktC2HuSt7N13rSfkwIcZ1ErWIisHt68ZbD9Oqudyy4xaXWaWJZ
	auRJhSfowqT7biWNYV3V6fuRTLxs8h9VbMdOA/7EQ6PZ5CbdZ7tuOEsNzXm3sy+S
	pYCKfcZnEQRn9Aclhs6DhznHY+b3imEmWoPz/jehmSQ0g9uXDLrZ6KdgoiUBDyty
	tLZhbYOo9FueXDcc8LLJOg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s0t58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 16:36:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FB1xq008602;
	Mon, 9 Dec 2024 16:36:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct786eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 16:36:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7DVeyjqPReQRFwcyXjH31esYzcjnjHo33iVzT8hxH3kcQEZa15JogcMbf8c9Pig1e1vunnY/w86O58hj5tEPKpK3DsrOlPC0PCuscm3HnSOgZxy4iipgec2D44GrxNr7eFxKzoUdVOQ1Cv0qw9P8PyBvgkM6nwu6YFqCmd7/2PIaTeyZJDE1Hsm8dKCiQeRIgjNnaQP+e7SzuiC02xK/O8QWlcGoO5FNvr1l09L0rOIQDsFa/sZA0RvyaNaz251MfaGalmpPlOi7stTwPm2c//qqPS/TPwetC2EHSYOb7Jsbo0D/SpaQqIKm7SfDfeLONKgWQFC0CxtlzRPAb7nOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IavNWKk/lcPT02WVfqua3mY5ycie870tVPrGn4o919A=;
 b=K88chQYmpfzy1YPYZnja9lKSOjbfKuZrF378NvotInj9gxAZgAA9Dc3G2k9NZPZH8BOX06KD1oRg6TKeLKQqpQAwN3zXAX3AUFstN4K5v+GfR8ezR+6oRKcJL3jdB6O3Hwe90v+OW9QPp5pAVRFJdDRKmqmLgekxQ4G4Y3pIgGabqPm/6Eps1yN+58IBzRPGWTc+FM3xTxd+bM6xFKeRo/kpSKoW5fRv29i+ADmKDzBhBA63DztqKvgWlYq2rPq7VfVUE3F18ZE7ex4t90nmP7kyptmrkcVd1AwJYSpLbZP7LC+wTMpnac7ejikW2EEuo5LXJA2E/fvrvxCriBSelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IavNWKk/lcPT02WVfqua3mY5ycie870tVPrGn4o919A=;
 b=mu97yj84axBj7xLK2v1f+PKUDHIixVPvKfMBji6QHkOScB3uv/+8dAc6o5EBGp9piKd5olGwJVOpE2yQGvxb+gLd11IcgBzb56IvThtGk+SebaxxDpl18j0Mk2Ttck61bjzVIe+Sn5s3KXdaHn6AtlN5oDKyDjzaRjauFhf89tY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB8118.namprd10.prod.outlook.com (2603:10b6:208:4fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 16:35:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 16:35:58 +0000
Message-ID: <15628525-629f-49a4-a821-92092e2fa8cb@oracle.com>
Date: Mon, 9 Dec 2024 11:35:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export operations
 as only supporting file handles
To: Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Erin Shepherd <erin.shepherd@e43.eu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, stable <stable@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, Jens Axboe <axboe@kernel.dk>,
        Shaohua Li <shli@fb.com>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org>
 <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
 <20241206160358.GC7820@frogsfrogsfrogs>
 <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
 <Z1ahFxFtksuThilS@infradead.org>
 <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
 <Z1b00KG2O6YMuh_r@infradead.org>
 <CAOQ4uxjcVuq+PCoMos5Vi=t_S1OgJEM5wQ6Za2Ue9_FOq31m9Q@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAOQ4uxjcVuq+PCoMos5Vi=t_S1OgJEM5wQ6Za2Ue9_FOq31m9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: e08c1ed3-b9b9-4fb9-69e5-08dd186f8f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUFYbFpZQ3FmMGhMc2FrOTF3eFZmd09lRW9GZ0xwbVIwbGdFRlIxOG4yV012?=
 =?utf-8?B?bjFBalhZOXBBRjNsbEMxbkxTemFGYW5ncXBxQ0t4TlRsNkVrRFM1eEg2TFdE?=
 =?utf-8?B?YWVkUzhOYjZhOUpGYzhVc2pMT1VxZVJrNUE3aVM0MDhwVHFCRXBJbUkyaEdF?=
 =?utf-8?B?Q0UydGZRWWd1bU9CQUNnMSt6djl5djhnc2ZRajBiSWhFSnBTVnZuV3B3amxQ?=
 =?utf-8?B?YUovS04zQ2FldjBjaVdVOFZqQ2QyNnAzWXpmL3pGb3NFZkRwRXozZXN0SU82?=
 =?utf-8?B?Q1htWGpIMGhESFhDRnpJR3IvQ1phdG5JVUtNQ3ovVVRyKzBvaElqd1NCdFB3?=
 =?utf-8?B?TFQvaUZxWXRLNmtSa0VBeTFKNmx3eUNFYlR5OUsvZmI5M0w2bThBcFdKa3JP?=
 =?utf-8?B?c0NHWjR5Nnl2ZWhlSENGKzBzU1BNRWJoMGxIN1lwRHZZanVFTitKVEJmbFpE?=
 =?utf-8?B?eGZBRXRPK0kyYXpEQ0ZZdTlPYVJ0TXMwdG1DL1FNTVVrcGZpUGJsOFRqOXFK?=
 =?utf-8?B?bEE4ZFVDalh1a3VMZUFWRlBPc3BrN0w4aHlBYjZUb1Q1Ujh5YTlUdXZlbkNx?=
 =?utf-8?B?eDUweG1CeEFQRWx2a284S3AzTVpneCtqbkdjOXJxMUxrZS8yZVZlTTh6Q01L?=
 =?utf-8?B?N05lZkllTElpelIwTzZOWlJmU1gzaGRiS3JyNnk4Z2xVOVJHS2oydWpQd1Ji?=
 =?utf-8?B?Q3NYd3J0VVE4L1kvSjhvUWpEei9LYWlxcW95NjgxeWEyNW1Jd0VpK0hxKzhY?=
 =?utf-8?B?eFAxbGV4ZDNqNWI3YmpZM0N1VHBKSWh5N3lsaFJrSE9ZSkR3ZERJVWczRG5V?=
 =?utf-8?B?blVDT3FoWW0rWWNqUjJwQzN5THV5VG1PaUc3VmhmWFJNeDJ2RCsyb2YrS2FH?=
 =?utf-8?B?NTArcSsyM1pCcU9maWRRZjNaZlBjVEs3aHlLM3I0NHNmME1XbVJDT0tzeGQy?=
 =?utf-8?B?OXlFMmFkQUI3UVREWXZOWXNJbnRrYngzYU42ZVdSQUxvTk9Ed29qU1M2Mk9I?=
 =?utf-8?B?OHB1M2tuWlE1L2hjTHp3Rk9HeDIwcVB6ZG5McGpIc1NDRDFwazYwL25ad3dT?=
 =?utf-8?B?MVdsY21tWE1sdkFxa0h3UEd3cUMvRU8xZ3RZQ3VJRGNPVVJUTE11WUdOQXZ2?=
 =?utf-8?B?RlJVU2dDcmpIL3VFQXJveVR4aGw1eW1Pampva1BFdlcwbVVYcG1salo3VVRT?=
 =?utf-8?B?OUZTaElOODRTTWFsNEZOeTFpV2k5bXkyYjUxajRaRGVMdXFrUVVtQVpmNWFm?=
 =?utf-8?B?TVFxQXBCWjZuSUFmTFpmREs4OFZMeUNXVTVpU1A5dmR0bTNJdDkrNXNGcEd5?=
 =?utf-8?B?SDdaM1RnU0g3MWxnSGRBUmc4TEM0c0dNTVBoRVowSXhCUkFRbk1FallIS2RU?=
 =?utf-8?B?eFhIWk5yQmNGT0d6S2MrM3FKaHNIWjErdVZkeGhvYWR4TEoxbmZJOWdXNys5?=
 =?utf-8?B?MGpnR3ExVVdLMWhkakJyRzBncEE0alg5TlA2b0VIdW5aZGxDNTBaZmdtYVZk?=
 =?utf-8?B?SVRVMlc0VnJiaGp3L2xrajlWeklOR3BISjlQbXpRZkZWelFXVzcxVi9yZzB5?=
 =?utf-8?B?WXYxMDJ0Ymx2TWdjelhTSlBLeGRVTkRWZDl1a0xzZWJmOVVid1l5aDQ2Zndx?=
 =?utf-8?B?RkdWOVpyMHJhYTZMbExuMTV1ZWJlYmM3M3NqYkREYjB4WUF3WG9MY3hKM3pn?=
 =?utf-8?B?ZWFVdjlsbHBxWFJpUk1ZTVBrTW9wQm5yQW1zaDlzNFZoNnJsUDNBMVUzdEJu?=
 =?utf-8?B?YmdSWVRJeUM5MDhrK24rczA5OU94M1RHR1c1YXRHZ0trakpRQU84aU9jSUR4?=
 =?utf-8?B?MjdsNllsd3lNYXA4Y1VwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkxhL3BVV0x0Ry9OcjRZY0dIQjV2QmhOR2x6UFpiN2diSEZlYlNqaENuc1py?=
 =?utf-8?B?Q0xWZk55djBjdmhMRGo4a1g1TTlLaXZQdVMzelY0SWR5S0ZCaFVRUGM3SVVi?=
 =?utf-8?B?ZktGaDh0bTBOcy9FK015ME1IVm1DU3NidFRIWG5NdzU3NHg4N2RVUVp5bFZw?=
 =?utf-8?B?U1pQeEVNRHZ1Yk81aEJkaEVsTW8wZGgxVVNZUVdURStxV1kvelFyWllsb21z?=
 =?utf-8?B?Tm9HTURhRFpqNUxWZ245MjMzcjdRQU5jSGZYVmJGSTMzUHQ3NldxcUptMm9o?=
 =?utf-8?B?Slo4MVl5YVk4clNjNUdtcG1vNStwc1ZGZFo0S2FpbWZiVzhMQXNWZmVFVU5a?=
 =?utf-8?B?Z2l6ZXZvZ2dIRFkwRmRhNW51UUtFeTA3bDI0NHJNdmUwRHNCV1AzcEJidDM4?=
 =?utf-8?B?bnM0QnZrcVk0NU5ERE04SVZIL0ZOYWVpMlEzSjdac3UrS2xqZDVxNmF2UFoz?=
 =?utf-8?B?Vmx2ZkNvT1RNMWZHMnZkMTVLNmdSckNoM1FOdU5Wc2ZBQ0wydkdNcDZ4aVU0?=
 =?utf-8?B?Tm9qLzUrenJnaXFnYnltajRQUUthRWF0WDNOWEpnRE5QMnlMQWZpanBPNVhp?=
 =?utf-8?B?M1YxNDliUzdQcHVnZHQrdVB0MjhrUVhoYTU5WWtUc1hlY3laQlhPcHdpRjFp?=
 =?utf-8?B?ajZWUThaVEsrb3FXYjg4cHpwSDlaam9oa1l3RFdTdld5TXlLalRVREJFRndF?=
 =?utf-8?B?Y2kwTEIvck1GOGZoR0xVMGlpSkhGazVIMWhCcmhQTXNXQlJtRUczcjYrZ0V6?=
 =?utf-8?B?N2RTNENMMTNHQkhrNXg5dS9vTlEzcFFhcnFKYWxUWGM1TTF0OXc3emJtRVY0?=
 =?utf-8?B?d2JmOWtTZUFoTFJNU2dZN0ZOMFBvSUVWZEhQTU9LaVhxWHl5bGFFaUNzeER0?=
 =?utf-8?B?NHAzYUoyOGttTDdiZmtCaDR1cERRRHdLenJqYUdTbVVucjkzRWRNRTgwUXpM?=
 =?utf-8?B?Q2JoWEhqUzdxak9JdWFYdXQvUENaNWhuN01DUGJpLzNwUFVwYkFxWHFNZ1hh?=
 =?utf-8?B?a3EyVld0RTdwQzVTWXRKK3FzYVVFQm51ZVdhTVdJd0kwLzJoOVBta0dTdVl3?=
 =?utf-8?B?L0Rhek9maklWWFY3ZDJDZEk2NVFjZWFiSDBrMmk3M2lMR2lBSjllT1d0c01E?=
 =?utf-8?B?UEUxRGExdVFjWVN3ZzdMbXliR0R2VGlCWEdTQUw5WnRhZCtYSnhsZFB0TjJ2?=
 =?utf-8?B?eVBDTklPR3lrZkJTVS91SEVHU2RUV1R6QkVLK3VqcXd2NjU1cjYxdE1iSEdn?=
 =?utf-8?B?RGpMRlJyWnRuQVdjSWRWTVZhdTY0OTdBN1hVc2JBR1MwTmxIZ2pab09sT3pX?=
 =?utf-8?B?S2VuR0tReGl6MTdlN1EvRldBOHRZRUNFdmg1dlFXMENXZVBQeGhFUXQ5eHhY?=
 =?utf-8?B?ZmpFaFZUR00ybk5pMEg0NHZtMkZoZnJTczdiaENNWlNPNU05bjkwVGIxOXh6?=
 =?utf-8?B?WTEzeGJzQnUyVFdDYmZGR3VCUmkrZnJLeDhoK0hqNlRPUzU2ZkhOMWFQRGVC?=
 =?utf-8?B?bVNqN3dDWEJpeU1JNSsreTAraFdmTlNvQ3VhZXNPdTJzRjJCcnVTK2VuRjRX?=
 =?utf-8?B?OWkwNnNkNEUzcyt2QStwV2RESUtpZVBhSXlidnBUOEdjRzIzWWJrY2hZQm5R?=
 =?utf-8?B?SFJmR1M3RkRHQXk5cDRnSDlMTWhGSUxPTUxwTkpleXc1ellXSSttYzR6NUts?=
 =?utf-8?B?ekNaS0FpWTNUUXhWRm1TVEFNN2xqWVFEZWd0MExkeXlyaWxGc0NoRE40a0Zv?=
 =?utf-8?B?cHo4bXA1SHJCa3llMm91MVhnUEx3aURLTlNVRWFjcHdMdFpjREZENkFPZEVq?=
 =?utf-8?B?aUkzS3hWZVo4d25iby9yZkd3SnE2bkxXVFNHeW1jWEcxeEJ6SjgyOUd6S3FI?=
 =?utf-8?B?dDBQVElPQ0JaV3pwckRBR3pCbHZmbFQ2YWEzdm1wbllhK0NqOW9TTjM5bFZy?=
 =?utf-8?B?OXEwdGJzai9kdU5hZ1p0dTgxRDhyVFJETDEybE1ZZU14eTZRWGZWR2ViSUpv?=
 =?utf-8?B?c3hZZEY1UGNBRXRYQkpmWm1xMzZhcHRha1drejZ0S2NBUHZpcm0wZTVYajFE?=
 =?utf-8?B?ZzY3MzNiWU5VcjJkUko5UWdFaFhFcS9idFY0NjJEbXVIc09OeG1YU0crMmxi?=
 =?utf-8?Q?+GU4gWMqvTpy5JQ3HiQTi1jm6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e/qtYsUD47bSYy+xK0YYwTDAFqP5bArUe9auNDE6AZWA2UJbCo5HZCh5GAWDFh9bOtlQZNReXQ56W3MXgld8Tqj2kgvSXF7Ke6VjLO6Lshlb3WuU8v0lGjLQHv/ESXCMRTFd4bvVnZg04gVIGy5hoUNo8NIb4WizNYHiUHQfUHtGdzH4TAp1f0mT/6qtXd3Di0lZ1jwBQw1Pqd1wO5BtbbQPqpr152abp9v/A7SpXbABy0hkwdDvtF3J4MWFWHcXzv/5RCMqSd7C5+NkiGHc+uMuEYhJZAGYfdudgIEhNguyEnhxs9sYIcbuv60bUllETFGBqpTgYmD7aabw6wTsAhqHlHNxyxwTV4dwindCHbwD5ik56pxor6U0tMpk8BLJ3rCaZdWu/rEjczXrFpxmtQybKPByjY68cKPq+tR1T62JgFXD8WMA3TLxrA1QxEXXWKpu/xwnEW42oTYkcUToVkYA3hJvJDIhODgNVl81E+Bf8R5hQt0P2LCZH37VVWc9jqlWnlvEnRy428y2u2aK6CLeKWjiWwBj0KOshnfykPojy4fIpQl+j27PGyDAk4ffnCGSWeRuy0V20Wsbu/JfSftjqcwYL4GzKtfh69wkR9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08c1ed3-b9b9-4fb9-69e5-08dd186f8f4e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 16:35:58.2585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6SSs4DkahJ3fYiwWaHAaG6c4cOOXSAHen8U6AZxmUh0Z0QoYCvekyM0i041wXTHmvZbL1SbNoIaDTEFPFYJ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_12,2024-12-09_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090129
X-Proofpoint-ORIG-GUID: cILD_3SvlLgFbsiC5sjPV3gEgbM4r3Bx
X-Proofpoint-GUID: cILD_3SvlLgFbsiC5sjPV3gEgbM4r3Bx

On 12/9/24 11:30 AM, Amir Goldstein wrote:
> On Mon, Dec 9, 2024 at 2:46 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Mon, Dec 09, 2024 at 09:58:58AM +0100, Amir Goldstein wrote:
>>> To be clear, exporting pidfs or internal shmem via an anonymous fd is
>>> probably not possible with existing userspace tools, but with all the new
>>> mount_fd and magic link apis, I can never be sure what can be made possible
>>> to achieve when the user holds an anonymous fd.
>>>
>>> The thinking behind adding the EXPORT_OP_LOCAL_FILE_HANDLE flag
>>> was that when kernfs/cgroups was added exportfs support with commit
>>> aa8188253474 ("kernfs: add exportfs operations"), there was no intention
>>> to export cgroupfs over nfs, only local to uses, but that was never enforced,
>>> so we thought it would be good to add this restriction and backport it to
>>> stable kernels.
>>
>> Can you please explain what the problem with exporting these file
>> systems over NFS is?  Yes, it's not going to be very useful.  But what
>> is actually problematic about it?  Any why is it not problematic with
>> a userland nfs server?  We really need to settle that argumet before
>> deciding a flag name or polarity.
>>
> 
> I agree that it is not the end of the world and users do have to explicitly
> use fsid= argument to be able to export cgroupfs via nfsd.
> 
> The idea for this patch started from the claim that Jeff wrote that cgroups
> is not allowed for nfsd export, but I couldn't find where it is not allowed.
> 
> I have no issue personally with leaving cgroupfs exportable via nfsd
> and changing restricting only SB_NOUSER and SB_KERNMOUNT fs.
> 
> Jeff, Chuck, what is your opinion w.r.t exportability of cgroupfs via nfsd?

We all seem to be hard-pressed to find a usage scenario where exporting
pseudo-filesystems via NFS is valuable. But maybe someone has done it
and has a good reason for it.

The issue is whether such export should be consistently and actively
prevented.

I'm not aware of any specific security issues with it.


-- 
Chuck Lever

