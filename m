Return-Path: <linux-fsdevel+bounces-43791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1155BA5D900
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 10:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873F31665C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 09:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA8F238D21;
	Wed, 12 Mar 2025 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DYdHptXb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gbKKP6i2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EAC23875A;
	Wed, 12 Mar 2025 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770842; cv=fail; b=Ab0mfqD1dG8rJP6oZjIvJR3dvC2cRRBn0H4Gdwjg0Q6aj27A/BAUGa0r9iG0jsTnwfjFCUQRYRykgVrcQEfz0jmm8x4bPWCNR5meEVG4erA2y9jEf4wizK+Q4G+J8msR24F4q8/bPfzvhfaUuIICceOGx+r3+cGAHl1BGqXPnoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770842; c=relaxed/simple;
	bh=FCdD9cpoZEseeo2k0d+zNdC76yIKllHP2kdwKxC+zWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nZCav6oQ4ENRffJIR2VJp9wq7XRqnkuBW9/j63tHfo+pxBnGQznR91pi82SSWhlyZJPJdQurBTIR03EnjBYYmAjE+42mxA+Q4iA+jLWmvrX3I/x9EbQf5V4abfpqAK5afvG0f1y2LZPxrTxFP3OiB3NHZ2SskLHZs2E4deSU6f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DYdHptXb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gbKKP6i2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1fpPm022177;
	Wed, 12 Mar 2025 09:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3Azrm9oKudfgHqS/HT6K1JWUDm49B2XmUygrFUxf5Ng=; b=
	DYdHptXbuR/Cd7ZNmfT7FoaOjCfEf8PqChxLH4Kh30bRKoE89sLotI/wCfKYTr3b
	6NYPOWxl95drWSU0QEgpFxH2XpLbWyd0uE4CBIsx0Gm0cKH0JC/Qo7d2lICC8cqH
	iveW+hiYopaFclNe3XfY2g9CPe7um/KJp+YiroFZVxt9PPwjRI6akRIRmQ1t4ZmD
	lh7CXGb/EarvY1KtoIVPnz9zTYOEFYsaZ0Epu5UyGvwiNdP3t9e7owBNULcifT9I
	tf1/v66l563NrOe3c/tprwOsiboo5jjRMYI/uDd06MDPo8C0cz+isRr1+0E4/O2U
	4MSxMvTKK/nL/0gmpA0DGA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4h185a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 09:13:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C7HrjE003886;
	Wed, 12 Mar 2025 09:13:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn0gjq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 09:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyQZZxVbl4undmulNpvEIaB/SkW11WFgdK+xuB7ZgR0mmEsM8I/fscaU7qCx+rAszuZZeZh5qu2sDBei/9J9Xf6xscykuT3gLHIFwHLcbqiv/Srr5I/QZC+4Ip/I3+a8iUPofMcyrmBdvG9E522YrqMhM7mQHcadSub+WlOJPQ3f+sVv9wz3ZXixJidsdgkkyF6QYp1TOBRJR0vIjxQicgSSObCtNZJQEKB4dv2rcVhXDx5Ummu1xRGrXoaBwfcRXt226/OknhI4MWTrBx+e6SuSk/5Immjywp9zr/rt8ha3sQj+NHd5WHZacUFQ0KxBXQVmoCcHo6vT+ARNmS48aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Azrm9oKudfgHqS/HT6K1JWUDm49B2XmUygrFUxf5Ng=;
 b=kNobFZmh5KK0lyyuo036dnV0EFU8PApyU/V1yWbRyIAoSzppkhUn1MTu/XUA0OD5zlwmHW5oVsErc7iAWyFYp9UNmFvs/nXFoLd6UXIKDoUTZMlkFDoJZHc8TQVYyMWWaZPJY6u1Q62J4PGZtOWaDwz6PsHp4EwMI47yRFooouBGIO2gr5ijPheAE/FROsv0etv5YAblKKT2qvy1Edq/Swb6Bg2CUTQwLiiPtTTn3wQK6ro8j8VFLWgzMEUVvhwyQ/FpRNTaqjIu8/1RmcNTnDGc7shQvl03sM9ZUc3njAjTusIw5eGtuUvxJYXxzVVIyLpO67uVuq5PPW+Knwyxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Azrm9oKudfgHqS/HT6K1JWUDm49B2XmUygrFUxf5Ng=;
 b=gbKKP6i2AhlrcYNMTcLRIWVx7MPAbRsOkTEt84uORogRDobHGYBe/FI/h9giNY5b/XP4kU4Ae4l557g2qn3VS8lNg88EsiUsyfIksFPtD+MtDurlHykjSTn3QYsoOm06wyStn41sRfE+/Cw6omg8KtrlRn9Dv4srtnEMQIdw2ww=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:13:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 09:13:48 +0000
