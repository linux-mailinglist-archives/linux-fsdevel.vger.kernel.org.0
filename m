Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4ED25391C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 22:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHZU2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 16:28:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10685 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZU2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:28:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f46c5a00001>; Wed, 26 Aug 2020 13:27:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Aug 2020 13:28:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Aug 2020 13:28:15 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Aug
 2020 20:28:14 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 26 Aug 2020 20:28:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgjlfkmCMiSrARlQmjNLLsBfEHDKXqYKvMrOmPLJjG2zUz47+P/Cfsf1N+A9hPrkPW3+knsqovYp4THusVDaCXq/O/EUl5Nv3IUE4hwUpBBk3B2patpj1033IFAlc55o/3gPNZ/HkNNCuLdTRa//c7tnWGJ5Td/HvN3mBoqKM5WPI8lF8jDoAdfjtV5ESDU93ZvCQoFmPxJvVFZUB9Ew9uSrGQ60Oclj5HzLZ1L0K5islT6vt/dbrx61a4ziAZMQBN9W2KQx/6tMuApOYB4EJCVJH/0IvmYFHRNzEw1GcfIT1ybQHnQzXkbay52gZDbXRvVVAOMlRfnL4+KhBL0Zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJWsBXOk0aD6ldTvyiEaUbyFfX1QABdfGbvSn0J6Xt4=;
 b=LuUg0npgI7g6syQC7cb2OXyTJ9zwG8zM/YW6Z5OsV/osZdkzlE7JleyXYYGsZ9Q2H3faHTj3cMPki8Bqen+h6A8pGo6UAiKdz+3SNphkil9LB7YULiDXhj1HI1c0pVLT/SRQx6sEqBUpW/fBoUJcintlof2d/IA42L3SjKy0hUMD5X9YcA9a7hLCOfNfWb4m4uxu+DnkFxF8RnPJOeZS0dC1JT8IWEmNb4Ds/lHA8dWOBTKdeqNQCskSAg60mPWbwX2wd0r6yKDHFH7qyGkoFv7iYuAR92cySBMxdyWKVfnk2a4OMaFMbJnJWHPpQ/T9I1Z+iDQM6mIigmQ2659mbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3385.namprd12.prod.outlook.com (2603:10b6:5:39::16) by
 DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Wed, 26 Aug 2020 20:28:13 +0000
Received: from DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::c896:55c1:677e:45f]) by DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::c896:55c1:677e:45f%3]) with mapi id 15.20.3326.019; Wed, 26 Aug 2020
 20:28:13 +0000
From:   Ken Schalk <kschalk@nvidia.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [fuse-devel] Cross-host entry caching and file open/create
Thread-Topic: [fuse-devel] Cross-host entry caching and file open/create
Thread-Index: AdZ2cgXArydRfBZsQFmRYJ9twGDRZwBYJUoAAQSxwqA=
Date:   Wed, 26 Aug 2020 20:28:13 +0000
Message-ID: <DM6PR12MB33856CB9CC50BE5D7E9B436DDD540@DM6PR12MB3385.namprd12.prod.outlook.com>
References: <DM6PR12MB33857B8B2E49DF0DD0C4F950DD5D0@DM6PR12MB3385.namprd12.prod.outlook.com>
 <CAJfpegu6-hKCdEiZxb9KrZUrMT_UozjaWC5qY00xwqqopb=1SA@mail.gmail.com>
