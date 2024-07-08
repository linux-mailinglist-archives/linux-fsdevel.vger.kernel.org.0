Return-Path: <linux-fsdevel+bounces-23287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CA792A4E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 16:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875581F2228B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3AF13D2A0;
	Mon,  8 Jul 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O5z7Jydk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uQohCrPH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5FF1C06;
	Mon,  8 Jul 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449694; cv=fail; b=KQOzRuJhQb8DCQnZCXh1dUDU2IFVnmur4WrY45M2u0CvgerCsFmOGdvjEwtsJpEIrHhW5sVV1dt0h3H5KB2Eg2fcJ0dYW2kDIHwwUVDSs0iQPJz1JzcC8LpLjYW1mkY06cblkOiSmqcRTy8SnzImyRhwB4dbCbAdIE7JweED4C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449694; c=relaxed/simple;
	bh=NQ5asENGmQspEx7SuWponZ17RUqKlOdRN8QUoPPs+jA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kskb/PBOCSU2wFHBIxbsyuHDAaWWuWBRATKgIpqE8VMzLL/rbuTn+Cf7qnbVFqFvEnXQugG5QwWxOVmJ/1c8biUyBm6ZlUsL0puSfuQsupZvXFobfrmpgjJt86HmFzpXv8yXkq3VMR2C5CX+s5ybtTQ0cBt83Vm5fUa+mphzQKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O5z7Jydk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uQohCrPH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687ffxE011980;
	Mon, 8 Jul 2024 14:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=SxHzRQ835mn4bQ7HcdfRLmOej0kEuviQpT5sx4J9QUQ=; b=
	O5z7Jydk7U4Gz/MHDnofqbvyPDZXCUnYjbcAbpgAFOy9Loi9P/QHi1oEe0KA1+/V
	4i2C5LTQfaxz67fvHwHjDJFCPJM0dGAENQTAnQ5CbCSSerGSbrr7WSnze0ZCE2/Z
	SKideuphMbnIIRBTL1Z6J2GWa0SGLxIzwQXdNWIH0ICnrk3Jh0cP2OA1RcBsks8s
	yLOGIRfhQMDEwLBUS1P5qUJaHh/2IzimR+iI4C/n0IeJeH5anWBCBBG/VEfM0DEh
	dQr2XQFJ+T+ezUoS20lWXmSChgkG1eW/Ta3zy/DvF56gL8dT3KshIqG3XO/SZSOq
	qRs0dGsz82HKdOJAksvs8Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybjtqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:41:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468DHYvH005824;
	Mon, 8 Jul 2024 14:41:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx18d7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 14:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jV3prlZ3kM28/1cmk5BtZh8IXTLqQofe+Nr4bM6pMVIbffxAey2C8dZGSZS/aOpd5ybtZOMHrZzXFQXMR+XP7j+fFmBpe9baEAJ1Ja0BQDT0nTPvn2qZQ4+nn+hxvQjnXBAHFzkOy56U3ExbjvVyzEJ+8Io0lPdD0UfehG04fwFhMG58pQ6acZbhmvZIk0VNQ7qYVaFTzXshePQSkCN8xcrscLhNOBRM0qSc9padGAfPMNy+th85YX8g+fiu+2eE164JFIF+fyA9PaX/c9jnthBGFCTSKJWyhwmIlMtrF88iYdIiOwf+6JWj0TEnpKlkoDDrBXHL4qhAMZyWW7SUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxHzRQ835mn4bQ7HcdfRLmOej0kEuviQpT5sx4J9QUQ=;
 b=R8PNBvdmnWi5WpZFMFbLjT/LAYrbjxqzTEAWfK2ivR3v85t+jsxOR9SYSUckHtwqy37CUAi8deZmQz+jShQwpgboFHimZcWEbWvdXXu/ZO1Uj+/WgXv5f5y1oJpn58anhLLKRBScHkIo5C+kiGUHACYs7dn/JR/TBx1Cp9HxgT3cRkIxMwZAwoukRU5DRNETzgYQt6LtphLSWJQuOXZVPiZtC2/KaNA9XGqG7rkLAsfGdFm5BCg2Wlk6/EV7Zs0Sky+5bbsID++9z/N1KlZu4lAMMO+p/56TJRcc4MepKjaEsPGerPebp/aqFARrVzqm8fWd7CAhuGVJN8R6C70SGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxHzRQ835mn4bQ7HcdfRLmOej0kEuviQpT5sx4J9QUQ=;
 b=uQohCrPHu4OP4Xh+EfWf7Sa9Ufa6onCx3MMzjNkiz7Go/IGLS7/w5/Hq7EETTvZYFalYR7DkkWPB7qAsqE+LFYaKYvni+O2h5MYU47BpdMR6mcbljmUSs+4EBBcRYW1nMN/JSvOqy9Yc65H+VO4Ha9Wt0wsSgHOo/FRuieonqVk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:41:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 14:41:12 +0000
