Return-Path: <linux-fsdevel+bounces-75647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHRNBPgheWnMvgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:37:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D259A624
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEEED3032647
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 20:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5F9350D7A;
	Tue, 27 Jan 2026 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Op2knb6y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wkpKTko4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3488230BE9;
	Tue, 27 Jan 2026 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769546220; cv=fail; b=itg0j4TSd/l56/wkumnTf3n5FQIHENLqId5oWnV3DG/R36yCoOp5j+B9OUZ3TcjiQW0CZITEbCrnDJsbUVGhj6NmxiAU8XrADA00ARLQi8udnA4ukbAPHbWThDleBiL3CGY3TGLjjFt0w6Pu7oa6A4jXIUSGKBUUIFFlg5M71MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769546220; c=relaxed/simple;
	bh=Ch0gs9hTCYDGrH0pQroSAow7Bcv83G+BmJnhkzgABr4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RszbV+VXbtsD3stKonARnm68Xzk0IQFLETLWhgadI7ecLLyh7de02XOeXUqf+WzUY8CqsHmtvhXq1P4SVevZCAzVaUi9Tzwnh6mA5Q0MVcGS5ej3n15OFzm9u/ItCMCFqgNcx+Eetcfe9dnwyn/WNKVkEOy4VchpbGEDhy1uQZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Op2knb6y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wkpKTko4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RJwI7u415081;
	Tue, 27 Jan 2026 20:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UDjUIT9b1FhEqUrnqmJvqik5S+FbhF8j6sJkX8Upo3o=; b=
	Op2knb6y8WdvYaFw8m7VH85hVOE/ZFZtBDTs4yZP4IQgIHP0lJURVj2n6eTSMBPQ
	BblDlJItQ1Lb/4JR/zXil0674LvoyVmXgUaXVZnUsfLT+5YdtsgZi26QMgqsTftv
	snRxogtbtxeMAcJP0TE9Ob9e8p2l+i8cjsF+Nh4ytdl6qUFPFcH++UyQLzk+OUO8
	AXH2HHdGsqAnovafsbFv6m6UPkbfGgWaSuDn9Ng+WTPACCQ+Ew/eg8gas6S/3ksc
	a2SIGuj318UkeFBVAAgbbAKHDpSl7uh006VZEBl57O5wuaGlDv0AWJHHRpA2Pc/n
	iWr7H9GukGWD40gg1060OA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvny6vtta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 20:36:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RJKDim019779;
	Tue, 27 Jan 2026 20:36:31 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhf8suh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 20:36:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBBLvmUneiccufhXGIWJSl11MU0A6r3MvQjDAi1d8bBoV6JK2hGflCIGCVfynC9PLnlyiNGrfE9FHdrhj4OJu0GKAylMR9pRGn4WnLg4mDRIJfyNAoe82OwS5gJumwk2PmyXR7T2yxmOueuimR5R9JJFSqaPXw1jIIO9wPoBn1skLHZkWD6+DGbNSB0MWDrie5zjVcTzoWnwb5Cle2mAQ5CvLFqfbjcoTmDa8UiQIAS5Dc9HM64ACLKV3H0FieznhLolLfr6GZ2CauKCh0QArEcskZUjDX6xj86e/VfEBdJRlKAIfHRzE/NO3TZldakIFSla2OpQaeSHhcCG9tWQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDjUIT9b1FhEqUrnqmJvqik5S+FbhF8j6sJkX8Upo3o=;
 b=jzH6KCtAtuaNYWeaNE2QFSLfbcFdAa0DtNfoaMBQuQ8Zamw0/LnG/KvWfhc8PB6PTXJuZgY5xkuRDqnQ5fcBWpxzFLOJ9yfTPfdm05/cnUira1d27qN1U8LDGsB1jX9U5nfVM57MAt9QkMbEmutbDMqArqs0oxP5fzT5nuJkZ8OAYl+U2zUbEeqjuTnewshax7/gPIPJc6hLm0KpXCirETryX1LW3z+lOCaf9IDIWp6TYOKYe04VF7KCMavA01f5MgtvWlei8p3+ASOTavosa0pCnWCc8fpUmtasD324z6/l+NfQrIKO6488BNGmK4yaRNnesIJeJdI1VE61IGRpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDjUIT9b1FhEqUrnqmJvqik5S+FbhF8j6sJkX8Upo3o=;
 b=wkpKTko4Tg0yKcqjWAH1z27TuD13fc/NVTOZHyU655YJtFh9T3IcULi2IC1owjgk4Bj8f5icKjbBLR7thm4/GRbXz9THKMmIwpZHCt4h5m0FjmXPpqedLijwaN878zexB1e9tZ/2s44NyqIISoC2o80TVaU26ileGq4zsiMD0Q0=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM4PR10MB6061.namprd10.prod.outlook.com (2603:10b6:8:b5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.16; Tue, 27 Jan 2026 20:36:25 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 20:36:25 +0000
Message-ID: <d8040fde-ccdd-443c-928a-9bff93641294@oracle.com>
Date: Tue, 27 Jan 2026 12:36:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] NFSD: Enforce Timeout on Layout Recall and
 Integrate Lease Manager Fencing
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260127005013.552805-1-dai.ngo@oracle.com>
 <88a3edc5-4928-4235-a555-a7017d5ca502@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <88a3edc5-4928-4235-a555-a7017d5ca502@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::14) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM4PR10MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: c01db6c9-d3b7-420a-370e-08de5de3bd9b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?T0hzM2QrRWFTbGRrWUxmUWhodWg1RUYzTXlFSUl5b1NkUjc3NG9SeEF6WjBl?=
 =?utf-8?B?TGw3WFlSRmpwRGNIMFlGbzYrR0lxVkVrWXZHcyt3VDRiVkN0cGN1OEhmMkgr?=
 =?utf-8?B?dUxySHVmM2tvRWZCYkhlaE42RCs4RHF0MHcwSzI1ZmlWMmtuVkJmL1psaE1k?=
 =?utf-8?B?K2x4c3NJenkxYm0wZXJ6Q0VnV0JPeWhqNDN3a1J5YWh2Zk54QVovVWFrSVJz?=
 =?utf-8?B?eWcrMVc2Tk1zTHRJelExanR1M2wrU2hNNk1STmhwbFF4aVBOMk1jMnZQdjg1?=
 =?utf-8?B?UEhiWmFrZm11SUFERWZMNXZFbzg3ZjNIRUtLOFowWDRWMmYvZU54amg3cjBj?=
 =?utf-8?B?cDQyVWFYMWNic25CRFFwWXN1UWdoaWdWNldEdTFRYzRxaFNibU5UdTNjakNK?=
 =?utf-8?B?UFMxQmVTZ0IySUFxL1ova2gvMytQUmFJUTg1Q2lscFFmSDN5WGZTSEszYkxZ?=
 =?utf-8?B?dzJQbHJmck1sL3RpNkltRDVlaUpBTnMyNjlzdy9BKzFtYStiMmQ1ZmE4a0Iy?=
 =?utf-8?B?ZjVhMHhneFBtelV6QjV5ZzY2N1Fwb3ExZUdYbG5tN3dieUx3d3czd20rRDJp?=
 =?utf-8?B?YkxJbjlrSnRRL1lLbE5UNFhmSklXVWt3SkM1QU0reDRBU0ZnUVEzcW5GQXpY?=
 =?utf-8?B?VzI5SVhPa2o5eUFQTDNucmdXbXdxWXZ5d1h4Uzhtb3grTkx5WTNpTkRXN3Jy?=
 =?utf-8?B?YUNvc2syS2wxaHdNd01PUFR3N2lFTEt1M01pK3F4bk92eWFka0I3SVJKR2Nu?=
 =?utf-8?B?Yll5emVrWXZqbnR1b2VITk5BaFpUZzB1YnY1d0NJelBCeURlUnd4WGNuVmla?=
 =?utf-8?B?VlIwTjg3SWk1Nm81bHlEMmovT1RCSXUyeTlDVGZhZVdkRWt3SjFBbVl0Z3JY?=
 =?utf-8?B?MGVqMkZOZTRKTEhFTG4vWXZSY2ZVdzlDTnRxSTl6TXVaNFBNanNvNUVmcXky?=
 =?utf-8?B?MUQrUFE2UHdNcWVJQnlLSFgwZlhoVjd5OVNPS1JLU2RQNE5HbzBSSjNrZGYz?=
 =?utf-8?B?N1dnbFhjNEZsRFRQd1NiK3FVRzlmazBqbWR5UXN1SlNtNmZJcHh5b3Y1bFdp?=
 =?utf-8?B?TmxpT1VLTzF2WjJUcUpKbElqTHRRSjRWdXBxalBFMjNMNGorUjdTekVrYjhl?=
 =?utf-8?B?TzQ2K2laaEVnYVBxejNCdWRkcXhoSitra0NZT1RES29FQkdUQVI1bjBlQ1BF?=
 =?utf-8?B?Rk1kd2lWaGx6dzQ4ZmxWTHJCc090Yi9oN3hxVWxNVHArQnhZS1R3Zyt5cFJJ?=
 =?utf-8?B?TzhtaFV6ZDhKeDlhTmNwNEtEM0JvYVMzUzZ1and2UmtvRFQ0SHlXeE1NWC9T?=
 =?utf-8?B?UEJzS09oNVFjQlFuTGo4V1ZXdUZTWU4wNGRyOUlqT1UwYk5VL0Z3M09mbkdY?=
 =?utf-8?B?SEt4K0ZPNVNJQUNOYUVHYWw5K25GNjArTlNQN3RnckNxdGxvT2dhdE5yTXlr?=
 =?utf-8?B?akxzVkhQaWRRTU9DaVR0VEhtREpGWEdTYW16b1kvUnV2b2xkZ2R0YXJaZmVP?=
 =?utf-8?B?VnQ3Mnpvay9GNWcxZTNPdktLcG5CWmF5eWkrWllzRTVEVjUrelJLSVhKZUVq?=
 =?utf-8?B?SWJRT2gwc29jdWJHeUtLZzQzT1lJdlJIakN1NHh6Q0pSUGk3aEpieTlKQkY2?=
 =?utf-8?B?R2E3cHRwMnUvNHZpSEhMaWlBVVhBQWdxV2JUdUhDSG5xR0luQ21oWUVVcFVq?=
 =?utf-8?B?VjRRK2Z0M0QwQWtuZkR1bXdwWXkzczNKQ1h6SUYwMkFYd3pyQjNqM056NGF0?=
 =?utf-8?B?eXh3dTBQRVA0KzJVL1pTeGNJTlhPalg3VjFBN1d2NVNMZ2NlcXM5R3ZKOWJV?=
 =?utf-8?B?YVJidHVlV2VrR2pObVovNk9hRU1ZSmhkN0liZmE0UE9ZQUxUQUhiVUlmRlMx?=
 =?utf-8?B?K1ViVGZKRG9ERTBNanBkanpIQ2R0VlhrdkNqRVp4M3JCWGxENXRxaVNYaTBo?=
 =?utf-8?B?UFE3Y3hmLzJvVm12Y0lZTm5JcmR5OUcvdVJLNnRhb3UzRVZCLzEvQlVVQStB?=
 =?utf-8?B?TDd1cEV5R0RSbWx2dExRdmhoUFUwazdyWTAyV0IxOS9kTkFlV3pjcTd5ZUw5?=
 =?utf-8?B?alc2c2w1dEE2SGtpU3VkUk5GQ2FXL1RuSEdQenhmenZ6anIzT1NnN2lvdTN3?=
 =?utf-8?B?dmVXUUxobXcxbHhydU45b1dpbUx4YWhxV0RteUk5OW8yQ21TeG5GcjRQRDVC?=
 =?utf-8?B?SkE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eWExYmdsZjdnNGFCcnlMdEFWWnpVMkJ5a1d2eWNkV3VEbWQ5UFFwenJJYklz?=
 =?utf-8?B?bGdNRmk3cjJDUjlTUEk0MjRiSlNMZkJra21FdUJxZGtEd3VLQjJWeFpUc3Ji?=
 =?utf-8?B?TWlFbnZsOGwrSXpmaTUzNEd2NjR0RmY4VmRpajUzK3BITENza08rNDBncDBR?=
 =?utf-8?B?cDI1QW9HNEk4OUtKdTMxUUY5SGluekw3TDhReXJhM2tjaHdTcS9GbElWL0pJ?=
 =?utf-8?B?TVp4QTFCM3VKdTd4N3pCYmhVSTMzKzFidVlnbC9ueHEvMmwzNzV1V2p6NURO?=
 =?utf-8?B?b0ZBaXpTZlBtWGlWMjliMGo5Z2wwSENNRU5mZ3pVeW5hVFJtUzJsYjBCYy9E?=
 =?utf-8?B?MzRYM0tRMkpOcjZXNFhpMWFnWDNLTlc4TTVKVm9KMG1PNGhFNVhlQW0zMjBM?=
 =?utf-8?B?NU96WHlrWUxxTmhvZzVHMDZraXdaam95QllFckwvc3FKUG9PQ2wvZ0JIeWJI?=
 =?utf-8?B?NW9FN3llTjE2dXgxWmpvZTY0MEpKc0pnT015eDcrZ1NUZWxSYnVwZG84dDY3?=
 =?utf-8?B?bjhwbCtOVnpYaVpodTRtbU9QVlhHZXVuN0s0WnRMRUpHOWVvdE1URk90VEw3?=
 =?utf-8?B?VTd1WDFmSUYvZTJaZk5RWXJYRktIUnN2eTdJRzdlNjdOZnY5c3AxQnhTYi9V?=
 =?utf-8?B?d05meE9KS3pBUzh5TFlJdnNXNDNyMlhQT3VabjI2ZFVXNWduSUY3dVg2ajV5?=
 =?utf-8?B?Z3NmVVczR3c4eFRKd09QZHRBRGlpWTZ0b2lxejNBaUgrMHpGd3NhQURUSFhy?=
 =?utf-8?B?c2I2WVhkM1FpUVhmbkprMnpJbHFmTDN4S0dMVHZJNFVXcjR6TEhzcXFPVGNG?=
 =?utf-8?B?UW1OQStmV1dvOVl6WVZYV0kraVYvejcxY3JEbzBIczRSVmZ1WGhNU2dDdGds?=
 =?utf-8?B?NFIzMTFSK3p6dVRGL2p3bkZCa3FRdlIyOHlwaEdmaHZ2TjEwV1h0RDVVVXl0?=
 =?utf-8?B?OStLYUlHM2xoKzZJVXF3U3dwOGs5eEFYcFIzcjhTYnlETEFJOWphZjkwRVhr?=
 =?utf-8?B?ZjlVVkhtQ25JZ1pBcHRKU3cyMm9TOUc1cE1ZN2dNR0Z3QXRIS0xaN3Q4b3Jj?=
 =?utf-8?B?VzNlVjRWZDJEa1JTQmcwZkswOEZlZEFrN3dnS1ZyMDNyTnBVSGtwWERWRGtr?=
 =?utf-8?B?LzdyU2svRnYyU0dMRlJsYXZzZWpHa1h0Q2crbUdFY0YyRURZZisvTkxsZGZF?=
 =?utf-8?B?UytkTGVvSkp3L3k2NXZYK0k2cytqN2F1VHpob0Rqck9NS1NEVDZyR1lTWnhW?=
 =?utf-8?B?bnlhcDNPVmt6ekhuZ2ZWVkpLbFZtVURkbGlEL3JiL1VDMFlKamtycStvZkE0?=
 =?utf-8?B?TmJoMWt6dXd4MlI1M0o0VDNkalBWUUxuOFVzNTM0NlpOMmN3VDVpUHJOejAy?=
 =?utf-8?B?Zk9qaVg2NHlPalJaMWZmWFdVdW94Y3U2aXhkMEFqZnpjNDhsV2RQUmZRcHZF?=
 =?utf-8?B?c2NPOGttdVlYL05PUWtKa1JONVJmUjRxb2h6U293eVdtY25taGJXRWVjbkpt?=
 =?utf-8?B?QnBDbkRJYTFVWUg5Z2hoMGw2UkhWdFJGTnBaZU5kbjJvTlpScVV1bnJTeUYv?=
 =?utf-8?B?U0ZOLzRnMVgxb2QwaTladFJyQmtkL2wzOVZCRTBDRkFUTlR6Mm10ZmpVSXU4?=
 =?utf-8?B?Tm5UenhsU25Bb0NkLzAzRjBuS0IvMWF1OEFVbDIvYWZaWXpBQXpqb1VPY1Jy?=
 =?utf-8?B?OUNSQVAwclNucUNDdCtNZjE1T3VFQ0d3VlpvSk9qdTZLQ0NuUmNyNC8raUdX?=
 =?utf-8?B?Tm1YNU83aE5OWi9KQ25xSVREaDR5d05QWnNHVzJGN3MzNWNQbG1kcTkxSC9j?=
 =?utf-8?B?NHJmeTUxUWpHcnFMVkxuUnM5alNaSkw4d0ZhMUhKYjN6V1JzRDhueURCbnpG?=
 =?utf-8?B?bUgvbkpXR3hDZkhQc1hxWld2MDVjQ1ZiQktpTi96YmlQSW1YSEJPbElsVzZN?=
 =?utf-8?B?NFF4TkQycHZaMmlwVDRxUE5BVXVodGFHSFduamIrZDJnY05wMFYwaTBzMysy?=
 =?utf-8?B?OWpLbzdWMzRUOFhIQVJUZlEyVFFvZksxT2FFZjF6bFY4SlhFUFp1aDFmUmt5?=
 =?utf-8?B?Ris0czkrTG9BSUNjdloxUVBLVCs5Y0cxd1dQeEg0UDhMdU01b0x3QTdjMUR4?=
 =?utf-8?B?NjFqM0hPQ1JYeG56Wm16WnNQMk5jZ2h5Tlp0a2RzbjJSeXlaelNmQzJNVXAz?=
 =?utf-8?B?MnljdU1OS1Zsb2VCdTZZcG9yMm9FaHFPKzlrUnYwVU55c1BSTEtQT0NWVGox?=
 =?utf-8?B?NndRSldYRTVRcEVXWTFZNlBoTlBKczhxNHFySGYrUDlsdnRrdWk0RktLWG92?=
 =?utf-8?B?NW16dVp2MDY4TDNGZkRxQWhSblEyNmNrUGFjMGdmRUM4U3I2Z0FoZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q+nZHTDfa6Qvpx3KGG97yJvwXk20eZSqzZFuFHh4LLbPTAz012MEnHRhRqgkWEmZqi2iyq76sjaC9tD6DZDIhwV+gcgqFKponYaReuy5b+SzA5FAnDuacN1/Uis6zGXwkR7gpy+37LWuRgewb1bFqizxst5uaspqSaLSQut2GwKWNdGRqCGYhqo/Upq/4zeUZeOxRV7PKCHQrvYKzn3qHSW3VoxccO+v5ytWSHMfzZlS2D3KxbD2+5o2nom0C/LRUq4w35fD98HEM0A2a9ombCxi+pSYhjgWYWS0K2o1AtnyRsyFDZ7hIdMGVZm1DtVeNQHrN1Q31WHKu9UpfoG7v6x4DETuZvVYvQ1NIEXkyfndj8T6BforhZPjDBR6Rwe1uZL4/2zox0WuXHvY0Y7g9kqz5XdKW4QwEoS6r8F1rSexhw0eLKXLW7l8PmVR7P1p3sjQgg9l/DsFFkKH9K/CTtjb1Ro0NWu6Emjsa0GUPQxZZoa5jNsB3H7d6zh7z7VatLUAlNlZBHbTS59hbYVGjOs3ZqFXOtI9cM20E1XwBKllWEfrXa507Q1aZ9hdgWlUHenYdtlwnvzzk81TIUUxbsVwTDOZmJ+8TSI1QJzjlpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01db6c9-d3b7-420a-370e-08de5de3bd9b
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 20:36:25.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZOBbvfsf/lrpildAjVNKnjQydlgAd/5twykRiCtt1o6NEZhZiXkE7mKv6Y7vAdorTO9A/KLGxdov2NV4O1L2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE2OCBTYWx0ZWRfXyhSi1LzCKkRM
 5lYqU+IqCSdDTIosBfkjxdv3OcqKS0UZhh23yrSYCKsl2bVmqQxGvzP7LWs5Egu95fCWgRHdv/t
 BJYRP7JE3/dTexoGLrTJMBQzRtKTucWiLmYQdCtX2a5F0fr6G3F8RoOElb2qC4yIXDuwnBiagEH
 lIy0/txHYne180W4MP9diUiUUf4ZlESF3NmIUDKM95LGtikIwpBLFgil52hXJhehu5WJxclKQz9
 TyHs8Il1QKgq+mOKjWBL/OIPUwhdwq8/WZTiKXWPBs4jL24r0ccTZMxiPajDkyB63iKn1NCgWMw
 nS5FYVzZ+4vKulKAl2wEkGQByf4q3GEj/wTch9ovLCtokF/5hl+tx5GaZ3fQfus4QrIQVavzAr7
 9c4gu7VhS22xs4LzUimy/YXjaYH3Wfyu0+u+Olwol8+TVzwiztzE2iCCwAfvtBeYUYGlxh3Ad7v
 KxViKTHEbVjGagpfL3J2IvNEUKSlzULotfV6YBDw=
