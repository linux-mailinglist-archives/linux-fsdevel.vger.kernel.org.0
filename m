Return-Path: <linux-fsdevel+bounces-33243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1C9B5D2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 08:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD032B22115
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 07:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB251E0B6D;
	Wed, 30 Oct 2024 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="PoTfosFI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144971B86E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274456; cv=fail; b=M0SS9KGKUt/6NolNA3t551d/z8B6dj04dh6W7qoIaAqjH7Dbchc04lYRKlKrrKHl2AoxLtP5BitCktQIpS0XbqZIVg7O9bb3I4l5jgTGKpSngjy0pn/XqSCssjAVlAQQfHtoQ49aumcjoxpTURavmcjamVm+C/+Op5AOQ3Hb/iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274456; c=relaxed/simple;
	bh=acvWYGI63PLxWNbHF7lmyOyCCWdpZBeGisGN6YsLQ6g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Tr0CkmO4Eg8kzC0gPirxTMpZblSk4MtcseQXdcE8h94bK2CXR1IkO3HRss7h7gILA3IinVQH7uWrAq92vnFznI3BU8dkafqpur0QG5yM7bYdrKLpIN8KQLK5WRmaGRkH6TVmc50nP8N3cD5nHUAHf43uzMPAQGU2on+Nb4SGa80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=PoTfosFI; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U6eLmq031030;
	Wed, 30 Oct 2024 07:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=acvWYGI63PLxWNbHF7lmyOyCCWdpZ
	BeGisGN6YsLQ6g=; b=PoTfosFIHOyyntlmy1iOQjN05Ah2gSVJOYk+ye0XHAEI/
	LkW8q8PoMAVAUnPO9przjoVB9yHJSkdJgrXU29Xx3JzqlRUZGGzqg41jUQthKY4m
	CUhYx8yXT62PGhIxaowlavU2GOmnGaqK13mmKy186jMR15ug4IBzkF1673BDSQGr
	+Kvwg72f2nAHfCQMl6sC2swT8hryz7Z2BkUptcGng57lspFQ0B1J6N1IkVRerWMV
	hmgwxvC5HwQLVxpyg43uFDXMB5gERkdO3db8+czEt9fuq6udQSKX0UAfoGi4IATc
	pQgX9+H+gKUHPcNMnd6zrKV+UZsiKAZ8fxxNVxypw==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2049.outbound.protection.outlook.com [104.47.110.49])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42k2ypgnpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 07:47:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hROgxftDFDkyvtXNzXk29l5gBF3kgi5U9SBZXQuNkWZwfIs5kE0uKcCm4obif59aHgZYx8ceXCMxzRYfSHj/QvLnotPgp+Iv1Vt6lMVhnpXaWAchy08vuXkeBm5Bp3Qj6jC1C7dSAIRg0Ib2Bx5t7De5nKCIng/EfKukbIeRQiDxbnfAYxLy6PXhBWq0LQr7IyrFHRIwVJpAcaGFC94c2WsHgS76Osin+54LwCi4dmXFnE+viEKkVHRcUSTu0hJvofslqxyY+AtPGnb2wRiDxbuEf2HcfFdGrXEHqFpw4DPGjQOrGa/HD3A2yHZqVMJZkvSoAQYMXsL5AA/fHPRTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acvWYGI63PLxWNbHF7lmyOyCCWdpZBeGisGN6YsLQ6g=;
 b=YYl1brYhifsGF4aJ1rqi+vsRn78Os9SwODzgVXozgQQ8BeslxIZ3Ila40oS5EDymjJuAKCYff1xfHcU0rmLW+v2aJhCpVlWmc3SUEnjmlLO63F0rF/2JBO3h2z2mMULzZFU7U1b2DUslrogpxD85D6sGwhtgypUmSeVYy2uyAqKvqXl8ZGQZ9LvPp6AZkUAgLvt0KbcOdSeu61QJfOH/SN5Ehf0T+z4DqcAO9X/+lEJKmrsyjZgL2+eUIrudjN+bF3T9ukiNO3eORGAFcv6t1AB5PmpucS3PjiZPG+ffOVV/shMjwBJUboUkLZgdtfHc0qIKx0U1Cc5z3yu+nKW+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7707.apcprd04.prod.outlook.com (2603:1096:820:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 07:47:18 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 07:47:18 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: fix file being changed by unaligned direct write
Thread-Topic: [PATCH v1] exfat: fix file being changed by unaligned direct
 write
Thread-Index: AdsgM2W/x1aURdJJQVemxv1csSA60QKbCK6Q
Date: Wed, 30 Oct 2024 07:47:18 +0000
Message-ID:
 <PUZPR04MB631696A2513D72126D4165B881542@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7707:EE_
x-ms-office365-filtering-correlation-id: 9c4112ca-3575-48bb-1e4b-08dcf8b71463
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TW5FMjdQenRiaVFNb3gxU2Fib0tNNS9CV2pyMW5vVXpRM0REZitwMFJPekNn?=
 =?utf-8?B?NjNOWkRkYlRhazIvNWZneHRBUjk4L2ZyQkhZUUZSRWRZZjdFamZKbjJXeFEv?=
 =?utf-8?B?RmxXamcyRlQ5RmFYMmRXRTlvTHBaNUtIS1NnTjQwZWt6amVWc2llcTBIU3M0?=
 =?utf-8?B?UnRFa1d2ZTZoMlExTkJnQ1ZrazJhNjduTXZzSUVMSU9DYTFNY3BPbTZxWW5O?=
 =?utf-8?B?V0ZLWW9LYUQ0bElabUp5R3U4SWJsb2haWmtybzVuTGtEQ0d3V1UxeERKT25m?=
 =?utf-8?B?RTRiSTZ4NjNtSkNFbTBvRzRzVTdub3cyOURsRU02YUlPQ1JYK1FuTmhuK3VJ?=
 =?utf-8?B?TDJ1U3VmTUk5cnNrRDZZVDBpb0dOblE1bGRzOGhUeDJ6bmU2ZW85U0duMGZJ?=
 =?utf-8?B?TFlGeVVlekx3Z3grUWpQWnRRRjdpYWpHOVJ4a3JmdytBSVRSVlc0ZXhDSVZn?=
 =?utf-8?B?cDc0QlBpL1BzRmI0emhlNnN0bHcwRUgyVzFhbzVicElXUVdNTnc4VkxuazA4?=
 =?utf-8?B?V2VYSHBIR3VsT2hwM09QWktXSzYzVE9NczVlVzczQmFkQk40MXZpeUtSanhp?=
 =?utf-8?B?WkVxLzhNVEJuVnluTGxQbzA3cVErQ1lFSnNOUzdVWkZ3NGZjYmVMT0xSM04z?=
 =?utf-8?B?a3hKZ2Jvd0UrTU0wM3BacnNBOTN6ZTBxSThtVTUrSENkQThZc0lJeWp6Mnhq?=
 =?utf-8?B?cmN2VXl2N0J2UmhramYzaWdLbzR0ZXo1QjZzWHRDZzhlQXlzWjAwZjFVblpW?=
 =?utf-8?B?Y2JiODM1dDNqVVJHZmJ5UGZRN3QzWTR1NC9XQ2RrV2RrK0MwV2JVc24xSHZL?=
 =?utf-8?B?aEJ1cCsza2JqUW42bE9LbW0zaFY5NlR0aldHZmd0c2FTaFhWZEZTdVJleVFV?=
 =?utf-8?B?d2tJSW8vMGEra0tPTjBGSTl4UU1tb2Q1enZYRDVveW8xYUFMajhnTkVvbHZv?=
 =?utf-8?B?dFVEbStueno0S2FqeWVZY3ZmQ0lvamFaU1d1bC9pL0doWlFPVzVzK0xJc1ZV?=
 =?utf-8?B?Nk5RNGRPeDloeEpPOXMrMmNZT1p0OHRYMis4dWFwdmRpUzNReTRhQUZ1WWlV?=
 =?utf-8?B?NDFCUVFiZllHZ1VEZzkvcnFhT3BHSHY3T3ZBdWN1YlVCY2xyaTEzRVZZTFkx?=
 =?utf-8?B?a081aFFtdk4yOFVuTEZJaVB0ekRWRjBUbFJhTzVHY05aYnQwWWlTK1UxVmc5?=
 =?utf-8?B?am9kYnIvSjYxOGU4Q0J1T2p0M0FpYjdTejBpZmUySjJrQ1MreXVJRS9qQmJ2?=
 =?utf-8?B?RnNvam0yRGRFQjJvbGhVeHlmSnlDVmNRRjQ4ZXJPMUxXT3d4aFloNTUrclJq?=
 =?utf-8?B?TG5jbjREL2llQ29VQkthblFyTFVjR1FKZkdjUWZWeUhkeFpLVEZLOWgzRU9r?=
 =?utf-8?B?QWhqK3ZzYkFqenpRbFpoUkc5SUxraEdmUnFoRHBkYUU2c1JkaENjQlZUbUdU?=
 =?utf-8?B?bGRmT3MzRk1OZDkvMGg5L3IxUGtCMGtDL2RKZlFGYWdGV29YWGFtbHlha0I1?=
 =?utf-8?B?K08rRWxFL3dxQ0NBWnlxVEYvd3daTjNrN2x3NkJPVlZHWHAvNFJTWG4xci9o?=
 =?utf-8?B?SG93enRlaVlhQzlWUWVXN0N0VHJxVEl5cjE0VFBkaFZxKzBvZmx4RTY4ZVJx?=
 =?utf-8?B?ZC9LazEwckZSWEFUcTVUeVRsTG1tc1k4NldmTHptZC9FQmJMNWQzUDlXYjBZ?=
 =?utf-8?B?OU1JbUIrUDZWeDF2aXBYem9yRFNFb3RPK014QUpTbmN5eUFVdDJDQ2FRUjlC?=
 =?utf-8?B?dkZUaStIbzZjQVhQVmJ0WldkKzBjSFBLUXgvK3hrb1NwLzRObnZxWlByejhC?=
 =?utf-8?Q?Ln6pj0Xjh0abZC9XF6schm3H+t6NrPa7jEraw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFhrczVzNEUxRU1DYnFXTGZueXIzN3RRMFBmVFVuRkRqd2R4dmxqa2c1bG11?=
 =?utf-8?B?TlM1MWxvUCtSaUJJRXlDT0dKNSthOTlyWDVSaUljNnZnSXpmcHFLOEZDN0d0?=
 =?utf-8?B?ZEYyVVlISWlXN3h6eUVGYmRIMG9PMnl0WHVsUFF1WlhYMWViei9VYlNoU0FO?=
 =?utf-8?B?SEVDVWVqT2pwNFF0MFd6WDNhR09IVEM2QjVvcW91Zi8wZmx2eE1jYThyQytn?=
 =?utf-8?B?OHlZdDRmbUlxdm1uUjRHb3E5UnJvK0F5WHZvM1QxSnFCTXNnNTBDeWFpY1R3?=
 =?utf-8?B?ZWN0M3hpNWtuSjAyWnQxaDhzdXZQbGpQUWU4U2E2em0wcVpDT3pCZTN1SmdK?=
 =?utf-8?B?OGsvYWI4eFZtZWZKYi9sOVVEeHhGSEJBNU5CYzM0YkhkV2tjb2tacGRGRUJC?=
 =?utf-8?B?Q1cweXZTT2QzUmQwNTFQcm9kK0NWUFR1eHBhWHJrczdqYlJmNG9rd0trUmZJ?=
 =?utf-8?B?TTdrbDBHckhSazh6bVBtYlJpdHV5OGN3dlcvN0pwSzJzVVdTRHlabE5JQkVC?=
 =?utf-8?B?Y2VkdkU5MVZtS2cwTnVWZU5Hd2pSNVZkV3RleHBqOVl2b21UcHhzMFRYU2dR?=
 =?utf-8?B?U0dLeFJYOEpZNU9BeE1pRmpiTTViSEpGQjh6c2o0ZWdoU01aVnQ1cXV1Tmcx?=
 =?utf-8?B?Vm5JVUZkajQ0YlJ5d3Q3YnhSR2lqNzdFYnJQTEZRTVdsVGlRWkNyV0o1ZVpa?=
 =?utf-8?B?bDJpdlAzalBXOXZycjY4ZTFCVmF6T1QwUWlGOU5WeHZWbGl4WmRhZGIrN3Ay?=
 =?utf-8?B?SEtJaGVjQ25vTE9YeWJxNFdJRDBGMW9vNU9QTWk5K2k4R3lGZVZOV0xuYkVr?=
 =?utf-8?B?RlhWOTE1MGxZdVYxOUJabFJvYUZETnVpWU5LUVVQYmJGSVRPa1NDQnBEZ212?=
 =?utf-8?B?ZGduL05OWWs3Qk1NNmNuM3NxK04zYUJXSld4VDRJUGo3UVlMeFY3MkxQK1pG?=
 =?utf-8?B?enJHaTFzbGV4amY1N3F4alVJblRYRTV4MXhoeHh4VFlNV1pUK29Ld2tERGdm?=
 =?utf-8?B?MklXMnJ4M3k4TGJhM0VJVFprNk10T2lOblF2bmFFZ2ZZMzhlQjBtVHdHRUp0?=
 =?utf-8?B?U0VJOWNlMDdyT0d4TjNaQTZjb1c1NjNpeGJweXhXNVgrM1NOQUZ4UGNBUHZI?=
 =?utf-8?B?a3FVZkNFUS9uZGxaY3NNc3BNWDBYeGpwTFg0c011dGp0Q1RYRzgyemVYdWQz?=
 =?utf-8?B?cGJScEdhdm5uM242R0dUTWNMSUJ2b0hIbjFIWW9NZTIzUnJOZFZJSUxRYzA5?=
 =?utf-8?B?VklyU2E0bklQWU1OQUxlVWlNSEpRNFozUVVVZHRJRHV1eXZSTlgwSzMzUW1U?=
 =?utf-8?B?b0xZR3FsY05WOE1GaGo4a3RhSEhnTXlISXpMR0w5QTJvOXNoaE5YL3FjTFZC?=
 =?utf-8?B?Zk41dzBVeUJWVFFjeGp3emlMTFJLQlNRcTdCR1dscUVZbzNDS2d2MzgzN1dC?=
 =?utf-8?B?OTA0SmpXaURHcTVVT2V1ck9WRkZVL0kyRStuejNwTGdNVm8zb2dmSTlsak1n?=
 =?utf-8?B?QnFpcTM3aU9mZ1VhKy9kWGJjaHVsMjNibVlvVXZxNE1JckFFeTRhZnFkcUpB?=
 =?utf-8?B?QTBPYXFqQTFqOGw5RUdQQ3p4REpjdzlWaGc0NFFoeE1uRXYyM2ZvQmRaUk1G?=
 =?utf-8?B?K21JZmRNYkVMNlVwL3A1bGFlYjhzWlI5M1I1K3pXMHpGV1pQamtRSlNOOHo0?=
 =?utf-8?B?WGRBZ1lCaXozeFBPOFFHTmc4WTZRZ0ZPMlpFUmdzekZQM3huQ3pyWmhuSzRR?=
 =?utf-8?B?WWNLbHlkTHNrMWZBUXNvbjhBZHlNQk5EQ1NFbi9NU0VacmpKNHRGaHdLOFo4?=
 =?utf-8?B?WlZoMnBxVDRBalMrVmRLMkhwTFlFb09DTU5NQ3FxZVQ0TkowZ1dsbFg1NTFt?=
 =?utf-8?B?ZWhFdEpDTmI5R0JJd05rV1o4L3BaTHozWW1KR1VNN1ZSR20yVGRZNjJIeElO?=
 =?utf-8?B?TGN4NzdVanpaZU5yVmpQK1M1ZHpuU1dPOXdOK2I4Z2hpaDBFZ2ltZkJvV1dM?=
 =?utf-8?B?b1l5eVQrMGdMbmtpbitkTUhZOTBPSlkxdmdnS1Frc1V6K2dmaWtLQzNUNjFj?=
 =?utf-8?B?L0dBMUQ1Y0tzN05meEtPVlZMM09qYXdodzJ1bHF6cVg5eUI3c3YwTTdKTzFT?=
 =?utf-8?Q?JolV16mB/Shw/Yfm7QTk02s/F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1YcY2prUiOaQc/DzX1hSmAMC44paT8tlFT1vWf8RqP1Za1aRz82oi+g3TmbM8cAHExrcOHWJ27IPXgGamBORV8XuA7dxC3DCsnoH88CBxAPTGZkxOo69pwtAk5No7fhW5HTpNooN6wiyi9ZG0w9O7bWlQdJix+cmILic9ArDm9Y/0Vv7h0NmFJmJpHkmzdYrejRE5ccpMb8rxHeMkaYOLpPaBq2A+S9scHUZuxIL+JX9ik9n3Ny58doxkvSNsbY6GINBziXlzYhsx28MVTDM2H7EqH7QWX1zibxzCo9SUi/oCmllPvydEBQ4Zpe+aUfD74o3XjBPSupE3dJo4BNV6NLEo/cvX8watFoBcr0TLPRzJtPdKyYCkOYhRI19ZM7J+6JffdVuhhnZfRHz+arjgygd6zIaVpRAqs9jnP+QssRgnbq5MebmgWmKH3+dfM0lzEajdFLWfKS44onWLsM7Jw5VKUVl8VgTHEbuJB8F6k/XKLPgtybqwARs6pokrEKKTFEjZcdoj2kUOFtol+N1zeMUvF77oEAI+DTAKX9f7FKZGCXDnqSpuIV9/WEcl66jivLuKdV4gMthfmb5XhOh+OjvDa1Eq+8TtI0FEGZHdIPN8n30wA7d6FvldaKDii2W
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4112ca-3575-48bb-1e4b-08dcf8b71463
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:47:18.4291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oO8fFaWUUG00nqKP3MJk7W/8RefkGZr2MctCozxYxIqgPWQIBFae6CJf1b5rLB7bPQ+nWv4PFBqWJ0zHHwOO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7707
X-Proofpoint-GUID: 2950k_v_V8LQDoXKPkDm3QzTNV1eYvF2
X-Proofpoint-ORIG-GUID: 2950k_v_V8LQDoXKPkDm3QzTNV1eYvF2
X-Sony-Outbound-GUID: 2950k_v_V8LQDoXKPkDm3QzTNV1eYvF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_06,2024-10-30_01,2024-09-30_01

VW5hbGlnbmVkIGRpcmVjdCB3cml0ZXMgYXJlIGludmFsaWQgYW5kIHNob3VsZCByZXR1cm4gYW4g
ZXJyb3INCndpdGhvdXQgbWFraW5nIGFueSBjaGFuZ2VzLCByYXRoZXIgdGhhbiBleHRlbmRpbmcg
LT52YWxpZF9zaXplDQphbmQgdGhlbiByZXR1cm5pbmcgYW4gZXJyb3IuIFRoZXJlZm9yZSwgYWxp
Z25tZW50IGNoZWNraW5nIGlzDQpyZXF1aXJlZCBiZWZvcmUgZXh0ZW5kaW5nIC0+dmFsaWRfc2l6
ZS4NCg0KRml4ZXM6IDExYTM0N2ZiNmNlZiAoImV4ZmF0OiBjaGFuZ2UgdG8gZ2V0IGZpbGUgc2l6
ZSBmcm9tIERhdGFMZW5ndGgiKQ0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5n
Lk1vQHNvbnkuY29tPg0KQ28tZGV2ZWxvcGVkLWJ5OiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBr
ZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogTmFtamFlIEplb24gPGxpbmtpbmplb25Aa2VybmVs
Lm9yZz4NCi0tLQ0KIGZzL2V4ZmF0L2ZpbGUuYyB8IDYgKysrKysrDQogMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmlsZS5jIGIvZnMvZXhm
YXQvZmlsZS5jDQppbmRleCBhMjVkN2ViNzg5ZjQuLmEwMGYzZjFiMmNiYiAxMDA2NDQNCi0tLSBh
L2ZzL2V4ZmF0L2ZpbGUuYw0KKysrIGIvZnMvZXhmYXQvZmlsZS5jDQpAQCAtNTg0LDYgKzU4NCwx
MiBAQCBzdGF0aWMgc3NpemVfdCBleGZhdF9maWxlX3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICpp
b2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpDQogCWlmIChyZXQgPCAwKQ0KIAkJZ290byB1bmxv
Y2s7DQogDQorCWlmICgoaW9jYi0+a2lfZmxhZ3MgJiBJT0NCX0RJUkVDVCkgJiYNCisJICAgIEVY
RkFUX0JMS19PRkZTRVQocG9zIHwgcmV0LCBpbm9kZS0+aV9zYikpIHsNCisJCXJldCA9IC1FSU5W
QUw7DQorCQlnb3RvIHVubG9jazsNCisJfQ0KKw0KIAlpZiAocG9zID4gdmFsaWRfc2l6ZSkgew0K
IAkJcmV0ID0gZXhmYXRfZXh0ZW5kX3ZhbGlkX3NpemUoZmlsZSwgcG9zKTsNCiAJCWlmIChyZXQg
PCAwICYmIHJldCAhPSAtRU5PU1BDKSB7DQotLSANCjIuNDMuMA0KDQo=