Message-ID: <5cea4a30-76ea-480d-bde7-2109189ae5be@oracle.com>
Date: Mon, 8 Jul 2024 15:41:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] xfs: Do not free EOF blocks for forcealign
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, djwong@kernel.org, chandan.babu@oracle.com,
        dchinner@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-9-john.g.garry@oracle.com>
 <20240706075609.GB15212@lst.de> <ZotEmyoivd1CEAIS@dread.disaster.area>
 <6427a661-2e92-49a0-8329-7f67e8dd5c35@oracle.com>
 <ZovJqNFyHYRWRVbA@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZovJqNFyHYRWRVbA@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0623.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d586ec8-a3f2-4ac6-e525-08dc9f5c037a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cVhYYzB4dkxCQTRzMnVTUFEwSU55SFQrd1JVRXBlMU53OHVxM3VFd0FVREJz?=
 =?utf-8?B?UmVhOHlVc0JteVBPM3NVT3lXejJucUJDdzEyc2pXbnBxMDd0THYrQnVqU2Yy?=
 =?utf-8?B?Wkp0MkFFc2VFa3k4dkUxOFpJV0UwRkxVaThZMUFCQ0pJZFRGVFByY0RjTFVJ?=
 =?utf-8?B?ZmMvMkhSejRrN1pmNFBmL1Z6WnIyU3BiclNycFRLMVNuTU1WT3doWk9kV1ls?=
 =?utf-8?B?dU8zN05OdG9kWnd2YnBkRHhaR3VVbE5XbTREd2hoM3piZS8zMTN3aUUvR3Zj?=
 =?utf-8?B?MmhvQnNVVUl2QVBYcEJXUTBUOVR2L1dKMmcwanlnbzExYzNQUGdLYURpMFQ1?=
 =?utf-8?B?SVUrWXFmTXhSa2p2S2J0WTlwYjE5Y3haRGlIaEdXeUNCb0NBQ0tOV1RIY3Zt?=
 =?utf-8?B?ODE1cUQ0OGIzQ3IyeHRPeTZXNnZUSVVDcXZqejFHa3ZjZlZ2Q24yTGFJbVFW?=
 =?utf-8?B?VlZ6ZHpxTitJeWtPTEFhNUVNZ0p5RksyUFlheWU0TnRKTzh4WjZjdFNEbjA2?=
 =?utf-8?B?TzVaRFlueFl3czZrWFgzc2EvRlhLa0xzLzN0Rnk1ZTlva0VCdGgyYTFTNGpq?=
 =?utf-8?B?VCtLcFk0VHloYmtiekkrbmI3dGVNTTRscGlPdVczSEZiMTdwUmdVd21uZlV3?=
 =?utf-8?B?Y3d4YUErNnFQMml5WXcrdzJGNC9sRU1Ka3hwK3lGRExPbXpZUGh0bWJXSlQw?=
 =?utf-8?B?TFA1clBCbGFKd2dkMDlXYTFzck9Jdy9mcFF4TXFVMitFWjNzSmhtWUZITzFK?=
 =?utf-8?B?cGRESnpaRjhVdWs1YkJmRkZoMS9ZRjBrVmwyY0l0VUN4NXlDR1U4SmdaZTRj?=
 =?utf-8?B?MUNZL0tvejJDT0MzS1JiM2hnckgxUVM2MXN6andzbmF6QjlTVmVsa0tjbHdQ?=
 =?utf-8?B?WVpzU3pjQVkvK1lsYWtqOVAzSHZYY09FWktzQ0ZISlFiT2ZrRmFKVE5Gb3VG?=
 =?utf-8?B?S3VSQzU3TEI2UFFtU3haU2pLVkUvbE1uclZRR3N2bzRUUm9aS21YNkRjc3gx?=
 =?utf-8?B?dzNkSVlRdERQMHZrWGx2Qkpwdmx4QXhWNEFEVlRpVElYcVRqNExIbTFqS0lZ?=
 =?utf-8?B?YmQ5cFdNUWFFak43N2JETHM1ZEJ3WUZ1VGVNZUxUd1dwdWZkQkZQbUtaMGFP?=
 =?utf-8?B?WVZUdnFkQ1BRSElSUU1BbkVxejlhYkRER0JvcmladWpOR0lEOGwyQ2dpWkJF?=
 =?utf-8?B?bkljdXZNTTNXMVh2YnRJT0hSSmtkb1N4YWlTRW02aDUxblpDYjI0MUtQZERO?=
 =?utf-8?B?dnhMdFgwdVJRWXNoM3pFR2JJQ2NEMG1DMGlSQjVxYjRycXZLNWN1WVZHaG1k?=
 =?utf-8?B?dWZ3cUF6RjUwOWU4dDkzMkxwdlllMmdaOEUxQ1VIWWxkU2ZzOERqTkxJWmhP?=
 =?utf-8?B?WnM3dEhYZFZYZU5ZcUZBVzJoRlFOVjdUN1FFK3ZvNjd3c2s2cmZnYlZtK01J?=
 =?utf-8?B?OC8ybzQxQmhYMk9VbWE2ckk4T2lBTnRONFhBNFBUeFNXZTBkMHY5dE8waVB2?=
 =?utf-8?B?Um5kd2EzMWVUY1plVEpGUHlvRmZ1VlNETW9YUHV6SGkwdUVVS0FCRDMwb291?=
 =?utf-8?B?dy80Q0Zxam5ScFhTNmM5MUo2ZHhhbFJvOXRGWllLeFNyMG5Ja2R3Y2NuTnd3?=
 =?utf-8?B?bzc2Y010akJNdmErRlJNU0x0TC92QWkwc3hDN1NCa2lLbnNXVkZ1dFJpZ2Zn?=
 =?utf-8?B?czBBVG1CVU9mUENwM1dWZm5WUFNlVWFWZ1ArMmF4TzNuaTFKRXZEM04xcEpm?=
 =?utf-8?Q?Oeemny1ILbKnATlz18=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UVQvaHg2TXNJcnZxaWpYeXI5c3hMRjg4Ui9zUHkyV1VId21zbEU4RXlNWHJT?=
 =?utf-8?B?elBlU0xnYytab2hucTRBdzgvKzI1VUF0RFVJOTFYTGZucXhFWVlZUy82c0o2?=
 =?utf-8?B?Y2ZKczJRczBEMDFQS3N5ZmttRE5sY1lkWU5HRnVFdUtXenE5bG5ZNmYvNzgw?=
 =?utf-8?B?cTBiU2hBaWRPK241V1FBa25XdERQZmMreCs4N01aTWNtam1VYkUyL3pZclVV?=
 =?utf-8?B?elRqUXNERGFxejZnT2cwSDVYM1ZLdUtEa2FOemNoMjZjV3E2eWhZNDh6S1ZR?=
 =?utf-8?B?UkRXOG9oMHoyNFJvam9kR0NLUUhna3lqNUFURDhXRkJMY2JnL1FhaUtlNzQv?=
 =?utf-8?B?VFp5eGF4SUp1aVdOMzBFWEZ6dUUyajdKNnFUQldUckhBUEdvMmZaN05MdXhG?=
 =?utf-8?B?cHB0SkFqbkxjN0xEV1pxRGtkUDBEZGNmVXJaT2dhejRzUGxSVTZSaVdzRm5k?=
 =?utf-8?B?enREM0h1U3AvU1k5VzZNVG5ZRmw5RElFcSs0MXNPYmxKclBiMitqUFJQS2FD?=
 =?utf-8?B?ZEJNRU9jTnBmQVhWdXY4L2NubHlKR2oxK25qZmRyLzBiYldwSjNSVGw0cmM0?=
 =?utf-8?B?eDE3QjZObUZTTEJoTWFFSnJlVFZZVWY2Z2ZiR1AzOU1YdmV5RlM5MmFmaFBp?=
 =?utf-8?B?bzhpYzNodUd0dzBzQ25GUGpia01KRGdCUlp0N2RxdEZBS0xnRWpSWW1FT0pS?=
 =?utf-8?B?RDI2RFp1cHJ6b0phaGUrYmJjS2VFVjF4QWJmbDA5N04yZzRDYUtiV0oxeHNl?=
 =?utf-8?B?RTgrYndRMi9rSTlPR2FwY01qZ0ZYN0pxYjRiUGt0UnBJU2tRQUF4NE01L1lE?=
 =?utf-8?B?M0VXQzNlc2NYRTJleENCRGFwbWM0ZXpDUzlnbDU2WnJ0ajMwdS9sSUhHbnYy?=
 =?utf-8?B?NVZFVzlSd1lqTkgvQ3prd2JvSkR4cWdySldQWGpadFQwZ3o1OTNzS3hOaXM5?=
 =?utf-8?B?aWozbzQ1VURDaDUvVkIyY2N3dUtaOVYwQy9PME13T2Q5cGg3bG9rYVpOS09Y?=
 =?utf-8?B?QkV2QTREWmtCOWZSdkRYVGFYR1Mya1BCeXczdEVoMi9WbmdKdFM2TUlpVmhW?=
 =?utf-8?B?WitybndxS2lTTm9CTU1TSEZmRWQ0dTEvRkxORjdyNlhXck1KYjJXOGphQXZy?=
 =?utf-8?B?NHdtMFZZUi9WMzVCNGVMNTc5REd3d2ZJZEZnTFplM2tqQXdmMExNZWZrMEdR?=
 =?utf-8?B?aDBUSTk0VDNmNnVySWZ1VVlSb3g1R1RyNFhrVVAyYnF6NmJoa3ByM3IyVVU3?=
 =?utf-8?B?MWRzRHdMWVZqbkNMRzUxL0oreEFDVTBCUUEvWHNoM0s1YlhBNDhUd1hOYnpE?=
 =?utf-8?B?WFRnOThmc01ZWGpqb3J2b0NVZ2NScXljalhOVHVVN0tPTVB4T3J4TU54aEpP?=
 =?utf-8?B?QUZ1VXMzTnVPd01QQVArZWk5ZXRtZjUyMjdHWmZvOXZoZ0Z0ZFdiTGNYQkh0?=
 =?utf-8?B?bnNJa0hFcXQ3T1BWN2ErZXFTUTJSV2dsT0cwb1kwQVAwdWZ6a3NHTll0ZzRx?=
 =?utf-8?B?d1hWSUc2THZYWFVMa1lPZGNJVzNaZVI2Y2Z2NGxLRDZYVzdCYUJXZllpRVdz?=
 =?utf-8?B?OUovM3B3SDByWUdYeFIxTzc5bGJydWdqZ1NhRmM5c3dUYXhjNmc2QmNjcHZv?=
 =?utf-8?B?NithN2xpK2Rsam5PczlSVlVqek01eGd3SGMrN3VRVjEvLzV3MWpaREVnaG1B?=
 =?utf-8?B?WnJjbWsySWpYOVpFUlFHckNZVmpLRERta3V0d1FsRGpEQVRTb1RKcWlqdzdr?=
 =?utf-8?B?a3BJNG1mTkNWUWtGNHdEU3VIU1A3U1VBQmpyTDByUzNXQmoxcEd1Z0xJUVJR?=
 =?utf-8?B?SkYzQVVrY2pVWXNYc2VLZzZ3WTNIV1ZYNWs3QUtSN3FPeUZZN0lxVm9ZZ1o1?=
 =?utf-8?B?VTh5Z2dZSXVCUk1GcFBvSWIzZU1seEkzRDJ4NWV5S1BubzYxY2U3ZXJxNVRi?=
 =?utf-8?B?Zm1FbmpaSlF6VENtUFJLcm9qNCt5ako4bkwyYVNXYzMwQ0FEOGw3dGhjaGo0?=
 =?utf-8?B?V2pNaXk0RHcvWWF1T0psRTRuTmFrdmExaU5OSVQ2R1BxVUZTTFVHaDZ4VTk1?=
 =?utf-8?B?eWhHa1ZIYUpVUDkrNHl4TTZLcnNkb09yUkJRM3VkdFk2WjUzOXhWbXluRWh1?=
 =?utf-8?B?T29LK3poSFBTdkFQT1c4N3FhMnExdU5Tbks4c0RyQVp5bnp3R3ZBeFlDU0Fq?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LL/rB8NDONWTlHFtKpXoY48GvpBCJLMFTv6Mc9633pxxaRO6am5oO12JQLhbMcWPLxgQLrNexQL1erJeGnmM6Qpx1XnFXVJ5qzsYwMcyVzmi7Am7BMVUU2dqZ/4RXUYFLTmy4c8AkkyZPI1aS2cjQr6CMo7/ODst2mqeiYyVzT1Pe/eQ4FNk44THnlLidgV6G65hY8XvWQ0Z5zfefJUO61orw9bIMd4KTPdw5lHovyuFoV75yYXoZmx4KcO/JjZLrHHyUjPa2+Wv5OWgkBX/tvIALltbr+E5Ie1zpaGRlEaPK3MH2SjeGkP2QINlSZOiHDM0KJjdVNGIbKT6J4UKSYL7wSBU5Uz3MX2HjuJeVrRiUvSbDp+l2Hp8cYTvHp4xGswhs8XX5fLFZo146qXQvMPma+je79YL/fXd8Ilu3wB+TTnSuhtwGXAxM+M1YYZYwG00UEVPnHwfRc1VF2I8XD951Bl4Wa/MAbosKjWnrEoyRHeiTu9FEMr4n1RtxcVwG9bnnFx1PSbAN3z11w3O95xEl/h4ggwcYuj2D3FLBOvSuN1Ha4FTbm9XcIDClZ2jt9TnbXBWH2mN7yc5OdEy//B74iWkIs70kbmfbZ6vz5I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d586ec8-a3f2-4ac6-e525-08dc9f5c037a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:41:12.5895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKlmU0FJcZMSsNimQ2kJTl21wx4+2pBWbuBbNYftLicSM59nZ854qp+NJIjx16lBs/v2oW0OEWLOuhg/kQh5cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407080109
