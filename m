Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D524365542
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhDTJ1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 05:27:09 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:3644 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231324AbhDTJ1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:27:08 -0400
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13K9LA3D022253;
        Tue, 20 Apr 2021 09:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=S1;
 bh=GpE+bqy9fQcuw2y2aUqW9qPATF97gbsL0UF1usmuoHo=;
 b=KHUpgvdza5TuEP9I+GrIWdnTstymphnd56gYhA+7PCkrZS1CMo9tirfOTphMd6M9A/Mp
 GZTim/R9lXnyarfwtxWA4/5eNjLz5iqm6iHHYEEgFkYYFiOLTlBWzzsflzWfQTVxqLBW
 LsR7YMhGrjx9R+X+4VEEgo/32qbqYELA9YRDgn/yUF36yLe3qQXCymuc1un8KMhGr764
 Haf24+HOFqh7m31GxSPDDrz+5VpRnTIqqJK+3GF15T9wi8QNT98mfJPU5s6XiSS834su
 DXdn5coinMNn2/saHbCS3QlFxy4PgwrtFd3Q/HmjxS68VnSLtqjmEpHY72SDAhmq600W eg== 
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174])
        by mx08-001d1705.pphosted.com with ESMTP id 37yp874aht-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 09:26:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjzpmqY+TSdO3gM3+h3zcehzU6Oo3ksxDD1SslRSUATZaMVrYPAg0b37Mv/dXF3nzkn0ArkzVuSawBAD9YZkmb6nec4e8e5a/H4rZ9FLOVjGxIRX0ENypAYcz1/EY39v7kKUxndA7//CMHyvwHvaLtQuYxCzi1d7OprY7RyM7Hp0aebvtriQekPMuqlwP3zA+53smfpsjxKgfXeK19BVkJLb6Zrk3EYN0vcpXY3tWnpL4MAZnjp8s+N+ZfHap1KbarpTYuqbpFfUGHDKTPJCvAgl5LvUls2gXKdvIK85Dp8KNR5bKFs8BwV0XCc+AuqpytXtwZD+rubleL++MnE+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpE+bqy9fQcuw2y2aUqW9qPATF97gbsL0UF1usmuoHo=;
 b=J5DzmDMveu5rVD1Iw+IcSpBLu09pks1qkyuPjXszZ0LMhC7hNBrLKJeU6muMcvOH9xpW44C6Eopqz0c+EEds2I0LIqcJHRtKFtXFdQAyKmzGgTqyoWh44v2np7LnRTYb8PSpSvjfOyTgzmk45pd7X1RJzmTjzu+d9vWs+/AoDCRQbi1mXFavU4w4n2CRBktHe7E5+5W81WDABKPldw6eUyJFJvstcuY/TTx9ul7Q12RH4Jp+cNNNL4+KAfGTMvlUeDcXE9pTjpHV31+Rst/PAOpPEGQ2VARuBHSQdxCkb4TCovdlqNA/BKhhiqoQ7XM/Zx7mtEwLhNUjK8Ouvhwm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM8P193MB0947.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 20 Apr
 2021 09:26:00 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 09:26:00 +0000
From:   <Peter.Enderborg@sony.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <songmuchun@bytedance.com>, <guro@fb.com>, <shakeelb@google.com>,
        <mhocko@suse.com>, <neilb@suse.de>, <samitolvanen@google.com>,
        <rppt@kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <willy@infradead.org>
Subject: Re: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Topic: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Index: AQHXM6gnmsuLu+Ufhk6GusLEaztxYKq9H2WAgAAHpAA=
Date:   Tue, 20 Apr 2021 09:26:00 +0000
Message-ID: <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
References: <20210417163835.25064-1-peter.enderborg@sony.com>
 <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
