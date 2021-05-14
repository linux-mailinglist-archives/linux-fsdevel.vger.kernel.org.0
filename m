Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA180380341
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 07:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhENFXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 01:23:09 -0400
Received: from mail-eopbgr1400088.outbound.protection.outlook.com ([40.107.140.88]:37312
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232461AbhENFXI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 01:23:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUSxQEGRXkBWwabRxTLB3cQjuY3DyIbK4b1Gl2k21sw4WeLF9A8dSwbxv5IIfay+UGW/hlMmB7J2gnAYtj9nfy8MoQpy9yvv6U0p891O+nFbX4O66pMQua+XoB3aZG7FatD1XkPT2blBPOv6K3zkZ8kggA9ghKdYZdCBBnnsUlL269LNOWG2zurAvRHw9gxb523MlNzqn6iPR+1AW7eWRUNIe16x9AaTd5hSJ96C++JDBL7XKUN4rV+FF3GPyqnc7Rcm3VClikcOTOdGOXfrEIR64yshMSnrhsAbWY0x8mqOd7K3qsv0yQc3sF6hB4KewF+YIDaNA+JPfmpY4Fwfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLe8HhPPdENVJJLdpdh9Yy6H/eJK+djeW6o1LNtjpcg=;
 b=RucamXQezy1ijMbZ5G/q1iq3oMzwmWYYV/g1rGeJpFlE3gRPZuemXxHGuSp0KKZ6sZmuW12e46PD/d40hYSPtvewpzUmXnyP7Blv76lYGXIceHrOfrcL+VR9ydJ2xi7j2iLi329VdusVwbdEueUWtiPfogEmeFkrwoJdYUnha527Yy7AWbQSzXQx9yCnfxuTzA1GpIpCB5Lw0I3s2J/nRiz5pFhy+hn9GZRkBMYRbO2+B9S+rDc8ZcbTtH8Ae9VJjmlYTKrOUzeaav/Q90F1AMGdLIzqhGT+dgbs04ORq4jncxbjzAMTEzMjwB9BR2K6NOTHw5wWz1xllCIv259rqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLe8HhPPdENVJJLdpdh9Yy6H/eJK+djeW6o1LNtjpcg=;
 b=gaKydqGg6jTcH/0m+NhwCV+XaZRl18JOnNpGVF0JhPyPg4yNGJ/XDk/yygvUIgkX7Yn+iStWt2ZFnZppYsF38S8Z8YLzxL1yv5QWbnBtPEF9Q/TxhF5gppLR1ypyLRyajD/UyQjiLIZ+Z24d+iQ3cwinKccYZ2VhHTRECb4tbsk=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB7089.jpnprd01.prod.outlook.com (2603:1096:400:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 05:21:56 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4108.031; Fri, 14 May 2021
 05:21:55 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     yangerkun <yangerkun@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yebin10@huawei.com" <yebin10@huawei.com>
Subject: Re: [PATCH] mm/memory-failure: make sure wait for page writeback in
 memory_failure
Thread-Topic: [PATCH] mm/memory-failure: make sure wait for page writeback in
 memory_failure
Thread-Index: AQHXRjK1j3a2Ru6gikyV8HnazUFHgqridbQA
Date:   Fri, 14 May 2021 05:21:55 +0000
Message-ID: <20210514052154.GB983377@hori.linux.bs1.fc.nec.co.jp>
References: <20210511070329.2002597-1-yangerkun@huawei.com>
In-Reply-To: <20210511070329.2002597-1-yangerkun@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f624780c-6c27-4554-1642-08d916983078
x-ms-traffictypediagnostic: TYCPR01MB7089:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB7089C50CBA9AAA6A12BCA156E7509@TYCPR01MB7089.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JecJ1wGuwgzp4KwB79QoaZzdbUH/JugBLhE89JCIXttyNqxmz1MoFq//g5y/f/v2W6Z3q6A4ThrJVzSDbUB8IDFds/+0tCdCFNOMC/ZiZVYecKjX6XPphRtq5VL0m9e6+fRWvuYsTr3E3gddnsFJ6MhTo4qe4mphPsXT/yvAr6RkHeklX6FzDfDvLl7dqEZ8jkRUNds4/KpXyNl5S2aR23DkctRQBzIbKx7V5ZRtFZZ4TENjHyVh2HWMaGStY/38m7zjnr+zWiW5HZwnfX1n/4AJxGXMC6vWe8fGwucNSDNJb4veWCkoyht3PFJ1vvZfNtU4APO0QSFbvYiMNe8WgxBilWge14F/6qVRWG5JgCJP/VBZA/ytBHzWBTnk9KPxh9YNfCBZsoBm34v7MV0mWagsTsqF96vku2h9iy/n7FVVIkVNaFNOAlkOXfJavMMv6PGbqsFj21pjLwaYOmwWw+moimMyg8Tb5iTIqOjrqM6ANSSKrDN2dTyb/jYbUufEOhtJh2K1erhqSLkZHwQrj8Ne2rNIFujV3ZB2EnsgXQTV5bBGUkBIdiaY37fxUqiD51c70bu4xMOTPbvMYOZr1SSS02nUZJl3BLLHGXnmVgI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(1076003)(316002)(54906003)(5660300002)(66946007)(45080400002)(76116006)(8676002)(38100700002)(83380400001)(6916009)(85182001)(4326008)(66476007)(71200400001)(26005)(55236004)(64756008)(86362001)(66556008)(7416002)(6506007)(33656002)(6512007)(6486002)(66446008)(186003)(9686003)(2906002)(478600001)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WUFtdjlNK3pObnNnZXp5RzFxT0UwdVkxaW5SKzNNWDBJK0UvMlZYRkkyWVdO?=
 =?utf-8?B?S0FQaDE1aTYxR1pqV3c0WHpoRGI5N0ZFQXNOTnJLVzRQNC9pc2FXbW1ORHI3?=
 =?utf-8?B?UG9EVXVFQWM5aFlIT1QwbkZwQzBBNUszMUgyODY5UXVQWE1BRWVkNitxTzV6?=
 =?utf-8?B?MUo5MXkrc2JYZFFnczZ0U2dPY3NlOTVZRXFHQmJiT2dsdStIaWlwZnJ6SUlr?=
 =?utf-8?B?am5GVlYzNUJPVEp6VHlRd1ZXOVNtMVlPeWVNQ3gwTjhzam40ZFNWK24yVHZp?=
 =?utf-8?B?aGM4OEdkdEMzYmtOS0JaVmEyTnFqUHVkMkRVb3NSdmlvcU9EczZ6ejB4VG9U?=
 =?utf-8?B?REwvYXBtdW14cVN6VndlenZ5NU4rMFpVaVJsbkRKc2dNaFp2cWQ1VFdiTUJY?=
 =?utf-8?B?UG15SmNLV1IwRDJ3eG8zcGEvVTE4azdmYXFLbFdxd3JuN1M5V29UQjBFOVUv?=
 =?utf-8?B?eVZ0Uk1iVU5EM3BCUHIvQkh2dE9TT2FndDBodGdiM0l5NkxXcSt0dkJzRDht?=
 =?utf-8?B?bEtZMWlzQ1IvaHpuT0NKN2l2RC84UjU1RHZyQmFhVXNDaUtmOGoxeHpmTnVP?=
 =?utf-8?B?VC9kSUhNbmN5S1pmYTVxQWpkdzFFUHpOSUlJZGVRc3BPVkNuODd0WmVoc1U0?=
 =?utf-8?B?RjBPeTlnS3cvU0xIcjFtSU53ZGl3cmx4VDZKc1Q3Vno3ZnNuaGxvdkFvUGJQ?=
 =?utf-8?B?aEg4OExNdzlkMWZpYUVzK2hRMDJ4aFdYdmttbVRUUi9tTkgyZTNDNk5Id0cw?=
 =?utf-8?B?L2sxeStpcG5QTHVxSXd5dHV3RTl4dnJHeHpDVzVDb09wYXlOZHBwbENMZnpG?=
 =?utf-8?B?WVhlL2hyUlphRnJBaUpBUVB1N1pmUmo1Q3d1d0VTRDMxMzA3NnQ3MHhaRStN?=
 =?utf-8?B?OTRrYU52VlBTdFR4b2JBVEhyM3FHNG5waEZ5TEt0M1JxYi9zdlRuSnc4TlM1?=
 =?utf-8?B?S0FrcHova0VXMDROL3N3OWNuZ1ZOMzJicklGc3A3WWJKR2lHMnlnNS91Qmh1?=
 =?utf-8?B?S3VoOUx0Um53SjA2cUY5S2l1NVgvL3hQd0p0eGdvVVM2STl6SlNWY3ZvVkQy?=
 =?utf-8?B?YVRlU1BWT2JlN2d3L1hDMFM0aVZrNmZCc2dmVFovbHhXSmJtM1ZTNk5NSVZi?=
 =?utf-8?B?a0Z2eVdqVFh2alBlaXFjSmtMWTkyeW5XalpqV2YzVW9GcjhxWWo4cWlJemhz?=
 =?utf-8?B?MWdkckhYa21lb1VNYjJkS2I4V3FYQ1ltUjk2SUhsOEtZSDdSOW5wMlcycWFr?=
 =?utf-8?B?WjBqY3FQUnhCRnJYNWFTZTYzV0daYVEvT1oySkN6MXZ6WE4rTVN1a2NuRFVP?=
 =?utf-8?B?Q215QU5MYUY5RmM0eitDeXowck9LeU5DSDl3alp0YTQ2eHdoaU1vSW0xUDFQ?=
 =?utf-8?B?WXphSGt3cnltb3JXV2l6OWpHdmFuVmtjK0JFMGV4cFpUb0FBTWdBOStaSnVR?=
 =?utf-8?B?dFlzVVViVENqbTlwcndtQlZoS3dFNUtTbVNhQWJvaXZXWXhvSDJrOE1vVm1C?=
 =?utf-8?B?M1VRNTZRcWRuQVVvelB5YlYyKzB4eHlWZFBERjFmc2R3c1dxVGY2Qm01MW1w?=
 =?utf-8?B?SEUxeG9DZ2ZzQmdJODRFMTZIVDJFNk4vVUo5L2VvN0hTMU9qT3k5dGhOSTU2?=
 =?utf-8?B?WGk3WVRLem5OWVlVM0xHZFlkRjMrNHprU1ZZWG1SYVRZblBmS1VSMnc4VlIz?=
 =?utf-8?B?ZmJLdnFVVk9QK1J6MnRpUGgxNTBjd1NEWjRyWkU2ZGRiTEVMMUs5UjcydURm?=
 =?utf-8?B?dW91bWROZ1RtYkRxaWJGN1k2b21va2JGc0VCMUFzTzFJa3NXbnpnU0RGR3E3?=
 =?utf-8?B?d2gyazFMZ3U4YUxTaFIzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59EB3DC26176FA4AB52325786968236F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f624780c-6c27-4554-1642-08d916983078
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 05:21:55.2652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cptD9NGioXvQ6XT2wiWH+KnSUF9sbJjZuS7xAiI7Jq/9GyPbVpj2NFrZdVfa95UgAjqGpIGCIhEqS1h5I+eAKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7089
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCBNYXkgMTEsIDIwMjEgYXQgMDM6MDM6MjlQTSArMDgwMCwgeWFuZ2Vya3VuIHdyb3Rl
Og0KPiBPdXIgc3l6a2FsbGVyIHRyaWdnZXIgdGhlICJCVUdfT04oIWxpc3RfZW1wdHkoJmlub2Rl
LT5pX3diX2xpc3QpKSIgaW4NCj4gY2xlYXJfaW5vZGU6DQo+IA0KPiBbICAyOTIuMDE2MTU2XSAt
LS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gWyAgMjkyLjAxNzE0NF0ga2Vy
bmVsIEJVRyBhdCBmcy9pbm9kZS5jOjUxOSENCj4gWyAgMjkyLjAxNzg2MF0gSW50ZXJuYWwgZXJy
b3I6IE9vcHMgLSBCVUc6IDAgWyMxXSBTTVANCj4gWyAgMjkyLjAxODc0MV0gRHVtcGluZyBmdHJh
Y2UgYnVmZmVyOg0KPiBbICAyOTIuMDE5NTc3XSAgICAoZnRyYWNlIGJ1ZmZlciBlbXB0eSkNCj4g
WyAgMjkyLjAyMDQzMF0gTW9kdWxlcyBsaW5rZWQgaW46DQo+IFsgIDI5Mi4wMjE3NDhdIFByb2Nl
c3Mgc3l6LWV4ZWN1dG9yLjAgKHBpZDogMjQ5LCBzdGFjayBsaW1pdCA9DQo+IDB4MDAwMDAwMDBh
MTI0MDlkNykNCj4gWyAgMjkyLjAyMzcxOV0gQ1BVOiAxIFBJRDogMjQ5IENvbW06IHN5ei1leGVj
dXRvci4wIE5vdCB0YWludGVkIDQuMTkuOTUNCj4gWyAgMjkyLjAyNTIwNl0gSGFyZHdhcmUgbmFt
ZTogbGludXgsZHVtbXktdmlydCAoRFQpDQo+IFsgIDI5Mi4wMjYxNzZdIHBzdGF0ZTogODAwMDAw
MDUgKE56Y3YgZGFpZiAtUEFOIC1VQU8pDQo+IFsgIDI5Mi4wMjcyNDRdIHBjIDogY2xlYXJfaW5v
ZGUrMHgyODAvMHgyYTgNCj4gWyAgMjkyLjAyODA0NV0gbHIgOiBjbGVhcl9pbm9kZSsweDI4MC8w
eDJhOA0KPiBbICAyOTIuMDI4ODc3XSBzcCA6IGZmZmY4MDAzMzY2Yzc5NTANCj4gWyAgMjkyLjAy
OTU4Ml0geDI5OiBmZmZmODAwMzM2NmM3OTUwIHgyODogMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAy
OTIuMDMwNTcwXSB4Mjc6IGZmZmY4MDAzMmI1ZjQ3MDggeDI2OiBmZmZmODAwMzJiNWY0Njc4DQo+
IFsgIDI5Mi4wMzE4NjNdIHgyNTogZmZmZjgwMDM2YWU2YjMwMCB4MjQ6IGZmZmY4MDAzNjg5MjU0
ZDANCj4gWyAgMjkyLjAzMjkwMl0geDIzOiBmZmZmODAwMzZhZTY5ZDgwIHgyMjogMDAwMDAwMDAw
MDAzM2NjOA0KPiBbICAyOTIuMDMzOTI4XSB4MjE6IDAwMDAwMDAwMDAwMDAwMDAgeDIwOiBmZmZm
ODAwMzJiNWY0N2EwDQo+IFsgIDI5Mi4wMzQ5NDFdIHgxOTogZmZmZjgwMDMyYjVmNDY3OCB4MTg6
IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgMjkyLjAzNTk1OF0geDE3OiAwMDAwMDAwMDAwMDAwMDAw
IHgxNjogMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAyOTIuMDM3MTAyXSB4MTU6IDAwMDAwMDAwMDAw
MDAwMDAgeDE0OiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgIDI5Mi4wMzgxMDNdIHgxMzogMDAwMDAw
MDAwMDAwMDAwNCB4MTI6IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgMjkyLjAzOTEzN10geDExOiAx
ZmZmZjAwMDY2Y2Q4ZjUyIHgxMDogMWZmZmYwMDA2NmNkOGVjOA0KPiBbICAyOTIuMDQwMjE2XSB4
OSA6IGRmZmYyMDAwMDAwMDAwMDAgeDggOiBmZmZmMTAwMDZhYzFlODZhDQo+IFsgIDI5Mi4wNDE0
MzJdIHg3IDogZGZmZjIwMDAwMDAwMDAwMCB4NiA6IGZmZmYxMDAwNjZjZDhmMWUNCj4gWyAgMjky
LjA0MjUxNl0geDUgOiBkZmZmMjAwMDAwMDAwMDAwIHg0IDogZmZmZjgwMDMyYjVmNDdhMA0KPiBb
ICAyOTIuMDQzNTI1XSB4MyA6IGZmZmYyMDAwMDgwMDAwMDAgeDIgOiBmZmZmMjAwMDA5ODY3MDAw
DQo+IFsgIDI5Mi4wNDQ1NjBdIHgxIDogZmZmZjgwMDMzNjZiYjAwMCB4MCA6IDAwMDAwMDAwMDAw
MDAwMDANCj4gWyAgMjkyLjA0NTU2OV0gQ2FsbCB0cmFjZToNCj4gWyAgMjkyLjA0NjA4M10gIGNs
ZWFyX2lub2RlKzB4MjgwLzB4MmE4DQo+IFsgIDI5Mi4wNDY4MjhdICBleHQ0X2NsZWFyX2lub2Rl
KzB4MzgvMHhlOA0KPiBbICAyOTIuMDQ3NTkzXSAgZXh0NF9mcmVlX2lub2RlKzB4MTMwLzB4YzY4
DQo+IFsgIDI5Mi4wNDgzODNdICBleHQ0X2V2aWN0X2lub2RlKzB4YjIwLzB4Y2I4DQo+IFsgIDI5
Mi4wNDkxNjJdICBldmljdCsweDFhOC8weDNjMA0KPiBbICAyOTIuMDQ5NzYxXSAgaXB1dCsweDM0
NC8weDQ2MA0KPiBbICAyOTIuMDUwMzUwXSAgZG9fdW5saW5rYXQrMHgyNjAvMHg0MTANCj4gWyAg
MjkyLjA1MTA0Ml0gIF9fYXJtNjRfc3lzX3VubGlua2F0KzB4NmMvMHhjMA0KPiBbICAyOTIuMDUx
ODQ2XSAgZWwwX3N2Y19jb21tb24rMHhkYy8weDNiMA0KPiBbICAyOTIuMDUyNTcwXSAgZWwwX3N2
Y19oYW5kbGVyKzB4ZjgvMHgxNjANCj4gWyAgMjkyLjA1MzMwM10gIGVsMF9zdmMrMHgxMC8weDIx
OA0KPiBbICAyOTIuMDUzOTA4XSBDb2RlOiA5NDEzZjRhOSBkNTAzMjAxZiBmOTAwMTdiNiA5N2Y0
ZDViMSAoZDQyMTAwMDApDQo+IFsgIDI5Mi4wNTU0NzFdIC0tLVsgZW5kIHRyYWNlIDAxYjMzOWRk
MDc3OTVmOGQgXS0tLQ0KPiBbICAyOTIuMDU2NDQzXSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2lu
ZzogRmF0YWwgZXhjZXB0aW9uDQo+IFsgIDI5Mi4wNTc0ODhdIFNNUDogc3RvcHBpbmcgc2Vjb25k
YXJ5IENQVXMNCj4gWyAgMjkyLjA1ODQxOV0gRHVtcGluZyBmdHJhY2UgYnVmZmVyOg0KPiBbICAy
OTIuMDU5MDc4XSAgICAoZnRyYWNlIGJ1ZmZlciBlbXB0eSkNCj4gWyAgMjkyLjA1OTc1Nl0gS2Vy
bmVsIE9mZnNldDogZGlzYWJsZWQNCj4gWyAgMjkyLjA2MDQ0M10gQ1BVIGZlYXR1cmVzOiAweDEw
LGExMDA2MDAwDQo+IFsgIDI5Mi4wNjExOTVdIE1lbW9yeSBMaW1pdDogbm9uZQ0KPiBbICAyOTIu
MDYxNzk0XSBSZWJvb3RpbmcgaW4gODY0MDAgc2Vjb25kcy4uDQo+IA0KPiBDcmFzaCBvZiB0aGlz
IHByb2JsZW0gc2hvdyB0aGF0IHNvbWVvbmUgY2FsbCBfX211bmxvY2tfcGFnZXZlYyB0byBjbGVh
cg0KPiBwYWdlIExSVS4NCj4gDQo+ICAjMCBbZmZmZjgwMDM1ZjAyZjRjMF0gX19zd2l0Y2hfdG8g
YXQgZmZmZjIwMDAwODA4ZDAyMA0KPiAgIzEgW2ZmZmY4MDAzNWYwMmY0ZjBdIF9fc2NoZWR1bGUg
YXQgZmZmZjIwMDAwOTg1MTAyYw0KPiAgIzIgW2ZmZmY4MDAzNWYwMmY1ZTBdIHNjaGVkdWxlIGF0
IGZmZmYyMDAwMDk4NTFkMWMNCj4gICMzIFtmZmZmODAwMzVmMDJmNjAwXSBpb19zY2hlZHVsZSBh
dCBmZmZmMjAwMDA5ODUyNWMwDQo+ICAjNCBbZmZmZjgwMDM1ZjAyZjYyMF0gX19sb2NrX3BhZ2Ug
YXQgZmZmZjIwMDAwODQyZDJkNA0KPiAgIzUgW2ZmZmY4MDAzNWYwMmY3MTBdIF9fbXVubG9ja19w
YWdldmVjIGF0IGZmZmYyMDAwMDg0YzQ2MDANCj4gICM2IFtmZmZmODAwMzVmMDJmODcwXSBtdW5s
b2NrX3ZtYV9wYWdlc19yYW5nZSBhdCBmZmZmMjAwMDA4NGM1OTI4DQo+ICAjNyBbZmZmZjgwMDM1
ZjAyZmE2MF0gZG9fbXVubWFwIGF0IGZmZmYyMDAwMDg0Y2JkZjQNCj4gICM4IFtmZmZmODAwMzVm
MDJmYWYwXSBtbWFwX3JlZ2lvbiBhdCBmZmZmMjAwMDA4NGNlMjBjDQo+ICAjOSBbZmZmZjgwMDM1
ZjAyZmI5MF0gZG9fbW1hcCBhdCBmZmZmMjAwMDA4NGNmMDE4DQo+IA0KPiBTbyBtZW1vcnlfZmFp
bHVyZSB3aWxsIGNhbGwgaWRlbnRpZnlfcGFnZV9zdGF0ZSB3aXRob3V0DQo+IHdhaXRfb25fcGFn
ZV93cml0ZWJhY2suIEFuZCBhZnRlciBnZW5lcmljX3RydW5jYXRlX2Vycm9yX3BhZ2UgY2xlYXIg
dGhlDQo+IG1hcHBpbmcgb2YgdGhpcyBwYWdlLiBlbmRfcGFnZV93cml0ZWJhY2sgd29uJ3QgY2Fs
bA0KPiBzYl9jbGVhcl9pbm9kZV93cml0ZWJhY2sgdG8gY2xlYXIgaW5vZGUtPmlfd2JfbGlzdC4g
VGhhdCB3aWxsIHRyaWdnZXINCj4gQlVHX09OIGluIGNsZWFyX2lub2RlIQ0KPiANCj4gRml4IGl0
IGJ5IG1vdmUgdGhlIHdhaXRfb25fcGFnZV93cml0ZWJhY2sgYmVmb3JlIGNoZWNrIG9mIExSVS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IHlhbmdlcmt1biA8eWFuZ2Vya3VuQGh1YXdlaS5jb20+DQoN
ClRoZSBpZi1ibG9jayBvZiAiZ290byBpZGVudGlmeV9wYWdlX3N0YXRlIiB3YXMgaW50cm9kdWNl
ZCBieSBjb21taXQNCjBiYzFmOGIwNjgyYyAoImh3cG9pc29uOiBmaXggdGhlIGhhbmRsaW5nIHBh
dGggb2YgdGhlIHZpY3RpbWl6ZWQgcGFnZSBmcmFtZQ0KdGhhdCBiZWxvbmcgdG8gbm9uLUxSVSIp
LCBhbmQgbWF5YmUgdGhlIGlzc3VlIGdvdCB2aXNpYmxlIG9uIGNvbW1pdA0KNmM2MGQyYjU3NDZj
ICgiZnMvZnMtd3JpdGViYWNrLmM6IGFkZCBhIG5ldyB3cml0ZWJhY2sgbGlzdCBmb3Igc3luYyIp
LA0Kd2hpY2ggYWRkZWQgaW5vZGUtPmlfd2JfbGlzdC4NClNvIHlvdSBjYW4gYWRkIEZpeGVzIHRh
ZyBmb3IgZWl0aGVyIGNvbW1pdCAobWF5YmUgMGJjMWY4YjA2ODJjPykuDQoNClRoYW5rcywNCk5h
b3lhIEhvcmlndWNoaQ0KDQo+IC0tLQ0KPiAgbW0vbWVtb3J5LWZhaWx1cmUuYyB8IDYgKysrLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5j
DQo+IGluZGV4IGJkMzk0NTQ0NmQ0Ny4uOTg3MGEyMjgwMGQ5IDEwMDY0NA0KPiAtLS0gYS9tbS9t
ZW1vcnktZmFpbHVyZS5jDQo+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gQEAgLTE1Mjcs
MTUgKzE1MjcsMTUgQEAgaW50IG1lbW9yeV9mYWlsdXJlKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQg
ZmxhZ3MpDQo+ICAJCXJldHVybiAwOw0KPiAgCX0NCj4gIA0KPiAtCWlmICghUGFnZVRyYW5zVGFp
bChwKSAmJiAhUGFnZUxSVShwKSkNCj4gLQkJZ290byBpZGVudGlmeV9wYWdlX3N0YXRlOw0KPiAt
DQo+ICAJLyoNCj4gIAkgKiBJdCdzIHZlcnkgZGlmZmljdWx0IHRvIG1lc3Mgd2l0aCBwYWdlcyBj
dXJyZW50bHkgdW5kZXIgSU8NCj4gIAkgKiBhbmQgaW4gbWFueSBjYXNlcyBpbXBvc3NpYmxlLCBz
byB3ZSBqdXN0IGF2b2lkIGl0IGhlcmUuDQo+ICAJICovDQo+ICAJd2FpdF9vbl9wYWdlX3dyaXRl
YmFjayhwKTsNCj4gIA0KPiArCWlmICghUGFnZVRyYW5zVGFpbChwKSAmJiAhUGFnZUxSVShwKSkN
Cj4gKwkJZ290byBpZGVudGlmeV9wYWdlX3N0YXRlOw0KPiArDQo+ICAJLyoNCj4gIAkgKiBOb3cg
dGFrZSBjYXJlIG9mIHVzZXIgc3BhY2UgbWFwcGluZ3MuDQo+ICAJICogQWJvcnQgb24gZmFpbDog
X19kZWxldGVfZnJvbV9wYWdlX2NhY2hlKCkgYXNzdW1lcyB1bm1hcHBlZCBwYWdlLg0KPiAtLSAN
Cj4gMi4yNS40DQo+IA==
