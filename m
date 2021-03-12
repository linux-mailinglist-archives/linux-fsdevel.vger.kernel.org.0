Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5588338A0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 11:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhCLK0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 05:26:35 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:25690 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233188AbhCLK0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:26:25 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Mar 2021 05:26:23 EST
IronPort-SDR: BE2kqCUOs+YbkO4/TfSI2mmOojSUF5CJrJYiQamO0sI0APOg/iE5xsvJAtjI/uvkMY0tMi3MiG
 kSU7Po0gumyjlMFHYbzEGws4HXXVihAUkRWQRGI6sQgI6ri4p8ptYlOxxFB54exDQ1f8DwIDWZ
 7Zu+59skBnN8Sh4WsL5Ki2AImhrN6yyAbMyqBkILa0DSgHCE7Zso5ZXUH9YWgMqvcfXhdVdHEX
 Ln2qXqYj/VDzmW6Q2MEwgPZa+MKbO0MAZtK+4Gd+3cn0CWFH5o7VqG8ExPvt05CdgYtKmX+OFH
 ovE=
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="35826815"
X-IronPort-AV: E=Sophos;i="5.81,243,1610377200"; 
   d="scan'208";a="35826815"
Received: from mail-ty1jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 19:19:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOVl0PBlvOINu+7h2pT++bhSeoxC8nJMmGVLA42gSJfVd4We/sXSv2fzXGoAv9FPguhzryAPHbN9YYcC3Z6XrXBy6o34XlZguMGEucCgbmzxkyCsudkvCZ1eH+9gONqHe91SSF1pr0drqNdAh8q176/LDJKUZJTzyE8apTUPkq5D3DhkiaFS6ji3F2BNiVMgLwmcMN5Onc5fXkjSbeNdzHB4CZrYRfD/S0UYfBz9Ef2uK/NoV6e6n0uVURJxhLkNZUPBK95Ms7PWHf46RT915QFk/1lUm9w9CtkohpuGlLy+1er1gZg6GNfWbKBfUnSlzaLCmObjkrSDO/6srFm5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A+q/LIVtl8nw4QRQMucXxYfNJLCAqe3llPGRr2TjfE=;
 b=OodlpXl9f3281NwYpJ3Q8SHdNuePhycQXOG2N30zDFbwmddPtWg88zOKIrU7y5fFYLbnsznPgWz0vt83INGXC2AoMLwtAw8HkU4jyWYb3pYkxKYJ8ed1UmQEHusZFKi81rHGO2/9FKYMIlUBx/qyRWSVlX9XrIBG3VF6oKA0+7UjODd1YfscjABVAP2y6moeEeS0iF9FTfd79TrUm1zJEt6AfqxOcLM9z4l9jRRLnoQXFTf0zMpbZe9B1+WpXaptv9HBJnUD+qHRIwsQI5qvD7oneB84tWjSKt9R+PUmeemJQbBLpW4AFWjRdASHOjYiQE+Bz5vXlKgCvf1F9w4MjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A+q/LIVtl8nw4QRQMucXxYfNJLCAqe3llPGRr2TjfE=;
 b=S+HSMrYcSBXyPkW63VZ0pXOkK5+KfW+NBWZZAsrw/HYpl4wVEy4R/PEEVWlHkHDsDNcQIP8uFhRjiGA0renGkZaVkLpuNOxRMIWaXbWV4aO7LvvuB02tNTjCE4PIGxZE4rXjVtmDHotdFhDWg8lKtuV4itvmzh8XF20TO88mJ00=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSBPR01MB3285.jpnprd01.prod.outlook.com (2603:1096:604:1f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Fri, 12 Mar
 2021 10:18:59 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063%3]) with mapi id 15.20.3912.027; Fri, 12 Mar 2021
 10:18:59 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: RE: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Topic: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Index: AQHW/gjzAa5hnh6PaUq187fVBTbxkqp3lL+AgAIDAHSAACKcgIAARgh1gACNxwCABb8rEA==
Date:   Fri, 12 Mar 2021 10:18:58 +0000
Message-ID: <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>
 <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
 <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com>
