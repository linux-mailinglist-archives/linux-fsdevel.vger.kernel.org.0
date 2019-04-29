Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418C1DA47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 02:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfD2A5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Apr 2019 20:57:52 -0400
Received: from mail-eopbgr740091.outbound.protection.outlook.com ([40.107.74.91]:14256
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbfD2A5w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Apr 2019 20:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7f3n13E8yguE7Bwzru7hydhPpa9jK9yJKfJ4GVCMaM=;
 b=bsTYme28G5STarc6x4SUSQhySsxrgi6iJtPysCCT7UykNsfAjVHjDIQQzlekbz6cxs9UZZcK7yYiQlTmjBvlT81b5mTsqYM2sLvIxxUradDmtbHeOFEsaLIkYgs6j6MveE9nz5upYpf9UKFyYGzbIpSbrOahJMN0vIXVnspW/u4=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2528.namprd13.prod.outlook.com (52.135.95.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.6; Mon, 29 Apr 2019 00:57:43 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511%7]) with mapi id 15.20.1856.008; Mon, 29 Apr 2019
 00:57:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "amir73il@gmail.com" <amir73il@gmail.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "Volker.Lendecke@sernet.de" <Volker.Lendecke@sernet.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "pshilov@microsoft.com" <pshilov@microsoft.com>
