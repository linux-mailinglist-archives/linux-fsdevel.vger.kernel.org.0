Return-Path: <linux-fsdevel+bounces-58294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F713B2C0D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 13:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC983A8BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A3F32BF55;
	Tue, 19 Aug 2025 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KUjwdVrr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Moa8O/2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AB22A4D5;
	Tue, 19 Aug 2025 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603739; cv=fail; b=nmo7QcUK+G5SLzu3gA3leCbmQJmeXSLQgWwedCw4T0TYRKiVRBgKNsQtHhY22CO8hseI83A8UGJof0/HtnsrLqTL/O/9nA8tBDUvZSpApXAh26IIfPOlYf6afy+d/z+G4UwIwRlCltWLcGUjuo91DtkhyWvrDMtq++Cw56lF2cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603739; c=relaxed/simple;
	bh=phW00I8sOMoj2Hf1RQMD8Fwe5pyxDeJ/V26ZSR0CjRs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EbalgoQmUKBkJgwfzaiZh9eF+4EbYJ7271+8aslnd789lVOGP253PXUpr+G/0PPPig1nVrqE1iolHI8f/B+J6ZjUUSCSf9tnpCNISwuRnUTmPBPtsMl+YX9spNfUIq+pr3YFLdz5eGMK91B5q5y80JD5EtkhgPhDTEgRhGrG6Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KUjwdVrr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Moa8O/2T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JBBvVK011482;
	Tue, 19 Aug 2025 11:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ctSHOrnADcrT4uzjwaUTitAPSUoIRAFjqS8wf47BAq4=; b=
	KUjwdVrrtO0xr+fhO7p7avGqZ0cgiA68Ajzs0aDNwBOny0dKKGcsa/3uzfMBTdrO
	CQrJLUqpnkRb3tJThTM2w8jBJx96hYBrj7EaztYV1Zl/6ghrVoH2VrPrdSXdktHw
	Re5nFq4AaIvgA7nVaxBrY5QciDRGU4s4wr7oGguPFQ65OgHvv1VcQ04tuO2Ww32K
	rdq8qEUNqnzJCk9SzBMraMw4Pwf8vBOBPyA3WLLUZMQtrVIa5+EnpwJApSfVX43E
	FewG1zGQ+MGtYn3SMkuDZzBvbYnepzs9qkAdRIFQD7olow4FkQ7kcHiJ5aPi9mmF
	5r6XDR0x8NUJ2XVzn/gXBQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgs5n3vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 11:42:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57J9lUu4030973;
	Tue, 19 Aug 2025 11:42:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jgea2yns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 11:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWfFnJcnPRk1YUm+V22mJfVBWpK/sxEjm+JBS6sZ2BEmsEOniEiaGkX5rYCcqdLzdLMIkMFXy08bt3AIGmNIAJh7i7GYnQvtdkUL3FUJuIn5HWqvJcdOp2fKvWtj3qmXdjAahlQSOemDzrHbhnDcpJqwk2hbEzxBpSjsYsP/hp/Bq54KTlZh8j+q4Uw2knlYu2gu8ovV8yFV/nVGjkM+KDRQhsQ2KqelCda02kh4zAUSwHax4PwEza2k8L/pRXJdJ3MhTl5Nzd5/USn/slisgSuytaR9MF/7QoINTxmxu5Ogu9w5k1E3PyDi0OeoWGxGcx3PMpF94gvWCr0SxGyHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctSHOrnADcrT4uzjwaUTitAPSUoIRAFjqS8wf47BAq4=;
 b=vC+vaKWJn6HgVC7q5OVW8onbhyHKSDOzXgsrBEGPMbMYFGCfCt9MzkNKNbAx+qFvAq5LYdPQubcJUSkuNLwxpa7udBk6zp4keZc3o6WmNK1ye3J1UwwOuS5DRXeS4AgsirrBRcCgYH2H4XQHzPePKOSedxHSTvWUZP2KOrzVrD2Wv4kDwgl8DpbYmFFi7Gqud9Sr7c9etxhvJmPQTxX1yN/RMpNOV7S5BoUp6rBi/uZ/i2OdPbsr2JVJriYeGZNlsNkkVqLpGAXL46YZx4t8DChZKEiLPzysm0+x6xg1mARcLZMab9NclgyVK8dY+F5dGCbSjVlNOffVetL/TvmLFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctSHOrnADcrT4uzjwaUTitAPSUoIRAFjqS8wf47BAq4=;
 b=Moa8O/2TShoUz9FmiDvmyW5RtDMYpjmK91IluFAMhoDie78wMzTRJDrTcuS7CgGh/u8qMpQjYpB/nBigq86HpQ0Ris5Hqa6b8PPPb/uEUnTAgx0vlj54Tw6faedazZWZLvSD/u4z97dOOL5UTWeGttAtq0AbJnEN6gTYjObw7B8=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB4766.namprd10.prod.outlook.com (2603:10b6:a03:2ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:42:03 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 11:42:03 +0000
Message-ID: <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com>
Date: Tue, 19 Aug 2025 12:42:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
 <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
 <20250715060247.GC18349@lst.de>
 <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com>
 <20250715090357.GA21818@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250715090357.GA21818@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::17) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: 48170bdf-e237-4d27-e58f-08dddf156a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXM4VXk4NkordDQrVHpGUFNEUVN2SEJmNmR5TGpnTnN4b0E0dEh2aGJIUzNN?=
 =?utf-8?B?QmxiWE5vbU11TnRndVBxUW5FMWpwZDM5N1RaQUZqRFBKaGR4K0hLWk0vYzE0?=
 =?utf-8?B?WnpvdHFCaEoyaGk3UTVmRG5WVHB0dXMrRk5IVm04SnNXSzZvRHltQ3ZidHV2?=
 =?utf-8?B?eU9FdVZrNmJzcnY5YmxYK0lRbWpMeHE2QjJUTW9VNUZvNXZSZXYxZk12TU1l?=
 =?utf-8?B?WUR2L01oZU9JZjB1TjFDK3NyZ3p4cWY1VEZXcGdzUnVHcWtKVUMySW5xd0hl?=
 =?utf-8?B?WHp5TW9pZUJqOUQyeTF1ZUhGbTNXZndOOHBjOG95MWNGdk9vSE8rZUphcEpt?=
 =?utf-8?B?MHMwMi9rdkRTNGJkNm9JbVovbEFCV2N1NkV4N2NMQS9DZ3RiVDRlNTUyb3Bw?=
 =?utf-8?B?Qjk3Y2hrcG9TSktneDJiOUdrbmNOclJYUjdKK1dtS091Z0w2Z1FXdXEvZGUy?=
 =?utf-8?B?dVFnS3NZSHI0cVpoOTltN2xETDJicVFVc2pmMjhZYzVFNEhndzg5VGlEM3U2?=
 =?utf-8?B?aWhTTXZHMGhoYmwxdC9TR2NTTUhwWC9pNlZiMjVmcjBnSXYyb3M5VVJzcXl6?=
 =?utf-8?B?S2JQMFBVdU4wUXRiTXFQQlBOZVZLejhqVmI0M1RMSFBlUW9aMHY3NGdtRGpp?=
 =?utf-8?B?aDZia3FLdklRKzVXMHg3YTBWYVhsM3d2NkN0dmZUa1F2Mm0zeGJyR0JrUDA0?=
 =?utf-8?B?ZGMyUFBOUTA3YVJVaVJUMVNWME1nYXpmMkdpcUtrdXRnODZ6bFRTdjA2Y0JK?=
 =?utf-8?B?NXQyaUVUSkFZMFhBT2hrSWlFaXk1WlBocVd6cVZ4Sk5yQTBQR2xYRzBTeVBp?=
 =?utf-8?B?bVpqUlJRSndsY0ZlVkxMd1kwU3VOUzBXUlcySFo3bDFYVnl4ZFc3cjJlREEy?=
 =?utf-8?B?WmxzZ29tOXhqNk9XNUg4cnN3REcrQmZiVFQ0S0NpeWlXcFhMMmV5YjQvMkg3?=
 =?utf-8?B?ck4zZXpCNnpKNlpHcjQxWDc2U1NxNDlaTDhsMlZubmhWQ2k5MjA4NTZIUzJH?=
 =?utf-8?B?UTVBUjlDSkJzUTg0dG0yeGYvaS9BaUlqOXNqK21zRVBiNVJIb1l3RUNIMHYr?=
 =?utf-8?B?b2I1YXZyVUJqcjhZY296eWhzazhwQ3F4WlowWGJrWW1FNVE3V2YzSDVKUmdE?=
 =?utf-8?B?UXAyL1ZpSlVqVzB6aDJqY3FRK01hTjFSdi9nNnNUcC9RWHZnTm13VmREd1c4?=
 =?utf-8?B?aGNPT05TYVVKa0ZVV2F1WVRFUFlZLzBKTEUvYXZHcDVwYVhIMlh3MnF3RUYv?=
 =?utf-8?B?YUh5VUZSMjVKc012b21xVTl5SEFuL0VwWHJZR3RRekk4NnhyNXNIaVZvVkpS?=
 =?utf-8?B?R3VMc0FpQ1lyVFBvYUM5aWdSNEZNU2d5dERET25TNWFsL0pkTkdXOExNYWZM?=
 =?utf-8?B?MFRMMW5NQUVldmNoZ1AzNjloVGZLekpzVTJrUmtvM1Y3MGhsM2haNTJTQm01?=
 =?utf-8?B?YmNEajNBeEc4U21Wamlyc1J4dlNMQkFCeERnS3gyUE9rdkZPdzE1Q0JmRzh6?=
 =?utf-8?B?S3hvV1p0aXM3bjVEV2hKdldHQ0hoWTFlT2h6UEJ6dFRKcHFrZUI3amhkclBN?=
 =?utf-8?B?Wi80OXRKb3VWSGVDM2Fkd2RlSVZhek43ZWxGTllWVUE3Vk52ZUFia21BMXgx?=
 =?utf-8?B?VTd6djNTd05INmZqeDhUU3Nzd01SSFVOeHhMS1BRRVdURDgzYW9sc05FM3Na?=
 =?utf-8?B?RFovdCtHZ2JhVXA1eGNrQzJ5V29GSjM3OFM2Q0dSREtDUmNBQ2M5dTdSRlVD?=
 =?utf-8?B?bStaOEN6R25kYk1rQk13S0pJRnVGaFJRbWdFMG96OWl5UWF2WjFHa09vRzNi?=
 =?utf-8?B?aXQ4anFpQjM4ZEs4emgxQTVQUXJYRHRoUFlDWnIyRHlESk12S0VEWFVZRVA0?=
 =?utf-8?B?NnVJTkxoanE3cjZ3eEZzeXNvWWE0bDdMNTJuSFlaRTVsLzU5VkhzUnQyckY0?=
 =?utf-8?Q?aO6cpu3xL7c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU9idHZvcEN3ZWNXZkJJK01lSFJGMmFvM1FJT0tIN0tyMXIvenVEZiswRllz?=
 =?utf-8?B?d0hjS1gxV0dxLzZWWDBzNmVoTzJ3NWU4UFNwMlNFK1NjckpodWJSY3Q5K2JJ?=
 =?utf-8?B?UFZ6ZUZVN05xMUNTRjh1Q0RNK2R0eWZhVzBqVzh4RHE4bzZxUmdiRnNmUHQ1?=
 =?utf-8?B?YnBhanZKZkF4OGRKdU10RVhXbC82ZkpnTWoyS05yekYzNm1EbzZ4aGIrdHMw?=
 =?utf-8?B?Q3VUbm1nNlFpQUhrZWkwR2dTeEVKNXNsT1dJN2RGS0paZlB5a21Tc2kreUl1?=
 =?utf-8?B?Rld0ODFodlJmLzU4UnBnaWJWMUVVWDN2cWlpcDJ0YmtWYUxYaWdzOHVPVE95?=
 =?utf-8?B?UUh4QUlvZVQxa1dWdmxiaFhZSFd5czdwN3c2RjVnVGJPTEVjN3ZiOGZKQnBp?=
 =?utf-8?B?ZFpkdHRaczVJYm5TNkJCdlZCV0c3dmQxM2hFM3YwNXU0eHpnVXRnQkRBNmgr?=
 =?utf-8?B?MkN3eWt4T2lkdlE5UVRCKzJwY2hST1lXZk12dGxzVC8xOHoyTE1CbElTVDQ3?=
 =?utf-8?B?YkZmNGdiYmU0WWMwdkJRL0FyOVdZMFY5NnBTVDAzYmF5SWNJdW90ZWpnTTly?=
 =?utf-8?B?QnhleTZPaEh6ajlWVEk0TzNjN1kxcmZ3L1YvUVM1VVI1ckxra3I5cSt3Y2NU?=
 =?utf-8?B?dzhqb1lxTXpBVW1yNDRXb2QxcjJxSzlwQXRoVitNUDZ5MXk5c2JZSkRGeHpI?=
 =?utf-8?B?enlwTUJVQTh6VWpGM0JDazExaDZpc3d1UWxaaFRubTNNcmxYYllydUtOaGlp?=
 =?utf-8?B?VCt4VmRTVGc5bnBZUkN5cHJBSmIrYnkwbjZyaFo4MEN6bi9Dc1k1b1dQTjNo?=
 =?utf-8?B?NUwxbEFhbWdNdmtlZ3E4cmpTOXdYUitpYWJZMExuY1N1cWE1aU1sM3IwWFNJ?=
 =?utf-8?B?TDNDY0pwQ3l1U3JRaHY3R0RnMGFDVTNML2ptdlVtRHZKZ2o2M1lsdlJkUzVv?=
 =?utf-8?B?Y09WOU1paGpKbmpKNHdyOVZneHB1M1p6dHdFWWN5T1FWN00zUWtIOHlGL3pX?=
 =?utf-8?B?RGFtc21KT2R3VmRHUXNYeW5jL0ordFE1RFFlMmdsRGErWnc3d2JhMTZ2ZHl3?=
 =?utf-8?B?UUhiaEpNOFYxRlQ1a0VPcVgwQnVkWjh2SE5BRmNXSGtQbk1YdU5yQkVPRDRG?=
 =?utf-8?B?L0pNbTd6dW5xdDhPY3E5SWlpM3VnMDhOSy9CeE5FQXpmWEV0MWN5czNVbzRR?=
 =?utf-8?B?OGxJb05sMnh0dGpTUnpvcHhyWlVzSGQ4b0tpUFE0RmF5eHNnblJzbzBRM1Vq?=
 =?utf-8?B?cXhVSWJDV2N4VCs3YWRFcFhPcUtqNnVRT2xlTUhTQVNUNkhSbWdrZ0RFYTJi?=
 =?utf-8?B?WEg1VzJiK3JOa2wxQkFrMERlbHdZQ09HRTBrNVFzdWIrY2xpdmFEMUNsdXlz?=
 =?utf-8?B?MHlXZHdvU2RoQldjdTFMWWpjV201K21UQUViMHVoMXpoc205bS9RTG8waDhD?=
 =?utf-8?B?QWJMYlM0Wk1CWG83Q2dieDFDQzNUVGgvdVJuS2ZWRFNHVzBWQVRDMlFSZkVi?=
 =?utf-8?B?SGxzSjRYSkJOYk51d3FEMmxHYzVXWWx1dzk2dG5KeVpFVUZZaWVwS3pncVBX?=
 =?utf-8?B?akFnTWYxQ2s3NnJvRHNEVk9WMzRaM2tRNk1KVkVMRzFpbnRSbVZqU0liSk54?=
 =?utf-8?B?RzU3MCtwWHVjNVlIODNnS21hRDBETlJGdTNaY0pPeXAvSmlaRVE3NW10Y3ZP?=
 =?utf-8?B?VUdpeit0eU5aVzJ4UFNvREVMV1RIdDZISjJ1Q2pOZk5LRVJTWjQ1UU50ak9F?=
 =?utf-8?B?R1d0UEJPMkc4VkU4MDVrL2t6WW1qSmdDNEJaQVJvRUtIcHoxZ3lwVG92czBz?=
 =?utf-8?B?MVBjaGZDT0hYZ3pmTlgyeGk2SnJQRWpPVUtFVHhUWURoUEMyY20rTTVzYXFm?=
 =?utf-8?B?WHdYM2RmeXIyR3hocmNJeVpTQllhaFZBZ2xaVzhyNHp6TVZZaHYxbit2RWJ0?=
 =?utf-8?B?Ym0wWHVQTS9LV3dhOEdJWGd0aTZBd1h2Tm1nQkZMdUxaUENvWnMyMnU2V3E1?=
 =?utf-8?B?bkI5MGlTZlE2K0Y4RytvREI5VWcxY1U2YUt1SlMyRDErQjJ6WHduc1VuUStR?=
 =?utf-8?B?NU1DYVNLNWJGeEI5ZkdjWFdjZkxvRU1HU0pkSG4zL2VzVWc1eDBYY0hMLzBu?=
 =?utf-8?B?VFhDanpBTlN0UWxxcXh6VGxONnFVMjFhem1ldWNGMUFvQnVqVTE4R0M1aHNr?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z1dWTCnMfpiEZSPyc68dwvUR3JT2RsgdRhRV9L/F7UEktAqt2PsVFlZVxGMyRK5AcfwR0mBMaCWlnqjq+QmLVPy183zjLD1SKSNEwCTUGyGS6WOZ/b8pwyzYWQaVraeZo9ZKIlX4Z01l0BkiJ79hWGGCkTpNjdj31xhU050GeTT+JCKuW4dq6SXo7TtHJJRTYPmwPZnmIwrb7sCESN6Ri+NGIcN8/3UZG8TbDLO0NDirds4lDOuKwA4SQXHshjQnmAJOHi8uy3h1zqen/A49hQTyAmO6UVp2f6kb2dPb8n/2aTXihmzJdldbxvjD4wD8Fpoh0uw0jlTipp66h6Pw+uc03RUXlcis4MklpEgnpTRXb8nvll1WXDOB9GQWBKmaUEPMqjIhES1fA9xy0CRKgPXzdDrp+asno8ACfxqgBwQlLBjVHEnUklexnoQenabSQotAREnDjdemJoxJjg87Ry7Cy0TX/Q2f5sUeSqosPA27EOeQ0iCatni4cNrsj6HiBDbBl4NO5rF63cKME0sBZm3b9MGYaw5zER5WHA60a3/1QZAwPkFlbqZUMcO/K9RgpNR//YLQqgF/fk7fAfgXbMXZyN7A0w8q4nSx2r6nttU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48170bdf-e237-4d27-e58f-08dddf156a8e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:42:03.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OXRccuYkzFY50YzGx5O787N4+c0uLfnZQukmk6knGOFxeSKnf34FS23voTr33K0Yw9fpgNIhISXqYwHXBVl8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508190110
