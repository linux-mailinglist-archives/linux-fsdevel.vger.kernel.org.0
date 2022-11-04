Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD78619652
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 13:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiKDMgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 08:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiKDMgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:36:42 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB52DA8B
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667565401; x=1699101401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TyeCoEFhBcjam5WDLNJxpQIv1751QJin4t77LdQ7C7Y=;
  b=CIyVpl57tFcnrSHmPF5k0TvBVbWubqjoecFUtCjnK/4xDhoUSwKlrNvj
   3K8/CiOgT2LJV3L8/9KLxmcMfYbQ/5lTL9vJA5CnxBifOhHrQ94F/61do
   9y0WmknehnEMymVNANPOnmubSI+qtO5hvFnGCYCaOjeN2p1qyBip3e20K
   vQdx+vNEUKsr5+pdbXdHRI4sW1oaIEnduwSmNvibKUrbXUBVFz+hqniLd
   Y1F9uz4v6nuTHMWoTochbE1qD8RAjokW/MC6Zzd2Ch/lZtCJdRdHXJVss
   OmAznEBX8UNbNF2oKMMTJFbXs+Ol5X5Ad3Wuzn6VUKXu26Gf7UPVnSAoU
   A==;
X-IronPort-AV: E=Sophos;i="5.96,137,1665417600"; 
   d="scan'208";a="220649877"
