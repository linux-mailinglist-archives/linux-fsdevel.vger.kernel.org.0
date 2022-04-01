Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EE64EE80B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 08:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245297AbiDAGKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 02:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245286AbiDAGKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:10:21 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163A31083
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648793312; x=1680329312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5YZEOWFIhTJVNywGy6G1oEkp2/kcd/TPtXHF8BTWYOQ=;
  b=fyzNLktdAAd1LkJ78qKVLKaJnlYVGy3jLp6rq/2zHBb9dWvgd2+K1jxm
   ijoZktQSJi5lv/Tl8J4ueyxMP6AJk7QatQs7IjTh1ibLTM8xSz1352mm1
   9XNo92fSt3g5/sSN59krDRuojlJONZv12Q3S5Uc1BRAyJLhMceJAaPd2H
   BZHeCOURS4lCGB1CQL6k53AahdxyMHMg/s+YBmcj65Lrg4xJLBqXqyNFQ
   tEq8b4GHiO7vkTKl1Fk05hIFe6cyPd53qA0dcuOcprWTZKPx9r2WvXN3a
   kWo5Oe53pYTpOsZHwxRhgWdqzswDg+tM4W5lU4o1tXPJdfpD4vNTLMZyz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="53063241"
X-IronPort-AV: E=Sophos;i="5.90,226,1643641200"; 
   d="scan'208";a="53063241"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 15:08:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+6/J8GwVS2g8pn2vDJST2OL0e8OOG88QVeV3UOs/p3HXw7tKYGe6Fe8G0s/CK+ic3QClxA+9dQ6xHLh/XciTUL1nfpOHNS+bJ/DLsdY+m6DwEQVsz+hB1wYqhD1Juh0qQ7s/wrjf4kC+jzqX67L27H/CBtQuO+JeSogR9Gzty0YCsCICegZEf91ZF4e1iMSUUBqpSWcOZH6nJwc4xLk/1b7M2aNqJns72pxxsX8UbWaWNb5OTUwEuKkrzuKoCYZPY0ptXFQPRRBVIoqLIJaUsIqk4PH8SZ3VlkehVImK3MdCXOKZk4fSZPQTM/9kA5DGENKQqN5ozdlvrG2BaJ8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YZEOWFIhTJVNywGy6G1oEkp2/kcd/TPtXHF8BTWYOQ=;
 b=YSc5ObuqanR+GiZNJpnL2yNm1Ww1L2JnjtLxeFSxfX1f7SRpx7rV2c/iRMPHqcksEZgTnDh2DuTr235TSdXMH/jpnL+7MQ04/NJ+Ff3tR9ZEjaNp45mhn9V2iVToOTQtraPkFMJ+zilVZwSuvla+ReQnTtp8mGSTbibRAdCZf8D0SNrm+Yp7EVLUP8i85TxW/HqjzFJqx/yEiJu+ynq4yV3pqRV7vJCybyueBxYqrMPQHmj/OIK8AGREdDcVDQV3PE/4fvXEd6hPBpl9FeR9SnDaEIqYDOS5ASYxl/h1FxKtSr42G3rrk67KbO2w9w3EBr+A98LhxcJYsRqgLN13Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YZEOWFIhTJVNywGy6G1oEkp2/kcd/TPtXHF8BTWYOQ=;
 b=BK40TN/XgK/klazyE0yOUn51SgAb9YFdUH90Zx4itrGy8qoaj+dJe364ajN1hJIGHSPQ38pu1TiwNJeRMDsMwCI9DxGS0SII2g//JuldvFNXtZqjH9OuwWMYYDqBY4jxQ5clAcBa4vkWqkePJ0dO88kO4pKLq7Ru7gK9S5USU+4=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB4144.jpnprd01.prod.outlook.com (2603:1096:404:bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 06:08:24 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5102.023; Fri, 1 Apr 2022
 06:08:24 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] idmapped-mounts: Add mknodat operation in setgid
 test
