Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F96A60D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 07:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfICFwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 01:52:20 -0400
Received: from mail-eopbgr1320110.outbound.protection.outlook.com ([40.107.132.110]:6416
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbfICFwU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:52:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGF/guWPIUFihe/DnIshMXv2VnJxfw6EsqoJsgGtB6VqUXNgCtjZ/tIcDRZDz+pS4f35InV+AXZ6WTSGbS677AXOsxyPuOB2dls8qqfW2z/X9jd9uYrNbwjS33xFyQWZyEOpVnyHgpJbp29Ub7V9IM+RT2IPV1gky45l5ts5EY999Q/7V2C0R78DI+dX1xdz5rfVN1+lm4hvjyLn073fvjPAVnY/gMmU/CB2L0xZni2NK6bN1c9f6BOzd2PhRBpkZpSmqR35vDLWQ52m1kzTlocZ4QG1csdn+4JCreJHCbRAXHKVX8bSAoBpG7JHCCu+1Bvxt0UYTNh445SlBxkDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QWu1vUzgC+gBzOpFYQ8s//v1Vumo1pybegAlnDvQUQ=;
 b=KPmSpKSCCThwXLxKEdhZ+DBtpV7NgxOCkXvyvdKsT4Lcnwb7wWA8ksRzTZAfODTXp/FsBPrhmsYrHQHMDT/SsCDIepfz4pYWtLbeaHMAZSJmMip0yOMTliLX7T8MoKNDTt+oub8UW9EWATOsB/C5aT5nY/78giLIEtQNm/DUlyotm7si28CCLnxLkqu93bBshG+LFH3v7g9FykfsX2HKjYfheOagh2uxE1IdH9+L2BAN1DLHQZJZWC9gNivb9iYin+I6FRMxyslgCwL1HHEKKJiFixPtfqhcecaQNPKxywY35/uRpXSsQG8wa4lEvn7yKu7U640ex9NC9VHZCeb6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QWu1vUzgC+gBzOpFYQ8s//v1Vumo1pybegAlnDvQUQ=;
 b=Sa0MJjmmjPvZ/UZ2tyj/knwGeXYOx9bv1D7s7A3Lha/38moL0Pq+Hca+4X6GfhXaWEFX4oYxCMi5yXpbVJup02Oe+VH3RTDEHThI9hhZ6XPFV8r5FTSFyvfn2e08/g6rl+VTvt3DPDq8wrvcr88K70UPt/j8TYjY+x9V+piaJKY=
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM (10.170.173.13) by
 KU1P153MB0135.APCP153.PROD.OUTLOOK.COM (10.170.172.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.1; Tue, 3 Sep 2019 05:50:33 +0000
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::f112:af3b:a908:db07]) by KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::f112:af3b:a908:db07%7]) with mapi id 15.20.2263.004; Tue, 3 Sep 2019
 05:50:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan-Linux Cui <dexuan.linux@gmail.com>, Qian Cai <cai@lca.pw>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Lili Deng (Wicresoft North America Ltd)" <v-lide@microsoft.com>
