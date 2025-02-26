Return-Path: <linux-fsdevel+bounces-42725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE7A46CF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 22:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7405C3A9A86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 21:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762725B669;
	Wed, 26 Feb 2025 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NPxa2QM0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="guttX7xc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1D2512CF;
	Wed, 26 Feb 2025 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603693; cv=fail; b=EcDKLqWzJ9N43rgp7gkmz6wJ8UAi7PRu8LPVH41jH7w0cO9KSuYmmtKHjWnoqnBLebYxi6adYKSY+L02KeYtqQWnHzwFH4gkk2qqxQuS3PfqPHGPpTH68bgdGF97oDAY4UqiT1Ixdiq99/dkf9XSO0w39KJO14xlrwLiiAqZc7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603693; c=relaxed/simple;
	bh=7o/NTFyIVwmOSyLpe7MIwiSFSy37gyoyCdX4R3dbDZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bBE7MmKsRP+/0fLOpfDgJM1SzJYYQH4lVT08YAKd9cCwfa6e/kEzzZSogAg/HiDiD77BYjjLWvV0AFwaFoM/G0pjxwu9ZmnLwmO2F6hqcgTzg0MXCt+snQuMazTnbCg6zUSjQwcvJfw25VT+2DxMLP8IH7FhRT/iarFLPHA+CVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NPxa2QM0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=guttX7xc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QKMhg4023857;
	Wed, 26 Feb 2025 21:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dcMdNnW91a8hBpLhKIi4AmnsoCGqem1GiK9tt5U53Rc=; b=
	NPxa2QM03x+c12nvgLH+EA+D48U5bgvToDedLnVn/AKVxfLCae4prMoG8HG1UQFh
	LJeslOz5Im9gKE28i8rvYqOE/VqKm9vz38opdDCzGuZ/9XqZtAS+ZKj5CYtQMCBz
	wP0KXhFUlZw50wJ0e9AM679v4alH5mQK3yZZL3Xx+1u/GbowJBAZuSb9pVrSMAim
	Bkq0Yx2ibGFvP55dpNy8c7mElHD2TexLiSO7dT71hCOj6/iUsjTmrRyOLtDgf8+j
	dksgyoL9L+PLG17i4HE9CVZ5mOmE2m521CUvsYEyM/tg7bQvF4o0C0KI09MvIjn3
	MO8s89++Kh8qdw+hT3fGxw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf22hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 21:01:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QJGJpf025221;
	Wed, 26 Feb 2025 21:01:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51ht7qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 21:01:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQOaeupO2vFAxqQpQIdheQ9SWExVv6lw3Etqk2OYoAMCDQcpNnaCGHzz1/ciz/NXRNtKirOJRyct6DnPHtys02C49IV29861iHdvuxF0jOdyymgl/TiG0WQIriL/cg0EAVfx502ZVsngNRAKO8TIQV0GjvpXnhK/66yIXWgXhQBLIlYL4CtknMwJMXCVCCUw2Av6fMu5ZYtvwd3uUUCZKPKEkYQj02DqAM6oHepk2b4LukRBZqqcTKBvB7fGBsBYG6Fpu42kMjCPnlO5tiHvBMvv3Mfvk67bFCw8hFDxeBt4l4tvjwLo7Z8SLjLdp23beLI9DLf58ur0GlHSAZfzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcMdNnW91a8hBpLhKIi4AmnsoCGqem1GiK9tt5U53Rc=;
 b=GbhhFCzuBcCcNbBZZzjrEN+dDDF80ktPY5GaGcYY7g/T9jH7IaQyYoCSuUxK6nzqWteOWo2oWbCJfqLxDZl2xAvx8DD+PsXyobKGAIfr1RR+vpktIc5DV2rWlA8Ylq46TsCthgwp9ZKkxIAtqk4SFTYjZOyXhtWJVK2loiIVrN1kO3CnVA/Z+xUcCiKYQrnEfbnVOCy2hqQbXa6SZZzG2DsfyH3fYcMLSJPWK7WYm1gwnz77b9knt3ewaMjfJQeVStAvtV1HKqd1B5tXnW6+a3Jzo4KESUKLfxbv6d7soRCM32WRo7prXStfmk0LjsanLnFjWKI6QJMsMwY7UWdL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcMdNnW91a8hBpLhKIi4AmnsoCGqem1GiK9tt5U53Rc=;
 b=guttX7xc7ND6WS4IX4MFPxptEL6C84Q09VihzYRokMbv4ZiDgtKdSnzPA7IcaVlEI9rLXusEWUO/qClHTUMlPJOUJfQeS/v73+zcSebPVKu19mMJC1w6yM2FDXwySklh3+YeHm1V6Zwh2QKBxv7IMpeb5z7fDEcWkv5FK71Cj/o=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by MW4PR10MB6584.namprd10.prod.outlook.com (2603:10b6:303:226::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 21:01:19 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8489.019; Wed, 26 Feb 2025
 21:01:19 +0000
Message-ID: <4e1b220d-1737-468d-af0b-6050f8cdaf8b@oracle.com>
Date: Wed, 26 Feb 2025 16:01:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
To: Eric Biggers <ebiggers@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, regressions@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <874j0lvy89.wl-tiwai@suse.de>
 <dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
 <87jz9d5cdp.wl-tiwai@suse.de>
 <263acb8f-2864-4165-90f7-6166e68180be@oracle.com>
 <20250226204229.GC3949421@google.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250226204229.GC3949421@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:610:118::28) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|MW4PR10MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b6a7c0-ae08-452c-6f1e-08dd56a8b7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFJGVDNCTGtVMmowdlkyem5NNWVCWUd3d2pzUjVVRE55aUFCZ3dkS2VlRW1r?=
 =?utf-8?B?YkU3T1I5b1NxWlRUa1k2TWZBeEsrNmVYRy8xN1UxeG9ybEloUFZjZkQ1MXJp?=
 =?utf-8?B?Q2VZUDBDNlhIYjY0Q1VFQ2ZJWjB2cW5ma2VXZ3RENUhmTE9Qbmo4bForSER2?=
 =?utf-8?B?Z1c4N3UzVHNycEhZYWVsTkp2dUE3T2pIcjdyS3hndm41eDdaNGhBUmhlblN1?=
 =?utf-8?B?OVptWWFXL2VTR3VsVXZJYVprbGJSUmI0VmFWK0hrUEVNLy81RXdGYzlDcDEz?=
 =?utf-8?B?VXQyMy91TDdrUDNiaElFTzh4YnlORVo1dCtyd0dTVGdjMVJIVC85T0NROU1F?=
 =?utf-8?B?dldaZGZYK2FXQnloOGd0M2xrbGJQZlFPNjJmVzllWTJLNUNYekJWUDRKdW9C?=
 =?utf-8?B?VnpEdURsZFpmaU1wWU1UcEdZT2I2NHBZM3ZPVXZJVUJXSkVWNGhkL1pWVERj?=
 =?utf-8?B?MXVoSkFRb2Q5QU5xRWsyUStPTHI3OG4zVGVaWW5OeFdKbmtlUU9ySkxZVXdH?=
 =?utf-8?B?TTR1YUpNR21RdExLS1pTbndsOTFWQlFXY3dyM2JWZE4yY2ExYnp0MjNWRWhi?=
 =?utf-8?B?TUxOOEVOaS9aMHRaVE1Jbjg0c2I1c2xyOUxDVWJuMXN0bWxXb3IvQmtCTW13?=
 =?utf-8?B?UURNZnE0ajNBNmZic3Fla2s0T2xKc3BMd2ltS29RVXJ4VmtRdCtlZmwvV0Rt?=
 =?utf-8?B?bWtSOG9Uc0Y3TVlUUEVkblpJSml2c0RoRDBXQmk1eENBQzNYZnBuS2xZeDlI?=
 =?utf-8?B?QnUwME40SVkyWGFkQ21oS09VdDRBRWJLblM2eVlZK1g4eU9wSks5a2Fvbloz?=
 =?utf-8?B?N2VGUS9TNWxsUUxTWVdFTWliNCs0WjZJUi9YSGZGdEs2cExWWWJuWmx4MTlz?=
 =?utf-8?B?OEJnVHBjRlIyNjNiclRQL0ZqbUhPL0xyYjVzaWVIeE45d1hMNFByYU0yZ1FD?=
 =?utf-8?B?S2V5TmxpaXRXREQ1eWg4ZVRMTnM5SXNuUmhocEVqNm5aR01CTkFNcE8vbUp0?=
 =?utf-8?B?NnljR3VnTThBNWpRL3JIZVpGWmVOZWovSkdzdEJ4QXNpazM3b2xWMit0Qmw1?=
 =?utf-8?B?c0VmUzdGNE1zckZvd0FzSTYyM3VJN3FHTE8xMng2UmVvam9RK054elhZdk12?=
 =?utf-8?B?VVNMQ3lEMlJ3VDZyU2ZaQ01VakRyZ0xJd0JVZktEYW54c1Q1RnBnS2FMOWpN?=
 =?utf-8?B?RzlRNG9qOWphSWoxT3R0WElNb0pLZ2NUZFlyQ01QSDBVUGdiUzkxb0x6Z2Iw?=
 =?utf-8?B?Q2pKbzVNaUU1dzZSb3pBWmErVUo5MlFFM2h2QUEwTTAvcktDajRLaHIvOXQx?=
 =?utf-8?B?eDJhSUJhSTVZNElUamFYL21DVVk4ZjdyWGVnVmY3ZzBEWi9HNkJmdnhnNkh6?=
 =?utf-8?B?c2UreEZUK1dtbCtaaUlDZEJXQno5V2tCc1FxMzFBTEJtV1NNQXV2c2hia3hj?=
 =?utf-8?B?NG0wV21ZY3ZVZ2JnOHRQY1pmODN1Rno1R2EvOFI1aGxrTzh4L083VHBqZ0lY?=
 =?utf-8?B?YkpSbWdjK2NkVzVhVFZOTmJ4VCtVaUJRaGpocVYxdnA4NW1wL0pKUUNGLzhW?=
 =?utf-8?B?VnZsejZKU0Q0UlRRQXdocXBXRGlqU2VDWWlVcmhzODNGa0FodjVLbVVHbkJv?=
 =?utf-8?B?NzFEWXBERnFFdWtPeWtlRmtMOHlpMU9RbkhKZCs0Uk1Icjd4SnRHUGYwK3Fo?=
 =?utf-8?B?Mm9nSVZSNm5jUGhxSU9xWXdIV3Iva3FRaEx5cEM1Z1NTL0RjRjRjTGxieWlw?=
 =?utf-8?B?Y3haamxnaFRnYTBLbk0zcWl4cDQvUzA3QTBrbk1rYXBlUFZpMkE0Rm1LY2pv?=
 =?utf-8?B?eW1SY3NvWkJ0K1dlZzZ5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azRrYndIZGlFZWhxWGI4UzVtbzZZUGNLRk9pUW05eS85QktWdWJLSlFEQTlS?=
 =?utf-8?B?TFcvTHVqVTEvSUIxa1N6K3BLcVVsam9YVkZxMFdyR0NiT25ublZ6b2gza2VU?=
 =?utf-8?B?NFNoWUQ3bXM0aElXVmFZTFova3MwMFhNOTZhU0ZIU2xJeTRqYU5KUllnb1NB?=
 =?utf-8?B?a0RCMzNzQWVXNXNrcGJadnl5UTEyTlRhbWdySjhyb3Aza1YrbzE1ck51T1VF?=
 =?utf-8?B?WmJBUm1yUUtBSHJvTHhGWFRYN2hNbm1GaXZGcnN2aXMzeDZ6dWlBNGh0UkJl?=
 =?utf-8?B?NENoQTFrSFFLT0lqc3NWZlBqL1VwVG0yenVLVEdMelc1SmM0SGxXSE9ReXkw?=
 =?utf-8?B?N2tXb2NKdHFTeWpOaG1vRjhKeHJEZVpLNStlSXFXTEdqWUo2VkxYTmVrUkRX?=
 =?utf-8?B?cm8vNGhPT1J3dEY5bGdMdXRLZnYraUJacmtUcEhJVDMrS0ZoVDZhWWRoTm1h?=
 =?utf-8?B?ZkQ0dzVxS284N1dxNXk2V002Zi9HbzYzYkRXSUNzYzJqK1dITTB1eTgzNHFu?=
 =?utf-8?B?SGkxVlVjYXU1NHgvc2EybTZzTitLanJDdGJ5VkVRSGtzRWJTRzdPL2pEazBF?=
 =?utf-8?B?bjgwN0F3WUZtUXpTN3pQa1F3c09sTW9odVU3MzFuRHF1ZURWZk16SlVDbGxk?=
 =?utf-8?B?Nk5mMUt4dk1PSHVvdFdGQ3ZyUFdkSXErVWZGdUFDczVud3JSRjV3TjBGVDhp?=
 =?utf-8?B?SG4zMEI0T043MUNQTnFySS9KYnBwTFhLWnJlQ3lNc3prYzJRUnc4cUs1WVFz?=
 =?utf-8?B?ZjZLSHBCbGNWaGJBbGExSUIxMVZQWTBtdVMwa2RJaTRES2Fxa2tjTFJMOUxt?=
 =?utf-8?B?Z01kUnRMNjJzT2x0UVh1bmcvQW0rSG94dlV6Rno0aHA3QUFZTVNQcmlJVEh6?=
 =?utf-8?B?VVF0QlBvNEgxdDdlMlBxWkpxcVI1MmV0ZXZ2STFxZ2RsMGxFckJIQi94cXVD?=
 =?utf-8?B?NDdlMXZyb3ZHQ1lNY0F3T2dSWGhXclcvQVZsZ2hGNXYvWWRuSzRBMk1icDJL?=
 =?utf-8?B?RCtuN1FtZzZKNjc2M2dxZnhsd0orRlJBcXl1V2szMWNmTDJjaExGeG1leUha?=
 =?utf-8?B?bjk1SGxBWFdOenA3K3pVTE01NUc4YW01WlJKZFlmUVlsZG05cm9nci9EOCtL?=
 =?utf-8?B?TXBYZDE5aDFMWkxHRGFqT2F4cGdVK3NWcDNJZXV6a1RQSk1wUmdkaFRraDFB?=
 =?utf-8?B?bGRNMXV4Zks3Zk1XME0wYi9qYmpJSVZpVW12WEllWEhRd1I3K1JUK0NqaGtt?=
 =?utf-8?B?NnpOalNTRjNjQlkySGNseElURlFBTS9PN0RKU0x2QVFENm9GVXpmeFRIL045?=
 =?utf-8?B?djZ0MC9EcDZoTWhkQ1F4SURVei92bU13QnMvM0dXQlZGRjVtZ3JSREk0UVdo?=
 =?utf-8?B?WStMM0JoY3R3ZjFZZGNqQ096aVRqSnZ6eHljZmVFckJLcEoyd0E1NzUzdXlv?=
 =?utf-8?B?T2pmaFQ2U2hOSjZhMGUxOUVzS3B5U3MvN0hBczJ6VWNiejJybkxoM3NsUEk0?=
 =?utf-8?B?Q2tDa2xRZkVOc2FSQURIQXBSYXZlYnArQWdpQmJHQXBycWFmQXRXbVlpNERw?=
 =?utf-8?B?VzcxdHRBdnFXWkpnUWkwKytCTG8zTURXSmNxRThvWnBER044dWZNQk1ML2NP?=
 =?utf-8?B?aHMyUDRibmRzalJXVXZRQ0xTY2k3WWNpNmpBWXdwbjlzb2ExWjB1RGV3UjUw?=
 =?utf-8?B?VEtwZDlnY21xNHVUeFRuZTQzRXFpTmxKY0tHMi9vVDZBRVo3dEhUbTRFc3FX?=
 =?utf-8?B?bmhyanppOHFsTmRrU3BEbFJ6cHVJNEhENlcrc2RiYnVpNEFPWFpSOTBadkpJ?=
 =?utf-8?B?V3VsbmNzMytzcG5TT0ZDa0FWRVZpcW5EUGtzdk4vMFk0eHJNeUl6VHBGWmp2?=
 =?utf-8?B?MXJEMjJTY0ZPOHoyOStLV3lOTGZ5UC95eHBYa2xVcXNpay9nOWhOb3FaNEow?=
 =?utf-8?B?enluVnlkUVc5akxia3U3RXpSVUhPM3o1TU16UVRSdkxiL2hqVlFtM3Jwd2l1?=
 =?utf-8?B?S2dLS252MnV0L2dpK0ZpQWRWaHEzLzBnWjJOdEFRaXNwV3hEc3dlZGpjOW94?=
 =?utf-8?B?SUg5VWl3OE1jNndXaGxleHZoZWtsUXNYSXRmSmthbTUrWlZ2V3JMMWtjWkRE?=
 =?utf-8?B?RGFWWXNnL2lsTWJNK3V6aVBWNTE0TGxrMGtvb2JGdmpCWEJkMVBWRStoa0ZB?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jbib5MXHvxpEdSQsMNBxcwYVwbGKHsirxkA0UwbRUjo9DzaFwoQlmbRqe9Grcdm8Mr4idATDFAXcNzIZ/cI59Tw4j5YBcBygACkRZvn9rL0le5USLDvNAPfSTmWtNNWohg7DQAS8SdVLFd/C4CwntdLwrJraOSo5XNjsWvwQz+ky9Ryy5TPBV/zGIgCJ/WKFeT+dy6rGLQsZ3o1HsF3YuD5Tmva0i1be+KaPQ9GocZk0h81fd/s2e6VACqE8jgR+OIgURjy4+wyuH4qvFekeNWLrtYXxD7Cklc+N2dL2+MAUwPsPlW+JU14mz7a1DHi2vpv2HlGJy96+LFovBNYVf2ckijPPaoJkaG0Q7bQik9TEWHoAwVsdXg9dEcTcCHy1hiNmBOCZwjzWuKdH+exWejObYOUXKjIgym0Zp82prtzbhuskoCrusQO16j5sN70fpRCMtxQ05uH2bx4o5eoRLTteMzfrsljpILKJr6vojrVTrYqbqqI5jq8RyCuCVY7oHrjwFvsljT31vY5Sc0Kh4TTus1RGJFGaH+3il9wakKZBG/NA2x68abZLzRRL5TuSowceoVtoyNWXNC2cFONukcQnIospq7Fh8sWhkcCcAlM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b6a7c0-ae08-452c-6f1e-08dd56a8b7bf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:01:19.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8Audy7ltvey2/hil0KZHAGphVqLFR7XjJhaaRxTzm/t2Mjvw/Afo3AofDuxQG8RLFPAewzNU1UVXuSPE1Y2jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502260163
