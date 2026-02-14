Return-Path: <linux-fsdevel+bounces-77210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BukCaRwkGmkZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:55:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C1213BF91
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 769873006022
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44C3043B2;
	Sat, 14 Feb 2026 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="B21xsD3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53552202C5C
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771073691; cv=fail; b=FMwI8w85u/NJg8qQw0iI5/sgdDjSBkB7/2f7PTUYK5L7NZGq2xDGotVQQk+rACWFD4AiIOD4p25Am8e0vV0gpJIZXy+0t/JSWzFR5Mai5vPTGzvWt9j7GsMISyaeAPoEn5Fm7uaWomq6UACe88mRBh3NBrarW//Wv4XXH6soTiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771073691; c=relaxed/simple;
	bh=Tjy4LhGgKoq/PsaeNEt2f4J+w711K7+L9dSQc0uTzmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aT83/5Ig88PfpFpMyx5Mn6DA+wmfcX99GTs0Dp0/ZamNbK6juKlDTm5NmS/9PIYr9Gvg7RGUU/uiIDrcEdfxz3/VY284ntcjZAOei/u9H4TnNx6OQlvffTsR21aT8tfR2tGfQC3iw+L8si8rnLygOsP06S7xZbkRCXhvOGdXZWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=B21xsD3b; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020115.outbound.protection.outlook.com [40.93.198.115]) by mx-outbound-ea18-75.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 14 Feb 2026 12:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytp9Siq6cmD4X7R8xQ9FK/waKiMOD6t2Sq8jV4XueNeSlwmFXv5s9DPxJV/fXdu/KyZFMLIu+fPmvDcJWuEV/+e1L75LPUYATpwNbuMSPMWaTduhoh0Qx29jVroyJ0YRSnFnPd046b546hwLf/7Gpgm/jC+eftw6Wor21i6DQMjPC9vDnBb1WfMWPzcOLx1Bsl2+4Ursdxl3wU+B+peTvk3FtkAA32NiQyleMHlod90vfSVFwDwOMF64QZjutHfnQ2e7yPgwkOLXGhJMDjyUqt70WUFumsH2cp5tTMhaR33aQQXR6S8KT4o2zTWt/kj4+zZNPZ4ui2/TjpZiYaUVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjy4LhGgKoq/PsaeNEt2f4J+w711K7+L9dSQc0uTzmM=;
 b=vhTqgGec8vLaaDNewE4h6T/gfIx1uL9lH/Nlhmk287x/Vk+6BXCsgUZu+2ST2i7OpookPDKOPjhATyulgnsFhsWLqsGhemzrx8U/BuGuOc7BAz5q0DvU8Bvhd5ygPg8C56LVvc/hKK9AN8J/K+41qdLtQRY3SZ8OYhGMGdzl1QheS8Ysf7RuVuJ47l8sHSej5dLaVGgVPlyukQyAPWM6gkRCoWA1BS3s+zA/LEQPxPRCcDr+dXMjA1/Fg0+ZG1z5b9GsE1CulcdTDf/fmfI+1bvQaGYeiYw1ZespRjYuPGwEX2rFVc4eAx2ZcYnZLnAlKjyvlreHD77UBU0lglvc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjy4LhGgKoq/PsaeNEt2f4J+w711K7+L9dSQc0uTzmM=;
 b=B21xsD3bsBanHPSWLTdLzh8UV43dul/WYV5KE4hLQOeDNmMgzyy7VXtyV+BcBNFm2F4EKYL06GtmYrJHDGRaWFBOrSf3yVZAX93+3fkNxIQq10MDE8P2esPtfCvMeMzrFG3rxt6JReEBOXoPtBdWVcbLjaWc/d4srJaxgZvKASM=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DM4PR19MB6487.namprd19.prod.outlook.com (2603:10b6:8:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Sat, 14 Feb
 2026 12:54:27 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%6]) with mapi id 15.20.9611.013; Sat, 14 Feb 2026
 12:54:27 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Joanne Koong <joannelkoong@gmail.com>, Horst Birthelmer
	<horst@birthelmer.de>
CC: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Horst Birthelmer <horst@birthelmer.com>, Luis Henriques <luis@igalia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Horst
 Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH v5 1/3] fuse: add compound command to combine multiple
 requests
Thread-Topic: [PATCH v5 1/3] fuse: add compound command to combine multiple
 requests
Thread-Index: AQHcnbENdUUlFaKLF0Gh72gKh0Bcpg==
Date: Sat, 14 Feb 2026 12:54:27 +0000
Message-ID: <b0e7fb1f-7b5c-43f7-9198-5297775dcdf9@ddn.com>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
 <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com>
 <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com>
 <aY25uu56irqfFVxG@fedora-2.fritz.box>
 <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com>
In-Reply-To:
 <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|DM4PR19MB6487:EE_
