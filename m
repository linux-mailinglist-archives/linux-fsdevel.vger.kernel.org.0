Return-Path: <linux-fsdevel+bounces-42758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2571A4810B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 15:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06AC19C27F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550AF235375;
	Thu, 27 Feb 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e4Y5ZOKa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fp8bap4F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83E235354;
	Thu, 27 Feb 2025 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665814; cv=fail; b=dv2uClMtGm9dSwRSkAtcQoyEVczSTqs8DVy46XaihgDGdP4y7HK3BF+S7l/Z6JHELpvXIFFeMIxq5zgQwWLmxOcamsWviBprRVUWQt0bBkemr5H4BcOg62HgYejZg7PBbJiC9xXDJJ0b0RCpjeoBSnHQ77Vl3MOITLTeLPzpjpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665814; c=relaxed/simple;
	bh=wv0hvIFVaFzccde5uedOW7hPi/Lkkv9/j/Qz598/rak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PL24M3jzm1AL7am583vUjvFc4gO71ddKDkEt0pG4rg/hRzWHIM4teYvhxoLYggQS6tNvxZyAcNDSZctSeufWJaCm+KYpOV9LeTVFZtJwt3g2HsjHztU2IR/kcI7iLBZ5pW5ddFF7c1XGKvekWcbR0MlHH1kj14VeK3DO6ANsbHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e4Y5ZOKa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fp8bap4F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RBQa5m003625;
	Thu, 27 Feb 2025 14:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xIJGcdwJl92pf4I7rAdrpXSJlMOFTYexA/MnVvApujE=; b=
	e4Y5ZOKaUwudmTE1Kr4zYT2s285yDMTdUj0dcPrBFZBCQOlzL9A69JTgzjk9F7sU
	mE0r0JV9Fm3tzQXoay4XZo72HdUt9HGlNOu99h4H6rb5zgzSxdleBDoROKel3rcl
	ogI15KuYTk1mN5mEdVwwnWCkrDhWJcitHz0/pU4KARymEAbGdPRbw7lOeD40wEyR
	IWA+pqJINI+KE+AqB04v1Tw60OlV9eU0ezp6DGItdE70zObnLLhrepT64MuGhg75
	DWUKryWam4SFhBByz+zE/JNzzN5rT0rwqrSDhAK/Fo7bevGmj1dLWNOVmR5WXpbg
	mNt0WHwvB7f6ltcKAtJuFQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf3eqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 14:16:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RCltJd010107;
	Thu, 27 Feb 2025 14:16:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51bw5dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 14:16:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlqAZZgU5dOXFAZcPzvX03ilBQaPxe50F8eR/Y2l92LJMnbVd7NM+B8ijQLDPTGAFE3eSbr4RAxZbBrsoi2rThwls27V/bE4G6q4pG3nt5DJ9n6a6T1Y9sikI+eZldC9s6S8Au3n+o5HmpTEAZn0l0f6TJGH7ZiOOczCQWVILIZxtGoUj6OxlR8JbM1FBsL5YHTmz0j08PKNffix8G/OtFIbygIYN+ZvNtSj6QPckM8c089NZooyAdzY0nNO06jmCMs+QuyOkkc+JiWjx1VNtpKTAFF9aYWrqwZENuXuzgmIAKUAlwzwI3s2bXfFN2i2xsg9wmdvDAda1WLHYrdknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIJGcdwJl92pf4I7rAdrpXSJlMOFTYexA/MnVvApujE=;
 b=LgaKd5ph2vjltXJbyt8Vg9Y18iVqwzq4iZzd3yogveWMBRFl52vs3dvp0VinY+FdVX1DgrwhfYHhslh1YgZtBU3WzBvN0BOY6y3wjnQYeP4kI6elNCgh8tgdHFJDzAMnhKtZrIGteioRwj3bxsW2OV8555RBI4HywFYTkXgDK1KdgpQfdhC3oFk4LEJ2+B1n7+zmzlGOYwD3fxa7a4wkTgQ/wvMSNaniqwzR3uoSYbma2TC5uTz5RAq3ceLL/1YcUW7TFwT5jMicm8yRJbG+UmjuFyVkhiVtKblTKUW+E4+jSoEkFbzysVOnlcz3loyjHWNG4BAHCtMoN2Sy5efImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIJGcdwJl92pf4I7rAdrpXSJlMOFTYexA/MnVvApujE=;
 b=Fp8bap4FjW5qOY9h0906fFM8NrTSuJnyMExs6nbXLLeYbZGcj2QglSNuRlSoiYlwX0kpKk6jqcmYHU2v1j7Ssyfbowb+shE67eIBmqcgfkJj0Jp1xFLbL5jNMeycsQRyYZz3L8GAOU64NY6QqU16FuL0pLkaNsrMWJOsIn6dwTU=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by IA1PR10MB6267.namprd10.prod.outlook.com (2603:10b6:208:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 14:16:40 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 14:16:40 +0000
Message-ID: <ae375fe0-91f5-44b3-b58d-0dcff7f92d5b@oracle.com>
Date: Thu, 27 Feb 2025 09:16:38 -0500
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
 <4e1b220d-1737-468d-af0b-6050f8cdaf8b@oracle.com>
 <20250226214003.GE3949421@google.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250226214003.GE3949421@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:610:5a::30) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|IA1PR10MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5195ff-47dd-48ba-267f-08dd57395a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWpGcjdUeTJYY3BIbnU1ZkQyNFpHS2FYbWlSTXRLOGtpTjBWTzZMR0FQclEx?=
 =?utf-8?B?UG53eG1VTHo5THUxRmRxcXZQOTNIeWppTXFHZnk2R3orMWFvRGNhMmFkU3Nl?=
 =?utf-8?B?NlVNNVJUTURIL3hSUWxSejFjVDl4UjdDNjBGMi91Y1hIMTVsWHFFREo2SXJW?=
 =?utf-8?B?SkNhUzNPSS9JaCt0c25USmJkV3ZRQkhhL1pHMXNaODAzWENiOERlVmY0eFda?=
 =?utf-8?B?RDFzUnI1MkZKbmthOVpQS3Vvc3hVK2lFTC9FYkFaZ1Z2WnNLZGtFYWNtSEZh?=
 =?utf-8?B?ekgzcEhGL2E5OUtXNXIxZ2E4RHRpRWJLb1hhdUkwTGJCRmtzemdJUGl3SE1R?=
 =?utf-8?B?eEtaRGo3KzQrdnN2RzhXSWcvaWRaTUM4elZzZVk4Vm9ETXlwS1hIVk9LeUVK?=
 =?utf-8?B?NUtROGRjWGhNd1dtTnZwZEF3OFdxY2QwbHpObkthMDhYTEFlNWc4YWZrSnln?=
 =?utf-8?B?ZEU2QzNLMlEwV2hVY0ZoV3hmbUp1dVY2NWdtckNrUlQwWmtCR1lCSHdjMDIr?=
 =?utf-8?B?YUpIRUp6T2g4MXRibitpclpWQWJ4V0RXQ2p0eU9LNTU0YXJxaFVmU1NDVHJS?=
 =?utf-8?B?NERqZGZ4amFlR0F2cmZ1ZHFlMjg3WTBqY3pFemNjTTFid1kxcXh4ajQxVExr?=
 =?utf-8?B?ZkN2L0RNeW0yVnByei9WQmNGSklpVEliY3VnSHdTamxZeG9aYkx2RzI2Tnha?=
 =?utf-8?B?NEhOOVdRYzBGVzgvb0g0R3FaWG00UjZPNHdxZFNMUHgrL2lpR3FOa0lpVith?=
 =?utf-8?B?anMzNGIxL2liREtSbWhHSUg4dVE0WDRtdytkTEV2dGlIQjV3K0hNclRKK21X?=
 =?utf-8?B?akdLaTNoZ0RRTUtEVFIrKy96VHJ4WUwvMjJnSmJSRE5kVUhPVWFuTmZpOTdR?=
 =?utf-8?B?Q3c5b3p2ZVp5SzI0TUkwZlV0TFg3SjNocUFyMkpxS2RIS1BUdkxzdkFWa3NR?=
 =?utf-8?B?eWZYVk5wS2lHMnhpa1R6VVF0Rzg1NFZBcVcrWG9LUWdwMC81VnpzMUNpTE44?=
 =?utf-8?B?eDd2WENtOHg3WjlzOWZxd0hHdlp6dmlkZFhQUEc3K0szN0Y1TzhIakNVQnhv?=
 =?utf-8?B?ZnZDR1VKaHV0Q1dMWnR1Vnl2TCtuNm5UMyt1dDZSaCttU2VjMjBISTJEM2pY?=
 =?utf-8?B?cGdjb09Jd2k0eStXUmJkZjBLbGhObTIyeXBqb3JndG9USDlrckFxcysvaVpz?=
 =?utf-8?B?czI4MjQ2bnBwQkVxK1k4Y21BMW1IZHZLSEV3MUxzQzF3QXRqb3NiSitFa3lR?=
 =?utf-8?B?WmNlTGYwa3psVlFNVFRjVFdrUzN1VGhjUDMxb3ZETzN0K3JyejIvbzU5Mkhv?=
 =?utf-8?B?dnJFcUpjUkJyNkJrM2NoRnNDVWNXR0xxR0M3c0R0YitBNDI2WnprTHFEOFIy?=
 =?utf-8?B?dlJYcUN5dXBoV25OdmdhdWZYcDJWUTJnTlpUZTQrZWp0MXhmUi81S050QzJw?=
 =?utf-8?B?TmkvbGgyVXRhWVpGOGJSVUU2d1BxcS9zNHc2RkhQNmdCSkdqM2ZOK0Q5OVh6?=
 =?utf-8?B?L0Z1ODdBRXNLcU1wOTJlbndMNkl3TzBZZG02aEMvb3htclkvaEhpWXZraUVj?=
 =?utf-8?B?RDVCbDRCTXV3cGJHTUFwTkZtdHFpamx4U1RxaFRFOHp0d0EzQU11ZU8yU0ZQ?=
 =?utf-8?B?cGxrS3h1akJ4Ym43VDlkTCtGbjBRejQzRVlIUUMwUDd3WnkrM0VrZW5jK2Z5?=
 =?utf-8?B?NllGK1ZSb0lxamJhUXdNMC9wYndWbzE4b2lrT3pUSW5PY3p1Yi9lU2E1REx5?=
 =?utf-8?B?dFV3bGc5eVdvQUF3ZFh3TkZKNllZVmtGTlduMUpYcWVxVmR5T01JSU9JZEJC?=
 =?utf-8?B?aC9XN2JtNGRzSzArOFlBZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVkvYXZxdUdJQVhJZzRqaE5SdlAyOU0raTVZTHYxb0xxVmkzWHp3S21YWUl4?=
 =?utf-8?B?TVRiTy9od3IzdnhqNGNQcHI5R2VjZlZyZTJwQk9XUkhMUkRDQzUyZGlsaUdP?=
 =?utf-8?B?cWRJTktCZG5JeHR2MlpSRWl1a1gra1J2SmxOcmNKWnM2QzUxcVpLazZtc1pa?=
 =?utf-8?B?OG5Nd1gyenZoVmZZSndLRlQ1NEpJdEVkdjRpNU5KWlBJTTY1cHJWVnFGODFW?=
 =?utf-8?B?aUdWRjdDUVFJZGEyTG9LYmsxdWpiSndlWnBrUVoxYk9jRzd1ejRJZ0ZTYmVJ?=
 =?utf-8?B?N0NHU2svZzRjSXJuVkRnTzM0Vy9KWHpsWVhjcGc5TytRTWl6b0dxVFRLemVx?=
 =?utf-8?B?bXlhZHdHOG1BcjZZNGtycTZUT0FCbGFWMEFPNzl3NjZaOWNkSHpYRzYyQUJl?=
 =?utf-8?B?OW9mRFRidktUODY4QW1RYU1IRFpIaTc2WHlIaEFJZ2ZkZWFuSHllSnoreHA2?=
 =?utf-8?B?RWJxRjluN2IyWXdWcUFuU0lUTXo0Z1pkUzE2clZRRWk4cHNucVJFcTNGZnpi?=
 =?utf-8?B?OUpCV2NSYTZDbHIwOGdHZGkwNVdRcXNWRmJDbTdMUi9KcmpGbTU1VEltYy8v?=
 =?utf-8?B?bTlqU2VtcFFueUJOQXNYd1VUME1zajVOTnJORXQvZTlXOVoxUVRpZkgyV09T?=
 =?utf-8?B?UlQ5bkNSYTN4ZS9UM1crZ3F0UXpnQ1ZrUlRBTXQvbDE5NFJLemRvWk1qY2d0?=
 =?utf-8?B?WGtjQTkraXlZUkRCQVRRUDBaTVVGRWdjc2RRREVMVytzOGRzeC8ySkV5aTBw?=
 =?utf-8?B?aklNRitmNnZ4bmpySkVkSlJLaDEwZnB2OTcraHJNMmlBN1JTY0ZNQ01od2pi?=
 =?utf-8?B?Z1lLN3RzT0tPeXdKTC84TUo3c0x1UFI2T0FNTTBBbS9DbXAxTDkzU3lyend1?=
 =?utf-8?B?bEFLQnFrMElBYU1pOS9lY3JDcUJET1BrUE1FaDI5YUI2dTdpRGR2TngvajU4?=
 =?utf-8?B?SmZGS0tOSnpJdkozVUFnbmd5TG91VjUrajA0VGJwUVJxekRJak8vckNLVXZq?=
 =?utf-8?B?Q0lpdlBWNE5vSEtyWjArOURYeVUwaXJqNFpNblFHbm9yTHUzaGErdjVSWlVH?=
 =?utf-8?B?YmdwdXJaZGJkTnNhbzBYdUZpK0JTOWRRdEpTcnNvdW9nS1l4QVkyMGxlUUt0?=
 =?utf-8?B?aXBQaE8xYXdsU2NvUVBNUDh5K20zQXdmMVh0WGhZeFA0UXZsbjVvK09sK0h4?=
 =?utf-8?B?cmQrd2RJT2RseE1DNEl2bmhqbE9ueUxHK0Q2ZHozN3lXV3Y1VXRQMmg0Qmcr?=
 =?utf-8?B?UlB1YVl3LzBPUyswVkFGb2s1eXYxTG1DbDZPeS9GTE5ocXFvUnpqTUt0ZkdP?=
 =?utf-8?B?UklscHdFeE9Pa0FXd0JPTEJqZ1pIRjhJSFZLekt2WkgzNFR1d0lyUDJvMVNy?=
 =?utf-8?B?ZXpiU09xbDlTZlNGaHRnYWZhRzlTcEZTcXFuNkI3Q0VjbHNxZ2ZObEtENXVq?=
 =?utf-8?B?Z0hWblpNbjJqVGZOSnJYb3hFcEhUUks5cTJTUExLK3VGY3o2TlhaM1lHWnRa?=
 =?utf-8?B?K2FKWXptUXBYU0R4dnhTT3pnRlpVQ3gycitxWW52aXkwSGREb1BjaUozTzBM?=
 =?utf-8?B?U1I5a1JVKzU1Y2pNNEJaOSt2akZabENZWkZmb0t1VjFPWm5MWFRhM2drNkEw?=
 =?utf-8?B?SFZidXl3K2lScnFFaG1nR2hFam9yM0RMbTBaaUdPMjBuUjZZbGY1VFRpdUs4?=
 =?utf-8?B?NVRaQmpURnM3YWxGTkhwODYwSTdrWVRkdGFoYlBmUHVYZlRYZGljbVFNVmJZ?=
 =?utf-8?B?YTNRL3JxWXcwdnYzeVFLb0dIODhUbytHend6VDVvdHVMM1VuMlo0ck5YZzE1?=
 =?utf-8?B?L2gyWEVSbkhMOXZvTEtuQXFHdW9pVWh1bmFWYXA4RndFdE13R3pxamdXNmlC?=
 =?utf-8?B?MGNnZVA2ZUU4U0hLWDVmeE5DNGJSem5xMlZrMkdpd1pCdGk2OE9Wb0RMUUlK?=
 =?utf-8?B?YTlxUUsxQVBZT056OW9NWnpRbzZHRm1qcnBvRkNPQldPM1J6NVJlSXhOTWxE?=
 =?utf-8?B?NGQ2dUVscmI4d0RMTDdPRk5GazFIQVNPaHFoSmp0S1Z5WW9qRDFOcFdEdW16?=
 =?utf-8?B?UGVFMTVpeGZvVXhMdHJabFhLeE1TaHZWUWVvaU1nbjhrSzl0d1RxTG1IMXc4?=
 =?utf-8?Q?SJX9wT4SiYcYQ5He9R49opAGF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FQVx9RTnFLHLdor20yoDgsfTgrD33Z2PMQQN351UkrAVDk6IWU/MUwGFd4UFy4tPc5QQfXOCxE6CbuI01N4QfUirBGk8s78sk9CV5oCcPIQpp0hxS7VXa3cfEr1HHmBSq9KChhi4M9A20KT3oRTJGdN92G3ughrJAJZ1SaMRoaG5n/MDXIHW9z/4TfCLB8C885tJp7ej9mBYaZutU8lrpdRCfyeoChXAtyVeN/f174kO6uqdgUImCIEosxrRPUaHtHEVyIECnFYEQLboWrdPEaH6dlPWIpTD0MVbM7k6wQB5s/XPhD73f9uAheJDJhXo/YQN4EbI2SUq+E2mwY0TSrdPiJbReTGFoMkhKS/q3lwt4d6YMfR6tAEdDva4XbCJP8Px0xh8V4oXlVMsFhiOFY6cRQiP5dj1NofoMCxDVTlyhL4TVFROedhMellD7Vp3mIZebq3ZTknk5qT/7f08lJgRPRPsL75IPZhyT7Qpy14TFac9g8gkaat0fDauNHgncBGeIs2I6yLaHreLixPGNihy5BBI5aZRVn6fNevlya9Dtpp1oFgoKFBOxlWFQIPYfv73pIOCK5CZPN3p7sJDKik/+KwYgmOY7boKll67FN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5195ff-47dd-48ba-267f-08dd57395a7b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 14:16:40.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7Xd50TTDsCVHQLEDGeDrrgB275FImxNMponv/0gCgXz9AvO2iH8UgCVv12mTSQESoVHHQ5TQD40xSTmstRWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270108
