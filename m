Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F1B357AB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 05:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhDHDWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 23:22:14 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62]:1441 "EHLO
        esa19.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhDHDWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:22:13 -0400
IronPort-SDR: caNgbh3nz0oLKZ66KdNyNoDbHvwNAgJ0NlabsM7fb3BQkDXR1PS9aadInfWLSBp8Vm/xOK23Ub
 uCv7XxG6raOkDqBm29mrxIRmwzrslLXLrXKValE79vmcDCEljyfEY/iri6NwPSoXqTJCRgg3DW
 w3FqZHhB+bvSuQM3OTvo/IATm+nSjvCpAF0VRW6C75WIcPAPQfC+N7QCa5Im2ADPzrTEcT9R5Q
 FpJu9I6K2od5962qalQKq+IucXi5Qv+AMbog/lTE5M+Ll+EeFIK/3eG8/KkyeyKL7MPp7uUxHH
 HGg=
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="29046577"
X-IronPort-AV: E=Sophos;i="5.82,205,1613401200"; 
   d="scan'208";a="29046577"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 12:21:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ioz7fTclyMv8BabgaIs/Su60CsD6oDIvxIQdHroVv5pdYUA+/4N0MeyOrX2Ug7Zj2R/NXw3l4aGQaDlsNjbShbP6PfhUVPlspRvaq0zsPE8b1dEzZ4U7j4GF5EtrP5HW7TpzuwA4ijWe+3JbMOg++8j5IbswliU/FjGoLcNTqdKrzPJG6t9FSP3kGDLh9EuxDkYQfW0KErNCTRGRMww1NHDwV50O7gq8zZ0U8t4SUQG2tcJLTEKCKF+qH4VbAyyscVVoxZrSvblUs7lCwxu/S7OLPBCIo+jSQo9U72oWTCVxX8qqbkj5P9P9tjQkaHJ/pLzNSrS0oecHIqttJNzFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G4U9sk4VEpOveNCXolTsaOBVCwO0F/AdzrJAxbyFDg=;
 b=ZSL/yHhhWd2VK/S8uV1LntVMyP1Ic/Y5M9xZ9JFyeCQvmRBg6K7rBeoy/u67rfD1jQjyWzDcJd/NF28fkPosf1ErU0AJNWyUJcF9XlEBAD1t3DlNV9LWdM0/Pt58+CDNK/bFrc7EoSNb9S4w9JS4kHrRWd89hn/WzbIdshNNISsoVKnJBjq1QZ8jj3YRX2yzQOe1S2gLxzO2vIbUcyiThyAHZ/q/726AatIJDnDcux95iKLmZAGzQkpBhuzyi3tzzOGkN9RVk+UaF/jS0ssyxepQFZ9DI+z0y14f3xw17nwIqpIH/TTbfrf+OAJWcMI4KBbC9BcnnH28y6A6c0MDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G4U9sk4VEpOveNCXolTsaOBVCwO0F/AdzrJAxbyFDg=;
 b=TRhsc7o4UB45FQZNC2yM78cjuoCIja0GdT6sIiUSU8326blWJo3Havx7XXS5HbX0PpoN9apn6Ubehl2ycNcwZHHZ3q4QOoLthSfhDphIwhTwuSPg9VsYRDwF8K/+husj7SJ9eY6tm6M7airSyj5xJYxA1zGOeywWafBPRfBkt3A=
