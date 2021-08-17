Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF3F3EE3E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 03:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhHQBpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 21:45:08 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:6338 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229773AbhHQBpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629164676; x=1660700676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LiBnE8jREah+gkuNNgUZNl2vZg8tKEefMLdRaiEFnOg=;
  b=m90Jy3JWx7E3e8j8zHBYy2dQVS+bnXkegtXoPJmXp23S+D+I3yKQQ0Sk
   DLAaEh/8KP0B378hM7ReiwVRY4qWqwKwB0ggN386ut4DoDFFDk3n5szxv
   gtvxbmaB0y+cHa3TdBpKVPNx900Iv7rqKJ0wC3bmFmwe/7tOP4nxlMzk8
   RGc4KhVlUrWR6ch8KqKG48q8BVxEVOaO1KPbrEuq6GP6PhStoMVos8uG6
   AfK5nXAuymOEv+j9urAv1NvPKP7XHcotB/ura9zDhDRJn5hM1I2Lnsulp
   9mPdUu+A+80t1D9GB8ypjvHOrbrKEEdbo6NZecDXl8Yl8RrDwIFp4mv8e
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="36751826"
X-IronPort-AV: E=Sophos;i="5.84,327,1620658800"; 
   d="scan'208";a="36751826"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 10:44:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuUsDcj9KJPIzCbfd/dpfQUhhdrb50xTST/mdUzp4mXaiLP5tN1G7euy1DkPxEVVHze5cFJUcWKIhfwSKJUohwpxhkgQ58X136+WYRmHi79ut8ldODfuvE/pC/wpXWe4DO7XBLjM4XHRAuB864cR7KDHiRvaNzmSjIywEQc4BlgBuU5ZheOQxyoDa0jvkeLmk99bG0Lh+vSZxRNB9WOnOgQJzc4UaKMiCdatbN7xcP1D7AysJq7vQuj4pv+nVc/plJ5SVFryo+19iIdXCNgFoyXK/IBGTLTGZhJ1lwLXwXondeP94hwWxaXsJsnIbeCu4turxGwQzIKja8QTNYB/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiBnE8jREah+gkuNNgUZNl2vZg8tKEefMLdRaiEFnOg=;
 b=QWizcOTkHF9GvN5qwRoEKO9BImBhKBjN51BS6fKBVPYQyUMFyc++Ave75dFpSEIaYJC4CYCFvLGxOJV8mFCfhec0aBD2P4rYBDYb687SoihSn1OZkW4J9MuKn88HHY3VKNSjFIM+RT504Dpih4gheDvp+rTsVLxfliHOyG7dd3gJUhBzBKfQ6jhi5zLhrwRCCaex9jy67f1njqLnaW++aWP1T2eOdLVJPR0o6yalHiagaUk9X4JfhrATj3Uafu6wCfZ/lnYR8x1g8h+xfq8T2oa3t9O96JJV1c5Mrg67Jb+7hKyje0HpW+fnj8/D80AHx3bciUl5fzPZoW00eBHviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiBnE8jREah+gkuNNgUZNl2vZg8tKEefMLdRaiEFnOg=;
 b=XfpGJNf7Wy8WCZjQgKEeyeCLrsimphFblO6njcOPlIYvy+gLuepNCrgmmlUCKViodnvxyYYKUnInlW4ztFnb8sP9JJgEI2AhRRz2vrjxaw46g5l+PhDYtvb02/FVS/w61wDvhlVpzm/aR9WpVgEkNgmrX9G3eJ0Tk0+0gG9YWD0=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB6194.jpnprd01.prod.outlook.com (2603:1096:604:e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 01:44:27 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::6db8:ebd7:8ee4:62bb]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::6db8:ebd7:8ee4:62bb%6]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 01:44:27 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
Subject: RE: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
Thread-Topic: [PATCH RESEND v6 1/9] pagemap: Introduce ->memory_failure()
Thread-Index: AQHXhSoSnS/qStIblEyff+FzJU/rBqtlt1aAgBDEPoCAAIiTMA==
Date:   Tue, 17 Aug 2021 01:44:26 +0000
Message-ID: <OSBPR01MB292024FD65B5B21716C4CB66F4FE9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-2-ruansy.fnst@fujitsu.com>
 <1d286104-28f4-d442-efed-4344eb8fa5a1@oracle.com>
 <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
