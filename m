Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F6436BD74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 04:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhD0Cp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 22:45:26 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:14123 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231363AbhD0CpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:45:25 -0400
IronPort-SDR: TqZBe5NlH/Ed7W6BVPwgqH0mKVb0zv2PuYmRM2LP3tjbHH/lQJGGBLmPa+8GqXNVyrLujJ1djf
 6GNAlOSNc8dhMWFS+oFEy7cPKlt8/eS9ZYWwhQ2eAit5zYVYoF5q6ftbZDwzSOPzwE/uDE8tCc
 ZD+5T47w/rb5Ley/mW+VYkcM4JJEVFoxtk/IzgAE+dL6vlv0sfndH1uZWRbGHWBw/Oi/gpiSKs
 clEe1a91fRSnrLL7wwAz4ulFQjvS/A5zZAqxvk8MIz1c42kAfBqQikPgx28YlhOm7dBpLxgIrj
 A/M=
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="30438281"
X-IronPort-AV: E=Sophos;i="5.82,252,1613401200"; 
   d="scan'208";a="30438281"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 11:44:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in7FapKBuzO4JwaIOBLsQz4KzmgfsM5jT2pvrUwrcRDbVgXjnxd0XV/cgUlVOwLyVste52UC2IaXArcqUSXwjyxlMIB7QHPE8jscoQ5ibWqbs+GvR8TB6Ko2hS8uW32BaCTJ7WEJf18SiYkP3vJnitffq0NvydecwovkJ8raRS7bJVC/Ec2i3YpWEWPPxUu5zZa72Yo/EFTXcRmfZh1nR3QbpplnoZBuLfk4FyLVqqmjLLX2Z5kk62IqOjTrfWzx65QSpAFyYKUJsWeW2h8OSPMf38mQoRdgUDRXbdL7XkC3HOGmzZ5ICJxtCuhCJ5kritNOk7KvRK6VNRdfx4PYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0OIqqjv5K7zMT2rdwr+Ri7zoRHqzJU+Hwd0xJ360ZU=;
 b=oLnsILGT57DzG6FC3zERU0ap3U7r7Fhu7OiD9Z8Ly3JilDCRZf3biF1o9i+wLQELyxYrIZl4UtpndwbQaaWwrEZ5BJ2/vphc1k2vjThgQjGTpORBrTbry3VzIXsEmkUTYNnItbR7OdqHIjpel5FDifZgCA1rRK7DJw2iYR1UDIYN5g0EJ72lvc8d3XbLHx8EjZlEzXs/K+rcS59fH3j+TR6E8QWicWDq8qGGfiumHWP90FRoTCB9j64YHEPRGxXsSCJ0PRHwJP2orcm0Jumf9x2E3/IX6ynb4NVzZ6/fismC6dgNokAdb4dvF3fkgHkLW91/9kzk6VMBIHzpUpd6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0OIqqjv5K7zMT2rdwr+Ri7zoRHqzJU+Hwd0xJ360ZU=;
 b=FO45EUiK2JWfb1knZRQG7Ith5+fUU4Dc9oFPGTCPth8iZ/MYYS73XjDFQyn9Zr183cHfCPPMvGVRY9C0N25Q6S8ygRs7OGJ0vuQUXfKvqx4RcrUlHVwityTj4b8VsJOFdavSYZBQP1fcYTbEozQemZvaDmR6X4fGk8G/i547k54=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSAPR01MB3139.jpnprd01.prod.outlook.com (2603:1096:603:37::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 02:44:33 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::bde7:2ca6:9b9:8ce5]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::bde7:2ca6:9b9:8ce5%7]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 02:44:33 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Ira Weiny <ira.weiny@intel.com>
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
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: RE: [PATCH v3 1/3] fsdax: Factor helpers to simplify dax fault code
Thread-Topic: [PATCH v3 1/3] fsdax: Factor helpers to simplify dax fault code
Thread-Index: AQHXN33HjYLLHwr+rE+QAF3Yh+hjD6rHe4KAgAAnj/A=
Date:   Tue, 27 Apr 2021 02:44:33 +0000
Message-ID: <OSBPR01MB292025E6E88319A902C980FEF4419@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
 <20210422134501.1596266-2-ruansy.fnst@fujitsu.com>
 <20210426233823.GT1904484@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20210426233823.GT1904484@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed7f6c89-6845-451d-16c1-08d9092663a1
