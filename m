Return-Path: <linux-fsdevel+bounces-35457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E399D4F5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 16:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44288B2A1EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E081D89FE;
	Thu, 21 Nov 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bnash3J7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E9lXki8N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501F1386D7
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200886; cv=fail; b=eM2t1UYYMav5fMAtllepqyGgcEJbDe1FBSUGiftxL+T3p0R7ArhwxCqMnxGKzZmh+SEqOohyEs5Om+u618KrGTVOun04svlcMYrucYKSMGU/Aw7wWVIDzWBh0dgJ3mmVQfB7Sz74ohDjQi+M3I1MlubyzhuhPYLDn50RVrvNRsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200886; c=relaxed/simple;
	bh=w/LxgbjpR8BR0H/+QM8yedUjjZEd80orST4uetaHlAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O5MnyVTOaEx/TZpp3SIsfYHe6rjPNLEYgQagLEP3MTKjKIbmn4i8nDQpAfX/z2EDM317zbv9kJHLW2+z4M6DBcEWq007PnuX6sgxeTr1FQ1aqCLswNeWLA8In5iTXfvLiCDQIbevpY7gGncnDl2xqgnE/SDVPuchpIMOuknw7h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bnash3J7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E9lXki8N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALDKICl023495;
	Thu, 21 Nov 2024 14:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=w/LxgbjpR8BR0H/+QM8yedUjjZEd80orST4uetaHlAM=; b=
	Bnash3J7m2OtnwkxKLsa7dTmv4HystCjHSURa6McOW0lZ9era5FG1QDwxpsF2d/5
	jPI2Qud8Ow/oD/Og3r8ULVKnKUYyRZ+LHPMsbaqzBP55XPvrXJ5fN1et8cltZVYu
	0eISilEcIuEqetCVpsKG2gsrpohdBDd18ufgiDMnIRrgNmLT6t95JnYBIPaAuD8V
	fM7ETXiepAfeHmeG6SjgQcWwQKZ9bVj9A98D5NonW6q9qlZfmLDk/i7sbNFxpduq
	5tJxL0vM1nUWz96ThAsZJey7V7wybtv+f1DnoIYazmhjdw7ChJhzK/o183iQCuHJ
	Qfwih81cKy+PnlzkjkYslA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sstvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 14:54:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALEqsZi007722;
	Thu, 21 Nov 2024 14:54:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubs0s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 14:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqBvLXexZdES3jZaNRaQDBMvyiekDlXtIb2x5vlYjly1SXeGb65HfV7LA1Bb+gcG2fHblX8ywKRuywY2U/ZvuumLMK49KVIwxS84IYYOAkaE79/YYnilp0Xw2QdtzPyrZ2LFU4Zfg1ykpdRTbj/udoO3CdNaCS0d9Uh8C2dXoUC1DnmhTaVDK4YZ/jckP7DX7efdJjtIJVC30XBGGMUTf1HZZIA/6nbYCfhKnEyBxD3ioSL0w3NPBo1DIFenMsGtuAD6CdEUSMbE+dvW5nFDgwcrK5j1MZaXPgGk0MSPxYZhyvdYIEwEk8LWk7yjenDQfjZrHfWD38miFC9hsxS1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/LxgbjpR8BR0H/+QM8yedUjjZEd80orST4uetaHlAM=;
 b=jOleIdHYUc1mgA+BCFS8lsyIpPI5dIDqiK01eGtkvnG7dLJYlmC4hQhfSp6+Wrew71tVQDghxFuPiEx+Pu0Aj7wFFaSufMlmzgGvK4l8at+wubhWku7UFDPQV8QDP+vv+hfffcfA0UXHlHcnOFgbr1/9DZivmSsqewBs75fy+rHJ5uwBEKdOKmkEWWVqX+jOKIfnvV+jWESLLT1DOd2tbHNSE2l69u8A3RepKItSUoY8GhOKzusMikr5HlIT9H9lyHIUMssrur0CMoRKZYOACt0KgJo9fePY0V94IN0bnrlGq9wsVL0855jfcgSBmsxBcXw3e+lZlsy9X6K9o0xgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/LxgbjpR8BR0H/+QM8yedUjjZEd80orST4uetaHlAM=;
 b=E9lXki8NMBmB7eO4OSCv+LfTakyBeAg3NBX2LdoQqCECWCax31u23xTp340+yX4ofWeyqmtDsIEW6XvM+nt6izz7AeXm09WErtS56lWhsPpWqi1d0DDVxaxYTE7DREaRUKrTioZAdffI5rPpS9xmkcvz3V2bTuuD0SjAWZUqKd0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB7995.namprd10.prod.outlook.com (2603:10b6:208:50d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 14:54:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 14:54:16 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christian Brauner <brauner@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        linux-mm
	<linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Hugh
 Dickens <hughd@google.com>, "yukuai (C)" <yukuai3@huawei.com>,
        "yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
Thread-Topic: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
Thread-Index:
 AQHbOTg5NlJ24GOTaUaIEolbfGmWZbK9drgAgAAP/ICAAlv8AIAAEmaAgAF4ugCAAGosAA==
Date: Thu, 21 Nov 2024 14:54:16 +0000
Message-ID: <34F4206C-8C5F-4505-9E8F-2148E345B45E@oracle.com>
References: <20241117213206.1636438-1-cel@kernel.org>
 <20241117213206.1636438-3-cel@kernel.org>
 <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
 <ZzuqYeENJJrLMxwM@tissot.1015granger.net>
 <20241120-abzocken-senfglas-8047a54f1aba@brauner>
 <Zz36xlmSLal7cxx4@tissot.1015granger.net>
 <20241121-lesebrille-giert-ea85d2eb7637@brauner>
In-Reply-To: <20241121-lesebrille-giert-ea85d2eb7637@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA3PR10MB7995:EE_
x-ms-office365-filtering-correlation-id: e890d829-411b-4b58-8c57-08dd0a3c5f31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1M1RUNDOFl4UHUyMHVqRk1YaS81MHpaZDNwdEhvc2FwdVdkbS92NGVwKzFU?=
 =?utf-8?B?Z3BsMk1DQktsTnZtTnc0K0podlltb3RpZzhXUk1zQ055Y3IwT1duV3dIVTVL?=
 =?utf-8?B?NnIxMTVKc1YxN1ArYVc0OTZsb1JIOEdLUUZ5VUl0TExwT21oSENBeVZuejJi?=
 =?utf-8?B?RzBOT1FZdHlESCt0Skd3WU5SM3RoYXk1Wk9tRUtHeU94dU9QcVN3cTZNblht?=
 =?utf-8?B?bTRYNTcvS3NudU43UmVxQStKRkhMM21wcCtRVEc3cjhuTjBhaXNyT2orVFhN?=
 =?utf-8?B?bE9oVU5xaUduOExFSjFnV0RNejJ6Uk10cS9KdVF4b1ovb04rK0pMNmkwa3JB?=
 =?utf-8?B?SER6VzZHWjhkVXpmMkdFdW05ODh5cE5tYXB4bS9OMjFPUFRlN0NwKzVuOUwv?=
 =?utf-8?B?R2tIRlY4WU9nRGVhQlJGbWpGM1RNWENDbHhHNjkvSWNQbmk4Mm54aXlVaTVn?=
 =?utf-8?B?YWxvRHRtNkdpY210QVNEeEFvMW5rZGcrQWJtRHZnaGJXSFJRWDNTTm9nWldW?=
 =?utf-8?B?TVVJYXdLQmJTTUU0bkdlZk5CbTloSlN0VmU4eXlteUZvQStmcG94aE90OXBS?=
 =?utf-8?B?MDh3RHNvV2sxVlQ3NmJxYWVQKzlQOXlURUtyNGU0OVF1c08xdGhvU29VRVB2?=
 =?utf-8?B?cHB0QjNtUkJOUWdvQXlLNm1uT2YvbTdFMkkybU54MlQ5S3JCWi9DMnJ2OGtw?=
 =?utf-8?B?Y3ZuTGxEd1R1NWE5Q1VqQjcrcGNoN3NUbVRMUHRCNEhrOWZnZUNCY3JRM2w2?=
 =?utf-8?B?M28xQmRpd0hTNFJSZjczei9rY2IxS2JLTUx5RzJWVjhGVjF3aW1neE5kMFV4?=
 =?utf-8?B?V1JnVnVxOG5lSWV0Y2M4ZzhpbTl3M1VTdUJlM1BUREFvVHlDK1F5bXVXdFlM?=
 =?utf-8?B?S3hYZkxoQzArODVQR1h3NC93M0IyZG84K2IxZ3kzQk9pdDNKelZSYzB0cXdE?=
 =?utf-8?B?Tk9VNFhjUUNwakJ2bzN1dldsQ1VFWDlidGROeW9uZkNjRkxuWUZCdWF5YXU2?=
 =?utf-8?B?ZFhtOTNDYzcxWk05djdLalJlUlExdjYvYlN0ZmRsamVKMFBRR0hWa2F5dHRq?=
 =?utf-8?B?YzlONFpML0JRcFFFckRWWWxSM3Q5ZVdScW9Tb2RYZHJUQjBGT201U0Y1L0NP?=
 =?utf-8?B?V1JycytlVTIxTXVzeVBiZTIwOVUzWmMxa1BEaW5aaFZBamdMV0FLeDZzaVRx?=
 =?utf-8?B?bXYzZVpEMGJxMFhldXJKUzQ1K1BCQ01idDE1aWFXdDczcFZzckREVmxRRnZD?=
 =?utf-8?B?NEo0bnRrZWtMZFJiQk5WVzJmallJZ3NHcjZFVWZQT2ZzQUJ3TFY5YXFYUVc5?=
 =?utf-8?B?amxTT2EzVFhITXZhYTFYbU8xSmtDSWlVK2pBWDcxOXczODFlKzl4Y1VmWC9s?=
 =?utf-8?B?UnJGdC94RlE4N1dDblVCcWdBRjIySzJwUFZCOENwZ211MW01S0pERWtiVEd6?=
 =?utf-8?B?VUhYSmd2RmtkRTlKNXI2TnJ5YmR6Zyt2VzVucHBUbXg2RlBrbGsvSnVoaHlo?=
 =?utf-8?B?QnlLbnovSVVndGx6YklDSFEyNHdXcXpJT2s1djhvdWM4cnpkQ3U4WTFkSVJu?=
 =?utf-8?B?TnN4T1BjWTgxUlNqVUJBM2dNaWNjTUJwNUhoTFRSNUNYa2lPZ2RzaDdGNG9K?=
 =?utf-8?B?dnR6OHlSaHMyL2NicmpkeTFjS0xwMlYzOEc5bWNYUDh4c0w0cEZob0xZOTIy?=
 =?utf-8?B?aVFuclBGenlQWC84NTFwWmFBR1VuVzZwYU1YS3E2VHg3dTJ2bThVS3A3NzFG?=
 =?utf-8?B?emdEZEEyYmxwSkJ0RDlvaCs3SnFJVWx4WlVOSjJVaW1HWVZyNFNjU1hFRlNQ?=
 =?utf-8?Q?h1QqMRlH8Tu/Ur1lfhI0oGA9FmUhfvHHTCR+Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVRmZjROUlg4VkhROHVqMjVHaHJQREl5ZE9GcFFvR2pVLzhJMytxeXRDUWlQ?=
 =?utf-8?B?c1ZQM21DQTArb1NTWEhQU3lsamhuVWRYNDRSb3JQZFJZa1JNU3FudlEzdExm?=
 =?utf-8?B?TnVsWVNEQS9vT0Jrdy9wVGk3eTlTSGxRTW43T2pUTzgyZmd4VFJqOElKdzlV?=
 =?utf-8?B?cG9HdEl0bEM5ODN3TUFXeEl1Z1BxVWZIV1JzbFFZSm1zT3hKZkpuVklYT0ha?=
 =?utf-8?B?U3BWSVQwYUE4RVhpNERRYTZ6ai9vaWg1SkxjbnpaV1IxeTgyNzZFNWxORWRv?=
 =?utf-8?B?ZUZVV3JpYUw5bmo5NzJmR2Q0bFZQZFlwQ2lWM1c4YVdIQVZKRGU0dGV0U0RB?=
 =?utf-8?B?ZTFCeUlkQUtuaCtTUkF4eW5vK3AwL2hNcGY0akhYdU1IYlRKSVNiZXdMWmtK?=
 =?utf-8?B?eHB6NDIyVGM4S0ZpUzh5YzlLY2xSa1NrRm9xM09iYThoQWJlM1BVYUVUZUFU?=
 =?utf-8?B?VGRFSjR5ZUY3NElIakwzbmRwVXZnTlpTc3JQZkJscnBBamU3WXY1K3JSQ1pI?=
 =?utf-8?B?QTVXUHRtOGhTZUVQV0o0V0pLVmFzSFdLZzVxck9tNURScU9PQ3pOaEh5a1JE?=
 =?utf-8?B?QkJnelh0V0NueGs1SnZmNEdMKzJrVytZdHNNcWVzWVFJbFRhUVJDRlh2d1Na?=
 =?utf-8?B?bkRHZHFvem0wSTZ3TVA2dUUvalUrWjE2NkZUaWYxaXFLM0hORk9EamFEUU1I?=
 =?utf-8?B?YUdVY0VrYkJMOXFCUDNvd0tNYlA1VmRmWDFpSldMUm1oQVlheW9mUjg2OVJQ?=
 =?utf-8?B?T0JvalJEMWdBVmZSK3lMVUJrS2VadTQ1L3BFMjQwaXhuMXdNWVh3SzRWSTdt?=
 =?utf-8?B?UjRVQmNCVDZKVWxUZk9ubGZEanVjY0I2amd0Sit2UDI2OTBhYisxRXdSUVNI?=
 =?utf-8?B?K3p4cm1hQjdhYjZkYjNlODljVHIxMjZETUUvdjBVVktWWk91aTZJYTUveDdI?=
 =?utf-8?B?STFLaHJabFhFQW44YVlIM2dXTHZVeUZsNzFYYUR3SHNmcitOTkFiMTNVZGd5?=
 =?utf-8?B?NUJPU3I2RFRkWGJyb3N3aVVBZWFjRGdWVFhKK1ZycEV5WjF0UWZ4a0c5N200?=
 =?utf-8?B?L2RnUGpOWTRidnpOMndiWk9KQXNpcGNINW83YzdsTVBVTWM0U1dLS3dKZkhT?=
 =?utf-8?B?ZnllN3dYZStMVnNyZjBGRWhLcWg2YXE3NVJISXUwWG02WDlTZWZoK1I0cFFm?=
 =?utf-8?B?bWQzV1p0MUo3TGd0a1JDcHl4Q0E1TTArU3RqZHM1QU0xVkZ2UmpZWDBDZlND?=
 =?utf-8?B?ZVRuRExYcmpKb0JZSmpFY1JGZ3YrYUdwa1FnNVdBQUlYUGhsNVkzWGNyb080?=
 =?utf-8?B?R3lZSHR1R2NaK0J6dUNrb01aRGpMN2g4SWV0Sno0WWRPWFFxdS9RVVJJSkJi?=
 =?utf-8?B?b0IzdTQ1anFtK3c4bUJNV2ZHYzZkY3lSU0NXalRseVE3S1l2cUxCRm5FcDZ5?=
 =?utf-8?B?TjJTdmxVVzBwWFljK3lsTm45bjA1V1h6dnRJeklOaVcwZmwvaU9sZVlnRkJF?=
 =?utf-8?B?R2pyN2YrbmpJRHZkM01wZzRRQ01XaU93WjBZSGZYNVIxanl0ZmVsNWZJZmls?=
 =?utf-8?B?dlNCZUxHL0pZNC9MY3RCaVhVelM0Ly9OaUNBYkxNYlJJbG40UWdudmdJOEJF?=
 =?utf-8?B?dGk3VC9ncGt1L3h3RmFqY2NqRVZOYnVOQkoxUDhDZmNCQmkzekJwYys1L2NX?=
 =?utf-8?B?WlF1cm9lck56RjQ1TDlMYjBCSzh3eTVHT2g1NEVJN1ovU25lU1VKZkRXMkN1?=
 =?utf-8?B?eVhmUWFSaS9HS3graXhQSDZmUEkzS1JVcVhsY0RlQmtqajVWbUFXMTliTVkv?=
 =?utf-8?B?WkR4Y3kyNEd1VGxFSzJtR0NVbCt3Z0lROTRYZzkvVXZTMTlGUDU5Q3V6aEhJ?=
 =?utf-8?B?cnFqT3hiQ1pzclFJak4rMHFrWUpjTGErQXFyYnpVby9oQnhpMTB5SjlXRFRm?=
 =?utf-8?B?ajQzaWcvRDlDWm0wS0hqWWl1QXRiZm1nTWtjYTFRR3QvQllndjlkbGNsNVFK?=
 =?utf-8?B?T082RHFIcXQ5UlVRaVcrTEwzVEVLS0E3MkVqcTduSG13dnVMQVhyOTVLNmRV?=
 =?utf-8?B?am0yaXBNdmF2aFY1NTRSOVVuK0QxY2NSR1NXTVV2VzFwWlRMc2phQUQ5RXR5?=
 =?utf-8?B?SWVzR1NIdE56bytTNTU1RENtKzhpRXkwSk9DY2VyMVhQeW9sbUxNMFBpamtj?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A664C9A457DE4246BE8492294BB60588@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UeN33yrqZzkf38tt87COvpMT8nYBXPlsAzQVFGRJDYjGrc0jXSEQbepNX2IMvEzkmU6dOrISK973S4tUeveTCdpx9fiy6VBpd3DIFjuRfDENR7JwVNn3J4WxuMRu5qjT0wd+xN6c2KWw9u28Sdds+qwsZIllWp4Te+b5gEUiAJ5xOBB3AD0tmkhUwq7IOYmnNR4aVN79wI0RztGBJ/KBH4CrGewVQSEMxxjxz488thLk1wu8MKSl8JXfByO1YPd5uscMYuDgFf+J+0mFwkF/MqYFfF7QER+UQZGwgxF/jeSn7H1DQFmdD1EynT9OGNb9qxMW/qT1XrgOovx4pLzFAdhcBi1DP6//1jG/v5NwARrR+dIRQebTKpKjHe0UnuqhtdTG1UFi7C68II0Dq/IWfQz2bKM5LEPdFLZVBxwnIDI/wSUx+B/ViOYrQ6mJqMpBExePaGZdtSrxmjArDAZdk9cD/9eZvH9F6b7OvDBJ5ioIYpD5yNDR1+tCyomwYB8+nB1oUs5cC/f499A3VCFytHTpiXMDaiRprXRcJNe8g8mDV5JhwKhOnmoa1SbcbEVV+FwCV46trZepOm0zGsLtCpCOVqlabLuQZBCoWhFbjsk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e890d829-411b-4b58-8c57-08dd0a3c5f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 14:54:16.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6Oo4t1GPQJKj7ReEj0wbss6he31KS31uOQ8J7lpzD1jbFkQZh6zOj5Y9fgrFs2Aj54foeCAPn7l5RhlEDnr/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_11,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411210115
X-Proofpoint-ORIG-GUID: sFNXRJkjHUs87ZKYDWMOVRAgQggMfEkl
X-Proofpoint-GUID: sFNXRJkjHUs87ZKYDWMOVRAgQggMfEkl

DQoNCj4gT24gTm92IDIxLCAyMDI0LCBhdCAzOjM04oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxi
cmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBOb3YgMjAsIDIwMjQgYXQg
MTA6MDU6NDJBTSAtMDUwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+PiBPbiBXZWQsIE5vdiAyMCwg
MjAyNCBhdCAwOTo1OTo1NEFNICswMTAwLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4+PiBP
biBNb24sIE5vdiAxOCwgMjAyNCBhdCAwMzo1ODowOVBNIC0wNTAwLCBDaHVjayBMZXZlciB3cm90
ZToNCj4+Pj4gDQo+Pj4+IEkndmUgYmVlbiB0cnlpbmcgdG8gaW1hZ2luZSBhIHNvbHV0aW9uIHRo
YXQgZG9lcyBub3QgZGVwZW5kIG9uIHRoZQ0KPj4+PiByYW5nZSBvZiBhbiBpbnRlZ2VyIHZhbHVl
IGFuZCBoYXMgc29saWRseSBkZXRlcm1pbmlzdGljIGJlaGF2aW9yIGluDQo+Pj4+IHRoZSBmYWNl
IG9mIG11bHRpcGxlIGNoaWxkIGVudHJ5IGNyZWF0aW9ucyBkdXJpbmcgb25lIHRpbWVyIHRpY2su
DQo+Pj4+IA0KPj4+PiBXZSBjb3VsZCBwYXJ0aWFsbHkgcmUtdXNlIHRoZSBsZWdhY3kgY3Vyc29y
L2xpc3QgbWVjaGFuaXNtLg0KPj4+PiANCj4+Pj4gKiBXaGVuIGEgY2hpbGQgZW50cnkgaXMgY3Jl
YXRlZCwgaXQgaXMgYWRkZWQgYXQgdGhlIGVuZCBvZiB0aGUNCj4+Pj4gIHBhcmVudCdzIGRfY2hp
bGRyZW4gbGlzdC4NCj4+Pj4gKiBXaGVuIGEgY2hpbGQgZW50cnkgaXMgdW5saW5rZWQsIGl0IGlz
IHJlbW92ZWQgZnJvbSB0aGUgcGFyZW50J3MNCj4+Pj4gIGRfY2hpbGRyZW4gbGlzdC4NCj4+Pj4g
DQo+Pj4+IFRoaXMgaW5jbHVkZXMgY3JlYXRpb24gYW5kIHJlbW92YWwgb2YgZW50cmllcyBkdWUg
dG8gYSByZW5hbWUuDQo+Pj4+IA0KPj4+PiANCj4+Pj4gKiBXaGVuIGEgZGlyZWN0b3J5IGlzIG9w
ZW5lZCwgbWFyayB0aGUgY3VycmVudCBlbmQgb2YgdGhlIGRfY2hpbGRyZW4NCj4+Pj4gIGxpc3Qg
d2l0aCBhIGN1cnNvciBkZW50cnkuIE5ldyBlbnRyaWVzIHdvdWxkIHRoZW4gYmUgYWRkZWQgdG8g
dGhpcw0KPj4+PiAgZGlyZWN0b3J5IGZvbGxvd2luZyB0aGlzIGN1cnNvciBkZW50cnkgaW4gdGhl
IGRpcmVjdG9yeSdzDQo+Pj4+ICBkX2NoaWxkcmVuIGxpc3QuDQo+Pj4+ICogV2hlbiBhIGRpcmVj
dG9yeSBpcyBjbG9zZWQsIGl0cyBjdXJzb3IgZGVudHJ5IGlzIHJlbW92ZWQgZnJvbSB0aGUNCj4+
Pj4gIGRfY2hpbGRyZW4gbGlzdCBhbmQgZnJlZWQuDQo+Pj4+IA0KPj4+PiBFYWNoIGN1cnNvciBk
ZW50cnkgd291bGQgbmVlZCB0byByZWZlciB0byBhbiBvcGVuZGlyIGluc3RhbmNlDQo+Pj4+ICh1
c2luZywgc2F5LCBhIHBvaW50ZXIgdG8gdGhlICJzdHJ1Y3QgZmlsZSIgZm9yIHRoYXQgb3Blbikg
c28gdGhhdA0KPj4+PiBtdWx0aXBsZSBjdXJzb3JzIGluIHRoZSBzYW1lIGRpcmVjdG9yeSBjYW4g
cmVzaWRlIGluIGl0cyBkX2NoaWxyZW4NCj4+Pj4gbGlzdCBhbmQgd29uJ3QgaW50ZXJmZXJlIHdp
dGggZWFjaCBvdGhlci4gUmUtdXNlIHRoZSBjdXJzb3IgZGVudHJ5J3MNCj4+Pj4gZF9mc2RhdGEg
ZmllbGQgZm9yIHRoYXQuDQo+Pj4+IA0KPj4+PiANCj4+Pj4gKiBvZmZzZXRfcmVhZGRpciBnZXRz
IGl0cyBzdGFydGluZyBlbnRyeSB1c2luZyB0aGUgbXRyZWUveGFycmF5IHRvDQo+Pj4+ICBtYXAg
Y3R4LT5wb3MgdG8gYSBkZW50cnkuDQo+Pj4+ICogb2Zmc2V0X3JlYWRkaXIgY29udGludWVzIGl0
ZXJhdGluZyBieSBmb2xsb3dpbmcgdGhlIC5uZXh0IHBvaW50ZXINCj4+Pj4gIGluIHRoZSBjdXJy
ZW50IGRlbnRyeSdzIGRfY2hpbGQgZmllbGQuDQo+Pj4+ICogb2Zmc2V0X3JlYWRkaXIgcmV0dXJu
cyBFT0Qgd2hlbiBpdCBoaXRzIHRoZSBjdXJzb3IgZGVudHJ5IG1hdGNoaW5nDQo+Pj4+ICB0aGlz
IG9wZW5kaXIgaW5zdGFuY2UuDQo+Pj4+IA0KPj4+PiANCj4+Pj4gSSB0aGluayBhbGwgb2YgdGhl
c2Ugb3BlcmF0aW9ucyBjb3VsZCBiZSBPKDEpLCBidXQgaXQgbWlnaHQgcmVxdWlyZQ0KPj4+PiBz
b21lIGFkZGl0aW9uYWwgbG9ja2luZy4NCj4+PiANCj4+PiBUaGlzIHdvdWxkIGJlIGEgYmlnZ2Vy
IHJlZmFjdG9yIG9mIHRoZSB3aG9sZSBzdGFibGUgb2Zmc2V0IGxvZ2ljLiBTbw0KPj4+IGV2ZW4g
aWYgd2UgZW5kIHVwIGRvaW5nIHRoYXQgSSB0aGluayB3ZSBzaG91bGQgdXNlIHRoZSBqaWZmaWVz
IHNvbHV0aW9uDQo+Pj4gZm9yIG5vdy4NCj4+IA0KPj4gSG93IHNob3VsZCBJIG1hcmsgcGF0Y2hl
cyBzbyB0aGV5IGNhbiBiZSBwb3N0ZWQgZm9yIGRpc2N1c3Npb24gYW5kDQo+PiBuZXZlciBhcHBs
aWVkPyBUaGlzIHNlcmllcyBpcyBtYXJrZWQgUkZDLg0KPiANCj4gVGhlcmUncyBubyByZWFzb24g
dG8gbm90IGhhdmUgaXQgdGVzdGVkLg0KDQoxLzIgaXMgcmVhc29uYWJsZSB0byBhcHBseS4NCg0K
Mi8yIGlzIHdvcmstaW4tcHJvZ3Jlc3MuIFNvLCBmYWlyIGVub3VnaCwgaWYgeW91IGFyZSBhcHBs
eWluZw0KZm9yIHRlc3RpbmcgcHVycG9zZXMuDQoNCg0KPiBHZW5lcmFsbHkgSSBkb24ndCBhcHBs
eSBSRkNzDQo+IGJ1dCB0aGlzIGNvZGUgaGFzIGNhdXNlZCB2YXJpb3VzIGlzc3VlcyBvdmVyIG11
bHRpcGxlIGtlcm5lbCByZWxlYXNlcyBzbw0KPiBJIGxpa2UgdG8gdGVzdCB0aGlzIGVhcmx5Lg0K
DQpUaGUgYmlnZ2VzdCBwcm9ibGVtIGhhcyBiZWVuIHRoYXQgSSBoYXZlbid0IGZvdW5kIGFuDQph
dXRob3JpdGF0aXZlIGFuZCBjb21wcmVoZW5zaXZlIGV4cGxhbmF0aW9uIG9mIGhvdw0KcmVhZGRp
ciAvIGdldGRlbnRzIG5lZWRzIHRvIGJlaGF2ZSBhcm91bmQgcmVuYW1lcy4NCg0KVGhlIHByZXZp
b3VzIGN1cnNvci1iYXNlZCBzb2x1dGlvbiBoYXMgYWx3YXlzIGJlZW4gYSAiYmVzdA0KZWZmb3J0
IiBpbXBsZW1lbnRhdGlvbiwgYW5kIG1vc3Qgb2YgdGhlIG90aGVyIGZpbGUgc3lzdGVtcw0KaGF2
ZSBpbnRlcmVzdGluZyBnYXBzIGFuZCBoZXVyaXN0aWNzIGluIHRoaXMgYXJlYS4gSXQncw0KZGlm
ZmljdWx0IHRvIHBpZWNlIGFsbCBvZiB0aGVzZSB0b2dldGhlciB0byBnZXQgdGhlIGlkZWFsaXpl
ZA0KZGVzaWduIHJlcXVpcmVtZW50cywgYW5kIGFsc28gYSBnZXQgYSBzZW5zZSBvZiB3aGVyZQ0K
Y29tcHJvbWlzZXMgY2FuIGJlIG1hZGUuDQoNCkFueSBhZHZpY2UvZ3VpZGFuY2UgaXMgd2VsY29t
ZS4NCg0KDQo+PiBJIGFtIGFjdHVhbGx5IGhhbGYtd2F5IHRocm91Z2ggaW1wbGVtZW50aW5nIHRo
ZSBhcHByb2FjaCBkZXNjcmliZWQNCj4+IGhlcmUuIEl0IGlzIG5vdCBhcyBiaWcgYSByZS13cml0
ZSBhcyB5b3UgbWlnaHQgdGhpbmssIGFuZCBhZGRyZXNzZXMNCj4+IHNvbWUgZnVuZGFtZW50YWwg
bWlzdW5kZXJzdGFuZGluZ3MgaW4gdGhlIG9mZnNldF9pdGVyYXRlX2RpcigpIGNvZGUuDQo+IA0K
PiBPaywgZ3JlYXQgdGhlbiBsZXQncyBzZWUgaXQuDQoNCkknbSBmaW5pc2hpbmcgaXQgdXAgbm93
LiBVbmZvcnR1bmF0ZWx5IEkgaGF2ZSBzZXZlcmFsIG90aGVyDQooTkZTRCBhbmQgbm90KSBidWdz
IEknbSB3b3JraW5nIHRocm91Z2guDQoNCkkgd2lsbCBub3RlIHRoYXQgdG1wZnMgaGFuZ3MgZHVy
aW5nIGdlbmVyaWMvNDQ5IGZvciBtZSAxMDAlDQpvZiB0aGUgdGltZTsgdGhlIGZhaWx1cmUgYXBw
ZWFycyB1bnJlbGF0ZWQgdG8gcmVuYW1lcy4gRG8geW91DQprbm93IGlmIHRoZXJlIGlzIHJlZ3Vs
YXIgQ0kgYmVpbmcgZG9uZSBmb3IgdG1wZnM/IEknbSBwbGFubmluZw0KdG8gYWRkIGl0IHRvIG15
IG5pZ2h0bHkgdGVzdCByaWcgb25jZSBJJ20gZG9uZSBoZXJlLg0KDQoNCi0tDQpDaHVjayBMZXZl
cg0KDQoNCg==

