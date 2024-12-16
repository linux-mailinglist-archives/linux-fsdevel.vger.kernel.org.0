Return-Path: <linux-fsdevel+bounces-37475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 168629F2C1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 09:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE59718843E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4C21FFC63;
	Mon, 16 Dec 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kjaUcIRe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vY5lMl38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68511F709A;
	Mon, 16 Dec 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338451; cv=fail; b=EgiCeHNaMs7naDlAFHwWbV0hyiUSHVnLDWNu45Xncv7Bkf0gHq2pq0koJntG+7a3XpQAaV5s+9fvMuLFcc1UQbZfqjrSu2nFxU00DPz3zhYF3Dc/xRItvezzkztK5y4YL3bW/AkGC71JGifoBNM1pbgIhzgP7grEuut4u9+8pFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338451; c=relaxed/simple;
	bh=i5w5NaQAospY1P+euYFTLp8G8FkDCNN7DNk/pW07SfE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VvtmlvK7PIfWNpmfgD9Wui37ZHx4k8geZ61mbYzPFpzM79vDWKiw/uCfFaJRai8ZQXyadsxEHe5dKPyHV9reWhOpLwzUmS73jFZDIsFXXWtBoxPeFTfnu07/mhTVjBPoIghWDpvmfVnAOYneOFTWqo2KP4aYrHXLeTCjZert0Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kjaUcIRe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vY5lMl38; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6bV0f014947;
	Mon, 16 Dec 2024 08:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Sg07l1zRtiaaIoNE02CujBVybpB8W4+JKtvoZ5q+ce8=; b=
	kjaUcIRew0aj4Fg5nKi1HOMQsujQ8ctVxRhAhfzg9AflDEAjc/knFalAM8ekVj0W
	UGhfRv4WRAzTSF0CD+GhN8JQwi9kEkE1FZJaNk1KMA/B64Zdw1pSzpgErOVJSZZu
	ttcCz3j+6S0C1S6oTwEWkNMy2MMxIoquYKJmMMMBvUwmrXnNsc0yX17UsRMWKMSc
	okz145KGZ4U2OSlxFeMiAP/1A2l1JbQAc1ME1gx0i3Ovl/KvuTaU50kmuF+9k+9V
	R2BjD4mdDz5vdyXAndQJzQrETcLxoyccd08YqhAeFebtidWUd+udfTFjIogiEEjO
	lW8U8M8djnbv+iL3gyAH3A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xatq9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 08:40:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG7ZNgl018361;
	Mon, 16 Dec 2024 08:40:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f70gq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 08:40:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITG9SGupg7qW4eCI9BK2YVjKWX8iT3nbuvwxtKe0tlcxHfjAAd6LClDXFSH6hqwr/I38RdZH9JI0v2vnxx1B1ouL9wDaX3dhZ86zx2Uxw9WBRhh+aAGtSL3rYgZaDHMg05rkf8JBIqYOBepOOtSpkqPQrxHsfetRAp+FYWHmUc/Fg0Ozuyw0Gablp21tyVMwOlOvBLXz9akr3Hf2zw+g3qb4yVU4a4w7Hy3/Y7SZwLYQ8W69ViG66UB0/nMwifCPUrrRySuCWP+bCZDyDTgtURWuqp2kxb6TBCd5RGBKXCgqU/IS4sDkFhVYLvHN22RNRDGeloLLlSQfmuuALZewCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg07l1zRtiaaIoNE02CujBVybpB8W4+JKtvoZ5q+ce8=;
 b=jvLADjtdlUPMasb6RkvloL3DLeMW5kKVbWvGDSriBBjvWcZYNsYZnFP99zk2wdlqV526B334rCmYTP7hkOLAYz3UbeV/cOMV19AkzE/MOmhi8JlWCOkWnfN8LE7JZ0QrVZB9oUtsOUnMAIxxFq1dPCuTWvaAAuGgDhdxMzhdrkd9Uo6HMIEOcHfluXu5vNf8AfCUcMOIfZKZCVNqtq3tmeIwfTGacXCVm9PYCKZr1qOP9vaP4XKkCx/hFwlAIixIKoqCSJwlRxDB4/5PNVT81FmJGR7EF/bkqxONBrwsaXz7MqBIxig5Itc9wsWZJd63H3kQbW9sBeGVnYnGDFTR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg07l1zRtiaaIoNE02CujBVybpB8W4+JKtvoZ5q+ce8=;
 b=vY5lMl38mC5wVza+ZqaVgX3bBKB/Li+oy9AFuPSepXAO6mTNH2T41R0A84/f1T931LkzBz3kEN92cwn51RHGYgRg/O2bi3Q4m/chgxLm9ENDzbRgrJkPWXpME7um7wkCqb4t9ciCJXAVC6Wt1dqdi/RZHFW/1XCUuJvKVO2grUU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4800.namprd10.prod.outlook.com (2603:10b6:a03:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Mon, 16 Dec
 2024 08:40:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 08:40:36 +0000
Message-ID: <37cab50b-5791-4840-b7b7-c67d3878fced@oracle.com>
Date: Mon, 16 Dec 2024 08:40:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] large atomic writes for xfs
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241213143841.GC16111@lst.de>
 <51f5b96e-0a7e-4a88-9ba2-2d67c7477dfb@oracle.com>
 <20241213172243.GA30046@lst.de>
 <9e119d74-868e-4f60-9ed7-ed782d5433da@oracle.com>
 <20241214004256.GI6678@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241214004256.GI6678@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0114.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ff73e9-c763-405e-b3a1-08dd1dad4ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEEwQnV1NjNHRkZzbjZBbWVmS1VINThEM1h1cE4vOGdlMWNPV1JsZE8zNVgy?=
 =?utf-8?B?ak5jNTJKNlZ3K2xLdHJpbXp6OWlnM0pvVmpPUjdiKzlDTW9JdUIvZlI4c1JX?=
 =?utf-8?B?bVVlZlZlMGpyZUVZdTMyQnZ6Rm9idFh1b1E2RzhLaHF3dXRPY2NMZE4wWjBw?=
 =?utf-8?B?UFlBaUtJcG1YSDhiNys3NnNEcDdjVllNaXZ3U0JzenhKSm1BdExFL1FpT1lK?=
 =?utf-8?B?VmUycmFIbXVFbDdoOXlhSUJ6R2ZDY0h1OVFQR1Y0MUtwYmVRaDg3bkZpN1Zh?=
 =?utf-8?B?RHVmOTJIYXE2UEhnOE4xZ1kya0J1YWNSa2lybGI1ZjN4U0t6YWVMcTJ6NGFC?=
 =?utf-8?B?UkxETUZLNjdNaWk1bEk3WWpkcktudithakg0Rks2a0FINkpuYTZvK1NoNENW?=
 =?utf-8?B?dHFhUHlHQXJFNDFSeUtDbjNZQUFPbEFLLzVaMFJLb1FpaFlUM1RYOHJMeXE3?=
 =?utf-8?B?Q1d4YkpBeHh5aFEzdHlFTS9KWURaWFhiN0Z5c0lZd0hGTkxsRGlNS0ZrTUcv?=
 =?utf-8?B?ampydGRUYmJQQkwxdXlqRyttUUVMVnZxRjZlMmIxbDBYQVNSa21WR2piK2Ju?=
 =?utf-8?B?Z2VkTTNxWll3MG9Va2k5bXQxUmZCU1V3b0RodWxsRFBNTU5mN0E2UFd4Rmp4?=
 =?utf-8?B?Q2h3R1VNM1JwcXVTSDB1Wjc1d2FabVczR01oOG1DeFpFWHIrMzFTYUhTcit6?=
 =?utf-8?B?Wjk4T2pKb2tIN09WU0dEZncxV21SUWJuQ2s2SWJmRUVDUGxrOXFrK3pLdThx?=
 =?utf-8?B?QWt6ZmFGWGlVRVNyNjVuNEhwdUUzeU00Rld6VFZ2SGZSNWFmUXE1SUpmYjNN?=
 =?utf-8?B?dTJqQVppck1JT1A1ZXU2b0M2WnNVdDNScHhnZlUwbS9UbnBCZVZYckdlcXU4?=
 =?utf-8?B?NEhLeW9uWlp2TVIzTno4TVB3OFdjaUUzOWI3NlpRVTFQYlBJTklhbDJnYTFI?=
 =?utf-8?B?UUVKU0FkMkJ5Tk1RaU1TUjViVUJNREJ6V1JjSVp0bmdnSzE4RFhOODNaZ3J6?=
 =?utf-8?B?U0hSLzRGR2FhRDVKYWtaaEFRNXdwQWFXZytWV0Vwa05GdktQWXRtcWFyVW9Z?=
 =?utf-8?B?alVGejRGYXl2ZDFpZlZKRVB1SGRQUElUemRSMU9qRXF0MDJKYjlDTHhoOWgy?=
 =?utf-8?B?ajE2N3dtZVVYUHo3V3R2QU8wOUN3eGJWNmFkLzU1WlhqQkNPaEFHMFFGL3VN?=
 =?utf-8?B?Q241cHhPbkwyVFNYZ0FRTUdreTFLMEhHcTBwR0d5NEhXUnFmc1ZVQk1pTWlD?=
 =?utf-8?B?MDh1bUI1UmcxTDE0T210YkxWcUJRMnJPbnRIclRKYlFKcGdpSGNjSVRuZFk1?=
 =?utf-8?B?ZGpZSHNtTjN5VHlyNllpazJsK1dnbTJnVzdQL2w5OXpxSVdzaEVPbXArZnN1?=
 =?utf-8?B?TUluYWlBUVZia25vbENkaUh2S2lZVWdSVkxjSUdVUGFOZWI1L0N4NFVPdXp4?=
 =?utf-8?B?MEtGc053dmE0Ukt3VFRpVnNpVlpob2hlYXU1Vkc1bkdsU3lwWDNxbGMrd0V2?=
 =?utf-8?B?ZmdjL0tFbnBSRXJuMUtnZ2RUK3RJYnZDSitCQ2Y5YXRXNVRQQ1l5dHZRQTNk?=
 =?utf-8?B?QlJBbnpmaENaU2grVjViVGQ5M2FwTVAzSnJQeG1YQlEvdnV1RnRGSWtva3BS?=
 =?utf-8?B?WUsra1dtc2hjWEVmbGZkNHl3d3ZKN0dxY1ZzR2JTZFhEZlpJRC9wVUU3Y0ww?=
 =?utf-8?B?U08xblV2bC9CcUJQZS9MbW13ZTl2TlZOQ3lBTUU4R1lMWlRSVXFXb1VTVFJW?=
 =?utf-8?B?eE9BOUttN1lpU0Zma2pMWEhpRUdFQ2N4d2tjRWNBUzRSVklya3lRMlNFUHRu?=
 =?utf-8?B?aEJlVERZRllaV2FnQmdpZExlelA0bDdUL2tsNUduZHJvL3R5eHJySHpoSWMv?=
 =?utf-8?Q?QooFB9GNtYhbM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXRDVjdYejhVUUFpeVllNHFNZ1g5dzJWM1dnUlByZmZ3cUxzelNUR0x1eWF3?=
 =?utf-8?B?d3JUdWt4UzUwRmllZFhUMmtiVlVWVUZPMlN5eGtnQVFVa2NIRkJOdHZHQStp?=
 =?utf-8?B?cUhoelRzNzAxWmszNjg4Nms2QVpSNFJjbVBGTU9CTDZyRmc4MWRQV0JXaXFz?=
 =?utf-8?B?NjVjS3lDMXh6WEVNL1J3dWxYZGg0bUsydjRQcWFXY1k2cXV2QkpnVGhIU010?=
 =?utf-8?B?Vlkya1hvTmVmUkRpZnFUMGllajlPbVBGYW1sbUZjUHJaSGRranQ5RVVHa05i?=
 =?utf-8?B?aDZrMmlXZm5sUWJDTmVEUjV3YmlHNDBWeXNUb1gyRFQ5R3E4NjYxZHFKeHIw?=
 =?utf-8?B?MjAveEEyNlptUjAxZStpZjc0cDVTd1UzMisvTnRJbzBqbXpSRk5pZlkyalNI?=
 =?utf-8?B?RUUxN0Uzak5HdjJJYVVVT1pWVzdhWG1EZzYrY3FGRWYzYjlSMmdIRk9LUHdB?=
 =?utf-8?B?RWZhUWh6N3JFTGtmRVBTOEhOM09QcXppYXJDY0FaZnRYcmFMaWpSYUlpRVZN?=
 =?utf-8?B?c0VXTUJRTGw5SkpIaW5zcU95U1Z5UmZieEhhblZHaFhhZEtxKzFpdVlzbnhD?=
 =?utf-8?B?Z2k0c1BpaTk5dWprdjBTbmQyMG9zcW9meUVvMjh5UUhxMjRqQW1iRGRkemtF?=
 =?utf-8?B?TnhjT3M5RS8yT3RCT3VYc0gxNk05VXFwNG4wbGZkUlA2alhuUU5GMk9sQmpM?=
 =?utf-8?B?Y2NRaEcxMU1QSjJ3aDNWdzRuSWdveklXUUl4bEhvQjdzU0JaMU5MbmNTbHQ3?=
 =?utf-8?B?V0JqRE5CQ2dETGwzeVBGRkJEUHhTM2JuUXhzelB5LzRJNDloUmZVME9xV1hm?=
 =?utf-8?B?YklKWldYVlI5L044aHdLWk1nMUh1dHZCZzhlelpnbEo1YjhWK0tCOGdpN1Ew?=
 =?utf-8?B?L0lHMVU3M0NKRkxNeEF3amd1UnJuZFdYbEUyUlF2eEZza3p2NDJaQ25WVzdj?=
 =?utf-8?B?THQ5UG5zd3IrN1FCbHk1VW8vNFE5TUlMeFRVMjBuc0lvaC9wZUsxS2FVb2Y5?=
 =?utf-8?B?ZmhPTnZmN3d5Z2NQcGs5YlB5TXFBVkk1Qkg1dmR0Q3lEbmlLbkR3QVphS05V?=
 =?utf-8?B?TjBvM1lPajZiYzRuM3A4ekhTM2JvdFo4RG5SamJQbWlNcTNJMmJHSHpwZ2Er?=
 =?utf-8?B?QVFnelp2d2lQeDNKd2JBRERRNDlIN2hSTTN5OGxoclVHbGVOVXlBN3dyZG5W?=
 =?utf-8?B?bEFxbmZpSUV4S2ovNzduQ0RUNW81amU0bXZTU2pKdVNFMWI5SmRmYk54aFNB?=
 =?utf-8?B?UitLenBMR2ZNTDAwR1kvR0hvOWJoY1hqcHlvVXBhNy8ycXlsWndaTVZWOXhq?=
 =?utf-8?B?Nkw3TmVEaXJTR3pxdzJOeXNHRWYzZk0wSGo0RkpZZkRYaEpNUEdTOUt1R1RL?=
 =?utf-8?B?WWlidmxsTWQzaWFGVENDcXVHeHdjV0pTOTJZdThXMk1OWVc5STVtRVdjaHQ4?=
 =?utf-8?B?N09HMUtDRkVjZjVUWERLK1hBZzJoa0JpVHJKa04yN2wwWm9NRDVwRStRVzMy?=
 =?utf-8?B?VkNYOUVVZDJJaEl0ZmREWTJJWEQzNG5IQVI3VmVwQXJxS0NmanNqamVkRkVm?=
 =?utf-8?B?TnJCSmxuZitRZzVmNUM3RjdkbmhvMGhXVm1HYlJlNnBmUXdhazh5L2R3OGdI?=
 =?utf-8?B?dFQ4NjJDRG9IK3l4UjlBV2tUdWkxQ1IxeG1sSHZwZDVmRzU0dm9WWVZXVk5M?=
 =?utf-8?B?a0Vla0VQMUFXb2dqWmZVL2EyYncxQ2ZPYjJRSzdjQ053TC95WTBsaUdEWlIy?=
 =?utf-8?B?SUw2bEN2M05OczJ0OFE3c1RQSGNXNEdJWWlCc1ByMHJDWXRDWDMxbjlZQklw?=
 =?utf-8?B?TFdCamdNeUpVYzFDNmtLL2VJczlCKzBEemlnM0FOeitrUEdaSFR6YWRiS0xK?=
 =?utf-8?B?RE44U0FyU0dwSU90elJmOVhSTEtBL2pMUTZlbHcvWjNaWVFVYmtEUHdpNDhm?=
 =?utf-8?B?RjlPRFBBQW9rNlFhcUJXVGgxQlpZVWtkdnNFNmJoQXJKbk1CYzEzVlpNMjdH?=
 =?utf-8?B?alFjeTBaSXl2dG03d2puU0FHK3M4bm95RTdwT2RENDcvSkplZGNFNkNMMzk4?=
 =?utf-8?B?MmpNQ0JKM1ROekU1YVZaT25YdlJTNkhqN2VXN1BPR2I5K1pPUktWREZWaDB4?=
 =?utf-8?B?YkJsODRUdU9BOXJwU05xc2dIa3RWYW5VT0Y4Q1REL3R1bGY0QUc4bmhnRUh2?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/jVCrJBYKxiqkeV3+PlywPY1YeXrkIAoFmqGGObGpSnj5vWBMLxB5sc7VsR5X1wSpYzfjO4YPSZmOcwr462W0RmpPHexZbHfDrgGBRKjOC2x+wIP6aFaStcR573mYn14I0x9GkDN01w1nBn9a/peiE62HhYv2lAMHOxJKxhMvkUyr4Nk9wtKl32cxNdmw0fpBhXwwiEbfdReLOjdMRhXTNFTS7q6TlrgDtNcr5v7lsIwuCFNaX1XoMjuN731srg6NYNzpee8YyUCcZWFpIi47VsG+nKnJVkC9qpgNRfgt43oqHJRnzVho3NEFoKVjcSwBPjSMUaKFvFe3qwP0QVvURTKaPXshhaWf325AlTis0fsw5TYGRrw+q6IQ5gpppBJ4RXMAy8DZPEheQClSsUYQ7LvKfXkSChUjKUjoFMnl5ePhqACNygg845lKY24UGN/X1cJfHzLlvdqyI4pVNtpO/MgFrJzmUM4QLPSDyqA00aqBeEalkhovOsuPOYoKFNe9doGvfhff3aV47rzjA6R3j3MiydXhLsRfazeeC2pxqfVk5/sAhfTrLlw3G2Fapfja3Oi690jx9qd9DEDR4B4QfChjGAwjcUS3xE5x7j5oHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ff73e9-c763-405e-b3a1-08dd1dad4ff5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 08:40:36.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7GV5X+kreXfRBbaH32Dk4cZHhVwsqfLSp/II9OuAQffo1VabEhuiLqsHlEN/82rlbIZtzyO6jXspN6U+gVXVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_03,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160071
