Return-Path: <linux-fsdevel+bounces-40242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF35A20F27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1481885252
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A8A1DDC30;
	Tue, 28 Jan 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V6OfJuej";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E8R8ui41"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545E1ACEBA;
	Tue, 28 Jan 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082864; cv=fail; b=ViSEPmOpYbofHWbFOoF3JRw9D/XgTdTJNpfA8ZupKEGrNdIYFyJmNrr4cQFYD7QRtkE2dviofE4rZgL+g0tnrsYjjL0hZ1ozMGMjLaVt6UW8A+zzGi7X9ep0d0dEbWsHgOQztgpU1S05z67JgrhhcDCe3o77SOnDxEl4ybxKmYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082864; c=relaxed/simple;
	bh=QyzbBxYZZ/nd3y6NIeawjnAhPVGSS+PJMaXtjXz1UfE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R05qx+VaFxMfM5v+TwGStsOH+mqmIxfJI1vYsQccds3GvVSIUAt/onPZgatnzA/aSJsd78VWMmZ+3z4ugAit5qgajs4StnrcZM3NH4Hhcnq32gVjhsipQr7EZLVMOhlPG9Mbpnsgl+Q29ZlPgH1NTedpql4uzGpc9mBwAnFf+pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V6OfJuej; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E8R8ui41; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SGMrwA022211;
	Tue, 28 Jan 2025 16:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=k7Z2fhFvPINW8jAE9y4l7Z+dsviJJKNR7p7fSzBB7GY=; b=
	V6OfJuejyg0Cw5s2Qo0SmoW8sxlgmjrbCsOYfx56DqRTHQM14lvCaLF5zFugeqd9
	N/ZDcFmqLTFo4kQGBjEcUmYp1bYS4LtZaeUrJ7y6rwv8aYN35rKqMA08JtE8fJUp
	MpkhH5ibvZxRIjqjeIvMwI2u7CGvVjGl5Memw0TGFdQHlnLEqaYRKdxfD1PtwXhu
	YeTTS4n0IqPW8eM1uLSIn2cZ6WURkwZVKWgCGsVwD/R5Gddxhof5ZU+klvXRqAxp
	+dUdV+4URuNVhlqp1HPgtnX1uMiYwIVtsE37rAX+EvKTKNnyVEuFZ61i6UVTCCE/
	6Vpm+9yw0JJLIIs1b8GamA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f0mwresb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 16:47:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50SGXfiR036792;
	Tue, 28 Jan 2025 16:47:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd8kecb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 16:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtsPt7jDkxzR7B50ahpk77vh8lgZCslFtz8n8gY4up5ZTbMq6qufbVwKATAU9s2scvHYhqlT18OVSBxr4kmi3MYDAsFSGIi7Z1MuYuTVHyV6tcrPnhLAoAiMutoFu7zO3PB4pwSnHiZFW7ieKWEZTSa5D1sMmo2kTBPwD0kbdA1yf2c535yeoVsUP6jCvp8zBXxNy0QHHjeCoACbXlgWiBN9GEJA8fumH7vjxIicklNL51Mi0shZTnnzrE5bd9oQaA5Xde31/BgFUtyMcC1NacnBccLFVQHqmRfEM6hsxLU5nRSH6McnHehrWDwgxSqm7ZwPm2e/v124BAxnzP+Dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7Z2fhFvPINW8jAE9y4l7Z+dsviJJKNR7p7fSzBB7GY=;
 b=cxlO20285NOPC+v83zHF0n9WZT18JCfC/NLghN8U0KNfrPI/V1j7hj4U4EhiKFzpwk2qfyxnRCTKPDhTfr3dVD1qah9OL3gU/P9KlGCRfHNL1bkfXGY+D/3QkiwOm5kynhRarq+iAWwIXMYP5ym0RY1RiDEKRYsf75wZUSXDNGshP2qi0cvch2CCVsT3MmeX6wc8WdCKQafKVpN7muzCL8h21kDKj6GAB0It+VKY9qEq0NBHuWpyCeedNOmcYbb30ju0zCZnyNIvG6/FKVC4FzxHxqkTEI+Zj8molyG+u7e0hgsdVWnlJhedu3SmilarmIV/6LvCUakYuKy9wJfpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7Z2fhFvPINW8jAE9y4l7Z+dsviJJKNR7p7fSzBB7GY=;
 b=E8R8ui41NwPvqwFc03QJxl8Zw9xvuIWOgtY9VnGb9dobfNywF+CMP+1qcLwCnf8wYoU1w9uzVXPAVGd2BAWYE4PzCV8rGszcRgyz9EYCyHlDOgv2qSi1pFBOT9t80eGJiJTxDxo5GAArTD4NYALRZJBOxMG8M10QTLmJtf4/CFk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6041.namprd10.prod.outlook.com (2603:10b6:208:3b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Tue, 28 Jan
 2025 16:47:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 16:47:04 +0000
Message-ID: <d0f8315b-e006-498a-b3e8-77542f352d40@oracle.com>
Date: Tue, 28 Jan 2025 16:46:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/8] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP
 to queue limits features
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu, djwong@kernel.org,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
 <20250115114637.2705887-2-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250115114637.2705887-2-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 817b9dbd-e8c9-4208-0168-08dd3fbb64b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWdYSG5KaldmZHNxSS81b1N0Q1ZRTjJvOWt4ckpweGFTV0RvSWtGOWxEZkZx?=
 =?utf-8?B?MXR5S1BJN3VGZklOdkJITGFHaXVPeXRjejRyMmczSlBaSW5TQ1RtS1FleTE4?=
 =?utf-8?B?UUNNRlhWdXFqTkxYUTdvbVVQem52b2dPcGhabWw4RnA2MzBDV2d2blkwMkVY?=
 =?utf-8?B?Tzd5bUIreDh6MVJnWjBROWlkSmlwYWtoUllKdmtDVVdvY21XUmdpTXViMktm?=
 =?utf-8?B?dG93MGNvZ0pjWExTYTNUdG5YN29OMFMvVXFkMnZxcEJOT1dMTVRwbkU3NkVR?=
 =?utf-8?B?bE55dmN6VGdwQmxOWHM2T0lPRFFESU8rR1AyNjBucXM0SE9FVHFIN3JHWHQ1?=
 =?utf-8?B?alR5UUwzZHIwOUF4dTJYV21QVFZDNmVZUWlBanRDVTBZSERMMDdZMWFTTUh6?=
 =?utf-8?B?WFE1UENBWkhTMVV1ZDU0NFA2dTZQeU5uVkgyK0dINDBsaUZjWGRabXdYa0Iw?=
 =?utf-8?B?OHBrTGVkOWw4MjZCZ0d2Mm5GNldtbFhFeTBNYUtJWmRzMDk1aGpvalNrelF3?=
 =?utf-8?B?aWxFcm9scmhNWkZOS2Vka3A3OXVySGRtY1diai90d0ZsaGJNeTVlNGI3Wmtz?=
 =?utf-8?B?Nm9LSG9TMXZPTmNkSU5Fc2k3ZGJIUUR4S3ZtMEh4S0FHZ3FmM08rZCtjVFdy?=
 =?utf-8?B?UHU1eU5lTU5RL256SEliQlcrVmdLN3NkZ0haRHJxelVhMmkwTUJZWHR6Tnpl?=
 =?utf-8?B?ZnpjZUtOQmx3MUJXcEdtbExJYkxJNzNGaUVycTllOU5uYnR6cWd5YkF4REE4?=
 =?utf-8?B?NVJjYkg5aThKQTJVREhVVUZySGhKbWVuSU5JNzI0b1J2ZEQyd0J4TXNkSEFO?=
 =?utf-8?B?ak9vR3lab3dPVW9LT3lYWnEzZkt0dWFQZExac01wMmNMTUlDS2U4TjRTU2tH?=
 =?utf-8?B?MGFqNWphYUFnNHk1cis1S25XUHNRTTQvZ09YYkl1UnBRaG1nSkpTY05HOUNO?=
 =?utf-8?B?cVJPZWVjNjRtWXZhbkxsR2gzK0VQK2VYa0RYUkVTT1krSlpXVzFMcGtETzlS?=
 =?utf-8?B?VGg1UkpOakc4MEJ4TXFlaUt5dlJlQjRKRFZTa0VPY2lCenlueXY3alZxUzBj?=
 =?utf-8?B?cmxXRGUySkt3aDhZVTlISUM2MTNmRlEvUG9ZcDZ3NlR5T0ZTZEdpQ3JuOStY?=
 =?utf-8?B?OGlWRGlJcitML0w2THRkRUJ5cTY0UDQybDI1YnBISVhJMlJYNCs0VWRsLytK?=
 =?utf-8?B?dXY5U2JjZzUwT1B0ZUlmeWk1dkNkTDJNVjYzbEYrQ2NuaEp5dkhmaEZVTVRy?=
 =?utf-8?B?cnpkaCtCZU5zYThraXg2Q0IvK2hhRUdIWDliNmRZZzR1S3p1cDZDcVBrUmZv?=
 =?utf-8?B?NE1jZXNPMlAwNXdMSHZhZ3laWXN3ZEJMVStZdzRrMmRGNEUxWEJ0SzJ1bnUv?=
 =?utf-8?B?NFV0c1EzNkt3bFV4eC8ybCtvQVlJZmk5VTJrY3YwaVhzN3YyaHpiajVjdU1w?=
 =?utf-8?B?OURteXdYdkxDSzErZWlFcUtjZVU3SDVoVEw4bGVLZEgyZHYvM2lMSGZsNUoz?=
 =?utf-8?B?K0tXamwzTXR3aTJ4SXk5bUN0WlFpcVcyYlFRa3RJbkdoQXhLQXZJODRZUmxG?=
 =?utf-8?B?MmZhWWJ4L0grRmYzcWRRWjlHeklLaHJ1dEdTKzVPc0JuMHY0SHBRS0krMkhI?=
 =?utf-8?B?R0FnRU4xU1JXM3JnTmgzWm9EM21JZDlvejdjbmk3NS9CM29GQTBmQWdwUmtt?=
 =?utf-8?B?Z2YrWkdodVd6d2hzcEtiS0JhYytqTmozZXhqbDY5V2JwWUFDbGVlZlBuQVFp?=
 =?utf-8?B?WGNjWmpGQ1Jsa2RtUWJDbS96RkdOSE14THAzaUhZWXBRUHU2Y08vOWZ2NjNJ?=
 =?utf-8?B?NE1POHpCcEVjTllqNXNtclBWaVVrQVJIYzhuZ2RJK2pzYVUzTndyb2FRQ1ZB?=
 =?utf-8?Q?qD1lysDc8O4EZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDRzMXRoVHF5TjNodkdkTjlrSjdBYmhtcjJyb3BGVno2WVdtVDJRM1FIMHBt?=
 =?utf-8?B?SS9FRjJoS2xYL0Q2NWVYenA4cEU4L2s2eEE2WEY1N0h0bnIwU3pHaGVJdE9j?=
 =?utf-8?B?K21tUkd5ZVZhOXFaTUxEWkF2V0paQ0JMMVVQQ0hsUWNETSs3dDd4WWFHOGov?=
 =?utf-8?B?aUNoR2xuaUhDOWZMTGpzeitHdWhHUFRMaWhTRitjRkhKS3FOeUtjQnNNa0li?=
 =?utf-8?B?RGhmT3htdmpYNVBIZUJVaHlnQ1dDV01iMWVMOERFWTd0b0k3T3MxT2Evcksv?=
 =?utf-8?B?Ty9KaFVLeGpmY0VRZTRNY3dkb290OWIvMDNCTDF3ckpacUVZUER6eFRvenY2?=
 =?utf-8?B?VmJFVXV6Ynd0TnpwYnZ0UE5Wb1RJb3VkQ2dGS2R3OXROazM4Y2laNldjYVYz?=
 =?utf-8?B?dWRuYVVUb054a2haWU4zM3VkazR6TTA5TWRRZWJJNTIyYyswN0VNejFpQVYv?=
 =?utf-8?B?NGpUWDBueSt6am0vMGprWTBMZ2J2UllDdWQ5T0U3SG4vZjZ4cElkNDBNY0xw?=
 =?utf-8?B?eHZaazBrMUlhSnBVTG95cDJZM3BXdjVRRlM1ajM2VENOQlFSZ3B6dEw1L3hr?=
 =?utf-8?B?cWVCT3lQQ1R3T3pYZGZBMHQvVG1Ra01hT01vOFFPaVZBV2E2UFZ0NkRwYXkv?=
 =?utf-8?B?dGxjZVBxck9mNWk4Rkp5bmdDNlZuZ0lpWmlvRFlMRE1TazFENys5Y1E4Mnk4?=
 =?utf-8?B?bzJSVEg3ek5OYlI1YWVEVi91R3FuM1BWMVVJSDdMWXEwTG1kQ0hBcXh3akkx?=
 =?utf-8?B?RU94NFVHYk1uVjJqZ2NpMmYwNk02d00vQmJqRnIyNHJzYVE4Y2w5a1dxczc0?=
 =?utf-8?B?dFJUN3AzRzNnZGdqRDZLV21hRmJrcFpjTEJEMzBrUXVzS3ZqSzJKZEhpVkhR?=
 =?utf-8?B?MzNkMzhva2NwMHl0aStRVDY3WFlNVG1sdHRBb0pzOW5lTUZXU3ArOEw5dUkx?=
 =?utf-8?B?TmwxZXBHRWdreStMemQvR1oydW8zLzJ2MXdYaGsyRkU5Y3ZweHhSaFczV1hy?=
 =?utf-8?B?dUlkdGNDSDZmT0h1dzdNUGhMa3dQeDlFU1VKd1lQK3R3SHNEMDJwOFNTZnhH?=
 =?utf-8?B?bzdJRnI1VWt4bFZlS0Q4TnlFNitVcW1rcWpwM3BoU3NvWWRvNzE0Z2QxZ3JV?=
 =?utf-8?B?cFhqMXBhWmppdnI4eEtXNzlPaEJ2RzJqeUJnS0JBell3eTQrMDJuWlVtZm5h?=
 =?utf-8?B?ZHc1Ykg3QWxVY0NsV3l3YnlLWUFGa2NvbHFBUk5PZ0VZaHFmZHF0a21zMG1w?=
 =?utf-8?B?V0hZWnN3Ri9qVVo3REhpSmR5eHNtNWpVZ0QzdzdQS0NxZDF4VFJEck0zMllt?=
 =?utf-8?B?VzZ1bU04V2hRTUNlUXdVV3QrcjBtb3ZGcnFNdGMyUC9UYitOMVVTL1VrRTV3?=
 =?utf-8?B?S0lKakdPeGdJNUYyS0lTWkdYaFpqVjFVeDRHUDg1L1VFZFNSY3FFSlFKcHZK?=
 =?utf-8?B?NDhTWFlLR2R5RlFOYitMMGl6b1RwdWlBSWtQYmJWOVZyLy8yMWlRMGI3dlcx?=
 =?utf-8?B?WTI4eFN1SWh6aGJEZ2UvU21abjBVQTV4V1BaalA3c3NScHpkOHFqaW9IVndm?=
 =?utf-8?B?MzRRaVd2RmhlbkJKWDZ5ZnZlQnVWYWc2RmVmU1pDUlVOWlBGOUlPVSs5RXh1?=
 =?utf-8?B?SDJyUC8vemJDb1FMK2wrOUxWUS93aWlyd2grZ3A1MnJKM1F6Wm91OVE4MDly?=
 =?utf-8?B?QjZJMTFhL1NjUUNCb0cza2UrOUlSUXR1K25EaU1aTk56V2ZMZWoxQm94Tkpp?=
 =?utf-8?B?Q0E5K291QkF0MWw0bUc1QWF4TFJzditXYjI0emhEanBGSTUvQ3FERFVxODM5?=
 =?utf-8?B?TkpsMVZ3M3h6cGdPcVp0a3lSUTdmMGpxQ3A5b3J2ZWtacEV1bDY4Rk5sMmhP?=
 =?utf-8?B?amhZTUp5TWJnL2V6Z0RObThDS25QbExIQWRkcUJCVUFoYUd2cDkxSWl1eWFP?=
 =?utf-8?B?M3o3K3RUMmY0aEpxVFh3RDlZVDBJT292Y2lFRDlZcDQ1YnBtZ2Y4VGU4VFhW?=
 =?utf-8?B?ZVlJNEY5YjAwS0ZGRDJybkRFUWRLTHV3WDBYVFMvT0ZNYmRVMDJKa0pHQmRO?=
 =?utf-8?B?VVZ0Tk93NFFITnRodnlRZ004Wlg1Uk1qc2Y2SHc5ZTNsOTdCUHVPeUJoelAy?=
 =?utf-8?Q?ut/b4+P1dzQtMQ9AZxMxlDiuk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cUyPmbXRujMXMKztSoPVGTnoMR/R9+CaKpAGabXurzyBHVoQdfsYBdmoiILiCigolBoUw7mKMPMJxsVBW/vO+ZtaZ6i/xVGN5BMZcQiuGLIoEO6iL52g+7nxNJg9W3FHqpWn5zBs+v098al68DKN6JJy1yhn9Gho/s/pkIHcfIbjrEMXNy+AovR4AQhNJkHtgw4NxHsGPS7zpH/aiomxkeXYMu1fOGil+OhKWcG97Eb24hwGStBDSaRvE4EB/XBX7C46lF3atdapAMQ21GMfJo/LrNzwFGes0YRzYEhrNOmvcgCf5s15QyBBCocF2BJQkaWeut9q5fx9aByOUw0kL3/TGONz0QawM9B7hPW9Fwf4rciqHh96sxl+WJXA1vXJ/ynIWBDWmm3yTF0DMiKhR3xUeTEMByFluAqbACYu7Xcav2ssdKPblf29mCGiv2q8NL/gLC+CMtqGSgZ3ntzR76Tyi1IH+WMaEvDs1ZwRXCm51xboVat+CZrJRdagQSVx5VxcgebnYesWaHtj6YMEcrxGA0yhNWpE3wA0b18qDxijSubbEApMh9vA0H8HFlNI+jX1kRPpGegWXNoiq1hFRKC8sy7zaZbjvZ5slMHkQ+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817b9dbd-e8c9-4208-0168-08dd3fbb64b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 16:47:04.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgooFErCEgsAUjvE1ZWqm/SYvoX2soJOqcYzI1LfG1fnYCNPozUOEy76EmMWyepZ1iUPW/V+czyj8KQD8klfOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280124
