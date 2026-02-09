Return-Path: <linux-fsdevel+bounces-76757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DwiLKKBEimk9JAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:33:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 308E0114797
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BDEF300BB82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5A2DB784;
	Mon,  9 Feb 2026 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gpbk4+qt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965F33987;
	Mon,  9 Feb 2026 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770669212; cv=fail; b=N8gWQPQfDeDHpGUn9Zl0/E3lfUPFrvybAAtNLtltvUV/NEWP0TMQEEC3SANFpT2piCjR+nolmJ0Wypdwd9nACT6bjj6VlDG8uaB4YS68Hq+VlMCFF2pg6tQDjM7hcVaa48Xqp3oE5jAiJgo/HJbnmhGcxGIRUOOfeS3j9zuNzxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770669212; c=relaxed/simple;
	bh=DPh2X5QObwj9yqwZXhcipddRdX4CYSr1rW98iQDxOoQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=f6a2mulHF8z6Nyn1VCx/jEXycu6ESeVzPFVS5B0RGQuo3gO6OyWiDWAFHDFgRT5F1rpCktoBNpKKwU+HCUV1BUIYKtjeOgq/cuzhrT2zg7jC5AnSmjnTz2dlGQ9VeRBWFVkH8N7rAqVikbBUb7d4eOGu5++ImQWPG0I/h3xt+rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gpbk4+qt; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619FYbGK239438;
	Mon, 9 Feb 2026 20:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=DPh2X5QObwj9yqwZXhcipddRdX4CYSr1rW98iQDxOoQ=; b=Gpbk4+qt
	I0SMXFOgicO5MOJWHZjmJAiRw3S3sGpyWjRi4cGU8EZffjeAnUQzHD3qrM+Njpj8
	9ssLsrF5Z2O5LB1gXumIDOt6+h+5Xxq+lWpFJkSq0+snijE9msC4el26ytDwvbP8
	2A9UdfXn/lTa2AkSLv/x5R6jU6tLQnf5JwG03Y+S9xXKoAMhp3f0ykcaRYY4y/RE
	ACxopRuP7NIkZnyvGGbxE6tYyaRjIWzkVJNdlNurShdVT2QSTqSmdONBVHZuTnZ8
	w4BdrQIiiK++pD/5vtQm35tVGwyiYG7YLEEgeh8Iuuq9HjHj/Mj63XYgaZT+TF23
	LkU6jh9DNCqa/g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uqhqy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 20:33:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0vWd6aM7nyLRTsLox+8HO7cRJBJ5w9RLPptQHrv6vMw5L6UWUlNwlqIGPQPrvlwAMU2WOJjn+41OGEJhDww8EgqBx1Hal/T0LwPbo0nh3gZKaZ22Pa1WLKmoo0+q4qZYMXgA951wtUXmRZetNi/Qh9Gev1P5XCCu147RluqVAtmT/kL2Ls48woevAZoeey3BAMX9cbG5+e+2TYS11ixbjIMIsvweAszNV7FPnFlQ1y6T2+41R7pHDDYXEwvMtVG7WSv0Q+UsedgsosAT8Fb9lm8JjINeKSTCLk9v/qXGCx0+oniYyOvUyU0VhGHYmHV7ZSdD3nZZHFzXWDkbnAXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPh2X5QObwj9yqwZXhcipddRdX4CYSr1rW98iQDxOoQ=;
 b=jtlcnJJFXnP5CBjq6y06298cVD5fYRayBuJ7rsYW0FDwcUQKIMSXrcei1X/lJPJ0tY1GVsjsHBeQbAtQC9nRsDwHKl4yHrPSh9lhEkiRleY/Acb6vsN8jjJdfj/+g9ChpCiR6Z3k7MoMBxEHqHWqguK7663Ft+gA3jtHJ2ZgZhtt3OMKimkkoI67MnwSJTA/R9rlj7SThuIrjTrM6PGUykDpD0UlY2/0Yyl6+/x1LtcM/EU0WRtPBohHj34unic8fDgy05MTkeurtB1vqoIMPppt/5s2DujdbzfeYiMlRlNG5FrSDj/6Ib+9WtM43CE6c6kFaqHtnkLq8sSJJYbXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV3PR15MB6411.namprd15.prod.outlook.com (2603:10b6:408:1a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 20:33:19 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 20:33:16 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "corbet@lwn.net"
	<corbet@lwn.net>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH v1 0/4] Machine Learning (ML) library
 in Linux kernel
