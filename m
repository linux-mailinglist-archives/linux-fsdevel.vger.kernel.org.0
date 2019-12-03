Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE771111E4C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 00:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfLCXAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 18:00:33 -0500
Received: from mail-eopbgr730090.outbound.protection.outlook.com ([40.107.73.90]:30910
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730588AbfLCXAc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 18:00:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcKGefL1CRTCnbwYscekyYDPp/5d9/nN+98hQ8nFXwL753KEP6HkLH2ATJtAFgQqBf+8nHnEh/2FhEDzqp3xhSwd8FBaf0bNMjnSOz0o3rlLWRwT6rASF3FHfi3m+hz/SQYV0jr36OFjQr27AxW7QfBWl8X2o3QflzcMnKOePXTtRwN1FrV6WbQiaiaM7jTsxFgE8eLmVq2+o9afj1Bq1AX5WDzFKt6fwmLk5F/cHUJ+JK5QLYgmtBRDL5pSJsnVTBQIdzuGYhtC9PMtd5pL7mhuZECEIT8+mSbC747ai+GyDl2OnOe2y0jbLAxze8txPKCDfBlCDWlhs0pAJJBxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxXyst3VbIitgF/A+itbtsXYaHiezDhfmIUJH1yCPzY=;
 b=AClYQtmTGAQHneF+dznC/3TG+QzCz4tEOCw2R4sqSqRIFUzs+gJaa75pPSUDrGUmKlCIETfYtEMHREcFUfI2UcVp52B6YB5rQ4ztdUx88Sy/3Flblsf0RcR/IZSqqmOtuQu8DE72CTEts43p0wO052UM8LI2JP7bpA6DUd4VkiuJOft408MVaLZ2FkJL+XVYazhoM57JuXpvEN7GCjNpSavYwAwzykUerz+RngZ56HsE4MK9SYlIcoMWqaPUOQaMXECWRsMow2QAGucia3eJg4FY0Px7zXpHDuDP7gKY7fCkzUYU/pkGb0977EEc6S1q3h+o7m8rQfNsOlmPykO4GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxXyst3VbIitgF/A+itbtsXYaHiezDhfmIUJH1yCPzY=;
 b=f1D3A5s670ImuvLA8T5t+Qe+2Hqs1XVhbD1svQt3C6YOcw3Xeoqk6CyUMISrrY+Ky3R+IfM5GoNr2XXf0iJyaEpEE5TRYn1T42fiyTRiJX4UxyhLkcTJhXqnCOKFoFLtbNNJ1brQkFwkhBNh+tBFm0Z9mReN13/9/8t9dTkckBQ=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2059.namprd13.prod.outlook.com (10.174.186.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.4; Tue, 3 Dec 2019 23:00:26 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 23:00:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Question about clone_range() metadata stability
Thread-Topic: Question about clone_range() metadata stability
Thread-Index: AQHVpVHnjYPZ0FhJIUe2yp+YUANojKefdeQAgAZVi4CAAkKrgIAAlpcAgABrjYA=
Date:   Tue, 3 Dec 2019 23:00:26 +0000
Message-ID: <5bef0bc533c3ab768538a58e3ae7fb9ad26a5d83.camel@hammerspace.com>
References: <f063089fb62c219ea6453c7b9b0aaafd50946dae.camel@hammerspace.com>
         <20191127202136.GV6211@magnolia>
         <20191201210519.GB2418@dread.disaster.area>
         <52f1afb6e0a2026840da6f4b98a5e01a247447e5.camel@hammerspace.com>
         <20191203163526.GD7323@magnolia>
In-Reply-To: <20191203163526.GD7323@magnolia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [88.95.63.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c38f2b44-f88e-4473-92a1-08d77844960a
x-ms-traffictypediagnostic: DM5PR1301MB2059:
x-microsoft-antispam-prvs: <DM5PR1301MB20597920A0ED2B1DE752C292B8420@DM5PR1301MB2059.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(366004)(39840400004)(376002)(51914003)(53754006)(189003)(199004)(7736002)(316002)(11346002)(446003)(2616005)(8676002)(81166006)(81156014)(86362001)(25786009)(6486002)(229853002)(6916009)(71190400001)(71200400001)(5660300002)(99286004)(2906002)(54906003)(118296001)(305945005)(2501003)(66446008)(102836004)(6436002)(5640700003)(186003)(256004)(14444005)(4326008)(6506007)(26005)(8936002)(6512007)(66946007)(76116006)(91956017)(2351001)(64756008)(66476007)(6246003)(508600001)(66556008)(36756003)(14454004)(76176011)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2059;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNRlk3PWoux96Mt1awgcsuAZjiGWQ9Nbj1uH8JTkZoz0mC2Iz3SMrTOAvIgveUSvzaCnaGk8eeyZgFkib/YX6yCxApdW20+XUPrl7zM2W4MGmqUHdZ1DeaI6/pbVbEtxsJm9kwqx9NktWa7KxlNVeqZ/B50pImJdMUnaDcAfgCuEHsaDFtT8mC5KsAWxfmif6yqAinG0hSkYv4SjqpPFKou5vXi4GaG32pUElNkoVg9+JlDUpNcRiP8flykk1uW3T3oxlQbl9ICrTvnxdqJd3Z46LYGW1oIyJJFyvHh6qlotmowSGBtXIPtR/zl06+EzS2EVWK44P6Wwl453pAPuhLIQWNtfuOmFQBRfnebPUm+IPsGwzQN6lMtxnXXerCe9V/Wmm7YDCXvv2+Zb6VXsfL/Q5Ye3gmD8KvmqbMobHeeJz+6V9JPMr0Crqrzyn6++
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E21E3B831CFD54BA78E80EC1ABC0106@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38f2b44-f88e-4473-92a1-08d77844960a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 23:00:26.4240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzDehDofkjRXfpU1i3f1CLYjsoOX+27aPdKOlYaxXQ2DLchY+ZqlZUEPHxYiZyeemURBPlFVuQHoT8aG3/YJIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2059
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTAzIGF0IDA4OjM1IC0wODAwLCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6
DQo+IE9uIFR1ZSwgRGVjIDAzLCAyMDE5IGF0IDA3OjM2OjI5QU0gKzAwMDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBPbiBNb24sIDIwMTktMTItMDIgYXQgMDg6MDUgKzExMDAsIERhdmUg
Q2hpbm5lciB3cm90ZToNCj4gPiA+IE9uIFdlZCwgTm92IDI3LCAyMDE5IGF0IDEyOjIxOjM2UE0g
LTA4MDAsIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCBOb3YgMjcsIDIw
MTkgYXQgMDY6Mzg6NDZQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0DQo+ID4gPiA+IHdyb3RlOg0K
PiA+ID4gPiA+IEhpIGFsbA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEEgcXVpY2sgcXVlc3Rpb24g
YWJvdXQgY2xvbmVfcmFuZ2UoKSBhbmQgZ3VhcmFudGVlcyBhcm91bmQNCj4gPiA+ID4gPiBtZXRh
ZGF0YQ0KPiA+ID4gPiA+IHN0YWJpbGl0eS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBcmUgdXNl
cnMgcmVxdWlyZWQgdG8gY2FsbCBmc3luYy9mc3luY19yYW5nZSgpIGFmdGVyIGNhbGxpbmcNCj4g
PiA+ID4gPiBjbG9uZV9yYW5nZSgpIGluIG9yZGVyIHRvIGd1YXJhbnRlZSB0aGF0IHRoZSBjbG9u
ZWQgcmFuZ2UNCj4gPiA+ID4gPiBtZXRhZGF0YSBpcw0KPiA+ID4gPiA+IHBlcnNpc3RlZD8NCj4g
PiA+ID4gDQo+ID4gPiA+IFllcy4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gSSdtIGFzc3VtaW5nIHRo
YXQgaXQgaXMgcmVxdWlyZWQgaW4gb3JkZXIgdG8gZ3VhcmFudGVlIHRoYXQNCj4gPiA+ID4gPiBk
YXRhIGlzIHBlcnNpc3RlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IERhdGEgYW5kIG1ldGFkYXRhLiAg
WEZTIGFuZCBvY2ZzMidzIHJlZmxpbmsgaW1wbGVtZW50YXRpb25zDQo+ID4gPiA+IHdpbGwNCj4g
PiA+ID4gZmx1c2gNCj4gPiA+ID4gdGhlIHBhZ2UgY2FjaGUgYmVmb3JlIHN0YXJ0aW5nIHRoZSBy
ZW1hcCwgYnV0IHRoZXkgYm90aCByZXF1aXJlDQo+ID4gPiA+IGZzeW5jIHRvDQo+ID4gPiA+IGZv
cmNlIHRoZSBsb2cvam91cm5hbCB0byBkaXNrLg0KPiA+ID4gDQo+ID4gPiBTbyB3ZSBuZWVkIHRv
IGNhbGwgeGZzX2ZzX25mc19jb21taXRfbWV0YWRhdGEoKSB0byBnZXQgdGhhdCBkb25lDQo+ID4g
PiBwb3N0IHZmc19jbG9uZV9maWxlX3JhbmdlKCkgY29tcGxldGlvbiBvbiB0aGUgc2VydmVyIHNp
ZGUsIHllcz8NCj4gPiA+IA0KPiA+IA0KPiA+IEkgY2hvc2UgdG8gaW1wbGVtZW50IHRoaXMgdXNp
bmcgYSBmdWxsIGNhbGwgdG8gdmZzX2ZzeW5jX3JhbmdlKCksDQo+ID4gc2luY2UNCj4gPiB3ZSBy
ZWFsbHkgZG8gd2FudCB0byBlbnN1cmUgZGF0YSBzdGFiaWxpdHkgYXMgd2VsbC4gQ29uc2lkZXIs
IGZvcg0KPiA+IGluc3RhbmNlLCB0aGUgY2FzZSB3aGVyZSBjbGllbnQgQSBpcyBydW5uaW5nIGFu
IGFwcGxpY2F0aW9uLCBhbmQNCj4gPiBjbGllbnQNCj4gPiBCIHJ1bnMgdmZzX2Nsb25lX2ZpbGVf
cmFuZ2UoKSBpbiBvcmRlciB0byBjcmVhdGUgYSBwb2ludCBpbiB0aW1lDQo+ID4gc25hcHNob3Qg
b2YgdGhlIGZpbGUgZm9yIGRpc2FzdGVyIHJlY292ZXJ5IHB1cnBvc2VzLi4uDQo+IA0KPiBTZWVt
cyByZWFzb25hYmxlLCBzaW5jZSAoYWxhcykgd2UgZGlkbid0IGRlZmluZSB0aGUgLT5yZW1hcF9y
YW5nZSBhcGkNCj4gdG8NCj4gZ3VhcmFudGVlIHRoYXQgZm9yIHlvdS4NCj4gDQo+ID4gPiA+IChB
RkFJQ1QgdGhlIHNhbWUgcmVhc29uaW5nIGFwcGxpZXMgdG8gYnRyZnMsIGJ1dCBkb24ndCB0cnVz
dCBteQ0KPiA+ID4gPiB3b3JkIGZvcg0KPiA+ID4gPiBpdC4pDQo+ID4gPiA+IA0KPiA+ID4gPiA+
IEknbSBhc2tpbmcgYmVjYXVzZSBrbmZzZCBjdXJyZW50bHkganVzdCBkb2VzIGEgY2FsbCB0bw0K
PiA+ID4gPiA+IHZmc19jbG9uZV9maWxlX3JhbmdlKCkgd2hlbiBwYXJzaW5nIGEgTkZTdjQuMiBD
TE9ORQ0KPiA+ID4gPiA+IG9wZXJhdGlvbi4gSXQNCj4gPiA+ID4gPiBkb2VzDQo+ID4gPiA+ID4g
bm90IGNhbGwgZnN5bmMoKS9mc3luY19yYW5nZSgpIG9uIHRoZSBkZXN0aW5hdGlvbiBmaWxlLCBh
bmQNCj4gPiA+ID4gPiBzaW5jZQ0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IE5GU3Y0LjIgcHJv
dG9jb2wgZG9lcyBub3QgcmVxdWlyZSB5b3UgdG8gcGVyZm9ybSBhbnkgb3RoZXINCj4gPiA+ID4g
PiBvcGVyYXRpb24gaW4NCj4gPiA+ID4gPiBvcmRlciB0byBwZXJzaXN0IGRhdGEvbWV0YWRhdGEs
IEknbSB3b3JyaWVkIHRoYXQgd2UgbWF5IGJlDQo+ID4gPiA+ID4gY29ycnVwdGluZw0KPiA+ID4g
PiA+IHRoZSBjbG9uZWQgZmlsZSBpZiB0aGUgTkZTIHNlcnZlciBjcmFzaGVzIGF0IHRoZSB3cm9u
ZyBtb21lbnQNCj4gPiA+ID4gPiBhZnRlciB0aGUNCj4gPiA+ID4gPiBjbGllbnQgaGFzIGJlZW4g
dG9sZCB0aGUgY2xvbmUgY29tcGxldGVkLg0KPiA+ID4gDQo+ID4gPiBZdXAsIHRoYXQncyBleGFj
dGx5IHdoYXQgc2VydmVyIHNpZGUgY2FsbHMgdG8gY29tbWl0X21ldGFkYXRhKCkNCj4gPiA+IGFy
ZQ0KPiA+ID4gc3VwcG9zZWQgdG8gYWRkcmVzcy4NCj4gPiA+IA0KPiA+ID4gSSBzdXNwZWN0IHRv
IGJlIGNvcnJlY3QsIHRoaXMgbWlnaHQgcmVxdWlyZSBjb21taXRfbWV0YWRhdGEoKSB0bw0KPiA+
ID4gYmUNCj4gPiA+IGNhbGxlZCBvbiBib3RoIHRoZSBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIGlu
b2RlcywgYXMgYm90aCBvZiB0aGVtDQo+ID4gPiBtYXkgaGF2ZSBtb2RpZmllZCBtZXRhZGF0YSBh
cyBhIHJlc3VsdCBvZiB0aGUgY2xvbmUgb3BlcmF0aW9uLg0KPiA+ID4gRm9yDQo+ID4gPiBYRlMg
b25lIG9mIHRoZW0gd2lsbCBiZSBhIG5vLW9wLCBidXQgZm9yIG90aGVyIGZpbGVzeXN0ZW1zIHRo
YXQNCj4gPiA+IGRvbid0IGltcGxlbWVudCAtPmNvbW1pdF9tZXRhZGF0YSwgd2UnbGwgbmVlZCB0
byBjYWxsDQo+ID4gPiBzeW5jX2lub2RlX21ldGFkYXRhKCkgb24gYm90aCBpbm9kZXMuLi4NCj4g
PiA+IA0KPiA+IA0KPiA+IFRoYXQncyBpbnRlcmVzdGluZy4gSSBoYWRuJ3QgY29uc2lkZXJlZCB0
aGF0IGEgY2xvbmUgbWlnaHQgY2F1c2UNCj4gPiB0aGUNCj4gPiBzb3VyY2UgbWV0YWRhdGEgdG8g
Y2hhbmdlIGFzIHdlbGwuIFdoYXQga2luZCBvZiBjaGFuZ2Ugc3BlY2lmaWNhbGx5DQo+ID4gYXJl
DQo+ID4gd2UgdGFsa2luZyBhYm91dD8gSXMgaXQganVzdCBkZWxheWVkIGJsb2NrIGFsbG9jYXRp
b24sIG9yIGlzIHRoZXJlDQo+ID4gbW9yZT8NCj4gDQo+IEluIFhGUycgY2FzZSwgd2UgYWRkZWQg
YSBwZXItaW5vZGUgZmxhZyB0byBoZWxwIHVzIGJ5cGFzcyB0aGUNCj4gcmVmZXJlbmNlDQo+IGNv
dW50IGxvb2t1cCBkdXJpbmcgYSB3cml0ZSBpZiB0aGUgZmlsZSBoYXMgbmV2ZXIgc2hhcmVkIGFu
eSBibG9ja3MsDQo+IHNvDQo+IGlmIHlvdSBuZXZlciBzaGFyZSBhbnl0aGluZywgeW91J2xsIG5l
dmVyIHBheSBhbnkgb2YgdGhlIHJ1bnRpbWUNCj4gY29zdHMNCj4gb2YgdGhlIENPVyBtZWNoYW5p
c20uDQo+IA0KPiBvY2ZzMidzIGRlc2lnbiBoYXMgYSByZWZlcmVuY2UgY291bnQgdHJlZSB0aGF0
IGlzIHNoYXJlZCBiZXR3ZWVuDQo+IGdyb3Vwcw0KPiBvZiBmaWxlcyB0aGF0IGhhdmUgYmVlbiBy
ZWZsaW5rZWQgZnJvbSBlYWNoIG90aGVyLiAgU28gaWYgeW91IHN0YXJ0DQo+IHdpdGgNCj4gdW5z
aGFyZWQgZmlsZXMgQSBhbmQgQiBhbmQgY2xvbmUgQSB0byBBMSBhbmQgQTI7IGFuZCBCIHRvIEIx
IGFuZCBCMiwNCj4gdGhlbiBBKiB3aWxsIGhhdmUgdGhlaXIgb3duIHJlZmNvdW50IHRyZWUgYW5k
IEIqIHdpbGwgYWxzbyBoYXZlIHRoZWlyDQo+IG93biByZWZjb3VudCB0cmVlLg0KPiANCj4gRWl0
aGVyIHdheSwgbmZzIGhhcyB0byBhc3N1bWUgdGhhdCBjaGFuZ2VzIGNvdWxkIGhhdmUgYmVlbiBt
YWRlIHRvDQo+IHRoZQ0KPiBzb3VyY2UgZmlsZS4NCg0KSW50ZXJlc3RpbmcuIFRoYW5rcyBmb3Ig
dGhlIGV4cGxhbmF0aW9uISBJJ2xsIHRyeSB0byBzZW5kIG9mZiBhbg0KYW1lbmRlZCBwYXRjaCB0
byBCcnVjZSAoaG9wZWZ1bGx5IGJlZm9yZSBoZSBtZXJnZXMpLg0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
