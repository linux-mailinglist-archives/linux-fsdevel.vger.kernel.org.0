Return-Path: <linux-fsdevel+bounces-77618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HY4IycolmnxbQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 21:59:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 216EF159AFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 21:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0EDD3045E10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B0F349B05;
	Wed, 18 Feb 2026 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VShUNwIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FFE3491C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771448207; cv=fail; b=IN9EEqT++oSpijFzW+eSt7A+wpepSA+EGtBy4HmuzkvVQ/5eLpl5cbQtflbPLb6oRant4K7qACnQf1RQeMHmV7Zboo4Tngw3OvmIyiw8r5sYTbuTWnWpPgvC0K6XQ3GXZUrOLz1Qhu9UCExRrfWiDseoLnZEw/9PVy/iZxSSMT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771448207; c=relaxed/simple;
	bh=XAId9EQgjgwq5YeqQjRgg62t3fvvtP0O848CgO7yvF0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=JetTTioNQmx+ilbxd+Ah8Rja3Domz+zhNus1CvyYYqtArYnmmyvvgn9mNySXKfg0blh5CI3+cn8ZvqOWXl+8znmvXkyd8c/9xl7jyJZHsUX9FJlhDGZXlL9F/hmFzCiq+AKgh0xouH8PiJIE2iNifyoNonrbRsc32FkFXYLhIng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VShUNwIx; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IGRfNf2217750;
	Wed, 18 Feb 2026 20:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=XAId9EQgjgwq5YeqQjRgg62t3fvvtP0O848CgO7yvF0=; b=VShUNwIx
	Jz+q/XQx9zZHmc87deupn1RWWEZcp8VlPMU+XlFURyaa5llcqeJd8X4JJ0u36kW7
	HiDjCHj5eO6dC0lP1+fBNWcUndBHP5BPEjHSTMBYXerKTPexEox3ZIJ8TWSYBEix
	DboE3w3eliUla2E6ojYrHU7yKnNmP6CTFQwHq+pEZ5iaMCrOfXTT9IdVGdNqbc7V
	0ycVIiRAPJlPHStbcxhPhTQk689OzDC70DyGhXc+O/Y+H/zBT2i6I0m205yY4dlj
	Qtcv7jNt/k3d00nQ33AORk/xH2U75TiZC3IFnwtLApLDzFTFvQe6nJK4bwk4yg9I
	ufcTv6RjmBuImg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcr36pq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 20:56:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTLM71MFxdEA6cvGlS9PxhLUbheZwKGlSrHPWGdMRsjGBROGMATNzCk2onPD0i8ugdblgKOvSe+C/r0z3PU0VtTULT2l8oaDzo3882xkJJFaYnSvxacnpA0Ff26dm6qsVklICjhlCJMJ6yE4w5tqdSWDx6P/J+TsIhoERQMEnPlHWTR9H+QS71L4RJm3dLlIqafFGZpEbKTGq9o9X7shHVTJY8LTemfX3jGDo40pzLhn2s8aEQUJGv+SqdkvsTzKbv5iUrPUnSb6lsD58iUmTnA+TrfTvdE8GhUSyCZvYuHw6fpm72kplP8UMKnOGk/gWQuxtcFc0bsBf6h8tmXWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAId9EQgjgwq5YeqQjRgg62t3fvvtP0O848CgO7yvF0=;
 b=NL98CMdEi7SpG9R85rppF7jFkhv1g/CJXe6YwTsc48vyuOD3zYaEzjGTD36+lJL5F0RUf8aBeK37ytsHhojSbiDisgMoKEwElqoyElpvv0ypvyMnpWZLEuzRFDkR22zWUxU+3BL6OzYQYWZ0GwEmdP7mgowtTiU1OO6d7CRG03SIOpueFwIy9qMrpeTZmED9J7MYHWCEGKHZdrbykrH1HMqDtNWRi6LQVFIj0OlrcDoM6cvqgbKF+D2/z6+7Mwzv+aJcTVFKiFzU1JVm2KSwhwNqDvuafsAOPrKptoA+2fL0vdcATcRQD7Miyb224iSdk59ZlHAvlHxpJsXcPRsNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB6478.namprd15.prod.outlook.com (2603:10b6:610:1b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 20:56:28 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 20:56:28 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "charmitro@posteo.net" <charmitro@posteo.net>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs/hfsplus: fix timestamp wrapped issue
Thread-Index: AQHcn7avK7OIubRA4kGw9zI5SLiJRLWHMl0AgACC1oCAAT14gA==
Date: Wed, 18 Feb 2026 20:56:28 +0000
Message-ID: <15b8136f279abd8320e2d4745a4f1e76c9f9aa83.camel@ibm.com>
References: <20260216233556.4005400-1-slava@dubeyko.com>
		<87a4x8f5zq.fsf@posteo.net>
		<2b7b7a970926f56a3742cb76e394e9fb3d79b0eb.camel@ibm.com>
	 <m2bjhn81n2.fsf@posteo.net>
In-Reply-To: <m2bjhn81n2.fsf@posteo.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB6478:EE_
x-ms-office365-filtering-correlation-id: abd60c12-44b2-473d-5ffc-08de6f302fac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWVRUlYxNnhJaTNpZFZMNlpZdmpZb0pEczQ3OGlPWWpNdUd0ajNiYkVsSHFN?=
 =?utf-8?B?dUlxYUE3bUltaHoxNGRzV3Z5NWl2L0ZzNHpVOWRaTGZqNlFDaEF2YXJseU15?=
 =?utf-8?B?UW14dFdtYk05RlExbjlOcUxtYzkwNjRsbmNvRFduODVIVy91Q0ZFM3g1NEV1?=
 =?utf-8?B?UXNzOGEwQzR6bUFWWEU3VzdvbnlkZVZhREc3TkVtbzlhNVoxSjJXV2lSMVBz?=
 =?utf-8?B?eDhFOEVEbUVLZUVIT1JteEN2QTcwT0ZZcUNPV2VTbWllYllLR1JxaVVjamlz?=
 =?utf-8?B?M3p1bjI1NDlRd1dQNHZ1NGFkbG5uVFVVeWJ2azdWa3krYVZPOWJFRHVDSkdW?=
 =?utf-8?B?SGxMZEFCdVZtNnBwT05yN1FVWWYzVGhUZ0lMZk10Q0JWeGd3VmEzblUzYmZQ?=
 =?utf-8?B?bUdScHdEVmVsQjgvaXdDczluM0ZpblFMTEJlRTcvSjZTRHpIWStLMm9mNnNi?=
 =?utf-8?B?Y3BMcXptSzYvcGNRQU8zTmNyd0JKUmZvUFR1KytBcVQ1dkErTk1rZVV3c0Rl?=
 =?utf-8?B?UCs0cWg5bm1tOW1sNnJuV3VVK0J3MkxiYXgrMGM3Q3pTOVFzbDNhdFI1UEhn?=
 =?utf-8?B?TW9rOFBFMkg3WStYZ1ptUzRpUE54bTNHejE4WFJqZkF2bzhybXFzOUtXd2U4?=
 =?utf-8?B?ZE11emZ2blJQYWlRMklaUm5Hd0FPYU9RZnNFVG0rNDc3SlNidjB0MmxDZ29p?=
 =?utf-8?B?YnYrb2I2WDgxL2lkcVYya1dQdjZsZFZTQkI0SjB3ZjhocDUyMTJPd1NhRXA4?=
 =?utf-8?B?WHZvTjVOeTNvNno5SzNjYStVK0FDK2pCWG15ZDdrZ1B3a2M3TFlnajNYU3Nk?=
 =?utf-8?B?U2dyUTNBSEhRSlBDekJmcHJ0MXE1SXVJQkR3RGxCVXFYcDI4ZEJscFVlUW1H?=
 =?utf-8?B?WkdMZVUrbmNNY0FIS1FXK2NWYjR6S21ROFA0eklQL0UyMG9zenBPeFBVWGZz?=
 =?utf-8?B?NzQwVjB0NVlmK1pJU1RLbndpMThIb1ZCNHdTVEZyOTNwTS9WaTl2czJDWjRr?=
 =?utf-8?B?YjhuY3FkTVdwYmVQejBMbVV4OXRjT3YxUk5PRThaeVJuZFdpQ0hlanlaVktZ?=
 =?utf-8?B?WFlsaHM3YmlhM0ZOYVc5YVBPbXU0d2N5L25qa3JaRFcvUDc2N2czNkxSVGcz?=
 =?utf-8?B?Y3Z3am9sZlM3SXh1MkRCWldraHhpeHJVNnMyb0FabFl1QnVRT09BTEJGQ2dY?=
 =?utf-8?B?MXJrZlRuQkVseGtKck40YXowU3cwZHBxQXliNm1pWkZoNlhpRFM3bGhMYndT?=
 =?utf-8?B?U0lQTmdSc2tpQWU0ZmROU0pxbW5IY2ZicDMyZFBsVWsvcmNsZVUyeENqY0hV?=
 =?utf-8?B?UWROK1htUG42SzgzeVAwRUZHaktmcE14MmFQdmdKSEI4VkNCK0VodkhCbGV5?=
 =?utf-8?B?bmFtNWd0dUVqRk9ydk5oQVdtM09yQkk3Z0lrc2xEN3dmYnhWbDV4ZVYzVWdW?=
 =?utf-8?B?NUFiRlRDK0k4am1mOE9xeFZ5VHNWbThDQWE3RkVaWDZubG8yQUZJMk5ZM0J4?=
 =?utf-8?B?eHlFeStrbm9DTEptZU90Y2NZcjZaZVBVYzNoUnRrTkRqRHpqSzA1dU53Mk5o?=
 =?utf-8?B?WXlxYWh4MTF3ajcvSWFCY2s1NWJZdXphZzdZWWZMbnZNaWJTSlpiSEFxQmxv?=
 =?utf-8?B?djRSZ1UzTUg4MmlpWkpGczQyamRlMEd1YUVjck9nY0ZQQTMvVDRKdFQwYzBu?=
 =?utf-8?B?RjJDa1ovcHQyNFAybDZRVkZzVWQyckh1VHN1dmRwclBmREdMK0V4cHJMenZ3?=
 =?utf-8?B?NVFybExaZGJQbGcyNHdIL2tHcXRFSkIwOGc2QTlOVTdHVDRjOVFTWWo3dEVj?=
 =?utf-8?B?c3g1cTArUlVmZndGd3lVdHViaU85eFcwQ1dvQU51Ry93STBEcE1ISTdOLzBY?=
 =?utf-8?B?QU1FMUN3aEdENkRWRFUramZ6VGdtNTV6VURyZXEvVkJOQWpMTTNRVFZydDJV?=
 =?utf-8?B?T3V5VndNb0hBQXcxbzJOcFFNVXhNa3dwSENZNllpSklDODE5VjRUVHVsOTlZ?=
 =?utf-8?B?NjcvRjF6MEV0TkhUelBSN3dqRk1qcXZWYmVOWTNGQWNhcllBRVdCM1R1RXBG?=
 =?utf-8?B?anN6VGp3Vk5qeW5KOHo0UmEvbUM0T211R1F2eEt6ZmZhS3liNjlwT1hHanZP?=
 =?utf-8?B?T0hKQzhhS2dURSt1V3RLdHNGTDZEdk43WU52cVpBZG5QOEdDQS9RcHhNTExm?=
 =?utf-8?Q?Okj7NCU0Pz3v7obCpYHOIeQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFN4N2lFK1F3cHlrcjJhdkYzZUJCbzBaUjRIKy90SkVxN3NpT01tOEpjbUJC?=
 =?utf-8?B?WldwZHN4MTZUb3ZBQXpJcDNYcU96dWdtK3VZU0h5ditrdXhuQlJ0dFNzYmxj?=
 =?utf-8?B?RWFLcVFXMS85dmlSTzlpOUhiMWFQWVRZTHFRL2tnNjRNVGhyUmYxbXR6aDUx?=
 =?utf-8?B?NTNDK0JxM05qSmx0QWZ4Y1NuVWRLYmorT0F5YTJvZmVhcHFmd0RUQndhT2Mw?=
 =?utf-8?B?RFcwYjVidmRmdzlscjdGbjRhUW9sdVF5TTlrRmo1VTlnV1IzZ016aGg3M2FN?=
 =?utf-8?B?Y0x2ekl2ODVYRmFBNlhTOEg4UkJyUThrbVZNL0tWVXI2dWxvUy81TitjYlZh?=
 =?utf-8?B?V1RNb1VZSWJuOU1IaGxXRUo2THU3aDVLajJ5bjdNb1pIWDk5WCtNVExtSWpT?=
 =?utf-8?B?S3piQjlxL1JKOFlLNGVyY1NkbXpYYm54UFg4d2pPYmxCVm8rZlo1a1JXN2tn?=
 =?utf-8?B?S1l2bzFubFZYNWY2end2bzROUWEwRDk5amlWNkhCYUozdTlia3h2YTh6ajBK?=
 =?utf-8?B?NHlYRjZtWXZadGdzN3YrbCtoK2dxWXN3ZDhiaEFJaVVpN0ZTZmVrR1hIVytF?=
 =?utf-8?B?S3NCcFpaa2I5b2pDalJTT3h5ZDREU1pFOVlMWnozd0huRVMxZ1hzYWcrTFhY?=
 =?utf-8?B?M0EzbDFybkV4a1d4d1dyNysvR1JTZXdkYy9KVTQwKzM4NmV5dFdwT2dTTjJa?=
 =?utf-8?B?VkpDOWFwQ2RlZTYzS2g1aUFzcFNxMGdkV3dRRzBGRFB3aURwZ2FJb0NxSEMr?=
 =?utf-8?B?aHpwV1NSd3hMNXVta21HSGV4QzVjcjJMMXdET09UbGVWazR2WXRtQVNtejV4?=
 =?utf-8?B?eUtEcVVDd0lHVUU4R1JBZlJmT0hmOG11Q1EwM1ZQRFNQL2xITVd3am4wQTVG?=
 =?utf-8?B?bHpwNmg2Q2tVdWtIQytOWGVaVk1aVnVzMEMzVEZ0NHJvd2FITmJJNFdRajA5?=
 =?utf-8?B?dHVLbkNGTkZXbmlOY0xvVGVvUzBpRlY2S1JUTWc2RXNDTVhUM055Wkx0b2FX?=
 =?utf-8?B?ZjNxdGR6cVQ3VkdrNTVlUy95TlZTd0VNcWRnOWU0UG5aSVJNL0YzZS8zN3Y1?=
 =?utf-8?B?YXFXR0FJMU9FcGNPMnN3SW55LzRTditVekROOTBTYTlZbGI5UHkvQXd0UXls?=
 =?utf-8?B?QXEwRGFnZlRJQTZqZHlPblBMNktBTjhxMUwzdldxckRFL1phQTg4T29qSXBq?=
 =?utf-8?B?TXk5QVBXd3hOYmJPZDhTdXMvclAyRGJPOHpnYm9BVDZFeThhYVI4T0MyYnhH?=
 =?utf-8?B?dWNpQjRScElsM3pGQ3RaTkZQR2x0RkNLZXk0b3cyUStvaE5va0g1ZVpYcCta?=
 =?utf-8?B?S28wRDJYK0l5aDFmYjRPdUpQZTMyVHNXN3BlT3J2Yjh0NVhvcnM3UUJDcFl1?=
 =?utf-8?B?clVlUW05MTNscG9qT2VVcUF6ak1NTEtSS1hnOUxBMWludUo0c1dFbnA4Smo2?=
 =?utf-8?B?bEFZRFJSOXdGRXcwbDdWa0psTCtMc3VUMHh1WDdCUkFIOExoQ1hyUWhtbmRV?=
 =?utf-8?B?T25BbzNidk1BTTFXQXFKU3Zac1piS3Fxc1RLYjRJcW56SWwzWXpCeFRNYW45?=
 =?utf-8?B?Y0hqaHIxOHdxZHFteG5Ic3h6bHd3bUFZSHZVbDFHZ2V3YlZoNTdSWjlxbEVJ?=
 =?utf-8?B?K25pMDJuU2FBdUtSUFdsKzlnZFpNR05DRVppRnk3dW9CbURCczRGT2xLMmxH?=
 =?utf-8?B?bjhPekMrYi9HanZpTFc5MzdmN1lKc3BycU0reGdwMlhTVm9FSk1JTFVjQUg3?=
 =?utf-8?B?YWY1R3kvam1FRUpWSzBLejZUcVpSK0RsOWZhRXhSTHNMWmY2N1BsdGZIRy93?=
 =?utf-8?B?RjdYS1lvT2FSdmd4NWpkZDhkS1J6Vmc4WU1NZ3pDWUJZTjR0aWxIc0dzcHVa?=
 =?utf-8?B?Z3greVp4R3FIbFQyQUlMUlF2T3dvVnJ3UnJXek81YnRaeUVabStoQ0U2WEpH?=
 =?utf-8?B?YkpFSmFLck5YWE1neE1FU21UTTI3NldTTVBvYlJBeEJjWHhsTklORlphT3ha?=
 =?utf-8?B?WVBkZGxsdGZkMFhYZVlQdG1Lb25oV1lReFg3bnlBZHZGU0ZtYWxXeGZNSXh6?=
 =?utf-8?B?NWUrT3haUWpVb2VxQmFTTnVFTkNDSFRZUlg5Rkc1RUxpR1k5c1FVdkJLSlZs?=
 =?utf-8?B?a0NZNzZZU2d4N2tsSDZmdmZWZml3MWU1QTBXanR5UGdEOG5uK2kvTlJxNG83?=
 =?utf-8?B?TXhMaVcvM2ZxQ1JndmxJMmlvalJPVGNrdFpNK09OZmwySXE4QjcyYXdQNzd0?=
 =?utf-8?B?MHJuRFFsZERVUm5wNWFoMFgxckU1ZDZ5cE5zNCtCdUJxZDdESUlKSHlrKzJF?=
 =?utf-8?B?V09STkQ4bjFYcHhBa1VWcWNqSnZsMVJtQ01IR0dqTGt5d21qQXBFMlRJbXc5?=
 =?utf-8?Q?STnmS6VnVMhBaCGndX+yHnHrIiQWlYX4WeMZd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0094747438B9CB458BDBDA7C4B5930C2@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: abd60c12-44b2-473d-5ffc-08de6f302fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 20:56:28.0982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEufXU7b3TRNi7ioXdtWQkCaWF25R/jpY1XNhTM5+iHTN4onFkvllxl/Po1gojBHGtryKwxzg+orroS3Nxl5kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6478
X-Proofpoint-GUID: SfcaJ1DWqHwCBM2_0vmQb3jQXONboKPm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE3NyBTYWx0ZWRfXxSTemy7Jatb7
 S9D8hSNuCBINP0AFHdFKffI0kzFO6sarFUdx1w+2kXMpf/+N4fq01qWQRg5yijk2rx0YFQt/KwA
 OowH2ZXWigruCs2ibwpDwpGznJNGnXQLag+/pZR/zYYzOPjZZ1KjF7rp8qs9jMFA5kVPyTmdU7j
 a7K+0U+6vEMJV2q9jtuVMvlZQG0Xuf+pc+W8TTvi/0yRYkoMLur3hOUEjnU79TpyncxJXBbKExF
 UrJkI7OYgGQiLF9+ddUaGv/kWfV4NnM6PGQVQVzBCar7iLqmYTv4/tvcH0D8RBTtq5F3DSL5r9q
 1+PKoKm4Flr9TSJsBDgk8S1EL3kackexCQWPasghZzG1n7RyaJhe7XVhWv0ekgqdd4pvqG0z0n/
 qvMeRxzT1i3422RHgGRwpvCcYDazwZN+hEEgF41NB3OUbkTaLTzDb/X3fn4R8LJd0Fx4+sZ7WvP
 bYeiqPnC1z5vARY1bjQ==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=69962780 cx=c_pps
 a=PxTiP5NnQLoflLcDylFrfg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=wCmvBT1CAAAA:8
 a=1WtWmnkvAAAA:8 a=VwQbUJbxAAAA:8 a=r5Ix1k3T6i3GlxaHQ68A:9 a=QEXdDO2ut3YA:10
 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: SfcaJ1DWqHwCBM2_0vmQb3jQXONboKPm
Subject: RE: [PATCH] hfs/hfsplus: fix timestamp wrapped issue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180177
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-77618-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,proofpoint.com:url,fu-berlin.de:email,dubeyko.com:email,vivo.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 216EF159AFB
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTE4IGF0IDAyOjAwICswMDAwLCBDaGFyYWxhbXBvcyBNaXRyb2RpbWFz
IHdyb3RlOg0KPiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3Jp
dGVzOg0KPiBYLVRVSUQ6IExIZlFPakwvVCszaQ0KPiANCj4gPiBPbiBUdWUsIDIwMjYtMDItMTcg
YXQgMDI6MzkgKzAwMDAsIENoYXJhbGFtcG9zIE1pdHJvZGltYXMgd3JvdGU6DQo+ID4gPiBWaWFj
aGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPiB3cml0ZXM6DQo+ID4gPiANCj4gPiA+
ID4gVGhlIHhmc3Rlc3RzJyB0ZXN0LWNhc2UgZ2VuZXJpYy8yNTggZmFpbHMgdG8gZXhlY3V0ZQ0K
PiA+ID4gPiBjb3JyZWN0bHk6DQo+ID4gPiA+IA0KPiA+ID4gPiBGU1RZUCAtLSBoZnNwbHVzDQo+
ID4gPiA+IFBMQVRGT1JNIC0tIExpbnV4L3g4Nl82NCBoZnNwbHVzLXRlc3RpbmctMDAwMSA2LjE1
LjAtcmM0KyAjOCBTTVAgUFJFRU1QVF9EWU5BTUlDIFRodSBNYXkgMSAxNjo0MzoyMiBQRFQgMjAy
NQ0KPiA+ID4gPiBNS0ZTX09QVElPTlMgLS0gL2Rldi9sb29wNTENCj4gPiA+ID4gTU9VTlRfT1BU
SU9OUyAtLSAvZGV2L2xvb3A1MSAvbW50L3NjcmF0Y2gNCj4gPiA+ID4gDQo+ID4gPiA+IGdlbmVy
aWMvMjU4IFtmYWlsZWQsIGV4aXQgc3RhdHVzIDFdLSBvdXRwdXQgbWlzbWF0Y2ggKHNlZSB4ZnN0
ZXN0cy1kZXYvcmVzdWx0cy8vZ2VuZXJpYy8yNTgub3V0LmJhZCkNCj4gPiA+ID4gDQo+ID4gPiA+
IFRoZSBtYWluIHJlYXNvbiBvZiB0aGUgaXNzdWUgaXMgdGhlIGxvZ2ljOg0KPiA+ID4gPiANCj4g
PiA+ID4gY3B1X3RvX2JlMzIobG93ZXJfMzJfYml0cyh1dCkgKyBIRlNQTFVTX1VUQ19PRkZTRVQp
DQo+ID4gPiA+IA0KPiA+ID4gPiBBdCBmaXJzdCwgd2UgdGFrZSB0aGUgbG93ZXIgMzIgYml0cyBv
ZiB0aGUgdmFsdWUgYW5kLCB0aGVuDQo+ID4gPiA+IHdlIGFkZCB0aGUgdGltZSBvZmZzZXQuIEhv
d2V2ZXIsIGlmIHdlIGhhdmUgbmVnYXRpdmUgdmFsdWUNCj4gPiA+ID4gdGhlbiB3ZSBtYWtlIGNv
bXBsZXRlbHkgd3JvbmcgY2FsY3VsYXRpb24uDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHBhdGNo
IGNvcnJlY3RzIHRoZSBsb2dpYyBvZiBfX2hmc3BfbXQydXQoKSBhbmQNCj4gPiA+ID4gX19oZnNw
X3V0Mm10IChIRlMrIGNhc2UpLCBfX2hmc19tX3RvX3V0aW1lKCkgYW5kDQo+ID4gPiA+IF9faGZz
X3VfdG9fbXRpbWUgKEhGUyBjYXNlKS4gVGhlIEhGU19NSU5fVElNRVNUQU1QX1NFQ1MgYW5kDQo+
ID4gPiA+IEhGU19NQVhfVElNRVNUQU1QX1NFQ1MgaGF2ZSBiZWVuIGludHJvZHVjZWQgaW4NCj4g
PiA+ID4gaW5jbHVkZS9saW51eC9oZnNfY29tbW9uLmguIEFsc28sIEhGU19VVENfT0ZGU0VUIGNv
bnN0YW50DQo+ID4gPiA+IGhhcyBiZWVuIG1vdmVkIHRvIGluY2x1ZGUvbGludXgvaGZzX2NvbW1v
bi5oLiBUaGUgaGZzX2ZpbGxfc3VwZXIoKQ0KPiA+ID4gPiBhbmQgaGZzcGx1c19maWxsX3N1cGVy
KCkgbG9naWMgZGVmaW5lcyBzYi0+c190aW1lX21pbiwNCj4gPiA+ID4gc2ItPnNfdGltZV9tYXgs
IGFuZCBzYi0+c190aW1lX2dyYW4uDQo+ID4gPiA+IA0KPiA+ID4gPiBzdWRvIC4vY2hlY2sgZ2Vu
ZXJpYy8yNTgNCj4gPiA+ID4gRlNUWVAgICAgICAgICAtLSBoZnNwbHVzDQo+ID4gPiA+IFBMQVRG
T1JNICAgICAgLS0gTGludXgveDg2XzY0IGhmc3BsdXMtdGVzdGluZy0wMDAxIDYuMTkuMC1yYzEr
ICM4NyBTTVAgUFJFRU1QVF9EWU5BTUlDIE1vbiBGZWIgMTYgMTQ6NDg6NTcgUFNUIDIwMjYNCj4g
PiA+ID4gTUtGU19PUFRJT05TICAtLSAvZGV2L2xvb3A1MQ0KPiA+ID4gPiBNT1VOVF9PUFRJT05T
IC0tIC9kZXYvbG9vcDUxIC9tbnQvc2NyYXRjaA0KPiA+ID4gPiANCj4gPiA+ID4gZ2VuZXJpYy8y
NTggMjlzIC4uLiAgMzlzDQo+ID4gPiA+IFJhbjogZ2VuZXJpYy8yNTgNCj4gPiA+ID4gUGFzc2Vk
IGFsbCAxIHRlc3RzDQo+ID4gPiA+IA0KPiA+ID4gPiBbMV0gaHR0cHM6Ly91cmxkZWZlbnNlLnBy
b29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19naXRodWIuY29tX2hmcy0yRGxpbnV4LTJE
a2VybmVsX2hmcy0yRGxpbnV4LTJEa2VybmVsX2lzc3Vlc18xMzMmZD1Ed0lCQWcmYz1CU0RpY3FC
UUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVn
U3MwMCZtPTBmVC11TDU2T1BuZGlTM3ZpTzB0YklvZkRoY2U3bF9EdnFYMklnNWUxMUU5c1JHU1pI
ZXNMdmdwR3ZhRUdwdmomcz01MnJDM1RYTEtXejhhck5LWk15U0R4LXZ3bXM1ei1NZDBibnZQNnRH
a0VNJmU9IA0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVmlhY2hlc2xhdiBEdWJl
eWtvIDxzbGF2YUBkdWJleWtvLmNvbT4NCj4gPiA+ID4gY2M6IEpvaG4gUGF1bCBBZHJpYW4gR2xh
dWJpdHogPGdsYXViaXR6QHBoeXNpay5mdS1iZXJsaW4uZGU+DQo+ID4gPiA+IGNjOiBZYW5ndGFv
IExpIDxmcmFuay5saUB2aXZvLmNvbT4NCj4gPiA+ID4gY2M6IGxpbnV4LWZzZGV2ZWxAdmdlci5r
ZXJuZWwub3JnDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZnMvaGZzL2hmc19mcy5oICAgICAgICAg
ICAgfCAxNyArKysrLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiAgZnMvaGZzL3N1cGVyLmMgICAgICAg
ICAgICAgfCAgNCArKysrDQo+ID4gPiA+ICBmcy9oZnNwbHVzL2hmc3BsdXNfZnMuaCAgICB8IDEz
ICsrKystLS0tLS0tLS0NCj4gPiA+ID4gIGZzL2hmc3BsdXMvc3VwZXIuYyAgICAgICAgIHwgIDQg
KysrKw0KPiA+ID4gPiAgaW5jbHVkZS9saW51eC9oZnNfY29tbW9uLmggfCAxOCArKysrKysrKysr
KysrKysrKysNCj4gPiA+ID4gIDUgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMjIg
ZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvaGZzL2hmc19m
cy5oIGIvZnMvaGZzL2hmc19mcy5oDQo+ID4gPiA+IGluZGV4IGFjMGU4M2Y3N2EwZi4uN2Q1Mjll
Njc4OWI4IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9mcy9oZnMvaGZzX2ZzLmgNCj4gPiA+ID4gKysr
IGIvZnMvaGZzL2hmc19mcy5oDQo+ID4gPiA+IEBAIC0yMjksMjEgKzIyOSwxMSBAQCBleHRlcm4g
aW50IGhmc19tYWMyYXNjKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQo+ID4gPiA+ICBleHRlcm4g
dm9pZCBoZnNfbWFya19tZGJfZGlydHkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYik7DQo+ID4gPiA+
ICANCj4gPiA+ID4gIC8qDQo+ID4gPiA+IC0gKiBUaGVyZSBhcmUgdHdvIHRpbWUgc3lzdGVtcy4g
IEJvdGggYXJlIGJhc2VkIG9uIHNlY29uZHMgc2luY2UNCj4gPiA+ID4gLSAqIGEgcGFydGljdWxh
ciB0aW1lL2RhdGUuDQo+ID4gPiA+IC0gKglVbml4OglzaWduZWQgbGl0dGxlLWVuZGlhbiBzaW5j
ZSAwMDowMCBHTVQsIEphbi4gMSwgMTk3MA0KPiA+ID4gPiAtICoJbWFjOgl1bnNpZ25lZCBiaWct
ZW5kaWFuIHNpbmNlIDAwOjAwIEdNVCwgSmFuLiAxLCAxOTA0DQo+ID4gPiA+IC0gKg0KPiA+ID4g
PiAtICogSEZTIGltcGxlbWVudGF0aW9ucyBhcmUgaGlnaGx5IGluY29uc2lzdGVudCwgdGhpcyBv
bmUgbWF0Y2hlcyB0aGUNCj4gPiA+ID4gLSAqIHRyYWRpdGlvbmFsIGJlaGF2aW9yIG9mIDY0LWJp
dCBMaW51eCwgZ2l2aW5nIHRoZSBtb3N0IHVzZWZ1bA0KPiA+ID4gPiAtICogdGltZSByYW5nZSBi
ZXR3ZWVuIDE5NzAgYW5kIDIxMDYsIGJ5IHRyZWF0aW5nIGFueSBvbi1kaXNrIHRpbWVzdGFtcA0K
PiA+ID4gPiAtICogdW5kZXIgSEZTX1VUQ19PRkZTRVQgKEphbiAxIDE5NzApIGFzIGEgdGltZSBi
ZXR3ZWVuIDIwNDAgYW5kIDIxMDYuDQo+ID4gPiA+ICsgKiB0aW1lIGhlbHBlcnM6IGNvbnZlcnQg
YmV0d2VlbiAxOTA0LWJhc2UgYW5kIDE5NzAtYmFzZSB0aW1lc3RhbXBzDQo+ID4gPiA+ICAgKi8N
Cj4gPiA+ID4gLSNkZWZpbmUgSEZTX1VUQ19PRkZTRVQgMjA4Mjg0NDgwMFUNCj4gPiA+ID4gLQ0K
PiA+ID4gPiAgc3RhdGljIGlubGluZSB0aW1lNjRfdCBfX2hmc19tX3RvX3V0aW1lKF9fYmUzMiBt
dCkNCj4gPiA+ID4gIHsNCj4gPiA+ID4gLQl0aW1lNjRfdCB1dCA9ICh1MzIpKGJlMzJfdG9fY3B1
KG10KSAtIEhGU19VVENfT0ZGU0VUKTsNCj4gPiA+ID4gKwl0aW1lNjRfdCB1dCA9ICh0aW1lNjRf
dCliZTMyX3RvX2NwdShtdCkgLSBIRlNfVVRDX09GRlNFVDsNCj4gPiA+ID4gIA0KPiA+ID4gPiAg
CXJldHVybiB1dCArIHN5c190ei50el9taW51dGVzd2VzdCAqIDYwOw0KPiA+ID4gPiAgfQ0KPiA+
ID4gPiBAQCAtMjUxLDggKzI0MSw5IEBAIHN0YXRpYyBpbmxpbmUgdGltZTY0X3QgX19oZnNfbV90
b191dGltZShfX2JlMzIgbXQpDQo+ID4gPiA+ICBzdGF0aWMgaW5saW5lIF9fYmUzMiBfX2hmc191
X3RvX210aW1lKHRpbWU2NF90IHV0KQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAgCXV0IC09IHN5c190
ei50el9taW51dGVzd2VzdCAqIDYwOw0KPiA+ID4gPiArCXV0ICs9IEhGU19VVENfT0ZGU0VUOw0K
PiA+ID4gPiAgDQo+ID4gPiA+IC0JcmV0dXJuIGNwdV90b19iZTMyKGxvd2VyXzMyX2JpdHModXQp
ICsgSEZTX1VUQ19PRkZTRVQpOw0KPiA+ID4gPiArCXJldHVybiBjcHVfdG9fYmUzMihsb3dlcl8z
Ml9iaXRzKHV0KSk7DQo+ID4gPiA+ICB9DQo+ID4gPiA+ICAjZGVmaW5lIEhGU19JKGlub2RlKQko
Y29udGFpbmVyX29mKGlub2RlLCBzdHJ1Y3QgaGZzX2lub2RlX2luZm8sIHZmc19pbm9kZSkpDQo+
ID4gPiA+ICAjZGVmaW5lIEhGU19TQihzYikJKChzdHJ1Y3QgaGZzX3NiX2luZm8gKikoc2IpLT5z
X2ZzX2luZm8pDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9oZnMvc3VwZXIuYyBiL2ZzL2hmcy9z
dXBlci5jDQo+ID4gPiA+IGluZGV4IDk3NTQ2ZDZiNDFmNC4uNmI2YzEzODgxMmI3IDEwMDY0NA0K
PiA+ID4gPiAtLS0gYS9mcy9oZnMvc3VwZXIuYw0KPiA+ID4gPiArKysgYi9mcy9oZnMvc3VwZXIu
Yw0KPiA+ID4gPiBAQCAtMzQxLDYgKzM0MSwxMCBAQCBzdGF0aWMgaW50IGhmc19maWxsX3N1cGVy
KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBmc19jb250ZXh0ICpmYykNCj4gPiA+ID4g
IAlzYi0+c19mbGFncyB8PSBTQl9OT0RJUkFUSU1FOw0KPiA+ID4gPiAgCW11dGV4X2luaXQoJnNi
aS0+Yml0bWFwX2xvY2spOw0KPiA+ID4gPiAgDQo+ID4gPiA+ICsJc2ItPnNfdGltZV9ncmFuID0g
TlNFQ19QRVJfU0VDOw0KPiA+ID4gPiArCXNiLT5zX3RpbWVfbWluID0gSEZTX01JTl9USU1FU1RB
TVBfU0VDUzsNCj4gPiA+ID4gKwlzYi0+c190aW1lX21heCA9IEhGU19NQVhfVElNRVNUQU1QX1NF
Q1M7DQo+ID4gPiA+ICsNCj4gPiA+ID4gIAlyZXMgPSBoZnNfbWRiX2dldChzYik7DQo+ID4gPiA+
ICAJaWYgKHJlcykgew0KPiA+ID4gPiAgCQlpZiAoIXNpbGVudCkNCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL2ZzL2hmc3BsdXMvaGZzcGx1c19mcy5oIGIvZnMvaGZzcGx1cy9oZnNwbHVzX2ZzLmgNCj4g
PiA+ID4gaW5kZXggNWY4OTFiNzNhNjQ2Li4zNTU0ZmFmODRjMTUgMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL2ZzL2hmc3BsdXMvaGZzcGx1c19mcy5oDQo+ID4gPiA+ICsrKyBiL2ZzL2hmc3BsdXMvaGZz
cGx1c19mcy5oDQo+ID4gPiA+IEBAIC01MTEsMjQgKzUxMSwxOSBAQCBpbnQgaGZzcGx1c19yZWFk
X3dyYXBwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYik7DQo+ID4gPiA+ICANCj4gPiA+ID4gIC8q
DQo+ID4gPiA+ICAgKiB0aW1lIGhlbHBlcnM6IGNvbnZlcnQgYmV0d2VlbiAxOTA0LWJhc2UgYW5k
IDE5NzAtYmFzZSB0aW1lc3RhbXBzDQo+ID4gPiA+IC0gKg0KPiA+ID4gPiAtICogSEZTKyBpbXBs
ZW1lbnRhdGlvbnMgYXJlIGhpZ2hseSBpbmNvbnNpc3RlbnQsIHRoaXMgb25lIG1hdGNoZXMgdGhl
DQo+ID4gPiA+IC0gKiB0cmFkaXRpb25hbCBiZWhhdmlvciBvZiA2NC1iaXQgTGludXgsIGdpdmlu
ZyB0aGUgbW9zdCB1c2VmdWwNCj4gPiA+ID4gLSAqIHRpbWUgcmFuZ2UgYmV0d2VlbiAxOTcwIGFu
ZCAyMTA2LCBieSB0cmVhdGluZyBhbnkgb24tZGlzayB0aW1lc3RhbXANCj4gPiA+ID4gLSAqIHVu
ZGVyIEhGU1BMVVNfVVRDX09GRlNFVCAoSmFuIDEgMTk3MCkgYXMgYSB0aW1lIGJldHdlZW4gMjA0
MCBhbmQgMjEwNi4NCj4gPiA+ID4gICAqLw0KPiA+ID4gPiAtI2RlZmluZSBIRlNQTFVTX1VUQ19P
RkZTRVQgMjA4Mjg0NDgwMFUNCj4gPiA+ID4gLQ0KPiA+ID4gPiAgc3RhdGljIGlubGluZSB0aW1l
NjRfdCBfX2hmc3BfbXQydXQoX19iZTMyIG10KQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAtCXRpbWU2
NF90IHV0ID0gKHUzMikoYmUzMl90b19jcHUobXQpIC0gSEZTUExVU19VVENfT0ZGU0VUKTsNCj4g
PiA+ID4gKwl0aW1lNjRfdCB1dCA9ICh0aW1lNjRfdCliZTMyX3RvX2NwdShtdCkgLSBIRlNfVVRD
X09GRlNFVDsNCj4gPiA+ID4gIA0KPiA+ID4gPiAgCXJldHVybiB1dDsNCj4gPiA+ID4gIH0NCj4g
PiA+ID4gIA0KPiA+ID4gPiAgc3RhdGljIGlubGluZSBfX2JlMzIgX19oZnNwX3V0Mm10KHRpbWU2
NF90IHV0KQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAtCXJldHVybiBjcHVfdG9fYmUzMihsb3dlcl8z
Ml9iaXRzKHV0KSArIEhGU1BMVVNfVVRDX09GRlNFVCk7DQo+ID4gPiA+ICsJdXQgKz0gSEZTX1VU
Q19PRkZTRVQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlyZXR1cm4gY3B1X3RvX2JlMzIobG93ZXJf
MzJfYml0cyh1dCkpOw0KPiA+ID4gPiAgfQ0KPiA+ID4gPiAgDQo+ID4gPiA+ICBzdGF0aWMgaW5s
aW5lIGVudW0gaGZzcGx1c19idHJlZV9tdXRleF9jbGFzc2VzDQo+ID4gPiA+IGRpZmYgLS1naXQg
YS9mcy9oZnNwbHVzL3N1cGVyLmMgYi9mcy9oZnNwbHVzL3N1cGVyLmMNCj4gPiA+ID4gaW5kZXgg
NTkyZDhmYmI3NDhjLi5kY2Q2MTg2OGQxOTkgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2ZzL2hmc3Bs
dXMvc3VwZXIuYw0KPiA+ID4gPiArKysgYi9mcy9oZnNwbHVzL3N1cGVyLmMNCj4gPiA+ID4gQEAg
LTQ4Nyw2ICs0ODcsMTAgQEAgc3RhdGljIGludCBoZnNwbHVzX2ZpbGxfc3VwZXIoc3RydWN0IHN1
cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQ0KPiA+ID4gPiAgCWlmICghc2Jp
LT5yc3JjX2NsdW1wX2Jsb2NrcykNCj4gPiA+ID4gIAkJc2JpLT5yc3JjX2NsdW1wX2Jsb2NrcyA9
IDE7DQo+ID4gPiA+ICANCj4gPiA+ID4gKwlzYi0+c190aW1lX2dyYW4gPSBOU0VDX1BFUl9TRUM7
DQo+ID4gPiA+ICsJc2ItPnNfdGltZV9taW4gPSBIRlNfTUlOX1RJTUVTVEFNUF9TRUNTOw0KPiA+
ID4gPiArCXNiLT5zX3RpbWVfbWF4ID0gSEZTX01BWF9USU1FU1RBTVBfU0VDUzsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiAgCWVyciA9IC1FRkJJRzsNCj4gPiA+ID4gIAlsYXN0X2ZzX2Jsb2NrID0gc2Jp
LT50b3RhbF9ibG9ja3MgLSAxOw0KPiA+ID4gPiAgCWxhc3RfZnNfcGFnZSA9IChsYXN0X2ZzX2Js
b2NrIDw8IHNiaS0+YWxsb2NfYmxrc3pfc2hpZnQpID4+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2hmc19jb21tb24uaCBiL2luY2x1ZGUvbGludXgvaGZzX2NvbW1vbi5oDQo+
ID4gPiA+IGluZGV4IGRhZGI1ZTBhYThhMy4uODE2YWMyZjA5OTZkIDEwMDY0NA0KPiA+ID4gPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L2hmc19jb21tb24uaA0KPiA+ID4gPiArKysgYi9pbmNsdWRlL2xp
bnV4L2hmc19jb21tb24uaA0KPiA+ID4gPiBAQCAtNjUwLDQgKzY1MCwyMiBAQCB0eXBlZGVmIHVu
aW9uIHsNCj4gPiA+ID4gIAlzdHJ1Y3QgaGZzcGx1c19hdHRyX2tleSBhdHRyOw0KPiA+ID4gPiAg
fSBfX3BhY2tlZCBoZnNwbHVzX2J0cmVlX2tleTsNCj4gPiA+ID4gIA0KPiA+ID4gPiArLyoNCj4g
PiA+ID4gKyAqIFRoZXJlIGFyZSB0d28gdGltZSBzeXN0ZW1zLiAgQm90aCBhcmUgYmFzZWQgb24g
c2Vjb25kcyBzaW5jZQ0KPiA+ID4gPiArICogYSBwYXJ0aWN1bGFyIHRpbWUvZGF0ZS4NCj4gPiA+
ID4gKyAqCVVuaXg6CXNpZ25lZCBsaXR0bGUtZW5kaWFuIHNpbmNlIDAwOjAwIEdNVCwgSmFuLiAx
LCAxOTcwDQo+ID4gPiA+ICsgKgltYWM6CXVuc2lnbmVkIGJpZy1lbmRpYW4gc2luY2UgMDA6MDAg
R01ULCBKYW4uIDEsIDE5MDQNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBIRlMvSEZTKyBpbXBs
ZW1lbnRhdGlvbnMgYXJlIGhpZ2hseSBpbmNvbnNpc3RlbnQsIHRoaXMgb25lIG1hdGNoZXMgdGhl
DQo+ID4gPiA+ICsgKiB0cmFkaXRpb25hbCBiZWhhdmlvciBvZiA2NC1iaXQgTGludXgsIGdpdmlu
ZyB0aGUgbW9zdCB1c2VmdWwNCj4gPiA+ID4gKyAqIHRpbWUgcmFuZ2UgYmV0d2VlbiAxOTcwIGFu
ZCAyMTA2LCBieSB0cmVhdGluZyBhbnkgb24tZGlzayB0aW1lc3RhbXANCj4gPiA+ID4gKyAqIHVu
ZGVyIEhGU19VVENfT0ZGU0VUIChKYW4gMSAxOTcwKSBhcyBhIHRpbWUgYmV0d2VlbiAyMDQwIGFu
ZCAyMTA2Lg0KPiA+ID4gPiArICovDQo+ID4gPiANCj4gPiA+IFNpbmNlIHRoaXMgaXMgcmVwbGFj
aW5nIHRoZSB3cmFwcGluZyBiZWhhdmlvciB3aXRoIGEgbGluZWFyIDE5MDQtMjA0MA0KPiA+ID4g
bWFwcGluZywgc2hvdWxkIHdlIHVwZGF0ZSB0aGlzIGNvbW1lbnQgdG8gbWF0Y2g/IEl0IHN0aWxs
IGRlc2NyaWJlcyB0aGUNCj4gPiA+IG9sZCAiMjA0MCB0byAyMTA2IiB3cmFwcGluZyBzZW1hbnRp
Y3MuDQo+ID4gPiANCj4gPiANCj4gPiBGcmFua2x5IHNwZWFraW5nLCBJIGRvbid0IHF1aXRlIGZv
bGxvdyB3aGF0IGRvIHlvdSBtZWFuIGhlcmUuIFRoaXMgcGF0Y2ggZG9lc24ndA0KPiA+IGNoYW5n
ZSB0aGUgYXBwcm9hY2guIEl0IHNpbXBseSBmaXhlcyB0aGUgaW5jb3JyZWN0IGNhbGN1bGF0aW9u
IGxvZ2ljLiBEbyB5b3UNCj4gPiBtZWFuIHRoYXQgdGhpcyB3cmFwcGluZyBpc3N1ZSB3YXMgdGhl
IG1haW4gYXBwcm9hY2g/IEN1cnJlbnRseSwgSSBkb24ndCBzZWUgd2hhdA0KPiA+IG5lZWRzIHRv
IGJlIHVwZGF0ZWQgaW4gdGhlIGNvbW1lbnQuDQo+IA0KPiBIaSwNCj4gDQo+IFRoZSBjb21tZW50
IHNheXMgInRpbWUgcmFuZ2UgYmV0d2VlbiAxOTcwIGFuZCAyMTA2LCBieSB0cmVhdGluZyBhbnkN
Cj4gb24tZGlzayB0aW1lc3RhbXAgdW5kZXIgSEZTX1VUQ19PRkZTRVQgKEphbiAxIDE5NzApIGFz
IGEgdGltZSBiZXR3ZWVuDQo+IDIwNDAgYW5kIDIxMDYiLiBUaGF0IHdhcyB0aGUgb2xkIGJlaGF2
aW9yIHZpYSB0aGUgKHUzMikgY2FzdC4NCj4gDQo+IFlvdXIgcGF0Y2ggY2hhbmdlcyAodTMyKSB0
byAodGltZTY0X3QpIGluIF9faGZzcF9tdDJ1dC9fX2hmc19tX3RvX3V0aW1lLA0KPiB3aGljaCBy
ZW1vdmVzIHRoYXQgd3JhcHBpbmcuIEZvciBNYWMgdGltZSAwIChKYW4gMSwgMTkwNCk6DQo+IA0K
PiAgIE9sZDogKHUzMikgICAgICgwIC0gMjA4Mjg0NDgwMCkgPSAgMjIxMjEyMjQ5NiAtPiAyMDQw
DQo+ICAgTmV3OiAodGltZTY0X3QpIDAgLSAyMDgyODQ0ODAwICA9IC0yMDgyODQ0ODAwIC0+IDE5
MDQNCj4gDQo+IFRoZSBuZXcgc190aW1lX21pbi9zX3RpbWVfbWF4IGFsc28gY29uZmlybSB0aGUg
cmFuZ2UgaXMgbm93IDE5MDQtMjA0MCwNCj4gbm90IDE5NzAtMjEwNi4gU28gdGhlIGNvbW1lbnQg
bm8gbG9uZ2VyIG1hdGNoZXMgdGhlIGNvZGUuDQo+IA0KDQpPSy4gSSBzZWUgeW91ciBwb2ludC4g
U28sIHdlIGNhbm5vdCBleGVjdXRlIHRoZSB3cm9uZyBjYWxjdWxhdGlvbiBmb3IgdGltZXN0YW1w
cw0KdGhhdCBhcmUgbGVzcyB0aGFuIDE5NzAuIEJ1dCBpdCB3aWxsIGJlIGdvb2QgdG8gc3VwcG9y
dCB0aGUgdHJpY2sgcmVsYXRlZCB0bw0KMTk3MC0yMTA2LiBIb3cgY2FuIHdlIGltcHJvdmUgdGhl
IHBhdGNoPyBXaGF0J3MgeW91ciBzdWdnZXN0aW9uPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiAN
Cg==

