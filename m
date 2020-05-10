Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976E81CCB5A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 15:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgEJNjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 09:39:08 -0400
Received: from mail-dm6nam11on2102.outbound.protection.outlook.com ([40.107.223.102]:59936
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728238AbgEJNjH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 09:39:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYNwrtFSM6EQsDqDB1ccr22FZhpzXVc8YfzJSvv7KmZpKGH7E/UsOQhr/sjYC+SfrzWiZMIaDqq84ofukba+8WeThXMZsvtT00lyRkH8k3M4vXaCzGxOUK7PbHVPzm7BCRi5A0AcXaxpHU97BBJfbzL0vNk9yh7ClevgSRuwT6z2F0VH4YO1QGNlLesHMkb3XK2bvS5Ip+/UVWaDiKFo6/XWHA+jMbclNNU1CxnvUXQe+vpSwHwnzFH+0/52aFQoxkjyLM3ATx0cbEC4hmzVZwWrRoBJSF22VRj+wsx8b2CFROHyInldCqAo2iHrx5fI1InkizcrglmtB2OWtlYEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1qY67iWPl2NvDvI+6/kkS0Pk2zGIQN14Y+f8x4h5L4=;
 b=bycQ5Pl9AthhoPe2hktyhr/kOqbunnQ8OmwcG9fBO68X6+r3XJPP/pVdceV172y9GjOfVbAPuRlTj/g9/FRqYIMjTVlk2PpVJwNeVCxJAI4qvJ//ds4/tU8+Fpr/GUe5WCVYtPry3QGUjWqEZSaOYp9mlGbvcCUgINWyvB8n0qw8/ag26WMv8raEVk0W27kSuhN3CptYQcTq7sRETP2+3S2gDERSIvaCs/QHqC3bAb29QnXlcPITLnqC0LJwKJKGfYMddMQOcmMARwk+u3RTC+G5SWRkQq/QodVaHcc4qy7ZcDIO5WQ4SX6aICZ3rVbvY8wfl1Yfki39O3hCOiQv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1qY67iWPl2NvDvI+6/kkS0Pk2zGIQN14Y+f8x4h5L4=;
 b=CzQhZS8aZ/Qc+bO5wly8rBlFLS1+XtGcuc8cqKrihxhHiupdLnEuQQZhaL/ZNq64OgIayhtWJsxYHaGnMML40H+lmuirH+8xSkxcPwVkNTcQnn/8MUuYrkVUMKPVph+Ja2vlkMnkHDdCJGX8LfFpYudyFroUmsrdm/HUYFyJb14=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3607.namprd13.prod.outlook.com (2603:10b6:610:28::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.13; Sun, 10 May
 2020 13:39:03 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3000.014; Sun, 10 May 2020
 13:39:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "cmaiolino@redhat.com" <cmaiolino@redhat.com>,
        "carmark.dlut@gmail.com" <carmark.dlut@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/5] cachefiles, nfs: Fixes
Thread-Topic: [PATCH 0/5] cachefiles, nfs: Fixes
Thread-Index: AQHWJYZfjpuxdZELmk6DUdcB+BLTBqihVa4A
Date:   Sun, 10 May 2020 13:39:03 +0000
Message-ID: <d4efead1d6dba67f5c862a8d00ca88dd3c45dd34.camel@hammerspace.com>
References: <158897619675.1119820.2203023452686054109.stgit@warthog.procyon.org.uk>
In-Reply-To: <158897619675.1119820.2203023452686054109.stgit@warthog.procyon.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5816056e-63e4-40c5-8cb6-08d7f4e78124
x-ms-traffictypediagnostic: CH2PR13MB3607:
x-microsoft-antispam-prvs: <CH2PR13MB3607E79F5CE64155820481D9B8A00@CH2PR13MB3607.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 039975700A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3tZrJRNs1H1vgr45yXNez+KZDoFcagDu5ROzmMJXQk6NjRBb2HXQzvKNMGvvXwQPgUUtRfgKNi8Hj101FOCFnEw/1b5pSqONNCNIdSTW4TVqx/Ytdvur2xkFSmrhoLZLfq8vIskmGvrhg07qvQf09togl4NT8HuwGe47mKK+NtcBtkch2QttMvoBiSKkVd3GDdoFGoQ6aYMRV4tar/D/J2XtU5HjUaEYHOMaQqXdDsrwDuuP7XL6EKV3fYn5uIV+xtfdFKvMtz43wk3JEwHYWnBwwKh7eTZfjAEaJtA0YtDS2klOHC15LK3WoVnqJbOiz4qgK2MqZKVlIcfMjoyQbdIeLl7k+xruJZUNWxCDL05AvxLOZmyHktMuopCtrLa+66PZMTs0YQv1kwf8Yf7LLAgb3bjvjVUHa9YIGnn4YFBNZFWiH+GZpGi+0yNLAo4UgJjoRgJaCu9or2XdSkUx050iSUkU52V0KuxSYkYD5Q2Xxp+SXasrOAHAcnrXrDpykrWAxCTimccBeP18KHuDwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(136003)(33430700001)(110136005)(54906003)(4326008)(6506007)(6512007)(26005)(186003)(2906002)(71200400001)(6486002)(5660300002)(86362001)(66556008)(66446008)(91956017)(8936002)(36756003)(76116006)(66946007)(8676002)(66476007)(508600001)(33440700001)(7416002)(2616005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WGeGTGxlSxfb7jC4lABoYrFgoCSGTWuYTwlZ8WPehStdKioQ2VyQsUo+TcWuKJrKuT4VVaxM/EXASyvUnWlRNTobwyDjl7AHzZc9PL15QLG2XXjOVqZp3/M3jlxmsW51ScM59MeE5RLz7ToqtfEEbZHn37fugaRPlO+R88+8A7YWyTdC18jyZOoFi05l/5Zn/Ce3VGbw30J+YCt1Rvi5NLdGiZhGK7z5uTHDB29WQFf0yDGEas7AyHIAEuSEuERmsf94oP16Or3rTuxJZuUS7yPZM2V8BUth+sKRHDmC+00EJ+9WMTHngmS+/Lr5owOiHvNEcWEWsKD1IzXmpXQaUmkyNJnJAYCxPDe2a8/KlV3FcbZKqOA6MrUVpaQYjQ6gRElFpf6mxGHn4JAdmdxJGBgcj/LEDOLfaK6iXRAHDRwEw51R/6MQwAiJvU1XNwfEqr8LbXPx5kMk07VF6UiqRMRSOWKCl/q1uRewB17aHls=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EA20451C727ED44A0E8883B4FF0319D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5816056e-63e4-40c5-8cb6-08d7f4e78124
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2020 13:39:03.6783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9t+XYVcqVx0nS/MMdM/gM2JLhvkU7TYBZxtm51QaUCOncp8QmF9woFoHIh7Dosxx+SityU5PTkE5U5HAbuF6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3607
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgRGF2aWQsDQoNCk9uIEZyaSwgMjAyMC0wNS0wOCBhdCAyMzoxNiArMDEwMCwgRGF2aWQgSG93
ZWxscyB3cm90ZToNCj4gSGkgTGludXMsIFRyb25kLCBBbm5hLA0KPiANCj4gQ2FuIHlvdSBwdWxs
IHRoZXNlIGZpeGVzIGZvciBjYWNoZWZpbGVzIGFuZCBORlMncyB1c2Ugb2YNCj4gZnNjYWNoZT8g
IFNob3VsZA0KPiB0aGV5IGdvIHRocm91Z2ggdGhlIE5GUyB0cmVlIG9yIGRpcmVjdGx5IHVwc3Ry
ZWFtPyAgVGhlIHRoaW5ncyBmaXhlZA0KPiBhcmU6DQo+IA0KPiAgKDEpIFRoZSByZW9yZ2FuaXNh
dGlvbiBvZiBibWFwKCkgdXNlIGFjY2lkZW50YWxseSBjYXVzZWQgdGhlIHJldHVybg0KPiB2YWx1
ZQ0KPiAgICAgIG9mIGNhY2hlZmlsZXNfcmVhZF9vcl9hbGxvY19wYWdlcygpIHRvIGdldCBjb3Jy
dXB0ZWQuDQo+IA0KPiAgKDIpIFRoZSBORlMgc3VwZXJibG9jayBpbmRleCBrZXkgYWNjaWRlbnRh
bGx5IGdvdCBjaGFuZ2VkIHRvIGluY2x1ZGUNCj4gYQ0KPiAgICAgIG51bWJlciBvZiBrZXJuZWwg
cG9pbnRlcnMgLSBtZWFuaW5nIHRoYXQgdGhlIGtleSBpc24ndCBtYXRjaGFibGUNCj4gYWZ0ZXIN
Cj4gICAgICBhIHJlYm9vdC4NCj4gDQo+ICAoMykgQSByZWR1bmRhbnQgY2hlY2sgaW4gbmZzX2Zz
Y2FjaGVfZ2V0X3N1cGVyX2Nvb2tpZSgpLg0KPiANCj4gICg0KSBUaGUgTkZTIGNoYW5nZV9hdHRy
IHNvbWV0aW1lcyBzZXQgaW4gdGhlIGF1eGlsaWFyeSBkYXRhIGZvciB0aGUNCj4gICAgICBjYWNo
aW5nIG9mIGFuIGZpbGUgYW5kIHNvbWV0aW1lcyBub3QsIHdoaWNoIGNhdXNlcyB0aGUgY2FjaGUg
dG8NCj4gZ2V0DQo+ICAgICAgZGlzY2FyZGVkIHdoZW4gaXQgc2hvdWxkbid0Lg0KPiANCj4gICg1
KSBUaGVyZSdzIGEgcmFjZSBiZXR3ZWVuIGNhY2hlZmlsZXNfcmVhZF93YWl0ZXIoKSBhbmQNCj4g
ICAgICBjYWNoZWZpbGVzX3JlYWRfY29waWVyKCkgdGhhdCBjYXVzZXMgYW4gb2NjYXNpb25hbCBh
c3NlcnRpb24NCj4gZmFpbHVyZS4NCj4gDQo+IFRoZSBwYXRjaGVzIGFyZSB0YWdnZWQgaGVyZToN
Cj4gDQo+IAlnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZGhv
d2VsbHMvbGludXgtDQo+IGZzLmdpdA0KPiAJdGFnIGZzY2FjaGUtZml4ZXMtMjAyMDA1MDgtMg0K
PiANCj4gVGhhbmtzLA0KPiBEYXZpZA0KPiAtLS0NCj4gRGF2ZSBXeXNvY2hhbnNraSAoMyk6DQo+
ICAgICAgIE5GUzogRml4IGZzY2FjaGUgc3VwZXJfY29va2llIGluZGV4X2tleSBmcm9tIGNoYW5n
aW5nIGFmdGVyDQo+IHVtb3VudA0KPiAgICAgICBORlM6IEZpeCBmc2NhY2hlIHN1cGVyX2Nvb2tp
ZSBhbGxvY2F0aW9uDQo+ICAgICAgIE5GU3Y0OiBGaXggZnNjYWNoZSBjb29raWUgYXV4X2RhdGEg
dG8gZW5zdXJlIGNoYW5nZV9hdHRyIGlzDQo+IGluY2x1ZGVkDQo+IA0KPiBEYXZpZCBIb3dlbGxz
ICgxKToNCj4gICAgICAgY2FjaGVmaWxlczogRml4IGNvcnJ1cHRpb24gb2YgdGhlIHJldHVybiB2
YWx1ZSBpbg0KPiBjYWNoZWZpbGVzX3JlYWRfb3JfYWxsb2NfcGFnZXMoKQ0KPiANCj4gTGVpIFh1
ZSAoMSk6DQo+ICAgICAgIGNhY2hlZmlsZXM6IEZpeCByYWNlIGJldHdlZW4gcmVhZF93YWl0ZXIg
YW5kIHJlYWRfY29waWVyDQo+IGludm9sdmluZyBvcC0+dG9fZG8NCj4gDQo+IA0KPiAgZnMvY2Fj
aGVmaWxlcy9yZHdyLmMgfCAgIDEyICsrKysrKy0tLS0tLQ0KPiAgZnMvbmZzL2ZzY2FjaGUuYyAg
ICAgfCAgIDM5ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZnMv
bmZzL3N1cGVyLmMgICAgICAgfCAgICAxIC0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQo+IA0KDQpJIGNhbiBwdWxsIHRoaXMgYnJhbmNoLCBh
bmQgc2VuZCBpdCB0b2dldGhlciB3aXRoIHRoZSBORlMgY2xpZW50DQpidWdmaXhlcyBmb3IgNS43
LXJjNS4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
