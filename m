Return-Path: <linux-fsdevel+bounces-49157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E1DAB8A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 17:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B7500D11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495CB20D4F8;
	Thu, 15 May 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BzsdmDm/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rXtXXMj1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D918B47D;
	Thu, 15 May 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321606; cv=fail; b=kJr5HLldCFEXki1LZAbSfJUZt0X0D28osAx0DMfeQ+UeW9X4t4i7Vyl+WUaj3yVAjZdqPTwwi65RnNd7+Mds5044uvRSrvIjgt9ixhaW4SlQcxILrCxBHuNpOTME7EPDUSKTuKUo14hcw2VfDBkyiwd17hZu8RKluFrgOcLy25I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321606; c=relaxed/simple;
	bh=Te77Znj6axBH0x7FUGWzSF6pCSPVknEoutLh1V4zhH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=goAwZ+5IOCMmDl1oTWetClI6dhY5NnE4agSsFmtpajfu33GQx4H3eFcwRcsDfm3bP7V5m4HzzuN1ubkwRfJW4O7NZY0QQKrIJI1FwO7M0UJ+MFqukAtuwgV/ZjZ/E5D6nqsO+HJh54h7k1mWcyVFIsbXqsRGtqHMM2pCW57MRv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BzsdmDm/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rXtXXMj1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1lb1023104;
	Thu, 15 May 2025 15:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=d4ACZbLoGAB/3RpkiBCgGLQ2j/xCkC6HsKH4qNBo0io=; b=
	BzsdmDm/1W7AYNhEj4xh3lEodXhQg+qPO/9xMeNVItVXA8o/7Xvi8u+SLyltMpmm
	trtPBlqUGkGKGdlQcg0xDdQ5cdWfyCIy1hA5/GFWCwcUHTKIcsWaU1A3r6WcAExt
	M3TlojnNDU0dH+Wsf+aub5UTOiWfKz6KIJ++pEdY6H1OzgqRsQ1HlllAfuzdoddk
	ZOYTm+4VKjoBP5NfmcffZbP4OOEcswXmXPz2ikyVOkU6w17DeMI5UV1gD/9X6gMj
	2vmvNvPq/0vxRru/1tqZeYZt8HwqCDQj4bdx4V4oenOw5lDuX7p4vb/C7RPJbdmA
	KZAG0w33HlU6QhO3g56QMQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbccvf8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 15:06:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEvSLT004664;
	Thu, 15 May 2025 15:06:29 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013076.outbound.protection.outlook.com [40.93.6.76])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mqmdhks1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 15:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4oMFGy5lMysdJUSLUm7KvCnKmhF7ZxC39NgYprMK7lfcfjNJ8Wg/TI/a65VZsY1nmwLjaNeAQEvUhMUPWAhD2gU1LkkLwVxbE68oZ5vEo+DkLZKxkU4lxszD6F6/rXK/B14laKe/KkuQYcIDihNajl1M6eBtkgkbQGRvX15khYMjpk+ZJQm/nbR/xB3Y85OzTc0JZLAtAkJX9vF/z07xJI+U8k04olvmEZFFjpUwrwAu5MDzE79qVbbaYuCuCsd5z/1XVTvW497qakrjAIPm424vwIb0hAakXKA4Lt4dz9GF4Fbvfmta15utaaZJXSay6zSRVxOqlZtCXMF8U1yUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4ACZbLoGAB/3RpkiBCgGLQ2j/xCkC6HsKH4qNBo0io=;
 b=Qb83dPvEGa8E4HRm2RSecyRPJT7ITZbg/1s/qY+/MEBKkHNcmQrKqGJfCF3CcZ9fEGaGNemE0I4E4XSXiP5ZkCzsZM0Z2tOpGQA6m7qXwUwMdr0tp5Cu4zvQT6fZnqWbFhftqcWEm7a7MAx/4fVPLu3eWu17OsUMXFNEomyG9G1LCX6apGlWm0BoISfPrYFSp/F+PHwBczbj87YWDd3uIkDJr8HvVFh23TZ08UMGJ8oklLC2svY2DKL9LCF10V2HjqEdvGMWtURXN9buGwlBabCLKvuZkCPLFEFDodE98yAYAC72zx5upeufDTluuf8VRpPenpVuRzSLChtst3szCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4ACZbLoGAB/3RpkiBCgGLQ2j/xCkC6HsKH4qNBo0io=;
 b=rXtXXMj1E/7XME+c6EXC//ih4F7KjiVI7fX+E5bcEiDd649ocyJNmFmNokYyiW/S/LI3wQEoPx6TPfXGw83QhvQn0L023syzfu0a/kvz33DcAQaE0CvrxA47bNibZlZXgxWLm0oyUzCAbB6eAtLutWIlrlrvYh7T5gKOBB/o370=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ1PR10MB5977.namprd10.prod.outlook.com (2603:10b6:a03:488::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 15 May
 2025 15:06:24 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%6]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 15:06:24 +0000
