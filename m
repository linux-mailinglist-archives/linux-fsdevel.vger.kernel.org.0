Return-Path: <linux-fsdevel+bounces-37484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D289F2E3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 11:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BDF162F81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F95202F9C;
	Mon, 16 Dec 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oQ0UA226";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SFlZp3pt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA91CD1E0;
	Mon, 16 Dec 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345352; cv=fail; b=t+DGV1J7Qt2kBA+LbMmep5CHxFSG0VZaJ41CtA//jpKWObvnNcwYwwaRxfB9033Y08Qb4Oi7PPKk3wkXJWYBrntNoSMENVMZHaqoGV9hI5I9MrsWBETJMJRLhrZLFRiHcv+/AVtt1DjmMolF/CV3itYxL1ij3fw2djp9DYHVBWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345352; c=relaxed/simple;
	bh=7Ah4bdGtLEm5N8o7c+hWcqPCOtbTbf8qGHIkm5u0hl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dQ1VAcRsYx3OZFYexM8pwsXJgrxRykL6aD7TJCMXCAswUWqsK1FA8zQPVrcVFkGZUpPV5rb/hzS5R0h219VpkQpEvOdXdIGQDfwY1+QN9vTVzr+4vzlIXjVdfJ9y/1WTuKPg9mmZJSjqmAE5NpBDj8jpcwzuoFfCZxy1xBbZQM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oQ0UA226; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SFlZp3pt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9MvSf020351;
	Mon, 16 Dec 2024 10:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=P5774DIS6vu2evJcdn9fWFFPzVQT4zU31u2vafZWM2U=; b=
	oQ0UA226f/q7zN87nVYDl6itV1B1Q0ueA41jZLP6wQ9mwQJK/lbhhVaJCHA/L+Sq
	zQrXNaCWS5NA2zxFDGN0MjWvaR6953dpg4qurlureffZs8Pq+u22kSxLMB0fg0vu
	huc5oc53Gd9izxXKh1XiPEhpRlArW+kQ7ZnUtFm+mQFzWqI/VLemQdRvoee7wJR/
	NdXUkjm26Cr96oWhzlP51lYw4/KSCAsz6EHWAcYkUZP5frIBcQcz2XkKVFabzuUT
	ZgvjazgkDE4ov+un7LhrfIEF4B5KA+q5NPDdaKUMsZqeDSySJGfUTzyM6gcCagQU
	vWsRHlyhr11tcbjEQQxDWg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9avvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 10:35:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9s5cN006388;
	Mon, 16 Dec 2024 10:35:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7ukme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 10:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMM171XjpERDSioZ6tvGNEXfafnx1hMfzhDyYTcU3meDnbB9NerovYUX7GVwfHen9fZvwWFnAUtQjRLH8IFGzZ7R00bBukBjeOpJz4TShUhJswcA3FipjZomfSa+H40KnmLwEu/kTmbHtADKvvrUvUbDrKlsueQxalklSLBEXxgyp4fkThuPwBePpcpu79fa5xqQhmik6IWgFizEbZC1HX0L0B3JsHk2Z26E9KrtOxAypj3qbdSg3u9j9oUggvgJaF2Eh99e3QNtUfY+/CPsEoJqMyiQGZ2YWMLs1tChHuONFSvnduCPgJP6khuVlTvqpHrMLS4NttrFcC3q4rsPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5774DIS6vu2evJcdn9fWFFPzVQT4zU31u2vafZWM2U=;
 b=BfCc/yzDSlhgWRVz2WW8XtSCDfRwBNMolSkuxrci3LVFwb+K0kK+ibFby+fskQ5L2SUlKo/C/rdM80TaXgKdSMJVSzIxU/WM/AwyETSYlzEhCvifAltCeCfVyZWtNjzINlj0PrKE4OJgl7LNkYGhQCbqB84FVXjDlYj7XDjj16QSfrFLkitWAZcl+R1Pq2Yawg2/T8LzrNi8yQx0GKLl3AYykHCpE+vNf/iJ2UpQq37YZhyK2BCcoR40eI3V3aEmiFnlACZJ/JYrl4CROiFr+II04/k+XwXm0NoAJkFmaG9WZdOoVoQBk8WEx+OoAALSB9+fsJ0uVcHEsmsNAbpV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5774DIS6vu2evJcdn9fWFFPzVQT4zU31u2vafZWM2U=;
 b=SFlZp3ptENQ0wtqjn/q7izABb1SiCWTHzCvAfYAPLvRXnAkkAGGBPVPPI0EWmqPSvKQy1w2Lig62NaDZ2ZWUBh13j+wz3osrvruolhGzAMmESs0gtbZ5nPdfW2aYHhM8mSftjr3FS2XAO1Fzbbj8yh0W+Tjf8I73x7xc4DMGRPk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5732.namprd10.prod.outlook.com (2603:10b6:510:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 10:35:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 10:35:44 +0000
Message-ID: <ba9bbcbd-a43e-465e-ba17-8982d8adf475@oracle.com>
Date: Mon, 16 Dec 2024 10:35:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org, ritesh.list@gmail.com
References: <20241203145359.2691972-1-john.g.garry@oracle.com>
 <20241204204553.j7e3nzcbkqzeikou@devuan>
 <430694cf-9e34-41d4-9839-9d11db8515fb@oracle.com>
 <20241205100210.vm6gmigeq3acuoen@devuan>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241205100210.vm6gmigeq3acuoen@devuan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e49a17-e2f0-419f-6a07-08dd1dbd655f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEtjVkg1bFd2eUdTajJ3U1REYUNDb0hIT0J4WFhsNWdlbEdOTUYzdkJXcHBk?=
 =?utf-8?B?VmM2K1lHYWNkRzQ0Vjlzalh0cDRKNEtkVkpieTVCMFpEZysyWVBmczkyVHpD?=
 =?utf-8?B?U0plOVVmb1ZDeTNHTmliVlVNSFR2VkVKY29qWFU3SGFrZm9DSFBkcEFDRkZv?=
 =?utf-8?B?aXV0RlJVZ1JPd1RpUmVLRnV5aWdGYWhMQktpSXNXUUQwbHRwSWpsblJiVHVK?=
 =?utf-8?B?SWtLdTgvR253YVBJdldCV1Jsd04waTBWRG1KOTNSdGNnejhBNXBSZU16VExs?=
 =?utf-8?B?Um5CZ0tFNGZKTm5RUE5vUHhpa1dHcklXMUxxdnV3eDdRNW9hUENHc3ltVjlU?=
 =?utf-8?B?UWpLWmkxVWRWblFCMnlINjlzV1kwcjBtMkk2WFh4aWdHMlVkZ29VQm0wRkUw?=
 =?utf-8?B?Q0wvK3NOelhVZFA3WGNCdHFHV0o5U2VCdnF5UmdFWnlubENsTkZnSjVheENh?=
 =?utf-8?B?TUVud3pEdEFHT0VBZDkrcVlBeGpHYzdnQTZ0NUFoQ3Z5N1g4bTZZK211Q0Jr?=
 =?utf-8?B?cjBISUtkVU43YkNWckF5eUNORzlKaS8rN0g3alY2Q0Y2Rkl6RG9MUUcxVE9v?=
 =?utf-8?B?d1Jaa3JvTDFOVnd4T29MNStnM2NZSlBXYkl2UUc3UXpiV1ZOOG5XcmVIbHdp?=
 =?utf-8?B?dERZanVYNWRrQnVwVmZZNjlvOHZGZjFqcEZ4eTVNcVp1czdESkJTK0hIQVdD?=
 =?utf-8?B?ZTdXekNXL296bGFTSW9PUjZ3bTNBeWVQOEpsVWdITWxZeCtrZWE5L0M2a2tZ?=
 =?utf-8?B?UWJjanFUcVIvaVg5VzcxcTJHSnBlaGh5M25jaUFHTk5Pa0xZOWFBWmZ1dEdn?=
 =?utf-8?B?RGppbXNtdWJVdE1pN3VtdkxaYlZFZHdLVzRKVUtyY1lyQVdmUXhMV0diaGY5?=
 =?utf-8?B?QlpSUU40eU9hK3ZXVDFaZVRmL0ZnUEZmdTR1R2plMHltaTUzdEc4d3REeGl6?=
 =?utf-8?B?eDdjQTkvVk1QR042VE5jclRtcFVTYkxyQnpkam8ybSsvc2V1b2JheVlnTFF3?=
 =?utf-8?B?aEdWc01jZnpMRStiYUlTdTIxSk1KQlhrZW1IRzdSWFlCdEJBdytxbXpSejNj?=
 =?utf-8?B?NjBWUXQ4UzhuVE10QjMvOHJ5WGc5dWljTTl1U3REbEtQNXlhVS9UY1oyQkIy?=
 =?utf-8?B?V21YbmpXd0pSY3l1aVlhT1ZRRzIwZ2t2NVNXNFJwdzJPaWZmNVdkeFZuM09H?=
 =?utf-8?B?WTA1ZVVXR1hDWUF1b1hWZVpBWG9iZVEzR1hodC9OQjFyWXdQRndiTzNpckFy?=
 =?utf-8?B?L1FOUXc0RzQ4YlNQbmM4bGN5bzBCTkNxdTdUZjFXZHZMaGRqRndUcGNXU3l5?=
 =?utf-8?B?eHA4eTFqUGxRRTg3allCaVVCaHRVT0RqRGVMVE90SXFFMXNrb3dYNGtSbFdO?=
 =?utf-8?B?MUtnT1JmbVQ3TzZoRjZkTTRrdzN3ektXL0l2MW0xWDhncHhOcVdYMFpFTnFB?=
 =?utf-8?B?ZExKdCtrM3VZQzdyRmVvUlZoa1Fmck55a0U0L3c2dk5jalNBdjl5U2NYYUdK?=
 =?utf-8?B?SkNLc05Ka3ZJYUIwakRJVUpaNjlJUU1xUVhUN1RHemJUL3JIaytsenV0aWV4?=
 =?utf-8?B?cDg3dGppSWhyR1U4anFLWmhyS083ZUNYQkRSR3ArbXNORTkrVkpiYnNQT0pm?=
 =?utf-8?B?UUxDQmsxVnVwTStwT1lrN0RhYTR0V1UzNEl4QUFsWlN2TmFUWGtndmJzVlNY?=
 =?utf-8?B?bUc2RGhKdjdzM3VNNi9rbUNiL3FJV3Q2QjZkZnFFdFo0MlgrZ3RQbmRTRFlH?=
 =?utf-8?B?aFdyTzBkZGlhbC85UE1ocGI3K2FGb3hJcGJOakJwQ3k4cElIcEU3L2ZmUjN3?=
 =?utf-8?B?d2k5QUNKaUs5dDdFLzBZKzNnUkRqUTdKYzVySFo1QVhka3BQQ1VUSlNON2Z6?=
 =?utf-8?Q?48NZ+zLza+sXR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUpFalVzL0t0QkYxeDZmbnBYakZWcC9lamNEUytPU1hDOWJMWjIvUzk4RGw2?=
 =?utf-8?B?bUJwTTM1STRJbkwxb0dsNmRyT3pXdjZWTWVlY1NIWDVxRFMwWWV3Wk1PaUdu?=
 =?utf-8?B?T2kyM041aEp6WHlPbmVxaEttWC9NYU9zTzlBaHJWd21hQkpZRkNjcHc4dVVT?=
 =?utf-8?B?ZzZ0WExONk55a1lSbHVUK1R6RGNHWWI2TWNBa01YOFJ3ejh5YmZ4NEN4RDRR?=
 =?utf-8?B?ckRXRkxXN2p1TDdQSlpGMk5pUFVxY29ncGFqdVVjOEJzUDV3aWhpRUtVN2Vt?=
 =?utf-8?B?OG8zUjJxTUNnd21nNjFia2lRT0VuZ0hHOXpNRjMvYjJrZHB1RVd5V1I0clpE?=
 =?utf-8?B?YzhUUFIwMnpvWi95RlJzV0t4L1FxQ1IyanBDQ0R3c0lTa01lSE9PdDVoZlFK?=
 =?utf-8?B?UkhSRUNmOXUwMVBUc0dhZjJmS1VQWDAzSktCQVJJbUpwZktoVDA0aHpjV2ly?=
 =?utf-8?B?U0pyeFNPeUJ0dXVzSzRLZW03cFp1UUw0VkxQYjI4T3QvcVNta2xmQ3ZjWTE2?=
 =?utf-8?B?b053SUwyL2JlOGVucXhPMC9sUlZHcHNvYVl2NlNnZ042clVYVnVnNld1RWlQ?=
 =?utf-8?B?S3Rud01ZSXluOWhTTjFGakg5dUY5YmxONldZOC8yV2IyMVBGa2hvOWY0OTQ5?=
 =?utf-8?B?VUx4WlY5Tjk1bklEZGc3aG43cGVpQW5pZ3JQN0Y5dVlDSDRMMmZkZmR1NVpj?=
 =?utf-8?B?a09oS0N2NmcyOFhtUjRNTk1naGRTK1hKcGJvK3lncnZ2aGYwUEJUSGIwT1Jn?=
 =?utf-8?B?aFM2RDNSMXZ1Smc0VUpUaFFxRndlc0J5MkpOWE1uOFo1QWwra1p0UUh5ZUlC?=
 =?utf-8?B?aXR5L2J0MkFZQ0FsWDZRMlB0aG84d1ZMN0ZjOFc3S1BVM2luQmJoVURuN255?=
 =?utf-8?B?c1pqV0IyMFZudVhJTm9BOEJBdldIT2Q3aUNrd1VsdERrb1ZTWnZ6SkJBa2t1?=
 =?utf-8?B?K2dWZUJJemhmZHUyeDQ3bHgrd3c0ODFmaVRDNmxkUFhMdmJoQVp5UEM3REc2?=
 =?utf-8?B?QzRlZ2Q5SjBWUGJ1Uy9jQkpMR0dLK2w2SHlzK0lCQU9vb21mdXNBUXBFTWZN?=
 =?utf-8?B?d0wwc1RkcDlMbG1ZTlU4WjJCUm9HZDBUUTc0MGNoQ3NJaHpud3BWcG5IbytT?=
 =?utf-8?B?VWl1S2RvdzJJSjNaUGF6VmFEWExsVVJRVFZKRWdSTFVBMGlQQWh3UlExb2R4?=
 =?utf-8?B?MXR4R2RZTW00V3YraW1TR1I3ekJRYkVDSVFmVFZVcEg1RDEzMVgwY2Q5N0lR?=
 =?utf-8?B?cHNWYm5LSFBXZmIvZkI4MldmWmVLa2xxeGNrV3BYWTFNbmZpazdLRmV5Yy9B?=
 =?utf-8?B?YldaMEptU1g0NjBnQlFhanhpa0kyaENOZ0VZL1RxeEgyRDh4aVlCSVIrR1lz?=
 =?utf-8?B?VlozZmpNMUVId3hlYW9vRnFEaXJsbWdLU1hNQlV3RSt6TVJIdzQ2Y2hMS2x0?=
 =?utf-8?B?alJoYTl2b0hINHYxbURHWm5xNW1ZVVpQOEVRN25KaHNMdFpuUGpKNkgvY3Fk?=
 =?utf-8?B?N0VMN2loaTdTeVdBclZTQmJHa2FkUHhNY1YwR2dlSk5IdEpwRFhWYjhQMlh0?=
 =?utf-8?B?YUhlY3R3ZjFkcXV6UFZmbGZjazZYNHNOb2hPWnNHUUtrVy9PbldXUEx4WXQ2?=
 =?utf-8?B?SVlPU2haTU9ONVoxSXdKanAvUEJSSkxWRXdTMlFGWTVoLzc0NHN1cSs0bGtV?=
 =?utf-8?B?ZnJuWkxXREhKUlN3OUR1bTMvRmpCdmhJeXlNMENmU3U5Zkp6alpFSnBBU09w?=
 =?utf-8?B?MkszNHd2ekQ1dDB3LzdXTkZXNExEN0ZUVk9yN3VBQjJUZDJ4TjJ1ZE1BN0Zm?=
 =?utf-8?B?R2h1QmorNlpyRFBJYitieHh2eWhrRXpvUTFPVm9PWGFIOTN4OXloREJZNjJR?=
 =?utf-8?B?QTdwSjNFT3laNTZOa0srMCt6L3piWkhPdEV5elpnc3o4bFlJeVlObDZEYmpK?=
 =?utf-8?B?TFR1LzVTa3YyanNQQnBESWZKWi9LWmxYb1pTOTRvK0tubk9Cc3Z0TVlzaEtm?=
 =?utf-8?B?SUp0RVI3RmFDNERvSG9CamhGbmNXdm5FKy9UZzhZNWNnZklpbjgvb09xalph?=
 =?utf-8?B?cWhpOWlHdHp1Yk5GWlB5WUVLV1ZTQllET0FwQllmTVpIRlowdjlsMTJIRzlN?=
 =?utf-8?B?dVgxSkI1Y1JLUTZCby96NlpEcHZZM0pyU1pXWW55aWZFekZsWXdQL0o4M0lG?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XaDavIdlvRBo3LIG7U81d8uFY2aazhpLdw3JWW0sKthwvdE8BfoCyayLEAS+O7ZSofLAjWvwRdx6aPGI1xegaV++Uno7bMpMdUm23cYiD5Xt7GOJ9E62PBFKbr4aDUK3Fp+DFH5TpoggK7KZySpKAOEluP+p/QY23+omdHd0fCP5ki5FRxKCE2MuN66kEXC4l1JXbbEz0z7o3iFIiA3kyq/Qg2g679pVr3DdT9QFAfl1AFgQaPCr32P6HovDYopPQkf2MltQrQ77wvN5DDelgTmOaqYPAPM8PEfsHZyuIrdHSBdYXVRNkchFqs+CGSPVSwC4coKZDoY9y382NdBaZoWh2hREOK5d06bAWUDKfoJHdrhv5DNwJkDZMg+LC27rE1yntK9tvzGD7Sgm4GZKG+sagX35Vm7oKmpBhbRHxrljqCA8kdBl2H04xRj1dXP7Ex+kS7gpVLd2srjwJ3YIpHp4oiD0SsiAauueAyjtm8ezBnSR1+urVjCk3wIhSp5aRj21Rk499bWUybfyKe+XnM7/ewcD2nO08XVRHTYvrQ6W2Es+8Pf4pqmqgUZbLMJTkpyS8DNmTwrLBwBtIsb6fJKayQOfolUH6jTwKWCrsjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e49a17-e2f0-419f-6a07-08dd1dbd655f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 10:35:44.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+4lY0fRUA+o032WR4Sfva33+35YwoV6+03en6nS93s02fUpvlq2iKxGJvwOiyTWfMT1ObaeBmxSWmxciv7edA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_04,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160089
X-Proofpoint-GUID: lXrOlvLdxAeeNjBc1t202wm7tEAD-TAO
X-Proofpoint-ORIG-GUID: lXrOlvLdxAeeNjBc1t202wm7tEAD-TAO

On 05/12/2024 10:02, Alejandro Colomar wrote:
> Hi John,
> 
> On Thu, Dec 05, 2024 at 09:33:18AM +0000, John Garry wrote:
>> On 04/12/2024 20:45, Alejandro Colomar wrote:
>>> Hi John,
>>>
>>> On Tue, Dec 03, 2024 at 02:53:59PM +0000, John Garry wrote:
>>>> Linux v6.13 will
>>>
>>> Is this already in Linus's tree?
>>
>> The code to support xfs and ext4 is in Linus' tree from v6.13-rc1, but v6.13
>> final is not released yet.
>>
>> So maybe you want to hold off on this patch until v6.13 final is released.
> 
> Nah, we can apply it already.  Just let me know if anything changes
> before the release.

Hi Alex,

I'd suggest that it is ok to merge this now, but Branden seems to have 
comments...

> 
>>>> diff --git a/man/man2/statx.2 b/man/man2/statx.2
>>>> index c5b5a28ec..2d33998c5 100644
>>>> --- a/man/man2/statx.2
>>>> +++ b/man/man2/statx.2
>>>> @@ -482,6 +482,15 @@ The minimum and maximum sizes (in bytes) supported for direct I/O
>>>>    .RB ( O_DIRECT )
>>>>    on the file to be written with torn-write protection.
>>>>    These values are each guaranteed to be a power-of-2.
>>>> +.IP
>>>> +.B STATX_WRITE_ATOMIC
>>>> +.RI ( stx_atomic_write_unit_min,
>>>> +.RI stx_atomic_write_unit_max,
>>>
>>> There should be a space before the ','.
>>>
>>>> +and
>>>> +.IR stx_atomic_write_segments_max )
>>
>> How about this:
>>
>> .B STATX_WRITE_ATOMIC
>> .RI ( stx_atomic_write_unit_min,
>> .I stx_atomic_write_unit_max,
>> and
>> .IR stx_atomic_write_segments_max )
>>
>> I think that this looks right.
> 
> No; the comma shouldn't be in italics.


Please fix up as you see fit.

> 
> .B STATX_WRITE_ATOMIC
> .RI ( stx_atomic_write_unit_min ,
> .IR stx_atomic_write_unit_max ,
> and
> .IR stx_atomic_write_segments_max )
>


Thanks,
John


