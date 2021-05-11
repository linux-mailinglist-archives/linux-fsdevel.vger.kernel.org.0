Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFA4379F5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 07:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhEKFzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 01:55:06 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:41953 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhEKFzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 01:55:06 -0400
IronPort-SDR: fPIgCnMqdJHn2yB2gcchxiJhoJCDl2Yx9mgHwIyWZc8RY4YqIZoqtLL3zL2fpneC5BI7QUYn97
 1YpTV9sJzlrNVckvPDjeLywOJiDJXBBQeNXJgVOt435CSzP6YCLkrYwDI3KWofSIEP4o31zAXE
 St/CRks65nSWWd4wjEZOvFUsvrD905Qvhr0VuSHxFdJtgyGHgyIfN1P1s9PcJ+tUxmgRm4PgOT
 FZ7LlrbwvoXSPgJ5IilxzFSaCz8rDaJ67q7+Pz+KjjSMkZSogQNsJH+/G195+mLCdPmQ5ihxe4
 0k4=
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="31056023"
X-IronPort-AV: E=Sophos;i="5.82,290,1613401200"; 
   d="scan'208";a="31056023"
Received: from mail-ty1jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 14:53:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK7OD2fZ7MQZDSIe+RxOwAoOszfsQvUmL0kjgqnZzBEBPRPqGpcH4O5HValxDN20S8yyqh95NekUdH536VqDhCK5/YMut8pvUg6nBrdkTpzPeY3eFrw/ARV20Otl6m6PqJbSrc3b1AEiXl78WNy+lFHzHroLsnvjaXGo/6h1hHUa2+fkY+uL8aj/1j6emayEoa/uKvLkP3lKAGAOOQYrldmTtZ4JPws0Ja5d9qmefOVTKLW/4CxH5wHLNSQbckq9M7zQBzFvuhUklCzbWeeZCTSwebzM/RItx/YyqqYSUD05ta4+2pfr+tOkvQLyIiXUB6YbNxsmlnxUfUo+H+fM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywSVl5JuvVgOwa835Fi/m25xN3VVnOyf0RLVY+05sx4=;
 b=Nggs2oTjXvuXJBRQIIyebsVWFe/fdAPP3Zk7ZvQB8hQ/j8vyvIoBOnbJalDo3JrGYxiI/FKGHtL3Z9uJTbxhgrRSHjrQ+7ZuN3D0fzh3Yf1+tFK9Fh7bXjIjh3CPabInhz1uifa3pdtAzG7NI9HeRiKsuX5LWD20S7mCRyVweD8CmUhEautRCJW2ZZx/tXTVy5BlTqmmHmqStmuGZZCod+nVvg6J408qp3N340cenoFy1KuCBXHbfyKY46yEbUZZgF2v4C52XxkDBT0MYgkAobKczlgUiEUQQI7ueM3MsRkPD9aJiAza+TPxe06uP6GTpHvGKA6OsOrIa5B94sifJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywSVl5JuvVgOwa835Fi/m25xN3VVnOyf0RLVY+05sx4=;
 b=ejvpelUMt0atUPoXs5MdTaMQfZYf85h/BLFOgESp2w/EPTCiiDn+o8ug3TVwJZxHMrllepgYgDmuAZJIKw5mMVAPH0O43q3Z1G6u9aZoYQPfoiMf6q7d4wiSKkeXxrBG6ghWidz8s/Agm3kd0N5Y3StbNiyw/pKTQmZm9W6B4jA=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS0PR01MB6035.jpnprd01.prod.outlook.com (2603:1096:604:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Tue, 11 May
 2021 05:53:51 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 05:53:51 +0000
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
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: RE: [PATCH v5 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
Thread-Topic: [PATCH v5 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
Thread-Index: AQHXRhMgYtQIMqpR5EmTUmDl9HnNxKrdp0QAgAAa8pA=
Date:   Tue, 11 May 2021 05:53:51 +0000
Message-ID: <OSBPR01MB2920C085D788A9F918107F33F4539@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511035706.GL8582@magnolia>
In-Reply-To: <20210511035706.GL8582@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c838aa83-850b-455d-8306-08d914412749
x-ms-traffictypediagnostic: OS0PR01MB6035:
x-microsoft-antispam-prvs: <OS0PR01MB60355CFDFDD3158105FBF4B1F4539@OS0PR01MB6035.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vWqxvLAkvefAaVxmBtPQFAyVlAG23xc23KW1efPdiaegcsBI/k8+aQMPQ/EuszQPMkTZqg6iqKSyq1pQRVZomS8yy9OWUF/Rya323EP3rzua1gOZerDHmmQFKdCG+I2XTOSSDZL3PBNjO/lC782Hk1/HXE3kzquLhdt2Ke9gFkIvZl5Og6qcBJDXFpQPtLZRnbN9pHD9LrTb0yFmKUalnujV2yngU0wGwTg8BZ24ld9O9i2k/S9r3poJBfwqKZYj8j+r3sHkM3hqEstibtfuqAy0yuf3qGVUQiKclc4sWBrdPlAsgdTot7k0YH5qHlaxRy/iFnIdj2y0yh0GtOZalS+Odw/y9g8PkJ/mkeJgjl9bEaQUZQAcu8cO+EMIAFZKAIY3dRD770XZBw9dJUTNqfM2f0te5TENNpA/6emb3rBQ8X9ukQn/VGQJUkQd9Jjqx3XZrtRpG7W6b7XZAVaNdGJ01fVIZV7aEtXeQrezUH9kW8B3s81tbd7Qr810h3hWdY2ZVwKser5ydF/UTjR8vByb0W0N7gt+oqfNN0NI94/oSyDTopUEfbHNyfNaKSRCjFOQQZOR8FO5CbHXlLegTp2Pwo6s42areVdOX+nJGeLE0UngUg4Gxy7LE8v/AyKbnTmBcHOP9vkQZOG+kvSZbvuYp2rXrfAWmkUW91gGlIf0vNSx1OVnNLqCTA/INR73
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(6916009)(8936002)(5660300002)(71200400001)(6506007)(4326008)(478600001)(52536014)(7696005)(122000001)(7416002)(53546011)(83380400001)(38100700002)(33656002)(66476007)(26005)(55016002)(8676002)(66446008)(66556008)(64756008)(76116006)(9686003)(66946007)(85182001)(186003)(86362001)(54906003)(316002)(966005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?N0FSdjcra3JNY0VWRDZac3RJSlFtSGpJbGtEdEJEejhxbFZETExSbjhmOGFV?=
 =?gb2312?B?UzN2aUdFUnpGRzUvam1CK1YwYTVSdDcrVVlRa3JsaEx2VXlDREQ1STk2bllt?=
 =?gb2312?B?UlRTRlUwanczR1ExS3p3d2pTbFdPSmFSM0FDRkQrbjFYbHRHWFFjL1BrcnhM?=
 =?gb2312?B?UDF1T2NOSXNsWmpGeURPMmxyY1NRV05OcEFZNUpDS0FGbXJzbC9QaVVPbFFJ?=
 =?gb2312?B?d0pxUXlGRFlxalkzc1dYK3NCUW1USEc0c3o5YXA0Q1gxUkNjVExYWmlHaUZq?=
 =?gb2312?B?dDc3THBUVmJJK0FuMGQyUW1WcndFSUdaNHZ4OEpzaE1nbnZub0J4VEdwdFg0?=
 =?gb2312?B?S2h1M1dRRVp2M05mR01maXUyQlFRRkllN0pQT2J0UzNvVEt5WURwZ1ZhSmNS?=
 =?gb2312?B?dlpIQ0ZmcVRHUGkvNlFkb0I2aHpJMU5laEJXMkpGZjhQajVDTG5MTTFSS2cv?=
 =?gb2312?B?em1COWRaNWhPYWZpNkhTU0haQk1uRkdOTlAxMlVWVVlZNi9pKzFJRzBuVkRK?=
 =?gb2312?B?cG5LTFZ3TC9MYXN4dEVTcEhCZmpHc1dtbEFnWlViN0NTM3F1eW5MRFhBeGV0?=
 =?gb2312?B?Szl3RWJPZHIzNW5WN1lkVUw4eHhFU2lBQ0FrK2pQMWN3NmtWS2dTYWlPMEw1?=
 =?gb2312?B?S1pzU3dseDZVeDByRFIrZnUxVml5eS8wTlNtVEdDcWl5R0oyNzlKK0ovTG5C?=
 =?gb2312?B?bDdBd0tMSFBjcC9CZE1NbjVuYVN0ckhOMUlCREJJTzRobWw0VG1wZzQra3pn?=
 =?gb2312?B?VWJueDdFNVplMlhETk1yeXlTMDZTdlhjSjFZcXg1VXJlTmoyTkNXSVppMElZ?=
 =?gb2312?B?LzFBYW1uS3Z4c0NrTk9EbFFFRUl3U1oyenlrMExBdzdZVTNMSG1WZVI4cFZp?=
 =?gb2312?B?NW1kMVhyWnFjWkk0NTNOd2JkWWtBWTFXcUI3cUxkc0c1RjBRRCtqNkZkbUxz?=
 =?gb2312?B?TVV5U0hXYkNRQ0FyeGxqWlh6Mnl1Wlk4MkQ5Wi9nQUFMWjNOdWNRZGNYcjlD?=
 =?gb2312?B?RFFSQkpSdU90dGt0YkR3bWJWaXFmV0JVMnZkYWt6Skg2YkkzN095dytRREhL?=
 =?gb2312?B?SnJsdFQwaWVZNXV1cHFIbWlBZ3Vwa1czUXhZWmxEQXYrL2haQVdsNERLSkQ5?=
 =?gb2312?B?MndzM2k5RFpEVGh5Rk5lUG9zcE93MjZ3dk9rQStIQ3JlSVlGQ2lEYkNUT2Jv?=
 =?gb2312?B?MGRVMHVvcFJUdVZyTHFQT3dpNFVLMFdCVXEwRWpyZGZ6NUZ1WjBTem9KV3h5?=
 =?gb2312?B?Y0cvVEROVS92ZmZ5dkJQaXhLbDVDTlplZHBYdVhzKzZSaWw1akFEbXZDV09m?=
 =?gb2312?B?SmdxNXJ3NWswMHhiOHQrTkVacWpyblBXNTE4MTBWSS90ZG0wR1h4UHo0SGFn?=
 =?gb2312?B?djMzaGdkVEg4WDAzbVMrbWw4NkdzK3NPU0d1N2EyZ1RNcWp2OTJnZmdrNE1z?=
 =?gb2312?B?cUU2cGtJbks5bDIrSlpBdlF5VnJObFlvejQrbE0yQXMrVWcvNFVSMUdCcXZV?=
 =?gb2312?B?TVNoektjRkN1RkY3QkxYaUFPUHg1djJsZjlRWEFMYjNBM0huU1pKOTFlSk1i?=
 =?gb2312?B?d0tNMXdvaUx6ZHNyRkN5NjhpbkxMTGl5TEJJSy94MzREdk5BQVd0Y09VV2pk?=
 =?gb2312?B?d3h2Z3IzR3RWWE53L09PaVdPRFBjQnNvem1lMmhOakVidW9pbWlxaGhQYXlX?=
 =?gb2312?B?Y29HR3M0OWd3cHQ0bnJTMnk5bzBZNGtFYTBRN2xrWVRCV0p2S1FXemtFTU1v?=
 =?gb2312?Q?TxYYHxOtpPPjEnJnV1qQShI2a9nv3OvoTmLEyVh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c838aa83-850b-455d-8306-08d914412749
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 05:53:51.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNTXktMlJ8CVcFqO7v7wqFqZ7TqroLMMy9curUrdOpVN4U+CNLuyRc77lNB7QK7KzLHsvuy1b3FZFRg9JKwy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6035
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXJyaWNrIEouIFdvbmcgPGRq
d29uZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMTEsIDIwMjEgMTE6NTcgQU0N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAwLzddIGZzZGF4LHhmczogQWRkIHJlZmxpbmsmZGVk
dXBlIHN1cHBvcnQgZm9yIGZzZGF4DQo+IA0KPiBPbiBUdWUsIE1heSAxMSwgMjAyMSBhdCAxMTow
OToyNkFNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+ID4gVGhpcyBwYXRjaHNldCBpcyBh
dHRlbXB0IHRvIGFkZCBDb1cgc3VwcG9ydCBmb3IgZnNkYXgsIGFuZCB0YWtlIFhGUywNCj4gPiB3
aGljaCBoYXMgYm90aCByZWZsaW5rIGFuZCBmc2RheCBmZWF0dXJlLCBhcyBhbiBleGFtcGxlLg0K
PiANCj4gU2xpZ2h0bHkgb2ZmIHRvcGljLCBidXQgSSBub3RpY2VkIGFsbCBteSBwbWVtIGRpc2Fw
cGVhcmVkIG9uY2UgSSByb2xsZWQgZm9yd2FyZCB0bw0KPiA1LjEzLXJjMS4gIEFtIEkgdGhlIG9u
bHkgbHVja3kgb25lPyAgUWVtdSA0LjIsIHdpdGggZmFrZSBtZW1vcnkgZGV2aWNlcw0KPiBiYWNr
ZWQgYnkgdG1wZnMgZmlsZXMgLS0gaW5mbyBxdHJlZSBzYXlzIHRoZXkncmUgdGhlcmUsIGJ1dCB0
aGUga2VybmVsIGRvZXNuJ3Qgc2hvdw0KPiBhbnl0aGluZyBpbiAvcHJvYy9pb21lbS4NCg0KSSBo
YXZlIHRoZSBzYW1lIHNpdHVhdGlvbiBvbiA1LjEzLXJjMSB0b28uIChRZW11IDUuMi4wLCBmYWtl
IG1lbW9yeSBkZXZpY2UgYmFja2VkIGJ5IGZpbGVzKQ0KSSB0ZXN0ZWQgdGhpcyBjb2RlIGluIHY1
LjEyLXJjOCBhbmQgdGhlbiByZWJhc2VkIGl0IHRvIHY1LjEzLXJjMS4uLiAgSXQncyBteSBiYWQg
Zm9yIG5vdCB0ZXN0aW5nIGFnYWluLg0KDQoNCi0tDQpUaGFua3MsDQpSdWFuIFNoaXlhbmcuDQo+
IA0KPiAtLUQNCj4gDQo+ID4gQ2hhbmdlcyBmcm9tIFY0Og0KPiA+ICAtIEZpeCB0aGUgbWlzdGFr
ZSBvZiBicmVha2luZyBkYXggbGF5b3V0IGZvciB0d28gaW5vZGVzDQo+ID4gIC0gQWRkIENPTkZJ
R19GU19EQVgganVkZ2VtZW50IGZvciBmc2RheCBjb2RlIGluIHJlbWFwX3JhbmdlLmMNCj4gPiAg
LSBGaXggb3RoZXIgc21hbGwgcHJvYmxlbXMgYW5kIG1pc3Rha2VzDQo+ID4NCj4gPiBDaGFuZ2Vz
IGZyb20gVjM6DQo+ID4gIC0gVGFrZSBvdXQgdGhlIGZpcnN0IDMgcGF0Y2hlcyBhcyBhIGNsZWFu
dXAgcGF0Y2hzZXRbMV0sIHdoaWNoIGhhcyBiZWVuDQo+ID4gICAgIHNlbnQgeWVzdGVyZGF5Lg0K
PiA+ICAtIEZpeCB1c2FnZSBvZiBjb2RlIGluIGRheF9pb21hcF9jb3dfY29weSgpDQo+ID4gIC0g
QWRkIGNvbW1lbnRzIGZvciBtYWNybyBkZWZpbml0aW9ucw0KPiA+ICAtIEZpeCBvdGhlciBjb2Rl
IHN0eWxlIHByb2JsZW1zIGFuZCBtaXN0YWtlcw0KPiA+DQo+ID4gT25lIG9mIHRoZSBrZXkgbWVj
aGFuaXNtIG5lZWQgdG8gYmUgaW1wbGVtZW50ZWQgaW4gZnNkYXggaXMgQ29XLiAgQ29weQ0KPiA+
IHRoZSBkYXRhIGZyb20gc3JjbWFwIGJlZm9yZSB3ZSBhY3R1YWxseSB3cml0ZSBkYXRhIHRvIHRo
ZSBkZXN0YW5jZQ0KPiA+IGlvbWFwLiAgQW5kIHdlIGp1c3QgY29weSByYW5nZSBpbiB3aGljaCBk
YXRhIHdvbid0IGJlIGNoYW5nZWQuDQo+ID4NCj4gPiBBbm90aGVyIG1lY2hhbmlzbSBpcyByYW5n
ZSBjb21wYXJpc29uLiAgSW4gcGFnZSBjYWNoZSBjYXNlLCByZWFkcGFnZSgpDQo+ID4gaXMgdXNl
ZCB0byBsb2FkIGRhdGEgb24gZGlzayB0byBwYWdlIGNhY2hlIGluIG9yZGVyIHRvIGJlIGFibGUg
dG8NCj4gPiBjb21wYXJlIGRhdGEuICBJbiBmc2RheCBjYXNlLCByZWFkcGFnZSgpIGRvZXMgbm90
IHdvcmsuICBTbywgd2UgbmVlZA0KPiA+IGFub3RoZXIgY29tcGFyZSBkYXRhIHdpdGggZGlyZWN0
IGFjY2VzcyBzdXBwb3J0Lg0KPiA+DQo+ID4gV2l0aCB0aGUgdHdvIG1lY2hhbmlzbXMgaW1wbGVt
ZW50ZWQgaW4gZnNkYXgsIHdlIGFyZSBhYmxlIHRvIG1ha2UNCj4gPiByZWZsaW5rIGFuZCBmc2Rh
eCB3b3JrIHRvZ2V0aGVyIGluIFhGUy4NCj4gPg0KPiA+IFNvbWUgb2YgdGhlIHBhdGNoZXMgYXJl
IHBpY2tlZCB1cCBmcm9tIEdvbGR3eW4ncyBwYXRjaHNldC4gIEkgbWFkZQ0KPiA+IHNvbWUgY2hh
bmdlcyB0byBhZGFwdCB0byB0aGlzIHBhdGNoc2V0Lg0KPiA+DQo+ID4NCj4gPiAoUmViYXNlZCBv
biB2NS4xMy1yYzEgYW5kIHBhdGNoc2V0WzFdKQ0KPiA+IFsxXTogaHR0cHM6Ly9sa21sLm9yZy9s
a21sLzIwMjEvNC8yMi81NzUNCj4gPg0KPiA+IFNoaXlhbmcgUnVhbiAoNyk6DQo+ID4gICBmc2Rh
eDogSW50cm9kdWNlIGRheF9pb21hcF9jb3dfY29weSgpDQo+ID4gICBmc2RheDogUmVwbGFjZSBt
bWFwIGVudHJ5IGluIGNhc2Ugb2YgQ29XDQo+ID4gICBmc2RheDogQWRkIGRheF9pb21hcF9jb3df
Y29weSgpIGZvciBkYXhfaW9tYXBfemVybw0KPiA+ICAgaW9tYXA6IEludHJvZHVjZSBpb21hcF9h
cHBseTIoKSBmb3Igb3BlcmF0aW9ucyBvbiB0d28gZmlsZXMNCj4gPiAgIGZzZGF4OiBEZWR1cCBm
aWxlIHJhbmdlIHRvIHVzZSBhIGNvbXBhcmUgZnVuY3Rpb24NCj4gPiAgIGZzL3hmczogSGFuZGxl
IENvVyBmb3IgZnNkYXggd3JpdGUoKSBwYXRoDQo+ID4gICBmcy94ZnM6IEFkZCBkYXggZGVkdXBl
IHN1cHBvcnQNCj4gPg0KPiA+ICBmcy9kYXguYyAgICAgICAgICAgICAgIHwgMjA2DQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gIGZzL2lvbWFwL2FwcGx5
LmMgICAgICAgfCAgNTIgKysrKysrKysrKysNCj4gPiAgZnMvaW9tYXAvYnVmZmVyZWQtaW8uYyB8
ICAgMiArLQ0KPiA+ICBmcy9yZW1hcF9yYW5nZS5jICAgICAgIHwgIDU3ICsrKysrKysrKystLQ0K
PiA+ICBmcy94ZnMveGZzX2JtYXBfdXRpbC5jIHwgICAzICstDQo+ID4gIGZzL3hmcy94ZnNfZmls
ZS5jICAgICAgfCAgMTEgKy0tDQo+ID4gIGZzL3hmcy94ZnNfaW5vZGUuYyAgICAgfCAgNjYgKysr
KysrKysrKysrLQ0KPiA+ICBmcy94ZnMveGZzX2lub2RlLmggICAgIHwgICAxICsNCj4gPiAgZnMv
eGZzL3hmc19pb21hcC5jICAgICB8ICA2MSArKysrKysrKysrKy0NCj4gPiAgZnMveGZzL3hmc19p
b21hcC5oICAgICB8ICAgNCArDQo+ID4gIGZzL3hmcy94ZnNfaW9wcy5jICAgICAgfCAgIDcgKy0N
Cj4gPiAgZnMveGZzL3hmc19yZWZsaW5rLmMgICB8ICAxNSArLS0NCj4gPiAgaW5jbHVkZS9saW51
eC9kYXguaCAgICB8ICAgNyArLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2ZzLmggICAgIHwgIDEyICsr
LQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2lvbWFwLmggIHwgICA3ICstDQo+ID4gIDE1IGZpbGVzIGNo
YW5nZWQsIDQ0OSBpbnNlcnRpb25zKCspLCA2MiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IC0tDQo+
ID4gMi4zMS4xDQo+ID4NCj4gPg0KPiA+DQo=