X-Authority-Analysis: v=2.4 cv=C+XkCAP+ c=1 sm=1 tr=0 ts=697921d0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=sR-xgAtX51SPT2W1DEQA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12103
X-Proofpoint-GUID: 0TPKb2WKw4qbKk0nGvZMgN89MWQAKNZM
X-Proofpoint-ORIG-GUID: 0TPKb2WKw4qbKk0nGvZMgN89MWQAKNZM
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75647-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 55D259A624
X-Rspamd-Action: no action


On 1/27/26 9:11 AM, Chuck Lever wrote:
>
> On Mon, Jan 26, 2026, at 7:50 PM, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout is
>> necessary to prevent excessive nfsd threads from being blocked in
>> __break_lease ensuring the server continues servicing incoming
>> requests efficiently.
>>
>> This patch introduces a new function to lease_manager_operations:
>>
>> lm_breaker_timedout: Invoked when a lease recall times out and is
>> about to be disposed of. This function enables the lease manager
>> to inform the caller whether the file_lease should remain on the
>> flc_list or be disposed of.
>>
>> For the NFSD lease manager, this function now handles layout recall
>> timeouts. If the layout type supports fencing and the client has not
>> been fenced, a fence operation is triggered to prevent the client
>> from accessing the block device.
>>
>> While the fencing operation is in progress, the conflicting file_lease
>> remains on the flc_list until fencing is complete. This guarantees
>> that no other clients can access the file, and the client with
>> exclusive access is properly blocked before disposal.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |  2 +
>>   fs/locks.c                            | 10 +++-
>>   fs/nfsd/blocklayout.c                 | 38 ++++++-------
>>   fs/nfsd/nfs4layouts.c                 | 79 +++++++++++++++++++++++++--
>>   fs/nfsd/nfs4state.c                   |  1 +
>>   fs/nfsd/state.h                       |  6 ++
>>   include/linux/filelock.h              |  1 +
>>   7 files changed, 110 insertions(+), 27 deletions(-)
>>
>> v2:
>>      . Update Subject line to include fencing operation.
>>      . Allow conflicting lease to remain on flc_list until fencing
>>        is complete.
>>      . Use system worker to perform fencing operation asynchronously.
>>      . Use nfs4_stid.sc_count to ensure layout stateid remains
>>        valid before starting the fencing operation, nfs4_stid.sc_count
>>        is released after fencing operation is complete.
>>      . Rework nfsd4_scsi_fence_client to:
>>           . wait until fencing to complete before exiting.
>>           . wait until fencing in progress to complete before
>>             checking the NFSD_MDS_PR_FENCED flag.
>>      . Remove lm_need_to_retry from lease_manager_operations.
>> v3:
>>      . correct locking requirement in locking.rst.
>>      . add max retry count to fencing operation.
>>      . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>>      . remove special-casing of FL_LAYOUT in lease_modify.
>>      . remove lease_want_dispose.
>>      . move lm_breaker_timedout call to time_out_leases.
>> v4:
>>      . only increment ls_fence_retry_cnt after successfully
>>        schedule new work in nfsd4_layout_lm_breaker_timedout.
>>
>> diff --git a/Documentation/filesystems/locking.rst
>> b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..a339491f02e4 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,7 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>
>>   locking rules:
>>
>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     yes             no                      no
>>   ======================	=============	=================	=========
>>
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..1b63aa704598 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode,
>> struct list_head *dispose)
>>   {
>>   	struct file_lock_context *ctx = inode->i_flctx;
>>   	struct file_lease *fl, *tmp;
>> +	bool remove = true;
>>
>>   	lockdep_assert_held(&ctx->flc_lock);
>>
>> @@ -1531,8 +1532,13 @@ static void time_out_leases(struct inode *inode,
>> struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> -			lease_modify(fl, F_UNLCK, dispose);
>> +
>> +		if (past_time(fl->fl_break_time)) {
>> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
>> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);
>> +			if (remove)
>> +				lease_modify(fl, F_UNLCK, dispose);
>> +		}
>>   	}
>>   }
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 7ba9e2dd0875..69d3889df302 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -443,6 +443,14 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
>> struct svc_rqst *rqstp,
>>   	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>   }
>>
>> +/*
>> + * Perform the fence operation to prevent the client from accessing the
>> + * block device. If a fence operation is already in progress, wait for
>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>> + * update the layout stateid by setting the ls_fenced flag to indicate
>> + * that the client has been fenced.
>> + */
>>   static void
>>   nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct
>> nfsd_file *file)
>>   {
>> @@ -450,31 +458,23 @@ nfsd4_scsi_fence_client(struct
>> nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>>
>> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>> +	mutex_lock(&clp->cl_fence_mutex);
>> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>> +		ls->ls_fenced = true;
>> +		mutex_unlock(&clp->cl_fence_mutex);
>> +		nfs4_put_stid(&ls->ls_stid);
>>   		return;
>> +	}
>>
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>>   			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
>> -	/*
>> -	 * Reset to allow retry only when the command could not have
>> -	 * reached the device. Negative status means a local error
>> -	 * (e.g., -ENOMEM) prevented the command from being sent.
>> -	 * PR_STS_PATH_FAILED, PR_STS_PATH_FAST_FAILED, and
>> -	 * PR_STS_RETRY_PATH_FAILURE indicate transport path failures
>> -	 * before device delivery.
>> -	 *
>> -	 * For all other errors, the command may have reached the device
>> -	 * and the preempt may have succeeded. Avoid resetting, since
>> -	 * retrying a successful preempt returns PR_STS_IOERR or
>> -	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>> -	 * retry loop.
>> -	 */
>> -	if (status < 0 ||
>> -	    status == PR_STS_PATH_FAILED ||
>> -	    status == PR_STS_PATH_FAST_FAILED ||
>> -	    status == PR_STS_RETRY_PATH_FAILURE)
>> +	if (status)
>>   		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>> +	else
>> +		ls->ls_fenced = true;
> The removed code distinguishes retryable errors (such as path failures)
> from permanent errors (PR_STS_IOERR, PR_STS_RESERVATION_CONFLICT), but
> the new code clears the fence on any error,

In v2 and v3 patch, I left the comment and the code distinguishes retryable
errors intact. And you commented this:

> In nfsd4_scsi_fence_client(), when a device error occurs (e.g.,
> PR_STS_IOERR), ls->ls_fenced is set even though the client may
> still have storage access.

So I'm not sure how to treat permanent errors now. Please advise.

>   potentially causing infinite
> retry loops as warned in the removed comment.

Infinite loops can not happen due to the maximum retry count.

>
> Either the comment and error distinction should remain,

As mentioned above, I can put the comment and code that distinguishes
temporarily error codes back. Then what do we need to do for other
permanent errors; PR_STS_IOERR, PR_STS_RESERVATION_CONFLICTT?

>   or some rationale
> for removing the distinction between temporary and permanent errors should
> be added to the commit message.
>
>
>> +	mutex_unlock(&clp->cl_fence_mutex);
>> +	nfs4_put_stid(&ls->ls_stid);
>>
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>   }
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..1c498f3cd059 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -222,6 +222,29 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
>>   	return 0;
>>   }
>>
>> +static void
>> +nfsd4_layout_fence_worker(struct work_struct *work)
>> +{
>> +	struct nfsd_file *nf;
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct nfs4_layout_stateid *ls = container_of(dwork,
>> +			struct nfs4_layout_stateid, ls_fence_work);
>> +	u32 type;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf) {
>> +		nfs4_put_stid(&ls->ls_stid);
>> +		return;
>> +	}
>> +
>> +	type = ls->ls_layout_type;
>> +	if (nfsd4_layout_ops[type]->fence_client)
>> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
>> +	nfsd_file_put(nf);
>> +}
>> +
>>   static struct nfs4_layout_stateid *
>>   nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>   		struct nfs4_stid *parent, u32 layout_type)
>> @@ -271,6 +294,10 @@ nfsd4_alloc_layout_stateid(struct
>> nfsd4_compound_state *cstate,
>>   	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>   	spin_unlock(&fp->fi_lock);
>>
>> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
>> +	ls->ls_fenced = false;
>> +	ls->ls_fence_retry_cnt = 0;
>> +
>>   	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>   	return ls;
>>   }
>> @@ -708,9 +735,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb,
>> struct rpc_task *task)
>>   		rcu_read_unlock();
>>   		if (fl) {
>>   			ops = nfsd4_layout_ops[ls->ls_layout_type];
>> -			if (ops->fence_client)
>> +			if (ops->fence_client) {
>> +				refcount_inc(&ls->ls_stid.sc_count);
>>   				ops->fence_client(ls, fl);
>> -			else
>> +			} else
>>   				nfsd4_cb_layout_fail(ls, fl);
>>   			nfsd_file_put(fl);
>>   		}
>> @@ -747,11 +775,9 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent NFSD
>> +	 * thread from hanging in __break_lease.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -782,10 +808,51 @@ nfsd4_layout_lm_open_conflict(struct file *filp,
>> int arg)
>>   	return 0;
>>   }
>>
>> +/**
>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
> Nit: Move the description of @fl here.

Fix in v5.

>
>> + * If the layout type supports a fence operation, schedule a worker to
>> + * fence the client from accessing the block device.
>> + *
>> + * @fl: file to check
>> + *
>> + * Return true if the file lease should be disposed of by the caller;
>> + * otherwise, return false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +	bool ret;
>> +
>> +	if (!nfsd4_layout_ops[ls->ls_layout_type]->fence_client)
>> +		return true;
>> +	if (ls->ls_fenced || ls->ls_fence_retry_cnt >= LO_MAX_FENCE_RETRY)
>> +		return true;
> Since these two variables are accessed while the fence mutex
> is held in other places, they need similar protection here
> to prevent races. You explained that the mutex cannot be
> taken here, so some other form of serialization will be
> needed to protect these fields.

I do not think we need protection here to access ls_fenced and
ls_fence_retry_cnt. For ls_fenced, it's a read operation from
nfsd4_layout_lm_breaker_timedout. The value is either true or
false, it does not matter. If it's true then the device was
fenced. If it's not true then nfsd4_layout_lm_breaker_timedout
will be called again from time_out_leases on next check.

ls_fence_retry_cnt is incremented and checked only by
nfsd4_layout_lm_breaker_timedout.

>
> If I'm reading this correctly, when the fence fails after all
> 5 retries, the client retains block device access but server
> believes recall succeeded ?

What should we do if the maximum retries is reached, perhaps a
warning message in the system log for the admin to take action?

>
>
>> +
>> +	if (work_busy(&ls->ls_fence_work.work))
>> +		return false;
>> +	/* Schedule work to do the fence operation */
>> +	ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> +	if (!ret) {
>> +		/*
>> +		 * If there is no pending work, mod_delayed_work queues
>> +		 * new task. While fencing is in progress, a reference
>> +		 * count is added to the layout stateid to ensure its
>> +		 * validity. This reference count is released once fencing
>> +		 * has been completed.
>> +		 */
>> +		refcount_inc(&ls->ls_stid.sc_count);
>> +		++ls->ls_fence_retry_cnt;
>> +		return true;
>> +	}
> Incrementing after the mod_delayed_work() call is racy. Instead:
>
> refcount_inc(&ls->ls_stid.sc_count);
> ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
> if (ret) {
>      refcount_dec(&ls->ls_stid.sc_count);
>      ....
> }

