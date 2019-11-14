Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8232AFCA90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 17:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKNQIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 11:08:23 -0500
Received: from mail-eopbgr800075.outbound.protection.outlook.com ([40.107.80.75]:19215
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbfKNQIW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:08:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2zc3LtToEK+Viv2Y9fxhdPXwr9P1mwBICDUyENdAr6vjGKCrcZjnVx+YQJinCOk29BQo+Ekcs3reCYvaYnaoGea0JeucaGXrxYvWgmz5e6n81WWXxT384tCMbcBefVycIP8Cz3pz0br68x/R00OSEAj40qcQMshA55+3xdewOhyJb2OcZEpJdGOJmYClVlJORXp2hQM3C+RNsfkBNTlLCGUMevetV1tvQuGH/AyG/ND5mjb70/vY8DC9cSPi3eFnri9GmB8W/9WXX1EH50NfWvi5TkRrso5xj6aZibnG/eNgX3sYEUjAE/hKhDhK6R3ebzedEHXiQfyCVo56MY3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6bRkEzzVQcMlASVe4oXu/rgEVRgTu0Au/02upsF3+I=;
 b=QE0Nl36WQWwncmqwzMhvHrY9Uv37ef9lLgfS8AKGev8Zzpt6oXDnFhmjW9hFdDQYmBjunqfmljnn00nKg7Qowi3IYhbCeWLB0AR0U7MJ6cCtefSiAK6MIsyIvURrgKmGVY+mSreIqGRNoATtoZre+aw8q/+wXYbWRGyRKfRD/twNzschBDBUm48eClm0IKAuUD9g2k6FeSxP+cSEiNeOrVh8J5fNr/5k9LUgpAuxcRNI30gDTv0EiIxUu9mJaiIbjE7bQnlBsFMsXsuRQP82UN7Cx0rAwXcQdkoeyw70FXovtJ+9DrNIdQf60SUF2fBE7tS6iM17aAob4FEqgBhKRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6bRkEzzVQcMlASVe4oXu/rgEVRgTu0Au/02upsF3+I=;
 b=nLV7El16pIWBGN0W7OlPSd5+rK7Qp08MQHwp+IvntevlugiHuiFdJLwk18bnwBs563LcScqxCtqqQDvrRL50nBXorShK4FbznSQnB4Y8M+63qgV6MRVC2P53DqKYWfck9K9fof79T0gadssi3URuBL6umILbMT08zQXmOwMuu4Q=
Received: from BYAPR06MB6054.namprd06.prod.outlook.com (20.178.51.220) by
 BYAPR06MB5765.namprd06.prod.outlook.com (20.179.157.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Thu, 14 Nov 2019 16:08:18 +0000
Received: from BYAPR06MB6054.namprd06.prod.outlook.com
 ([fe80::918d:490e:90f0:61f8]) by BYAPR06MB6054.namprd06.prod.outlook.com
 ([fe80::918d:490e:90f0:61f8%5]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 16:08:18 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>,
        "boaz@plexistor.com" <boaz@plexistor.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "Manole, Sagi" <Sagi.Manole@netapp.com>
Subject: Re: [PATCH 11/16] zuf: Write/Read implementation
Thread-Topic: [PATCH 11/16] zuf: Write/Read implementation
Thread-Index: AQHVdA//sJnd28EioU2o/wN+WZnZEadyQRGAgBjThwCAAA67gA==
Date:   Thu, 14 Nov 2019 16:08:18 +0000
Message-ID: <8bcfad422eb582349836544117babf01d3e81a47.camel@netapp.com>
References: <20190926020725.19601-1-boazh@netapp.com>
         <20190926020725.19601-12-boazh@netapp.com>
         <db90d73233484d251755c5a0cb7ee570b3fc9d19.camel@netapp.com>
         <46507231-91ba-0597-94f8-48f00da46077@plexistor.com>
In-Reply-To: <46507231-91ba-0597-94f8-48f00da46077@plexistor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.32.74.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2978ed2d-4fc3-4189-f5bc-08d7691cdd38
x-ms-traffictypediagnostic: BYAPR06MB5765:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR06MB5765935F130BF06F12C6B11EF8710@BYAPR06MB5765.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(2201001)(5660300002)(102836004)(478600001)(71200400001)(6116002)(99286004)(26005)(6506007)(2906002)(53546011)(476003)(3846002)(76176011)(36756003)(2616005)(11346002)(446003)(71190400001)(25786009)(2501003)(66066001)(14454004)(4001150100001)(81156014)(86362001)(66446008)(7736002)(118296001)(66946007)(229853002)(6512007)(8676002)(186003)(486006)(64756008)(256004)(5024004)(14444005)(6486002)(54906003)(58126008)(91956017)(66476007)(76116006)(110136005)(6436002)(4326008)(81166006)(6246003)(305945005)(107886003)(8936002)(66556008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR06MB5765;H:BYAPR06MB6054.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OCkl3+ELfYDHDMrfpy4jrsU0q2nrbLZiyhQfUY6Qfo2HPrhHPqki8tnqB4PdCqFfMRBndeqduHQ94shtPRo7A8GZWBEEt8gUBZoe0XVWxoC83sM/JHRsgKt9wt+7AnAhmH/bzaMP0/phxDmH3dZWyBl3dHf/T8mvXua69s3s+34udz8M7qaruv5EIuPTWGb9tT7UY8sg8juu7PAbmnleusy3zg55TKjnd7fywWb9mpnaZVDRs6NJa+2tkdG2j7jBow3BkGJzx/IstHhsxcq5F0B8X78+2ZxuRPXl1241LHavexfNwwnfHOiujbXLQZh8ofSrHRYtsUi2Pjaf4Borv6j2858z0+o/001P1vDD/OeKEP2tDotOJJCmexSW6QQGtjS4STLfdF4aeewNZoxYzwHnLP8mKCDa5WUTEPn2NRRcgUpR8Y/qlwNEjz5bLE+t
Content-Type: text/plain; charset="utf-8"
Content-ID: <2855C6523AA3014BA6253AA35C8939E4@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2978ed2d-4fc3-4189-f5bc-08d7691cdd38
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 16:08:18.6033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0dFUBl5jmp53Q3mrEzt2xISc8oKg1f6GWBioNSSlNf8VOCn4FXHCvtZ9CPdlPNOrydpq+z0bH5WdLl/lIRs2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5765
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTE0IGF0IDE3OjE1ICswMjAwLCBCb2F6IEhhcnJvc2ggd3JvdGU6DQo+
IE5ldEFwcCBTZWN1cml0eSBXQVJOSU5HOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBEbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3Blbg0KPiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6
ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+
IA0KPiBPbiAyOS8xMC8yMDE5IDIyOjA4LCBTY2h1bWFrZXIsIEFubmEgd3JvdGU6DQo+ID4gSGkg
Qm9heiwNCj4gPiANCj4gPiBPbiBUaHUsIDIwMTktMDktMjYgYXQgMDU6MDcgKzAzMDAsIEJvYXog
SGFycm9zaCB3cm90ZToNCj4gPiA+IHp1ZnMgSGFzIHR3byB3YXlzIHRvIGRvIElPLg0KPiA8Pg0K
PiA+ID4gK3N0YXRpYyBpbnQgcndfb3ZlcmZsb3dfaGFuZGxlcihzdHJ1Y3QgenVmX2Rpc3BhdGNo
X29wICp6ZG8sIHZvaWQgKmFyZywNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1bG9uZyBtYXhfYnl0ZXMpDQo+ID4gPiArew0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgenVmc19p
b2NfSU8gKmlvID0gY29udGFpbmVyX29mKHpkby0+aGRyLCB0eXBlb2YoKmlvKSwgaGRyKTsNCj4g
DQo+IFRoaXMgb25lIGlzIHNldHRpbmcgdGhlIHR5cGVkIHBvaW50ZXIgQGlvIHRvIGJlIHRoZSBz
YW1lIG9mIHdoYXQgQHpkby0+aGRyIGlzDQo+IA0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgenVmc19p
b2NfSU8gKmlvX3VzZXIgPSBhcmc7DQo+ID4gPiArICAgICAgIGludCBlcnI7DQo+ID4gPiArDQo+
ID4gPiArICAgICAgICppbyA9ICppb191c2VyOw0KPiANCj4gVGhpcyBvbmUgaXMgZGVlcCBjb3B5
aW5nIHRoZSBmdWxsIHNpemUgc3RydWN0dXJlIHBvaW50ZWQgdG8gYnkgaW9fdXNlcg0KPiB0byB0
aGUgc3BhY2UgcG9pbnRlZCB0byBieSBpby4gKHNhbWUgYXMgemRvLT5oZHIpDQo+IA0KPiBTYW1l
IGFzIG1lbWNweShpbywgaW9fdXNlciwgc2l6ZW9mKCppbykpDQo+IA0KPiA+IEl0IGxvb2tzIGxp
a2UgeW91J3JlIHNldHRpbmcgKmlvIHVzaW5nIHRoZSBjb250YWluZXJfb2YoKSBtYWNybyBhIGZl
dyBsaW5lcw0KPiA+IGFib3ZlLCBhbmQgdGhlbg0KPiA+IG92ZXJ3cml0aW5nIGl0IGhlcmUgd2l0
aG91dCBldmVyIHVzaW5nIGl0LiBDYW4geW91IHJlbW92ZSBvbmUgb2YgdGhlc2UgdG8NCj4gPiBt
YWtlIGl0IGNsZWFyZXIgd2hpY2gNCj4gPiBvbmUgeW91IG1lYW50IHRvIHVzZT8NCj4gPiANCj4g
DQo+IFRoZXNlIGFyZSBub3QgcmVkdW5kYW50IGl0cyB0aGUgY29uZnVzaW5nIEMgdGhpbmcgd2hl
cmUgZGVjbGFyYXRpb25zDQo+IG9mIHBvaW50ZXJzICsgYXNzaWdubWVudCBtZWFucyB0aGUgcG9p
bnRlciBhbmQgbm90IHRoZSBjb250ZW50Lg0KPiANCj4gVGhpcyBjb2RlIGlzIGNvcnJlY3QNCj4g
DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGVyciA9IF9pb2NfYm91bmRzX2NoZWNrKCZpby0+emlv
bSwgJmlvX3VzZXItPnppb20sIGFyZyArDQo+ID4gPiBtYXhfYnl0ZXMpOw0KPiA+ID4gKyAgICAg
ICBpZiAodW5saWtlbHkoZXJyKSkNCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0K
PiA+ID4gKw0KPiA+ID4gKyAgICAgICBpZiAoKGlvLT5oZHIuZXJyID09IC1FWlVGU19SRVRSWSkg
JiYNCj4gPiA+ICsgICAgICAgICAgIGlvLT56aW9tLmlvbV9uICYmIF96dWZzX2lvbV9wb3AoaW8t
PmlvbV9lKSkgew0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAgICAgIHp1Zl9kYmdfcncoDQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAiWyVzXXp1Zl9pb21fZXhlY3V0ZV9zeW5jKCVk
KSBtYXg9MHglbHggaW9tX2VbJWRdDQo+ID4gPiA9PiAlZFxuIiwNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHp1Zl9vcF9uYW1lKGlvLT5oZHIub3BlcmF0aW9uKSwgaW8tPnppb20uaW9t
X24sDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBtYXhfYnl0ZXMsIF96dWZzX2lvbV9v
cHRfdHlwZShpb191c2VyLT5pb21fZSksDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBp
by0+aGRyLmVycik7DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgICAgaW8tPmhkci5lcnIg
PSB6dWZfaW9tX2V4ZWN1dGVfc3luYyh6ZG8tPnNiLCB6ZG8tPmlub2RlLA0KPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW9fdXNlci0+aW9t
X2UsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpby0+emlvbS5pb21fbik7DQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIEVaVUZf
UkVUUllfRE9ORTsNCj4gPiA+ICsgICAgICAgfQ0KPiANCj4gPD4NCj4gDQo+ID4gPiArc3RhdGlj
IHNzaXplX3QgX0lPX2dtKHN0cnVjdCB6dWZfc2JfaW5mbyAqc2JpLCBzdHJ1Y3QgaW5vZGUgKmlu
b2RlLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHVsb25nICpvbl9zdGFjaywgdWludCBt
YXhfb25fc3RhY2ssDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGlvdl9pdGVy
ICppaSwgc3RydWN0IGtpb2NiICpraW9jYiwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgZmlsZV9yYV9zdGF0ZSAqcmEsIHVpbnQgcncpDQo+ID4gPiArew0KPiA+ID4gKyAgICAg
ICBzc2l6ZV90IHNpemUgPSAwOw0KPiA+ID4gKyAgICAgICBzc2l6ZV90IHJldCA9IDA7DQo+ID4g
PiArICAgICAgIGVudW0gYmlnX2FsbG9jX3R5cGUgYmF0Ow0KPiA+ID4gKyAgICAgICB1bG9uZyAq
Ym5zOw0KPiA+ID4gKyAgICAgICB1aW50IG1heF9ibnMgPSBtaW5fdCh1aW50LA0KPiA+ID4gKyAg
ICAgICAgICAgICAgIG1kX28ycF91cChpb3ZfaXRlcl9jb3VudChpaSkgKyAoa2lvY2ItPmtpX3Bv
cyAmDQo+ID4gPiB+UEFHRV9NQVNLKSksDQo+ID4gPiArICAgICAgICAgICAgICAgWlVTX0FQSV9N
QVBfTUFYX1BBR0VTKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgYm5zID0gYmlnX2FsbG9jKG1h
eF9ibnMgKiBzaXplb2YodWxvbmcpLCBtYXhfb25fc3RhY2ssIG9uX3N0YWNrLA0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgR0ZQX05PRlMsICZiYXQpOw0KPiA+ID4gKyAgICAgICBpZiAo
dW5saWtlbHkoIWJucykpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICB6dWZfZXJyKCJsaWZlIHdh
cyBtb3JlIHNpbXBsZSBvbiB0aGUgc3RhY2sgbWF4X2Jucz0lZFxuIiwNCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIG1heF9ibnMpOw0KPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAt
RU5PTUVNOw0KPiA+ID4gKyAgICAgICB9DQo+ID4gPiArDQo+ID4gPiArICAgICAgIHdoaWxlIChp
b3ZfaXRlcl9jb3VudChpaSkpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICByZXQgPSBfSU9fZ21f
aW5uZXIoc2JpLCBpbm9kZSwgYm5zLCBtYXhfYm5zLCBpaSwgcmEsDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGtpb2NiLT5raV9wb3MsIHJ3KTsNCj4gPiA+ICsgICAg
ICAgICAgICAgICBpZiAodW5saWtlbHkocmV0IDwgMCkpDQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgICAgICAgICBraW9jYi0+a2lf
cG9zICs9IHJldDsNCj4gPiA+ICsgICAgICAgICAgICAgICBzaXplICs9IHJldDsNCj4gPiA+ICsg
ICAgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICBiaWdfZnJlZShibnMsIGJhdCk7DQo+ID4g
PiArDQo+ID4gPiArICAgICAgIHJldHVybiBzaXplID86IHJldDsNCj4gPiANCj4gPiBJdCBsb29r
cyBsaWtlIHlvdSdyZSByZXR1cm5pbmcgInJldCIgaWYgdGhlIHRlcm5hcnkgZXZhbHVhdGVzIHRv
IGZhbHNlLCBidXQNCj4gPiBpdCdzIG5vdCBjbGVhciB0bw0KPiA+IG1lIHdoYXQgaXMgcmV0dXJu
ZWQgaWYgaXQgZXZhbHVhdGVzIHRvIHRydWUuIEl0J3MgcG9zc2libGUgaXQncyBva2F5LCBidXQg
SQ0KPiA+IGp1c3QgZG9uJ3Qga25vdw0KPiA+IGVub3VnaCBhYm91dCBob3cgdGVybmFyaWVzIHdv
cmsgaW4gdGhpcyBjYXNlLg0KPiA+IA0KPiANCj4gWWVzIFRoYW5rcywgV2lsbCBmaXguIE5vdCBz
dXBwb3NlIHRvIHVzZSB0aGlzIGluIHRoZSBLZXJuZWwuDQo+IA0KPiA+ID4gK30NCj4gPiA+ICsN
Cj4gPD4NCj4gPiA+ICtpbnQgenVmX2lvbV9leGVjdXRlX3N5bmMoc3RydWN0IHN1cGVyX2Jsb2Nr
ICpzYiwgc3RydWN0IGlub2RlICppbm9kZSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICBfX3U2NCAqaW9tX2VfdXNlciwgdWludCBpb21fbikNCj4gPiA+ICt7DQo+ID4gPiArICAgICAg
IHN0cnVjdCB6dWZfc2JfaW5mbyAqc2JpID0gU0JJKHNiKTsNCj4gPiA+ICsgICAgICAgc3RydWN0
IHQyX2lvX3N0YXRlIHJkX3RpcyA9IHt9Ow0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgdDJfaW9fc3Rh
dGUgd3JfdGlzID0ge307DQo+ID4gPiArICAgICAgIHN0cnVjdCBfaW9tX2V4ZWNfaW5mbyBpZWkg
PSB7fTsNCj4gPiA+ICsgICAgICAgaW50IGVyciwgZXJyX3IsIGVycl93Ow0KPiA+ID4gKw0KPiA+
ID4gKyAgICAgICB0Ml9pb19iZWdpbihzYmktPm1kLCBSRUFELCBOVUxMLCAwLCAtMSwgJnJkX3Rp
cyk7DQo+ID4gPiArICAgICAgIHQyX2lvX2JlZ2luKHNiaS0+bWQsIFdSSVRFLCBOVUxMLCAwLCAt
MSwgJndyX3Rpcyk7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGllaS5zYiA9IHNiOw0KPiA+ID4g
KyAgICAgICBpZWkuaW5vZGUgPSBpbm9kZTsNCj4gPiA+ICsgICAgICAgaWVpLnJkX3RpcyA9ICZy
ZF90aXM7DQo+ID4gPiArICAgICAgIGllaS53cl90aXMgPSAmd3JfdGlzOw0KPiA+ID4gKyAgICAg
ICBpZWkuaW9tX2UgPSBpb21fZV91c2VyOw0KPiA+ID4gKyAgICAgICBpZWkuaW9tX24gPSBpb21f
bjsNCj4gPiA+ICsgICAgICAgaWVpLnByaW50ID0gMDsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAg
ZXJyID0gX2lvbV9leGVjdXRlX2lubGluZSgmaWVpKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAg
ZXJyX3IgPSB0Ml9pb19lbmQoJnJkX3RpcywgdHJ1ZSk7DQo+ID4gPiArICAgICAgIGVycl93ID0g
dDJfaW9fZW5kKCZ3cl90aXMsIHRydWUpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAvKiBUT0RP
OiBub3Qgc3VyZSBpZiBPSyB3aGVuIF9pb21fZXhlY3V0ZSByZXR1cm4gd2l0aCAtRU5PTUVNDQo+
ID4gPiArICAgICAgICAqIEluIHN1Y2ggYSBjYXNlLCB3ZSBtaWdodCBiZSBiZXR0ZXIgb2Ygc2tp
cGluZyB0Ml9pb19lbmRzLg0KPiA+ID4gKyAgICAgICAgKi8NCj4gPiA+ICsgICAgICAgcmV0dXJu
IGVyciA/OiAoZXJyX3IgPzogZXJyX3cpOw0KPiA+IA0KPiA+IFNhbWUgcXVlc3Rpb24gaGVyZS4N
Cj4gPiANCj4gPiBUaGFua3MsDQo+ID4gQW5uYQ0KPiA+IA0KPiANCj4gWWVzIFdpbGwgZml4DQo+
IA0KPiBUaGFua3MgQW5uYQ0KPiBDYW4gSSBwdXQgUmV2aWV3ZWQtYnkgb24gdGhpcyBwYXRjaD8N
Cg0KR28gZm9yIGl0IQ0KDQo+IA0KPiA+ID4gK30NCj4gDQo+IE11Y2ggb2JsaWdlZA0KPiBCb2F6
DQo=
