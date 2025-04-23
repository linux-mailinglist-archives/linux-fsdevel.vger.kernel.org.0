Return-Path: <linux-fsdevel+bounces-47108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF36FA9931D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 17:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40481BC1315
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE77293B73;
	Wed, 23 Apr 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="THlCZkO1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XO6COsTY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CF293B60;
	Wed, 23 Apr 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422248; cv=fail; b=EHuP3MPI3k1ixAASUfeQF6pHeX+xw1hqhiODtJ5QUiFhdIdYIdeM72k2kN037ha0Yj0Tim8mScE+1KIv44kJp+SbTFSIHOAxCFtbMtasph2NLnn+UbC6I3wi1xeqy0GClofnOawxXNFYrj12ePn09vAbl4nZudIzOG5g2d/PQPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422248; c=relaxed/simple;
	bh=arNmmLmTxkgHrU8SXstO/3IgT/lP0w+4Xe8H74hRjvw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QoUPNgjMQ/L8blMIIgqhSWOcVK1fi1pzEU2rU4myYq4vuzhsn6D+gzIqmbdM7rsxez38QrbK9S7hNgkASIeMUdxWbd2ZJY3V1mg1AbnPtIyE3G/zta2+4NMHI/bg3ZPKSm0y3do4KxPx5MuI9ON4UU9N9gbnRqtMlIlyv2yoSdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=THlCZkO1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XO6COsTY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NEg0fM026214;
	Wed, 23 Apr 2025 15:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XyoMQAcIzGBgQsKihd7IKPpCNdEhjNBn2BA8aVq0k6s=; b=
	THlCZkO1ghfCr0RkQ3I35cBevsSNvUzSQ0/pb19s/B+neBmeyqbzSDi8ll6gBGNp
	n2WMe81gvLFNBIOGq/326HhSEztndwzCZuR6qpGP7jlOk52Tl5n20YvprTxdsy7W
	iw4ymreoekcx/CJCJvy1rCk/fTCKHSEcz7bt+g9x85x5syqbEVO5MEqUkZMPewef
	pRAwPmV/LwJrOrdraXG3uYsBk+KzZ1SoA36RVVUYGgFlU+bk/uBjp3gdArLyqwI2
	UpKjQCCMgK3QVO/VcdDQQ6JJG2mocxqmCqPsN18dVfHWHdUgrjYxgSs5KVOcJltg
	ehFRDgnBNpMY3iNEAVxq+g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhdhj4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 15:30:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NE7fpb025219;
	Wed, 23 Apr 2025 15:30:25 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010003.outbound.protection.outlook.com [40.93.13.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbqt64n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 15:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wG1z9VNIJeweyJJEopkvYNRFlokONyufJtewoIg2hBrbswa46ZSALkyxEDgu2VOoqixoGqVJuOgTLvJL0V8FDed4sgJs+qoVBwns4fItEcRi2ocXlhgwUjxuW68Sv7wi8rrh0weqOPzSrV+pJjGdYmTrp4MixUnS15VewpX+i6rVHuNIn3qGvBMqaX0UNRU4D8swdjz2ZSjEezgXMKkesCSyMqZKoD6EghGzwsAfb2pCxhSbDVPGWH/dbmzTzIqEutinxfxzDw3tJV7tAp5MMfKmSqCTaTQHkGtcvbvO9QSKWdA+KqJjM9Z+Wmd3V3zg+2fcIwdU5w9awl6mqT2T9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyoMQAcIzGBgQsKihd7IKPpCNdEhjNBn2BA8aVq0k6s=;
 b=gGqf7rNMZUgfWaIJawWzL6qv6oARbRTOa61P3jS5xPJlvg8PXdioNCCMH2PyjNK90/pB9oEDoFCqzex2kpo27BJI/zm8m4sqQJGGia+pplb/SvG+hyAyarocXI2kiFhv6I1tUqCq+3Phwpg7oorbssDYajOEBRbCnXeF1OXLc5vczXNZ3Vtg1wcu6VvuEsU0/JIUmeXh12tKbt90t8nMgbYcoR5dhz1PGjp44iEipAMs+T50v/m/+mK9bMZjk/585KexWIWeL82VIh/v99N6lMgP2J6oZtZlSpbLLGiuucDJBtus8qJF2ypIq3FiZPNJjDPrrW5pqCdz6IxswbGbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyoMQAcIzGBgQsKihd7IKPpCNdEhjNBn2BA8aVq0k6s=;
 b=XO6COsTYEnHWJUYiozD24uHcEZNsysPdEPsWK5ws8zYf5wK9K/mTfn48FFxshJB1Q/s47KwsZkDUELrwAEcBKxyPqKf3VuZg/8dmSMd2oaCH27GG0cQP44ly5CKWx5uPZ57v4FaULpUpxQd5o/Ih35tQWAy31fvtcrCoG/KjMNA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5118.namprd10.prod.outlook.com (2603:10b6:5:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 15:30:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 15:30:22 +0000
Message-ID: <97033bd0-dcf9-4049-8e44-060b7e854952@oracle.com>
Date: Wed, 23 Apr 2025 11:30:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Initial NFS client support for RWF_DONTCACHE
To: Matthew Wilcox <willy@infradead.org>
Cc: trondmy@kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
 <c608d941-c34d-4cf9-b635-7f327f0fd8f4@oracle.com>
 <aAkFrow1KTUmA_cH@casper.infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aAkFrow1KTUmA_cH@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:610:b0::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: c9412da2-e0f8-4d3c-2674-08dd827bc360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU5FSW1UTUlqUzZLVkJxTFMyK1JvNTNELzNJWEtMODVGREZPWHNDc3d3RDQ2?=
 =?utf-8?B?NG1PZndTTjZhck9HVkVDZ3hoMzB5NVhkWHJsbis5bEM4L3Q4RENTT2N3UmxE?=
 =?utf-8?B?VnlZU0R4WVRpM0RiUlVXSlNTUFhHSjlPdk1MNVR2VUUxY1JHUGJELzhxS0tm?=
 =?utf-8?B?TTZmRHVEYlcrYTBhZ01lT3pqQzZUWUdyQytBYmFqVGlGK2N4UWxSSjViUlN6?=
 =?utf-8?B?cE55V1FJTGY3dUxRcTVyUmJZbFR3ZGRIWUxnOE5naFFzeGVlaVdNazBzQ3ZS?=
 =?utf-8?B?MTJmT2svblliNnJ5V2tJcEk4dDgxTTJhQXl2SHZEbkNKSitrREs4SmN4UmNU?=
 =?utf-8?B?WWVORHRLZGpQNUtwTDA3QzNUeXdqOFo4Z21INkcyTlVOMUZxYnNKTVJodzV5?=
 =?utf-8?B?ckhER2FXRm02Z1pLRENnek1IZVUwMGJDMktRakg5OGJiYXhOZmh5L0wzQW9K?=
 =?utf-8?B?Wko1TmNLY3lpU2UzTzJFVGhJa1c3TkF4NkxXcDNlR0VjSHAxV1RiVmRmejM0?=
 =?utf-8?B?VGxuWGhBaEhvM0JoVWZVL1NGbktjYVVUZm1mRTFmTWZxZjY2eElLRmFYNURl?=
 =?utf-8?B?VnRreHhNU1NzclpvWjhJUWlBZVJJWWJ1d012OEt4YmZ0cXNWMkJ4bVFVazll?=
 =?utf-8?B?dzAxcS9XMkZvRnhtMlU2MXZNa3V6TXY1ZTJCL0dNS1JEaHBmWjl6alR1QlFS?=
 =?utf-8?B?Q1NjOTJSeXRiN1paZTlRdk1hMmtzQUdEYk1GbWRMQm9jVHQyWVRvckx1Wmhn?=
 =?utf-8?B?K2hkRWV1YmRpRTZCU1M0RWl0N0E5Y3cxYmM4ZHBrYWF4YVN2V3lNbXRLajc3?=
 =?utf-8?B?c0dtakNldGhxc2kzL3FCQnJ0Q3l2MU5rWUN0akdxVHdNTFFKbWFjYWY2ekE1?=
 =?utf-8?B?cVhUd1lEL2laN3dwS0VTRTdhaEQ4K3A5WEpKOU5TYjJoMFJNU3hEa3BUMnNT?=
 =?utf-8?B?RkFTNm9HRGVpbk9pMnNJQTFzakh4d25abk4zb05xZ0RIRHFzd3BKLzVMQjRZ?=
 =?utf-8?B?MGdKWVpxNkpCdE1DMU5kWGpuMXEyVE1jVFZZU29uL0k5RmhtdVJ0WGVRV3Bp?=
 =?utf-8?B?QVpZWXNhN3EvakMybkZZa3kzN3RYVU5VRlJWSTIvVDAvVGVSc0MzbFVqMURS?=
 =?utf-8?B?YkMzdHFLd2xwZkNhdVV3UXpTTWtoWjZrWW55QmMySDBidzFiNzkvTDhyMEcx?=
 =?utf-8?B?U3N6aUVNOHBVYmcxKzlNbTFObFVzZFJpbmR3N1kvQzExcVdtMGErYTRCbENw?=
 =?utf-8?B?ajRsS3JQcHN0VzgxdEFPSkRUS2tYSlcvUXFqUXNqMStncHY3aUxKdTBZRGc3?=
 =?utf-8?B?UUt1T3M2bVZLOGRZQjNKMmJMT1lQMUk1UWNVVnpVN1V1UTZ5Rm0xdDRnUHdn?=
 =?utf-8?B?NjJjNks3SzNoUWg4Zk1UTzJtN0srWUJXNnc2REpDNUhtVVZCUWdtMTFCRUt0?=
 =?utf-8?B?UVdoOWFWYVNQYXBqZXpoc1NHVG5BVXpoSUtNTENzRjNFM1Q0dk4wU0IzdHo5?=
 =?utf-8?B?aThmbHZJR2JoTzlmc081Nk1BaGpRNEJRRTlQMllrT3NoTHd3c2RaQUJLOTdS?=
 =?utf-8?B?cDdCbHhFZ1NiNTVGN3RES1dUZVFYcDV4c1Zwdytzd2U2bzdzK25yMTgzanpk?=
 =?utf-8?B?eUNGUkJEVjN6MnhNV0N4TVVqNFNJT1UwemdhNG83d0NYRUVqWUV2bTNlbGRm?=
 =?utf-8?B?VGltcElXcUVvVDBiN1pQcE1XVkl5N0YydUFQMjdqTUxwL20rR3h1NHIxcU5U?=
 =?utf-8?B?Nm8zZGtLRHZaQ08xRTZjZUZ4eWJoOVkrQWxJaWpQN1hpN015K1V2Q2Nhdml1?=
 =?utf-8?B?aFhUNC9iL2QxcHlueVZlMmxXVjdRK0tGU3A3TkVyb2E0RC9ua1g0NmJFbEhK?=
 =?utf-8?B?aTBacWJnTjhxMWE2cDJIUzd5YlBnUVZjb2hrOUh5aHRwRElwcEFpMUxDZFJz?=
 =?utf-8?Q?edUsUVsmw4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHBmOHNiNmpsdUk5STYzWmk0bWY1b0hHN25RL01udzZpdUdzNW1lYzUvVmFj?=
 =?utf-8?B?TlJ2NXYyVzFLTlhDRjJvdHlRbVlsYXZuSEhUT08zL0UwWi9aclhlSlkxdFlH?=
 =?utf-8?B?TzBrdWhySVhPQ2szd1JuZmxjN2tUSkgyVnp4enlpMHJzOU9pVzdKOGx1YjNq?=
 =?utf-8?B?L2xUSWR4K0p0S2dFdU4zVExLT2J5bDRnK0hyQ25zMkw1bk9vWmJQdEVKejJ5?=
 =?utf-8?B?dDNMTzRjcUhnTEZNZ1puOTZBZGwyOVl4NTFuUFpKcTVaRHMwU0NLUFI5bmkr?=
 =?utf-8?B?UTFJV2RlbUlqZ0ZDbFNrRUYrS1ppeTlMck1lMVVDVjNyVWw1NUFTcFgvblVW?=
 =?utf-8?B?RG1vQWFCd1puYVlyQW1IWVFUbW95cExyV09lazNuUzNqSSsvdVlGMWw0MGlX?=
 =?utf-8?B?RzViamwwT2gvVXFRYUplV2dKcWNwU1pSNnAycWwzOWFSNS9kUkYzdVNFWlpo?=
 =?utf-8?B?Nklxd3lncVIxVGhNWStncE9IWDU1V3FIV245OEhvT1hIekQzQ3BSK3RVMVVm?=
 =?utf-8?B?cUU0R1FXV2Qvbk13L0RkTjhkK041SDkvbllXRXhYYzFTTEtsU1piWElQTW94?=
 =?utf-8?B?L01nMmRhOFQ1Qi9KOEVOOWNUemZ5czc5cklJUUp4M0U0OXFCZGtvN2xXNm5Z?=
 =?utf-8?B?Q21qZzNPcVFaR0tHRENiN3B2bEJrck11U2M1M25DZldyV2tTY1NGcEpSR3Y4?=
 =?utf-8?B?N0NvMFA0RXNQT1I4UXpISEhiODR3eUx2MVFaeThmU2J2Y1UxUmxzcUpvdGRs?=
 =?utf-8?B?Q25ocTFQVUdEb3ZsNUo3ajBzNW1oTjhKdEVrN2dkY3NSbHJ2RzFteUI0dSs1?=
 =?utf-8?B?T0gwTW1pTnRRSVcwbTUzVmpCMXdUQUtiTVpSTjRPQ3pmRlFpZG9KLzJIQU4z?=
 =?utf-8?B?a1g3b3h2ZS8vbHNSU2JwS21sY1Z1cW0rVzlCcmlwMDZDdDcxMjVnMElwNWZy?=
 =?utf-8?B?bndmY0plYUFrdkhnbnQ0VklKRk9mdnlnb05RSW11YWN5UHhhOHc5VG5vZEE2?=
 =?utf-8?B?dTNNeStVbys3d1hoQmdyckdRempUZVBoUzJ1Z01HeE5iZkdTby9WS0lSZVkx?=
 =?utf-8?B?RWlodTllSkxGMHVEdEkxTGdMcmlLRzlPU1Y2RmoxK256RUtadzhRZENBamda?=
 =?utf-8?B?ZjViYWdXRGhBTGJYVTgwOWJOVmNhRzhhUis1ZzMxT0pXaWh4dWVLcmFpbGNm?=
 =?utf-8?B?T2ppK3pQNDN2Ny9ueHRpTEJZajNkSW5neWRySGk1ekh6N3E4VXUydG9hYm5B?=
 =?utf-8?B?cVNOSDBqaG54UHg0MFZyaFA0K3pXT3lBSlBuM1NWa0cxQTV1TnNDMjhGQ2Vm?=
 =?utf-8?B?SXFWSnh2L2FVQUIrTGYxZlhiVW9yNU9mdm9GRitERXI2bVZTZGRERWo3R1Qv?=
 =?utf-8?B?MDdIbWdMSDVMSEtqMEt6UzNMQmhpMytxTHRPUThoenFqZWN1dlN4dkNwaDE1?=
 =?utf-8?B?MFFzSE1RbVB1VVhGZHZHNVFMQlZNNjdnblJsY0duL1Z1bDFSZnE1cTBRUmJI?=
 =?utf-8?B?V1ZlL21IV0doaTd4MWpYMkpaQ0ZreVJJdDk2bWNlcFZpdklYR1VwaGJQRkVO?=
 =?utf-8?B?SVdSYWprUFBGNVhta2hGRjMrOHNndTI0bFQwWjcrTFZIcm9LTDBQWDdrQllK?=
 =?utf-8?B?Nmt0dFhZeVBrNk9XeEJrV1QzYjFuVVh1OEJyeGxrVlB3NzRzaElsQTNBTkNI?=
 =?utf-8?B?TXRodkoranJjdkpSYmFOQUVsbEV0WlVIc0JCd2kveHRoZjFFcy9wM3BsRzlO?=
 =?utf-8?B?OXc4dTFSVGFlNVdnRmdscXJrRGRMQS9sZUZQaDFaejZwT1B5MkN1TWFlbTFa?=
 =?utf-8?B?TjN3SDN3dWgrQ2piZXBnL1dPN2VZbTBqSE82UGxRbmo4RGVHTThUaFRBbk4w?=
 =?utf-8?B?bUpWdUd1NE5qdWs2NGpGYi9NMmYwUytjUW5xbzF4VXhYZE9JR1VsMXJiRk9z?=
 =?utf-8?B?b29jaXZJTGI1N2s4UlRLWE5TeG1EbU5LSXdtc2gyc1BzMnRZUEJDYS9MSXNQ?=
 =?utf-8?B?djQ5Qy9yR2RsTkVvbTg1QTcwZ2gvQ0R1bDZhWHFxZU1TSFNDY3ZRTmFOaEtz?=
 =?utf-8?B?bmNud3F1cEhFT09xMmNmZWJsTTNpWXZSQnNxOXlNd0lFTGlFZUY4RVc0Z08z?=
 =?utf-8?Q?41bFPf5GTIezGq/Rbbrf1z28b?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+coGypk07oBF3W53Rp22rAZ09B1GpnPnNJGhCVuQTsdVRS2gTSNnZyTvo76+fW98dAituCtqK/k7lXbDeB2E/TdcbcVk+jM1nx6kUDsRJdntV/Z0nkP1qH7DlKb46DDSeHUZz3vY6DBbTWmOGNC3d7bZaFaQRS6XrEAR4lb1r/sv8ERiAIcP2L/g4R4yq99TDzBEbR0SZrYfyN7UGVRr0W4hqjhMSwndqLHjpUVH2r1PSR20mPzX6N4ENsnxBGVbHsZewwKIG0FVZfQPpJ1YGlHOD5rYt4oGNrcp5eYWcwxIUGeALQ4p9shnR6G6CAN5UVyrVwhvNcAa7jx76eCeHjcbgrWG8rcvHXiIBAougA5k8dO2cUa3wAEEtHwg9tKIEKHBZFZMAsXWpGnh2eZWGJOwZrGpkMKnbvEDNdMZPnkYBJSzxybcn6ImpxAOr3fbf8VAx9QYBTCCMLliPH8I3C4tXlAzxDtw6p67wEUO69c2rIulZR1EDOJqyvNvw+l5prtdH+LTJPwxqYDmu40lhMZt0bXNox/wsTKYEzzc6BHbvgLQ4hDruzB8Tmf9SHvb6IHjsBJf28H03HW9tVhbgBcIfJAINvK42sc6IUJkwKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9412da2-e0f8-4d3c-2674-08dd827bc360
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 15:30:22.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+97DEzZzMiNd6FunE0MTfO4MqEfRz+RXYSDXjF7x3Sfhh6thVU/rs6K4F/r+5wcZoNJ31R3CXszd+5cd5AfFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_09,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504230109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEwOCBTYWx0ZWRfXwqc5TQZxUelz RYgqabwO+YGZrNq/UQnppNDloKsWiS2LnBJpE6SyEjkNVWbk9pGrOtGUqql5H9+911ktI1xT/7R zt5SWL07T+gppVfkv88kmubqSqOKwSAwr9mn0T22yaBuQFFYbEqDbcNDAjHujmv7+zHD66IGv2A
 B28mrOY3YHuc5EoX9cfLzXcIs4rCuWYrDvtnj2T3K+bmLP7rQ4rk7efyPhUZFzsMjn7nLe7GKij FCXJjjv7c83BqELGfZkqebayLJOKvc2iIP/Vll6wdCiWekOGmM4+jubTANYxD90d8pO6m5wlYfX RGoo78gl8ZrGow5p37E26kajadw1ALsRNUpcyzoRDI5BTF7JXEurmYu3p9qNIlvZYVMwR7GU95V IU48MLAo
X-Proofpoint-ORIG-GUID: XuiSGTmo0LYy6nmw87bwMrYfKZiWX-C_
X-Proofpoint-GUID: XuiSGTmo0LYy6nmw87bwMrYfKZiWX-C_

On 4/23/25 11:22 AM, Matthew Wilcox wrote:
> On Wed, Apr 23, 2025 at 10:38:37AM -0400, Chuck Lever wrote:
>> On 4/23/25 12:25 AM, trondmy@kernel.org wrote:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> The following patch set attempts to add support for the RWF_DONTCACHE
>>> flag in preadv2() and pwritev2() on NFS filesystems.
>>
>> Hi Trond-
>>
>> "RFC" in the subject field noted.
>>
>> The cover letter does not explain why one would want this facility, nor
>> does it quantify the performance implications.
>>
>> I can understand not wanting to cache on an NFS server, but don't you
>> want to maintain a data cache as close to applications as possible?
> 
> If you look at the original work for RWF_DONTCACHE, you'll see this is
> the application providing the hint that it's doing a streaming access.
> It's only applied to folios which are created as a result of this
> access, and other accesses to these folios while the folios are in use
> clear the flag.  So it's kind of like O_DIRECT access, except that it
> does go through the page cache so there's none of this funky alignment
> requirement on the userspace buffers.

OK, was wondering whether this behavior was opt-in; sounds like it is.
Thanks for setting me straight.


-- 
Chuck Lever

