Return-Path: <linux-fsdevel+bounces-23272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D31929D33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 09:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215F91C20DD6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A152224FA;
	Mon,  8 Jul 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TPuMB+2V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="djXXmJ9s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25420DE8;
	Mon,  8 Jul 2024 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424242; cv=fail; b=KWUqiku+JxhBHohrz65T2b0EJWK9YsFzb9ObVCGFauVlYThoLqPC5vwWY582zzvA2GZYuHHwTkgKSgW4o9HWWbl5ODSzLHAm62clItfXaHb1gkjO0uqT7csBhgDDomI9LoBRBqSu1x4NZSH6LwpdozhHzLao1ywPn50dYuiGwuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424242; c=relaxed/simple;
	bh=0SzBRZN7QHrk444w9QaofqvgJ8PRcZEekJGaIHU82NY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+6s+o2GHYVn4bUW2rMr/QOmibUYBNM4XUXCRf1eDm9bGrt2odMPzOok7aq4MmTwCYqexHQYN69jEmkwsDGuFngzB6eao6bq6DARPdy74BByNcke1fY+i0EIOQndRzRhR8VJ6iDjBl3tBqTyaQVX2K4KvL2PeoHQope6TK00ddc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TPuMB+2V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=djXXmJ9s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4685idIk028966;
	Mon, 8 Jul 2024 07:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=gyV9qsk6abloR4rwfJxL4uh9giZemdEaiKDnDdRrGFQ=; b=
	TPuMB+2VX9jVZ13V49VRrUnuN60crmSPWbSSn+xz8FZdFLsRMDYyp44omZUmW1O2
	wM7p+8AuAzwT2mCD8hUuEZ8O+XuT9akifSwuwPFKv4K/JEGnwJtncEdZrgMBaJr8
	3+4qFfQKzLTPdOS7TqYNMBRHeF4zvh4QIPXeHw/CxkxxG4eR93mdT5QynJY9OIEe
	qNX9aR2sVGppoPbsZclP6tM2THEXCbBz57jQlrGCzUm0pNh3zh4Tmew4G9Paazmq
	4SGOKvr0NhJ/z2K7v32dSWQjuBC+Wc/lx7CVWvXNvVBI58dCBDCoZasIJUxMAL8h
	H5+178pcQKl40Q4E9vGGGA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgpt026-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 07:37:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4686Zu83038098;
	Mon, 8 Jul 2024 07:37:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tuyah6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 07:37:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYvpN55shMqLbfn2+k1Db4KWTjzCjNERaI4y9i0SAJAWjTr8wq118JGMU2fKOcJlk9b877aZDm7gvN9oZlOC9qNPSikXfs4oiY323cKRVglsVv1nJrX6T2peNu5xBQVdKGfsip2VMxtwUkYSN+eOkmxzdkJ5BTKg73dqe5eCJHgWuTt/t2QIORpXTXFJqbQadFzNyCNZAdu2yX4UBByGHj00CVsO3uUNOJ1jUGB0TW54B2hqzTn5izfSKNtWZ1WYYdK0TEiSLKglzvh14+3K3m+xB5Zo3zcRryyfyhwB4dBOMcGzkM1F9q9N/pm5TOKvKzZm4ibuTE7TG+7TYKQ0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyV9qsk6abloR4rwfJxL4uh9giZemdEaiKDnDdRrGFQ=;
 b=cXleUK+oD4Mah8mvtDxTcTshSxfYbf8ii5/rss0TM+C1Ay0coVnkb4NWO9Vv/jrX/+MI7nGyFQQWUbLirbNoq2oGfBSyZSUoNdCZ7BIokBf0IXYkVS3fPLp+kZ9LCGe5PXXuHE5iEsO6z98u7Am/udViy/X3lPkpQ6lzMtYxGcWjryTbuqlsrQWUlPiW2AFF7rK2nXPeWyHDoHZjO2UUR4xiwxtcX+TVFxi0ZKcYGh5VwNZURpM72J3DAQpBWjUOFu/qdI8WrloXqq+9WPtaywZ+9Bh2/Xp4rxku/CFzEbX8Fo9oowWrO9N/aWTGubW9h63M+S9AGLviPyZ16drOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyV9qsk6abloR4rwfJxL4uh9giZemdEaiKDnDdRrGFQ=;
 b=djXXmJ9sJW9uxEnmzFLo7MijN7ZRtGS8rM6Gy5XZsUsDJqtl+uPi1+CuRMJf8wyWDtyi/r1CEgRRSLi1GgNjMHZPuPp5vwrGgZoZ8jzFimw3f0wl/pnhWGxjHkiw0ucziKRt7AJ2f5NkS1iCrj5TukuNACZY0BzVUAVWhiytqfQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB7633.namprd10.prod.outlook.com (2603:10b6:806:375::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 07:36:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:36:58 +0000
Message-ID: <6427a661-2e92-49a0-8329-7f67e8dd5c35@oracle.com>
Date: Mon, 8 Jul 2024 08:36:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] xfs: Do not free EOF blocks for forcealign
To: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        djwong@kernel.org
Cc: chandan.babu@oracle.com, dchinner@redhat.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        catherine.hoang@oracle.com, martin.petersen@oracle.com
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-9-john.g.garry@oracle.com>
 <20240706075609.GB15212@lst.de> <ZotEmyoivd1CEAIS@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZotEmyoivd1CEAIS@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6f2e94-c02b-4ae6-f34e-08dc9f20bf62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N3JNQW85L0FON2FoeldWWkdLRDhMeUkvc0QyWnVTYlAvdCs4YVgwU2JKbUZ2?=
 =?utf-8?B?SzFYazNRWVZkUnhibWd2dlpQcUxJVnJ0S3NSVlE5YVMvcVordXBHdXVsbm5Z?=
 =?utf-8?B?QUdXQll2U2QvOENEVzhhRzdTeUVuNWNnYW1vUWsyUFVSM1lReWFITWNML2pP?=
 =?utf-8?B?TDh1c1J5dmlCcTVPbXYrZnpwMlY4RXZuNkhYbnhoMUlxSE5wTVpjN3ZrRk9i?=
 =?utf-8?B?bTI5My93YTJ2anVKNTR3VkhzRVJUN285OGNwTVhGMG4yV2NyUS9nMXNnZTZm?=
 =?utf-8?B?OUFicVVGRVdzWWpvVHd5NldpSW5hNmF2SmFmQmM4enpqQitQRkk3VWZDOGtX?=
 =?utf-8?B?SFA5enF0VXVDTSt4eWV4YjZjM0lrQm4yYmMyN1lCeUp3a1daU2ozbE1ndUtM?=
 =?utf-8?B?Y1BLZ1U4bTB3bmszUmJERUxxR1k5OWRvS2NDWERpc2FCMkk2VS9LZ0kzQkgy?=
 =?utf-8?B?T1Jnd05lVE9Gc1FleXVQaHFqREcxWGRkclpnMW1XakxWelpXSzY2ZzBreU9v?=
 =?utf-8?B?VUVmNytyV2E4RUZnUnliOE1BTTdxM09iSFNNbTZ1ZmRUTWlrdTYxSGYyVWJi?=
 =?utf-8?B?MkZua3hhbGtjcllOOVQ2U0dQS21TdGpRbHhLTkZ0bHNGVndWQU1JUUtEN2Ir?=
 =?utf-8?B?cXJNVUwwY2o5bU5QK3dBNmpoY3oxQlRsL2JWdnFnQnJpdUhzbnhiWkZsWGxz?=
 =?utf-8?B?a1hJYS9nSGVYbTRyRWRkdjNtS1VkN3RPbDVPL0pQUTV5azQ5dzlKTlFCR2xH?=
 =?utf-8?B?Y0lCS1J5bVdxOTFSOE1zR1VKMklVaEk1NmU0NUowd2JYMWs2cGNKMWUyOCtU?=
 =?utf-8?B?SW8xd250enJURzJUVnJ3UlhSaXFJTndpaHE1eFdnb0s5dzVRMTFrNkxFRTlG?=
 =?utf-8?B?aW9YeDAzVEphNXVObFpIMElORHQ2cFNhUGsvTXFPV2tpbGowMTZPTzhMbEUz?=
 =?utf-8?B?emd4SkdsbVlqVkQyZitRR0xPYlUwN2RTUEtwQkkwQS94d0p3VFl3UGN6NW1u?=
 =?utf-8?B?c2gzWUszTlVXdE1iQ0VySXpacVBiOU40ZnJrK016eERLaVBrWk9Ib3ZyZW42?=
 =?utf-8?B?OUpCdllSWUdUL1FBMzlHaERrenRNREd5ZnhzY3NXY1kzVlRyYzA0VC8wWkF3?=
 =?utf-8?B?NGw5amhFaEJxdEhBZHIwL0prdjJHc2VKdHBaaWd3bE5iZHVhNTJ6Mkg3ZlNj?=
 =?utf-8?B?NzNSWXVud3BZckxYelY2WHQ4YWNRaTVtSzkvOXNsRXR3ZWNyTXZGbGxNZmZa?=
 =?utf-8?B?Y2M1NlBFaXdEcUNPZGJETHduekZ5NnVibnFxTFNDNTF3NDdIdC9INFNENFd4?=
 =?utf-8?B?SnYwcUpzRWZ1dlNSL2tPMmdjWHlpWWNyTUZRMVpGdVVGcXIrZDA1S3ovTEox?=
 =?utf-8?B?eEp4VGpPQldPTk1KNEt3ZUJOOTlxUUkrR2xPUjBnUi8vSDh0TVpqU1E2anc1?=
 =?utf-8?B?VmpFbGNxYVErTlBkZklsOUZHUXJVYjZSU0E1cURMMUtGemhuSHNrTDhLbmtL?=
 =?utf-8?B?aHFNSDJQR0lLemRWL2J1WFRsbkg1QWxyYXZxMjIrdW5OV3drZWFSbWZRa0sx?=
 =?utf-8?B?MG80SzN5TVMrQWdSWVpLUGdBV25vMW1FQmU3VGV0eW40ZldqNHBPanByTXUv?=
 =?utf-8?B?Ry8zNXZna1ZUL2pCLzd0UnNrYlR3am00TkFOSW1WSEUwUGF3ek1VaTA5dGlx?=
 =?utf-8?B?M3MvSTRkOVRXMzYvUTBFMUhhU3kxR2NvS2hKTUlYdCsxNGF0TTJrRzRJZS9q?=
 =?utf-8?Q?xd4s6SV0oqKxneRMKU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?azU1OTkyaUtwblBKdE1UVnIwZnZHUmhEb2VCYm8vS2h0eG9tOTVyL0hTdTFn?=
 =?utf-8?B?NXM3VkxQeUNyN0Rldk50UExBckozTFkvZUdRMkxZRG5RbXFhdW9zN2xVOW5z?=
 =?utf-8?B?V1N4SGlzVUp0Yzcya0c4Y2NESW43T1doUmtFYUpsd3BBK2ZXTkRFZWFpQ3Ev?=
 =?utf-8?B?Zjh5NG11cUN2UjVEUWhVZnZwdFg1Q01GZEtSTTIxbFYxdk1EdlVSYWQxZG1F?=
 =?utf-8?B?YXRObXZmYzYxZWRqQzJLbTdYc05XcWJDcjNmOFF2dFdiZnhRbnhqVlRCemhE?=
 =?utf-8?B?aGNBaHFLQjhzUGhURnRpZzFtSlNBVWE3R3NRT3JvVWY2R2RzdzI4aWZ6YXFP?=
 =?utf-8?B?eDE0ZU8vazZUbkdPYUg0c3Y3ek5hTFh2UWE3MkY3Y1dvUlV6Rk1KcU5NR0pp?=
 =?utf-8?B?WHVtZnFQc2Jod0EzejNpMFE5N1p6S09kWFBIVjJzZGdObFRMZVYybTI3N1Qx?=
 =?utf-8?B?em1Qd2VXNDdqMWZxZnNPaUpRV3h3dUNra2MwL0JLQlgzYUVBQXpCQlVENCta?=
 =?utf-8?B?MmNZdzlRODl0cDhQQk9pamNvblZSN1ZlVFE4ZUlPT2dCclFHSUFKem03dFJy?=
 =?utf-8?B?Y21qV3RnMWVRbzB5cXowZGJ3YzRNREN2emh5Qm1UcnAxSG1nQWh0VGRiWXkr?=
 =?utf-8?B?WWRweUQ3ZDlRa0RCcHY0K2pLZzU4OFMwRUhNeFo3OERVb1Q1SWR2WTNUVG1t?=
 =?utf-8?B?cTBIZmxIUi9STHp0aFBKRmluaDZMUTNTSEowSEtHU2MzK21Kaytod2RpMVpS?=
 =?utf-8?B?ekZ3bHdUZlEyZ2ZjTE15MUw2NFV0YUg4R0hpdnZrRGhRUjU0bGhqcDQvSEJU?=
 =?utf-8?B?Qnp3RHNaWlp5d1laL081NGp0RU82eFNiTkpaQmFXZG5tQTBacG5sTE1oWElz?=
 =?utf-8?B?dkpYN2k5M081WTRKMnpIM0Z4VUtWaXdvUEsrNHhWenpCUFU2TmpZQlM2dStS?=
 =?utf-8?B?MHRJOTJGK0pueWViaHhlUVVKRlpjVFM1THVzL0hRaHowblRnemgvd2lLZ2dv?=
 =?utf-8?B?bTdndGdSYXBJZUxkZDBhMERMaHNPblFLVG9XTjVFLy9xQlVrQlV2UjRPZ2JR?=
 =?utf-8?B?akpmNUNsc0tvekhodEV1b0N3WG5uSzBmaVFrS3M2S1BYR0E5NlBkMmU5eWFo?=
 =?utf-8?B?czJ4dmtSZEh0RVd0TGUrOUN5VzJ1dUFUUmw2QllkSjFranlmL1AyRExRVWNG?=
 =?utf-8?B?bEt1NjZHRWhrTURpOXRkd1Q2SmZNbWZjRjl6aEVCek9ORGdYbTJoMU1YZXRl?=
 =?utf-8?B?MWw2bkxieTlHM3FxOVBuMDZocFNWWFNHZ0kwMVV3aEdmSkYvU1gybXh5RURX?=
 =?utf-8?B?K0lHZG1vdXlJN2lQUzM3Q2lSR0crbWtYalQrSEtqRlVtcjFUa2xiWGlrVUgx?=
 =?utf-8?B?UDhxZzFaRkRnNFgvbkxwV2s3d0pkSEQzMXlzYnAvUURuY011Vjl2RnQvdXha?=
 =?utf-8?B?VVgra01nTEorWXEvQzhMaDE3Vld2NkduNS96L09sNU5tdHU5dEgvTW8rN1Jx?=
 =?utf-8?B?NzkwTmlyUGoxWndtZHV2ZjRUVDY5bmJhZkR3SW5FSEJHN01zZXJNcWtaVVg2?=
 =?utf-8?B?OS9UWDVuK21ycWlkWWtaR0t1bkhuZVIxQnQ3ZW41eTBldExxS2oyVVpQTzZN?=
 =?utf-8?B?VDE1Zkovb2dFSTZsdXBCMFYzbDZZNUovK1duKzQzcnF4UlpvbkJ1TFFUbFpG?=
 =?utf-8?B?TThvMWlkcE9kbXZoQStlUkUyNktGc2Q2WkxVYURuOUF2TlhsNGJQOHhUZUFo?=
 =?utf-8?B?QnB6ZysrQXJxUUh6RWN3Z01TUVJKTHhqQjRmbDd6VWtseHNub3lvUHZvNEpj?=
 =?utf-8?B?MEdpYkNaQSs3ZHdEQkVvUW1ZMTgzdWVIK0twVjc4aFFBRVZ6MlJNVzJjZlVk?=
 =?utf-8?B?eGNhVW9HZ1RicmViVmFUNHlkZ2x1V3pycnVwcHd3elBaOStJQ1BEVUxicnRQ?=
 =?utf-8?B?NTNJSm9PWmFJY3BPeHRHeVFoaHM3MThCb2hYSWVodmUvVUtoTzIzU0NQZjNm?=
 =?utf-8?B?NWp1WVJlbmFleVRxMlFCTkJmRnMzQjJqZ0FtYlZySURWVWJmL3lOYlZFTEFj?=
 =?utf-8?B?S09FQ2s4VHgxWUZDUHJLZjk0NjRKQlVpMTFadTNPZEkrNTc2U1dUY2FDUGlF?=
 =?utf-8?Q?Omv8asEXU1FlsNSGLgEYPOqo4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	64J5JYvEQpBs3cCW7I4B8JSq0xr9FqXpom7qkgLOUPVxlPOZPSZioM+aTUbw00Hj1ud+6BRp/Cv1GGP8c0GYQUCbXp85yQ9+8Sw2zpQqXR+6Se+5Pgp/gZ1IAzfPZ04yuw8DoMHHB6ZCKAc98vTflyVZY/1TEDiXEYEsSU0538xcpkYpcOtxgnSUYMnc59CSXM4Gv9QLvoXDH05SJ6bUP2H8owFPF329J96z7CdXMCzJGaH8opgw/zfDopnYa/ZKbAlhDqMq9u+gCH2iAm0tdZsjrxyuW2veZCKTjpls/NpPDFPYwVub4eGTu6tZsoW7MlwLG2utoBNtSW41zQKykuauLDCAB2k5oX08fqWyiT5aTFDBK63nxm74iDSj5FmdHHazsMNHxMg9OOBX2l5dTig9v6eFb9neogkWKjMCnFoZjTXy/ksb1XiuNVblqKHkmrg2V9wHd8sIHed+ylPEVXtuwy/Vjlrs7zayHrt4UzkRa1QtxCD6XR44Eu1lTq8ynQHzRVIyDauBqO4DXZOkQKK94C3GhH6CfEGWtOMfDtPpLd1dlcPrCbYbDc21vYOmLF0gWeBcz5kfkQEA5t9uNpk5rf5FyIEG4aya2AIVXrc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6f2e94-c02b-4ae6-f34e-08dc9f20bf62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:36:58.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCxOlh2Cs8ZWjU3Ef2znaTsUrjbfaCe+WnwM0K9L73dHx7hFTL1FtZZVKv1zmWskYeXqE64BDRguWPP0rTAxkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_02,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407080058