Received: from mail-bn8nam04lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2022 20:36:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYfYgSA4iv4EsW9kpDjyjmB28cSXz58yrL0JY6/ShAZQxQQEFsdjpo+7kjye6HzyXXxTMGTUyy+Jr2ycYZXQweze37BgxSY7FKv0mTb/RyW63fCLa67tX49BLo+dTlaKkVUyoEj3R4PzYA+o0p3njwhAAiMOviBy9NGt1CrOSiLdBoPBb0dQF48BNfCTIOI+w3GCvjesa0EeG7tB0cvk5+AEwd7Yf7U2zRNl1j+bCWeYVicEgIj+1iPDgK6DQFxDruccbmdfU2xRn1Qs1B/73zfuFdDkplPKBmlVgviNTIHKFWYbcMSJnhvMxWJKV1dmxqsmznU305lgFgci4d98oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyeCoEFhBcjam5WDLNJxpQIv1751QJin4t77LdQ7C7Y=;
 b=YPhUjct0mWs15S6lx43t8E+s+dlAKd7vnl1rLqle8x3Mw3V+RgzD+Wa6g5gyX9tnxE0XaiACcd8Y8VwDRlQdZpOsLI/Priq+H2Y46yFaTv+1bx1fS7QoUaVxyIw/dD032oWiRL6L+fQYLAC+WRThnOuWDZujMryDqHctfc1YuC5L5AzwJNYQRAEiinFoLhLlUYc4/uRlqHcEsP6tzm5gm6lMRJ4GB6f3/rwMC5oXhKy2bzzZRmDPywAtk3Q1Vq/34gD74+0znF1GVymO4NMBvp4AQiWbD+JmdLq99uZi21UG2na14isPT/6oHpbDiY8wumur4igiIWd2NEs1Xv1c+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyeCoEFhBcjam5WDLNJxpQIv1751QJin4t77LdQ7C7Y=;
 b=x6Q/LdOO9GXrZdABdxf54jvbLutxivTjia5TICf63atP/9PuPLROEp3rFLIvn3cr0AJvv4KFhy+JH8Ecd7ssq8dvHeVLxfDs9gfDefw6rWEcQU3vhvNGA2krY04nYqCh01QRMdXvW1ZWbBtEqYOSVd3yp5ETE3DeSbxznK22rUA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4036.namprd04.prod.outlook.com (2603:10b6:406:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 12:36:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.023; Fri, 4 Nov 2022
 12:36:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: add sanity check for aggregated conventional
 zones
Thread-Topic: [PATCH] zonefs: add sanity check for aggregated conventional
 zones
Thread-Index: AQHY72+Xy/lTG5532kytK/TEjg0Lya4t6U4AgACcp4CAACbJAIAACIMA
Date:   Fri, 4 Nov 2022 12:36:31 +0000
Message-ID: <d68b3fca-a8a0-f36e-1aaa-c375f8d8eb6e@wdc.com>
References: <f7e4afaca0eb337bf18231358b7e764d4cdf5c5a.1667471410.git.johannes.thumshirn@wdc.com>
 <085f1e1f-0810-1850-44d0-2704250799a3@opensource.wdc.com>
 <86c97181-fcd5-8e8d-9b20-b7fc2e74c8fe@wdc.com>
 <f5513658-6cfe-fe24-d072-ea957d319254@opensource.wdc.com>
In-Reply-To: <f5513658-6cfe-fe24-d072-ea957d319254@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4036:EE_
x-ms-office365-filtering-correlation-id: 826eb09f-a406-4cac-6235-08dabe6133fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0GNp9B+82QRUpJlkhVZrXrwow1556QccGO4a42A74LIC8Ovwbr5j1kUctdqM5Wg6vp4gZErbisu/Q81GJcx6BrpIsPSc2WrHshY++3mZuDh1RRy6p1Usr96JTSbP5xRl2Dd+K2EA5MsKPy+FEawFMEVVtAQzjx+PyYihvbC3rVaSh1cUrOWhmxbLS6LyZRfjC/B3fYuIqgMVW/fiA1UoqYf5OeMg1Tf4JoOL7ob9Ed3jAsZ9eY7xzrPi5TLJaiqH8a0MDKnT8+kt+okEcfnngDdo/c2y7r0geSBpGNuTL3vevQb9B5FZ2Sslla2lA6ZQhxBiiIFoRR2TD3Wy/rHPtus3XnqvIDR9EqTzRxGxj4QqmLOTl5C5bKZcoTgjbxsKvxACxOcJjstSOT0Wn9wf2DzHS1c6KkuoGkCeGRZ2slLEdgZ9s8BeNaOnB4RhDBl4gaC/JKNI1PEd3n4ywoI9G9pyATSaN5vKJZZKpuI+6GfsxwvduTMiytACkxI3ZVVNtgPr8BlZPo4KGRVzA274fA22Hyz57lB9WGRAOTR04o1oMSC6dLHoOED/EskcqdUNXirrOPQwy9xXYZgCxhU/44phG7dZNYyaa6YOe/RHD0C8VCi/1erF9ljIUOtFDoGU69OhdKYEay+ITuRPVvCa/XD8wVTL7tTJOjVim3TmSaZUJ/0dii+54BDDUqcR6H3cID0irj4kLDUznLMtoRcvE8RoCGjg36DOZf64fwShkXM90uA/v5dKcqocW9Y+agOIdPuFO/a5qf7mTtX9q5BVpMeLruJiHQDQbqSKuIZpsLqv+LDKX85BU+8lVl9DTq2vgnMP2bLtdDvtfHi1XDwRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(4744005)(2906002)(36756003)(91956017)(8936002)(6862004)(5660300002)(41300700001)(64756008)(66446008)(8676002)(66476007)(66556008)(66946007)(38100700002)(4326008)(76116006)(71200400001)(82960400001)(316002)(83380400001)(186003)(478600001)(31686004)(86362001)(6506007)(6512007)(38070700005)(6486002)(53546011)(122000001)(31696002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTlWdEVrUG4xS0Q3alVDR3hSUEt0RnFvWjJhMTBWeUNtVnR6dk9XQTdhNFlv?=
 =?utf-8?B?ZW9KeS9veUNuejNucTkrQnN1Tm5xUWRkeWFyanZaS0R0WThFMG5uMmJlcmxj?=
 =?utf-8?B?TndtSHRSamd6b2lEMXd2Wm1oT29pUldQb29qMzdhZUVVbmpIR2FocHZheWpM?=
 =?utf-8?B?dkZkMlJFK1RXdFMyU0xEeXVmZ0VGZnJ4WDRNVjBvYkZXNU1aV1pxbkhrbjdB?=
 =?utf-8?B?d2hxZnN2NzQwZWM5U01FbUR5d3BoZllOR0pzaWZ6NFowd1ArUjQ3VXJaNjdk?=
 =?utf-8?B?dmJUU1d5NjdKWDBCWW5SMjYwU0w5TjlVQVdvSm9JRUpna0xQek5pU0s5YTF0?=
 =?utf-8?B?azlKb0IwSTV4cUx5ZzkxWGVnTWEzaXk4aW5Hc0RLU2FobXpXSjZUTW45aVEw?=
 =?utf-8?B?d0lFbXdtdXBaS0taLzVXUFRsYzY0QTF3akRnWHZtNjlRaFdtUHJmZ0hLaURB?=
 =?utf-8?B?ditVWHlZL2tTR1M2R1k2bUNWUERTM05sbUtSZTMzZ0g1YnZJdmJSTlNHeFZt?=
 =?utf-8?B?cDd0SzRidjVuUktXRjcxNGt2WEQvbW1XR1dEbUpLaDhGK1dSakd6MnlidjZj?=
 =?utf-8?B?Nm5VMjlESEJLWHV0QUtMRG1UVitJLzJ3VUVKbUxQSElNUFZaQzJiM2tXTVQ3?=
 =?utf-8?B?YXV5U250S2hkeWQyL1pwZGJtTEcyRVFkWVF2MmkxZHoxZDMrdGpTbHVVbC8y?=
 =?utf-8?B?OFpQajZRUlJCUTVKcVlKaFRSMjBKZXZQakZOQmNHQTEyb1BTTGdCVnZTWi9l?=
 =?utf-8?B?ekV6aHlHMm05aUlCV25pd0RrTndRUGtEY3F3ZHR0Ky9peks4S1g1RURGNmpI?=
 =?utf-8?B?N2pSWHFYcklqSU85SEV6dG0vTE1GL1pIclpGekk3SVNoaVRBNVUzUDJ0dW4x?=
 =?utf-8?B?bUg0Tlpzem91cG0wVkMvY0pidlVJS2tjY2RCKzI1bUIxalJQdFNJeVdNdnVD?=
 =?utf-8?B?V0cvWmdmcFRWTEh2Z054OWlXbEZqN3J1L3JlRVkwZGo4WDZ5SC9wZm5rZU0v?=
 =?utf-8?B?Mk1pcWdrQWN6cm9iejN0elFJeExyeFpyQ2xxc1V2RTJLeW1jYWx0Vit6NzFo?=
 =?utf-8?B?MExpbjQxMFo0QnBNdHZVTXhnM2dpZFVTVGR5WnNkNmtoL0w4REtyUWtRVHQz?=
 =?utf-8?B?Sklyak4veHZiRlFSSzF4L2RYZUJSSUhnbUVKUGhMT1AzR29xVXp4WTBGamhL?=
 =?utf-8?B?UFdmOXMydWxTTWJwL1lnY1FRbC9ReWxydm9tcFBlYWZDWVNRZWZvbG1CamZt?=
 =?utf-8?B?RTRyUEd0UnpCekIrNVVHd2hEdjFmTUNqSEwyamZBZHNFOE5ibjZKYmc0djFX?=
 =?utf-8?B?WFZtV3pMUXNWWW82c1pOSlFnVWV0ckRURDM2Tk44czZ3MzV5NUlNL3JNcVh4?=
 =?utf-8?B?K0hERXE2WnJKbGl6WEd2am9uUkcxR0dCeWJjbVVUU2gyNk84T1lUSUVzam4z?=
 =?utf-8?B?MmViakxEM2FJeHRyN2xFamdKZE5NK1JCM05kMFh6RzJLRm1EQ2duMWFoOFFv?=
 =?utf-8?B?cmg4ZVJ4K3NGNnpVSVV6NnZqM0dKK1pZYmhaU2QvMWpUUE9BMWpxUUovQlpn?=
 =?utf-8?B?YVVHNFJWSnlXS0hEd2lvUjA4STNrZ0NJbGFBcCswYi8xSmxZcE54bk1pc2Zr?=
 =?utf-8?B?V0d2bzN2T0ZWRjNZK2xsR3Z0Y1pZTVNyTHNCZDRMYmllYkRnUUltZmp6WG5J?=
 =?utf-8?B?bVdlUkFvRVd5VnhzMDZDaFlSdXUzQ2x3NkZmS3dGRlJRQ1pmcG1ZU0Y1MVh3?=
 =?utf-8?B?WmY0OTM4Q1FtUVI4NWI0akVEa3dTcXN6L3k0ZWtmZytkTkkrczRGTlBoZ2U4?=
 =?utf-8?B?THBuaTBQTmhxYnFWMU1KMTd2aFQxK2I2TE4vUTNER0tlczNaeXdPMTlJZjY5?=
 =?utf-8?B?TUQxUFo0K1UvYmtRSkdvbmQwaGx3NnE3aDVCaGNwaEduMHdZVmdJVDRJRmNR?=
 =?utf-8?B?VHBNcVZSZjhDeDdKME96ZmZkUGxpYlVwQll2bHB6Smg0MHU0OFJwMSsyWDFI?=
 =?utf-8?B?aW9keTRvbmlBeVByaUhyYnc1UU43WG1SMHBBUkZ1WGcyZ0U4ZU8xcUxaVzR3?=
 =?utf-8?B?cDhDNUx3VVR4eGV6V1hoTEliWWJZYVhkK2Qyc1c1VkhCbjVrRDlTV0F6cFNl?=
 =?utf-8?B?bCtPRkdNNmljeUpGRDBMWDRYV1JQN3lVNmhDclBqOG81ZVU1L1ZrWHZ0amxN?=
 =?utf-8?B?VlFaWWhNWkM1RHZJb0wvOG4yZkNMWW80aURSTnRDZEZyWE9JQndSaElKcTJY?=
 =?utf-8?Q?mwg2/1bdSj646NwP9/+3GARK0Rtj2c/Zm0rAR56BDA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <896381EF02D82240BB60F5C1BC45FF0E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826eb09f-a406-4cac-6235-08dabe6133fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 12:36:31.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBbIV3DcG6I6KOFr5MgargOlOmcWogp1HtogbWxBYxCn9PH0oLTheW/DD1M0KugV7a4L5D2L+cd/hj3cDpIRQogdz0gUGWe4kQmClIrIPTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4036
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMDQuMTEuMjIgMTM6MDYsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPj4gQWdyZWVkLCBJJ2xs
IHVwZGF0ZSB0aGUgcGF0Y2guIE9yIGRvIHlvdSB3YW50IHRvIGRvIGl0IHdoZW4gc3F1YXNoaW5n
IGl0DQo+PiBpbnRvIHlvdXIgInpvbmVmczogZml4IHpvbmUgcmVwb3J0IHNpemUgaW4gX196b25l
ZnNfaW9fZXJyb3IoKSIgcGF0Y2g/DQo+IA0KPiBJZiB5b3UgY2FuIGRvIHRoZSBzcXVhc2hpbmcs
IHRoYXQgd291bGQgYmUgbmljZSB0b28gOikNCj4gDQoNCldpbGwgZG8sIGJ1dCBJIGhhdmUgdG8g
Z2V0IHNvbWUgYnRyZnMgZml4ZXMgZG9uZSBmaXJzdC4NCg==
