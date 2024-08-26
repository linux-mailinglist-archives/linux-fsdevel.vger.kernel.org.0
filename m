Return-Path: <linux-fsdevel+bounces-27191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D6C95F522
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 17:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471121C2186C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F50193408;
	Mon, 26 Aug 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YTPK9CV1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vaMhwVYp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745418E057;
	Mon, 26 Aug 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686297; cv=fail; b=uxnw/ROmE8hBs+t+MnH1mjH4x3hxsOI9SwTLJPLcRUHbUDX4v3v5h91+GVu5rcTpbBgywP6+PWwFG/rWyV5YYUm3kBT8zclW/ktZgXmzTiMCA1pOk8u5z3Zjnik+pRiaGrkoDCo/jL8JgQGjWLFHUCg4v35xKj3CBTxDUDnlU3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686297; c=relaxed/simple;
	bh=X1571vfm9b8Wk5/O3PBruNyYngxzN8Hdga0wxtp+jVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iDn5CmI3xHZPtOWBfp8peTdRJpHYnd/+UffdZvQVuNrNji8gOG8CKtX1CxepR3GJIp/pMJ5T8/jycHmC2J16Zr2s0vODIwVM08LURL9lUTJA621AwtIfCsjVCIgCLCvKVDjHRGlwf0UEhAcEIJiAHXty3Lh3U6fgFK1NrxzAlS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YTPK9CV1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vaMhwVYp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEfWI5007799;
	Mon, 26 Aug 2024 15:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=IPgxRZc2hO9JVpYyI16Fggfa6yHzA7TgAEfPJUMaZr0=; b=
	YTPK9CV1i3TzCLCw5/ocy4xMwI5+RwlBVPdb8RKfh3NH0w0ADmcxzl+f3F0MnY29
	5cXPIN/O+NTcj9E9rtZuz3dTn2aoIJ0FxE3C/+NgGOg02rYaFVLmylAmPRCsYbEr
	4kEZn/ea37ibLppzouQP7bWeKdZyfVgJQqU2fUIIo2eX7zCrByX5RShR+QqkcEs6
	ZNpGUfMulABHlcaKWrjIIfVziNMeJoP81+c7Kqdf+WhimYLsE2DgXCkPK6XWqEya
	uWfkksDlsKE5TVaXandjG0cM/X4PlEwPXlPesccbvUW5WxZis8gbCNMyYbKA/K+a
	RGsdwgg2wBmCaUwjvBwMCw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177npbce7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 15:31:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QElArI036474;
	Mon, 26 Aug 2024 15:31:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jh6daq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 15:31:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2w7sLtEU+dK6r47er8NwvHF4hJSE7MKqo45S6SJrcYc+kxkoXTE0hTnXGYFDIr33PJ7OaJJHy9jQ0aoXepwFsOMsxc4jKpbWYZlPmGSnV2M7MrgGkm4jhXxcNlsukiZH669Oz+A25D7jHFHU9mH6zRw2aKEFExwxnIOoiasOcUEYl9ak4ZbF5l9UUUhdImEU3O9wlMgkmVWBqVEqtPrhL/Q/4MXi3ilQJDLAn67/vyD7IcPEB/j3lpz6sBaS9QjB5idGumoxEhcBdNe35dLWOccCwOmMi9BG4JFviWTC7RXgseVcwMWRlIotUcFVgx5/wu6n3OMEkiksXFz5TXwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPgxRZc2hO9JVpYyI16Fggfa6yHzA7TgAEfPJUMaZr0=;
 b=I5GS0w2vYf+mwYxOIM4QvbhWJeZzgYnIAx5N5UmWWYzaTqpD6kttsgWvWAe3IZkDqGpN5RKfJTUHwbeKffelgRRhrptWqZz75aMLjm67QdOzKJ/EO0teSTq9xY0I/f8+S2Kz8HBuIvw19MUqKrb2uXqSS3LA0BDZi2ab3eCeGIHg9/wt5n8OITeD8TP+eIJCQ+bsKKJ8hFrkFH2iLgt8yh02hZmsYN63dTeRhC6EtWphGD4UiUE9x/N7IQVRNsG4lXN0DVkPbFNdYqZBk/exEHtGfaF9PoO2Izgo16bWIGnENzRPeyj4MVmv7uj2OBLou6MS16mwHMVkbkErqtECJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPgxRZc2hO9JVpYyI16Fggfa6yHzA7TgAEfPJUMaZr0=;
 b=vaMhwVYpNM06pFdhdpbDsW/PoiaRbFXaKZJiR/C3UXmRKyDgHUunAScwHFmUQICIl5iET92VOe3QboJRR6unIIsK49gjTLC4248122q47sxbBbB4pNbLtIBrYVFtJeYaVo7wTAozHwVE6RkALRtCrLi4GUyYaM4UOkNGLLMT1aM=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 15:31:12 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 15:31:12 +0000
