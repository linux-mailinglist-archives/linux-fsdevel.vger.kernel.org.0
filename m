Return-Path: <linux-fsdevel+bounces-47880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A22AA67A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 02:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F4F171D5E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 00:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EBD2581;
	Fri,  2 May 2025 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gaxu+kEz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCEC2576;
	Fri,  2 May 2025 00:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746144476; cv=fail; b=Mb0cL4vvNU/DiV/xcjskMNOKCmSj8QJrLWPjA6kBFkviQUhFpotExi74djYsG9Pp0hqMrxTe3FK6b7Hj49u+rritNkOLmrt2qf0CyD5UriResXEC4zfAmGTxXuT8DDRLRi2Vl+pFCTNDxhZ3KHE1EjWQPnGDuZbjcSL2XD6Sv1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746144476; c=relaxed/simple;
	bh=k6Zi0LIrYSlmQL9dgWey8EQZ2dh4u7Ed7pBPsFLqK4Q=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=JANAsM0BE6s+glJtrwvRI8RuEmwnWIU7tT8iegsC4ODNO/oUt/rxDEzFjqJvAvujgTrJZTynaEw9heGHjxDegRD76IKv/xLX3J1HqlAF/CU2GlDtd30dM1UOyGMI89jUVRJeSv3eMVo/t7iBQG0+SnAXFQNFKpDiQbUHz3Z2t5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gaxu+kEz; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541LgWdl006180;
	Fri, 2 May 2025 00:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=k6Zi0LIrYSlmQL9dgWey8EQZ2dh4u7Ed7pBPsFLqK4Q=; b=Gaxu+kEz
	Ey9BWvbNWUIRFDafnd/nQovbsZTQbcnc12Aikfj6lYWN5cNqPioaKzAsx5AnIRoI
	dyI1NKmeNTlBmuKt6uPP2/AxL2RCgMsah0XjXn9jPug6XXC3uKP6je4qdedZwfAq
	nvVOOA16QtBpPkHz67Th9VgOfCKhBOA7ExcIZ6bUfLyvqdBF2oZripb/iJ7PN54/
	YxKD32fDIaLM2lwymTr52TPn1GWjmWgp6rZiADUoQcxANEQb+EOfV6oaja6lcXlf
	K/8LTb89GcclHkbu9OmM+skdLmkjC4TXWroNDVm5xPWDeTZIIqVhDOGP3foGnRr4
	lFoJmXIc0LFT1Q==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ch3vrc6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 00:07:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSqxWmJFZwgvrM6coEsnsDKcuDiwRQ7mceM6tPtNM90JY7hT/EkJbxBP4zPSygrus/Whx8k3h2LElOgWuHReI2SCSt2vf8EpTvKOANkLC5nNFkDjrqAExKVHR4K9111fimK0StnsycBWtNn9u+mSxkIEQ8La44ZZUqTTQh2Hts0MTIoX7Z1NGudtdMFiW2d0NY9e0B9snfWMUQgOUixehl6yzdS+HGY82095QCrnufxI8j+K385p91IRmqGKBcaQqLjN8CC46QZQ4qq1+1rZ/430gHtsPapWds3PyGVrkhd/izov2fE1HyRNISQIqgifTHX6ezivKDPjofHeER8YcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6Zi0LIrYSlmQL9dgWey8EQZ2dh4u7Ed7pBPsFLqK4Q=;
 b=a6o3fHASQ5QqUeNZ34zYghSVEAb5d/LRthV4s7EzSIelTO8oQY/VRWAwfEsa38OHm2DhKnG2WntI7oVRiVorgpVppIZA7Q/lFQGGUWUPD2vgtIcY09y4H+EsmJXLIBo8zvD+YraG9wIVYBRx+ccGBz/kvQE/89+Ht1KvXJAV2SNWFQe+OroI0JQaC+pzQKft1iljAdsxJrFfyb/G8pXoOdi32VgUB2yGwS/Q8fj29sSwNwOxksYHgXwnGyjXtwEopW1A24Mm4We1imnr/CdLbOQ/BI7aUo2cneL9yAp10KZg/aiQoIgjf2GnxhV4mcuEH3o8Fvfw9Z/gOZarm2ztGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4235.namprd15.prod.outlook.com (2603:10b6:a03:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 00:07:48 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 00:07:48 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 1/2] hfsplus: fix to update ctime after rename