Thread-Index: AQHcl7w/U0uwYm+xA0CfKDHQZtX7p7V61ymA
Date: Mon, 9 Feb 2026 20:33:16 +0000
Message-ID: <af90d545b2c74a406d38a6cf7aac61c7b7d90eb8.camel@ibm.com>
References: <20260206191136.2609767-1-slava@dubeyko.com>
	 <87343deawn.fsf@trenco.lwn.net>
In-Reply-To: <87343deawn.fsf@trenco.lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV3PR15MB6411:EE_
x-ms-office365-filtering-correlation-id: d2ffece4-6bfb-4d70-8341-08de681a7497
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGp6dTVPaCtvb21nWEFkaWc5dUZMR2VZQUFDY0hrNGdwVWVTcjVkaEhXR1Ru?=
 =?utf-8?B?b0hzTUs1cGtYTFBFZVNXSW5SL3duNlZtMG5sQklGQ1laNTlrQjFYSHk2RG5i?=
 =?utf-8?B?VUlhaE9oOHpzRzN3M1pSejZ2OC9DaHA4U0NxUE8zMTlQRDdXdVFXQVhwbnN4?=
 =?utf-8?B?dVQ1dEk5SEltWWxJbGplK3RzNDM3QXQ3L2oxZTFTc1ZXZ0FuWE9QYjZFdkhq?=
 =?utf-8?B?RlVMckVlK3NOaXVuUStTUWk1Y1RVcmZ1anhLTld3TXBOdmt2bERwWWlFaUZr?=
 =?utf-8?B?RU5PcEJCZWpqM0ErcThzSXdzQ2dsMk90a0ludUVMaFVJeFk4VktiWDg5d2ky?=
 =?utf-8?B?OHpSdlFoWVFpTUk0b3hCeEQrREZiS050UTQ0RWNEaTczKzJZcU5uSXlwazcx?=
 =?utf-8?B?aEFUcTBHRzZSbFN2NnovdjFzK24wT0cxMGlNNE9NSXgzc3d5WlkvNnQ2QU9T?=
 =?utf-8?B?UVNIVjVHY2FoZ3E0OFE3R2hmWUVaU0NGU3p6cnkvUXZCMFZhVUpzblJRVDhG?=
 =?utf-8?B?NDBMdkxZZGFvVHF3ZnRvQlFxSkx5S3JjT2FEdWhaLzhQT0JLa1dvVGJUdkw3?=
 =?utf-8?B?V1lqL1BkNXowdHducjlPaVNFdGR6TjN0eHhEZlorblFWWWNMaFpndlBrRWpO?=
 =?utf-8?B?VnEyWlF4a0lFN21CSEE1OTBEVE5CdGE1dW9CeTJsbE5nM1hKUVZRSTJIejZF?=
 =?utf-8?B?U0dOWkRkU0xKb21vMkJiT1EydHBZYXlGRXlOd25GaEtCMjFxRjVRMlVxYTk0?=
 =?utf-8?B?OFVXUUpVOXdQcU82OUx6R0pMZExmUkVBU04zYkwrdXMyWGxwWFo4djhCSDlR?=
 =?utf-8?B?bzk0QkNXOFlHdUFpTXBQZWZPbUNBVWNFZFc4bnRFZ3J3WE8yMUJYRjFqcEdD?=
 =?utf-8?B?Z09ISlk2bWxWeEtxWmRPWVdyaEkxcEhBMHRZV0N6OTVwRDVQcXdvTkUrZ004?=
 =?utf-8?B?cHhFRmcvZXE4cElBL2JHdlRiaTJtaTVodU5lblVZWXJ1ODU0bWJmeHB1cFIz?=
 =?utf-8?B?ZllJS0ViMFhLMkhEN0NKVDUzMjR6ZjVERGF6U3YzVUtKQTQwRjlkYVNzZkpJ?=
 =?utf-8?B?T3ZYYzBKSXFLSGVnVXR2NWhaS3RZSU5STFZOdm5WZDdtM1pMN2c3NFQ4d3lB?=
 =?utf-8?B?cDB6TEVoZGVNRXY2VVRJdWMyY2M3eE5Ic3U5dTJkNlFjLzhBRjhEMkRyZG9w?=
 =?utf-8?B?OHBDaC9PSWV2QXQrODdaUHRnY2dRZ1Q4UDl5bnJIZk5TVWJOalNFQUR1Yyta?=
 =?utf-8?B?eEJIUWI3aW41S3pTUGt5MzFEVktYTTU4MnJqS09mNE15K2lnV1NrTkVnZDAz?=
 =?utf-8?B?NEhLUFFkRGhSWG51b09DR0dybnVCa05vVVRGSUdzRGU4RjZSZHZObE1NMFdK?=
 =?utf-8?B?K2loQkVha0pQWG50WlVsUU82dC9YMkx1cEg4V0RieFZtMzlpUUczVTJKWWhr?=
 =?utf-8?B?TnpvakpSeFRHZzZad1FMME5pWU9XQ1N6b3BkWVhWaU50dFludTkyVWtNTVJT?=
 =?utf-8?B?c0dJblVCZTFDUTZ2VGQwWU1uRytkRDFvTzJReHNoUFRPVitCYms5T3R4U2N2?=
 =?utf-8?B?Z2JwWWlLVGpXR05xaVJZZjNMc3hweXIwWENsdmovTFNaME51SGhJTENuU3o0?=
 =?utf-8?B?QlovQ3A2dTJMMDluYmIxWGl0U1RqMHVSVmc4b1Ztays3MVpiT3hCTlROaXFT?=
 =?utf-8?B?dmh0NTd6MnBvZS9PN2oyTnlOOFRBQUV1SjAvd3pxT1I4SkRadFlQWGgzT1M0?=
 =?utf-8?B?bzdpY0Q1K0t6YUZCV2FZKzVGc3IrVVJjYUYxVlB6cVZFaUxtMVZueVltMUE5?=
 =?utf-8?B?bkxpTFd5VmxwcEJEY0E2ZXlHMG5uYWFEYUhiZURmOTN5bittVjVrZVZKUm5X?=
 =?utf-8?B?OTYxQ0V4aGJTSm9tWlhkTXNvTktDZTExVG5tYXFpSG9aYVFSTmRPZUdMVWQ2?=
 =?utf-8?B?NXpHOUtIdE85NlVvMDdPbHBwUWxxc01hbFA0Rzg3dU9yeGdvbjZOQnBuQmUx?=
 =?utf-8?B?aUlvS3lYcDlrTmZFUStocjdERG9GeG1oL0t2NDJMMTFURExhTzR4c0VyS2tM?=
 =?utf-8?B?MDB6d051VzYyQ24vYkh4RDRvL2pWaFZKM3VsUW9RUHhGVkJCN0M1T1hETFZj?=
 =?utf-8?B?L2ZaejBiMVJOdHBzRzE2UFF2dWl4aHc5cnBZNjloSTR1elZQcGFVMm5BNnRk?=
 =?utf-8?Q?frBuL+hgYh7PNd4P9H93+dU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzBuRGdEL3Vhb0tsQjNIMHVzVVRlczFuWE04a0VOK2R6b1JBNGxVS3NGMGZY?=
 =?utf-8?B?Vkp0OTdTMlI5OHloajZHTWRQcWhwenpNSWJHRXVZbko0RjlTM3JtY1p0V1ZC?=
 =?utf-8?B?dU9hdzljTWxLcmkvT0piWTM4alEvdW1lVm5qaHRaMFVNeUZOZXZtSGkxVXZz?=
 =?utf-8?B?ZTVoZ1dTMkUrL2huRUZlb3BsRExDQVZGeE0weGIrSy9nMGVCL2FXQjBHMHQw?=
 =?utf-8?B?UHZiUUkxSlpwNStyUE1uZXhOcjdrSmhZT3pibDVsR1NpVTZURUJ3eDNQZ3Fs?=
 =?utf-8?B?aEo1UzBKT1NJYU1kMFpsbVl3dGwwV1QrNHdPM2pvUUlDenJHcVlZbEpKSnJH?=
 =?utf-8?B?MXplK1Q3RkdNYUVyTHdjWmdkdVA2QTBjcWoxbXA0K0tSYzNlek5iUXBvdXBq?=
 =?utf-8?B?M1lYTnNta21MTyt4UHJITUs2WlVaN3FtMkFCeXVoMUF5THk1cXY1U0Z0WkJ0?=
 =?utf-8?B?WCtSYXpNZU5VeklrdTNDOWJXOHdUN04zK0tXRVFxZ28weXRYQ1FJczBGMFQ5?=
 =?utf-8?B?RW9yTlNPYkQrOVp5VzY2OVBaZmltUEhodjMxRCtqditpM21YMkRuSzBvOVBB?=
 =?utf-8?B?eHp3NnBDbVA1R3A0OVBwNlpiYUZSTmE4UDAwbEF2VEJzNUcvemZuZFQyUVVR?=
 =?utf-8?B?N0VEOU9OcmhFQ1BsM1pWYlZUMWluUWtMdG8wbXo5bVkrdWhzTlJKc0drRy9S?=
 =?utf-8?B?RzN0bE9iektOREdncTdQcitpdWpFUXROMnhrQ3ZmRzVISDM2MWRENlZ0bm0r?=
 =?utf-8?B?OUFRQWU1RElSV3hINHNDNkNxQXJyclVQNHBuWG5QVjRJNnhjKyszRC9tK1Fn?=
 =?utf-8?B?REo1NHBrM3pEMXRvSWhaOXZIM0NVUVd3OXZnOTk2SXdrM1A5dFhiSVFVblBt?=
 =?utf-8?B?bUtYNzhOTzQwU3hFL2hXV3E3OUFCWVk4TFFIa09BK0FSaEJNYUJUR2dnM3hn?=
 =?utf-8?B?UUt3eUsyK3hCVGpRUU9udk80Qm52eXY4N1E4T2pWcFkxQW9tNlNNclFXTTdq?=
 =?utf-8?B?QlgweUVaM0pia0sxNXM4VnJsL0RjUS9XNEhvUmlkdEpHV0o4SGRzTVBoWFJD?=
 =?utf-8?B?czk2VjlkZ0hyUHhWN29pNkVlNEtIcHlLSmFJN2pacFpHM0FWRUJhaXJpTTN4?=
 =?utf-8?B?bGFnWlNaK3VsdisyaFdOSXk2MldRTDRaSTFjRDlQMXBjV0tIYU1wQzl0b2pE?=
 =?utf-8?B?bzNWWjRYaW0vZmx1WlZlZWQ1L215b05XRGRhQnhYQTNuc0JKL1pacWNQMFVr?=
 =?utf-8?B?MzdaV0dDYlFwZTUrRWxXSlpqWlUyZTBacWlXb0dDNTFBUHM0MHAzalNFNUJx?=
 =?utf-8?B?eHJnS0VLVkt1OGpjWmk5dXlqN25QbHJZUVIwdzVoZGZ1LzQ0M1ZNd0R3TFJJ?=
 =?utf-8?B?OTg2aXB1dXN5T1hlSm5HTFFBemVHSGNPOXNMTEhGWkpGZlVzRWlDQWdYNGto?=
 =?utf-8?B?Q2lFNUVjSFkrelVxOUZjUXJWemdBV29XS2lWRHBrVzh1SkRQQmVMLzFGR1Ju?=
 =?utf-8?B?SHM4WDU4WlVEVnZYL2ZCMk5HQVdIOUZOV21ZQzdGOFcwcHNtdHY5WjVvSzRY?=
 =?utf-8?B?NWlKZjlMeFNqS1dpZGN5OG9JNnE2cXZXcFE0cElaT2R3TUxJamZjRE5PUS9U?=
 =?utf-8?B?NnZHUUt6RjArbmhFSlJlejNoWXlYdWxlMFlrY05GS0UwT2p6d0UzZFhHaVgv?=
 =?utf-8?B?WlZ1a1pkL1NNRXh0eXN4c2llKytSSC9lVGFVODJhUTNZNXlLMFo2MXpTczJ5?=
 =?utf-8?B?ejM2bXBSemk0Wjhlam5Gc0ZNaXgwUjQ5VWF1ZHVFd3U2RlQxNlBRWWpUT3p0?=
 =?utf-8?B?b1orcmFPNTZzUSt2T3RnZ3c3TDRDOWVZeHRReUpqMlU4RXBNb1hRYmoxcDRV?=
 =?utf-8?B?NC91djhHR0sybmxYdlhEclNNQUM1L3pVa1RDMTZFb0VvQ05NNFA5cWdGalNW?=
 =?utf-8?B?TzRzVmdxZ3FBRzVkb01hVW1xMzdmRjVqcTU0UEw2ZFhHNWV3Z2RkLytRSDVR?=
 =?utf-8?B?K0ZTT0pIQmlTUnRCdUZkc2xMWDV0Y2JieWVVSm1qNU1tRGQ1Sk5KQm45cGlJ?=
 =?utf-8?B?RlkyTVZ6VnBqdkQyTE1YbjZ0VHgrQ0hXTXcvY29uampVd2J0V3BYNm9namFU?=
 =?utf-8?B?YS9UMlBVM0JvNUpYRDFkS09TYTNxSlYwOW1zUGxPMkJuUHc5YUtaS29wckJ4?=
 =?utf-8?B?N1pOSkx5emVtZ0ZDMHNoSmw4MzFBd1dRSHk0WXlQeWlOSW4yUk1mYzJwZkhH?=
 =?utf-8?B?MXVLdnFQcDFna1NwZTdiaytMVDVNZnFzczBiYzJGOE12TkVlbythNE5oVjYx?=
 =?utf-8?B?eWkzVTR4cldRMjM3U3M4OU9tMm1HOFFHaTJGWlczVlVIUzlkM2hnVmI4ZkFy?=
 =?utf-8?Q?svXawj3hgD4fA0RHTjshJqcO6AvftcxNZcrPG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D94F316E73EBDE4694DA7A172206473A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ffece4-6bfb-4d70-8341-08de681a7497
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 20:33:16.7131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IAeo1afHQCrEZztdqJpLgaroqKsYjSMBLHHRA6HrxuY8gNUdZ6cB9OVOJs1t5RjNWvCORXc22z0DW3zraG7Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6411
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE2NyBTYWx0ZWRfX7bDNgTFyYNSz
 jPw2IgBBO/uho275V/qIdIbDOqomRevveUFvWVky6mcDTrvDyJQTy7hg5xYfuOYBkJmUjLtukub
 eHdxMTL8DBUIVm2U8aRTnMjs8bctx+sAObggEc2GNlDX5zFrEzTYBXi83TMBcQc6Kv6CEjgXvct
 hJy3aeszdtODSO6mlmXBaVIU5YD+qvgTO9aWOhfDaLkPVbX8TDii11F1bcBvaC6ibhodGbZOX6L
 rpmpDZHZXhtXyGixfUXNFR/vRmXVnW4XiqW8WEEU8ve76cGXxRBKrntFmflhpRlafDQtLr705t5
 IDY3cf3xgdz3/ROQMQkvpoFJVyGPugikz8prv7ToY7TaGy9J0cuUR6atFytYYNtthlur8SBAMnY
 8BGrDCxoaxPyOPIK+5NBPZi6aoVNRIgKjQ9/4v8e7WHViRVA4pu8y8STUW+UODhBa23J/YCyIY4
 YBf8PRoG2yTqMtYANbQ==
