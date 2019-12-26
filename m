Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8386512ACF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 15:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLZOIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 09:08:36 -0500
Received: from mail-eopbgr750093.outbound.protection.outlook.com ([40.107.75.93]:59532
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbfLZOIg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:08:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eaahrcwea5W7kbiGHhmLfrjNP4oe4VHW5weGqY+jcrRsT/QFalQI3xVJ8ncEQYhKSnLNklFMayXU14QZ4jBLM2M30BvojbDLpZED7Z/o0Z/LUg7FNHnP2tq4gsHCaQZVjLUG9GHEWxySIWpWXTlUeabKDM1ASAliGuAA3CM81Xii6pqE46GaPVZ4X0T57kPnfh5O31CcIUu6lf+2YXFYIxyUqgkwRTLV/04Qwkl/DCDXKiDvSuzdC09TWBa4ZiTzFzsjkPdCveoSLYRLuDikzM4QGUQ5hUS8t2dP9giigTCu06Ohl1TuhymPfYb1ZghWcY/2yxbZQ5lhHZBvwlmtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXE/jF2ikelMs/haymvzpw+aGwStu6YZtATP6PCq5ic=;
 b=ZOt7Mkxba8MJ8tZNfAwljkuPfT/022rCCTHAG9T6CYa5kz6y7sarPQlnO/oJZtkVnhC0R2PqP9/0iJJ2Ik4DcTv47Q6Yi2F0/I91Pcqf3jXBYqsLKFiBIgJoU2hlqGdMUwn6w95dKm7nvC5BnlfJqGmTUSzJ/VEzLNT1WZfkhES7doDtwZTdVkYJ/0JCFJui6JLYac8icvZMB6jtjxaKuOfY/uABAZxbu7h1cBT+yaEDJxegYJkIjuhBM7a/wZcWSlxD5I/lAEXDxCMLqLDL/fYlWQJwAb2TnDqvgGsyMiHZ2XnsT9PpD+jmWRD5XKcOA3y8SfNdb/gMaSQms18dLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXE/jF2ikelMs/haymvzpw+aGwStu6YZtATP6PCq5ic=;
 b=MeYA/lTQOe3kCAIt2Og0Mq42L5lRw7in3Gd9tfcy2ZvTwH7FToeV5FZadiD7Yk6pLLUlIJ3oQjwzk43MDYLNVekzDhOVYED+7g9turpQt7Z/w/txNQqSrdVp1lWqiy3X+oiqi8tSLCqA2fbJ2z+7TPWZKMIOuvg2uOaVCCo9nBA=
Received: from DM6PR22MB1948.namprd22.prod.outlook.com (20.180.21.12) by
 DM6PR22MB1961.namprd22.prod.outlook.com (20.180.20.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 14:08:33 +0000
Received: from DM6PR22MB1948.namprd22.prod.outlook.com
 ([fe80::b18e:67cc:ec6a:c4a1]) by DM6PR22MB1948.namprd22.prod.outlook.com
 ([fe80::b18e:67cc:ec6a:c4a1%6]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 14:08:32 +0000
From:   Yunqiang Su <ysu@wavecomp.com>
To:     Laurent Vivier <laurent@vivier.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: RE: [EXTERNAL]Re: [RFC v2] binfmt_misc: pass binfmt_misc flags to the
 interpreter
Thread-Topic: [EXTERNAL]Re: [RFC v2] binfmt_misc: pass binfmt_misc flags to
 the interpreter
Thread-Index: AQHVs/Ja8mmcR0C670e60gZCQXPtr6fMg6ZQ
Date:   Thu, 26 Dec 2019 14:08:32 +0000
Message-ID: <DM6PR22MB19487D781D665341FA5FF72CDE2B0@DM6PR22MB1948.namprd22.prod.outlook.com>
References: <20191122150830.15855-1-laurent@vivier.eu>
 <45e55b6b-4ee0-0700-e425-2d661de394ed@vivier.eu>
In-Reply-To: <45e55b6b-4ee0-0700-e425-2d661de394ed@vivier.eu>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ysu@wavecomp.com; 
x-originating-ip: [2408:8215:4b38:b450:5c38:3154:c0f4:dbf3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f25bf1-f85e-4194-3e52-08d78a0d1771
x-ms-traffictypediagnostic: DM6PR22MB1961:
x-microsoft-antispam-prvs: <DM6PR22MB1961CC6745D2BB66FF0F2284DE2B0@DM6PR22MB1961.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39830400003)(366004)(396003)(189003)(199004)(13464003)(110136005)(4326008)(33656002)(71200400001)(316002)(54906003)(966005)(9686003)(55016002)(508600001)(76116006)(8936002)(52536014)(81156014)(5660300002)(66446008)(66476007)(2906002)(186003)(81166006)(8676002)(66946007)(64756008)(66556008)(53546011)(6506007)(7696005)(66574012)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR22MB1961;H:DM6PR22MB1948.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XWoKjYFVVRi72A9gj/gyUxin4LJBzetucbu7kTCs+Dglr43KybomdutlOicONgxwnuvEApsGbHIYf9v66LWOL3XC6wkFSBmQ0OZazwueIxBdmCkEgiZFqSCqlLsu03mJfmJ7f0UgqsFobckwWiyneoMfPplYJybqTPxyYJRLRVzn5fhPDoZp2s9V+22TzzLUiRgSpzE8uCTN5tzl7BCy0A6tTN/iWP3WOQ7GXK85uQRrPMCX3yUGIa2/hvxVLjNhorXWafdCs29UeprtUssQanLDIUJa8NfYYMfHrbjCpOnxSsmzZGK+pzbhKnDDeNuwuLpwTXAsWeNf2rVVcTKCwVnD2eN1H1lh/0Th8l+Lej1o02vZKHViGeJ6qAamvAUS8+/UqcTSIYab1WsdJSa21Z5vYOsfbNVjKaCfw9KsRFCWwCOhNIexYSunfgZddxhNz1fXKoHvwJ2mcVQ2guvJpdL0CMEvJa2a26YfSz3xvexoXmO4bnVPvLYxTr3H/36U/bVN63RNAbQlaQw3M4xDNmshWsqK8T+jevtVD7gttcE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f25bf1-f85e-4194-3e52-08d78a0d1771
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 14:08:32.6240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3x32UovymIH1uuBF+rrUb15o7AWA0wZ6fUd4kxU/tSP4+U4oijUYvL5iwoS8akq56V5XB8jgz8uMhR9/xoJ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR22MB1961
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

UGluZy4uLg0KDQpXZSByZWFsbHkgbmVlZCBpdC4gc2luY2UgcWVtdS11c2VyIG1vZGUgaGF2ZSBu
byBvdGhlciBjaG9pY2UgdG8gZ2V0IHRoZSBpbmZvIGFib3V0IHdoZXRoZXIgUCBmbGFnIGlzIHNl
dC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXVyZW50IFZpdmll
ciA8bGF1cmVudEB2aXZpZXIuZXU+DQo+IFNlbnQ6IDIwMTnlubQxMuaciDE25pelIDE3OjIyDQo+
IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1mc2RldmVsQHZn
ZXIua2VybmVsLm9yZzsgQWxleGFuZGVyIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPjsN
Cj4gSmFtZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29t
PjsgWXVucWlhbmcgU3UNCj4gPHlzdUB3YXZlY29tcC5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5B
TF1SZTogW1JGQyB2Ml0gYmluZm10X21pc2M6IHBhc3MgYmluZm10X21pc2MgZmxhZ3MgdG8gdGhl
DQo+IGludGVycHJldGVyDQo+IA0KPiBIaSwNCj4gDQo+IHRoaXMgZmVhdHVyZSBpcyByZWFsbHkg
bmVlZGVkIGFuZCByZXF1ZXN0ZWQgYnkgc2V2ZXJhbCBiaW5mbXRfbWlzYyB1c2Vycy4gSXQgaXMN
Cj4gZGlmZmljdWx0IHRvIG1hbmFnZSB0aGlzIGF0IHVzZXIgbGV2ZWwgd2l0aG91dCB0aGlzIGlu
Zm9ybWF0aW9uLg0KPiANCj4gSSd2ZSBmb3VuZCB0aGF0IHNvbWVvbmUgZWxzZSB0cmllZCB0byBh
ZGRyZXNzIHRoaXMgcHJvYmxlbSBpbiB0aGUgcGFzdCBpbiB0aGUNCj4gc2FtZSB3YXk6DQo+IGh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA5MDI5MzUvDQo+IA0KPiBDYW4gYSBt
YWludGFpbmVyL3Jldmlld2VyIGhhdmUgYSBsb29rIGF0IHRoaXMgYW5kIGFncmVlcyBvciBkaXNh
Z3JlZXM/DQo+IA0KPiBJIHdpbGwgdXBkYXRlIGdldGF1eHZhbCgzKSBtYW51YWwgcGFnZSB3aXRo
IHRoZSBuZXcgZmxhZ3MgaW4gdGhlIGNhc2Ugb25lIG9mDQo+IHRoZXNlIHBhdGNoZXMgaXMgbWVy
Z2VkLg0KPiANCj4gVGhhbmtzLA0KPiBMYXVyZW50DQo+IA0KPiANCj4gTGUgMjIvMTEvMjAxOSDD
oCAxNjowOCwgTGF1cmVudCBWaXZpZXIgYSDDqWNyaXTCoDoNCj4gPiBJdCBjYW4gYmUgdXNlZnVs
IHRvIHRoZSBpbnRlcnByZXRlciB0byBrbm93IHdoaWNoIGZsYWdzIGFyZSBpbiB1c2UuDQo+ID4N
Cj4gPiBGb3IgaW5zdGFuY2UsIGtub3dpbmcgaWYgdGhlIHByZXNlcnZlLWFyZ3ZbMF0gaXMgaW4g
dXNlIHdvdWxkIGFsbG93IHRvDQo+ID4gc2tpcCB0aGUgcGF0aG5hbWUgYXJndW1lbnQuDQo+ID4N
Cj4gPiBUaGlzIHBhdGNoIHVzZXMgYW4gdW51c2VkIGF1eGlsaWFyeSB2ZWN0b3IsIEFUX0ZMQUdT
LCAgdG8gcGFzcyB0aGUNCj4gPiBjb250ZW50IG9mIHRoZSBiaW5mbXQgZmxhZ3MgKHNwZWNpYWwg
ZmxhZ3M6IFAsIEYsIEMsIE8pLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGF1cmVudCBWaXZp
ZXIgPGxhdXJlbnRAdml2aWVyLmV1Pg0KPiA+IC0tLQ0KPiA+DQo+ID4gTm90ZXM6DQo+ID4gICAg
IHYyOiBvbmx5IHBhc3Mgc3BlY2lhbCBmbGFncyAocmVtb3ZlIE1hZ2ljIGFuZCBFbmFibGVkIGZs
YWdzKQ0KPiA+DQo+ID4gIGZzL2JpbmZtdF9lbGYuYyAgICAgICAgIHwgMiArLQ0KPiA+ICBmcy9i
aW5mbXRfZWxmX2ZkcGljLmMgICB8IDIgKy0NCj4gPiAgZnMvYmluZm10X21pc2MuYyAgICAgICAg
fCA2ICsrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L2JpbmZtdHMuaCB8IDIgKy0NCj4gPiAgNCBm
aWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZnMvYmluZm10X2VsZi5jIGIvZnMvYmluZm10X2VsZi5jIGluZGV4DQo+ID4g
YzU2NDJiY2I2YjQ2Li43YTM0YzAzZTU4NTcgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvYmluZm10X2Vs
Zi5jDQo+ID4gKysrIGIvZnMvYmluZm10X2VsZi5jDQo+ID4gQEAgLTI1MCw3ICsyNTAsNyBAQCBj
cmVhdGVfZWxmX3RhYmxlcyhzdHJ1Y3QgbGludXhfYmlucHJtICpicHJtLCBzdHJ1Y3QNCj4gZWxm
aGRyICpleGVjLA0KPiA+ICAJTkVXX0FVWF9FTlQoQVRfUEhFTlQsIHNpemVvZihzdHJ1Y3QgZWxm
X3BoZHIpKTsNCj4gPiAgCU5FV19BVVhfRU5UKEFUX1BITlVNLCBleGVjLT5lX3BobnVtKTsNCj4g
PiAgCU5FV19BVVhfRU5UKEFUX0JBU0UsIGludGVycF9sb2FkX2FkZHIpOw0KPiA+IC0JTkVXX0FV
WF9FTlQoQVRfRkxBR1MsIDApOw0KPiA+ICsJTkVXX0FVWF9FTlQoQVRfRkxBR1MsIGJwcm0tPmZt
dF9mbGFncyk7DQo+ID4gIAlORVdfQVVYX0VOVChBVF9FTlRSWSwgZXhlYy0+ZV9lbnRyeSk7DQo+
ID4gIAlORVdfQVVYX0VOVChBVF9VSUQsIGZyb21fa3VpZF9tdW5nZWQoY3JlZC0+dXNlcl9ucywg
Y3JlZC0+dWlkKSk7DQo+ID4gIAlORVdfQVVYX0VOVChBVF9FVUlELCBmcm9tX2t1aWRfbXVuZ2Vk
KGNyZWQtPnVzZXJfbnMsIGNyZWQtPmV1aWQpKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZnMvYmluZm10
X2VsZl9mZHBpYy5jIGIvZnMvYmluZm10X2VsZl9mZHBpYy5jIGluZGV4DQo+ID4gZDg2ZWJkMGRj
YzNkLi44ZmU4MzliZTEyNWUgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvYmluZm10X2VsZl9mZHBpYy5j
DQo+ID4gKysrIGIvZnMvYmluZm10X2VsZl9mZHBpYy5jDQo+ID4gQEAgLTY0Nyw3ICs2NDcsNyBA
QCBzdGF0aWMgaW50IGNyZWF0ZV9lbGZfZmRwaWNfdGFibGVzKHN0cnVjdCBsaW51eF9iaW5wcm0N
Cj4gKmJwcm0sDQo+ID4gIAlORVdfQVVYX0VOVChBVF9QSEVOVCwJc2l6ZW9mKHN0cnVjdCBlbGZf
cGhkcikpOw0KPiA+ICAJTkVXX0FVWF9FTlQoQVRfUEhOVU0sCWV4ZWNfcGFyYW1zLT5oZHIuZV9w
aG51bSk7DQo+ID4gIAlORVdfQVVYX0VOVChBVF9CQVNFLAlpbnRlcnBfcGFyYW1zLT5lbGZoZHJf
YWRkcik7DQo+ID4gLQlORVdfQVVYX0VOVChBVF9GTEFHUywJMCk7DQo+ID4gKwlORVdfQVVYX0VO
VChBVF9GTEFHUywJYnBybS0+Zm10X2ZsYWdzKTsNCj4gPiAgCU5FV19BVVhfRU5UKEFUX0VOVFJZ
LAlleGVjX3BhcmFtcy0+ZW50cnlfYWRkcik7DQo+ID4gIAlORVdfQVVYX0VOVChBVF9VSUQsCShl
bGZfYWRkcl90KSBmcm9tX2t1aWRfbXVuZ2VkKGNyZWQtPnVzZXJfbnMsDQo+IGNyZWQtPnVpZCkp
Ow0KPiA+ICAJTkVXX0FVWF9FTlQoQVRfRVVJRCwJKGVsZl9hZGRyX3QpDQo+IGZyb21fa3VpZF9t
dW5nZWQoY3JlZC0+dXNlcl9ucywgY3JlZC0+ZXVpZCkpOw0KPiA+IGRpZmYgLS1naXQgYS9mcy9i
aW5mbXRfbWlzYy5jIGIvZnMvYmluZm10X21pc2MuYyBpbmRleA0KPiA+IGNkYjQ1ODI5MzU0ZC4u
MjVhMzkyZjIzNDA5IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2JpbmZtdF9taXNjLmMNCj4gPiArKysg
Yi9mcy9iaW5mbXRfbWlzYy5jDQo+ID4gQEAgLTQ4LDYgKzQ4LDkgQEAgZW51bSB7RW5hYmxlZCwg
TWFnaWN9OyAgI2RlZmluZQ0KPiBNSVNDX0ZNVF9PUEVOX0JJTkFSWQ0KPiA+ICgxIDw8IDMwKSAg
I2RlZmluZSBNSVNDX0ZNVF9DUkVERU5USUFMUyAoMSA8PCAyOSkgICNkZWZpbmUNCj4gPiBNSVND
X0ZNVF9PUEVOX0ZJTEUgKDEgPDwgMjgpDQo+ID4gKyNkZWZpbmUgTUlTQ19GTVRfRkxBR1NfTUFT
SyAoTUlTQ19GTVRfUFJFU0VSVkVfQVJHVjAgfA0KPiBNSVNDX0ZNVF9PUEVOX0JJTkFSWSB8IFwN
Cj4gPiArCQkJICAgICBNSVNDX0ZNVF9DUkVERU5USUFMUyB8IE1JU0NfRk1UX09QRU5fRklMRSkN
Cj4gPiArDQo+ID4NCj4gPiAgdHlwZWRlZiBzdHJ1Y3Qgew0KPiA+ICAJc3RydWN0IGxpc3RfaGVh
ZCBsaXN0Ow0KPiA+IEBAIC0xNDksNiArMTUyLDkgQEAgc3RhdGljIGludCBsb2FkX21pc2NfYmlu
YXJ5KHN0cnVjdCBsaW51eF9iaW5wcm0NCj4gKmJwcm0pDQo+ID4gIAlpZiAoIWZtdCkNCj4gPiAg
CQlyZXR1cm4gcmV0dmFsOw0KPiA+DQo+ID4gKwkvKiBwYXNzIHNwZWNpYWwgZmxhZ3MgdG8gdGhl
IGludGVycHJldGVyICovDQo+ID4gKwlicHJtLT5mbXRfZmxhZ3MgPSBmbXQtPmZsYWdzICYgTUlT
Q19GTVRfRkxBR1NfTUFTSzsNCj4gPiArDQo+ID4gIAkvKiBOZWVkIHRvIGJlIGFibGUgdG8gbG9h
ZCB0aGUgZmlsZSBhZnRlciBleGVjICovDQo+ID4gIAlyZXR2YWwgPSAtRU5PRU5UOw0KPiA+ICAJ
aWYgKGJwcm0tPmludGVycF9mbGFncyAmIEJJTlBSTV9GTEFHU19QQVRIX0lOQUNDRVNTSUJMRSkg
ZGlmZiAtLWdpdA0KPiA+IGEvaW5jbHVkZS9saW51eC9iaW5mbXRzLmggYi9pbmNsdWRlL2xpbnV4
L2JpbmZtdHMuaCBpbmRleA0KPiA+IGI0MGZjNjMzZjNiZS4uZGFlMGQwZDdiODRkIDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYmluZm10cy5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51
eC9iaW5mbXRzLmgNCj4gPiBAQCAtNjAsNyArNjAsNyBAQCBzdHJ1Y3QgbGludXhfYmlucHJtIHsN
Cj4gPiAgCQkJCSAgIGRpZmZlcmVudCBmb3IgYmluZm10X3ttaXNjLHNjcmlwdH0gKi8NCj4gPiAg
CXVuc2lnbmVkIGludGVycF9mbGFnczsNCj4gPiAgCXVuc2lnbmVkIGludGVycF9kYXRhOw0KPiA+
IC0JdW5zaWduZWQgbG9uZyBsb2FkZXIsIGV4ZWM7DQo+ID4gKwl1bnNpZ25lZCBsb25nIGxvYWRl
ciwgZXhlYywgZm10X2ZsYWdzOw0KPiA+DQo+ID4gIAlzdHJ1Y3QgcmxpbWl0IHJsaW1fc3RhY2s7
IC8qIFNhdmVkIFJMSU1JVF9TVEFDSyB1c2VkIGR1cmluZyBleGVjLiAqLw0KPiA+DQo+ID4NCg0K