X-Proofpoint-ORIG-GUID: kqD-pfM_CSJKfHRZxwfEWQ6pyBJendke
X-Proofpoint-GUID: kqD-pfM_CSJKfHRZxwfEWQ6pyBJendke

On 08/07/2024 02:44, Dave Chinner wrote:
> On Sat, Jul 06, 2024 at 09:56:09AM +0200, Christoph Hellwig wrote:
>> On Fri, Jul 05, 2024 at 04:24:45PM +0000, John Garry wrote:
>>> -	if (xfs_inode_has_bigrtalloc(ip))
>>> +
>>> +	/* Only try to free beyond the allocation unit that crosses EOF */
>>> +	if (xfs_inode_has_forcealign(ip))
>>> +		end_fsb = roundup_64(end_fsb, ip->i_extsize);
>>> +	else if (xfs_inode_has_bigrtalloc(ip))
>>>   		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
>>
>> Shouldn't we have a common helper to align things the right way?
> 
> Yes, that's what I keep saying. 

Such a change was introduced in 
https://lore.kernel.org/linux-xfs/20240501235310.GP360919@frogsfrogsfrogs/

and, as you can see, Darrick was less than happy with it. That is why I 
kept this method which removed recently added RT code.

Darrick, can we find a better method to factor this code out, like below?

