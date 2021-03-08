Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FECC330C7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 12:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCHLem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 06:34:42 -0500
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:31326 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhCHLeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:34:25 -0500
IronPort-SDR: sBtAvlq4x0Bw3Jq0ZkvcKdGZbpT7DAVeRHgEWqKnhh0TR9UjZTvL2h0No0H74xqx3ucAAT/7yk
 fo6TN3naQDmGdlGChxEJzp6IPWWRMFm7vNZ18GnW4NSIRRsevGHa6JT92QDCf8JH9XqYVBCnGM
 y6KkABELqZV3TG7wZVdxzoOmbWLsPFDjltu6D4sL0bQWkftCILI9y3sjDsBrdl16LP2FfSA+Ks
 CKOARliCBcxUcn19CSe+8Suj+IvkiPql+dgRgTAoiwTvYn/5Sm2fwsQbOTRHfEjPA/NPOJzs42
 Urs=
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="27391094"
X-IronPort-AV: E=Sophos;i="5.81,232,1610377200"; 
   d="scan'208";a="27391094"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 20:34:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzpAy9oXxURtcobhOqbyWv8P1ZXPYQMU5RkIdq23lQ3za+zuMWWSYb7wu7aLL+uWGt5lV499n0y8EsY5CYNyAoXe7TivNMuzboaCi/9t36xUHpHP2mKf9uACC/tCtDdlCRJNas3BeBDp/y3kpeb9YRfw5/kbuXoxjPYmCQsoKD1zYJugHzZp8BHCVuSsTc40qCh+kS54QvZDt3bHovLH4FvvN/mw+RdGn1d++/KpTwC19aOVTUDrHBq53N7908VyC3nLgr0De+h8/lIRsXXkQrQYkGudzvwFkH3ZgbKK06QvVc6r+eAa9vP5XFvV2MDOC6fqjF1+nBuuT8xDJjiCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7yH3Ef5p3eCXwKhdWr3MstcfOaVdOEKpIAQ0ALp5Ss=;
 b=lb0chRdPEiFmR03TEiVOE1yN1F/k9LEqqAIDtCwTs8uKYcUI6YwlcIpjylJu8RyZVE8GOw9eHRfN+7z2zQek7fhhWWbnWFMFtjo/BUoAW16NuEVomF+co29lYXurrMp2oDvI7N3MInGAc3qoyKFYN0xppe3kHgGDJN9oB0np1FFdKAYtAvSZ8gy3Kn7yrLy1Gk6uvLUSf9HBZfpTwxvZ5TVN2ENQSVSr7oJtx35frXG/vKXWRotpWy2GGMhrVK6LsNlWN8CaU8zs6ybRXoooBMJObVFmPjl0WSbefTtqo/r1Lrrn7tPGZNWctAYEK5xhvaz14/BX2iXJx7WqG65qlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7yH3Ef5p3eCXwKhdWr3MstcfOaVdOEKpIAQ0ALp5Ss=;
 b=Czbqi+PyG0lOv17fA2FBE7tDVy97Guhpv/dSuX0xbADf6FUHttPzkRZVNTWB7ZH2xT2Y5GUqqGwO2mt7WJv1SN4vDyoz7xqax8my73XPnnLNz0QoKz9tki4cJUN/V4kmjzzR6BRaOb4ynHIRGaRPMl4/J2ngmPVoR7AwK3LKLeE=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSYPR01MB5413.jpnprd01.prod.outlook.com (2603:1096:604:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Mon, 8 Mar
 2021 11:34:16 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063%3]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 11:34:16 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Topic: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Index: AQHW/gjzAa5hnh6PaUq187fVBTbxkqp3lL+AgAIDAHSAACKcgIAARgh1
Date:   Mon, 8 Mar 2021 11:34:16 +0000
Message-ID: <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>
 <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>,<CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
