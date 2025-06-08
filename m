Return-Path: <linux-fsdevel+bounces-50941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF10AD14E3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 23:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7617A4CD6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 21:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2950625C703;
	Sun,  8 Jun 2025 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PPPDGqvr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xzCBLEbl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94026AEC;
	Sun,  8 Jun 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749419567; cv=fail; b=fxjJMOC7N4PJoltl+s2RU2LoEy44xeIHOV6cfvjRrbfFU8Yr8GqLd8CUId2Lw1LwAg6gLEYqw4jIBUm9RVzHhHxH7DFG6aKRvEyO3Vsigk7JB0cvA1+WxugBHU5gkOj4JAWVIockIfejdwu6gB+C+v498DK1sTSkQF57FePtvTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749419567; c=relaxed/simple;
	bh=cNDtjn5mhyQaTv21kpfClUJji6pI3G42x3zbgwitnTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qjaj4fNJIBKs2OT5zYobN20QiOEVVGvEId0Pxa6aE5TRGMVAnylUaH5jw0n8mjFO7p9rDpaGaCWErVfbhwEMxPQKz1++im0JSgc1NulnXIdG0vmmbyJb0eZmg6G7CGmzXtAN1G9S0csyytz0YAcKeT7yLEwfTZcOiGoauScCKTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PPPDGqvr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xzCBLEbl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558LU1Fv018973;
	Sun, 8 Jun 2025 21:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1/K5MkgDscqZBttZwOnAXyJHwwPQ/6uRrL36KCMNCrY=; b=
	PPPDGqvrGSj0YN/qbEzK0YRAsSUxMrNWK6m3X/HPHpcaIxYXCjNDHazizAnnUv/E
	PABTQO3CxeTWYubT5894zINcGXMycgHGISTLIESN1ufYTUOIxjoumMblkoeq8iyp
	DAIkVzBYKg+0iPy/4FCPCLmmBdGZuPNf7y357WxbzakNd7xblFzzUGyNcM1xz+l2
	+eaeO6+pn2wpmnJ5+WFaY4V1oCQaazXTlL3QoonvpnT72W9PVF+soO/5pVAg23zU
	EYUVfVQ+SVopi1oCmpJY3FLfs21+G3F0SYhHGT8RGx6d1qDmPACqjquvHrEz/6y7
	16Kn4UTUYE0Hyp/G9FUEAQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyws6ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Jun 2025 21:52:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 558Gdu7d003975;
	Sun, 8 Jun 2025 21:52:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv6tg40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Jun 2025 21:52:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYBAZVDrW1v8bierFuDXsFaMXkottqqxEKwo4txONP5e+c3DzPgUxR0SZzzXtHVPt0Z8LAmsrBiT78f8jeh1FAyBAsH/O6+OOq2ijJAD32s1JqaIn/kbQ//t0LKFLqoBYf321tglN8hRdwVfUvS94drVEnX0HXw9vM5HIweULtOj2EOA4Nkg9XYDQKkY7yTw21m7KekypUPyRsTbyNUqCVu9h1lFQpLsh/p9vDftZ5Yhg6/Ee5iv1O7HzmQy0n0oJktOOcNAWJBbItEoGUs16O4IjM64tfsxX1kS3JquHBOJ9NT1Xf/6K04bFeCsLE3qXBcOZjMAj/8VosDD/xy8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/K5MkgDscqZBttZwOnAXyJHwwPQ/6uRrL36KCMNCrY=;
 b=rExWfohKnxglJCbECvpPduhlZ/9K2pqgPkkZJVJzBbF4QghkERjg/UOGHXFe1nksDOveHjQD/1Ln3rqYdjaI8wsSVCcMuWYPE2zh1xImXvRyaecBKQkLFwMQsJTrllo00BmOO0cg4EqsizVgQBqxpLBIv9KwRBlq4SXvCvQ6gbKXhtIBvd4P/1LbaiHAJCYP0eETWcFZ86Zlnu4bGgSJnvuuzMh3zqNBMiqZ45qiGsuuCEuLcshSLPbq0e2epNRrqZ+M2JyJZZ6j4KNlUvjhkuGAzufPZudtx4ALpsJicgx6Xo/djjG5wwTToK7URnQBVf8nNz8tkM+jlirQefH68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/K5MkgDscqZBttZwOnAXyJHwwPQ/6uRrL36KCMNCrY=;
 b=xzCBLEblzPO+pYev6mj0hSzYhWl3MaNuqg9nF5iNmnuew0LFykLeDGfZ1NOfwG7REM2ZEzwPfFcg32wAsEkZa5/4lbzHzyfG9pz/xBZH+g3wy3dLw/GNgRPGNAttfE7FT+t0ZwFT6uNUkXy8z7RfmnYCN6N4pFIKdf1mcUbl4QE=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DS4PPF3B1F60C81.namprd10.prod.outlook.com (2603:10b6:f:fc00::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Sun, 8 Jun
 2025 21:52:38 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%7]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 21:52:38 +0000