> The common way to do this is:
> 
> 	align = xfs_inode_alloc_unitsize(ip);
> 	if (align > mp->m_blocksize)
> 		end_fsb = roundup_64(end_fsb, align);
> 
> Wrapping that into a helper might be appropriate, though we'd need
> wrappers for aligning both the start (down) and end (up).
> 
> To make this work, the xfs_inode_alloc_unitsize() code needs to grow
> a forcealign check. That overrides the RT rextsize value (force
> align on RT should work the same as it does on data devs) and needs
> to look like this:
> 
> 	unsigned int		blocks = 1;
> 
> +	if (xfs_inode_has_forcealign(ip)
> +		blocks = ip->i_extsize;
> -	if (XFS_IS_REALTIME_INODE(ip))
> +	else if (XFS_IS_REALTIME_INODE(ip))
>                  blocks = ip->i_mount->m_sb.sb_rextsize;

That's in 09/13

> 
>          return XFS_FSB_TO_B(ip->i_mount, blocks);
> 
>> But more importantly shouldn't this also cover hole punching if we
>> really want force aligned boundaries?

so doesn't the xfs_file_fallocate(PUNCH_HOLES) -> 
xfs_flush_unmap_range() -> rounding with xfs_inode_alloc_unitsize() do 
the required job?

> 
> Yes, that's what I keep saying. There is no difference in the
> alignment behaviour needed for "xfs_inode_has_bigrtalloc" and
> "xfs_inode_has_forcealign" except for the source of the allocation
> alignment value.
> 




