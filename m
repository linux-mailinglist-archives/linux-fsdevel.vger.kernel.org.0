Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54353B6BCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 02:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhF2Apn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 20:45:43 -0400
Received: from mail-bn8nam12on2096.outbound.protection.outlook.com ([40.107.237.96]:5089
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229678AbhF2Apm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 20:45:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyQRDMpsrHGfIDAl88fQkgEmWE2RvhkQTr+2m1RpCjbez7K54DcEmdf/Fv3SWqajLQrjI04MsZZCujKm4sJlha8EoHnr+Dpqs9FXGv3xQaktpIyOmyNTjbIIC9DORMvwqjgVBEetUyknQegNU52Eh9mjGIJX4habKpZXg3eIHL6hfGYi0Ty3wHQkSTY/jSHSqH114aDx8xkuW6Y7gCyURd2I0a5hE6kbM1uXM7kqM2KJRxbZN8qsxaoqKpkPPY26H6VHDiQXfN6VClA0AE5aHkDLzDSEs1srq6LEiSKg8ZcjYtqwi2Tf0KlOa93QRBgG24bUhST6NgsEKU/8qUX/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+MB0Jrvc87KJ9WDumWJ1sl4a2lTTu3461oCdBmMPg8=;
 b=S5SYdlnzmXW4Wo1BwQlhUYRe5hK6nkjri4prj2ZJBFOy2h17ulwQbk+dSB4mumg94xjZhT4BSKyQJdENpzuSkOTIntrnfn+PXEMnJyDIwZv0eXf7cOBvW0hJVIWaMV2n4DIReLPgxDgeveZO2NncIZMOq9T6uD5h02ZRkSd5J/x9qlCxYb/kBjhzpra5YZ8iCctXLyFPum2BKLvQJatTDrUUDw1NQffs6TkSin4EziCRcEzOaHE6pty8o0ZPJ5BDBLnFoYDBP5GWBHw6HYsWCGaWL5oBrIHdCke9E0km9gRIGsg64J+DGy4xziQ7OUiDzNMge6zNEWozIjvpIrx9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+MB0Jrvc87KJ9WDumWJ1sl4a2lTTu3461oCdBmMPg8=;
 b=Vm9yO0eDKN0uVALpPmo06zmx6a3riNcAm86egpOeXl2xBuCWBeDlGT0p3LPpr+dlALI4koWyPaWSKFzzGKzOuSHv9cJCNWCi7iB03vcIPWivEDaeHR0SuUhYZeXHEJDOrEAxRiSwb9+q7LoeaIzFnqpUhjtpt1XFi6lDumziI2Y=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 DM6PR13MB3292.namprd13.prod.outlook.com (2603:10b6:5:19c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.13; Tue, 29 Jun 2021 00:43:14 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::1cbe:81ae:4a8f:1068]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::1cbe:81ae:4a8f:1068%6]) with mapi id 15.20.4287.016; Tue, 29 Jun 2021
 00:43:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: automatic freeing of space on ENOSPC