X-Proofpoint-ORIG-GUID: QQYnX1Cf6w4Iiu9PQSiDCAwKTF_-wqSt
X-Proofpoint-GUID: QQYnX1Cf6w4Iiu9PQSiDCAwKTF_-wqSt
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698a4494 cx=c_pps
 a=n6quz47VtcdWtWxmUgX64A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=wCmvBT1CAAAA:8 a=8EddwFpGMAP6Hhd92e4A:9
 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
Subject: RE: [RFC PATCH v1 0/4] Machine Learning (ML) library in Linux kernel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090167
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76757-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 308E0114797
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAyLTA2IGF0IDE1OjU5IC0wNzAwLCBKb25hdGhhbiBDb3JiZXQgd3JvdGU6
DQo+IFZpYWNoZXNsYXYgRHViZXlrbyA8c2xhdmFAZHViZXlrby5jb20+IHdyaXRlczoNCj4gDQo+
ID4gVGhpcyBwYXRjaHNldCBpbnRyb2R1Y2VzIGluaXRpYWwgdmlzaW9uIG9mIE1hY2hpbmUgTGVh
cm5pbmcgKE1MKSBsaWJyYXJ5DQo+ID4gaW4gTGludXgga2VybmVsLiBJdCBpcyBhbiBlZmZvcnQg
dG8gZGVmaW5lIHRoZSBNTCBsaWJyYXJ5IEFQSSBhbmQNCj4gPiB0byBlbGFib3JhdGUgdGhlIHdh
eSBvZiBydW5uaW5nIE1MIG1vZGVscyBpbiBMaW51eCBrZXJuZWwuDQo+IA0KPiBJIHdlbnQgbG9v
a2luZyBmb3IgdGhlIGRvY3VtZW50YXRpb24gZmlsZXMgLi4uIGJ1dCB0aGVuIEkndmUgYWx3YXlz
IGJlZW4NCj4ga25vd24gYXMgYW4gb3B0aW1pc3QuICBUaGF0IHdvdWxkIGJlIGEgbmljZSB0aGlu
ZyB0byBmaWxsIGluLg0KDQpZZWFoLCBJIGNhbiBzZWUgeW91ciBwYWluLiA6KSBJIHRvdGFsbHkg
YWdyZWUgdGhhdCBkb2N1bWVudGF0aW9uIGlzIG5lY2Vzc2FyeS4NClRoaXMgcGF0Y2hzZXQgaXMg
b25seSB0aGUgZmlyc3Qgc21hbGwgc3RlcCB0byBzaGFyZSBhbmQgZGlzY3VzcyB3aXRoIHRoZQ0K
Y29tbXVuaXR5LiBJIGFtIHNoYXJpbmcgdGhlIGluaXRpYWwgdmlzaW9uIG9mIHRoZSBpZGVhIGFu
ZCBBUEkgd2l0aCB0aGUgaG9wZSB0bw0KaGF2ZSB0aGUgcmV2aWV3IGFuZCBkaXNjdXNzaW9uLiBJ
ZiB0aGUgQVBJIHZpc2lvbiBtYWtlcyBzZW5zZSBhbmQgaXQgbG9va3MgZ29vZCwNCnRoZW4gaXQg
bWFrZXMgc2Vuc2UgdG8gcHJlcGFyZSBkb2N1bWVudGF0aW9uLiBJIGFtIHBsYW5uaW5nIHRvIGhh
dmUgdGhlDQpkb2N1bWVudGF0aW9uIGFmdGVyIGNoZWNraW5nIHRoZSB3aG9sZSBpbmZyYXN0cnVj
dHVyZSB3aXRoIGEgcmVhbC1saWZlIHVzZS0NCmNhc2UocykuDQoNCj4gDQo+IFBlcmhhcHMgbW9y
ZSBpbXBvcnRhbnQsIHRob3VnaCwgd291bGQgYmUgYSByZWFsIHVzZXIgZm9yIHRoaXMgZmFjaWxp
dHkuDQo+IFlvdSBtdXN0IGNlcnRhaW5seSBoYXZlIG9uZSBpbiBtaW5kLCBjYW4gd2Ugc2VlIGl0
IHRvIGdldCBhIHNlbnNlIGZvcg0KPiBob3cgdGhpcyBsaWJyYXJ5IGlzIG1lYW50IHRvIGJlIHVz
ZWQ/DQoNCkkgYmVsaWV2ZSB0aGVyZSBhcmUgbXVsdGlwbGUgcG90ZW50aWFsIHJlYWwtbGlmZSB1
c2UtY2FzZXMuIEN1cnJlbnRseSwgSSBoYXZlDQppbXBsZW1lbnRlZCB2ZXJ5IHNpbXBsZSB0ZXN0
aW5nIGRyaXZlciB0aGF0IGdlbmVyYXRlcyByYW5kb20gbnVtYmVycyBhbmQsDQpwb3RlbnRpYWxs
eSwgc29tZSBNTCBtb2RlbCBjYW4gYmUgdHJhaW5lZCBvbiB0aGlzICJtZXNzIi4gOikgQnV0IGl0
J3Mgbm90IHZlcnkNCmludGVyZXN0aW5nIGV4YW1wbGUuIEFzIGEgbmV4dCBzdGVwLCBJIGFtIGNv
bnNpZGVyaW5nIHRvIHVzZSB0aGlzIE1MIGxpYnJhcnkNCmluZnJhc3RydWN0dXJlIGZvcjogKDEp
IEdDIHN1YnN5c3RlbSBpbiBMRlMgZmlsZSBzeXN0ZW1zIChOSUxGUzIsIEYyRlMsIFNTREZTKSwN
CigyKSBNTC1iYXNlZCBEQU1PTiBleHRlbnNpb24gd2l0aCB0aGUgZ29hbCB0byBjaGVjayB0aGUg
d2hvbGUgaWRlYSBmb3IgcmVhbC1saWZlDQp1c2UtY2FzZXMuDQoNClNvLCBsZXQgbWUgbWFrZSB0
aGUgbmV4dCBzdGVwIGFuZCB3ZSB3aWxsIGJlIGFibGUgdG8gZGlzY3VzcyB0aGlzIE1MIGxpYnJh
cnkgZm9yDQpyZWFsLWxpZmUgdXNlLWNhc2VzLiBCdXQgdGhlIG1haW4gYXBwcm9hY2ggaXMgdGhl
IGNvbGxhYm9yYXRpb24gb2Yga2VybmVsDQpzdWJzeXN0ZW0gYW5kIE1MIG1vZGVsIHJ1bm5pbmcg
aW4gdXNlci1zcGFjZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