In-Reply-To: <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8cb24de-ab7d-4f07-0a5a-08d903de4ff0
x-ms-traffictypediagnostic: AM8P193MB0947:
x-microsoft-antispam-prvs: <AM8P193MB0947CB1CA9049E9DD78C5E4986489@AM8P193MB0947.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPAnOt0OgK6qn+JvyqSEzK0LTD3706zJMBkXISQxaLLBKJYJnEQ3zI43v5y4fF1DLtCd0QRNoIIATjFq0DxC9RhxQtnnjBh4ogrzCsuDGV779UZWr2jIsunJD3c87KN9vODmvd9lJAszKbZiUelXJdcBt6OB1E1SZOU3K51El6NSF7c/zTbIpZKs4mRvL45AdSNpVNioot4uzXpaLAzLXmHFMoKPr9mU/AzWtsZnbpYcYsG6PoDwM0x1o78MIIHXCuMMg9dLgGVXXoBxBoPxbIUhixtVLgMiy/8vPS+Aue3x6Y+5SrgcSkO9ai8lzXZ19Yp0KNM9UmeGL/bBPYVeEVaK9Ttjdk8Ux9+D9s4ItkQOZHKzR0UlhsQNix0IN5mwq2frAPw4/pUITqxFbUFt9h5UscGh2S75Z4fiAR8jA0vgw+3JXGUPvWgmYVo16qrvlzYVYEVcHYizhihnsWJyYyb6iGmbnPUGuJR569hmH08IU+vUibIYq5U/PK1DNiUv0fO8Vn3l5bxssT6VN27dHw2/yCQfEK7G8m+xOJ+q5481SKa18iKI/2BNLew/2GCl8vjUuWA+s6x0pN79CMig0v7VImXOBc2vCMAnUyFNmeN/ySLLBbudrJVtRdrwh/UsxmVmnSs3AkxIDs/0oo8vufUD4aNB8DlnVV5dHGRO0lqidVGrSM3oVF2hEVM9U0zBTFN1elnB+E1QAo2B4++YJQoEn6vnSvx3Y7x78fm90z7X7uxica9CqqK0/pVtaSID
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(6512007)(8676002)(966005)(7416002)(8936002)(36756003)(186003)(38100700002)(6506007)(2906002)(31696002)(64756008)(66446008)(31686004)(86362001)(2616005)(83380400001)(66556008)(53546011)(66476007)(122000001)(316002)(921005)(5660300002)(6486002)(478600001)(110136005)(26005)(66946007)(76116006)(91956017)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ajE5RWJzcWFUcXBZMytTZFVKRStBeWZiM0JoN1ArSEdBZkE0RnFPaFJ4Znpr?=
 =?utf-8?B?cVMzQUVZbC9ZbkRPV1dtUkpReTVhWlRZRlJiSUR3MEsyamd0SW9rRHdFRmkr?=
 =?utf-8?B?UitlZHN0SlQxdnJBK1lPbHg5cEhkYjNwV0VLdTNKUzFURjdVWFFEbzhQR3RM?=
 =?utf-8?B?Tk5leVZJdVlCeXdxOVg2MXRUT1JIckp4TEFNY0poUk9BckVia2xJajB1VGtW?=
 =?utf-8?B?YXg2VzhNR25obUdqcnA2ZkRCbXdGL3RGWXY3UkV3Z3VQb0RWZUZ4MWRkeEt3?=
 =?utf-8?B?K3diUnA4L01QWXVFN2FMM2xSSTJaVVN3aG81Y21JdHhrYUxqKzhUU0FaUi9L?=
 =?utf-8?B?b2dRbUZIQlVMTTQySzFpQUhveWhIbWhrSENQNG9sSTBFVWZ1RStJSTVKT0ww?=
 =?utf-8?B?WkxwQlhiYmtsbUlheHlYTkt6RmVHbjcyQkphVllZRzY4QnRFSFhDSFAxZ1ZV?=
 =?utf-8?B?U2E0c0YvY1pHTXFYdXVwSDhWS0cvTGthWGZ5Y2lmZEZOR0dqZVUySHN2Y0p1?=
 =?utf-8?B?S1hOUWxqSEFVa2Ixb09TV2ZmS2o0L20zVUhCVXdtRTRlM0czaDNMRm9HSzdj?=
 =?utf-8?B?RldyWGlxWHg2OXpmSzdGSE1UekozN29CNWNybEhIUVdXeCt0Z0RZUjBrRGpV?=
 =?utf-8?B?aVlkQWlxaVR0b3BOZ1BvMVpiU1Z6dm9QNXpNNWYvaU9PaFI0L0FVamE2Wk5l?=
 =?utf-8?B?NWxQRnQ4eXM4YUlsVFU4bDNFemlkMTR6b2dpZHdZVW1JZVdCamtOU212K3JD?=
 =?utf-8?B?NnNDUTZBblZ2eXZ2RXpOQ0VoVVpKTnBiOVpBZ0FMYUV3OXc4VjVPMDRiWHB2?=
 =?utf-8?B?Qk10ak5kUVJvRTVhQXZIZ2lWaWMzcDdYR3h3VmwyTlI4THh6NEhMVUV6NXVl?=
 =?utf-8?B?VlRCZHRlblF3UnRVRDJBMkRMbnRGRFNRYlV3b1JlT2VFbm05VnFjbktPNkgx?=
 =?utf-8?B?amxpZVVPWEFCQmdhTUJnUVlOMWVYc25rRGRUdTZhaWFXR3R1S2pRMmQ0SE9M?=
 =?utf-8?B?Ui8zZWxjNTZSNkZpUTg0RnYveUNLQ3hFaWgyL05wSnJjckVYV01nQmpFTjRB?=
 =?utf-8?B?SnRrRHBSWHhIYVY5Q2JtaDNzUlQ2WGZzN0tsMHdhOEkwRkNuVDhvOW9pOEVt?=
 =?utf-8?B?V0FPV0JWb0x2RHpjem9WcEtzbm5BUHo0U3FxNk9Bd0FJdUoyUEM0bXJtdWpn?=
 =?utf-8?B?cXh6eHkxSVBEWStDME9YUVdrUURvcm5oUUNzTDBBZE1wdy82Ty9TTzh1MVA4?=
 =?utf-8?B?WWJNYnh0Vnl4QW82L3Mxa3I0Umc0dTlZNWl2TFE5SDVXM1ltL1QwaXJ6QmdO?=
 =?utf-8?B?OFozZk5KSUdLc0RrSEU5eWIwdEJEY0FvVmptdzZES0pKUzZjODQvMTBXL21X?=
 =?utf-8?B?YjRkMGxLcWtJZkc2V3U1WTBHM09GY292RXpFUGtQZ0xrbzJhSWQvaUtyWXhQ?=
 =?utf-8?B?SDVxUTYwdGdxdHFncmtscWo5aVRKcVhybmEzZmFqeTZYUjNsS1NFd2xNMW5p?=
 =?utf-8?B?eEUzSWdJeGtWNTN2amFsbXRsZnA3N0FXTVRac1RUeHk5ejFsZmV3WDd6Q0Vn?=
 =?utf-8?B?R1BTU2NxdjViK3RwNE5GU3krVEpmcG0ycG5GVmVKYjRrL2xhbUNzNWFjSlh6?=
 =?utf-8?B?YVNFSEh5YVYzTzhxdE1OVXNMSWxtWVhzdWNYOHdoMWFxcS9xbjdsNzEvWUJv?=
 =?utf-8?B?Qm1IV3RlMXlOdDVkNFZ5YjIzSXB1MSswK1ZHRnJTZUdUSGtPUW02SFFRTUg0?=
 =?utf-8?Q?BqSZ3ZeXCf2dqjJFqvMbPBE4IOKHWZuGEBMfz9N?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <471C00AEA817D34AB18B641B729A7222@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cb24de-ab7d-4f07-0a5a-08d903de4ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 09:26:00.6876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HM1GHViAZDFidAfa3ZTYhiHalyPCN96WJTDzTEagNxw5IFQnW6WSNK/Uv3CBaVNBWuggiRuTjyPK0Ic5U9qOfuCkhsNaBctFScTPr1Paljg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0947