X-Proofpoint-GUID: 0TxQROyJ-k5rbaPT5DeiZnMP2WltyVNx
X-Proofpoint-ORIG-GUID: 0TxQROyJ-k5rbaPT5DeiZnMP2WltyVNx

On 08/07/2024 12:12, Dave Chinner wrote:
> On Mon, Jul 08, 2024 at 08:36:52AM +0100, John Garry wrote:
>> On 08/07/2024 02:44, Dave Chinner wrote:
>>> On Sat, Jul 06, 2024 at 09:56:09AM +0200, Christoph Hellwig wrote:
>>>> On Fri, Jul 05, 2024 at 04:24:45PM +0000, John Garry wrote:
>>>>> -	if (xfs_inode_has_bigrtalloc(ip))
>>>>> +
>>>>> +	/* Only try to free beyond the allocation unit that crosses EOF */
>>>>> +	if (xfs_inode_has_forcealign(ip))
>>>>> +		end_fsb = roundup_64(end_fsb, ip->i_extsize);
>>>>> +	else if (xfs_inode_has_bigrtalloc(ip))
>>>>>    		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
>>>>
>>>> Shouldn't we have a common helper to align things the right way?
>>>
>>> Yes, that's what I keep saying.
>>
>> Such a change was introduced in
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240501235310.GP360919@frogsfrogsfrogs/__;!!ACWV5N9M2RV99hQ!LU97IJHrwX9otpItjJI_ewbNt-T-Lgyt5ulyz0yGKc5Dmms4jqhwZv5NregBEK_dTEtEDCYCwcA43RxQFnc$
>>
>> and, as you can see, Darrick was less than happy with it. That is why I kept
>> this method which removed recently added RT code.
> 
> I know.
> 
> However, "This is pointless busywork!" is not a technical argument
> against the observation that rtbigalloc and forcealign are exactly
> the same thing from the BMBT management POV and so should be
> combined.
> 
> Arguing that "but doing the right thing makes more work for me"
> doesn't hold any weight. It never has. Shouting and ranting
> irrationally is a great way to shut down any further conversation,
> though.
> 
> Our normal process is to factor the code and add the extra condition
> for the new feature. That's all I'm asking to be done. It's not
> technically difficult. It makes the code better. it makes the code
> easier to test, too, because there are now two entries in the test
> matrix taht exercise that code path. It's simpler to understand
> months down the track, makes new alignment features easier to add in
> future, etc.
> 
> Put simply: if we just do what we have always done, then we end up
> with better code.  Hence I just don't see why people are trying to
> make a mountain out of this...

