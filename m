Return-Path: <linux-fsdevel+bounces-35057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 187C09D07CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 03:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BD8B22112
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A882F855;
	Mon, 18 Nov 2024 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="BLrinwiu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77827E55B
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731895846; cv=fail; b=XxtGXWQV+w4Y8IcovQQfE9JURH2DfgW5Oa+C1DDkURtYNk4TMzAdjRFZ2feAKq2G0rtg84/Msf3hC7C0xctLSL0Dc+ZH78narr8A8/aOup86tsbL1N2kDP++zNNo7qBycpgutCIJrif319k97ojHDBX05r2opzLRzdJv0ImBW0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731895846; c=relaxed/simple;
	bh=e1a/WlIwVsuY4mQM53XHUsIVLbrWykAEWvuOXSw+/ik=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YKYVgQF308jwE1wkNtJQnw6szC8QZCBVX4JefsI4ol2t0H6itJvkS4qqb2EC3M9s7QJYD1TyKfad4iE5kxnMI1qFeZQk3Syjj0z+QFhWOemt3ZXDPggib0eJ8z17hR3tixNv8SvMVEWHiwUmQDlNb+uAlGnKUF+DJ+VIywC2Uhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=BLrinwiu; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI0I3O5002713;
	Mon, 18 Nov 2024 02:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=e1a/WlIwVsuY4mQM53XHUsIVLbrWy
	kAEWvuOXSw+/ik=; b=BLrinwiubIArB6hzJp1t3ryPNjGixXfBRlrQDRLuIx7rk
	A9Gsn1CwQh1/DWhr/kjq4tmEWxFjGz4yePuo4x13KPQZDfbIFM/g4bWlVVCe193t
	5KnbUxG6q9fm0LUQ85fT2QUUBzDM83rBHR9NU/aXUEHaeM4rO9jX0iEQWq/DUnAa
	e/6gE5/HWoZz5xLldvwI8jeR5V2cpceeAapW5TtDGWDdTaJ+dCqDywhhlmxvqXeO
	5/+x5oo5eHp+iTh3kaRR7clS6ctlujbQIAJF7C7ccHimXS5YDPNrsNG201tyrUsx
	bPkI0+e7gbQJegkdkVnGaZ61evyqfGKJrNk2DqpYA==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2049.outbound.protection.outlook.com [104.47.110.49])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42xm9p8xeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 02:01:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAkQFiScbueZjKi9pcaTbwDjRK/dN5eIiNPFVxd93U0xuPRzkfAM61VIyp87JVOPhQbgt03KVQr2mngIrQKCNpDtSM142P5X3U3PF/kXcXtbtqZZi8aeVlkmCzjxHrdbByPrqEpDVDU4bWGEn3Nfvgkpikj96OyDcZJAUR7QqG0ShDgR/H/XY9kpNBRb2P895X8YZ75+9DRZZS6WRlyQEWm3o0EWm45mdsyWNhTaqvUX6eT2Amzs4Y9Xbkbu9B4C4Jev604lxBShhRu1rBc9qtX5AGhVUmE51yY9MIzdkrk19inkl8S/WXNq6cXD3wRwF/2YfWQaxn4Rh6r3rxAF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1a/WlIwVsuY4mQM53XHUsIVLbrWykAEWvuOXSw+/ik=;
 b=VOg8PuHM/EF48WyhBdFVXIvTrwY/fkV93tRSgAMYKvyOgEx9H3DgXncKSTdlQkyymQrqzFJNASHKmV2a01aeFYFUJa6RXlai4JqT9jHzucekoW+7cU8qfwVTA3EgClNJPi6SwZdBFH5pdngpmVx/qa8RbH56B8uz1+PEmELarPSbZCRbKqIh3SBuFX+fNop45EMe5hkq9RIbTVG0RYqQoqG9qSyqEnXDvBcjoVvMhuC8MhCnWYvwqCI9/24nngBVdznCZQOTOd5qD2tJGTfOWp6m3VqapdNG8IADBx9286v2AiZU2Rtqs1y3aljuNVXpc7xSBSfVk65Fn38fquJ0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6119.apcprd04.prod.outlook.com (2603:1096:400:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 02:01:25 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8158.013; Mon, 18 Nov 2024
 02:01:25 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v3 0/7] exfat: reduce FAT chain traversal
