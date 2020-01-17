Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3016140EB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 17:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgAQQMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 11:12:32 -0500
Received: from mail-eopbgr750104.outbound.protection.outlook.com ([40.107.75.104]:25775
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727043AbgAQQMc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:12:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icJoj+plNkA+r7+g+sZaCCDCvuEQCAOA5QA6HvOif02gxHcO9vGwd+xCwxZiJH3XjIspMifm93v/ftTjXlHz5f6ie644j5SQXodLgO/a5W6lzQeayWo+Al5FPlWAsZT/3bPA8uGDLhA5+Ddkm04tZF7ugc3pr7h6iJXVuDzi9Ynv3bnunT75KAAlDrbfO/w04zqPoH4R9knEpcmZFOMxbUjTEHpmPLOAlshobb2ZB6uMG7+j96nX0yVnZ940cv/hTqwh2/41yjeIDP7zfcwmdE0HfaBGyiyS1TBgEdmNEQXHwmC4xV75itqCEJ3WT7tb4dYGPc2sUaa4Bb/vMZe1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CXTm5kaW2e0irOuIeM5xdfh7F9yNXmLv4hvalHj0jE=;
 b=QwuLZ1pWFKU2MKNYU7XCuwlgw4v1DpQVrH99T8V1hdRBWNGb9zVAScztp+EyJM94zH7XdQ82MGcTfFzAqIhywFvcys4tzr23X1vI3du4X5HGtl69ikzSLjW6bW2WjUVf324FDyYUL3KNtfXE2WjfAjegVG6civqhCEWV5KGa3CZnREPr7BN5fWfvdf7F5prrVI+VzhBK3jY8UwvuhhLg74Nf9d+dJXhyXWyQAv3MF1+/msQNBQ/NjVuzl4/d0vPu09IRZ5wJY1CszvtALL3wtcyr79HjQgc6T0zDs005eDj946T1WQYBEr77fQXUIwwWABf2v2sXnv0EWmMa0/a/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CXTm5kaW2e0irOuIeM5xdfh7F9yNXmLv4hvalHj0jE=;
 b=Zzexh/Kh5w2JvaAgnUrrRcy/7bP6i70necGWjRTW/6dwEWXN19kKNBN8kzxybs7BLKq/lI1rR8fcvQgvu512A3giTsdEp7kdO/mQxwbs5xMPpKPaKpnSoQlVfa94uV4l7itkPWvuxg19meL033cCO+5zvDyrD8vy4kvYidaHCRY=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2025.namprd13.prod.outlook.com (10.174.186.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Fri, 17 Jan 2020 16:12:28 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 16:12:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "hch@lst.de" <hch@lst.de>,
        "osandov@osandov.com" <osandov@osandov.com>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Thread-Topic: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Thread-Index: AQHVzTSO+0pwcPyVr0iwCBUjAesfDKfu658AgAAUqoCAAAcggA==
Date:   Fri, 17 Jan 2020 16:12:28 +0000
Message-ID: <9bfe61643b676d27abd5e3d7f8ca8ac907fbf65e.camel@hammerspace.com>
References: <364531.1579265357@warthog.procyon.org.uk>
         <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
         <20200117154657.GK8904@ZenIV.linux.org.uk>
In-Reply-To: <20200117154657.GK8904@ZenIV.linux.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caaeb9ae-602a-4835-a613-08d79b680c95
x-ms-traffictypediagnostic: DM5PR1301MB2025:
x-microsoft-antispam-prvs: <DM5PR1301MB20254F357319AE449279B663B8310@DM5PR1301MB2025.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39840400004)(136003)(396003)(366004)(376002)(189003)(199004)(6512007)(86362001)(8676002)(5660300002)(6916009)(8936002)(4326008)(2616005)(6486002)(478600001)(71200400001)(6506007)(81166006)(66556008)(66446008)(64756008)(66946007)(66476007)(54906003)(76116006)(91956017)(966005)(81156014)(186003)(2906002)(316002)(36756003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2025;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0h19YWE6P7eVQhOFAt3qvLrLXWcftfL17y6DKhWaPwn1+FiUWyoVy4yYz7k1+CANy5J9nQGMe7xrk8I7YMtUJBcP1/raiKsqi8ADO4sdGbCUps9VOUf/RQ/xs9msFLM6kX338AWHzpJrQE83u++hImTXACJmmtNJ/LJCO3y+jd3NUoSK1Gke57TxAyUfK2gCq65fltssBqNmdh+fDpeyy+XlUg/WLel9FSsLAebsXPwg+PrGmjyZI+HBZ+OTH3O+7KhW+sehBM9IdlrSXEDjITL8/qdyUEpUdVs0ON1LeA4NyztbZCK8r7F5sD8H7lKQuUsxXZOea+4IoXInyWifCqdw0eozPKSEAPysH2VE1lT9lL+hc99ZH1UNUN2cJhXwfd/rxxD+TJmWUYC8fjZpsjHk1Hb9y8caMcawDdMn/fqOlTI6oCnxG7vIkGxnTW20Nrqs5I3Nn3yupvwpYts+rQzvYiiVXQ9OuhOnuXzMfc8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED9682068C0CF9459E2DC1CC8F60917A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caaeb9ae-602a-4835-a613-08d79b680c95
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 16:12:28.4633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6J2yiUjvG0h6amdOFFZiO0mK2ixWQIKj7CspQugIVFJLX9HT7dDCTtWrwbDLhIWo2URVI143mARFfHWqnYaXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2025
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTE3IGF0IDE1OjQ2ICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBG
cmksIEphbiAxNywgMjAyMCBhdCAwMjozMzowMVBNICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3Jv
dGU6DQo+ID4gT24gRnJpLCAyMDIwLTAxLTE3IGF0IDEyOjQ5ICswMDAwLCBEYXZpZCBIb3dlbGxz
IHdyb3RlOg0KPiA+ID4gSXQgbWF5IGJlIHdvcnRoIGEgZGlzY3Vzc2lvbiBvZiB3aGV0aGVyIGxp
bmthdCgpIGNvdWxkIGJlIGdpdmVuIGENCj4gPiA+IGZsYWcgdG8NCj4gPiA+IGFsbG93IHRoZSBk
ZXN0aW5hdGlvbiB0byBiZSByZXBsYWNlZCBvciBpZiBhIG5ldyBzeXNjYWxsIHNob3VsZA0KPiA+
ID4gYmUNCj4gPiA+IG1hZGUgZm9yDQo+ID4gPiB0aGlzIC0gb3Igd2hldGhlciBpdCBzaG91bGQg
YmUgZGlzYWxsb3dlZCBlbnRpcmVseS4NCj4gPiA+IA0KPiA+ID4gQSBzZXQgb2YgcGF0Y2hlcyBo
YXMgYmVlbiBwb3N0ZWQgYnkgT21hciBTYW5kb3ZhbCB0aGF0IG1ha2VzIHRoaXMNCj4gPiA+IHBv
c3NpYmxlOg0KPiA+ID4gDQo+ID4gPiAgICAgDQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1mc2RldmVsL2NvdmVyLjE1MjQ1NDk1MTMuZ2l0Lm9zYW5kb3ZAZmIuY29tLw0KPiA+
ID4gDQo+ID4gPiB0aG91Z2ggaXQgb25seSBpbmNsdWRlcyBmaWxlc3lzdGVtIHN1cHBvcnQgZm9y
IGJ0cmZzLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGNvdWxkIGJlIHVzZWZ1bCBmb3IgY2FjaGVmaWxl
czoNCj4gPiA+IA0KPiA+ID4gCQ0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
ZnNkZXZlbC8zMzI2LjE1NzkwMTk2NjVAd2FydGhvZy5wcm9jeW9uLm9yZy51ay8NCj4gPiA+IA0K
PiA+ID4gYW5kIG92ZXJsYXlmcy4NCj4gPiA+IA0KPiA+IA0KPiA+IFRoYXQgc2VlbXMgdG8gbWUg
bGlrZSBhICJqdXN0IGdvIGFoZWFkIGFuZCBkbyBpdCBpZiB5b3UgY2FuIGp1c3RpZnkNCj4gPiBp
dCINCj4gPiBraW5kIG9mIHRoaW5nLiBJdCBoYXMgcGxlbnR5IG9mIHByZWNlZGVudCwgYW5kIGZp
dHMgZWFzaWx5IGludG8gdGhlDQo+ID4gZXhpc3Rpbmcgc3lzY2FsbCwgc28gd2h5IGRvIHdlIG5l
ZWQgYSBmYWNlLXRvLWZhY2UgZGlzY3Vzc2lvbj8NCj4gDQo+IFVuZm9ydHVuYXRlbHksIGl0IGRv
ZXMgKm5vdCogZml0IGVhc2lseS4gIEFuZCBJTU8gdGhhdCdzIGxpbnV4LWFiaQ0KPiBmb2RkZXIg
bW9yZQ0KPiB0aGFuIGFueXRoaW5nIGVsc2UuICBUaGUgcHJvYmxlbSBpcyBpbiBjb21pbmcgdXAg
d2l0aCBzYW5lIHNlbWFudGljcw0KPiAtIHRoZXJlJ3MNCj4gYSBwbGVudHkgb2YgY29ybmVyIGNh
c2VzIHdpdGggdGhhdCBvbmUuICBXaGF0IHRvIGRvIHdoZW4gZGVzdGluYXRpb24NCj4gaXMNCj4g
YSBkYW5nbGluZyBzeW1saW5rLCBmb3IgZXhhbXBsZT8gIE9yIGhhcyBzb21ldGhpbmcgbW91bnRl
ZCBvbiBpdCAobm8sDQo+IHNheWluZw0KPiAid2UnbGwganVzdCByZWplY3QgZGlyZWN0b3JpZXMi
IGlzIG5vdCBlbm91Z2gpLiAgV2hhdCBzaG91bGQgaGFwcGVuDQo+IHdoZW4NCj4gZGVzdGluYXRp
b24gaXMgYWxyZWFkeSBhIGhhcmRsaW5rIHRvIHRoZSBzYW1lIG9iamVjdD8NCj4gDQo+IEl0J3Mg
bGVzcyBvZiBhIGhvcnJvciB0aGFuIHJlbmFtZSgpIHdvdWxkJ3ZlIGJlZW4sIGJ1dCB0aGF0J3Mg
bm90DQo+IHNheWluZw0KPiBtdWNoLg0KDQpXZSBhbHJlYWR5IGhhdmUgcHJlY2VkZW50cyBmb3Ig
YWxsIG9mIHRoYXQgd2hlbiBoYW5kbGluZyBib2ctc3RhbmRhcmQNCm9wZW4oT19DUkVBVCkgKHdo
aWNoIGNyZWF0ZXMgdGhlIGZpcnN0IGxpbmsgdG8gdGhlIGZpbGUpLiBZZXMsIHRoZXJlIGlzDQp0
aGUgcXVlc3Rpb24gb2YgY2hvb3Npbmcgd2hldGhlciB0byBpbXBsZW1lbnQgT19OT0ZPTExPVyBz
ZW1hbnRpY3Mgb3INCm5vdCwgYnV0IHRoYXQgc2hvdWxkIGJlIGRpY3RhdGVkIGJ5IHRoZSByZXF1
aXJlbWVudHMgb2YgdGhlIHVzZSBjYXNlLg0KDQpBcyBmb3IgdGhlICJoYXJkIGxpbmsgb24gdG9w
IG9mIGl0c2VsZiIsIHRoYXQgY2FzZSBpcyBhbHJlYWR5IHdlbGwNCmRlZmluZWQgYnkgUE9TSVgg
dG8gYmUgYSBudWxsIG9wIElJUkMuDQoNCldoYXQgaW4gdGhlIHByb3Bvc2FsIGlzIHJlcXVpcmlu
ZyBuZXcgc2VtYW50aWNzIGJleW9uZCB0aGVzZSBwcmVjZWRlbnRzDQphbHJlYWR5IHNldCBieSBv
cGVuKCkgYW5kIGxpbmsoKSBpdHNlbGY/DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K
