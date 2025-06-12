Return-Path: <linux-fsdevel+bounces-51487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEA6AD72AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437841885E52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD29923CEE5;
	Thu, 12 Jun 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AxMvUy6v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="irCAu8nY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFE23C50F;
	Thu, 12 Jun 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735984; cv=fail; b=RdRUVukV1MPRa+q9SQxDCHlLOCnYjMtkX6EwLnmn1+RBCgdMY4QrZ03NKAMIVMUd6xmNDcPsTEsnJ8/Pj11AJ6+gWUoS/snZSV4VEsqgI2VAz8zFe598pnAmbGcEt2dPnoTLgRMg2J971UwmYCib30KjmGRn3Q2QAitvCQ1VE/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735984; c=relaxed/simple;
	bh=4sQ6TNEUR7GTi/CA8PAfZGPsFehaG/mBaGGbwUwD3JY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFygpcm1/5zR7QZFm/jQCEt67oWlz6BQek/2/D/HXg+QSx3prYWrV4EMPI55A6rmQfLz1w+yB3r7EpusLRROx0ksQyDDZpEnktAO4BbRjlvfzjMhKIXyXojXmvgTY3rJZPrgY/IInc5pB36tnz4/PVydwYrJewl3IpolAfUjA28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AxMvUy6v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=irCAu8nY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7fZbK032555;
	Thu, 12 Jun 2025 13:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GlyrOd2zs7ucN4aXxrfYFQhuXfjCkmskyVnzDLCNRaI=; b=
	AxMvUy6vZG0zrBqEi1bawR6tJW1D4pfb3oEgHUa78fDFJc6F4260LjrELqKIIusr
	pSzFqKAUuZHB+tst9amJRfkCWjEWe5mvPFCnJzmj67Dj2KEIz8DkQN+zrosGkNR8
	+oefhlWfyE6N46N4QmihLWtAsvdc3GosZpd9Ksa4TRtHzXn95VD8K2QMswAMOdPE
	lhWPwnwYRSjLhK5Jke+oRCATrej1X5Qu8l32p5NXeLsgmOiuS9f+CUoUVJPvoSWs
	7urf6lY9v66qSiwG/kd/u0BXMBxJ+t3SgXT2mcUwhWpDSLnBvGlx6I5ps920soP8
	+tQq1yf0NXcLxm2FnJZEww==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf9p92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:46:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CCLtwF040773;
	Thu, 12 Jun 2025 13:46:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvcm3x8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:46:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEhKaagewjrMGQWYAkFsGTwQCtwd9C435jgCuAa8HyCBzCphfYw2JJFYYWcv9KPGPGezED+0aTB3hAsuHL0NabXjj2Tk1qzjO8uUmLMwkrpQpZ5wbg+3vhsjcSPpO7dum+rhCLNEwHbonYyRCysKcDFsrOHrstaO2MyPwDL5tcXaOBiHQTPaPOaveFdFc2/B28+LxIV+mdxDKesrJrT/eJLYbNpa7hx5TOmgp6O2PT5/8pFmBvxNX6tDE71wuxeZb87U5ldbfyWPuFA/EbE+obPaH0Q6SP4GuBxnuyrM0gbJAgkJdEN7xYVez/C1M7pKo5rB9cORSDdQ6cZPiD2Trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlyrOd2zs7ucN4aXxrfYFQhuXfjCkmskyVnzDLCNRaI=;
 b=MNnhoHgaLw4Jnug7XgH8A+3SCZNDtdygFdB5zMbjCq1woiwmqZnvTM8y81Mlq4CHACr28aWaNDB11yI+DpmUvmuVWZjjWQLp1idlSl/261AgWglkYOLdi/LWxMQf9ARUEXCfXs+HzuCf1+7vfU/pfr8RHWrp5lmyMtUcTiaSXNtHu8k210yY2mbaYOWQ9++34glkOt+T5PJztTnsiNGo/yRLLRh7eB7+5VH8DKZCVby6WY02zr1o6gHlPTZNRc+O8yRdnO1f/kLUOBjaZRV9iY2LoY0E4czgQFopLZXJzshLQVg1UDi9NWYdmQ1/zLWmi0hxIG1D7zz33aTkC3NnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlyrOd2zs7ucN4aXxrfYFQhuXfjCkmskyVnzDLCNRaI=;
 b=irCAu8nYFBGUQXjrrSsPIZMyu28zEbE8bido0gcJEZm8dsBQnSEZ6VP9ZM9KCU2HZ44Py84ENQfwC9ZOW3gWNOk9amcy26yomRej6ia0icnT0LcnKa1pV8PAuFL/HuG2QqN3f7puWzw8ABKS90QoJ4ToOyAO1LQLVGAc5rmjV84=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4667.namprd10.prod.outlook.com (2603:10b6:806:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 13:46:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 13:46:14 +0000
Message-ID: <7944f6aa-d797-4323-98dc-7ef7e388c69f@oracle.com>
Date: Thu, 12 Jun 2025 09:46:12 -0400
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
X-ClientProxiedBy: CH0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:610:cd::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: e10fa79d-6d60-4bf0-4f69-08dda9b77fcd
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?b0FWTlh4NVQrNTdyS1ZjTkswRnQ3blg5T3ZjR2xpcGZkUGVscWc1T3RCVW5J?=
 =?utf-8?B?NzFoWFlpaXZGdEZYZXFqUGtSUmZlMjRRejFsbGNqUVNXQWZZQzB1SlBBV0JM?=
 =?utf-8?B?N1lJc2RiRTVUQndzV3FYOFVZUmRXR1B6RFdzQ01EZWwyRlZMMnRUYVkyL3Vh?=
 =?utf-8?B?R1pRb0NTSmxSSTJkM2o1UkVBUFpCTFIrQWJsWk5BL28vV29Gc1hLclhUc1pB?=
 =?utf-8?B?MGo2WnU0eitGYTd4VkU1RWgza3JSaVhwK00wRkNNOTFEUDljaDdYNXhvaXF5?=
 =?utf-8?B?bVhvMWY2dVN0STRxZUFIYkM3cVFWU0pFUVlzRVBrV3F4TVJ5c1Jpc080Z3NG?=
 =?utf-8?B?MW5LWE04Qk0vVkl4YnhpL2tZTXA3UVFCWHJsUGRsVVkrNUZmQUI2RGxoaFI3?=
 =?utf-8?B?aHVrZG5zeWZOZFEzMy80anRmQUxhQ3Rzdk1ieFl3cG1HVmo4UjlEM2ZJN1Jn?=
 =?utf-8?B?aWNYd0FJVlU1cmppRXV4OW5oRng2anMwSGtacCt4MTNxLzdKSE1qUXZtK040?=
 =?utf-8?B?WHU1Y2VGeVZsVFpUNnd5cmtFblZraTJFYlh1ZzMyN2x5Nms1NjBleWN2V3hx?=
 =?utf-8?B?dHAyOTRlZ0JYdFVXNzRpeU1wU203aXB2RkNlL0UzdERKWndmSUN5dTloUHhu?=
 =?utf-8?B?MisvcStwSDRKM2pJS0RscklidTZ1RDd1T1BNNStOT1NzaVVpV0hNSUo2bFRZ?=
 =?utf-8?B?TkFXSCs3eFowN0R1Z1hMZ3l0TjNaQlFWdWlMR3JWNzk5RUFFSVc2SEVwNnNq?=
 =?utf-8?B?UjYwbSswZHgvZFIrWU9LWWdub21sSXFwNFJMNnBNZWVpeUFuRVFsNXBoaWpM?=
 =?utf-8?B?VmV4L1dKc3c1OEkwbHFlaFdnQjlkU29UTTN5SGxqVmloTEI3bmxzczBPRzBN?=
 =?utf-8?B?eCtLWW9NdjNXcnJHWC9BYXEwcTJEaWphOENTVTZ6RFRqSER3dXdSTEZ0MGNT?=
 =?utf-8?B?YVlxNzZCR0d4MTFmeFJaZ3AvcFRoZGxuQktaaVlSb25Td0Q5ZkdkdE1HVnI1?=
 =?utf-8?B?bVhPcU4wZko5WUM1bVUxMUFxYjRqckNLdkhoeFJ5c0lvaTE4QWk0Ty92VGpO?=
 =?utf-8?B?NEs3dVpOU1hlenRtTm5zV01ScjBTTG1hQmJNRk5rQy8rTEdLVWJLYzl4bldM?=
 =?utf-8?B?M0l4RzhraXg3L09VVmdCSVBJZVBQN2lNZzltZ3E0TlQ5c2JmWXR3MkJMRHgr?=
 =?utf-8?B?aWhhWWdWclU1NVIwRjk3WFpmNHhrdVJXUlFuMmwxNDhLRWx2MTJhRkdYV0JG?=
 =?utf-8?B?YkVEQnZEaXNzczVtVmhCVlVnTkF1T2pHb0lveUlpN0h0bkxTRjV0Q2hZT3JI?=
 =?utf-8?B?c3J0anR6ZWdhZGIwVkh4OVJpa2tPZlR5RllrNnExbWN3UjV3ZllmdG50SkNW?=
 =?utf-8?B?ejNrc1VUUTBOMStsK1RaaUFXZGJDdlZ2WEZ1WGhMYmxmcEhTUlM0RW1udkI1?=
 =?utf-8?B?dGsvU2dzeEYxUVBiSTRRWFRFRkoydVpIVFhTRnhyamdmWTN3aFNWb21BVFly?=
 =?utf-8?B?YWhkOFJNOWRMczhoOXRHNWZqcXgvaDFsb2thLzNmODRoUEtid29jdUVyR2Z6?=
 =?utf-8?B?a2laazk4VWZMVmo3RFYvR0Y1a09BZ0tSQjEvWWd0eElaNDBoRTFzU2UwQ3JH?=
 =?utf-8?B?VWRGMXZGQ0lTbk00aWd5ZkhUK1JUWWtubGRpcGNKUEcvV0Q5RG8zemE3QmJL?=
 =?utf-8?B?N050bTBCa0ZqUE05WmxYL0pOMG9kaHZ3dnhkZWUrWXlMVU50UTNjUGRUaEJh?=
 =?utf-8?B?S3lidFR4QXYzUXlkUnVHeFRTSjloeDZacGVuZlcxUnhqUi82NGdHYlJNbmty?=
 =?utf-8?B?TS8rMGVnaFJKbC9aeUROelJySWZFV1MrSGI3cDdxRGdTeDRVNm9Gb1o0dTVm?=
 =?utf-8?B?dEVVa0ZUZDhmTVQ3RWVJVjFKaEFNRG5TdHpkdStMZnBzUkJtZTdJR0NvN1Zp?=
 =?utf-8?Q?hcssgguoKLI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RS9DU2dqSVhpdkJDRStGeUxra1hnakVhUmllUlFhNm9HREN1dVpsTHhvOGc1?=
 =?utf-8?B?SU4rMGE4UHFoWlBKL2ljV0ZQUU5QSE1PMXZ1VStCTUxrbUw1am8vNUJWUWRC?=
 =?utf-8?B?ckdsZjM3bmhnVnNCK3FRSmJDZHNZdkF2RG81WXNLU0dNVHlGanpXVng3bFJa?=
 =?utf-8?B?T2R6MC9wVStXcmZiZWJSek5FZXV6UnNhUDl6K1BQVDRBZTNoNEhyWlZTR2l3?=
 =?utf-8?B?Vm5aWlNWeUV0b0lpVmxqaU5QUkhpZWdOWFJLMEVBOVFwbk1kOXc2TGxxUERY?=
 =?utf-8?B?S0gveVZMSDVHdkdQUjR1RWc4Y055V2dhWHVCM2VwUXE4TVdMMC9FMFFmR1lZ?=
 =?utf-8?B?Uzgvdjg2SmFqVjNvTHpxOE8relhGZnRZUmhodXpYVDA2dTh0Y0krM3FoZFJQ?=
 =?utf-8?B?TzdOZmpYdnFsdWdGUnVPanB2dVdRaG5TdGRZSWsxQlB1SWtEekQ0TVRtV2VD?=
 =?utf-8?B?UEczazZhclc4SDFxb2YvVGFHSW1TYy9HUjNvT2pyZzN6bDl6OEZKQnU3TnFC?=
 =?utf-8?B?bzJQT0xES3BYREI0cytGaytXeDRCaWszREE1OHlNOFNkZzRNM1NYc1pHcDBH?=
 =?utf-8?B?ZWdEV08zaFR6RWdDTTNzdEdJaG1QdWRiampmbFBFeFA3c0taRko5eTFyWVlj?=
 =?utf-8?B?RlduMjFUOHcvWTM5Nzk0Tzh3ekRGbzMzMXc2eFhCb3MzOE16Nlp3VXVlOHhU?=
 =?utf-8?B?aForcDRSUkhGRktBUHpnNWtxOHlBTDBKUVhNUkwvaFFVZVBTQjZ2ZTNBM3RM?=
 =?utf-8?B?UlFTWGhmUWRocmlJVGxsa0cvUG1HaGRmbDVvc3hEbDdTU1lsbTRaT2tjYVRn?=
 =?utf-8?B?U1FoY0p5bm55bDU4bHdIRi9MZERjSEd4MXpMNU14U0tPQWJBUlkwK1Y0RnNj?=
 =?utf-8?B?eC8xdGhvRUZKN0xYakhsL2srSHp1UEZ3N2dzMTNHRisvVVJ2WFN4WHhHQnp5?=
 =?utf-8?B?ZUtvZnZpNm5sTEdBSkdxWStJZGRwcC83RXBQc0Y0NjRtMTl3bGoxb1p6cXFH?=
 =?utf-8?B?S1lrWWtQaWg1VzN4S05YSHhFR0E0R0RxL2c4NFU3WnlvRmtIeU1VZTRnV1J5?=
 =?utf-8?B?WEo4OFlBTjM5VnE5WTFCamZWcWVpTGJGTndEdUlQQWE1TUY4b1ZNQUpDSXJs?=
 =?utf-8?B?UmZsd2Fnc3RrekkxbHpVNExZd3NxTXdNTWxBNHFoT2t0VHR0U0VQS0YvWENX?=
 =?utf-8?B?cmxqeHRMSlIwMjY4dWNaeG0wdlZjeEtLdnVZeHA3ZjJxMnc4YXVYTTU3elFt?=
 =?utf-8?B?TTRlaGRIV29Ld2licmNIMUdPL1U4YUhkRGdtNEhHS05GSTI0SVdvaGlkaEll?=
 =?utf-8?B?eEtnbHprVVlrN3NQZWRXbjVXTS9uWTBjMEFkQnRhMnBmdm1PbVM3bVZWMzAz?=
 =?utf-8?B?WmRGSGQ1MFhlOFFmUzUvU0NNKzBtME1naEk4Zm1UcGFFektjY1JIUG5iQlo0?=
 =?utf-8?B?TE1vdEt0bDNVU09Udlh6TGptb1B0MjdqclQyZjMvanlWY1IwT04wQjluTjh2?=
 =?utf-8?B?d25PUUtKVnM1WWs1bWM4T1FtRTFHTUg0Wkl1NkpzdzQrSlptZUtZVkNYb2Zr?=
 =?utf-8?B?MXh2NjZlVitpbjZQa2c3QWFXRXdCWVZYdU1LaGk5R1VuaWtGMUxCRmtJeWx1?=
 =?utf-8?B?Q3ZDaGdnSzhkd2k0Q2ZYOFgvcmlaRzFpVEpQZUIwb1RMZExiSEpHeER0bnhK?=
 =?utf-8?B?S04xb1NKRlhWSFJKN0lSS3VaY3h3QytoVlNsWXlKUU1mMDFoMmZ1ekRyRzVR?=
 =?utf-8?B?TjJhSCtUbDZQeFIva2hkL3BwYkFIeXZoOTU5Ykp6UDA0MHZBdG5WRVVHSGtJ?=
 =?utf-8?B?WEZsUHY2NmtBdjhMQzRRMlVnZzM5MmU0Vy82ODZRT1Y1Zno3N0gxZFRML0lM?=
 =?utf-8?B?NEMzaHFpcnZKZUZ6QWg2VFZPakt6VnZQd2wyQlRXUk4wdVFXODUxajlUY0dV?=
 =?utf-8?B?ZUZVbFg3TmZXZGZMWHk2VTZzSjA1OWwzOGNOUjE0cGlWTHcwazJqQ1VHRmtQ?=
 =?utf-8?B?TVlJRkJFYmx0N2g4ZkxiVnZ0ang3MHluVy96eE4yanVsck9meU9xZzdFOHl3?=
 =?utf-8?B?ZTBaM3JJaVFxVDRLY3pOT2JBM3BkY1JWUzE1NFhpM0hvYVNlNHFXTkdURVln?=
 =?utf-8?B?MEhWZStERVZLRUxncDIyTmNldlRVZEFGdTd1QUdmQ1h5TVJjZE0rN2dwY1J1?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xRnELdmVH1UM8BguZ5+YTc3aTdL77VQF4mhjWUK+ECvj7SqRprAmG0VP9xVsgND+evl5xeoZ54EwrpztNZ8fj3rbsA+p7MvB/RWfSaMeUoAbrQCPQSkBvz2MuOKMFOHFKdiKkkNFscl/P9D+3LWHjKfSeQ/Y1WrR3rt2POFwzh6cKVfyv5dboSmNuKxf2xa6WCgPSFPxGd8S84ishEzaGmAJfR8Gw7zwqsPhXEgPasNqdVGOoGsX5K77vlmDnGc2++aikyC+2YepaZv9jvYMLG9rqRPocTk+554wbWkjf3MlsIFaqHIA2UbnXXIVOtb1H2aoUmiorkDJzPR9jX8mfOiDpVKJcr70V1sFf6xql3zNe8ppjLn1yTMyqHudS1XKKOKE99tpA/SGJiWgPCKhS1Sy6OWqBbDmMvdV3U24mRLOGHICoQqenqyuz41We7QhQaos3gx/EmZftH8Q0zcPpjtiF2N8reARfbF2M2KQ9G3D4rIoY9yuws7KYEkztxsNetgo/LkK/piC83fjAMqo/q53ML9vnhP3/zPK+Hnx78ne9VK3o4rImS7H7MeQLXI2XWaULGnrWo2aI2aOB4VdViv2nWD4LaRwSCDeL+tr04E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10fa79d-6d60-4bf0-4f69-08dda9b77fcd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 13:46:14.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MxUyxqqKhnZc7kfNzNm83AOXdS7HBq67N0uw06ad3DUrB6BbuH0rtWbLH2oYszwPm2+iLDRL7P9b1ykGHYOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120105
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=684ada2a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=MmVkddRvAAAA:8 a=WkR0Wmi6DWqSYiukBgIA:9 a=QEXdDO2ut3YA:10 a=sDnPZfDcMZJXlSf2PV7B:22
X-Proofpoint-GUID: 6515jMPQfaUdRDVb4Zj97DVso5TaFkZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwNSBTYWx0ZWRfXwhMeaunK0Z3b kQd1QLOhfvds36WK07D157V/ew0OnS+vPWd+I9u14dovQ/fG7/CyPLcWr6I+mH0B6Ep/r3qgyVl Mp3HTRj/wNnEj5ZQwfwWD/12C0CwgOmwdBk0LyWu6UNBgAN7kIFEMKoi3gaiV0M7c128uf6R2bv
 UGT6SxnK35hqFXk+f+W4rWr2XqCOfBbygNhi27JMxdWICxSMZxr6rxwg6BAsp3+leR2BIwe8BKC bBhRwit88rwkNhpIUQBaAHAO4Lh6T0NRL/OcUiITNnncqBa1XXeNTojhwdMpJZ74ym7LwwLuKh+ NibJ/flJwPYlJMCB+7gXA4jm2fYC1bJt0H+7eqBLBOY3yPnLbJ/GjXyg97mhqmQdN3eeem7477/
 nUQ+oOCm/qtoOIQNT7qvjIPfZiKOyW/pvcbU/EPxcIkvOSErInVJU+N1vQIIP1lSFLoU+nS0
X-Proofpoint-ORIG-GUID: 6515jMPQfaUdRDVb4Zj97DVso5TaFkZZ

On 6/10/25 4:57 PM, Mike Snitzer wrote:
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

The IO wait and IRQ numbers for the buffered results appear to be
significantly better than for O_DIRECT. Can you help us understand
that? Is device utilization better or worse with O_DIRECT?


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
> - ability to support more IO threads per client system (from 48 to 64)

This last item: how do you measure the "ability to support more
threads"? Is there a latency curve that is flatter? Do you see changes
in the latency distribution and the number of latency outliers?


My general comment here is kind of in the "related or future work"
category. This is not an objection, just thinking out loud.

But, can we get more insight into specifically where the CPU
utilization reduction comes from? Is it lock contention? Is it
inefficient data structure traversal? Any improvement here benefits
everyone, so that should be a focus of some study.

If the memory utilization is a problem, that sounds like an issue with
kernel systems outside of NFSD, or perhaps some system tuning can be
done to improve matters. Again, drilling into this and trying to improve
it will benefit everyone.

These results do point to some problems, clearly. Whether NFSD using
direct I/O is the best solution is not obvious to me yet.


-- 
Chuck Lever

