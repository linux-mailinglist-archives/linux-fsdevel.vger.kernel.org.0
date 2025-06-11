Return-Path: <linux-fsdevel+bounces-51329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F71DAD5923
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABA21BC4C20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D90283FD5;
	Wed, 11 Jun 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BxAdx2UK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wCl/IUlL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD55A1E485;
	Wed, 11 Jun 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652934; cv=fail; b=A/jynDloUL7/k8vAhlHOphS9KbbQGFiq8JVnYHFqp7pQjDTCfE/KssaD4KmRWUqpTlbZ8HXRWDJP+4PHDzEeZAnbSmFSmRTG+oZJW75tKOmkrhCQKvhdY4d+ZTBI826btpgHr4LLXOfk+aPKHrkggjc/Nb9RWXrbastyU/13K2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652934; c=relaxed/simple;
	bh=FcCuwYnOGr/kR5niWWgD95dq1Hfef0D5npCjO8d2MQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VjxTl2qg9yaO8wrcyZnXsjoli0LOx/A8wv6wUTyzKBePHiYKEwa0cyYEcKzeUyQEAyj8U/xuz6Y4FAulfcIA/TNudEFr906N07etMY6aXZ7p1hEM5/RK7rgzD5wXhpN5GZjBX6lYvcmaoBAzaOU3LKre/fBOnn79ot6cCD+hNmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BxAdx2UK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wCl/IUlL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BEfbtY029878;
	Wed, 11 Jun 2025 14:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oJ5GtGEx2WOKif7x+yczpY91ULWiKtt5yBcA+/Vz00U=; b=
	BxAdx2UKPMm/egUDmi/eu8VzNsjLLDK2WMkvaQaIWvhmz/VHxFpvdr9CaFmB2kJJ
	wOA9LG3pASVSi18m6TiOlnQCzpnwm9fvTsEs59/zkGLdUzlCJeQGJGsD+lFNZDjO
	pI0cCWZ1w1F/QPfC9lFb7qpCG5ovQttklYrFHzzJVyXvLlCCiNateDEfzZhxqVGO
	zfMZixCUMP5hz6Lawev8ZnzKJIhz1Yj20OOBoEZ7AS6l4cTmPJn23vMjWay/Ddwj
	kkxWn8YyO4qYqhZzvn76xbaLQazfy7u/CxtBHfuQJNzzBwTUwxc8mDmJXq8/LCsF
	Put/aAPkNfDG2J55qz9Rww==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14fhxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:42:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BDexDe007381;
	Wed, 11 Jun 2025 14:42:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bva1su1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyGgEJM6Ev8tWS0wL5baCfFP8e5VWcKLLErteZyAJ2A01hQGBN3LlBmosTwcCLAv61LLcIl8XsZG0qGbjzLBAUwiABeNgTk5Sd172L5cZeGsyh4qzz+z6DeuMO81JcEsqqXJMvY+EyBwmo9bZsHrBD8DqzS4CEOL8+i+OoC6sX4fHvx7U6DKUdOm5kWPzhlWgKA3AjMxo2il1iFL1M8JV/wdP4FWO4N0athz87CtF1zAtqfm3+6vULYPXY+d+WtGimR++0QfXzuwsADmi5dTKfBAjYr2ijwh6wJmPestR/8p4WiWoelX3R/Vnn5Bj7dP2Ernh1rDCwL9Qwm3Fk9F1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ5GtGEx2WOKif7x+yczpY91ULWiKtt5yBcA+/Vz00U=;
 b=Uhl2/ujjHBxKyO90h0RnFzNGVuSsSVzCo53BbPHiQrEMVFGxffQwnLeTSlr6TmPXzhceFiDSrhk+Llbax2HocjdImXaKiqqyftzufC8HIA7WeMRjmX4cdakrWhNhgsXoBKIC35BmbnSP/M+PbIGIhk4OIEJ1RsXbq9Yr1Y3gaippa8cEBMNkqXiPQBQzAgECZ20pqxJRVpJplE1+SiTnb7fXaimKlSO/taUU6ZzcObomXUIVymEYX4riDpBI27vYnbroCdXSLtKeCjP57SUioLM7YaP2fa+1Q5J8NDtm1rheKc3lbuRLFxAp0FDt0bUUTQI4dD24zIlihBX3itIbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ5GtGEx2WOKif7x+yczpY91ULWiKtt5yBcA+/Vz00U=;
 b=wCl/IUlLb2JwGCXxv1F85Y+m/C2KqabrVsZDyPMyu222fpd59R5LFZkGTcgpO2IbRG6RVtKrwV8XqIjE/aEtJTvKUPcNgEZ346+DYfhmzMHskw86ZP8LlclR+CtXsKwn4m9JtOx4nR1OBrfaRMPTbFgNLj8mSbpJXkzAmRhuKL8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 14:42:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 14:42:03 +0000