Thread-Topic: [PATCH v3 0/7] exfat: reduce FAT chain traversal
Thread-Index: Ads5Wp9MXZ59BzhnSQO0AU1xE8yPRQAAVSgw
Date: Mon, 18 Nov 2024 02:01:25 +0000
Message-ID:
 <PUZPR04MB6316B385B7AE35C20C574B4481272@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6119:EE_
x-ms-office365-filtering-correlation-id: e0e7a6e6-8a28-46cf-8495-08dd0774e870
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTJJQktyVE9hL3MwVFBtYTRwdFNhbUcvZVpWaUt6MThidXZMWjBDdDROeVBz?=
 =?utf-8?B?UE45WWxvdFVMZ3kvVGVxeHhRdWZxNzc3cnZLREFvYkhXT1h4R0syZnpLemM5?=
 =?utf-8?B?dVFlY1pkRE9FNDhLd2F3eWEyS2dTMm16RDhjNS83VGczTCsvS1R0SnJuejI4?=
 =?utf-8?B?bDBYSWdLQzFhb3lWZ3FaU3pkT2pwRElGcmFDNFFZWXYydS90aUVzM29kdzJV?=
 =?utf-8?B?bmNtMDlYSlhXMWZjM3pQaG1QblJLLzJBRnlXYlkwM0JJbUxsVWVaa1FTeFQy?=
 =?utf-8?B?MGMwZ2l0S0ZnV3FhL2RXVC9VaVBoZ0paU2J3amMwd1NXQldvVUx4Mm1oUjVG?=
 =?utf-8?B?UFhJODgxa2VPaWFrT2NRaXU4WGl5eFNnaGJPbHFBL3lMRGpraWtiN3M3SURU?=
 =?utf-8?B?WHR1MVF6SnVkYVp6WGtqRGtsT1RsMW5UdHlOcmxIZm5EWkJRVFlOV0VWNkZa?=
 =?utf-8?B?WXFvQTJHa0pFZ211RWFuVzFwSXhEaUxhVEFJMHVQMGNOcHYrYk95d1hOOEU1?=
 =?utf-8?B?UU4rNTNOME1FOEQ3c1ZFZ3EvbUx0cm5VeTR3b3hOR3Q2bmZBa2gzaU1VVS9x?=
 =?utf-8?B?QUd1ZlRaRlRrRmw0UTg2TmQ2VWNxRHgrVU9TOVhXYUg5SjM1c0MvWUlZampn?=
 =?utf-8?B?YjNiMG5BOWNFTkJNZEFUbFhYTHlDQmV0dVdORDNwTEdkM1c1b3NKWjZiV0hz?=
 =?utf-8?B?NmQ3Q0pLYzdLWjd4UXF2a1BBRjlMWU9tZmxwakZHT3h0Qm92RStJOEFRcjlC?=
 =?utf-8?B?YUZ4eWpqVHdQd0x1ekpWcy9aa3krRmtXbmhKMXJvaDB3b2xIZUdPdldvTzVE?=
 =?utf-8?B?aFZ5NnNOWkhxalVVL3g1RDI3NGVES2thek5JOHBiMnN1YmJHSldOSUt1Lzl5?=
 =?utf-8?B?eUpYZFlHeXNZZitRZEF6Szk3VlVBSUlvOFVyQllUNHMySmE0NWVxSXhHM0xE?=
 =?utf-8?B?Mk5BaE9HMGZDWHRFYkx6VGJjbGNnSlpoblB1TUlwRUh3bzJpUVNMcHBWaTd2?=
 =?utf-8?B?LzJ5TUJHNTRTM1A1cHc1STVGRVExZWlQLzNqb2xNSjhNT0hiajZPZzJUQWJW?=
 =?utf-8?B?ZHpFdEFYWTUrQ0t2UW1Hc1huVzNieXFxQmFQN2dsOUUrMHhDaTRRWlVyUlRr?=
 =?utf-8?B?Y24rZXlaRWdLODNydzBkWE9kYXlHN1FTamErL0dFbzA0WnFpNWwzWktod083?=
 =?utf-8?B?YjdKNkVlVC8yckxzWkw5alVpWHJqWkpUMEQvcUo3eXhyNWJvRFR6ZjM3cDcr?=
 =?utf-8?B?T2xEVFRSY0lsam1xRktkalRjTTdxYmpVckI5LzA4MEVnUTdjMUcwalpoRys3?=
 =?utf-8?B?L0ZxbnlMaWozcVhFWGJENHZiOGRhOElQbmxEdnFhdkM4WmhoZWFDTzZVUG8y?=
 =?utf-8?B?VGR1YlNyV3EzSWlzcWdMVG93NEhtaW1RSzNvREY3bi8wVzNNKyt5OU51YVlD?=
 =?utf-8?B?NlR6SlQ4QWVORy93bjNaNGNkMHFrTTZNVXhyOHB5U05jdlMxTzRiM3dOZGV0?=
 =?utf-8?B?WXlxa3I5eXJVaGptSjl3SzRPTzRIcGppdDlJZ2h1MkJUM0ZZOXFQdHRVdXZu?=
 =?utf-8?B?L0lDMWRWM3o0dHBTdFZlWVRmd1lSbWdWbmljVElSWUZmT0d3MVZZNCtYc0w4?=
 =?utf-8?B?dWRLRE5Sc3JtdXBZekU4eTBzRXIyRVNWS3JIZ2gzMDdrVEtDdXZha1JURzFC?=
 =?utf-8?B?a29VR2lDSnh3VFN1Tm9xbXE1WU9qL3pZaGwwOFpMZlM0RTlZQzdyWEs1T1lq?=
 =?utf-8?B?UlA3cVl1QUlZN2Zzb2IzZHFrK3Nxd04zc29lVEVvY3lxVURKYWxnZjErUnJU?=
 =?utf-8?Q?QyEMKtDcqxSgpwyntzZnxTTY9J0OfP4NVaExU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEZLaHVWUTI1T2NMWkRRQjdKcXhjY3lRSk9BbE1iTytteDVIdkhOK015cWt0?=
 =?utf-8?B?RGhRUjhTZC9hNmpsMk5veHN3MkRkOVRBd3ZicWZ2WEdieTFla3dEZmVrMUtI?=
 =?utf-8?B?TXJ1eSt4MGkyM0xpYzd6Uys5Vndqb1NIRVRZL0t0a0tPUXZTSHVOYzllVGxR?=
 =?utf-8?B?bFdzWitLb2ZTU3pFUi94T0puOTY4bTJyTUoxYWJBNitZWlRZa2dBWkNWd0hq?=
 =?utf-8?B?dlpubEZDS0x3MjYrL2R3dE04cEs2WmhoYW5RVFJJWDNzbFZlaEU0SDNuUVpy?=
 =?utf-8?B?cmMxRXZJcVJ6YmVMb2xXcyt4aXJZK3dlc2JrRnhRVzAvUnFUa2FFK1hXcXVO?=
 =?utf-8?B?S3owNWx3NnZlUHpNeWVBWjRFMmYrenNLeGo4T09JUmhsRmpOc05kdE9sZ29L?=
 =?utf-8?B?ZFo3ZVZnWDRaemVERWxyQ3lxMGEwSWtBT0JSM2FOR1pRZ2xscmhHNytud0hN?=
 =?utf-8?B?QUYrQ0dqTXJjVmlhUHVqNnN3aGIwL1FtaThHSHcvN1Zqb21xMkpLZ21ad2RT?=
 =?utf-8?B?bDAvQkNyU1JjeDhQQXpnVXdwT1poKzRDcTd5NHBCVVFsVnRVLzFSS1JGcTQv?=
 =?utf-8?B?OXh3VTV1SDYrR1NGaDdiMzRtQ1lkb0VMaGNIQ2lMVFFRZEJ3eVpxSnFXZE5t?=
 =?utf-8?B?YWFwT3VnNHBTN2dZZHc1OU9YT1Y5REZRS0tSZDhSKzBDMjd2blczY1RpY1dE?=
 =?utf-8?B?UVBOcGM3cDV1VWZaUDNGZTU5bHcxemliTEptY1Q1c2lkY0Q5cnhYRFRpYUw0?=
 =?utf-8?B?MjVVc0t1YklzTUh5M2thV0F4SEVqVS9iYU9VYXRKSTFGN000Y09QSUVrNUQ2?=
 =?utf-8?B?NElsRmRKd2w4bDhtMW5rbFlodFpaKzhGV3ovbEhZelkwa2szUzhnbWpCTGdn?=
 =?utf-8?B?RGxVbGFuajE0ZFRJYnJjMmxOMXlqd3QwV05xa0dLOWNJWkVRdzdsTzFYM25Y?=
 =?utf-8?B?UUZlYkUvbW9JaklURDBvRTRkbFFFS2d1YXVGMHA5bWJxNWQ2dFMxd0pJZHpz?=
 =?utf-8?B?bVd1bnliT0wxelZDWEFGemQyZ1hSVllnZjhUMmhhVjN0eXkxSGZIMFNnNDNu?=
 =?utf-8?B?WGZ3QVRNclU2dWJlb0U1dFU5bEtWT2dTTHJXZHhFbkhxOXMyYzc3UWtWMTJZ?=
 =?utf-8?B?WXlLV3Z5eFV2bXFZa0xqekNTOHRxTjVmZENWTUw3SURPd09PaUZYdTVZeXpM?=
 =?utf-8?B?azZLYWpabkY4SE5mS2FZdC9VRWFSY1B4ZW45VS80a2x2UzdGME9qSDI2eEVC?=
 =?utf-8?B?WEFpR0ZNUnpxL1FTZGxzZkVMUW0rendhOThwd0JZTmRQZGhoUUJLRnpGZnpI?=
 =?utf-8?B?M1ViZG1qa2VqNnJHRWZkZlpjQWFLdlVuc2dVRVhkL2RvQXBjWHljVGJRQWdO?=
 =?utf-8?B?MFFRUzNuVjBob0ljU0c0U0pSOXlRVVJWa2oxbTNTd2Jxd1BqL05LMUZyV2lL?=
 =?utf-8?B?Y2lKa2JqNjc2MlhFV2E4OVdnUG0yWW9YNFMzZnE4eUxCYk1ZYWE1VEcvdFRt?=
 =?utf-8?B?ZzllVVB1Qk1XenJuK2JEVTRQUXJnb1JSMU9RSTJSSGhvZlFQdjlGTmxvZHQz?=
 =?utf-8?B?SXlIbHgyOW43SlpNT1NMdmtKNGpJYkg0RmJERE5DMzhSTWVvVENjMmVPc0E3?=
 =?utf-8?B?THlYRFB4bWJrc1kwczVndDZKV05uSnh4Z2xSampGanZlTmkvTisxQllnMUdS?=
 =?utf-8?B?NGdVZ1RHc01yWlo3UjlwRytweWVhRjZOT2x2NWk3SytIc3BqajNhVm42Qno3?=
 =?utf-8?B?cjJHN0kzWmRTZitzNWtoZThxTUdEUCtscFlzVXNscDUwcnc0bGpESEw0YkVx?=
 =?utf-8?B?NUtoT1lUMk56NXNOd1FFS2tZN1lMRzJsOGh0MmNnb01paE1IZ0NDcFNHdGZX?=
 =?utf-8?B?amxTTHJPcFhpcWRYYzJCSGpzMkEzUFp3KzVGOElOUkpGbytCTVZrMFpzU2xj?=
 =?utf-8?B?dTk2bVEvNzBIUDRPdFpPbkZscDN2ZUkrVnBTTFVjSm1mdEF4eHVSWmhjV2g2?=
 =?utf-8?B?bE5RQlZCb2hnMXZZelpvaTB1TWhuVlZ4YWttWmVOQnJBMDVoeGpuaTEzNTZi?=
 =?utf-8?B?Uk5IZmJ1S2RsOEwwaHRuTXVnaXRJMi83KzZrWmpCcVE0ejhVWUlSa2h5YlUv?=
 =?utf-8?Q?VAQA=3D?=
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
	xIhP4DGflwHqFwmQVQvEbkUdKlspbSTc07VJYV5RfzA5gBPp3xP6kJWI+Ci2ISWdQ91h84B5tORxlLGJkTxu8rpxjmlZn83wPAlsTSAUBZ9muC1L/efIQt9OxEDMpeeZKTYIIItYK6fX8CA/hEL7oT3mBtLACu63RwaFeT26XqsocnBFrecFQkejSvI4/fP1aPfiQpQjok1B2IPkUvYEtSNOOCPylM3wUrjLoL12qxK1pL3Rt9Lr8EpBtEXU6MQ10242P6+uhY3PoyuA/VyCIC2Z2G6y9AIxKvIfhVdLuVT8NO2JRADJ276goeLckClS6xU2ywpvn347pGPcenyJm4G3tE+wSVluVqhlhFW6vE4UymbrNkF2/8GE5KoKd/APo+MjMnxDvo5gbwpULv19qzwzCgMld+8tkfASRYpXV+h9jqMtPkAb7f+XaAIsZh+OvLukIRgH9LklWh7gN7H1x9to1RBADzkKiTRweqO6Hm5h6Mds7YXyZL6TXz1faBBHCcRb9ehKRjCAplprXzk2vX7UYKH4R+uzt++lwRWk2LylMsNru2Z6zrG/fl6oK9gqv3X6LqvuP10L7SkNC150BPquV1HUfV0XQY3pXbOFlzaE5HPIkJ4tjww8LhMqtlt7
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e7a6e6-8a28-46cf-8495-08dd0774e870
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:01:25.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHlw2t54t5p0ZIoP8Fj++sy7gbLjdrsNEpUWYklSlL/quQxpOXh8D5wpy8MdfScX2zZHcxD2uJVldMwjAMu+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6119
X-Proofpoint-GUID: Es68eQz3haPTANgLXEhN9zq8Aptn-Wpv
X-Proofpoint-ORIG-GUID: Es68eQz3haPTANgLXEhN9zq8Aptn-Wpv
X-Sony-Outbound-GUID: Es68eQz3haPTANgLXEhN9zq8Aptn-Wpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_24,2024-11-14_01,2024-09-30_01