Message-ID: <81247acc-f0fe-4d10-a0cd-bbd5b792267f@oracle.com>
Date: Wed, 12 Mar 2025 09:13:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] xfs: Reflink CoW-based atomic write support
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-5-john.g.garry@oracle.com>
 <Z9E3Sbh4AWm1C1IQ@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9E3Sbh4AWm1C1IQ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0348.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: f72577dc-379c-4979-a01d-08dd61463296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTZmRVRZY0NmeS8wSlFJaU0zM1hVaTdrUmdXSEhxUktRbUVoU21LNVdKU01y?=
 =?utf-8?B?dXgxZDVyRGZVWTFZZUFRKzl1aVFwdjg2KytuTVVucTE0cE1hMUdNVEVxZTFt?=
 =?utf-8?B?bDRQRWxlWTU0dlZ4MUdGazk5cXBuMTB3d2o2L3ZzRzVsWWlTS3cvbURnUi9M?=
 =?utf-8?B?MDE1TEdTOWYzV1hFZCtwVGpUY1BOb1BIdXlWVkFrZzhHZ0M3enBldmVDbXlV?=
 =?utf-8?B?MTBTcTNZNEdjZ1VENFF4QkJKaGxLclFxVmJUREhsTkF3TjRsdzN6QVdXMTVn?=
 =?utf-8?B?NS83Zkh4RVA2cmRnaEoyVm5LNXB0bmtTMkRTSGcrT05ESG1IRGVURG5NU2JV?=
 =?utf-8?B?a0JHU0N3MU5xMG8zU0ppdWpaNzRHTk14UnEzMkJ2RTlZWHZibzROdnM1RDVy?=
 =?utf-8?B?L2YvY2N0dFJISHRCR0o0M1h1ZExBM2lzQmlwc0VYaWdkZlpSdTZSOGorb0JY?=
 =?utf-8?B?Z1lraWF5Q280a1V2UE1xLzR3Zm5mcU1HQWtHemNBN0FmSmlWdFpSRWpLL3Qy?=
 =?utf-8?B?cGNxQnNaTHIzZzBINUN6VGc5b0UzTEZSTGU0TmRSMkhaOXpRZFB6eDFpN3By?=
 =?utf-8?B?eUtjRFV5MEdkU3paR0trVjEwWTJEUWVyRmg2SnFubmNYY0NKSU9HbHVYOHNI?=
 =?utf-8?B?ajZZMUZmcUN3R0tqUG1ycEw0bUs5bFJzcDhoSGF2ZEw2ME5zcFhIcllJNWQ3?=
 =?utf-8?B?MWVrS2txdDMyUnJXbTR3alpnbi93alR4T1ZhbmZZUEtEVm1mY2c2SEJqN0NM?=
 =?utf-8?B?d1V2STlSb2VQZm9CM3IwcDNyTWplNUt6a1VNSk13MXhCVGxXaTgwWGVDMlpS?=
 =?utf-8?B?SjNvZlEyNytidFJkWTRyemwzUzdINDBtS21UV3B2R2dWa0w0VUZqM3hRZXdR?=
 =?utf-8?B?K2Q4SjBQUi9mdEFiWTBaK29tUFB0WEl1U3VKRkpLU01aUUlETWFGSmtlZlFq?=
 =?utf-8?B?eHd2NjNnSjNTYUI1alFWNXA4b2RhS01aSWhlWWRadzVWcmZTS3BIY2FJWHV0?=
 =?utf-8?B?MzU0M05nVFp4VHFvTHlML051S1UxeC9GVWozL0RGZ050dFlmS0pteFVodU9Y?=
 =?utf-8?B?eEN0V2RISUtxeW9VM0FXclNuaUp4Tk5XbWdaQ3RZS3hWZ0tXeTZzQWliNWdR?=
 =?utf-8?B?bSt3eGJkTGRiZVlFL0pWSzBuYVVTMllKSnJsdTBaNHdzYy80NUNhcDlBWkZx?=
 =?utf-8?B?V2hJSndXN0lDVG45Mm51bjI3NUxvNEN6eHdKZmJEb0pibzNqNnpNaW55aW9B?=
 =?utf-8?B?Uld6bkswZ1hCaFh2WUxFeWRJWVVWRUdTQlExSjBsdUNkNUROQkZtQmMyZGRX?=
 =?utf-8?B?a3oyKzh5Y1NrZ3R5Z2JoN0tXcHlxQmRZdi9BZWtwYnlHeEVjMDhkL2ltZlRp?=
 =?utf-8?B?MFJkVHhxdmdUaGRZQ1B3cWRNRE5WeVhlWjZoTGo1UHNZY29vVkxzT1Bqb1cr?=
 =?utf-8?B?eWtHaXZJeVhjQjBCcmEzdGxva1B3SVlaQkJEd3ZQQzZNZ0xJU1NOS0hIM05B?=
 =?utf-8?B?WW40NHRpay85eVhZV1NqM1dzbUdVUFBlYlRPVVNnM204ZlM0Q3ZUWXhCRFJu?=
 =?utf-8?B?LytmUGw0ZFh5cmUrYks4amJIempSbW82WTByR2RmbWl2SDZjYVB5akhsRE1x?=
 =?utf-8?B?cGFscWZTM1Jsc0dFZW5QZ3VtWktFSFovU21hdk1NeUV0ejdhU2pjaWJxRWpC?=
 =?utf-8?B?YnFFSk91Y2FRL3hObml1azhYWHErcjdlQXJFRjNRbWJQR2hKSVk4VG1sUktx?=
 =?utf-8?B?VytsWFdoY09lUzN0NTA0UUhTZERFR2h1YUhrWUNpRXc2RzRCcEMwbmozUk1o?=
 =?utf-8?B?cWxLNkZjd2g1Q2huRU9oSXVFVTE1TytYV29oYi9VSDVhbkRmbnM4REljU01R?=
 =?utf-8?Q?LhjsXxbH4vulo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0dZZWVodHBXbElHT1UxYnpISW1vS0FjUzdSOFRDQkZsSVBMV0g0TytFd1VL?=
 =?utf-8?B?a1RrNFQ1aE03bjdhTlpCdUYyaWUzUEc4aXdQdENsWENiSk8zaVhabUYraTdC?=
 =?utf-8?B?bTN1djVSZ2cyanY0SjAwMEY2SVhNUGFLRnQyUHhyMURIcFMwYk85SEMyUmpj?=
 =?utf-8?B?V3hQNjdHZjlpWW05TEN5d0JZb3hydThlYWRFcmsrUzJvNERQYjhiK3hzU095?=
 =?utf-8?B?ZGtNSldLNkxzb3JDZm1vMHFWa2dlNWwrZThlMFZpQitXMWRhMGx2c0w2UFJm?=
 =?utf-8?B?L0wzdWd4YW5DZUJ5c21BYkp4ZHkycElBUzlPK094WkVyTUwvVXU1L1ByOGJ1?=
 =?utf-8?B?VlNoalNZN21nTmlwU0dQNThHdEhWL1VSY0xSeDFpZFZpaCt3a0FTdlIxZ0Ir?=
 =?utf-8?B?eERJMXAzSm5XSUZveUgxN3paVkZ1MjRvZ1gyVjQvU1dEVUJxT3NDTzdsUHBK?=
 =?utf-8?B?Q3lSTHlOSEc4eW82M2tmU1RkY3NRU1FTRnM5NzNpMEtSSnh6L2dtUTRhZUJy?=
 =?utf-8?B?VVROcldvNSs5U3dzSzdoaVo3SjdYRlUxa3RCYlJtR0hZSThZaGFhVEJ1Sy9o?=
 =?utf-8?B?M0pQZ3drazlicmFnckFSbU5SQzYwNEd2TTZTdHFvU3czbWJtY25ONnVXQzli?=
 =?utf-8?B?aTFob3pPVGVDWDdQaUZJTnNaUUtCcUNtdHNWNTdQWngxZUt5aDZGa00wV3JW?=
 =?utf-8?B?MmpPYXFlbHlVVThDbjYxZlVncFIxdnpMTm95TUZsN0JudGttWmJrV2hMa3hi?=
 =?utf-8?B?dnVrSEk4U0ZQQTI5MlpFS3ZacXJWY3ZHMVdvUFBZeTREa1FEaUZRbm8xSm5i?=
 =?utf-8?B?V3FLZlRWZVJ5RWFwYlpLek9BdzA0ZGpEZWlyWnFKbTF1S3hweHlBMFdUSXJI?=
 =?utf-8?B?T21EQnBsMkNtSFRvSjFLek9qakpXTmhMRkg5cHV5azgrUGJzSkpqTkZFeVhm?=
 =?utf-8?B?YWxJaEhoRUR1U0J1cVpXSzhqdVFzTHpwRXFSTHFwWlRwS3F1eTBMYlFUQmV3?=
 =?utf-8?B?TnBreFdmRW1oVEk1VW5mTW5NdzB6enE4YVpxZU9mVndiUEdPL0xteVdWZUoz?=
 =?utf-8?B?M3g2M1NxdkV0L3BBem16T1lYbEhaN1l5NHBJU0UwSWc2L0VvTm4rRHN0Yzlu?=
 =?utf-8?B?TFR3RjhVbk1HWEpjNlh6WFB5ejU2OHRIVW1HZ05KRjVOVUxKa0tEalF5UGcy?=
 =?utf-8?B?YlJRUUlOTDFETFlacitNMWVJb0NVSEN3Q241VHZnQmptREord1lNczc3czdT?=
 =?utf-8?B?WFA1RlhEdmlvOSt3eFlJVXlPTzZTS3ZiczRmNlFUVFRPMzFFNDBsOU9tZWF1?=
 =?utf-8?B?dVFyWExJL1AxNC9hb3Jxd3dKTjRQdzFxcmM0dHJLTzNNNVFpSE1ldVVLRUEy?=
 =?utf-8?B?VXlNL0paVERnZ2NLYk8rRjQyZDNveUN6MVF6VmR1WU1sMjFPd2dJd3NpbU13?=
 =?utf-8?B?UmdySHowMER3dVJCN29Ka1l0MkNnczlDa0FxZjVpWnlxVVZQNmVBWXpSUjVB?=
 =?utf-8?B?bDF4bjdXM1ZWellJQlAvOHBLeEE3TmJSSVNtTGNLdUlsbjdacHN4UzRabUlI?=
 =?utf-8?B?VVZjWkJMcUlaajJiakZsM1hmMzd1eXpNKzc4dCt5RFpzelhPbGlIdjN4aXZ2?=
 =?utf-8?B?NmFtTHdIN1lXZ00xYXNWZVdtR2w1ZXV4SVZ4cjN0VnRuS0ZIWm9BYmFYeUw3?=
 =?utf-8?B?LzY1U1ZHZFA4OGdPTjQzWTdlUmd5UzNxNWMydlJBVVpXYTc5V0U4NGM2TXJI?=
 =?utf-8?B?NUY0eFAvQnV5TCt4Nmo3a1NsSS80ZCtqTzJobWhsZFp0ME5jMXRuOWRlQm9D?=
 =?utf-8?B?aGUzZ0NUeWFleXk5aksrTlhrU09KdGkrbFQxRm1aTEdScTQxd2tQbUZqSXVM?=
 =?utf-8?B?N1h6a3ZGajVVaW9XRjdHTFNsa1FpZ3pBUWhZR05SZHA1SFF3c0E2VDZacC95?=
 =?utf-8?B?VEJLV1FrOWw2anJad01UZlpnSTF3NDM4eklNc1Azc3dLa0RwaTJFTy9JUy9t?=
 =?utf-8?B?aEJaTFY0MEI5eEIwTXQvUjM5eW1PaTQxZmxIa0hSeUJwYnNJZ3I0ckY5cS9k?=
 =?utf-8?B?czBONW16N1E0NUpINlVwcHdzSmJZOGVzK1dXQldFMFhZR3I1eGYxTnhEb3kv?=
 =?utf-8?B?TThXc2xPT0VpOS9aZDdDNjRieVRXSDVsYWFtcFoyOVFETlF1dVE1Qjh3T1cv?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a6iXz/xjj9IrqSGY1LKj913cfqQNMbLPUAiWs8M7PpjNFLmM6C3Xno9b/c8NYglidKDPiq70CwLKiMMT8kBrypSmJrmq0vDceoInrmUmM0g5BxGvqfK+3euFbl+9jupgZQBZrvdCGVYEaWTfP1pjGQm6avHqMcn4MDTPRpdfRixhyFBw4m2mwAAmhlx3ULk1TOB+vOIjL3siadeK6evKAYqSOvVMnPh3jhCdcOlbl2axdhy44Zihl6VY9ltO2NDGXUhLjpj1nXwMiFjkb16eS3Ms7912UHiS7lsMO7o+BGI3z7nu36I/QWZAl78ZDrwVr/1ytwdfOIQIbErkaMMUlQ2w0npdbpogHv7WnNmwiymP9S361bbHAbJe4rVq3x0NG4j31LVKEBGTES/utQbALWlD6aKkK6NxQVJsqaN+o1ki2M5fy8NggEl7Rni1rFwVWuwtE74bhm49RftV6xKpG9NNa1YWVqATsNy3btgFh4xHwp9rErsZrWK4DcA7W8GxrhMMCdOycVBm/7C+YgjHqtfUFjZOZu1kii2dlv+h3+GDOhLgPiGwQPOX2DBqPEOeJfDjNAeLk2DoyQcyY1QF4GHaQf3oL9ZuN5brHa2zz3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72577dc-379c-4979-a01d-08dd61463296
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:13:48.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KpaX1lvqoy1QT4r5EoZGkZ6L3Tnd3lTZPsaaSQJvMz1VrGoOGkEk1IxQEWqdxf2RB5QpUA+h7k3e7kHjI98bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120062
X-Proofpoint-ORIG-GUID: cL_SqcGN4XI-Ea-ZuZew0oSflgn_gPOX
X-Proofpoint-GUID: cL_SqcGN4XI-Ea-ZuZew0oSflgn_gPOX

