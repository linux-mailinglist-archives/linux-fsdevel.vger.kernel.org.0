Return-Path: <linux-fsdevel+bounces-51325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC9AD5860
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 16:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1C61BC42AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD128A1D9;
	Wed, 11 Jun 2025 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lN98eFM/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qPa6n+bC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706681885B4;
	Wed, 11 Jun 2025 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651417; cv=fail; b=l7MvA+4jPCX/yidViPNAPIkls+2TjaqBqtRtTYudwRiGXa+eK4qkw18iffsWxORDncOf+KIqJVjdpdOXR54jaYVM1Q8nwRxFnCuoNf2F1WDNYKoaret1lVupfC59PPigKp3RAI+HmOEizoIw8RhgR/GtCjx3zDG1KAqp8c9uDOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651417; c=relaxed/simple;
	bh=RjfAFbknwSABICnirmaTkRaZGk/SF2YUhPjrLfsXpNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kdDKIAs2zvec7A+Gf/j3EpXwg2D8ETCg9sFb0r00PNe5wGmeD1Ky8ShxfoxnFWn+4uP/loBjVuTeMgeZFr/UTxfVtL71qLcHxZZEfJ6k6T/RZtNhe7wyBcCO37e1sbRFuwhOmsVk/8PvsdKQI55b1+p1KIw7i9QlDZrIX8iY1w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lN98eFM/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qPa6n+bC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BCtVoa006774;
	Wed, 11 Jun 2025 14:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YtpSOU2vbokOUixJxRW2/zIww7x09kPmg6UhbZuzd2o=; b=
	lN98eFM/K2QgQKEGdisRkbS9/iN8v7bxPB2wL4/mqQiZW1AtV+DuRMfEHFbRVpxA
	gROlHv+ht53LYbANoULN1Y8dt1yG6iUxw9r3+QwhpkIo4Njq26eyrYrzHHmWhNc0
	GsnxN+CoREMtB1XhX9C0/4kA09gAZ8aLJwYJJx+ANovAhhCdRY+VNIutGg6reqXd
	TjySyfN/+0SSCquDrwXqjCW6jWZL9QPNG/8V12biD8iAPp9Y1D5QE2Q9UEUIMUa3
	NdpPta9s/xORymGd3LDYuPag7aWXlU6tW4uK/zHZMh6klPotrp5sk9vqhid8PqsM
	Npvam5v0KnonxquVIblTZg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjxpnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:16:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BDlAEx021009;
	Wed, 11 Jun 2025 14:16:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvgfybt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDlpkY3Eyzok3GklrT7r4kmlyprS/nW2e8E6ij4J8Xlp4ABNsJ8bx4aj55YLI/n2NABtd4II7F3AS7JN1axL2hCWSd6iAgupiDKMjPsRj8uQ5ZNE3tiLKpkkgT4H/BAm3TCICX4rdU/5o/GkRDeJXb3E/N5HbRxduFVi/Wf9tsnds2jRp6QlK+zrZAlhT2ASPmoZl8twOnR7K9CE0kk0gHqVhRAUAEpIay1xHM1SXQrOa1hqNWP2RjIsnqsWLKoqbp1D5rpQAH5G8DYbRmGOtGSgteZpYGEHYZALE3FYBP5t6qhH7K7CqSrQPnvvanWIXOuM8qghxqaR8NSOqC/niA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtpSOU2vbokOUixJxRW2/zIww7x09kPmg6UhbZuzd2o=;
 b=c104CP6+eHP5mMkfjnap8PbjGYv2oJvbh3MZ/5Gmo2tGg3hRyVrR++HLpArpbvMR1rOeihnNkjEyIOESGGhhHfLeEnFuurMCBKx42z7uLEc/ceQhpBwKve7uTJ6NMT7w9UjPzVeJhs8OoZNcboqhN52R2vf5ctg87hXdX0sMjV7lr3syjelcCE870c/+IMvZ4Hdl3DzQJdotsnnVVJV79wLA8vgEK58IGREyxoffr/4rBA+PuDqSMJGuCrPio0DTmC+GvqpLjyEoiBA6OvPuF2oSpOBa8Oyea89++KR4peBrdxuHnDpAe7rgd3Mu80lHx57b5d0wpPQEbpI7wkH1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtpSOU2vbokOUixJxRW2/zIww7x09kPmg6UhbZuzd2o=;
 b=qPa6n+bC0QKbXzLM+YJaY/x+DG9zYu80av5IX6tk7hwFwPgBkPiIwuxj9KDXEXHay4WAnBIszKUG3N3tcNKntwnoVakjWx9593SdcgrwyvAqJX8umSuH9isg/2UL9FjcBj+woA+KfUkPCxBBMNeVO+6XMuEeE71TnGQSu2CBv/s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5999.namprd10.prod.outlook.com (2603:10b6:8:9d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 14:16:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 14:16:41 +0000
Message-ID: <9f96291b-3a87-47db-a037-c1d996ea37c0@oracle.com>
Date: Wed, 11 Jun 2025 10:16:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] NFSD: add enable-dontcache and initially use it to
 add DIO support
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250610205737.63343-1-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b47380c-ba74-4d45-878b-08dda8f29606
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Y090Zld3ZFgyU3A0MDlBOGU3ZHRzVVZXdjBNRmVHVmVvTTl3QVlHMXNMNVor?=
 =?utf-8?B?dmhObmV1QUM3THdwbEFzUlhMMmptM3QrVTN0Z3o1NXlRY0dWeVh2eEZMVHZv?=
 =?utf-8?B?STBXeGRFWmdZam9JREduMHpCQ0NuUkNMWC9KbHZwSndtVE5iNE01NDdrZS93?=
 =?utf-8?B?RUVydWNVZ1p0Njh6ZHZjRzVMeWlVTW0rcFB1RFZYcVFYcDVUOVp3R0p0aU00?=
 =?utf-8?B?YSthYmR6aktweGJWMEp2M2FwMm12bFoxTjYwamFnN1o2UGpVN1d2ZW9BSmVx?=
 =?utf-8?B?ekl4Ym5JenVxWlZRTnBiL2JQUHdnaUR2WEVpcTROWFMxM3E1aGpuNFIvbmo2?=
 =?utf-8?B?SXpWdS9IRjNPSUdwcGVkN2oxblNQUjcyVUlTeEc4ZWxHZ3RQRnRBNjhPUGNC?=
 =?utf-8?B?VCtOYVhOdUVuMlN6N3pUdFp0Qi9LczBlTzFMNmxscnFrbHYzVXhSZjY1SFpo?=
 =?utf-8?B?bGZzZFZaR0dza0NzNC9lTEUrbHhsa2Z1U3VkUHdSeDdjNkFsTHlEWFdLZzFM?=
 =?utf-8?B?bTFNWko2U3VtM095b3RDT1VXcmJ1QWVJeUF5eWhHL3lLZlZ3djdnZWhjRExC?=
 =?utf-8?B?d1JzVW42NUlsdFVSOXdhRkdlMU91UjlNNWhLNmljSVhRS0pUK3IwcU1KTmJ4?=
 =?utf-8?B?RWJNK0JISmNVOUtxM0UrakpHL25rMjNiSlJ5MGpjcnJVWHV2K2tOWjM1ZEt1?=
 =?utf-8?B?VXo3d3RTZjVVeEtxQVc3TDcyNkFLTC9xQVRRQS9HVG5PYVNoVU1PS0F4cDJV?=
 =?utf-8?B?bnZRZ3VFRFlNQnZhL0JQaUZ4KzBCUFhENGMwdTNXd0ZNdDk2bnpVR1VpQTA0?=
 =?utf-8?B?Q3Qrck9zWkk0eWR2bWZRUFN3SUFYaWlGdnloVnNzR0ovc2lFdjM1RWxYdEgv?=
 =?utf-8?B?RnM1ZVJPWmlFbEJPSm9NS1lnaWV1VnJGQXRxWXJONHNlanlXdlJBY2lFWkhy?=
 =?utf-8?B?NmFFQmFHWWtEV3Q2OVpVT1VSSWhWNWw5bFpQL1JITXF5SGNRR3RmajVuVEZW?=
 =?utf-8?B?MGM5T2hrc04yU25mNmlTc2VZTFFnc1NiZmpjUzBqUWx6d3F2VnFUdndnSHg5?=
 =?utf-8?B?NmJtK0dxY3hwZDFYN3FWRVNMYXFCcmNuVGtHRjdocUczZHp3Z09tQ0E2akNp?=
 =?utf-8?B?WDJEeERRbjVCOVliZ0FDai81T3liK3luZ3lPcTlYWDFjQU4zOW8yMDhXYjds?=
 =?utf-8?B?clVreUZsYWhVWEZUdUNHTSsvRXJmMUxVTGY2SXRnUDdkSkJDR2VQUFFtWEJ4?=
 =?utf-8?B?MU1GcHY0SzhoWi9hdG5sb0xFbTVYL3hKeWUwV01WRnI2Z3NsZWM3S3d6dXdy?=
 =?utf-8?B?cXR1dXJWMzZQUDgrano0VGFrTFhEbEFFL1JDTWgvQ3oxcFVxeXFkS3c5QitO?=
 =?utf-8?B?YVJJRkplOGQwSlh6eHlUZ2s3cXhUOFNRc002RnFub2w2ekhVNitOZUFiUU1l?=
 =?utf-8?B?OHBjTUc1VDFmajNleDh4em5uVU5CMnFBeXljaVFLdTJVTkxGd2pQd2w5SW1t?=
 =?utf-8?B?dHFzTzJJQnRDbTdiWWgyZmxqUnVhU3VuZVpVaDM1WWlhVno1emZFREpFM2pN?=
 =?utf-8?B?bEpxTFFlRUVsOXRDZ0h0YXQ3NDJRVmVUUUFEVW9TZG5HVHYraUdBVjhUTlBn?=
 =?utf-8?B?RTExaGtZUmkvV2p0RmZSa1dISkxONE1kVEZ6SFV1K3A4N2RrVmxHa1JKMWlX?=
 =?utf-8?B?RFlVamg0T0g4NDdTTExkcG51ZmJ2UjlVR2xqcG9WNFRyVzB2NHRWeVRlUk5i?=
 =?utf-8?B?aEo4NDRCMlc0Z2ppWjFOQXZpd2ludFJnRk13dlRxeEw1UEorZjFDai8xSEly?=
 =?utf-8?B?R2ZSWGphcEJDZkEvTkxnT2c0TEEwd0wraXlGT1hYOHJJUUZKaVQ2cXh4N0Jl?=
 =?utf-8?B?VjJJekJIUk92UVpoTEhQbE9VWkl1T09BTS8wSVFRS2Q0bnoyVXdkc3Z0bXN4?=
 =?utf-8?Q?jfQ8DV6tvuw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U0N3NnR6Vlh3R3dvMnl2Q001Q1o2bkZYVjVwcjBzT3RYUDJpMFYwNklkOUs1?=
 =?utf-8?B?WkJLM0xxdms3aUlFKytYc1NZMEZwZEw4dVVSKzFUZUVYc3hCa1N1QWRNbVkw?=
 =?utf-8?B?ckFKWW1ZaEJ4SStFV3ZyczV5dEtva0J5NVBLT3FGNzFQSk1wblgwbG5oK2Zq?=
 =?utf-8?B?REFvQSt3bnhnc2pDQ0U3WFM0WTBBRlc5UzhHVnJRWThsMndOU3JXT1BVVW93?=
 =?utf-8?B?eTB2ZmNoMTZraUhIeGlHRjRWc1hRdk9ZeFF0bENveTYvK2FJcy9YUHhiUWo5?=
 =?utf-8?B?SlE1LzQ2YUxNVDBYTVJHc2RmeTF5aG1TM3MwMmt5cHZYRS9Nd0J4ZmZ2SE9y?=
 =?utf-8?B?ZnBteDUrVm0wWDBZWnFhWmdmK3dWZlZ6Sm84MlJoU3QzVGxNNytHYklOOGMy?=
 =?utf-8?B?RUZOMjVtRXFmNlRkL3JjOU0wUWw5a25qdjVoMi9zTk5DVURBVE5TNUxIZjJj?=
 =?utf-8?B?Rkx2N0czM0dEU05neFE0WDhidmNWd1B0ajFLUDlUY1Z6VW4va2F0c0dabk1x?=
 =?utf-8?B?UWkzMXJoeCtuQ3V6a3NDOGJEWkN1VkVaNUE4ejkrOHVkOUV6eVpyYXhMdDhJ?=
 =?utf-8?B?SENRQlFsUm5iTjlGSUhjVHp2bVh4ajlTWXhlOXU0dGhnT3ZPMGZTWUZlaWU3?=
 =?utf-8?B?ekt0QnQ5end1SDFyREVwM290OVNKdGRGL1ZMTVZxRUhpT3JIM2hiYXZ1R0dH?=
 =?utf-8?B?MGNEWDdnSVZ5c3Bnc3ZWbWJaL09ZYkJCWUF1VnVSU3J1bVNDdEV6Y25oOGVw?=
 =?utf-8?B?MGkrOWpUdFkrT3pMUUNjSlFUa0dCY3c0SlY0NlNKQTcvZlZlbkNsdndxRGIv?=
 =?utf-8?B?NDZaVTBuOWV5UkdNWjltU09zcGNxZmpkYXBSQm9QQ0lkLy8yQ0NJL0ZOUEF1?=
 =?utf-8?B?SkJtUmNsK0dhemZuRDZKcERyRk42bWpvdXJOTml5U2VvQnhlNS95dlFIV1BD?=
 =?utf-8?B?d0FQWE14RUJZTHpUZ1g3SDRReU9ZZm1wN3hiaDhrQWxFYi9XLzZ5ZWM4cjh0?=
 =?utf-8?B?SmN2SUZvc3p0bERnYkVZNGlWcWFhVGNtWUVZL1BPTkdQVkhvYk5aSnNUK0tj?=
 =?utf-8?B?R2UwMGtaTHZaQVIzcU16RFYvT0FRL1UrMGFHaXNHN1oyY0JoSFV6NUFvR2dl?=
 =?utf-8?B?bkFZenJkUGNsY2huQlZpZWV1ZjAxbWVmTjZNY2x0N3U0a2E2UCt2aWl0cHpB?=
 =?utf-8?B?UmFPeTFaTTdSekhUSWxkKzRFYXJjRVFEYndSSzRRR1hDbmMyN1U0TU1MWUls?=
 =?utf-8?B?cnlsOEtVNXE1VWZwZFBleVE1QlpCckhhMEtteTYyZDRWbDVpcG1weDhHTWV2?=
 =?utf-8?B?Z2RHMGNlcU1YcGNoZjRxcVlxQUlTMC9OaEVQVWYxQnF3OVF6UWFVVDcvemZS?=
 =?utf-8?B?QWd2blhOdTV4LzkzaXlSVGx0VllORE5DaktpdU5YWWVMSWJLSFlaTEtWUFNu?=
 =?utf-8?B?ejF1VTBOa1JvcTlITUxicmk4MElLUmdEaENqWEF6S1Vvd2Q5YnV3M2s2NWZ3?=
 =?utf-8?B?ZlBlSGluVGpaS1Z3eU8rUkhQWFNUWXFmclhzeUZ6OUFIWmpLWG02Z1dkWG5n?=
 =?utf-8?B?WGdxV2NSbGZyY0JKZFRkRXFPazcvazdhQk9LSXBIanZBU3JTczFzZTBUaE56?=
 =?utf-8?B?V0hTeGJZUlFzZS80Q0V1NDhRRWxycFdScXVZVm8wNEErMnY2Q1E4a0grRW01?=
 =?utf-8?B?MmVOWVlpUFZieVNCN3lvdGQvQWxzTHBXMTRTYmpaZXFhMkdjd044RE9UYk9i?=
 =?utf-8?B?K3h2UjNETUtDYUNReWxTQW1SZFJQSDVuK1B3S2xuNjRrcGQyZERlKzFaU1lm?=
 =?utf-8?B?NlhrTll3V1lSckoyNGFLcE02UlZZcE5hSVcxdDBtUVl6NDFlL25ncm45blVj?=
 =?utf-8?B?aW1ERHZoemhKWWo5VzlER3hybVNsazFEcWtFR2FKNTN4VWtaS0FxRE8wb2dU?=
 =?utf-8?B?b0dWWUIwSlFRSHVrL2hoL3lSclVXVFc5K3UzRUV2WnpqdkVPN21HUTNTYzFJ?=
 =?utf-8?B?bGM5TkpNQnBnSmorN1d3SnVBci9Rck5DbFVwTlVLVjVraVMrSGdhRElSSlhZ?=
 =?utf-8?B?aXdxVUpxWEJSYUV4Y3lNNHBadE10TVlpYVFURlpkUWt1aVVCSE1JVHc1YXBk?=
 =?utf-8?Q?EdqbMjytqlSAC1H9HxE7wUbpJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/4E07DZzkyj63w7YwOvgoI18y80QSxqSHGXQUpEWypghx7Glae3rgwtzhzepGrZu2IsvtBAlUaao9jTLhWPbTxl91AxeyeiR9KOWmrzFqzgZmaMwa47EuMYCv/i+4X8CV8pRCx8j98+UDUXotn6VGglbiMk2eZB4govJTd05F2ABEU5BAlL0TFa28xgZ2yKDFsJ9uB42WW4C36T7dM81AvcSqdb3iq/Fomr72BU8pexQjzj7rxn7iP0OuUoOdsv9rRUY2MQZaiawJQwhh907lbfDSXPhTuavrsZwbVADNsfV4o00BKiutLpaeOJldGOShT90epaUtE6cF4a/Iz7siRrBdgDIxkHD0exwS2o0NmFYnGGj6GirdRYA06Zas9v1Qtsi/Fa/n1lw4PW6sOPEntK8H2ji8fedgNV0Kh85RlzoldNR2e9KLe+8U2FI4XSfP2aoW2Wp5OwTTrSRdtxgkYa/I9WwRjleWpYzn2J3anPZx6BZOJRO2UpNUCElTqzlQUaFpLW5FAB7pt1N4P+7ZHdD5VkHKnBSSvD5AMqIauFmxpyxW4J9R2LLBJdKwBdjGqtgYpHuY1HiLBWhNdQ5DS4661e8usuw/00ZSGEaZJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b47380c-ba74-4d45-878b-08dda8f29606
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:16:41.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2R6l8D1Vuwc9l6lNQ2eR1EWEz5jV6RqhL+1nuiO4xvrjoTZGGQxFMCBKpCVAIDCaRBFTf+Yg8j/S1QpyRvtLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110119
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=68498fd0 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=MmVkddRvAAAA:8 a=T9KdYhCr_1QtSGZKqycA:9 a=QEXdDO2ut3YA:10 a=sDnPZfDcMZJXlSf2PV7B:22 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDExOSBTYWx0ZWRfX3IeSf6OxEN8J nPHMXr6G/DYsPN39Lqj/THIgiQF99LWTKNR3koI5eL1UYpWgn//9oLfuVH5rDt+qlWQ1Wd8NBwr ooJH+QO/10dQFWtHUXQVUFhRigeLU01RXDzr76BeXFu/78waRS06ElhXCz5ZsqT9pXLSRKHcXoU
 Z7Ms26ocNhzpMT571/frI/7j53EiSMuEYLEDMRYp0muBdpJnO8up3aS7IlihBowwrLoYprOnsW0 SyyTpAa+DUptbTdfSublkjYyruKkQStQsVVUb6K57j2cQ4NDM/kF64bcAaua4n6UQDlk6E94f0v gcpHbwcl+9ByNQoZFYyt9ADYEMXGQLTM0NxfDIC9lRpQAnLrJD+EAv7gNCZDrhEuTJk2NSR67MB
 rNE/fw/s4w2RXGfkPFxFnyma5bV1Hj2jz/pIB+sF7kudYrdocWx3lngs+Mo+yZguYxqnObnD
