Return-Path: <linux-fsdevel+bounces-41658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D9A341B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95715163485
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D57281365;
	Thu, 13 Feb 2025 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="efZV8+cD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g+TCYfFf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0AC281346;
	Thu, 13 Feb 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456288; cv=fail; b=lVDs72pdkFwOaKC2bKMmY3rMk5STdKZjNr2wq1TBWIRSqqkXrrHDrEHDA/ZoJDGkJz+fQ3rpib/BlUOHC2xernFHlFXUrBjvdw9Gc6zorUOXJbVVNn//wK5tOGiABe0m+GQkPi1M7TzfzFa98kat8OAcxr98ee2FcLnhf2CvlXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456288; c=relaxed/simple;
	bh=0jyDK/LZmR2vwbnOTesx58qjJfsFOExDrPZQeJU5eFA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vBPMG9A1IsFAIFvvRYKqJS6C6YU9tpTzeMXc/M3O9KLq6SKKy6hkmrEN7azTCZ0TMKYEsicNj4VFMjkIJUtU3BFHMsYLiBySS/S7v8ljeRt5odgBf8eh/xCkNEX4WCwhNW4z0xV37gE9XkQXwKcrH6PDFg9TfR95fC6oiFodhcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=efZV8+cD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g+TCYfFf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8feKt015121;
	Thu, 13 Feb 2025 14:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1oVo42ybCJRWQG+uiwRvHHgsO1Fnqp3omfEEeBxNYFM=; b=
	efZV8+cDSg9Ok3yeUhyiE+jy5bhJRfJ8ISuHdg3OSkT0Fm5nh8GKL2HtO2gLN+sb
	OiwLx/kNxv4qwS0zFgAC3vcROHdGW6SfYeHOyfmbqHbbVVM4zc7pB0m3YVZMpjAI
	KSZ7ymOyCWVRvZSRM88rxf9o2dYLllMVcwhuCXuFxLnyuOp65et7DH5ReIrFL3Fy
	SNNFGK3EvS7ejookthQlxgYCB9zyKvukhm/usjcih79hu4MBxh7E48Cps0X5odqf
	vyzg8HjAFT3E7vNQqWFIZEFOP0So5V/Zb59lEkw8i1S322zz5/Xf8eTwnk6CVGeK
	no+NbuQJPV7naeqUrqH2pg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2hpxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 14:18:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DEFrxV023553;
	Thu, 13 Feb 2025 14:18:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbr8pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 14:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTy+X41/289GRRMkLF727T0WYEs21xpN+ysdcHLYNV77ClTQOu2RmYk/SQZRSLqFL75cZvZ+OY1WArA+8epNSNh08O8A2gm7fq7KLW/pudVLyhuCAPE4NzvhZtINxSP77tA8pepT4Lg06yl/m4nU0Fh9rD3vkBvWPX4xbY3g6w0fsFm5DMpT3xyIOpoLerdRa1EXUJXjjWQkejiMdc4i8lSV02bR2xdF2Ir1VcIpbBnMXNFU+x8orlnK4saNF2i56pYvO6YFELau/ebPPUu8aivneY3MlwCrwb4SJikrxXNlwT4c2SbeiZUOwRz0QinGTreGHbDXxyou9Nyv7ELmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oVo42ybCJRWQG+uiwRvHHgsO1Fnqp3omfEEeBxNYFM=;
 b=Vg935eC3y4eQwBaYb6o+2rwAPeC9P3GxRpICLaxuZA7JbdMmr1G+5GVHSA9gFZOBoBeqNz5LIcMXujznrmXYlWyYaE96ZaJNHGbVC3oHfUij+ONGNT21BXMVvi10epLNincZLDQ+e3lL+FOgzixRvfQHg1WqOvxpQtc+q7UN7ZA41Sa0vgeMjT7oUT4IIFOaGWaKU5wZhvPl1a+AZk80boFdrkXgbF+0U/eymE+JEN5kTpvEMBgBLsmQMcXtBIeFZ29FKrfyZoirIB4W/nS/xXsxn849uDSYNtxLCOCrlHFmvuZJPp0mvJNLze/56aLhND8GyQEEGjg2AiHMwegS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oVo42ybCJRWQG+uiwRvHHgsO1Fnqp3omfEEeBxNYFM=;
 b=g+TCYfFf2bQqmPnovmBuHR1tFocOO5g6AVJujosPIs+/klxj48dD26F1a0enFMBC4Y5QxWApshI9zv03No+nnh9XgFyeZdBUACq/RpYsjRYKVNPpIRAui2Xmhd5n8uNRdcmWTkE/VFoCU5hS0NvBrP/sbv3N4PbBvmgsYZCC3No=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6870.namprd10.prod.outlook.com (2603:10b6:8:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 14:17:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 14:17:59 +0000
Message-ID: <9f3ad2da-3a85-4b1e-94b5-968a34ee7a7a@oracle.com>
Date: Thu, 13 Feb 2025 09:17:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: 6.14/regression/bisected - commit b9b588f22a0c somehow broke HW
 acceleration in the Google Chrome
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, brauner@kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-fsdevel@vger.kernel.org
References: <CABXGCsMnkng1vqZ_8ODeFrynL1sskce1SWGskHtrHLmGo5qfDA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CABXGCsMnkng1vqZ_8ODeFrynL1sskce1SWGskHtrHLmGo5qfDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:610:52::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: cf453943-f7ab-4c53-70c1-08dd4c3937e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGp6VWV5TzlnTGhRWnJUZHY0Q01aRmRYejNsK0llRDV1WTdnQVdKb2l1RWxz?=
 =?utf-8?B?K3NHeTJSZ1QrUWQ2Z0tVRWtwUVZCS1VuU0RsMmxCWEdFNHAwbkNYS0ZuUHFZ?=
 =?utf-8?B?ME5JbVkvQ1FHVDU1MkMvUjc3YjlobEd5Q0RZZFhLMXZPMnI0Y0U0OGRBMlFm?=
 =?utf-8?B?d0RKZGRiYWVGTW9lTTMzV1ZVWHpJS1RWMzZGb0JpcDZacHFkaFJSbGVjVWMx?=
 =?utf-8?B?cGdWenZDOWNjbjAzODVlbTAxRWdDUEtYVWZNT0dDR1RPZUNoVUMyTko5dnBh?=
 =?utf-8?B?cHQ2OXpmOXg3em56VTVvSUc4eUVybXo4TDc5NmRxU0JSekNSRlVPaVNmZWR2?=
 =?utf-8?B?ckdFMWN2VWMyd0g3by9XWVdpSml5N3BvNHI0a3RpR1dMZ3cxb0ZrekthbGwz?=
 =?utf-8?B?M0ZNZzRGbzFhQUpqd3d3bE80YXlOVHBiQUVDSitFMXlyM2thdGl3OGEwSmll?=
 =?utf-8?B?a0p4cFBTbW5PQ0E0K2pBYnQyZVVEUi8rcGhHRnMwL2RmeFZqRFJmZTBOVmhV?=
 =?utf-8?B?K2dWQnJKeisza01QNGU1dXB3QjQ0cHdvNU0yWWtSUUwvcExrd2lpeTlqeVVY?=
 =?utf-8?B?R0V6S1ZtYXpyRDJ6TGFWamk4MDkraW82LzZadmtOa1dqR0FSK0dJNUZUOE1l?=
 =?utf-8?B?VDA3RnNoMEJwdnUzQi9ldW9NRXZnOTBtYXRWOXhhV0RNZm95Z3ljdkJQQVA1?=
 =?utf-8?B?RDdlUS9qVTVVUXF6OUNoWE9yQnM5TVJ3UjFQWTU0RFdieVpRUGFqZHhXTG9Y?=
 =?utf-8?B?aURCTE50bDNXNHZFY1ErUGtZcjJDUEV1amJTeEtlVE5YWmlvVXZibkFVdnAr?=
 =?utf-8?B?bWdnSE5DaU5pUWVXMjFobHZwQU9RM2xhMHcxMjBXUTA3OU1JQzRnMHZzc0E1?=
 =?utf-8?B?Wk56YnM0Mkk0WDVwWVhOV3ZOOFhVejZuYnQ5K1ZIc2xEbG04ZmxpQlJHRmFt?=
 =?utf-8?B?eDlRbmtrSTQ2WEFGWmppaXhBRW45dDFnRFlMaFp4dkpCSG1jMDZxSm91YXhx?=
 =?utf-8?B?K09JekR6Sk85Y0c1Ym1jSjBwK0tnNnFiRWtQcWZvUGhrTXQ3NGhNQ0NWK0Nz?=
 =?utf-8?B?RFVLRUZoY1pReXRLeWQrWG51MDhxVFJYZVFjSTFZeHI1Q3A3NE5zeTUwTHQr?=
 =?utf-8?B?MUw0TVVuajhXc1lhVkQrcVl2eFUvYXFIS0ZyaUgwQ3BzSGRvc3dPVkdBMXhO?=
 =?utf-8?B?WWFBRkVONWwwSVcwSWVkRXpyZmtyWUtYbHB3dmFHWUpsUCtQTUVkUHpvZ1Fz?=
 =?utf-8?B?UkJsZVpzWTNyU3Z2clNzbVNwN3h2UGwvblYwSVNkbzIyMVg1aHN3YjJTWE9O?=
 =?utf-8?B?b2lUdU1JbEJjUnNndEhnZ0hKSG5xUzE5TkVsM0FTaTFNcHhZcjE1Zjd2U25r?=
 =?utf-8?B?dklBQU9VZEpkbmR2YThVQVR4RHhEdnEzeDJlVnZCYVphdUl5ZEdxQVFUbGRU?=
 =?utf-8?B?U2hVVTl4eTU3TlZhR0FjYklUUW5kbGRISDhqMXNSck4xZG8rWkN0K1hRVERU?=
 =?utf-8?B?ZWZJcnpwOFV3QzlRSklNZmtEM2huRldHZTZFbG9PbXVxdEhTMm5IMXNnV1hJ?=
 =?utf-8?B?bWdlZVVSV2dhbDBWWDJKZ0ZoMzh5Z3NYY3JqbXJSN21uMjQwQWRKYUpvMm84?=
 =?utf-8?B?U0tZYm14bCtlWlFrOVNROXUxaGZwNEtUbHFJV1FsR015Ykh0OUlJRlZVSEw5?=
 =?utf-8?B?ZVNXaDZqS08rL0VDcFpWanhIbXd4NU1RUDlWZUtWcnFSeEFLQ0cxYVJRUEI2?=
 =?utf-8?Q?HV/zclnmFbGi0LHMH6VJguM3UakpfBXi1yU3ujM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eExoVFVndUcySXBxQkpLcTF4UEZPdlFPb042RmVEVjNta1gvdXpBdE5sY3Uz?=
 =?utf-8?B?T0dJb0RsdDAxSGRhdW1GdlNoRG01eDk5T1BDNFdzYWIzRDVLaVdOUFVxU2pW?=
 =?utf-8?B?VXRxSnluU3dRZ0dIL1haRkRkWmg2NndnU2hHSGJNUTJzYjJtMUsrVE9YalI2?=
 =?utf-8?B?TVZ4Nm13L1o5dkpET0JiWHJlY3VIWHlKbEdjQUpKYW12T1JDOTROdStKWWlx?=
 =?utf-8?B?VGVKdEV4blJWeXVFZWNHQVVDZDhPR0phdEtaZnpibndFQU16a1lVQjlmbDFX?=
 =?utf-8?B?ZTV2Y1l1RmJ2R1BzRmdta2VEVkIzZWtOdzBhKzNVbzhFNFJ4Tm9Ga0tIMXNQ?=
 =?utf-8?B?SHdFeXhmOWNxQmEzdTNlQVk5VVFMNzZHMUVzcnFibnV0NjBEK2htQTN2Q01I?=
 =?utf-8?B?VjYvU3JNcGRBbVFJaFZ4allteXlsUksyS2c1NHAxeHdVN0ZTWEozSTg2ek1L?=
 =?utf-8?B?cVRHQmIvQ2JieFpobWQ3ZXFRSy8xQzluaGQ2MEVmMTBNcmxTN3A3ODhRN1lF?=
 =?utf-8?B?MzBCc3RGaDdxUHpKU3pIQUxreGswRFhoTjh3aUY2RzZ3b0xQQVJYaXZjNEpF?=
 =?utf-8?B?M3RXQlpDcXdPWEM3b2FaR2pZam1KcFBTaHQwQi9jQUs2ZGkvN2pSVGxTTmEr?=
 =?utf-8?B?enlPU2ROc1FNODlRazBCdlRqcWxXdEFwNkFQeWNObUcydU1Sc1BXMHIzSDJu?=
 =?utf-8?B?Rk1peHo4UW1odTUwcHNOMkFiWXRhRHNTVVYwNTY5VnhXd0FoQmpsZjIwSHEv?=
 =?utf-8?B?a2ZmeExKOWJybUdXOG9NWEtmVTZhYVU2ME5kWXI1WEZQM0tKak1WbTRQTWt4?=
 =?utf-8?B?Z1dUQmpObFgyNHhWbGwvbStxcVhBUmVXb3dGWUZlaHh3ME9EZ0RHNEpYMGtF?=
 =?utf-8?B?Y1hXUnhaeWJJWFozajRobkhnQm1DU1ZsSVEzNEwzaklUTUQxZW9zNHlKZ2p6?=
 =?utf-8?B?cTc4eHdmL0pTTlNPdEUxcVRMa0Y2K0MxT01HT20wTkhzdURIOEh5OHdOUHVv?=
 =?utf-8?B?NHIvcGM1cUpNSk1xL3lQR3B1ZzlJR2xacXJQYmp4Q2FwdVdpSlQwQndhSzNh?=
 =?utf-8?B?VXdUQUR0VnlzbHpHRENvc2p1a3ZPRTVJTVlrWFF3bzNob01WcGhnN2hHSHBv?=
 =?utf-8?B?VU5pTGtkdUZoMklkUEZjRURra0dtZ2IraDBFdUJaV0tiQTJLSllwemJUQjlJ?=
 =?utf-8?B?NzZyQkg0YWs2Qk8wTjJPa0dNbURuU0NhRmYyeE9pTHVQZk04eFlUNjUzVFBH?=
 =?utf-8?B?M3E4K1VqeS9iZzNRaVI4YlUxZjE3ZUJkcWpaNCtmRytGOWJsTjloMjZYOTQ1?=
 =?utf-8?B?aHZlK2V5cXh2SGhWZmcyak1Qc0s1QUY3Q2lFZStLdVJZblBsNGRMdVIxM0tq?=
 =?utf-8?B?b2JGaUEzMzJ5YTExSzMrM3pNL2RDc1M4S0cybE5KcCtrRHFvWStWc0VJbE9Q?=
 =?utf-8?B?YmxYMWZBODhlaHVxODFtenhwVTd0a2grWGNuem9RMGxubTlPUEwrUlk5Tloz?=
 =?utf-8?B?OGVJMmRYS2hiVElqUERUYTgwSFhmV3hQRW1VZExhOFBGQ2dscUZ0dmVBZXpK?=
 =?utf-8?B?cDJLY08xdEJxVDBnbThrWGtVZDV5YTdIaGF2MEI3ZW9keWpiUFJ5elJGTFpE?=
 =?utf-8?B?aTAzaXk3UkpDOXV0STUwL0lUUVR3dkEyemczM0F3SHphYktyczNqWk9yYzlY?=
 =?utf-8?B?S0c5T0ptUkkzbDdiZWJHWlltZ3BWcElML0x4TXZqOWdkalljWFNiY0k4TnN4?=
 =?utf-8?B?UVJIcG1nZ0t5SGprZGpZT3NKLzhURy8wWHZxNmYxYXd5UkY5ZytwNlBFWVVv?=
 =?utf-8?B?WlVocWVXSlM0K1FCYTNEZGtCQUdtekEyTVovazdLR2xCREREOXFrZ2xWc002?=
 =?utf-8?B?YndZa3VxektRM0loU1ViaHVxWG5NWGNxNE5MZW9oSlY4bTlwOVJuS2c1Vm55?=
 =?utf-8?B?SnB4V0ZHS2V1aEk4UDJZV2JsRVpmQmJnQU5pTXRnTGxTSHdqanQ5RmhvcFk2?=
 =?utf-8?B?WGp4WGdLNUdMN1dUZTdzRnp4Y3A0V3ZOSllkTkkwNExmamhJK2dNWU4zTmdu?=
 =?utf-8?B?enVBZ0NJWkcvdjU0TUNWVHRUR2JRZFYwSUtnMUc3VWVNcDFNaGxObVlUS3l5?=
 =?utf-8?Q?sb+P7qQCqwCo4JD3ft8OZnx8H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iQs/1GX0Mt8EOx3t4PgnB14zlVSYnG+QoJt29QDRTLL4rEMYPrH/nkXGWuNqeHRJzpN9Hr8xch2RkJFis1S8KsCmV4FrMl66pshIOM2jW9ZcnrygxzVO7RzWClUcy32YZhJ7os6vWBHxHIdI2/KjbatXlsXtgTBHkntkMFYu6UwTHEe/O1+g1nUHnKo+LcSjim1vg+5cWNEZQb/tthHmr5Lxf7sm2m5g5Om1yKZozZfKO5NK6Riprvfh/T9VC2pENFaVV/Ek6CTtqqnZu6ee01eeCfnwByC67fiN6CrA6n6lQm4e6u0qiTOUJcNonQ8PRw9sBGL8+66yxcG5AHyYfVH84nOetZNrMwdOiWDl5k/Zrowos1n8THYyBi88gk851EV5XKyaO7zwB1ewZ95xIvZgSiiJsqr4/RBpitwW0F3oM4fT0roSt0aKhqmZPcip41oClF8kZOwReJVszF7Ly7xBnG3bGmUtvBtyTv6th/PdPVB6PMwEEOW8EahHUjCSDMmwlGn/LNC5T33uAddYt0A8P9XIOV+4GoXNOOdpe34OeYm51tdX+eTp/JFGxGOSsQPLFMZturPIe8jWMZfYF/HGu43cGc4vz7AcNdz3dGY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf453943-f7ab-4c53-70c1-08dd4c3937e4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 14:17:59.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DumCkv7X9zLva3KQDBjAWMRKM2k6anE4Stb5QWx06102f7DD0hFS91oiJej6J4wpdOWPbasUyr+AkEFvXS7IIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130108
X-Proofpoint-GUID: HLe-o93-cS5cF7PqjrTO13hA_pc4H_2k
X-Proofpoint-ORIG-GUID: HLe-o93-cS5cF7PqjrTO13hA_pc4H_2k

On 2/12/25 9:16 PM, Mikhail Gavrilov wrote:
> Hi,
> I spotted that Google Chrome started working without HW acceleration.
> And git bisect found commit b9b588f22a0c049a14885399e27625635ae6ef91
> Author: Chuck Lever <chuck.lever@oracle.com>
> Date:   Sat Dec 28 12:55:21 2024 -0500
> 
>     libfs: Use d_children list to iterate simple_offset directories
> 
>     The mtree mechanism has been effective at creating directory offsets
>     that are stable over multiple opendir instances. However, it has not
>     been able to handle the subtleties of renames that are concurrent
>     with readdir.
> 
>     Instead of using the mtree to emit entries in the order of their
>     offset values, use it only to map incoming ctx->pos to a starting
>     entry. Then use the directory's d_children list, which is already
>     maintained properly by the dcache, to find the next child to emit.
> 
>     One of the sneaky things about this is that when the mtree-allocated
>     offset value wraps (which is very rare), looking up ctx->pos++ is
>     not going to find the next entry; it will return NULL. Instead, by
>     following the d_children list, the offset values can appear in any
>     order but all of the entries in the directory will be visited
>     eventually.
> 
>     Note also that the readdir() is guaranteed to reach the tail of this
>     list. Entries are added only at the head of d_children, and readdir
>     walks from its current position in that list towards its tail.
> 
>     Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>     Link: https://lore.kernel.org/r/20241228175522.1854234-6-cel@kernel.org
>     Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
>  fs/libfs.c | 84
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 58 insertions(+), 26 deletions(-)
> 
> I tested Google Chrome after reverting commit b9b588f22a0c and ensured
> that this fixed the issue.

I need a simpler reproducer, please. "Chrome stopped working" doesn't
give me anything actionable.


> Machine spec: https://linux-hardware.org/?probe=5810cda90d
> I attached below my build config.
> 
> Chuck, you, as the author problem commit, can look into this, please?


-- 
Chuck Lever