On 12/03/2025 07:27, Christoph Hellwig wrote:
> On Mon, Mar 10, 2025 at 06:39:40PM +0000, John Garry wrote:
>> Base SW-based atomic writes on CoW.
>>
>> For SW-based atomic write support, always allocate a cow hole in
>> xfs_reflink_allocate_cow() to write the new data.
> 
> What is a "COW hole"?

I really mean a cow mapping. I can reword that.

> 
>> The semantics is that if @atomic_sw is set, we will be passed a CoW fork
>> extent mapping for no error returned.
> 
> This commit log feels extremely sparse for a brand new feature with
> data integrity impact.  Can you expand on it a little?

Sure, will do

> 
>> +	bool			atomic_sw = flags & XFS_REFLINK_ATOMIC_SW;
> 
> atomic_sw is not a very descriptive variable name.

ack

> 
>>   
>>   	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
>>   		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
>> @@ -466,7 +467,7 @@ xfs_reflink_fill_cow_hole(
>>   	*lockmode = XFS_ILOCK_EXCL;
>>   
>>   	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
>> -	if (error || !*shared)
>> +	if (error || (!*shared && !atomic_sw))
> 
> And it's pnly used once.  Basically is is used to force COW, right?

Yes, we force it. Indeed, I think that is term you used a long time ago 
in your RFC for atomic file updates.

But that flag is being used to set XFS_BMAPI_EXTSZALIGN, so feels like a 
bit of a disconnect as why we would set XFS_BMAPI_EXTSZALIGN for "forced 
cow". I would need to spell that out.


> Maybe use that fact as it describes the semantics at this level
> instead of the very high level intent?

ok, fine

> 
>> @@ -10,6 +10,7 @@
>>    * Flags for xfs_reflink_allocate_cow()
>>    */
>>   #define XFS_REFLINK_CONVERT	(1u << 0) /* convert unwritten extents now */
>> +#define XFS_REFLINK_ATOMIC_SW	(1u << 1) /* alloc for SW-based atomic write */
> 
> Please expand what this actually means at the xfs_reflink_allocate_cow.
> Of if it is just a force flag as I suspect speel that out.  And
> move the comment up to avoid the overly long line as well as giving
> you space to actually spell the semantics out.

OK, I can do that, especially since XFS_REFLINK_CONVERT is going to be 
renamed.

Thanks,
John

