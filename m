Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 448BD5A626
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 23:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfF1VIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 17:08:35 -0400
Received: from mail-eopbgr750071.outbound.protection.outlook.com ([40.107.75.71]:39682
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbfF1VIf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 17:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLgLEJUHkQXKjGrOtnbFeAR89mxqW7EXn0YYtpiOAQA=;
 b=htYxJs+MLXODW43oWkslij9rCa3f9ladN0eLzm95gsmJvEF7LXdPhjTpg6NQlm9edFpg84CiMnJ1Khuzgy2BAnciZPhP0dWvQs8xhww6LBy8DOH9/LlIITfN1oVyoyrBpRpLHnTtn4/ttLEQzi+8waRUUpkgXtadVGtL5dxQavY=
Received: from BN8PR06MB6228.namprd06.prod.outlook.com (20.178.217.156) by
 BN8PR06MB5538.namprd06.prod.outlook.com (20.178.210.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Fri, 28 Jun 2019 21:08:31 +0000
Received: from BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::1de4:694f:e20b:137c]) by BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::1de4:694f:e20b:137c%4]) with mapi id 15.20.2008.018; Fri, 28 Jun 2019
 21:08:31 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [GIT PULL] Two more Linux NFS client fixes
Thread-Topic: [GIT PULL] Two more Linux NFS client fixes
Thread-Index: AQHVLfWjrS3C/N3qdk29RYss51YoBQ==
Date:   Fri, 28 Jun 2019 21:08:31 +0000
Message-ID: <89f621cf02c20863839561bfc0ef2ee36cbfe9ab.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [23.28.75.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f7c3d2a-8aad-45d4-32ce-08d6fc0cc670
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR06MB5538;
x-ms-traffictypediagnostic: BN8PR06MB5538:
x-microsoft-antispam-prvs: <BN8PR06MB5538F407EFDD07525A347627F8FC0@BN8PR06MB5538.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(305945005)(66946007)(66446008)(66476007)(6512007)(64756008)(53936002)(73956011)(7736002)(5640700003)(102836004)(5660300002)(476003)(1730700003)(81156014)(81166006)(2616005)(8936002)(99286004)(478600001)(8676002)(76116006)(6486002)(66556008)(186003)(118296001)(6506007)(86362001)(6436002)(26005)(6916009)(4326008)(2501003)(25786009)(68736007)(66066001)(2351001)(71200400001)(2906002)(486006)(54906003)(36756003)(3846002)(58126008)(316002)(72206003)(14454004)(256004)(71190400001)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB5538;H:BN8PR06MB6228.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xp3d9BOa5B0iMZ8NXYkgu5mzNR4NpuV4d5vt4SEpacWcmbj8oBhW9jXeqebv2UBh5n0FUv4SFgz9MiH7ibeMu5Y0uplBdHtk6AZSRo/Da5+V3Z8AjNYjysx1VISefxsErqn5Pj7WSF52k6MF0dNOu++qgaBWKyszJDMn48HcFCU97C6OUKIxzSxEhNU0wQd4LVbKn3DrNLJNfnk3kUfY3bhIglf9sjTivgqNohu7inq7V4LNpq7SOb7Ye1VuN8mJ05BWiY0w0t60XCiMWm/j3wV68c5En3zOYuKKpu17A0ptjGIJj8M7Y3F51lU8OZRgDCFoAzeeY/X9TFC/pZww2ftxR/LbCMmaqAhXN6RgybHdN+L7wTYyclRbJ5ls5gBYzcI/l96lFuL+uu3ZNg9glsP9tUU9+wTSHbievPF1Piw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <296AA00904137F4EBB4707584C776469@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7c3d2a-8aad-45d4-32ce-08d6fc0cc670
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 21:08:31.6413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjschuma@netapp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5538
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQNCjE5ZDU1MDQ2
Y2Q4MjRiYWFiNTM1MzRiYTdlN2Y5OTk0NWM2ZmRjYjE6DQoNCiAgU1VOUlBDOiBGaXggYSBjcmVk
ZW50aWFsIHJlZmNvdW50IGxlYWsgKDIwMTktMDYtMjEgMTQ6NDU6MDkgLTA0MDApDQoNCmFyZSBh
dmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdpdDovL2dpdC5saW51eC1u
ZnMub3JnL3Byb2plY3RzL2FubmEvbGludXgtbmZzLmdpdCB0YWdzL25mcy1mb3ItNS4yLQ0KNA0K
DQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8NCjY4ZjQ2MTU5M2Y3NmJkNWYxN2U4N2Nk
ZDBiZWEyOGY0Mjc4YzcyNjg6DQoNCiAgTkZTL2ZsZXhmaWxlczogVXNlIHRoZSBjb3JyZWN0IFRD
UCB0aW1lb3V0IGZvciBmbGV4ZmlsZXMgSS9PICgyMDE5LQ0KMDYtMjggMTE6NDg6NTIgLTA0MDAp
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NClRoZXNlIGFyZSBib3RoIHN0YWJsZSBmaXhlcy4gT25lIHRvIGNhbGN1bGF0
ZSB0aGUgY29ycmVjdCBjbGllbnQNCm1lc3NhZ2UgbGVuZ3RoIGluIHRoZSBjYXNlIG9mIHBhcnRp
YWwgdHJhbnNtaXNzaW9ucy4gQW5kIHRoZSBvdGhlciB0bw0Kc2V0IHRoZSBwcm9wZXIgVENQIHRp
bWVvdXQgZm9yIGZsZXhmaWxlcy4NCg0KVGhhbmtzLA0KQW5uYQ0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVHJvbmQgTXlr
bGVidXN0ICgyKToNCiAgICAgIFNVTlJQQzogRml4IHVwIGNhbGN1bGF0aW9uIG9mIGNsaWVudCBt
ZXNzYWdlIGxlbmd0aA0KICAgICAgTkZTL2ZsZXhmaWxlczogVXNlIHRoZSBjb3JyZWN0IFRDUCB0
aW1lb3V0IGZvciBmbGV4ZmlsZXMgSS9PDQoNCiBmcy9uZnMvZmxleGZpbGVsYXlvdXQvZmxleGZp
bGVsYXlvdXRkZXYuYyB8ICAyICstDQogbmV0L3N1bnJwYy94cHJ0c29jay5jICAgICAgICAgICAg
ICAgICAgICAgfCAxNiArKysrKysrKy0tLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo=