Message-ID: <4dcf783e-c79b-486a-b4a5-e35681cb8306@oracle.com>
Date: Thu, 15 May 2025 11:06:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] XArray: fix kmemleak false positive in xas_shrink()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jared Kangas <jkangas@redhat.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>
References: <20250512191707.245153-1-jkangas@redhat.com>
 <053ad5f9-3eee-486e-ac29-3104517b674a@lucifer.local>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <053ad5f9-3eee-486e-ac29-3104517b674a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::28) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ1PR10MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cba5b6-9863-4112-9428-08dd93c20ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0FZc1VodVRCZTR2ZzRLRE8yeUViL3IwZWZyY1A5b3pQSzVsSUI3MGw1Q3Nx?=
 =?utf-8?B?MzcycVRxcTZCMElsSXRSYTA1SFBHMWlNTWd6bzA5Qkl5QzdGWDRGV3JhbW4y?=
 =?utf-8?B?UHZGZzJOSGx2NDdBQ0QrZGZ1WXJXZU5WVDFjeU42c0JPWXhvKzV2QXVHcHhz?=
 =?utf-8?B?ZDRzdUZhcGw1Q2ptYmllekdFR09uZkV1ZTNacTFHYVBlUUdXdGhtYUFzeGdh?=
 =?utf-8?B?ZG4reG56NWNMZVA5Tm1RUDdpT1IyMnlwVFdhdkZqeldBTU1EdlA3TnhjNzM1?=
 =?utf-8?B?ZXBhaEpOQUsyNnhUVS8zN0VJaVppaWJBQmNWMlREekhBcllRVXNnZUpCNXZ4?=
 =?utf-8?B?TnE1MnJpNVhOQ05EVm1LMlFSM1pVNG9KVEx4L1ZxYnNRUENZNWFFZERQWC9z?=
 =?utf-8?B?NUEwd2dEblpuZWsyc0treFVudVF5UHFlUjJySVJqRW5zSExTT1VKMk45Uk8w?=
 =?utf-8?B?MGlpbGgvUFNYSHRDMjhZZ2VXVWRsY1hpL28zcGtvUndibi9DNlRQS3QvWnpp?=
 =?utf-8?B?RHJRQU8yZUpBVnpSbkdQSExZM2dLR1hBZFlXS3lnTkZDRnNQcWtmcE4zNERJ?=
 =?utf-8?B?OEdHVDhiOVluc1ZYU1VBMXhrS0ZMa28rVlpQYzQybXhUbGI3bDQrcWQ5bHhJ?=
 =?utf-8?B?emdvOWZydHpUaDZ1N2cxYWRqc0l5OXJVdGJVRDNFeWQ0aVlWYm5vazR1QkVu?=
 =?utf-8?B?bHVrRmNjTmVLTDBNVXVNWU1hYkxlOGNqRHRqd2gxSXB6aU5nU3B5OE9FcHUr?=
 =?utf-8?B?aFFUR0xEWDFidzFWbTRIdThWcFRtSmNtaFFiR3YrSkhpYk95QWhFb3E3OFhv?=
 =?utf-8?B?ZXE4NVI3MnBQUW1sbzRNZU9NTW0rZ2dZaGJOVFhuaVhpR01TUG84OTMzV0Z2?=
 =?utf-8?B?Q0p6MTJVVlZRb3k5Y0dMb05yRUhHc2RNV0tUemZiSnFsZUFVNzR4Nk1WOGh1?=
 =?utf-8?B?cmgxM2o5YmFYalYvWkFUZXZvTmI3RlE5R284R0sxemMyeXpWaDFLZFJsMkoy?=
 =?utf-8?B?MktXaFdzODBrWWJMVzM4TEZUVXJIaG5TaHNObnhoam42eTBUZjR3Mjh2UzRV?=
 =?utf-8?B?d1R6cTRpbnU0MmQycHJKell6V2I3ajVrdTkweHBkMDQ0b24vTVVrY05DZUw0?=
 =?utf-8?B?a1ppeWZucXYrbE1wa2JpcFdOR1FwSVMxV2NsVXBqM2RBd01XNmZCVUdKb2pD?=
 =?utf-8?B?UFZ5U1BRUnlOekJ0L2JCMDE1MGhMcFNiR1puTTNWblNMOVZEMEFIalVNbU1U?=
 =?utf-8?B?MnpUVkhENDhnZW41RXVlNU1CS29BbVdJTTdWSUlvL3M1VW10QlJtQVRDWXZx?=
 =?utf-8?B?THJnbEdvb3RVazdJRGJYekNCZ1hZZW5XdU5CSEtxbGVwc1djZEdDT1lRM254?=
 =?utf-8?B?SlFMcjlsMmwvckl1SERsdTFlTDZqTTUwd0hRQjBPRFcxOTBobTlmWno2amlH?=
 =?utf-8?B?ZFd5TnUzL0d6cEZhdk9RbEFYTG03Smc5NUZVaFZwejVGVXZ1YWgwL0JpWGtx?=
 =?utf-8?B?T1hBR2Y3cDA3bzlibnNUU0hLaHBBRU5paXJ2cXlrd2tibUJoVG0rL3E4dzl5?=
 =?utf-8?B?Ni9ueTRDU215clc4Q3pYWUVYR3c0NW9YcmdGeGt0dGxpcnlMdm1ydzMwWGo1?=
 =?utf-8?B?MkpIVUo3cTlOYnpSd2l6VUU4UVVTbitDNUs5QXRzb0tjNmJTMDkvYWxYNlRu?=
 =?utf-8?B?ZVlZN1FDTnc1cE1SWGpOa1hSM1FMUzc0aUVYY1ZmUkd3LzZlVGlPYUZTZUZw?=
 =?utf-8?B?WCs3UXRydk1jZFRjVmFnVGNNdkZJNHlaQWJPeXBYSSs1MTdDL3U3bEw1SWtJ?=
 =?utf-8?B?blIyNlRPU2NkWm9aMkw2bkZ5RG5DVFluZkgrczV5V1BHRndSYzJhNGowdmlI?=
 =?utf-8?B?eUs3TVk4SnphU243TWlBRzdUVmR0ZlRlaHEzZVN6dUQyeUtTSkNYNmZrM0Yx?=
 =?utf-8?Q?m6glKZV7MCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N05keDlUYzlhSWtCT1hRT0wxalE0VzBucjFCN3hQMEhUeEM3QU1mdDlmNDV6?=
 =?utf-8?B?WFYxME9iakhWcFRuNnZJNGMvQ0treUNIUHhPQzhFZzYycS92MjVFclE4MXg4?=
 =?utf-8?B?UlZPWVkycVBPanoya0pIUFRpMWhXQnZlOXBIZXp3T3pPWXpGaWl5MGFzU1RX?=
 =?utf-8?B?WVVoa3RvSzJlOXg3TlBxemp6QmtoY0x4RzV3WCtGU0dSUStXWFNOa2ptQzAz?=
 =?utf-8?B?bnk2RVpKbnhqTEw1OVFZWktlVVJiUWhCTUZFdWtEVCtFNEYwVHRGQmN5ZVdJ?=
 =?utf-8?B?c2hCLzlodVd4Qnc0bjRlOWVadTlCaWNpaW9iVzBNaWNiM3EwQVhUbEZCTzdB?=
 =?utf-8?B?MTVOOEpYNnkxYksrenArQU1rUVBudnNwakIwWGNnbUJXdytLclRFaXZVMUV5?=
 =?utf-8?B?OTVIc2l1aFFtbTBlSE9ndGR5SGlPL2ZiYVl6VUxmZGsraHhQMy95ZTFZMkpJ?=
 =?utf-8?B?bzYyTmRlSHdmVmJEVFd2ekxIVTVBRTBHUU1pOENETStCOGpxUmpBNFNRb0pj?=
 =?utf-8?B?WTFjWFB3NC9oY3Fac0Q3dndlY3lJN2hrRTNzaGZqOCswekM0d0ErRjI0eTR2?=
 =?utf-8?B?dE5ISVZXd2RXY0FjN3U1K1lRU1QyczNZZHkzZFNlSVlRQ3IrL2ZPK0FWZGZH?=
 =?utf-8?B?cFlVQXRuNkpUQmgzZnhCWnJEMkcyZUFTK1l1dmJXSkxtZUxlem5VdVFaNWpx?=
 =?utf-8?B?YmxrdHNnTkp1QktRQUhCMFFMTUxJY1VEdFZRcjhDcXpsWDQ5cllTVDdhbE9P?=
 =?utf-8?B?WHREbWNZWVN0N2w0YXlJQmhxOUNRVm5rL0JQa3EzSTNGaHl1V1V3NWJ4ekJW?=
 =?utf-8?B?ZTIrY3hkaVVlYWxPYzgyajVyMDcxa1krNUljcm9GcjhSeG1yUFJSUDF1SFI5?=
 =?utf-8?B?ZjRyNUdkekxLK2pHazdTcHlMZjlKNnc3bjd1aTVCZEIwSmtjUmU1KzlpZkEw?=
 =?utf-8?B?V2lhbXlxMHlLQVVWWVlLYmdKMm56YnJObTFtN1RvbEhMQkUxMkhueE5ncTkr?=
 =?utf-8?B?Vi9ocFg4aU5mc3ZuclZEZXVlQlp5cTdkMjZxdmxTaUdOSTdGeGhMSTAzTzUv?=
 =?utf-8?B?bWNmOVZ1dDMra291aTRmcUJzNy9WSTlteGtRQ3BZUHpvZ293eHpMTXNpZUc4?=
 =?utf-8?B?VjNIOXpnWVJIeU0wS0lhV2FlU0t4Tzg1VXZIa3M1QXpUeCsyOHVycTdPOG9G?=
 =?utf-8?B?QmorS3RZZGozR1B3VW02RXU0aWdFNkVzdkNDMHk4NDNQOFlMTUZkcS9UNjBC?=
 =?utf-8?B?dVhZYkl1eVJtakVBNG53SFVLN2xmOS9adEgzeFpOWkNvUXloVVJJcmNKYXNw?=
 =?utf-8?B?aEZZT2xXQ3NzTTVXUFZhTVBSelJKUDd6VnUxYUQ4L2JjbzAwYkZOZHBBZmZk?=
 =?utf-8?B?WmE3Vk4xaC9Nem8yY09ZUEZZWkJoczRYY2dmb01ZcE5qUTFuZDdFMTRYd1Mz?=
 =?utf-8?B?QndSbG9IbHNUOUZiN0FqR2FzYlRrdTVrQzN3NmhhVW5VTmpRTlJod0R4aG16?=
 =?utf-8?B?V200eVo3Q2RpdnIyNFlPaHNiMjBVcEhDbDBVck0xS1UrVXpnelRZNDJzUWVN?=
 =?utf-8?B?UGhrWWUrSGRYeWdDaERNUjFRMkV6Q0Y0aGlhczhVTW1QSlRtZWZFRDF2Q1V5?=
 =?utf-8?B?dHBWK3dQOEM1T2FZaSs4K1BJdTVVdFRtalE1Uy9kTVZkUnlYc2kxS0IveGYw?=
 =?utf-8?B?QU43RWluWHpJd2Q4eW9rMWhOREFNRWZacFFHZ2JlZWQ2TFZjcVhwU0g3NG9i?=
 =?utf-8?B?R3l5WmRTWnpkWXg1dmVVU3ZJczNWUklqeE02MDlGbmJjSjUwekJGNGpReHNV?=
 =?utf-8?B?dmd0RjFLREpCcW5LRUl5VDBKOTJmS2piYkgwNlE0RmxaWmh5V1J3WXNIK3pj?=
 =?utf-8?B?RzErdHNoMDM4b3BPQzNPWjVQTzQ2WWpZakVib2FHVkNsUXpneG9aQmhLVDFQ?=
 =?utf-8?B?b1ZJdkdNdkFNOU4vM3hPbkFobTdTb1FsZFhjdWc1SFNGSEtqN0czOXlnZk9k?=
 =?utf-8?B?WVp3WXdDYjRIRzNpcjFsZzg1azQvYVNjSE1iTjA0bzk5T0JBQm5nbjgyUXNt?=
 =?utf-8?B?c2tCNzNiRkYzV2IrUGdLdGdIK3NWTXpKYVNxVVdCbzJieWdpY1RrNnRXNk9U?=
 =?utf-8?B?K2hGdm5LZXR2UEpwWlkxMHc4QmVScFhrdW1WOEdFYzhDQU1IYkl5ZURrOTJD?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yBTdpXW/96TEq4h7xvaAXx2TkouZPa1wuY1U0M79Z9KRFnLszl6JZx6zWn+ZIUa4G9gnPD9cDIi2LsNMixKpthtV6y2KZI3sXVcq0ZCqCHmIZ6SmdNEWgW34AjsnQdHJl1bjbQZmzz1qkdxQa4uBYQ6MM6NRk0NedReI1fFc93g7tNX4vWzaCLQaEQ0r8h+waKuBOl7RvCIOezq3DM77wysyZT559tgHCean4G3gI32YeQbasRzyj/uha8/Mk60wBg6R+GIAFmjSE8osE2dpsBWL9HSyDm7ve8o6PGtj8tAe2DeHtNd45AkB71NjRNaKWMOGUR4c7niaDn4pv1ZCG0ASuTMcUVpCEGLUaZY/DoTWkyd6135PIfAY+YiesVzO8Ftywfy9U2kolpGSFHOel1VuoURgFaMNS0njppHJsYwH+MKzg1tTq1ayjUbRIa30iLxjt7oomXjWKTlg6UDZpviUet+Kv0oHpLuhY3OvJcR9ZTEGWIsmcyL/Df0fYmHUAp9FTDg/93sI5KKehcSiYxOYiivHXCHgIWqOS7w7Yh+IiGp/bU/wW2P5Tgy0mvKOPRWOWAicx/m7nOc/MdPZxBrA+9XlAvCjyXDq1ReAMNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cba5b6-9863-4112-9428-08dd93c20ef6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:06:24.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VB6NKGy+b1CK8MausiT0tptHH1BA9bfwpj/H4CSdyTlqVfA8ENcMjgbtq0R/hqI/+oLNc+sMZt5lP/BI3alJUGC8pdBmwOMotFNWzZ/IA+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MCBTYWx0ZWRfX7NskU31iJWkD eHdJVZCLDA2qt7XBGyD6hJ3Gz7vmnDzggWGYA0wOvEdldr+CcdKPBP02PmrSuXVwKla4mv6x0J3 sqN30FRuVUCrO6mMb5cF9B6XC4DqESgTr+0bQZ88X3dYiMQGBZRJEPqpzXFJD070ZYgkRLwxFeL
 0W6NrBSPW7C8G+2xKn+bui2kO9sxotcWp0gPx1oSEXKg9V6leNPIhO7LfX3Js7IeWFVmmyDpxFr nqljS0TU74GK4Bde9DPcUVgY4PjDXzzkGHVB8ejfNNLi0n/T0pQFqVCiaM+NHybCu3WZCl2Ve2X 7U/JUhge+NlQ9Y91rsrGc65vfJ+BQelWW4pm9FYWXV1Q43aqNOJS1SgBofxkgWhER83CvM0Su1q
 HVi684XqgYlTJJzillKe/U7LABr38N1anbWz0o9UE02MUW0/yUg63VdVog7xeBRC7/FsWLwz