Subject: Re: Better interop for NFS/SMB file share mode/reservation
Thread-Topic: Better interop for NFS/SMB file share mode/reservation
Thread-Index: AQHUv6BUED9wy3m1tE24F/mnamgiLqXV4DAAgAAaggCAABW6AIB63KrUgAEKN4CAABrTAIAAFnQAgABzxACAAAJMgIAABwQAgAAoLQA=
Date:   Mon, 29 Apr 2019 00:57:42 +0000
Message-ID: <b4ee6b6f5544114c3974790a784c3e784e617ccf.camel@hammerspace.com>
References: <CAOQ4uxjQdLrZXkpP30Pq_=Cckcb=mADrEwQUXmsG92r-gn2y5w@mail.gmail.com>
         <379106947f859bdf5db4c6f9c4ab8c44f7423c08.camel@kernel.org>
         <CAOQ4uxgewN=j3ju5MSowEvwhK1HqKG3n1hBRUQTi1W5asaO1dQ@mail.gmail.com>
         <930108f76b89c93b2f1847003d9e060f09ba1a17.camel@kernel.org>
         <CAOQ4uxgQsRaEOxz1aYzP1_1fzRpQbOm2-wuzG=ABAphPB=7Mxg@mail.gmail.com>
         <20190426140023.GB25827@fieldses.org>
         <CAOQ4uxhuxoEsoBbvenJ8eLGstPc4AH-msrxDC-tBFRhvDxRSNg@mail.gmail.com>
         <20190426145006.GD25827@fieldses.org>
         <e69d149c80187b84833fec369ad8a51247871f26.camel@kernel.org>
         <CAOQ4uxjt+MkufaJWoqWSYZbejWa1nJEe8YYRroEBSb1jHjzkwQ@mail.gmail.com>
         <8504a05f2b0462986b3a323aec83a5b97aae0a03.camel@kernel.org>
         <CAOQ4uxi6fQdp_RQKHp-i6Q-m-G1+384_DafF3QzYcUq4guLd6w@mail.gmail.com>
         <1d5265510116ece75d6eb7af6314e6709e551c6e.camel@hammerspace.com>
         <CAOQ4uxjUBRt99efZMY8EV6SAH+9eyf6t82uQuKWHQ56yjpjqMw@mail.gmail.com>
         <95bc6ace0f46a1b1a38de9b536ce74faaa460182.camel@hammerspace.com>
         <CAOQ4uxhQOLZ_Hyrnvu56iERPZ7CwfKti2U+OgyaXjM9acCN2LQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhQOLZ_Hyrnvu56iERPZ7CwfKti2U+OgyaXjM9acCN2LQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0f88b2b-f21f-4c72-484e-08d6cc3daf92
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN6PR13MB2528;
x-ms-traffictypediagnostic: SN6PR13MB2528:
x-microsoft-antispam-prvs: <SN6PR13MB252817659D4BA1579365C965B8390@SN6PR13MB2528.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(346002)(199004)(189003)(229853002)(66556008)(66946007)(26005)(91956017)(76116006)(4326008)(66476007)(508600001)(2501003)(102836004)(6512007)(76176011)(7736002)(14454004)(66446008)(8676002)(256004)(53936002)(2906002)(186003)(68736007)(64756008)(73956011)(118296001)(5660300002)(6116002)(53546011)(3846002)(6246003)(305945005)(6506007)(561944003)(97736004)(81166006)(81156014)(8936002)(1361003)(54906003)(486006)(5640700003)(71190400001)(71200400001)(66066001)(476003)(86362001)(14444005)(25786009)(2351001)(93886005)(36756003)(6916009)(6486002)(1411001)(6436002)(99286004)(2616005)(446003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2528;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mGgqUa5YVQ/cxdY4ZeD4v/ShhaR5Lni2TStKPg3OlLv4VJMH1CDC/fU19Iik7yu8Sq6Rr5fN0uFr0tR+194lUccs7hOxypyZiDfTvp21L68qWUZBSY/uT6o5bZbxGoaVGGHX5cjc7GEOK4r4neB0bCqQOp+u2DH47yv1bDHnzk8njq6yr47z0lS6PyK6IB1Lv6cBomiDnZaT7v5wjmJEJ7dLAjPSwf7bMIw9fEc/YvtHRxRavNDISUAJAQ7xO1lV8BZ1XZc4ZBR3UzOsJYMnqp22vsRqK55IlGHmez3r7o7+likH7/NdNxHBenx94hY9jNWxvKNCINo/b34O6xvhXjvUOG5X5AYl3O01qdGpBtD9ckJgLd+KWhBYtJgQnfZFFlTbCXZYAezdMhPT96T/WtUG4bvfBgLevcG8MokHmUo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4312FFDF264E34F9DB7A7C8AB6AA0E2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f88b2b-f21f-4c72-484e-08d6cc3daf92
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 00:57:42.7916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2528
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gU3VuLCAyMDE5LTA0LTI4IGF0IDE4OjMzIC0wNDAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gT24gU3VuLCBBcHIgMjgsIDIwMTkgYXQgNjowOCBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0KPiB0
cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gT24gU3VuLCAyMDE5LTA0LTI4IGF0
IDE4OjAwIC0wNDAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4gPiA+IE9uIFN1biwgQXByIDI4
LCAyMDE5IGF0IDExOjA2IEFNIFRyb25kIE15a2xlYnVzdA0KPiA+ID4gPHRyb25kbXlAaGFtbWVy
c3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4gT24gU3VuLCAyMDE5LTA0LTI4IGF0IDA5OjQ1IC0w
NDAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4gPiA+ID4gPiBPbiBTdW4sIEFwciAyOCwgMjAx
OSBhdCA4OjA5IEFNIEplZmYgTGF5dG9uIDwNCj4gPiA+ID4gPiBqbGF5dG9uQGtlcm5lbC5vcmc+
DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBTYXQsIDIwMTktMDQtMjcgYXQgMTY6
MTYgLTA0MDAsIEFtaXIgR29sZHN0ZWluIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBbYWRkaW5nIGJh
Y2sgc2FtYmEvbmZzIGFuZCBmc2RldmVsXQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gY2MnaW5nIFBhdmVsIHRvbyAtLSBoZSBkaWQgYSBidW5jaCBvZiB3b3JrIGlu
IHRoaXMgYXJlYSBhDQo+ID4gPiA+ID4gPiBmZXcNCj4gPiA+ID4gPiA+IHllYXJzDQo+ID4gPiA+
ID4gPiBhZ28uDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gT24gRnJpLCBBcHIgMjYsIDIw
MTkgYXQgNjoyMiBQTSBKZWZmIExheXRvbiA8DQo+ID4gPiA+ID4gPiA+IGpsYXl0b25Aa2VybmVs
Lm9yZz4NCj4gPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gT24gRnJpLCAyMDE5
LTA0LTI2IGF0IDEwOjUwIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMNCj4gPiA+ID4gPiA+ID4gPiB3
cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IE9uIEZyaSwgQXByIDI2LCAyMDE5IGF0IDA0OjExOjAw
UE0gKzAyMDAsIEFtaXINCj4gPiA+ID4gPiA+ID4gPiA+IEdvbGRzdGVpbg0KPiA+ID4gPiA+ID4g
PiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIEZyaSwgQXByIDI2LCAyMDE5LCA0
OjAwIFBNIEouIEJydWNlIEZpZWxkcyA8DQo+ID4gPiA+ID4gPiA+ID4gPiA+IGJmaWVsZHNAZmll
bGRzZXMub3JnPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4g
VGhhdCBzYWlkLCB3ZSBjb3VsZCBhbHNvIGxvb2sgYXQgYSB2ZnMtbGV2ZWwgbW91bnQNCj4gPiA+
ID4gPiA+ID4gPiBvcHRpb24NCj4gPiA+ID4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gPiA+ID4g
d291bGQNCj4gPiA+ID4gPiA+ID4gPiBtYWtlIHRoZSBrZXJuZWwgZW5mb3JjZSB0aGVzZSBmb3Ig
YW55IG9wZW5lci4gVGhhdA0KPiA+ID4gPiA+ID4gPiA+IGNvdWxkDQo+ID4gPiA+ID4gPiA+ID4g
YWxzbw0KPiA+ID4gPiA+ID4gPiA+IGJlIHVzZWZ1bCwNCj4gPiA+ID4gPiA+ID4gPiBhbmQgc2hv
dWxkbid0IGJlIHRvbyBoYXJkIHRvIGltcGxlbWVudC4gTWF5YmUgZXZlbiBtYWtlDQo+ID4gPiA+
ID4gPiA+ID4gaXQNCj4gPiA+ID4gPiA+ID4gPiBhDQo+ID4gPiA+ID4gPiA+ID4gdmZzbW91bnQt
DQo+ID4gPiA+ID4gPiA+ID4gbGV2ZWwgb3B0aW9uIChsaWtlIC1vIHJvIGlzKS4NCj4gPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFllaCwgSSBhbSBodW1ibHkg
Z29pbmcgdG8gbGVhdmUgdGhpcyBzdHJ1Z2dsZSB0byBzb21lb25lDQo+ID4gPiA+ID4gPiA+IGVs
c2UuDQo+ID4gPiA+ID4gPiA+IE5vdCBpbXBvcnRhbnQgZW5vdWdoIElNTyBhbmQgY29tcGxldGVs
eSBpbmRlcGVuZGVudA0KPiA+ID4gPiA+ID4gPiBlZmZvcnQgdG8NCj4gPiA+ID4gPiA+ID4gdGhl
DQo+ID4gPiA+ID4gPiA+IGFkdmlzb3J5IGF0b21pYyBvcGVuJmxvY2sgQVBJLg0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiBIYXZpbmcgdGhlIGtlcm5lbCBhbGxvdyBzZXR0aW5nIGRlbnkgbW9k
ZXMgb24gYW55IG9wZW4gY2FsbA0KPiA+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiA+IGENCj4gPiA+
ID4gPiA+IG5vbi0NCj4gPiA+ID4gPiA+IHN0YXJ0ZXIsIGZvciB0aGUgcmVhc29ucyBCcnVjZSBv
dXRsaW5lZCBlYXJsaWVyLiBUaGlzDQo+ID4gPiA+ID4gPiBfbXVzdF8gYmUNCj4gPiA+ID4gPiA+
IHJlc3RyaWN0ZWQgaW4gc29tZSBmYXNoaW9uIG9yIHdlJ2xsIGJlIG9wZW5pbmcgdXAgYQ0KPiA+
ID4gPiA+ID4gZ2lub3Jtb3VzDQo+ID4gPiA+ID4gPiBEb1MNCj4gPiA+ID4gPiA+IG1lY2hhbmlz
bS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gTXkgcHJvcG9zYWwgd2FzIHRvIG1ha2UgdGhp
cyBvbmx5IGJlIGVuZm9yY2VkIGJ5DQo+ID4gPiA+ID4gPiBhcHBsaWNhdGlvbnMNCj4gPiA+ID4g
PiA+IHRoYXQNCj4gPiA+ID4gPiA+IGV4cGxpY2l0bHkgb3B0LWluIGJ5IHNldHRpbmcgT19TSCov
T19FWCogZmxhZ3MuIEl0IHdvdWxkbid0DQo+ID4gPiA+ID4gPiBiZQ0KPiA+ID4gPiA+ID4gdG9v
DQo+ID4gPiA+ID4gPiBkaWZmaWN1bHQgdG8gYWxzbyBhbGxvdyB0aGVtIHRvIGJlIGVuZm9yY2Vk
IG9uIGEgcGVyLWZzDQo+ID4gPiA+ID4gPiBiYXNpcw0KPiA+ID4gPiA+ID4gdmlhDQo+ID4gPiA+
ID4gPiBtb3VudA0KPiA+ID4gPiA+ID4gb3B0aW9uIG9yIHNvbWV0aGluZy4gTWF5YmUgd2UgY291
bGQgZXhwYW5kIHRoZSBtZWFuaW5nIG9mDQo+ID4gPiA+ID4gPiAnLW8NCj4gPiA+ID4gPiA+IG1h
bmQnDQo+ID4gPiA+ID4gPiA/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEhvdyB3b3VsZCB5
b3UgcHJvcG9zZSB0aGF0IHdlIHJlc3RyaWN0IHRoaXM/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBPdXIgY29tbXVuaWNhdGlvbiBjaGFubmVsIGlzIGJyb2tlbi4NCj4gPiA+
ID4gPiBJIGRpZCBub3QgaW50ZW5kIHRvIHByb3Bvc2UgYW55IGltcGxpY2l0IGxvY2tpbmcuDQo+
ID4gPiA+ID4gSWYgc2FtYmEgYW5kIG5mc2QgY2FuIG9wdC1pbiB3aXRoIE9fU0hBUkUgZmxhZ3Ms
IEkgZG8gbm90DQo+ID4gPiA+ID4gdW5kZXJzdGFuZCB3aHkgYSBtb3VudCBvcHRpb24gaXMgaGVs
cGZ1bCBmb3IgdGhlIGNhdXNlIG9mDQo+ID4gPiA+ID4gc2FtYmEvbmZzZCBpbnRlcm9wLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IElmIHNvbWVvbmUgZWxzZSBpcyBpbnRlcmVzdGVkIGluIHNhbWJh
L2xvY2FsIGludGVyb3AgdGhhbg0KPiA+ID4gPiA+IHllcywgYSBtb3VudCBvcHRpb24gbGlrZSBz
dWdnZXN0ZWQgYnkgUGF2ZWwgY291bGQgYmUgYSBnb29kDQo+ID4gPiA+ID4gb3B0aW9uLA0KPiA+
ID4gPiA+IGJ1dCBpdCBpcyBhbiBvcnRob2dvbmFsIGVmZm9ydCBJTU8uDQo+ID4gPiA+IA0KPiA+
ID4gPiBJZiBhbiBORlMgY2xpZW50ICdvcHRzIGluJyB0byBzZXQgc2hhcmUgZGVueSwgdGhlbiB0
aGF0IHN0aWxsDQo+ID4gPiA+IG1ha2VzDQo+ID4gPiA+IGl0DQo+ID4gPiA+IGEgbm9uLW9wdGlv
bmFsIGxvY2sgZm9yIHRoZSBvdGhlciBORlMgY2xpZW50cywgYmVjYXVzZSBhbGwNCj4gPiA+ID4g
b3JkaW5hcnkNCj4gPiA+ID4gb3BlbigpIGNhbGxzIHdpbGwgYmUgZ2F0ZWQgYnkgdGhlIHNlcnZl
ciB3aGV0aGVyIG9yIG5vdCB0aGVpcg0KPiA+ID4gPiBhcHBsaWNhdGlvbiBzcGVjaWZpZXMgdGhl
IE9fU0hBUkUgZmxhZy4gVGhlcmUgaXMgbm8gZmxhZyBpbiB0aGUNCj4gPiA+ID4gTkZTDQo+ID4g
PiA+IHByb3RvY29sIHRoYXQgY291bGQgdGVsbCB0aGUgc2VydmVyIHRvIGlnbm9yZSBkZW55IG1v
ZGVzLg0KPiA+ID4gPiANCj4gPiA+ID4gSU9XOiBpdCB3b3VsZCBzdWZmaWNlIGZvciAxIGNsaWVu
dCB0byB1c2UgT19TSEFSRXxPX0RFTlkqIHRvDQo+ID4gPiA+IG9wdA0KPiA+ID4gPiBhbGwNCj4g
PiA+ID4gdGhlIG90aGVyIGNsaWVudHMgaW4uDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBTb3Jy
eSBmb3IgYmVpbmcgdGhpY2ssIEkgZG9uJ3QgdW5kZXJzdGFuZCBpZiB3ZSBhcmUgaW4gYWdyZWVt
ZW50DQo+ID4gPiBvcg0KPiA+ID4gbm90Lg0KPiA+ID4gDQo+ID4gPiBNeSB1bmRlcnN0YW5kaW5n
IGlzIHRoYXQgdGhlIG5ldHdvcmsgZmlsZSBzZXJ2ZXIgaW1wbGVtZW50YXRpb25zDQo+ID4gPiAo
aS5lLiBzYW1iYSwga25mZHMsIEdhbmVzaGEpIHdpbGwgYWx3YXlzIHVzZSBzaGFyZS9kZW55IG1v
ZGVzLg0KPiA+ID4gU28gZm9yIGV4YW1wbGUgbmZzIHYzIG9wZW5zIHdpbGwgYWx3YXlzIHVzZSBP
X0RFTllfTk9ORQ0KPiA+ID4gaW4gb3JkZXIgdG8gaGF2ZSBjb3JyZWN0IGludGVyb3Agd2l0aCBz
YW1iYSBhbmQgbmZzIHY0Lg0KPiA+ID4gDQo+ID4gPiBJZiBJIGFtIG1pc3VuZGVyc3RhbmRpbmcg
c29tZXRoaW5nLCBwbGVhc2UgZW5saWdodGVuIG1lLg0KPiA+ID4gSWYgdGhlcmUgaXMgYSByZWFz
b24gd2h5IG1vdW50IG9wdGlvbiBpcyBuZWVkZWQgZm9yIHRoZSBzb2xlDQo+ID4gPiBwdXJwb3Nl
DQo+ID4gPiBvZiBpbnRlcm9wIGJldHdlZW4gbmV0d29yayBmaWxlc3lzdGVtIHNlcnZlcnMsIHBs
ZWFzZSBlbmxpZ2h0ZW4NCj4gPiA+IG1lLg0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBTYW1l
IGRpZmZlcmVuY2UuIEFzIGxvbmcgYXMgbmZzZCBhbmQvb3IgR2FuZXNoYSBhcmUgdHJhbnNsYXRp
bmcNCj4gPiBPUEVONF9TSEFSRV9BQ0NFU1NfUkVBRCBhbmQgT1BFTjRfU0hBUkVfQUNDRVNTX1dS
SVRFIGludG8gc2hhcmUNCj4gPiBhY2Nlc3MNCj4gPiBsb2NrcywgdGhlbiB0aG9zZSB3aWxsIGNv
bmZsaWN0IHdpdGggYW55IGRlbnkgbG9ja3Mgc2V0IGJ5IHdoYXRldmVyDQo+ID4gYXBwbGljYXRp
b24gdGhhdCB1c2VzIHRoZW0uDQo+ID4gDQo+ID4gSU9XOiBhbnkgb3BlbihPX1JET05MWSkgYW5k
IG9wZW4oT19SRFdSKSB3aWxsIGNvbmZsaWN0IHdpdGggYW4NCj4gPiBPX0RFTllfUkVBRCB0aGF0
IGlzIHNldCBvbiB0aGUgc2VydmVyLCBhbmQgYW55IG9wZW4oT19XUk9OTFkpIGFuZA0KPiA+IG9w
ZW4oT19SRFdSKSB3aWxsIGNvbmZsaWN0IHdpdGggYW4gT19ERU5ZX1dSSVRFIHRoYXQgaXMgc2V0
IG9uIHRoZQ0KPiA+IHNlcnZlci4gVGhlcmUgaXMgbm8gb3B0LW91dCBmb3IgTkZTIGNsaWVudHMg
b24gdGhpcyBpc3N1ZSwgYmVjYXVzZQ0KPiA+IHN0YXRlZnVsIE5GU3Y0IG9wZW5zIE1VU1Qgc2V0
IG9uZSBvciBtb3JlIG9mDQo+ID4gT1BFTjRfU0hBUkVfQUNDRVNTX1JFQUQNCj4gPiBhbmQgT1BF
TjRfU0hBUkVfQUNDRVNTX1dSSVRFLg0KPiA+IA0KPiANCj4gVXJnaCEgSSAqdGhpbmsqIEkgdW5k
ZXJzdGFuZCB0aGUgY29uZnVzaW9uLg0KPiANCj4gSSBiZWxpZXZlIEplZmYgd2FzIHRhbGtpbmcg
YWJvdXQgaW1wbGVtZW50aW5nIGEgbW91bnQgb3B0aW9uDQo+IHNpbWlsYXIgdG8gLW8gbWFuZCBm
b3IgbG9jYWwgZnMgb24gdGhlIHNlcnZlci4NCj4gV2l0aCB0aGF0IG1vdW50IG9wdGlvbiwgKmFu
eSogb3BlbigpIGJ5IGFueSBhcHAgb2YgZmlsZSBmcm9tDQo+IHRoYXQgbW91bnQgd2lsbCB1c2Ug
T19ERU5ZX05PTkUgdG8gaW50ZXJvcCBjb3JyZWN0bHkgd2l0aA0KPiBuZXR3b3JrIHNlcnZlcnMg
dGhhdCBleHBsaWNpdGx5IG9wdC1pbiBmb3IgaW50ZXJvcCBvbiBzaGFyZSBtb2Rlcy4NCj4gSSBh
Z3JlZSBpdHMgYSBuaWNlIGZlYXR1cmUgdGhhdCBpcyBlYXN5IHRvIGltcGxlbWVudCAtIG5vdCBp
bXBvcnRhbnQNCj4gZm9yIGZpcnN0IHZlcnNpb24gSU1PLg0KPiANCj4gSSAqdGhpbmsqIHlvdSBh
cmUgdGFsa2luZyBvbiBuZnMgY2xpZW50IG1vdW50IG9wdGlvbiBmb3INCj4gb3B0LWluL291dCBv
ZiBzaGFyZSBtb2Rlcz8gdGhlcmUgd2FzIG5vIHN1Y2ggaW50ZW50aW9uLg0KPiANCg0KTm8uIEkn
bSBzYXlpbmcgdGhhdCB3aGV0aGVyIHlvdSBpbnRlbmRlZCB0byBvciBub3QsIHlvdSBfYXJlXw0K
aW1wbGVtZW50aW5nIGEgbWFuZGF0b3J5IGxvY2sgb3ZlciBORlMuIE5vIHRhbGsgYWJvdXQgT19T
SEFSRSBmbGFncyBhbmQNCml0IGJlaW5nIGFuIG9wdC1pbiBwcm9jZXNzIGZvciBsb2NhbCBhcHBs
aWNhdGlvbnMgY2hhbmdlcyB0aGUgZmFjdCB0aGF0DQpub24tbG9jYWwgYXBwbGljYXRpb25zIChp
LmUuIHRoZSBvbmVzIHRoYXQgY291bnQg4pi6KSBhcmUgYmVpbmcgc3ViamVjdGVkDQp0byBhIG1h
bmRhdG9yeSBsb2NrIHdpdGggYWxsIHRoZSBwb3RlbnRpYWwgZm9yIGRlbmlhbCBvZiBzZXJ2aWNl
IHRoYXQNCmltcGxpZXMuDQpTbyB3ZSBuZWVkIGEgbWVjaGFuaXNtIGJleW9uZCBPX1NIQVJFIGlu
IG9yZGVyIHRvIGVuc3VyZSB0aGlzIHN5c3RlbQ0KY2Fubm90IGJlIHVzZWQgb24gc2Vuc2l0aXZl
IGZpbGVzIHRoYXQgbmVlZCB0byBiZSBhY2Nlc3NpYmxlIHRvIGFsbC4gSXQNCmNvdWxkIGJlIGFu
IGV4cG9ydCBvcHRpb24sIG9yIGEgbW91bnQgb3B0aW9uLCBvciBpdCBjb3VsZCBiZSBhIG1vcmUN
CnNwZWNpZmljIG1lY2hhbmlzbSAoZS5nLiB0aGUgc2V0Z2lkIHdpdGggbm8gZXhlY3V0ZSBtb2Rl
IGJpdCBhcyB1c2luZw0KaW4gUE9TSVggbWFuZGF0b3J5IGxvY2tzKS4NCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
