Return-Path: <linux-fsdevel+bounces-6354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39C4816B69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 11:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE9F1C2292C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51033090;
	Mon, 18 Dec 2023 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CRNr5Ndx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iFK73NKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972632C91;
	Mon, 18 Dec 2023 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702896158; x=1734432158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NktjQF2EDIiYU5iO83Shb/G/8BqOsWSy7k+BIp55kN4=;
  b=CRNr5NdxbbfaW86EZi5DQ3H8UX9S/Pst0SETGSKP686a87tdFHDA1/tv
   4QIeGOzkaEGC25dzETfttY8Ulw9CXWDROioel4P7+Gx8EZXsrTDxE/njj
   hnhefE+GeinXmBK4ZOmBNXiNTvwyS3POCLpLBpLdczb0GWdtpJeuHC1Kj
   FWMrF2x6Pq7IM0baf/BbfRnL6YuL4CbU2C+tVJoEED0Mx3EitbiHWGrkq
   4YeIG5paBPYqa4eWRhUZHQqdcAAayuXMyt9Q1g2aA5fYrk32Hi6nJhOZs
   SxGnNX53Uf6rHTaRtbG9rnPknnkEebKmvhvI27Uuy+1e3DT0TnH3kuo+V
   g==;
X-CSE-ConnectionGUID: +mUv9BsQR7qzVKYB6cw87A==
X-CSE-MsgGUID: CPe6rkOIQIaN+ToJAVKXOQ==
X-IronPort-AV: E=Sophos;i="6.04,285,1695657600"; 
   d="scan'208";a="5277417"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2023 18:41:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By/YHCZfT2gDIUO76XJpRbkGE/KO18Gjmg33E8vOR3KkKDY3Nr+CstfQ5Q6N8fFd5RAaqKJz7/agJ9WumTU8urjfjFiaqknX5dje2BdiY5PO30T1gVJC78bq5OQ3A9tStRZLDLsIGJUqG626eR1dIwsm4U54miE25RdcnUqvCOTnJHnlM4EMNO4ll2bSD8RKOIyEy+NK9ZHol4NsaMK3+MqwsbbiTq7NdbDFI+hBR63afTAk5jOQdNOz4epGqgdX5AXQO+CMW055Lo/WdcND3wro8j+SK+jd3f6R4LP1kTxkRGVh1KtBEjgan1tqB8npTgcmiAs4FqImAc6wpPjCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NktjQF2EDIiYU5iO83Shb/G/8BqOsWSy7k+BIp55kN4=;
 b=RsHwHhFNbSLtlmPCeWsWGqdEdB1toZPLFxA4+I4wo9e03bevCUqDZieTe1m/ejapR/L/P0gZwfmCbbW/nxF36KLsjykvs6hDzgXqleKTx0w6iDWL41acjwhWaAqN+fy0kSRokE545b3jLET4v89sHH42i5m/vKN45nRagkJitKVDhgG+xU+ObzqwM6Tl3aj+Wc+sAU2Ufh6OEOaz2aenM4ZSX5i90VfU1OxcY+jJfxHvCZdWnbb9fUUMXNOqw2mrekLcoxyXnOy7UnYkSNG/vJzgmgs7Jg9ysSPthXRI91FhDnm/cMUgZyGM/80TgDfVRCzNJD/E3ersjyz2TlJSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NktjQF2EDIiYU5iO83Shb/G/8BqOsWSy7k+BIp55kN4=;
 b=iFK73NKg2kyuvswSDUNcnvoDUnY9ve1pIkws9l80EiveDCNCj0YVFkI3EYnalQeutdnqSN0NMrQYb+98j/xBGyXNkRjN2NK1SqsIgz0toVDv3vr7cyNvDpzf6QCJQ3Nt5ycDLqJIK/LG7Vzoa9fYa9fExJJzrHzRULVQmwVIf40=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH8PR04MB8759.namprd04.prod.outlook.com (2603:10b6:510:257::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 10:41:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 10:41:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 08/14] hfsplus: Really remove hfsplus_writepage
Thread-Topic: [PATCH 08/14] hfsplus: Really remove hfsplus_writepage
Thread-Index: AQHaL5Hpr4Da0he2ZEWmJqZkmdfVTrCrUuMAgAOLeQA=
Date: Mon, 18 Dec 2023 10:41:27 +0000
Message-ID: <50696fa1-a7b9-4f5f-b4ef-73ca99a69cd2@wdc.com>
References: <20231215200245.748418-1-willy@infradead.org>
 <20231215200245.748418-9-willy@infradead.org> <20231216043328.GF9284@lst.de>