In-Reply-To: <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 035cdfb5-f722-4166-77e7-08d8e5404029
x-ms-traffictypediagnostic: OSBPR01MB3285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB3285FF7DDC5D33573D21ABDCF46F9@OSBPR01MB3285.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wezIMGHhX/LzoDNXoLe/G9/AIK8zzdReRQWz+f1UbDjtmXIPQdB48Tq1Kn9EggqNFy3stPHrinDyfBQNGS4QWTWNu5Uqm6OX8euhYU8+vMEaVXbq7g6dyAmZB6ZdkXdqo4bSiATvcrzb20aMmjWyAv5Sjt+gun4WoQ7RslzwcfrX93N1hdGqNxmNKueqfr2uFwyP7z/6GCVWQGAZPD1HlChD4WS6lq95BOizTKdqAQDtDAMA4ZHtHz14qDLv/oJv//1gMN4RpKmHJbVL0NDNQLM6EwAK3RNCUOUVMn3QefoaELd/klyZDZ8a/pR9ICghKfmtqpJsXW4Jr7bnJ+RvQxgocemoWcMkt4CTJTSt6FCxUHdNU/iJkDC8T80fTIu4vhM1mIDNr809R77nqTMmdNWY0qX+O0350WrfAjSZICN5H/wlOj4UXa6UteVgtsPGhdLu3hR7XHo2IUcLb5lCexdg9s6G9Bw3LwFaORLHMLVqrzx/Oqly1yK6hbG5aoluNvrKvOB5ogyviCeEF4JsLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(33656002)(9686003)(76116006)(52536014)(7416002)(83380400001)(5660300002)(316002)(66556008)(8936002)(26005)(66946007)(6916009)(55016002)(7696005)(66446008)(186003)(6506007)(53546011)(478600001)(71200400001)(54906003)(2906002)(4326008)(86362001)(8676002)(107886003)(85182001)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eVNWV2hnQVNodmswNFdIb0doQlBMbzhqVUsrK3JlcWFWQjR5NmVCY2E4cGhq?=
 =?utf-8?B?Q3MyZ3dEUk16VEYzU21FMFFyV1pGVUlvSk9IOURESEwyb01oSFkyYzcyeUdr?=
 =?utf-8?B?czN3L0cveFhQNThUZk11M2VlYW1Wd0hHTzluTEQvUmY5ZDZyQ21DUTE0RG5V?=
 =?utf-8?B?ZUNLZFlYalBsZngxWGFKem5EcllyUXJjWGNFbFJhbzVYRFJPaDUxa0Znendp?=
 =?utf-8?B?WW81MGNBRGJjaWFHU0NCbjZUTFR4azZUVHJyQStRZGdudDFwWFlCZmRLUW40?=
 =?utf-8?B?Qk1zelkxRkRxamE0Q1hwWmZVa3k4bUhSVUZFYjVLcGVJdmYxZUJHbFg4U3Vt?=
 =?utf-8?B?VXFuYXNZUFg2bElxVFJjVXdXL3pJOVN1NVkramJpZ0xOcHZuQnIvMnN4Q25P?=
 =?utf-8?B?dnY2TXorK3c3Z0xQdmo4MTZjUlVsS1Zla1Rjd1Nrdm8rbmEzb0UzZGxsOFA2?=
 =?utf-8?B?Z1RNNVFSY0NwRkttZmV0cXJvWmNxSmVNbU5LM2NrY2N5eG1qUlRSa2FBWUda?=
 =?utf-8?B?b2QxQktGcVM3NFFyNTVTTStDUTZVUzRZSzI5SUJrYTlrWnpuZjJjeTcxbGl3?=
 =?utf-8?B?NFFKSUgvUi9oYjYxQ0FOK0VyZ3Vmb1VkbCtNQXFhUzZvNitLUm1welg0Njk3?=
 =?utf-8?B?em5MeUErVlNFOVNoRnBkekdCcHZIc1BWa2pmeHFHMm1OZHVFV0QwNUJaNlMz?=
 =?utf-8?B?Z2dqNDdGV2dBUWdYM2lHMjZNT0F6Y0xlbVBEODdycUthNDRBVklZbVV0UG50?=
 =?utf-8?B?bFRTYlY5QmVIMmRpZXg0dCtNODk3aklaUjMzbnYwQ1dZVWt5TDZTRDF0R0xs?=
 =?utf-8?B?c3dZcDBnYmJ1YjVPcFlrQ0xJdXgzVGtVR0UraXFyREpxSUora3VHanZoWTMr?=
 =?utf-8?B?VVFYS204UVB4b3QzUElDdjdWeGlja3hOckZ3TG50SURRdXhOc1pKc2JiWGE5?=
 =?utf-8?B?MXNKYXV6Vm13RDNpSzduRUROeFhOME5YbDlzRVpxSk41WElxc000RFIrSXRU?=
 =?utf-8?B?R3FuTEhZcHNqYnRxZDAxaENUTFVteUUwUWhyYW9SVUtxN1drS2ZMa0ZwZGZZ?=
 =?utf-8?B?WHpzdnJzRmRXY09uQk1kb0FTS2VLb3k1MS9sVTl3T0wwWFlmSXFuc3V0eURl?=
 =?utf-8?B?aDMydE15V2dOVlNCemlsdmJlTStKaXhuR05YTmZGT1hTT1JMb3g5OEFIdS9M?=
 =?utf-8?B?NTdtS2h5WW00VHNRaXBFZ0huQVhWNU8zL3RHWjFIdkk0bXRFZjE1b01FeDdt?=
 =?utf-8?B?T0V0ZWNlK3hZMUoycHRUSWZuTEtQenJFVkxmanhIM3VIeWdIVVYvZHVpcDNx?=
 =?utf-8?B?eWd6ZGFnMnE0NFpZNE5PdVZBdnFUME83ZER6S0EwZklCZWdrczRRSHAyTnRx?=
 =?utf-8?B?dGo5VmZRdkhWblBjQlk1Q0RPVXFsVENLSU1sN3JFWmVBOXd5NHBQYTFIUjZQ?=
 =?utf-8?B?RlJyU2R1MFRQV3NQbms0WEJDV0VRRlRiZUZ2UU9zN3daWUNPT0xXSERtcUc0?=
 =?utf-8?B?c1R5WGZlcUxGZlJQdlhFUjR1YmFqOVZ4NExkVzA4OE11dmZNbUxQZ0s3L0RZ?=
 =?utf-8?B?NEkrNG1DdjhablJER2tuWXBndCtQbktLVUdiUmV5dmErZDlseFlDV3Q2ZVp2?=
 =?utf-8?B?TDJXV25rV2NZRzNrSDNIdlk0NFF3Q1lXbFVXMWludURMbnBoTmpSWHJRS0FF?=
 =?utf-8?B?dWdZSFZMbDJyeDJzKzdjelJQR3JyRVNwU1FwOXZRMXV2ZGowd0I2c1NGRTVj?=
 =?utf-8?Q?qSqJb39YAxFfNo1ceMNqst3pS+aZlYkoQRzCdIN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035cdfb5-f722-4166-77e7-08d8e5404029
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 10:18:58.9642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eZsFLftvM3Vo++GjOZfyLJ6WHkqfsDwkjPVaPdnZ6qaMSW+ucjusr7wZlwsTmWe9BYyYqfWSBUeuguVUgwwlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3285
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDEvMTFd
IHBhZ2VtYXA6IEludHJvZHVjZSAtPm1lbW9yeV9mYWlsdXJlKCkNCj4gDQo+IE9uIE1vbiwgTWFy
IDgsIDIwMjEgYXQgMzozNCBBTSBydWFuc3kuZm5zdEBmdWppdHN1LmNvbQ0KPiA8cnVhbnN5LmZu
c3RAZnVqaXRzdS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKykNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9tZW1yZW1hcC5oDQo+ID4gPiA+ID4gPiBiL2luY2x1ZGUvbGludXgvbWVtcmVtYXAu
aCBpbmRleCA3OWM0OWU3ZjVjMzAuLjBiY2YyYjFlMjBiZA0KPiA+ID4gPiA+ID4gMTAwNjQ0DQo+
ID4gPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21lbXJlbWFwLmgNCj4gPiA+ID4gPiA+ICsr
KyBiL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KPiA+ID4gPiA+ID4gQEAgLTg3LDYgKzg3LDE0
IEBAIHN0cnVjdCBkZXZfcGFnZW1hcF9vcHMgew0KPiA+ID4gPiA+ID4gICAgICAgICAgKiB0aGUg
cGFnZSBiYWNrIHRvIGEgQ1BVIGFjY2Vzc2libGUgcGFnZS4NCj4gPiA+ID4gPiA+ICAgICAgICAg
ICovDQo+ID4gPiA+ID4gPiAgICAgICAgIHZtX2ZhdWx0X3QgKCptaWdyYXRlX3RvX3JhbSkoc3Ry
dWN0IHZtX2ZhdWx0ICp2bWYpOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgICAv
Kg0KPiA+ID4gPiA+ID4gKyAgICAgICAgKiBIYW5kbGUgdGhlIG1lbW9yeSBmYWlsdXJlIGhhcHBl
bnMgb24gb25lIHBhZ2UuICBOb3RpZnkNCj4gdGhlIHByb2Nlc3Nlcw0KPiA+ID4gPiA+ID4gKyAg
ICAgICAgKiB3aG8gYXJlIHVzaW5nIHRoaXMgcGFnZSwgYW5kIHRyeSB0byByZWNvdmVyIHRoZSBk
YXRhIG9uDQo+IHRoaXMgcGFnZQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgKiBpZiBuZWNlc3Nhcnku
DQo+ID4gPiA+ID4gPiArICAgICAgICAqLw0KPiA+ID4gPiA+ID4gKyAgICAgICBpbnQgKCptZW1v
cnlfZmFpbHVyZSkoc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCwNCj4gdW5zaWduZWQgbG9uZyBw
Zm4sDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZmxhZ3Mp
Ow0KPiA+ID4gPiA+ID4gIH07DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBZnRlciB0aGUgY29udmVy
c2F0aW9uIHdpdGggRGF2ZSBJIGRvbid0IHNlZSB0aGUgcG9pbnQgb2YgdGhpcy4NCj4gPiA+ID4g
PiBJZiB0aGVyZSBpcyBhIG1lbW9yeV9mYWlsdXJlKCkgb24gYSBwYWdlLCB3aHkgbm90IGp1c3Qg
Y2FsbA0KPiA+ID4gPiA+IG1lbW9yeV9mYWlsdXJlKCk/IFRoYXQgYWxyZWFkeSBrbm93cyBob3cg
dG8gZmluZCB0aGUgaW5vZGUgYW5kDQo+ID4gPiA+ID4gdGhlIGZpbGVzeXN0ZW0gY2FuIGJlIG5v
dGlmaWVkIGZyb20gdGhlcmUuDQo+ID4gPiA+DQo+ID4gPiA+IFdlIHdhbnQgbWVtb3J5X2ZhaWx1
cmUoKSBzdXBwb3J0cyByZWZsaW5rZWQgZmlsZXMuICBJbiB0aGlzIGNhc2UsDQo+ID4gPiA+IHdl
IGFyZSBub3QgYWJsZSB0byB0cmFjayBtdWx0aXBsZSBmaWxlcyBmcm9tIGEgcGFnZSh0aGlzIGJy
b2tlbg0KPiA+ID4gPiBwYWdlKSBiZWNhdXNlDQo+ID4gPiA+IHBhZ2UtPm1hcHBpbmcscGFnZS0+
aW5kZXggY2FuIG9ubHkgdHJhY2sgb25lIGZpbGUuICBUaHVzLCBJDQo+ID4gPiA+IHBhZ2UtPmlu
dHJvZHVjZSB0aGlzDQo+ID4gPiA+IC0+bWVtb3J5X2ZhaWx1cmUoKSBpbXBsZW1lbnRlZCBpbiBw
bWVtIGRyaXZlciwgdG8gY2FsbA0KPiA+ID4gPiAtPi0+Y29ycnVwdGVkX3JhbmdlKCkNCj4gPiA+
ID4gdXBwZXIgbGV2ZWwgdG8gdXBwZXIgbGV2ZWwsIGFuZCBmaW5hbGx5IGZpbmQgb3V0IGZpbGVz
IHdobyBhcmUNCj4gPiA+ID4gdXNpbmcobW1hcHBpbmcpIHRoaXMgcGFnZS4NCj4gPiA+ID4NCj4g
PiA+DQo+ID4gPiBJIGtub3cgdGhlIG1vdGl2YXRpb24sIGJ1dCB0aGlzIGltcGxlbWVudGF0aW9u
IHNlZW1zIGJhY2t3YXJkcy4gSXQncw0KPiA+ID4gYWxyZWFkeSB0aGUgY2FzZSB0aGF0IG1lbW9y
eV9mYWlsdXJlKCkgbG9va3MgdXAgdGhlIGFkZHJlc3Nfc3BhY2UNCj4gPiA+IGFzc29jaWF0ZWQg
d2l0aCBhIG1hcHBpbmcuIEZyb20gdGhlcmUgSSB3b3VsZCBleHBlY3QgYSBuZXcgJ3N0cnVjdA0K
PiA+ID4gYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zJyBvcCB0byBsZXQgdGhlIGZzIGhhbmRsZSB0
aGUgY2FzZSB3aGVuDQo+ID4gPiB0aGVyZSBhcmUgbXVsdGlwbGUgYWRkcmVzc19zcGFjZXMgYXNz
b2NpYXRlZCB3aXRoIGEgZ2l2ZW4gZmlsZS4NCj4gPiA+DQo+ID4NCj4gPiBMZXQgbWUgdGhpbmsg
YWJvdXQgaXQuICBJbiB0aGlzIHdheSwgd2UNCj4gPiAgICAgMS4gYXNzb2NpYXRlIGZpbGUgbWFw
cGluZyB3aXRoIGRheCBwYWdlIGluIGRheCBwYWdlIGZhdWx0Ow0KPiANCj4gSSB0aGluayB0aGlz
IG5lZWRzIHRvIGJlIGEgbmV3IHR5cGUgb2YgYXNzb2NpYXRpb24gdGhhdCBwcm94aWVzIHRoZSBy
ZXByZXNlbnRhdGlvbg0KPiBvZiB0aGUgcmVmbGluayBhY3Jvc3MgYWxsIGludm9sdmVkIGFkZHJl
c3Nfc3BhY2VzLg0KPiANCj4gPiAgICAgMi4gaXRlcmF0ZSBmaWxlcyByZWZsaW5rZWQgdG8gbm90
aWZ5IGBraWxsIHByb2Nlc3NlcyBzaWduYWxgIGJ5IHRoZQ0KPiA+ICAgICAgICAgICBuZXcgYWRk
cmVzc19zcGFjZV9vcGVyYXRpb247DQo+ID4gICAgIDMuIHJlLWFzc29jaWF0ZSB0byBhbm90aGVy
IHJlZmxpbmtlZCBmaWxlIG1hcHBpbmcgd2hlbiB1bm1tYXBpbmcNCj4gPiAgICAgICAgIChybWFw
IHFldXJ5IGluIGZpbGVzeXN0ZW0gdG8gZ2V0IHRoZSBhbm90aGVyIGZpbGUpLg0KPiANCj4gUGVy
aGFwcyB0aGUgcHJveHkgb2JqZWN0IGlzIHJlZmVyZW5jZSBjb3VudGVkIHBlci1yZWYtbGluay4g
SXQgc2VlbXMgZXJyb3IgcHJvbmUNCj4gdG8ga2VlcCBjaGFuZ2luZyB0aGUgYXNzb2NpYXRpb24g
b2YgdGhlIHBmbiB3aGlsZSB0aGUgcmVmbGluayBpcyBpbi10YWN0Lg0KSGksIERhbg0KDQpJIHRo
aW5rIG15IGVhcmx5IHJmYyBwYXRjaHNldCB3YXMgaW1wbGVtZW50ZWQgaW4gdGhpcyB3YXk6DQog
LSBDcmVhdGUgYSBwZXItcGFnZSAnZGF4LXJtYXAgdHJlZScgdG8gc3RvcmUgZWFjaCByZWZsaW5r
ZWQgZmlsZSdzIChtYXBwaW5nLCBvZmZzZXQpIHdoZW4gY2F1c2luZyBkYXggcGFnZSBmYXVsdC4N
CiAtIE1vdW50IHRoaXMgdHJlZSBvbiBwYWdlLT56b25lX2RldmljZV9kYXRhIHdoaWNoIGlzIG5v
dCB1c2VkIGluIGZzZGF4LCBzbyB0aGF0IHdlIGNhbiBpdGVyYXRlIHJlZmxpbmtlZCBmaWxlIG1h
cHBpbmdzIGluIG1lbW9yeV9mYWlsdXJlKCkgZWFzaWx5Lg0KSW4gbXkgdW5kZXJzdGFuZGluZywg
dGhlIGRheC1ybWFwIHRyZWUgaXMgdGhlIHByb3h5IG9iamVjdCB5b3UgbWVudGlvbmVkLiAgSWYg
c28sIEkgaGF2ZSB0byBzYXksIHRoaXMgbWV0aG9kIHdhcyByZWplY3RlZC4gQmVjYXVzZSB0aGlz
IHdpbGwgY2F1c2UgaHVnZSBvdmVyaGVhZCBpbiBzb21lIGNhc2UgdGhhdCBldmVyeSBkYXggcGFn
ZSBoYXZlIG9uZSBkYXgtcm1hcCB0cmVlLg0KDQoNCi0tDQpUaGFua3MsDQpSdWFuIFNoaXlhbmcu
DQo+IA0KPiA+IEl0IGRpZCBub3QgaGFuZGxlIHRob3NlIGRheCBwYWdlcyBhcmUgbm90IGluIHVz
ZSwgYmVjYXVzZSB0aGVpcg0KPiA+IC0+bWFwcGluZyBhcmUgbm90IGFzc29jaWF0ZWQgdG8gYW55
IGZpbGUuICBJIGRpZG4ndCB0aGluayBpdCB0aHJvdWdoDQo+ID4gdW50aWwgcmVhZGluZyB5b3Vy
IGNvbnZlcnNhdGlvbi4gIEhlcmUgaXMgbXkgdW5kZXJzdGFuZGluZzogdGhpcyBjYXNlDQo+ID4g
c2hvdWxkIGJlIGhhbmRsZWQgYnkgYmFkYmxvY2sgbWVjaGFuaXNtIGluIHBtZW0gZHJpdmVyLiAg
VGhpcyBiYWRibG9jaw0KPiA+IG1lY2hhbmlzbSB3aWxsIGNhbGwNCj4gPiAtPmNvcnJ1cHRlZF9y
YW5nZSgpIHRvIHRlbGwgZmlsZXN5c3RlbSB0byByZXBhaXJlIHRoZSBkYXRhIGlmIHBvc3NpYmxl
Lg0KPiANCj4gVGhlcmUgYXJlIDIgdHlwZXMgb2Ygbm90aWZpY2F0aW9ucy4gVGhlcmUgYXJlIGJh
ZGJsb2NrcyBkaXNjb3ZlcmVkIGJ5IHRoZSBkcml2ZXINCj4gKHNlZSBub3RpZnlfcG1lbSgpKSBh
bmQgdGhlcmUgYXJlIG1lbW9yeV9mYWlsdXJlcygpIHNpZ25hbGxlZCBieSB0aGUgQ1BVDQo+IG1h
Y2hpbmUtY2hlY2sgaGFuZGxlciwgb3IgdGhlIHBsYXRmb3JtIEJJT1MuIEluIHRoZSBjYXNlIG9m
IGJhZGJsb2NrcyB0aGF0DQo+IG5lZWRzIHRvIGJlIGluZm9ybWF0aW9uIGNvbnNpZGVyZWQgYnkg
dGhlIGZzIGJsb2NrIGFsbG9jYXRvciB0byBhdm9pZCAvDQo+IHRyeS10by1yZXBhaXIgYmFkYmxv
Y2tzIG9uIGFsbG9jYXRlLCBhbmQgdG8gYWxsb3cgbGlzdGluZyBkYW1hZ2VkIGZpbGVzIHRoYXQg
bmVlZA0KPiByZXBhaXIuIFRoZSBtZW1vcnlfZmFpbHVyZSgpIG5vdGlmaWNhdGlvbiBuZWVkcyBp
bW1lZGlhdGUgaGFuZGxpbmcgdG8gdGVhcg0KPiBkb3duIG1hcHBpbmdzIHRvIHRoYXQgcGZuIGFu
ZCBzaWduYWwgcHJvY2Vzc2VzIHRoYXQgaGF2ZSBjb25zdW1lZCBpdCB3aXRoDQo+IFNJR0JVUy1h
Y3Rpb24tcmVxdWlyZWQuIFByb2Nlc3NlcyB0aGF0IGhhdmUgdGhlIHBvaXNvbiBtYXBwZWQsIGJ1
dCBoYXZlIG5vdA0KPiBjb25zdW1lZCBpdCByZWNlaXZlIFNJR0JVUy1hY3Rpb24tb3B0aW9uYWwu
DQo+IA0KPiA+IFNvLCB3ZSBzcGxpdCBpdCBpbnRvIHR3byBwYXJ0cy4gIEFuZCBkYXggZGV2aWNl
IGFuZCBibG9jayBkZXZpY2Ugd29uJ3QgYmUNCj4gbWl4ZWQNCj4gPiB1cCBhZ2Fpbi4gICBJcyBt
eSB1bmRlcnN0YW5kaW5nIHJpZ2h0Pw0KPiANCj4gUmlnaHQsIGl0J3Mgb25seSB0aGUgZmlsZXN5
c3RlbSB0aGF0IGtub3dzIHRoYXQgdGhlIGJsb2NrX2RldmljZSBhbmQgdGhlDQo+IGRheF9kZXZp
Y2UgYWxpYXMgZGF0YSBhdCB0aGUgc2FtZSBsb2dpY2FsIG9mZnNldC4gVGhlIHJlcXVpcmVtZW50
cyBmb3Igc2VjdG9yDQo+IGVycm9yIGhhbmRsaW5nIGFuZCBwYWdlIGVycm9yIGhhbmRsaW5nIGFy
ZSBzZXBhcmF0ZSBsaWtlDQo+IGJsb2NrX2RldmljZV9vcGVyYXRpb25zIGFuZCBkYXhfb3BlcmF0
aW9ucy4NCj4gDQo+ID4gQnV0IHRoZSBzb2x1dGlvbiBhYm92ZSBpcyB0byBzb2x2ZSB0aGUgaHdw
b2lzb24gb24gb25lIG9yIGNvdXBsZQ0KPiA+IHBhZ2VzLCB3aGljaCBoYXBwZW5zIHJhcmVseShJ
IHRoaW5rKS4gIERvIHRoZSAncG1lbSByZW1vdmUnIG9wZXJhdGlvbg0KPiBjYXVzZSBod3BvaXNv
biB0b28/DQo+ID4gQ2FsbCBtZW1vcnlfZmFpbHVyZSgpIHNvIG1hbnkgdGltZXM/ICBJIGhhdm4n
dCB1bmRlcnN0b29kIHRoaXMgeWV0Lg0KPiANCj4gSSdtIHdvcmtpbmcgb24gYSBwYXRjaCBoZXJl
IHRvIGNhbGwgbWVtb3J5X2ZhaWx1cmUoKSBvbiBhIHdpZGUgcmFuZ2UgZm9yIHRoZQ0KPiBzdXJw
cmlzZSByZW1vdmUgb2YgYSBkYXhfZGV2aWNlIHdoaWxlIGEgZmlsZXN5c3RlbSBtaWdodCBiZSBt
b3VudGVkLiBJdCB3b24ndA0KPiBiZSBlZmZpY2llbnQsIGJ1dCB0aGVyZSBpcyBubyBvdGhlciB3
YXkgdG8gbm90aWZ5IHRoZSBrZXJuZWwgdGhhdCBpdCBuZWVkcyB0bw0KPiBpbW1lZGlhdGVseSBz
dG9wIHJlZmVyZW5jaW5nIGEgcGFnZS4NCg==
