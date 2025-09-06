Return-Path: <linux-fsdevel+bounces-60453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73320B471CD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 205267B0B1C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2801B21884B;
	Sat,  6 Sep 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g1rtd6WN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hQ8YarUF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D418C1E32D6
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757171786; cv=fail; b=gv3U5jcweCYiDPWcmeNMhxPRKnmTfanASlaj9U4xTu+I4N8knDQOH2OK5uGAzCbNy4D9T7wRxOLJRecoRsAfYIpRUBVodubF/15RHiPSueEghNvQiFX3PA0XKjZS+HokR9moPUXmmaiR1It0fku/3gI0kfknj/jPl8HiezndFbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757171786; c=relaxed/simple;
	bh=DeFDhvj8kW5Q7sNsqEua0uoxwBz/sFKcCNP9WqzPET4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HCqvxmHFZ1HRxvIHCHyidJEn5DWNW6R26LK2I9WKEYsFkUtU/NhA7DgoWUmxeFTVrmr8R3ePkUvxhXd49uAsUQ8XpCWmwZUxBLf2OQkWY9BR/w+UfDISVy/qWDHkyoMMW9HVMx+szALZ3jxr5uJusfIwdNu9ebnK3GYj95M9O90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g1rtd6WN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hQ8YarUF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 586EudXJ015149;
	Sat, 6 Sep 2025 15:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sPwXV7SD5tgxkAki108DqjWXW/upHcD1qVNBELOoN9A=; b=
	g1rtd6WNqMWz5U1bEFhOy4ccj/wvwdPYFuLv1/kxl7e/h1Biy1qki1SdP5CrYCcp
	IC1qp3XtO7B3YkEITOn2MECUU4u4raHnTVXGJOS2lL3HW7gBSjZZOOQKe651ZMOL
	l1HVOB0Ds7gvNPFmv0slreVrAVzeqSr9Gpgy8VRwP4wELIWsYBrg+uVo//rZgFuz
	4RlYp70z8x6okxN3DuB7jaXwgliUGg7K+DvGlmeqYnn3UKuFCXneV2bFLQGXIC51
	SO8i6PcX/6+cPTmrFB7zhD0JhB8js18sQXCQPGmK6YFJ54AckxIUEFHYOsKwXY7G
	O5hBol+WL/90lCts/jDExQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 490q4nr09n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Sep 2025 15:16:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 586F9nwr002807;
	Sat, 6 Sep 2025 15:16:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdd5buu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Sep 2025 15:16:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQnOwU69XGQ1WkomEjLiMnjHlJn93nPweWp6bhUOG185Gj/QMQEEO83a2hhA1yDUi2RIl5TYqDRwqt20cbOUONQ0fIZcCsM69Dkok6hAMD44Mp3mSW3qEoooCYnDaxTVg5ynYeEwvoTbQtfu0StmNjY5kfIrO+QUm8U268jlklSZQZXoSViWXuxvlZFXoLPc6Be7pdNuNKDW2qMTAK6h/fFAuHkJPqitM4xFTPJcJG2t52g1mUzc+kSnUJj+sTK22PmE5PQfnuGyv4pM6BH+s1k5rcJKm6HjFInGrHfrdSypOxmzkodIAgYwQY6kSgpwPGe5qQMTc55y74xHa+cdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPwXV7SD5tgxkAki108DqjWXW/upHcD1qVNBELOoN9A=;
 b=Cdwglucm4AU2lP6jIbzPojfCJuARKdy0SpQxMSSfZpKPUwo+bmvijKtY9jHVdRw3pn4BpHRxrkoPQ5P7BC6Ke5+V1W6YpjvR9QvH1GQtJbWpjfquoaDhCfHuecn9O95XalDcP2qbgp+JTpYe0mb1KHZNwoIijJF1ZB1xYMk0rT1M+GoR+f0YY20qQ2ZBebApVvBnd+h3WoVxLTT/Wu3ItTXSl2/axutnm3nV/MjcTKgM1EBD2AdXd/GXgGP5N5IzfEpJDntrOtUDgULf349qnnenUJPpAmokCUGS+rjhglkvUiTafyYdw5TmG73tQRRqmXVWhhTEwfXEcOzHmujlFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPwXV7SD5tgxkAki108DqjWXW/upHcD1qVNBELOoN9A=;
 b=hQ8YarUF7i9XOdICmlG7kZpFEEupXNpB23xRcD/KwEuUMKPBWONChh7QDaM6aHwKZGkso+PQKH2TI8bK527yONeQkjJGHc23/tgN4163R9WhrxkkDJ4kozSdhtJ74y9QwUAt28nqUFRMv5MMTx1u0qg+UVcxj5xq0ied3RBgna8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5596.namprd10.prod.outlook.com (2603:10b6:510:f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Sat, 6 Sep
 2025 15:16:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.017; Sat, 6 Sep 2025
 15:16:07 +0000
Message-ID: <b442a8ad-95f3-4a9e-bfbd-32aef45530a8@oracle.com>
Date: Sat, 6 Sep 2025 11:16:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] rqst_exp_get_by_name(): constify path argument
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, jack@suse.cz, torvalds@linux-foundation.org,
        amir73il@gmail.com, linkinjeon@kernel.org, john@apparmor.net
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-7-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250906091137.95554-7-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0037.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ebbdfc-9429-4324-09be-08dded584d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXNteVRqWnkrdUdEZXFNNFFkYTRIRHFWbUNKZWhucVBOVTdLQjh1ajdyUE8w?=
 =?utf-8?B?cHUzSUdncTVrWXZaWmdSOU1UWVNwaDhHVkh5WFVQNCtTdWJyVlBOblRnUk5o?=
 =?utf-8?B?TXQzU3pwYms4cC8zTS9Jb3RYdGdkRmVGSU5vRGNjS3cxSWQyaFppalhib2tD?=
 =?utf-8?B?ZFAvaTIrQjB5dEc1Z0NTMFBrQ1JxTytHM0JzbmIzb0kvSlVudkpBRmIxank2?=
 =?utf-8?B?Q2lnVzF2djNmSlVUbGdtQ1Rvd3VYcE1UM3NYNXB1ZlVvRFhheERITEhBWTIv?=
 =?utf-8?B?bUpIRXNydG15VkZOK0tTOHdCbWthOFc2bzBQZWJuNUtHMXBLZzB3bW1BN0ZD?=
 =?utf-8?B?Z0VhcVgzQ2R0ZWV2STN5YzMxVjE1SGVJSVpaQlR0WFlUVWdaQjI4RXhoVkVL?=
 =?utf-8?B?aWFBczNmRVN4eU5Yc0JUcU8vUUpDNXl2dm5qUXBpNGwxWFV3aGVXNkpEd2xU?=
 =?utf-8?B?VklrVWluZ1lwdk9pTmVqNFpyRUFiWjAweHZVTmVLOXVKU0FXTHpSTVRWMVBy?=
 =?utf-8?B?Y1Erd1BUdzhkTjJxdE9jcDl6STVGTmJZOWlpL0JGVXFVMlkzYm5OSk9TWC85?=
 =?utf-8?B?WTMySTZQYm9ZL3RPcHR3SGdaM0ZRUko1RFM0bUltcE1BTXpHMmt2Q1dWOEdx?=
 =?utf-8?B?LzNHYVNSOGttbFdKMUowYUpIVXp4TkI2K3kydHRvNnNISFRYSFdPUXlFOGVH?=
 =?utf-8?B?Sk02ZkY5cTVqUzdvUDlFQmo3YUNRVzBPaVRRMlpVNUYwbXZiL1R6amkrNnNY?=
 =?utf-8?B?OTVSUVREZ3RiclJxRko5QTRNdFN3anJpQ2tWUFB3cVhsbklCSnM4dHN3YTZs?=
 =?utf-8?B?bVYxTXFhdkdEMTZNcnJFWnFlVE5WRFRGWTBHNTdDbHFEODhUemFTd0FyamJm?=
 =?utf-8?B?N0JnRmxwWk81d1o4c0tZTDZkZCs3Rk1TcUFwQnVQaFJXQkxJN3pYdVUrdlZ5?=
 =?utf-8?B?MDZzZ3grQ1o0dXM2bWtlQWVQMXpGNUpnbFZneit1d1NMWGgyMlBHcGphSWxM?=
 =?utf-8?B?dC94S3p5MHNuL3IxUngwL0JPT0pvTTJLNElMZHFSekdEaFdqVEE3dEF6SGR6?=
 =?utf-8?B?UUxYSGk1OEo1SnlmY3h0TVVISWduZjNJTDNjNWg0NnNXeEpyNGlGVWlUc0cv?=
 =?utf-8?B?cmM3ODhFZnh5aVlVUzBHbTJHUkZ3cWRQdE5tTFFXOFY3VzZRLzZiV2I0VCtF?=
 =?utf-8?B?NWJtamRPZ0lFZVF5NTJRU0xCd2FMMXl3SWw2bmg1UTRZNHFpNGNhQnZuVTNS?=
 =?utf-8?B?THdJUXFjNXAybm8rZ2NML3hpdXBBU1VKaFlDdFRCVjhDeGVsdlhWVHppNUI1?=
 =?utf-8?B?NjhSYzNBdjh4TGpPaGFKSzlLL1RvbDAyTFpyRDRMNGtJTzQyMmQraE1QODUx?=
 =?utf-8?B?aUhHbnlObEtEVno3RU9JWDk4a2R4amsrM3JtWVBjYytCOHllMHIzRzcvbGJx?=
 =?utf-8?B?WkI2WG5nVEpockxjY0VJMjlJYVlQQVRtSzBhOHh4QVpDa0lJUVh5eXlhWHZZ?=
 =?utf-8?B?NDl0NkRKRmxvL0lVRE81LzU3NmhFVkpMKzV2MGF4N284MmxyWXJSeTAxL3Bh?=
 =?utf-8?B?S1AwVUpFRS9zQ2Q1bVcxNjlrSGN1Y1I2Zkk3WGlVT051bmplQ3F1T3VjNWlI?=
 =?utf-8?B?cWRVWkJzajlsNVI4L1kxcGtKMGl6dmo5WDJ3VE1RcE5Vd2h0ODk4anltd05w?=
 =?utf-8?B?RUNsVjN2Z1QvOFovcFA0eW1SR0wyMkxVTGFCV0pwNmlEcFlLT29maklXNGRN?=
 =?utf-8?B?aVZMakJrMTJsOEV3QnJVQ29Manhoc1EzTkRSeGhkakt3YUpZUUVJOEt1NVc4?=
 =?utf-8?B?aDQ1b2RRY0xydmlDbmJpdEQ2UEFiUUcrVHIzTWd3VjRWZHRHUzF1bzh0RkdC?=
 =?utf-8?B?R2JpWVZJSEFjbjFaUTRYU1R5QWxFVSsyQlpmYTB2T3pqeUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UldPWDQ0UTVMc1c5VFIzcUV2b3RjYWtYSzBuTVVlOTg0eTl4eHlBOVNMbmpl?=
 =?utf-8?B?T3NZd3RVMTI2NkI0YjU0NkZkRXppSWY1ekZVaTV0eml0ZGs3U2M1d3ZvMldv?=
 =?utf-8?B?ckJZNml5c0EwazhRR1NWMGhHZ0JnMHhaUXVOaGtBYTM1dUxNYVJUQVlaZWVX?=
 =?utf-8?B?TGZNaFRZWDlTNVlEWFhWVkZSTmdMVkdnUzZCS2lSNFRDbVpHSUVkbkJ1UWY1?=
 =?utf-8?B?NlBtRy9kbEJBUjJSUDFpSk1GQjMySEhNK2tDVFBuVTBCNklSYjBuSUlBYkwx?=
 =?utf-8?B?ejdNcnd5YUlaN0NxVVRxMHFIN3pKMm1uSkZhUjdBOVZhdjg5U0xJQ3BwQ0l1?=
 =?utf-8?B?RlltanBlN050MVNVc1BvSGxXRDB1Q3VCU1VZWHo4OUVOU0hVYWRFOE5oK0to?=
 =?utf-8?B?ODRSOFpyWjdMLzlTWWZ3VzAvNXRBbzVBS0tyMTJDT24xdGxUanA3L2lBYVVR?=
 =?utf-8?B?ZjVVV01MOURIVUs4bWhPSkE3U0M3dXF5SGpNYnBwSmRCNHZ2SHZ3R1k5Y28w?=
 =?utf-8?B?SThUYXFjbzgzU2JxQ1dXeURNN2NsVjMvNXRzOWU1Y29ydTBIWEgxRENJdHND?=
 =?utf-8?B?U3dacmZET0F0U04vUDBIWVRnQ1p3NjAySEs5aU83SmZZTzNyU3Vud2pOdUIr?=
 =?utf-8?B?R2QrQmMwRWFmZGxvVjVPMFFHUm45U1hFR1BKL1owOEJURHVKMzZabHpnbmtR?=
 =?utf-8?B?UTU5UEc2K3p0YzNmZmhnckV5dTU1dTlqUjEwbTd3cUNxT2hiTzk4eXpLVXFz?=
 =?utf-8?B?WmFxQjZnQUxWMW9zcHZYT1BVN2puNjBvWnI3K2dRZytRTzZVcmtUM0t3dU9D?=
 =?utf-8?B?aU5OelVLZGpudzJ0dGE0VVhrNTN2ZDFWdWVpSE9PKzcxOEZRcy9QaWdjUU52?=
 =?utf-8?B?WCtFKzIyZU9udnI5VHVqeG5uMkhDeDM5WUhQT0IwZUUzNVFPck83aHZwSlp0?=
 =?utf-8?B?Ym1LUEVGN0ZSYXd6bWxVNHhacWFZblYweVY4TEkzNnBBbGk5YjBzY2xDTEtm?=
 =?utf-8?B?M0lucHpXSU0zZElxVzBRYUs4QThRRCtKK0poTUZGYlo2Tnp4dzRCVFF4blNL?=
 =?utf-8?B?cm44eHQ2TXJVUGljMXcwcUVzdFNBeU01T2xoNi9ieUxhS29SdU53bFNLV1Iw?=
 =?utf-8?B?WGtrWGNEaTVpazNCRGhFNWJMb3VxSGVuRlhSbDdWKzhEMDFQK0thWm9LR1Ja?=
 =?utf-8?B?Q3FzL0h3a2dnQUUyQWtGQjVNU0RSUXdBc0E3czBmWnBsTmxUeXYxdDJQZzFC?=
 =?utf-8?B?Z2F4c1lZNEdvQVpqT1VSbFlQaVNYN2dWbWY1VGl1dFBDdlZTcG8yVzM0aVZR?=
 =?utf-8?B?RWtjQkk5WmZtckRsaXFqNzhxWnN5bHBxbzVSZlYrSi8vU1FhRFRza0lnQ2V2?=
 =?utf-8?B?QzRiYmlMTE40WHRMOXFXWU1uemRuMnpJVjhBNDgrMkpJUGdQN3g1R3Vwc0ox?=
 =?utf-8?B?ZDVKd3IxSFd2REZQUFpwcitBTFpPOHFHcVFwTnFxRU9EcFB1SFpXZkhRY0or?=
 =?utf-8?B?YVArY1JIVG1BNHRYRDFyY0I4M1lBd2VDaHdwRGc3aFU4U3lXTGk4blJESkdV?=
 =?utf-8?B?eTdoeHZUV0FUTFdZei84TmU5RktEU0crMysrR2dMZzNOdHQ4em5nay9Md1NZ?=
 =?utf-8?B?ME9YZ1ptd0l2cHdLWHpEcmFTcW1xeFBPRTlLZGRJMWdIRjRIb2UzL0J1cFVZ?=
 =?utf-8?B?eWpvdUJ3eWk2Zmg5Q3N0NitPL3J0cldKZFNvQ25DL1BFZlhJQW0zcWswM0Zq?=
 =?utf-8?B?RnRWOHlqcTNxSUJ5MDBUZFVJY0hHc1Vwa2dCYnNIeHdBQVM3UHJ5YVd1azhh?=
 =?utf-8?B?S25TczNZbUNnYmoyT2tnUDlQY0NkajlneSs0YVNESk1tQmdWM1F2MlFpbDl1?=
 =?utf-8?B?RnVGeURWbUNxakRGV05IcytrNlllUjZvRGx3YUlScGhpVVI1M2loNGhQWnZG?=
 =?utf-8?B?bG1OWEJMYytaTTh2bUM5NmIvbW8vbjhKbXlHMTE4SFJCMUFvQ2pTNmc2YjBF?=
 =?utf-8?B?RkJXM0RTNURTcE1HbVFwRXFHL00ydk01UE9WeVVBaGtWUG5aUGNKb2hJYXBr?=
 =?utf-8?B?WC9HYlhja0NwVkNwRCsxZmlucGxjK3V4NHpUZC8xYWlwM0thdTBEb2ZJalV6?=
 =?utf-8?Q?JnNzza8LOZL2UHIx5lCzmR/IR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qEIRDadXDMvvsqa02UjwU74vj6sRGAS4Kn1NaOPb1n+YhZYNBLIpIzI6YAoljk+lmZ++Mef7tl8HEx37reLcC395grlmKEtsguKg480UMiA/bXfriZuU5dRq67MPioe70LB01iJ3Xb8/yVb4Xa1jQOhNKZMXkBeqIqmMc5MuVSrRka8WtEkmkx60qXGQ/dUBH4R3hMU36V1Tf/QKdddE2CpEtg0h0L75nS+7s7k1qGWd1F8enFgqQ6EvXV237LFPSX7yLYcaSxZJQr/yXZfHZ5T97GMNWZg3YWz6biNStmkA7d5aZShl7r3fS0Rqj3kkJKBRbN2nqxk/605gdTPmFFzM6QXZ/RNxBIX5TexEYWPV85Ssq1KUvTiMz7avne1O23EgOzviNHgh5b018EMzJb7hvnqF2hSCPM1B9WsRwCoHGJw1oEi0ey4htjq5nqyO/BaH8Yq9+TNgwvmW5RV/V2xHY9iO0fk7AQ7zOgrXa5QzOi1BRhYJIclLx5b2INt4J8I9mp709sqQkiL0EvDStV6p7/ipMZdMQg28Dz2VfC3tXEt1Mop0IgQwhZtLFKMk01eMxO0mGaFPywQ0uZKEnoMYdJmIkj1UjqaQ+MlLZ1k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ebbdfc-9429-4324-09be-08dded584d2a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 15:16:06.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ar4JEQRXQqHUQZ01hoN9TVFHHcQ4HInQRXB0ikRHh0VSLb3XwvfZCoxK+t0Wv2sRJM7D+yYsPbM5n6YsvwdBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509060146