Message-ID: <a44ebcd9-436b-436f-a6f5-dea8958aaf2f@oracle.com>
Date: Sun, 8 Jun 2025 17:52:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: LInux NFSv4.1 client and server- case insensitive filesystems
 supported?
To: Theodore Ts'o <tytso@mit.edu>
Cc: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
 <20250607223951.GB784455@mit.edu>
 <643072ba-3ee6-4e5b-832a-aac88a06e51d@oracle.com>
 <20250608205244.GD784455@mit.edu>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250608205244.GD784455@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:610:51::15) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|DS4PPF3B1F60C81:EE_
X-MS-Office365-Filtering-Correlation-Id: edb25ec6-be71-4d71-23ca-08dda6d6c8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1NFWlF0eXJrTWNSR2I1QkJxRXR4ajA1MjI4WHJUR1RUdkNGN2xPM0U0c2dP?=
 =?utf-8?B?VUJpZjY2T1VhYlpzcWxaSFAzSzBOYldZVmdaaXE2NThRNFI4Q0hBZiszQmV0?=
 =?utf-8?B?d0FXTTkzdmkxSDd0ZjNHNHg0cW9xN2U1bkJIMDBiRGZWd0NMSGZ4WUF1L0Nx?=
 =?utf-8?B?U1FqYWlsR1ZXQ0JBMnJ0OU5HUzNPRk9nSTBIbk1XbDdTdW9UZ2p4MXpkeFI4?=
 =?utf-8?B?R29ZYmNkSGFBaDlNZEg1bnFTTkRRSVZVcVNKeHgrZ2YycXVQTjY4R1ZDTzNm?=
 =?utf-8?B?bnlyNjFMM1FWWCtHSThEeGN4N1ArYThlbVBHYzRDNDlkQ3I2VmFhbCtpclo1?=
 =?utf-8?B?QWh6VndFRUsrR0ZRU1R1dFAzSmF6TkN5ZXJPdlBVVmhpTVBDMkxXNWM1TE96?=
 =?utf-8?B?WkJHbldwVTA4eWdaQXpwYnJFZlF4QnNIMEpDcGh2WTQyZC9DM2dEQXZvdVRV?=
 =?utf-8?B?M1JjcWRPTGprNlk2b1MwSHZ2bEZQSlZxelVwUS9rbkpacEJwam1pOEpiZkVI?=
 =?utf-8?B?cDQxek1tMGxNNTU0Nm9hc3I2VGlGVmN3Z2V2c2tjYlVvUkxwVGJCTWx4bjBl?=
 =?utf-8?B?dXlMWEFFb0tJUTRXYjhDbGl2SHJaNHliVllmcEYxaEVWYUUzd0toTXdmV2tr?=
 =?utf-8?B?TStOUVNrblVLNVZUM0orblVFOEhwVmZGNTFTNmtxU0hMT1MyQVJmMVJQdXF6?=
 =?utf-8?B?bVBLa0pCT29SN1RkWFBndEdHNTdYTHdaUjRPMHlOSyswL2FMVzFBa3cxVzB5?=
 =?utf-8?B?OFZBYkxEeEVLOHhFR0RGVTA4bGh1TjRTY0hMYWh1MWJEL0xFdlhJUW5HdFFn?=
 =?utf-8?B?WjdvNTJYcSs2T3RBVnNjUmJmWnV6NDhYR0NldElGaHVZeFEyelZMeWxhWFlM?=
 =?utf-8?B?TlhIQWpnQkJHNys2bTZtaHdDeU5Ha2Q1a1JiVVBRTUxLK3E2cjdRcHNxb05I?=
 =?utf-8?B?VVVwTDhxQmJ4RXBlWm5DaTBndXR0MFhSVHdld3MyS3J1V3YzSlJUNGV4QktF?=
 =?utf-8?B?V0VkUzlycWJjQnprSDhMVWo4UkFHVWMwWVdMNnZRQzl5VUpUQmJQY2srSk90?=
 =?utf-8?B?V3hqMXByR3JVQ0NHc2NXbXhycHdsTk9TZHA2TXdHdTVZYjRGOWF6Ym5VWEZP?=
 =?utf-8?B?VG1zY0J5QmpoYjJqcVVaRkhkL2hobDk2ZlMyeVUycDNwblFteVlpTDlTdUt2?=
 =?utf-8?B?ZmpoSFpLRHdBQmhaSEFsZnBxajJ3aDRNVGMvQkFTTDVOeUZOaitrQU1sRU94?=
 =?utf-8?B?Ykc0UTd5RVFtTkJNRVZLQTZMVFJEZU8vN3E0Y0ZDL2tIaUhkTzlaNEtld01D?=
 =?utf-8?B?VUF5YWN2aEVPMXh3aHdGcDBsR2U4ajAzZHY2K2Nxam8rVU1DMHZsdjVRbll1?=
 =?utf-8?B?ZE9mQ256K04vcWNFNFZCM0Uza2VvbnkzL1BzbEc1bUxPUkxtbWh5blpHdENR?=
 =?utf-8?B?WVNFOUI5Q3Y0THpTcFRtZExZSlhFcWdta0cwUURad2MrTjZmeExBaGRzUGpM?=
 =?utf-8?B?cUZmb01XYjZiN0NFZTYwK084dWt1UDNtamF5V2dWMlJ3ZXpFaThjNi9kRHJ0?=
 =?utf-8?B?YjdDOUVMWHpZWTQwYm10UktUNDZIeHZiRnJTNjB3bHZZVDdPQW9jRlBEQTgr?=
 =?utf-8?B?UGZBZUFOSkJIbUJiOE1qUHI3alBzR3U5RVV5WjhweGhsRnROWXFYaGlBa2Vw?=
 =?utf-8?B?eG9YVUsxd0VycllWcTFLT0RLcmUrV25LcmprUkdEdU55d2RieVF2dFpENE1p?=
 =?utf-8?B?aHVrU2Y1UmNIUnZ1elE3bXNGL1FwNjlOZEk0YkVsSHluQkVJV2R5VEJoQTdH?=
 =?utf-8?B?YVhRT2w4dWthM3NyRTZpTFNoWDUvTXZHd3ZyVWIzZDhGZG5qOC9YTk0rUE9a?=
 =?utf-8?B?RWxWdkxrT2Fia1RhZWhYeHdpNllaY0hPR041bnc2Ui9NYzhZZDdrVkhVTFJa?=
 =?utf-8?Q?un+fBQXjiEM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHB0ZVE5NzBESFNUSk1xTjJlOWRJWnBhUTJ5YVJka2Eyd3c2SVI5YzgyRlY1?=
 =?utf-8?B?NXltcUp1b3I0enRLS0NXUGFkTzVhbk1RVDBKOFFydUZLbjQyOVU3NkFadnpR?=
 =?utf-8?B?QXZMRll4Z3RxQ01udVZEU2NFWEp2cE4xN01Mb3IxN3JKMVlOUm9uMEhWOEgz?=
 =?utf-8?B?dCtPWlJpdEQ1anM4a1crcVZFRVZuaklHMkR6NnNrNXl1T2E4MFRlWGVNZ1VF?=
 =?utf-8?B?MEVHRXZaWTcvS1F5RTNkZ0xUb2hMWjZsUWo3dkJrNFA3MnZpek9KQkRxNFZr?=
 =?utf-8?B?WXAxdnVIa1VMeVhGMW43VzNjOEdTTXhyWVdxZnJ4NnQ1Z2NvNFJaL3h3YmNn?=
 =?utf-8?B?R0JZaS9iTlRLNjVLYnI3Qjg3L3RMR0tqbmVNUmVKa2JDdG1aYThTcmJkNGtj?=
 =?utf-8?B?djdmcVpKeXhpVWErL29pV3lNTHFHT3V5MzFKZERCRkJPKzlJNWo1TVhnZlN4?=
 =?utf-8?B?VXdOc1FydFZ0b1hCeHhYWlRqSE1KUVBKbVdicFBPYWZDT2Qxa1RIcUhWcFg4?=
 =?utf-8?B?TkpHMXFRcTlEZ1dMQnU1UGFiVTFnSlh0Y3NGVk5EUDZqR3ZUMnAxVGRJd0Jx?=
 =?utf-8?B?aGVqN0hoN2IxOG81ZW9hcUYwTkNJQVpyRTI5VnhaS1g3OVZQcGpSeXFCVzZv?=
 =?utf-8?B?ek9lY3EzRVJ5UU9zU2pGY0RXTnNDZzZKS054TnJYM2ZxM2M4QkNILzFxUVl4?=
 =?utf-8?B?UUNiRjJ6YzBUbXlUNEFpUEx1LzhjRTVvbll3WTJuWTI3Ym1XQi9BaWZoUVJC?=
 =?utf-8?B?QzdjNWFqQ1plRWdnWWZwQ1VraFJuWmFJbWl3VUd6SXFoblBVS2c0bXhxYnVj?=
 =?utf-8?B?K3lyRVhhVEF6eE9OZjIrQ2c3dVMxdWhENHpOajRGTzdNSk5rUGdUVlptTjA4?=
 =?utf-8?B?UjJOdzBUUjBPejE1ZWdhZm1wUUNDK1p3dzFsWWVhSlVWUmxZU3EzaDFiOTl0?=
 =?utf-8?B?dTZVMW14S2xFNVFkUkI3cnVVNTVDblZrZGRKdDNVcXVCT21EMFRFcUJnL1F0?=
 =?utf-8?B?cEdKZWhkSWVsWVFVNW1ia09pdkJRSEUwUEVDN09tMURCS2UrSk5Vc1pxMU9j?=
 =?utf-8?B?ckdXeVlvUTUydkd1S1hpUE1ub3U5dmwvaGVnK2pmSmpoSjk2akw2K2R4MEQ3?=
 =?utf-8?B?dE5wTmFjZEd5dG1VU0YwVGYrZUVVOVBCS1RGdFg0ODhnV2svblhteVZRRmo5?=
 =?utf-8?B?Vk1XNFBDWVJ6T2Ntb1JuRTRqRlE2dzZXYks0dUZzeHV2N3JqQ0NteUpwK29l?=
 =?utf-8?B?ZW9DQXUvS1dhbWZUZXp5TWNVR0pHNFhBTG1zemdBN1hoaU43d0pzYnVZK3FB?=
 =?utf-8?B?WHZ6dkprcXRqcEZ2UkppdjJGSDZ4a0FFd2c4NzY2eDQxUS9kZlFYTXdRRWxO?=
 =?utf-8?B?Qm9RNGF2emxqZHNrN2NxOHo5bUFnY01zK25rSERzZGRnN0FwbmtLcVdUYjVn?=
 =?utf-8?B?TWxPMk9NMStiV2hjUWVoeGNvd1ZDME5xSW9OZXl1NlhHMk9GZVFVN281bURC?=
 =?utf-8?B?UUIrZXZLcmJvK0kzUFdrSkpIdUdWRTNHVHRCb3ZGa0twVStOYWVWbE5CaXh0?=
 =?utf-8?B?TkFvaEErL2NLRFVydDV0VDUycG9wV2tDb21nTTRUR1o5KzlHYllnQkMraXNa?=
 =?utf-8?B?REhVY3k1NllWcHMxeUdrY3o0WkNFcWVnZDFYQ1g1V3JMa3lZMWtMVjlOekQy?=
 =?utf-8?B?WGY2eGZCSlhHbFpNNUtobVRadWlYditHWWNtd3pjUkdPYWhPWkgwMzdhZGdh?=
 =?utf-8?B?ZmVSUDdlWFlyYWtjRGR6Q3hqbnBhMkwyOUkxK0x1SW1rM2h3WHFrbE84Z3Rq?=
 =?utf-8?B?YTlTNlNYRnNnQ0htd0ZiTGFHcmcrajlkTTZRUDFWK0xWcXk2NkRnZDdiNmV5?=
 =?utf-8?B?YTg4eVNwQWh6di96c2JpQmozcTlzS1Y2NmFMTG9UWnVIczNQQmNpTEpWMmFw?=
 =?utf-8?B?VVlUSElhaGdGZ2V2dU9HelVtTUxkS0FUbU45SW90NjZDZnd4dUdWcjhkNkNH?=
 =?utf-8?B?QVk3UE11Z0loYzZGd0t4R1pBeGthbU1LcXdvdWRqL0ZQOS9kdEJoMWRmM1Yv?=
 =?utf-8?B?Mnh1UVd3T0dyMVdFc2N5QjNQZFNvZW1RNkZ0ZTZiV3F4bCtEOHk5eWw5c2hq?=
 =?utf-8?Q?Q9dyvoPWP5+IbuZx8Dc4ywkB6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yc3Gnm1GJf869IQMdp2CptEQuT13Mr0gdCfbcr5ph6IktxSKuhyWg2hb5ERGw9p6Ig1Rdaksl3ecG1lCy3kGObwXvzu+E+nUAtWeyJ31AA5ypl8F27BISwEU9apVmCLzpEd5OnPvvnr+deERuv+wSjJ9gIU3qPND/gh0uJ1HFp8h35xyfThqB+Slhk486t4OsZmBCbigEGEGXu94D4ZLQ/2/9/7RMEMTzZVSWXCnkPGQEqpcH1XMgqwl/S5A1xBB8pNcuvL8nd3CkAQOMHA51D/KY+1oM4PHx9JA0osj8OWzzq0PLhAUjo5o7zozi2UUBYAO+yIuWj4ciud6VRIpUpcCWpBx3hp+TBN92kx7+TFGkpVcwBG5nrX5D1eJ2qyMQitLHczmjqk+t8OPihZhAWGHmuaYZRX27UgvDmjIG2F6gQ3wpzxWCfJdYWhoV16PYFmD6roCm+EpQmttiRjU5z0iyZlsLG3mbbXESiDqIHgfs8T889blIDfuQ07PyfpWKgPXP3pzlC/1l1mPf4i1GvSrq1Ys2VtxWBGOxK0zAnb+icSaD2VBdWuLm0mfQKwixHa0AMf/qY3LXHAiozfONvbjDZ2SCFXrGukFBi//GRQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb25ec6-be71-4d71-23ca-08dda6d6c8fd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 21:52:38.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZRcEnqMOfoJGZp3iqWTYVf5/zyU8/L0CQEW439hc9HdGrIS5bv1kx+WcV2JB1GkoIUAwMqsFdQqMmJb0QnEeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3B1F60C81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506080177
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=68460629 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=gvl4HP8tAAAA:8 a=x0Q7JSsmjavWYkfBapsA:9 a=QEXdDO2ut3YA:10 a=tRkgsvjveJ3YVe9fnr1q:22 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: QXGxVeItAVZ5GujGf9bO6A06qxh3Ipzp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDE3NyBTYWx0ZWRfX8pzKC7GkP4Mm 7tGr1UYgYLLsIzrO9y41k07hG7V3WdhU0my22YaMPHbg2K0mB/emmpqaWM2BL/v037fCTjl7UbV g7ME1JznjLnvA5AAgdLnW9J9VF0D5knXiE8PypRV+vYCe/jAaI9zmO+IAf8tNPnmViSV5kIORiS
 7iP/Da38FHxSRbBXL74XH4Ao0veU25jXkbZxEZ7KOndXEeMNkWFnDzEzqNPLtxj+HkApKLKRlAS 6iYiYG9f3VOiHM6rn+T2kHYUQzX81Vym+g8cIfeT+sX0rWr3ApLFwlpMP3D7KwjufmLL88Cl9aD FTT2W17FKkuiuEC93h7rr+TuFr/o9ByxWDy2AWXfopFiw6Hhw/dXEM0EKkbP7Y5A89a4Jkz4xgo
 Haw152+G0x/svP9QYVu1XWBFEkkq572R5h+xHxHVPsLyJIzcyDxWPS2vT7DhMrmdGDrGfdAX
