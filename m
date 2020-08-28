Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36C3256253
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 23:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgH1VBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 17:01:39 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:54515 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgH1VBg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 17:01:36 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4970ac0000>; Sat, 29 Aug 2020 05:01:32 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 28 Aug 2020 14:01:32 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 28 Aug 2020 14:01:32 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 21:01:32 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 28 Aug 2020 21:01:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEUYRP57gwAaGDe5IvOqh3Hx/aE2pruK/j9UvNnJO/rb4pRqHLLACZNYB8QKP409QaMW2nQxs5pZocYaN+GmQBw7UVthpd7aG4lKUfFmJLLtaFA5jNJftRIY0hDb9XvYlfmmqm4TN8XGqgKahSCF1TERjGGegqODQ6Rysm/Ya86zr5pCMABG1q/VvD+X3wB4J1eIV5YXorBPJmPyuwwaSxqvyyPXz8pmecl672TpBl96X21YaJLm3a0Urs027hC0ka32MCN0U95ATEZJc3FPG636/JOfWrNBgnJx3CcbcCP5N8ewbddntGisRgK97E2kyp7zMliv9pir89Il/b5FbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN3i4IoumTfcKQauie/oiN/pXTeUUH2VI9HFbwlhXU4=;
 b=PUjsRf/PYtthUpJ2tgfJEvDU8NZWxg9KuVVxd4sWjR1NqNUa53Y1VLtEqm6wYmO+AzTtHDE3/H4hf295wfBISk/H8z2MDs/4rmdrrbJ/2PsZZINwhI7jRFi9qE6/sEgvJRiC0IkEcMphLmbQDBtXpWNyJy3iK+AejpmJM4DheIzWY1lOXdjh/i12qoptyQ31fkjpnqNd9d/qwZnH89cEYlsbAN1cqkZ7NlBbbTHpP6rIpw1iUU8e0EAICtM6Fk5Sdw5bGhwaKEfqar/z0eRnRb5fyOXrNS/LIn4SpaVcO6kmxr44us6WI0GCQY4RmeQAhVreU1OCvQR1FqEEjZNA4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3385.namprd12.prod.outlook.com (2603:10b6:5:39::16) by
 DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Fri, 28 Aug 2020 21:01:29 +0000
