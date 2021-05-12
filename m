Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC4837B39C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 03:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhELBlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 21:41:22 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:54880 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230154AbhELBlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 21:41:19 -0400
IronPort-SDR: 53A6+YzlHKCiZBzpNd4zLJ8H9eLmEr+Bvcktaq7ipO7yhC6Atzi9Bv11UVmz+GYc8xWO/Drgwj
 VblyTRrzr7LAdnTceOC1m5r2/iTYfAGUZvgSbHQHQ0bNH7fGr3gjO6ya3wZR3UoeJeGhRkw4+Q
 ugZv4A2Up9+/4JGiSaRiNHbSn1A+PsDhuZwmjgCTErnSKLUy17sfRZeWxIhC9XoHoU3yuBD6Tm
 yQh1cMIX2pqwSCzRlpmn9xCSw4zBvXi28zgk+Kop/07AQpYJg1JJBz0L2RFcIp9nD5TMuysRpp
 8oo=
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="31282675"
X-IronPort-AV: E=Sophos;i="5.82,292,1613401200"; 
   d="scan'208";a="31282675"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 10:37:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBfPLJQ6t5JPCFDviZP6PdMLwX1JgYyUnRYPI+m5jGt+EGneGJGbE+oo1seveJjEpeBL12/hQnaOaU7rk4ZmZAulcA4FHgKCKxDHHD7xfQx3ztJN+IqiUWWFG3c6SL3O9qDjMSKOoKstWyN0UMBcNnX1DcYT94GPQWEdpbmpEKd1RV309NGBoXWEC8cXk6Ga8sIajWiq44XJrw6Fces38PMnR7VUJbII1n6gIN0i/JMmq5CWNuBHnL3Zt6KyGEJ3pq2JTm8z0xCp9gvy3sgrThviG7mq4MSkfDgrraQjoh7HWlZdHd/HnOb3PrvmRbWFPW5ZNEhfc1Q60fYfRYg07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCW86joLdl60d/7X4s9We6jevS8YWJ2Pc9jZLuMahog=;
 b=erSGbQ3emBW9alt3PrGRUv+i59zY2AH1SSR6SHOdzIGix5mLYZpP3F+q02VfLMPifbCbNCD6bASmP6zFZ4CZwwzUO25tdf8xPT0K6VZwtsVGr2g4Tcr4GgQZ1/5PT5lrHwbcWRTVIdNWThedPBQX0s0ZXIPBWAXbD/dBfiChy8UrkZ4wyavuG+x2gJiG4USQl/mCy9h6rFR67yvKuqXoZhil8M0cZWWb2wBZudGwsDIgfJtY2E96yX/ohPQwcomvtICczKcBExI1/ufQUDKmeTu6ZUEeCGTqawkPBi6Uyt0lzhsMNmr0sSE05i8ZWJuyImiFMgB4m9WF34YmdTvfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCW86joLdl60d/7X4s9We6jevS8YWJ2Pc9jZLuMahog=;
 b=MFgDSViKYWbDhUZo8fo8Uk8aOWKBcBHLrQk4QvcYsqBjhsexRRiL85hU9popuIh77FDV5TDZkj9RaU2tHqeIVXx96/z3roIoC3DvwnE7TNiV0qprIWRDgC5g1U8FgzK1Hc6h7rfW/iHKMFNJd3VxQjvk+YmLlDD2BcV7m5LTFU0=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB6722.jpnprd01.prod.outlook.com (2603:1096:604:f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 01:37:24 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 01:37:24 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: RE: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
Thread-Topic: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for
 dax_iomap_zero
Thread-Index: AQHXRhMzaICBJaaoNUiclL46cJ8Bn6rfDQsAgAADYFA=
Date:   Wed, 12 May 2021 01:37:24 +0000
Message-ID: <OSBPR01MB2920F14C201E24027A38204AF4529@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-4-ruansy.fnst@fujitsu.com>
 <20210512011738.GT8582@magnolia>
In-Reply-To: <20210512011738.GT8582@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b32d762-4afc-4ef8-123f-08d914e67e4a
x-ms-traffictypediagnostic: OS3PR01MB6722:
x-microsoft-antispam-prvs: <OS3PR01MB6722635AA9953F17B75B7A99F4529@OS3PR01MB6722.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k4Tmkp4wLYkVCKhmw8tyXqdVNqNOfg9KE9mzO2C/BKjOEbcM9BOXqnMCWME1sHKuznBmHImowhH7G0OYaaMxx9q2yXqMAoxPZSgkTMNcp7+f//T+AXg3c1bLN+KnVBU9rhOGzARoESP1tWubygTDxLGfOIvvS0P2pvb/NYq0NJeHCC3PKXq7b14iRUF8uBqqGYZe6bhCOwDI9MCLA/i29WdNkruqCJHEebNAoiogIiYDPS2h5wXbEwtxr+EZ1QcyVvBZ5a6aF63loFqPlXWybLCVy68MzpJDypsSHUHK91rXg5r4i/VYLu9PjxZZVMY1usKIUmuuQ7t7oq2bRJnp13NxakirqaYvtCoZqh2IAQmklouYFGX3MB+QNjdomLJ6JRgN5v+M5xCHqUH9mAeL7nmUUsyuMxtUzgf23mwEwsAN6kbRZTaaF8LjZiao3PLzyU0y03NVCRs/ZPccXJAS/S10wvb2UK0tzCj6GJlK2Ar9+l2ds12Cu2U8Bmr6F/RLafCWdpipZrUs4B4qxRsyAlbPKqmhIvJ5WzHfIc2B+fdXgOvgy7TcK8/A/u3N6bbM6K/vO7iA8eLP8lgqkNgSwSs650qw8SymdhgQOS2GQ88=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(122000001)(5660300002)(478600001)(7416002)(7696005)(8676002)(33656002)(66476007)(71200400001)(54906003)(76116006)(316002)(9686003)(6916009)(186003)(64756008)(4326008)(8936002)(2906002)(86362001)(38100700002)(66946007)(66556008)(83380400001)(55016002)(26005)(66446008)(85182001)(6506007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?TVMrOVN2cUNKU2pyVlhYRkxhb0xEVCtad2xaRDB0U2NLUTczY3EyVk9HWnZm?=
 =?gb2312?B?RWw2MkVrclVrdm1wbitHdkxxQXM4T2pMU0p2RWgzZmVTeVhRZXg0TjRuSXVk?=
 =?gb2312?B?UGkwR3FaeGNqOG9RemErbDQ4bVVUVkh4MlI3aDZBQ2laMER1eGJjRFBWV3hG?=
 =?gb2312?B?TUh0UXBaTGxNV1pZWVZxUmRPbFJIbU41YStrWHlaM1I0YVlZU3l1Yzk3RjFP?=
 =?gb2312?B?SW9JYlpPZEtKbFFZZDdNVDA0K0hhOEQxU205OTBlY2pUdGNrOHB0UHVOM2hU?=
 =?gb2312?B?M1NaSUhwM0EyU3pyR0h1dk5sa0VaU2VLRTdpQlBoM3dpV2xjMDRqTEY3N01M?=
 =?gb2312?B?YjFlY0tnWmNmVmdEU091SDd0RkNTZFRuNVNKTk42N0U4emw0L0dkbjZRMjh6?=
 =?gb2312?B?a1pqN09IK3Q2Wk00bXV5UldxbVFYSmQ0bXY2ZTNHZDZKMHFPaVoxRzhUcmxq?=
 =?gb2312?B?bjdNVjduS0N1NkYwSlVIZWlyMXgwdGIrZ0ZHT0tJR0YzbkwxcG9NZi91aE9I?=
 =?gb2312?B?dzF0VGQwblZJeEpaT3ZMaVU5dnZiZk8vak9keEcrNXgzVEp0OFNrY28zRDMr?=
 =?gb2312?B?Mk5TZDl4b0dkSi9sTHlxcG9XZ0dQMTVjREgyWXRlU2M0cXg0SmYwWjA3RmxJ?=
 =?gb2312?B?RmFhMmM3SkxZYzI0cVdQNUs4d015SjVEby96VExHZHRTZ1ZEaDJ3bGVvUFRB?=
 =?gb2312?B?YjhDdGZFMkRhNGQ4bjV0L2JqLzRzSWxOaVErTm9CcUNVd2lqMlpnQmk1MzIv?=
 =?gb2312?B?aWhpRllNalh6akRyOGNYTFpsTzVkN203QTNGamRjNmE3ZnBSTzRuTnVOTHFZ?=
 =?gb2312?B?L2ZNTmV2bHlCUUR5cTBZck01d0pZZlFoTWVCdEJYVW9uN3BldU01d2tWQURS?=
 =?gb2312?B?c2JlQmI1b240aWJBbEtyRE04eDliNlQ0eVhFcmkyTzN2SnlRQkVJbmlCcTJx?=
 =?gb2312?B?SnBOOE1iVUk5RFFrcEtKdW9TdHJDd3Q2RnhQd2F3NTc1eFA1N1p4Y3k0V2lK?=
 =?gb2312?B?VjVNb1JyaUdIL2puR0EwM1hDZEdubHpvVFJHemdKcUNsNlZ3YWR4K09GVGtm?=
 =?gb2312?B?cnp2SFRSYUJDT1VMdXJrS3lEc3ZwZjR5MWRyNENscHhVUVVESGl6ZDBxUFVE?=
 =?gb2312?B?Z0xlN0wvVk1FNWdsKzkxdWpvSDJvQW1UZVkxc1I2d1g4eXFFb3BXTlZkakNI?=
 =?gb2312?B?ZGlkS3BZUTZUZk15dy9yc0hmVFIybFJ4Nk1CWW9NelhYNVo1cjNQcStWTElt?=
 =?gb2312?B?NEx2dGJEWkNvd1pEUkZXL2duKzdpRk9OVy9hY2d2WHpuOXRBYk1ocGhZdzZo?=
 =?gb2312?B?bXFHeUpHVGNMWWtIVkhVOHJpWmRxM0N5QmErengyTjc4WjRXYk1WN2VVdkpx?=
 =?gb2312?B?ekQ1dFhTMmRVdG1mVzBTaEJnUWhqRXdBSFJ0MXhQWko5d2MxNUdlSzBUSlFU?=
 =?gb2312?B?YnRKU0IzcG8raitUUWRoRXRGbWxsemp1bEx5cStDMmVJMml4MmhoZG9MZ1Zo?=
 =?gb2312?B?RWduMG9zNlNIS0RldzVGeHg4bWNUZmRWMFdBalZpNWNBREo4Skx1L1Fmd1NG?=
 =?gb2312?B?WXpkZE9ScldSeTBZcDgzUitEUkNHZk5lVHhpL285THZMblFmVWxlRVF1Mlo0?=
 =?gb2312?B?UVcvOFZLOVNUdVplSTcvVlJxdThuNzdiSlF4Mi9BZEo0eTlOOUs2R1ZCL2Uy?=
 =?gb2312?B?UkUwbnRMczdrTFJPbXgrZHBMWXdHeXBiUzlReWliOG5rUllQQ1JRd1BnM21H?=
 =?gb2312?Q?/45xLncWqAg2N4vc3m4cZ1bzu62480Cn5F8AeBO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b32d762-4afc-4ef8-123f-08d914e67e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 01:37:24.1953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7cHTNkyzbhDmnyMkYdxIPBfb7/DVeYJgBlwhYNfhFVAWrOPvhGJLaDQUfTOp+W842nIeAh2wTIpFiDnrrdmXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6722
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXJyaWNrIEouIFdvbmcgPGRq
d29uZ0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMvN10gZnNkYXg6IEFk
ZCBkYXhfaW9tYXBfY293X2NvcHkoKSBmb3INCj4gZGF4X2lvbWFwX3plcm8NCj4gDQo+IE9uIFR1
ZSwgTWF5IDExLCAyMDIxIGF0IDExOjA5OjI5QU0gKzA4MDAsIFNoaXlhbmcgUnVhbiB3cm90ZToN
Cj4gPiBQdW5jaCBob2xlIG9uIGEgcmVmbGlua2VkIGZpbGUgbmVlZHMgZGF4X2NvcHlfZWRnZSgp
IHRvby4gIE90aGVyd2lzZSwNCj4gPiBkYXRhIGluIG5vdCBhbGlnbmVkIGFyZWEgd2lsbCBiZSBu
b3QgY29ycmVjdC4gIFNvLCBhZGQgdGhlIHNyY21hcCB0bw0KPiA+IGRheF9pb21hcF96ZXJvKCkg
YW5kIHJlcGxhY2UgbWVtc2V0KCkgYXMgZGF4X2NvcHlfZWRnZSgpLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogU2hpeWFuZyBSdWFuIDxydWFuc3kuZm5zdEBmdWppdHN1LmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogUml0ZXNoIEhhcmphbmkgPHJpdGVzaGhAbGludXguaWJtLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZnMvZGF4LmMgICAgICAgICAgICAgICB8IDI1ICsrKysrKysrKysrKysrKy0tLS0tLS0t
LS0NCj4gPiAgZnMvaW9tYXAvYnVmZmVyZWQtaW8uYyB8ICAyICstDQo+ID4gIGluY2x1ZGUvbGlu
dXgvZGF4LmggICAgfCAgMyArKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9mcy9kYXguYyBiL2Zz
L2RheC5jDQo+ID4gaW5kZXggZWYwZTU2NGU3OTA0Li5lZTlkMjhhNzliZmIgMTAwNjQ0DQo+ID4g
LS0tIGEvZnMvZGF4LmMNCj4gPiArKysgYi9mcy9kYXguYw0KPiA+IEBAIC0xMTg2LDcgKzExODYs
OCBAQCBzdGF0aWMgdm1fZmF1bHRfdCBkYXhfcG1kX2xvYWRfaG9sZShzdHJ1Y3QNCj4gPiB4YV9z
dGF0ZSAqeGFzLCBzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwgIH0gICNlbmRpZiAvKiBDT05GSUdfRlNf
REFYX1BNRA0KPiA+ICovDQo+ID4NCj4gPiAtczY0IGRheF9pb21hcF96ZXJvKGxvZmZfdCBwb3Ms
IHU2NCBsZW5ndGgsIHN0cnVjdCBpb21hcCAqaW9tYXApDQo+ID4gK3M2NCBkYXhfaW9tYXBfemVy
byhsb2ZmX3QgcG9zLCB1NjQgbGVuZ3RoLCBzdHJ1Y3QgaW9tYXAgKmlvbWFwLA0KPiA+ICsJCXN0
cnVjdCBpb21hcCAqc3JjbWFwKQ0KPiA+ICB7DQo+ID4gIAlzZWN0b3JfdCBzZWN0b3IgPSBpb21h
cF9zZWN0b3IoaW9tYXAsIHBvcyAmIFBBR0VfTUFTSyk7DQo+ID4gIAlwZ29mZl90IHBnb2ZmOw0K
PiA+IEBAIC0xMjA4LDE5ICsxMjA5LDIzIEBAIHM2NCBkYXhfaW9tYXBfemVybyhsb2ZmX3QgcG9z
LCB1NjQgbGVuZ3RoLA0KPiA+IHN0cnVjdCBpb21hcCAqaW9tYXApDQo+ID4NCj4gPiAgCWlmIChw
YWdlX2FsaWduZWQpDQo+ID4gIAkJcmMgPSBkYXhfemVyb19wYWdlX3JhbmdlKGlvbWFwLT5kYXhf
ZGV2LCBwZ29mZiwgMSk7DQo+ID4gLQllbHNlDQo+ID4gKwllbHNlIHsNCj4gPiAgCQlyYyA9IGRh
eF9kaXJlY3RfYWNjZXNzKGlvbWFwLT5kYXhfZGV2LCBwZ29mZiwgMSwgJmthZGRyLCBOVUxMKTsN
Cj4gPiAtCWlmIChyYyA8IDApIHsNCj4gPiAtCQlkYXhfcmVhZF91bmxvY2soaWQpOw0KPiA+IC0J
CXJldHVybiByYzsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gLQlpZiAoIXBhZ2VfYWxpZ25lZCkgew0K
PiA+IC0JCW1lbXNldChrYWRkciArIG9mZnNldCwgMCwgc2l6ZSk7DQo+ID4gKwkJaWYgKHJjIDwg
MCkNCj4gPiArCQkJZ290byBvdXQ7DQo+ID4gKwkJaWYgKGlvbWFwLT5hZGRyICE9IHNyY21hcC0+
YWRkcikgew0KPiANCj4gV2h5IGlzbid0IHRoaXMgImlmIChzcmNtYXAtPnR5cGUgIT0gSU9NQVBf
SE9MRSkiID8NCj4gDQo+IEkgc3VwcG9zZSBpdCBoYXMgdGhlIHNhbWUgZWZmZWN0LCBzaW5jZSBA
aW9tYXAgc2hvdWxkIG5ldmVyIGJlIGEgaG9sZSBhbmQgd2UNCj4gc2hvdWxkIG5ldmVyIGhhdmUg
YSBAc3JjbWFwIHRoYXQncyB0aGUgc2FtZSBhcyBAaW9tYXAsIGJ1dCBzdGlsbCwgd2UgdXNlDQo+
IElPTUFQX0hPTEUgY2hlY2tzIGluIG1vc3Qgb3RoZXIgcGFydHMgb2YgZnMvaW9tYXAvLg0KDQpB
Y2NvcmRpbmcgdG8gaXRzIGNhbGxlciBgaW9tYXBfemVyb19yYW5nZV9hY3RvcigpYCwgd2hldGhl
ciBzcmNtYXAtPnR5cGUgaXMgSU9NQVBfSE9MRSBoYXMgYWxyZWFkeSBiZWVuIGNoZWNrZWQgYmVm
b3JlIGBkYXhfaW9tYXBfemVybygpYC4gIFNvIHRoZSBjaGVjayB5b3Ugc3VnZ2VzdGVkIHdpbGwg
YWx3YXlzIGJlIHRydWUuLi4NCg0KDQotLQ0KVGhhbmtzLA0KUnVhbiBTaGl5YW5nLg0KDQo+IA0K
PiBPdGhlciB0aGFuIHRoYXQsIHRoZSBsb2dpYyBsb29rcyBkZWNlbnQgdG8gbWUuDQo+IA0KPiAt
LUQNCj4gDQo+ID4gKwkJCXJjID0gZGF4X2lvbWFwX2Nvd19jb3B5KG9mZnNldCwgc2l6ZSwgUEFH
RV9TSVpFLCBzcmNtYXAsDQo+ID4gKwkJCQkJCWthZGRyKTsNCj4gPiArCQkJaWYgKHJjIDwgMCkN
Cj4gPiArCQkJCWdvdG8gb3V0Ow0KPiA+ICsJCX0gZWxzZQ0KPiA+ICsJCQltZW1zZXQoa2FkZHIg
KyBvZmZzZXQsIDAsIHNpemUpOw0KPiA+ICAJCWRheF9mbHVzaChpb21hcC0+ZGF4X2Rldiwga2Fk
ZHIgKyBvZmZzZXQsIHNpemUpOw0KPiA+ICAJfQ0KPiA+ICsNCj4gPiArb3V0Og0KPiA+ICAJZGF4
X3JlYWRfdW5sb2NrKGlkKTsNCj4gPiAtCXJldHVybiBzaXplOw0KPiA+ICsJcmV0dXJuIHJjIDwg
MCA/IHJjIDogc2l6ZTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBsb2ZmX3QNCj4gPiBkaWZm
IC0tZ2l0IGEvZnMvaW9tYXAvYnVmZmVyZWQtaW8uYyBiL2ZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMg
aW5kZXgNCj4gPiBmMmNkMjAzNGE4N2IuLjI3MzQ5NTVlYTY3ZiAxMDA2NDQNCj4gPiAtLS0gYS9m
cy9pb21hcC9idWZmZXJlZC1pby5jDQo+ID4gKysrIGIvZnMvaW9tYXAvYnVmZmVyZWQtaW8uYw0K
PiA+IEBAIC05MzMsNyArOTMzLDcgQEAgc3RhdGljIGxvZmZfdCBpb21hcF96ZXJvX3JhbmdlX2Fj
dG9yKHN0cnVjdCBpbm9kZQ0KPiAqaW5vZGUsIGxvZmZfdCBwb3MsDQo+ID4gIAkJczY0IGJ5dGVz
Ow0KPiA+DQo+ID4gIAkJaWYgKElTX0RBWChpbm9kZSkpDQo+ID4gLQkJCWJ5dGVzID0gZGF4X2lv
bWFwX3plcm8ocG9zLCBsZW5ndGgsIGlvbWFwKTsNCj4gPiArCQkJYnl0ZXMgPSBkYXhfaW9tYXBf
emVybyhwb3MsIGxlbmd0aCwgaW9tYXAsIHNyY21hcCk7DQo+ID4gIAkJZWxzZQ0KPiA+ICAJCQli
eXRlcyA9IGlvbWFwX3plcm8oaW5vZGUsIHBvcywgbGVuZ3RoLCBpb21hcCwgc3JjbWFwKTsNCj4g
PiAgCQlpZiAoYnl0ZXMgPCAwKQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RheC5o
IGIvaW5jbHVkZS9saW51eC9kYXguaCBpbmRleA0KPiA+IGI1MmYwODRhYTY0My4uMzI3NWUwMWVk
MzNkIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZGF4LmgNCj4gPiArKysgYi9pbmNs
dWRlL2xpbnV4L2RheC5oDQo+ID4gQEAgLTIzNyw3ICsyMzcsOCBAQCB2bV9mYXVsdF90IGRheF9m
aW5pc2hfc3luY19mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQNCj4gPiAqdm1mLCAgaW50IGRheF9kZWxl
dGVfbWFwcGluZ19lbnRyeShzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4gPiBwZ29m
Zl90IGluZGV4KTsgIGludCBkYXhfaW52YWxpZGF0ZV9tYXBwaW5nX2VudHJ5X3N5bmMoc3RydWN0
DQo+IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsDQo+ID4gIAkJCQkgICAgICBwZ29mZl90IGluZGV4
KTsNCj4gPiAtczY0IGRheF9pb21hcF96ZXJvKGxvZmZfdCBwb3MsIHU2NCBsZW5ndGgsIHN0cnVj
dCBpb21hcCAqaW9tYXApOw0KPiA+ICtzNjQgZGF4X2lvbWFwX3plcm8obG9mZl90IHBvcywgdTY0
IGxlbmd0aCwgc3RydWN0IGlvbWFwICppb21hcCwNCj4gPiArCQlzdHJ1Y3QgaW9tYXAgKnNyY21h
cCk7DQo+ID4gIHN0YXRpYyBpbmxpbmUgYm9vbCBkYXhfbWFwcGluZyhzdHJ1Y3QgYWRkcmVzc19z
cGFjZSAqbWFwcGluZykgIHsNCj4gPiAgCXJldHVybiBtYXBwaW5nLT5ob3N0ICYmIElTX0RBWCht
YXBwaW5nLT5ob3N0KTsNCj4gPiAtLQ0KPiA+IDIuMzEuMQ0KPiA+DQo+ID4NCj4gPg0KPiANCg0K
