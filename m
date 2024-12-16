Return-Path: <linux-fsdevel+bounces-37483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB729F2E2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 11:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F358518856C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E44A200118;
	Mon, 16 Dec 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cvd0cUXi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UbTYouH9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23352A41;
	Mon, 16 Dec 2024 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345220; cv=fail; b=oK2MXz6bEro1jHMR1XjxeXNyx2pCpbSSDRDBf1gLY+HYswhbaYGaFcOqjcLgbgHaJ5QLO3IoF01cfIwlNuanFVIfV7MBWmvqSNcDW14gYvTjTOK3lO2m9vS/p07ubptOg0a2p1WTIq7a+aIt08F443qyoKu8ColIqYU3kTVMBHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345220; c=relaxed/simple;
	bh=P3WrH5YZAPpXqUiPlDcZ3/7n7FdptOebLKa5E8krcZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EO8Uo4q0B+TBDEi/u22yUuYtBxb6sBapP6DEj0y3bArZ8tmwhP2zvJfI/pcx9vQl2cjzRagsHNBeS0TkZuc+3++yozD8tgm8AvxJbySE9LFe1d1hQzRBNagT6aO5m44t1rllZIAHLKTmy9VJsMQ8Fc8JmEdLFBkJZxAtrlrHgHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cvd0cUXi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UbTYouH9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9MsbY020630;
	Mon, 16 Dec 2024 10:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=69/+TbB6GzRbH11qpk0WEGh5vvvzNDiGIeGk+BMdAQo=; b=
	Cvd0cUXix0zUd+yfxfZi5Jyy3Rkg5e82qgBLO367hlVxoFBTVsO64Hh30Yrrg3aG
	P2M3r6equNOPuOzOuZXwn1UNrX6EYBPhEKp7psCtTIMjvTY7+WwiREMl4bK82sbD
	mFVkJ2n710gt0NRug6kwXxdVjKqi8y2koX+x3cB16USaZABBvIVTscu2BI5UvXym
	AWDnqSak/V4OAjniHFiLM+sCiSHEyPXvUoxBUfuVHgJGbmNujQbnyYIV0e1vGk6w
	lnSxTev8Z/8QOreHoDZ3jwi/+wn8PtzJJBcS9LRE+Ra/CkOVWEdULtTc4p/oVXLM
	72O1CT4BF8MBH9JvT1s5oA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xaty0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 10:33:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9s5bI006388;
	Mon, 16 Dec 2024 10:33:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7uht5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 10:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrJ8IbSXMC+fdNAiDpF4rV/oOdn+cPwF7uqvZYBmbsMorCAVUn6Cy6+T7vlVexBb6jHmbpuapqqHCYIaRYp4fPKT4th8pV8e3Tt7HKYC+qsRPuDMU0HBHHXhZJKvuS4Ms5xW7TVPojdj5y+bOFyau9OAjjn3pT7DBfGoYJ7D/h8vI2rg4SJORXKe/vSdnFsAtJ6oPTY8CvRID8YLX5G1wW8Ka5ICRkHMMZ13vBciAZP+M+aPBpzF3MZ6ZpCWdDFlXziG+PvVoL0POO3F0B8WbLqZjfY9iK8ssMdfNePtz6BGVRJvqulz8ZNeQiQWnA4ThxgOP+BkYukdw6k7uIRQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69/+TbB6GzRbH11qpk0WEGh5vvvzNDiGIeGk+BMdAQo=;
 b=PetuB2DIz1HDY66U4VpIHaUk3mdBZHxGPL/gwZ0TJtcK0QcVJbgHra9bLNfgwqMx7kmCoBk1wjE38VaX2zf7WB20NFPoUnZlQYH8rB5cdix0/MUEp/meGZhzF9KVVr8siDgNTBibk12gvoGXlwHuDvT8t7Owu/5FT97ZuNxAhJBQ1b19vhPX0Fxj89Bl1iA3TV6wQWmfMncTFODjIJCvGdduIAUe0wO2sm9TtU2sPhUqQWv7oChdEPZCApj8YPuTkdKKxYZm3e0ScLSEIcuiOpGfwFQ+9r6Qgu8F1hWyzAEU4H/C9ZkDFt5TedJi9q1tH9W0fut12vd+ltTDuDtzeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69/+TbB6GzRbH11qpk0WEGh5vvvzNDiGIeGk+BMdAQo=;
 b=UbTYouH9Nyl2cS5FrXqrhXM5dwIzf7DVO9kbzOLKVWVidF58xmIWVtUb3zQBtapOudP0XSw/n7Rt4aRN+leAgL62gqMJxH6yBJaNrpyzuRTU7TqN0nvbAekfvxngjd2Zs9sj5TFDjPDP4RZ3Y0YCOavMv/Fe0o72ioVKPXaMucM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB6421.namprd10.prod.outlook.com (2603:10b6:a03:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 10:33:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 10:33:29 +0000
Message-ID: <539b1d48-e0d9-41fc-9c12-fe85b1018297@oracle.com>
Date: Mon, 16 Dec 2024 10:33:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] man2: Document RWF_NOAPPEND
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, dalias@libc.org,
        brauner@kernel.org
