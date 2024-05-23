Return-Path: <linux-fsdevel+bounces-20052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1EC8CD34C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 15:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52FB28188E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAF014A4DD;
	Thu, 23 May 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PBxg44/B";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a+vmcYeC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92D14A0A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469838; cv=fail; b=tLNIS7jxkSLOFUYvZZCQfxJfsUA+/khAGc88eO8+GlmuGuZs6JMSBVulYOB0pf/NgkQTAT3r35r5O67kE6lCGEG0BQ4yFX6G6QVQxEZATEGRv+l8QcjDDdXzql7I1FrCUOqrvkyWffqByDb9SBcL/kVeryIHi3unONk9dR8IzRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469838; c=relaxed/simple;
	bh=F+8EBzI5xW7Kx2D223tRStctum8EHc8rQMPaoLfIKyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kI0CFLHsP5oEKH8DvEXo/53DxDw0BR9i9uNuXLyFALphT3sp/2+AYCh0dXRLmknha37vqHGaLFXGUniJPQNpSA8FP3Ot9K+c2kJuiVZhW+yJTswmjOGIlxaE6dRwx7QaG2EA0n3tgZ5nHQAF11ieQxpHEDm8SieYFJMKiTNyaVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PBxg44/B; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=a+vmcYeC; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716469836; x=1748005836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F+8EBzI5xW7Kx2D223tRStctum8EHc8rQMPaoLfIKyo=;
  b=PBxg44/Bnz5YQgl4l1Yo8En3FeUlLpvphoSzRaJfSvRsWXJgIGJeU5+H
   cyFxuJTWKlR5g8GSWvMxJIrqktz9n21z9WRtr5yzkmwT3DeN/S7fsnqrf
   Q9nkLemfh3IjQNyHwu7c4nHFR3M6UHhQ4LVK/Jb6us2r7Fue4ixyYeKZq
   kj/bD3XmOsukgSy1XDrvKHeGjoBAdWNeZmmVvJPYk/5hjSr/IVPhJn8DH
   ypAcf++8JxSJ0BqiiCGwJ8pQ02xCbRShVCIsYcT1Nbz46Uqf+aMBrYS/q
   fhSJWbGAgha2+DC11fRtO7zensYEgh1YZQlGJR5/PduxF35OS9UvZfmtW
   Q==;
X-CSE-ConnectionGUID: 8NytGHSMSnORezplIk2eKQ==
X-CSE-MsgGUID: UO4iy48TQ3K0fTW/1RqBIQ==
X-IronPort-AV: E=Sophos;i="6.08,182,1712592000"; 
   d="scan'208";a="16406246"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2024 21:10:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWhb9YtDbNfpSowhmap7qCHend8VRE731hBJ1UreYM353AVZNO/tbA+ZqEv/07ikKwuKo9vT2t+dZ5LYO+sChSAfdF3cX6fml0SEsTcGP57tstU9HcwJjvhNrlaaoHPM9PTcWuDzWq742ALs/iUEUjl94S8Ggtt04ktMJahmryo6uMw3TvDZGDznGU2k7oVmZ2ss/hkw3wR/j4302ynKR/Mrl+a9W9nfpvdZn/+HbTiNwK08W/rWLgb7pfFp7YMuz92Pj5rqC4ClzEqfcj1xmYJP9jlMpka0iQy3Vzo80A88wS+yuqcETq/7Y2IaLgoxfPwjc0U0ojgiJ1ouyse4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+8EBzI5xW7Kx2D223tRStctum8EHc8rQMPaoLfIKyo=;
 b=VqqvOrqnYP+qIP7/OuLGrPDgfPgY85S0z9qt+F106IjT9dhCOQiosDzUlFn0aaW3pjHxIcX8aZtz/lJ2HSususzHlMeTvHoZy/FuoxTQoZPN9ft810WP80RNR7YxSzDp2nV6SgL/DqCeumNgYDbcYjl6MsMOPIgrTZ8eXtdAsbV5GUJylzuZaXJwtJgh+DjXrfkDHvYwHPwcovYgRna750u1sEtUxa65prNQaVRoNFL500jPFZxtLXBBfglOSKCHnoMHBPPHGtYPcjOaye1rGV0RxHcw64E4Zi01+qP5qfZPi4sWnmShqR4pi55rkuosPjLyPiUtXrtfLOLOwRqcOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+8EBzI5xW7Kx2D223tRStctum8EHc8rQMPaoLfIKyo=;
 b=a+vmcYeCLkFKhnK7tGU8A9emwad1ZqnSfyjFIvCY3pvA5Ji2/rpzhdkRjISRovEkf04xGXNbNDZqs1BZ6IHJwz4zMZFbkh76q3MEXIFKAbtu2o7UrcYB0SHVpOq1A/nLLQ7E86/DMIlqgbA9kcPT3dJ5/yIVv+gc5TDfNqzoZKA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8223.namprd04.prod.outlook.com (2603:10b6:806:1e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 13:10:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 13:10:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] zonefs: move super block reading from page to folio