X-Proofpoint-GUID: 9fltIo7A_948IgzUWcg0kR5oN00hKgS3
X-Authority-Analysis: v=2.4 cv=EKkG00ZC c=1 sm=1 tr=0 ts=68bc503a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=drOt6m5kAAAA:8 a=yPCof4ZbAAAA:8
 a=fTXboX_nnPtUOq1DmN8A:9 a=QEXdDO2ut3YA:10 a=RMMjzBEyIzXRtoq5n5K6:22 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: 9fltIo7A_948IgzUWcg0kR5oN00hKgS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE0MyBTYWx0ZWRfX9ffLxDjUMpG5
 usPLmhK/51IFSConKwwCzvCQviQVIv5cOkDe/p7RCJA4vOYsTFAUtYwQIgrPeLjIYERw+pFxXTQ
 6HFctqmzRk7MgMlXuzMCMczE3BjyVS5EeqnTzRrB+2nNMLNrEY4Zl8prlAYFRSx1S8cu4jIPlUH
 7fSYRrEcq/2P1nznhl3CKzmo5xkSm/L/LdQLE01mxdPwxfyP5/ydS563e1oeZmbIKcpus8t07Ad
 GUua7PLEIl9q2zPR3XnhyGjlRRTcFYFx70cJt3oWULZFz6BhyNEXB3R+xHXihMApFx5ro/UO6fr
 9s85OUd5VEYHMhEAB66wext0kUxB+uwuC4mLSa8YSs/muvcGxlsGrd88v8+JrUD1//FtVQQXB7L
 BaK+bNok3cFaHSCBFjIJzfLAsihV0A==

On 9/6/25 5:11 AM, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/nfsd/export.c | 2 +-
>  fs/nfsd/export.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index cadfc2bae60e..dffb24758f60 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1181,7 +1181,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>   * use exp_get_by_name() or exp_find().
>   */
>  struct svc_export *
> -rqst_exp_get_by_name(struct svc_rqst *rqstp, struct path *path)
> +rqst_exp_get_by_name(struct svc_rqst *rqstp, const struct path *path)
>  {
>  	struct svc_export *gssexp, *exp = ERR_PTR(-ENOENT);
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index b9c0adb3ce09..cb36e6cce829 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -111,7 +111,7 @@ int			nfsd_export_init(struct net *);
>  void			nfsd_export_shutdown(struct net *);
>  void			nfsd_export_flush(struct net *);
>  struct svc_export *	rqst_exp_get_by_name(struct svc_rqst *,
> -					     struct path *);
> +					     const struct path *);
>  struct svc_export *	rqst_exp_parent(struct svc_rqst *,
>  					struct path *);
>  struct svc_export *	rqst_find_fsidzero_export(struct svc_rqst *);

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