Message-ID: <36698c20-599a-4968-a06c-310204474fe8@oracle.com>
Date: Wed, 11 Jun 2025 10:42:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-6-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250610205737.63343-6-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:610:5a::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 43604baf-6f97-4ab1-67f8-08dda8f621a1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bXgvc3RHMUZlbEdoaTdUZjM0YTdKak4xQUw1N2RtcEc1KzVIQXF5K0swcVl2?=
 =?utf-8?B?b2p6YzJtN0FNclFLcnVML05BRlIzemx3MUhodzlUL0cvTXV0cEMzVm40MWZx?=
 =?utf-8?B?dHN0L0liVmd3NWx3SmZFKytLeTIyZHM0Q2tPQnhQMTkvWkU3VitQaXhRQURG?=
 =?utf-8?B?NG5OM0VJaVdlR0JFenNhcm9PL2gvbUN6cERUQU1aSGRhQnlqS2RlVWdGb1Zy?=
 =?utf-8?B?R2kxUTMyZFFFbkNMN3EwMVczWWhHalVQMWI5QWIzN2xhdmxveUN0N2pQeVow?=
 =?utf-8?B?T3NPN0dheERrZndEZDAzcFRWU1RuVWZOcGJ2aDREaWFiQWFsSTlram5zbCt2?=
 =?utf-8?B?c2lpUDBTYnRtaEN2VFpJOHBvTCtuUGtDVU13K1pINzF0VFpXdzAyRkVrN2M2?=
 =?utf-8?B?Y1ZaelAvaWpQKzNRbVRBK3BuSG9CbndTZ0dGcEEyb1FHNkpkTXBINnlyQUQ4?=
 =?utf-8?B?SVNjbVRGQXhSQ3RCaTdHWFJxcWIvWkg3QzVZQ2hMUlNrZ29Uajh6UnlYUUsy?=
 =?utf-8?B?KzRVZFdjOXBVUUdHTlEyRWxIeGR6L2JDRE9penhqekYvM2l4MUNyV3QzQ08r?=
 =?utf-8?B?K0J1UnQwUHJqQjF4NXlZcFVFanFPelNDUFlVbjQ3ZitCdFZSZkhFUitaTThC?=
 =?utf-8?B?ODVhaTFBbUYraGpER3BhTENPRlJEUW9LOHp3VlJzSUtwRHkvTzQ2WDdyTXFj?=
 =?utf-8?B?dzdIY09UVGI5MFlCSXpxTEszMS9udmJKRkcza2V4a28ybERXaElGR2N5YnRE?=
 =?utf-8?B?L0ZTT0g2MlNUVnpEWStQNzM3UnBYNitCbGJzVmxYdjgrdkNpS2pHenB4L2VL?=
 =?utf-8?B?VmJDZGlwcDVrNWg3eDdNSndwWUxmV2J5YmVhc1hObTlXUS9veHdlMGpjbkUw?=
 =?utf-8?B?dit2VzBoQVNGRXpkbER6cHZWQVhWMDR1ajVJUVlTeHl6Zk1vVUEvZXZJUjZl?=
 =?utf-8?B?SUJJUnhZRm1qRlNFd3N0MGJ2VHZlUEV1ZU1NTUY1MlFUbWpGclZ4eVJsTHhL?=
 =?utf-8?B?WU5zUVMxRzBycVhPZzFXcE4va1V4YjJXbEdEYjdydWFFSUdsRld4bVd2SVJq?=
 =?utf-8?B?QnVHRVhiK084YkViemVVTlJRNHdXWm9PR2F3Ylh0SHNuQ2NzQ1lwZStHZkIz?=
 =?utf-8?B?Sm9yNFJGL3BDN3U4ZTQwanRTNTRSdWtPVVZ4OGhLNmpadmFmbExXMytLcG1h?=
 =?utf-8?B?MGY1NmE5dEc0ZU1NSGhmZngrK2pmSjdvTFRyd3VWcTZjZ3RZS2VIL2NoSVFo?=
 =?utf-8?B?RWsycVdtUnh5eVVlc1N2N0d5MWtjeGwyNHdBekNPU1Jya0lpWks1ZjlHRTg5?=
 =?utf-8?B?TnFSYVd1bE9sU0lzRUNYampkU3grcjZRZ0N3ZXhybXg5Z01Ga1FFUzVzYk9l?=
 =?utf-8?B?S1pkWmlIbWswc0JtK0c5dFlYYXQxUVR3TStrWHVuUUNGTWxEWDlTSUNoY293?=
 =?utf-8?B?QlhsY2FXMFdvWTF6d2xjNXNhNVNwMGo5ZTVEOVBMUUJ2anZWcnV3d0Z2QUEr?=
 =?utf-8?B?SXFWVlRWZW1Dbk5kR05rSVg2NkFnelpodnZzcFFWdkdOYU5YbTZNTFlXL2VL?=
 =?utf-8?B?ZTR2bGs5YkRPcGhMckF3VVdocS9jNDlpVUMyT0JWcjVNMDBrV1pCMXY5bmgz?=
 =?utf-8?B?RXFxUlhGS3MrTGRGZ0JlK3RZZmo5c0c5RVlUZ3pkdjFwNTRqOVJra2xSY29T?=
 =?utf-8?B?TmROMEUzMGdWUWdETHdMWEFPeDk2dGVGNkpsM0JZcVFuNVZUWVV6cGJMUGZy?=
 =?utf-8?B?T3FYMW00VkJHaUc0bmdSNXlwcmJuSHJVdi9kQnpOdld6K1J0Wjl0TmdMZzR2?=
 =?utf-8?B?dTEvdVROWFJEcG5vcTBsb2Y2MVRySHFlYm5YZEFVTm5aVWU5WEptL0J0QVlm?=
 =?utf-8?B?eGpmS1g2RzNZOUhmZ09EcXpZeHJDZmdoQ1JZWmxtV1pqNDEyeWttai9lNkJM?=
 =?utf-8?Q?vcvOevQxvYw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MmFYSjhaNG1pcjNmcXFIZXhHQmMzNWdTdzhqT0lGTm4yUWt0djNheS9WUkpx?=
 =?utf-8?B?WTVsTlA0dGM5ejB0bFpZeUt5MUZPZ0t3dWtJUGdVODNxZlJKZll4Z0dpMlJ6?=
 =?utf-8?B?cjdZTjFiRjJmak9rZmVaL2pUd1hJZ3R3NGZ4R1N4azkvS3kyRVIvVkpCUmlC?=
 =?utf-8?B?eDFFV0R1WWhsWlFZekpqakdJSjVMZDBvNnQ4Q1RtYnBQSXJSLzlDSU51aFpr?=
 =?utf-8?B?bWpuK2p4NWR1NHF2cElIVmptV2ZoQmJpaGdiNHJoK0ovNjJheXVteWxQRHVD?=
 =?utf-8?B?SlZkdnFSMG9HZ1FEYlZFSVpmdnNYTlpEdk9NN0ZJSmp0RTBWYURvejNyOVF6?=
 =?utf-8?B?d3FHVzJmVE9aTHFzcFVzQU9nT0VjOUhKT3llS1Rld1I3SUNDMEpKdTNZRXFB?=
 =?utf-8?B?c0pzS3dMR1V0NWMrdzNqdE5JVlFnMUFuMXNjeHhXTm1JVCtPSHJhSThKRllp?=
 =?utf-8?B?UTNvMnRmekY0YnZ0V3ZBQXk5NWo1Qno3YW1KbGhtNmNlRGRqTzFtUDNEVkFi?=
 =?utf-8?B?R2ZNdFVvYmdkaFhibGtJeWFlcktCQlRPU3pJc3RBcjkyQkNYeGlxU1FGK2hO?=
 =?utf-8?B?ZFBWNDMwd3RVN3FqUGpSQTVxb1owZDByWVJTTkNQS1hWVTF2SklCbEZFdFZY?=
 =?utf-8?B?T2RleFBUcmpsNDVidDgwRDJKOWFJdXB1MmlVUFRWbkJTQ0wvMWFPUWU0RUpV?=
 =?utf-8?B?b3FjNnMrU0dUamthYkNPd3I5b08xNFdmSTFoQkxhbkFyY0c1WldYM2FEbXVZ?=
 =?utf-8?B?eXdjZWx2K3puTGdmSXpTUUM4ME1FRVozM2RvMi82ZEFyd2swemI4cjVUUVVr?=
 =?utf-8?B?NXpQbitFejZ5Mmk0Mm5NeDVEdUJ1K1YyYy9UU2Q0QUNLQkN3N05JUjYxOGts?=
 =?utf-8?B?aWxBT00ydU50ekdoSUlxc3V2UWxPR0txSFJ3SGdnSUVpYlFUaHgwUkFHY0Yw?=
 =?utf-8?B?NlpjMG9WR0FDN1Z5c3hqb2tqRlZGVUxjOUZsUGZzcmEwdFRjZHJwWkpiVjVF?=
 =?utf-8?B?dzdaOUNVNWhHSEZlT1NHRE9SYzhhcE5tdm4ySFRpNFlGZ2ViR3NPTG90SGZW?=
 =?utf-8?B?aVN6UC9PVDVVc3hsUzB0V1BDVmltRDVjcmRNV3ozWTE1dW5kQ2NQQ0h3Smpa?=
 =?utf-8?B?c1laVGJ4SDdCaHZjL1Q1MmRsVVp3RkNPQnAzb1hBY3grSXRGY0ZsNjNOaHBW?=
 =?utf-8?B?Y1FxaC91cHptZ2lZWmtOc256U1NFaStSU2kyYTVURHZFYXJmYk5jSllKK2tt?=
 =?utf-8?B?b2FZTXY0cTJ2SUhLSi9SbU5pRjBFMmRpN0g1cmpuNldMOS8vbytrMDBnenQy?=
 =?utf-8?B?OHZsZVF0cy9LREhLcFgyNU5xQ2VMTGxQQ3RQUVhaM2VTWDJSaG9ZbHdJanlY?=
 =?utf-8?B?N0RXSDJReHJZNnUxOFNUbVc3RjlIUHFkZ3RlYTQ4bjNuNmJZdjZYSWVoYjJ3?=
 =?utf-8?B?YVRHMFdzbHk4R08xVlBJUm51TE5Bci8wZE5lL3k5SVBCOEJaamJweHdqOU9p?=
 =?utf-8?B?V05sQ2pRNjZvMDRzNk5zRFp2R0xKcWVtMkpSQ2ZJMTdQUGl2L3RZWjhtVjYv?=
 =?utf-8?B?eFFmS2pUSHZ3ZlVScFlDSThxVTArZHFQSnRJdlJoRmZXWkM4c0NLdlNBSWVH?=
 =?utf-8?B?VlI1bnpvc0wreHhubWNlaUY3cXFLVXQzcnRjSUtpc0xteFdTSVF4Njd6NmIz?=
 =?utf-8?B?MWY2WVRrREhGdklteTUxTTNKaGQ4WnZRU0plQisvTXhYQXljZS9hSXdrY3Z4?=
 =?utf-8?B?eVlXeFdTQStyek00QXNsVGxwbklYZmhidEVDeEc1RzJUVXBVSW5XTi9DbXVl?=
 =?utf-8?B?V3FQNjlsQXNGT2twYk8vMjBkMjhxUEp1WC8reFoxSkx0SGE2aFQvdGRSY0FZ?=
 =?utf-8?B?SmNpK3gwVTBWTFdhWkc1dFpyZWloQzk3eE54MHZXbFZ0REh2bUN3Z2s5Sk9C?=
 =?utf-8?B?ZW0zL25FUGtkakhYTWp1N1FCQnF6bDZkVWF6Mk9TRFp4bDQyaHp5VEhxbitn?=
 =?utf-8?B?eC9kYlVZdUxqUmFqaUNud01wSlBYME14TGZaRGlhMDJlZnJFeG9rK0E4U2tt?=
 =?utf-8?B?d2ZCQ0JNd2hkemF5SkZYdHBkVFhvNEU3djRUTDlWWEFBcUZyMDZHQlNPR3RW?=
 =?utf-8?Q?SZH6/Fg9+Kzr6G8ymg9erSK9Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vPGE3GcDSajFAAMpGuJMyF+0fxLmN/9LSCvPJ8VJaPdlGz9z7m6H0RxZpO1jL+AopcDtja/+FWrEgbY0c8Afm3L96jRojgBuEY0B7fTPqkIlKnHhxvWUs23Y2cW4InDX5kzLvDhfhTHv30Jrh8CXGTT45+kI2kHv7ZfVNNZ7cPWAOkESa0LC+em3iGnbJj3ZmF7o8wvF9rlps/3bYc/hft9KuCVtaJuv9iX7jFAH5hviQXG+M0TI0ScpXkNxsZOFdkLzg23/tcwYOWhWjhDb+V3maBqt2jRxMexrZmAuPlTuTlG5ZENymEnmXpUNVpybvsT7MHrkUHdcU2+8PFZz7fw+f6T18HvCfIPQQLtS4HEVMuedsc3zkPboW0RIWMt4kwsc5P5SKz4HjSbTEe7FnptNC5RQ8gLZyAqBVF8fOWrrqf/rKcSyFcjIncltnSZFflH5nuXvfA18Z+TCXS9Ra5uzhHWflN9wupQ6d6a2APi2S4vkgSFMqZ6EnU/i5gk7UZZx2VOZw3AaTV+FwC3SPUFU2VMM+UPy5PASSoME+cYg1NEjHbRcYPeDnfrXyIJA4Ozio4TV4CC76vJPAypbVpTHCYWfVcnwhFj4IzBRL5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43604baf-6f97-4ab1-67f8-08dda8f621a1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:42:03.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmxsHZVyYe+dYin8WvQN6M1DhlsCdrdnXXODhhjLG0byIXLwTdbvYqideZVskZqlJIVRshQfoK/AWCjFwAzWhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506110122
