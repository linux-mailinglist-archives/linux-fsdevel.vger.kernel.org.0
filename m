Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1134F8E57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiDHEAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 00:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiDHEAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:00:43 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B0A11F7BC;
        Thu,  7 Apr 2022 20:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649390319; x=1680926319;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b2TpeZcnprPlIvn8+KsdtMVsDYyqRLCA55EBMkG687g=;
  b=njx2LViduF6Mv9+XxAYfYvnWkT6hRcJU34OdHjRKjGCepr2ypaF85xy9
   8cjG6lyeVmb60ebqbsvbvjF/5/cH/T3OEYnjuqrBp4eV8TfCccx0CiDCh
   FBzvc8+norCiKZtBFqGGuYuEqxGwsNvr3Nq/Z6lYBHk698jCaotf6RCmP
   +MkSKX7ggXMU28JoyPtLzG6sx3ehZLjLrl7rFWqnHRVYygb0zRQi7jzoB
   PG8HkIZXNecQd4ZbDz7t2oXmK3yO56vittUpyHASSLgX0xr4kbjqZVq/N
   NmOznvteqOHCdyIpbJJX5wtg3p81k7qR1uuraCZ5P8tPVJ3RSjlMu095G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="53487607"
X-IronPort-AV: E=Sophos;i="5.90,243,1643641200"; 
   d="scan'208";a="53487607"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:58:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtfgvFzQPWeyCuD2QwENReazBa1m0U+m1R+X2Mh/Afc/OoFNGrh/ErcKPSfgvav2Q/W7RxEhzs2jfQ4GriyYsZd9eAVHb7u0mw+sQSSMeyehELbTGQmcM0He3oTjv4avPekgdtu2rUwtiTH6M/Tw4IR5RkvJMTuy8pHegwBiOAMcMKiLp0wj0cpcAtZwlUHJH/w46xQOOxuVlR64N9jXulBr3wwnObvl6EvnHX3lE+Cn6Sj7AgvaxVPLFb4EHn/1gJDn5NG1lJ37QUliF92uiBNj7khm7arZtlmsnLnG73KU0KylGHEEFfhyzRvlY2gPUNcYf5aT8DS7IyMaRD2cMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2TpeZcnprPlIvn8+KsdtMVsDYyqRLCA55EBMkG687g=;
 b=GH7lYvQn9b3w0ISMdUQSHN6VBLJ74d1aoPx1oRubrLv3t4YjBqAAJ9ZWO8WTd1Y4oBK0Bd0LusVW0rUX546Q+WH8AZm0q0//C5wQp+Q1gwbKsy/LUmTEtE9jK3fuWywzf9bQbHcXQ/G1g++LRKmriJAMfrvoIKFBM8Jbz7r3AAJ5L4IZx7oeAmiF/2a7DAHE1kw9k0Pp1klfttR7/BiRr+K+EYY2zvE0p5va6n+r4bvFrhzyfxpbqyq1+HKiG3nqZ0j5W9v6jn9wg3mNjLxJu+A2PxAQnd4V3ltYSBCjJMZ/dSXboTSfqVhz+TizfzssIpgM+/sbgu6gNnCSHKHO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2TpeZcnprPlIvn8+KsdtMVsDYyqRLCA55EBMkG687g=;
 b=olAJXJQ2HP+mjn7XL3NPA0UUoRECIkPBRnvpofPLkb6puXQnIbe3EmP/Bl/c2iJdx8Pq6J7QVrpCr6kN6v01J8hZiYlu+/KcmCRpl4egg8kazb9VDQLvQDy2PzY7Er3WFjGdre9YDi5zsRojUu2nl36glVn1cJfO2O7OKaWjy5I=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB6411.jpnprd01.prod.outlook.com (2603:1096:400:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.24; Fri, 8 Apr
 2022 03:58:28 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 03:58:28 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Zorro Lang <zlang@redhat.com>, Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2 6/6] idmapped-mounts: Add open with O_TMPFILE operation
 in setgid test
Thread-Topic: [PATCH v2 6/6] idmapped-mounts: Add open with O_TMPFILE
 operation in setgid test