In-Reply-To: <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [49.74.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3393f5fb-3e41-4fab-a05a-08d8e2261af8
x-ms-traffictypediagnostic: OSYPR01MB5413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSYPR01MB5413B2F1021BEA9CB1105D49F4939@OSYPR01MB5413.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qsYrcBXi0KulC1SmKo90aNEZp8MLk7sk/ilhirmcf67RTHrrFkXYrkAUFiZwhGaeGhvGi08Tw3kGQ4m4yt3gmajQWUvWvYlJTQbYSbXSwdqMiVuJGcGN//Mfd1aYcHPjidRib6LXc8L/S2dNvJPSjrbniA2S3Z+AUu5npSJnHFh9OmBt5MF4PmT5hgc8vzyIO5VogxxCS5JAZlvq1cyZtoA2C+mcrV3U3bQlGVfRy3QmL0AYlb15Gg1Jwv4zuegBGh6UpDmmtvDt3Kq5rMhhE+y2JH6RTePQga5tFpBRpq/wd9hZkIGH5hkZGVnSXGo07KDOl69KLWKq1y46tt6FSXOxo8Dhq6Zt6d1h+9HNzOkVeHkTW9Qs5QqN8csAJZP6YOqRT3WHS5BzjNVAtd5cV3ib9HTw2wpye6D0z6RAXIxYsCj3SxhdEKjjq2fsNtFhToW+tn265Da7QBf7Tj1kQbGBZaS9VAvvDyo5yg9kP76d3L06JLgML6v6L47oOdXFlU63z9LvPL3vfPN7VMfVtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(91956017)(5660300002)(85182001)(76116006)(86362001)(4326008)(83380400001)(2906002)(186003)(33656002)(107886003)(7416002)(6506007)(8936002)(9686003)(71200400001)(55016002)(26005)(8676002)(7696005)(52536014)(54906003)(66556008)(478600001)(64756008)(66476007)(66446008)(66946007)(316002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?dEVqakxySFdndFlOK3FlbzQ2KzY0eUFPZUZMYjArV1kwUk1EN0pHbnoxc1Yz?=
 =?gb2312?B?Z25ZY0VJaHNlbkV0bE1TcE52OWlXV2ZkSzNqcjlJV1VzUG5RTXhxaUlGVGVY?=
 =?gb2312?B?cjN0WllFTWVKWTd3QlcvOGpvRGVCenVORTBwN0l5d1hDaVNZekpxbHJZQTd6?=
 =?gb2312?B?d1JOZnIzdHE5a0ZkZWwyTnhackxzaGpGSVJvSWFUMjhjSE85TWxSR2xOWTYr?=
 =?gb2312?B?VFFsay9PTHFZcG9nOFp1ZVVkZzdZU2lPUit6allTUjEwVFBvTmdKaFo0SzU0?=
 =?gb2312?B?SlYxa0ZVdnllRnJ2Wkh2NVRVcUs1TzdrSTh4R3M0SzFwTWIvc3R3Mk12dDM3?=
 =?gb2312?B?TzdiNFhxbWNYcGh1MHBWS09UZXpTcHZIbjQwZUcvMHZFd1RhMGxRUmViSFpS?=
 =?gb2312?B?M2VvNlZPSnI5UXNEaEd1ZFdUSEZQZEhIY0VYMnlhbGV6ZkpZdE5GejJRbXhZ?=
 =?gb2312?B?dDhNaUR0eXRWTEIrRnBtVnhnYTNVY1NuZ0NGdFVJekp5WVd4dC9GL0kzRC9Y?=
 =?gb2312?B?N2RPRy81K0cvdGF3Qy9lSDNUdUR0eCtFaXVhd1V1YStja2w2YXFuSDhlTnBu?=
 =?gb2312?B?WnJDZnhkTUwrWk5MaVZxRUNUc29zbU43cDNRSk03NWQ5NmpHSTRCb3JTMmd5?=
 =?gb2312?B?eUtSdm94Qm1MaTNSQXhBVVR3QnpNVnkxSGhRVG1pVGxMSnNmQlgvVHhQbGJQ?=
 =?gb2312?B?M1I1N1ZVR244YkdPR0l1dHA2UHphMkNXaW93U1UrcTc3WEF3b2ZMTm5IVFF1?=
 =?gb2312?B?S3JGU21CQ2xqVHhYZitVdDMyYXlxV1VRWXVwYmNPRUNCQ2VVU3pOdXl6V0da?=
 =?gb2312?B?Z1oxQUpKT1lIejBGNUxyR1ZtaEwyd0xoaWZMLzZPZ1VKM0NSemFJYUZjelQy?=
 =?gb2312?B?TDlBeTVWRzNkcWtNTXhYNG9ycWxWdFRwUzVQbStyamFZMVZHUURCYTVtbGhY?=
 =?gb2312?B?MUlySUpWem16NERCbjdvclNWdVBybTAzVjh5dzYyMEVxTUozN0EwZXdBdzBj?=
 =?gb2312?B?dTlLYWowL2t5TlVQYXExRkd0ZUFVZVFlMzgxczVPbUFtL2E0aGM4Ykl6cTZu?=
 =?gb2312?B?TmJwOHZKRzduMGRNQjdYR0tTaW5Fdm90NU5RR1hYQVFTQ21yY2FOVzhXL0po?=
 =?gb2312?B?QXVtT1QxZzZvQ1VTU0JRN1A1cUdwQ1hGQ3htbW9Za3pPYXpNTGVycFE2VThB?=
 =?gb2312?B?NUgxdnhyMUZ4MVJ2TFVKdGFwSzlVZ2hMWTB4dHRWMFdSOTJZYjZ3OUN4SEF6?=
 =?gb2312?B?ZmJnN3JmU21aVmRjTjRqd3BocGN5L0FTYzF1akdObi9SbnB6cEhMaGdETm9W?=
 =?gb2312?B?MjBjR3prazA1WFRoZTNBSm1HS3lWMjI4azhNcFhYa0hrOUNYaHhCa095amw2?=
 =?gb2312?B?dmtLMzh5bmNZSG9VdG1DTFZPVXkvUzBBN2lOV3A5d2NuL29Qa2t3NWNHSTBh?=
 =?gb2312?B?NVFobnJCU3ZoajZ1T0VpVlE5Y2dRSy9hRkwrZmJaV2NYVWtLL2RUYkh1NjRY?=
 =?gb2312?B?RWFudWUra1FMVEhuVzd5eEVTNzd6R1F1RHcrVWUxYVFwc0lFUXlCMU5heWJH?=
 =?gb2312?B?UnQ1bi8wNFVkWXpWVWdXc29zMVVGbnFhVUpGQ1hXTmtGODJEYmEzS0x5d0oz?=
 =?gb2312?B?NUVlSGNOSjJyTEszR1hhc0Z6dmEwSmpTZ1M3TjJKSXVYSFhJRVpKRUxKc3dP?=
 =?gb2312?B?L3AwL3F3RTIrbkl0cTVSeS96ZU52am1rbk1vOC9rakpTbDRHUE90RzJpalps?=
 =?gb2312?Q?QHDdUxnV9N2YlN3mIA=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3393f5fb-3e41-4fab-a05a-08d8e2261af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 11:34:16.0742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZmgYXijU2OzGS67bH7T8nFINHi5rZeMUr/enpXJ43ReabbnKKq4IIuZ8SzgFhDJGp4K2klH1NeurZsoM7Dipg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5413
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQo+ID4gPiA+Cj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaCBiL2luY2x1ZGUvbGludXgvbWVt
cmVtYXAuaAo+ID4gPiA+IGluZGV4IDc5YzQ5ZTdmNWMzMC4uMGJjZjJiMWUyMGJkIDEwMDY0NAo+
ID4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaAo+ID4gPiA+ICsrKyBiL2luY2x1
ZGUvbGludXgvbWVtcmVtYXAuaAo+ID4gPiA+IEBAIC04Nyw2ICs4NywxNCBAQCBzdHJ1Y3QgZGV2
X3BhZ2VtYXBfb3BzIHsKPiA+ID4gPiAgICAgICAgICAqIHRoZSBwYWdlIGJhY2sgdG8gYSBDUFUg
YWNjZXNzaWJsZSBwYWdlLgo+ID4gPiA+ICAgICAgICAgICovCj4gPiA+ID4gICAgICAgICB2bV9m
YXVsdF90ICgqbWlncmF0ZV90b19yYW0pKHN0cnVjdCB2bV9mYXVsdCAqdm1mKTsKPiA+ID4gPiAr
Cj4gPiA+ID4gKyAgICAgICAvKgo+ID4gPiA+ICsgICAgICAgICogSGFuZGxlIHRoZSBtZW1vcnkg
ZmFpbHVyZSBoYXBwZW5zIG9uIG9uZSBwYWdlLiAgTm90aWZ5IHRoZSBwcm9jZXNzZXMKPiA+ID4g
PiArICAgICAgICAqIHdobyBhcmUgdXNpbmcgdGhpcyBwYWdlLCBhbmQgdHJ5IHRvIHJlY292ZXIg
dGhlIGRhdGEgb24gdGhpcyBwYWdlCj4gPiA+ID4gKyAgICAgICAgKiBpZiBuZWNlc3NhcnkuCj4g
PiA+ID4gKyAgICAgICAgKi8KPiA+ID4gPiArICAgICAgIGludCAoKm1lbW9yeV9mYWlsdXJlKShz
dHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwLCB1bnNpZ25lZCBsb25nIHBmbiwKPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZmxhZ3MpOwo+ID4gPiA+ICB9Owo+ID4gPgo+
ID4gPiBBZnRlciB0aGUgY29udmVyc2F0aW9uIHdpdGggRGF2ZSBJIGRvbid0IHNlZSB0aGUgcG9p
bnQgb2YgdGhpcy4gSWYKPiA+ID4gdGhlcmUgaXMgYSBtZW1vcnlfZmFpbHVyZSgpIG9uIGEgcGFn
ZSwgd2h5IG5vdCBqdXN0IGNhbGwKPiA+ID4gbWVtb3J5X2ZhaWx1cmUoKT8gVGhhdCBhbHJlYWR5
IGtub3dzIGhvdyB0byBmaW5kIHRoZSBpbm9kZSBhbmQgdGhlCj4gPiA+IGZpbGVzeXN0ZW0gY2Fu
IGJlIG5vdGlmaWVkIGZyb20gdGhlcmUuCj4gPgo+ID4gV2Ugd2FudCBtZW1vcnlfZmFpbHVyZSgp
IHN1cHBvcnRzIHJlZmxpbmtlZCBmaWxlcy4gIEluIHRoaXMgY2FzZSwgd2UgYXJlIG5vdAo+ID4g
YWJsZSB0byB0cmFjayBtdWx0aXBsZSBmaWxlcyBmcm9tIGEgcGFnZSh0aGlzIGJyb2tlbiBwYWdl
KSBiZWNhdXNlCj4gPiBwYWdlLT5tYXBwaW5nLHBhZ2UtPmluZGV4IGNhbiBvbmx5IHRyYWNrIG9u
ZSBmaWxlLiAgVGh1cywgSSBpbnRyb2R1Y2UgdGhpcwo+ID4gLT5tZW1vcnlfZmFpbHVyZSgpIGlt
cGxlbWVudGVkIGluIHBtZW0gZHJpdmVyLCB0byBjYWxsIC0+Y29ycnVwdGVkX3JhbmdlKCkKPiA+
IHVwcGVyIGxldmVsIHRvIHVwcGVyIGxldmVsLCBhbmQgZmluYWxseSBmaW5kIG91dCBmaWxlcyB3
aG8gYXJlCj4gPiB1c2luZyhtbWFwcGluZykgdGhpcyBwYWdlLgo+ID4KPiAKPiBJIGtub3cgdGhl
IG1vdGl2YXRpb24sIGJ1dCB0aGlzIGltcGxlbWVudGF0aW9uIHNlZW1zIGJhY2t3YXJkcy4gSXQn
cwo+IGFscmVhZHkgdGhlIGNhc2UgdGhhdCBtZW1vcnlfZmFpbHVyZSgpIGxvb2tzIHVwIHRoZSBh
ZGRyZXNzX3NwYWNlCj4gYXNzb2NpYXRlZCB3aXRoIGEgbWFwcGluZy4gRnJvbSB0aGVyZSBJIHdv
dWxkIGV4cGVjdCBhIG5ldyAnc3RydWN0Cj4gYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zJyBvcCB0
byBsZXQgdGhlIGZzIGhhbmRsZSB0aGUgY2FzZSB3aGVuIHRoZXJlCj4gYXJlIG11bHRpcGxlIGFk
ZHJlc3Nfc3BhY2VzIGFzc29jaWF0ZWQgd2l0aCBhIGdpdmVuIGZpbGUuCj4gCgpMZXQgbWUgdGhp
bmsgYWJvdXQgaXQuICBJbiB0aGlzIHdheSwgd2UKICAgIDEuIGFzc29jaWF0ZSBmaWxlIG1hcHBp
bmcgd2l0aCBkYXggcGFnZSBpbiBkYXggcGFnZSBmYXVsdDsKICAgIDIuIGl0ZXJhdGUgZmlsZXMg
cmVmbGlua2VkIHRvIG5vdGlmeSBga2lsbCBwcm9jZXNzZXMgc2lnbmFsYCBieSB0aGUKICAgICAg
ICAgIG5ldyBhZGRyZXNzX3NwYWNlX29wZXJhdGlvbjsKICAgIDMuIHJlLWFzc29jaWF0ZSB0byBh
bm90aGVyIHJlZmxpbmtlZCBmaWxlIG1hcHBpbmcgd2hlbiB1bm1tYXBpbmcKICAgICAgICAocm1h
cCBxZXVyeSBpbiBmaWxlc3lzdGVtIHRvIGdldCB0aGUgYW5vdGhlciBmaWxlKS4KCkl0IGRpZCBu
b3QgaGFuZGxlIHRob3NlIGRheCBwYWdlcyBhcmUgbm90IGluIHVzZSwgYmVjYXVzZSB0aGVpciAt
Pm1hcHBpbmcgYXJlCm5vdCBhc3NvY2lhdGVkIHRvIGFueSBmaWxlLiAgSSBkaWRuJ3QgdGhpbmsg
aXQgdGhyb3VnaCB1bnRpbCByZWFkaW5nIHlvdXIKY29udmVyc2F0aW9uLiAgSGVyZSBpcyBteSB1
bmRlcnN0YW5kaW5nOiB0aGlzIGNhc2Ugc2hvdWxkIGJlIGhhbmRsZWQgYnkKYmFkYmxvY2sgbWVj
aGFuaXNtIGluIHBtZW0gZHJpdmVyLiAgVGhpcyBiYWRibG9jayBtZWNoYW5pc20gd2lsbCBjYWxs
Ci0+Y29ycnVwdGVkX3JhbmdlKCkgdG8gdGVsbCBmaWxlc3lzdGVtIHRvIHJlcGFpcmUgdGhlIGRh
dGEgaWYgcG9zc2libGUuCgpTbywgd2Ugc3BsaXQgaXQgaW50byB0d28gcGFydHMuICBBbmQgZGF4
IGRldmljZSBhbmQgYmxvY2sgZGV2aWNlIHdvbid0IGJlIG1peGVkCnVwIGFnYWluLiAgIElzIG15
IHVuZGVyc3RhbmRpbmcgcmlnaHQ/CgpCdXQgdGhlIHNvbHV0aW9uIGFib3ZlIGlzIHRvIHNvbHZl
IHRoZSBod3BvaXNvbiBvbiBvbmUgb3IgY291cGxlIHBhZ2VzLCB3aGljaApoYXBwZW5zIHJhcmVs
eShJIHRoaW5rKS4gIERvIHRoZSAncG1lbSByZW1vdmUnIG9wZXJhdGlvbiBjYXVzZSBod3BvaXNv
biB0b28/CkNhbGwgbWVtb3J5X2ZhaWx1cmUoKSBzbyBtYW55IHRpbWVzPyAgSSBoYXZuJ3QgdW5k
ZXJzdG9vZCB0aGlzIHlldC4KCgotLQpUaGFua3MsClJ1YW4gU2hpeWFuZy4=