Thread-Topic: [PATCH v2] zonefs: move super block reading from page to folio
Thread-Index: AQHarRFtSciHNldruU2IgubTjJ8qsrGkywsA
Date: Thu, 23 May 2024 13:10:33 +0000
Message-ID: <315528c0-b108-42f5-8f13-b5766e2a3917@wdc.com>
References: <20240523130153.27537-1-jth@kernel.org>
In-Reply-To: <20240523130153.27537-1-jth@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8223:EE_
x-ms-office365-filtering-correlation-id: c5709c25-61b4-4d2f-8e7a-08dc7b29ba7c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWlnM05NbnY4ZFFKbTNUZVc2c0ZobjRTUjdRVGRDNE03dVVoZE4vYk5CUVk3?=
 =?utf-8?B?OVhyOWViYVZlL3RPdkdMREYycDNET3hCQThzWldMNGdSbFFsZ3YvdEVZcTkr?=
 =?utf-8?B?RjVmaUJxQzR4RVV3Yjg1bFdMZzI2N3lkTy9JZjIwcVNhNWJqcXE4WjFURGFG?=
 =?utf-8?B?SjBNMmN1QWVQV2k5Z1d5eldRakNNZWpFYmtPclV6Ym9ob2wzYm56SU9BRmFL?=
 =?utf-8?B?YXdPWWxkQWJ1ZUxXb3NwOXNobHpQQSs3bzlQSjhSQm83VGxiV2R3Q0xwU3JL?=
 =?utf-8?B?SDhZN1NGY1NKRjNNZkE0YkNhM2N4STFJU2xFL3hGSG1YMmIvS3kwV0pMUzMw?=
 =?utf-8?B?MmJvYkpYSVFySkx0a3lQbEh3LzVMRXJBRHVaQllzblBiQ3BqYXJleHlTNm40?=
 =?utf-8?B?dER2Z1VGT0xaUkVpazB0QzlGMGdJQXVnTUEvN0FCMXFQOHdOSFFNeU5POFZQ?=
 =?utf-8?B?NWRNYzJlR2JBWkJtZXJxR2dMaXk0ZmFqSDdGL1N5VWE5TW80UllidE5PdmlJ?=
 =?utf-8?B?RFN4WjhZRzYzY29jL3JnNHJQVDRQQll2Q1ozRUh0amQwVTVlb2lhYktMZDhC?=
 =?utf-8?B?dENQUUZFWUl6R01rOWo0SmVDZTlnTzJkRFZHRkhadk5QZkJ3MU9oRFFPYUhy?=
 =?utf-8?B?YUJsM01ObFM0bVI5NDV2STRoUFVadTQ2V25VdGF6UnVad3FYSUt6Q09oS082?=
 =?utf-8?B?TjNJb1hWcEhJQjREY2hsMEY2b2xKR2ZKaXFYZUpRMEtKaDRLSklRQTFTZFpv?=
 =?utf-8?B?WjdCbEM3Qm1PQ2FVVjV2c25WTEZLcUxrWHJoM2hjdzFaMW5ST0tleG1BdG9B?=
 =?utf-8?B?NWgwa1YxaDNoMzN0OGx5SVpZaEZlYWFsQWVJQm40cUZFMzYxMjgySWp0M1Jj?=
 =?utf-8?B?VTRLMk5TN2VOdnU3dmduVVF3ODZNaXc2VHY2SDhXTWdITlZROGx1WEZjMVJh?=
 =?utf-8?B?R2hjcUZiNEJtR3JhS0UzNllTbndIZWJ4azQvVXJDNzZPemNmQnUxRW52dkxx?=
 =?utf-8?B?RERUaE5GcWJLcmNEVGJwV1R0MWRBOC84SzAzbTlqZzZjbm5TRzY0TEZiNUx2?=
 =?utf-8?B?R0krTTEzaHpMdUVrOVRCajMvMGh3ZFA1RVdodVZjZ2tOcGw1ZVN1ZzdQeW5n?=
 =?utf-8?B?VDB1bnRnN1lnWEpnanhadTc4QThxMytVVmJFaHJsNUN2S3JlcUorNDFoWDR2?=
 =?utf-8?B?bzYzamY3REFsa1ZWZFdJaGNVNmJXeFFmQit0TU9mcFd0MjhsMVdRN2J4YWl1?=
 =?utf-8?B?VU1yQThKQVU1Q1FlN0lkVk1qc3ZBdzdYK2ZoVGxSSS8zWENtVUo5dG0rUVlV?=
 =?utf-8?B?TTZrbU9GS1ptQzhPTmRkdjhsTmRENFhZamxSNlBUM3dVWUlFVTZZVzhqWkt3?=
 =?utf-8?B?dXU5NVlDNXZFczAyTEhwbWZEaUJpeXM1c2Z6ZktkSDFwOFRidE5KaVd2enZJ?=
 =?utf-8?B?MGFmTVNoS1ZSU2p2RmtZTzJjTHg5bkhlT3ZTWmdxUkJBZEVTdE93c2o3cThZ?=
 =?utf-8?B?bWllNkZsVTBnbW51YlB3ZkZlMzZxaXZTdEJRWjJyVmw5UUsrRmJNRzNjalBq?=
 =?utf-8?B?SHZBa2F2bm5YUTZYM3c5bmVmdTNmTGRjYXc3bHFScE1rbmR0WmFVcFo2cFEx?=
 =?utf-8?B?Y254Ym1PNUVKSDhFdXc0dUJjVjFCTFhVUWplYmpwOE9kMVJrUDN6ekkvaVRs?=
 =?utf-8?B?c0RFYldvK3RpTEV2aWxkUmRKTEJkcWpoV1dyYXJKbFhPQXA0eXQ4ZTZ2d01r?=
 =?utf-8?B?cFhDRHVuUlZzNWt1b0ZjL2taZnhVWVFkVEhYRG1Db3MxSzVWc3dWUzJMMUhm?=
 =?utf-8?B?bHBVbklpRnFqdlRiMXlLQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cStUWWhDS0VaYUhQTWVJRzJTUzQ3aEpieUdGVU9GaWxSZUZyQkV0MEk2ZGsy?=
 =?utf-8?B?WmhoUHJRRVBnYlhWZXV4TlNuZGVIYUdJNFBqU1BaY3RNT2ZHbTBOcEJvNEIv?=
 =?utf-8?B?Ni9PR3RpQzRyanpESXBrL1hITnVBM1l6QzlMV1E0MzRQUWFpYkVITkFNeXJR?=
 =?utf-8?B?bno3cE9XeEdqNmdWOEVzaVJCa2dSYU5KQURoeXBjRk1jWEtqL0V6K0pzY1NT?=
 =?utf-8?B?ZmxYcG84b1AyS2VmVlJuckR2aFE2Y0VOalJiZTllbVNNcXlWaWhJSEZ2akJt?=
 =?utf-8?B?RGkwNU9VZ1hIY0dMWU9QbWQ2M1JjeHBwR09LTlh6c2wycVBMZHVwTFl4d0Jv?=
 =?utf-8?B?a3Z4U0MyUVg2SWROY014d055em1hYlRsR0Nwcm40NWIybEowSnBYWUZJaGJY?=
 =?utf-8?B?ZmF6VDYyWXhwemZJbFBlbzJwZzhONUVrWVpQVFB4ZFdxZjJ3REpvQXB4QU1p?=
 =?utf-8?B?UHF3MDRQNDdiajVacG9zNGdUbDJSMTN5ditybXE2M0p6ZVo5aTZ1L21rbnRP?=
 =?utf-8?B?NUwvWWZ1dGtTenE3STNuWXpudXhsNE83b00vQTJ5YkpPcXpvaVZWcFR0NStk?=
 =?utf-8?B?MnY1Q0JQUitxUGZYYnpJOHd0NEF1aW5qcCt0TTc0WDNGWHlOVVJNaHU2eTc0?=
 =?utf-8?B?bnRsSUZNM1U2MHpkZ09GNkNheUMyRU9PcklMMUc4TFl2TVlLdUVsZFVtWWph?=
 =?utf-8?B?U040SC9VOGVmUVhmT0FQaWNLdWlsaHNIbjhaWjQvb29FOE9BdVV6UFRtdklU?=
 =?utf-8?B?cE1TUllHRXFIeDBMR3BLUWpYOFNSWnFxSnBjSkxtMStZaFRBT0lMVW0xckFD?=
 =?utf-8?B?SE0zU0ZLVGNUNkxMVklsMGdsYU81c2EwOGplTUFBSDhGTUFsVCswNWtsQi9s?=
 =?utf-8?B?L0NERmZaS2N4aElnODBkVHlFc0lxQlY0WkJEbk96Um9TbDQ5MWd5anR5bnFE?=
 =?utf-8?B?NWhBbzFYQWpmbEVIakZ3c29lQnFUV1VuNzBoTXZVblBUL3Bad1VDd2ZnTlBL?=
 =?utf-8?B?Um1nYW03UklZS1pVeVduNTdEeHpleXhNcG9sbVJLOUUzWi83Uk94eWt3Q3Nk?=
 =?utf-8?B?TnpYTnQ0Y3lqYVEvK0NrYWtIUkpLd25qcTFlR29PeHVUZU1ib09rU3ozaGJI?=
 =?utf-8?B?dGZiRHhFejV6bjFseUpJUmVoNU0yc1NsWUJiVmo2S0xodmhjcC9NMVlYZ21C?=
 =?utf-8?B?dUltamJ4TWpYSGhreEcrQUZ0S29DdGpOLzlvMmJXU1hSZWJjWk1DcG8reG80?=
 =?utf-8?B?cWtaWXc4dVRhdEY0Tm1ZUUxsVVFDM1VsY3ljbFdlNjFiRncrU2FtYjM3UmFx?=
 =?utf-8?B?K0pRclVZRlMzVklYUVZSS3Z4ZXhDUXBIUVQ0ekFmaGthVDlsL0JYcW9CZ1dZ?=
 =?utf-8?B?Y2lpeHZ1eHNPalVMWGF1Y1BoVDRhUk5KR0VocFpEbUlzbXZZNUFZTkJWeVdD?=
 =?utf-8?B?Uy83K3ZqMmhNNE5NTEFnYTJPUGNWZzNYTHNWL2Jmb0xMa1BLSXU4RVRPL0Qw?=
 =?utf-8?B?dGViOHZxUGFJWUhhTnIrRUZVWDN1QVQvVU80dEFiMU1MY1VOYW5LSE9LRiti?=
 =?utf-8?B?WVdtL05MM3JXTjk5di9VSVhWUFVFaEp6VnZLeGhCTmovbXZ5NlRaZjJvL1JQ?=
 =?utf-8?B?WFFXQjVjaHdMWndhbzNkMGlkSFgvbzNFbFozTHpGeGxSSS9VcXpnaU9HTnZo?=
 =?utf-8?B?L0hhOHdlTDRzcVhueE1EUUNlZ0ZWQ1JSeVFkNGEzUEUyTFlTZkhnenEvVnJE?=
 =?utf-8?B?STM3dWEvTkZZWnhLNkR4THpwT2NxbW1oeHlkdzIrNUlKL1NRRm4vY0tqVEdt?=
 =?utf-8?B?eWJWK3RYRUhYc2ZwallHVWtpV0VXZTJtYnN3R0w2NVdQd2xjemRFRnRlNllP?=
 =?utf-8?B?RitnT0xhbzNRUU9pRXZ2UXhVN3NPZUp5eGlsNnR6NXk0OU5obUtWVE9lN3lC?=
 =?utf-8?B?Ym13V0R6eXlES1BPdUtTUnUvaCtCUERacXBhZFA2RDYvZTNYUytUOEFISWh4?=
 =?utf-8?B?bENvQ3RZR2Z3WVVsbitkNGd2R0dTRFRxVjVhL3NGWHJhQ2d6aU9LTmNwQ3lG?=
 =?utf-8?B?Zis0Tkk4NjQ1WjNnZ1cxd0tMTHVwODhyYW5YVTFMTWdIOHRkb2JKSExHWHY4?=
 =?utf-8?B?QmRWaDlTdGQwZFAwZDJWSEIwL0gzSVZNMUhUeG9IYkxONGtpaGZSSlFYdHVr?=
 =?utf-8?B?R1JwdExrcjJTRWduQ0JJWTNkeVZ2d1lJckdzeHdIVHZ6RE1WTzQ1RXM0YUFP?=
 =?utf-8?B?ZHlyWUpRc0ZSYkFFcDFiVkRUOVN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <721C1D4E84FF6543BBC1BCE4B0DF5B38@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rxmxJeCYQTo+kUfPhz1sbqYuyvTqH8ttG7K0MgVDJOtiItXlFCPLIQtP71cDpW1alF8Mh/EHCJikPtPk7w1SCho8vnHo+0VhVYm8FZ1HbROwU4+ch2Pi6L4DtghsMtEyNx3sG5LUSjvK3vokN5QZJ0oVcFFLe+dDWFUsXKYvrd20aMh5pUf9d/StNY132H7K75WHvQYNl2F/J/mjPdWhYPyum5CNPkiOuPhFpIddYXV+pXgXZadl0YqBptyWcofD7JssU93I+oIOrLcHlrmnt6SHABQiwUcjNv81dOpB68699VbEp4Msn1GhOkjcPpTpp+Cio7mLFS6rcDXkkWjbKNjIhcN8NC677Ec2mAV5ULT2/OubSw2EMv14t12aAflnkyMi+BqZis6AlBcN6Urn0EZFmte3Gyhbs5h2Glso7Ah8uYrYDfHMY5t7I8c2sdQG+FuF8VqNiSCkCUEiR1oyzQVB8FE88DAF27wRjxjyLuW94+CYgeVifeAhHaLyxSJCt0JJWj+5xG2pv4y06a8cRCxrNdvxiVg4MjS9tXD8smu2A3ERihM3dZd2WvbxkNDedwb2cZlZYQGZ5KWqNfhT2+EUo0w34Hn1j8wnm6MHfb+KTjJ/BH7T2G0OJv2SLf8D
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5709c25-61b4-4d2f-8e7a-08dc7b29ba7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 13:10:33.2075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGrQ0M+V+NRNmo+BRb83LobdxnhR431+sTjgtMiNj7mvNEQoVR9JSzY7Lkf8cz6mHUAzixY71ks43JQQin9/mDoSc9uIH0TPTCaXNM3JkA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8223