In-Reply-To: <de19af2a-e9e6-0d43-8b14-c13b9ec38a9d@oracle.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a6df821-f31c-4b23-d3ac-08d961208c4f
x-ms-traffictypediagnostic: OS3PR01MB6194:
x-microsoft-antispam-prvs: <OS3PR01MB619482DB1BF8268616E0F6F4F4FE9@OS3PR01MB6194.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wLLEkGThhbiMBszBTNw/HfCDUOKz4Bwp0us8/ongZRjpQyof6RGzqAbR1gQlqQx7HF7rWd2V+tl1Udnkh00KSMV/9xiIpkh1aS8k9qYZb84SLlljeWGmQNpts2m9NOGBT/xGcrOzbmv0CXrVk0EP/4Ww3BIXUoj81EVCKtQsYvEmUL+9OPRCtfE8TFsTauGV33t5pXkzvr54nYpzBKcv376WcVER9k+SGq+PyYHQYYXY6WqwpwD3II2A89m0J4EZlEZxIp4vuKBfq4w47iThGloc1e4D/9MVAE0rc6J6lIujbbzw9WOQaAo0R+QNNxowbUhsA6kWCfsvwozLqVAGjsDUUShXeZTFuoge3oavwUIH3d+eOAfxXwEa8ZlPGQ40Z9twCnowYQBnl6k3nwdB/f+M/PqkxGX6uyO1Qljw+0kOc89sP+mbzBMRH/VAK/GAKEWj7+7KjZh8cbvPBMBAsw+KWLWPBh0sUktK3MAXaz1aWjy1lfAUO36q6AMz4ASJR444vc+OqrGIi1hwLrv9FjcnTTs+L7Ty8NLCd970tY4jEAhNwR41ozRn40bsbH4xpjXMy7TsE5qN8f+CBGyuQee4VCmdVAaA0JiUBxqu7qhroPi/LoSi/9etLEbTDcJ0YE/wH0EA8tB91e7WYDqvu/2jB7Wsv/NLiwpdxf4bCTfnopFTU6DMFCAI2UUwSXbSm3gmt0oyBw8nB8Xmp6BnVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(8936002)(2906002)(122000001)(38100700002)(478600001)(5660300002)(4326008)(86362001)(186003)(83380400001)(55016002)(71200400001)(52536014)(33656002)(7416002)(7696005)(8676002)(316002)(76116006)(85182001)(66946007)(38070700005)(110136005)(66556008)(66476007)(54906003)(66446008)(64756008)(26005)(9686003)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2M0UW9GQUt1TlRrd3ZOTVhHeGoxSXl2S1R0WktjcUZ0bHdvcCtLMU1MVjBU?=
 =?utf-8?B?OTk4a3hZQTdyUjlDZVpJeitxckZLTk1Lc000YmNwaWJtNnAwYVVtdmFHbXcx?=
 =?utf-8?B?VW1Hd3RremtrRnN0UGxVR0JRb2ltR3RDdGVSeW9POENlczhvRHF2Y2dxaGxr?=
 =?utf-8?B?QVpKbWh2OFJQZHNJYXNKcjJVZWp6Wnp3bmQxbXVFMDRKUmQzQnZrMHR3Vmd6?=
 =?utf-8?B?QlF2QXI3Wk40R253Z3VrYWk0QXR0MmYyYTZKQW5UVmVXUTlOVllNdkVuT3A5?=
 =?utf-8?B?YTNSd2dPQ0c0bFZGOGY1c09ucUhiei93L2pvaXpOMWtsWFZZa1FJRGRIYzFl?=
 =?utf-8?B?ME1taDFSVGplZks0SU5zaHRLSXJla3NMZEZFQnFTR3hGRmxaSFI3cWRyWjdG?=
 =?utf-8?B?R1R4QysrNjZicjJQc29qbm9VSW5XSXNnd3F5MEtzVGNqWFkxV2ZxUno2WmdN?=
 =?utf-8?B?V3FDeThwZEpndU5aN014bDRrcVJtdUVHL0wzaytDZWtGZ29XeDZMRHF0dEtN?=
 =?utf-8?B?WkRnczAvTHlCRHpoaXlpV3A0WVF0TXFQTmMrNTAxVTlDWVk5TUVHZDN1d1NC?=
 =?utf-8?B?RFNDT2IxbTRoNWx3TmE5Z1B5SkZ1OHo2ZXAxMllsR2ZJSnYxM292MkRoWWxO?=
 =?utf-8?B?ZjBkZ2lhY3B0WlkwOUQ0YVJQaVB5NzZHNnp3SVJ4WmpITlJObElZR011eFRK?=
 =?utf-8?B?Z0tXN0kxWERudG16OW5VZHlWUUljOUZDcFZsUERKc0JkeGZUVGl1QUdqRFR2?=
 =?utf-8?B?cThwS3RYdDNsWFZUYjBGNWdzRTFLazBOUkp2ditIN1JaS3ZzZHh0UTZrc2li?=
 =?utf-8?B?OHNaUWQ4Y1JmeFFZY0RJYkJrN1RUZFlIS3NpNWlVZUt4Ym1tU3FvNFBIYjlU?=
 =?utf-8?B?WmovRFAycy9GM3IrQjA3b05JeDJLYjFwYzZxS1c4S3BXRjJCK28yRjZxanFh?=
 =?utf-8?B?WTlod3dhMGtRYVUxSHdPWHlLYkY5SUZwU0w3Z3k0WTN3aFZ2L1BhSkI2eVZH?=
 =?utf-8?B?YjBIbjNDMlFkSloyMkJFeXpvUlE2QjBIb3dnYml0bUZSemJVTWl6TFZ6MWRt?=
 =?utf-8?B?N1ZYQWhoRzN2SnVEdnQ3MjVlUnc1VzhKMlZNY3dML2lOWG5aaitOR2JCWkRB?=
 =?utf-8?B?TFN0VWhoNTBIUlpleEhYZGZiTE5Pdm5CeEk4QTRjRzlLM2xrZ3VlSGUyRzl3?=
 =?utf-8?B?enN3WE4zbjdUa1M1ajk2eUhjWmRua3g4cnhqRGZlWGM4OUlRTTJJc0xBYUlp?=
 =?utf-8?B?T2pwUWkyM3NqaFJPc1VzU085bjB0UnNTdWxjeFVIN3FyM1ArUWFIMHg1YVlw?=
 =?utf-8?B?YjVjZEJlMkZIUHBoalB4QnhwcGRveXloZDc2UXhrY0JiNzN3andzS1BzM1ZV?=
 =?utf-8?B?enF1aUs5ajZvRDF0QUV4alZFQXVISlF2WWFDUjBXUUxCamxmdUE1UUM4NkpP?=
 =?utf-8?B?QXdrWFF1S2hXbUw0R1RGcHFLVUZCWWxvUWRaYUtaeFpRaHRJSEo3Qk0yQncv?=
 =?utf-8?B?MFRTekt0QXRBWHlvaHBMWU5SMVNOM0VQZWJIQm9iMUZORzgvZEZRNnZFMVYx?=
 =?utf-8?B?NmN2LzZ6UVJJL1YvNExLeUJpcFVBTDdqa3dCdExkZHhEWUk2bGc5Ukt1ekFS?=
 =?utf-8?B?bWZmdXJmRFZzdDFDNzV6dmU3NHo4OHNpbUlncjNzRGorVHRiQmlYNEcyWU5x?=
 =?utf-8?B?RWZjZHVsT1ZxZXloUkFmWElEenNXQWljdjhsY0F3VUNmNDNKMXp2VEY5UDZt?=
 =?utf-8?Q?oMaQH4zyP/m2wInazQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6df821-f31c-4b23-d3ac-08d961208c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 01:44:27.0085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R16RznhLDeaqjndQkbsAyrMW+Cl4XpbX33QheYAEkOg0Zt0M8vjtqD9wmqrJYTVIHyaqLSIdZPWgg/TXI4KHug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6194
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW5lIENodSA8amFuZS5jaHVA
b3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRVNFTkQgdjYgMS85XSBwYWdlbWFw
OiBJbnRyb2R1Y2UgLT5tZW1vcnlfZmFpbHVyZSgpDQo+IA0KPiBIaSwgU2hpWWFuZywNCj4gDQo+
IFNvIEkgYXBwbGllZCB0aGUgdjYgcGF0Y2ggc2VyaWVzIHRvIG15IDUuMTQtcmMzIGFzIGl0J3Mg
d2hhdCB5b3UgaW5kaWNhdGVkIGlzIHdoYXQNCj4gdjYgd2FzIGJhc2VkIGF0LCBhbmQgaW5qZWN0
ZWQgYSBoYXJkd2FyZSBwb2lzb24uDQo+IA0KPiBJJ20gc2VlaW5nIHRoZSBzYW1lIHByb2JsZW0g
dGhhdCB3YXMgcmVwb3J0ZWQgYSB3aGlsZSBhZ28gYWZ0ZXIgdGhlIHBvaXNvbg0KPiB3YXMgY29u
c3VtZWQgLSBpbiB0aGUgU0lHQlVTIHBheWxvYWQsIHRoZSBzaV9hZGRyIGlzIG1pc3Npbmc6DQo+
IA0KPiAqKiBTSUdCVVMoNyk6IGNhbmptcD0xLCB3aGljaHN0ZXA9MCwgKioNCj4gKiogc2lfYWRk
cigweChuaWwpKSwgc2lfbHNiKDB4QyksIHNpX2NvZGUoMHg0LCBCVVNfTUNFRVJSX0FSKSAqKg0K
PiANCj4gVGhlIHNpX2FkZHIgb3VnaHQgdG8gYmUgMHg3ZjY1NjgwMDAwMDAgLSB0aGUgdmFkZHIg
b2YgdGhlIGZpcnN0IHBhZ2UgaW4gdGhpcw0KPiBjYXNlLg0KPiANCj4gU29tZXRoaW5nIGlzIG5v
dCByaWdodC4uLg0KDQpIaSBKYW5lLA0KDQpTb3JyeSBmb3IgbGF0ZSByZXBseS4gIFRoYW5rcyBm
b3IgdGVzdGluZy4gIFRoaXMgYWRkcmVzcyBzaG91bGQgaGF2ZSBiZWVuIHJlcG9ydGVkIGluIG15
IGNvZGUuIEknbGwgY2hlY2sgd2h5IGl0J3MgZmluYWxseSBuaWwuDQoNCg0KLS0NClRoYW5rcy4N
ClJ1YW4uDQoNCj4gDQo+IHRoYW5rcywNCj4gLWphbmUNCj4gDQo+IA0KPiBPbiA4LzUvMjAyMSA2
OjE3IFBNLCBKYW5lIENodSB3cm90ZToNCj4gPiBUaGUgZmlsZXN5c3RlbSBwYXJ0IG9mIHRoZSBw
bWVtIGZhaWx1cmUgaGFuZGxpbmcgaXMgYXQgbWluaW11bSBidWlsdA0KPiA+IG9uIFBBR0VfU0la
RSBncmFudWxhcml0eSAtIGFuIGluaGVyaXRhbmNlIGZyb20gZ2VuZXJhbCBtZW1vcnlfZmFpbHVy
ZQ0KPiA+IGhhbmRsaW5nLsKgIEhvd2V2ZXIsIHdpdGggSW50ZWwncyBEQ1BNRU0gdGVjaG5vbG9n
eSwgdGhlIGVycm9yIGJsYXN0DQo+ID4gcmFkaXVzIGlzIG5vIG1vcmUgdGhhbiAyNTZieXRlcywg
YW5kIG1pZ2h0IGdldCBzbWFsbGVyIHdpdGggZnV0dXJlDQo+ID4gaGFyZHdhcmUgZ2VuZXJhdGlv
biwgYWxzbyBhZHZhbmNlZCBhdG9taWMgNjRCIHdyaXRlIHRvIGNsZWFyIHRoZSBwb2lzb24uDQo+
ID4gQnV0IEkgZG9uJ3Qgc2VlIGFueSBvZiB0aGF0IGNvdWxkIGJlIGluY29ycG9yYXRlZCBpbiwg
Z2l2ZW4gdGhhdCB0aGUNCj4gPiBmaWxlc3lzdGVtIGlzIG5vdGlmaWVkIGEgY29ycnVwdGlvbiB3
aXRoIHBmbiwgcmF0aGVyIHRoYW4gYW4gZXhhY3QNCj4gPiBhZGRyZXNzLg0KPiA+DQo+ID4gU28g
SSBndWVzcyB0aGlzIHF1ZXN0aW9uIGlzIGFsc28gZm9yIERhbjogaG93IHRvIGF2b2lkIHVubmVj
ZXNzYXJpbHkNCj4gPiByZXBhaXJpbmcgYSBQTUQgcmFuZ2UgZm9yIGEgMjU2QiBjb3JydXB0IHJh
bmdlIGdvaW5nIGZvcndhcmQ/DQo+ID4NCj4gPiB0aGFua3MsDQo+ID4gLWphbmUNCj4gPg0KPiA+
DQo+ID4gT24gNy8zMC8yMDIxIDM6MDEgQU0sIFNoaXlhbmcgUnVhbiB3cm90ZToNCj4gPj4gV2hl
biBtZW1vcnktZmFpbHVyZSBvY2N1cnMsIHdlIGNhbGwgdGhpcyBmdW5jdGlvbiB3aGljaCBpcw0K
PiA+PiBpbXBsZW1lbnRlZCBieSBlYWNoIGtpbmQgb2YgZGV2aWNlcy7CoCBGb3IgdGhlIGZzZGF4
IGNhc2UsIHBtZW0gZGV2aWNlDQo+ID4+IGRyaXZlciBpbXBsZW1lbnRzIGl0LsKgIFBtZW0gZGV2
aWNlIGRyaXZlciB3aWxsIGZpbmQgb3V0IHRoZQ0KPiA+PiBmaWxlc3lzdGVtIGluIHdoaWNoIHRo
ZSBjb3JydXB0ZWQgcGFnZSBsb2NhdGVkIGluLsKgIEFuZCBmaW5hbGx5IGNhbGwNCj4gPj4gZmls
ZXN5c3RlbSBoYW5kbGVyIHRvIGRlYWwgd2l0aCB0aGlzIGVycm9yLg0KPiA+Pg0KPiA+PiBUaGUg
ZmlsZXN5c3RlbSB3aWxsIHRyeSB0byByZWNvdmVyIHRoZSBjb3JydXB0ZWQgZGF0YSBpZiBuZWNl
c3NhcnkuDQo+ID4NCg==