X-Proofpoint-ORIG-GUID: ZGqifWVdK9GDLyuQDEpoiK_WUm_-poR2
X-Proofpoint-GUID: ZGqifWVdK9GDLyuQDEpoiK_WUm_-poR2

On 2/26/25 3:42 PM, Eric Biggers wrote:
> On Wed, Feb 26, 2025 at 09:11:04AM -0500, Chuck Lever wrote:
>> On 2/26/25 3:38 AM, Takashi Iwai wrote:
>>> On Sun, 23 Feb 2025 16:18:41 +0100,
>>> Chuck Lever wrote:
>>>>
>>>> On 2/23/25 3:53 AM, Takashi Iwai wrote:
>>>>> [ resent due to a wrong address for regression reporting, sorry! ]
>>>>>
>>>>> Hi,
>>>>>
>>>>> we received a bug report showing the regression on 6.13.1 kernel
>>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
>>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>>>>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>
>>>>> Quoting from there:
>>>>> """
>>>>> I use the latest TW on Gnome with a 4K display and 150%
>>>>> scaling. Everything has been working fine, but recently both Chrome
>>>>> and VSCode (installed from official non-openSUSE channels) stopped
>>>>> working with Scaling.
>>>>> ....
>>>>> I am using VSCode with:
>>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
>>>>> """
>>>>>
>>>>> Surprisingly, the bisection pointed to the backport of the commit
>>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
>>>>> to iterate simple_offset directories").
>>>>>
>>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
>>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
>>>>> release is still affected, too.
>>>>>
>>>>> For now I have no concrete idea how the patch could break the behavior
>>>>> of a graphical application like the above.  Let us know if you need
>>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
>>>>> and ask there; or open another bug report at whatever you like.)
>>>>>
>>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>>>
>>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
>>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>
>>>> We received a similar report a few days ago, and are likewise puzzled at
>>>> the commit result. Please report this issue to the Chrome development
>>>> team and have them come up with a simple reproducer that I can try in my
>>>> own lab. I'm sure they can quickly get to the bottom of the application
>>>> stack to identify the misbehaving interaction between OS and app.
>>>
>>> Do you know where to report to?
>>
>> You'll need to drive this, since you currently have a working
>> reproducer. You can report the issue here:
>>
>> https://support.google.com/chrome/answer/95315?hl=en&co=GENIE.Platform%3DDesktop
>>
>>
> 
> FYI this was already reported on the Chrome issue tracker 2 weeks ago:
> https://issuetracker.google.com/issues/396434686

That appears to be as a response to the first report to us. Thanks for
finding this.

I notice that this report indicates the problem is with a developer
build of Chrome, not a GA build.

If /dev/dri is a tmpfs file system, then it would indeed be affected by
b9b588f22a0c. No indication yet of how.


-- 
Chuck Lever