Received: from DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::c896:55c1:677e:45f]) by DM6PR12MB3385.namprd12.prod.outlook.com
 ([fe80::c896:55c1:677e:45f%3]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 21:01:29 +0000
From:   Ken Schalk <kschalk@nvidia.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [fuse-devel] Cross-host entry caching and file open/create
Thread-Topic: [fuse-devel] Cross-host entry caching and file open/create
Thread-Index: AdZ2cgXArydRfBZsQFmRYJ9twGDRZwBYJUoAAQSxwqAAZXXxAA==
Date:   Fri, 28 Aug 2020 21:01:29 +0000
Message-ID: <DM6PR12MB3385C2556A59B3F33FE8B980DD520@DM6PR12MB3385.namprd12.prod.outlook.com>
References: <DM6PR12MB33857B8B2E49DF0DD0C4F950DD5D0@DM6PR12MB3385.namprd12.prod.outlook.com>
 <CAJfpegu6-hKCdEiZxb9KrZUrMT_UozjaWC5qY00xwqqopb=1SA@mail.gmail.com>
 <DM6PR12MB33856CB9CC50BE5D7E9B436DDD540@DM6PR12MB3385.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB33856CB9CC50BE5D7E9B436DDD540@DM6PR12MB3385.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: d2b94f51-8931-4500-048a-08d84b95892d
x-ms-traffictypediagnostic: DM6PR12MB4076:
x-microsoft-antispam-prvs: <DM6PR12MB407610F0DA06865EF3E6CFC1DD520@DM6PR12MB4076.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kaVN9jRRuIjdTLQoCLgJV2iT48654IJAMieSDZqQR9NnDtUwstZMNybZHti4oJ77VF8mrcB7RDRa5/5GAuAIosqWWeZ6pvLLrMR0OVevX1KTRLRcYEp7/XmB/jcwANA2QGa0X/wfnkefBVSx7wp2NG2v0AtuJRiuQeZoPW4eKplNTGEYW0HaVfnTdEzkHoBmKH8Xi2AexkOxS0mmQaXMulkgqf35QgagCo1yU1ZoUsL/NrnQ46NVuni0iqDBXq8kZ+Sgencvf5e7ii6mCYeyiz0DH/b2baTwF5F7U/kZAHJqXsm4uD8FHY8u1mhnwMDVB2Oz8vun9++62o1FDtpVQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3385.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(478600001)(71200400001)(6916009)(4326008)(7696005)(6506007)(64756008)(66556008)(66446008)(53546011)(99936003)(2906002)(186003)(66946007)(66616009)(26005)(83380400001)(54906003)(5660300002)(8936002)(8676002)(55016002)(76116006)(66476007)(52536014)(316002)(33656002)(86362001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EPaq2Ruiy/hMAG5ToHaCCGIZ7kAn8zBcL8uWNssH4SR47XhxzFT9ugxpWIg6GvKN6X5pffTbE83UggI5IMHCV0te++pgTYiCQVhUqKmTCNDDNDrebNmysfikn65UwH0HIPB+mPcKRHyuvz6Xx94c+I2Naf7iotTytRzDqU0Q3MdPdX0j2LLdEqa4i+EntEIsX91H3buJ6qyMVFJjCcHt+vV1v8QwSLhaXUbQ8P6OINTD2UwDMVFFvdL7Wvdl5yHdQnsFULWQWbfhDjLcqa70coJz9TRKXI0QvleS3JsNzxENWC2J79ic6yIf4HUuIju3LwzS/icK5VnhRC5o3hkY3bgCg8IAXdTJxK7EnytdI9tFkl58WecJ0D5i/X3wz3W/qZEHJZWXyVU3Dyk/q1LYMa80mfHuzodWGwz+GIRGgdXWyUsVlqMgwgf7DGZvAaaMtV1PAhTqCRmm2kYafaDACXlvz0I3OZlNs6og6OlFD2a9qFU6rfwuh6le/A0AbasIMyo8r8bp9StkZ+mXkqwZeTD2WGSJkuxhYkaMr8G8dSwB+Ycv4DuJUWZAPQUOA8X5BXI4iLKSFa3YgpcYlrHKKda53JtFH2kGboaCv6dgrkRWmXfBqr4+NSf9uhmPRTglN8kcjcmn8WNmHz1M/3TPWA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3385.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b94f51-8931-4500-048a-08d84b95892d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 21:01:29.4415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o21cIV+9r7XoZM+k6feIDJn10jkUVasI35pM7bOabEVIkw+srlHimDU53lIPdFd6ujBwFlvJNz00X6ZTLwVSnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: multipart/mixed;
        boundary="_002_DM6PR12MB3385C2556A59B3F33FE8B980DD520DM6PR12MB3385namp_"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598648492; bh=gN3i4IoumTfcKQauie/oiN/pXTeUUH2VI9HFbwlhXU4=;
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
        b=GzXEkTPn1HGRN79BB+qRwAAh3LmXA92ftk9sarloCLCbRbYJfn0t38WOKdRsQ0lYw
         JqRrpcd4Pl+z+h6mepOeDkyqumUKWMG3ezLO6kykHM4QSBW7EBjAx1sdBzwGBO8saK
         fctfJmBOf0eSyu3t4srMQh/I0safD7V6ngBCc+Jr147BG4JEOoW+HjkQX87RIgM5lJ
         zqPSGDPvGM+wKGuax8STfZZUjtX5QklWQ9xKzM8aVFHGdVsb9kfYQ4DouFHNMG4SPw
         6ZWXKHLhHLZdTzhsIK9XvZiCEqg2E1psrQbomGuwLq/Pc4CvN3iNeb9FCIOQNol7Es
         xydfiFq5IGQwA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_DM6PR12MB3385C2556A59B3F33FE8B980DD520DM6PR12MB3385namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gQXVnIDI2LCAyMDIwIEtlbiBTY2hhbGsgPGtzY2hhbGtAbnZpZGlhLmNvbT4gd3JvdGU6DQo+
IE9uIEF1ZyAyMSwgMjAyMCBNaWtsb3MgU3plcmVkaSA8bWlrbG9zQHN6ZXJlZGkuaHU+IHdyb3Rl
Og0KPiA+IE9uIFRodSwgQXVnIDIwLCAyMDIwIGF0IDEyOjI0IEFNIEtlbiBTY2hhbGsgPGtzY2hh
bGtAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gPiBJZiB0aGUgb3BlbiBmbGFncyBpbmNsdWRlIE9f
RVhDTCwgdGhlbiB3ZSdyZSBzZWVpbmcgYSBmYWlsdXJlDQo+ID4gPiB3aXRoIEVFWElTVCB3aXRo
b3V0IGFueSBjYWxsIHRvIG91ciBGVVNFIGZpbGVzeXN0ZW0ncyBjcmVhdGUNCj4gPiA+IG9wZXJh
dGlvbiAob3IgYW55IG90aGVyIEZVU0Ugb3BlcmF0aW9ucykuICBUaGUga2VybmVsIG1ha2VzIHRo
aXMNCj4gPiA+IGZhaWx1cmUgZGVjaXNpb24gYmFzZWQgb24gaXRzIGNhY2hlZCBpbmZvcm1hdGlv
biBhYm91dCB0aGUNCj4gPiA+IHByZXZpb3VzbHkgYWNjZXNzZWQgKG5vdyBkZWxldGVkKSBmaWxl
LiAgSWYgdGhlIG9wZW4gZmxhZ3MgZG8NCj4gPiA+IG5vdCBpbmNsdWRlIE9fRVhDTCwgdGhlbiB3
ZSdyZSBzZWVpbmcgYSBmYWlsdXJlIHdpdGggRU5PRU5UIGZyb20NCj4gPiA+IG91ciBvcGVuIG9w
ZXJhdGlvbiAoYmVjYXVzZSB0aGUgZmlsZSBkb2VzIG5vdCBhY3R1YWxseSBleGlzdA0KPiA+ID4g
YW55bW9yZSksIHdpdGggbm8gY2FsbCB0byBvdXIgY3JlYXRlIG9wZXJhdGlvbiAoYmVjYXVzZSB0
aGUNCj4gPiA+IGtlcm5lbCBiZWxpZXZlZCB0aGF0IHRoZSBmaWxlIGV4aXN0ZWQsIGNhdXNpbmcg
aXQgdG8gbWFrZSBhIEZVU0UNCj4gPiA+IG9wZW4gcmVxdWVzdCByYXRoZXIgdGhhbiBhIEZVU0Ug
Y3JlYXRlIHJlcXVlc3QpLg0KDQo+ID4gRG9lcyB0aGUgYXR0YWNoZWQgcGF0Y2ggZml4IGl0Pw0K
DQo+IFRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHlvdXIgaGVscC4gIFRoZSBwYXRjaCB5b3UgcHJvdmlk
ZWQgZG9lcyBzb2x2ZQ0KPiB0aGUgcHJvYmxlbSBpbiB0aGUgT19DUkVBVHxPX0VYQ0wgY2FzZSAo
YnkgbWFraW5nIGEgbG9va3VwIGNhbGwgdG8NCj4gcmUtdmFsaWRhdGUgdGhlIGVudHJ5IG9mIHRo
ZSBzaW5jZSBkZWxldGVkIGZpbGUpLCBidXQgbm90IGluIHRoZQ0KPiBPX0NSRUFUIGNhc2UuICAo
SW4gdGhhdCBjYXNlIHRoZSBrZXJuZWwgc3RpbGwgd2luZHMgdXAgbWFraW5nIGEgRlVTRQ0KPiBv
cGVuIHJlcXVlc3QgcmF0aGVyIHRoYW4gYSBGVVNFIGNyZWF0ZSByZXF1ZXN0LikgIEknZCBsaWtl
IHRvDQo+IHN1Z2dlc3QgdGhlIHNsaWdodGx5IGRpZmZlcmVudCBhdHRhY2hlZCBwYXRjaCBpbnN0
ZWFkLCB3aGljaA0KPiB0cmlnZ2VycyByZS12YWxpZGF0aW9uIGluIGJvdGggY2FzZXMuDQoNCkkn
bSBnb2luZyB0byBtYWtlIG9uZSBhZGRpdGlvbmFsIHN1Z2dlc3Rpb24gaGVyZSwgaW5jbHVkZWQg
aW4gdGhlDQphdHRhY2hlZCBwYXRjaDogYWx3YXlzIHJlLXZhbGlkYXRlIGEgbmVnYXRpdmUgZW50
cnkgZm9yIGZpbGUgb3Blbi4NClRoaXMgaXMgc29ydCBvZiB0aGUgZHVhbCBvZiB0aGUgcHJvYmxl
bSBvZiBhIGZpbGUgcmVjZW50bHkgdW5saW5rZWQgb24NCmEgcmVtb3RlIGhvc3QsIGFzIGl0IGlu
dm9sdmVzIGEgZmlsZSByZWNlbnRseSBjcmVhdGVkIG9uIGEgcmVtb3RlDQpob3N0Lg0KDQpJZiB0
aGUga2VybmVsIGhhcyBjYWNoZWQgYSBuZWdhdGl2ZSBkZW50cnksIGl0IHdpbGwgZmFpbCBhbiBv
cGVuDQpzeXN0ZW0gY2FsbCB3aXRob3V0IGFueSBGVVNFIHJlcXVlc3RzIHVwIHRvIHRoZSB1c2Vy
LXNwYWNlIGVuZC4gIFRoaXMNCnBhdGNoIGdpdmVzIHRoZSB1c2VyLXNwYWNlIHNpZGUgdGhlIG9w
cG9ydHVuaXR5IHRvIHJlcG9ydCB0aGF0IGEgZmlsZQ0KdGhhdCBwcmV2aW91c2x5IGRpZCBub3Qg
ZXhpc3QgaGFzIHJlY2VudGx5IGJlZW4gY3JlYXRlZC4gIChJbg0KZGlzdHJpYnV0ZWQgYnVpbGQg
YXV0b21hdGlvbiB3b3JrbG9hZHMsIG9wZW5pbmcgYSBmaWxlIHJlY2VudGx5DQpjcmVhdGVkIHRo
cm91Z2ggYSBtb3VudCBvbiBhIHBlZXIgaG9zdCBpcyBwcmV0dHkgY29tbW9uLikgIEkgd291bGQg
c2F5DQp0aGF0IHRoaXMgYnJpbmdzIHRoZSBvcGVuIHN5c3RlbSBjYWxsIGJlaGF2aW9yIHVuZGVy
IEZVU0UgaW50byBsaW5lDQp3aXRoIHdoYXQgd2Ugb2JzZXJ2ZSBvbiBORlMgZm9yIGNhc2VzIHdo
ZXJlIGEgZmlsZSBoYXMgYmVlbiByZWNlbnRseQ0KY3JlYXRlZCBvciB1bmxpbmtlZCBvbiBhIHJl
bW90ZSBob3N0Lg0KDQotLUtlbiBTY2hhbGsNCg==

--_002_DM6PR12MB3385C2556A59B3F33FE8B980DD520DM6PR12MB3385namp_
Content-Type: application/octet-stream;
	name="fuse-reval-create-or-open-negative.patch"
Content-Description: fuse-reval-create-or-open-negative.patch
Content-Disposition: attachment;
	filename="fuse-reval-create-or-open-negative.patch"; size=567;
	creation-date="Fri, 28 Aug 2020 20:33:08 GMT";
	modification-date="Fri, 28 Aug 2020 20:33:08 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMgYi9mcy9mdXNlL2Rpci5jCmluZGV4IDI2ZjAyOGIu
LmM0ZDc2OGMgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZGlyLmMKKysrIGIvZnMvZnVzZS9kaXIuYwpA
QCAtMjA0LDcgKzIwNCw4IEBAIHN0YXRpYyBpbnQgZnVzZV9kZW50cnlfcmV2YWxpZGF0ZShzdHJ1
Y3QgZGVudHJ5ICplbnRyeSwgdW5zaWduZWQgaW50IGZsYWdzKQogCWlmIChpbm9kZSAmJiBpc19i
YWRfaW5vZGUoaW5vZGUpKQogCQlnb3RvIGludmFsaWQ7CiAJZWxzZSBpZiAodGltZV9iZWZvcmU2
NChmdXNlX2RlbnRyeV90aW1lKGVudHJ5KSwgZ2V0X2ppZmZpZXNfNjQoKSkgfHwKLQkJIChmbGFn
cyAmIExPT0tVUF9SRVZBTCkpIHsKKyAgICAgICAgICAgICAgICAoIWlub2RlICYmIChmbGFncyAm
IExPT0tVUF9PUEVOKSkgfHwKKyAgICAgICAgICAgICAgICAoZmxhZ3MgJiAoTE9PS1VQX0NSRUFU
RSB8IExPT0tVUF9SRVZBTCkpKSB7CiAJCXN0cnVjdCBmdXNlX2VudHJ5X291dCBvdXRhcmc7CiAJ
CUZVU0VfQVJHUyhhcmdzKTsKIAkJc3RydWN0IGZ1c2VfZm9yZ2V0X2xpbmsgKmZvcmdldDsK

--_002_DM6PR12MB3385C2556A59B3F33FE8B980DD520DM6PR12MB3385namp_--