Message-ID: <8708e2e4-b9e9-45a7-8aa5-2f06234d3ae2@oracle.com>
Date: Mon, 26 Aug 2024 08:31:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/nfsd: fix update of inode attrs in CB_GETATTR
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20240824-nfsd-fixes-v1-1-c7208502492e@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20240824-nfsd-fixes-v1-1-c7208502492e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:408:fe::27) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SJ0PR10MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a79405-cd55-483e-1c93-08dcc5e41de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1RnZEovY3NXYXpOcCtQcmw5d0pFTU16RzZVTWtjdXYvMnZkR0FaOEtoeGFM?=
 =?utf-8?B?bEMxdTFpNUlBdEZQSzIvVlJnSFNPSmNuUTZSa3cwenhXQVpEVURlNzQ3bmlX?=
 =?utf-8?B?UTVOdVFoVDNlK2lVZklrQ3hNZE9tdjFOVGNXZ2p2bFV3RTBER1NCY2t0Vk44?=
 =?utf-8?B?b3dWbkRuc2ZRZi9wT0Vsd2xDckk1NndiZk9hVGg3R1Y5Y3JLYlpEWHNodnls?=
 =?utf-8?B?aGdYcGxOMktpY0lydGlwb3dBbnQ4K3ErWWJMM0h0b3I0QWJXUDVrY095cTBr?=
 =?utf-8?B?Y3diZDBpeFBmQ2FUR1FBYm94TTNtRStFa2U5L0hqN1VtWjlLdkM2aHBQMVpz?=
 =?utf-8?B?R0JrdEY1RVhYUjl3OTRJNGVpNDM1bXM5ZVFKSVJjU2xQb3Q0cUVIb2MyU0lC?=
 =?utf-8?B?MDdqaDZRZERSK3R0WHVyQ0VDdWcxUHY4dUVmM25keThJWHFVTU5NKzE3VU1R?=
 =?utf-8?B?V2JvdllTWGtFUC83aHlnY05lY21UU21CWlZpZjVKY0s5T1RocGZDQUNvYUtE?=
 =?utf-8?B?blE1Um9pUG9JMzVVT2t0NzdSSDNWSkdsMzlYQ05QdjFNY0E2VWN4VVVuOEpQ?=
 =?utf-8?B?bmNEYlJ0NUxkTW9NcGFDMlJCbE1CRW1KMDhIb2RYQ2l2WndEd1BHVjVEaWVO?=
 =?utf-8?B?R3FybzgxK0ExM0UzSWRxL3JwRGxMMWUzWmZucDExWFZTc096TnovamRwbXlp?=
 =?utf-8?B?RE5UbklrTmxJSXM3UGRxYkNPL2JVV0hXblphcm9QVmcxc3BlOFE0cXV5VXJq?=
 =?utf-8?B?UjBHSVh3RUErZ2s1THRTS2ovb2E1TVhqWWNCYXdNdmR0QVU2b1U5TnNNdWR0?=
 =?utf-8?B?SUhVL0pyaUtzSk9KTVVGNEdRcTN6M3IxNzN2NXJ4UjcxWWpEVVdyeWRqVjF4?=
 =?utf-8?B?ZURFdTAzNEltTWxQVTViTzZDMEhGbUpmcUhraEdWdm1UcmZSVldlMzRRRG83?=
 =?utf-8?B?OEJOTUFPQVdHaGlOM1ZyNFhWRTZiQkw2WlkxUzQ3aTVkZkxUb2p6NkF1aGRL?=
 =?utf-8?B?Y2Mydm4wMnAyRmpoeDVtVjlwM2ttY1lnUjg2WThyTERPSjdpQU9oS3dmTkk4?=
 =?utf-8?B?THFOeWQwaEJyM1ROL1VHdThpODJXeU9oQWhFMytKa21zY3NrZndlZktsamYy?=
 =?utf-8?B?ZWlSVGdFY21aOXlkTjlHUzFLdkk2NWJaTFA5Yk9NemZTY0taUVFWRTlpU3RR?=
 =?utf-8?B?RDUweEswK3lPZ0dhNlZCTzRpNlVaKzZ5dExUZm1vbytneTRITklBN1dvY0xM?=
 =?utf-8?B?T3BkQlVKbWJ5aWwrWkkzRTRpWTVKNERyZ1BpaTJZTGFTMm1DU1dEN2NKK1Ez?=
 =?utf-8?B?aG13bzlWM21sV3NaUkVDL1JqbGZzYVFxSU1iRmdUdWpNZXU0alhCVHFteWVC?=
 =?utf-8?B?NU9mM1hkdHo2QzhxeXJtQ09VNGh0UVlheENUeE1KM1dqWkZ0Q0FOMFhWNGQ5?=
 =?utf-8?B?V3V1L3g1ZGlhZmM3OHFlRzI2Z0JtbnM5ZUNOSElISEl4bmo2QzgzVHRMQjBp?=
 =?utf-8?B?a3JtMmM0SXBlQ2c2RUFsOUo3RU56RzBseUlQYkRWS3NrT3BRaXhGcXRRVFo2?=
 =?utf-8?B?TTVTbFhiWHpoaU84ejhhUUpEZjRuaFRaUTd2d0xvcnhUQ0JoaDZDSFVsaDg4?=
 =?utf-8?B?eFdNY2N3d2k5ZHhrVjJveGd2MVR3NTNwbGV5VVNNcS9XclhsZVVrUEtuZHFP?=
 =?utf-8?B?ajlxdTh4MkNTKzd0Q3JpOUpDMXdaYURHRVk3YWVHNUozSVJybEZBU3lpOSt4?=
 =?utf-8?Q?PCt2AlHpAebo2tCUPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dS9VSkJpWWdtV1VWenVKaFdDZnUwamtVbnplY1BCTi8vYVhlMTJJNVZsd2cw?=
 =?utf-8?B?Rk51dTRmRDNGRU95c1NvQ3crcVUrc0MyMkdobHY3ek9IT1VmY05FSFJtbFVm?=
 =?utf-8?B?YlNkdDd5RStiL2N3M1VIbmNkZEErdUt2eGZIeGhFbnoyVXhJbWwwNUVQa2JS?=
 =?utf-8?B?Z3FVUWVNK0ZJZk4zWmdadFZwTVU3ZFdYZWsrR3pYQmRXeVZ1NzJ6NVorVnc2?=
 =?utf-8?B?Q29lbVVvMDlVNXJsY1lvc0tOYkxuZWZQTW1mZ0VRb3NJUE9zdm5VekRGNWJN?=
 =?utf-8?B?Mnp0MXVVVEo2dWduSHN1Qk56UDFBVk5mbisyV1c0ai9YWlVkY0RzTC8vblg3?=
 =?utf-8?B?Rk1ScGFaUFNVWXJIR3FDQnYySW4zcHI1bW4vZ3llZEYwM1ZWOVRqQ3pPUkt5?=
 =?utf-8?B?YTlWdXM2WXg5RjNwejNsNkxoZ3lObzNHOEp2RHlWellyeEd0a0NGNjFMaVY3?=
 =?utf-8?B?OGNCTUFPbk9MWkY5S0d1RmN4RDAxOU1MMml4cFlPU2lDTmlYcFlIZzhEbE5y?=
 =?utf-8?B?dWxVV0x3SUxqS1htRHI2aGdtNTFlRXBqWHhUQ2pwejNKclo0b0I0WlZrdm50?=
 =?utf-8?B?ZWdmeVNBZXkyemdUeEt4VWRnNDczSkdQaHN2Sms4WUpRRXNMTHNJbkNOclB2?=
 =?utf-8?B?NmlwaTJLN0dzNEtSUktsUTg0MWhKTnQ1SVZWWElFa0s2RGVlNnZaTmQ2R25E?=
 =?utf-8?B?bnVYTURkQk93dUJxRTFqeWtZSG1EcXNtNXJLMFhMQUgzMjNRRHBJNXpmQXVz?=
 =?utf-8?B?LzE4dDFqWU5tUFM2bU9KSmRhMHg0ZmQvSlZDYUwrcjJHVDVRNTg2UFYzRk51?=
 =?utf-8?B?akVCdkJuQzBXV1ljU2RwV0dzenEvUnFUcmVtZ2J3VTAzNkgzcHF1c3ZzTUp5?=
 =?utf-8?B?b3p5MWdMbGF6c1MvUkV1S1l4TFlDNUFxMGtZSHQxK1NTNUIrc3FobncxbUFZ?=
 =?utf-8?B?S09rbGh3ZSt0SldxN3duWWd2QUt4Tk53RHQxQmdJT1NmZjE2OTB1OHdJdUhP?=
 =?utf-8?B?V0tSTzQvZ3JyL0lmK1dZMGhWKzRHQTRZSkwvVTdLeXlhYllBNjRESmJPdVEw?=
 =?utf-8?B?dGtkaGk3NWJQSVJzWWpyVFhDbkU1L3FTdUtERzkzVXBHdFhwQnA5UkRhZ0dl?=
 =?utf-8?B?c1ZOYnRKNytVN1dLL2Z4bmpiVUlnODVNL2w2bUdXYzBRbjh3UDhLMWhaVTM2?=
 =?utf-8?B?ZnA4QkZZVVo5K0trZ3hRZlJ6WVhXTjl5ZVFYbUtrZGFNQ2FOVDMraUNCMnIr?=
 =?utf-8?B?eEx3amlqWlNwQ1RVSFYvbkdBZmN5aStaVUh3QXhSQkZ3aVlKc0RkeVpwVlZY?=
 =?utf-8?B?dmNUc3EvVUZHYVdjWTR6MlJBN1dZTUlhVjlhcGNWam9BOU9lWTBrc0UrVXJ3?=
 =?utf-8?B?cUtrMXVjSkNtTmIwTFBkWlBZdDJaVTNvaU1qZng3K3RtWS9OQ0ptdWtwZFNC?=
 =?utf-8?B?V3NaV1FsQ2hJY083V0NhblltRldFeGhwbDhtUGl5a0RzZzBUY0ovQ25LK1lK?=
 =?utf-8?B?YmlRN1loN09VQy9LbkpCVlZQODNqYjJET0s5N2dhVm5VUHJJdEhublRrMFYr?=
 =?utf-8?B?QktYWGdTUEhuTUJuSkZJczZkeWJhSmpIaWZnTVV3ak9BdG9WcEVJYVI1Nzls?=
 =?utf-8?B?UzFEN25tQU5rMDQyTisxYTAvUWoyZWhDTTlaVDYzK3FYcUFzdXA4cmg1dWZv?=
 =?utf-8?B?aTI0ZlUxOWtldUx4eWxZSC8wK2hYZHdHR01ZTSs4Q1hDempKdmYzN1VUbm5V?=
 =?utf-8?B?eUV3NTJWMUhWc05tRVNMTlJYaDk5ODcxRjh4ZitHVW14V20yanBQNTQ3TlEr?=
 =?utf-8?B?Z3E5Q2RlQWpVdVdPZ1hCVkdZenpoei9XWHQ5a05keWdsNXhGZGdEZGp6T2Ez?=
 =?utf-8?B?N3gwU0pKMGRiVUpVdkVYQ2t5b1JqZDJQVlh2Sm0zSDVUZFZHYXRNOHJ2S3Uw?=
 =?utf-8?B?WnNNaXNVTTJUS1dvRTZVUDV2MVRZTHcySGN5eHp5aXphaTIvUWVHMDBrWTFE?=
 =?utf-8?B?NHFwZnVGR3gvcG1iL0ZPYzlvYUlpTmZGaXlkd21DVEtsNEdZQnZPSnZHWjh0?=
 =?utf-8?B?S2ZvWGFMbHl3c1VSVUx3czIycnFXWWtmRDUzQ2RscTRQd3F6RzFOVmQ2UFpm?=
 =?utf-8?Q?GKQiiVqbAKIyKFS6WfY2TadKq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iccG6fb0ygBBOti+Ax2RomoQsHv2W2crmS6jg+Mn1g2SHzjtTbqpgJAsTkzsIjMqPT2rM9v8VP8oZzXlMER8AownB2dmoAkW17TF1+woauYDdSsrhJhdJ1mnDJXmiDuLE+FtWnRJPPphkr9UL8WSOj8ikbqXyNRIVdGXAFbLPV30jboMc1pKMpFoGFOeiJsFQvluXcbC1ApKLRAykKM5OHdgLchlKQwIA8v4YsCHXS85bNRbwZIWwfPucS2LHXPQtA//XF0v1uvNY+1wmCrj3XGFqZkmweQv5xdKHOGmiZ/ogGOjFU2lnpr+MA/S9zpJIYayKGwBrqyjlu86NI86ay9Dvho9iEYiPGxAPSqa4Q8yi87kBQmD2pHpP84QBPvk/XVpgSAzWwSbMl48A6ruDBfQW/Jsq4zubhBbmkRJ3c00Doa2sJM70BLRZkjYarl3q2QfdC1LK8pGsfbVJ2rzAU4NsTYBvZj+oknSysdslxDeura28VOFF0hvyzb3nvbxZVnuRjPOHUdhpsvQgf0+7s8tMFIy1OZp1dr554v7vL1ZbV9iJwvjLyeRK8F2mUW6QSzeX7KRegyULPQ/2WGMx9JjtV0MYyBJ2elB/N97Cno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a79405-cd55-483e-1c93-08dcc5e41de3
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:31:12.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtSQzP8Impsaoe0xWIi0vzD+l0j0BscF2dcV/GxcFtBP+50V037v90h89htqJ14itqkCohYVdT3cVlma7fG+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_12,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260118
X-Proofpoint-GUID: dFvRCDipUPODBmR3lQwQ1WZExbalb1c4
X-Proofpoint-ORIG-GUID: dFvRCDipUPODBmR3lQwQ1WZExbalb1c4