Subject: RE: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Thread-Topic: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Thread-Index: AQHVYhea2RO2fNjnZkqQ7htfXZO/uKcZbPIQ
Date:   Tue, 3 Sep 2019 05:50:33 +0000
Message-ID: <KU1P153MB016606E33CF2FFEBF2581C58BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <CAA42JLZySdadoL5LAhofXZx3T41A9hm=_izyrRs0MHbSbMf3MA@mail.gmail.com>
In-Reply-To: <CAA42JLZySdadoL5LAhofXZx3T41A9hm=_izyrRs0MHbSbMf3MA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-03T05:50:31.7179496Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4d8d62fd-1bc7-4759-8732-2e13cbb300f8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:45b3:904b:db76:f1a7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccf7c6c6-1c47-4fd2-1b58-08d73032a318
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:KU1P153MB0135;
x-ms-traffictypediagnostic: KU1P153MB0135:|KU1P153MB0135:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <KU1P153MB0135324CF046BA2B40FEDBDDBFB90@KU1P153MB0135.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(189003)(199004)(7696005)(476003)(8936002)(478600001)(33656002)(9686003)(81156014)(81166006)(53936002)(229853002)(966005)(6436002)(76116006)(66946007)(71190400001)(8676002)(71200400001)(6306002)(2906002)(6246003)(107886003)(52536014)(305945005)(10290500003)(55016002)(316002)(256004)(14444005)(14454004)(22452003)(99286004)(5660300002)(4326008)(25786009)(8990500004)(110136005)(54906003)(74316002)(6116002)(186003)(46003)(86362001)(66446008)(64756008)(446003)(66556008)(102836004)(66476007)(6506007)(53546011)(10090500001)(486006)(11346002)(7736002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0135;H:KU1P153MB0166.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y2bNapO0fZ5ufmbvTY+9Vv0lDBy2la+jIzTUgzFuoP5N/0cRcZmgx2XXJ8D+qGrdaKYsB/9e3suUZViy02Za9v7J9nVHIj+tRdoxbPFxawbZCvIHyUXNJZT2tJhQN8sQrgQqVsjM9H4J4xwe88JatKnS0Lp+aSW4CBt7x8MLpOlq+oYugtob+MUbhL9GQPcNQYB9/+OKBiLQeQ9cCPXuPZoBVVSphBNEmIVvG1qVAv2f0jmX2HklfdI0uBqVwbl7A/n3gTOh8+tf6b4e978OZnne8RsfWlEfZUrfggeaYlsIg0CDPxYijLh5jphHmNMjDz+24lnUHKR0uB4p+4KJ/DZyyBV6E9kdBcuR0gddAB99qw67tklHpVy3kX/MwNyttcrvWa3gl/m/7CmQgbrC+pA6fYACZX4ooXDzIhqrJdM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf7c6c6-1c47-4fd2-1b58-08d73032a318
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 05:50:33.4101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95O+PcW4qY9RHUoyal9agHHtyD0cFSFdMaZOkLaUUBXrPXWAWJQ5PkIeZTQNFjScM00L21Qx0NA4TvXr7G7paQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0135
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBEZXh1YW4tTGludXggQ3VpIDxkZXh1YW4ubGludXhAZ21haWwuY29tPg0KPiBTZW50
OiBNb25kYXksIFNlcHRlbWJlciAyLCAyMDE5IDEwOjIyIFBNDQo+IFRvOiBRaWFuIENhaSA8Y2Fp
QGxjYS5wdz4NCj4gQ2M6IEFsIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPjsgbGludXgt
ZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IExLTUwNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPjsgTGlsaSBEZW5nDQo+IChX
aWNyZXNvZnQgTm9ydGggQW1lcmljYSBMdGQpIDx2LWxpZGVAbWljcm9zb2Z0LmNvbT4NCj4gU3Vi
amVjdDogUmU6ICJmcy9uYW1laS5jOiBrZWVwIHRyYWNrIG9mIG5kLT5yb290IHJlZmNvdW50IHN0
YXR1cyIgY2F1c2VzIGJvb3QNCj4gcGFuaWMNCj4gDQo+IE9uIE1vbiwgU2VwIDIsIDIwMTkgYXQg
OToyMiBQTSBRaWFuIENhaSA8Y2FpQGxjYS5wdz4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgbGludXgt
bmV4dCBjb21taXQgImZzL25hbWVpLmM6IGtlZXAgdHJhY2sgb2YgbmQtPnJvb3QgcmVmY291bnQg
c3RhdHVz4oCdDQo+IFsxXSBjYXVzZXMgYm9vdCBwYW5pYyBvbiBhbGwNCj4gPiBhcmNoaXRlY3R1
cmVzIGhlcmUgb24gdG9kYXnigJlzIGxpbnV4LW5leHQgKDA5MDIpLiBSZXZlcnRlZCBpdCB3aWxs
IGZpeCB0aGUgaXNzdWUuDQo+IA0KPiBJIGJlbGlldmUgSSdtIHNlZWluZyB0aGUgc2FtZSBpc3N1
ZSB3aXRoIG5leHQtMjAxOTA5MDIgaW4gYSBMaW51eCBWTQ0KPiBydW5uaW5nIG9uIEh5cGVyLVYg
KG5leHQtMjAxOTA4MzAgaXMgZ29vZCkuDQo+IA0KPiBnaXQtYmlzZWN0IHBvaW50cyB0byB0aGUg
c2FtZSBjb21taXQgaW4gbGludXgtbmV4dDoNCj4gICAgIGUwMTNlYzIzYjgyMyAoImZzL25hbWVp
LmM6IGtlZXAgdHJhY2sgb2YgbmQtPnJvb3QgcmVmY291bnQgc3RhdHVzIikNCj4gDQo+IEkgY2Fu
IHJlcHJvZHVjZSB0aGUgaXNzdWUgZXZlcnkgdGltZSBJIHJlYm9vdCB0aGUgc3lzdGVtLg0KPiAN
Cj4gVGhhbmtzLA0KPiBEZXh1YW4NCg0KQlRXLCBJIHRyaWVkIHRoZSBwYXRjaCBodHRwczovL2xr
bWwub3JnL2xrbWwvMjAxOS84LzMxLzE1OCAtLSBub3QgaGVscGZ1bCBhdCBhbGwuDQoNCkZZSTog
dGhpcyBpcyBteSBjYWxsLXRyYWNlOg0KDQpbICAgMTYuODQzNDUyXSBSdW4gL2luaXQgYXMgaW5p
dCBwcm9jZXNzDQpMb2FkaW5nLCBwbGVhc2Ugd2FpdC4uLg0Kc3RhcnRpbmcgdmVyc2lvbiAyMzkN
ClsgICAxNi45MzY0NzZdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KWyAg
IDE2LjkzNzkyOV0gREVCVUdfTE9DS1NfV0FSTl9PTighdGVzdF9iaXQoY2xhc3NfaWR4LCBsb2Nr
X2NsYXNzZXNfaW5fdXNlKSkNClsgICAxNi45Mzc5MjldIFdBUk5JTkc6IENQVTogMTAgUElEOiAz
NjYgYXQga2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjM4NTAgX19sb2NrX2FjcXVpcmUuaXNyYS4z
NCsweDUwYy8weDU2MA0KWyAgIDE2LjkzNzkyOV0gTW9kdWxlcyBsaW5rZWQgaW46DQpbICAgMTYu
OTM3OTI5XSBDUFU6IDEwIFBJRDogMzY2IENvbW06IHVkZXZhZG0gTm90IHRhaW50ZWQgNS4zLjAt
cmMxKyAjMjYNClsgICAxNi45Mzc5MjldIEhhcmR3YXJlIG5hbWU6IE1pY3Jvc29mdCBDb3Jwb3Jh
dGlvbiBWaXJ0dWFsIE1hY2hpbmUvVmlydHVhbCBNYWNoaW5lLCBCSU9TIDA5MDAwOCAgMTIvMDcv
MjAxOA0KWyAgIDE2LjkzNzkyOV0gUklQOiAwMDEwOl9fbG9ja19hY3F1aXJlLmlzcmEuMzQrMHg1
MGMvMHg1NjANClsgICAxNi45Mzc5MjldIENvZGU6IDAwIDg1IGMwIDBmIDg0IDcyIGZlIGZmIGZm
IDhiIDFkIGFmIDViIDJiIDAxIDg1IGRiIDBmIDg1IDY0IGZlIGZmIGZmIDQ4IGM3IGM2IDA4IDk3
IDA3Li4uDQpbICAgMTYuOTM3OTI5XSBSU1A6IDAwMTg6ZmZmZmM5MDAwM2ZmM2M0MCBFRkxBR1M6
IDAwMDEwMDg2DQpbICAgMTYuOTM3OTI5XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiAwMDAw
MDAwMDAwMDAwMDAwIFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDE2LjkzNzkyOV0gUkRYOiBm
ZmZmZmZmZjgxMGUzZDYzIFJTSTogMDAwMDAwMDAwMDAwMDAwMSBSREk6IGZmZmZmZmZmODIyNjI4
YTANClsgICAxNi45Mzc5MjldIFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IGZmZmZmZmZmODJj
MGU0MjAgUjA5OiAwMDAwMDAwMDAwMDM5NDQwDQpbICAgMTYuOTM3OTI5XSBSMTA6IDAwMDAwMDEy
MDlmNjQ2YjYgUjExOiAwMDAwMDAwMDAwMDAwMTZlIFIxMjogZmZmZjg4ODI3NjQ0MDA0MA0KWyAg
IDE2LjkzNzkyOV0gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBS
MTU6IGZmZmY4ODgyNzY0NDA4MTgNClsgICAxNi45Mzc5MjldIEZTOiAgMDAwMDdmNGVlMmYwZjhj
MCgwMDAwKSBHUzpmZmZmODg4MjdkNzAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAN
ClsgICAxNi45Mzc5MjldIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAw
ODAwNTAwMzMNClsgICAxNi45Mzc5MjldIENSMjogMDAwMDU1ZGNlNzQwMzAwMCBDUjM6IDAwMDAw
MDAyNzY3NzIwMDMgQ1I0OiAwMDAwMDAwMDAwMzYwNmUwDQpbICAgMTYuOTM3OTI5XSBEUjA6IDAw
MDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAw
MA0KWyAgIDE2LjkzNzkyOV0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZl
MGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDANClsgICAxNi45Mzc5MjldIENhbGwgVHJhY2U6DQpb
ICAgMTYuOTM3OTI5XSAgbG9ja19hY3F1aXJlKzB4YWUvMHgxNjANClsgICAxNi45Mzc5MjldICA/
IGRwdXQucGFydC4zNCsweDE2NC8weDM4MA0KWyAgIDE2LjkzNzkyOV0gID8gZHB1dC5wYXJ0LjM0
KzB4MjkvMHgzODANClsgICAxNi45Mzc5MjldICBfcmF3X3NwaW5fbG9jaysweDJjLzB4NDANClsg
ICAxNi45Mzc5MjldICA/IGRwdXQucGFydC4zNCsweDE2NC8weDM4MA0KWyAgIDE2LjkzNzkyOV0g
IGRwdXQucGFydC4zNCsweDE2NC8weDM4MA0KWyAgIDE3LjA5ODUyOV0gIHRlcm1pbmF0ZV93YWxr
KzB4ZGUvMHgxMDANClsgICAxNy4wOTg1MjldICBwYXRoX2xvb2t1cGF0LmlzcmEuNjIrMHhhMy8w
eDIyMA0KWyAgIDE3LjA5ODUyOV0gIGZpbGVuYW1lX2xvb2t1cC5wYXJ0Ljc3KzB4YTAvMHgxNzAN
ClsgICAxNy4wOTg1MjldICA/IGttZW1fY2FjaGVfYWxsb2MrMHgxNjkvMHgyYTANClsgICAxNy4w
OTg1MjldICBkb19yZWFkbGlua2F0KzB4NWQvMHgxMTANClsgICAxNy4wOTg1MjldICBfX3g2NF9z
eXNfcmVhZGxpbmthdCsweDFhLzB4MjANClsgICAxNy4wOTg1MjldICBkb19zeXNjYWxsXzY0KzB4
NWQvMHgxYzANClsgICAxNy4wOTg1MjldICA/IHByZXBhcmVfZXhpdF90b191c2VybW9kZSsweDdi
LzB4YjANClsgICAxNy4wOTg1MjldICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0
NC8weGE5DQpbICAgMTcuMDk4NTI5XSBSSVA6IDAwMzM6MHg3ZjRlZTM3OGRhNGENClsgICAxNy4w
OTg1MjldIENvZGU6IDQ4IDhiIDBkIDQ5IDg0IDBkIDAwIGY3IGQ4IDY0IDg5IDAxIDQ4IDgzIGM4
IGZmIGMzIDY2IDJlIDBmIDFmIDg0IDAwIDAwIC4uLg0KWyAgIDE3LjA5ODUyOV0gUlNQOiAwMDJi
OjAwMDA3ZmZmYmRkYjc5NjggRUZMQUdTOiAwMDAwMDIwMiBPUklHX1JBWDogMDAwMDAwMDAwMDAw
MDEwYg0KWyAgIDE3LjA5ODUyOV0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDU1ZGNl
NzQwYjIyMCBSQ1g6IDAwMDA3ZjRlZTM3OGRhNGENClsgICAxNy4wOTg1MjldIFJEWDogMDAwMDU1
ZGNlNzQwYjIyMCBSU0k6IDAwMDA1NWRjZTc0MGIyMDEgUkRJOiAwMDAwMDAwMDAwMDAwMDA1DQpb
ICAgMTcuMDk4NTI5XSBSQlA6IDAwMDAwMDAwMDAwMDAwNjQgUjA4OiAwMDAwNTVkY2U3M2ZhMDEw
IFIwOTogMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDE3LjA5ODUyOV0gUjEwOiAwMDAwMDAwMDAwMDAw
MDYzIFIxMTogMDAwMDAwMDAwMDAwMDIwMiBSMTI6IDAwMDA1NWRjZTc0MGIyMDENClsgICAxNy4w
OTg1MjldIFIxMzogMDAwMDAwMDAwMDAwMDAwNSBSMTQ6IDAwMDA3ZmZmYmRkYjc5ZjggUjE1OiAw
MDAwMDAwMDAwMDAwMDYzDQpbICAgMTcuMDk4NTI5XSAtLS1bIGVuZCB0cmFjZSA2YWY2ZjZlYmNj
MzkzN2U4IF0tLS0NCg0KSXQgbG9va3MgdGhlIGFmb3JlbWVudGlvbmVkIHBhdGNoIGNhdXNlcyBh
IG1lbW9yeSBjb3JydXB0aW9uLg0KSWYgSSByZXZlcnQgdGhlIHBhdGNoLCBldmVyeXRoaW5nIHdp
bGwgYmUgYmFjayB0byBub3JtYWwuDQoNClRoYW5rcywNCkRleHVhbg0K
