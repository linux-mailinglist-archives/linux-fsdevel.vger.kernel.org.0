Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2AC6D2BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 19:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfGRR0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 13:26:07 -0400
Received: from mail-eopbgr740043.outbound.protection.outlook.com ([40.107.74.43]:5584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfGRR0H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 13:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDOqJF02kqb+emk5Y2/iGaAP4q9BUSEmLdbfBCo1jsJRc6ekJw0/iFV8OKvaj9G5GiKDoU6F6NNleV9Pq6FwkZiC/RK45z1rEcpF5V93HbDpK/J3mQAlpn5ZLD/V4yzGQtrSIThk+xdW5fiF26XScooUh8AK+ZyVntBxdHRkA6cd8K1gAJ75MkDg9vW875wFJolg6Wv8jZ4wmslaT4qSBcUnhiVWOjYw04lRUqCckKX/4j3H4IU60isfhcbqJ3d+LmkYXk3Mv7HHGC7Bkt8mTy1kAeY9e8daFTgzoioFvxiaYCdHZ08JzRuFI0e81FByj0jOzFM8wuqxEcb5iwQdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNL9q5hnBoygndJR8ey0WtGHNhEHzH+qT9L2S+bFBcY=;
 b=V9aAkTZn4buQQYR4owGu46YeximctY3uvZQKPxc13npNK/1vzdwKxJLOr+kQ2gUJ5ml6+0lNtRGtqJG3xom3hbYf1aLR14Ws2uhX4MGBh0c884CMtoyOBRjfUgLGF+mPdjdcl7tSkvXMUrO+uLglZcVlXp/H9Vetrz/JuUAVReulJQQW30l2DoM8rQ9iL2dD5pwBcUG2/RGcaTghC4n27lWM1xZAPpppweBI+B/ymb8CA+GUNI1RIjdvkPU+klpYXwekowoGadgRXusP5Mfsv5ppyk7IaQQU4cov3okDacH0iZWtVgowK5W+4H1ettJrt/BZ13Yd7LlyCJqloCCoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNL9q5hnBoygndJR8ey0WtGHNhEHzH+qT9L2S+bFBcY=;
 b=em0188wfhZaK6eJecR3sefSeZ1dn++fQw+tgxMHFtCA7ILG3sumWAJz1vVye5S5zOIFPbNHpbi+AdHgdf0wy3K6NYT+L4ZT64ldXX7acGWsDDNjdWWPUGxDxaDj+I8cmVsnRe/Z4rq7jYF8G8yflbMgR2RKCpDFSMEqhSsPW4q0=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3452.namprd12.prod.outlook.com (20.178.198.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.12; Thu, 18 Jul 2019 17:26:02 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 17:26:02 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v3 2/6] swiotlb: Remove call to sme_active()
Thread-Topic: [PATCH v3 2/6] swiotlb: Remove call to sme_active()
Thread-Index: AQHVPRkEwUtZWv2UAU29jYa98DzoIKbQoYiA
Date:   Thu, 18 Jul 2019 17:26:02 +0000
Message-ID: <7708048b-cc92-debc-54ba-6b3ad353c5bb@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
 <20190718032858.28744-3-bauerman@linux.ibm.com>
In-Reply-To: <20190718032858.28744-3-bauerman@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0015.namprd06.prod.outlook.com
 (2603:10b6:803:2f::25) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0602e1f5-b632-4d76-031a-08d70ba50194
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3452;
x-ms-traffictypediagnostic: DM6PR12MB3452:
x-microsoft-antispam-prvs: <DM6PR12MB34520EDD0EA3C25DC3ED802BECC80@DM6PR12MB3452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(8936002)(3846002)(6116002)(305945005)(7416002)(6512007)(6246003)(31686004)(4326008)(316002)(7736002)(2906002)(8676002)(110136005)(6486002)(54906003)(186003)(53936002)(68736007)(6436002)(26005)(102836004)(36756003)(66476007)(71190400001)(71200400001)(66556008)(486006)(478600001)(53546011)(6506007)(66446008)(66946007)(66066001)(81166006)(81156014)(5660300002)(76176011)(25786009)(386003)(52116002)(14454004)(256004)(476003)(86362001)(11346002)(31696002)(446003)(2501003)(64756008)(229853002)(99286004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3452;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3AuUs6/FSKIZa7VmcvIO61u/oLDAtemCXC40CxRR4QY3IUtZEQ0ghcxMBnzXjApv1XCl23eR/oRhIPydtTsgDNroBxoZbqNEm0CmEAmDxraxHYq33k1758CSGC2b9BsVfNmGwvJ26xvBwhg+3Z2WfmxfZHwBNtXPRoSiPXZOhyLUZFoVtDqwkhS9re31cQKz8pu3Ch8FLiz9/9pMN7GM7RszX7lKofhcCsNxNLpTHqip+UKNjF7lgJnJgJx4AJk5fS28ypSnnawCES7ngxP7oeN+yw8Fwh6YrSHlbq5lU59z+EG8YPL2vdkyZFuJvYE+ior7Pd1gFIxvx5gnRKOPWvfV3P9dk7909E1SSoDLWN8Vb3CVwVkhgSRO1+Vyd4ykAf4f/WMKdztWOWAPKJ+SGJ/mw+X4u6wwgCzAbWNu6ps=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A98D6908BDCEF34790FCA6C994A418C8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0602e1f5-b632-4d76-031a-08d70ba50194
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 17:26:02.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy8xNy8xOSAxMDoyOCBQTSwgVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIHdyb3RlOg0KPiBzbWVf
YWN0aXZlKCkgaXMgYW4geDg2LXNwZWNpZmljIGZ1bmN0aW9uIHNvIGl0J3MgYmV0dGVyIG5vdCB0
byBjYWxsIGl0IGZyb20NCj4gZ2VuZXJpYyBjb2RlLg0KPiANCj4gVGhlcmUncyBubyBuZWVkIHRv
IG1lbnRpb24gd2hpY2ggbWVtb3J5IGVuY3J5cHRpb24gZmVhdHVyZSBpcyBhY3RpdmUsIHNvDQo+
IGp1c3QgdXNlIGEgbW9yZSBnZW5lcmljIG1lc3NhZ2UuIEJlc2lkZXMsIG90aGVyIGFyY2hpdGVj
dHVyZXMgd2lsbCBoYXZlDQo+IGRpZmZlcmVudCBuYW1lcyBmb3Igc2ltaWxhciB0ZWNobm9sb2d5
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIDxiYXVlcm1hbkBs
aW51eC5pYm0uY29tPg0KDQpSZXZpZXdlZC1ieTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFj
a3lAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGtlcm5lbC9kbWEvc3dpb3RsYi5jIHwgMyArLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9rZXJuZWwvZG1hL3N3aW90bGIuYyBiL2tlcm5lbC9kbWEvc3dpb3RsYi5jDQo+
IGluZGV4IDYyZmE1YTgyYTA2NS4uZTUyNDAxZjk0ZTkxIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwv
ZG1hL3N3aW90bGIuYw0KPiArKysgYi9rZXJuZWwvZG1hL3N3aW90bGIuYw0KPiBAQCAtNDU5LDgg
KzQ1OSw3IEBAIHBoeXNfYWRkcl90IHN3aW90bGJfdGJsX21hcF9zaW5nbGUoc3RydWN0IGRldmlj
ZSAqaHdkZXYsDQo+ICAJCXBhbmljKCJDYW4gbm90IGFsbG9jYXRlIFNXSU9UTEIgYnVmZmVyIGVh
cmxpZXIgYW5kIGNhbid0IG5vdyBwcm92aWRlIHlvdSB3aXRoIHRoZSBETUEgYm91bmNlIGJ1ZmZl
ciIpOw0KPiAgDQo+ICAJaWYgKG1lbV9lbmNyeXB0X2FjdGl2ZSgpKQ0KPiAtCQlwcl93YXJuX29u
Y2UoIiVzIGlzIGFjdGl2ZSBhbmQgc3lzdGVtIGlzIHVzaW5nIERNQSBib3VuY2UgYnVmZmVyc1xu
IiwNCj4gLQkJCSAgICAgc21lX2FjdGl2ZSgpID8gIlNNRSIgOiAiU0VWIik7DQo+ICsJCXByX3dh
cm5fb25jZSgiTWVtb3J5IGVuY3J5cHRpb24gaXMgYWN0aXZlIGFuZCBzeXN0ZW0gaXMgdXNpbmcg
RE1BIGJvdW5jZSBidWZmZXJzXG4iKTsNCj4gIA0KPiAgCW1hc2sgPSBkbWFfZ2V0X3NlZ19ib3Vu
ZGFyeShod2Rldik7DQo+ICANCj4gDQo=