In-Reply-To: <CAJfpegu6-hKCdEiZxb9KrZUrMT_UozjaWC5qY00xwqqopb=1SA@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=kschalk@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-08-26T20:28:11.2394972Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=10745070-db93-4da8-a678-34fb6a9e3bec;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: szeredi.hu; dkim=none (message not signed)
 header.d=none;szeredi.hu; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [12.46.106.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4553a6f7-ce14-42d0-6016-08d849fe8e8a
x-ms-traffictypediagnostic: DM6PR12MB4074:
x-microsoft-antispam-prvs: <DM6PR12MB4074EF9BF6773A7485D7E51EDD540@DM6PR12MB4074.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pqY18Vz2gXWd3uFxc/LF6H6wBDW3pwDzxUcWi3+DA8w3toCoJE2zhmfSA3dVA64LTt5haXB2K5//BEsQOgb3oRU1nNeFkEE/w18+5/xpIUzXKtEe6REcu70lrvm8us6Bi+liuv83jXfk+HCxeaqFVkKkC+k5h8ri3xwp2bExA7tn4AorIauoXT9FXOLKqPCjwEyNv+sCCoUKvCgXlReLWN+eGwqdSqOWYE7r3GCVYayrwTqYZEE2JeuhAvh/S6FJDOBzHqS6L/Jz67YFeLp1ngSLT7S5lMYYqdydQSZX0BC2g+jc1BuOnlqxVSVithrW0UaZkVGikOclEiTdM37hfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3385.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(2906002)(478600001)(4326008)(33656002)(83380400001)(52536014)(76116006)(66556008)(66476007)(71200400001)(64756008)(66446008)(66946007)(66616009)(8676002)(316002)(86362001)(5660300002)(8936002)(9686003)(186003)(6916009)(7696005)(6506007)(53546011)(26005)(54906003)(55016002)(99936003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Q3DQPLvSyS0IkRaWyZ7QX8Ly1OpyX4gLuRz3njlDdHntB2mpge7veAO4CRe054+G5epH7iehqQ0z7GmS0MvBC6M3rFboNbwJpEE4uZC6fzP+iqwNoOodj5ieGeqPQwkDjk0yM6Rejp2GQZcw9QZtZW2P13U/yMaYFND0C6YaGstj8RKWunOOOD3JnMXWwgvNUaPKn09/dW5rPJ3jVbcuBIkVo2DAsh9Hu+Cmq1ZxPhoA39zO1LGOAtKwTsM3cF4yZyO/lWCG4qtZ6/FfcvybUSZlsntb5moIruYrzKMmIB4A+l7vnlqYO5LiOfNMOROSzppfNb1tLIbqwEbF2iNzhC+HR7JcC9C4EdfLycF4gdPG2FAgXsC/CiMOcCGu/P5oXpl/LBGN7ult09BzcSOIb4tXf+g32XowGM8oV80Zd8JkVpAjYvga53gd67ot4Gdn2TN+pxqJn8fUuH0QThB9Jn3Cg3ZLtFuD3ltU8YuCAADKJ50h5QMkxOneRc0I0/33SDXrlIECZZZqdXYv/qNL/oG+hDVKpJofmzZmlQZ4Hs11cnlv0BsuoHXf0Ykd6aVLTNg4MbkNDVA6E3gKbjKoBix0clsU5UOXN0GTWa+rJ0mTLEbUSC8BpYIcLENFsGJudHAgslL8ohNjtCWqOjXPFg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3385.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4553a6f7-ce14-42d0-6016-08d849fe8e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 20:28:13.3400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sXRjuFtyBYwz68JO99VvtlcpsKaEjHKMs18QZ4q4Wuxi4m9eX4PyHaqScTy1ByxypyFlZAcZ8Ym48ICL+qY4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: multipart/mixed;
        boundary="_002_DM6PR12MB33856CB9CC50BE5D7E9B436DDD540DM6PR12MB3385namp_"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598473632; bh=IJWsBXOk0aD6ldTvyiEaUbyFfX1QABdfGbvSn0J6Xt4=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:x-ms-exchange-transport-forked:
         MIME-Version:X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type;
        b=DdmELfjOIq6OLv4GTKLYaZzV/cyYROUHrwNEqYkCydEWRsSF6xzE05Sr7UyIim31R
         gQwBDN+lQUBTQOXD5DOSRBy37CG+FnujP+hzyAggPVltFfjowtsPK6A3xIEfyED8Z/
         axx0Ng4HxLtSXPyjA3yeuE3V5L0wvWjLKx55K+UUM1ozSc8Uor1VPK7DhHTQjWhx8R
         Piy95rqd9q2s3Gd/UZ8hnFUIDQkr6AYiYwrU/3iG+HUyjV9/vQhzXiKK4l54Yfi8SR
         YDsB4jzAhPFVOZBBtzyrhPK5044sxrmN3jDv+4j7oCEyS49tSKyrJ6lGk6JhGKsBYe
         25zky9uNn/B6w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_DM6PR12MB33856CB9CC50BE5D7E9B436DDD540DM6PR12MB3385namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gQXVnIDIxLCAyMDIwIE1pa2xvcyBTemVyZWRpIDxtaWtsb3NAc3plcmVkaS5odT4gd3JvdGU6
DQo+IE9uIFRodSwgQXVnIDIwLCAyMDIwIGF0IDEyOjI0IEFNIEtlbiBTY2hhbGsgPGtzY2hhbGtA
bnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gSWYgdGhlIG9wZW4gZmxhZ3MgaW5jbHVkZSBPX0VYQ0ws
IHRoZW4gd2UncmUgc2VlaW5nIGEgZmFpbHVyZSB3aXRoDQo+ID4gRUVYSVNUIHdpdGhvdXQgYW55
IGNhbGwgdG8gb3VyIEZVU0UgZmlsZXN5c3RlbSdzIGNyZWF0ZSBvcGVyYXRpb24gKG9yDQo+ID4g
YW55IG90aGVyIEZVU0Ugb3BlcmF0aW9ucykuICBUaGUga2VybmVsIG1ha2VzIHRoaXMgZmFpbHVy
ZSBkZWNpc2lvbg0KPiA+IGJhc2VkIG9uIGl0cyBjYWNoZWQgaW5mb3JtYXRpb24gYWJvdXQgdGhl
IHByZXZpb3VzbHkgYWNjZXNzZWQgKG5vdw0KPiA+IGRlbGV0ZWQpIGZpbGUuICBJZiB0aGUgb3Bl
biBmbGFncyBkbyBub3QgaW5jbHVkZSBPX0VYQ0wsIHRoZW4gd2UncmUNCj4gPiBzZWVpbmcgYSBm
YWlsdXJlIHdpdGggRU5PRU5UIGZyb20gb3VyIG9wZW4gb3BlcmF0aW9uIChiZWNhdXNlIHRoZSBm
aWxlDQo+ID4gZG9lcyBub3QgYWN0dWFsbHkgZXhpc3QgYW55bW9yZSksIHdpdGggbm8gY2FsbCB0
byBvdXIgY3JlYXRlIG9wZXJhdGlvbg0KPiA+IChiZWNhdXNlIHRoZSBrZXJuZWwgYmVsaWV2ZWQg
dGhhdCB0aGUgZmlsZSBleGlzdGVkLCBjYXVzaW5nIGl0IHRvIG1ha2UNCj4gPiBhIEZVU0Ugb3Bl
biByZXF1ZXN0IHJhdGhlciB0aGFuIGEgRlVTRSBjcmVhdGUgcmVxdWVzdCkuDQoNCj4gRG9lcyB0
aGUgYXR0YWNoZWQgcGF0Y2ggZml4IGl0Pw0KDQpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGhl
bHAuICBUaGUgcGF0Y2ggeW91IHByb3ZpZGVkIGRvZXMgc29sdmUgdGhlDQpwcm9ibGVtIGluIHRo
ZSBPX0NSRUFUfE9fRVhDTCBjYXNlIChieSBtYWtpbmcgYSBsb29rdXAgY2FsbCB0bw0KcmUtdmFs
aWRhdGUgdGhlIGVudHJ5IG9mIHRoZSBzaW5jZSBkZWxldGVkIGZpbGUpLCBidXQgbm90IGluIHRo
ZQ0KT19DUkVBVCBjYXNlLiAgKEluIHRoYXQgY2FzZSB0aGUga2VybmVsIHN0aWxsIHdpbmRzIHVw
IG1ha2luZyBhIEZVU0UNCm9wZW4gcmVxdWVzdCByYXRoZXIgdGhhbiBhIEZVU0UgY3JlYXRlIHJl
cXVlc3QuKSAgSSdkIGxpa2UgdG8gc3VnZ2VzdA0KdGhlIHNsaWdodGx5IGRpZmZlcmVudCBhdHRh
Y2hlZCBwYXRjaCBpbnN0ZWFkLCB3aGljaCB0cmlnZ2Vycw0KcmUtdmFsaWRhdGlvbiBpbiBib3Ro
IGNhc2VzLg0KDQpJIHdvbmRlciBpZiBtYXliZSByZS12YWxpZGF0aW9uIHNob3VsZCBiZSB0cmln
Z2VyZWQgb24gTE9PS1VQX09QRU4gYXMNCndlbGwsIGJ1dCBJIHN1c3BlY3QgdGhhdCBtaWdodCBo
YXZlIG1vcmUgaW1wbGljYXRpb25zIEkgaGF2ZW4ndA0KZGlzY292ZXJlZC4NCg0KLS1LZW4gU2No
YWxrDQo=

--_002_DM6PR12MB33856CB9CC50BE5D7E9B436DDD540DM6PR12MB3385namp_
Content-Type: application/octet-stream; name="fuse-reval-create.patch"
Content-Description: fuse-reval-create.patch
Content-Disposition: attachment; filename="fuse-reval-create.patch"; size=513;
	creation-date="Wed, 26 Aug 2020 20:13:24 GMT";
	modification-date="Wed, 26 Aug 2020 20:13:24 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMgYi9mcy9mdXNlL2Rpci5jCmluZGV4IDI2ZjAyOGIu
LjE1NjVlMTkgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZGlyLmMKKysrIGIvZnMvZnVzZS9kaXIuYwpA
QCAtMjA0LDcgKzIwNCw3IEBAIHN0YXRpYyBpbnQgZnVzZV9kZW50cnlfcmV2YWxpZGF0ZShzdHJ1
Y3QgZGVudHJ5ICplbnRyeSwgdW5zaWduZWQgaW50IGZsYWdzKQogCWlmIChpbm9kZSAmJiBpc19i
YWRfaW5vZGUoaW5vZGUpKQogCQlnb3RvIGludmFsaWQ7CiAJZWxzZSBpZiAodGltZV9iZWZvcmU2
NChmdXNlX2RlbnRyeV90aW1lKGVudHJ5KSwgZ2V0X2ppZmZpZXNfNjQoKSkgfHwKLQkJIChmbGFn
cyAmIExPT0tVUF9SRVZBTCkpIHsKKyAgICAgICAgICAgICAgICAoZmxhZ3MgJiAoTE9PS1VQX0NS
RUFURSB8IExPT0tVUF9SRVZBTCkpKSB7CiAJCXN0cnVjdCBmdXNlX2VudHJ5X291dCBvdXRhcmc7
CiAJCUZVU0VfQVJHUyhhcmdzKTsKIAkJc3RydWN0IGZ1c2VfZm9yZ2V0X2xpbmsgKmZvcmdldDsK

--_002_DM6PR12MB33856CB9CC50BE5D7E9B436DDD540DM6PR12MB3385namp_--