X-Proofpoint-GUID: RIb7I9hrT0ZLm71SfZJIE9ITHZ2sVcgl
X-Proofpoint-ORIG-GUID: RIb7I9hrT0ZLm71SfZJIE9ITHZ2sVcgl


>>
>> Yeah, at the low end, it may make sense to do the 512B write via DIO. But
>> OTOH sync'ing many redo log FS blocks at once at the high end can be more
>> efficient.
>>
>>  From what I have heard, this was attempted before (using DIO) by some
>> vendor, but did not come to much.
>>
>> So it seems that we are stuck with this redo log limitation.
>>
>> Let me know if you have any other ideas to avoid large atomic writes...
> 
>  From the description it sounds like the redo log consists of 512b blocks
> that describe small changes to the 16k table file pages.  If they're
> issuing 16k atomic writes to get each of those 512b redo log records to
> disk it's no wonder that cranks up the overhead substantially. 

They are not issuing the redo log atomically. They do 512B buffered 
writes and then periodically fsync.

> Also,
> replaying those tiny updates through the pagecache beats issuing a bunch
> of tiny nonlocalized writes.
> 
> For the first case I don't know why they need atomic writes -- 512b redo
> log records can't be torn because they're single-sector writes.  The
> second case might be better done with exchange-range.
> 

As for exchange-range, that would very much pre-date any MySQL port. 
Furthermore, I can't imagine that exchange-range support is portable to 
other FSes, which is probably quite important. Anyway, they are not 
issuing the redo log atomically, so I don't know if mentioning 
exchange-range is relevant.

Regardless of what MySQL is specifically doing here, there are going to 
be other users/applications which want to keep a 4K FS blocksize and do 
larger atomic writes.

Thanks,
John