On 8/24/24 5:46 AM, Jeff Layton wrote:
> Currently, we copy the mtime and ctime to the in-core inode and then
> mark the inode dirty. This is fine for certain types of filesystems, but
> not all. Some require a real setattr to properly change these values
> (e.g. ceph or reexported NFS).
>
> Fix this code to call notify_change() instead, which is the proper way
> to effect a setattr. There is one problem though:
>
> In this case, the client is holding a write delegation and has sent us
> attributes to update our cache. We don't want to break the delegation
> for this since that would defeat the purpose.

I think this won't happen with NFS since nfsd_breaker_owns_lease detects
its own lease and won't break the delegation.

-Dai

>   Add a new ATTR_DELEG flag
> that makes notify_change bypass the try_break_deleg call.
>
> Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> One more CB_GETATTR fix. This one involves a little change at the VFS
> layer to avoid breaking the delegation.
>
> Christian, unless you have objections, this should probably go in
> via Chuck's tree as this patch depends on a nfsd patch [1] that I sent
> yesterday. An A-b or R-b would be welcome though.
>
> [1]: https://lore.kernel.org/linux-nfs/20240823-nfsd-fixes-v1-1-fc99aa16f6a0@kernel.org/T/#u
> ---
>   fs/attr.c           |  9 ++++++---
>   fs/nfsd/nfs4state.c | 18 +++++++++++++-----
>   fs/nfsd/nfs4xdr.c   |  2 +-
>   fs/nfsd/state.h     |  2 +-
>   include/linux/fs.h  |  1 +
>   5 files changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 960a310581eb..a40a2fb406f0 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -489,9 +489,12 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>   	error = security_inode_setattr(idmap, dentry, attr);
>   	if (error)
>   		return error;
> -	error = try_break_deleg(inode, delegated_inode);
> -	if (error)
> -		return error;
> +
> +	if (!(ia_valid & ATTR_DELEG)) {
> +		error = try_break_deleg(inode, delegated_inode);
> +		if (error)
> +			return error;
> +	}
>   
>   	if (inode->i_op->setattr)
>   		error = inode->i_op->setattr(idmap, dentry, attr);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index dafff707e23a..e0e3d3ca0d45 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8815,7 +8815,7 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>   /**
>    * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>    * @rqstp: RPC transaction context
> - * @inode: file to be checked for a conflict
> + * @dentry: dentry of inode to be checked for a conflict
>    * @modified: return true if file was modified
>    * @size: new size of file if modified is true
>    *
> @@ -8830,7 +8830,7 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>    * code is returned.
>    */
>   __be32
> -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
>   				bool *modified, u64 *size)
>   {
>   	__be32 status;
> @@ -8840,6 +8840,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>   	struct nfs4_delegation *dp;
>   	struct iattr attrs;
>   	struct nfs4_cb_fattr *ncf;
> +	struct inode *inode = d_inode(dentry);
>   
>   	*modified = false;
>   	ctx = locks_inode_context(inode);
> @@ -8887,15 +8888,22 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>   					ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
>   				ncf->ncf_file_modified = true;
>   			if (ncf->ncf_file_modified) {
> +				int err;
> +
>   				/*
>   				 * Per section 10.4.3 of RFC 8881, the server would
>   				 * not update the file's metadata with the client's
>   				 * modified size
>   				 */
>   				attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
> -				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
> -				setattr_copy(&nop_mnt_idmap, inode, &attrs);
> -				mark_inode_dirty(inode);
> +				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
> +				inode_lock(inode);
> +				err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> +				inode_unlock(inode);
> +				if (err) {
> +					nfs4_put_stid(&dp->dl_stid);
> +					return nfserrno(err);
> +				}
>   				ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
>   				*size = ncf->ncf_cur_fsize;
>   				*modified = true;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 43ccf6119cf1..97f583777972 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3565,7 +3565,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>   	}
>   	args.size = 0;
>   	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> -		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
> +		status = nfsd4_deleg_getattr_conflict(rqstp, dentry,
>   					&file_modified, &size);
>   		if (status)
>   			goto out;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index ffc217099d19..ec4559ecd193 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -781,5 +781,5 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>   }
>   
>   extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> -		struct inode *inode, bool *file_modified, u64 *size);
> +		struct dentry *dentry, bool *file_modified, u64 *size);
>   #endif   /* NFSD4_STATE_H */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0283cf366c2a..3fe289c74869 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -208,6 +208,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>   #define ATTR_OPEN	(1 << 15) /* Truncating from open(O_TRUNC) */
>   #define ATTR_TIMES_SET	(1 << 16)
>   #define ATTR_TOUCH	(1 << 17)
> +#define ATTR_DELEG	(1 << 18) /* Delegated attrs (don't break) */
>   
>   /*
>    * Whiteout is represented by a char device.  The following constants define the
>
> ---
> base-commit: a204501e1743d695ca2930ed25a2be9f8ced96d3
> change-id: 20240823-nfsd-fixes-61f0c785d125
>
> Best regards,