I tend to agree with what you said; and the conversation was halted, so 
left me in an awkward position.

> 
>> Darrick, can we find a better method to factor this code out, like below?
>>
>>> The common way to do this is:
>>>
>>> 	align = xfs_inode_alloc_unitsize(ip);
>>> 	if (align > mp->m_blocksize)
>>> 		end_fsb = roundup_64(end_fsb, align);
>>>
>>> Wrapping that into a helper might be appropriate, though we'd need
>>> wrappers for aligning both the start (down) and end (up).
>>>
>>> To make this work, the xfs_inode_alloc_unitsize() code needs to grow
>>> a forcealign check. That overrides the RT rextsize value (force
>>> align on RT should work the same as it does on data devs) and needs
>>> to look like this:
>>>
>>> 	unsigned int		blocks = 1;
>>>
>>> +	if (xfs_inode_has_forcealign(ip)
>>> +		blocks = ip->i_extsize;
>>> -	if (XFS_IS_REALTIME_INODE(ip))
>>> +	else if (XFS_IS_REALTIME_INODE(ip))
>>>                   blocks = ip->i_mount->m_sb.sb_rextsize;
>>
>> That's in 09/13
> 
> Thanks, I thought it was somewhere in this patch series, I just
> wanted to point out (once again) that rtbigalloc and forcealign are
> basically the same thing.
> 
> And, in case it isn't obvious to everyone, setting forcealign on a
> rt inode is basically the equivalent of turning on "rtbigalloc" for
> just that inode....

sure

> 
>>>           return XFS_FSB_TO_B(ip->i_mount, blocks);
>>>
>>>> But more importantly shouldn't this also cover hole punching if we
>>>> really want force aligned boundaries?
>>
>> so doesn't the xfs_file_fallocate(PUNCH_HOLES) -> xfs_flush_unmap_range() ->
>> rounding with xfs_inode_alloc_unitsize() do the required job?
> 
> No, xfs_flush_unmap_range() should be flushing to *outwards*
> block/page size boundaries because it is cleaning and invalidating
> the page cache over the punch range, not manipulating the physical
> extents underlying the data.
> 
> It's only once we go to punch out the extents in
> xfs_free_file_space() that we need to use xfs_inode_alloc_unitsize()
> to determine the *inwards* rounding for the extent punch vs writing
> physical zeroes....
> 

ok, well we are covered for forcealign in both xfs_flush_unmap_range() 
and xfs_free_file_space().


