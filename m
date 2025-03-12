Return-Path: <linux-fsdevel+bounces-43809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0BEA5DF8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 15:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D58318983B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CD524E002;
	Wed, 12 Mar 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ncrPr9uG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xwyrg7iH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB471EB1A9;
	Wed, 12 Mar 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791475; cv=fail; b=jHV2S9599N+dbCCi28od8TtYiFbNP6XN0BYaCvjlvPnJaxk7PVjIVY9XyhbN/07V0HC5qfE6n6fLhEb6KZf48j7rk6UnCpnpJUEXTkeNsY4E2sDtL+0TbHDVmBkXBzxG2i+kGRXLfx8x3W+sRipogoezMIOlW05tN0vOH24ffKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791475; c=relaxed/simple;
	bh=bxdMLqmcW9hOhq6Vgx3IgX2bp8k+o49a58c2sVBoDow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V2oihOA4N5aD9fpDtUH47tptJ0JHdR6Ivfleu5g2pZZ473H7G/ptOBjf10ojBcq3ZLH2uP/cQDSkYeHbzIMRFRVVfqvewhfVmxOfdVYmugns6zOmfMvogfVGZelTsagG4JdgnYbqvaHRXx4YGLhl2/uNzI+KNWwVCKMpqNJPz98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ncrPr9uG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xwyrg7iH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CBihp4014784;
	Wed, 12 Mar 2025 14:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oBxgkGWppi6BQzopok4xNWklwgUdG1xiiWjZaNuqCIk=; b=
	ncrPr9uGR4BJ2v+ptRZVKRSYoQ+RhxJDONrl8QxYTQTEA1PqMz+9vhnx7cmcZpZ4
	4Y99YpYWbQt5wIaHkBlYgnsseGIdsJcVLgsTKWTMZZ7HUHuBooosGfgQKQJ5psL7
	kitNVbn0BKTTXu5zuzC/AnMa+hTzgQsdQgmIAsaFYRGHKEfZ+8YYmIFigWxZDWeo
	vMTNpRo1jOteVxesp+148irKJLUiqKHCVOGBzRKO8Hyy9e2+L0fNDyjL9pT5aLwH
	fPh3nmSeQvoJCl3YpZHaXYvOisOLTxVW7posfnFZmphIgwQS6muXvrhbVxDi21DS
	eTuKFcPegLBYTgGOf+gtDQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dt0nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 14:57:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CEpsuR019562;
	Wed, 12 Mar 2025 14:57:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn0mc6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 14:57:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8fVHqrzdAFFvBXW8IJjKScomVT3ZUhB2FzfqR942qtZH5s4mKMbj8Pu5loieJ+kFnbzEcLdSgcVp394FRNllCpL48z2KTVUQBNMmm2YKxOlaJbUyAM90aHNwsBB8+5pdxm39/N1He+6r2Xt4MqG6FSiL1r6menpxKNny5Wu+G5U9tC0fLyl/jgKd2C1Vdkl5EU64duIy+TW2j0TPWepAos1in4+ONRr13dNTiqquYTJt3UOpqlI/8v6r8cikItS0AzB6pKGuuCsdoQQSlfVD6fLTbO6YwbZiKMyU+OTGnzI/ZVfBiHV0mGSh2ExQiHH8XOcdsDej71IcHdSKz2l4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBxgkGWppi6BQzopok4xNWklwgUdG1xiiWjZaNuqCIk=;
 b=IUQvD6IDE2zKTy4Bj1innRxTr9Rso41l+wjzUHfg170lcifsjjT1tyj7pJ54PfZaYQEwsZNZi2uHJ0pUeCUIPx4Mxt1FKJwviyiFmDV7xXtjqQBPjgZ97PDPmJxLmqNoEhBKLolcDRPYbJNE6e2HLS2CxHFiMSs14yzqGo8S78TIvtnQuMsHZr5U6cH74IwVvafElwvmDm4Jj1oqdRO1BBHdxSMRSk9xDftsVmX21hQIEWPl9w1tr89GSyGTKZre2egYk0J5++3yBwQ0+n1H4jdPjw0M6JKeA7dd2thaqEcnjCUeCMqjXYccMMD3OlEq5lwfgsDpoBYDx0pgG9djNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBxgkGWppi6BQzopok4xNWklwgUdG1xiiWjZaNuqCIk=;
 b=Xwyrg7iHTIHoc3Y9FMV5fcYGm/0ZygaYrYNrdrEiMd+n68kllxLsZaR2i8QRQS025EBCL9HJQJkxTIMVT6tfsjOGNjOm4Eg5DXcMV+glRo+m0Jo1xqU+j9VVckNvTHjE9AxJuHf4ngRlrje1uh8RNP0TyL0JKwNvriwVyW/u72M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5072.namprd10.prod.outlook.com (2603:10b6:5:3b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:57:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:57:41 +0000
Message-ID: <9337105f-d35a-4985-ad21-bf0c36c8fd50@oracle.com>
Date: Wed, 12 Mar 2025 14:57:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] xfs: Iomap SW-based atomic write support
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-6-john.g.garry@oracle.com>
 <Z9E5nDg3_cred1bH@infradead.org>
 <ea94c5cd-ebba-404f-ba14-d59f1baa6e16@oracle.com>
 <Z9GRg-X76T-7rshv@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9GRg-X76T-7rshv@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0097.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce7b125-4202-4343-b26c-08dd61763ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zk5VbmJieUZoZEQ2OTNJN2VNakttcVBKTFBIRE1oTi9jYjRVNjZDM0poTHdm?=
 =?utf-8?B?MDN6RGlXTmFuNE5tMUd2b3lNS0JQM1kvTktnZkJxOUxnZ29FSWJGVVdTTFFJ?=
 =?utf-8?B?N0pFVHhmYWVCb1dhRytYMUs0V200bkpXbFNOU2JOR1pyZlNmamNOdlFRSmlz?=
 =?utf-8?B?SEQwWlhjc2xaUkNiWEx2aFhRZ3lzSG5VTStNUE90eFVCSzVPMGVSdEpaaGNB?=
 =?utf-8?B?VWZMa2VNTUtwWEFRVWJ2N2x2d3NnVUt0cmw4ek9TMTVTNnlReVduTmhacGo0?=
 =?utf-8?B?YTBJdndDb0tEVXZzR0haMFRpUXpWZUVEUmJ4cGVFU0E2cllJRVdFVFk1UXRN?=
 =?utf-8?B?L0crd2p4b085T01wZjc3TytGUFQyVEF3ZWdnZ0VFM094aWJmMmQrMlVKRWM2?=
 =?utf-8?B?OWZ1bHdORWJoYzl4amNFVW9qLzJxZ0F2akV6RCtEZ0tQLytPV3VRMzBrMHp1?=
 =?utf-8?B?aXd4UG5XUFdjMk54RlZzaVNJdytaQThaRHBiZXk4RG81WjdSOG00ZFpHczF2?=
 =?utf-8?B?WGtNb2o2TU5jQmUvRGd3Y3U2bVUzcFFIUjkzdEgyeitNUkIzTllFWVdMZG5Q?=
 =?utf-8?B?SmN6c3BLY1pBc0pHUlJITnNFM2l5VDhMbFI1VlJDbVY1OHlwSFlPMGdiQXlt?=
 =?utf-8?B?ZTRWODZ0dFFYQ3dLZ2Z2dUF5bFlBT0ozZitpS0NsbFB2bU0wcVNyb3pjL05m?=
 =?utf-8?B?ZUF6NHRrMDM0Sy9ibXhzMnBWakpvbVRkNXRCQzdHblpodjZTZGk1QldxMkNM?=
 =?utf-8?B?QTVKWFY5OXM0L3U1RHFieTd0WFZ5K3N3MGNIQ09PM2lBdE1xZzRBTG03eUg3?=
 =?utf-8?B?Qmt0ZFVqczQyS2JrNkd6Yk9OR0tqdXVzUDZabENwRFQva1NoNkpvNnJ3U2t3?=
 =?utf-8?B?VXBtKzVFL0FmOE02WVpldmpxdlpWcVFDTG9UOUFtOUN1bC9hY1JsSWMvNmND?=
 =?utf-8?B?bFVXT1F1eVUwcG5LenVxRXB5NnBzYmFOZnhuYUd0ZXZZR2duVkNRditjMEhQ?=
 =?utf-8?B?U2VkQlZvMnFHa0o4dGpKaWZoL0JRcm1XVmM5bTN3aUVSSkl1VmlidThQcmV3?=
 =?utf-8?B?R2NDSW1Va2ZjYkFBZ1d5ZVQ5TTFCMENFaDNqbkhrUDJIQ0RCYWtQeDNYa25P?=
 =?utf-8?B?b2xtaDh5Z256M2UxUnBnSTNpNGpxbE9TYkM5OTJSYSt5dkxpeUx5akp4dnpX?=
 =?utf-8?B?TzF2V3NsUjdzU2xEOTRhd21uTERqSXpmRmVoVm94aHZBc21NSXRvT1ZjcEhN?=
 =?utf-8?B?UExLMjZKQjFVMDNuQnlwVzJIVWZseGlKZGhtR0ZQbkdrSHZuNnF3TTdjSWtU?=
 =?utf-8?B?R3hsWTBzb1FPNlM1V1VqMXJIVXl2RFNqclkzeWhLYkZkZ3B1QUtkS2w5dHYz?=
 =?utf-8?B?YUNDcFR2dFNRYkxNQ2ZtTXk2ZEtsOWhUOEorWlBmQnhHZ3U5OWhpajAvV3Nv?=
 =?utf-8?B?TitVQ1dGZUJBclZpMEdHTUxWR0szNng3ZUJSVHhHaG02RHF0Vm0yc0Nyemw4?=
 =?utf-8?B?V291RWxhNGtFdTlMZytCV0JtMy9BVFZTVHJUaGZzNnA2SDNnOWlMQWZlYWNC?=
 =?utf-8?B?RFExaWd3VjdaekZIV3pVRGUxVCtDTytZT25sMkRwK2J2Q0R3R1UyRnhRNjd2?=
 =?utf-8?B?SGtlRklCZWVTZ3orNncxZlRJWTIzUE9WRVFiNjFaU1B4QXAvMW9KRml5Rnhp?=
 =?utf-8?B?QWtsWFA5TEtKcHdiQUN0S1hlL2pSSTQ1a0lCZEkxZkRVWitQWlo5azFySmRY?=
 =?utf-8?B?SExETHo5NExVUndRbEpjZDZTSlVvKzhPSlBDRUMzeCtOWXlIV3IrSzBKY25T?=
 =?utf-8?B?NnkweVFPd1JLNmdYZTVTSmRHd2g3T2Q2SFhzNXhVa09KVmNtWldFUzdzcmlV?=
 =?utf-8?Q?HxeJMP2M1Vqmh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEV5RHZDRzVBdHAyN0dkbFpPTENlRG1lelM2N3lRdklJaFBoYWlkQXBsOFFW?=
 =?utf-8?B?YStQZG5IVit5WkVySE1vL2w3ZE9JbGNEUzVDRSt6cFFoSkpHdGJoWjJmY2Rn?=
 =?utf-8?B?dzQzUjNzYWYySnhBcFhnaW5wSDhDaTdPS0ZsN3pPb0JjZ2w3ZHhCVGF5Zlg4?=
 =?utf-8?B?M3dvY0JFc2E1VFZ0enN3dFR3SC9DY3htKzZaMUExWktRQnBFVXFRc2VXK0Mr?=
 =?utf-8?B?UUNHMm1nTC8ydTkwREkxZERDK1RlRDMvRnVERlhvR1hQOGRBM2RyeHlIWUwr?=
 =?utf-8?B?aVZRL0ZxVjB1UzgvWWJPaDd4MlNROGN2OVlyQS9Lbzl2bFF1NUJaSzVVVzdO?=
 =?utf-8?B?ckdiS2pCcEt0OW0rYkI1UGJ0bDIvUE1mdERzREdSVmdGSk5MMWUwM0x2Lzc2?=
 =?utf-8?B?NEF4UStZZ2M4WkUvNzJHWkpsbzk0eXF6VkxMZmV1YmxYc0RNRHlTcW9NUjAz?=
 =?utf-8?B?QUJNWFFKTGRGRDNCYmZNaWcxOHBXYWs0c216TDl1K1dwMVZ0VjExTVB5Rkto?=
 =?utf-8?B?N3pjd09CczI2MjVLaWFnKzhweGFYQ2dya2FhV2JXTXhqM2twT3dkRUtWeDJT?=
 =?utf-8?B?UUN2aEM3NVhibS9RNWkzUXV2TFB5WmFTUHUwNHpPN0VjeWZ3ZU51OTVJRjcw?=
 =?utf-8?B?bC9CYUduc24xRHJSTzViTzR5c2JaQlZhSzZKdFE1ZVpmS0RKWDFkNFJyRGk0?=
 =?utf-8?B?K01nNnR5VkhzYWEwcU5tVVAvQWY4dDMvYjE3N3RvS3gvMHpGVzVuR3FvSStW?=
 =?utf-8?B?Sk51Vi81THh6Z3JRcmZweTlWYnlEUXVVT0JjUVZvMzVTMDRKQWgzVFB1TEg3?=
 =?utf-8?B?Wm11U2dVcEtFS3IrSENGSitHc0I1TzFYdWdZM0tjODdOTUdiWXhHQjJ6U3Nz?=
 =?utf-8?B?dkhRQ0Z1ZGhyWTFMczBKU2w4WDFDTWloazFjU0FCNm1mVFc4clNQWVNoZlJo?=
 =?utf-8?B?Z2VRNklkbzZjcW1TODl4QjVHYlpjS3RVRXY1L0tubG9wcUVoYVkyMlozUUN6?=
 =?utf-8?B?bFozd1A2cDdNRDN0U3c0ZCtNNld6eU9OcmFzVjl0SHZEaEpGMlEyMHBxL3ls?=
 =?utf-8?B?dnNlUXVpeUt4RFl0UWpWU3hvbUdDajRsbWdYQmJkblBYNzdiRk9Sdm9RQWlE?=
 =?utf-8?B?TS9IZDVVc00vTHk2eW1EUUx2OVdUbXN2Y3ZuVDZyWXp6UkF0WTRwSE5LNUpB?=
 =?utf-8?B?aU9mMW9paE9mM2d0THlYRS9mVzVQTUlQeEIxcnJOT0poSWgwVUtsQkZMZlZx?=
 =?utf-8?B?Z2hCZk9aaHYxMXB4NkVsU0pyM0kzNSs1a05iOHIwZUU2em5XcmRpSTFJZzlu?=
 =?utf-8?B?Q2FLZjRsTi9NSHc4T2E1WkZOa0VGMlF2WFVIV0JTMGRuUEw5eHYxcFQzUmJm?=
 =?utf-8?B?YUYyT1I5bzBYalRQa2NOYXBxZUhPZ0I0VS90Rlo2MlVxWVJCNVZvR25NUUds?=
 =?utf-8?B?NUZ1OElrMS9ia0ZHU0cxNC9YRmJBMERkVHY4c01uTlFvY2xxZ1l2bHBveFIv?=
 =?utf-8?B?dVd1bFhMWHVRb2NSYWtXNXJ6alFUeDlHa29SWEw2cjBCUzdJVDVmSkhoeUdk?=
 =?utf-8?B?a2ZRYXdKSjI3dUh1TzJDQ1A2ejlvK1UyMkR4bGVRSXF3UkkzZG1VZVZ1MEo5?=
 =?utf-8?B?OFhLeHJJQUV5OXU1TGwyZ01rb2RQOE1tMW9wbGFTakdCM3VsUTlqY1FwNUpz?=
 =?utf-8?B?VTl5QkFLZDZJek5JemFuQ29rcFhtN21CSnIwNURuMjdZNm04SHlGYjdOQUt0?=
 =?utf-8?B?Qk9DV1MvWGZMQ2tqendVR3E4enNqQ3NjOVJQVzI5Tmd3aUhNOHRpL1B5YjVv?=
 =?utf-8?B?ZlorUXhaTjBSNTNPOWNnQ3JQa2xkRmdtNW8xZytrT0w5d0Fsa1BkK0xuSVhi?=
 =?utf-8?B?QlkzVFZYUFNJSWJNZjlucUJoNzQvUXdWYTJMajUvdXZ0SmxYRnZEUU9DWDMv?=
 =?utf-8?B?OXdWek5uV0pEWm5jclo4K0pKeS8za0dZaWlRajRpSHV0MEp2Syt6b01XZjVD?=
 =?utf-8?B?TGlnOExubXlDODdFWVB2MG1xTE5EdnRhL0F0N2c4YzlEUC8wZXZmVk9GbkMy?=
 =?utf-8?B?NVE5dENjdE8wZnNReFBpMkZUdER1dHpGU3BKNDJmUTlFYVMwcDJxaEg5OE94?=
 =?utf-8?B?YjlSWk14N1RqdExCeEozaWdDQzB6RnFhME9oanprSzkvWWJxOWM1cHJ0V1Vl?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l3ktQ/Qjkz0XOGiCGhMoQy7IdIWOQljZzRT8AJa6KaYTpgrfWZN+zgbpzhpC79oA76dw7g3VtgLi95y7HJYGfukQEjC3a7bPCXE0xl399LDGTIn4RxtSp6kCnLwGdrpN/34lQ74AA12WdiA6C/ViQ+Y3OsTMTAdmJt5F4UWqBGOSqo2gkAdukGBs/vTZx+HkEo6RTiCuSieIdWNxpBlhsP9U7m9MGkR2vmgHczQUmjE2+JXy7382DOdnSrD5CL+wDJauE0H0tfsWG6Hya3AQ2L0APUH2rlA2A2lsHfYTVRfrdiIf2mfGr1pnpEtuTr0qnJfdjDiMUVtdbdHopZNUWATkL3J9XqgPfwMQIBLzgId7+ccBMWw95N1VXXnM6EqxHGw4T+X0y3FfETtJQPl8yu+Tb0qyln7TTd+rBcYNIkIvCT+FdWYlF832axJ+b73x65RMcdBbDXlONRDHOJLiSC84E9F7j+qZIl8OxX013RGjN57YkyCJViNrH+1ae49K1kBskVatl5PENmT9x3G+R5EFXY0gGD/rqJ6vUEjmwOuJmDIqr39NK3vGn5E/UeCNOq0BCjkX0/BSuoufYeFrUXXYIhp3EYI+dP96KDPxzps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce7b125-4202-4343-b26c-08dd61763ccf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:57:41.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efuiMNln09qsHGyq7s4LXJCElfArKbdKivK6Db0rcUvfrdcavJj/joj39HjuARe4UknelIxAtmnxoeNrkufU3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120102
