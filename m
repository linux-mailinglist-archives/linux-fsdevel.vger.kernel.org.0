Return-Path: <linux-fsdevel+bounces-51512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FCBAD7850
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0993AF854
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D417AE1D;
	Thu, 12 Jun 2025 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WhV16BbU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="By9XQLkY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC679D2;
	Thu, 12 Jun 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745991; cv=fail; b=GScBp0wZ8yVZLs86F71r3tPWtYSjTjnkS26boR+ryFU5lwwirw7QFMT1mYwI8tOMyD7jIsENprJ8G2TfglP+ViLVZcRrrcyiyAd6mN2Nre11P+huuNxWNo5+9j1lfVHFonCXPuxiX5B4EsT1nVQKzHPF2N07SCV0vZUBYw4YY8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745991; c=relaxed/simple;
	bh=7L4WM4lUSYItjCHHPzxMMFfcXGeg78kBiBv8nCG0OxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nwwRWs/HVrr+aMqT78OnaM2S42Ks/drMwVY6OCU9nTq2IJDYKwR242HJ3iytTJnj/L5w7Jpyg6yMqIbkXC2jfA5SYOLz876KUUmMN5MNa9vK8HjBlWYjuz7aOWUsgq/GgBHuWuAjA8ULVWrMlyjXyQy7JQKAUNVBFf8uzD8b/P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WhV16BbU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=By9XQLkY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CEtaA8029170;
	Thu, 12 Jun 2025 16:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ils9IALW4HDb2nXoefXIIlVU7MrSYxOi/f5OLc+PSi0=; b=
	WhV16BbUqRXssdFNyE/XpshnHf4/9UlHHT5l7OhVgXiTW3hkjBUVpEhAjl4cusbM
	4umBx3z0ktug0+X6QOBBnbBuoeF1QLEpGr8f3a9wowP+4GkpgnNVFxN0CLgv6PH4
	KSyplFivxmJp/2UFXsliRTv/ZN/KtOMNVk6sYJRcHUU42YTehlpSmAy07iMDXR3H
	qUVibkD9YaBlpx2D9DQ0aMeWJp9+nkOesbsdc6pns9Ojg0CZI1XYJsNkd4DiAe/t
	HOA9tZj641EFBdKUcAsmQuqJ5u6L+t6Q0nTu66uxTqlEBV+OnfeRYDVZ18GwDdIs
	gbmgYXeHroeuPfV2ghyv7w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xk1j1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 16:33:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CFFv6n040802;
	Thu, 12 Jun 2025 16:33:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvctr2r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 16:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaTDRCBDcm/dRm+8LRt6mMlz4zO5dSII/UAAFlo3D9x0QMI5nKdcohbBBQMBDiITUt9RtvPcqeRShZZ52eaihbnoq0s7weK9S/flNawCoqy4G9ghKcCs3v2VfcNYr0Vl30yrTiMIPQe+Vwu7zPVSkTZhcKjZwmzon0+bLvjo7qiQptWpB4NTZdCEOhcZLractzdVG7xssMs8W2POYKDSBkg3eChYN4uNUrF/Z+YyCQofWeKm52mdL+TEs9azN8kgArS50XTAxkJyh2/FhQDQK6EJJdHDiWovVN11mXr9n1hlI1RIDYUBxrDqBG6KO7UglSHzo5PfeeRCSIC4o0J/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ils9IALW4HDb2nXoefXIIlVU7MrSYxOi/f5OLc+PSi0=;
 b=yHfw7uP4o/lplLKKxj365+WdexPsYhBrXxOl2VWTcH+2VhNejtFEIKMaaP4zPAmv8XWqk9SRxr7rcG87hGaZLzegDFvlxljgMp1L5iQJ03VWr3HV0CjbWxjFGlWF4Qif5xEOhNB/J5tsZZJ4n9nW2jLe4lHNDRJgmL3IKCv6vSTRr2hvZZgRDDW1ehx2yEx+1pk6cq+cZLleAuzbCJrc10RMIbolm24nc3yyBPAv6E6bhEB+12Hia2KJdK8nJwE098D7NkksJckYjg/W5JshEQeER3FLlsCgG5ixUp8lP0GfDUEPdT0f9+ILoQTWr+NG91g+Tihbw96p6B3cFO9/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ils9IALW4HDb2nXoefXIIlVU7MrSYxOi/f5OLc+PSi0=;
 b=By9XQLkYQw0+NDCwIch60708+hOHuJ9P6hN+LXARo6tm1bPWPETx2momLn0UFccztJd6UFZbnJf9oC6W4o6mea7DA8qn7s5PcZsi3NgN+5yIwfi8cKKvqBbdvyW3u8bzFyu6xMBuoC0uWzFO+SnEUAxwb63DgRgaasado8PY6YM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Thu, 12 Jun
 2025 16:33:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 16:32:59 +0000
