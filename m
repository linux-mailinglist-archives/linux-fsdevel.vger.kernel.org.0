Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526521194EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 22:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfLJVQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 16:16:49 -0500
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:6100
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726968AbfLJVQn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:16:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTFUFelECr8EC7z0hCDchkGIen8uRrpehu4YnxHFFY//WQYie8pjPTYeaxCQES3yFE4ki/X9g88qEPozkBgwB0i96MkgCb+ZE5jaz3tcs+e0iewcalAfM5x7ZSQFIC2gnm03rHlaiuPeCa0rLc6YY0fPdOI9JmYd3ohsNsLBDi1T16weBMZ2Q7wQ9CWZ2D+2yLWYautgZGNTJFjRGaG30kekgdriKeZpnxOt+IxCnwnAz+B46ELxJt098OBbWN1r/S/EeUBn5u1JNw0Qn4aQy16X+/etcfEYvSz+/Vacld0Y0gtBwlkVIvEQF3r2vsE3iiaUBDDNtbkphnqDOx7K1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSoZuO4USlWzYQnwjNGnAvTCmHXnPGXZpROPM+hPd8o=;
 b=AsjtpOMUrVmmXmotkVSLiIQuzM5ovv61bWNmMNi8R1mlmwwa/g5I6IZFE1MEHxVSu+pCvqoJqJLgKCw1veoERw/CCXS9yTghH4JhB0pCrvkuyis9ivofROrfVfR76P7BFV4ezt0iq6BoKPUy7OfB6abWasgRCdyfvnO+emHUCQfwtxUMNeJYn3BHdQxAvg+0ej2teklyXVG51is2Lo7u9IIBzuabsgru+J7HeHgCPFrnQxL5wdALoYtGNxImitp9DhhTXf6OLwLbJBuCJd6COt4it80HYlM2MBL6oIkwV63SiJ4/Pqh6oL3b3DjG5BNVnkg3UagOh8qMfUoBosUjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSoZuO4USlWzYQnwjNGnAvTCmHXnPGXZpROPM+hPd8o=;
 b=s99Dir0VoKQEUEVk5sQ8eAiZ/LgoBAtpglcUD7Lu1p/sQL90s5goO/e15ArswxcshcENOYyIv8Lr3nmjG6VYuTkz/K98SidVbv3theKgBUeoVCUeKJAhpSii0vtc30N0UZAUpMoYW+698OZc895da3VsKLDQOeiicDqT4pxU15w=
Received: from BL0PR06MB4370.namprd06.prod.outlook.com (10.167.241.142) by
 BL0PR06MB4433.namprd06.prod.outlook.com (10.167.181.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 21:16:40 +0000
Received: from BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1]) by BL0PR06MB4370.namprd06.prod.outlook.com
 ([fe80::dd54:50fb:1e98:46a1%6]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 21:16:40 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH v6 00/27] nfs: Mount API conversion