X-Proofpoint-ORIG-GUID: wMvzap05kbJ1OL4SeUdw964bqK_ycF-L
X-Proofpoint-GUID: wMvzap05kbJ1OL4SeUdw964bqK_ycF-L
X-Sony-Outbound-GUID: wMvzap05kbJ1OL4SeUdw964bqK_ycF-L
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_02:2021-04-19,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200070
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMC8yMSAxMDo1OCBBTSwgRGFuaWVsIFZldHRlciB3cm90ZToNCj4gT24gU2F0LCBBcHIg
MTcsIDIwMjEgYXQgMDY6Mzg6MzVQTSArMDIwMCwgUGV0ZXIgRW5kZXJib3JnIHdyb3RlOg0KPj4g
VGhpcyBhZGRzIGEgdG90YWwgdXNlZCBkbWEtYnVmIG1lbW9yeS4gRGV0YWlscw0KPj4gY2FuIGJl
IGZvdW5kIGluIGRlYnVnZnMsIGhvd2V2ZXIgaXQgaXMgbm90IGZvciBldmVyeW9uZQ0KPj4gYW5k
IG5vdCBhbHdheXMgYXZhaWxhYmxlLiBkbWEtYnVmIGFyZSBpbmRpcmVjdCBhbGxvY2F0ZWQgYnkN
Cj4+IHVzZXJzcGFjZS4gU28gd2l0aCB0aGlzIHZhbHVlIHdlIGNhbiBtb25pdG9yIGFuZCBkZXRl
Y3QNCj4+IHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMgdGhhdCBoYXZlIHByb2JsZW1zLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFBldGVyIEVuZGVyYm9yZyA8cGV0ZXIuZW5kZXJib3JnQHNvbnkuY29t
Pg0KPiBTbyB0aGVyZSBoYXZlIGJlZW4gdG9ucyBvZiBkaXNjdXNzaW9ucyBhcm91bmQgaG93IHRv
IHRyYWNrIGRtYS1idWYgYW5kDQo+IHdoeSwgYW5kIEkgcmVhbGx5IG5lZWQgdG8gdW5kZXJzdGFu
ZCB0aGUgdXNlLWNhc3MgaGVyZSBmaXJzdCBJIHRoaW5rLiBwcm9jDQo+IHVhcGkgaXMgYXMgbXVj
aCBmb3JldmVyIGFzIGFueXRoaW5nIGVsc2UsIGFuZCBkZXBlbmRpbmcgd2hhdCB5b3UncmUgZG9p
bmcNCj4gdGhpcyBkb2Vzbid0IG1ha2UgYW55IHNlbnNlIGF0IGFsbDoNCj4NCj4gLSBvbiBtb3N0
IGxpbnV4IHN5c3RlbXMgZG1hLWJ1ZiBhcmUgb25seSBpbnN0YW50aWF0ZWQgZm9yIHNoYXJlZCBi
dWZmZXIuDQo+ICAgU28gdGhlcmUgdGhpcyBnaXZlcyB5b3UgYSBmYWlybHkgbWVhbmluZ2xlc3Mg
bnVtYmVyIGFuZCBub3QgYW55dGhpbmcNCj4gICByZWZsZWN0aW5nIGdwdSBtZW1vcnkgdXNhZ2Ug
YXQgYWxsLg0KPg0KPiAtIG9uIEFuZHJvaWQgYWxsIGJ1ZmZlcnMgYXJlIGFsbG9jYXRlZCB0aHJv
dWdoIGRtYS1idWYgYWZhaWsuIEJ1dCB0aGVyZQ0KPiAgIHdlJ3ZlIHJlY2VudGx5IGhhZCBzb21l
IGRpc2N1c3Npb25zIGFib3V0IGhvdyBleGFjdGx5IHdlIHNob3VsZCB0cmFjaw0KPiAgIGFsbCB0
aGlzLCBhbmQgdGhlIGNvbmNsdXNpb24gd2FzIHRoYXQgbW9zdCBvZiB0aGlzIHNob3VsZCBiZSBz
b2x2ZWQgYnkNCj4gICBjZ3JvdXBzIGxvbmcgdGVybS4gU28gaWYgdGhpcyBpcyBmb3IgQW5kcm9p
ZCwgdGhlbiBJIGRvbid0IHRoaW5rIGFkZGluZw0KPiAgIHJhbmRvbSBxdWljayBzdG9wLWdhcHMg
dG8gdXBzdHJlYW0gaXMgYSBnb29kIGlkZWEgKGJlY2F1c2UgaXQncyBhIHByZXR0eQ0KPiAgIGxv
bmcgbGlzdCBvZiBwYXRjaGVzIHRoYXQgaGF2ZSBjb21lIHVwIG9uIHRoaXMpLg0KPg0KPiBTbyB3
aGF0IGlzIHRoaXMgZm9yPw0KDQpGb3IgdGhlIG92ZXJ2aWV3LiBkbWEtYnVmIHRvZGF5IG9ubHkg
aGF2ZSBkZWJ1Z2ZzIGZvciBpbmZvLiBEZWJ1Z2ZzDQppcyBub3QgYWxsb3dlZCBieSBnb29nbGUg
dG8gdXNlIGluIGFuZG9pZC4gU28gdGhpcyBhZ2dyZWdhdGUgdGhlIGluZm9ybWF0aW9uDQpzbyB3
ZSBjYW4gZ2V0IGluZm9ybWF0aW9uIG9uIHdoYXQgZ29pbmcgb24gb24gdGhlIHN5c3RlbS7CoA0K
DQpBbmQgdGhlIExLTUwgc3RhbmRhcmQgcmVzcG9uZCB0byB0aGF0IGlzICJTSE9XIE1FIFRIRSBD
T0RFIi4NCg0KV2hlbiB0aGUgdG9wIG1lbWdjIGhhcyBhIGFnZ3JlZ2F0ZWQgaW5mb3JtYXRpb24g
b24gZG1hLWJ1ZiBpdCBpcyBtYXliZQ0KYSBiZXR0ZXIgc291cmNlIHRvIG1lbWluZm8uIEJ1dCB0
aGVuIGl0IGFsc28gaW1wbHkgdGhhdCBkbWEtYnVmIHJlcXVpcmVzIG1lbWNnLg0KDQpBbmQgSSBk
b250IHNlZSBhbnkgcHJvYmxlbSB0byByZXBsYWNlIHRoaXMgd2l0aCBzb21ldGhpbmcgYmV0dGVy
IHdpdGggaXQgaXMgcmVhZHkuDQoNCj4gLURhbmllbA0KPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9k
bWEtYnVmL2RtYS1idWYuYyB8IDEyICsrKysrKysrKysrKw0KPj4gIGZzL3Byb2MvbWVtaW5mby5j
ICAgICAgICAgfCAgNSArKysrLQ0KPj4gIGluY2x1ZGUvbGludXgvZG1hLWJ1Zi5oICAgfCAgMSAr
DQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgYi9kcml2ZXJzL2Rt
YS1idWYvZG1hLWJ1Zi5jDQo+PiBpbmRleCBmMjY0YjcwYzM4M2UuLjRkYzM3Y2Q0MjkzYiAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMNCj4+ICsrKyBiL2RyaXZlcnMv
ZG1hLWJ1Zi9kbWEtYnVmLmMNCj4+IEBAIC0zNyw2ICszNyw3IEBAIHN0cnVjdCBkbWFfYnVmX2xp
c3Qgew0KPj4gIH07DQo+PiAgDQo+PiAgc3RhdGljIHN0cnVjdCBkbWFfYnVmX2xpc3QgZGJfbGlz
dDsNCj4+ICtzdGF0aWMgYXRvbWljX2xvbmdfdCBkbWFfYnVmX2dsb2JhbF9hbGxvY2F0ZWQ7DQo+
PiAgDQo+PiAgc3RhdGljIGNoYXIgKmRtYWJ1ZmZzX2RuYW1lKHN0cnVjdCBkZW50cnkgKmRlbnRy
eSwgY2hhciAqYnVmZmVyLCBpbnQgYnVmbGVuKQ0KPj4gIHsNCj4+IEBAIC03OSw2ICs4MCw3IEBA
IHN0YXRpYyB2b2lkIGRtYV9idWZfcmVsZWFzZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+PiAg
CWlmIChkbWFidWYtPnJlc3YgPT0gKHN0cnVjdCBkbWFfcmVzdiAqKSZkbWFidWZbMV0pDQo+PiAg
CQlkbWFfcmVzdl9maW5pKGRtYWJ1Zi0+cmVzdik7DQo+PiAgDQo+PiArCWF0b21pY19sb25nX3N1
YihkbWFidWYtPnNpemUsICZkbWFfYnVmX2dsb2JhbF9hbGxvY2F0ZWQpOw0KPj4gIAltb2R1bGVf
cHV0KGRtYWJ1Zi0+b3duZXIpOw0KPj4gIAlrZnJlZShkbWFidWYtPm5hbWUpOw0KPj4gIAlrZnJl
ZShkbWFidWYpOw0KPj4gQEAgLTU4Niw2ICs1ODgsNyBAQCBzdHJ1Y3QgZG1hX2J1ZiAqZG1hX2J1
Zl9leHBvcnQoY29uc3Qgc3RydWN0IGRtYV9idWZfZXhwb3J0X2luZm8gKmV4cF9pbmZvKQ0KPj4g
IAltdXRleF9sb2NrKCZkYl9saXN0LmxvY2spOw0KPj4gIAlsaXN0X2FkZCgmZG1hYnVmLT5saXN0
X25vZGUsICZkYl9saXN0LmhlYWQpOw0KPj4gIAltdXRleF91bmxvY2soJmRiX2xpc3QubG9jayk7
DQo+PiArCWF0b21pY19sb25nX2FkZChkbWFidWYtPnNpemUsICZkbWFfYnVmX2dsb2JhbF9hbGxv
Y2F0ZWQpOw0KPj4gIA0KPj4gIAlyZXR1cm4gZG1hYnVmOw0KPj4gIA0KPj4gQEAgLTEzNDYsNiAr
MTM0OSwxNSBAQCB2b2lkIGRtYV9idWZfdnVubWFwKHN0cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0
cnVjdCBkbWFfYnVmX21hcCAqbWFwKQ0KPj4gIH0NCj4+ICBFWFBPUlRfU1lNQk9MX0dQTChkbWFf
YnVmX3Z1bm1hcCk7DQo+PiAgDQo+PiArLyoqDQo+PiArICogZG1hX2J1Zl9hbGxvY2F0ZWRfcGFn
ZXMgLSBSZXR1cm4gdGhlIHVzZWQgbnIgb2YgcGFnZXMNCj4+ICsgKiBhbGxvY2F0ZWQgZm9yIGRt
YS1idWYNCj4+ICsgKi8NCj4+ICtsb25nIGRtYV9idWZfYWxsb2NhdGVkX3BhZ2VzKHZvaWQpDQo+
PiArew0KPj4gKwlyZXR1cm4gYXRvbWljX2xvbmdfcmVhZCgmZG1hX2J1Zl9nbG9iYWxfYWxsb2Nh
dGVkKSA+PiBQQUdFX1NISUZUOw0KPj4gK30NCj4+ICsNCj4+ICAjaWZkZWYgQ09ORklHX0RFQlVH
X0ZTDQo+PiAgc3RhdGljIGludCBkbWFfYnVmX2RlYnVnX3Nob3coc3RydWN0IHNlcV9maWxlICpz
LCB2b2lkICp1bnVzZWQpDQo+PiAgew0KPj4gZGlmZiAtLWdpdCBhL2ZzL3Byb2MvbWVtaW5mby5j
IGIvZnMvcHJvYy9tZW1pbmZvLmMNCj4+IGluZGV4IDZmYTc2MWM5Y2M3OC4uY2NjN2M0MGM4ZGI3
IDEwMDY0NA0KPj4gLS0tIGEvZnMvcHJvYy9tZW1pbmZvLmMNCj4+ICsrKyBiL2ZzL3Byb2MvbWVt
aW5mby5jDQo+PiBAQCAtMTYsNiArMTYsNyBAQA0KPj4gICNpZmRlZiBDT05GSUdfQ01BDQo+PiAg
I2luY2x1ZGUgPGxpbnV4L2NtYS5oPg0KPj4gICNlbmRpZg0KPj4gKyNpbmNsdWRlIDxsaW51eC9k
bWEtYnVmLmg+DQo+PiAgI2luY2x1ZGUgPGFzbS9wYWdlLmg+DQo+PiAgI2luY2x1ZGUgImludGVy
bmFsLmgiDQo+PiAgDQo+PiBAQCAtMTQ1LDcgKzE0Niw5IEBAIHN0YXRpYyBpbnQgbWVtaW5mb19w
cm9jX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KQ0KPj4gIAlzaG93X3ZhbF9rYiht
LCAiQ21hRnJlZTogICAgICAgICIsDQo+PiAgCQkgICAgZ2xvYmFsX3pvbmVfcGFnZV9zdGF0ZShO
Ul9GUkVFX0NNQV9QQUdFUykpOw0KPj4gICNlbmRpZg0KPj4gLQ0KPj4gKyNpZmRlZiBDT05GSUdf
RE1BX1NIQVJFRF9CVUZGRVINCj4+ICsJc2hvd192YWxfa2IobSwgIkRtYUJ1ZlRvdGFsOiAgICAi
LCBkbWFfYnVmX2FsbG9jYXRlZF9wYWdlcygpKTsNCj4+ICsjZW5kaWYNCj4+ICAJaHVnZXRsYl9y
ZXBvcnRfbWVtaW5mbyhtKTsNCj4+ICANCj4+ICAJYXJjaF9yZXBvcnRfbWVtaW5mbyhtKTsNCj4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaCBiL2luY2x1ZGUvbGludXgvZG1h
LWJ1Zi5oDQo+PiBpbmRleCBlZmRjNTZiOWQ5NWYuLjViMDU4MTZiZDJjZCAxMDA2NDQNCj4+IC0t
LSBhL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2RtYS1i
dWYuaA0KPj4gQEAgLTUwNyw0ICs1MDcsNSBAQCBpbnQgZG1hX2J1Zl9tbWFwKHN0cnVjdCBkbWFf
YnVmICosIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqLA0KPj4gIAkJIHVuc2lnbmVkIGxvbmcpOw0K
Pj4gIGludCBkbWFfYnVmX3ZtYXAoc3RydWN0IGRtYV9idWYgKmRtYWJ1Ziwgc3RydWN0IGRtYV9i
dWZfbWFwICptYXApOw0KPj4gIHZvaWQgZG1hX2J1Zl92dW5tYXAoc3RydWN0IGRtYV9idWYgKmRt
YWJ1Ziwgc3RydWN0IGRtYV9idWZfbWFwICptYXApOw0KPj4gK2xvbmcgZG1hX2J1Zl9hbGxvY2F0
ZWRfcGFnZXModm9pZCk7DQo+PiAgI2VuZGlmIC8qIF9fRE1BX0JVRl9IX18gKi8NCj4+IC0tIA0K
Pj4gMi4xNy4xDQo+Pg0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QNCj4+IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbF9fOyEhSm1vWmla
R0J2M1J2S1JTeCFxVzhrVU9aeVk0RGtldzZPdnFnZm9NLTV1blFOVmVGX00xYmlhSUF5UVFCUjBL
Qjdrc1J6WmpvaDM4MlpkR0dRUjlrJCANCg0K