X-Proofpoint-GUID: P-M738-bvt5oXYqVRl9aVydHlH2nd53Q
X-Proofpoint-ORIG-GUID: P-M738-bvt5oXYqVRl9aVydHlH2nd53Q

On 15/01/2025 11:46, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Currently, it's hard to know whether the storage device supports unmap
> write zeroes. We cannot determine it only by checking if the disk
> supports the write zeroes command, as for some HDDs that do submit
> actual zeros to the disk media even if they claim to support the write
> zeroes command, but that should be very slow.

This second sentence is too long, such that your meaning is hard to 
understand.

> 
> Therefor, add a new queue limit feature, BLK_FEAT_WRITE_ZEROES_UNMAP and

Therefore?

> the corresponding sysfs entry, to indicate whether the block device
> explicitly supports the unmapped write zeroes command. Each device
> driver should set this bit if it is certain that the attached disk
> supports this command. 

How can they be certain? You already wrote that some claim to support 
it, yet don't really. Well, I think that is what you meant.

> If the bit is not set, the disk either does not
> support it, or its support status is unknown.
> 
> For the stacked devices cases, the BLK_FEAT_WRITE_ZEROES_UNMAP should be
> supported both by the stacking driver and all underlying devices.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>   Documentation/ABI/stable/sysfs-block | 14 ++++++++++++++
>   block/blk-settings.c                 |  6 ++++++
>   block/blk-sysfs.c                    |  3 +++
>   include/linux/blkdev.h               |  3 +++
>   4 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 0cceb2badc83..ab4117cefd9a 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -722,6 +722,20 @@ Description:
>   		0, write zeroes is not supported by the device.
>   
>   
> +What:		/sys/block/<disk>/queue/write_zeroes_unmap
> +Date:		January 2025
> +Contact:	Zhang Yi <yi.zhang@huawei.com>
> +Description:
> +		[RO] Devices that explicitly support the unmap write zeroes
> +		operation in which a single write zeroes request with the unmap
> +		bit set to zero out the range of contiguous blocks on storage