Thread-Index: AQHYSnA+nOenZG026kaVeJqYAFsZy6zkdiUAgAD/xIA=
Date:   Fri, 8 Apr 2022 03:58:27 +0000
Message-ID: <624FC123.6060603@fujitsu.com>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649333375-2599-6-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220407134350.yka57n27iqq5pujx@wittgenstein>
In-Reply-To: <20220407134350.yka57n27iqq5pujx@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5701918-7044-4afa-a893-08da191409d5
x-ms-traffictypediagnostic: TYAPR01MB6411:EE_
x-microsoft-antispam-prvs: <TYAPR01MB6411D0B80055C392353648C2FDE99@TYAPR01MB6411.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yu5392eHYLBJWcJMPwGwqf6rM+NGPMuuwQz/yVA092bqpYHcAjYY5ErINU8I2Q6GySR+FJkulC9i6T+7HGwj4Yxkpv5fd779zORPd3cXj8cUFv/7eNrWTgcsO90zEZg64izBnw+etANzMYzxD1oAiQD0cfD+yWb6dw8W8a6CaSinsUMuhQ7Nq2GG0Q7OBJb5HyQnT1Ka0JE5oeOhCf75M4wnczNJFDyY0UZd8qL0Fga5MKhpcVxWCMFPuuOG1oH2RkUQYRUpyfTqaBTOxO80lrqVgOcV7aFU/KNiCL9w21ddz73aRZfbzrn8wYwfnBkDPvmg5DTqVFva3nfnjHajBr7naMArhDIJaLPsEUberNGtCueJi/8FdRMKNHzkMy6jewlf7Qs2ab111f/o/CrEI/hwzuOdvwJJOekAo/Jx8tvz5lF+lsHacFMbm+qBK5D/89f8GBNCPgY8wwBByCcAiW3wwoEIRrWVbhVwDqrdSybE09i1EW23H6LBjrH0JWPDzs1c45jvCIdmoN5ZikmekuN9Dr4Cx5IP1G7lEQVgiqccYIand81x6PfIqfPGzD3P1HKMGYPBtsLc8jX7b2rhhs6PwRssflO6gSKV0tobwDHcmOz0wys7jC/u5v0jca0YnmyuNt+C3BFRmGDACAzASI8z1Q4O+UXlTl9jsDv75FQvhCWM4+yHg9dA7y5G8Bve8tSxHkGOcuSpoF3RKa144Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(45080400002)(122000001)(85182001)(36756003)(82960400001)(83380400001)(66446008)(6512007)(4744005)(508600001)(6506007)(2616005)(26005)(186003)(87266011)(2906002)(5660300002)(8936002)(54906003)(6916009)(33656002)(316002)(76116006)(66556008)(64756008)(66476007)(66946007)(8676002)(91956017)(4326008)(86362001)(71200400001)(6486002)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGZaOXg2MEVkYy9PWkZESTRwNS80TDgwSFlKbWZreFY3Rk1xc2dWVmFQNG9n?=
 =?utf-8?B?Tnowd29NZFZnaXRjdG9QbUx0dDlaa1hReFBta3QwRHVjaUNUQ1lwTHdZWjNP?=
 =?utf-8?B?LzdzNDdNMUZhZXV5aWVBRG5CbnZMcmlaVHRrcm1pRFFiWDVhVVBXSklnZm1Q?=
 =?utf-8?B?ejVrU1M1T0RKbG1xVjE5VS9pVVN2QnRpMzlNSWtFdi8rOUg4eldwM2Jwbm00?=
 =?utf-8?B?NS9teDdPWEVVSTlWU2hLZUl1ZHR2VEROQTVwcU9MWVhqdWtFVkNUdzBZOWRp?=
 =?utf-8?B?cXc3REJtZWpoNXFmWVZKcWNUN0QvV0IzSFUvSEg5NGZ0ci9KRUgyWXdkZXFK?=
 =?utf-8?B?WmNBS3AvVTg0bHlRNTQvLytyckk2SS8vbnFJenZXYk41SzFEd1gyQXhMRlQ3?=
 =?utf-8?B?VmROdHd3OG1OQ216eFNvTG5jWVkrMXZBSUhKTllrWTVKQzQ3OEEwbjlWbUYw?=
 =?utf-8?B?S3psOU1zTEFLZUJiNkEzZ3ZjcjhZeWxyRkwrMmcxOUZnb3EwWE9yNWpYajh3?=
 =?utf-8?B?UFgvSFJRZGhVRUhuT1BNMnFhdkh1UVNOYjMrY3owdnhJcjlvdVpVS214Q3kw?=
 =?utf-8?B?Z09HMmxrVGxibEJqTVlhUzZuWGhaaDEzSGpHVVNWVHg1N2xJeUh2V054cGli?=
 =?utf-8?B?VnJScHVjRUV1clBGWkdOVGF5aVVkdSswZWtKU2Z1SHJUZlJNcm5qU1VtYlI5?=
 =?utf-8?B?YkNybEo0UldDdXpWcXcyRzZlYUJnbGhRSUF3d3NiempiUWVKQkJDYy84a010?=
 =?utf-8?B?TkQ0d25vTUVXRGIxR3h1VzVqcGRHcmc4ZmE3eFM2WThlYUR3VndpOFBUTUNn?=
 =?utf-8?B?NnVHanNyc2Q3MFVWcTEzZXoxbWYyL0d6dXJFdURjN1FHajNYSnQvSzE4TkRr?=
 =?utf-8?B?T3Qzc2hMYVpjb1hySDFWNE1abDdiOTQ2cmpUdFNEZVcwenE0UFNIRkVhdG81?=
 =?utf-8?B?UWYzbWM2cWwxdFZZMTFGMlVLTzV3bGdTZzVhWXB6ZGR0ZmlCNVBRSlNwNjdS?=
 =?utf-8?B?YmhUNnJDamw1ZEtMTitpRTkvVWN6blVENkhPam4yczA3dlVReDFJUFRlazVZ?=
 =?utf-8?B?UVNkTnVLbnIyVFhJYXNOYnZVNHFSakVLN052dHkzZGtpOHE4ZCtmcXFwVUFP?=
 =?utf-8?B?ME04clF4R2NIenBOMDRZN3RlREZtMHpGUWwwbzVKWHM5VjlFaVI5VjNUVU1G?=
 =?utf-8?B?Tk9KeVgvMFpmdFkzNHg4MmgrZDZYNndSU1BCSjkyWGEwb0ZCQklsTjlWdWIz?=
 =?utf-8?B?VzZrSG1lbkxNOFFKeEFjSEs1RHdwa1NPQzc5YzdTZU41M0xXd0QvNUs0Y2Fn?=
 =?utf-8?B?NXF0NThvOHJtdVRFUFkvTnZ4Q2hhWEpSK3pTZ1oyeWhRZERBZE1NM1cyOVhv?=
 =?utf-8?B?ODhldnd6ajJmd2gwZGJ3WlBXOEg2TWNHVFlMYkM1K0JXNlNCOHRyOTFkOUJD?=
 =?utf-8?B?c0VLWGQvUGVDc2dRNVVTdnhRUkppQitnaXFOeHdmeTJYWElWQlVDZmhBMTMz?=
 =?utf-8?B?Tm9YL1ZCMG94c0tsRUNpQ1JlNUZsMTBlNHMrUVhIRmFHOUZDN1JkS1hLRlVt?=
 =?utf-8?B?K3M3MU9paXBDRGFKbis5cjNhRzdZMW0wS0V2ZHNzVHZCRmhkaW1nK0lHNmRO?=
 =?utf-8?B?ZFdWRnMzYlh3SnByVDI2b0g5ZkxQQVp4VUVrUlZwbVR5TnhVWXZzMmFJa0lo?=
 =?utf-8?B?dUxwK1BKNWc0Z3dZVGlReHozM0Z5Wm1vU20xRGxtTUdZc1c5Y2tMLy85ZWJo?=
 =?utf-8?B?MzNaZGdWRTFpck00RktkNzVmdHJOdk9xdThpa1Vzb0RUa1F5WmhhS1Rpb2Ez?=
 =?utf-8?B?UXkyeE91V3dDOFZDaUZ6OEVnS2JNZmE2VDBYcXhVL2JHNU9wWGR1MURaNElG?=
 =?utf-8?B?SXNjd0M0NHVndmc4b3lLeXpRKzNwV3dpY3BGdVhXUHBOS2Z0SG9CdXd2cHpG?=
 =?utf-8?B?cUQ0ancvVy83eWxVRHpSMWovTW9PN2J4bDdaekhXUFRad3U2WTBHSjJQeVMz?=
 =?utf-8?B?ZERaamJ5ekZCZzNOc1hJU2lCaTZ3NjA1TjNRZnJZU0Z2Wjl6dUh4K2E1Qkp3?=
 =?utf-8?B?OEhOSTQyd2oxMitVZkVXcUdKeGc2eWwzN2JoUlJ4S3pPTmtZTTh0YzBBZVQ0?=
 =?utf-8?B?MFFWTjdlcU85STJ2T0pxaEN0OTIwTTV0UkVrdi9Db2pWaG0yelhrdHZmWU1M?=
 =?utf-8?B?NlFqM3RSMzdSWWowY2VCdDBLcGNUcXpSYjEwa2JIdHlIajZ1RUtndUJXVkxt?=
 =?utf-8?B?M2RvaUhleU1qVk5EZ3h6MXEwTVR1Qlg1US91OVpYdGRwWnAyTFFWVGRLUlRP?=
 =?utf-8?B?N0ZRVjJDaDNwSUhPd29vdkxmbW5QMk1PRWx3UmZBWGcxM0NEblZZaWlkMnMy?=
 =?utf-8?Q?RJADJfLyZyWyI6B2Q6dL89RfTgKePrYgIKL5+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD2F72C2A197954DBE22BA61B4E02190@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5701918-7044-4afa-a893-08da191409d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 03:58:27.9977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mMyEG3PRCqtrVifQQzJ3KM7OSk8qQg/yXCVwKwfqCHi5gqRkeIa22XBTBOH6/+nz7xJx2WiTxCC/3IpBQBzmjFhNM7Hfi78zfZIWhd89Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6411
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzcgMjE6NDMsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiBPbiBUaHUsIEFw
ciAwNywgMjAyMiBhdCAwODowOTozNVBNICswODAwLCBZYW5nIFh1IHdyb3RlOg0KPj4gU2luY2Ug
d2UgY2FuIGNyZWF0ZSB0ZW1wIGZpbGUgYnkgdXNpbmcgT19UTVBGSUxFIGZsYWcgYW5kIGZpbGVz
eXN0ZW0gZHJpdmVyIGFsc28NCj4+IGhhcyB0aGlzIGFwaSwgd2Ugc2hvdWxkIGFsc28gY2hlY2sg
dGhpcyBvcGVyYXRpb24gd2hldGhlciBzdHJpcCBTX0lTR0lELg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFlhbmcgWHU8eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPg0KPiBUaGlz
IGlzIGEgZ3JlYXQgYWRkaXRpb24sIHRoYW5rcyENCj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBC
cmF1bmVyIChNaWNyb3NvZnQpPGJyYXVuZXJAa2VybmVsLm9yZz4NClRoYW5rcyBmb3IgeW91ciBy
ZXZpZXcuDQoNCkBEYXJyaWNrIEBFcnl1IEBab3Jybw0KanVzdCBhIGtpbmRseSBxdWVzdGlvbiwg
bm90IGEgcHVzaA0KeGZzdGVzdHMgaGFzIG5vdCB1cGRhdGUgZm9yIDMgd2Vla3MgYW5kIEVyeXUg
d2lsbCB0YWtlIG9mZiBtYWludGFpbmVyLg0KDQpab3JybyBsYW5nIGhhcyBhcHBseSBmb3IgdGhp
cyBqb2IuIFNvIHdoZW4gZG9lcyB4ZnN0ZXN0IGNhbiB3b3JrIHdlbGw/DQoNCkJlc3QgUmVnYXJk
cw0KWWFuZyBYdQ0K