T24gMjMuMDUuMjQgMTU6MDIsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gRnJvbTogSm9o
YW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gDQo+IE1vdmUg
cmVhZGluZyBvZiB0aGUgb24tZGlzayBzdXBlcmJsb2NrIGZyb20gcGFnZSB0byBmb2xpb3MuDQo+
IA0KPiBDYzogTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+DQo+IFNpZ25lZC1v
ZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+
IC0tLQ0KPiAgIGZzL3pvbmVmcy9zdXBlci5jIHwgMzUgKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMjEgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvem9uZWZzL3N1cGVyLmMgYi9mcy96b25l
ZnMvc3VwZXIuYw0KPiBpbmRleCBmYWYxZWI4Nzg5NWQuLjAxYTAxY2MzZTBlNCAxMDA2NDQNCj4g
LS0tIGEvZnMvem9uZWZzL3N1cGVyLmMNCj4gKysrIGIvZnMvem9uZWZzL3N1cGVyLmMNCj4gQEAg
LTExMDksMzAgKzExMDksMjMgQEAgc3RhdGljIGludCB6b25lZnNfaW5pdF96Z3JvdXBzKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IpDQo+ICAgc3RhdGljIGludCB6b25lZnNfcmVhZF9zdXBlcihzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiKQ0KPiAgIHsNCj4gICAJc3RydWN0IHpvbmVmc19zYl9pbmZvICpz
YmkgPSBaT05FRlNfU0Ioc2IpOw0KPiArCXN0cnVjdCBhZGRyZXNzX3NwYWNlICphZGRyZXNzX3Nw
YWNlID0gc2ItPnNfYmRldi0+YmRfaW5vZGUtPmlfbWFwcGluZzsNCj4gICAJc3RydWN0IHpvbmVm
c19zdXBlciAqc3VwZXI7DQo+ICAgCXUzMiBjcmMsIHN0b3JlZF9jcmM7DQo+IC0Jc3RydWN0IHBh
Z2UgKnBhZ2U7DQo+ICAgCXN0cnVjdCBiaW9fdmVjIGJpb192ZWM7DQo+ICAgCXN0cnVjdCBiaW8g
YmlvOw0KPiArCXN0cnVjdCBmb2xpbyAqZm9saW87DQo+ICAgCWludCByZXQ7DQoNCkFyZ3Mgc2Vl
biBpdCB0byBsYXRlLCBiaW8gYW5kIGJpb192ZWMgYXJlIHVudXNlZCBub3cuLi4NCg0K