X-Authority-Analysis: v=2.4 cv=DLiP4zNb c=1 sm=1 tr=0 ts=68a4630e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kLWA3gBXtu5QbDPQ:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=t9M0ccyR3wMi44KbuZQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDExMCBTYWx0ZWRfX9UsQX3c17D/f
 FOP2zViAk+fiXcR/sqsDrhZP5EoUTbo9QedjjyMKMpS6iLbjTqHrWNZFWBMsC9YO6xXodXIzNXg
 60FNaZj8N7OX5x2nOXaT9pqBPp8Ez0E71+FBZoEPNDxbK+gOWPTSOn57tIJW4DfoOL0q1SwXjVn
 eblN0u0D0IcyGMyetMJ6Cn7Pu1zqrvglsF5xFK53zi7IbUKOEkBFv3opyMOWLyagkZ/lfLI8G5X
 tZqYLi7e6szHf385EtZfxDihKrEPHEW+Fy6wSvS0k33AImN75Hew9Yz8lyTJWrJIDuR81Im25qm
 JCRtaSmdviSQ9Q2olEywnxM3pxP/23nrx0QSchTl0QZhEYt/7IDxBlvBz7XPrc0k6Yc7JLB6mEO
 jTA605TXlu6PPJgbnk4qEA2PruNDl7CE9w+iGuP9bmIT7Qv0wANgkGR24PKAoH7A+V6ZC4QQ
