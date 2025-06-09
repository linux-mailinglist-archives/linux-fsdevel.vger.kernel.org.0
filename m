Return-Path: <linux-fsdevel+bounces-51053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA6FAD244F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DEEF7A6AC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F6621ADA7;
	Mon,  9 Jun 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="COAIMWUz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y9fhThxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C0A1DDC18;
	Mon,  9 Jun 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749487322; cv=fail; b=uhUuhqYqDasye+jYbT5r8BiLeWagy5nGPjGc+6sxhnlJ7vGVu+oUaBgWY1zrMWvHZlWO8qSDeCGXXMajg2pAFx140IRV5icoBUkQhoHxAqi+inMmoDTrQxkZGBl7Azy1GZqXhAevhUtm5qxQDaVnc3i0wnJ10qzEAZSdV7GLGFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749487322; c=relaxed/simple;
	bh=nZWcb2alsouv5BPiP1DMYiXr4pFqfNRQrQxEixkRGh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iva8ItK18rRopierkJ6pPRsuFOwDeYpOsTY5yl4SXOXLmmYSxMTCQ6llBvfwpclTrxavpz/nStCWhKx8Zbf03ssR73n9nNcHw0WrzAo34nqd+CqxYw86PLr8/d9FWh/vlieCT72E9reQVzzrGCvKCN0iVEFhQsbPNwN9goReylM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=COAIMWUz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y9fhThxw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559Fdbvm006154;
	Mon, 9 Jun 2025 16:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GbMPTfXyQA51PGC7+gYkqnoYvr194IFNdefauKHYtW4=; b=
	COAIMWUzL2FsMA9xI0U9xhk6yFZ/+0F+OxTFF0JzJjyuzKaoWpmGNu5oQSuDm48/
	Ali23pDIf2lFbP+J4Raaz+gOo99bRFfWLmIfwmfpZv8oW11l1Gu1nZowFdqluY/8
	CMzZeqTfqXp5P/NkY+eg5QqklDx5ZxVZS3W/AnC2ddDHNYpt+Gt7OgSwymRXWn0u
	jCVhGuQgXMtDifs6RV51Y+jK7AU572uejXzuc4GG0iv7wenWUOzCUJ6db/yMEgUQ
	VuqwUnbMCIibzsGD5UuK2sqxPJqdsRlKkFygL0gfORPX4oCCJmeHkV8bj6iXIW/t
	KMaQVwQGT/1XTHF36rUGsg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjsvka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 16:41:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559FNCGh021009;
	Mon, 9 Jun 2025 16:41:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvdwewf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 16:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2QvD4HrLOmqRxgYMptzGlww4rlniort0j9M1tGAYAwuRgH/+vkN8CsjfmS6Du9k5vVv+aGn5hSCncPElPkNBZSeIs10Fidh4e481t54bYfdyTwQ2XCbKt/KtfW3ig022tXosSfv+89PIT5MTgXjQf/kydzXTYmcgsoh/3/TejyNoECiHcWtEhxedVKoPjPb3A/Ij/woWDKE5WuF3qkeZ7Ug6E2f8NWO9Sk1Qpx3gaEVlH9W5R28zy7DnCXXTw9jEpW940zspJ9ayM+niRIH8yJ5JoPQj7vnt/giDoTbu3x0wXMK+bhcjBDIGVoLrIkAE/fFUTSzPBNbDib3A/lQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbMPTfXyQA51PGC7+gYkqnoYvr194IFNdefauKHYtW4=;
 b=VjazxrL7DUJbdN8spasJYxu15D2HFrUdDfa3kHpit6uR6x6FynRGzWnlF5wp4d+EfpV4AqudtEHMOMh94r+wXknWFTSrr+rTKEOaTcYEF9L/LvYRZotGQJpuqZdwm4KAYB1wRIIdTZ1tqF6muiLCVj/U8ZM6rb0cnk2HPJ26HUCHtFTzfl9WB39cvSLobIA6RFDvAaLAYd3LqEtR1RSk7J2PFEUNGysyFGD7FLkumJmpRce64re5o+ZUAXk7QjisAIVuaVn2vhGrU0QbahQUQCF9xz7sQW7EIIexWT4K0Ru/wyac+/zCZC+70/Oe+EZLIpvoaiULgPhBKLXTxoGXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbMPTfXyQA51PGC7+gYkqnoYvr194IFNdefauKHYtW4=;
 b=Y9fhThxwGn1WIT30I+hwrux5wz+mrxEQoDgneihpuY3DT5bhTSpOlUO0D4pdR2tKGqqQU2XQnl74UVHL7NTpYG29OI8H1cN2vp4Xuzcv8SO+B8CKEMZQCbqSQz8A+UDjRjbqDRc/H5OsM48RxTnLL/GWB7VCDWsntGdc8Svuy10=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4735.namprd10.prod.outlook.com (2603:10b6:a03:2d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Mon, 9 Jun
 2025 16:41:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:41:53 +0000
Message-ID: <03386ad5-38e6-4f05-a064-f045e0d150dd@oracle.com>
Date: Mon, 9 Jun 2025 12:41:52 -0400
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
 <a44ebcd9-436b-436f-a6f5-dea8958aaf2f@oracle.com>
 <20250609155010.GE784455@mit.edu>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250609155010.GE784455@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b06193-ff4a-490f-184d-08dda7748a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFNjcXNrZjN1VG5LdEhZMkRBa2NJdlNZd3pJdE42ZC8xNWRLR253a1pIS2xD?=
 =?utf-8?B?dXZLUkgwRHlhd0VqVUp1d3pZcHJsYmpjdnNkWFJHTnp0bTBlNjA4SnE3SS9S?=
 =?utf-8?B?U2YxUDNtL0YvV0liOURpT0xsd3lTdVNKbTlwSTRnTGNDNGJPaEUzN29wSXlF?=
 =?utf-8?B?cDRBZmhhTittYmdma2FJQXFFdTdhQ1QwMmVER3YzVnpHNHd1dmpYZSt3bEtI?=
 =?utf-8?B?MEJxalhtU2NYVzRFNzVTdDdoOXhBOHlQUkRZTXdQdkRvYllIeXFITUNrSHdD?=
 =?utf-8?B?TTVlNUpadWJrWENtcWIveGVSYWFyeTFMblUydDN4MThRUE16MkptU3dFQWJO?=
 =?utf-8?B?NnVIOGFwaVBadHkvU0hXcWgrZ2tNcGg3VEplalhCVlpSSllwUXpsUWRmNnNP?=
 =?utf-8?B?UjlIbzFjajhUUXg5cm9BZXZsaGxKdS9pNkErcFpTVEVOTDdHeEVFUUN4ajhk?=
 =?utf-8?B?bG5oUEczN1paZmhoUTU4bDhyWkRFVmlPU1pQT1M3bEhTN3o4dlVWaGE0d2Vr?=
 =?utf-8?B?anYvOFZMeEFMOWE4YXVwOCtxdWVTaHR0aTNBYTZaKy8zWmxoWEVvNk93dmpS?=
 =?utf-8?B?VE9sRzdFaTV1emVITGxPc25heXJSRlFWYldZTmk3WlhjYTB5bk1Db29xRWZz?=
 =?utf-8?B?SVl6ZUpvSUNHTFpXMlBiRE5VZEtOblEwbVU1VjAyTnVTTGZGbWJBNjYyUlls?=
 =?utf-8?B?dHJXaFFmcGhkRjNHbTQrNTV3MVNFTGFROUQwL29UYXhNQXRkcmNoaWJieVU1?=
 =?utf-8?B?K2ZYZXJJMTY1NVNMVngrZ0JzK1N5K0FDT0Q4ZW9DREZxUjVOUGVlWTBHbDlF?=
 =?utf-8?B?VGZuUHJ1QWgrY21pWmVSMjZQWG1rS1pxd3cxNkdFRWU3UnVMelVuQVAwOGZC?=
 =?utf-8?B?ZlEzcHZBZC94dTJORFVOK0VrNmMyazZxSGFOeWtGdjNLUnZmMUdkVW8xTllh?=
 =?utf-8?B?RC9pK25WRDFEbHB2UXNGak9CUnVrR2J1TzlMeU9vY2dSQ1oyQVBZb0tOMC9T?=
 =?utf-8?B?MnRGeG5KS0JlNTNXN1lNb3Y3c21WVkdkKzdZN2xsQWM0MUdCRkIyWSs5dzJx?=
 =?utf-8?B?S2RFbFc2OHN2VTBTN09haWU0cWVIdDZBTzFHNnNHOTIxM0RGWkgyNnlpR1dH?=
 =?utf-8?B?U2krai9uSGZ0Q0JReVpOMythZXhrZ2RKVXMzL3RiaXQ5SmZLd2g4TjJMSC9F?=
 =?utf-8?B?VjdzZWNhazFTWXo4dFJENkF4Q1g3bjF2OWVhYVZOQWJ4VFY1MGNKZWhSOHZD?=
 =?utf-8?B?WGN3TDJic1UwRXArTytEYWcwMFFkOTBxUlBxQTB0TFdNV2NIYnBtV0VFWmlO?=
 =?utf-8?B?ck5uR3QzbFViQ01QUjl3UzFtR3hNRzhtaEV1U3pleXhmWS9oaE1PS2pJMUc1?=
 =?utf-8?B?Mk4zcUtUUmhML3hNL3hpMStpSTU4bllYRnFLbjFpNm1TSEJaQ08yUzREU09P?=
 =?utf-8?B?SFdpVHRXYm8xT0x6R1h5T2ozQStDZklYU2JXUVJydzhNM2srQ3M3TWh5eC8w?=
 =?utf-8?B?aHdQWVMvYTBOVmQ3VHluSTRBNlo3bllvcURiT25tZTJ2YzJRTjEzN2VrMjU3?=
 =?utf-8?B?MndQb0dtL2NhdGR4TDh3NlZLTmVLZVY1WkppNytqV21KS3hyUlRQQ1hLNDll?=
 =?utf-8?B?Wkc3aGR5UHBmRzU4eDhMYlpvZ3FRZmt3eUVodGlISVhtRmxxSGZwakxEVDRR?=
 =?utf-8?B?TFZURFhMeUV1M3NvKzM4YzN1eFhyUUdad1hxZk9jYVF6N1dVVkhmYUtGajFT?=
 =?utf-8?B?anpsaEhEU1ZVL2ltdzNobGhhQTNETm9yWmljKzhKc1l6ZktNRjN3YnR1WGk3?=
 =?utf-8?B?V1hPVXkyZm85aHNqQlM2YVFXZWM4ZU12bXA1azhVbFEyRS9lZXNGc2g1ZVFw?=
 =?utf-8?B?alpWUXpMNGdiWnUzM1N4NEJFYkoyaVpZZTYrOC93aUMwTUVYanhSVW9iVFJR?=
 =?utf-8?Q?PRSE1zPw8es=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sjd5a2JPRC9YbDZHamcvblJERFgwSFZWMGtLdUwxQWtrZk9vdHVLSFdCeE5L?=
 =?utf-8?B?bTA2VitmTUJ5VXQ1eThHMWhqaDdTT1k4bWQ1MVVoNW9PZFlDdUxNV1hPOHdP?=
 =?utf-8?B?dWRVNlpmV1o5ajVVbHpBSVhpRTk0M3BxWm5PK2dDdUdIZUxBdnU3RE9jUDh3?=
 =?utf-8?B?RXVQdnl2czRrSytTOFlJZUpFOW02aWI2SVNsWEZwYkg4WXlvUHZBZU9QaHk0?=
 =?utf-8?B?b2t0OVdOQkVTd1JvOUE0djJpVFZrb3N1aVlRVUgzMFVrd2R2b3lVZFNkOS9X?=
 =?utf-8?B?SlZBZEQxMVFVRW1DOENhOTlwcmJVQjYzNUM3ckVVbkx6cVRaMEhrWEM0aEV6?=
 =?utf-8?B?RE8zZ3ByTFVxbi85QXJUdDlDN1lYM1NIV2FRTHBvTjNUb2ZUY2dWbzVLOHdj?=
 =?utf-8?B?SWVpaXIzOWZxN1VYakRrVzBVSGs4NENTV0VDU3FVT2dMWmJFRWNkZTI4Nzhx?=
 =?utf-8?B?NDdNMUhGRldrZWFMN0N4Yk43ZlRKd25YSVFqRG1UQjd0aVpqUkVNZTB4dG8x?=
 =?utf-8?B?VnpoN1FvQTkzR3l2djE2TFNjMC9WZUtzYk9taXpwQ1ZHVE1BRTkydG9aSy9T?=
 =?utf-8?B?VnF1Nis4b1huZEhwUTlsSkdidHNhbWd1NlNNZFFac0VGQ0gzTjhZRmJtWmNL?=
 =?utf-8?B?bFNFRlNjR09sN1NOVHN2SS9TQyt0cXVsU1ltVjJrWjN5UEpaUlRkdGxCS3Ir?=
 =?utf-8?B?aWc1Y0tqTk0vKzRQY1ZtdjVicjdMQ09VaXdwUlZWRFQxSE1Pb1dlOW9IYjV1?=
 =?utf-8?B?WGZnb0h3L0hzWmtSRHYyc2JHVTRBaWYvUlBMblRzbE5JZDR5R2VWYmVNaDNx?=
 =?utf-8?B?YXczV2s5Q1BEL1pITWh5NFoxVmo5WDYvUE1oT0Exc2lRZ0k1bnNwK3RySmxQ?=
 =?utf-8?B?QVM5cm8xSUFtSFBHWC9PdlBudE5NbTB1ZlFBSGhrSFVvdHJ4dWxLZmpkT3pM?=
 =?utf-8?B?NDZzMmZhRGxCa2ovSXEwUGNmNi9VYk5GVDFsNGNMWFQ0SEVDUU5xdUpTMXZ0?=
 =?utf-8?B?bzE1bHJzQlhUYzNYWU1vUFRqMmt4V0F1R3JqU2dudzFSYytlVUFJRG1nYU9o?=
 =?utf-8?B?ZTlPSzBNOUxIV3hpZHltQWQ0MjdDU0dkb1U4WkpEWW55Rkp2WngxaWt4eDZT?=
 =?utf-8?B?K2l2cXFnaGx5RmQ2REovOFBzR1U5ZEk4Tk0xL2hzMzhlSEFIQmdvZ2lQR2xh?=
 =?utf-8?B?aWkvaFhZeTFFdUtxYkNYQTJJU0ZXZ05GOE5HNG9mdURMZXMzQk9NUkJSVVF1?=
 =?utf-8?B?RFhJUDZkMDhFcytMN09UeTdlZU1oelB3dDZNMUlTaGhtWTZqYzdwYUtaUFVT?=
 =?utf-8?B?aWUwN3VQOFNVOVF5SzQvS1k4M1RycS84REdqc1c5RCtTNjNOK3BkbnN0b0hJ?=
 =?utf-8?B?N2g0cHdlOHlOazQ3UGZFNmdmL05OeUJYb3RBYUJ3QzczeTRLM2lKWTNiSW94?=
 =?utf-8?B?SGVFR1VRb2Jhb3VENXp6V20vM0orMklCNVVVTkVrZXRzT1p2dDVBOFQ4cThw?=
 =?utf-8?B?MTNTcGRhV2xCWUl5SWsxRE1KYnE0YmpIUDRaaUovNG8rSnluQ2lTbHMvUjBZ?=
 =?utf-8?B?aEdUOGJCN3VLVWtnREZjZmJQZlJrUEJoM2JoTENLTUY1b0tmZWRHRUxiMDJ5?=
 =?utf-8?B?Z21mRURmYUFHRFpndGRsQmdZanVOMUFicGFyc3FSOEYzM1JDMXVjOTVoeXVu?=
 =?utf-8?B?KzJOWG1nRExKVEplS1ZXZ2QvdzBwNUp0aFVWbDVlUXpxTkpHcEdibWI0dmd1?=
 =?utf-8?B?YnZBazdlUXUzQUpBdll5T0cvcnAzbENEc0ZFbGRSTS9aNi9kRXRNYWdYeGRU?=
 =?utf-8?B?MVJ2cGxtSDh5WmRiQ2xIa2VkSm11aG9rYjhWOTlFMVVySm5IaTRQQXgwMmRr?=
 =?utf-8?B?RUpHWW1Tdno2bVQxaU9TMWhjaWtHT2hzakxNZG1pZW1NMU5QNmR3SW5LOG5B?=
 =?utf-8?B?ZG5TS24yeDBnTFcxWEN3cEV4LzhDTjNSQU9yTXpqWEpWYXJiSXdkWjlac3Nv?=
 =?utf-8?B?WTBVVzRqZTYvbmlXVWUrY0pmSkxjYkhjaUNEY3huMmxoVllMK2JMVTJYN1Y3?=
 =?utf-8?B?OER5RkVNc3AvN3BJYTF5cDVjcmZvSjRwaDg0ekJLaVhaU2xXR3ZXRlNFT1dI?=
 =?utf-8?B?MGxQdWhXK1NWMTlTb1J4cHAweWd3ajVMK2p6WnM3T1FiS0Y5ZWU4OGNCdUp5?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xKkcHAmrvnvKamDrZ3hGZYm4ViOClSmjiTXrF+0kxBJ3HEIwxT8r8YEVztmFSinx5lFv/r+NgGMOYZtTPo8hcXk+82BK8lUWY7K6LfX77rz/jOsoqpBrVcKJ4EqjCqlAqGi9INKID/0rJ250D3JAFijj5jwpKcJFbzmPj91cVYL50CRAs0O+vh9tOgpNvJc49x7mL1D3aBka57Jrp+j5LbM9HCy0Hww3ak5HNzkkjR5XcX5NStIucm65mhmD4Fo38ib8N+MSyRU2fjG8h7H83+F0PTx/Lot2W7F2Lj7FhKoxHJVQXb9E6WxvDKx6TYD+BZ/z+FLCs55E3UbYFrcS6MqLGeJCiYlf2MauEd9OkcNcbzFCoA1+7p6qZN2d/Jfexq6QqNt9k3AW9OIjS8asuejHeOzVnREj4Mdbcoa625qwS8K/rJ+Cz6LwnUL0lgX3E13OADEx+Wc5qdjMXS9OAAKHO6X3xW72QYGpsc578rgqsy46yNcUcmmRIof7xNCDD3WWIXlWT/fJqtnXOJP0BufY++5MUf+hgHxCt3Q3vbnMVF2n+OBrxyMW3sxhZA5Kj1G+Hq5U5XbtwwUrAfh92exNyDanoDC6cn7jsY7VFKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b06193-ff4a-490f-184d-08dda7748a6b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:41:53.8170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nacxX7CaCAnEUqZHSewsMC6x7LTTXM35ynEYIE9Y4d81FYdcpzJVAfCrMegwjQLcLXvaiYfFA0p3ZnCtyTql+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090124
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=68470ed5 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=oC7zTRI0yVpg2M-rWTMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEyNCBTYWx0ZWRfX7bNq0gBo7Ys9 TJxjrM6KGePGDWUgpeGk+t1GiWS1J0riQASUHa6sg/XM8aE3HA/DykSD204TDfvCBDTJ7Fvao2p +FRcS+IAyJwNWh+053trkmvh9PFog0CzqXIgiwQnRubttvmt9Bz84jTH2YELpyAt7p8UBIsX416
 5ommlviJFiNefG2sxeORG1xMCAT/Cd9dltyZggRAOpBxMtBBJWiknvvdFE9CVqAewbk/TKeBPxE OQDnF5sfN9JisWLuYzNH04bkL5tgtD1uo2P13Z/EoHZepB5o+u0Gn1yPn394rD9xPKnEHhRGTJG qHSEX4rqeHCE92X+DHkGRAfIYzPStBwdVxrqR1ls6tHxTveYR8hKHupkPnMYK15xe3R2PL3RX7d
 2HWJ6mGPv9Lpo6jO0NAZC5VdFnxLv26/oXkfEzGGlE8CxZA6nzTsOqrP7L+ZcGntZz0FsYZn
X-Proofpoint-ORIG-GUID: VytgBIc4Wxkk-CM9f-76qysVKzNoS_e9
X-Proofpoint-GUID: VytgBIc4Wxkk-CM9f-76qysVKzNoS_e9

On 6/9/25 11:50 AM, Theodore Ts'o wrote:
> On Sun, Jun 08, 2025 at 05:52:36PM -0400, Chuck Lever wrote:
>> NFSD currently asserts that all exported file systems are case-sensitive
>> and case-preserving (either via NFSv3 or NFSv4). There is very likely
>> some additional work necessary.
> 
> If the underlying file system on the server side does do case
> insensitive lookups, how badly would it confuse the NFS client if a
> lookup of "MaDNeSS" and "maddness" both worked and returned the same
> file, even though readdir(2) only showed the existence of "MaDNeSS"
> --- despite the fact that the nfsd asserted that file system was
> case-sensitive?

IIRC the Linux NFS client used to cache READDIR results via the dcache.
It doesn't do that, these days. If the client mounted with
lookupcache=none, it might work OK?


>> Ted, do you happen to know if there are any fstests that exercise case-
>> insensitive lookups? I would not regard that simple test as "job done!
>> put pencil down!" :-)
> 
> There are.   See:
> 
> common/casefold
> tests/f2fs/012
> tests/generic/453
> tests/generic/454
> tests/generic/556
> 
> You'll need to make some adjustments in common/casefold for NFS,
> though.  The tests also assume that case insensivity can be adjusted
> on a per-directory basis, using chattr +F and chattr -F, and that
> probably isn't going to port over to NFS, so you might need to adjust
> the tests as well.

This is probably the more general concern:

- Both the NFSv3 and NFSv4 protocols mark a whole file system as either
  case sensitive or case insensitive.

- NFS protocols do not facilitate case-sensitivity to be be enabled or
  disabled from NFS clients.

It sounds like it would be difficult for NFS clients to make sense of
an exported extN file system that contained some case sensitive and some
case insensitive directories.


> Note that some of these tests also are checking Unicode case-folding
> rules, which is a bit different from the ASCII case-folding which FAT
> implemented.  It also might be interesting/amsuing to see what happens
> if you ran these tests where the NFS server was exporting, say, a
> case-folded file system from a MacOS server, or a Windows NFS server,
> and the client was running Linux NFS.  Or what might happen if you
> tried to do the same thing using, say, CIFS.   :-)

Re-exporting remote file systems is a massive jungle even on good days.

I think a narrower concern might be keeping lookup behavior consistent
between local accessors, NFS accessors, and accessors via SMB (Samba or
ksmbd). I admit I have no idea if that's possible.


-- 
Chuck Lever