X-Proofpoint-ORIG-GUID: GgY9pDM4soyTlQng9LB5Y6tmO80Wvh4i
X-Proofpoint-GUID: GgY9pDM4soyTlQng9LB5Y6tmO80Wvh4i

On 2/26/25 4:40 PM, Eric Biggers wrote:
> On Wed, Feb 26, 2025 at 04:01:18PM -0500, Chuck Lever wrote:
>> On 2/26/25 3:42 PM, Eric Biggers wrote:
>>> On Wed, Feb 26, 2025 at 09:11:04AM -0500, Chuck Lever wrote:
>>>> On 2/26/25 3:38 AM, Takashi Iwai wrote:
>>>>> On Sun, 23 Feb 2025 16:18:41 +0100,
>>>>> Chuck Lever wrote:
>>>>>>
>>>>>> On 2/23/25 3:53 AM, Takashi Iwai wrote:
>>>>>>> [ resent due to a wrong address for regression reporting, sorry! ]
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> we received a bug report showing the regression on 6.13.1 kernel
>>>>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
>>>>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>>>>>>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>>>
>>>>>>> Quoting from there:
>>>>>>> """
>>>>>>> I use the latest TW on Gnome with a 4K display and 150%
>>>>>>> scaling. Everything has been working fine, but recently both Chrome
>>>>>>> and VSCode (installed from official non-openSUSE channels) stopped
>>>>>>> working with Scaling.
>>>>>>> ....
>>>>>>> I am using VSCode with:
>>>>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
>>>>>>> """
>>>>>>>
>>>>>>> Surprisingly, the bisection pointed to the backport of the commit
>>>>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
>>>>>>> to iterate simple_offset directories").
>>>>>>>
>>>>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
>>>>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
>>>>>>> release is still affected, too.
>>>>>>>
>>>>>>> For now I have no concrete idea how the patch could break the behavior
>>>>>>> of a graphical application like the above.  Let us know if you need
>>>>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
>>>>>>> and ask there; or open another bug report at whatever you like.)
>>>>>>>
>>>>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
>>>>>>>
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> Takashi
>>>>>>>
>>>>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
>>>>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>>
>>>>>> We received a similar report a few days ago, and are likewise puzzled at
>>>>>> the commit result. Please report this issue to the Chrome development
>>>>>> team and have them come up with a simple reproducer that I can try in my
>>>>>> own lab. I'm sure they can quickly get to the bottom of the application
>>>>>> stack to identify the misbehaving interaction between OS and app.
>>>>>
>>>>> Do you know where to report to?
>>>>
>>>> You'll need to drive this, since you currently have a working
>>>> reproducer. You can report the issue here:
>>>>
>>>> https://support.google.com/chrome/answer/95315?hl=en&co=GENIE.Platform%3DDesktop
>>>>
>>>>
>>>
>>> FYI this was already reported on the Chrome issue tracker 2 weeks ago:
>>> https://issuetracker.google.com/issues/396434686
>>
>> That appears to be as a response to the first report to us. Thanks for
>> finding this.
>>
>> I notice that this report indicates the problem is with a developer
>> build of Chrome, not a GA build.
>>
>> If /dev/dri is a tmpfs file system, then it would indeed be affected by
>> b9b588f22a0c. No indication yet of how.
> 
> Just to confirm, the commit did change the directory iteration order, right?

Yes, the order of entry iteration changed, but I thought it was going
back to the way tmpfs iterated directories before v6.6.

Also my impression is POSIX allows filesystems some leeway in that
order, and thus apps cannot depend on it. Makes me suspect there's some
other issue, like offset_readdir() is skipping an entry somehow.


> The theory at https://issuetracker.google.com/issues/396434686#comment4 seems
> promising.  Just the exact code hasn't been identified yet.

Yes.


-- 
Chuck Lever