X-Proofpoint-GUID: JqkhkIpKpM2Yr2RbqnB13Xm0HNAtu8pV
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684995c1 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=bZWSKylo5WoFJb3XScwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEyMyBTYWx0ZWRfX86S7O4CnXV5C +1M08jcrCZqW2GyZCSq/w/1Hd1vi0r95muGl9vVReJQj8RGBKw68ZV6R9IH06HANqcCbcT2E6R7 pDzeFTjewycIUpxzNlYcKg9Sg7akd3PJ2N47xwJzPd1C160HjZRGOTG6J/iY1ttzSdSaEafNDY5
 kmyvIQsBu26vde7wCnXP3hsTPGWnO37x4eaval+swsV6nIulw8X23B9qaRee0jBRQrCFtb0LFIT Z54jkEyxdjveqGRRD6tNlZQ6R1e1tFFcm/uGIVOXXA5VB1QPvwKgn0owTVIPgY1ky43X+L95n8M tqWPYSg2eLrbCNrrwgKoRoWiVjAGU4TByJ20au8j30zPoWMH89Zw7d4LdzGxO5Y6A0V+Ep/34pi
 HJSmS4cMc5dhM/taz/gI4uQ1g328o5cOTJp1ZiCQlhqPnMzpnJJd7bYiv0Dspo+HJuGyIJ4U
