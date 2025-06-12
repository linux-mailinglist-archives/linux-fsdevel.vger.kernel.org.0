Return-Path: <linux-fsdevel+bounces-51507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8FFAD777B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 18:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE2A3B5E0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7E27144B;
	Thu, 12 Jun 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NycjEnhu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z+c5YZE6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1362989A5;
	Thu, 12 Jun 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743924; cv=fail; b=EaJZpkkU6DpcLNp+VF/qFSzP5Pqk/PW0cDht6hrTUe3bSifAauu7fTpCswqFPoqzGg7pJq8m164+UDi5GLyq1XRzwxUmXjR8xU4KzNo4i1oIYyfsgDpg/pi1N5AN5PB9+ow+rT6m+4+2Xy/HYPzXrU7bhIUB5bhDN8FQMlJLfr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743924; c=relaxed/simple;
	bh=vSB9fRY/GzB4AKt44RbtkH6FFhoZfcjtNvPWZxhjgMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tA3/WXtoguIeZkPanTGwieF4pML5Nwmw146+HCBY6SzuQH/ReFou7iOmWUmceXQedfFJKUYrTCdzMGYQlg8ejRU65rAANiG7lpO/nC9WiIddcvva2Ioa+48XWxROuG9APKo+pFgkEum9jYsNqB0o/Aj9F99TBKFxfcEqJYRzqgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NycjEnhu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z+c5YZE6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CEtfL8004362;
	Thu, 12 Jun 2025 15:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bPAeYITSooNg4czKbJsl01li/dNbYfMMCtg2aH8C2Y0=; b=
	NycjEnhupdljAVCx+ilYp4QnUGDATtfxMKGETk7I1rRuvC34g+lvzDwy0YMTgtJh
	HrJboqKVllnUfZIR5Q+zJIDjbTwQkRkjx7HD5BAQ+QygsNEGCJHba9GqIxoj3I7U
	rNt3/I+lHjvOu9uWwwBMSCEVsAaoYRXX0NBj+jzzQQ2Nf7EDZ6BHNq5739ZXX4kK
	ikLt5Gj1xe/SRuON1Clxu+fLNe0ym0YnEhHZFY5QWjOcOZ1fw3/N+qLI23HCVQes
	K9uxVnh6GWzjzv46OIcjjdYxO2A91NVp37a7BQhsXHealTWYgE5ShvhnQt2RH+GB
	oxx3QJrtwzjb6AxpGSKM0Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c7522fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 15:58:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CFd2vr031918;
	Thu, 12 Jun 2025 15:58:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvbsb5y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 15:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwHzmA3JOGeIxk4YZLSXeKRCHQiWH/d5t4pwOyCBT2jnV6DVUbwil6kniqS86V67dy0EB0EKPpid67c4xrQNJVGLNuQOC9Z4kKeYw2WZ6je7xuOQlQZnPpbtlvcTnvQrm01m1td8hFl3YL0b+IYqwe2/y5k2w/rwPu4LzMdV0I2jObrWwbkc+/1/YGIUX/8+vzKAdsnf3LwJH4JuCS0rHmO1pQpKqz9zUVjqZGdlKYBkrMZ/AqJP0SGnKoG/Rqcl0hzVj+REZxfjAQZ/LKV7pRou7SIuk5BdYldjf6AcwHUcoyXbEVIjSUVoEfhQz3p/w57AoUWs/NAfPJvT76o00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPAeYITSooNg4czKbJsl01li/dNbYfMMCtg2aH8C2Y0=;
 b=WZ0Aljdp+nalMazzEjy+uCrwRxJdH85gtTv6gVNWLx0uBF7/1G7RVgSaVlPQ9wBwa+JCwh2l5ZeVLOGGKTAUxof2DXjpflq2bqoh7lDkdZA7lnbblDf8KlZFukMdnkgTUrmFWUWoYWX8ab8uTvKkMGDYWelCTVDGWzJm9u0ULhku66b7Cg4l1VahTbIL0UJY+i15XAPwLeHU8BUKsD8t1qj+ADT8kUUYSWhxK2c7cPEKB/0yG3weTsO1qfXQ5FOm02XpQCJaubZS+CRgkD3xOk6i+luKbJgJetVL/Xgp0v78Olf5mIfEEBprAawmGODQ3N2CdDGf/PLhr3LxCUMmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPAeYITSooNg4czKbJsl01li/dNbYfMMCtg2aH8C2Y0=;
 b=z+c5YZE6fKbUJ5UYl7rEcViS0XsqBRQSmTGvxGWG5CQ9HRxYJOG2UWczrTzngjmBLY0QiLphqRRR5IGmWI/3Fzdr9aTGdVUlwN1fIQEPU3sqIdrpEIePzEzCE/AmHz6ewvAeBdpD3kkDT9qa9cBITJy6yXPJux1nK58bpGqJT4Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6757.namprd10.prod.outlook.com (2603:10b6:208:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Thu, 12 Jun
 2025 15:58:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 15:58:28 +0000
Message-ID: <04acd698-a065-4e87-b321-65881c2f036d@oracle.com>
Date: Thu, 12 Jun 2025 11:58:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
To: Mike Snitzer <snitzer@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <5D9EA89B-A65F-40A1-B78F-547A42734FC2@redhat.com>
 <aEr4rAbQiT1yGMsI@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEr4rAbQiT1yGMsI@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:610:53::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: a38d7568-65ea-484e-a975-08dda9c9f908
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bXdscXJHbGswOEpTQ3lCN2xlRCtDd0loQkRzOFFRR2JwcXBwV0kxTVdoWVhx?=
 =?utf-8?B?NUxIRTZBWmIwbjNlaEk5aGhRTzFWZldvdXk1bW1LYUtwc21PandyVlhtR215?=
 =?utf-8?B?SkVHL3ltdXpBWmxnSEIxNCt1di9ubTl4RUpTNGFKcWo3OTNXbG4xU0RHQmtL?=
 =?utf-8?B?elNQL1R3MEExWUxuaDZMVXZocksvTXM1bkUxRGRTMDBHVVZpa2g3VXFkVlFG?=
 =?utf-8?B?VlU4Slc4S005OHp3YmxZcHdJd0JLT1VwK1RZQlFKdG1WcnM2UXA1ZlgwaVNM?=
 =?utf-8?B?NVNpb0dLMW90Mms3bkJ4SjRIenQ5N3dSdDlnc3puQmVrSWhJRTM2S2xMZDVm?=
 =?utf-8?B?S2RJbjZlalVHS083N0NDa3VlWWZoU0ZpUld3RWlOS0ZadE1YNFREV0g0S0Jy?=
 =?utf-8?B?YUlNdlRjZmNFdytrZnhHZkhxTG9VVDRUR040VVRFdEx1dXNQaU9LR3hyOW5n?=
 =?utf-8?B?UUdRWG1GLzVMcTVjbE9SRVFJdWJMVERGaDlTb2FZSitZOCtQR3UrcmpaVFF0?=
 =?utf-8?B?YkJxdjNpbUJNVWYyZmE4dkRZR1RqcjlqSWsyZUx6ZjJLbUZWa1BmajRQNTNO?=
 =?utf-8?B?RkNYQm94cmZ3UUV3VGlxOS9mT01hcHZzNUcxOTBWaVBHTG5vVmNGcTM4SWJi?=
 =?utf-8?B?L2FwQU1zbHF4bUdjTkF0Y0xteS9BWFI3aHJRYjRkbGxndHhxK28zdXM1djc5?=
 =?utf-8?B?amFWZXFVNSthb1M3RFFCcUpFSTNQSnZYOTJvUXo0Z3h1RHljRFJPYnI4WHBH?=
 =?utf-8?B?TUFndWZSSk40SDhDdnpFcE12NVljZ1FxNUFYbTRWOXZVOTVwaVZRQnlGeHZT?=
 =?utf-8?B?QW5VbVZMSHZubnd1Nm5ZK1o5dGlFL3RCYktycDlQdDJsZGovcVl5VjUrenk0?=
 =?utf-8?B?ZXR2dUpnWjRPcE5MQzBWSnpsKzNnUEVXbHVwNTBqUDkwdUF6czFEMnBmQ0pY?=
 =?utf-8?B?TC9aMlR3UEdoeXRQbkF1MktrWXNTcVZldFRPOWxGYThCVmpJWkxRd29CbW5V?=
 =?utf-8?B?L2txdnc3UTVGYU1nN3ErZ1ErbGxtNlFxTmo3amptZHBwOXV2WlZBTGVtaVl4?=
 =?utf-8?B?ZjQwVWxrSW0xNXUwRG56TWxDQlJ6STdOcEJvODlHUnZCNTBOZUY2OGlvbVI1?=
 =?utf-8?B?THBXWjhHTDZpaWVqSmNQL3hEQUJGVnlRWHhhcGlzTnltazlFRTBpSTBMMUZi?=
 =?utf-8?B?Y1MzazNUSmtrWDlOYnFlUUdveE9kbUJWL3F1RFpJSWFxclB2L3lHcGVlYlB6?=
 =?utf-8?B?ZFFQSDJUM201TU1SY1doSkJ5UkcvZy9waEtGZGFONUFHdUZSaVI0Qzg3bmNN?=
 =?utf-8?B?dGFmdHcxWHpWa0k2WElxR01UTjZsbnFwTlBocmZxSjB2WGUxQi94YnFBQUpC?=
 =?utf-8?B?ZW5MZThSZHJScXY2NEZVKzBUTnI2ZVFvOVgxWGVzd3VFSjRKK095anczMDlK?=
 =?utf-8?B?TTE5QmFnejNwajg1VDM4MEt1bDJXNUcreFRHYkRwVGM0RnArYjI5c3daRWsx?=
 =?utf-8?B?d1p5RzdJYWhTSitlN1F0WTBhNTBkSmMrYnFNc3dnSjIyWHRqTFM1RUoyNktw?=
 =?utf-8?B?ZlJFMzJ4ZERVSW9QdlVJSEs0dG1Zd2M5aGpCZlNzZHRrMWlwU0dMR1pmbjRt?=
 =?utf-8?B?aDEvZDFlSXpFVjFSdk9sVHZISDlYRjJyR2RzY1FKcDB1QnhFSWlLcTUzUnd5?=
 =?utf-8?B?b1Z6VjJUSTJQQ3lNR1J1eE0vRXUvbVRXcHRhTloySGtPdlpMSk5KNzI4WHA4?=
 =?utf-8?B?S1dIM3BSM2lnRlpseDZ3aWRQbEZkZ0ZMdG4xYWFYaGJZUXhSbWhxZnAzbnFL?=
 =?utf-8?B?WUNKUUZjblZkRmdNbHY5Z0k3djA2RXp6NFdLSGE0TEQvMXdjRi9GNUtQbGtC?=
 =?utf-8?B?ZHl0ekJMVnZmUzlWZk9YMWRyRGRTOTFwL1luL3pLRFV2MGpWMUdlUXM4blEx?=
 =?utf-8?Q?bOPGNpKNV7o=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Wk9XS1NXeThJVDJtVHhTRGI3SEpLVXpvemRkbi81RWNyRWFteWxWVXJVL09v?=
 =?utf-8?B?RndGUWNSZkVxa2JnYnNYR2ZucUFCdTJ3alQweE40cUc5ZTNsUmtyVXZCdVJp?=
 =?utf-8?B?akRMbnpKM0Q0c3k3cFR3WlF1d29LZ2x1UXY5RFdnazV0LzhMUE5vSkZneUtL?=
 =?utf-8?B?R0ZodGd5OG10cDJaM0NabjZ1NlhEQTVWZkgvbmxySGI0eTAxYnNLbGd6NVdq?=
 =?utf-8?B?Mm1BSTRNRi92c3UwR1RSdmJYcXhZRGJmY1Nab1A4dzAxS1R2VGRLbWVFeVV4?=
 =?utf-8?B?dUFjTEducmVuaXJGVkhxazhFdk8wTlk5TGc5WUhQNFRsU0RROFNBci9FMEx4?=
 =?utf-8?B?OFM0TWEvTWlmNDArSEltK3VuTy9oVTRlbk15ZTg2Uk1aKzdDQ1RldzB2UTJk?=
 =?utf-8?B?ZlBJVHRudk1yb29DYktjVFBUVGRabWFPbDk3dERvZ2ZFUytnVkFMR0xMRlhm?=
 =?utf-8?B?d1Bsam9aWDQ2ZlBVKzNtbkxLQUFHMHFzNk4yak9RQXF4RU1IMkNBaFRHNlpE?=
 =?utf-8?B?MTNyYmhwVC9jai9ITm9kVzdKbEhuVlhteXFzU2dIcWhxS0VaK3pISWRLbnpn?=
 =?utf-8?B?QWRleDdoL2Y3T3FQZDY5bmMzTVN3OE5PSVMyQ2lqSVJTa1hRSm9CLytVQVlS?=
 =?utf-8?B?RkczelFpa1pEN1dqMk1GQm40VmE5Z0JkYlJVR1VHU0o0RDdzMEx4SXJ4SHE4?=
 =?utf-8?B?aG1nb2ZGMXVmajFxMTF1bEZKSVN3eWlrQzEwVXFoK2NlSUhQS2RXbmJrRFZp?=
 =?utf-8?B?OFpVQ2h5bUtmNFd6akFhdTVWTzAvVjZHdFpNSEUvZTVXcjB0YXovczZZQ25B?=
 =?utf-8?B?emRHb0hFNUtpc25xMW9UQjRQdFcwRGxWVXZrdFprYnBXR3BtWURvNlg5U3F0?=
 =?utf-8?B?MmVFUXJraEdpUkZnd3lzQW5EOU0waS9VWDJDalFTSS8vRElEUU9DVlM1Q0JD?=
 =?utf-8?B?RTRZRnk0K0pEbDk5b0tUZElBbk9GZWFITW9Ecmx3aFhxSHlQaTBKeEhhTXh1?=
 =?utf-8?B?MGtoVDdiRnFvUkpXS2xsLzBucHpITFFkMzdlRm11S1hxd3RmWUJKbU9nb3Mv?=
 =?utf-8?B?Y3J2bDVOenFpbVNZZ2dYMFVYdWlJQ2QwWU1UVi9wSmI4NjRxSVBuK3c0Wm5x?=
 =?utf-8?B?YjYvcVJVSXB6RDRuNW1xaE5GY0hxdHRPYUV0MlpIV2l0VC8rd2JFREl4dGp0?=
 =?utf-8?B?MTZLdXlPREN6c1hsUElhMFc3MDV1c2Z2ZGxXTlZPMkVpbnQxTVhqUGNJQ2tt?=
 =?utf-8?B?cS91OVNRNVFoYTM2dVZKZzBPbDM4YnJhKzJiOVNoOWplYVJpOXRHTUU3R2pN?=
 =?utf-8?B?WlZtSCt6SVdiZElEeFp2bVU3UGNYR3l3OWZFY3k5YzVBcUIvcS9FV3U4RFRz?=
 =?utf-8?B?Sy9OVE5GVkI2czlWdzh6T1EvaWwrMnlwRHNnSythYitJTS9ZVGp4aUlIR3px?=
 =?utf-8?B?QlVPbnZTbzhoOERaem84aTlmMzRaRlNZUzA3U3V0ZE44K2wvY3JKTkphZWJt?=
 =?utf-8?B?QlJNR2Vwd296VjRMYnNYeG15Y2RSTTA5c2tMcHJGZFp1bVZmSTVDRDVORWF2?=
 =?utf-8?B?NndRSUkveWJLTzhSTzlwbnNjcFYrWFk1TVBxUDU2ZVpHeER5cVExSTdGMjlK?=
 =?utf-8?B?UUtkUVZDSDFjV1h5a0JxdDRNeDlHZHQ1bkNSa3lkQWxPdEdzajA5djJ3dEZy?=
 =?utf-8?B?R3pqNWdNU3Y3YzFwRzdCLzhIVlRsSUVLZHZVekhvb285NGlvUTFYSWFTZklV?=
 =?utf-8?B?dFZnUGpWbDNRWDBFdk9KRGovRlk0TzhtdTBDRjZIcXZsb2F4VWpCblgrek1T?=
 =?utf-8?B?NHZ0OTRPUFFlME5VNjRLTmVVdU1wNlhWUW5JL2Z3MW5wUndmQ0xXM05Ebm5C?=
 =?utf-8?B?V2RjZUJJMjU0NjJ5OS92VjZjWVJ5TmZDWTZnZjhHelloNWpRcTJqUEhjYzkw?=
 =?utf-8?B?N1NpendyWGM4RlZkRk5WN0hWKzNSU2NnWW80bFp6V0NIRXowQ3VyNDNId1l3?=
 =?utf-8?B?QVh1ZU5ETndYVnBybmdVQk1ZZnFveXNESEJDOHpudlRpODlrUW9CVDBveDNI?=
 =?utf-8?B?aFlsKzN4aElTV01iVzljRGcxelFXdlhUS2w3N0h6TXR2Yy9mV0J1d0hlT25S?=
 =?utf-8?B?UFdTRUdGR1dZZVNlWFMrZWgvaEtrNFFxU3VTaUNleHAyN2tCUC9wSDRTekN3?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RPb3cHIFL2sk4V5Yg0kZMjoP2b2wtHQrLVPOT1IbwOvbFH8r/C1nahVozExxH0LJZPgc5aLpU1TyrxHC2w83DWw1VK4SHUapghzWx0x/S9HkOo5a6xdkxTMWviPrOzJefPS/4Fxx9nDQkIFp8Jr/hICqBaR81eG7yRr+S8aGYQEWGl5TDLu1STGr+LwwwEkvxxnVtMk3ZpWU+6D6hUd8W+/X9m3gfNu4wj3rkEUMLxMcY5hrIeZW9tTULOB8qUh76m6box7gl8JYXdHMlrEZTa9u7BBAj6cBQyWREDi6GaHKAdi72LBcB2ciuVyTkoIiONv/GsDLJ7zIhtijO7WxcVIGjb9mv+qPzIEh+ywydL3MXNUNdxQ5c/RVuuD+KT0HJJoelovI84WS2OJuI+x19m+R0FwGlDjmCH4tDBqnXl18Hgwhjxjd4AmWbWR0UPULpz18suh9dgIMTWnf6/E8ObpmsXz0uo8NZRUP1qbJ1QDxz0rc/NIqFUYqkUYXM2FOveXqHcm/mH/f5J6dVwfXgdAIvLJyv6oYnSrigo6v9yO99HaRlfM/30gY/OiSwydERjYppC0DNbv0pmv0slSCuM/KHlLfRo+F7NnEJEgykTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38d7568-65ea-484e-a975-08dda9c9f908
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:58:28.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f26NzmMEe08/L7wf7cbKc/czKnpoLr92l5OwVKyoc3UzkoysqwZUKK5snNkA2z1INSztOiMZHocSi+xeueG1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120123
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=684af92b cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=HqPsqNtGgo7iutim:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=gwp8_JPBZ9R-eeyEtUIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6YkyWWJTUD4-SY4WpMlBM3VmUiUjeAvd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEyMyBTYWx0ZWRfX+3G5Revwl7uC sc7B+jWP/33pePuRtAI+U5UzwAFQMzXVLyrI8Z2XLsc/h8Jbw6Yo+5LYelGNeYlJkMiyk2n3zPC ah/qu2Llxkn09wP+3EK1kmD4H0MybYmXxWtsoBZlTlCBKwlLpUeXYor0xn3ivgS4pG/avUZR/3x
 Zjv0WVhXHKscXrrDR1QwERt9FueV3TRDxVc0wxgHGX+aEx5tLJPvxaLOJ0xx5jnxPwpaKORneIn UV2CLB2Jc/pBdhg1RqaBsJtC/4vt9cwpJkxw8TtZnU3f93hMnNNzBXj1L0xO03WC9Eg4IDdQHQx qX8uqvW02k5ChUh8pht49q2WA5dJFUYh2TTihdGVTImLMF5dVoeiB3md7p3uriXmDQMQ4fBsPQg
 CfRt91AlycyuTrp/yNuMMzVHDYpGzC8uKqhVt8bkO+AUc9aYYrlnN7LJfbuQ+S4Tq5LYrw6v
X-Proofpoint-GUID: 6YkyWWJTUD4-SY4WpMlBM3VmUiUjeAvd

On 6/12/25 11:56 AM, Mike Snitzer wrote:
> On Thu, Jun 12, 2025 at 10:17:22AM -0400, Benjamin Coddington wrote:
>>
>> What's already been mentioned elsewhere, but not yet here:
>>
>> The transmitter could always just tell the receiver where the data is, we'd
>> need an NFS v3.1 and an extension for v4.2?
>>
>> Pot Stirred,
>> Ben
> 
> Yeah, forgot to mention giving serious consideration to extending
> specs to make this happen easier.  Pros and cons to doing so.
> 
> Thanks for raising it.
> 
> Mike

NFS/RDMA does this already. Let's not re-invent the wheel.


-- 
Chuck Lever

