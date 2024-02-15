Return-Path: <linux-fsdevel+bounces-11668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB61B855F1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13CD1C21B20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA067E97;
	Thu, 15 Feb 2024 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QM2TLNZi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oQNtjPA5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AC0692E1
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992732; cv=fail; b=WBwISLy7x4tj2s4AVHAmWXcdv1ySwkKs1PuUzfIrhPKA3VL6rAsCAS+aANoXJKobAPe74Fue2ySvhdc6wCmtEMxq63+9USXMi0sBk6CK9pex16W0WmT1pkElXYr7KJltB88Gf8pojQxDmJTeefS5ibl1Ftffq/A/Bh8wumejRRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992732; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4iaOti4oU/1ootzA6yIaOGo802AretcgtdxuxNDURMdIPXqxrxdtbIz80GDMLUTvx2UzIiNems6GQDlqfVpgVJqeaNiloa2ncBRs0dhlRxTiXIRmVu1QzzuiBoiAdZyVziea0ssiTMcUWD7eYEDqNchGbF/MPAmm5Np/RzXsDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QM2TLNZi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oQNtjPA5; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707992730; x=1739528730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=QM2TLNZicZVh8Bs+fV3YHBFKPE9OLYqI4uSwrhrVgkf4SDATsY89/YGS
   ZVPyJPioJmSzqMMgUpNWFtXaCAwqGPoRnCrQVOgh9lUt2tPZE2HvZfGsZ
   xpJyJpugdofMgXIt7eO6y7nIBiAhi/0rBh0pqRmFS+tqN7iuwBpy4IIBZ
   UZmaf28s7Fy85Eg5Uvpj1hDgTR1dRFWNQxlJuF4NwfJCIndS+pFuIutlb
   0EhBZCfIR3EGMjboKXynBmPObDtuT5vCvGkLEpySPK/s5tQf2hwFM4dPR
   5M8TQ95oNfiLlmuFp9vSF4F80pSNUmmArgkQZnQ8u5w7pX1/w2T8WWdsm
   Q==;
X-CSE-ConnectionGUID: GeRQmdjNQauo6kmcMrUiWg==
X-CSE-MsgGUID: EvqVwf74TDiKoqOQFn3dHw==
X-IronPort-AV: E=Sophos;i="6.06,161,1705334400"; 
   d="scan'208";a="8961869"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 18:25:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edgU06sW6oKWGenGdGJRMdmcFLAeL5StpWnF6puHVdkPAgSlt/QPwpYuICBcNWy3S0HPnOi1twBSF51okhMlHnwcWe9YB85GXtpeuCZ5/ZiofQwLldksy15k6K0vr6YEvYivZBuZHWlitSLX/nqmlqm9hQoqa1ermBLGPZY55CQDuuj2WfKwO8+QB4Ox4b2J3EPkTOZ/pY6jriyyZR4454YYfMNOh3adIT+Czm1xlIM4ocYhCyhczKdl82qsZoslrFDRoW280BUdckQLFQ7d2sfUP0DmcE9s3R22pzb80CUZsePDlpx/MBTR8pmJTAV/YmGKQ8YFVE7IuSSlt7NVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=XnwwLOCNMKNp8Qn8neZ4rozawO4lSMpSJ5dwLJgsZJH9Fz2kiWfFaTZy2AHwVd9UoqIBCbj3GX8j21HXmI+tzf7nDf7V3GjZsZuSwyR7d7FKALFVJVMPe198RRaN/ZwxAI1sXUanxnnC6UwGLrwfQ0o5VqN4KAcDcyHrsE26dY826W6RyH4Chna8jvBwC1jTBW4Lzz5dCwd34T8McoR5wJXetLFhLGc8A6j3x5nQAR4tCR/RmmgbyYmZ8JYHWf5N2M0+OQHYL1fftB4oa5uQgzLgvpq+/gRBNb34ruDcJ9aIHIOrJm999kN/PD+7Tsu54injulUQ6BvbaoM771zHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=oQNtjPA5DY2jUgLC339+hP7pn76pfdzi4gAdlg/saiRiRUpHLdZpbrR3y28ldLdkRmB3uhAF3YaVxHiM2pMNY6kG1Z2eSD2lXtTNsEF/r1NO9bVxUnM8PmSzMCPzwkfAZYqW3lw2bsjyUov2fpZYNZvmfKDZGNG6wSfbiDtDjAE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7461.namprd04.prod.outlook.com (2603:10b6:510:1f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 10:25:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::73c4:a060:8f19:7b28]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::73c4:a060:8f19:7b28%6]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 10:25:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] zonefs: Improve error handling