In-Reply-To: <20231216043328.GF9284@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH8PR04MB8759:EE_
x-ms-office365-filtering-correlation-id: 3348dc59-b3bb-446b-d9d8-08dbffb5e346
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yOQyPSSF1E22XEHJDX/pQ3Zrd7RQMzakCPqKNCkiD+xTWJbiucrIvQpmuDlDjr5T7M8GqTiZ7PxXpDOvPaXM3BVEB/hFmezCW55TuiuAMktnkBEK633MTcgvdXvfE/aztsiyaamaPZPzfMbX6jnosv80pZ2eNTTbDZTQKhLzHO/dHZJiXif+3wja68Ie7BnTw8xyOtH4XABmBWZnAFYd9VBGltFxmDg+QMuY1tZmNst3p7gBjsjXnCdiMyPu/S0XYhNSvipXjnTc7y7vmgWwZbKAhyshl0DnjI/uNQ6/XRPplgRhUlnFzZmkYhwVI0vd/aFf8U27MwIBDGqrfJwwk8Jg5Vtco3eatdpKMo/RskgznBPGPwKhRswZEgvzvtS8aoWkAIoGTWRbzcxArFGoPAm0Cs80s9/Tafj8j7BSpgXUxVtEgtHVsjJFhvBX4ZaIZojBylei3gJdE1SidGsjttosrHYXnJ1QlbvItHBjYCLCz9rZPhItibVGd+sOYD182EG7X3cajRbnISTl8CFpDOh/eTxcrfxuBXB5yq02TJM1F1zpwvneTyZ6d6PL0vYIwQznmApZN8YA/ikAULOZ++h/jKnf8gBGktgjVTGlR4RZ+C6e0OYsCponJ9iDg09xkpiWZAs3OhmYDdQo8mcb0kaFgIb4m/sFakk5XWuJ2A2KbL1kq7nf1uVo9Og9/hhH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6506007)(53546011)(2616005)(6512007)(5660300002)(4326008)(4744005)(41300700001)(2906002)(71200400001)(6486002)(478600001)(316002)(110136005)(54906003)(8936002)(8676002)(91956017)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(36756003)(86362001)(31696002)(122000001)(82960400001)(38100700002)(38070700009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z09HcW93Ni96QmdvUjhLZGliSy92YkdIQ000dXA4WHFTbmc2V3hVcDF2L1Ex?=
 =?utf-8?B?YUlBaGNTLzZJcFlyN3NjaUlRc2RiR0xpay8zNHptdHIxQU5wUm53UUdIdFdG?=
 =?utf-8?B?c3ZKNmNBT1poRmFGNExXNUY3SnAvZHBRQTBxRGRrRzE1UzlWZFBwRDBJd2dk?=
 =?utf-8?B?bWhZL0ZjaFZxdWVFUFVwVGlpWktneFUyZmk0UWp6MU5BcEErL2VUVlF4U3p4?=
 =?utf-8?B?VFhYZW5KczFQUUhEV1Jsa21ZWXFRbDVkak9PREtyeFlGQVM4SElURkF5RkVH?=
 =?utf-8?B?NzVhKzNwcGlZU3RLajlIT1BsWks2Rlp6RHVHTG41YmRIa3dwQ2VVT1duVlJ3?=
 =?utf-8?B?eHhud2NOUmVlVmU2VmJqcTlpdldXQ3pXQUV2MkdicU5MTUtRU2dGR0hJK2RW?=
 =?utf-8?B?M1lHaFFwcW9hSEd0Wm1BbnNiQmoxdkUybTZKdTRwWjdEc0hZUk5GeU45WURr?=
 =?utf-8?B?Z1cyc24vazF5VEc2ays4SVlJUnVCd0VjbmdXUlk2Y1gySVNmdTN4THQrRXc4?=
 =?utf-8?B?aTN0K1RCR0h1NVUvY1VRNTVrVzZmdHJ3STNLRmlmTWJ1OGszMjMwRDl2YjB6?=
 =?utf-8?B?MHllRDUrUlUrZ2xYc1gxRHRJSHB4RzFwODgrei9yaGVOS1NTR21YaUkyZHNw?=
 =?utf-8?B?RDRkVUY1czVUanZwUTFVdkNURVRJbkI3TjhXSFRPaDNSZks1T2lHSHZ3dTZF?=
 =?utf-8?B?N1NWSGhlOVpJOUxvcjdmZVBEa3pFci9ENkc0bVE2REZMbE5TN1liSXRnUmVX?=
 =?utf-8?B?WERCN2xwTTRocUFXNTJWNXB1emdmUnJ2WXZjTjFOcElCWEYyNFc4Szl3ZEIx?=
 =?utf-8?B?WjgyVWxVWWpVcTh4ODlXcHVDSEp6a3RtaFpVZFl3YXhXY3FyYzBXbVZkSG5p?=
 =?utf-8?B?YlhwWVZ4V1NlWThSUHA2MmhyNUN6ZHMyNEwwM0tqaEtiZktZc09Kbzl1K0c5?=
 =?utf-8?B?RXZNUVJIWUJJa1kwRm4xWmVpdC9xT2lvQmN6V3hsaTlkcEhMLzdUMHZQUlM4?=
 =?utf-8?B?RzJTZVg3b0N0ZUZYWExzM1J4bEJTTmEzb210cDgwS2tmdXRTT1pUWlVjWUJY?=
 =?utf-8?B?SlZmM1Q5WFgxNzBqTjROVW1RUi84Lyt5QXFuQ21RQnhLOVRHZ0xjclpQNm54?=
 =?utf-8?B?M3ZNTUJRQVZIS0lnVDB0OC9wbVQzeVdLUVBNa0lzVzJtWW9qZEs3UCtHS1B1?=
 =?utf-8?B?Q0hCUlRNbWJVK1BzdnNYS1ZTWUM4Q0d5SjBsYVIzTjA2ZHNnRytVS05vb2pq?=
 =?utf-8?B?cW1UV0ptbFFyTGJFNmQzWjFzdCszOXZDaVBWN2hBNi9VNXY4MmxnUVdQY2Fo?=
 =?utf-8?B?Rkl2dTRNcUNUOUc4Um53czRuVVJqT1FteitLVHhRSS9OaXpkSUZGeXV5Tmhk?=
 =?utf-8?B?TFNUUXhsd1lwNnpOUFc2aDNPK1R3THlUajk4VlpYWEU5UHI0RkgzMkJQVWp6?=
 =?utf-8?B?N1R3cndaNEN6UmluNWZQSStKUExRcXRaZVZYdXFaWldjMXRkT0tKUy9icy9O?=
 =?utf-8?B?VjM4MHFaU08yeERLTEh3MUF6QWNkemlNemdyTVZuTVJGeUNVUm5qUHRuNWlr?=
 =?utf-8?B?UGZQR1FMOGR4cERtQ0dmSFB3Vlg1WjhHRUl4dEJmOGNFQ0NHU09rNTh1ZWhv?=
 =?utf-8?B?OGNUaTNlYmF6RTVVUDIwWHViYWxxd0FhL1BIWndNNnBIUENvQXBkR1NBSGhn?=
 =?utf-8?B?VHBJaDFqTWVKeHBvaWp2eVBndW55SWhmc2IyVkQ2cGphZGhNbzhiR0pCVnVO?=
 =?utf-8?B?dGV6YllxK25oLzc2bnV5TnFjaU4zSXZrd0ptZWZ6TjlwMDkwSGFDKy84azVE?=
 =?utf-8?B?Qk5XTC9BWmwrREUwMk8rYnk3cTFrWXFMUDRMK3E1Qk5GWjBHWW9kWUwweUtG?=
 =?utf-8?B?bk50T0dTYVp0YmYzUU1VbEg5K0I4WlNTdFp0KzVrakFxMnA5YnhHT29BSTdt?=
 =?utf-8?B?QnVDZE1zNXQyQU1mNmlNM2RGME1EaUNXZE9sVjNZYk8vQUY1anNyMkdMOE92?=
 =?utf-8?B?K0Vaamt4bUFlazFURjRwTEFVakJpWFhWTzJnd2QwVU0rcjNNL0prTlM2ZllG?=
 =?utf-8?B?aUhrWG9OQkkxaWphbmtEUVZHNE1PRE1LV2poa2M0blpIdXZrSzlDb2Q5cHpi?=
 =?utf-8?B?ZUVHbENkWkw2RVVQVXIxaTlLd0FXR1FNbGZGR3BYMDZuY3JOb2E0YnBBbFZD?=
 =?utf-8?B?OWhHejZrWlAyQndsb2Z0OHowUEp5bGRNSU9vd2I2bmNjYlc2cUE5dlg1bVhT?=
 =?utf-8?B?bVFCRXJrajV0YTNTcHdaMTd5dlV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C500415C4AECCE4DAD715D98DD4DCECA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q8K1WUwodA/oL0vKNR2mWw1G3CAxVvESA3aodg3m4A1gi6Q5IZI2U8Q4Q7VaO3j0Nw1e2izoMyKh6f4k6mNpMU0JnvFVhe1OLOhWgg2g9xCbllFcymB0aM9j3y7RHATMmdmDJskAb4DHgpCFsjOLl1xBF611BKCKhj+zq4GmG2pHYH1LkyoqjbXOeSWtcnjBj20mXzBa61pHo5zZJnuIvUupRk5kLorZNSq6PD5iVtjKJsVKubOw43s3dKVDhhv0pF+//cU62S1L240HCUptYnkm0DvGss+JzmjuTvEQ6zBKfMRrPCeE2bWU0p5oA0kYJkLeprX61XWYKgNWt/3y4pE41hk+zUqmw9+6OmX5TsOXb0FTJMb7P+aB1ys16SfV8i46kU7zhXJz2Vq6N2n2rku4Z7gvDNvKYOdH4MoEDqLZr5XnzbT+ZiBGa0pN+JiFdpeKE/oBprJnu0E130rxI5Hy7RegbFr4tvDAkpGUHwsUtbbl1g/vRgYcVIvyrY7b8lDgq6jbGD+YQHRQST07wbSxXYAUdLyVaJqHNNOW8WXG/PZCnITl5Co7KjUxTGq+aAP9pFwRqjEgk+gm9gxjEGS+6J2tgy3V4SOEmFXDMBzO0vB+hkmlpf+9oGRcwe4d
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3348dc59-b3bb-446b-d9d8-08dbffb5e346
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 10:41:27.0205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: su8TBrpzgY8NQI8jUvtpdum3y3X7PS0s/1zuYwg4hXHSOxrOsqQCcl7LYmnQpheDdjpzMFV+ZtsODEHqdzlffftlhK6L6CZ9I10QobBJcG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8759

T24gMTYuMTIuMjMgMDU6MzMsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBGcmksIERl
YyAxNSwgMjAyMyBhdCAwODowMjozOVBNICswMDAwLCBNYXR0aGV3IFdpbGNveCAoT3JhY2xlKSB3
cm90ZToNCj4+IFRoZSBlYXJsaWVyIGNvbW1pdCB0byByZW1vdmUgaGZzcGx1c193cml0ZXBhZ2Ug
b25seSByZW1vdmVkIGl0IGZyb20NCj4+IG9uZSBvZiB0aGUgYW9wcy4gIFJlbW92ZSBpdCBmcm9t
IHRoZSBidHJlZV9hb3BzIGFzIHdlbGwuDQo+IA0KPiBMb29rcyBnb29kOg0KPiANCj4gUmV2aWV3
ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiANCj4gYWx0aG91Z2ggSSBo
YWQgc29tZSByZWFzb24gdG8gYmUgY2FyZWZ1bCBiYWNrIHRoZW4uICBoZnNwbHVzIHNob3VsZA0K
PiBiZSB0ZXN0YWJsZSBhZ2FpbiB0aGF0IHRoZSBoZnNwbHVzIExpbnV4IHBvcnQgaXMgYmFjayBh
bGl2ZS4gIElzIHRoZXJlDQo+IGFueSB2b2x1bnRlZXIgdG8gdGVzdCBoZnNwbHVzIG9uIHRoZSBm
c2RldmVsIGxpc3Q/DQoNCldoYXQgZG8geW91IGhhdmUgaW4gbWluZCBvbiB0aGF0IHNpZGU/ICJK
dXN0IiBydW5uaW5nIGl0IHRocm91Z2ggZnN0ZXN0cyANCmFuZCBzZWUgdGhhdCB3ZSBkb24ndCBy
ZWdyZXNzIGhlcmUgb3IgbW9yZSB0aGFuIHRoYXQ/DQoNCg==

