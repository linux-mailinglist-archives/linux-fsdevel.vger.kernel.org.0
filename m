Return-Path: <linux-fsdevel+bounces-45743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF1AA7BA0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 11:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8D217A80E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558911ACED9;
	Fri,  4 Apr 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WYdsh1GR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g2zHseP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE816132F;
	Fri,  4 Apr 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759418; cv=fail; b=mjrqUtGB7y3tQf+qN7ylqyuoiLh0EoXzLlRgT2mVNmwT1sEqhqO86mSuRJ55iBMuUFPrVkr/xHIrCPM0YNFWdlecZl53M68LKtAWudYLpNdLLcw0oc43oxY6p6nFNwFenFIZr/KXGw13p+5spa/BIjQLQ2ksAyABTcuyL5dhBiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759418; c=relaxed/simple;
	bh=ehj5/E3Tau3jaX1L79T3ylaI6CBqHWbHIG4RvG2XZcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I604JhAjL/MUsxskyVRLAIMGm2l8+kc2lcx0LPrZEtnGGf4UMM9HH+QPcMzSLieEg5ZBiZNBX7oKikrAMnY3vz8nifibFlp4I512YFMZhyLhmz/Gs/NK+VuC72tDLp8CtgjpnBuKKlPXE9Rn9c7h3n1amwPtzbuZIRrjacWVBhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WYdsh1GR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g2zHseP2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5348N3xd022380;
	Fri, 4 Apr 2025 09:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vnt+Cv6q+q+FQGqoyEJZreqF5qz4BGSEqu1sGNIIcAk=; b=
	WYdsh1GRnEJ2y7TZgONe3quP41CooOepLE0szhFog+tNuiQttIDeDkWHj7xHBQbM
	WMRO9oCgc0sKG0DAxXkWOxrhaQPcbRpCMV0YEJ29vz1xPQTIuJQuCDOSuk6ysWC4
	H5CVwaA0/HRtCYYETmpE5EIRwrGTHOEh2iRdY29crdrVd2W8sRwsni7vfXH5jlSd
	BKeh6gTM05f51uXADTlxs+PHjVJevhVpmg97cLG3feZHXH/WI/x0I24g5VCgotZa
	nqjOkT4vbq7F0KXhLTYtyRBoRNzYHwdqXGBGQcE22y4Yq0K0NB4QDGZh/VKsnD9y
	/qf86UlkueXKXh7QJhe2bg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n2f102-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 09:36:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5348nQBW024200;
	Fri, 4 Apr 2025 09:36:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45t339hrf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 09:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBk/xCHFOnDxLRlb03z3Iltf6/lRiKzVn+gNqmVGZ/4A9rfVzh+0rs19ljBhYTs/t5bM9ZwZYiHMm8mYqM+4pUR6lURh1qftszezy9dM0q3hOW0aToTTNDoij6ox7xoINF1sqCcaLkASnbABgBB0QGek2Jj+bTH4swKV9GlbwM9c8KkVq/umFq0gr4zoRnCwuzN3l1/0uBpulK6GZ3jluXEOKqHWfXZjMmtA8otE6jy7TaimFyQmj2inPksRM3N9nmD81o1V6xRW8rM+J+nQDrU320exbOYv1Pb6g5BrYWgm84oLiTfhJs7fDSr/5xuPARAbAIDbsBAJbMk3b+WhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnt+Cv6q+q+FQGqoyEJZreqF5qz4BGSEqu1sGNIIcAk=;
 b=b7rIDnFAIaIF/i90EViq09qdcD7jRMkNUPQVkwCaTWDnZGdjtLsFlFU6DVEOYcpbI4WA2A5rpEolfu/7W+FhJ9U5ZkWjPOoTAYQU5wySqDQZGQLDRjl1TOXa16PGAe04ijR3d/9Xoju0O9XZJIbR3jdyCuDPLUu6MmlrPPtP68pjvZD1bi2sz7HzpTVd/v6Sjzc4P/7JwDnJWWI1SK7vZuR9CawQ208nw6Kq9jNzJe7FA6HvepxmBHHybLJK4Dkmuq7L/rfXNoY+wZlV9mCIsHcNYcF59EgQfUageMgWq1jITNNohnvhnlkvged+Ypb26PLo9ClFDByN82LvH5WSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnt+Cv6q+q+FQGqoyEJZreqF5qz4BGSEqu1sGNIIcAk=;
 b=g2zHseP24vmaMSXHDzQlkJlJffTsat8E5fEZMEWGxHUzqoPuh2eBOIQIcZd/Vyv/6CCh0QGbrGJ7ovajjzWte9TEDwYRxHT8wSVNIX8tpeImUS3lFO0zwqC9f7OMrrEmAdCCJpBkshDJe9CDWRCCT/8BD/UMSrtr765fOrGoUk4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB4930.namprd10.prod.outlook.com (2603:10b6:208:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.44; Fri, 4 Apr
 2025 09:36:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 09:36:40 +0000
Message-ID: <cfd156b3-e166-4f2c-9cb2-c3dfd29c7f5b@oracle.com>
Date: Fri, 4 Apr 2025 10:36:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: iomap: Add missing flags description
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org
Cc: djwong@kernel.org, ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org
References: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: f57af40e-1444-44e7-dba4-08dd735c33bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG5FdjlFRDZkYkdKOXNOd3FtOHhKdzV0N3FQbHdPT1JCbFluL3REeVVvMDlD?=
 =?utf-8?B?T0ZQeUJUR2hjSFRWOFArRFpYcGNXMnJCR3ArZmN0dDJMcU9XUk5hZVJBbC9W?=
 =?utf-8?B?KzJVR3krYnpZYmxlYmZ0alNmSWFEamNsVW53aGVsM0dtK2V6d0xQRmxvM2ZR?=
 =?utf-8?B?UERMUjAvZjNNd09aVHBCVWFoRzFuV1pEbi9YcU82d0ZMcGdJZDVWbUM0cm5z?=
 =?utf-8?B?Zm9xNjVqc1BQK1BzR05JbzhOQjNnSlkxSXJkZnNNa0l1emxLb3hHYVI5eXQ4?=
 =?utf-8?B?N04zcUJHTFIwOVB6aUJjVnZ3QUtBVHZWRm5OSk1kRzRXdDNyNE94RHRGVEZu?=
 =?utf-8?B?VWxTTEFMVGVwd1dlZmJXVlBnaDFJaWgzUHMvV0prQVNRd1kvOHZ3SFBFSW92?=
 =?utf-8?B?ZXk4MW5YYzF3YWFES3hQQnpPSEJMWGlaZ2I5d3ZzelpDQlNqMWNLbUw0YnNY?=
 =?utf-8?B?ek5WZHpBeTlRZnovckFRYzA3Z0l0UVk2WDEzMkFERG12V3VJZjh3blRWUXd6?=
 =?utf-8?B?Mm04Qy94dDNvSnBHczNzR0hDTXduQzM1Kzh4OU1wNkRGNndtQVJhQWJTb2dO?=
 =?utf-8?B?RDVwNmZKbURYYnJZNWdaQ3U4azFKd094ekJXZzYxZ3FvNkV6cGx3UExnVjcz?=
 =?utf-8?B?VFpvcWtveC8xQnFvaE9vVDZpTkpoY3Bsd2UxVklnalBFU0s2UkRWREtSSmQ2?=
 =?utf-8?B?SnU3bGhjYVVQYUN1Z0ZFVWxkK3ltUFBacVF6RjBCamo2YkczYm5wWHVsenJs?=
 =?utf-8?B?cjZjZUJQYWVmZEtZcDVhYm5oUHNPbmhQaTZpWk1QbXZsMjRsY3NyYWJ0N3Ft?=
 =?utf-8?B?aWVaWEtJUCtvWDg1eDBYUU54R0MzckVlTjlSVnpmNElGaEJHMGRhK2lsOUIw?=
 =?utf-8?B?SFJMcGpaaGdPVm9sZjFCTUszcUhJQVR5MWpZcmRKUm1PQUZlVzV2OUNqVzQ2?=
 =?utf-8?B?SEFVWGlGcE9oQjRhRFdmNEU5U0J1K1k2UmZnNDhrbjlQN01hckhuYnJLbWxC?=
 =?utf-8?B?TE1SeXZZbUJNd21xRUVKdkZmQ00rWTZ3Ym9zakRIaHMrVHFqdlhqRDQzR2hT?=
 =?utf-8?B?QlY0U1VMV3pWTlFTYllVSHZlTmk3UXZCL3pwWG0xZXkxZEdqSWZxQ0R6Y29V?=
 =?utf-8?B?K1JNendJUDBibVU2SVVsd2w4aElnNEpZcGtQNlBEYzhIVEpaRElMMWRHUENW?=
 =?utf-8?B?STZ4aTQrSkNRRDBHREo4TXQ5aWtvQ1VGSllob2x3eFU5VE16NHdDTEVWMlZP?=
 =?utf-8?B?L3dUd3djWE5LWUJYWjVzNEZTbURPOFRwNEJDTDErZ3o2VVZMNDdGdnh2OGw2?=
 =?utf-8?B?eHF2VmNINUNibjN2QzlnOFdURTlyZUc2Q1h2cUNRYTdxV2Q2U1FqUExteGpn?=
 =?utf-8?B?VHIyUC9iQ2RxdGd0TVp4cDJQV2NmejVjMHkwNFh2clZkaHRGWmU0Mi9KNFo5?=
 =?utf-8?B?bE5hVnBxNUZMdGNTWjJZR01JWkc2ZnFCQzJ4UG5XTEEva3A4ZUY3REwxY0w1?=
 =?utf-8?B?STkvNXhSZmJHbVN4NUc5QWNSSkIxaVkrVWhLa0FUZ3FBVXhWekNBSFJONW85?=
 =?utf-8?B?MzlkZWFNcTlnRUZ5THQ2WTNkZU90UUF3Z1ZqVDM0SXdnZ2NjR2NoL09ST25u?=
 =?utf-8?B?YW9CSENkeEt4c3UvbXpoTVNjdkRJQkRFcFVoWkQ5QXFLMGhxYXdaYWorNUJQ?=
 =?utf-8?B?d0hhZTFGQWJVejRyZDlldmE2eEZlSENNSGFmL3hJT2NaUnFLRWxyQk1NeTlw?=
 =?utf-8?B?cWZCVjVpME9kdlZGT1IvcFJIeE1jWDU4N3JvbmloRHRzbTVGN3RUY252a2Zv?=
 =?utf-8?B?clg3MGxZUnQyYlM5OEFWbFYwSU1pMXZrRHJsUlpSNXJydlU0TmFUOWRaSlI4?=
 =?utf-8?Q?YAGGePb4J7WV0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTZ4dXloTG9RMXBiTlc2Tng0MGxVVHR4MXNiSXFMaVB0NDNDQlloTE1YSjhX?=
 =?utf-8?B?YkgwMU9sZGdWajNUMVdLS0U4SUYxeGVJeWFSSnBCYlpic3RsdDNVR0dJYWNJ?=
 =?utf-8?B?d3cxdG8vV1dlTTNaNjc2bkVTSjM1NUxKNkFYYUFyLzZ6L0hNNmhvVDNPRTE3?=
 =?utf-8?B?ZFlNOXhmSGxXdlZaeTNvMDM0bGducmFrWmNQSHRrSng3citsZVlmbEQ5aldI?=
 =?utf-8?B?YU9DckJ4bHFlWWRDdDFzYkRpR2pxbjVENEFnUWgwNys5Q2MzZWFUM3JVdVgy?=
 =?utf-8?B?SXJhMTl5eGs1Y2dvNUhlY2RTNmU5VG1QTVJCZ0pwYlBqYWVxUHFKR3o5a3R5?=
 =?utf-8?B?clNHY2hpTDVPTXFsajNqQzZlZGV6NUdRdDJ0bExQb1ZEa05Tb2dWVWcxZHkw?=
 =?utf-8?B?ZFJoLythcEJscWpGVVBqd1NEMGx0RlMxU1BmTkdvYzRXbnZLMHB2cXVrMnpG?=
 =?utf-8?B?b3pCb29jTXczeC9LWVdTYnVnRnV6NFQ5bDlYNUVZRDZKQW55S0tmVnkxSGNw?=
 =?utf-8?B?ODcyNXFCcm1EaFlRMkpvNkhqWFRlM2JzamVLSncwL2h5K3dLak1rbG1meG5k?=
 =?utf-8?B?cVlwVlJKRTdPbU5jVGlsdHFvQnAweC9mbUFuUFlFNXRtWkNySGI2K2xVb0g0?=
 =?utf-8?B?MzAySEI2b0V2MEEzUVlxaU9mbkFYbEV1eWM2YVdFVHFkZlNLUWFGRGJlMUR3?=
 =?utf-8?B?ZHlDOVYvckF4eHIvU3hVM29ydTcrcjFKc0dWOURDdnhJWGdPVEVadzk3MzYr?=
 =?utf-8?B?V0o0Ni9kL1gwT0JnWVVWU0NhQlFFTk5ZSmxvKzR6NWhabHVvR2tZY3NvS3ZO?=
 =?utf-8?B?VzhkN0EvWUh2RnovMEZKNUFsOVhRd2VuVXNJOFNZM1BqQ0JzYi9lVTc4RWtD?=
 =?utf-8?B?S01aS3FnK3BMZmRtZHc4a0Jzb1BqQ25jaTl3NE9kSE1oNTJ4VWNFMHkwS3l6?=
 =?utf-8?B?ajExdE4wMUhZajZlQmxQaW83bko2dTBrajYzMnBaV3YrcUhxTUhla2dqWWZ3?=
 =?utf-8?B?bXIvOG1UOHpQdk1lSFJMM1lYZThway9TN0N0b0VZbytmWEF5N0tFMTdubUFz?=
 =?utf-8?B?a3Rtc2FXT2k4OGtpcS84OWNCNlUvL0xKYTk5RHFHUXJIS2g1UEFBa3hMNDRj?=
 =?utf-8?B?MGtHaUUrRU56MUE5eWQ1QTgyczd4a0JIZTBWb3BKWEZ3Qld1eDArYVZaRm9N?=
 =?utf-8?B?bzhpMlJGS0h4SzJMTUo2VUJEQ3BBdkl5TVdiUGR3bVZxOGk1LzZVblhvNzVl?=
 =?utf-8?B?MTFVRk1EWWdyWXdHeTYzY0JNeGNvaGczblIrSmNiQUkzQ0txYitORVBNdlAv?=
 =?utf-8?B?VzRXM0VsMFRNbFdpR1FRdTM3SU1QbnVzdDhaejdXUE04Mm12cjdxcGJMS1Zo?=
 =?utf-8?B?dHFUMkt2LzM0MGdkeUZlbkxNYU51MUZKT2l0Ym1EOFpZNmdGUTFnckhubG5N?=
 =?utf-8?B?S01ld0ZDWmlyTDRldkRSbkszcDhSUlp0SGZEdUdIV1RvOWtBalFjT2pHajZX?=
 =?utf-8?B?UlpjUXRpVFdIaUlxMXlKZDV1Vndoek02VTFPRmRsQzgzYWhBWmVaOVcybXNM?=
 =?utf-8?B?elg5VXV3WCtpL3g2YmUrbEVmY1RPSUgzaG9BYko0RkdNQzJ3NVd6Umk2V0JC?=
 =?utf-8?B?cEhvYkc3c1hVOXFubU5wdjN1Y1N2ajR4bU45bFhIbDk0RlBVeEVYNC9MRzMv?=
 =?utf-8?B?NHNhbkhQMk5YejhJTU1YU3BNQkphQnJPZGZURUNSSUxXMmJqdnpHMHNQTDh2?=
 =?utf-8?B?RGk3dk5UTVRFUURzRzJZNjBMM1dtRkhCd3V3clN1ZW9NL2ljQlQ1YWg0WkQw?=
 =?utf-8?B?Y1cvT2tQbEd4cDM5c2Vxb2g1MlBzZ2hDOFV4NXluYzZ0QjkrZkt6YzN4bzBk?=
 =?utf-8?B?ZzU2cVlSalNSSDJMNUxrcWlxakl3TGExTVhXL3plNWxYVG91bjJ5L0JuU1N3?=
 =?utf-8?B?Z1JaQXBZa1BaRUhmYnUyQklFaGFxcGZibzVFU0xWclRkSmNwbVJTYjBrcmVx?=
 =?utf-8?B?b0pvNTVDaWZqS3UrT3Vkb21CQkNaYy96SXRtMXFPb25KNlNEaUdsR0hOS05k?=
 =?utf-8?B?a2NQdTk2M1FoVlZVT284dytEcURzd0J4elFGQXNCLytYV1N2RmlvZlV6aWxp?=
 =?utf-8?B?T3RNUzlFTHpnRjdaS0hIUlc4VVJkMmpkNnBIbTBIRk1rSi9PTURPK09FNnJj?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7oVcwBw9ODpc5YZrP0hNjWunsmyvqRiJdk7Nng5I/9YZHyxvVYIcYWnczazg4mqM5KznD1dxAUAQw4u7sEYO+rOyJ7A62XkL5RA0QRupb0ayk88jy3pXNXbKNXHY02pyP4MWwwHjouMAxFoBrJwj23w0j3/RZweuiAH8HxoY+PnP5Inxb4UYb5NWCj//uTvK5UybnIZ3pp7AYL91iAJzD1eJma0bw0mELo4le4qGiqTr02HWC4ZTyeQy3474VUqp7nFSjgQGxoKGj4HFXwFjSu+m3VKh5U6a9MkJGlB4zoMjUeKUSf9ZfmzOD6A6l2dOL1vA2snXZ0XH7VnG5aGllPRey+LFdac8oq+nserUJP9dbvZWXzgZWJS1Fsu3PohQUOfoZbVB5uMUeXCj8XNBjzn2cqIIXQYAAl1N4LoIh5oWNOdCxqlibR0tSVgEFjnyBxRIoKFiDYm8iGgJ9pjCUcc56kpzcWfgw56uedGtulDUYxBg6QGnYo4tRvZpNPVTOyuT+xSrKzvZoONgu2rMZDq1GEzKPNhqaTIHA/dIPaZ/4ikZ7qrIbAmiBS/1vleve7un4AkVQGnThyt1+lJK0IpM4pGEkwxUq4/07Ui25eU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57af40e-1444-44e7-dba4-08dd735c33bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 09:36:40.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqzfOagz0EyZM+PGKySMku4TWrv3f5resAy6FLNy8f9V2rvzFx817AOBoFkgjRWp6SBLvJq3AbKHS/o8udpsQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504040064
X-Proofpoint-ORIG-GUID: 8cUUl7TAaGkmob_PGcOFSFpA4soTf02i
X-Proofpoint-GUID: 8cUUl7TAaGkmob_PGcOFSFpA4soTf02i

On 03/04/2025 19:22, Ritesh Harjani (IBM) wrote:

IMHO, This document seems to be updated a lot, to the point where I 
think that it has too much detail.

> Let's document the use of these flags in iomap design doc where other
> flags are defined too -
> 
> - IOMAP_F_BOUNDARY was added by XFS to prevent merging of ioends
>    across RTG boundaries.
> - IOMAP_F_ATOMIC_BIO was added for supporting atomic I/O operations
>    for filesystems to inform the iomap that it needs HW-offload based
>    mechanism for torn-write protection
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   Documentation/filesystems/iomap/design.rst | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
> index e29651a42eec..b916e85bc930 100644
> --- a/Documentation/filesystems/iomap/design.rst
> +++ b/Documentation/filesystems/iomap/design.rst
> @@ -243,6 +243,11 @@ The fields are as follows:
>        regular file data.
>        This is only useful for FIEMAP.
>   
> +   * **IOMAP_F_BOUNDARY**: This indicates that I/O and I/O completions
> +     for this iomap must never be merged with the mapping before it.

This is just effectively the same comment as in the code - what's the 
use in this?

> +     Currently XFS uses this to prevent merging of ioends across RTG
> +     (realtime group) boundaries.
> +
>      * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
>        be set by the filesystem for its own purposes.

Is this comment now out of date according to your change in 923936efeb74?

>   
> @@ -250,6 +255,11 @@ The fields are as follows:
>        block assigned to it yet and the file system will do that in the bio
>        submission handler, splitting the I/O as needed.
>   
> +   * **IOMAP_F_ATOMIC_BIO**: Indicates that write I/O must be submitted
> +     with the ``REQ_ATOMIC`` flag set in the bio.

This is effectively the same comment as iomap.h

> Filesystems need to set
> +     this flag to inform iomap that the write I/O operation requires
> +     torn-write protection based on HW-offload mechanism.

Personally I think that this is obvious. If not, the reader should check 
the xfs and ext4 example in the code.

> +
>      These flags can be set by iomap itself during file operations.
>      The filesystem should supply an ``->iomap_end`` function if it needs
>      to observe these flags:


