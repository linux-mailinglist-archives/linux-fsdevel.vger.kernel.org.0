Return-Path: <linux-fsdevel+bounces-62854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0710DBA26ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 07:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D321C02D47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 05:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EFD2741AC;
	Fri, 26 Sep 2025 05:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="oDJcGem1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23610246799
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758864021; cv=fail; b=E2pqhRZ/h2AhBpxLmjkOq0CQGdiINRJ2a/1fxZ02M93kpP+SsA4FmNQsVe+pW2zoazXDl+YMFOe57eNNyvYVSnnNVW+EDx2JXoNET4/YtNvOlsUh2AH/pfF6kmN0HQaDMfjhg0zmu7VN5w4mnole97wiopKHb+NeInjSC1eHdQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758864021; c=relaxed/simple;
	bh=pKAHNqa3RrqIfeboHtR7qRgqK0V+vZKQ7Bq+wInoGOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=POC4Knd8HAt4WdInNrKHsYVGhsNBzpsAo6z+xMmtu4WKjtq9OTHgx2AxPIZonHyv2DmPzTrxzHbcfDY6bCtlgJYYaWv2zkSTeYCmFOhKL3UnnWSpA9pDVLrL7g/lVyQKrOv18dj6Y5heKk4W1MuYiMzKsUat0TKootsPt/Tw2aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=oDJcGem1; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PMKL4H031488;
	Fri, 26 Sep 2025 05:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=pKAHNqa
	3RrqIfeboHtR7qRgqK0V+vZKQ7Bq+wInoGOE=; b=oDJcGem1c9A6FuyIoVwKye4
	uxc3IzGvX41D9y3vnjFh2TpZJRLjM+YwHFq9y7GfTlNW5267WhLkj7hgOC0S/Zst
	jVSTBNKZW925LGMDZVG0YTnbVI1kr8sfUyTarv9Jiwsisadc6JRtmNQrej8BXKCt
	+9mAvRJc/J2+3Mddz55ZJ03M6BRuXb3QTWeLOj2rtekZUHP1tv81nlmjx3jczHSN
	ertFY0Y79gzizBbnIcU7JKEYA9Uw9YXwdnOSki2CmCEEvrZ8CCvSXw/2HCo2LEVw
	O8NPYaGj4ulTn/iJtX2bq/9+PtlvjyVcGTpKl2MKEC7MABd6rgNVCGQykTHP51g=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012031.outbound.protection.outlook.com [40.107.75.31])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 49daw5gk2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 05:20:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO1W7hMp2eiTLte5VqLqn/9PUrNU5xOgHMy2ibPWLcKmNi+IAm7VfPNpdswXwmplBCutaVD1wpwtetRFDkBjRStO7YYhgxIbAKV751iekRCqzLlY+JpX/u1+wmqo3vTDN9W3X/7GlW6skgAEWg0clUF4INnJ1Q5dGYKdWCcffDM7DM7d5IR1sAt9xnlCwPQxWTrtGsn25YUwJ733evBztEFWjvE5txXY5VMtumtOynpl5KB89n7cj6nuzwyIqMGs4ZPitQp6JUZMtRLETbJLCDNZdU8ht/U4p+/KPaqemyg751TVFGaYlleoW18IkkDlXaZUrUMz0l9iuJ53HzTh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKAHNqa3RrqIfeboHtR7qRgqK0V+vZKQ7Bq+wInoGOE=;
 b=Uf/UyiFwV2yoUecxW57YeyMnDEppkkHpiYDKUSIojDaLuC79Bzn1zpfKackRUiY4NVrMwQzAGITBW8+eismntntnK6OFfD9HqaoMzG1nFZMFQjvSB3NmVzpuydNtp85YHLPtTonsqxCzvHvP5c2giL1qXfuIxSnMfa5YDh+mOVUUA/qz5E8PcndmWLv4dkNezk9yifugPxVZ4aMVbTM3tpY562FUgnNjt/YtbgepUe8GhCYqqoSU/2CVK0CHyeUsWWnK+oyeOGlT6xvBR3D7psSEFYLYlVzj6ccPaKDMpNhP2Zo4etJb7OW4/NEOpivZlKHPBdz3Kl4GiC0AYPr1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7121.apcprd04.prod.outlook.com (2603:1096:820:f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 05:19:55 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%7]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 05:19:55 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