x-ms-traffictypediagnostic: OSAPR01MB3139:
x-microsoft-antispam-prvs: <OSAPR01MB3139F81F7BC5F831C35F2F7FF4419@OSAPR01MB3139.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgtBpefexZRleSKaLMoEPk1qogFJvwX0Lkg85YOw0Rt1BFmodIgykP6vX3TpwiWDaCWsBqvlr3Ha9hTL4pgJ61cKSfyWSxpAO29tw/2InT3/nPu0qhBLfM1qQP4sxk75pd07AsYEi+eJRZnNkSIyL5DElNMCzZumsjLzzsO2vRXIk6zcCRsF3hgiaMfRM6ms7m030zdKJuqmGWyWtXZ3Eewx7X/I6sRiHwcveoVYyyH8L9JzQ+RzRCzpgQElr7vIdUPY7mWx8lTu7DZtccCcN86FraLbRaYmNsU1NO0tnJeHQr3M0djJ3rCzjAqIVFPtqarpz86emcB/cq6Kpmb955NWm+YBTeg3nsb6uus66GWXyIese3FMmT3kl7tyDatEi87HeqRkM52HgGn8mPA6eFL2z8J5XPv2IdvqRTUKQjmN8Xy7V8jZWEUnxOpmTBisxHi8u28Qvdah1GgPIE3SPuADlrTSpFsib+caUxmeMtxhZC34B9UA//dgXzuh/0/gZwG12kAAccF2Lwb8bQa6R0RxzJM/g9Dmc8hPUwkETh1seOGPONWQ+1+zlPUq2i/sAqiTFwZB5sY+jou2wFkYU//a4xEnnBaHbY70lE9tjSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(9686003)(71200400001)(33656002)(8676002)(64756008)(66556008)(66476007)(83380400001)(66946007)(66446008)(76116006)(26005)(55016002)(186003)(6916009)(8936002)(316002)(478600001)(4326008)(54906003)(7696005)(6506007)(53546011)(122000001)(85182001)(86362001)(38100700002)(2906002)(7416002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?bnlSUWliMUhzaS84Mzd1OU4xUThaN0pjTWNnYnYvU1FGTzRlSmt1WVRJeXI3?=
 =?gb2312?B?Q09OVG9TdnlNbmR2V0tuVEE5YlhPbGtpNmRjU1Q4Z1M1N0pBWUtPcVlyZ0dO?=
 =?gb2312?B?elBRejQzRERLT09OcmdyZGY0RmRwY3RKZWlnMFFRS0hCUnBwb1JYL1ZhQTBj?=
 =?gb2312?B?TmtuN1BjYUFvK3lKZUlPeGo4M2xaUko3d3JZb0g5V1ZBRUlaRE1nOWtzUWNK?=
 =?gb2312?B?NVJoREJMRDM4Wm0zK1RRYlZpeUhhOXBSR1VzWmMzODlWZnQwVHlzUldNNGls?=
 =?gb2312?B?WXVucmxPcEZwamlOUjZCL3duNEpIT3pWRWxVR3RSVFlvMW9YakdJK0Y0Mk9H?=
 =?gb2312?B?ZVc1TERmS01HWkViczlsWkpjU1BxYjFVeTBmWDMwQWJlTGNXTHFPaDhKemtn?=
 =?gb2312?B?S0x5R245SERIb0Fpa2wveVVmb0ZiOTNaalorbFNzQ2xiWnZBMHFvOGYwQnFT?=
 =?gb2312?B?aEYyNlY3eG85cXBDd1U1VUtjZmd4QU1rR1Jpb2hYOWVqcHNDWlZnKzRXVU5m?=
 =?gb2312?B?b1NteUw0SVhWcGhaSEdCZnVBMmt2S2NGeHRhbUErS1RDOTFVZnI4c3JBZ3lm?=
 =?gb2312?B?VlFQeHRrK0RwVVFnR2ZpWXE4bWthcFlKWEtCZFpDa0UvRkxpTVhlV2VKZktX?=
 =?gb2312?B?ZzFSODI1cjk2WUZLU1BTdFQ1QkxoSVNyY1RjNFJWTWMyRDM0SUJaWVBlMUhp?=
 =?gb2312?B?S0dDK1YrUEJsZHYvUUFlZkg0N01ZL0dCZFdpRVh4OGxSMlMyVk5PUjlNWDRV?=
 =?gb2312?B?ckdyK1lrUnlPcU8zdG1scG9OM0N2RTVROC85TUg5Z3c2cVRaajB3ZndPRzhq?=
 =?gb2312?B?Zzl4YjFPUi9ZZ2x1dmV0bmRtUVFOeW40TEZWeHJ3T0x0b2ZJZjk2QVNmZC9M?=
 =?gb2312?B?a2c0MHJwV2tuMFFXYTlrNGtLTXNwS3FoWHpJYnUwbE5tY0xIOTYrK0pDcWlC?=
 =?gb2312?B?Z0JRbXdkNVZaUjVjT0JDSkZseHd4NDdUT2pNUllkcitIS2EzUHBJT294SklU?=
 =?gb2312?B?NGRwTC9pOTZyRUh6eW9YaStvL2ZEbE8rTGRNcWdDamxMa3A1QjdVN3ZsNlhC?=
 =?gb2312?B?bHpUVWw4OVh3L1VUQ3hxVjZTL2phajRUbWxCZC9lZkR4YVpVbjREcnZUbFhq?=
 =?gb2312?B?ajlESG01cDFmajV5T05SOWhuOHlIZVJvUEJCczVhZkJZdmUzYThGMEhPdlZK?=
 =?gb2312?B?M1BpTkdCRXRPOGlzaXlmbEhOeGFQQlFIWDlxelJ3R3djV0Jhb3hjeW41VVlp?=
 =?gb2312?B?eWRnL1gxZ2toQTdwMG5iRDAvS0xtREl5RnZ6UXEyYVRkSDhpNHNPMGdjeE9Y?=
 =?gb2312?B?ZHU4eGgvYnlFbzZpVnZMcmJ4RFNRbnVRYVNWSGdQbGtwQmVyQ1NkZitRaDJ2?=
 =?gb2312?B?c1ZaTjV2Z2hiOGNrRlNKMXppRHhMSlprbjdqb2VHdHZ3ejMxcVJXcys5ZW9G?=
 =?gb2312?B?Zzk0N3ZZMGJkY01nRFBnMFA0cmk1elRCcldiRkdNTjJXeHh5VHI3eGxuSk51?=
 =?gb2312?B?WS84SWRXc2IwRDdmZzRMSlpVV2xpVjhOUWNVZVI0a0YrZ1A4aE1SUG1kNmlx?=
 =?gb2312?B?bWJPVmZnSERYbnB1dHpFRDJVWUgrcGsyUDdqRzFjcjNzTlBwRU9WSUJ0cEVE?=
 =?gb2312?B?bFNwQXRLcFVDcmlxK081YTFjTlp2bkVmSjdHdGphVHVObEN3Z3p6Q2l0QmdB?=
 =?gb2312?B?dmVEYWMwd0ZaanRkV29HOTFLamhPa29TWlFDaE5td0dzaWF5aDgzWVVXQjdV?=
 =?gb2312?Q?9rP592+hKGg7+QLTww=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7f6c89-6845-451d-16c1-08d9092663a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 02:44:33.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L//CgqHJ1WMUJ/srxouQjnq/j3gEagqULhgGjJcdNIsEWlpTTgTyS3/5zsMa2DIeR368IQX9iBMgpxD1o9PTVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3139
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJcmEgV2VpbnkgPGlyYS53ZWlu
eUBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDI3LCAyMDIxIDc6MzggQU0NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzNdIGZzZGF4OiBGYWN0b3IgaGVscGVycyB0byBzaW1w
bGlmeSBkYXggZmF1bHQgY29kZQ0KPiANCj4gT24gVGh1LCBBcHIgMjIsIDIwMjEgYXQgMDk6NDQ6
NTlQTSArMDgwMCwgU2hpeWFuZyBSdWFuIHdyb3RlOg0KPiA+IFRoZSBkYXggcGFnZSBmYXVsdCBj
b2RlIGlzIHRvbyBsb25nIGFuZCBhIGJpdCBkaWZmaWN1bHQgdG8gcmVhZC4gQW5kDQo+ID4gaXQg
aXMgaGFyZCB0byB1bmRlcnN0YW5kIHdoZW4gd2UgdHJ5aW5nIHRvIGFkZCBuZXcgZmVhdHVyZXMu
IFNvbWUgb2YNCj4gPiB0aGUgUFRFL1BNRCBjb2RlcyBoYXZlIHNpbWlsYXIgbG9naWMuIFNvLCBm
YWN0b3IgdGhlbSBhcyBoZWxwZXINCj4gPiBmdW5jdGlvbnMgdG8gc2ltcGxpZnkgdGhlIGNvZGUu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0
c3UuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4N
Cj4gPiBSZXZpZXdlZC1ieTogUml0ZXNoIEhhcmphbmkgPHJpdGVzaGhAbGludXguaWJtLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZnMvZGF4LmMgfCAxNTMNCj4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4
NCBpbnNlcnRpb25zKCspLCA2OSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9m
cy9kYXguYyBiL2ZzL2RheC5jDQo+ID4gaW5kZXggYjNkMjdmZGM2Nzc1Li5mODQzZmI4ZmJiZjEg
MTAwNjQ0DQo+ID4gLS0tIGEvZnMvZGF4LmMNCj4gPiArKysgYi9mcy9kYXguYw0KPiANCj4gW3Nu
aXBdDQo+IA0KPiA+IEBAIC0xMzU1LDE5ICsxMzc5LDggQEAgc3RhdGljIHZtX2ZhdWx0X3QgZGF4
X2lvbWFwX3B0ZV9mYXVsdChzdHJ1Y3QNCj4gdm1fZmF1bHQgKnZtZiwgcGZuX3QgKnBmbnAsDQo+
ID4gIAkJZW50cnkgPSBkYXhfaW5zZXJ0X2VudHJ5KCZ4YXMsIG1hcHBpbmcsIHZtZiwgZW50cnks
IHBmbiwNCj4gPiAgCQkJCQkJIDAsIHdyaXRlICYmICFzeW5jKTsNCj4gPg0KPiA+IC0JCS8qDQo+
ID4gLQkJICogSWYgd2UgYXJlIGRvaW5nIHN5bmNocm9ub3VzIHBhZ2UgZmF1bHQgYW5kIGlub2Rl
IG5lZWRzIGZzeW5jLA0KPiA+IC0JCSAqIHdlIGNhbiBpbnNlcnQgUFRFIGludG8gcGFnZSB0YWJs
ZXMgb25seSBhZnRlciB0aGF0IGhhcHBlbnMuDQo+ID4gLQkJICogU2tpcCBpbnNlcnRpb24gZm9y
IG5vdyBhbmQgcmV0dXJuIHRoZSBwZm4gc28gdGhhdCBjYWxsZXIgY2FuDQo+ID4gLQkJICogaW5z
ZXJ0IGl0IGFmdGVyIGZzeW5jIGlzIGRvbmUuDQo+ID4gLQkJICovDQo+ID4gIAkJaWYgKHN5bmMp
IHsNCj4gPiAtCQkJaWYgKFdBUk5fT05fT05DRSghcGZucCkpIHsNCj4gPiAtCQkJCWVycm9yID0g
LUVJTzsNCj4gPiAtCQkJCWdvdG8gZXJyb3JfZmluaXNoX2lvbWFwOw0KPiA+IC0JCQl9DQo+ID4g
LQkJCSpwZm5wID0gcGZuOw0KPiA+IC0JCQlyZXQgPSBWTV9GQVVMVF9ORUVERFNZTkMgfCBtYWpv
cjsNCj4gPiArCQkJcmV0ID0gZGF4X2ZhdWx0X3N5bmNocm9ub3VzX3BmbnAocGZucCwgcGZuKTsN
Cj4gDQo+IEkgY29tbWVudGVkIG9uIHRoZSBwcmV2aW91cyB2ZXJzaW9uLi4uICBTbyBJJ2xsIGFz
ayBoZXJlIHRvby4NCj4gDQo+IFdoeSBpcyBpdCBvayB0byBkcm9wICdtYWpvcicgaGVyZT8NCg0K
VGhpcyBkYXhfaW9tYXBfcHRlX2ZhdWx0ICgpIGZpbmFsbHkgcmV0dXJucyAncmV0IHwgbWFqb3In
LCBzbyBJIHRoaW5rIHRoZSBtYWpvciBoZXJlIGlzIG5vdCBkcm9wcGVkLiAgVGhlIG9yaWdpbiBj
b2RlIHNlZW1zIE9SIHRoZSByZXR1cm4gdmFsdWUgYW5kIG1ham9yIHR3aWNlLg0KDQoNCi0tDQpU
aGFua3MsDQpSdWFuIFNoaXlhbmcuDQoNCj4gDQo+IElyYQ0KDQo=