x-ms-office365-filtering-correlation-id: 5fd43448-fbb6-4c7f-bedb-08de6bc82faa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UHFqUXFRMGVURzBwVjJrTGhaR3JmNmovcUhXM1Z3SzltV3lKU3UxT3lQYXlD?=
 =?utf-8?B?cXNHaUlhQkxTMXJiMmpucGlvc1Y3U1R3R3N6WmxPT2EveTBJWGJQOG13dmVI?=
 =?utf-8?B?SnpybTFWdUJ4SWszcFpUTlFxM01zV0wyVGJHaCt5QXpyYzdnMmVKMEZhRjRG?=
 =?utf-8?B?ek9pUEVaQ1NVSkIzdEw4aEhZbmtGb0xFN1dPc0pRL1FycW9YQUZDVURwclBa?=
 =?utf-8?B?a1BwYkRQL2J6Vk9kbVRBbFdGamJFWmNGTCtjUERCc004a1RZVFNRbkdpaFd6?=
 =?utf-8?B?MThVQU9OSWNrcnVoVi85TndKeTNmMmJmaTN0NmJCVTRvajZTbHpBNnFVaXkx?=
 =?utf-8?B?VWIyZSs4b04ybzZSaVdES1FyYzJ3R3kzcmc1YlBaK0p0UTVMbFF0RTExZzR1?=
 =?utf-8?B?R3luQVlrVFc1cjVaRmFxMXJJN2JMSXdCWE13Wng2eE1lVml5b2k0em1vd3A2?=
 =?utf-8?B?Z1AvKzB5ZUFmbit2NnlwUFFRU0JHdE12TytLRW9DeU96c2xrUTJSZkpSckpY?=
 =?utf-8?B?TDAzTXJwdGJVUmJ1ak9qVEVFMytyaVhXeWxXNDRPWUJKM3dadWZoaTk2K0gz?=
 =?utf-8?B?SjdDYU5iM0NyMHZCMHlXWkh6OWIzbHVqTk41c0VFeER5bU1uRjlLZHNmMmdS?=
 =?utf-8?B?VHZNaXhMMU1OSml4RHhpa21HMEQxbm13VzZkSU8yeE9Kamt2VVN2MkhjYUt5?=
 =?utf-8?B?MFVvVkd1S2MzU2lGWFF6blJraG16TXhzaFRBSTdQc1VXdmozdUU2TTEyMW01?=
 =?utf-8?B?aE9lazE2K01CZ1d4UVZWOWlBMGJ3UGI1RFRJczZGK003OTgxdE13VGgra0Q0?=
 =?utf-8?B?L1VYWHlJTjlZNnRPMVo2dlRDMFVWWnlsYzBIeHJ5V3dWWURUSlEzVTc1Ym1l?=
 =?utf-8?B?TWZIYWg2WDVreWM4b0V6ZjZyVFVhNGM3a1NhSVhqVEJNYzZDc2ptbU1aN0Jq?=
 =?utf-8?B?NHdrM0h2SlFXRmt2N0RUbVpBcDQyTFQwRVZaZTJsQUJqaEIvUWJITWMyVnlP?=
 =?utf-8?B?MkVGT1VpYTdoM245QWhETnRuTk1DRk5wUVpwN2lPOTlEU0M5YWpFNzFVM2xK?=
 =?utf-8?B?dUFOcElWaHEvT0g0QkFzLzFCdXBYeTlnVlFQZThiWmpLNjlzNHp5dm5LRjNz?=
 =?utf-8?B?dkphdE1KMUJXOUVRRUZPYWc0cmdBQ014cm0yTTR6TnFLUnA0Ymw4eEYzNE1G?=
 =?utf-8?B?VG5CQ1p5NjRGL0toUlVYZm1nUDVadjFoS1BvbVk5TnB1aEorV0N3T0M1R21D?=
 =?utf-8?B?eElaaGFDMjJoR1NSMlFHbGVoUFdUamFrZWpONitoaHZLMDFmUzl5Z3kxanpG?=
 =?utf-8?B?ckt4SmZBTFFrVnBhdTdiNEdvbFIyYzdwb0RNdUJmWTBSemhvK3dUR09sSVdR?=
 =?utf-8?B?Vnpkc3lvQ2t0VVUza3RqOG9BRThlaWxOY1VMaWs5U1QydkJWRU9YbTg2QVhl?=
 =?utf-8?B?cFptczJsSGx2VXllMStYSG8yREs0ZU1oaWl5b3VyTWxOYUMxVEtLUHo3RnJu?=
 =?utf-8?B?YWdCam1TT1MrVTJjbUE1NXRyY0Zib2NXYmxiM2l6WkVxcHBqMFFaenRXUFkz?=
 =?utf-8?B?S3FNODJveUlkRUlpS2taSVdMVFhwMlpSbkx6WTlpcjRTS0lqSWp4QlN6M085?=
 =?utf-8?B?QjNZQ1F5bVJjRzgwN0U4ZGhvbjFBNEFxUTlvQUF0bzFsdVhNODhCbmFlRWdL?=
 =?utf-8?B?K09OVVRxcVJ0bUg1dCtXVFE2bXhZUzVHNTlEUWdoUnRnT1VSdk9mQ1BMZ3dE?=
 =?utf-8?B?UzgxWWUrTmhGcFFpWWQ0Rit0WGdSNEhmekoyMVJrY0RiYjBEcWpuY1NqeWxK?=
 =?utf-8?B?eXVLTUtBSUxWRTNqdmp3b1YwNlQ0c0VGWXFKeUJrbjl3V0RnY2ZPSExqbXBG?=
 =?utf-8?B?QW5XMk9Wak1xQzdtVHV4dkxrN3dlLzZmdjFuOEFpdzMwN2VJNHhKandHbTVG?=
 =?utf-8?B?S3dpYmxPRkJrb0Y1WFcraW4rbUlMdmNqRzhmVGJFeEM0VC85bi9jTlY4UC9l?=
 =?utf-8?B?RkVlQU5JUG5rS3VDQm5EWjRHVmtrc2NPUmNVZWtPR3V2UUhFdTgveWg2T2h0?=
 =?utf-8?B?WUZrQlVyRDRzMlBiQUlqQUZtdUFEQ3lDL0x5bWRpUFRtMFZKQmxTMWZGWk4y?=
 =?utf-8?B?YWc3V1RKbE9scVNzd245a2FLNmk3dGd4a3RqWEN4dzdZZWFkY2svY0dJUUhR?=
 =?utf-8?Q?zvMBhK89VPyQa/uYvmF/4io=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzdmM2d3WFk4dFloc0pCOWIzbGJNSW5malBYMmlKNkdJYWFBSzJFTnAvaVJi?=
 =?utf-8?B?SkFaNXQ2U2h6V0hyN2MvMEN1bGFPck56dmJ5ZEZ0U1dFT3o3MVlZb2o3ZGpG?=
 =?utf-8?B?NmpaZmViRXJlZXQwZTkxOUo5Y2NMUllpZ1RJL1V5WU5TYmxhTjllZjFrQjhw?=
 =?utf-8?B?U2J6all0YTV4dm1XbnZ2dHJwQnpjeGhWeU8yUE53Qk9FSll2MTgzRzAyUGty?=
 =?utf-8?B?T1ZoV3lwTU4wM1FSQUZXQy9rS0hhYlg5emxTOHZzcHc1a0RtaFE2QWYyZWFk?=
 =?utf-8?B?cS9Eb3gwQk9tTUswVUF0NXVwL21iRytWWXlVdEtLRk4rQ3hyQUVRZmNiNlpn?=
 =?utf-8?B?Ny9xNFYrZi9hdDUrTWQxbG90c0NTOXJORDF2MDJjVW1hMk1ucDd6N1hRbU9U?=
 =?utf-8?B?aCtUVklRcElPdzhrRnpkUDRaaVNPUXNKb3k2cW52Ym4ySForbWlZNkt6Mms1?=
 =?utf-8?B?ZFJNVGp1YmtrN1VHQ1RVbzBwL0tHcHoyMVdub1MvYkthQy9NOHBra2E0L0Rn?=
 =?utf-8?B?UUNMSEZqL1laVG96UGxyT0dPeDlUVExNZ3VLcW5UcDZTeUpYNThlNUVSd0pu?=
 =?utf-8?B?N3BHYW0yamFoNnpMY2Q2c25ibDREcGNrRUdXVGZCSExTMngrd0hndXZtQXc4?=
 =?utf-8?B?NUtza256QVpNSUxZZi94UHF2ejBYcm82VDlwSHRndmxoSlptTC9ZVGRwL29L?=
 =?utf-8?B?QXNsUjBTZmZhNUY1Q1B5c3Q2bTQrV1dVdnJ6YnB5b3ZBYm9vQ2M3RkVEWnZ3?=
 =?utf-8?B?WXNnaVdqTDNsUHJzYkhOT2VCN2lSVDdibE83bGxEcHpTNEI3d01zeERldDcy?=
 =?utf-8?B?V2pBdlBobE1lcGhyODBmZnJPT1BnWkZ4akUzRW0wWGt3T1NxbElJWTFQUFlI?=
 =?utf-8?B?R244aVJlNEIvUnlaVmNpL1R6dHFWa1hPZS9jZmhUVnlzc01qaHFLNVF4cno3?=
 =?utf-8?B?WE9iTEFUb0VhdTBjZS94aUtZbFIrV1dsTEhYVjdxdU5odks2bUQ1ZEhKWmJi?=
 =?utf-8?B?b29MWGlYT2QxTFgwRElZcGFlazZNdWg3alBjY0FwZzFWVFFqVjlBSEZrbmoz?=
 =?utf-8?B?QmFyS1ZuaDcxMkxjTE5RS1kyVlJqT0dYSk5YYXBTM0pQUmYyNFg5N1dibDdF?=
 =?utf-8?B?UE1RNFozbktvTkhuSStjQTYyTU9DdStPYlFYaFdCclhzcjJaTDVhZ0lBSkJO?=
 =?utf-8?B?UklSZWVBY1NySUtJTjlFZnFpWk9RNVdpdTFCSzdxUERRTDVNVXBGU096RW92?=
 =?utf-8?B?dXFHQ0djY0xlWDNkR0FxME1tUkh3dGU0bHMyeUIwU2kvcVpBTDQrdWN4U2ZZ?=
 =?utf-8?B?dDNYanVzVW1Nb1RiZ2IvWkxodHJXVko1alpOWHRqSi9BajVtZFdSYmdJOFJn?=
 =?utf-8?B?cmxSYWhncE9hbDhCUkh3Ym1xOVRpY01XTHNjcGJoT2RoOURWZTBwdlhVbE9B?=
 =?utf-8?B?VkhReDZnTldldnJtSnhibnl3SWU2RU5NTG5DVlo0SXhYK1VTaGE4T2pJbTNK?=
 =?utf-8?B?UVU0b1JoWnlaMElaNTRTa0UxaDVpL2RrVEJEMkZ5b0J6c3graWFONUQzLzVr?=
 =?utf-8?B?eFlXVUxCSGRPV0lYcjFVUDBQbC8zZ2Y3Q0xNNFQ0aUNPbXpxT3kwcEhIV2ZP?=
 =?utf-8?B?WE81NHZ1RXVmaitnWHdUWWUxUGhwQ1JsQmEvL0RQSmt0M1FDaTRDTlNQSWpk?=
 =?utf-8?B?OTJsOXdLVWozOVg0bk5xQ29MNUpBZTZLRlR1YXB4VSs4N1d1ZlVzcmlyVzFG?=
 =?utf-8?B?RkpURGVGMk9GYkdFK094Ty94TCtwUklwVG5lNWU5RE5IaXBORVFZMXlObGR6?=
 =?utf-8?B?emZGd25VWVFvK2ZTVk9uMnlJQUd3T3RWdFZRTXBHUjZzZkZ5Y1dEandjRGJs?=
 =?utf-8?B?ZFlvcDhXekw2ZUVwSE5ONzBwcXhXODhpZDl5clFYeUt6M2M4VEdtN2ZVc0lX?=
 =?utf-8?B?RmZiNE9vUVpoZ2lRbkJ3blJtNmt4ZFpsKzY1TlloVThYYUgvRTVxeTQ2TU1n?=
 =?utf-8?B?NWYrSzFodXZoU1RkY2tYMmlFdXhRMGhKNDRJRkdoQjEwTDFHTHFlTVRESDdE?=
 =?utf-8?B?M3BuSVNxbGN0MVorZHBIYzRQT1N4NGthWi9NYXIzVGlwVVBJaFh6YkVUcWxS?=
 =?utf-8?B?em5UNStkV2lTRW5TMXJiNVduVnJEQUt1dGdUbm9jTE1wVjVySjNVRmZhREdI?=
 =?utf-8?B?MmJRZk1zdFJIamtreXdOZWtjMitzdGgyUjlQMml2MVBPVm4xc0FKNFpOTU1N?=
 =?utf-8?B?N3h3NE9WSUlmRnArK1JjeExKc0RQUDBPOGRoc2tndUtKRVY0SVNYOWZjc2JZ?=
 =?utf-8?B?cEJSdkRLWStzL2hwNE9hcFlMSXQ5TDlwNmRaNkwrVUNkS200UmZ5aXltSDdT?=
 =?utf-8?Q?mwx08jETip7q3pp3Mno2/AXGqjIHoNJck8za/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26234413450FE34CB57C1DA96892F1A7@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x695qQLb4ChB2ZSD1B+tc/uMHQXFb/Gv2GLjvwgqU++xSc0x4NEetCgQdfJMEaz/FbWHqZOMHS0ayQQBHEgXMoVxa0VFlLzuKRJMmgkCPc5/aIM8N8d08YjTLvloB3RdCixwyEJe0KRDVjvTzznODVuEaFkDOaE/KqMUs6ET9FgwyN7vmn6fzLSDFqVph709o8MwW/mbLSX+Pq9q3fcRdx3u1rTJwPVTfpomttSP4HhVMQkLXfNfOzsdpUtzcfDBNiaJ4MU6haphqzYcT1oQ68Lf5RQKC7JJsQLCfdrlMoLPHL30bk8g1tF9DpqWBdgZawpOKk5a+jt+QB6LY00gJvl53YKYSU4//RSFS3Pz1ccosmPDSRlBLeVtuVZUMt4H3hBIasb/lL9APkjCCm3rQySK2uXR3fPdQde6KeMl/2uAKaMct7doFgcPR1jFgA+wg20Uo/3l+01L4MxW8rFbONNZkwd/QG005q0m1OFeiwH2nLSBh2yUwMOHtc7zsFVLekfnmUtD32avMXoQo+/7IFmjl+DbSTCMHsVWD57gqtbTRZeLYX5AgGpXGuRrAlvUAw22CD9OqaOekwjDktYLIK2HUcIwutN+v+wlvacnWYCZPlBoxjRG9FHWQIrMoF8IK6ngrpkJed9zuT351+n8rQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd43448-fbb6-4c7f-bedb-08de6bc82faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2026 12:54:27.0451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ipJ+zJZo2Bvzxr7JmrBEatGMhlNRqkJS0v+hEThduJ9pMt1fgqehkMJvScoHwyJWAAQAFKsf7aY9gY2CvczAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6487