CC: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Subject: Re: [PATCH] exfat: move utf8 mount option setup to
 exfat_parse_param()
Thread-Topic: [PATCH] exfat: move utf8 mount option setup to
 exfat_parse_param()
Thread-Index: AQHcLpc7P634kEkOY0iGrMX887YZqbSk2nQAgAAPuZI=
Date: Fri, 26 Sep 2025 05:19:55 +0000
Message-ID:
 <PUZPR04MB63168BA36C98DD9A732AD487811EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <PUZPR04MB631693B0709951113DC1B8DB811EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CABFDxMEwSNh4Uhit_uPugJe5uyz_w9JfrgZ7qvVJZziUcdVXJQ@mail.gmail.com>
In-Reply-To:
 <CABFDxMEwSNh4Uhit_uPugJe5uyz_w9JfrgZ7qvVJZziUcdVXJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7121:EE_
x-ms-office365-filtering-correlation-id: 92a1a020-574f-4bcd-4939-08ddfcbc5414
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajR4ZGV1cExBRVc4eUUyM1RhdWxNMW5GdFA5T0tkSWUybnltcXlRZzFTU0hE?=
 =?utf-8?B?YmVSNUhmY3ZncS9DSmYvdnU1NTk4dXNWZDh4TU45UnZDUzl3eGlVS1VFQWU1?=
 =?utf-8?B?STJiSkgxMGhEWHloWGcrRDhKbFByM1Z5VFM1N1lBT2Fsb2JGOXJsdW1YV25Z?=
 =?utf-8?B?eks2SWczYndTdVBvYWhZQUwxU1M1bFlzMENhcThTb2FSNU9XY1BFNERnVm85?=
 =?utf-8?B?VkMycHRacUxBNldDd2MvcG1MdVcwajZMR1FEWnNrS3UrSHFDMklHV1VrekQy?=
 =?utf-8?B?Q0lMaFJ3T3lDZkp6UnlydGRXQzkzRmFBUmFIeTJQRHZlRXVBQ2Y2bXhUWEFW?=
 =?utf-8?B?Wlo2NkNPNVo2YWk2WmtUV3dvUmFueDhNd1Qxc0NpZDRFREhoV0NTbCt0WHh3?=
 =?utf-8?B?dWt4YXpUYXBXa1E3S0d1azZydlRiVVRuSnBJTXpDL01rWE5HMWFYTmltZ2pM?=
 =?utf-8?B?MENYbEpaNEp6cHdhdEpXdGljeDhIamMzMDFyaHNVL3ljanpkS2NuZ0FNeFJ3?=
 =?utf-8?B?MWVPSC9nQTJoTDZjMUgrNXVLVHJORXdmYkM5NVZ6cVAvYnliem1OSUlUVWFR?=
 =?utf-8?B?QmE4anp4YXFURGF4Y3Y2b1FPdkRoT3hKNWNqVWJHaXAvWGtrelNHUXg0K0p3?=
 =?utf-8?B?bFRycnJyOENHVS9lUGRMamlsRHpJaFNybSthOGlPNVF0cDd6UDJyL1RRcnMv?=
 =?utf-8?B?VGo4Y2VEWHl4TXFqS0srZXFSOC9aSmV2M3QzamZpQUJyRllOUzVPQW1WMGdh?=
 =?utf-8?B?c1ArY2cxTEtmL3krZUVwTnU4b24zNCswcnVJSndmZUVqbHd5WTF0QXR6bEtQ?=
 =?utf-8?B?QitBVGUraWZRM3VBMXZTdmUvTDdpRkpDSUpBSElhQ0NGdFQ1dllZWUk4NHV3?=
 =?utf-8?B?U1dXb20wRFpPRTQ0MDc0MHM4akZxbmVYLzlRSlhUc0JsNkVZZUFjbmJSN01D?=
 =?utf-8?B?TDg0Rm95cVZCMEwyWXk2UzdUcFdsNlNQNEdpZWxVQmFYUm5lQlh3N2dEbjF1?=
 =?utf-8?B?UG5FU2h4Z0ZXUkNRUzRGZWpLaS9GR2lkNFE0NHVROERUMVpmc0lDMXovQkh6?=
 =?utf-8?B?S040MWRrelJ5NEY2a2tSZXNrOFVXemZGWVpMczRld2FLb0tzS2hxNFFvdWxU?=
 =?utf-8?B?Y0RUU1plLzZTd0ZGM3RrOEhVeUY4QmJNd2JlY2VUQWFqcTl0T2NOSFh3UFJj?=
 =?utf-8?B?MmR3cFYzSGdiOEdjN1VSV3dzTm05aUF1TWkrTURFMEtRL3lGcWhLWGZ1bU1L?=
 =?utf-8?B?M2puQTRvOHRQMTdKVkQ4NEFEM0ZtQUkwRXk4TE5TTWN1eUlWOHpBeC92OGJL?=
 =?utf-8?B?YnhYV3lWakl5dDdSU1Y5NDlPYzRCWkE1dnRGT1V1T0R5SmZETkhlWDRUR3VH?=
 =?utf-8?B?dDZjTVQrUHdVL0pTWERLOXBwSFVqZE9NSXhvUy9RSGd6eVlsVDBHdHFhMHNi?=
 =?utf-8?B?VzhiYndIY2xTKzZpOHRVUlBDYzlLSDVjYnRKR3JuUDlNRGdRUmFnSFZKV0lw?=
 =?utf-8?B?QXlzaHhHa0RzVDdaMFpxUUpiaUl3QWI3M1JHeU55L2VmeUlhZ21wenM4YjN2?=
 =?utf-8?B?RThoNENIN01iZDdDcXhGU1ZzaVZ0Y1VwVG5UdVczaTJ0cjlFRTJVdjYzRDhz?=
 =?utf-8?B?ZlhMN0k5WldZVlh5ZnZjNXhRV1dPdWpmdEdTdHFpNDluRERwdHc3dy9rdjJK?=
 =?utf-8?B?NDliYkZWWnAwQmRnU21scVpUcTJPUFh4bUw5b0s3M2lid09QZHVreDZ1MjJn?=
 =?utf-8?B?cnZpSnNtUkEzbUY5Y1RDS1hydUJNVVVJejk5emw1c2xYNFBOY2N5ZkJtSU5y?=
 =?utf-8?B?NDdVbEptODZDYXlsN3l4dzJOOEo5RVZwcC92bXJpdmpIZEU5UWFHbVU5cmR6?=
 =?utf-8?B?VHgxbmdJeEUrWE1DVk4vbDJldk5DNFYvRS9qd2w0cVRXcFp6MUxOeDd5MWZa?=
 =?utf-8?Q?0l5MsCIjx4w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWEzQlp2WjZhQy83eDg0SmdQb1VGTjVaYXNNNzN0SlpKQXZRRWpCeld6SlV2?=
 =?utf-8?B?RnJ0U2Voem41UmY1bk1oMHdUNStvMjJIVGxKVnNrRHBoZ0M5VXBnZ3V4WWdl?=
 =?utf-8?B?RjVVMmRiYU55Y2g4emxVV2Z2aGJvWmtGWjZrVk1PTjBQSjFwVDdTUFB4Tlk5?=
 =?utf-8?B?K1E4WTBWdndvZHFnaCtHdVZFKzVKYW9LUm85bk5zS1NuR3JIRHRPZUsvOGY0?=
 =?utf-8?B?SWJsakRUdHZpOERrZENvVWh5anByVUhRb0pEMEMrVW9tSGczOWE4Tno1ZDFE?=
 =?utf-8?B?NUZxNEtVOWs3bHVYZHBtSGNsYTZJWEtUbUxobnR4TXA5c2gxemxzN092dE1Y?=
 =?utf-8?B?TURhenJsdC9ZZ0g5dVMvUmhMNEdVOTE2QWlqVjlqajN3ZVRsakJ1ZHJ5RGRi?=
 =?utf-8?B?Y1RyTjBJcXhiVytJemFWbEZ4eXAvaVF5dFVFN1dGU3F4WTVhZEQ5V2VnbXFn?=
 =?utf-8?B?U3hyQnRsN1FrZ3JZb3h2RDdST205czlWWVRDeUtPdjF0N2hmSFZmaVZWSEY2?=
 =?utf-8?B?Z1QzV3Uybm03YlJ2d2FSdTNWanpaUnNQQVFxM1dPTEhpNjRLWWd4UTlYN05O?=
 =?utf-8?B?YUw0VnAwWWJjWDd6RGxQSEpSdEdQeGtkTEwrbU1LMkR5ZHN2OTFxWVpMU1J0?=
 =?utf-8?B?Y2JGVE8wSUhtVkxLbG9lY2c1TnVSSlplTzB5dEg4c2FJWGVVMjZ6Y0hpTE52?=
 =?utf-8?B?c0RCc0tUajFLc3JpNzVva3BDbms3c3FkTTc1VWEzUzMrUmpWay9JeHdmd0gx?=
 =?utf-8?B?WkVXcDh4NGxWRjFIRGpPRmJUck5YRFJOOTFsTldaeGNJYVhtR1dnVkljSmtR?=
 =?utf-8?B?TGtMS1ZQRjFCRUI3eXpjd0pDTDN4elJmdE9vN0RiRERXcC9SaXkxUHhZRVhC?=
 =?utf-8?B?Q0M2d3lXMFZrbGgvTHozUllQRGVzM3VEOUFYdUF3YW9ab0R3RU8waHNoTk1x?=
 =?utf-8?B?UUFxdjcxSnQxeTk5U0pDblo2UGluR2JGVVJ4SzQ1bFczQy9qZk5KZjRQZ29j?=
 =?utf-8?B?bUtENWs3YnhEeWVwWGphV2NmTFMvc3BHS3BsRkVXazdWa2lCUWtrM0syd0lY?=
 =?utf-8?B?ZzNkeGVhK3ltcjZyUkd0aDlabTRTSmhrMnVGWlozZFNjUHBrMW5PVTU5WFNH?=
 =?utf-8?B?dzMwZXRXcGlGNGJzczJRVm9VNDVhQVVvUWtmMUxENGNLM2lYdU5zQUQ5bm1s?=
 =?utf-8?B?d0E1L2VSOVdqdlZ3QlBWd2p4U3F4MTc1R3ZNbjVxK1ZmQXQrTDArd0lBdy96?=
 =?utf-8?B?SHR4YUZsREpSRmVoWm5rMElFK3JZTDFoa2llWTBDSlNlTVgzTHFTQnRSZUFZ?=
 =?utf-8?B?blE3MW53eTBaaldpR21yQmN6WnA2KzNjeS9BSXJoUEZWdXhqem1oa1k1QVVT?=
 =?utf-8?B?a0pqV2lPT2k0bGQ1eVdWL0RWSmxhSWJzOFlOVjc4RzBKV3puWW9yK2hjL2ZZ?=
 =?utf-8?B?YnRaemtGSUNycGN1c3Z4YlNvWFp2R3NYTjdTeG9zNDFDbXBhaEdPeWxpcjk2?=
 =?utf-8?B?dUFpQ0IwUDN4QUZwRzZzOVBZdTJOMEtTdDZyKzV1Q3lZSDMwUEdwajZqLytD?=
 =?utf-8?B?QTJhMUdLSlo5T1RKd3FING9DUkphU1B6ZDFJMkV3cUxnMGhlRnhSTll0a3R2?=
 =?utf-8?B?emp2U1psRnJOL3R5ejdtb2NjdHhNb1p4bWpmZXhiZ1VVcmM2dHJrYk0vdE95?=
 =?utf-8?B?Qm9OdHlqVTdoSzBlbCtnNkNDNjhNT2d1VFVoNytGN2h1VkViL1dlMVJYVXFJ?=
 =?utf-8?B?TDVyd08xUlBVai9yM3lFQWRlaFVDY2lzVWFwOWhDWnZKRmhGWlk5SEVtZHV6?=
 =?utf-8?B?Y0ZtNGtwOVU3QjBpc0lNTEVlR3JhZlg1TkV6YmJYRzAxNGZWRnhuS1NWVTAw?=
 =?utf-8?B?MTZSOFNSdUpYRFRZRjVibUxEckl1SERGaEJyWDF5UTlEOVdOZmpzakMyV0VE?=
 =?utf-8?B?SDZyYUJVYkJMNWVFWWlRVGdBM01GTVNobTVJaFNYUC8zYkxQbk5sM2xpakda?=
 =?utf-8?B?UFVmWE9FTGdlcngyOGZwV0o5YllsamhpZ28zVmRsR2VOdW9VT1REclBWSldn?=
 =?utf-8?B?QzdDNDgzV01JUHdSaW9aRndFNGZ6bWkzd25xbmR1dDc3ZTVPMzBFNkwzbjdR?=
 =?utf-8?B?TXBEY1A2QldmYXc1UzBTTXVxaHViVGhVVll1NTFTT1ErSlJoUy8rdGl1UXM0?=
 =?utf-8?B?M3c9PQ==?=
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
	jX+nPrjUcx93a/I6WrfLBsOQm+ZMEEp88RoY40OjXV1fFha97EaIkCwo1Amk8n+/XHd1xRZrHWsaD1v1AhOjtvXgMFU0RdAaL/3VcFKz4zBjXI8Ff0ZFcfpXc6DX8/mUOoWjKjmXTg6rrz671ieppppxORhMxvc8ymgp/jX3QCBCTQpoayBmHTMUEB+GFdCh5P3bJlsQVI3XMLD53AY0aG97NYZz1h6l/9hQRSTIpx9cPYUUyDgSPJisRstyamZfBz65Ev7hB6aFSJfeIPCU7WLsTzIQrBO9va9/p3Ujy8c1qAceoL7ZMZ+NqNwwyDBLp9JzjIRRuYAp6uks5+DSK5ieE7X9B9XG0QjiDCT+1jek7hDXujFRkVkDamGBAP+Z09ePRfW0Q1wzPXNl5Q9mELuS3KtfdZdls7FpZ7aPV6YttM2No2Px8g8SsbhkamuEej/yElcALnWDgk4T3weMYNJqJQ7dULPzgOT5nqJ5PrGr/DeledSi5aSFAAbd02t0emCdeylvwm1byGTTukacByyWXa628PQ1g4QhsB00hw7baUaE6GOz8CVv0DbKdsaYo1ckq45dlsEju0mM4rwAaO+nclrN+C7N7BWJ5FQgxLFAWtIBQdUmRDM7i7yu/UIr
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a1a020-574f-4bcd-4939-08ddfcbc5414
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 05:19:55.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOj1gdD7U7OTyIskLmjmHM2VHpXFcvz7lC4mzvgUXQD1GbfWPg7Jt+QkjdHwEJpuLfdApveh2Tr92fEv8k+i8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7121
X-Proofpoint-GUID: nEa1diBY7uZ967W9TMvYdx7PPnIIyDq-
X-Authority-Analysis: v=2.4 cv=IeOKmGqa c=1 sm=1 tr=0 ts=68d62282 cx=c_pps a=wqg/xdzaCh6LQOKqGP1W/g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=edf1wS77AAAA:8 a=z6gsHLkEAAAA:8 a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=FQrN6S8f3NVr8L9YEC4A:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-ORIG-GUID: nEa1diBY7uZ967W9TMvYdx7PPnIIyDq-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MCBTYWx0ZWRfX/sQ4nRcDMBls 4rjl2buRK5gkGL91FHtaSh90MNCA0TSZX4HVdL/ndC/RKyP26sB4LB+LrAl12aIVhWliyo8elfw +L2mvG9B76ojFChdhcztt1/My1GF8NBat02q2vHVp4XeymgAqBs9XC/efZd3ryS/nvyaGt/lQgJ
 7Uxp8a36SKv8VoWe+/Y8o+UgbTVowMd9VlchwBweBLrw11m+MnXczAyjVJ8z40UnVQ/J6K34gSR TvWPgS7kp05SPdlV2ZMjq1pXP+FgXxNGrB0Zcz5UvQtpjYmhP4bP7lYWNKshcBkkWmZHw7brVgk TeSfBhKdv9gwJjyzl2hJ0rT5y4I3B8BPjyqe8nv3g+exNYNQp3iwCaoapA9H+8iBHUhJuRXGKWj
 aFLk4RHbUTAelzD5F7jXZbmpdfD3nQ==
