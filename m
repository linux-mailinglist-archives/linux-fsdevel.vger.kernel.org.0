Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DE32AE086
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 21:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbgKJUMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 15:12:06 -0500
Received: from mail-bn8nam11on2115.outbound.protection.outlook.com ([40.107.236.115]:34785
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbgKJUMF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:12:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahaZomfyWv25eYKMGhG2fmzqsmK9jOhuYYYEqp+jxUcFouQODRdLK15uF5n59kR/nfYimxkSchU1YwTeQLHOXxlTOchTrtLQW/AnY4RyhyIaKwRNShckL1rwLnwSPxL+16WAU56dsj3pJbL+PLXrMNVJgtpRJlp1Aj28eFbc3AferbFsUAYv2v+eNlGVZWv/PGl+8bXcaYicbcV712Njty+sEkz7PcTAg+Tk4tsZROk2OfuaL9w0d+9Vd2zTCaeEWIUZagmmEpUtzKg3Kje/FhL64PgcAnQVLKm9A8E7oUOUgbGUli0c8yqIgopgGt9cAn2Cls14oDv/g644oh6DwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTBEgqEcRGDqVXlDGVelub0G/ygtKhqGcbkxufaoJRc=;
 b=bs1haGf2Ei0an+wz1c2W+10gCIvUeYSMoPSkATzIpnfcrpJEVqxrCMq53LWEmKRL91Uf5AgPTDMGXuThcZZfK9AXjT0vWkyywFsjygFoks/1XDbgeUZKy1HI1Lz92TsOpPzhAqNJKToIspJ27V9n4Pxz1A7oGCkNntqhQXnp9PTyA1VxgtSUFv2dEFdEhXKs1MDa7WvKSbYUX7Cl00F/f6wfwQl3ckO8QAvRnIX5ddSVcKErUBC4/OOefnTLt7aceq9SZU+gcPWZJetxdkd79E2jwazGbSuRw0twV9zii8pzGFOaPBEgjEd+4XWLkj0UcMirps/65fw9w6u1RAfSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTBEgqEcRGDqVXlDGVelub0G/ygtKhqGcbkxufaoJRc=;
 b=IovmiRjCWewkok8hLgeBVeVXs6UKXeYuuaFWFz0J3vXzznWH/mgawWxakVDlQV01nn+DIL575sq9l28FM0aAEWJ+Jarfqrr/Bntvihu2jhBE5yZEwIXPpqUXpKXkklEZvJB4BlgWLmrxu3newFX/WgWZdg1BYkFPsZAOytgm+U8=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3133.namprd13.prod.outlook.com (2603:10b6:208:137::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13; Tue, 10 Nov
 2020 20:12:02 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Tue, 10 Nov 2020
 20:12:01 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "alban.crequy@gmail.com" <alban.crequy@gmail.com>,
        "sargun@sargun.me" <sargun@sargun.me>
CC:     "mauricio@kinvolk.io" <mauricio@kinvolk.io>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v4 0/2] NFS: Fix interaction between fs_context and user
 namespaces
Thread-Topic: [PATCH v4 0/2] NFS: Fix interaction between fs_context and user
 namespaces
Thread-Index: AQHWsUBG7BgYV56FhkmlUyrWpPNGJ6nBns0AgAA6MAA=
Date:   Tue, 10 Nov 2020 20:12:01 +0000
Message-ID: <f6d86006ccd19d4d101097de309eb21bbbf96e43.camel@hammerspace.com>
References: <20201102174737.2740-1-sargun@sargun.me>
         <CAMXgnP5cVoLKTGPOAO+aLEAGLpkjACy1e4iLBKkfp8Gv1U77xA@mail.gmail.com>
In-Reply-To: <CAMXgnP5cVoLKTGPOAO+aLEAGLpkjACy1e4iLBKkfp8Gv1U77xA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ddcfa0a-338b-4e5f-9513-08d885b4e2dd
x-ms-traffictypediagnostic: MN2PR13MB3133:
x-microsoft-antispam-prvs: <MN2PR13MB3133A49959F70AF3DBCC2AB0B8E90@MN2PR13MB3133.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pcbJHu9NP2WcVIKUUB0tfWLfd8Kw15DJL8doDUVhu2t+i2VQue8IsxSgZevaLXgc5LTgRFC5KnXAR6KUkjZKhSBB3Th99utNGZf3pbeRb2F9Iu1o+SLmpBxy1oHE1DI/WBgD4h0qbgrHnVEtJucE4bWe6HeDHAtYyUy0HPqzjYkVn4QkECjYHMIirQjIxmocgK++cbenOAtv9LycM/34aE+XhdADJfPHcL3nu5oPtmFx3HBcJrsNtX5MkQpRqr/293p+pH9cznSr2pZwC26HJaGqpb/M3KT8wrDiKC7WGFJkxd/PWCqMX9GnlsW2kDGy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(136003)(346002)(396003)(366004)(4001150100001)(71200400001)(186003)(26005)(6506007)(5660300002)(316002)(83380400001)(110136005)(2616005)(54906003)(8676002)(8936002)(7416002)(76116006)(6486002)(36756003)(86362001)(91956017)(66556008)(66476007)(66946007)(66446008)(64756008)(478600001)(6512007)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hTiMKIA0OUmWtjwpvPrBmFOgm6d44XJRcEHiMyvCK4FX6gshWa2a+Y2KpcLQk8QXxqps8FBQnDg2Qz1QhHTYzvWrhI90wokK/Mr0TG0ofpHKh9ny1ZpME5w6iEEbwusX1hWQ6YqUo+fPOEBsZsYp7ghyrkGArBqjtkPGzNxIo481o/KzRamMhfXaJfWyYGoPIaL6CFKHlr/o9pF8WmacDCD+zq++8jR7C86cp4p1uKX/z/IdRYBSh1QBlJzrpJ7ROl1VZwx0rIReeJF5YLuDB5GL1qJABu84Ls/E4N4wkksv9I2OpwJT6oYtPfcBdC4obhFYaDa+jYG0DDrztnSdDD1zmRd5mRrUEFLkBpErx2POaEJGGTY5dq3UFCjjbKZcuSZF/fCqGNI92Cv9g67OS1kQ894Z25zqDYnmjmBhW+baDKSVnsnx17uVdE6HArMcWYjOmRYEBnzs8iYIj3v+ZqBgYbCXXr20WRq7pXuoAU1iOFE7hx2vXB92/7lseW16B3g3ac7Y4XjnPq2S/6m54yEXuYWL6G9gQxt0aANUKsZ62pSjWESsmjCmBGw4QYmqKA8TfmZ4T8m7FgJFAC+GSks4uPcIGzXOJbdlJIixzFk4e3jZLnRYIiN6U+DLYToCDRm9MCouxM2T/spFQreU+g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0978FA741844F5479AB72F7DEB21B473@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddcfa0a-338b-4e5f-9513-08d885b4e2dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 20:12:01.8480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzRWMylFOYj3Pi2OBcOhJLFqrT1i7iDXexe78++dfGyxJsyxVZESiucrTcfzmGKqtG1QjAgKywzzwyyIHgpdcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3133
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTEwIGF0IDE3OjQzICswMTAwLCBBbGJhbiBDcmVxdXkgd3JvdGU6DQo+
IEhpLA0KPiANCj4gSSB0ZXN0ZWQgdGhlIHBhdGNoZXMgb24gdG9wIG9mIDUuMTAuMC1yYzMrIGFu
ZCBJIGNvdWxkIG1vdW50IGFuIE5GUw0KPiBzaGFyZSB3aXRoIGEgZGlmZmVyZW50IHVzZXIgbmFt
ZXNwYWNlLiBmc29wZW4oKSBpcyBkb25lIGluIHRoZQ0KPiBjb250YWluZXIgbmFtZXNwYWNlcyAo
dXNlciwgbW50IGFuZCBuZXQgbmFtZXNwYWNlcykgd2hpbGUgZnNjb25maWcoKSwNCj4gZnNtb3Vu
dCgpIGFuZCBtb3ZlX21vdW50KCkgYXJlIGRvbmUgb24gdGhlIGhvc3QgbmFtZXNwYWNlcy4gVGhl
IG1vdW50DQo+IG9uIHRoZSBob3N0IGlzIGF2YWlsYWJsZSBpbiB0aGUgY29udGFpbmVyIHZpYSBt
b3VudCBwcm9wYWdhdGlvbiBmcm9tDQo+IHRoZSBob3N0IG1vdW50Lg0KPiANCj4gV2l0aCB0aGlz
LCB0aGUgZmlsZXMgb24gdGhlIE5GUyBzZXJ2ZXIgd2l0aCB1aWQgMCBhcmUgYXZhaWxhYmxlIGlu
DQo+IHRoZQ0KPiBjb250YWluZXIgd2l0aCB1aWQgMC4gT24gdGhlIGhvc3QsIHRoZXkgYXJlIGF2
YWlsYWJsZSB3aXRoIHVpZA0KPiA0Mjk0OTY3Mjk0IChtYWtlX2t1aWQoJmluaXRfdXNlcl9ucywg
LTIpKS4NCj4gDQoNCkNhbiBzb21lb25lIHBsZWFzZSB0ZWxsIG1lIHdoYXQgaXMgYnJva2VuIHdp
dGggdGhlIF9jdXJyZW50XyBkZXNpZ24NCmJlZm9yZSB3ZSBzdGFydCB0cnlpbmcgdG8gcHVzaCAi
Zml4ZXMiIHRoYXQgY2xlYXJseSBicmVhayBpdD8NCg0KVGhlIGN1cnJlbnQgZGVzaWduIGFzc3Vt
ZXMgdGhhdCB0aGUgdXNlciBuYW1lc3BhY2UgYmVpbmcgdXNlZCBpcyB0aGUNCm9uZSB3aGVyZSB0
aGUgbW91bnQgaXRzZWxmIGlzIHBlcmZvcm1lZC4gVGhhdCBtZWFucyB0aGF0IHRoZSB1aWRzIGFu
ZA0KZ2lkcyBvciB1c2VybmFtZXMgYW5kIGdyb3VwbmFtZXMgdGhhdCBnbyBvbiB0aGUgd2lyZSBt
YXRjaCB0aGUgdWlkcyBhbmQNCmdpZHMgb2YgdGhlIGNvbnRhaW5lciBpbiB3aGljaCB0aGUgbW91
bnQgb2NjdXJyZWQuDQoNClRoZSBhc3N1bXB0aW9uIGlzIHRoYXQgdGhlIHNlcnZlciBoYXMgYXV0
aGVudGljYXRlZCB0aGF0IGNsaWVudCBhcw0KYmVsb25naW5nIHRvIGEgZG9tYWluIHRoYXQgaXQg
cmVjb2duaXNlcyAoZWl0aGVyIHRocm91Z2ggc3Ryb25nDQpSUENTRUNfR1NTL2tyYjUgYXV0aGVu
dGljYXRpb24sIG9yIHRocm91Z2ggd2Vha2VyIG1hdGNoaW5nIG9mIElQDQphZGRyZXNzZXMgdG8g
YSBsaXN0IG9mIGFjY2VwdGFibGUgY2xpZW50cykuDQoNCklmIHlvdSBnbyBhaGVhZCBhbmQgY2hh
bmdlIHRoZSB1c2VyIG5hbWVzcGFjZSBvbiB0aGUgY2xpZW50IHdpdGhvdXQNCmdvaW5nIHRocm91
Z2ggdGhlIG1vdW50IHByb2Nlc3MgYWdhaW4gdG8gbW91bnQgYSBkaWZmZXJlbnQgc3VwZXIgYmxv
Y2sNCndpdGggYSBkaWZmZXJlbnQgdXNlciBuYW1lc3BhY2UsIHRoZW4geW91IHdpbGwgbm93IGdl
dCB0aGUgZXhhY3Qgc2FtZQ0KYmVoYXZpb3VyIGFzIGlmIHlvdSBkbyB0aGF0IHdpdGggYW55IG90
aGVyIGZpbGVzeXN0ZW0uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