Thread-Index: AQHbuUCvMoIBkNVd7ka331jcjCdQj7O+efcA
Date: Fri, 2 May 2025 00:07:48 +0000
Message-ID: <e0e427e5a1ecdaaa188e5ae80a75723c04619161.camel@ibm.com>
References: <20250429201517.101323-1-frank.li@vivo.com>
In-Reply-To: <20250429201517.101323-1-frank.li@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4235:EE_
x-ms-office365-filtering-correlation-id: 022cd5bc-6156-40fc-f467-08dd890d5f72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWI3NC9Cc3JyS2VxcklHMzNjRGM4Sy9oQVVEQkZDQW1aQTVnL2phbFFvTmFo?=
 =?utf-8?B?WGFqb1lUSE16SjQ0NGExM1hLRjdFbWFmUmhtaWlBK3g5UHZWS3djYWJvRzJl?=
 =?utf-8?B?VTBITU91MTl2cEFuK1BVYjYySWw4OUlTWFg4YUwyUXZUK3JheEk1K3hlMWZJ?=
 =?utf-8?B?STgrRHJGM0tzM01jM2xjelhzUkZ2b2VMUVVxSHIzbjNkWktwUCtBOWVja1NU?=
 =?utf-8?B?K1hySTFyM2RZZkRZenYxeWllVHNiWmpldldMTWlhUUsyTWZ3TlAyYlBXSUtF?=
 =?utf-8?B?dnFZMHhDdXNnTE0zeHJabUF3a2VsN1FtNnNRd0RhMmpVWERJM2M3OWRaY1Q2?=
 =?utf-8?B?M1JsSzZzaFBWL1dOTHF5bUJRV3ZtenFGWTNYdVFTLzdDOTcxRWhrWjJIK3Bi?=
 =?utf-8?B?aWNkdG5pTnlnNG54RFhhVkhYM0VyeEVXdFU2UTZ6WVlHRVFldDdxV3ZmdG9C?=
 =?utf-8?B?SEJtNVAvbVo4MWVmMDNSdmwxKzZGSkM1MzVpaVFuK3JIdXhuWjRxdkNBczQy?=
 =?utf-8?B?SlFpMHhVMUx1SVcxcG5PS3BFeUlTTVZYN2RsamQ3ellPTXdGWkpIV3FRVFl0?=
 =?utf-8?B?VW5DTnR4dVBSclpUbE9PV2cyRk53dGdSREZLU01FR1pSalhQVzZnZUlDYlpo?=
 =?utf-8?B?Q2FqQVI1NTJvY1N3RlBLVXcwdzVwZzVqMmI5SGdidGxHRFpSMm1wYytsb3NL?=
 =?utf-8?B?T052K2FjOWcyZ3FNcjNCMGNjbEZldEE0TGtiUDRTdmlQWCtaWkM5eHlqdE5Y?=
 =?utf-8?B?VzR6NXlEOTdFOUNtN0tBQVVSRDlyNExhZkJSRGszOEJSeEF0Z2J0NnViOGZE?=
 =?utf-8?B?WlA0MlFZU2hMOE42QUw5ZzNTQ2o3L0ZadWFNRWVRL3IwUzkvZkZlN1hYb21p?=
 =?utf-8?B?Z1QraHdJZDlpaVJQQkVXN3Z1MjN5RTRiWGlydmxka3BibmJNZjIvRkNoR29s?=
 =?utf-8?B?OGcrMUQyYkVITmU2UlRxYXVRYnQ4dTdhRVFRSThNdjhWQTFEaHpsK2pMdWR4?=
 =?utf-8?B?cnhjU0hGdXljV2loSVJONmNENTJOd1VrOE1JemZHeGJhejFUYjdYSHZaaHVu?=
 =?utf-8?B?UytIaFV5MDVIOW9UUU1QSDFDMDA1SllxQWF1RElIZVRtTUI5Qml2MnlKL3Z6?=
 =?utf-8?B?Vm5mRjBNWUNBSUVXYlpSWUtXRnp0QSsvcEVLMllyMmRON3I1SXhreG82NGZN?=
 =?utf-8?B?K2I5STQwS2wvSUU4aFRCQ2U0MVR6LzRjQ21paFpTQmpJN2hIbyt2aWdKM0th?=
 =?utf-8?B?OEVPR0o4VDZJMTlkVE9DVnpkQ3pwb0dCcDc0NHlyMDdESGlaaFQvaWgyWnBB?=
 =?utf-8?B?eEZ1ZkZCKzJxdlNTb0pqRGd6dHkwMmhUZTRGODVDSkprM0tzY2ZuSk1PdUpK?=
 =?utf-8?B?dGdKS1laRUlMVjhiWFJqdWVQNFhJcWsrWHdGODErV1VSNzVnWWxiaDByZlVE?=
 =?utf-8?B?dXNKVml0Uk84OXhodzFWU24yQlZWdWdJNkRNR2tKaFp2d2htSE1oM0t1RG90?=
 =?utf-8?B?YXNrclpJZlFuQndCWDVsU0MvblVZT1lNQjB6SllSRzFsOW5tanpqSzBGbHlQ?=
 =?utf-8?B?anlQTFBWb3R4WTNwTDRybjFNdG9xV0xtSyswSjhka1hBME9UL2NjWlNPNXdo?=
 =?utf-8?B?c2loZmp1aWJjUTRUZWdFNWR5bC9TOUsyeCtMYVdabG12Y3Z6TkxNdDljcU0z?=
 =?utf-8?B?bjdwcGpramRrWTlwSHBuSDBrSFpVbkZTNG5xWkt0dXRnMFFhWmh5aklxU2Rp?=
 =?utf-8?B?MnJlSUpRWExXTlhZTElGbVZoT0Q4RmowL0ljdURKRHRCQzJtdUFuN1JxUFF2?=
 =?utf-8?B?am9oT24rUEk4WkZVeVdZZFdndVc3aklnRVlVcDE2bHMzMjhpRDY0cjBzY2lV?=
 =?utf-8?B?UEpUL3hrV2E4K1g1L0VTMkYzcTBpNG4vTVpXODdvNHVaaEdkYWQrTXpIekxE?=
 =?utf-8?B?OFRBOXA0cHdWS3Q3dkl0VGszOSt2WHhNOXFBMFlkSzk4SGdMTklpUGp6ZE80?=
 =?utf-8?Q?Ihk8ddkxWjIu7CAwVBMnx4swItBhw8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0c0OXNhbFpvdHpXUG1PTkZNMW9vdS9wS25namVmTUJXcWs4SHBDRGZtY1g1?=
 =?utf-8?B?SzArTytZMHAxK2JrdXRzcG1xR2FNendISVNhZEpteU9BSnFTd0lGVFhCeGVk?=
 =?utf-8?B?VUN1UFkxZWN6dElBS2FxclN3UnpFZVdSN2tJelpJWXF6Tk9XWnBudXREM3R4?=
 =?utf-8?B?NFNiTnJsVHE4d2FsNVRXTGpNNXl6b2dmS2dYNkNRK3NvNkQ0Tk9xY3liQmNi?=
 =?utf-8?B?bVdSVW55QXBYOEQzR2ZwdUNBaytKRVpWeVVBL1ZCdGdDRlIzR0FIQVBhZW8z?=
 =?utf-8?B?TUFyWnppeFdXVTlvb1VmSko2aDJ6dFY2MGhWZWNVOTU3NW5tRW9kdzFxaTlB?=
 =?utf-8?B?Z05UeGQvTjl0ZWNaZ3dWd1lRNVdLSEZhQit5RGpEZm11MTFEVTBMSDdBVU94?=
 =?utf-8?B?b1V0dVVQWTdmeUdlaW9pM1dPeDNrRGVJN2NNREp1ckovZlJ3cTJra3hGa2wv?=
 =?utf-8?B?VUd1NFNwK0J0S2dsS2IyY29oelJLUVdUYTRMQTBHVVM3eG5ObXNaUjBiSC9r?=
 =?utf-8?B?UGxiVUV5RHloR3RHUFJWWEI4dFhIM3Q3ZnM0Y2xxVVhWSWFDZDFKcFlDV0F2?=
 =?utf-8?B?bDUyTW8zYktwSisza2VuSHNQUTVramFRVW8wK1hJZkpMQ29WaktoTnUzYWhD?=
 =?utf-8?B?YkR6OXIwYzQ2TEwyNG8xSEp5VFRsQTg2YjJpbmhpZXFEd3JhdG94c0tNNnEy?=
 =?utf-8?B?UnFvSFJmTDFrc0hjWkVsU1VlbmVjT1NYWUwyKzNjUlpTc2lmUy93UHptYjc1?=
 =?utf-8?B?Z3o2UDdPbGNPb042ZE5mbno1TER4UjRhUFVoOG1lVXAxVy9nNmc1VEFlWWQr?=
 =?utf-8?B?MCtCVHJwbFA5bDhvSXY3MTlWQU91b2R6akxwTXJ2SzE2QmxNYk8zZGFnc3Ri?=
 =?utf-8?B?Ulk1NlNtbWJoQUdYdG4zdURNVS8wNTlscVRLeVE3cXR6TFhzVmdWYnh1SkVJ?=
 =?utf-8?B?a1VycGVPU2hmdVM2YTZxS2ZsWStLbVJ6UW9abDZLMFQyVXJWSFljUWwwTCth?=
 =?utf-8?B?RmVVbXR0RGJZZWpZMURpTzFLTnRiOUE3SlNzK2dTbXhIVWFCUGNwUzliZk5U?=
 =?utf-8?B?KzBRdTEyS0dVVmpnR1Rxa2tlNVdoK3NkdDdsVXp0aU1nd1FOZ1AyRDlxajU4?=
 =?utf-8?B?RkNhbnZIM01ySkxlb3FubkdIU3JJOTg4aHFKV2VIcXg2K1dhZEgrOG9SOS8w?=
 =?utf-8?B?OTU1emcyYlVNai93Rk9jNVhkaXpubDU3NG5nZGt5UzVoQ3BUVG9UcmhCdXk0?=
 =?utf-8?B?L1ZnOXJWNUsvN2N1dFh1L2ZSQThaSFN4eGhaajYxeDBzd2U0UXpCS3U0dkdv?=
 =?utf-8?B?eVNxRkRHWTJYSXJ1TnlBdllTMFNSTHViQWhlRkVveTdteUIxTTRzMEgrdDB1?=
 =?utf-8?B?TFprZWFScVFRM254YzExT2pxTmhHVlpjZER6S1FWWmc3N1g2eG5RV0tianYz?=
 =?utf-8?B?S1h1Wm5xQWZEanNFNkppRnBGd3lpZ2twdld0bkxpakZPcXVrYyt5TUptb2xI?=
 =?utf-8?B?Vm1ZcUJTQnRlb2pWT05LYU92ZGg1UXJrOWdHQVBKOElWWmh1eWQ1ZHhDRyt2?=
 =?utf-8?B?VkI2YjNvczY2M3l2QTQ3K2FRbStRNWNsdVdHSlJqT0pDR2VIUDExZlBFV2tD?=
 =?utf-8?B?cmN1U2JmNWJvVm9sU0NaTXl5bTZQTnA1OThzdTFZNWhtY3V3M0prWDZTQm8r?=
 =?utf-8?B?Z1JuL1pwenNBUFF4QTBPMW9FTzVwNFJNeHJFc1hmQ3A2SFI5UkYydVp1b0Rt?=
 =?utf-8?B?R3Rub28zQ2h6SzgrMUFRZlVoVXZyaUJkN0JrQ1pPbEhIWEo0N0FZQzV2U0JC?=
 =?utf-8?B?VENFaGswZWx2U2IyTVZ1RVBCNkJycE41Ylc2VktvNnNCMmcvZWR1QlhiUVFW?=
 =?utf-8?B?QzdVdHB2SmFKRUhkTmtoM1lJRUJseDY0YkViQWVGcCtxOHM3REtHY2RSN1pC?=
 =?utf-8?B?cDU4N0VOQ3FEcHF6Qk1ISm9BRGhaTHBkTG1ZU1hVc2tvVlNZWXlCTlNFYm80?=
 =?utf-8?B?Q1V6dkNzOGRBQnZEU2pXajJ6NkN2OEpkVkYyWUxKR2RObTRSNGh4YjkwUHRj?=
 =?utf-8?B?VGx1UkE5NVFscHZpU0hML3FWZGpnK1haanoySmpqL09VblZNTUUvQ0NCMFJ1?=
 =?utf-8?B?OUNrTVFBUHFkK2lNN1B4WXBZeWdlb0ErOGowd0tYR21zVEtrRm5oV1UzZUxs?=
 =?utf-8?Q?xIeYH3yFiXKLz1Sjg/CgjuE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A8391515566104AB71EA20FBF152249@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 022cd5bc-6156-40fc-f467-08dd890d5f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 00:07:48.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPvcTuPercLic9OaULYeMvtPUpGxGgTCVQyl9aJXqC6sAmoH/uZrHQdUQUxu9mKyVbhEYc3RV9Vl+hkwWQqe7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4235