Thread-Topic: [PATCH] zonefs: Improve error handling
Thread-Index: AQHaXxFq7i1kFnZpm0ygMf6LKk01jbELNHCA
Date: Thu, 15 Feb 2024 10:25:26 +0000
Message-ID: <868dff00-8631-4c1c-aa3e-4cd8b96bc0fb@wdc.com>
References: <20240214064526.3433662-1-dlemoal@kernel.org>
In-Reply-To: <20240214064526.3433662-1-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7461:EE_
x-ms-office365-filtering-correlation-id: 017fa457-faa0-492d-1e9b-08dc2e106cfb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jfe8B5NF7dqbZ8GdDsDdFVn34LoyqPMZmlDH9zTxj09mN9C7ZV8Qu0tbCTjU0WmQhnNzawxRHqYErJYaFOTmWWMnAgQ8VKDcE9uLZU5BYDZk3IRr2uo/8ha3V3unxRPj9/67Ncyi2mUKmYFQIQxmApsKtRnznEaNT+J34Eit43mK1exouGNs6BJsUOkp5NS1PypImzeiiBVP3aCXBE9wT3/K+ewWN/cKFQjfhw/kIJEHayxot37YwVr2ZmDHLZP8tKBCs88dTMEEcyRB5wTXJu5+U3mRhQQBiUmHW77bdmsXn8am6M98LVE0kWKkGxwNrwk8B5/r38xs9izwN8QJ6fRqXCEjmsEbAZV5K6l25X0KaGZ1Kq2FVX6Aus3pqSmbbweI8hpabejrA1wREu+HhuGtm+2zcqXhPbUtUO8VrxlzRs2Hu4CEMd+FzFrOEnDkNB7zyiI41EA2qOYuJcRVm7LIImt+Nq345KhS0KBzukl251rPEJM25iL73SNwRdj7Qall029hJeRw99iry7Sj5mQrDvO2Bu79mhpdtDy/OvEp1hJ7GjTQbnvzJ2mZpuVdilq39dijBd6y6QjMSkIWzipCRIFRdGacigkFc3c1dRVwc+qVjiQ5DrVXCSvQtzom
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(19618925003)(31686004)(5660300002)(316002)(4270600006)(41300700001)(4326008)(31696002)(110136005)(86362001)(122000001)(38100700002)(71200400001)(478600001)(66476007)(66446008)(8936002)(8676002)(64756008)(66556008)(66946007)(76116006)(6512007)(6486002)(6506007)(2616005)(38070700009)(82960400001)(558084003)(26005)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk1jNU9DaGhodXdlSGxTY2ZhNDZCWkIyckN2MGhtMG1DMjZjdlVYdk83a3hZ?=
 =?utf-8?B?NnFzTzhVOGU0Q0dMSTYzUG1vNmVJVzJ6WHhISG1zOTVFVjBBS1U5L1EycTNo?=
 =?utf-8?B?SWE0L3ZOQzExL1VsM1RpK0pLVUVrWkhBNk5tVDFXQVVQWEluSHNCSTYvRU41?=
 =?utf-8?B?Z3kvUHF3UVBEQnNIbTlXUXdEVnVKR25Lckkyd2JVbERubVRvUXF5U3NjTmlw?=
 =?utf-8?B?dDdYWU5TZXAvVEYzbitXNEtqYW1yMjJzTHhTMTVJZUhsV242ZlROTVZlT1VC?=
 =?utf-8?B?RG1RNjVmVkFJZ2V5NHhpcEl5MlNDV1cvWUVNMnMzVlNCeno5cnlTMXNPRGdz?=
 =?utf-8?B?VWxsME9SM2ZUUzVINjhVTjJ4a1NSdVZtOXRyZUFqTmM5T2ppaWduMGFmTERq?=
 =?utf-8?B?WFUvcDBHMmZXaVRtTkduc3Fxb1djL0wzZTgvdzNmcnNEK3VCTDN1Ly9YdXVO?=
 =?utf-8?B?RUdWSk56RFFGd2RURDc4T0c5MGVCc0xyaUpiUnJqdDA0V1d2d3QwdVFRNTZa?=
 =?utf-8?B?NjhZWXc2UWJPang3bCtXUnJESFhGZmw2YWtJSTE1d2U3ZHRibTJRSmdFQTJP?=
 =?utf-8?B?Qzg4WWJzRVlROHk1bkFYSmVXZ0QyRk0yaHoydXlrejJ6Nk9BcE1sZ2YraExr?=
 =?utf-8?B?eWdPSlBFRENodmVsaHpVaWxLRFR3ck42NlVDdmZNZkZ0MWRuK0dWVk5mMHV1?=
 =?utf-8?B?eVFzRHhSQXNLeXg3KzhhaXc5bXlEc2MzYnV6MGxnalc5Tm1hbTZ1cXAvVU10?=
 =?utf-8?B?eUVidklFbCtuRjA3MCtzeFJvc09JeGRnc2lGK0xxMS9rMThRWTd0SnJ0emYy?=
 =?utf-8?B?bnkvazRheVVYbVBid0c0V1lNaDdOeVZLZ3FEbGJQNE16VzRseUY1SGp3QVJF?=
 =?utf-8?B?QldNSFBlVDBxcUtBTTMyY3c3WHJvakpDVTBWOUN4UEEzMTJIalhjcFNjSXpm?=
 =?utf-8?B?ck9KdEVsV0RiY0pHcFE5WVFzbVg2SmFtMEVnUzNtNm55djVHUTZzSGtTNkRh?=
 =?utf-8?B?MGVvdVEwRi9lc1BiRFRKcGx1NWlxRVAvd2ZnRGNFTEZpSU1tUmhkTTZwK3pm?=
 =?utf-8?B?eXk3dnk0MlZRUERUTjZUVlRtOXFzdnh5YkFwYWNYWFlTeVVPWFVNaUJrRVhT?=
 =?utf-8?B?ZzBTSGlPeEdsMTRaS1ZETU5hRU1WaGZPT0pNazIxK01HTjNrZmxReU9DZEda?=
 =?utf-8?B?a2Z5WUhLRjZoeGY5MU8zdmhvK0k1VXFUWjZoNVFIZ1FneGFNUjZXdGtNd2lC?=
 =?utf-8?B?VHdLNE5ZRzUzVWdwK1BjQW1rWEtKYURSeGlxektEclBKK011UFBCLzFlYjdn?=
 =?utf-8?B?cDJoTmY2bUVZcEoxN284cmlXdDBNN25OeXc3T1NzV2dsdGtPMEZEcW9UWjVM?=
 =?utf-8?B?ZXNFL1NmMzBMdDBKSFFteWFHaWMxUzBTQWwzWW96Q0Q1a1ZKTlVtZ0U3WUxN?=
 =?utf-8?B?OFJ2TnRaUjNGbXNoU3kxV0R4REZuMHFyVVpQRmlkSFNBdGRURmxwQ0VPSVdm?=
 =?utf-8?B?Y005QXJGSkZycENpbUVnYmtJN0NDYWVsZGRCVFNjcUJFTVRRc3RhNzFaQkhB?=
 =?utf-8?B?TE9uQkRoQTNJbzZRN3M0aTBucU1GbG04N2Z2MW5WNHdKVG1NZGFQRFZ0Q2Na?=
 =?utf-8?B?NmMrdEhpSHVSV3ZJd3Vhd25ZcG1WWTUyNnBUZmhPM0ZFVVptZDdPdjJsakh4?=
 =?utf-8?B?d0VQVDRnU3E3bzlGTHpFeDVyZE1HS1psck41NnZmTWljZStqK3lXdzRFeFBp?=
 =?utf-8?B?SCsxb2RSZ2YyQVpxdW1LRytVb29ONGxPQzc1bEZxaEh3U1BqczBIZkRudnJz?=
 =?utf-8?B?NGhnMWZsZGEwUVA5NUtNTU00S0IxMTBwYVk3Q1BzcHJJM2IxNVhkVU5xcjh4?=
 =?utf-8?B?RUJOSmV1R3dSZVZWOE00U2pnRktKMGJuL2NnNm5NT21rTTB5TGhuc0c2cjZN?=
 =?utf-8?B?MDlkd3g5dWtzT2VoTTBlZm9WNUh4eTcxVXZHYktqS2tDZ0tlQTgycitXM2dB?=
 =?utf-8?B?cFFuaFNSalRua3NmMWNrS29pajVUc1VIdHlxeFhqYVduRlVrek5MS0RzeVBa?=
 =?utf-8?B?WGxNMlI4NGJoRFR0NnowclhYZkg0OXZhOURlZDhDeXprWjRxcGVwRldESEk0?=
 =?utf-8?B?ays3WjVBak1GUEk4aEgrSWw3eUp6RW55OVl1MXlvY0ZsdGRSUU9iaTN5Vi9q?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <426C31B7E8D1BC47941EA130A510AB15@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l0wqlvFi/7iTlxkkvrOss7eJ7zYTm2nfx58wrM/0J3CavtbEFnZ1DWSFLiARf9qP3RGNTa6rEyza4u3wAlx/FAUgKmdceRocXvRZ2P0tLIqvYrfOnIUcxBmgXgSTYJ2hI91wwxoS0yHHEZuNjWsNF/CJ+9Sh2ASqxGQ3zTt/g7a5wVolyjeY7JU2WBbO0L2+fK0Yb6NUv1C2xaJfi76iaPKLe56bHK7aGZK8gjPapJ2gI2EjUgnztghWVYhMZukfI1+73GN3RD+KeZbj4oUDP1D+VP5pDY6IaHrUh+k4h3HfRE6H9PwGDXZ1BrSDMMPLGxfirNGjbA40G1ofi/kHR/M0cCx+XZ0jfBmQwyAs7gdnU1CEqP2BCBi+y7QQtnIO+x2Tj+K3vuQM/JHpbZ6mTDnNkv7o9HzuRepl9BUWlfSDjO3HJjiMfdwfK0AkRpVhYTFAc3BMi8yyVitThSh5WXrkdGHrs3i12IjapQy2DBcsrPv4Q6RIWb4j2n1xlI3tnfGpUk8pFD2iu/1qsOOIQTsY+w/HyPW365U0pZfY9fwWZ5xKXfbRb+7rgbeZvuOjFzf73tFQ43EkyX2mpXo402OujnVLEvw2NpuFYm9HVlFqvcIsPujHgw5fPGha3nXS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017fa457-faa0-492d-1e9b-08dc2e106cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 10:25:26.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRmWhDSwv/nlWrgWZOMSsGU1pbEHW1xqXcujs+rMf+ZjGePnlluDdFACR7RSUm5/Sp7dt3uf0/gGUP0bI47lMMy5kB2piLfm48AMuNVMdg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7461

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