X-Proofpoint-ORIG-GUID: rKBdMS7bnK9QJGHmdlTa7_O7s3pR1cHb
X-Proofpoint-GUID: rKBdMS7bnK9QJGHmdlTa7_O7s3pR1cHb

On 6/10/25 4:57 PM, Mike Snitzer wrote:
> Hi,
> 
> This series introduces 'enable-dontcache' to NFSD's debugfs interface,
> once enabled NFSD will selectively make use of O_DIRECT when issuing
> read and write IO:
> - all READs will use O_DIRECT (both aligned and misaligned)
> - all DIO-aligned WRITEs will use O_DIRECT (useful for SUNRPC RDMA)
> - misaligned WRITEs currently continue to use normal buffered IO
> 
> Q: Why not actually use RWF_DONTCACHE (yet)?
> A: 
> If IO can is properly DIO-aligned, or can be made to be, using
> O_DIRECT is preferred over DONTCACHE because of its reduced CPU and
> memory usage.  Relative to NFSD using RWF_DONTCACHE for misaligned
> WRITEs, I've briefly discussed with Jens that follow-on dontcache work
> is needed to justify falling back to actually using RWF_DONTCACHE.
> Specifically, Hammerspace benchmarking has confirmed as Jeff Layton
> suggested at Bakeathon, we need dontcache to be enhanced to not
> immediately dropbehind when IO completes -- because it works against
> us (due to RMW needing to read without benefit of cache), whereas
> buffered IO enables misaligned IO to be more performant. Jens thought
> that delayed dropbehind is certainly doable but that he needed to
> reason through it further (so timing on availability is TBD). As soon
> as it is possible I'll happily switch NFSD's misaligned write IO
> fallback from normal buffered IO to actually using RWF_DONTCACHE.
> 
> Continuing with what this patchset provides:
> 
> NFSD now uses STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get and store
> DIO alignment attributes from underlying filesystem in associated
> nfsd_file.  This is done when the nfsd_file is first opened for a
> regular file.
> 
> A new RWF_DIRECT flag is added to include/uapi/linux/fs.h to allow
> NFSD to use O_DIRECT on a per-IO basis.
> 
> If enable-dontcache=1 then RWF_DIRECT will be set for all READ IO
> (even if the IO is misaligned, thanks to expanding the read to be
> aligned for use with DIO, as suggested by Jeff and Chuck at the NFS
> Bakeathon held recently in Ann Arbor).
> 
> NFSD will also set RWF_DIRECT if a WRITE's IO is aligned relative to
> DIO alignment (both page and disk alignment).  This works quite well
> for aligned WRITE IO with SUNRPC's RDMA transport as-is, because it
> maps the WRITE payload into aligned pages. But more work is needed to
> be able to leverage O_DIRECT when SUNRPC's regular TCP transport is
> used. I spent quite a bit of time analyzing the existing xdr_buf code
> and NFSD's use of it.  Unfortunately, the WRITE payload gets stored in
> misaligned pages such that O_DIRECT isn't possible without a copy
> (completely defeating the point).  I'll reply to this cover letter to
> start a subthread to discuss how best to deal with misaligned write
> IO (by association with Hammerspace, I'm most interested in NFS v3).
> 
> Performance benefits of using O_DIRECT in NFSD:
> 
> Hammerspace's testbed was 10 NFS servers connected via 800Gbit
> RDMA networking (mlx5_core), each with 1TB of memory, 48 cores (2 NUMA
> nodes) and 8 ScaleFlux NVMe devices (each with two 3.5TB namespaces.
> Theoretical max for reads per NVMe device is 14GB/s, or ~7GB/s per
> namespace).
> 
> And 10 client systems each running 64 IO threads.
> 
> The O_DIRECT performance win is pretty fantastic thanks to reduced CPU
> and memory use, particularly for workloads with a working set that far
> exceeds the available memory of a given server.  This patchset's
> changes (though patch 5, patch 6 wasn't written until after
> benchmarking performed) enabled Hammerspace to improve its IO500.org
> benchmark result (as submitted for this week's ISC 2025 in Hamburg,
> Germany) by 25%.
> 
> That 25% improvement on IO500 is owed to NFS servers seeing:
> - reduced CPU usage from 100% to ~50%
>   O_DIRECT:
>   write: 51% idle, 25% system,   14% IO wait,   2% IRQ
>   read:  55% idle,  9% system, 32.5% IO wait, 1.5% IRQ
>   buffered:
>   write: 17.8% idle, 67.5% system,   8% IO wait,  2% IRQ
>   read:  3.29% idle, 94.2% system, 2.5% IO wait,  1% IRQ
> 
> - reduced memory usage from just under 100% (987GiB for reads, 978GiB
>   for writes) to only ~244 MB for cache+buffer use (for both reads and
>   writes).
>   - buffered would tip-over due to kswapd and kcompactd struggling to
>     find free memory during reclaim.
> 
> - increased NVMe throughtput when comparing O_DIRECT vs buffered:
>   O_DIRECT: 8-10 GB/s for writes, 9-11.8 GB/s for reads
>   buffered: 8 GB/s for writes,    4-5 GB/s for reads
> 
> - abiliy to support more IO threads per client system (from 48 to 64)
> 
> The performance improvement highlight of the numerous individual tests
> in the IO500 collection of benchamrks was in the IOR "easy" test:
> 
> Write:
> O_DIRECT: [RESULT]      ior-easy-write     420.351599 GiB/s : time 869.650 seconds
> CACHED:   [RESULT]      ior-easy-write     368.268722 GiB/s : time 413.647 seconds
> 
> Read: 
> O_DIRECT: [RESULT]      ior-easy-read     446.790791 GiB/s : time 818.219 seconds
> CACHED:   [RESULT]      ior-easy-read     284.706196 GiB/s : time 534.950 seconds
> 
> It is suspected that patch 6 in this patchset will improve IOR "hard"
> read results. The "hard" name comes from the fact that it performs all
> IO using a mislaigned blocksize of 47008 bytes (which happens to be
> the IO size I showed ftrace output for in the 6th patch's header).
> 
> All review and discussion is welcome, thanks!
> Mike
> 
> Mike Snitzer (6):
>   NFSD: add the ability to enable use of RWF_DONTCACHE for all IO
>   NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
>   NFSD: pass nfsd_file to nfsd_iter_read()
>   fs: introduce RWF_DIRECT to allow using O_DIRECT on a per-IO basis
>   NFSD: leverage DIO alignment to selectively issue O_DIRECT reads and writes
>   NFSD: issue READs using O_DIRECT even if IO is misaligned
> 
>  fs/nfsd/debugfs.c          |  39 +++++++++++++
>  fs/nfsd/filecache.c        |  32 +++++++++++
>  fs/nfsd/filecache.h        |   4 ++
>  fs/nfsd/nfs4xdr.c          |   8 +--
>  fs/nfsd/nfsd.h             |   1 +
>  fs/nfsd/trace.h            |  37 +++++++++++++
>  fs/nfsd/vfs.c              | 111 ++++++++++++++++++++++++++++++++++---
>  fs/nfsd/vfs.h              |  17 +-----
>  include/linux/fs.h         |   2 +-
>  include/linux/sunrpc/svc.h |   5 +-
>  include/uapi/linux/fs.h    |   5 +-
>  11 files changed, 231 insertions(+), 30 deletions(-)
> 


Hey Mike!

There's a lot to digest here! A few general comments:

- Since this isn't a series that you intend I should apply immediately
to nfsd-next, let's mark subsequent postings with "RFC".

- Before diving into the history and design, your cover letter should
start with a clear problem statement. What are you trying to fix? I
think that might be what Christoph is missing in his comment on 5/6.
Maybe it's in the cover letter now, but it reads to me like the lede is
buried.

- In addition to the big iron results, I'd like to see benchmark results
for small I/O workloads, and workloads with slower persistent storage,
and workloads on slower network fabrics (ie, TCP).


-- 
Chuck Lever