X-Proofpoint-ORIG-GUID: X381wVbI1v8Yc2Q7nVqpzL8fnaS92b8B
X-Proofpoint-GUID: X381wVbI1v8Yc2Q7nVqpzL8fnaS92b8B

On 15/07/2025 10:03, Christoph Hellwig wrote:
> On Tue, Jul 15, 2025 at 09:42:33AM +0100, John Garry wrote:
>>> I'm not sure a XFLAG is all that useful.  It's not really a per-file
>>> persistent thing.  It's more of a mount option, or better persistent
>>> mount-option attr like we did for autofsck.
>>
>> For all these options, the admin must know that the atomic behaviour of
>> their disk is as advertised - I am not sure how realistic it is.
> 
> Well, who else would know it, or rather who else can do the risk
> calculation?
> 
> I'm not worried about Oracle cloud running data bases on drives written
> to their purchase spec and validated by them.
> 
> I'm worried about $RANDOMUSER running $APPLICATION here that thing
> atomic write APIs are nice (they finally are) and while that works
> fine with the software implemenetation and even reasonably high end
> consumer devices, they now get the $CHEAPO SSD off Alibab and while
> things work fine their entire browinshistory / ledger / movie data
> base or whatever is toast and the file system gets blamed.
> 
> 
Hi Christoph,

nothing has been happening on this thread for a while. I figure that it 
is because we have no good or obvious options.

I think that it's better deal with the NVMe driver handling of AWUPF 
first, as this applies to block fops as well.

As for the suggestion to have an opt-in to use AWUPF, you wrote above 
that users may not know when to enable this opt-in or not.

It seems to me that we can give the option, but clearly label that it is 
potentially dangerous. Hopefully the $RANDOMUSER with the $CHEAPO SSD 
will be wise and steer clear.

If we always ignore AWUPF, I fear that lots of sound NVMe 
implementations will be excluded from HW atomics.

Thanks,
John