which bit are you referring to?

> +		by freeing blocks, rather than writing physical zeroes to the
> +		media. If write_zeroes_unmap is 1, this indicates that the
> +		device explicitly supports the write zero command. Otherwise,
> +		the device either does not support it, or its support status is
> +		unknown.

I am struggling to understand the full meaning of a value of '0'.

Does it means that either:
a. it does not support write zero
b. it does support write zero, yet just did not set 
BLK_FEAT_WRITE_ZEROES_UNMAP


> +
> +
>   What:		/sys/block/<disk>/queue/zone_append_max_bytes
>   Date:		May 2020
>   Contact:	linux-block@vger.kernel.org
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 8f09e33f41f6..a8bf2f8f0634 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -652,6 +652,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>   		t->features &= ~BLK_FEAT_NOWAIT;
>   	if (!(b->features & BLK_FEAT_POLL))
>   		t->features &= ~BLK_FEAT_POLL;
> +	if (!(b->features & BLK_FEAT_WRITE_ZEROES_UNMAP))
> +		t->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;

Why not just set this in BLK_FEAT_INHERIT_MASK? It's seems like a 
sensible thing to do...

>   
>   	t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
>   
> @@ -774,6 +776,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>   		t->zone_write_granularity = 0;
>   		t->max_zone_append_sectors = 0;
>   	}
> +
> +	if (!t->max_write_zeroes_sectors)
> +		t->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
> +
>   	blk_stack_atomic_writes_limits(t, b);
>   
>   	return ret;
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 767598e719ab..13f22bee19d2 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -248,6 +248,7 @@ static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
>   QUEUE_SYSFS_FEATURE_SHOW(poll, BLK_FEAT_POLL);
>   QUEUE_SYSFS_FEATURE_SHOW(fua, BLK_FEAT_FUA);
>   QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
> +QUEUE_SYSFS_FEATURE_SHOW(write_zeroes_unmap, BLK_FEAT_WRITE_ZEROES_UNMAP);
>   
>   static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
>   {
> @@ -468,6 +469,7 @@ QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
>   
>   QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
>   QUEUE_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
> +QUEUE_RO_ENTRY(queue_write_zeroes_unmap, "write_zeroes_unmap");
>   QUEUE_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
>   QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
>   
> @@ -615,6 +617,7 @@ static struct attribute *queue_attrs[] = {
>   	&queue_poll_delay_entry.attr,
>   	&queue_virt_boundary_mask_entry.attr,
>   	&queue_dma_alignment_entry.attr,
> +	&queue_write_zeroes_unmap_entry.attr,
>   	NULL,
>   };
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 378d3a1a22fc..14ba1e2709bb 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -335,6 +335,9 @@ typedef unsigned int __bitwise blk_features_t;
>   #define BLK_FEAT_ATOMIC_WRITES_STACKED \
>   	((__force blk_features_t)(1u << 16))
>   
> +/* supports unmap write zeroes command */
> +#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))

Is this flag ever checked within the kernel?

If not, I assume your idea is that the user checks this flag via sysfs 
for the block device which the fs is mounted on just to know if 
FALLOC_FL_WRITE_ZEROES is definitely fast, right?

> +
>   /*
>    * Flags automatically inherited when stacking limits.
>    */


