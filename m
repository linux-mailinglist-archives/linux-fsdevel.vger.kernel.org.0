Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5AC69881
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 17:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfGOPot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 11:44:49 -0400
Received: from mail-eopbgr800075.outbound.protection.outlook.com ([40.107.80.75]:39488
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730257AbfGOPot (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:44:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8hy4etxacvzqFWy9OvzYQBeASyMkUdHiNPXEUK0Yrpr/kYGRFsp+KoCDC3SstEq5DbFBcjB9gR6wG7/sgumWbHnPtnboWfqyuP5ZbVNGdKLb+FvOBXBxUNN6/4kHvZ8jeb33IP/31gGzZw4ZsEwEa1R3T5eBb9NknuGOlbBG3usThtcOgz85jibe5/8rnPeu41pzu1SVYcQKAnfIuYX0jDmbzY0nixcDrG24zCfenAkiJEJ/SyUD9RhKxKbvqIcvF8X1QcODH4n6lRFnXM4CaxrAPzTFUry+nIb+hlgyNMw4IZg7nQ57OOYgMJy/gBNNtRXjpPzJj7+sAtia0oDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkm7TlCflg2h/1CDmf+8ktI4jTUVpUIqS9NvG32ss0E=;
 b=Q3TEMDGLmrzHkZNfYET3SxOeYOxs2dRsO9RULb7ewz7RMTGJ+Rwj7l5VuWJ3sykW9mBNazOFoHAbGFIeZpZRol8o9NKjN3rA4+vo3yM8YdiDnHpOOUeLRkCVq3CGYYGGD4GtdA8YZuC6myjDWMzk+4Y5spMVR7fGIyH8L3VDtypVJghLWZ1/gc//8Jnt2AvA3aEAQxGyN/Rylv3kBPGh2L4AByOirtbx8U7XRtz37ednZ2m0kQhRH++QdIzThvX68yW7mu55/gq0qvmumZGudNE400tRgKxC3CbTT2Sjcu/bFMggxH78VrGcfUYAxgg+jbf90ej3y/S7LUXUtH7E4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkm7TlCflg2h/1CDmf+8ktI4jTUVpUIqS9NvG32ss0E=;
 b=bj7U5cnIW6AfdWq+we005xBQxadaCFpeY1/gm0mdbZAGbud9J1i+DMw94xDsCBNkecLNcStk4a79Q73ZzEJHWsVVxjFhx3RMyMdQhr5hCq6kMgTfkZprPI2ACy+3hLPrDlnEbBeWiEBN26+P+om8Giw9py2CgGszqpA3q/dczUA=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB4220.namprd12.prod.outlook.com (10.141.187.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Mon, 15 Jul 2019 15:44:45 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 15:44:45 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Christoph Hellwig <hch@lst.de>, Halil Pasic <pasic@linux.ibm.com>
CC:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
Thread-Topic: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
Thread-Index: AQHVOHSFvIHUoc7V+E67qRA9cO0Ig6bG9RYAgACTIICABDL6gIAAB6aAgAAUsAA=
Date:   Mon, 15 Jul 2019 15:44:45 +0000
Message-ID: <56b79040-257b-3a89-c9d2-5842594cad17@amd.com>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
 <20190712053631.9814-4-bauerman@linux.ibm.com>
 <20190712150912.3097215e.pasic@linux.ibm.com>
 <87tvbqgboc.fsf@morokweng.localdomain>
 <20190715160317.7e3dfb33.pasic@linux.ibm.com> <20190715143039.GA6892@lst.de>
In-Reply-To: <20190715143039.GA6892@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0093.namprd12.prod.outlook.com
 (2603:10b6:802:21::28) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d1b8e82-6d74-4a39-35fb-08d7093b5c1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB4220;
x-ms-traffictypediagnostic: DM6PR12MB4220:
x-microsoft-antispam-prvs: <DM6PR12MB42209CF912174AD934AC70A3ECCF0@DM6PR12MB4220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(8936002)(305945005)(14454004)(14444005)(186003)(256004)(26005)(478600001)(81166006)(68736007)(8676002)(7736002)(36756003)(81156014)(2616005)(31686004)(446003)(54906003)(6246003)(11346002)(316002)(99286004)(476003)(486006)(6486002)(53936002)(6512007)(6436002)(7416002)(102836004)(53546011)(110136005)(66066001)(3846002)(6116002)(386003)(2906002)(6506007)(76176011)(52116002)(66446008)(5660300002)(66946007)(64756008)(66556008)(66476007)(71200400001)(71190400001)(86362001)(31696002)(4326008)(25786009)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4220;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2o3CgTK+bX0s2m1XSegvscLbDT6F58lpElIkDqZpZU26BvxzZNhleRjrqJv+HR0G8yUEdUOAN/zrpN3wnXm8EsKQPjXZMjOg2pGr9PoQP0vj77hYLrd6xq6CQx2B3FqvB78bXjK8CcfgkOa09BP5acePv1z4g/E3srFrQpXB/KOtBk3wjjy0bLrrDM8HrbRwElah4N2CuXJjgPBgesiawmgYzTlTAOXBzkWlLiWtFW8zftxNcjxnwGoAluVWm1encfoKx+VbBFdTTE7WQGF7ZvllMOJ5pUVuvuz9VHBMPRuJ12gIVN329z9BgoKX+16C8lgd2Fj4hey4LFDJrfFkkawpVI/j8bumX2zjDjpROooNyoE1qxBXbVokIXRpQXaX+vfqU0O4RF0dobkMpFj87nq1Yh8t4LQqQY7X//6OuzY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0FC09AEBDB7CF40BCF8F08977DC2498@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1b8e82-6d74-4a39-35fb-08d7093b5c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 15:44:45.1446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy8xNS8xOSA5OjMwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gTW9uLCBK
dWwgMTUsIDIwMTkgYXQgMDQ6MDM6MTdQTSArMDIwMCwgSGFsaWwgUGFzaWMgd3JvdGU6DQo+Pj4g
SSB0aG91Z2h0IGFib3V0IHRoYXQgYnV0IGNvdWxkbid0IHB1dCBteSBmaW5nZXIgb24gYSBnZW5l
cmFsIGNvbmNlcHQuDQo+Pj4gSXMgaXQgImd1ZXN0IHdpdGggbWVtb3J5IGluYWNjZXNzaWJsZSB0
byB0aGUgaG9zdCI/DQo+Pj4NCj4+DQo+PiBXZWxsLCBmb3JjZV9kbWFfdW5lbmNyeXB0ZWQoKSBp
cyBhIG11Y2ggYmV0dGVyIG5hbWUgdGhhdG4gc2V2X2FjdGl2ZSgpOg0KPj4gczM5MCBoYXMgbm8g
QU1EIFNFViwgdGhhdCBpcyBzdXJlLCBidXQgZm9yIHZpcnRpbyB0byB3b3JrIHdlIGRvIG5lZWQg
dG8NCj4+IG1ha2Ugb3VyIGRtYSBhY2Nlc3NpYmxlIHRvIHRoZSBoeXBlcnZpc29yLiBZZXMsIHlv
dXIgImd1ZXN0IHdpdGggbWVtb3J5DQo+PiBpbmFjY2Vzc2libGUgdG8gdGhlIGhvc3QiIHNob3dz
IGludG8gdGhlIHJpZ2h0IGRpcmVjdGlvbiBJTUhPLg0KPj4gVW5mb3J0dW5hdGVseSBJIGRvbid0
IGhhdmUgdG9vIG1hbnkgY3ljbGVzIHRvIHNwZW5kIG9uIHRoaXMgcmlnaHQgbm93Lg0KPiANCj4g
SW4geDg2IGl0IG1lYW5zIHRoYXQgd2UgbmVlZCB0byByZW1vdmUgZG1hIGVuY3J5cHRpb24gdXNp
bmcNCj4gc2V0X21lbW9yeV9kZWNyeXB0ZWQgYmVmb3JlIHVzaW5nIGl0IGZvciBETUEgcHVycG9z
ZXMuICBJbiB0aGUgU0VWDQo+IGNhc2UgdGhhdCBzZWVtcyB0byBiZSBzbyB0aGF0IHRoZSBoeXBl
cnZpc29yIGNhbiBhY2Nlc3MgaXQsIGluIHRoZSBTTUUNCj4gY2FzZSB0aGF0IFRvbSBqdXN0IGZp
eGVzIGl0IGlzIGJlY2F1c2UgdGhlcmUgaXMgYW4gZW5jcnlwdGVkIGJpdCBzZXQNCj4gaW4gdGhl
IHBoeXNpY2FsIGFkZHJlc3MsIGFuZCBpZiB0aGUgZGV2aWNlIGRvZXNuJ3Qgc3VwcG9ydCBhIGxh
cmdlDQo+IGVub3VnaCBETUEgYWRkcmVzcyB0aGUgZGlyZWN0IG1hcHBpbmcgY29kZSBoYXMgdG8g
ZW5jcnlwdCB0aGUgcGFnZXMNCj4gdXNlZCBmb3IgdGhlIGNvbnRpZ291cyBhbGxvY2F0aW9uLg0K
DQpKdXN0IGEgY29ycmVjdGlvbi9jbGFyaWZpY2F0aW9uLi4uDQoNCkZvciBTTUUsIHdoZW4gYSBk
ZXZpY2UgZG9lc24ndCBzdXBwb3J0IGEgbGFyZ2UgZW5vdWdoIERNQSBhZGRyZXNzIHRvDQphY2Nv
bW1vZGF0ZSB0aGUgZW5jcnlwdGlvbiBiaXQgYXMgcGFydCBvZiB0aGUgRE1BIGFkZHJlc3MsIHRo
ZSBkaXJlY3QNCm1hcHBpbmcgY29kZSBoYXMgdG8gcHJvdmlkZSB1bi1lbmNyeXB0ZWQgcGFnZXMu
IEZvciB1bi1lbmNyeXB0ZWQgcGFnZXMsDQp0aGUgRE1BIGFkZHJlc3Mgbm93IGRvZXMgbm90IGlu
Y2x1ZGUgdGhlIGVuY3J5cHRpb24gYml0LCBtYWtpbmcgaXQNCmFjY2VwdGFibGUgdG8gdGhlIGRl
dmljZS4gU2luY2UgdGhlIGRldmljZSBpcyBub3cgdXNpbmcgYSBETUEgYWRkcmVzcw0Kd2l0aG91
dCB0aGUgZW5jcnlwdGlvbiBiaXQsIHRoZSBwaHlzaWNhbCBhZGRyZXNzIGluIHRoZSBDUFUgcGFn
ZSB0YWJsZQ0KbXVzdCBtYXRjaCAodGhlIGNhbGwgdG8gc2V0X21lbW9yeV9kZWNyeXB0ZWQpIHNv
IHRoYXQgYm90aCB0aGUgZGV2aWNlIGFuZA0KdGhlIENQVSBpbnRlcmFjdCBpbiB0aGUgc2FtZSB3
YXkgd2l0aCB0aGUgbWVtb3J5Lg0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4+IEJlaW5nIG9uIGNj
IGZvciB5b3VyIHBhdGNoIG1hZGUgbWUgcmVhbGl6ZSB0aGF0IHRoaW5ncyBnb3QgYnJva2VuIG9u
DQo+PiBzMzkwLiBUaGFua3MhIEkndmUgc2VudCBvdXQgYSBwYXRjaCB0aGF0IGZpeGVzIHByb3R2
aXJ0LCBidXQgd2UgYXJlIGdvaW5nDQo+PiB0byBiZW5lZml0IGZyb20geW91ciBjbGVhbnVwcy4g
SSB0aGluayB3aXRoIHlvdXIgY2xlYW51cHMgYW5kIHRoYXQgcGF0Y2gNCj4+IG9mIG1pbmUgYm90
aCBzZXZfYWN0aXZlKCkgYW5kIHNtZV9hY3RpdmUoKSBjYW4gYmUgcmVtb3ZlZC4gRmVlbCBmcmVl
IHRvDQo+PiBkbyBzby4gSWYgbm90LCBJIGNhbiBhdHRlbmQgdG8gaXQgYXMgd2VsbC4NCj4gDQo+
IFllcywgSSB0aGluayB3aXRoIHRoZSBkbWEtbWFwcGluZyBmaXggYW5kIHRoaXMgc2VyaWVzIHNt
ZV9hY3RpdmUgYW5kDQo+IHNldl9hY3RpdmUgc2hvdWxkIGJlIGdvbmUgZnJvbSBjb21tb24gY29k
ZS4gIFdlIHNob3VsZCBhbHNvIGJlIGFibGUNCj4gdG8gcmVtb3ZlIHRoZSBleHBvcnRzIHg4NiBo
YXMgZm9yIHRoZW0uDQo+IA0KPiBJJ2xsIHdhaXQgYSBmZXcgZGF5cyBhbmQgd2lsbCB0aGVuIGZl
ZWQgdGhlIGRtYS1tYXBwaW5nIGZpeCB0byBMaW51cywNCj4gaXQgbWlnaHQgbWFrZSBzZW5zZSB0
byBlaXRoZXIgcmViYXNlIFRoaWFnb3Mgc2VyaWVzIG9uIHRvcCBvZiB0aGUNCj4gZG1hLW1hcHBp
bmcgZm9yLW5leHQgYnJhbmNoLCBvciB3YWl0IGEgZmV3IGRheXMgYmVmb3JlIHJlcG9zdGluZy4N
Cj4gDQo=
