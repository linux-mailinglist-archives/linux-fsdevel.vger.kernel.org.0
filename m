Return-Path: <linux-fsdevel+bounces-32329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38C69A39FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800671F25322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF701F12FB;
	Fri, 18 Oct 2024 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cuHa8L8T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iab75FiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776F1EF0B2;
	Fri, 18 Oct 2024 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243781; cv=fail; b=O+7ZqH+HwdRCvylxKgXYAl7mb5V5zI++viKs4nuunNTmX+3/QOgF5XDUIdaYK3CCRymO+shZ397R4Zp9eI76vKWZ/VpsB42jeAIQXnDlF0ASGPbJK9VMC+3WI2fiNeHRKv/ew7kErOcDJ5euet9Oto8QmN/oCcLnGRor7bUT/YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243781; c=relaxed/simple;
	bh=IGqDKTdH2GEpMYncG2jU6vLqwMHU6XYV/ncy6765Cc8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHv1iJaLF7jrAJ1ftoeeZ8Vpa+7LoG6GWTHeK9FjaJggGEsl8zOC4u4o3rHU1D7db9wbSRJfTaOU4i/3Sl0lcd7Pbi7wvokloMumTQkv4JuSwIO49DywZMPeYAexy+Py73/QY6T4+cDMo7jBOIF+xrdVKk8IAuMgPR3be5+LPAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cuHa8L8T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iab75FiL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I8fwNm001205;
	Fri, 18 Oct 2024 09:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=y81UFp2KDTT9xs/r9zsJxJGwQuJXaQGy16LMLl4YJQE=; b=
	cuHa8L8TzMiw0s4m3MGdXl+Y4TJj7+3M0QFGhyPhQIDOtEmCQBrstGPMM1CTgP6M
	sJo9xUPYRS4wP68dwQlsvhJ0k+T4tBFuOmnqpD/zgN1NJll4UUx84wkC8Wx9AJh/
	qn+ySFWH4GMbS9Kdul8VLOVE98PlXHqMSGSCv303/LTvSIEeZePjlCKeasn8tGCe
	hGpps/CNAk8CFeF2ZJvxS141oxP4C6TLX1qlGQ2Wvu/uM0q9y7hKr3AW7kTlpVeo
	IvC3EGqi6LboPCOHE9JTrf1F118JkUwkw/0+vnIzgEZkVauhyHjwVPFCTA2poRw4
	0UYAzXrXN02hwjSZC8fZdw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5crrtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:29:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49I7ilnL012214;
	Fri, 18 Oct 2024 09:29:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjhqrms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:29:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLmO09c996cV0Fxgb/ZkqihKO+DIFnT8aQ7znnyRJlV8eEKTHAwFmu3MA2jIPNXxpk+5ca8GUn5BZhk84Jf2KQ/uxMga2tOmP3klf/MkFX852nQj5DrL4wDFmVun2Idz1cAbaWby+gLT2xWCiSJt7ZqBYD9z22yQCyQZEMuVs3rQINf/AgwyVB1s20UOVXYYZlzl0YKBc2SDuDQCGeChR8k4DD8QQgH4BLi2LG3RTqX75qOjtEUmI7ewfGHd95TLLnOZyPtkI7acP3Hd+xNQAMNdrFPIu4sJ0VQdvNKJwW5gbTh7aZgu5T9CvNPQYU2u+wM8nQxkyaUe97HZLKX2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y81UFp2KDTT9xs/r9zsJxJGwQuJXaQGy16LMLl4YJQE=;
 b=JQsVOeG3EhqeCSUHuhayByOimyhI30dzu9NOGW2nvaHkBEcE+1z1t51HVzAErqEenEzXd+Zw3MmpGQvhZxwY0wcze/k1CZKPRQ6nZ7QUj5Io5AKALKYTyMnwYhoDl914Q6vUYRuTioFgZKL81i3eOHM+pQPK0B+/6RAwzEY9WWvc1r3GMZEJBydhgYHehFQXBBmMM8VZYeHVqtzp9Nw6AAqmdp1a6v0mzB/a1KPqhf+9C/gmZ57LJrSDEmxJ5Sqc2TCYUskJjQO/q5Qf0OCPVRST5dxerK5MZJk1sCqd1n00kkDN0Ul0v+VZGHYaMHz9abuS/gnSKoWZcMnq60fblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y81UFp2KDTT9xs/r9zsJxJGwQuJXaQGy16LMLl4YJQE=;
 b=iab75FiL4BdlNZKoZbvUnWSVJ0cD1H4ui7p2ivPNeMrenNxHumePg+DoXb9OBgeFX4qwrBARtX8DDC2Gv25odG/qgeHl2y8pXZIYM26ZTCHImkJYUgAEJP1gB3bqdcn069sSxVtLD1PiVGCmNmHim82qVMogIHJSZxqKvoAlR78=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4159.namprd10.prod.outlook.com (2603:10b6:208:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 18 Oct
 2024 09:29:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 09:29:21 +0000
Message-ID: <8107c05d-1222-4e47-bbcd-eba64e085669@oracle.com>
Date: Fri, 18 Oct 2024 10:29:17 +0100
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v9 0/8] block atomic writes for xfs
To: axboe@kernel.dk, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, dchinner@redhat.com, hch@lst.de
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <20241016100325.3534494-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: e67e5604-7f75-4230-d1d4-08dcef5758ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M04xbTNEbnRQWlRPWi8wYTVVUWRqdEJPMW0zVThJMkMzeC9CVnZuUnFzdFhV?=
 =?utf-8?B?MzV1dEwxYUF0WFVRNWhoZERWTGs3OU9BRWcwTzdLMXZJSTJGYW9LMXY4bk11?=
 =?utf-8?B?dWE3ZFpZUU55YTk0emZteXV0U2E2b2tCajQzb3FreHpIZjVkTDRDZ0pJZFNm?=
 =?utf-8?B?VXhJVDB2VjlRa2ZBcHRON21Cclg4eS9zaEdQSVVib3I3VnNWMEZCLzVIQjhO?=
 =?utf-8?B?ZW05b1pqdzAxSW1CcFZMbDJabkFJQ1dZczNCZkZLU05JazVHR0ozeUcveitC?=
 =?utf-8?B?T3JPaGtacVBmNkZiYXJ1SXFMeHkxTTl6SGxQeVd1dFIvdkNnbzgvZTVoV1Zy?=
 =?utf-8?B?dkxDZ2p4d2NaRmZydWk5NXFhRmlhQUJNNWQvdHFXcGdIVDFuNHlHRENwWnN1?=
 =?utf-8?B?WDVvODF4cmVTZG9yZ3ljd1hNSnlrVjlPbkVLdGxEV0VQL29IREdZOHlDSitS?=
 =?utf-8?B?U2RKZnV5TGVCVjNNS1Vwc0pSTmlQMWFYK3A0enhFaTE3R1kvZzJLMDNwYUFB?=
 =?utf-8?B?ZXBucTc2eDdYZDlGYUdIQVY2WnM4ajY5dTBKUTdBeElDUGlHTnZwZzNzK0lR?=
 =?utf-8?B?dFNtazAzZGlZTldDK2oxMCt3M2RYbkV2MXovdGZMOFVYWDZ3NVU0KzVqRE42?=
 =?utf-8?B?Ymo1ZFNWOHNLVnZmNGIxQlBON3dSMUt4aElMTFlSM3hQc0t2Nk5tdnpFeFph?=
 =?utf-8?B?ZXg4WGhaQkw1RFRIT1BzMUtFb09iVUQzVGtJTXJLYkVWRTQzTzV0ckVsRExj?=
 =?utf-8?B?ckhUTFNSVFIrdmwzRGFWd3QrRmUvK2hxU0RwNHJIWmd0aERtdXZYM0c4MXdR?=
 =?utf-8?B?amRLajNZV0dqT25CR2k0QmhHRXB6OFkrajRwckxLRytPMVFKcGdoMEdzT1p4?=
 =?utf-8?B?Tlp0OTM0MkJlMWlvOWxPb2tIMXArVkVHYWtTSkIrMVN5eTBMVXNHWTYyaml3?=
 =?utf-8?B?cGRVMUdqVjNqcGsvelRKK1dUbUdOUExrYkRWM1BrSXFvWHRza2RUc3dmQ0pF?=
 =?utf-8?B?MlJVcEZWMnFhZ20yOVpPcnlKNjhsWlErVFc4UjhWaFBkM1BkV3poSzdLakxq?=
 =?utf-8?B?QnlENmFnN1BheEdBSWQ3bjJjdUd3VCtBVyt0NnZKdXBLc2RQRnVyVVlpOXVF?=
 =?utf-8?B?WDR4MDRSSWFsVGVjVU52VkJaNTRYcmd5TDhzVDdyV2prVmg1dVJSODNPeG9F?=
 =?utf-8?B?MFZsNlEveG9mSHRrRGs3YWVrbXhBaGNtYmxsWnlGdnByQ1VBci9kTktkMDBX?=
 =?utf-8?B?WUE0WjVscWM5M09pa2NVclBZWEJwTElEOHJtNzlBbnRXVVQ3Zm5CNmVFcjJ6?=
 =?utf-8?B?N1ZQZEFTenhFdnlndE03R214bEJzdnBHa0hidTc0MDRrbVBGSGQ4UHJWeUJV?=
 =?utf-8?B?dGx0RXl3QXBSVmRpTFRNU1c0cE0rT1diNkdFYzJQWWk3c3AvUkl0MWdZRUov?=
 =?utf-8?B?eG9Jb2RCRU9mR1F0VFRBNUxJdVJSWmJtTFd0aU1YNDNhdFl6UHpTNG1aSkR2?=
 =?utf-8?B?eFhNTE1iMnAyRExhZFg5VkN1SDBFOStQdkM0cmtJbnZJLzZydXNOMDFQOVQ0?=
 =?utf-8?B?MlEvaURxdHVWSzRFQytMUHUveXVXK1VuSXhhZlIyeUd3Um51VXliWC8vZjM3?=
 =?utf-8?B?RGR3QW52TWJnN1RjaDZUTXBXZ254aXAwRUJYdEFISFRXYVpEWWtXdWdBOThB?=
 =?utf-8?B?WE9JWkZqL2FtcnI0Y25ZcUUzVE1sc0RqTG00dk0yVS8vYU1UZ0FySmFGTXFU?=
 =?utf-8?Q?5wNjOJbiH56ee1x7iFKArReX4qTMnmMN2JpylD4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1lQOUlWR1NDZVRQMjhMRDlyLzBOTUhBWmVrMFBFNW44bW1neXhQU1VJNzhl?=
 =?utf-8?B?cGQ4OFpQdExDVG9PbXNLeCtnZXViMUxZWWxLcFltOU1rNUJPaFdtcy9rdUt6?=
 =?utf-8?B?S2N2dFplNDJ1QXZCdmJTUVA4bUNYS0pzOTJtVC90QzBocjRnN1NLUjNnK1l4?=
 =?utf-8?B?UWJBT3hXWXc1bCs4MFdmYk9OOWliMVVVM05UL2t3UWFaVjNBdVdMckwyVlVT?=
 =?utf-8?B?TlJicjk0QnNUZnBWUnl0dGdMazdubzlzZWhuNXBYQVV6M2dsdmE2MEN4RHRK?=
 =?utf-8?B?dE5lL2xTZUJkOWZERlF4eiswOUNjQ0FwSExPMWRuVzgyL25LZkM1eXpXWXJJ?=
 =?utf-8?B?N3lFemF4RzhEU2lsOTg2SStzV2puRHpOSkF0emIrb3NnWUt5bE93YVpSTGdT?=
 =?utf-8?B?K1E1V2FoS25ZRjFsWnFPN1I2K2EraEtRMW5hSEQ5NFFNK0k1aWlSdW0wRkMx?=
 =?utf-8?B?VUx2bVg4UVNTYmxLR2IyaHJZeU9oNS96eExrVnZYckZWNmRRN25wNXNmL2N2?=
 =?utf-8?B?K3lXeFB2TVgrb1hOTy9VZzhLajd3am8rWmIzaWpHR1h5NzdxUVphY2VkWUtN?=
 =?utf-8?B?a2pUSWQ3cFdsMWNNd0pxeFBwVDJYZFRDei9FUVZUR3RqZVljRUdlcTY5M0U0?=
 =?utf-8?B?Z3NaNFJQcWNJVm14UE1FOG5mQnBDaElReXlSQXdpQUs5aGhhZHc4MUdqa2xF?=
 =?utf-8?B?ZGduYnB1Z1ZvS1UzdGc1aHBwZFMrNEpFNktobU5VYXVBYURETFdmQWVVU1Bo?=
 =?utf-8?B?QnZXSE9QWEw5ZUZSZVFGWHFVRGEwQy9MVjA2NzAxRE0zcHUvMkRWZ1NjRnNP?=
 =?utf-8?B?WTRDWnN0VHBHekE1NmpuOUJaekU3eHRIOGdjaHJBWld6MUtSUkhyZzNlckNl?=
 =?utf-8?B?SWhUbFJKdHl4NDlLeE1rSWNrQ3V2czdJWUxpQ2xmYTN4Z2FYUWdRZkE5ellR?=
 =?utf-8?B?bW1FclNIWm9nT2Y4QjdUSEovb1krYXMwU2I4bllXdmlSdTdTVUd3WDdFR1I5?=
 =?utf-8?B?Ri9JblJTUkw3OXZra2c1VmZQSSs1M1o3eHZVd3dJcFo1UFU1cy9saWhmV3RZ?=
 =?utf-8?B?MytLOVZtbWswRGdidEU0WEpLa29tSVFWU1ZkTWpYbGtkVmpqTmc4UGJnSXBZ?=
 =?utf-8?B?bFFIYlNHeVRPTlgxcmE0M1FLYjJQZCtoNW1pajZzdnFBOHRqYU1pN2JlNXlU?=
 =?utf-8?B?WWVwdWVVd0FhVnZ6bm05RUJyZ0lpSDdPeGJUVU42bGUzajJPQ3FLSU1aQ0VU?=
 =?utf-8?B?VEF0MERnbXdtbFVVT01scGdpL1U5QUM4YzlMNzRtY3RRWGorVGhIZXBvY3Br?=
 =?utf-8?B?L013UXhVU0tXRGlkRzRsZnBKM20vUk43UU9hY0laN3dpd2ZBdmlvcG5GdTNj?=
 =?utf-8?B?cHlleldDVkVLYS9jYTNuRGpsUjRSWFl1Uzc2SWFqRzVXZnpDVDBaVVhVU2Uv?=
 =?utf-8?B?K3FNamg5d0YrLy9QTXVQazFjaTFXYkcrWVpjYkpVSVQvd3JGeXppWTk4RVRj?=
 =?utf-8?B?UkJCSnZTbXNEUFcxWGlQeHk4V3U0SW1KdU9vSmw0aGhEdDhneEtueGxWckIy?=
 =?utf-8?B?OGtyN2E4NjhibGV5d3RkTmR5Mm5scE9UTHhYTHFsTklvU2NoVGJBVHoybDcy?=
 =?utf-8?B?UkM1ZXJhTnFPcm9QWmxITVdwemZSa0cwekRXeEZTczF1cjhEeEJtd2tOM1hV?=
 =?utf-8?B?UmZXZFhNY1I1aXpVVGgwczcwaHBqb2s3M2FvSW1qZXNhZFVaSXpDdDhzNnZP?=
 =?utf-8?B?OGYyTVNLNjFKY1JHbFIrMUUrZXd0ZHdrTUN3MFNRTkZ4NDlqbFhjSjhrN2pG?=
 =?utf-8?B?NFY0dno3ZjFXbkM5VTl6elVQaXdwazgvTkFKQm1KYXpUcTJ0eUMwU1BVVVFE?=
 =?utf-8?B?WnEzNGhlK3FiMHR1K1ZBcVc3WkVTQWVvWmUvaE9uYVNiRzN3U1JjNlVSQmJR?=
 =?utf-8?B?QTFBS2htMGY1aXlweVJraEtTWEU1dWs1M2N1NVNjK2ltM1lYWFViMmRFRXN5?=
 =?utf-8?B?NlpqeVFPODdzNUl6cE5XUjlzSElXUklzcjhvM21RT3oycXdNQWRDNWpnd3E3?=
 =?utf-8?B?OGxOaFJFOFI0UFV3RmdEbWplRURhOG9RUlUrNDNMMU5jcjk2cVM3enRkV2pw?=
 =?utf-8?Q?D3QHfGsux5ElTf0ArBvjPWzdD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IyaiSCvV6k6KmRz9QCLLHE+iSUgsQANhhrtprcNBXmJ5dLaEevgocamqK8nIZL+6i8Mg9HxkCo/ZNKTAClGLBFNj2VQOb9sdQikLWQX6xUUoiDIaCsWrybofJLL0OjgeVUr5lO9JhKJJLiuxo5og1sMHBDnqG/YmHEZadF30z+4+3ilkJaEizt2mOouBIKxAc/ZcLco/AY4T7y8yjkEphcsIIQkXpscb+lsdowxkF1TzB1FmFs8UHuYsjTbXGFuG7ao5yIgCwqFFf7tDpLXgvOsg/0oq1PdoLM1O+4V6W9PQMIwLf0cBz2UzPWF063bSlIaChNl7kI2Dah5BytW9aydXCZs0tc6UsCTRI9TUe3avKSATgCq7tp3i55tqlzNUdJklb7cUd25hIG0VfEojDBowypIk20bIVFp0XrhQjDPkKGvXi8ibrtZYu2GIxAfCJQ1yeu4swIlw6wXrB7U8ao49CzGxpvUm7lNE9wo0iig4z8+Ycg5g7rLNQOgknASogt1CWtbo6EAVx4Nqk3GECXuLQGwIwH4WQ2FUiiIAp1az8SQruIFOV43/Fdjw457DUrp//sTc7ADfjWRPMszro7DJX6PZ9sRwwdF+1gVYrws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67e5604-7f75-4230-d1d4-08dcef5758ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:29:21.7106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjJlsMDdpjgFJrIBgaVAIVgp4QcphNCSQiB/Dn5pxikvSNzejNklx0YG9KqDsoSQ0ED1El5xm7p+iqW6FF0CXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_05,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180060
