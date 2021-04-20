Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2A365A7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhDTNsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 09:48:00 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:12122 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232450AbhDTNr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:47:59 -0400
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KDkaV3019600;
        Tue, 20 Apr 2021 13:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=saUdFj59vLScZDz77SunDlmjFm8Hhw6DFVdZrZY7Rrc=;
 b=mCaTRR2srEotl51dtQ99uQSyyEovK+3mYmGpZ7RzosufZyBgXpwqnfacNvlHCvmjAi+P
 NU3T956aOycQhIXk6V4/TMHaBq6RI+n0ZLVAPj7kix12OUPlxXrq/+DWJziHqeP5UnTg
 I3RJuR6U8NjsCSEmQEcg/7QINPrnXVqL12HODr5oeLA8HI/axznpXQPbNQ2/n+7u1ODB
 WlAc2F5iclkHFWGdt0H/osmbj1BismkLuu+9XTXsCz+KL0XNP976OcZN6cP4cqsKxfsS
 R7emeSAspFV7WaVmTf6BzNnkDDuP5K3WVfK4nev1CIO1JeXZMzSptmbmtfROlPC1kjZS aQ== 
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
        by mx08-001d1705.pphosted.com with ESMTP id 37ypb0241h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 13:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJFEp7ZMF5UazHrLssgrW925wlb0/SMGHv0mGxtrplH/F6sIqSi/I9RtBQwkzUmEUFGgWe/htGiG74KxQqJeLdhNFNfCj7TtGigBmrFlWH1MPRqXx9+O0V4Eft3oQjLb9+bmLY+tY6RuJmmWfrJ8RVc2x6unCxV7r6NOcfZVNSGfBVDQRvMWUdbHcK8WoT5VFO9Vvkcc+j3na+x1Ep1NgT+1RCUJg8KEkRpLVkH4Mtrj1tQ4UZBVgXy67NMmb1srPmSTaluBgFlXt0zPa6QxzLXaaqkJ09KovFJ/5DgK5Y/V3MnMRkj37lJROyrsqMSkCwxjbwuUzreXP044O/r1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saUdFj59vLScZDz77SunDlmjFm8Hhw6DFVdZrZY7Rrc=;
 b=hNMDjLEZ+4ubtKQDBRfYDyTZTj9T6lOMl/SVyYctnOM6Mzq/fXw/UEhoyunvvP8H1rIumRe4MyIn0P4a73yjF76l85BKTwCTOxFU3M4nglBLVxsFKNI/MLw3dxn32j6UWlmcmmk2G78q+hf0rAQnJGTIQjCq6WZ0IHzU7gTn0GOlPbY3jhfjfLANa3bAajKD5Z1W1RuKd/cBFCKo8QS91kYeOboY6gGl3AOLHMjsGd5LkVBKBPKrhWPRt5UJjUXXoHW5+/917AH6UOsLWmTnbCmRH/BJM9xHzsdjxgg1cNByIZ5Ltzq6jKf4LqeEYaCFuLWc/snuraQitZPE92juBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM0P193MB0465.EURP193.PROD.OUTLOOK.COM (2603:10a6:208:5a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 13:46:29 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 13:46:29 +0000
From:   <Peter.Enderborg@sony.com>
To:     <daniel@fooishbar.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <songmuchun@bytedance.com>, <guro@fb.com>, <shakeelb@google.com>,
        <mhocko@suse.com>, <neilb@suse.de>, <samitolvanen@google.com>,
        <rppt@kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <willy@infradead.org>
Subject: Re: [PATCH v2] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Topic: [PATCH v2] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Index: AQHXMrzS5xsiePyv1kC49iGqOSZm9aq9bm8AgAADNoA=
Date:   Tue, 20 Apr 2021 13:46:29 +0000
Message-ID: <9d4b7f7d-1a7d-0899-bf33-49fac1847bbe@sony.com>
References: <20210416123352.10747-1-peter.enderborg@sony.com>
 <CAPj87rM9gaPS5SOHo3CKUU=5H0PDaG28r8BXimhVp-wmCbMvWA@mail.gmail.com>
In-Reply-To: <CAPj87rM9gaPS5SOHo3CKUU=5H0PDaG28r8BXimhVp-wmCbMvWA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: fooishbar.org; dkim=none (message not signed)
 header.d=none;fooishbar.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47e46a0a-d195-41a9-f0de-08d90402b322
x-ms-traffictypediagnostic: AM0P193MB0465:
x-microsoft-antispam-prvs: <AM0P193MB046549C92184B784398F83B986489@AM0P193MB0465.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tXcbR9U3Z1xG9bxjVQjoLYeB/f+3jknnI4C6yhGRAQQKdM+ZnkE82KsuNpqwfG7JLq44F4fs8USJNbxuKRLpZ9qxCmJ85cI5ML1uW8erVjmGMg9Fap+G5IknvicJeXjDqEb5oCHchKow0xx0o5JidcTz5oUVo6egUXS8rg0H196YjW9vsq24uUyiaJ4VU85qkee7qUxiJTixwnQ4vI5CBAoIAcqZ11sLCo0Gz8uUpLeS9+piTINfLTYk/vcKrJbCOhqGDft+MRqd6m8lBepLfErZ98gfdoaLzJn4gtm1E+DWnOFjVDzjoEjMXYeeSioOpRwVzCURpxfC+h/vA4nZe962+dp7NN7jXOq6hz5mh3NvRTieEDahRFnz3J5qY+mKFgttGwiFhRxdvGwqjSIeZozJ7Z7/6WABxZQy+J1QhwnkaT6+vukeY/eE7uKjagOp2a/fllqaJB8vYxB27yKKVTOAtOIfYMJx41ybasLUzJDmvTOfW3AfQ4VGVf9zAF8rIpHy6YhtADSpg6WgrqWm5y0k0nc7KPMwlrpXPx5hAOoz3PsJQ5K2bsdyGxJIqaX2CKavtsWgJwZjREYRETvdpGnb6eixUX/UK7oE3cN0I5NbUho5HxLHn79kR0ql7neiWkjbFRkw53M6wpF77vbCFPUjyFmLz0FiWqc0tQYC0krVj5qQfzP57+miLwiQCojT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(346002)(376002)(396003)(136003)(26005)(6486002)(2906002)(71200400001)(186003)(64756008)(86362001)(478600001)(36756003)(66946007)(38100700002)(4326008)(316002)(31686004)(4744005)(5660300002)(31696002)(54906003)(6506007)(8936002)(7416002)(91956017)(2616005)(66556008)(122000001)(76116006)(66476007)(66446008)(83380400001)(8676002)(6916009)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aUNaRno5RlNGTU4xSWxXbHlQc0RZOFNVOHNHTUZYYURXNWZoUXFwaTQyN2Jn?=
 =?utf-8?B?V2RPWVY1ODFYbHE4ZngwY015U0JVdloxY3NPK2ZjZTZaQzdRRS9TVzVOUjUw?=
 =?utf-8?B?ZVZmeWJNMWREYk5kL2ZBcnd3Uyt0azVOcEZIMFA5QmRWZVBaa0NRSWZWa1Q2?=
 =?utf-8?B?aDBkb3RBTlBIMGxTSkxia2pRMmM1d3A0WkdwUkx3VnFMUlpUSEdYNFNLZWh5?=
 =?utf-8?B?bTNxVEloQXVuOUd5N01NZWJVMHNHbU12ZHp1bnBMdmJ5Wlp6U0Y2Qlg3YitY?=
 =?utf-8?B?SUJxRUppRXhwdnFwNXlUcGtHeDJ2OWI4NmZGVVhSeUs0TEJrRGRiWXdwTCto?=
 =?utf-8?B?ZTNnL3Z5MkJtUTluNXBIMTJoM01XdmNnQlhHY3ZyWUtRN29DMm4zMXJ0OVRy?=
 =?utf-8?B?Y0FLL0VNWXpBalpYc0dtL2FySXl5NU1VbUphS2xKcGJseWJPTi9YajlsMTBp?=
 =?utf-8?B?djhPajk4NFlwSlBoWjRHQVhFeFRScGZzYm1QUTIxSmdFcElSNk1LcVU5S0k5?=
 =?utf-8?B?ZStLcXZCbXgwWjlySVMzbnNLRU03Q3VjN1U4Mmg5WnhyRzcyUUtCSVo1Zll3?=
 =?utf-8?B?OEtmcjFxM2kydGJ6UjU1eU55K09YQXFCNEgwczIySFVJWXgyeStRZkJteXFq?=
 =?utf-8?B?STRtL3dxY1QrTVpGLzBhbnBpQVhzRnlRQURwQzlFU1lkci9rWHk1MTY3N0tl?=
 =?utf-8?B?Z1BZQ1ZzcGxlNW1YbmVFdjBFQmsrK3EyZFg5MUVacGQxVFlYV0RvcERyeHF2?=
 =?utf-8?B?ZVBjMU40OEtyRVJka2VpRUZ6aFp6Q1BKYkxZUXJzazZHbENZdlozVkdMaHZW?=
 =?utf-8?B?bEZLUW5ZczQxZm9BYlM3WXF0Si9qZVcxOHFmYVdSQjNEdGZPNXdqTk5RM2Jw?=
 =?utf-8?B?ekg3WklsZmdqMzB3TUt4OFlrei80STNjNUlBSGgxMUVDTXNJK25UeHdvUVNT?=
 =?utf-8?B?aXAyU0crazQ0VEc5MGl5ZGFRdTF4M3VaWGE5Mlp3RmxFSlVHejNBZ2kvSTV0?=
 =?utf-8?B?U1RIekhyR1lRMW1NSUVYMmJpVVI2SUlVdkFIOEdRN1JxSHJZbmpNaXRUNlda?=
 =?utf-8?B?WmFRaGtBUk1ZNU9lbUJEVGZ2UlVCV0RPRFhHaFplUTZ6U2JBd2NreGpyMHB5?=
 =?utf-8?B?bis0dDI1bnZ0dWxtaDRXa3R1N3JER2hmemV2RXVrVDl0N0tqVlJuTjczSjcw?=
 =?utf-8?B?NHRlQkd3Z0VoZEVSb0xIQTBmV3Z0THdFZHUwTWQxR3l5amJhOG41SWtCb1Na?=
 =?utf-8?B?eW8rcFpLU2VYU3ZBNlFLdzF2cU5lN012YkExa3E1RVZxd1hadHdFdFFYbTRK?=
 =?utf-8?B?TzJDZisrVkJrNFVOMXBRYld6a2hLSi9HTEQrcjYvSmljbHZwbkErYmtvbjlU?=
 =?utf-8?B?ZFVVZkg2OThYWWNtS1NyUFQ0OVJ4ZjV4RmtGYThIOVdaN01McG5ZOXVVZ3Rl?=
 =?utf-8?B?Rkg3WlpycTZEUitTS3RueU1NL2ptTEVBU2xkdVkvMllLamZJWnBDb3ZVZ2Yw?=
 =?utf-8?B?Tk1PYWsyNjJDM1NpS1MzRWZRU0xCbFJMd2o0dFoweXZtbWxlb0JxdFpnTitM?=
 =?utf-8?B?eVRHWDkrNU9FaGlBcllvb0NQRlZUZHF3RlQvL0RaeTYzNDBzR2dITy9sa25X?=
 =?utf-8?B?R3p6YXZDQi9RYkp4R05CVCtia2YvRlQ4YnNQOEw4WGo2WWtHVlhzM2ZzbjFY?=
 =?utf-8?B?MjVzMzlSN09BNFZud1lKZTJhWmlSMnJ0WkgzRC9pc1piTUxjWkVCNFI1aU8y?=
 =?utf-8?Q?NBDdSEzU47Gd4Twv+jVqpQLFxv1TVkE6jC6Th22?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A46D38193DB95A4EA597B7977E04768F@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e46a0a-d195-41a9-f0de-08d90402b322
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 13:46:29.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuDeK1oKMHWWXbT6NofW8BAx+g6YD43aDakPD+CGkjVB4l3RTyeZPvW9+ad++I9cCsDnqxZyKBt0UE8c+RDHOFlOHPLh1ScwXnTc9oYzbnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0465
X-Proofpoint-GUID: 3alh0NEod9WPBcpYTpsJh29iosjaXj5h
X-Proofpoint-ORIG-GUID: 3alh0NEod9WPBcpYTpsJh29iosjaXj5h
X-Sony-Outbound-GUID: 3alh0NEod9WPBcpYTpsJh29iosjaXj5h
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_06:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200103
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMC8yMSAzOjM0IFBNLCBEYW5pZWwgU3RvbmUgd3JvdGU6DQo+IEhpIFBldGVyLA0KPg0K
PiBPbiBGcmksIDE2IEFwciAyMDIxIGF0IDEzOjM0LCBQZXRlciBFbmRlcmJvcmcgPHBldGVyLmVu
ZGVyYm9yZ0Bzb255LmNvbSA8bWFpbHRvOnBldGVyLmVuZGVyYm9yZ0Bzb255LmNvbT4+IHdyb3Rl
Og0KPg0KPiAgICAgVGhpcyBhZGRzIGEgdG90YWwgdXNlZCBkbWEtYnVmIG1lbW9yeS4gRGV0YWls
cw0KPiAgICAgY2FuIGJlIGZvdW5kIGluIGRlYnVnZnMsIGhvd2V2ZXIgaXQgaXMgbm90IGZvciBl
dmVyeW9uZQ0KPiAgICAgYW5kIG5vdCBhbHdheXMgYXZhaWxhYmxlLiBkbWEtYnVmIGFyZSBpbmRp
cmVjdCBhbGxvY2F0ZWQgYnkNCj4gICAgIHVzZXJzcGFjZS4gU28gd2l0aCB0aGlzIHZhbHVlIHdl
IGNhbiBtb25pdG9yIGFuZCBkZXRlY3QNCj4gICAgIHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMgdGhh
dCBoYXZlIHByb2JsZW1zLg0KPg0KPg0KPiBGV0lXLCB0aGlzIHdvbid0IHdvcmsgc3VwZXIgd2Vs
bCBmb3IgQW5kcm9pZCB3aGVyZSBncmFsbG9jIGlzIGltcGxlbWVudGVkIGFzIGEgc3lzdGVtIHNl
cnZpY2UsIHNvIGFsbCBncmFwaGljcyB1c2FnZSB3aWxsIGluc3RhbnRseSBiZSBhY2NvdW50ZWQg
dG8gaXQuDQo+DQo+IENoZWVycywNCj4gRGFuaWVswqANCg0KVGhpcyByZXNvdXJjZSBhbGxvY2F0
aW9uIGlzIGEgYmlnIHBhcnQgb2Ygd2h5IHdlIG5lZWQgaXQuIFdoeSBzaG91bGQgaXQgbm90IHdv
cms/wqANCg==