X-Proofpoint-ORIG-GUID: JqkhkIpKpM2Yr2RbqnB13Xm0HNAtu8pV

On 6/10/25 4:57 PM, Mike Snitzer wrote:
> IO must be aligned, otherwise it falls back to using buffered IO.
> 
> RWF_DONTCACHE is _not_ currently used for misaligned IO (even when
> nfsd/enable-dontcache=1) because it works against us (due to RMW
> needing to read without benefit of cache), whereas buffered IO enables
> misaligned IO to be more performant.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/vfs.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index e7cc8c6dfbad..a942609e3ab9 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1064,6 +1064,22 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
>  
> +static bool is_dio_aligned(const struct iov_iter *iter, loff_t offset,
> +			   const u32 blocksize)
> +{
> +	u32 blocksize_mask;
> +
> +	if (!blocksize)
> +		return false;
> +
> +	blocksize_mask = blocksize - 1;
> +	if ((offset & blocksize_mask) ||
> +	    (iov_iter_alignment(iter) & blocksize_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  /**
>   * nfsd_iter_read - Perform a VFS read using an iterator
>   * @rqstp: RPC transaction context
> @@ -1107,8 +1123,16 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
>  	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
>  
> -	if (nfsd_enable_dontcache)
> -		flags |= RWF_DONTCACHE;
> +	if (nfsd_enable_dontcache) {
> +		if (is_dio_aligned(&iter, offset, nf->nf_dio_read_offset_align))
> +			flags |= RWF_DIRECT;
> +		/* FIXME: not using RWF_DONTCACHE for misaligned IO because it works
> +		 * against us (due to RMW needing to read without benefit of cache),
> +		 * whereas buffered IO enables misaligned IO to be more performant.
> +		 */
> +		//else
> +		//	flags |= RWF_DONTCACHE;
> +	}
>  
>  	host_err = vfs_iter_read(file, &iter, &ppos, flags);
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
> @@ -1217,8 +1241,16 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
>  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
>  
> -	if (nfsd_enable_dontcache)
> -		flags |= RWF_DONTCACHE;
> +	if (nfsd_enable_dontcache) {
> +		if (is_dio_aligned(&iter, offset, nf->nf_dio_offset_align))
> +			flags |= RWF_DIRECT;
> +		/* FIXME: not using RWF_DONTCACHE for misaligned IO because it works
> +		 * against us (due to RMW needing to read without benefit of cache),
> +		 * whereas buffered IO enables misaligned IO to be more performant.
> +		 */
> +		//else
> +		//	flags |= RWF_DONTCACHE;
> +	}

IMO adding RWF_DONTCACHE first then replacing it later in the series
with a form of O_DIRECT is confusing. Also, why add RWF_DONTCACHE here
and then take it away "because it doesn't work"?

But OK, your series is really a proof-of-concept. Something to work out
before it is merge-ready, I guess.

It is much more likely for NFS READ requests to be properly aligned.
Clients are generally good about that. NFS WRITE request alignment
is going to be arbitrary. Fwiw.

However, one thing we discussed at bake-a-thon was what to do about
unstable WRITEs. For unstable WRITEs, the server has to cache the
write data at least until the client sends a COMMIT. Otherwise the
server will have to convert all UNSTABLE writes to FILE_SYNC writes,
and that can have performance implications.

One thing you might consider is to continue using the page cache for
unstable WRITEs, and then use fadvise DONTNEED after a successful
COMMIT operation to reduce page cache footprint. Unstable writes to
the same range of the file might be a problem, however.


>  	since = READ_ONCE(file->f_wb_err);
>  	if (verf)


-- 
Chuck Lever