X-Authority-Analysis: v=2.4 cv=Y+b4sgeN c=1 sm=1 tr=0 ts=682602f6 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=YDJL3FfxHMx9HDRr7DEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pmaSoF4HMvoiLn9loU6b9WnGQwG5YhFp
X-Proofpoint-ORIG-GUID: pmaSoF4HMvoiLn9loU6b9WnGQwG5YhFp

On 5/15/25 10:01 AM, Lorenzo Stoakes wrote:
> +cc Liam, Sid.
> 
> Andrew - please drop this patch until this is fixed.
> 
> Hi Jared,
> 
> This breaks the xarray and vma userland testing. Please ensure that any
> required stub are set up there to allow for your fix to work correctly.
> 
> Once moved to mm-unstable, or at least -next this would get caught by bots
> (hopefully :) so this is a mandatory pre-requisite to this being merged.
> 
> Cheers, Lorenzo
> 
> P.S. Liam, Sid - do you think it might be useful to add us 3 as reviewers
> to the xarray entry in MAINTAINERS so we pick up on this sooner?

I would be fine being a reviewer to catch any breakage to the usersland 
test suite.

Thanks,
Sid

> 
> $ cd tools/testing/radix-tree
> $ make
> cp ../shared/autoconf.h generated/autoconf.h
> cc -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o main.o main.c
> cc -c -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined ../shared/xarray-shared.c -o xarray-shared.o
> In file included from ../shared/xarray-shared.c:5:
> ../shared/../../../lib/xarray.c: In function ‘xas_shrink’:
> ../shared/../../../lib/xarray.c:480:17: error: implicit declaration of function ‘kmemleak_transient_leak’ [-Wimplicit-function-declaration]
>    480 |                 kmemleak_transient_leak(node);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~
> make: *** [../shared/shared.mk:37: xarray-shared.o] Error 1
> $ cd ../vma
> $ make
> cc -c -I../shared -I. -I../../include -I../../../lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined ../shared/xarray-shared.c -o xarray-shared.o
> In file included from ../shared/xarray-shared.c:5:
> ../shared/../../../lib/xarray.c: In function ‘xas_shrink’:
> ../shared/../../../lib/xarray.c:480:17: error: implicit declaration of function ‘kmemleak_transient_leak’ [-Wimplicit-function-declaration]
>    480 |                 kmemleak_transient_leak(node);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~
> make: *** [../shared/shared.mk:37: xarray-shared.o] Error 1
> 
> On Mon, May 12, 2025 at 12:17:07PM -0700, Jared Kangas wrote:
>> Kmemleak periodically produces a false positive report that resembles
>> the following:
>>
>> unreferenced object 0xffff0000c105ed08 (size 576):
>>    comm "swapper/0", pid 1, jiffies 4294937478
>>    hex dump (first 32 bytes):
>>      00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>      d8 e7 0a 8b 00 80 ff ff 20 ed 05 c1 00 00 ff ff  ........ .......
>>    backtrace (crc 69e99671):
>>      kmemleak_alloc+0xb4/0xc4
>>      kmem_cache_alloc_lru+0x1f0/0x244
>>      xas_alloc+0x2a0/0x3a0
>>      xas_expand.constprop.0+0x144/0x4dc
>>      xas_create+0x2b0/0x484
>>      xas_store+0x60/0xa00
>>      __xa_alloc+0x194/0x280
>>      __xa_alloc_cyclic+0x104/0x2e0
>>      dev_index_reserve+0xd8/0x18c
>>      register_netdevice+0x5e8/0xf90
>>      register_netdev+0x28/0x50
>>      loopback_net_init+0x68/0x114
>>      ops_init+0x90/0x2c0
>>      register_pernet_operations+0x20c/0x554
>>      register_pernet_device+0x3c/0x8c
>>      net_dev_init+0x5cc/0x7d8
>>
>> This transient leak can be traced to xas_shrink(): when the xarray's
>> head is reassigned, kmemleak may have already started scanning the
>> xarray. When this happens, if kmemleak fails to scan the new xa_head
>> before it moves, kmemleak will see it as a leak until the xarray is
>> scanned again.
>>
>> The report can be reproduced by running the xdp_bonding BPF selftest,
>> although it doesn't appear consistently due to the bug's transience.
>> In my testing, the following script has reliably triggered the report in
>> under an hour on a debug kernel with kmemleak enabled, where KSELFTESTS
>> is set to the install path for the kernel selftests:
>>
>>          #!/bin/sh
>>          set -eu
>>
>>          echo 1 >/sys/module/kmemleak/parameters/verbose
>>          echo scan=1 >/sys/kernel/debug/kmemleak
>>
>>          while :; do
>>                  $KSELFTESTS/bpf/test_progs -t xdp_bonding
>>          done
>>
>> To prevent this false positive report, mark the new xa_head in
>> xas_shrink() as a transient leak.
>>
>> Signed-off-by: Jared Kangas <jkangas@redhat.com>
>> ---
>>   lib/xarray.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/lib/xarray.c b/lib/xarray.c
>> index 9644b18af18d1..51314fa157b31 100644
>> --- a/lib/xarray.c
>> +++ b/lib/xarray.c
>> @@ -8,6 +8,7 @@
>>
>>   #include <linux/bitmap.h>
>>   #include <linux/export.h>
>> +#include <linux/kmemleak.h>
>>   #include <linux/list.h>
>>   #include <linux/slab.h>
>>   #include <linux/xarray.h>
>> @@ -476,6 +477,7 @@ static void xas_shrink(struct xa_state *xas)
>>   			break;
>>   		node = xa_to_node(entry);
>>   		node->parent = NULL;
>> +		kmemleak_transient_leak(node);
>>   	}
>>   }
>>
>> --
>> 2.49.0
>>
>>
>>