X-Proofpoint-ORIG-GUID: cok9gqKpzGheHPEik1TGZ08g4RJP3yl2
X-Proofpoint-GUID: cok9gqKpzGheHPEik1TGZ08g4RJP3yl2

On 16/10/2024 11:03, John Garry wrote:

Hi Jens,

There are block changes in this series. I was going to ask Carlos to 
queue this work via the XFS tree, so can you let me know whether you 
have any issue with those (block) changes. There is a fix included, 
which I can manually backport to stable (if not autoselected).

Note that I still plan on sending a v10 for this series, to fix a small 
documentation issue which Darrick noticed.

BTW, I was hoping to send non-RFCs patches for atomic write RAID support 
soon, originally sent in:
https://lore.kernel.org/linux-block/20240919092302.3094725-1-john.g.garry@oracle.com/
https://lore.kernel.org/linux-block/20240903150748.2179966-1-john.g.garry@oracle.com/

They should not have any dependency or conflict with this series.

Thanks,
John

> This series expands atomic write support to filesystems, specifically
> XFS.
> 
> Initially we will only support writing exactly 1x FS block atomically.
> 
> Since we can now have FS block size > PAGE_SIZE for XFS, we can write
> atomically 4K+ blocks on x86.
> 

...

> John Garry (8):
>    block/fs: Pass an iocb to generic_atomic_write_valid()
>    fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
>    block: Add bdev atomic write limits helpers
>    fs: Export generic_atomic_write_valid()
>    fs: iomap: Atomic write support
>    xfs: Support atomic write for statx
>    xfs: Validate atomic writes
>    xfs: Support setting FMODE_CAN_ATOMIC_WRITE
> 
>   .../filesystems/iomap/operations.rst          | 11 ++++++
>   block/fops.c                                  | 22 ++++++-----
>   fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
>   fs/iomap/trace.h                              |  3 +-
>   fs/read_write.c                               | 16 +++++---
>   fs/xfs/xfs_buf.c                              |  7 ++++
>   fs/xfs/xfs_buf.h                              |  4 ++
>   fs/xfs/xfs_file.c                             | 16 ++++++++
>   fs/xfs/xfs_inode.h                            | 15 ++++++++
>   fs/xfs/xfs_iops.c                             | 22 +++++++++++
>   include/linux/blkdev.h                        | 16 ++++++++
>   include/linux/fs.h                            |  2 +-
>   include/linux/iomap.h                         |  1 +
>   13 files changed, 151 insertions(+), 22 deletions(-)
> 