Thread-Topic: automatic freeing of space on ENOSPC
Thread-Index: AQHXbFar2GebLqkz70+qFHFJud37ZasqJsmA
Date:   Tue, 29 Jun 2021 00:43:14 +0000
Message-ID: <9f1263b46d5c38b9590db1e2a04133a83772bc50.camel@hammerspace.com>
References: <20210628194908.GB6776@fieldses.org>
In-Reply-To: <20210628194908.GB6776@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72cc5742-4c2e-43c1-bf72-08d93a96e0f6
x-ms-traffictypediagnostic: DM6PR13MB3292:
x-microsoft-antispam-prvs: <DM6PR13MB3292CD03F0140C8821223CF0B8029@DM6PR13MB3292.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nDs1TTja+H2cH1WrWwuuO8h838JfIxmc5BIY6e2+A70hl/SHh1mBn26r7ALme4dHiwnaXPIVqFHxNhbnhvY8MDkXUlPB/l6dEbx91MuQNchMhqnYTHWGrklJrtpDqme/e12yy4/7yOWh3wM6oKDO4sZ+OEvzF3DSCczueieWM50QAQrxa4PMpTnaznK22xzp9gaVm6UZt5TSx7cPrHz3iUAXDySwueZ0iDBNI2NlAWJEepVHxqC0aSp4jVYmkR64FYtKqK2ht7eK3FufDLPPyWpOUpP13u/XsrjdlNwq3NhSIw2SLIcLEYqq4Q2remhmsDQJgN3P+zBT/wijPy5dVqf5GUp6Uqoef/1iJuK+ogFznhbnRxoXW6Q1JwgNwZH7P1WK7TX792zptMTG/QsxFPtPSzhMN07vKv/7cDTq0cFlAa5Yt4HmV9KRthtAmZA5jGvrbxc+fA0TRYPnZ/KVYgUX6m8sPpSyPi9cV3zLoQhAX9qU7LD29t91++BWO6sz65sDaIwJjJbHD7tYL2c4v4lSQhgQbpPhIAGYvjY366OYjApJOPqDtQy/g2SfB+eQYuF8cOxcfVvf5lEQoFZ6mmy/rM6B1qG/bjVwm2+PLYDoo1u7obLi2Pdd4T2zNgYvy/3kFZ/Juh+Db8ISVfLp7UrQjGXc5yFsOX68+qjYIPPTqe9JTb99h3UkjNZNa75dtDFsU6GNpzmaRwIPqNfo71KNAzyD2TviHbfm3qWraQCc8BPvtRnCJy62g7/7NIqa21IeV4+ee8iiOQR5+s+GAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39840400004)(136003)(346002)(396003)(66446008)(64756008)(71200400001)(66946007)(66556008)(110136005)(66476007)(36756003)(6486002)(122000001)(966005)(76116006)(26005)(186003)(6512007)(6506007)(91956017)(83380400001)(8936002)(8676002)(86362001)(38100700002)(2616005)(5660300002)(2906002)(4326008)(478600001)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW51eVhjZUlhd3BKN3d3ZUtTcHdPUm9maEpVdC8rWVFlajhGTmZxQ3c3eDlB?=
 =?utf-8?B?MUI2dU9WSWpqYy9JQ3VmZzNHRGhFc3hVV0JtZWFPVzV5STBOTkgzN1pTQ3RY?=
 =?utf-8?B?QlRseVlaYWtjZkg2S3J5UUxLQjU1c0JSZGpRVnV5d1pkY2dUeXNtTGRCQ0l4?=
 =?utf-8?B?bTZhNzFoS0J1Nmt6UnFwVHJ1VG91TUVJSm5jMzVuOXl0SmtHL3RIWTdCNzhr?=
 =?utf-8?B?dVlnTzJiaXNHeDcxYzZscWNjcTR4VnYrSWVaWEJ6VUUwREVwZmhxMk1SRlFH?=
 =?utf-8?B?Z25VZXlyc0lZYWtJVFdMYXhvYkZzRktnd29UTExQZGJWV3JvbkVBOHhjQmlR?=
 =?utf-8?B?b0wwTnl5OEdFOFpac2VlK2hyQzJ0eEpkMmlQR2xZVHI4SkdPQldiNnZ5Sk9k?=
 =?utf-8?B?MVZqVVZXZUJTOHByaDVMVDRtYVk3S3VmTlg3YjFNNzUvWnVSU0JiMHBhOEcv?=
 =?utf-8?B?QnRPZHovYWFvOWYrV0pXTFhiV1lMRDhmUTg0MUorbTJ0THV4VFYxVzhkUEFO?=
 =?utf-8?B?akpZeFBhVC9CSnphZ0JXbDF6c3g4cWRpNW8ra002Z1llNzNhd3BxSDUyM3c3?=
 =?utf-8?B?VUZxQWlRU2xWQjg2UjdjNWlTME5RZXFMSy9CY29TTGdISjNhS0VSbWpRZTE1?=
 =?utf-8?B?cGlrUWNqdWtFMThodm5mTWN6by96aVhPbG5zZStkaDNxOURkWi9KVDRKcnZF?=
 =?utf-8?B?YUJRV0d4RFBUamZXYU1oM3Y1cFRTR3hlU2U2VERwdW9jUkhaVXR2YUkwYlQ0?=
 =?utf-8?B?THdwM1Q5UWZHSWlocUl3SWxTZjVhZWhFbGdEUHV4UEg1aXFWM3FuS1dMaTZR?=
 =?utf-8?B?RmtyRUIyQk9odFFXQ2Vtck1rL3M0YlBoc2JtTytpclZ0eGVqK0VaN2dGNUxR?=
 =?utf-8?B?N1c3QUx5K2VHTXJNOFhLUXRXYjJSNVpKNm1JNmRrSGlzM1dzWUI2em50Qllu?=
 =?utf-8?B?MVRsd0U3UlJseTQ4TEluanBxZWZqTStDRlowZXpjZUMxMDJCYWpnOGw1YXFG?=
 =?utf-8?B?a2ZpbndBNFRnT1JMNUsvVm1PeUwwSEovbEFlZ1VnNmEvWVlRTCtDZFRVV0FW?=
 =?utf-8?B?WnhPNzd2c0FaajRobGFpRXBnKzhTQW1wYVlPOFFpa29NTU9sdThvWlo0Z2R5?=
 =?utf-8?B?aU9jY3NURDltYVhQRUw2Y3B6eTlYWkRQNkNhamdpYmhuaUpNZ3dYVUk2aHpY?=
 =?utf-8?B?S1hxNGoxc044bjBGTHA5YkFXK0NxTnNYQzhlSDV6TFVkRkg5Y2NSck5OclJv?=
 =?utf-8?B?NFl2N292ZVkyUUgvcjdpUE91YUdEUlpkUW1VNUt6MzhOYUpkd2pmNnJMdlZn?=
 =?utf-8?B?VE5jdDNaSmhKbXA1S2dLakhuYjZDekUyaGlPKzJheTBqTTg2VHJTTXJuQjBr?=
 =?utf-8?B?NGdLeWVJQ3NvcnZWa2UxY2M5cW9vMGxLcVdvdmJlaU1nNTgxYjg1Wnl1QTY0?=
 =?utf-8?B?SmVEWjEvcEJzMDlHL2RnUEFCVzhCL1BXL2FIZk9rMnA5NHhkRjNZcWQzRCtD?=
 =?utf-8?B?REV1aHlrSDV6dHVrdFB0eE0rc3pVSi9NS2V4K0s0MVdRcmhFS1ZGU0J6UUVq?=
 =?utf-8?B?Z005cWRUeVN1NmRBYUYxeDhwckxaamp5V1lQdmh4dXd1VUlyT2ZHS2w3cTIz?=
 =?utf-8?B?UDZmZHppaU5NQi9KWDVvMHAxMDhIaXA4bFZ6RkRBbStpeVg3UnptOHJ4MnYw?=
 =?utf-8?B?U2djNjFKQnlEVWZCQzJZaXo0QTNqWnBWNk9uSkEzWnp2VjJBUE9NRlZDbWdo?=
 =?utf-8?Q?6B7TtZ9VxEMt3K3khwgfO64f6sPkN6Z/7AyFVlH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6D51BAF29BF4F44AE39CB92A6F17B7C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cc5742-4c2e-43c1-bf72-08d93a96e0f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 00:43:14.2572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuO/gilazboYsBYKi086Xqw2FrXJ85U0HdxK926Q1VbUR3cMr1vyAzRrMsr3Qs4s2iPQBKbcc2DgFHsxqApdiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3292
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTI4IGF0IDE1OjQ5IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IElzIHRoZXJlIGFueXRoaW5nIGFuYWxvZ291cyB0byBhICJzaHJpbmtlciIsIGJ1dCBmb3Ig
ZGlzayBzcGFjZT/CoCBTbywNCj4gc29tZSBob29rIHRoYXQgYSBmaWxlc3lzdGVtIGNvdWxkIGNh
bGwgdG8gc2F5ICJJJ20gcnVubmluZyBvdXQgb2YNCj4gc3BhY2UsDQo+IGNvdWxkIHlvdSBwbGVh
c2UgZnJlZSBzb21ldGhpbmc/IiwgYmVmb3JlIGdpdmluZyB1cCBhbmQgcmV0dXJuaW5nDQo+IEVO
T1NQQz8NCj4gDQo+IFRoZSBORlMgc2VydmVyIGN1cnJlbnRseSByZXZva2VzIGEgY2xpZW50J3Mg
c3RhdGUgaWYgdGhlIGNsaWVudCBmYWlscw0KPiB0bw0KPiBjb250YWN0IGl0IHdpdGhpbiBhIGxl
YXNlIHBlcmlvZCAoOTAgc2Vjb25kcyBieSBkZWZhdWx0KS7CoCBUaGF0J3MNCj4gaGFyc2hlciB0
aGFuIG5lY2Vzc2FyeS0taWYgYSBuZXR3b3JrIHBhcnRpdGlvbiBsYXN0cyBsb25nZXIgdGhhbiBh
DQo+IGxlYXNlDQo+IHBlcmlvZCwgYnV0IGlmIG5vYm9keSBlbHNlIG5lZWRzIHRoYXQgY2xpZW50
J3MgcmVzb3VyY2VzLCBpdCdkIGJlDQo+IG5pY2UNCj4gdG8gYmUgYWJsZSB0byBoYW5nIG9uIHRv
IHRoZW0gc28gdGhhdCB0aGUgY2xpZW50IGNvdWxkIHJlc3VtZSBub3JtYWwNCj4gb3BlcmF0aW9u
IGFmdGVyIHRoZSBuZXR3b3JrIGNvbWVzIGJhY2suwqAgU28gd2UnZCBkZWxheSByZXZva2luZyB0
aGUNCj4gY2xpZW50J3Mgc3RhdGUgdW50aWwgdGhlcmUncyBhbiBhY3R1YWwgY29uZmxpY3QuwqAg
QnV0IHRoYXQgbWVhbnMgd2UNCj4gbmVlZA0KPiBhIHdheSB0byBjbGVhbiB1cCB0aGUgY2xpZW50
IGFzIHNvb24gYXMgdGhlcmUgaXMgYSBjb25mbGljdCwgdG8gYXZvaWQNCj4gdW5uZWNlc3Nhcmls
eSBmYWlsaW5nIG9wZXJhdGlvbnMgdGhhdCBjb25mbGljdCB3aXRoIHJlc291cmNlcyBoZWxkIGJ5
DQo+IGFuDQo+IGV4cGlyZWQgY2xpZW50Lg0KPiANCj4gQXQgZmlyc3QgSSB0aG91Z2h0IHdlIG9u
bHkgbmVlZGVkIHRvIHdvcnJ5IGFib3V0IGZpbGUgbG9ja3MsIGJ1dCB0aGVuDQo+IEkNCj4gcmVh
bGl6ZWQgY2xpZW50cyBjYW4gYWxzbyBob2xkIHJlZmVyZW5jZXMgdG8gZmlsZXMsIHdoaWNoIG1p
Z2h0IGJlDQo+IHVubGlua2VkLsKgIEkgZG9uJ3Qgd2FudCBhIGxvbmctZXhwaXJlZCBjbGllbnQg
dG8gcmVzdWx0IGluIEVOT1NQQyB0bw0KPiBvdGhlciBmaWxlc3lzdGVtIHVzZXJzLg0KPiANCj4g
QW55IGlkZWFzPw0KPiANCg0KSG93IGFib3V0IGp1c3Qgc2V0dGluZyB1cCBhIG5vdGlmaWNhdGlv
biBmb3IgdW5saW5rIG9uIHRob3NlIGZpbGVzLCB0aGUNCnNhbWUgd2F5IHdlIHNldCB1cCBub3Rp
ZmljYXRpb25zIGZvciBjbG9zZSB3aXRoIHRoZSBORlN2MyBmaWxlY2FjaGUgaW4NCm5mc2Q/DQoN
Cj4gSSBzZWFyY2hlZCBhcm91bmQgYW5kIGZvdW5kIHRoaXMgZGlzY3Vzc2lvbiBvZiB2b2xhdGls
ZSByYW5nZXMNCj4gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzUyMjEzNS8sIHdoaWNoIHNlZW1z
IGNsb3NlLCBidXQgSSBkb24ndCBrbm93DQo+IGlmDQo+IGFueXRoaW5nIGNhbWUgb2YgdGhhdCBp
biB0aGUgZW5kLg0KPiANCj4gLS1iLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