X-Sony-Outbound-GUID: nEa1diBY7uZ967W9TMvYdx7PPnIIyDq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_01,2025-09-26_01,2025-03-28_01

T24gMjAyNS85LzI2IDEyOjEyLCBTYW5nLUhlb24gSmVvbiB3cm90ZToKPiBPbiBGcmksIFNlcCAy
NiwgMjAyNSBhdCAxMjo0MOKAr1BNIFl1ZXpoYW5nLk1vQHNvbnkuY29tCj4gPFl1ZXpoYW5nLk1v
QHNvbnkuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiAyMDI1LzkvMjYgMjo0MCwgU2FuZy1IZW9uIEpl
b24gd3JvdGU6Cj4gPiA+IEN1cnJlbnRseSwgZXhmYXQgdXRmOCBtb3VudCBvcHRpb24gZGVwZW5k
cyBvbiB0aGUgaW9jaGFyc2V0IG9wdGlvbgo+ID4gPiB2YWx1ZS4gQWZ0ZXIgZXhmYXQgcmVtb3Vu
dCwgdXRmOCBvcHRpb24gbWF5IGJlY29tZSBpbmNvbnNpc3RlbnQgd2l0aAo+ID4gPiBpb2NoYXJz
ZXQgb3B0aW9uLgo+ID4gPgo+ID4gPiBJZiB0aGUgb3B0aW9ucyBhcmUgaW5jb25zaXN0ZW50OyAo
c3BlY2lmaWNhbGx5LCBpb2NoYXJzZXQ9dXRmOCBidXQKPiA+ID4gdXRmOD0wKSByZWFkZGlyIG1h
eSByZWZlcmVuY2UgdW5pbml0YWxpemVkIE5MUywgbGVhZGluZyB0byBhIG51bGwKPiA+ID4gcG9p
bnRlciBkZXJlZmVyZW5jZS4KPiA+ID4KPiA+ID4gTW92ZSB1dGY4IG9wdGlvbiBzZXR1cCBsb2dp
YyBmcm9tIGV4ZmF0X2ZpbGxfc3VwZXIoKSB0bwo+ID4gPiBleGZhdF9wYXJzZV9wYXJhbSgpIHRv
IHByZXZlbnQgdXRmOC9pb2NoYXJzZXQgb3B0aW9uIGluY29uc2lzdGVuY3kKPiA+ID4gYWZ0ZXIg
cmVtb3VudC4KPiA+ID4KPiA+ID4gUmVwb3J0ZWQtYnk6IHN5emJvdCszZTljYjkzZTNjNWY5MGQy
OGUxOUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCj4gPiA+IENsb3NlczogaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD0z
ZTljYjkzZTNjNWY5MGQyOGUxOV9fOyEhTzdfWVNIY21kOWpwM2hqXzRkRUFjeVEhM2hpM2RiZVlE
TlppSW1PdEI5bUxuWjdZN1NLR0tMNExzZGo0Qzk4WXNiZWZLNHNoNTFCYlBNLWkxWlc5cUcyWklY
b3BNUUVkJAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTYW5nLUhlb24gSmVvbiA8ZWtmZnUyMDAwOThA
Z21haWwuY29tPgo+ID4gPiBGaXhlczogYWNhYjAyZmZjZDZiICgiZXhmYXQ6IHN1cHBvcnQgbW9k
aWZ5aW5nIG1vdW50IG9wdGlvbnMgdmlhIHJlbW91bnQiKQo+ID4gPiBUZXN0ZWQtYnk6IHN5emJv
dCszZTljYjkzZTNjNWY5MGQyOGUxOUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCj4gPiA+IC0t
LQo+ID4gPiBJbnN0ZWFkIG9mIG1vdmluZyBgdXRmOGAgbW91bnQgb3B0aW9uIChhbHNvLCBjYW4g
cmVzb2x2ZSB0aGlzIHByb2JsZW0pCj4gPiA+IHNldHVwIHRvIGV4ZmF0X3BhcnNlX3BhcmFtKCks
IHdlIGNhbiByZS1zZXR1cCBgdXRmOGAgbW91bnQgb3B0aW9uIG9uCj4gPiA+IGV4ZmF0X3JlY29u
ZmlndXJlKCkuIElNSE8sIGl0J3MgYmV0dGVyIHRvIG1vdmUgc2V0dXAgbG9naWMgdG8gcGFyc2UK
PiA+ID4gc2VjdGlvbiBpbiB0ZXJtcyBvZiBjb25zaXN0ZW5jeS4KPiA+ID4KPiA+ID4gSWYgbXkg
YW5hbHlzaXMgaXMgd3Jvbmcgb3IgSWYgdGhlcmUgaXMgYmV0dGVyIGFwcHJvYWNoLCBwbGVhc2Ug
bGV0IG1lCj4gPiA+IGtub3cuIFRoYW5rcyBmb3IgeW91ciBjb25zaWRlcmF0aW9uLgo+ID4KPiA+
IEl0IG1ha2VzIHNlbnNlIHRvIHB1dCBzZXR0aW5ncyB1dGY4IGFuZCBpb2NoYXJzZXQgdG9nZXRo
ZXIuCj4gCj4gVGhhbmtzIGZvciByZXZpZXdpbmcsIFl1ZXpoYW5nIQo+IAo+ID4gSWYgc28sIHV0
ZjggaXMgYWxzbyBuZWVkZWQgdG8gc2V0IGluIGV4ZmF0X2luaXRfZnNfY29udGV4dCgpLCBvdGhl
cndpc2UKPiA+IHV0Zjggd2lsbCBub3QgYmUgaW5pdGlhbGl6ZWQgaWYgbW91bnRlZCB3aXRob3V0
IHNwZWNpZnlpbmcgaW9jaGFyc2V0Lgo+IAo+IE9oLCBJIG1pc3NlZCB0aGF0IHBvaW50LiBJJ2Qg
cHJlZmVyIHRvIGV4dHJhY3Qgc2V0dGluZyB1dGYgYW5kCj4gaW9jaGFyc2V0IGJvdGggdG8gYSB0
aW55IGZ1bmN0aW9uLCBhbmQgdGhlbiBjYWxsIGl0IGJvdGgKPiBleGZhdF9wYXJhbV9wYXJhbSgp
IGFuZCBleGZhX2luaXRfZnNfY29udGV4dCgpLCB0aGVuIHdlIGNhbiBwcmV2ZW50Cj4gaW5jb25z
aXN0ZW5jeSBiZXR3ZWVuIHR3byB2YWx1ZXMuIElmIHlvdSBkb24ndCBoYXZlIGFueSBvdGhlcgo+
IG9waW5pb25zLCBJJ2xsIG1ha2UgYSB2MiBwYXRjaCB0aGlzIHdheS4KCkl0IGlzIGdvb2QsIHRo
YW5rcy4=