Thread-Topic: [PATCH v6 00/27] nfs: Mount API conversion
Thread-Index: AQHVr1W8XcbfpDFp1UOihmUxoyYAoqez34uA
Date:   Tue, 10 Dec 2019 21:16:39 +0000
Message-ID: <498258bf630d4c2667920f21341a2a6e82a3788d.camel@netapp.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 255d2858-8314-4687-815d-08d77db63fb1
x-ms-traffictypediagnostic: BL0PR06MB4433:
x-microsoft-antispam-prvs: <BL0PR06MB443308E25869E84A29EEBF88F85B0@BL0PR06MB4433.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(51914003)(199004)(189003)(2616005)(26005)(2906002)(478600001)(110136005)(4326008)(54906003)(36756003)(186003)(6512007)(316002)(66556008)(8936002)(64756008)(66446008)(71200400001)(6486002)(5660300002)(76116006)(91956017)(66946007)(6506007)(4001150100001)(81156014)(81166006)(86362001)(66476007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR06MB4433;H:BL0PR06MB4370.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //MsNualPkBZhWykcBg3jQKrfU2sRe6gkerQvddm+d8CkpZvEXhtPMIC0/OlZOtV4NddfykJENsHUo+QfXCKDCdsG12eHT0oVuThSLtnEKo3G7uZA2mIZa4bjcFwrJ5rvPe2BF9l8DF6MyoBQHGSij4jTq1wXksgJ2HXsTmeTXHN6TmPn0vHJJqcswcuvsFJUgZSoKPo7n0v3hUNFIIL4lzM2JRSzlKJn9hRN/xDvkeHiJjJ8afdWldaFxuTZnNs1Dgz+nI7+KwomYMf4ULgubOGrm8MFGFFsxxXoVXlUqWc8eB8kkSoV6iZAWOlPwOn9bTYlmuGpdccBo5TqZqh0OeKWor9V3+DZTDBuZc/kl8Ii0PWdyPtxxEBR8chzBglKNknGDSep3J2eMc96JGD4VI/nEcfNmrXgVP3M44U0WPICRtg3cveMfFwWdh+tGUlAu9sux4lP9GyXm7W1Aj9xYB4LXrYy1yAj/QMPqP3rLST1UPHcOyseJ4Gr5TMdesz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA34966C5CA71D4BA37D8349CF7DA761@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255d2858-8314-4687-815d-08d77db63fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 21:16:39.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0deS/3gAQQKmREhyfC7Hs2i/gIJeUTZbm0ciBej5i/NAqYiLTIE1oH7mUdb7c6hxxKKGcEUqCKP3WAhpuiuHqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4433
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgU2NvdHQsDQoNCk9uIFR1ZSwgMjAxOS0xMi0xMCBhdCAwNzozMCAtMDUwMCwgU2NvdHQgTWF5
aGV3IHdyb3RlOg0KPiBIaSBBbm5hLCBUcm9uZCwNCj4gDQo+IEhlcmUncyBhIHNldCBvZiBwYXRj
aGVzIHRoYXQgY29udmVydHMgTkZTIHRvIHVzZSB0aGUgbW91bnQgQVBJLiAgTm90ZSB0aGF0DQo+
IHRoZXJlIGFyZSBhIGxvdCBvZiBwcmVsaW1pbmFyeSBwYXRjaGVzLCBzb21lIGZyb20gRGF2aWQg
YW5kIHNvbWUgZnJvbSBBbC4NCj4gVGhlIGZpbmFsIHBhdGNoICh0aGUgb25lIHRoYXQgZG9lcyB0
aGUgYWN0dWFsIGNvbnZlcnNpb24pIGZyb20gdGhlIERhdmlkJ3MNCj4gaW5pdGlhbCBwb3N0aW5n
IGhhcyBiZWVuIHNwbGl0IGludG8gNSBzZXBhcmF0ZSBwYXRjaGVzLCBhbmQgdGhlIGVudGlyZSBz
ZXQNCj4gaGFzIGJlZW4gcmViYXNlZCBvbiB0b3Agb2YgdjUuNS1yYzEuDQoNClRoYW5rcyBmb3Ig
dGhlIHVwZGF0ZWQgcGF0Y2hlcyEgRXZlcnl0aGluZyBsb29rcyBva2F5IHRvIG1lLCBidXQgSSd2
ZSBvbmx5DQp0ZXN0ZWQgd2l0aCB0aGUgbGVnYWN5IG1vdW50IGNvbW1hbmQuIEknbSBjdXJpb3Vz
IGlmIHlvdSd2ZSB0ZXN0ZWQgaXQgdXNpbmcgdGhlDQpuZXcgc3lzdGVtPw0KDQpUaGFua3MsDQpB
bm5hDQoNCj4gDQo+IENoYW5nZXMgc2luY2UgdjU6DQo+IC0gZml4ZWQgcG9zc2libGUgZGVyZWZl
bmNlIG9mIGVycm9yIHBvaW50ZXIgaW4gbmZzNF92YWxpZGF0ZV9mc3BhdGgoKQ0KPiAgIHJlcG9y
dGVkIGJ5IERhbiBDYXJwZW50ZXINCj4gLSByZWJhc2VkIG9uIHRvcCBvZiB2NS41LXJjMQ0KPiBD
aGFuZ2VzIHNpbmNlIHY0Og0KPiAtIGZ1cnRoZXIgc3BsaXQgdGhlIG9yaWdpbmFsICJORlM6IEFk
ZCBmc19jb250ZXh0IHN1cHBvcnQiIHBhdGNoIChuZXcNCj4gICBwYXRjaCBpcyBhYm91dCAyNSUg
c21hbGxlciB0aGFuIHRoZSB2NCBwYXRjaCkNCj4gLSBmaXhlZCBORlN2NCByZWZlcnJhbCBtb3Vu
dHMgKGJyb2tlbiBpbiB0aGUgb3JpZ2luYWwgcGF0Y2gpDQo+IC0gZml4ZWQgbGVhayBvZiBuZnNf
ZmF0dHIgd2hlbiBmc19jb250ZXh0IGlzIGZyZWVkDQo+IENoYW5nZXMgc2luY2UgdjM6DQo+IC0g
Y2hhbmdlZCBsaWNlbnNlIGFuZCBjb3B5cmlnaHQgdGV4dCBpbiBmcy9uZnMvZnNfY29udGV4dC5j
DQo+IENoYW5nZXMgc2luY2UgdjI6DQo+IC0gZml4ZWQgdGhlIGNvbnZlcnNpb24gb2YgdGhlIG5j
b25uZWN0PSBvcHRpb24NCj4gLSBhZGRlZCAnI2lmIElTX0VOQUJMRUQoQ09ORklHX05GU19WNCkn
IGFyb3VuZCBuZnM0X3BhcnNlX21vbm9saXRoaWMoKQ0KPiAgIHRvIGF2b2lkIHVudXNlZC1mdW5j
dGlvbiB3YXJuaW5nIHdoZW4gY29tcGlsaW5nIHdpdGggdjQgZGlzYWJsZWQNCj4gQ2hhZ25lcyBz
aW5jZSB2MToNCj4gLSBzcGxpdCB1cCBwYXRjaCAyMyBpbnRvIDQgc2VwYXJhdGUgcGF0Y2hlcw0K
PiANCj4gLVNjb3R0DQo+IA0KPiBBbCBWaXJvICgxNSk6DQo+ICAgc2FuZXIgY2FsbGluZyBjb252
ZW50aW9ucyBmb3IgbmZzX2ZzX21vdW50X2NvbW1vbigpDQo+ICAgbmZzOiBzdGFzaCBzZXJ2ZXIg
aW50byBzdHJ1Y3QgbmZzX21vdW50X2luZm8NCj4gICBuZnM6IGxpZnQgc2V0dGluZyBtb3VudF9p
bmZvIGZyb20gbmZzNF9yZW1vdGV7LF9yZWZlcnJhbH1fbW91bnQNCj4gICBuZnM6IGZvbGQgbmZz
NF9yZW1vdGVfZnNfdHlwZSBhbmQgbmZzNF9yZW1vdGVfcmVmZXJyYWxfZnNfdHlwZQ0KPiAgIG5m
czogZG9uJ3QgYm90aGVyIHNldHRpbmcvcmVzdG9yaW5nIGV4cG9ydF9wYXRoIGFyb3VuZA0KPiAg
ICAgZG9fbmZzX3Jvb3RfbW91bnQoKQ0KPiAgIG5mczQ6IGZvbGQgbmZzX2RvX3Jvb3RfbW91bnQv
bmZzX2ZvbGxvd19yZW1vdGVfcGF0aA0KPiAgIG5mczogbGlmdCBzZXR0aW5nIG1vdW50X2luZm8g
ZnJvbSBuZnNfeGRldl9tb3VudCgpDQo+ICAgbmZzOiBzdGFzaCBuZnNfc3VidmVyc2lvbiByZWZl
cmVuY2UgaW50byBuZnNfbW91bnRfaW5mbw0KPiAgIG5mczogZG9uJ3QgYm90aGVyIHBhc3Npbmcg
bmZzX3N1YnZlcnNpb24gdG8gLT50cnlfbW91bnQoKSBhbmQNCj4gICAgIG5mc19mc19tb3VudF9j
b21tb24oKQ0KPiAgIG5mczogbWVyZ2UgeGRldiBhbmQgcmVtb3RlIGZpbGVfc3lzdGVtX3R5cGUN
Cj4gICBuZnM6IHVuZXhwb3J0IG5mc19mc19tb3VudF9jb21tb24oKQ0KPiAgIG5mczogZG9uJ3Qg
cGFzcyBuZnNfc3VidmVyc2lvbiB0byAtPmNyZWF0ZV9zZXJ2ZXIoKQ0KPiAgIG5mczogZ2V0IHJp
ZCBvZiBtb3VudF9pbmZvIC0+ZmlsbF9zdXBlcigpDQo+ICAgbmZzX2Nsb25lX3NiX3NlY3VyaXR5
KCk6IHNpbXBsaWZ5IHRoZSBjaGVjayBmb3Igc2VydmVyIGJvZ29zaXR5DQo+ICAgbmZzOiBnZXQg
cmlkIG9mIC0+c2V0X3NlY3VyaXR5KCkNCj4gDQo+IERhdmlkIEhvd2VsbHMgKDgpOg0KPiAgIE5G
UzogTW92ZSBtb3VudCBwYXJhbWV0ZXJpc2F0aW9uIGJpdHMgaW50byB0aGVpciBvd24gZmlsZQ0K
PiAgIE5GUzogQ29uc3RpZnkgbW91bnQgYXJndW1lbnQgbWF0Y2ggdGFibGVzDQo+ICAgTkZTOiBS
ZW5hbWUgc3RydWN0IG5mc19wYXJzZWRfbW91bnRfZGF0YSB0byBzdHJ1Y3QgbmZzX2ZzX2NvbnRl
eHQNCj4gICBORlM6IFNwbGl0IG5mc19wYXJzZV9tb3VudF9vcHRpb25zKCkNCj4gICBORlM6IERl
aW5kZW50IG5mc19mc19jb250ZXh0X3BhcnNlX29wdGlvbigpDQo+ICAgTkZTOiBBZGQgYSBzbWFs
bCBidWZmZXIgaW4gbmZzX2ZzX2NvbnRleHQgdG8gYXZvaWQgc3RyaW5nIGR1cA0KPiAgIE5GUzog
RG8gc29tZSB0aWR5aW5nIG9mIHRoZSBwYXJzaW5nIGNvZGUNCj4gICBORlM6IEFkZCBmc19jb250
ZXh0IHN1cHBvcnQuDQo+IA0KPiBTY290dCBNYXloZXcgKDQpOg0KPiAgIE5GUzogcmVuYW1lIG5m
c19mc19jb250ZXh0IHBvaW50ZXIgYXJnIGluIGEgZmV3IGZ1bmN0aW9ucw0KPiAgIE5GUzogQ29u
dmVydCBtb3VudCBvcHRpb24gcGFyc2luZyB0byB1c2UgZnVuY3Rpb25hbGl0eSBmcm9tDQo+ICAg
ICBmc19wYXJzZXIuaA0KPiAgIE5GUzogQWRkaXRpb25hbCByZWZhY3RvcmluZyBmb3IgZnNfY29u
dGV4dCBjb252ZXJzaW9uDQo+ICAgTkZTOiBBdHRhY2ggc3VwcGxlbWVudGFyeSBlcnJvciBpbmZv
cm1hdGlvbiB0byBmc19jb250ZXh0Lg0KPiANCj4gIGZzL25mcy9NYWtlZmlsZSAgICAgICAgIHwg
ICAgMiArLQ0KPiAgZnMvbmZzL2NsaWVudC5jICAgICAgICAgfCAgIDgwICstDQo+ICBmcy9uZnMv
ZnNfY29udGV4dC5jICAgICB8IDE0MjQgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZnMv
bmZzL2ZzY2FjaGUuYyAgICAgICAgfCAgICAyICstDQo+ICBmcy9uZnMvZ2V0cm9vdC5jICAgICAg
ICB8ICAgNzMgKy0NCj4gIGZzL25mcy9pbnRlcm5hbC5oICAgICAgIHwgIDEzMiArLS0NCj4gIGZz
L25mcy9uYW1lc3BhY2UuYyAgICAgIHwgIDE0NiArKy0NCj4gIGZzL25mcy9uZnMzX2ZzLmggICAg
ICAgIHwgICAgMiArLQ0KPiAgZnMvbmZzL25mczNjbGllbnQuYyAgICAgfCAgICA2ICstDQo+ICBm
cy9uZnMvbmZzM3Byb2MuYyAgICAgICB8ICAgIDIgKy0NCj4gIGZzL25mcy9uZnM0X2ZzLmggICAg
ICAgIHwgICAgOSArLQ0KPiAgZnMvbmZzL25mczRjbGllbnQuYyAgICAgfCAgIDk5ICstDQo+ICBm
cy9uZnMvbmZzNGZpbGUuYyAgICAgICB8ICAgIDEgKw0KPiAgZnMvbmZzL25mczRuYW1lc3BhY2Uu
YyAgfCAgMjkyICsrKy0tLQ0KPiAgZnMvbmZzL25mczRwcm9jLmMgICAgICAgfCAgICAyICstDQo+
ICBmcy9uZnMvbmZzNHN1cGVyLmMgICAgICB8ICAyNTcgKystLS0NCj4gIGZzL25mcy9wcm9jLmMg
ICAgICAgICAgIHwgICAgMiArLQ0KPiAgZnMvbmZzL3N1cGVyLmMgICAgICAgICAgfCAyMjE3ICsr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgaW5jbHVkZS9saW51eC9u
ZnNfeGRyLmggfCAgICA5ICstDQo+ICAxOSBmaWxlcyBjaGFuZ2VkLCAyMjg3IGluc2VydGlvbnMo
KyksIDI0NzAgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZnMvbmZzL2ZzX2Nv
bnRleHQuYw0KPiANCg==