X-Proofpoint-GUID: QXGxVeItAVZ5GujGf9bO6A06qxh3Ipzp

On 6/8/25 4:52 PM, Theodore Ts'o wrote:
> On Sun, Jun 08, 2025 at 12:29:30PM -0400, Chuck Lever wrote:
>>
>> For some reason I thought case-insensitivity support was merged more
>> recently than that. I recall it first appearing as a session at LSF in
>> Park City, but maybe that one was in 2018.
> 
> commit b886ee3e778ec2ad43e276fd378ab492cf6819b7
> Author: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
> Date:   Thu Apr 25 14:12:08 2019 -0400
> 
>     ext4: Support case-insensitive file name lookups
> 
>> nfs(5) describes the lookupcache= mount option. It controls how the
>> Linux NFS client caches positive and negative lookup results.
> 
> Has anyone just tried it?  It might just work.  To create a
> case-folded directory:
> 
> # mke2fs -Fq -t ext4 -O casefold /dev/vdc
> # mount /dev/vdc /vdc
> # mkdir /vdc/casefold
> # chattr +F /vdc/casefold
> # cp /etc/issue /vdc/casefold/MaDNeSS
> # cat /vdc/casefold/madness
> 
> Then export the directory and mount it via NFS, and let us know how it
> goes.  I'm currently on a cruise ship so it's a bit harder for me to
> do the experiment myself.  :-)

NFSD currently asserts that all exported file systems are case-sensitive
and case-preserving (either via NFSv3 or NFSv4). There is very likely
some additional work necessary.

Ted, do you happen to know if there are any fstests that exercise case-
insensitive lookups? I would not regard that simple test as "job done!
put pencil down!" :-)


-- 
Chuck Lever