References: <20241126090847.297371-1-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241126090847.297371-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0247.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9b1067-3da7-4a89-665a-08dd1dbd147e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGNzdHpMV3k3T2MwZFVJWUNWSEJ0ZnNIcEtWa1RLWkxyNG13QURaY201RU9h?=
 =?utf-8?B?cVF2c1ZYU1dHTHM1L0dSNFZFUW9JQXZNeWMvcWcrYkhaVkpSdzl5VVdnb1ZN?=
 =?utf-8?B?Z1dZejBTVCtQSmIwTVAwM0MxWFBqTnl5bm16RWVjQjBDWnJlWk0vTERMdk5H?=
 =?utf-8?B?S2FlNThhTnI1N09aVCs1cVUrcGhYVVN2azRBRHMrK2w4THg1ZG4vUEQxY1Fi?=
 =?utf-8?B?UzdwajE5TWxiL2E4QnB6SGNpeUFWcFVsNEU3N0w2SzkwR3NieElqcTlzVnVn?=
 =?utf-8?B?ZWwxb3NXMzNpdTA2VktPQW5CMHhpWnVPRHhiNUhmZVZSeG1lUHhtdStISlA2?=
 =?utf-8?B?S2ZYSmVoNlpoYVRDbjRmbXV3V1Jmd1ZwbXRKMG1uTTFwbGl1VVRuUjAyb2Jt?=
 =?utf-8?B?ei85MmdIdC9RVXNWOHJUdE90Q3h0OXg2RE9JSW8xZktTVk9vZ3R4RGhuaDly?=
 =?utf-8?B?ZTZtM2x5S0crenJ3MWFEcHREVUFwOURodXV1aFJDVFJGTzdqVXVyYjB5QkFP?=
 =?utf-8?B?aC9vL1JmNHJkTlpORmVoZzB6WENsdlNGZUNVaEY1SERFek1oMUYrcDBDeWoz?=
 =?utf-8?B?Wm9qaXFyRng1M01KNTRDaXpjQlVUU3NJVktzc1h5T2pXbkdYMkVYbnZhWk1n?=
 =?utf-8?B?U2tjSnlIcDA2K01rNVlWemdxTzRad3JyMUcvQXpmNVZkaDljUmVIa3ZHQjZC?=
 =?utf-8?B?Uk0vc3paVUZ6WGRhTGYveEZkdU5IUG5CMEk4OE5TcmRqajBPcXFRTmxpNnJz?=
 =?utf-8?B?N1l2alhLS1YzK3kzK29aVmUrZEJEZm5RbXQ1eDlNR1BCZExCUVllbWhNQmtJ?=
 =?utf-8?B?cERIcWRjYkdYbnhnVVV5Q0VWZHA2UW02MW1hTmhQRzVRMkJ0MmpySjVYbFNZ?=
 =?utf-8?B?a3dXbG1Db1RQc01NTmg1U0dUMGRUZGlhU2t1L2M0d0xSR3ZVQlJ6YWxFaU4z?=
 =?utf-8?B?bDBQSVZtSE5vM0Jia1ZwYkpHaHdxOTJ6N0E2WHlMZ1lHbTYzWnhoaVI1Z25E?=
 =?utf-8?B?dnZrbEVvdG1RVzFPYTZBeStzRXF3bVZvWFhQNUlxbTlkVGYwTVRvUFFkeHRi?=
 =?utf-8?B?TnJXaDJGcEdjWWJ2NmJUUUE0NEhZNnUzT2RVaGtKQUp0cnowa1N1WTBaQkpQ?=
 =?utf-8?B?a0Ftc1BOTml5NmFRUVhJMVBtTlEvYTJVYml3bnVRSkVCNlBxM3EzcGRZYW12?=
 =?utf-8?B?L0phWHhYTm5XemlHeHpSVGFtZWpQUVp2RUJJa2llaXVUcWEzbXZjd1hOa2Yx?=
 =?utf-8?B?WU1sdy9paE00R2RLcVBEY2JxWFdoMWRzUmJaSFc5alZvMnU1VGFyODYxeXAy?=
 =?utf-8?B?MVUySWV6WCtINmdXQlRwUWFyM0pBSVFEYnhpbWREa0lMOG1WY3NoZS9kQVd5?=
 =?utf-8?B?NzRPcWRKNmxtejRpYWNTNms5NGw2aVUvK2R6eGJDZVU1cjlvWWlNeGtpL25W?=
 =?utf-8?B?bStCZkxzbHhOb3U4WHU3VXQ3OFYvNmVKV2Njd3V6b0d1SnVELzJoSFVsdmxv?=
 =?utf-8?B?RVFZblUyNlZzaDRhZGQ4TXBGYVZrRmwrNDNpMW1XYlhXTndJcXRCRm9oSS9L?=
 =?utf-8?B?emFkNE9rSWZoQ3VQR0dya0dHdGpBbmJlTW9GN2FOT2hvWWx0b25KeFZNL3hJ?=
 =?utf-8?B?UmhXQmpwOUdSRHhmcTVLREE4S2dDcldOMk5HU1VheDlqaXdWeWMycXQ1Z1Nt?=
 =?utf-8?B?VUxqSUtld3Ryc3JXV2pQSWJzZWo0NkZ4QTZRMjl0UGg1SWdJOXFyZVU3ZEFU?=
 =?utf-8?B?NVppR1dnTGFqK0RzWkRENm9XaFFjdVhNYlJMQkpEb3VvZnRJdTBGZERFSTVY?=
 =?utf-8?B?YWs3WmJDMnNVTVhKMEdkOGtMSTJGajNIbjRoRkhHSlVkZkhydmJmclFWdGNS?=
 =?utf-8?Q?vboGSg92y/A9y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUtYY2tBbStuekhDTldmL1UwVGZqSERseDV1cGl6Ly9xQ1VleXZXNlMvUXRl?=
 =?utf-8?B?TGFPUm5NbGcrT1lsQWU5YUNjL1k4eDIvMVdKdWhJY1FySzZpK0hpdE5ET2wx?=
 =?utf-8?B?YUlNVUl5MStDbkh0Rk96QklHWnNKRnFHZ1dwWHBiVngrZ1ZBZmVWbGNnV2w0?=
 =?utf-8?B?aGJZOE5iUTRhcis3QzIzR3Z5Z2xnTGFCUm03ZTBiZWc4U1dmYzlxZm9PZlRW?=
 =?utf-8?B?NzNiVjJOdEM5K1BPZFFBU1RtQnJKeVRvNkVZMVBuLzh5cGFSN2U3cGFRaC9E?=
 =?utf-8?B?cklIQ1htV3BwSG5zVFR2Z3N6cHRIOXAvSlBjcUkyY0R5UVg5eTZUblRPNXRP?=
 =?utf-8?B?YlpWSzdUajdxNWJvVlVSUFdIa3FPOGJSWGJ4UjJPcGFXVWJmbTNuVGpaeWhh?=
 =?utf-8?B?bFNuejVTM3J4TFNXM3ZCa1RtUkd4aHVRNWhTRGJJUHlYTVhEVUQ1TDU1Ykh3?=
 =?utf-8?B?dlNIN2ZMVGU0djBWZ0RmM1pITXVtS3ZaOEZNUnF6T25Ld0hDMDNSdTk5Nm94?=
 =?utf-8?B?QzVpSE9Ka21aLzdONHgyMG42NzFnYTdBNVBRY3d3Z3E2eGQrWFh5YWt6VnVC?=
 =?utf-8?B?ZEVyYU8ybzQzRUlkaFlXWTRxTUFDUmxBM0dMUitpVzdEb0xIakVjUzZoNmpS?=
 =?utf-8?B?S1JNcHRPdFJmaGhrSGRHSkNyWExUZTR0ZS9yT1N6elJDZXlveVpISEpkUVlz?=
 =?utf-8?B?Y3JuNDMzV2NtVythM1BONFVVQndTVTJzcHhvMkNBRlVrUlIvOG12ekJWbXU1?=
 =?utf-8?B?dElZejBvZFRva2hBdUM3RTFFMDdBV3J5emJqNzUzTEpvSTN0YXBGV1lBeEdm?=
 =?utf-8?B?UGdVZXBKeFhaQ2lER1lGVnh4UEZCdkdlYzJxeTMzZ2dxMjluR1ZrMHl2Ymg5?=
 =?utf-8?B?MEJvblJ5UVFzc0I1QTh0L091TnNwWnpKY2VUdE9aTUI2VkV6T1hPdXJmMnl0?=
 =?utf-8?B?TVp2OG1wQW90bmI4U3c5YWljTGNPT0daYkJyTThqdUdNNTRqKzQzQ2ZMeGtm?=
 =?utf-8?B?cUNaVFp1YUxkY2hiUUROcXNqTUhCRUhhQUVON1lWNWQ0RmF4MnczWnBrNDNW?=
 =?utf-8?B?NXRVdDBmeExQeE1nVTJQaFNxbCtscnBCMGVsYTE4SlFJSWFuc3QrandmdVZw?=
 =?utf-8?B?UGg5cnNNb3BrWUIwUGRURXorTjFUeGxhLzEzWWlDSWMzUEtycFl2Znc2VGxW?=
 =?utf-8?B?bGpQclJYQ3dYVjBjTUVreFJIMEFHQkwwMytzenRkckJRVktKZEdzK2lmU3ho?=
 =?utf-8?B?QStiUmUvZW5Lc3NGR1Zyd0svZDlIdUhZcEV5RlFCR0lYb1ZwaGU5RDYxVjJ1?=
 =?utf-8?B?QlVWMGlLMkY0K1I5cmMvZjlYQ2NkYlE1VUpFVDc2alMvWlJxYW5oOGxUL2cz?=
 =?utf-8?B?R29OK3paOXdPQ0J3OXkybzRQcEVvWWJpaFVPaFVtYzVxY3BUMGFwajNmOENQ?=
 =?utf-8?B?MGpmd1pWZzJ5aEZoZk93aDFOTkdZTFcydG1qb2IxYVNEUW1pTkwzN0tweVdy?=
 =?utf-8?B?R3Z4QUljbHdGa1prcmMyY2k0NXQvSSs5TjgwR3NMRkVBSFNmeHZZdWpXc2VY?=
 =?utf-8?B?bUJKOEJTcU1LMU9JcDRzazRVMHNvUlVkQ1JTWThKMUhuR3NnV1cxZ0dtR3Rp?=
 =?utf-8?B?NitzL1hqeTZaWGxMR2dVTW0ydVR6U2N4MEI2eStQMlFRSVc1Y0hKMVJIRXB1?=
 =?utf-8?B?TkUzbUVkTkVERmU1aHJvWWZKUks3RkJLTjM5ejJKYU5TVFFtOTc5d1hVU1Fm?=
 =?utf-8?B?VVpybzRsOEhySmJpZE5sLzZUMFFmVU5zU1JyVzI0bVcxL1FPRjhmYWNpalJC?=
 =?utf-8?B?Y3ZydDViVTBqZzFWRzlKcjd5U1EwY0NFVy9VZy9MdjlPVUE5ZWVCcGFycXdP?=
 =?utf-8?B?djBQWGlaR0V5RkxlR05kZGFZbDF4S0c1Tjc0WXVCd2t4NFhWYksrTmFXWEFx?=
 =?utf-8?B?K2h0dmZOaktQRHluMlpGT2FxamQxL2lXNG4yb2U3cDIxaEJkeUplUjVESHR4?=
 =?utf-8?B?SWNLYklyVFJVVkdteUdOTWNjc2R6WmpxYU1qZnFpV01nM0pEc0lFbFZoMUR5?=
 =?utf-8?B?b2YzcXpkUWRFZjNqZmZtemtxUWljUVlPQmJSdktIN28yejhINjFpV0xJSjhr?=
 =?utf-8?B?aVVpazhqTmtZTWEzUTg4V2RWZGNZay9MdHZSMFhpK0NJNWI1SWdNeitnUktI?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BbW19aGmf4sLw5JY/AUIc6/hQkVYTGbyZ4dAtDI3xKk+lJua/OdVXAXBdHbqSiM0/nMDCR7JaLsWMNRPugG9zQhXXMM7JPFu1ohzQ2YFJUN5cI4WOHSxNPYMzdxdUr0WwD+1MA8T+IybQUvcby1hY3a3mVCzI6kqpoySq+NUBmdeQ4eooHj7KyheoCYrQMd3YK9kDGmj0dzY3pbiyRH8gB7WoGyQLbuqEbYtOhieOscfI8ftgezj8kUB55Tr95hDUrV2qDfWuF+goBHK5Hbh2pUpAlFT8L+Gx9Yb+jpiZTNl63GBDY+Y5tjfwVm8VGJdBBO57wz8l6BGYyTPnl40x7F65P7LmBI2FjAM2zxTgHtOlDKhWRWEWwhf+9YQAuW2qWlYRmDsoW/b4U1PGfH0k6s2uQgIlsDGVu9yAcyef/bxG1wG0I1ykmeWPNv9Iv5qFucTqMepgRzIpCmCcccvk2f+XtSnBoOSohTqsPyTbt7pu8HFqnLhAIOZZzLSSPrUpdug3ZmWEStJg5CtNHYi5BJ3vO8Wmcjrd71l2d70V3ARgkxPY06JKFRfCgwVq6fkPBlzKK1NWljCDczjqUIjrxJ5hv3WkrWN6evPpp/in0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9b1067-3da7-4a89-665a-08dd1dbd147e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 10:33:28.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Yg/dJmYyVm7jDf8Bikzqm17vP0/ubSHAUdqEe7zuEWw0GvuLMA0rcW4I1zpxLltQKKX+943vz3wNplngi76iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_04,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=967 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160089
X-Proofpoint-GUID: k2GYc3f1tsU_gVkMzjVtxGTYrTcZykix
X-Proofpoint-ORIG-GUID: k2GYc3f1tsU_gVkMzjVtxGTYrTcZykix

On 26/11/2024 09:08, John Garry wrote:
> This provides an update for Linux pwritev2 flag RWF_NOAPPEND.

Hi Alex,

I'd say that it is ok to merge these changes now (with your suggested 
modifications), as no one seems to care.

Thanks,
John

> 
> John Garry (2):
>    readv.2: Document RWF_NOAPPEND flag
>    io_submit.2: Document RWF_NOAPPEND flag
> 
>   man/man2/io_submit.2 | 10 ++++++++++
>   man/man2/readv.2     | 20 ++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 