X-Proofpoint-ORIG-GUID: OBAEtIHT0VMHB0Bwj7H4GnQalyXDE6n4
X-Proofpoint-GUID: OBAEtIHT0VMHB0Bwj7H4GnQalyXDE6n4

On 12/03/2025 13:52, Christoph Hellwig wrote:
> On Wed, Mar 12, 2025 at 09:00:52AM +0000, John Garry wrote:
>>> How is -EAGAIN going to work here given that it is also used to defer
>>> non-blocking requests to the caller blocking context?
>>
>> You are talking about IOMAP_NOWAIT handling, right?
> 
> Yes.
> 
>> If so, we handle that in
>> xfs_file_dio_write_atomic(), similar to xfs_file_dio_write_unaligned(), i.e.
>> if IOMAP_NOWAIT is set and we get -EAGAIN, then we will return -EAGAIN
>> directly to the caller.
> 
> Can you document this including the interaction between the different
> cases of -EAGAIN somewhere?

Sure

We do the same for dio write unaligned - but that already has a big 
comment explaining the retry mechanism.

> 
>>> What is the probem with only setting the flag that causes REQ_ATOMIC
>>> to be set from the file system instead of forcing it when calling
>>> iomap_dio_rw?
>>
>> We have this in __iomap_dio_rw():
>>
>> 	if (dio_flags & IOMAP_DIO_ATOMIC_SW)
>> 		iomi.flags |= IOMAP_ATOMIC_SW;
>> 	else if (iocb->ki_flags & IOCB_ATOMIC)
>>   		iomi.flags |= IOMAP_ATOMIC_HW;
>>
>> I do admit that the checks are a bit uneven, i.e. check vs
>> IOMAP_DIO_ATOMIC_SW and IOCB_ATOMIC
>>
>> If we want a flag to set REQ_ATOMIC from the FS then we need
>> IOMAP_DIO_BIO_ATOMIC, and that would set IOMAP_BIO_ATOMIC. Is that better?
> 
> My expectation from a very cursory view is that iomap would be that
> there is a IOMAP_F_REQ_ATOMIC that is set in ->iomap_begin and which
> would make the core iomap code set REQ_ATOMIC on the bio for that
> iteration.

but we still need to tell ->iomap_begin about IOCB_ATOMIC, hence 
IOMAP_DIO_BIO_ATOMIC which sets IOMAP_BIO_ATOMIC.

We can't allow __iomap_dio_rw() check IOCB_ATOMIC only (and set 
IOMAP_BIO_ATOMIC), as this is the common path for COW and regular atomic 
write

> 
>>> Also how you ensure this -EAGAIN only happens on the first extent
>>> mapped and you doesn't cause double writes?
>>
>> When we find that a mapping does not suit REQ_ATOMIC-based atomic write,
>> then we immediately bail and retry with FS-based atomic write. And that
>> check should cover all requirements for a REQ_ATOMIC-based atomic write:
>> - aligned
>> - contiguous blocks, i.e. the mapping covers the full write
>>
>> And we also have the check in iomap_dio_bit_iter() to ensure that the
>> mapping covers the full write (for REQ_ATOMIC-based atomic write).
> 
> Ah, I guess that's the
> 
> 	if (bio_atomic && length != iter->len)
> 		return -EINVAL;
> 
> So yes, please adda comment there that this is about a single iteration
> covering the entire write.

ok, fine.

Thanks,
John

> 