Message-ID: <89d733bc-4381-4aa1-b685-b8b6d569487d@oracle.com>
Date: Thu, 12 Jun 2025 12:32:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
To: Mike Snitzer <snitzer@kernel.org>
Cc: Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <5D9EA89B-A65F-40A1-B78F-547A42734FC2@redhat.com>
 <aEr4rAbQiT1yGMsI@kernel.org>
 <04acd698-a065-4e87-b321-65881c2f036d@oracle.com>
 <aEr8WrzJsU6XTyki@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEr8WrzJsU6XTyki@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:610:74::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a78da3-5d9f-4b17-1da6-08dda9cecb61
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M200SDNJSVFtMG4yZzIrbWFaalgzZDFGM0ZBMTc3bFh0QnNRajFQVFVZb2d6?=
 =?utf-8?B?WGVrNm14Y3hjQmJkQ0srODg0Z1dscXJtbUpXaWwwNEZzNWw3SkNibU8xdGhP?=
 =?utf-8?B?dFA1Tk1ZNTEwWlk1aVRoQjBCblhOeUljNFBiS0FORTEyMmY4U3hOUXhoTzlK?=
 =?utf-8?B?aHhZZ1k4ZHpoRjdUeXFBenYybWdMNXgrcmpWdGRVM2c2MWNXMmZkVTJWSk9j?=
 =?utf-8?B?Z1VEeEJtZkI2RHFjS1d1ZnpRQzQ0SmRtbjJRQUdXYXQrdEU2TEwya2ZFemdi?=
 =?utf-8?B?cnk2cU02LzdhamhmU1lrRXBtUm5LLzJkNDdWVERqUFJzdUlCai9CVi9DUVE4?=
 =?utf-8?B?OVNjNWovanhpQzlrOE9ReVdwRThBOU5HM2JjRStKR1hlamFOU1Eyb1BjV3Vz?=
 =?utf-8?B?NEI5L29DemNpNXJzKy9wY2FXZFNKbHBPOXRodmxOeVdVVlFtTzA5MTFmb2hW?=
 =?utf-8?B?aHFCR256cVVJRlBiSXRxam5rNlczM3FCL2t5UWpRRGFYMC9QNUw4WGlQSU5Y?=
 =?utf-8?B?U3hsamIrYkJldlQ2WjlKMk9ySm1JZm1NazdOa2ZIK3k3V1BNdmJkKzVKdDd0?=
 =?utf-8?B?WEZnQ0Y1Z2hWaFJWenl3ZCsyUmVMV2kxc0xyR05UOXEraTNlemRpblRBTSs2?=
 =?utf-8?B?VFdxN3YxM0JLelYyOEN6Sm9VOE96VlN1SVJlQTRFcVlQRFFJem4rV0pqSzhp?=
 =?utf-8?B?Ukxvc1ByUk5lUkZ5OWk2a1pxNW1aTlVKOGFYdjgyeVVFU3Y3blA3WGdVUTA3?=
 =?utf-8?B?ZThQUi92R004QjVzQ2ZaamlIdzdDY2U4Zm9zaHhlQ25KSDcybU5lVi9xRkFD?=
 =?utf-8?B?RE5sVktJL09FZkVKS2diK0pVcEh3K3RoZHNlNldqS1dzNjd1cWYyTzlXNURy?=
 =?utf-8?B?OWJTK3p5dmNSK01rOFZ2NUh1VG1tdG5zZXhkclc0RDNqYTE3aERWZWVjWnBH?=
 =?utf-8?B?VXVPb3JnN3E1VTZNS1VGZVdmMm9pZm5nWDZ3TGk2dTVjOHh5SU5YVkRuaTZz?=
 =?utf-8?B?emwrL3JCL1ovNUd2b1J3T0NjQWFiNzNpa1NCTThWQmxPTVE2OUlmZmVnVENQ?=
 =?utf-8?B?Vkp1Q01tc1lYSVdodSs5RzJrNTRSWHMzcjFWdHU3S1Fxc3Nxa1UrakJaU3do?=
 =?utf-8?B?bCtzaVRySk9XZ1VzWkUxM0lTdzlFSlhJNzBBU1U1dVFWQjNZVThJOHhJMGUy?=
 =?utf-8?B?S0s4dXRmS3ZOU2xiSjFPK2Nrakx6Wm1QeTBCNWpyU2xRVS9rb2dPRmdxVWhE?=
 =?utf-8?B?UlNHa3M5b3F5UlEwQTIvclVhNUtYdjZMM2lxN3BtRzBQaVZ6K0RqcDBGSUR3?=
 =?utf-8?B?UTh0cnRlOWkwZndWWUlZcWt0ZC9sNTlzNjcySkdZVnNHMTZ3bkxDdCtURFJo?=
 =?utf-8?B?aVJJZ0w4SmJHSmhHRnJMYXE2anVuQWt1N3gvcVplbkYyRXdhN21XMjNIQk90?=
 =?utf-8?B?WjhTMEs5Y1JuS2JLaE1PTWhMcExmZXNzeW5lemZFWEJ4R0Q3bitzUWFSQ21F?=
 =?utf-8?B?VkpoUGNRQkRJOWpMb1dSNER4bEpqRlRyQXBua3NWcEMyL0ppSmZvdHBieERy?=
 =?utf-8?B?MDJHeUxZakNRZFVoVUtFa3BnWW9XMU9FTG9QdkJReEs1bmZBNDJqMEVKck9M?=
 =?utf-8?B?SzczN3ppTWx3dnppbHQyQXB2ZzI2YzIwc295Sk5LYnp4ZzQ2WlR0VFNFTG0r?=
 =?utf-8?B?ZUlVNVF5ekh5Q0tjNXpRSzZnSm10d2NxbnlzNVJ3T3dRYnNNL0tuaXpBZk1W?=
 =?utf-8?B?dGVIMERqbGVuTDJQQU5TR3RIYWRSbFY0bzQrZW1pb2dYbWlldjlXS05KODBa?=
 =?utf-8?B?YzM0OWJiZXZ2bUhUaXZiTWhWbkFnV3JTOUE5UFVyNDhiYXZ6L3pXcHNZU1Nz?=
 =?utf-8?B?QXdNU1pmRjRTQ2o5eWQrMGNPS08waGNvWVI4aHRNTTE3YzlRZGR3aUNBMlQ5?=
 =?utf-8?Q?Ls3Qr59KhQc=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NExpVnZWVXVKbTNXU29pa1lHUDZCT05SL2FheTJBZWVWdUpBbHZqWXNJRUc5?=
 =?utf-8?B?Y1lseGZBY0lCbFpqZHMrNVg3MFpLdW8rK1VyOWQ3Tzh2UXhJZGVqaFpOK2p4?=
 =?utf-8?B?MU53SURHdytlM2JUQSs5SDNVRktDV3V4MmwwNmtRRVNlOTJLSkY4bmhVazl2?=
 =?utf-8?B?OUNnUDExeElGcHhiY0txdDV3MWkrbTdsZHpyT0FVc216clU5bmJORHpwTUk3?=
 =?utf-8?B?OHBTUS9NMUlqeUQwR05VcGV6WHBuZUxXUVN6N3pxaFgxT1M1MDgzVk8rbngz?=
 =?utf-8?B?bTBQekV6OTRsdnNhclRsR2JKUXV6THVqQ1FrSUhJSzBSR0F4Sk93c3hhc3Er?=
 =?utf-8?B?QkFBZzcwNTVPV1FEVitnZUdxU1FOaFBQT3h6S0MrWC9sWUlFNnIwWDZmcnhU?=
 =?utf-8?B?RE8va3V4K09UdndpYkFEOHpJdkF2VVh2TXhSZjJvdlRXbisvUTI1QTJSV0pS?=
 =?utf-8?B?Rm1TY2RvQVBpVHoxdHRjdGwyOU1lY3JTd2lldXhGcEx2Sm82Ukk2SkNuVkVm?=
 =?utf-8?B?elJkVTY0UWtrck0rRDAxbVM0Z0NYRStXbGhjNVErWHdvZ0NsMkVSaHVTbXla?=
 =?utf-8?B?dmlFU05nN2NBOEI4amhMeGpaQmZscXhtQzk1OWFjaSsxWkMxcHBkTUZHNW1U?=
 =?utf-8?B?MUQ3VTFvbGlNZ3F4WHVWVEx4RFBzUWxaeFAzYW8xNjVtVjA0a3BQdjA5Y0dI?=
 =?utf-8?B?ejd6QzI4eVB6WnA4QkxoemNDVFpjcCtvcm5PMHQ3T1BWclFkUHptUng2QUtT?=
 =?utf-8?B?WlA1Um4zeVJ2bU5lQXlDdWJCSFAraStGaVZ5TXRhWmZzaE45bEtSNGlMWTVB?=
 =?utf-8?B?ZTVTVTYxSS9yZENrdjNybDlZcGtERTBQRndnVkxRS3prbW5BTHlENVlJbkdE?=
 =?utf-8?B?Y0swSmpzQ2dQdW95OVFPRlhYbjhMK0Zab0IwMXlHOERZcDBYMHhlUDFyVFdp?=
 =?utf-8?B?eHhhQmM2YkN2eXRKNjhGOXlObnYwUUtZZ1ovR3ZKaHY4dUptUWVWM3RMZXg2?=
 =?utf-8?B?eXVWSE1mQW9aUThjUFBhUURsNFQra21lc0NKcWdOMUk1bHVlMlFHcytRZjd4?=
 =?utf-8?B?bzllM0lxMHE0Z3RNRDQwRDRDODl3aHhmQk8rZXQwYS9xajUySVhUWEgxK3VF?=
 =?utf-8?B?UmZweWZYS0MxbDBONkw1Z1VsL0o5enNJVzk0WXBSUWhnejM4U040d2JCdHgw?=
 =?utf-8?B?amZKL1JtdFBnZk44MjhKMGVSWTIvckVubjNIeGluSW02c284cERBdjczQWd4?=
 =?utf-8?B?TDdlNEVralNJZDRUSDZZN0VFL3JKYXQ5NzFlbXVtYjBVeUQxcytkUGo4Tlp2?=
 =?utf-8?B?bjhvWFZCT3lGUThmSkgxNEdBcDFsTUZxaWh3c2RpOHFEWWJNWlFJNEh5RzNx?=
 =?utf-8?B?am1VenluTkJXNFJrektEN0R4bWFxY1V3bUxUVzdQSTl5YTFXRHRMYjdKalBh?=
 =?utf-8?B?LytXV2JXSUMwNnU5R1FTM3hGRzZQTzBCSXNiYlU3VjlZQTBGY1oydldkVXB3?=
 =?utf-8?B?RVlPZmpEMFczV1R3bjY3VWltQXAvM0R0SXBQeXVlVEx1a0dBZC93Tng3QXAz?=
 =?utf-8?B?bDdTVkVlMHhmMUhMcWlYdlhUZDBWSzNrWHl1ZlZiWmsyZWNENkEyOEZyeHVv?=
 =?utf-8?B?SUdRelVkcUpqVmhvVzB3VForbzBuMHJRajlyR2JwVFNnNnBoUkExOVZIOVp2?=
 =?utf-8?B?RExpNk9zeWgwd0tKUmpGWkd6WmNRcUp0b0FwejhKbE9vVi9UNEZIUE8yTUFr?=
 =?utf-8?B?WE1Od25WMUNzN0J4YnBqakJPQ3lQMWtpMFNzeXEzbklESEVkNTZpYUtja1dq?=
 =?utf-8?B?QklaZEFweFM3YTVYQXdJaDBkNHFqcmRNdzl6dk1xVEluWVlWdjhKMWxoK1hL?=
 =?utf-8?B?c3JTdmhHck5pakJGZTJTczNnNU0zZG44bFg2ZE1uYjRPL0lXZmwzZ3hRNE5E?=
 =?utf-8?B?c2JUNlZJMkQvZXNSMEpVNGczUkF0Y3YvUDA0V1NacUtSbCtVaE1FRngraFNZ?=
 =?utf-8?B?aGU1YU9XUnhWQ0g4VGxheWZvaUhaTHd3eWd2b3JOMkZKOXhDbHl5L2VCemV1?=
 =?utf-8?B?Tkx5U2xkc2V6MzQ0TnFpNTFOcG1qeHdRODhxZ2FScVhsY3plTEsrN2Fnbkxu?=
 =?utf-8?B?bnVjUjRhdk1GcVd4RUkxa2ZuLzBVWE4wTmpUUmpqYStoQ3doRXNHMmVjOEJx?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	59G8dfXLvbdEx9IZ5WLAl9lbbPQGaDGNYE0pzpO60KcG3EX+Jw9N0JBKQJalO2NabFXOmOX0Q3hrbpM+ZbCDVSC30b8YbfQ0WGDuVrYvJC/Tv1zywrbtSCqWfwE5xYLRndfdLjsbF7dx2N/0Msf8PteURAKSbjnJBr2+az6udizZm3xd9N7McDxYT3Zefw4v4nwUtP9b/K0bdwBjfuetlBWzMoa9pv8IhZBwCsvY2ppXKsCN3FHCY0PgXV94s7mdlFkml0sOZj5RDmVhlDRqEtFi1uRYUnwjwLEoBce/j533zPuRLUDr5TmbdwdJYUeaao5+b/VWkT11zyKSihrI2WTUv0937VKA4/TBGVe4Yd+BJVNf7IPQRqonJhY2YyiFWrZria9KIyeNuDnGqM7meWB77s2Fa/ZMGoR212rPwX8YvdxjOLNmHcIIWjiRcxzLc9b5uoIvtPvdWqPeHx2ePGXrzT7U7NlK6aQhYSC3V+eupt+wC4fta/Frl/b/TEPXe0Zz38mvttpICHRwDOuzhrMnsuFiJ74W+Dutpy0ToMFW9wPZDDCNv2woHUQBT8P6u8ognXaa7X3q0PhwHXgRSjjPEAISaY5/WPQQ5zCqIb8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a78da3-5d9f-4b17-1da6-08dda9cecb61
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:32:59.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Dy3u+0btyTH40QJnFwbCdbcno6QAbFTQoA+XluqFKzX3Muw7kTb9C4Je5I43moO29TZ6lAI6J27dbAGC+ubMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=795 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120126
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684b0140 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=HqPsqNtGgo7iutim:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=wWrx7hvCW8axltSXXyIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEyNiBTYWx0ZWRfX8qhdnsZqcpq3 3KJrMT+h4Xcbm8JMDhbdbrZG5XLJbFV3lIZBjc7TWlYGM5WlWXmf2TCxr+dSpyXHchM0OV94Cd4 DfCqpQQxa8UFJWQDaejllYJ60pS45QzoitV8/E228YenQ8iyw3rKWpNbpdIK3f0l0CcLbryo13M
 njbIhxuGXxvQWD5An/yy/TwQf13bEgOXQvRmsLxO9WbVv4xaik561lxEvj/+nrq/L01qUL3W8tC l2iMgZhO/QsauWgHc54yqCS5hWD63TsdfT8opvjHQy7IaZN6ElCrBH//9W8Jtej47+4yp+JSfUm TPWKWbwD5gTotjezE/yjBLw6U3fa4gE/pkIZzWfaNGtDEQlHsD3Mt2KcHoBRueGqb4MjR0mIst2
 BI9rSwUGhi38+ie+zkbw2hpwDOQcRZBsJUgU1LdqsX3XJlSc/DIJPS1Ph5upAxiEzVAB9J3d