X-Authority-Analysis: v=2.4 cv=Z+XsHGRA c=1 sm=1 tr=0 ts=68140cd7 cx=c_pps p=wCmvBT1CAAAA:8 a=19NZlzvm9lyiwlsJLkNFGw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=1WtWmnkvAAAA:8 a=P-8-FIfbV26GEPUy5WgA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: McmYiEUrC25BCQGecnygrA3Ol8mbg37q
X-Proofpoint-GUID: McmYiEUrC25BCQGecnygrA3Ol8mbg37q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDE4MyBTYWx0ZWRfXzQhQdR/8fRH5 +ayOwp38JfhXX5FyljTJ/7cxqQaOtbu4C8iMmBv0JEtM0rptBewWOYqnl+po8GxsCOMs4r5Uyud EHvZNGWJAkYhE2ZQkzUqd0Sf91YaUQENHIS198cn4dGwGKUbotF1PtIfNBXQBjjyX6Oqb5M6OLK
 AB7QgKRVNbq4I+o/RXkbHuRHyXcj8Q18l8izv5rXihiqUozgcyyArkO1h2Xsk3GRhCLpB9mtUdY 9dvF3SaMlYN0O8NuLi7FRdWHPdXJ4V9Rl92x5CfJV1lPAegDxdk6PjIzYvGp9rmrB1WR6ZNzHif F/K98r8aM2sSXN5nhEfD9tsc5ShjQssZDLkTLOd2BDPjzSXsPJo0i3En6oPtu+3zHA8TeDGQnmc
 IA2pssX4PZpwtIh4mQlJTNkq0piNfw68p9odqYoSKm4P1dbH0VpUIavx7hHksO5Ekouqv3IG