Received: from TY2PR01MB2921.jpnprd01.prod.outlook.com (2603:1096:404:75::14)
 by TYCPR01MB6557.jpnprd01.prod.outlook.com (2603:1096:400:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 03:21:53 +0000
Received: from TY2PR01MB2921.jpnprd01.prod.outlook.com
 ([fe80::e4ef:b5e8:6e7c:ee89]) by TY2PR01MB2921.jpnprd01.prod.outlook.com
 ([fe80::e4ef:b5e8:6e7c:ee89%6]) with mapi id 15.20.3999.034; Thu, 8 Apr 2021
 03:21:53 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: RE: [PATCH v3 08/10] fsdax: Dedup file range to use a compare
 function
Thread-Topic: [PATCH v3 08/10] fsdax: Dedup file range to use a compare
 function
Thread-Index: AQHXHGLCkg6dUIPK4kKi6Usidu8iSKqflrYAgAp3LYA=
Date:   Thu, 8 Apr 2021 03:21:53 +0000
Message-ID: <TY2PR01MB2921EBF98C2AC2900799FB85F4749@TY2PR01MB2921.jpnprd01.prod.outlook.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-9-ruansy.fnst@fujitsu.com>
 <20210401111120.2ukog26aoyvyysyz@riteshh-domain>
In-Reply-To: <20210401111120.2ukog26aoyvyysyz@riteshh-domain>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe7e6042-e563-44a6-711e-08d8fa3d7527
x-ms-traffictypediagnostic: TYCPR01MB6557:
x-microsoft-antispam-prvs: <TYCPR01MB6557E59B32D8D0350178C29AF4749@TYCPR01MB6557.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIHY3kfk21NG6iYaK/vNJm7XR27M46EOAfzJ+dLIwg6pYs5m7FWu2vxEaYB5KknTA1ham+FM27iW/3PhOMNT/NCoRTLne5bbriGeBYaEARUP7Mi7ezer2wBC6MZXkaGzNmPW+1qhH//NktDStR05rHolN4NDPHP5RP53T7ypofG3kfZydhT9e/enGXvc/Rr510tx6AF2vBN2YyDmOnLVyWAeBKZYDVlv1TTf49husJp3X9pI8eJNzNdD8tHdebLPCXsbezGnEwPQwe8eVS4EPuFnF/P7uEqnQ/GT9iQnQT8oHMmMZKJFjDOLQqkPo6tgFXf5U6qDjt4HuN+rZLVOxo0aY7gqtRuUk+hK0u+T32shfh6Okwk5nLKyi0Trbh0BPeH/EBXL8rTm/tPpMZgBkAdW+9H8yTtTw7ximzK0mF6cPfqCqxrgBXhEmdcwzA53St3tImp5ySdbeeQ7rN+M76avWtD+v5Nj7pL+m8bWrnJTR1Y4EoXko5rilj9OmFZsj9//M3sPE7BusibmIKTqava0CCENWKhcgICzUZOtzFpYSEZLXgNRTM7qVkMJTJGRR8THApCxLW04cd95g9QyHuNNO2TMZMw35Ekckkei8zkpUFyo9M5fLEhw6nfX5fee1uU1iNjhnYXtovavDQL56EtLQurKmieooeVTQmxMNVw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2921.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(86362001)(66446008)(66476007)(9686003)(66946007)(6916009)(64756008)(4326008)(26005)(66556008)(76116006)(38100700001)(55016002)(316002)(54906003)(5660300002)(71200400001)(85182001)(8936002)(33656002)(52536014)(186003)(7416002)(7696005)(2906002)(83380400001)(6506007)(478600001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?cGxMWFVkSkdET05Oemh1TnZZWjVmNW04aWxSbWFKN3pVS3hmQWdEUnc0Z3BV?=
 =?gb2312?B?NkdYWjl0cEQ0OWVJNWpEdldlakpEU1JqU042SXF5NllvRzMvcmM2azBXN0Jk?=
 =?gb2312?B?WXhHWGxGNTMzQnpidFBIdE5zdTVMSHYzZmw5bnAzS2Q2WHR0Nm91T2xtb2hD?=
 =?gb2312?B?c3dpUlJ1ZGlQem9SQmZaVFRnNnlvc0cvcTJCOEMxQUplWDcxRlVmV0NhdHNq?=
 =?gb2312?B?TzlxMm12QzZ0UEp3ai94REh6Z3NQVGVFMi93QjBIdVVNNmNYclg5SzgveUM5?=
 =?gb2312?B?YXJwLzJHYVhyZ2JDSXZPOHdYektySDkvL3RSUDBOUVB5ZDBzRzF2am9WYmFL?=
 =?gb2312?B?VDlJdUtwNFBMMjRKeDJhNWxFTjg5Ny9ibVlYUkorc0gvVE85QmNpemFtMEx1?=
 =?gb2312?B?ZDk1Y0FhS080SmQvTTZQNXV2NUxWWGRaMTlVR09xRFVoUjZ5Q1o2V1NUWDQy?=
 =?gb2312?B?VkVsZnkrblJZbUpUTG5TSE1xR3cydUw0SFBrdmNIWi95cUN6V2NaWXpkS056?=
 =?gb2312?B?MythSFZWdG1zS29sdzFMWDJBckVPMmk1THNxSFdNSkZOUTlsbXpTVnFTemIx?=
 =?gb2312?B?WWVzOFRKNi91QWJrejZ5OWVKNE9EWHFYNGt4NFFLWDVCNEJYbVFNL1dPY3FB?=
 =?gb2312?B?R3BjOWMwT215WXk4R1FVRFVXeTRqKys3Qjg5bEZsYTNSQVRHMWJON1NoMkx2?=
 =?gb2312?B?KzRFV1E2NXdnRzlyQ25mNmFPc2hGeCtEWHIrYUk4NzhHOTFKdmJ5OVR0MEUy?=
 =?gb2312?B?R1pacEFJWUFYVFcyM3ZjcUtJNDNQSXl5Q2JuT2NMUHlWb01aMDhKOXNTRnBm?=
 =?gb2312?B?SEh4MnhRUmNpTGQ0Q20rMzdTdk5MSmFtb0oycnlEbzhpbWpOQzhNQkR1TVBD?=
 =?gb2312?B?RExVRmUyZWJPUEpoQ01qTTFaSjVETlU1TitwSU9tTnVvc0QzMTd1eTU3Zmxj?=
 =?gb2312?B?M0d4a0JpL041UzExNTkrWDBkdWVhUi9uR015MXg4OENZTzIvUjU5Qmd4QWk5?=
 =?gb2312?B?MkJ0SHNLN1h3cEgvejUvQm52Y2E0TVR5TnBaV0tab3A4TkJpRHlRQWIwanpp?=
 =?gb2312?B?c3pObFZPWmR0aVEybTVKdVc3YTFEbGZBd0YzdFJESXo1SGd3aTRYSFpyWVFW?=
 =?gb2312?B?R3Y1c3F5eW50U1VKQzlYSzdjUWVwajR3VzZnUXRlUGxNUy9DQ1BCOThHSnJM?=
 =?gb2312?B?S2VxdmRQa1REVWdZbWl6WE5ab1ZsRzZrRWc5YjdPK0dycm9hRCs4anNnK2Rs?=
 =?gb2312?B?SjFHNGg4Rk5FK2F5YnMvMnhaKzJPTGlueG5UcXdmMnpveG1vTFlYK3FoK1JZ?=
 =?gb2312?B?Z1IvdnJmQVZYSEFRaURYQ0wyaDZ2bHJ5NS9RRzVWb3pLVURYci9md2RBNWhz?=
 =?gb2312?B?MVZzaGdoVHZMV2xUS2ZGTlZLaExqTkRQdWxveXg4b0tteWRiTEhXL00xbGR1?=
 =?gb2312?B?Q2FINkd5bkZLVWowcWxVVjdTOUFYbjBzMTFzbURPZ1pzN2pLUEtzN0dsbUM3?=
 =?gb2312?B?SWxIS0t3OFRrVTBzczRpQXpHSDZiRHE0b01uMDZzbzQza21UZmNxV3BDeTVt?=
 =?gb2312?B?aEQxdjQ1T1pLbGJ3WUlLV2NqdEV0cUZvZmxpUC96V3d2NjluRGI2dncxK0E4?=
 =?gb2312?B?YnRDdThZUGNzSHNJaU9rU05XOHpEa0U4eVNjc01HWXIrVVRhdnJPL0FXaCtW?=
 =?gb2312?B?WVdjcE5nOE5IWjIwMHhLZWpxY25YcGZwT1ZoLzQ0cnhlQmVSeEVTQ2N6MzVH?=
 =?gb2312?Q?f8AaHyEtqoaU8G9C/cXouR0l0eDxwOp2cwQa+mr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2921.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7e6042-e563-44a6-711e-08d8fa3d7527
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 03:21:53.7134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2AdHb+qutiKz/mU1neNKx5bjPe1CAp2VkbekY25IFinU0KQlZHxhhT5ZvHgN7OR3/ecWuDwMSypaScPscXMkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6557
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJpdGVzaCBIYXJqYW5pIDxy
aXRlc2gubGlzdEBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDgvMTBdIGZz
ZGF4OiBEZWR1cCBmaWxlIHJhbmdlIHRvIHVzZSBhIGNvbXBhcmUgZnVuY3Rpb24NCj4gDQo+IE9u
IDIxLzAzLzE5IDA5OjUyQU0sIFNoaXlhbmcgUnVhbiB3cm90ZToNCj4gPiBXaXRoIGRheCB3ZSBj
YW5ub3QgZGVhbCB3aXRoIHJlYWRwYWdlKCkgZXRjLiBTbywgd2UgY3JlYXRlIGEgZGF4DQo+ID4g
Y29tcGFyaXNvbiBmdW5jaXRvbiB3aGljaCBpcyBzaW1pbGFyIHdpdGgNCj4gPiB2ZnNfZGVkdXBl
X2ZpbGVfcmFuZ2VfY29tcGFyZSgpLg0KPiA+IEFuZCBpbnRyb2R1Y2UgZGF4X3JlbWFwX2ZpbGVf
cmFuZ2VfcHJlcCgpIGZvciBmaWxlc3lzdGVtIHVzZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEdvbGR3eW4gUm9kcmlndWVzIDxyZ29sZHd5bkBzdXNlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICBm
cy9kYXguYyAgICAgICAgICAgICB8IDU2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIGZzL3JlbWFwX3JhbmdlLmMgICAgIHwgNDUgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAgZnMveGZzL3hmc19yZWZsaW5rLmMgfCAg
OSArKysrKy0tDQo+ID4gIGluY2x1ZGUvbGludXgvZGF4LmggIHwgIDQgKysrKw0KPiA+ICBpbmNs
dWRlL2xpbnV4L2ZzLmggICB8IDE1ICsrKysrKysrLS0tLQ0KPiA+ICA1IGZpbGVzIGNoYW5nZWQs
IDExNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9mcy9kYXguYyBiL2ZzL2RheC5jDQo+ID4gaW5kZXggMzQ4Mjk3YjM4Zjc2Li43NmY4MWYxZDc2
ZWMgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvZGF4LmMNCj4gPiArKysgYi9mcy9kYXguYw0KPiA+IEBA
IC0xODMzLDMgKzE4MzMsNTkgQEAgdm1fZmF1bHRfdCBkYXhfZmluaXNoX3N5bmNfZmF1bHQoc3Ry
dWN0IHZtX2ZhdWx0DQo+ICp2bWYsDQo+ID4gIAlyZXR1cm4gZGF4X2luc2VydF9wZm5fbWt3cml0
ZSh2bWYsIHBmbiwgb3JkZXIpOyAgfQ0KPiA+IEVYUE9SVF9TWU1CT0xfR1BMKGRheF9maW5pc2hf
c3luY19mYXVsdCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgbG9mZl90IGRheF9yYW5nZV9jb21wYXJl
X2FjdG9yKHN0cnVjdCBpbm9kZSAqaW5vMSwgbG9mZl90IHBvczEsDQo+ID4gKwkJc3RydWN0IGlu
b2RlICppbm8yLCBsb2ZmX3QgcG9zMiwgbG9mZl90IGxlbiwgdm9pZCAqZGF0YSwNCj4gPiArCQlz
dHJ1Y3QgaW9tYXAgKnNtYXAsIHN0cnVjdCBpb21hcCAqZG1hcCkgew0KPiA+ICsJdm9pZCAqc2Fk
ZHIsICpkYWRkcjsNCj4gPiArCWJvb2wgKnNhbWUgPSBkYXRhOw0KPiA+ICsJaW50IHJldDsNCj4g
PiArDQo+ID4gKwlpZiAoc21hcC0+dHlwZSA9PSBJT01BUF9IT0xFICYmIGRtYXAtPnR5cGUgPT0g
SU9NQVBfSE9MRSkgew0KPiA+ICsJCSpzYW1lID0gdHJ1ZTsNCj4gPiArCQlyZXR1cm4gbGVuOw0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChzbWFwLT50eXBlID09IElPTUFQX0hPTEUgfHwgZG1h
cC0+dHlwZSA9PSBJT01BUF9IT0xFKSB7DQo+ID4gKwkJKnNhbWUgPSBmYWxzZTsNCj4gPiArCQly
ZXR1cm4gMDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSBkYXhfaW9tYXBfZGlyZWN0X2Fj
Y2VzcyhzbWFwLCBwb3MxLCBBTElHTihwb3MxICsgbGVuLCBQQUdFX1NJWkUpLA0KPiA+ICsJCQkJ
ICAgICAgJnNhZGRyLCBOVUxMKTsNCj4gDQo+IHNob3VsZG4ndCBpdCB0YWtlIGxlbiBhcyB0aGUg
c2Vjb25kIGFyZ3VtZW50Pw0KDQpUaGUgc2Vjb25kIGFyZ3VtZW50IG9mIGRheF9pb21hcF9kaXJl
Y3RfYWNjZXNzKCkgbWVhbnMgb2Zmc2V0LCBhbmQgdGhlIHRoaXJkIG9uZSBtZWFucyBsZW5ndGgu
ICBTbywgSSB0aGluayB0aGlzIGlzIHJpZ2h0Lg0KDQo+IA0KPiA+ICsJaWYgKHJldCA8IDApDQo+
ID4gKwkJcmV0dXJuIC1FSU87DQo+ID4gKw0KPiA+ICsJcmV0ID0gZGF4X2lvbWFwX2RpcmVjdF9h
Y2Nlc3MoZG1hcCwgcG9zMiwgQUxJR04ocG9zMiArIGxlbiwgUEFHRV9TSVpFKSwNCj4gPiArCQkJ
CSAgICAgICZkYWRkciwgTlVMTCk7DQo+IA0KPiBkaXR0by4NCj4gPiArCWlmIChyZXQgPCAwKQ0K
PiA+ICsJCXJldHVybiAtRUlPOw0KPiA+ICsNCj4gPiArCSpzYW1lID0gIW1lbWNtcChzYWRkciwg
ZGFkZHIsIGxlbik7DQo+ID4gKwlyZXR1cm4gbGVuOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQg
ZGF4X2RlZHVwZV9maWxlX3JhbmdlX2NvbXBhcmUoc3RydWN0IGlub2RlICpzcmMsIGxvZmZfdCBz
cmNvZmYsDQo+ID4gKwkJc3RydWN0IGlub2RlICpkZXN0LCBsb2ZmX3QgZGVzdG9mZiwgbG9mZl90
IGxlbiwgYm9vbCAqaXNfc2FtZSwNCj4gPiArCQljb25zdCBzdHJ1Y3QgaW9tYXBfb3BzICpvcHMp
DQo+ID4gK3sNCj4gPiArCWludCBpZCwgcmV0ID0gMDsNCj4gPiArDQo+ID4gKwlpZCA9IGRheF9y
ZWFkX2xvY2soKTsNCj4gPiArCXdoaWxlIChsZW4pIHsNCj4gPiArCQlyZXQgPSBpb21hcF9hcHBs
eTIoc3JjLCBzcmNvZmYsIGRlc3QsIGRlc3RvZmYsIGxlbiwgMCwgb3BzLA0KPiA+ICsJCQkJICAg
aXNfc2FtZSwgZGF4X3JhbmdlX2NvbXBhcmVfYWN0b3IpOw0KPiA+ICsJCWlmIChyZXQgPCAwIHx8
ICEqaXNfc2FtZSkNCj4gPiArCQkJZ290byBvdXQ7DQo+ID4gKw0KPiA+ICsJCWxlbiAtPSByZXQ7
DQo+ID4gKwkJc3Jjb2ZmICs9IHJldDsNCj4gPiArCQlkZXN0b2ZmICs9IHJldDsNCj4gPiArCX0N
Cj4gPiArCXJldCA9IDA7DQo+ID4gK291dDoNCj4gPiArCWRheF9yZWFkX3VubG9jayhpZCk7DQo+
ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGRheF9kZWR1
cGVfZmlsZV9yYW5nZV9jb21wYXJlKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZnMvcmVtYXBfcmFuZ2Uu
YyBiL2ZzL3JlbWFwX3JhbmdlLmMgaW5kZXgNCj4gPiA3N2RiYTNhNDllNjUuLjkwNzkzOTBlZGFm
MyAxMDA2NDQNCj4gPiAtLS0gYS9mcy9yZW1hcF9yYW5nZS5jDQo+ID4gKysrIGIvZnMvcmVtYXBf
cmFuZ2UuYw0KPiA+IEBAIC0xNCw2ICsxNCw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9jb21w
YXQuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21vdW50Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51
eC9mcy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZGF4Lmg+DQo+ID4gICNpbmNsdWRlICJpbnRl
cm5hbC5oIg0KPiA+DQo+ID4gICNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+DQo+ID4gQEAgLTE5
OSw5ICsyMDAsOSBAQCBzdGF0aWMgdm9pZCB2ZnNfdW5sb2NrX3R3b19wYWdlcyhzdHJ1Y3QgcGFn
ZSAqcGFnZTEsDQo+IHN0cnVjdCBwYWdlICpwYWdlMikNCj4gPiAgICogQ29tcGFyZSBleHRlbnRz
IG9mIHR3byBmaWxlcyB0byBzZWUgaWYgdGhleSBhcmUgdGhlIHNhbWUuDQo+ID4gICAqIENhbGxl
ciBtdXN0IGhhdmUgbG9ja2VkIGJvdGggaW5vZGVzIHRvIHByZXZlbnQgd3JpdGUgcmFjZXMuDQo+
ID4gICAqLw0KPiA+IC1zdGF0aWMgaW50IHZmc19kZWR1cGVfZmlsZV9yYW5nZV9jb21wYXJlKHN0
cnVjdCBpbm9kZSAqc3JjLCBsb2ZmX3Qgc3Jjb2ZmLA0KPiA+IC0JCQkJCSBzdHJ1Y3QgaW5vZGUg
KmRlc3QsIGxvZmZfdCBkZXN0b2ZmLA0KPiA+IC0JCQkJCSBsb2ZmX3QgbGVuLCBib29sICppc19z
YW1lKQ0KPiA+ICtpbnQgdmZzX2RlZHVwZV9maWxlX3JhbmdlX2NvbXBhcmUoc3RydWN0IGlub2Rl
ICpzcmMsIGxvZmZfdCBzcmNvZmYsDQo+ID4gKwkJCQkgIHN0cnVjdCBpbm9kZSAqZGVzdCwgbG9m
Zl90IGRlc3RvZmYsDQo+ID4gKwkJCQkgIGxvZmZfdCBsZW4sIGJvb2wgKmlzX3NhbWUpDQo+ID4g
IHsNCj4gPiAgCWxvZmZfdCBzcmNfcG9mZjsNCj4gPiAgCWxvZmZfdCBkZXN0X3BvZmY7DQo+ID4g
QEAgLTI4MCw2ICsyODEsNyBAQCBzdGF0aWMgaW50IHZmc19kZWR1cGVfZmlsZV9yYW5nZV9jb21w
YXJlKHN0cnVjdA0KPiA+IGlub2RlICpzcmMsIGxvZmZfdCBzcmNvZmYsDQo+ID4gIG91dF9lcnJv
cjoNCj4gPiAgCXJldHVybiBlcnJvcjsNCj4gPiAgfQ0KPiA+ICtFWFBPUlRfU1lNQk9MKHZmc19k
ZWR1cGVfZmlsZV9yYW5nZV9jb21wYXJlKTsNCj4gPg0KPiA+ICAvKg0KPiA+ICAgKiBDaGVjayB0
aGF0IHRoZSB0d28gaW5vZGVzIGFyZSBlbGlnaWJsZSBmb3IgY2xvbmluZywgdGhlIHJhbmdlcw0K
PiA+IG1ha2UgQEAgLTI4OSw5ICsyOTEsMTEgQEAgc3RhdGljIGludA0KPiB2ZnNfZGVkdXBlX2Zp
bGVfcmFuZ2VfY29tcGFyZShzdHJ1Y3QgaW5vZGUgKnNyYywgbG9mZl90IHNyY29mZiwNCj4gPiAg
ICogSWYgdGhlcmUncyBhbiBlcnJvciwgdGhlbiB0aGUgdXN1YWwgbmVnYXRpdmUgZXJyb3IgY29k
ZSBpcyByZXR1cm5lZC4NCj4gPiAgICogT3RoZXJ3aXNlIHJldHVybnMgMCB3aXRoICpsZW4gc2V0
IHRvIHRoZSByZXF1ZXN0IGxlbmd0aC4NCj4gPiAgICovDQo+ID4gLWludCBnZW5lcmljX3JlbWFw
X2ZpbGVfcmFuZ2VfcHJlcChzdHJ1Y3QgZmlsZSAqZmlsZV9pbiwgbG9mZl90IHBvc19pbiwNCj4g
PiAtCQkJCSAgc3RydWN0IGZpbGUgKmZpbGVfb3V0LCBsb2ZmX3QgcG9zX291dCwNCj4gPiAtCQkJ
CSAgbG9mZl90ICpsZW4sIHVuc2lnbmVkIGludCByZW1hcF9mbGFncykNCj4gPiArc3RhdGljIGlu
dA0KPiA+ICtfX2dlbmVyaWNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwKHN0cnVjdCBmaWxlICpmaWxl
X2luLCBsb2ZmX3QgcG9zX2luLA0KPiA+ICsJCQkJc3RydWN0IGZpbGUgKmZpbGVfb3V0LCBsb2Zm
X3QgcG9zX291dCwNCj4gPiArCQkJCWxvZmZfdCAqbGVuLCB1bnNpZ25lZCBpbnQgcmVtYXBfZmxh
Z3MsDQo+ID4gKwkJCQljb25zdCBzdHJ1Y3QgaW9tYXBfb3BzICpvcHMpDQo+ID4gIHsNCj4gPiAg
CXN0cnVjdCBpbm9kZSAqaW5vZGVfaW4gPSBmaWxlX2lub2RlKGZpbGVfaW4pOw0KPiA+ICAJc3Ry
dWN0IGlub2RlICppbm9kZV9vdXQgPSBmaWxlX2lub2RlKGZpbGVfb3V0KTsgQEAgLTM1MSw4ICsz
NTUsMTUgQEANCj4gPiBpbnQgZ2VuZXJpY19yZW1hcF9maWxlX3JhbmdlX3ByZXAoc3RydWN0IGZp
bGUgKmZpbGVfaW4sIGxvZmZfdCBwb3NfaW4sDQo+ID4gIAlpZiAocmVtYXBfZmxhZ3MgJiBSRU1B
UF9GSUxFX0RFRFVQKSB7DQo+ID4gIAkJYm9vbAkJaXNfc2FtZSA9IGZhbHNlOw0KPiA+DQo+ID4g
LQkJcmV0ID0gdmZzX2RlZHVwZV9maWxlX3JhbmdlX2NvbXBhcmUoaW5vZGVfaW4sIHBvc19pbiwN
Cj4gPiAtCQkJCWlub2RlX291dCwgcG9zX291dCwgKmxlbiwgJmlzX3NhbWUpOw0KPiA+ICsJCWlm
ICghSVNfREFYKGlub2RlX2luKSAmJiAhSVNfREFYKGlub2RlX291dCkpDQo+ID4gKwkJCXJldCA9
IHZmc19kZWR1cGVfZmlsZV9yYW5nZV9jb21wYXJlKGlub2RlX2luLCBwb3NfaW4sDQo+ID4gKwkJ
CQkJaW5vZGVfb3V0LCBwb3Nfb3V0LCAqbGVuLCAmaXNfc2FtZSk7DQo+ID4gKwkJZWxzZSBpZiAo
SVNfREFYKGlub2RlX2luKSAmJiBJU19EQVgoaW5vZGVfb3V0KSAmJiBvcHMpDQo+ID4gKwkJCXJl
dCA9IGRheF9kZWR1cGVfZmlsZV9yYW5nZV9jb21wYXJlKGlub2RlX2luLCBwb3NfaW4sDQo+ID4g
KwkJCQkJaW5vZGVfb3V0LCBwb3Nfb3V0LCAqbGVuLCAmaXNfc2FtZSwNCj4gPiArCQkJCQlvcHMp
Ow0KPiA+ICsJCWVsc2UNCj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gIAkJaWYgKHJldCkN
Cj4gPiAgCQkJcmV0dXJuIHJldDsNCj4gPiAgCQlpZiAoIWlzX3NhbWUpDQo+IA0KPiBzaG91bGQg
d2UgY29uc2lkZXIgdG8gY2hlY2sgIWlzX3NhbWUgY2hlY2sgYjQ/DQo+IHlvdSBzaG91bGQgbWF5
YmUgcmVsb29rIGF0IHRoaXMgZXJyb3IgaGFuZGxpbmcgc2lkZSBvZiBjb2RlLg0KPiB3ZSBzdGls
bCByZXR1cm4gbGVuIGZyb20gYWN0b3IgZnVuY3Rpb24gYnV0IGlzX3NhbWUgaXMgc2V0IHRvIGZh
bHNlLg0KPiBTbyB3ZSBhcmUgZXNzZW50aWFsbHkgcmV0dXJuaW5nIHJldCAocG9zaXRpdmUgdmFs
dWUpLCBpbnN0ZWFkIHNob3VsZCBiZSByZXR1cm5pbmcNCj4gLUVCQURFIGJlY2F1c2Ugb2YgIW1l
bWNtcA0KDQpUaGUgcmV0IGZyb20gY29tcGFyZSBmdW5jdGlvbiB3aWxsIG5vdCBiZSBwb3NpdGl2
ZSwgaXQgd2lsbCBhbHdheXMgYmUgMCBvciBuZWdhdGl2ZS4gIA0KSW4gYWRkaXRpb24sIGlmIHNv
bWV0aGluZyB3cm9uZyBoYXBwZW5zLCBpc19zYW1lIHdpbGwgYWx3YXlzIGJlIGZhbHNlLiAgVGhl
IGNhbGxlciBjb3VsZCBub3QgZ2V0IGNvcnJlY3QgZXJybm8gaWYgY2hlY2sgIWlzX3NhbWUgZmly
c3RseS4NCg0KPiANCj4gPiBAQCAtMzcwLDYgKzM4MSwyNCBAQCBpbnQgZ2VuZXJpY19yZW1hcF9m
aWxlX3JhbmdlX3ByZXAoc3RydWN0IGZpbGUNCj4gPiAqZmlsZV9pbiwgbG9mZl90IHBvc19pbiwN
Cj4gPg0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+ICsNCj4gPiAraW50IGRheF9yZW1h
cF9maWxlX3JhbmdlX3ByZXAoc3RydWN0IGZpbGUgKmZpbGVfaW4sIGxvZmZfdCBwb3NfaW4sDQo+
ID4gKwkJCSAgICAgIHN0cnVjdCBmaWxlICpmaWxlX291dCwgbG9mZl90IHBvc19vdXQsDQo+ID4g
KwkJCSAgICAgIGxvZmZfdCAqbGVuLCB1bnNpZ25lZCBpbnQgcmVtYXBfZmxhZ3MsDQo+ID4gKwkJ
CSAgICAgIGNvbnN0IHN0cnVjdCBpb21hcF9vcHMgKm9wcykgew0KPiA+ICsJcmV0dXJuIF9fZ2Vu
ZXJpY19yZW1hcF9maWxlX3JhbmdlX3ByZXAoZmlsZV9pbiwgcG9zX2luLCBmaWxlX291dCwNCj4g
PiArCQkJCQkgICAgICAgcG9zX291dCwgbGVuLCByZW1hcF9mbGFncywgb3BzKTsgfQ0KPiA+ICtF
WFBPUlRfU1lNQk9MKGRheF9yZW1hcF9maWxlX3JhbmdlX3ByZXApOw0KPiA+ICsNCj4gPiAraW50
IGdlbmVyaWNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwKHN0cnVjdCBmaWxlICpmaWxlX2luLCBsb2Zm
X3QgcG9zX2luLA0KPiA+ICsJCQkJICBzdHJ1Y3QgZmlsZSAqZmlsZV9vdXQsIGxvZmZfdCBwb3Nf
b3V0LA0KPiA+ICsJCQkJICBsb2ZmX3QgKmxlbiwgdW5zaWduZWQgaW50IHJlbWFwX2ZsYWdzKSB7
DQo+ID4gKwlyZXR1cm4gX19nZW5lcmljX3JlbWFwX2ZpbGVfcmFuZ2VfcHJlcChmaWxlX2luLCBw
b3NfaW4sIGZpbGVfb3V0LA0KPiA+ICsJCQkJCSAgICAgICBwb3Nfb3V0LCBsZW4sIHJlbWFwX2Zs
YWdzLCBOVUxMKTsgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MKGdlbmVyaWNfcmVtYXBfZmlsZV9yYW5n
ZV9wcmVwKTsNCj4gPg0KPiA+ICBsb2ZmX3QgZG9fY2xvbmVfZmlsZV9yYW5nZShzdHJ1Y3QgZmls
ZSAqZmlsZV9pbiwgbG9mZl90IHBvc19pbiwgZGlmZg0KPiA+IC0tZ2l0IGEvZnMveGZzL3hmc19y
ZWZsaW5rLmMgYi9mcy94ZnMveGZzX3JlZmxpbmsuYyBpbmRleA0KPiA+IDZmYTA1ZmI3ODE4OS4u
ZjViM2EzZGEzNmI3IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL3hmcy94ZnNfcmVmbGluay5jDQo+ID4g
KysrIGIvZnMveGZzL3hmc19yZWZsaW5rLmMNCj4gPiBAQCAtMTMwOCw4ICsxMzA4LDEzIEBAIHhm
c19yZWZsaW5rX3JlbWFwX3ByZXAoDQo+ID4gIAlpZiAoSVNfREFYKGlub2RlX2luKSB8fCBJU19E
QVgoaW5vZGVfb3V0KSkNCj4gPiAgCQlnb3RvIG91dF91bmxvY2s7DQo+ID4NCj4gPiAtCXJldCA9
IGdlbmVyaWNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwKGZpbGVfaW4sIHBvc19pbiwgZmlsZV9vdXQs
IHBvc19vdXQsDQo+ID4gLQkJCWxlbiwgcmVtYXBfZmxhZ3MpOw0KPiA+ICsJaWYgKElTX0RBWChp
bm9kZV9pbikpDQo+IA0KPiBpZiAoIUlTX0RBWChpbm9kZV9pbikpIG5vPw0KTXkgbWlzdGFrZS4u
Lg0KPiANCj4gPiArCQlyZXQgPSBnZW5lcmljX3JlbWFwX2ZpbGVfcmFuZ2VfcHJlcChmaWxlX2lu
LCBwb3NfaW4sIGZpbGVfb3V0LA0KPiA+ICsJCQkJCQkgICAgcG9zX291dCwgbGVuLCByZW1hcF9m
bGFncyk7DQo+ID4gKwllbHNlDQo+ID4gKwkJcmV0ID0gZGF4X3JlbWFwX2ZpbGVfcmFuZ2VfcHJl
cChmaWxlX2luLCBwb3NfaW4sIGZpbGVfb3V0LA0KPiA+ICsJCQkJCQlwb3Nfb3V0LCBsZW4sIHJl
bWFwX2ZsYWdzLA0KPiA+ICsJCQkJCQkmeGZzX3JlYWRfaW9tYXBfb3BzKTsNCj4gPiAgCWlmIChy
ZXQgfHwgKmxlbiA9PSAwKQ0KPiA+ICAJCWdvdG8gb3V0X3VubG9jazsNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2RheC5oIGIvaW5jbHVkZS9saW51eC9kYXguaCBpbmRleA0K
PiA+IDMyNzVlMDFlZDMzZC4uMzJlMWMzNDM0OWYyIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUv
bGludXgvZGF4LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2RheC5oDQo+ID4gQEAgLTIzOSw2
ICsyMzksMTAgQEAgaW50IGRheF9pbnZhbGlkYXRlX21hcHBpbmdfZW50cnlfc3luYyhzdHJ1Y3QN
Cj4gYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4gPiAgCQkJCSAgICAgIHBnb2ZmX3QgaW5kZXgp
Ow0KPiA+ICBzNjQgZGF4X2lvbWFwX3plcm8obG9mZl90IHBvcywgdTY0IGxlbmd0aCwgc3RydWN0
IGlvbWFwICppb21hcCwNCj4gPiAgCQlzdHJ1Y3QgaW9tYXAgKnNyY21hcCk7DQo+ID4gK2ludCBk
YXhfZGVkdXBlX2ZpbGVfcmFuZ2VfY29tcGFyZShzdHJ1Y3QgaW5vZGUgKnNyYywgbG9mZl90IHNy
Y29mZiwNCj4gPiArCQkJCSAgc3RydWN0IGlub2RlICpkZXN0LCBsb2ZmX3QgZGVzdG9mZiwNCj4g
PiArCQkJCSAgbG9mZl90IGxlbiwgYm9vbCAqaXNfc2FtZSwNCj4gPiArCQkJCSAgY29uc3Qgc3Ry
dWN0IGlvbWFwX29wcyAqb3BzKTsNCj4gPiAgc3RhdGljIGlubGluZSBib29sIGRheF9tYXBwaW5n
KHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nKSAgew0KPiA+ICAJcmV0dXJuIG1hcHBpbmct
Pmhvc3QgJiYgSVNfREFYKG1hcHBpbmctPmhvc3QpOyBkaWZmIC0tZ2l0DQo+ID4gYS9pbmNsdWRl
L2xpbnV4L2ZzLmggYi9pbmNsdWRlL2xpbnV4L2ZzLmggaW5kZXgNCj4gPiBmZDQ3ZGVlYTdjMTcu
LjJlNmVjNWJkZjgyYSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4gPiBAQCAtNjgsNiArNjgsNyBAQCBzdHJ1Y3QgZnN2
ZXJpdHlfaW5mbzsgIHN0cnVjdCBmc3Zlcml0eV9vcGVyYXRpb25zOw0KPiA+IHN0cnVjdCBmc19j
b250ZXh0OyAgc3RydWN0IGZzX3BhcmFtZXRlcl9zcGVjOw0KPiA+ICtzdHJ1Y3QgaW9tYXBfb3Bz
Ow0KPiA+DQo+ID4gIGV4dGVybiB2b2lkIF9faW5pdCBpbm9kZV9pbml0KHZvaWQpOw0KPiA+ICBl
eHRlcm4gdm9pZCBfX2luaXQgaW5vZGVfaW5pdF9lYXJseSh2b2lkKTsgQEAgLTE5MTAsMTMgKzE5
MTEsMTkgQEANCj4gPiBleHRlcm4gc3NpemVfdCB2ZnNfcmVhZChzdHJ1Y3QgZmlsZSAqLCBjaGFy
IF9fdXNlciAqLCBzaXplX3QsIGxvZmZfdA0KPiA+ICopOyAgZXh0ZXJuIHNzaXplX3QgdmZzX3dy
aXRlKHN0cnVjdCBmaWxlICosIGNvbnN0IGNoYXIgX191c2VyICosDQo+ID4gc2l6ZV90LCBsb2Zm
X3QgKik7ICBleHRlcm4gc3NpemVfdCB2ZnNfY29weV9maWxlX3JhbmdlKHN0cnVjdCBmaWxlICos
IGxvZmZfdCAsIHN0cnVjdA0KPiBmaWxlICosDQo+ID4gIAkJCQkgICBsb2ZmX3QsIHNpemVfdCwg
dW5zaWduZWQgaW50KTsNCj4gPiArdHlwZWRlZiBpbnQgKCpjb21wYXJlX3JhbmdlX3QpKHN0cnVj
dCBpbm9kZSAqc3JjLCBsb2ZmX3Qgc3JjcG9zLA0KPiA+ICsJCQkgICAgICAgc3RydWN0IGlub2Rl
ICpkZXN0LCBsb2ZmX3QgZGVzdHBvcywNCj4gPiArCQkJICAgICAgIGxvZmZfdCBsZW4sIGJvb2wg
KmlzX3NhbWUpOw0KPiANCj4gSXMgdGhpcyB1c2VkIGFueXdoZXJlPw0KDQpObywgSSBmb3Jnb3Qg
dG8gcmVtb3ZlIGl0Li4uDQoNCg0KLS0NClRoYW5rcywNClJ1YW4gU2hpeWFuZy4NCj4gDQo+ID4g
IGV4dGVybiBzc2l6ZV90IGdlbmVyaWNfY29weV9maWxlX3JhbmdlKHN0cnVjdCBmaWxlICpmaWxl
X2luLCBsb2ZmX3QgcG9zX2luLA0KPiA+ICAJCQkJICAgICAgIHN0cnVjdCBmaWxlICpmaWxlX291
dCwgbG9mZl90IHBvc19vdXQsDQo+ID4gIAkJCQkgICAgICAgc2l6ZV90IGxlbiwgdW5zaWduZWQg
aW50IGZsYWdzKTsgLWV4dGVybiBpbnQNCj4gPiBnZW5lcmljX3JlbWFwX2ZpbGVfcmFuZ2VfcHJl
cChzdHJ1Y3QgZmlsZSAqZmlsZV9pbiwgbG9mZl90IHBvc19pbiwNCj4gPiAtCQkJCQkgc3RydWN0
IGZpbGUgKmZpbGVfb3V0LCBsb2ZmX3QgcG9zX291dCwNCj4gPiAtCQkJCQkgbG9mZl90ICpjb3Vu
dCwNCj4gPiAtCQkJCQkgdW5zaWduZWQgaW50IHJlbWFwX2ZsYWdzKTsNCj4gPiAraW50IGdlbmVy
aWNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwKHN0cnVjdCBmaWxlICpmaWxlX2luLCBsb2ZmX3QgcG9z
X2luLA0KPiA+ICsJCQkJICBzdHJ1Y3QgZmlsZSAqZmlsZV9vdXQsIGxvZmZfdCBwb3Nfb3V0LA0K
PiA+ICsJCQkJICBsb2ZmX3QgKmNvdW50LCB1bnNpZ25lZCBpbnQgcmVtYXBfZmxhZ3MpOyBpbnQN
Cj4gPiArZGF4X3JlbWFwX2ZpbGVfcmFuZ2VfcHJlcChzdHJ1Y3QgZmlsZSAqZmlsZV9pbiwgbG9m
Zl90IHBvc19pbiwNCj4gPiArCQkJICAgICAgc3RydWN0IGZpbGUgKmZpbGVfb3V0LCBsb2ZmX3Qg
cG9zX291dCwNCj4gPiArCQkJICAgICAgbG9mZl90ICpsZW4sIHVuc2lnbmVkIGludCByZW1hcF9m
bGFncywNCj4gPiArCQkJICAgICAgY29uc3Qgc3RydWN0IGlvbWFwX29wcyAqb3BzKTsNCj4gPiAg
ZXh0ZXJuIGxvZmZfdCBkb19jbG9uZV9maWxlX3JhbmdlKHN0cnVjdCBmaWxlICpmaWxlX2luLCBs
b2ZmX3QgcG9zX2luLA0KPiA+ICAJCQkJICBzdHJ1Y3QgZmlsZSAqZmlsZV9vdXQsIGxvZmZfdCBw
b3Nfb3V0LA0KPiA+ICAJCQkJICBsb2ZmX3QgbGVuLCB1bnNpZ25lZCBpbnQgcmVtYXBfZmxhZ3Mp
Ow0KPiA+IC0tDQo+ID4gMi4zMC4xDQo+ID4NCj4gPg0KPiA+DQo=
