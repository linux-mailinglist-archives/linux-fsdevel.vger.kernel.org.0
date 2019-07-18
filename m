Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C54E6D2FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfGRRmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 13:42:23 -0400
Received: from mail-eopbgr800041.outbound.protection.outlook.com ([40.107.80.41]:54228
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728014AbfGRRmX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 13:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drFoWFi3QIdUpTZPJN6g7kpRgJDTiQ15e9nNHzkX5BrZIj9vjaijqrVtlFO+aYcNIXWIMdb9mh7uQJ9k6WHsb/MzEhdhDLRRmdF3J6SnCcX0lgI2hnUP26uyLDq1sEXtWv+9HlftrIBJSj5Vx9W76yR8gFz+8f/vUsGxOSJXxvgOYuVU65/VDbGhAOmGg9iTnqvTPJoek2f7xTfoeL99pUZ+ytJA9NBs6MI4Cw6RaGLTPWIzKkwIftuVBM2bb+S/6N67GndU+NSt5iW7z8eDUwKCBCzHSuUD8Qg0B8Wtp73U8Vl86afpCvLL9OlqqJhr+L5Q2mSmrvRhVptNgH3K9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvk/f5VP0rQP3go5PWBd23rYzHqqAjPoZM7BgH7OsRg=;
 b=FUSce7XoDf6mdHF6tu5IhCykss2dSi3QaGahJBFmZLJQEMeYkK5qw0wsFXYh1jVQK6KlLtMU54ZIB+ozhYnhnbjk0GCoiJ9x2k08WRZb8/QHhE4cL3/fP3MSL40M1G0RnJyYAv+qey5pltwFxlQB1R/ee6yRebmHsM95wpiUB+tlrpC/dTOwQ2hoEDXE4mjP01X/jrx9q5P+EYeHF8RPIgGQJLFe1o0OjDEJhS4VH3skwHTSFBtrkf78gSMhkcWrgv1ADi30TeDsjXYmBsITqQKHq4lco8GuoD3ZtvHQA8Mv4MFfUzTGAyI0VI8ijQzx1Z6iWigoidAQZLmgkzfiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvk/f5VP0rQP3go5PWBd23rYzHqqAjPoZM7BgH7OsRg=;
 b=P85kKbAze8Sv72t8t6NNr09QWiw7qxaEeuSPjmMETZcQIviw3tRabQbnOAoZUnHz/zSSEQUKFHrpN4uA/U5q03yb0r/TqE7xAWL1FgGinqlfbVvKVzHCL+XYsYBzlPOK1N29u9/3CE5vfSaxH14j46wD6bAdV951g/3q1Npeuyw=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB4155.namprd12.prod.outlook.com (10.141.8.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Thu, 18 Jul 2019 17:42:19 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 17:42:19 +0000
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
Subject: Re: [PATCH v3 4/6] x86,s390/mm: Move sme_active() and sme_me_mask to
 x86-specific header
Thread-Topic: [PATCH v3 4/6] x86,s390/mm: Move sme_active() and sme_me_mask to
 x86-specific header
Thread-Index: AQHVPRkIrZFaM8Ikf0iyeedsy3NkD6bQphUA
Date:   Thu, 18 Jul 2019 17:42:18 +0000
Message-ID: <cf48e778-130a-df2a-d94b-170bd85d692c@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
 <20190718032858.28744-5-bauerman@linux.ibm.com>
In-Reply-To: <20190718032858.28744-5-bauerman@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0011.namprd06.prod.outlook.com
 (2603:10b6:803:2f::21) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2f5b774-a586-49e3-bac1-08d70ba747c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB4155;
x-ms-traffictypediagnostic: DM6PR12MB4155:
x-microsoft-antispam-prvs: <DM6PR12MB4155B4A78E4C1B6E78FB1125ECC80@DM6PR12MB4155.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(8676002)(2501003)(478600001)(3846002)(6116002)(36756003)(71200400001)(66446008)(7736002)(66556008)(66476007)(64756008)(66946007)(81166006)(81156014)(66066001)(305945005)(71190400001)(7416002)(6512007)(8936002)(6246003)(6486002)(53936002)(68736007)(6436002)(6506007)(2616005)(2906002)(76176011)(53546011)(446003)(110136005)(256004)(5660300002)(54906003)(11346002)(316002)(4326008)(476003)(486006)(25786009)(31696002)(186003)(86362001)(102836004)(26005)(31686004)(386003)(229853002)(52116002)(14454004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4155;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aMBv+p0O8PA0MM8nKZUp/HxXHBQnrfAOt9MtrdR2SoniYa4Cz1m0lGkDQYde+tILo4j8ju8zrSNhKu0mEFGAuzKkxJWHAbzKQawG1cycc9Rlv8K5lVh1PZnZAjuaZlcHX10vw/uqBVd5MgaUD9kqtAqdQ3r8xvkfeE5Q/1s+kW5dBlKFF2mV1vhIa3nZaiXf6PHe0hqcCoKc4RamCio/q8K+nqyAU/0I1CjBW3TQ6arH8PTXg5FLJem/MWGrASE1VXZrdqWwW/R14WIM900avU2jreQncGr3ZKotidTCQOsVBOdgrpEWPIt2YUyGEVUyZpCYsh+1p6HYdl+jBr6h4P4lYekgp4IedmVvNEwypDu27NL0amvxEcC3TgDUr9YrB4LxsT63DrxM4OB3HCcOQebwpMqmOkicuTPxTWbcJ+s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D30328A1E6D7174797D57B6D36556B92@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f5b774-a586-49e3-bac1-08d70ba747c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 17:42:18.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy8xNy8xOSAxMDoyOCBQTSwgVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIHdyb3RlOg0KPiBOb3cg
dGhhdCBnZW5lcmljIGNvZGUgZG9lc24ndCByZWZlcmVuY2UgdGhlbSwgbW92ZSBzbWVfYWN0aXZl
KCkgYW5kDQo+IHNtZV9tZV9tYXNrIHRvIHg4NidzIDxhc20vbWVtX2VuY3J5cHQuaD4uDQo+IA0K
PiBBbHNvIHJlbW92ZSB0aGUgZXhwb3J0IGZvciBzbWVfYWN0aXZlKCkgc2luY2UgaXQncyBvbmx5
IHVzZWQgaW4gZmlsZXMgdGhhdA0KPiB3b24ndCBiZSBidWlsdCBhcyBtb2R1bGVzLiBzbWVfbWVf
bWFzayBvbiB0aGUgb3RoZXIgaGFuZCBpcyB1c2VkIGluDQo+IGFyY2gveDg2L2t2bS9zdm0uYyAo
dmlhIF9fc21lX3NldCgpIGFuZCBfX3BzcF9wYSgpKSB3aGljaCBjYW4gYmUgYnVpbHQgYXMgYQ0K
PiBtb2R1bGUgc28gaXRzIGV4cG9ydCBuZWVkcyB0byBzdGF5Lg0KDQpZb3UgbWF5IHdhbnQgdG8g
dHJ5IGFuZCBidWlsZCB0aGUgb3V0LW9mLXRyZWUgbnZpZGlhIGRyaXZlciBqdXN0IHRvIGJlDQpz
dXJlIHlvdSBjYW4gcmVtb3ZlIHRoZSBFWFBPUlRfU1lNQk9MKCkuIEJ1dCBJIGJlbGlldmUgdGhh
dCB3YXMgcmVsYXRlZA0KdG8gdGhlIERNQSBtYXNrIGNoZWNrLCB3aGljaCBub3cgcmVtb3ZlZCwg
bWF5IG5vIGxvbmdlciBiZSBhIHByb2JsZW0uDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRoaWFn
byBKdW5nIEJhdWVybWFubiA8YmF1ZXJtYW5AbGludXguaWJtLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQoNCj4gLS0tDQo+ICBhcmNo
L3MzOTAvaW5jbHVkZS9hc20vbWVtX2VuY3J5cHQuaCB8ICA0ICstLS0NCj4gIGFyY2gveDg2L2lu
Y2x1ZGUvYXNtL21lbV9lbmNyeXB0LmggIHwgMTAgKysrKysrKysrKw0KPiAgYXJjaC94ODYvbW0v
bWVtX2VuY3J5cHQuYyAgICAgICAgICAgfCAgMSAtDQo+ICBpbmNsdWRlL2xpbnV4L21lbV9lbmNy
eXB0LmggICAgICAgICB8IDE0ICstLS0tLS0tLS0tLS0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
czM5MC9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oIGIvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL21l
bV9lbmNyeXB0LmgNCj4gaW5kZXggM2ViMDE4NTA4MTkwLi5mZjgxM2E1NmJjMzAgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvczM5MC9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oDQo+ICsrKyBiL2FyY2gv
czM5MC9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oDQo+IEBAIC00LDkgKzQsNyBAQA0KPiAgDQo+
ICAjaWZuZGVmIF9fQVNTRU1CTFlfXw0KPiAgDQo+IC0jZGVmaW5lIHNtZV9tZV9tYXNrCTBVTEwN
Cj4gLQ0KPiAtc3RhdGljIGlubGluZSBib29sIHNtZV9hY3RpdmUodm9pZCkgeyByZXR1cm4gZmFs
c2U7IH0NCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBtZW1fZW5jcnlwdF9hY3RpdmUodm9pZCkgeyBy
ZXR1cm4gZmFsc2U7IH0NCj4gIGV4dGVybiBib29sIHNldl9hY3RpdmUodm9pZCk7DQo+ICANCj4g
IGludCBzZXRfbWVtb3J5X2VuY3J5cHRlZCh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdl
cyk7DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vbWVtX2VuY3J5cHQuaA0KPiBpbmRleCAwYzE5NmM0N2Q2MjEu
Ljg0OGNlNDNiOTA0MCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbWVtX2Vu
Y3J5cHQuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdC5oDQo+IEBA
IC05Miw2ICs5MiwxNiBAQCBlYXJseV9zZXRfbWVtb3J5X2VuY3J5cHRlZCh1bnNpZ25lZCBsb25n
IHZhZGRyLCB1bnNpZ25lZCBsb25nIHNpemUpIHsgcmV0dXJuIDA7DQo+ICANCj4gIGV4dGVybiBj
aGFyIF9fc3RhcnRfYnNzX2RlY3J5cHRlZFtdLCBfX2VuZF9ic3NfZGVjcnlwdGVkW10sIF9fc3Rh
cnRfYnNzX2RlY3J5cHRlZF91bnVzZWRbXTsNCj4gIA0KPiArc3RhdGljIGlubGluZSBib29sIG1l
bV9lbmNyeXB0X2FjdGl2ZSh2b2lkKQ0KPiArew0KPiArCXJldHVybiBzbWVfbWVfbWFzazsNCj4g
K30NCj4gKw0KPiArc3RhdGljIGlubGluZSB1NjQgc21lX2dldF9tZV9tYXNrKHZvaWQpDQo+ICt7
DQo+ICsJcmV0dXJuIHNtZV9tZV9tYXNrOw0KPiArfQ0KPiArDQo+ICAjZW5kaWYJLyogX19BU1NF
TUJMWV9fICovDQo+ICANCj4gICNlbmRpZgkvKiBfX1g4Nl9NRU1fRU5DUllQVF9IX18gKi8NCj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL21lbV9lbmNyeXB0LmMgYi9hcmNoL3g4Ni9tbS9tZW1f
ZW5jcnlwdC5jDQo+IGluZGV4IGM4MDVmMGE1YzE2ZS4uNzEzOWYyZjQzOTU1IDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5jDQo+ICsrKyBiL2FyY2gveDg2L21tL21lbV9l
bmNyeXB0LmMNCj4gQEAgLTM0NCw3ICszNDQsNiBAQCBib29sIHNtZV9hY3RpdmUodm9pZCkNCj4g
IHsNCj4gIAlyZXR1cm4gc21lX21lX21hc2sgJiYgIXNldl9lbmFibGVkOw0KPiAgfQ0KPiAtRVhQ
T1JUX1NZTUJPTChzbWVfYWN0aXZlKTsNCj4gIA0KPiAgYm9vbCBzZXZfYWN0aXZlKHZvaWQpDQo+
ICB7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21lbV9lbmNyeXB0LmggYi9pbmNsdWRl
L2xpbnV4L21lbV9lbmNyeXB0LmgNCj4gaW5kZXggNDcwYmQ1M2E4OWRmLi4wYzViMGZmOWViMjkg
MTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbWVtX2VuY3J5cHQuaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L21lbV9lbmNyeXB0LmgNCj4gQEAgLTE4LDIzICsxOCwxMSBAQA0KPiAgDQo+ICAj
ZWxzZQkvKiAhQ09ORklHX0FSQ0hfSEFTX01FTV9FTkNSWVBUICovDQo+ICANCj4gLSNkZWZpbmUg
c21lX21lX21hc2sJMFVMTA0KPiAtDQo+IC1zdGF0aWMgaW5saW5lIGJvb2wgc21lX2FjdGl2ZSh2
b2lkKSB7IHJldHVybiBmYWxzZTsgfQ0KPiArc3RhdGljIGlubGluZSBib29sIG1lbV9lbmNyeXB0
X2FjdGl2ZSh2b2lkKSB7IHJldHVybiBmYWxzZTsgfQ0KPiAgc3RhdGljIGlubGluZSBib29sIHNl
dl9hY3RpdmUodm9pZCkgeyByZXR1cm4gZmFsc2U7IH0NCj4gIA0KPiAgI2VuZGlmCS8qIENPTkZJ
R19BUkNIX0hBU19NRU1fRU5DUllQVCAqLw0KPiAgDQo+IC1zdGF0aWMgaW5saW5lIGJvb2wgbWVt
X2VuY3J5cHRfYWN0aXZlKHZvaWQpDQo+IC17DQo+IC0JcmV0dXJuIHNtZV9tZV9tYXNrOw0KPiAt
fQ0KPiAtDQo+IC1zdGF0aWMgaW5saW5lIHU2NCBzbWVfZ2V0X21lX21hc2sodm9pZCkNCj4gLXsN
Cj4gLQlyZXR1cm4gc21lX21lX21hc2s7DQo+IC19DQo+IC0NCj4gICNpZmRlZiBDT05GSUdfQU1E
X01FTV9FTkNSWVBUDQo+ICAvKg0KPiAgICogVGhlIF9fc21lX3NldCgpIGFuZCBfX3NtZV9jbHIo
KSBtYWNyb3MgYXJlIHVzZWZ1bCBmb3IgYWRkaW5nIG9yIHJlbW92aW5nDQo+IA0K