Subject: Re:  [PATCH 1/2] hfsplus: fix to update ctime after rename
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam authscore=99 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010183

T24gVHVlLCAyMDI1LTA0LTI5IGF0IDE0OjE1IC0wNjAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiBb
QlVHXQ0KPiAkIHN1ZG8gLi9jaGVjayBnZW5lcmljLzAwMw0KPiBGU1RZUCAgICAgICAgIC0tIGhm
c3BsdXMNCj4gUExBVEZPUk0gICAgICAtLSBMaW51eC94ODZfNjQgZ3JhcGhpYyA2LjguMC01OC1n
ZW5lcmljICM2MH4yMi4wNC4xLVVidW50dQ0KPiBNS0ZTX09QVElPTlMgIC0tIC9kZXYvbG9vcDI5
DQo+IE1PVU5UX09QVElPTlMgLS0gL2Rldi9sb29wMjkgL21udC9zY3JhdGNoDQo+IA0KPiBnZW5l
cmljLzAwMyAgICAgICAtIG91dHB1dCBtaXNtYXRjaA0KPiAgICAgLS0tIHRlc3RzL2dlbmVyaWMv
MDAzLm91dCAgIDIwMjUtMDQtMjcgMDg6NDk6MzkuODc2OTQ1MzIzIC0wNjAwDQo+ICAgICArKysg
L2hvbWUvZ3JhcGhpYy9mcy94ZnN0ZXN0cy1kZXYvcmVzdWx0cy8vZ2VuZXJpYy8wMDMub3V0LmJh
ZA0KPiANCj4gICAgICBRQSBvdXRwdXQgY3JlYXRlZCBieSAwMDMNCj4gICAgICtFUlJPUjogY2hh
bmdlIHRpbWUgaGFzIG5vdCBiZWVuIHVwZGF0ZWQgYWZ0ZXIgY2hhbmdpbmcgZmlsZTENCj4gICAg
ICBTaWxlbmNlIGlzIGdvbGRlbg0KPiAgICAgLi4uDQo+IA0KPiBSYW46IGdlbmVyaWMvMDAzDQo+
IEZhaWx1cmVzOiBnZW5lcmljLzAwMw0KPiBGYWlsZWQgMSBvZiAxIHRlc3RzDQo+IA0KPiBbQ0FV
U0VdDQo+IGNoYW5nZSB0aW1lIGhhcyBub3QgYmVlbiB1cGRhdGVkIGFmdGVyIGNoYW5naW5nIGZp
bGUxDQo+IA0KPiBbRklYXQ0KPiBVcGRhdGUgZmlsZSBjdGltZSBhZnRlciByZW5hbWUgaW4gaGZz
cGx1c19yZW5hbWUoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbmd0YW8gTGkgPGZyYW5rLmxp
QHZpdm8uY29tPg0KPiAtLS0NCj4gIGZzL2hmc3BsdXMvZGlyLmMgfCAxMSArKysrKysrKy0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2Rpci5jIGIvZnMvaGZzcGx1cy9kaXIuYw0KPiBpbmRl
eCA4NzZiYmI4MGZiNGQuLmU3Nzk0MjQ0MDI0MCAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9k
aXIuYw0KPiArKysgYi9mcy9oZnNwbHVzL2Rpci5jDQo+IEBAIC01MzQsNiArNTM0LDcgQEAgc3Rh
dGljIGludCBoZnNwbHVzX3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwNCj4gIAkJCSAg
c3RydWN0IGlub2RlICpuZXdfZGlyLCBzdHJ1Y3QgZGVudHJ5ICpuZXdfZGVudHJ5LA0KPiAgCQkJ
ICB1bnNpZ25lZCBpbnQgZmxhZ3MpDQo+ICB7DQo+ICsJc3RydWN0IGlub2RlICppbm9kZSA9IGRf
aW5vZGUob2xkX2RlbnRyeSk7DQo+ICAJaW50IHJlczsNCj4gIA0KPiAgCWlmIChmbGFncyAmIH5S
RU5BTUVfTk9SRVBMQUNFKQ0KPiBAQCAtNTUyLDkgKzU1MywxMyBAQCBzdGF0aWMgaW50IGhmc3Bs
dXNfcmVuYW1lKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLA0KPiAgCXJlcyA9IGhmc3BsdXNfcmVu
YW1lX2NhdCgodTMyKSh1bnNpZ25lZCBsb25nKW9sZF9kZW50cnktPmRfZnNkYXRhLA0KPiAgCQkJ
CSBvbGRfZGlyLCAmb2xkX2RlbnRyeS0+ZF9uYW1lLA0KPiAgCQkJCSBuZXdfZGlyLCAmbmV3X2Rl
bnRyeS0+ZF9uYW1lKTsNCj4gLQlpZiAoIXJlcykNCj4gLQkJbmV3X2RlbnRyeS0+ZF9mc2RhdGEg
PSBvbGRfZGVudHJ5LT5kX2ZzZGF0YTsNCj4gLQlyZXR1cm4gcmVzOw0KPiArCWlmIChyZXMpDQo+
ICsJCXJldHVybiByZXM7DQo+ICsNCj4gKwluZXdfZGVudHJ5LT5kX2ZzZGF0YSA9IG9sZF9kZW50
cnktPmRfZnNkYXRhOw0KPiArCWlub2RlX3NldF9jdGltZV9jdXJyZW50KGlub2RlKTsNCj4gKwlt
YXJrX2lub2RlX2RpcnR5KGlub2RlKTsNCj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAgY29u
c3Qgc3RydWN0IGlub2RlX29wZXJhdGlvbnMgaGZzcGx1c19kaXJfaW5vZGVfb3BlcmF0aW9ucyA9
IHsNCg0KQkVGT1JFIFBBVENIOg0KDQpzdWRvIC4vY2hlY2sgZ2VuZXJpYy8wMDMNCkZTVFlQICAg
ICAgICAgLS0gaGZzcGx1cw0KUExBVEZPUk0gICAgICAtLSBMaW51eC94ODZfNjQgaGZzcGx1cy10
ZXN0aW5nLTAwMDEgNi4xNS4wLXJjNCAjNyBTTVANClBSRUVNUFRfRFlOQU1JQyBUaHUgTWF5ICAx
IDE2OjExOjQ5IFBEVCAyMDI1DQpNS0ZTX09QVElPTlMgIC0tIC9kZXYvbG9vcDUxDQpNT1VOVF9P
UFRJT05TIC0tIC9kZXYvbG9vcDUxIC9tbnQvc2NyYXRjaA0KDQpnZW5lcmljLzAwMyAgICAgICAt
IG91dHB1dCBtaXNtYXRjaCAoc2VlIC9ob21lL3NsYXZhZC9YRlNURVNUUy0yL3hmc3Rlc3RzLQ0K
ZGV2L3Jlc3VsdHMvL2dlbmVyaWMvMDAzLm91dC5iYWQpDQogICAgLS0tIHRlc3RzL2dlbmVyaWMv
MDAzLm91dAkyMDI1LTA0LTI0IDEyOjQ4OjQ1Ljg4NjE2NDMzNSAtMDcwMA0KICAgICsrKyAvaG9t
ZS9zbGF2YWQvWEZTVEVTVFMtMi94ZnN0ZXN0cy0NCmRldi9yZXN1bHRzLy9nZW5lcmljLzAwMy5v
dXQuYmFkCTIwMjUtMDUtMDEgMTY6NDI6NTEuMjIwMTk2NDM0IC0wNzAwDQogICAgQEAgLTEsMiAr
MSwzIEBADQogICAgIFFBIG91dHB1dCBjcmVhdGVkIGJ5IDAwMw0KICAgICtFUlJPUjogY2hhbmdl
IHRpbWUgaGFzIG5vdCBiZWVuIHVwZGF0ZWQgYWZ0ZXIgY2hhbmdpbmcgZmlsZTENCiAgICAgU2ls
ZW5jZSBpcyBnb2xkZW4NCiAgICAuLi4NCiAgICAoUnVuICdkaWZmIC11IC9ob21lL3NsYXZhZC9Y
RlNURVNUUy0yL3hmc3Rlc3RzLWRldi90ZXN0cy9nZW5lcmljLzAwMy5vdXQNCi9ob21lL3NsYXZh
ZC9YRlNURVNUUy0yL3hmc3Rlc3RzLWRldi9yZXN1bHRzLy9nZW5lcmljLzAwMy5vdXQuYmFkJyAg
dG8gc2VlIHRoZQ0KZW50aXJlIGRpZmYpDQpSYW46IGdlbmVyaWMvMDAzDQpGYWlsdXJlczogZ2Vu
ZXJpYy8wMDMNCkZhaWxlZCAxIG9mIDEgdGVzdHMNCg0KV0lUSCBBUFBMSUVEIFBBVENIOg0KDQpz
dWRvIC4vY2hlY2sgZ2VuZXJpYy8wMDMNCkZTVFlQICAgICAgICAgLS0gaGZzcGx1cw0KUExBVEZP
Uk0gICAgICAtLSBMaW51eC94ODZfNjQgaGZzcGx1cy10ZXN0aW5nLTAwMDEgNi4xNS4wLXJjNCsg
IzggU01QDQpQUkVFTVBUX0RZTkFNSUMgVGh1IE1heSAgMSAxNjo0MzoyMiBQRFQgMjAyNQ0KTUtG
U19PUFRJT05TICAtLSAvZGV2L2xvb3A1MQ0KTU9VTlRfT1BUSU9OUyAtLSAvZGV2L2xvb3A1MSAv
bW50L3NjcmF0Y2gNCg0KZ2VuZXJpYy8wMDMgICAgICAgIDM1cw0KUmFuOiBnZW5lcmljLzAwMw0K
UGFzc2VkIGFsbCAxIHRlc3RzDQoNClRlc3RlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2
YUBkdWJleWtvLmNvbT4NClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1
YmV5a28uY29tPg0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