Thread-Topic: [PATCH v1 1/2] idmapped-mounts: Add mknodat operation in setgid
 test
Thread-Index: AQHYROGzpm6L1ToHZE61xo5lM5st0KzZY8SAgAEweIA=
Date:   Fri, 1 Apr 2022 06:08:24 +0000
Message-ID: <62469705.4000001@fujitsu.com>
References: <1648718902-2319-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220331115925.5tausqdavg7xmqyv@wittgenstein>
In-Reply-To: <20220331115925.5tausqdavg7xmqyv@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ec41355-4b8a-44fe-f544-08da13a6081a
x-ms-traffictypediagnostic: TYAPR01MB4144:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4144F961E2DD0E9083C4107FFDE09@TYAPR01MB4144.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKoIBcGSzUbc3akeS9Zv324tb7geyMXPizA0OsMCIm68cC73kIqxRv1sTbJxCDCx57vGUF8hvgnMhGvNCbDRJ0DvHVipH6D6e3oybOxhvaAXSpJgRlOrGii3eSqVL16fcwHZiiqDz0dXwujps2LyHs8HYaj/bLVV6JOIOvXyhyKe5T3Ym6ktA6VTttDj0pUvXO04RqiOjNTNgPHsS2Gjo+dHfXVVghf+kpjhZeEk1LV9CV9gamffe207DLKY2ZLcpeZm2BLQSCXL1VrCv68lIY+M1k5sFBObqH3ljKNEm8gkDOWysZXD9/1XzgbGmDSB0H6YNn6awaMg6vDFlgIia0l4F7ZZH9cZmsnlB+ZP0SxpuimPxbTQSdqXmkZoCVi1CRBL4dRFmsJatEOOxC3wTxoxOh+roxESDOXLsNa/yWs0ls+w+7+J7Eaeo8IX57yQyqqTlG85zkHsWam7c7GmmtBvISaDmC+FzfJhmukN9LuFTxDDZb0tuXGREevH7h4gQ6yIdUaStBFPIkvDL1BTRwkDdWSgxK8AgGTZkcMaeNKOEWn1Q70soiXqZL1eYpdzNOhmeBskBzKwp9iF6tIUnUbkZN1lj3ce63+X0wmdcd6IgzF7Q7VnfSk3mQJTjwyxkmOrsBDdxkhZ22e4BLE1BUc0VW9eEGMbTLurXRNUDfvWwjGLNixi97/MIvb7hAqyLuL+7PwF143jvbF7Lbqq0Ne6HsHLkQq5fxZaaV1cKcE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(54906003)(5660300002)(82960400001)(186003)(87266011)(2616005)(38070700005)(26005)(38100700002)(86362001)(8936002)(122000001)(2906002)(6916009)(4326008)(66556008)(8676002)(66476007)(64756008)(66446008)(36756003)(6506007)(6512007)(6486002)(71200400001)(85182001)(91956017)(76116006)(508600001)(45080400002)(66946007)(316002)(62816006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlhETkQwZTBVeTV5ejVXTDV6dlp5MEtCbEtlV29CQVJJaXczT1F6TTdOaHJY?=
 =?utf-8?B?TC8vdm54U3hrcXFGQktuTmljS0lCaVdmV0dkVVVIWXJmMlZhKzJXYWpiSXI2?=
 =?utf-8?B?WjkvZm5zYndrejk3bllmbmkwTWxhTTdyVGJ5Nkpna0FXRnFyM2FsY3ZBUnFs?=
 =?utf-8?B?UkRZdkRuYzFRR09qMHY5MEw0UXVKaGNHQ0owbG5JdFBjSWFkWC9NcldoUmcr?=
 =?utf-8?B?N21mZjh5OW5tV3piSXNsc2tKV2w4QnQ1dFpURzUvM0JEaC96ZzJ0cXlPbnVu?=
 =?utf-8?B?UFEwc0Joemdjb2lGdVgzSVpTZDd3SkM5SDBJOG5pdks0YWlMV0Z3eHZuUmdN?=
 =?utf-8?B?UFRYNTJTbE02ZHRTWU9CMGR5eWV6bDE5a2IvUC94U2puSEhkZVN6bitTZzZQ?=
 =?utf-8?B?d3ZCZnJOUTBWblpWUDJyU29GOHA2K0o1YlhERDNuOVZOM0trVnJNN1RveGRV?=
 =?utf-8?B?cEJ3a3dlbEp3TW9IS3ZRcXRjc2Y2MzFOZUE4bGhiOW1rRTBLU1R5Y2xsVnBs?=
 =?utf-8?B?UnRyZHpoY2U2VFNwU3VYWjYrK0h6dHE0MnBaMEVBUEZ0aDJ4K01Yc2RUNWF0?=
 =?utf-8?B?aTNNZkpkWnJQZEc5eklnMjZrWGgxQ29KMmdDVGZPRHZ5WEdDcXFZRlo2ZjFv?=
 =?utf-8?B?c1JQQXE4MnhnczdkOHU1TlFJUk45VllJdzQvZlNhR1Y5SkZsSFppemhKaVFl?=
 =?utf-8?B?M1dtUkViWkNQRktTRHlxK0VVU2RISHAzUHlxY2dpQis4SE9BV2tRREhnUWl2?=
 =?utf-8?B?KzQzRTYva2JCY2xxa05FS2tiUmFuNy9yaWtWVGc4YjlVWWIzWS9YOVIwRkJx?=
 =?utf-8?B?U1lzVFZTcUZNaVRnTzEwQ0RYSk9QZk8rNW82bW1sS3JJYm55eUIyL2kxaStI?=
 =?utf-8?B?aUJUQUg3NVA1VDNBTERQUDdkVVZyUEFFNHFKOWFEdEF2OUF5SWxXaU9lU1FF?=
 =?utf-8?B?K05Nc3A2QkNqeXVQVTkvcWRmTUk1T2dqVCtRYlVleS90UktVejdXcFBPNHVJ?=
 =?utf-8?B?RStYOC8vQklhKzhJU3dYS0ZHRENIOXNsaEhMK1VWR29EK20waDZmLy9aZEtV?=
 =?utf-8?B?NXNlcXgzY1Z6TVdKajFhMDduTW5PMDZLS2hXbUFQblcrSGU4c1RpRHhqSTQ2?=
 =?utf-8?B?U2dQR3JBRDh3Zk85TEx3VGxLazVYNEpYTEtMdG9CN056NGVXemk0Z3NvcUZp?=
 =?utf-8?B?K1B5RHkwRjJMbmgyTURiSm9Fa2NDczFJRVovbTVVVk5uSWxRNzhSaUN3dmFy?=
 =?utf-8?B?c2dsN3VOWldQczRXS1hwbWhDQ2ZiUlBzWUhaaXJSTmhyZDkzZ2VNT3BKL3lC?=
 =?utf-8?B?TUMzaTZmejRsWXF3YWk3TVNLSE12N1lQT1EvVXBjYUhUU094OFFXUno2clM0?=
 =?utf-8?B?SnZVRWVXMDhEaUNRekRVRElrZElsZ09wZ3FNZkxzVFZ3M2xmZzd3dWRjZFh2?=
 =?utf-8?B?dnVyT0Q1QlNGdWxnd2VKQkd4RlhoUHNQOWFhWUlQOFRFWklBdjUxZlZYdnpL?=
 =?utf-8?B?aVh1NkQ3Mm9hbGVUL0xCTXZNb1h3QTZ5ZW5VTzloZDdxMWdzWTZYNzdLR05r?=
 =?utf-8?B?ak1mMHpiSGJmRjQ0NlpvZ3BiTDh0azlrWEErSEJTUkJrUVNLcE5yeWl5TUZS?=
 =?utf-8?B?N3cySFJxZVhFRDlneWRlYk91QVJQbEdtaHV2L1kvYXZDRThyMC9oSEV2MDhD?=
 =?utf-8?B?M2xyd3hMSmFJOEx3VGZKL0pSZkYvSzQ3bXVtUldXQWRERWxwckxOT1NjUk5t?=
 =?utf-8?B?VDdkT2RhUDZaZmt4NW5VbTlpVUFaTnlWTXBFVGxSR2hJTmdtZ3I4Zy96bUxT?=
 =?utf-8?B?ZUJCSHlaUnJOU1NpRlJNaFlpWTFyWERhUDE5VDNPWGtVQ0pWRzN6bWRhRlFU?=
 =?utf-8?B?OEU3SHJjNXZ6bzNUZE5nek04dHJCWkJSRHRiNWtHRzQrQ0I3WlJIM3FjTlc0?=
 =?utf-8?B?b1JjZCtaYzQ2U1dIYVU2Y0laeEQxd2QzbDU5SDZDbmhmekoyczV0a1VlU0gw?=
 =?utf-8?B?VVJoWjY5WDVwQ1hwTStwOGh0OXU4ZndrUGZUNHlJSFF3R3IrQ1pSVTJTQ1B0?=
 =?utf-8?B?ZURxdjlNOGJuTU1MR0tIY2tRVWNZS1ZacmZqTUJZN1B1ckNvOG1Zd1BIdmNq?=
 =?utf-8?B?SE9Tbmc1aFF0b2JkQ3RSYko3emFvbUNmUEpONTgvNUFXSkNRaDl1WlcvZjJU?=
 =?utf-8?B?V0FWMWllY3RvVEwyUFY3TVJWalJ0NThSMGZrVEYzSmducHVZS2NaN0NBR1Fn?=
 =?utf-8?B?U2tIV2FSV3ZUZGpZd3hsTERNVmVKdkdYM1dWb2ZxL0RXV1Z6VlV1RzVnTXBp?=
 =?utf-8?B?VS9JOTRnVmZSWGU0QUdleXovQ2FoVTBDMldJWmNxdEhwVFdPU05MWFNKZmJG?=
 =?utf-8?Q?jFk/GMRHbk/iebPVqfV0D3lEGVDG5GjzAPBjy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0C8D01748456A4B9B39BE0028E63A8A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec41355-4b8a-44fe-f544-08da13a6081a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 06:08:24.7361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyRq5ZxyjakvD+YquAndaj3ikTWRRSd348U7PbhbEgBggJJLKSyBvJsIVedIR0HkGpCYM9SaqIkmRUuePmbzWXhR1pM1QcMOQO81QyDi300=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4144
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi8zLzMxIDE5OjU5LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVGh1LCBN
YXIgMzEsIDIwMjIgYXQgMDU6Mjg6MjFQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFNpbmNl
IG1rbm9kYXQgY2FuIGNyZWF0ZSBmaWxlLCB3ZSBzaG91bGQgYWxzbyBjaGVjayB3aGV0aGVyIHN0
cmlwIFNfSVNHSUQuDQo+PiBBbHNvIGFkZCBuZXcgaGVscGVyIGNhcHNfZG93bl9mc2V0aWQgdG8g
ZHJvcCBDQVBfRlNFVElEIGJlY2F1c2Ugc3RyaXAgU19JU0dJRA0KPj4gZGVwb25kIG9uIHRoaXMg
Y2FwIGFuZCBrZWVwIG90aGVyIGNhcChpZSBDQVBfTUtOT0QpIGJlY2F1c2UgY3JlYXRlIGNoYXJh
Y3RlciBkZXZpY2UNCj4+IG5lZWRzIGl0IHdoZW4gdXNpbmcgbWtub2QuDQo+Pg0KPj4gT25seSB0
ZXN0IG1rbm9kIHdpdGggY2hhcmFjdGVyIGRldmljZSBpbiBzZXRnaWRfY3JlYXRlIGZ1bmN0aW9u
IGJlY2F1c2UgdGhlIGFub3RoZXINCj4+IHR3byBmdW5jdGlvbnMgd2lsbCBoaXQgRVBFUk0gZXJy
b3IuDQo+DQo+IEZ3aXcsIGl0J3Mgbm90IGFsbG93ZWQgdG8gY3JlYXRlIGRldmljZXMgaW4gdXNl
cm5zIGFzIHRoYXQgd291bGQgYmUgYQ0KPiBtYXNzaXZlIGF0dGFjayB2ZWN0b3IuIEJ1dCBpdCBp
cyBwb3NzaWJsZSBzaW5jZSA1Ljxzb21lIHZlcnNpb24+ICB0bw0KPiBjcmVhdGUgd2hpdGVvdXRz
IGluIHVzZXJucyBmb3IgdGhlIHNha2Ugb2Ygb3ZlcmxheWZzLiBTbyBpaXJjIHRoYXQNCj4gY3Jl
YXRpbmcgYSB3aGl0ZW91dCBpcyBqdXN0IHBhc3NpbmcgMCBhcyBkZXZfdDoNCj4NCj4gbWtub2Rh
dCh0X2RpcjFfZmQsIENIUkRFVjEsIFNfSUZDSFIgfCBTX0lTR0lEIHwgMDc1NSwgMCkNCj4NCj4g
YnV0IHlvdSdkIG5lZWQgdG8gZGV0ZWN0IHdoZXRoZXIgdGhlIGtlcm5lbCBhbGxvd3MgdGhpcyBh
bmQgc2tpcCB0aGUNCj4gdGVzdCBvbiBFUEVSTSB3aGVuIGl0IGlzIGEgdXNlcm5zIHRlc3QuDQoN
CkkgaGF2ZSBmb3VuZCB0aGUga2VybmVsIGNvbW1pdCAJYTNjNzUxYTUwICgidmZzOiBhbGxvdyB1
bnByaXZpbGVnZWQgDQp3aGl0ZW91dCBjcmVhdGlvbiIpIGluIHY1LjgtcmMxLg0KVGhhbmtzLiBX
aWxsIGNyZWF0ZSB3aGl0ZW91dCBpbnN0ZWFkIG9mIGFjdHVhbCBjaGFyYWN0ZXIgZGV2aWNlIG9u
IHYyLg0KDQoNCj4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1PHh1eWFuZzIwMTguanlA
ZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4NCj4gU2lkZW5vdGU6IEkgcmVhbGx5IG5lZWQgdG8gcmVu
YW1lIHRoZSB0ZXN0IGJpbmFyeSB0byBzb21ldGhpbmcgb3RoZXINCj4gdGhhbiBpZG1hcHBlZC1t
b3VudHMuYyBhcyB0aGlzIHRlc3RzIGEgbG90IG9mIGdlbmVyaWMgdmZzIHN0dWZmIHRoYXQgaGFz
DQo+IG5vdGhpbmcgdG8gZG8gd2l0aCB0aGVtLg0KQWdyZWUuDQoNCkJlc3QgUmVnYXJkcw0KWWFu
ZyBYdQ0KPg0KPiBJbiBhbnkgY2FzZSwgSSBwdWxsZWQgYW5kIHRlc3RlZCB0aGlzOg0KPg0KPiBU
ZXN0ZWQtYnk6IENocmlzdGlhbiBCcmF1bmVyIChNaWNyb3NvZnQpPGJyYXVuZXJAa2VybmVsLm9y
Zz4NCj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBCcmF1bmVyIChNaWNyb3NvZnQpPGJyYXVuZXJA
a2VybmVsLm9yZz4NCg==