VGhpcyBwYXRjaCBzZXQgaXMgZGVzaWduZWQgdG8gcmVkdWNlIEZBVCB0cmF2ZXJzYWwsIGl0IGlu
Y2x1ZGVzIHRoZQ0KcGF0Y2ggdG8gaW1wbGVtZW50IHRoaXMgZmVhdHVyZSBhcyB3ZWxsIGFzIHRo
ZSBwYXRjaGVzIHRvIG9wdGltaXplIGFuZA0KY2xlYW4gdXAgdGhlIGNvZGUgdG8gZmFjaWxpdGF0
ZSB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhpcyBmZWF0dXJlLg0KDQpDaGFuZ2VzIGZvciB2MzoN
CiAgLSBbMi83XSBhZGQgdGhpcyBuZXcgcGF0Y2guDQogIC0gWzMvN10gdXNlIG1hY3JvIGluc3Rl
YWQgb2YgZnVuY3Rpb24uDQoNCkNoYW5nZXMgZm9yIHYyOg0KICAtIFs2LzZdIGFkZCBpbmxpbmUg
ZGVzY3JpcHRpb25zIGZvciAnZGlyJyBhbmQgJ2VudHJ5JyBpbg0KICAgICdzdHJ1Y3QgZXhmYXRf
ZGlyX2VudHJ5JyBhbmQgJ3N0cnVjdCBleGZhdF9pbm9kZV9pbmZvJy4NCg0KWXVlemhhbmcgTW8g
KDcpOg0KICBleGZhdDogcmVtb3ZlIHVubmVjZXNzYXJ5IHJlYWQgZW50cnkgaW4gX19leGZhdF9y
ZW5hbWUoKQ0KICBleGZhdDogcmVuYW1lIGFyZ3VtZW50IG5hbWUgZm9yIGV4ZmF0X21vdmVfZmls
ZSBhbmQgZXhmYXRfcmVuYW1lX2ZpbGUNCiAgZXhmYXQ6IGFkZCBleGZhdF9nZXRfZGVudHJ5X3Nl
dF9ieV9laSgpIGhlbHBlcg0KICBleGZhdDogbW92ZSBleGZhdF9jaGFpbl9zZXQoKSBvdXQgb2Yg
X19leGZhdF9yZXNvbHZlX3BhdGgoKQ0KICBleGZhdDogcmVtb3ZlIGFyZ3VtZW50ICdwX2Rpcicg
ZnJvbSBleGZhdF9hZGRfZW50cnkoKQ0KICBleGZhdDogY29kZSBjbGVhbnVwIGZvciBleGZhdF9y
ZWFkZGlyKCkNCiAgZXhmYXQ6IHJlZHVjZSBGQVQgY2hhaW4gdHJhdmVyc2FsDQoNCiBmcy9leGZh
dC9kaXIuYyAgICAgIHwgIDI5ICsrLS0tLS0tDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8ICAgNiAr
Kw0KIGZzL2V4ZmF0L2lub2RlLmMgICAgfCAgIDIgKy0NCiBmcy9leGZhdC9uYW1laS5jICAgIHwg
MTczICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogNCBmaWxl
cyBjaGFuZ2VkLCA4NiBpbnNlcnRpb25zKCspLCAxMjQgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi40
My4wDQoNCg==

