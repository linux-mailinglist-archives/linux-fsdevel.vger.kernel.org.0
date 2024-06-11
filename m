Return-Path: <linux-fsdevel+bounces-21447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC62903FEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 17:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB601F2439D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0220C2868D;
	Tue, 11 Jun 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IVI0y9A2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WkhxmF7M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB28219E7;
	Tue, 11 Jun 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119438; cv=fail; b=Zf52A0/snIiZJA0mXzZYl5j2K7NOuV5GKrKe8T3m3bvJs/bd9QMqFMUrW7zXd6FanamSBbWqoJwJYY3CKQhxX0icCb+tGg4DiY2uPfHh74qjfDINjWDJdZdMGx1HsuX/AVz3PQ6OYf+/RG0pV9BvMLOoIuQtlMJ5NiKVFUFupRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119438; c=relaxed/simple;
	bh=CMfIlGmtSVOX6dPBfy6RQQ0HFAVLQijBCzK8RxD5Tk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aHykiEZJ2rsgcZctffvjanuYj+DzIf40HwuL/SkdOVhNmwwSKh1hzxiyAglWzTm4TOnTXcRFm4U282EHRbb7Mq6kVb1Z4DxqG3Zf5OAm5pYc1auct6GcYsEcDKYOCqk7B4B2BIVpafv6b0XHrrpFOgmhj2kJxAzHlq4LarZO3BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IVI0y9A2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WkhxmF7M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7fTTK012066;
	Tue, 11 Jun 2024 15:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=FPlEiE9NdFIsIO5XSbm0caimsxNItip/aapF9JPJCmQ=; b=
	IVI0y9A2fb7o2G/voXPWWsehJycCdqGa8/R91k1PutfoaSh+db5UyYMQN/+sb1lI
	0xry5KXR7iGVOOhRHYdM8Rl6HMr+/ReLhMS82aVsVIu+kDsTDQqzBKkHGlfnaVy3
	1MLjL+BYVtWyG0lnHHCucGowSrSShPgdVi4vR9Xd+75H+lU2BezOORk2U00lBRmb
	SeHDY2beW1xlR0V9eK9HH440go3l5Jr0bcyDmoMALpMW485CJTqJRlW6nRdcmV/a
	v61dUw4LqO7mwCtydN+0PDHCnIhdYFYRL+D633EPCuyemBgZS8kHnv7ICwLDkYKS
	R+37rdzh5HnqwshOMPx9Vg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj541r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 15:23:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BE8ttT019928;
	Tue, 11 Jun 2024 15:23:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync8xc33k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 15:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/g0TCFIgzOsFBKxiOenopNFx8UMNSZ74T51GAWjUHq9qKyXLFl+ddbyq6Fei1tJadXPCj2HMNuW6u8Tu/NES3N+ZmmkS4getr36l1ZB7pkyb8r9RwDjhrRIvYh85UFPmX20fU+Pc2H+IxKFTXYw6k8gTqu7EbXeOfgkCAx2+q9tBcH21CKyDNSKYPo45s1wxPLrcoZPxdj2N50KvJQwVBMsiO+70RCvhzjs41GnDnOoG1BatvCApGvFCfe4ltLzGtZJe5VqjDJxDqyb0teoSvg0pVxHlxZs0Sb35kmfk97QIw97AFpEDWpbxbBYazdJl4m0kKsmZgUL5IyYoQzr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPlEiE9NdFIsIO5XSbm0caimsxNItip/aapF9JPJCmQ=;
 b=OxNxCPGVMI0K3sgYNm7XVMKhhrX9489mTyvXHbtUvaJofwYaupPJgmwi3k0TvveexyFGk/hDr+rI7p9iNnR+c3GyAYnXIW8Q07buRbKVpU8WKNtjKBYwfJGNGeFtDnoo0SaVcILSEubUcZBUcczrhAG0Lmj6AaY6LGsKRNYihZX+FMV7Zdkoo3qQx/MliuM/wfHdlME+6gnBJ1UNUDXnA6MbG11HUpkm2BxgUr4Q4UGntQGZifkbOwM6fVfZ5eWMsAaCQkKx7DYZfVi8gRlVar9jWO6yDIVOmIIncAYoRq1oaxD5/h9eFRRlKElBgGYSFTpFSsYaTVq7xLxPWbTefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPlEiE9NdFIsIO5XSbm0caimsxNItip/aapF9JPJCmQ=;
 b=WkhxmF7MyRl32QfXyyEIYj+H5FZ4Jakv5noNX0/hfHHLikCVPTd8pNf5cZoX2dr+PdjN134h3EBD3HjAACV2mIvAAsx9hkc8as1tG8CmpiR/Cl7UIldGaa3pYYGQrReUFLpbrO/8BCCdlKfG4+gFOE/y/D9Ddmlt8NdZbywn8Mo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB5970.namprd10.prod.outlook.com (2603:10b6:208:3ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.39; Tue, 11 Jun
 2024 15:23:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 15:23:35 +0000
Message-ID: <fc768320-f4a2-43d9-a7de-4441b60ced28@oracle.com>
Date: Tue, 11 Jun 2024 16:23:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
To: Theodore Ts'o <tytso@mit.edu>
Cc: Luis Chamberlain <mcgrof@kernel.org>, David Bueso <dave@stgolabs.net>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        catherine.hoang@oracle.com
References: <20240228061257.GA106651@mit.edu>
 <9e230104-4fb8-44f1-ae5a-a940f69b8d45@oracle.com>
 <Zk5qKUJUOjGXEWus@bombadil.infradead.org>
 <bf638db9-c4d3-44bd-a92c-d36e3d95adb6@oracle.com>
 <20240601093325.GC247052@mit.edu>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240601093325.GC247052@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d651431-1625-442b-4d30-08dc8a2a75f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OFlkdUZsMlFCQ2dYU05XMS9DdEZnS3k1UXNlOE1OOEFGUnM2L1Z1MjVHa05z?=
 =?utf-8?B?emV1bFNxaGNNUnUra2h5RFlmcFMyeU1XajdEd1pVb3NLVTRyYWxpbEtXdXNz?=
 =?utf-8?B?ZjZqRGo0SThkbTBmYnJjMm5XZDR5SVMvblIxWGZGWkwwQTliN2Ywa3RTMTdH?=
 =?utf-8?B?VUdUODBmMml1dUdUcDMvYm1mNnlraUFiSnVITXBIS20vYkVOeEpINVhEdERP?=
 =?utf-8?B?aXR3b1ZzOVhKTHlJZWhHV3I3ZHJuZzVBRkIxNkFVc1BhY3NBRWNmY211SzIz?=
 =?utf-8?B?ckEwQko1Wm1QQ2ZpRjZzR1ljcVNPV0pkeHNvY1hpa2sxTEtncU9ZTWZZcG4z?=
 =?utf-8?B?YUVDUm1aVjJzN1BXSmpnaXZwVVFRNzlvVGNXaXB2akVvNnVKd2ROMFBCcWd6?=
 =?utf-8?B?YmRPMTg0WmpySUJnZU5iVVRrRUFPWkxzOCtKQkxncjlSMUpkTUEyTU5Ga1dR?=
 =?utf-8?B?NXkyU3p3emZCMFp1b2lyL3p3eE5zZ2ZTaVZaZVdzeTZTSUlza3ViaURJc2dI?=
 =?utf-8?B?ZmlXeUYrekQ2U0RyNGp2TXE2VHduS0tsWVkzMlRBbG1ITU1EdVNKOHlibFd5?=
 =?utf-8?B?SUlKTE52OHB4bnh6ZU54SHZXaGp4K1J1eTFMTXBnSExKWWRsUElOWmFNeEZM?=
 =?utf-8?B?R1pDMEhrWHlPaWQrS2tPTVJ3SlQ3SGtoV1dvazVXNzdLMWRCYjduTDBuNi9S?=
 =?utf-8?B?L2JhL21TSmNLaVI0SjRZdDRFa2NjcmZvaDZqZUJkdkZ5a3JyOURMYmZlNTI4?=
 =?utf-8?B?Ym9maUdGZUt1MFBHVFMzNFFXSEJWdDBGd1lsa1owU0NYQlZOZElkZUc4bFg5?=
 =?utf-8?B?OHhibzlybEhVekZqZGFpdldxc1p6ZkZLU2FsUk5oMjQ0Q0tkSTZOOFd1b3ky?=
 =?utf-8?B?ZDFDQUEvditMQ3dSdENWcVFNNkRSb1RaSkdjMm1CS3g1RkJLbldvZXZ1b1F5?=
 =?utf-8?B?ZWF4UGJJV1MyOGc4dVVTODhWWVhreWtwTk9kN2xKV3M3Uk5RN21waGI5NExS?=
 =?utf-8?B?L1MvTUtBMTNLSm5qTXorMkZxRnZvUVBYVkpoWE15SW56Y2hHMFBQRmN2YjBR?=
 =?utf-8?B?NGY1UWR0YXUwYVBvTmdyR0svcXc2WmxhR2w2WGRoSkwrVEtZOEJlWHZZd2dx?=
 =?utf-8?B?amFqT2xwYWZsMFBkUlhnTnhTS2dlanBUcGJrSThESTBtdjRNVzE1RTNsbVRn?=
 =?utf-8?B?V05UTVloRERBcnpZdEwrMldORXM2dUtET2xxRTZ3QmFQWkN0QzEyRlkyYWhk?=
 =?utf-8?B?bVp3YlJjVUxERTBVVzZaakUyekdDa0ducDY2c0kvdnNka3Y3T2x1bkZTVDJN?=
 =?utf-8?B?aFlrbWRJc1c5YVBwVCtuTzl5djdXZGl4ZHo3aEdYcGRkOXNNNGJJR204cmEv?=
 =?utf-8?B?N2VBei9iQ29qK1BZMUJSYVFxWmRwNURDVWdkR1llRUhvWFI5R2FROEJpUCtG?=
 =?utf-8?B?WVlIbDBrWDVFN21vd3JyQVBVMTN6cWRpR2pFaTVoY1lVWlVhWlpVL09wODZI?=
 =?utf-8?B?SUcrNFNoZEU4YkVZRzdzZ2hmUHhhTUFIRVFJZkx5SDdkY1VqR1Z0cE1rUnZY?=
 =?utf-8?B?dStnMUR6eldMeVZXQTRLRTF1YmthYWwxbFlXSGJxajlSbWhPYStQN203S3Ru?=
 =?utf-8?B?THpjWlVBWldZbkVOc2ZFT1RQcTlHeW4rSXhqTjFiL1o4ZUJMNUl0M1JUV3BV?=
 =?utf-8?B?dStaU1BQL3VmdHVKcFBCUk8vcWxyblVxdnJPdHA3UHFOc1kyUzc1RFJIeDRF?=
 =?utf-8?Q?TdWaNl6qQni5OEgsy+tXzqo/ypmxVs15eB01Beo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZmJHTE0zK3BpaXRWcTg0anJDMy8xUmZMNllxRExIWU5PY3NvK2FTREIvbndF?=
 =?utf-8?B?Y3pNWHlVUW1KMElydTFMOFVLV3ZzM25zeWl0UnRkZlBYUS91S01MRVhpZ3ZL?=
 =?utf-8?B?eEpPZzJIZmwwNURBdU5uV3Z2VEFwcS9iNW9lT01Ld01PQXUyQ3ptbTJWZEt5?=
 =?utf-8?B?ZERPVGVzNFJOUXhlVllOSnJWSVNtdVdiNUdqVVQyd0RpK1FwVWVaTGdIbXZ0?=
 =?utf-8?B?Qk9JWE9TanZyaEFmRGl6a0JsTHVDN1FwREM4d0JkZkxsK0xJN254L2t5bWF3?=
 =?utf-8?B?MWQ2LzYxandwbmxLc3Jmelh2Wjk2ZVo1OWMzTFpUOUh6SGJyVVlFbS9JMEdO?=
 =?utf-8?B?a2tJVkJ0S2Z1NGJhRnQxeDZKMkZaNGpPSjlKS2dkS3pMKzhQTklnYzdIQjdU?=
 =?utf-8?B?VCtTb2hrbzRkaDNmdFJPY2dpSit2b2U3Q2ZqN0JSdlVGUythMDNoTUxuaVR3?=
 =?utf-8?B?T1cxbVcyRW1jVVd6UkszUE9MTEY1aFg5ZUFCMmFiYWNhQ0RmUmFjWHErT1lM?=
 =?utf-8?B?cmNHVjNrdXVDdEcvZTNWMVdKSEhjWEYzRzVqV2xRSnNmcUNzMS9KQitVQ2Vn?=
 =?utf-8?B?M0lMWnBuY3R0ZUlpamZlTkFFaG1FMVFqOWhEaVV5b0FnKzBzZWFGb0FuaWdp?=
 =?utf-8?B?MGlmcFBZclQxTitFdFpmNXFjNEdCbm1HUThPNkRaZlRrU1p4SUFqMis4TVlZ?=
 =?utf-8?B?Q2lVY2hMOWhYb1I4ajlic2FYMjU0em95V2NnbUZueEtGem5KUmswZXhQZ0Q1?=
 =?utf-8?B?MmtiaVFUN0dZS3lqTXZiZFE4SGRkOVVTWkZlcmNySDBjMHdHK3NpR1J2eU1m?=
 =?utf-8?B?YUJzVnZJc1pkNmpHYzdPWjZTd1V6OE5KNzErRWc2ZHhMNWRNZWVTWkZYeUhN?=
 =?utf-8?B?aThxekRYcUNYbVRRK0V0QkludmdFQm9SZkxKM1psejF6TDFQOW95NkFvRThr?=
 =?utf-8?B?MmVhd2J4dGlBUTVuczVKQXh0d3BTbVM2RXJPZFhpKzBndUpKbUZoaEFEN2Y0?=
 =?utf-8?B?TlU3OUtmVmlvbGJraFB4eDNqd0ladFlTWjY1OVBFRGpPbFY1RkNuSWVuYklv?=
 =?utf-8?B?eGhIYit2SFByR25PZEducE1nVU0zQ3o0SVptMUF5ZXJKN0VaMWt6REh5ZlJZ?=
 =?utf-8?B?b2tLZ2IyaW5Uc2VGYllBcGpnbStvcHMzdFpLZlRUSExQNjlzS0FrRnR5cDBu?=
 =?utf-8?B?THRDMzEvc202MDVXeW9aeDAzZ0VQYVIwN25xZ0pyeDFnTVQ3SDBHYWdCQzVC?=
 =?utf-8?B?bGgvV2xsVUlUMnZ5NnUwWE5Kb21iUFhDVFAvRG55eG5zYjhEWmVwbHVyNnBS?=
 =?utf-8?B?OS94NWFmZmUwN0tEMGd1T1huWWptMnQ2d3UwU1Z0WWdxSVVjWkJxVHYvdkQx?=
 =?utf-8?B?dVhkZXIwMlFqQkVDdFA5YmZjaHZCUWp5YUpiQkx3YjcyM2N1RithT3hCQkI1?=
 =?utf-8?B?U3V6WGR4L2dtRTNpcXZQbFJINDVYbktKY0N3U1ZKUWlIZTlOaFpsMndFQVB3?=
 =?utf-8?B?VWRvVU5CR2YvRFRKVmpGYTRlRGlybEhHYUZBVWZpSHowWG95N0szRlJ3dWVr?=
 =?utf-8?B?bENIVlFXRWhzeG9Iem5kZEJLdytlSy9JODZEcWlleCtJdTJjWGxhbWg0Nytn?=
 =?utf-8?B?NWF1V0lRbVR4RFIycEZMOUV1bkVyRmpVb2VmTHNiblZSQlpHZ3NEUnBMWGhO?=
 =?utf-8?B?YzVNNVovU3A0cWxST0tMcUc4SElROXNlOXhvTmh1K29JRDB4TzdheG4wYk1w?=
 =?utf-8?B?L2VBek5JU00xRlhHNWM2YVFCUEFrTEx6WSt5aDNuUlhXa1R2bTV6bEFTY2lz?=
 =?utf-8?B?dG0yd0pRSk80STVtNHUzVnpUa1RUYVJkaG1jRURuMjAzT2crQXVYbGdZSWM3?=
 =?utf-8?B?U1ZaZUtCM3ZhSWVPRjJiZVI0ODJoOERUUGt3emlIeUV2MTZsay9BQUgxd2tN?=
 =?utf-8?B?Z3d1dFhvRUVRUGZWeWM1NG1oRklFbFdIWEtQK3RZQzNHSU03WDJSUFNEYlND?=
 =?utf-8?B?ZmI0LzZPK0R5Rms0VTEva3d0N3BRWElJSlFMVGoyTWtaRExWNG9vMTYrNVZX?=
 =?utf-8?B?K2h2bzZZMDd6bmZTSVVHZE03MmNXMmg5QXdhSHI0bEdNdUpuZGVEbElra3Zj?=
 =?utf-8?B?RU5yTVlHVFRIQXhpeWJXT0srRW50UWRUcTZ1TnUvOGFTNFNJWnhiengyczZ3?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Rp6gWgUXUzTH6NW0Iuu2oiesxDa+pfrqkC1cL1kqv99VjI4ARr0UYAKIxnoupC7TDlodFvCyt2RF/LdyyIRosxgIJZl1K1ab9mTqk/cRc123//1JHzziUFxxKn0KLJ2tM/XVJ53w5a3fEAZqCYdqBUusT3iLvD8J6jsqBbmCSbA7KQKanfJFg9HE3rPLcKR5xoY/nbDKrGu0Q9NmRlzaTCEalsfK8RZYHDe4/yfZvqRSKwS9qSFXmxX8/7lzabkTIOk6Bop23yuuU21D97ujFe7YnqgJGf1YaYM6/pf9QZCWofk48doQdF7oHsaSqmdO7sHK9O7QUUzCa5tJchfKlnneuKI8V77At4xQSxn90G1CoXyPCWdyi2DAGTcgG9knS6ryko6vhMLenfnjqYqp5WoJiMJCUVEDQtbslLeyNRDCt7Swwgn4SYIXvCtNW/OyhILL2sqFsIhZ00gQaTQVtGavmJTuhVcA5bwk5GjzD5O3GfdE9S6Sksxl0xrMpfcPr0s7tOaHjOG6lh3uwPoy8Wiw1pPPT+qq+K19lm3a4atmGko681nZTcKk5DbfpAy1YQHHc37CUXQfo/2tio6tgoLXolZOACEpPeUsFAg4lHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d651431-1625-442b-4d30-08dc8a2a75f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 15:23:35.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4wt7M/lqlz0wN6eOhFvLxHCQaP3+TyScZxIDqOLqibCbmD4d8wK7ICWDHKkMaMbYxjto07hrXawbh1gYZbHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=942
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110111
X-Proofpoint-GUID: __X6WnEfLKdQWb6Zh69vCotQ9trXf75S
X-Proofpoint-ORIG-GUID: __X6WnEfLKdQWb6Zh69vCotQ9trXf75S

On 01/06/2024 10:33, Theodore Ts'o wrote:
> On Thu, May 23, 2024 at 12:59:57PM +0100, John Garry wrote:
>>
>> That's my point really. There were some positive discussion. I put across
>> the idea of implementing buffered atomic writes, and now I want to ensure
>> that everyone is satisfied with that going forward. I think that a LWN
>> report is now being written.
> 
> I checked in with some PostgreSQL developers after LSF/MM, and
> unfortunately, the idea of immediately sending atomic buffered I/O
> directly to the storage device is going to be problematic for them.

This was not my idea (for supporting buffered atomic writes).

As I remember, that was a candidate solution for dealing with the 
problem that is how to tag a buffered write as atomic. Or deal with 
overlapping atomic writes. And that solution is to just write through, 
so we don't need to remember if it was atomic.

For performance reasons, I was not keen on that, and prefer the solution 
I already mentioned earlier.

> The problem is that they depend on the database to coalesce writes for
> them.  So if they are doing a large database commit that involves
> touching hundreds or thousands of 16k database pages, they today issue
> a separate buffered write request for each database page.  So if we
> turn each one into an immediate SCSI/NVMe write request, that would be
> disastrous for performance. 

FWIW, atomic writes support merging in the block layer.

But, that aside, IMHO, talking about performance like this is close to 
speculation.

> Yes, when they migrate to using Direct
> I/O, the database is going to have to figure out how to coalesce write
> requests; but this is why it's going to take at least 3 years to make
> this migration (and some will call this hopelessly optimistic), and
> then users will probably wait another 3 to 5 years before they trust
> that the database rewrite to use Direct I/O will get it right and
> trust their enterprise workloads to it....
> 
> So I think this goes back to either (a) trying to track which writes
> we've promised atomic write semantics, or (b) using a completely
> different API that only promises "untorn writes with a specified
> granulatity" approach for the untorn buffered writes I/O interface,
> instead in addition to, or instead of, the current "atomic write"
> interface which we are currently trying to promulate for Direct I/O.
> 
> Personally, I'd advocate for two separate interfaces; one for "atomic"
> I/O's, and a different one for "untorn writes with a specified
> guaranteed granularity".  And if XFS folks want to turn the atomic I/O
> interface into something where you can do a multi-megabyte atomic
> write into something that requires allocating new blocks and
> atomically mutating the file system metadata to do this kind of
> atomicity --- even though the Database folks Don't Care --- God bless.

At this stage, if people want buffered atomic writes support for 
PostgreSQL - and not prepared to wait for or help with direct io support 
for that DB - then they need to design/extend a kernel API, implement 
that, and then port PostgreSQL. Then the performance figures can be 
seen. And then try to upstream kernel support.

We have already done such a thing for MySQL for direct IO. We know that 
the performance is good, and we want to support it in the kernel today.

> 
> But let's have something which *just* promises the guarantee requested
> by the primary requesteres of this interface, at least for the
> buffered I/O case.
> 

I think that you need decide whether you want to endorse our direct IO 
support today (and give acked-by or similar), or .. live with probably 
no support for any sort of atomic writes in the kernel...

Thanks,
John




