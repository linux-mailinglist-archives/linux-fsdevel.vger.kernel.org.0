Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C602C4BB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 00:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgKYXum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 18:50:42 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31535 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgKYXum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 18:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606348242; x=1637884242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dhJJEI1fB81meI2iHSVBk2Hq9RBjKWZ2evwrf8iJGJU=;
  b=RH0r2HwKTRv6aN3L6FSu83g6aOsioSy/9R3CyrCbAG5ZGcDdCsaSHPHr
   qHVdDCb/oVlR8WR5iNP8WXH6uNmr1d2OLHP9d4qLAivtcWUWP4dg0Fpj7
   0d8PcO3/zcyZSCUGa4tn96zERrZgFNWsBL6zAB0aCYwaU6g77xjsfK29e
   q/HX6vgZf8VPVlAfRegD+AL54YHK7+uF9ik/ozHOgS0FZiiaB3WhMOOID
   hIvqXYPvSLwBl8W7JB8fRsfz4gbHzEAujWcKdul7Os8apagbboFlqyqzO
   YG+bbkn15D/qFl7w/D9BFPRETc3tDPHA4KYJrI6rx9xXvOJqjO3o/56lX
   w==;
IronPort-SDR: ix54WLF+IFatHpEzFvQLe5NglzSng0Z00FQ4lD/NtZa4Ve7EUV0vchWCNZYJbAlad322I2GC6X
 4eRb6YD9ZiGPEiBtNwH1j7U/iIIiYaY28EieXB85U59T15FKQJnVRCUUV3+n5sN++8lxaliL/o
 Pq1l679552G7wssgmMgUCmZKkw/FFREPwPss6Y82f4J/41n49SRU3POxwsG1DzfK7ck2ZUjbUD
 R31F/ygfkkejmjYlM6hDdu7i+AZewa9u8RdZLd3NApz40X06IUVUv7DYtHImHHV0dporGxZx/E
 c6Q=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="154701798"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 07:50:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3FHovBLWp2n4jSOvrUV7SpMSMWCbtsjHEtN/5+9xpitLkcuSBWAM64kCMt5SlywfyB75pXZnHlwkg8eKFWi7uBD+9KRjlANjen/QZBca6P7+3Noy37c3PsgNTL1PUczQ/STyhJRljpTUpT4QLJUdFt7HKx7/wB/IdKUx7yOjJhRX8pwhiRVRwUxQw37tYu0bM1P/tmUebknEX9KHUe3z1srC9MgCKb7pRqEvQVfbMN1Ck0z0vbFqdeknnYzOxoyc2JJiBxODWo6pAfuLB9JXNtjpq/L6Fa/LlmpL9yC3qS5pgQMxXM9Ta/7CcRU6mhktYg9TDZ8BbxoI04Vk563Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhJJEI1fB81meI2iHSVBk2Hq9RBjKWZ2evwrf8iJGJU=;
 b=ohBJ5XiRyvaRomrF2RqcMlTHMp6lfaLLyd9ZH5sZ1YET0xgStICe8sgVO8YdXXw28e6G7od3cvRTvz3K0POPKfs+9n+2MQkglAH0s0uFF3rvGtwGYxGonlVqhmFk06PO/Y07gGvVQreE0dXVnAlVjrZPnYgvqczxUGOXaJd5jJ7oqUjmdxtJsV2LTXzzhKyOwqBPJyDy1QbzHKyJhy0d0WmPJ+rgCw4hxvAijMD05cOdCFVUmeqyiDfdZJ7nF1RK+FnK+KlBN0GdE5ubCkbuzfnaIna6RPNOasSdEBJIcb2X0qlqwqWnJ+O6kp7GXuMtn1G/XqWd6QkFM4oWEU+LKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhJJEI1fB81meI2iHSVBk2Hq9RBjKWZ2evwrf8iJGJU=;
 b=nuDPdi774QwXnOQoW+rPdUngQfOdq150354Ybx+Z/YZcS/fPRG6U8wkNminkQDmq5Y5G6N+OnMePNs3o/skAiE29LU+VfaW12Dv3H/Hn/hYRuQjTj2JsqmP1LmMWNfwb1c1OVX1vcEVIytluelwmlWa+x7UfWcc9Nu3zH2Ju4Kk=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6901.namprd04.prod.outlook.com (2603:10b6:610:a2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 23:50:39 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 23:50:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Thread-Topic: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Thread-Index: AQHWt1SWvHhLjwaA+E2FRhr9fhkwUanZepeAgAAiTAA=
Date:   Wed, 25 Nov 2020 23:50:39 +0000
Message-ID: <b96d23ea0f08ec74a7535b4feb17a000ab935abf.camel@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
         <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
         <20201125214753.GP6430@twin.jikos.cz>
In-Reply-To: <20201125214753.GP6430@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.1 (3.38.1-1.fc33) 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 529f2a12-b827-47c8-cd88-08d8919ce999
x-ms-traffictypediagnostic: CH2PR04MB6901:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB690140F2283A22CFD9068686E7FA0@CH2PR04MB6901.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQT17YkeGlu3TIjZQoyVt2Iizjq3wCbj6CYjc2DBWA0MiKDd4Z8OqF2h6TQvgwhWFi2hU+EGaPUTW2YXjYwMeY+gcEvX+sE5e+0PuA2NPdw9bwj3/Oczb4PyxMv4Ijx8X+E9AUnjjp+Z8XSMS9eT4JGx5p4AWvYCIw4Bg2/0iK7qbtNmJx1b2yNoYfGJ7RafIDiiRITvvtBHceAXRzmV9CWdkebrDlFO0Tq4GWdnwGzRQGMad1dzJic+TPFPuT2IiwKSMoufts+AT5eHqXILfce6FTriZdcQOYT1nm+LW/IvRkyGE+6+G0NEko6Ezmx1vU2aiMNwe9ZdiiNgNPsW+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(4001150100001)(6506007)(478600001)(71200400001)(66476007)(186003)(6512007)(2906002)(8676002)(8936002)(4326008)(76116006)(6486002)(64756008)(66446008)(54906003)(66556008)(66946007)(91956017)(86362001)(2616005)(316002)(83380400001)(110136005)(36756003)(6636002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dGpMNWFXV3ZFMGVZZmRsVmZxamZHdytzaW5jdkQ3NC9ZM1FPd0RFZUFIR25q?=
 =?utf-8?B?NmozcWQwUzd2QmRxVEw2Vnp0dHB6UlZKZUJERzl2N2N4TGpzblQwZzFtS0pr?=
 =?utf-8?B?M05wK1BHUzVrQ3BOUk1IQUxOeFVTSjJ3WmNUTVdVU0xISVRUTEM0WE1GOFZ1?=
 =?utf-8?B?Q3Z6WDBzQnI3VHFJRXVudTlUci8zVUhTTnZCSHdvcEQ3U3pFWHloVGliUHl1?=
 =?utf-8?B?N2hZcFE5Vk42QWJPRW4zblVEK0pock5TT1NZRDVwcTl2cEpuZE5Hd294d280?=
 =?utf-8?B?VWJlMVdoejlheDhJdHR5WmdBNTc5WnNtdmNCWE1MRDFpMzlDekxFN0V1Y0o4?=
 =?utf-8?B?TEZabFFBWllPQkFFV0VOZ0E4Z0hGNVlLZHVLT2txdkNaa1R0THdsZUwyY2F2?=
 =?utf-8?B?WlhkOU1xOUFYd3pkcGRiUFBUVitWMk9jK1ExTElnN2RRR09lK3BiQ3gxZWFS?=
 =?utf-8?B?SG02QzNjU0s2SkJwU2FsWjdHRFg3RGlTNENKRlF6MTBZTEN2K0tab0VacFI1?=
 =?utf-8?B?NHZmb1lRQVVqSXNZc1lkWjBZQllCdG9HaHFPSlE3Ylo1bkRjRTlCNGhCcnFP?=
 =?utf-8?B?MEdpUEhRd3NZUDBtd2JXR0YwWVlrVm1sdDFiOVQ3ZmdjWFU1YzdnM1RpMGdp?=
 =?utf-8?B?OEdhRmFFRm5HRHJGbzkwS2JzTmdqeHlXMVBCM1lVWGsyUmIzeXBCQnFud3Er?=
 =?utf-8?B?bzI2VjRhbDBDUkZjemUvL29TQndIbmd0bkZPMmtpdVZKSENLTUdia3RpNk52?=
 =?utf-8?B?eHpEcEhaS2V5bnI1blZlSHpoUEhOb0ZnYTRscnZoTVRSUzBpa1BRaHcxT1Ar?=
 =?utf-8?B?eWZvVUp0VUpYVW5zWWtkcitWWU9xS2YzamhoK3NRaWxocXREdEI4NFIyMDNO?=
 =?utf-8?B?aXN3aXdiVDRCdmo2YUJNZDFhNS9qNXcvNGViZWFzSkN3VWtva0xMRStTUzZq?=
 =?utf-8?B?TUxVTGdBMnA4SEpjYkFuWWpFNUU5RzFKREZPM0t6WHNpbWNxNEhuNWZXYnhS?=
 =?utf-8?B?Q0d1T0pLRkJIOFhKZmIvSkpXSzA5N1UxcGdHUzZwOGQ5YWdRSDB5c2xGQ04r?=
 =?utf-8?B?NUtuM05ObkxHd0FkOTBCQjY4eVYralRCTDhLSWY2MTU4cERHYkVjMGZIVG5u?=
 =?utf-8?B?RHlyMzBkVTJ6QkswaUJRaHQvMGlpTmZjMTNMaStBeURHNkdZOTUyS2RGTkpk?=
 =?utf-8?B?eUVqWjhkM0tKampwcTNnS1RQS1l3bTN3NWo5c0QwTDRYR2hYV1VhS2w4MHF2?=
 =?utf-8?B?dEJPYURDSTNnTTdMNVJHZ3JOQUN3TEE1OGtMWEdFdDNzMWxVellhSmRQSnVL?=
 =?utf-8?B?cTZicVY5RnY1VXB2NVh3a3JXTnl4SW1kQ3B3MkJBcVczQ1hnVXVGM1ZPMk02?=
 =?utf-8?B?Qk9xTjJ3WVo2WENwNEhVaXdBdW1BOVNZMFhwOUJOaTlhUjZ0bFdHZHFkVEJW?=
 =?utf-8?Q?rwvp8vEq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAA978012BE86949AEE36C862EB3C05F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529f2a12-b827-47c8-cd88-08d8919ce999
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 23:50:39.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/t5iexGonzg/xpb3kcV5r85T7PDI+geDd5FyTd8xaNEqH87ctqwmCn0C7cDnqoVzo8U6H9OQyNU6i7ChAB+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6901
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgRGF2aWQsDQoNCk9uIFdlZCwgMjAyMC0xMS0yNSBhdCAyMjo0NyArMDEwMCwgRGF2aWQgU3Rl
cmJhIHdyb3RlOg0KPiBPbiBUdWUsIE5vdiAxMCwgMjAyMCBhdCAwODoyNjowN1BNICswOTAwLCBO
YW9oaXJvIEFvdGEgd3JvdGU6DQo+ID4gK2ludCBidHJmc19nZXRfZGV2X3pvbmVfaW5mbyhzdHJ1
Y3QgYnRyZnNfZGV2aWNlICpkZXZpY2UpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBidHJmc196b25l
ZF9kZXZpY2VfaW5mbyAqem9uZV9pbmZvID0gTlVMTDsNCj4gPiArCXN0cnVjdCBibG9ja19kZXZp
Y2UgKmJkZXYgPSBkZXZpY2UtPmJkZXY7DQo+ID4gKwlzZWN0b3JfdCBucl9zZWN0b3JzID0gYmRl
di0+YmRfcGFydC0+bnJfc2VjdHM7DQo+ID4gKwlzZWN0b3JfdCBzZWN0b3IgPSAwOw0KPiANCj4g
SSdkIHJhdGhlciByZXBsYWNlIHRoZSBzZWN0b3JfdCB0eXBlcyB3aXRoIHU2NC4gVGhlIHR5cGUg
aXMgdW5zaWduZWQNCj4gbG9uZyBhbmQgZG9lcyBub3QgaGF2ZSB0aGUgc2FtZSB3aWR0aCBvbiAz
Mi82NCBiaXQuIFRoZSB0eXBlY2FzdHMgbXVzdA0KPiBiZSB1c2VkIGFuZCBpZiBub3QsIGJ1Z3Mg
aGFwcGVuIChhbmQgaGFwcGVuZWQpLg0KDQpTaW5jZSBrZXJuZWwgNS4yLCBzZWN0b3JfdCBpcyB1
bmNvbmRpdGlvbmFsbHkgZGVmaW5lZCBhcyB1NjQgaW4gbGludXgvdHlwZS5oOg0KDQp0eXBlZGVm
IHU2NCBzZWN0b3JfdDsNCg0KQ09ORklHX0xCREFGIGRvZXMgbm90IGV4aXN0IGFueW1vcmUuDQoN
CkkgYW0gbm90IGFnYWluc3QgdXNpbmcgdTY0IGF0IGFsbCwgYnV0IHVzaW5nIHNlY3Rvcl90IG1h
a2VzIGl0IGNsZWFyIHdoYXQgdGhlDQp1bml0IGlzIGZvciB0aGUgdmFsdWVzIGF0IGhhbmQuDQoN
Cj4gDQo+ID4gKwlzdHJ1Y3QgYmxrX3pvbmUgKnpvbmVzID0gTlVMTDsNCj4gPiArCXVuc2lnbmVk
IGludCBpLCBucmVwb3J0ZWQgPSAwLCBucl96b25lczsNCj4gPiArCXVuc2lnbmVkIGludCB6b25l
X3NlY3RvcnM7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWlmICghYmRldl9pc196b25l
ZChiZGV2KSkNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gKwlpZiAoZGV2aWNlLT56b25l
X2luZm8pDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsJem9uZV9pbmZvID0ga3phbGxv
YyhzaXplb2YoKnpvbmVfaW5mbyksIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKCF6b25lX2luZm8p
DQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJem9uZV9zZWN0b3JzID0gYmRl
dl96b25lX3NlY3RvcnMoYmRldik7DQo+ID4gKwlBU1NFUlQoaXNfcG93ZXJfb2ZfMih6b25lX3Nl
Y3RvcnMpKTsNCj4gDQo+IEFzIGlzX3Bvd2VyX29mXzIgd29ya3Mgb25seSBvbiBsb25ncywgdGhp
cyBuZWVkcyB0byBiZSBvcGVuY29kZWQgYXMNCj4gdGhlcmUncyBubyB1bnNpZ25lZCBsb25nIGxv
bmcgdmVyc2lvbi4NCg0KLS0gDQpEYW1pZW4gTGUgTW9hbA0KV2VzdGVybiBEaWdpdGFsDQo=