X-BESS-ID: 1771073669-104683-21195-178521-1
X-BESS-VER: 2019.3_20260211.2133
X-BESS-Apparent-Source-IP: 40.93.198.115
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqaGJhZAVgZQMC3NOCXF0MAy2d
	IoLTXJwjjNJDnV2NDANDHRzMDMxDBJqTYWADb8u1FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.271134 [from 
	cloudscan14-52.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ddn.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ddn.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77210-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,birthelmer.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bschubert@ddn.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ddn.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,birthelmer.de:email]
X-Rspamd-Queue-Id: 15C1213BF91
X-Rspamd-Action: no action

T24gMi8xNC8yNiAwMjozNSwgSm9hbm5lIEtvb25nIHdyb3RlOg0KPiBPbiBUaHUsIEZlYiAxMiwg
MjAyNiBhdCAzOjQ04oCvQU0gSG9yc3QgQmlydGhlbG1lciA8aG9yc3RAYmlydGhlbG1lci5kZT4g
d3JvdGU6DQo+Pg0KPj4gT24gVGh1LCBGZWIgMTIsIDIwMjYgYXQgMTE6NDM6MTJBTSArMDEwMCwg
QmVybmQgU2NodWJlcnQgd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9uIDIvMTIvMjYgMTE6MTYsIE1p
a2xvcyBTemVyZWRpIHdyb3RlOg0KPj4+PiBPbiBUaHUsIDEyIEZlYiAyMDI2IGF0IDEwOjQ4LCBC
ZXJuZCBTY2h1YmVydCA8YmVybmRAYnNiZXJuZC5jb20+IHdyb3RlOg0KPj4+Pj4gT24gMi8xMi8y
NiAxMDowNywgTWlrbG9zIFN6ZXJlZGkgd3JvdGU6DQo+Pj4+Pj4gT24gV2VkLCAxMSBGZWIgMjAy
NiBhdCAyMTozNiwgQmVybmQgU2NodWJlcnQgPGJlcm5kQGJzYmVybmQuY29tPiB3cm90ZToNCj4+
Pj4+Pg0KPj4+Pg0KPj4+Pj4+IFNvIGFzIGEgZmlyc3QgaXRlcmF0aW9uIGNhbiB3ZSBqdXN0IGxp
bWl0IGNvbXBvdW5kcyB0byBzbWFsbCBpbi9vdXQgc2l6ZXM/DQo+Pj4+Pg0KPj4+Pj4gRXZlbiB3
aXRob3V0IHdyaXRlIHBheWxvYWQsIHRoZXJlIGlzIHN0aWxsIEZVU0VfTkFNRV9NQVgsIHRoYXQg
Y2FuIGJlIHVwDQo+Pj4+PiB0byBQQVRIX01BWCAtMS4gTGV0J3Mgc2F5IHRoZXJlIGlzIExPT0tV
UCwgQ1JFQVRFL09QRU4sIEdFVEFUVFIuIExvb2t1cA0KPj4+Pj4gY291bGQgdGFrZSA+NEssIENS
RUFURS9PUEVOIGFub3RoZXIgNEsuIENvcHlpbmcgdGhhdCBwcm8tYWN0aXZlbHkgb3V0IG9mDQo+
Pj4+PiB0aGUgYnVmZmVyIHNlZW1zIGEgYml0IG92ZXJoZWFkPyBFc3BlY2lhbGx5IGFzIGxpYmZ1
c2UgbmVlZHMgdG8gaXRlcmF0ZQ0KPj4+Pj4gb3ZlciBlYWNoIGNvbXBvdW5kIGZpcnN0IGFuZCBm
aWd1cmUgb3V0IHRoZSBleGFjdCBzaXplLg0KPj4+Pg0KPj4+PiBBaCwgaHVnZSBmaWxlbmFtZXMg
YXJlIGEgdGhpbmcuICBQcm9iYWJseSBub3Qgd29ydGggZG9pbmcNCj4+Pj4gTE9PS1VQK0NSRUFU
RSBhcyBhIGNvbXBvdW5kIHNpbmNlIGl0IGR1cGxpY2F0ZXMgdGhlIGZpbGVuYW1lLiAgV2UNCj4+
Pj4gYWxyZWFkeSBoYXZlIExPT0tVUF9DUkVBVEUsIHdoaWNoIGRvZXMgYm90aC4gIEFtIEkgbWlz
c2luZyBzb21ldGhpbmc/DQo+Pj4NCj4+PiBJIHRoaW5rIHlvdSBtZWFuIEZVU0VfQ1JFQVRFPyBX
aGljaCBpcyBjcmVhdGUrZ2V0YXR0ciwgYnV0IGFsd2F5cw0KPj4+IHByZWNlZGVkIGJ5IEZVU0Vf
TE9PS1VQIGlzIGFsd2F5cyBzZW50IGZpcnN0PyBIb3JzdCBpcyBjdXJyZW50bHkgd29ya2luZw0K
Pj4+IG9uIGZ1bGwgYXRvbWljIG9wZW4gYmFzZWQgb24gY29tcG91bmRzLCBpLmUuIGEgdG90YWxs
eSBuZXcgcGF0Y2ggc2V0IHRvDQo+Pj4gdGhlIGVhcmxpZXIgdmVyc2lvbnMuIFdpdGggdGhhdCBM
T09LVVANCj4+Pg0KPj4+IFllcywgd2UgY291bGQgdXNlIHRoZSBzYW1lIGZpbGUgbmFtZSBmb3Ig
dGhlIGVudGlyZSBjb21wb3VuZCwgYnV0IHRoZW4NCj4+PiBpbmRpdmlkdWFsIHJlcXVlc3RzIG9m
IHRoZSBjb21wb3VuZCByZWx5IG9uIGFuIHViZXIgaW5mby4gVGhpcyBpbmZvDQo+Pj4gbmVlZHMg
dG8gYmUgY3JlYXRlZCwgaXQgbmVlZHMgdG8gYmUgaGFuZGxlZCBvbiB0aGUgb3RoZXIgc2lkZSBh
cyBwYXJ0IG9mDQo+Pj4gdGhlIGluZGl2aWR1YWwgcGFydHMuIFBsZWFzZSBjb3JyZWN0IG1lIGlm
IEknbSB3cm9uZywgYnV0IHRoaXMgc291bmRzDQo+Pj4gbXVjaCBtb3JlIGRpZmZpY3VsdCB0aGFu
IGp1c3QgYWRkaW5nIGFuIGluZm8gaG93IG11Y2ggc3BhY2UgaXMgbmVlZGVkIHRvDQo+Pj4gaG9s
ZCB0aGUgcmVzdWx0Pw0KPj4NCj4+IEkgaGF2ZSBhIGZlZWxpbmcgd2UgaGF2ZSBkaWZmZXJlbnQg
dXNlIGNhc2VzIGluIG1pbmQgYW5kIG1pc3VuZGVyc3RhbmQgZWFjaCBvdGhlci4NCj4+DQo+PiBB
cyBJIHNlZSBpdDoNCj4+IEZyb20gdGhlIGRpc2N1c3Npb24gYSB3aGlsZSBhZ28gdGhhdCBhY3R1
YWxseSBzdGFydGVkIHRoZSB3aG9sZSB0aGluZyBJIHVuZGVyc3RhbmQNCj4+IHRoYXQgd2UgaGF2
ZSBjb21iaW5hdGlvbnMgb2YgcmVxdWVzdHMgdGhhdCB3ZSB3YW50IHRvIGJ1bmNoIHRvZ2V0aGVy
IGZvciBhDQo+PiBzcGVjaWZpYyBzZW1hbnRpYyBlZmZlY3QuIChzZWUgT1BFTitHRVRBVFRSIHRo
YXQgc3RhcnRlZCBpdCBhbGwpDQo+Pg0KPj4gSWYgdGhhdCBpcyB0cnVlLCB0aGVuIGJ1bmNoaW5n
IHRvZ2V0aGVyIG1vcmUgY29tbWFuZHMgdG8gY3JlYXRlICdjb21wb3VuZHMnIHRoYXQNCj4+IHNl
bWFudGljYWxseSBsaW5rZWQgc2hvdWxkIG5vdCBiZSBhIHByb2JsZW0gYW5kIHdlIGRvbid0IG5l
ZWQgYW55IGFsZ29yaXRobSBmb3INCj4+IHJlY29zbnRydWN0aW5nIHRoZSBhcmdzLiBXZSBrbm93
IHRoZSBzZW1hbnRpY3Mgb24gYm90aCBlbmRzIGFuZCBjcmFmdCB0aGUgY29tcG91bmRzDQo+PiBh
Y2NvcmRpbmcgdG8gd2hhdCBpcyB0byBiZSBhY2NvbXBsaXNoZWQgKHRoZSBmdXNlIHNlcnZlciBq
dXN0IHByb3ZpZGVzIHRoZSAnaG93JykNCj4+DQo+PiBGcm9tIHRoZSBuZXdlciBkaXNjdXNzaW9u
IEkgaGF2ZSBhIGZlZWxpbmcgdGhhdCB0aGVyZSBpcyB0aGUgaWRlYSBmbG9hdGluZyBhcm91bmQN
Cj4+IHRoYXQgd2Ugc2hvdWxkIGJ1bmNoIHRvZ2V0aGVyIGFyYml0cmFyeSByZXF1ZXN0cyB0byBo
YXZlIHNvbWUgcGVyZm9ybWFuY2UgYWR2YW50YWdlLg0KPj4gVGhpcyB3YXMgbm90IG15IGluaXRp
YWwgaW50ZW50aW9uLg0KPj4gV2UgY291bGQgZG8gdGhhdCBob3dldmVyIGlmIHdlIGNhbiBmaWxs
IHRoZSBhcmdzIGFuZCB0aGUgcmVxdWVzdHMgYXJlIG5vdA0KPj4gaW50ZXJkZXBlbmRlbnQuDQo+
IA0KPiBJIGhhdmUgYSBzZXJpZXMgb2YgKHZlcnkgdW5wb2xpc2hlZCkgcGF0Y2hlcyBmcm9tIGxh
c3QgeWVhciB0aGF0IGRvZXMNCj4gYmFzaWNhbGx5IHRoaXMuIFdoZW4gbGliZnVzZSBkb2VzIGEg
cmVhZCBvbiAvZGV2L2Z1c2UsIHRoZSBrZXJuZWwNCj4gY3JhbXMgaW4gYXMgbWFueSByZXF1ZXN0
cyBvZmYgdGhlIGZpcSBsaXN0IGFzIGl0IGNhbiBmaXQgaW50byB0aGUNCj4gYnVmZmVyLiBPbiB0
aGUgbGliZnVzZSBzaWRlLCB3aGVuIGl0IGl0ZXJhdGVzIHRocm91Z2ggdGhhdCBidWZmZXIgaXQN
Cj4gb2ZmbG9hZHMgZWFjaCByZXF1ZXN0IHRvIGEgd29ya2VyIHRocmVhZCB0byBwcm9jZXNzL2V4
ZWN1dGUgdGhhdA0KPiByZXF1ZXN0LiBJdCB3b3JrZWQgdGhlIHNhbWUgd2F5IG9uIHRoZSBkZXYg
dXJpbmcgc2lkZS4gSSBwdXQgdGhvc2UNCj4gY2hhbmdlcyBhc2lkZSB0byB3b3JrIG9uIHRoZSB6
ZXJvIGNvcHkgc3R1ZmYsIGJ1dCBpZiB0aGVyZSdzIGludGVyZXN0DQo+IEkgY2FuIGdvIGJhY2sg
dG8gdGhvc2UgcGF0Y2hlcyBhbmQgY2xlYW4gdGhlbSB1cCBhbmQgcHV0IHRoZW0gdGhyb3VnaA0K
PiBzb21lIHRlc3RpbmcuIEkgZG9uJ3QgdGhpbmsgdGhlIHdvcmsgb3ZlcmxhcHMgd2l0aCB5b3Vy
IGNvbXBvdW5kDQo+IHJlcXVlc3RzIHN0dWZmIHRob3VnaC4gVGhlIGNvbXBvdW5kIHJlcXVlc3Rz
IHdvdWxkIGJlIGEgcmVxdWVzdCBpbnNpZGUNCj4gdGhlIGxhcmdlciBiYXRjaC4NCj4gDQo+Pg0K
Pj4gSWYgd2UgY2FuIHNpZ25hbCB0byB0aGUgZnVzZSBzZXJ2ZXIgd2hhdCB3ZSBleHBlY3QgYXMg
cmVzdWx0DQo+PiAoYXQgbGVhc3QgdGhlIGFsbG9jYXRlZCBtZW1vcnkpIEkgdGhpbmsgd2UgY2Fu
IGRvIGJvdGgsIGJ1dCBJIHdvdWxkIGxpa2UgdG8gaGF2ZSB0aGUNCj4+IGVtcGhhc2lzIG1vcmUg
b24gdGhlIHNlbWFudGljIGdyb3VwaW5nIGZvciB0aGUgbW9tZW50Lg0KPj4NCj4+IERvIHlvdSBn
dXlzIHRoaW5rIHRoYXQgdGhlcmUgd2lsbCBldmVyIGJlIGEgZnVzZSBzZXJ2ZXIgdGhhdCBkb2Vz
bid0IHN1cHBvcnQgY29tcG91bmRzDQo+PiBhbmQgYWxsIG9mIHRoZW0gYXJlIGhhbmRsZWQgYnkg
c29tZXRoaW5nIGxpa2UgbGliZnVzZSBhbmQgdGhlIHJlcXVlc3QgaGFuZGxlcnMgYXJlIGp1c3QN
Cj4+IGNhbGxlZCB3aXRob3V0IGhhdmluZyB0byBoYW5kbGUgbm90IGV2ZW4gb25lIHVuc2VwYXJh
dGViYWxlIHNlbWFudGljICdncm91cCc/DQo+IA0KPiBJZiBJJ20gdW5kZXJzdGFuZGluZyB0aGUg
cXVlc3Rpb24gY29ycmVjdGx5LCB5ZXMgaW1vIHRoaXMgaXMgbGlrZWx5Lg0KPiBCdXQgSSB0aGlu
ayB0aGF0J3MgZmluZS4gSW4gbXkgb3BpbmlvbiwgdGhlIG1haW4gYmVuZWZpdCBmcm9tIHRoaXMg
aXMNCj4gc2F2aW5nIG9uIHRoZSBjb250ZXh0IHN3aXRjaGluZyBjb3N0LiBJIGRvbid0IHJlYWxs
eSBzZWUgdGhlIHByb2JsZW0NCj4gaWYgbGliZnVzZSBoYXMgdG8gaXNzdWUgdGhlIHJlcXVlc3Rz
IHNlcGFyYXRlbHkgYW5kIHNlcXVlbnRpYWxseSBpZg0KPiB0aGUgcmVxdWVzdHMgaGF2ZSBkZXBl
bmRlbmN5IGNoYWlucyBhbmQgIHRoZSBzZXJ2ZXIgZG9lc24ndCBoYXZlIGENCj4gc3BlY2lhbCBo
YW5kbGVyIGZvciB0aGF0IHNwZWNpZmljIGNvbXBvdW5kIHJlcXVlc3QgY29tYm8gKHdoaWNoIGlt
byBJDQo+IGRvbid0IHRoaW5rIGxpYmZ1c2Ugc2hvdWxkIGV2ZW4gYWRkLCBhcyBJIGRvbnQgc2Vl
IHdoYXQgdGhlIHB1cnBvc2Ugb2YNCj4gaXQgaXMgdGhhdCBjYW4ndCBiZSBkb25lIGJ5IHNlbmRp
bmcgZWFjaCByZXF1ZXN0IHRvIGVhY2ggc2VwYXJhdGUNCj4gaGFuZGxlciBzZXF1ZW50aWFsbHkp
Lg0KDQpUaGluayBvZiBzc2hmcyBhbmQgb3BlbitnZXRhdHRyIGFuZCBhIGxhdGVuY3kgb2YgfjFz
IHBlciByZXF1ZXN0LiBJLmUuDQplc3BlY2lhbGx5IGlmIHlvdSBnbyBvdmVyIHRoZSB3aXJlLCB5
b3Ugd2FudCB0byBidW5kbGUgYXMgbXVjaCBhcw0KcG9zc2libGUuIEknbSBhd2FyZSB0aGF0IHNm
dHAgY3VycmVudCBkb2VzIG5vdCBoYW5kbGUgb3BlbitnZXRhdHRyLCBidXQNCm9uY2UgZnVzZSB3
b3VsZCBzdXBwb3J0IGl0IGFzIGNvbXBvdW5kLCB3ZSB3b3VsZCBoYXZlIGEgZ29vZCB1c2UgY2Fz
ZS4NCkFuZCB3aGlsZSB0aGUgMXMgbGF0ZW5jeSBpcyBjb3JuZXIgY2FzZSwgYWx0aG91Z2ggbm90
IGV2ZW4gdG9vIHVuY29tbW9uDQp3aXRoIHNzaGZzLCBpdCBhcHBsaWVzIHRvIGFueSBuZXR3b3Jr
IGZpbGUgc3lzdGVtIC0geW91IGFsd2F5cyB3YW50IHRvDQpzZW5kIGFzIG11Y2ggYXMgcG9zc2li
bGUgb3ZlciB0aGUgd2lyZSBpbiBvbmUgYnVmZmVyLiBUaGUNCmtlcm5lbC91c2Vyc3BhY2UgaW50
ZXJmYWNlIGlzIGxpa2VseSBub3QgdGhlIGxpbWl0IGhlcmUuDQoNCg0KVGhhbmtzLA0KQmVybmQN
Cg==