Yes, it's racy, I thought about this. But we can not just do a
refcount_dec here, we need to do nfs4_put_stid. But we can not
do nfs4_put_stid here since nfsd4_layout_lm_breaker_timedout runs
under the spin_lock flc_lock and nfs4_put_stid might causes the
flc_lock to be acquired again from generic_delete_lease if this
is the last reference count on stid.

We might need to add the reference count when the file_lease is
inserted on the flc_list and decrement when it's removed from the
flc_list. I need to think about this more.

>
>
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>   };
>>
>>   int
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 583c13b5aaf3..a57fa3318362 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2385,6 +2385,7 @@ static struct nfs4_client *alloc_client(struct
>> xdr_netobj name,
>>   #endif
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	xa_init(&clp->cl_dev_fences);
>> +	mutex_init(&clp->cl_fence_mutex);
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 713f55ef6554..57e54dfb406c 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -529,6 +529,7 @@ struct nfs4_client {
>>   	time64_t		cl_ra_time;
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	struct xarray		cl_dev_fences;
>> +	struct mutex		cl_fence_mutex;
>>   #endif
>>   };
>>
>> @@ -738,8 +739,13 @@ struct nfs4_layout_stateid {
>>   	stateid_t			ls_recall_sid;
>>   	bool				ls_recalled;
>>   	struct mutex			ls_mutex;
>> +	struct delayed_work		ls_fence_work;
> Still missing cancel_delayed_work_sync() when freeing the
> layout stateid.

I don't think the layout stateid can be freed while a fence
worker was scheduled due to the added reference count to the
stid.

>
>
>> +	bool				ls_fenced;
>> +	int				ls_fence_retry_cnt;
>>   };
>>
>> +#define	LO_MAX_FENCE_RETRY		5
> The value of 5 needs some justification here in a comment.
> Actually, 5 might be too low, but I can't really tell.

At the minimal each retry happens after 1 sec, and it can be
more depending what entry is at the front of flc_list. So if
retry for 5 seconds (minimum) is too low then is 20 retries is
sufficient?

-Dai

>
>
>> +
>>   static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
>>   {
>>   	return container_of(s, struct nfs4_layout_stateid, ls_stid);
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..13b9c9f04589 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -50,6 +50,7 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>>   };
>>
>>   struct lock_manager {
>> -- 
>> 2.47.3