X-Proofpoint-ORIG-GUID: qRJr1jUJslCgzqUcFWwqAK8QPgyHtMJi
X-Proofpoint-GUID: qRJr1jUJslCgzqUcFWwqAK8QPgyHtMJi

On 6/12/25 12:12 PM, Mike Snitzer wrote:

> the value of
> not requiring any RDMA hardware or client changes is too compelling to
> ignore.

I think you are vastly inflating that value.

The numbers you have presented are for big systems that are already on
a fast RDMA-capable network.

You haven't demonstrated much of an issue for low-intensity workloads
like small home directory servers. For those, unaligned WRITEs are
totally adequate and would see no real improvement if the server could
handle unaligned payloads slightly more efficiently.

I also haven't seen specific data that showed it is only the buffer
alignment issue that is slowing down NFS WRITE. IME it is actually the
per-inode i_rwsem that is the major bottleneck.


> RDMA either requires specialized hardware or software (soft-iwarp or
> soft-roce).

> Imposing those as requirements isn't going to be viable for a large
> portion of existing deployments.

I don't see clear evidence that most deployments have a buffer alignment
problem. It's easy to pick on and explain, but that doesn't mean it is
pervasive.

Some deployments have intensive performance and scalability
requirements. Those are the ones where RDMA is appropriate and feasible.

Thus IMO you're trying to solve a problem that a) is already solved and
b) does not exist for most NFS users on TCP fabrics.

There is so much low-hanging fruit here. I really don't believe it is
valuable to pursue protocol changes that will take geological amounts
of time and energy to accomplish, especially because we have a solution
now that is effective where it needs to be.


-- 
Chuck Lever

