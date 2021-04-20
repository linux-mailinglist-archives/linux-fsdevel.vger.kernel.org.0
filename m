Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C543636584E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhDTMEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 08:04:21 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:58822 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231840AbhDTMET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:04:19 -0400
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KC08OP013828;
        Tue, 20 Apr 2021 12:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=C1SYnUpFun4yx1g2FKyMssv8lZ628Jyx2UbKcD9MdGI=;
 b=gluS5fJosCRL60kezAvLbCfu7qd6Vwn+VwjFXfmthVjLPRAUbpHhjGchKpPUv8T2YmqE
 kCHDjw+fgog/TMTg5kq403mV4RIqbDHXT2l923QiSopkjD3+pCHtBEQv3izHpatFBOpe
 sFyMPxXkrFMguy9aOIfgOQQx+WA/qha2HeUJ6qTN9kgou9kWfrZ5wDZZyKN5vg5tnavU
 DUUsPPvi/Hf1IdBmk0hrGozCRiYHadV89SnD4SPemJLpBoK1KtROOcREnoFVoYMwgzTh
 TYgefhepmIwypiXtHPZ1KKcjLnck0+lTdoUuIMRCfWl5gTktxUiLMu9UvJMu2EyCewqr LQ== 
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52])
        by mx08-001d1705.pphosted.com with ESMTP id 3803w49t0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 12:03:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvAxHaoD0pw8OzL+XsKs8LeSdtfpCS+wHqci/iJ8ImiQrCo4JxFKof/I7o/952++MZU7G4fz/8OrmNG3ZdsqVFv+FUvh1vCS699Daj3bV0uVNqBhoKx/Sv9OCH63aUmRx8XyYBuahUV0ZgU0fYR9vLeVlP9wN0viJxoOqB2D5jEmvTRgvdR8FxicJwWVmF/s4vN8zHXlf1MhrgRCPQfKkkoBn3mEKdHgmGe7iIqYFNgr/dU9cXMh80s090gR6bDrjaxklk24cRY0NWP1hFICh7O7dAdIut04JXT9rHk3t3iACQLuHDLmmOd2tfkJSMrT4SYz0gwcfRR6fTUD42kjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1SYnUpFun4yx1g2FKyMssv8lZ628Jyx2UbKcD9MdGI=;
 b=XoEJUFqp65ZfEw6tE7LSNX1feRfw10UtYwY646Nsf/yBsUPbacbtcqBsJ/w8u/iL1I9bxB2qjEcUkT5bTZQk9Jg9aK+CveHeqkClvW91bH4jiz78UfHLbqO/Je5SsLEQxIxi0kASmkdYuYE0pCs6oBLft6P2MNnJYtVvyzIejKBTcw5nNaNyTXCtRY7XpTVtp2vfGcZda5UqVpWHm9eaNPzo9Z27ro9kRq4pssZeRcYdL9ih9X1gjlaKtHHl/cUBZ0+0oFvq+w166NlRZnhn2SyZsayl8/xbgqGQ1KKkgJ47PJimkgY+pKfD2piPsVYahANjM9KKXYeZGm+51MaBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM8P193MB1028.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 12:03:05 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 12:03:05 +0000
From:   <Peter.Enderborg@sony.com>
To:     <rppt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <songmuchun@bytedance.com>, <guro@fb.com>, <shakeelb@google.com>,
        <mhocko@suse.com>, <neilb@suse.de>, <samitolvanen@google.com>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <willy@infradead.org>
Subject: Re: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Topic: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Index: AQHXM6gnmsuLu+Ufhk6GusLEaztxYKq9H2WAgAAHpACAAARkgIAAEccAgAASvwCAAAL2AA==
Date:   Tue, 20 Apr 2021 12:03:04 +0000
Message-ID: <5603a2cd-c1f3-870e-8c22-d50c0d2a7053@sony.com>
References: <20210417163835.25064-1-peter.enderborg@sony.com>
 <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
 <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com> <YH6h16hviixphaHV@kernel.org>
 <b57a33a3-a5ed-c122-e5b9-c7e7c4dae35f@sony.com> <YH7AeqqNyNnY0Zi3@kernel.org>
In-Reply-To: <YH7AeqqNyNnY0Zi3@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d967c5c-b718-4926-a549-08d903f44130
x-ms-traffictypediagnostic: AM8P193MB1028:
x-microsoft-antispam-prvs: <AM8P193MB1028AC02368D2C74614686A886489@AM8P193MB1028.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixvCISAV9C3Xy67kK346SE9/bwsNDxkkvwqdvvmqTM/338D51pTwYvEDxA4RXs7NbJdQujBegfAiiWAfPn2t5BQXHEaayd9XWZEMdtt0BoBPYvp6o5SQm6DJ6L4Tl3HvkyX6AGMCTg3DIxwZ91BMu1frkWYO03gvGo3+2/bc0H6rq3YeP4ZSeh8Mx4HTfM8RSTmIzoMncnp2f6sA3/yfO/LbFB5RGMsEyuomW9m1Maytg5fGhO1GZKHBy7JldGfZYYnBKFc/KfLe7e8KDq86XsbblU9TFXOjo52Uz+Fx86BMCU2JwO/yxE0uwoq3J6OY3PGrypL0DaQDqQTU1dsLCI12p8Cwpg+1NSzd+UBpsl6hLauCjLlBw7i5RZhM8ZUwrQonCLnVSDtMwU0E9C1aVsVrWVw67CE/q+yTUVv9LC5wXMWR2M6mBhxcoL8E8gxRggibQ6Mu1LMj0hBZ1f5blx6+4vLw7GUd/8+gsQS0seZX9Bsp0JvRbxAiOmLUw6vQWPbRaNkZmpvcixcTdaFAXkg2wpURZHC1czhq87xKKQA+tguYZNsWOOi59wKIPgwqwuQj2YS5yGZ3gtbVPjdxZhIk73t4/jDniKa5bssNsq3SI7WkjeUhP36iDG+o37MTXPoVMG7N1CHkVdDzNDYuKcuHBCNJtUqRFebJRy1QHa9nc1tkCOZeyaqp9jJsGhdW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39850400004)(2906002)(86362001)(66446008)(38100700002)(31686004)(8676002)(31696002)(53546011)(66946007)(6486002)(76116006)(6506007)(5660300002)(8936002)(2616005)(316002)(7416002)(91956017)(122000001)(54906003)(478600001)(6512007)(186003)(36756003)(66556008)(26005)(66476007)(71200400001)(6916009)(64756008)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eFFpdjkzWmVqRCtUR0o3WWUwRWVSazRtYnlJK1ZWVy9BSWVjbFFvdWpKY0li?=
 =?utf-8?B?WVpCUE5CYzlZNjQ5M0ZoT0NOWm9hQWZKdmlWMkxtcUkyRUtJblVkVlcvSmxH?=
 =?utf-8?B?d2kyRnJ1bzNXQytiZmUvZmJJN29FSHZHNlVYZDNCaWQ3VVpLUXlTajJXMlk4?=
 =?utf-8?B?NlJnTUdMT1RxWTgycVBjRGVEZ0pUalBVQm0yaERVYVRTSGxWYWdOSUZaRERD?=
 =?utf-8?B?WUlOQTRlWUpIT0l0WEZTMmVjVVZCcW5LdVFnYUUrSDQ0VDE0NVRLZ1BqeU1U?=
 =?utf-8?B?SHZQemJtdHd4MGozRW9EdEVzMWpDNFZhWVVGbzJOdnpMNXpzVmtTOTB4NDY0?=
 =?utf-8?B?a2xscElLaUlMOHVDOHhjRGUrVXBZcklWTWFUNmMwTnNEY2MyYjJKNGY0ZDRt?=
 =?utf-8?B?a2hTQUNOYlF3cDlvbmp0cEl2Q0ZXOVp3K1ZMd2NuWDVuYjJUWmRoalVsYkxh?=
 =?utf-8?B?YTBvOCtSNng5Tm8xMG9OTHZQUUcyK1pnOHd5VG82eU1NQWFEV05PLzYraEJi?=
 =?utf-8?B?QU9KVTFieHNJNk5ERFdMTjdOV0JDTUlsMUpuMFg4ZkZTV3BZWFRaSXdoRU1x?=
 =?utf-8?B?OEFwdjJYenBUR3BQYlZjeVVTbmhPVDFtbnlaT0ZNYVpxQjVwRm9XRU90YTV1?=
 =?utf-8?B?THRYb2N5cmo5UEN5alVUZExoRnc2Y1JFZjYyUW9hUVJTaEVmZjE4cGxRNmVL?=
 =?utf-8?B?UlgzZDVtck9sREtuQW5CejArSVQxRlpSOUhWZ1JCZlZJaTM0K1kvclNkcXV6?=
 =?utf-8?B?WUwySzlkRTg2enZLY1ZNcXhKSTRJdk1kYlJrOXhGTXpmQXZTVi81ODA1bzhp?=
 =?utf-8?B?T3c3WWVFL3FoQTkxUmxHN3hia1ExSkowS0tlaExjM3EwajkwQ2d4a3FDNlFB?=
 =?utf-8?B?SjVYb1kwVUVsbm5rUVJsaGo2YmZOdzh4bEM1d1BBRCt4a3U4UXVTZzNsNEE5?=
 =?utf-8?B?aGcvNHpUYmNJam9ia1JxZDR2RGFIR1ZmRmI5MTdBYW00Q3Y0RmJyOXBYSkV6?=
 =?utf-8?B?dmVjakZKelRnUzlVN0RPWGdubVZhT01VOVYrdFF6VDJIdkdSZDBsM0ZEc1ov?=
 =?utf-8?B?OWJEb0Fuc0oxTkhWNm83bXVpdHJudEVnTm5uY1RsVXFGTENFTWxTZGxrbDlC?=
 =?utf-8?B?bVc5R2l3Z1l6UEhBQzhyck85dERZSk5PaW52blE3YlpUSndhQ00xL2hpSStU?=
 =?utf-8?B?WHcvY0hDZkxvckg0bW10aHdpMk14VFZBSTUvM05aUEVuVE4xaDI4aDNmcG1M?=
 =?utf-8?B?dlpQdUJqZWlEMDZLSjNxYWdVRWNNYnpnbVlCTTJSQ0Q1dUREQzN3VllCZThz?=
 =?utf-8?B?ZkVBempxeEdJZHVUZnpWb0Y1bkU4UmRtUC9kWGFIVUlmQWVXT2FrNXBoVmZD?=
 =?utf-8?B?MWFRcldIMEFVdHluM09zbVBKWjdFMndZU21sM1JhaWd5OWgxRmJsaFQ1dkor?=
 =?utf-8?B?VDVKVmQreHNPY0xVUHpISWFVaEtqcUZWd1Y5dEM4d0J0N3ZsVlpKKytWc3Bw?=
 =?utf-8?B?Yy84MUhvbFZ4cEZBQUMzVG9uSEJiNXdNUFY1bnNCeHordDN4dmVGZW1IaUx5?=
 =?utf-8?B?Wmt1YThDNW80bUNqVVJsaEJKRzFkWmxNdVF0T3BDYXZYdyt0MVVOUXJadk9r?=
 =?utf-8?B?eTZweVkrWjdtcXlMR2xFUldLLzRIOFhIVVlzUnEydWZLVnQ1YXpMTEU4MVpw?=
 =?utf-8?B?SXMycHhPYjlLZU1vanBtVkZwZSs4S1IwR0xmV3FOOEVXeEdCU3IvZittb3F3?=
 =?utf-8?Q?dxcOOVL0QxJMQFBkByR7jEcFgO7Lk/ajReFaEXp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <793AA08F35B9824AB134B5D21B2BD138@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d967c5c-b718-4926-a549-08d903f44130
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 12:03:04.8862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9fVitRQu6OjVVrDjjs1bBV5JcB4ON6jay3szuCVApcHacWO9Q0DebvgxWLVyuFr09cle8/g4Va2ULAxtkvKWQlJlR4X4RzZqC085ngc5Ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1028
X-Proofpoint-GUID: j2X3GopqUAEdr_TXlsA5deUz3RHp1iDW
X-Proofpoint-ORIG-GUID: j2X3GopqUAEdr_TXlsA5deUz3RHp1iDW
X-Sony-Outbound-GUID: j2X3GopqUAEdr_TXlsA5deUz3RHp1iDW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_06:2021-04-19,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200093
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMC8yMSAxOjUyIFBNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBPbiBUdWUsIEFwciAy
MCwgMjAyMSBhdCAxMDo0NToyMUFNICswMDAwLCBQZXRlci5FbmRlcmJvcmdAc29ueS5jb20gd3Jv
dGU6DQo+PiBPbiA0LzIwLzIxIDExOjQxIEFNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPj4+IEhl
bGxvIFBldGVyLA0KPj4+DQo+Pj4gT24gVHVlLCBBcHIgMjAsIDIwMjEgYXQgMDk6MjY6MDBBTSAr
MDAwMCwgUGV0ZXIuRW5kZXJib3JnQHNvbnkuY29tIHdyb3RlOg0KPj4+PiBPbiA0LzIwLzIxIDEw
OjU4IEFNLCBEYW5pZWwgVmV0dGVyIHdyb3RlOg0KPj4+Pj4gT24gU2F0LCBBcHIgMTcsIDIwMjEg
YXQgMDY6Mzg6MzVQTSArMDIwMCwgUGV0ZXIgRW5kZXJib3JnIHdyb3RlOg0KPj4+Pj4+IFRoaXMg
YWRkcyBhIHRvdGFsIHVzZWQgZG1hLWJ1ZiBtZW1vcnkuIERldGFpbHMNCj4+Pj4+PiBjYW4gYmUg
Zm91bmQgaW4gZGVidWdmcywgaG93ZXZlciBpdCBpcyBub3QgZm9yIGV2ZXJ5b25lDQo+Pj4+Pj4g
YW5kIG5vdCBhbHdheXMgYXZhaWxhYmxlLiBkbWEtYnVmIGFyZSBpbmRpcmVjdCBhbGxvY2F0ZWQg
YnkNCj4+Pj4+PiB1c2Vyc3BhY2UuIFNvIHdpdGggdGhpcyB2YWx1ZSB3ZSBjYW4gbW9uaXRvciBh
bmQgZGV0ZWN0DQo+Pj4+Pj4gdXNlcnNwYWNlIGFwcGxpY2F0aW9ucyB0aGF0IGhhdmUgcHJvYmxl
bXMuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBFbmRlcmJvcmcgPHBldGVy
LmVuZGVyYm9yZ0Bzb255LmNvbT4NCj4+Pj4+IFNvIHRoZXJlIGhhdmUgYmVlbiB0b25zIG9mIGRp
c2N1c3Npb25zIGFyb3VuZCBob3cgdG8gdHJhY2sgZG1hLWJ1ZiBhbmQNCj4+Pj4+IHdoeSwgYW5k
IEkgcmVhbGx5IG5lZWQgdG8gdW5kZXJzdGFuZCB0aGUgdXNlLWNhc3MgaGVyZSBmaXJzdCBJIHRo
aW5rLiBwcm9jDQo+Pj4+PiB1YXBpIGlzIGFzIG11Y2ggZm9yZXZlciBhcyBhbnl0aGluZyBlbHNl
LCBhbmQgZGVwZW5kaW5nIHdoYXQgeW91J3JlIGRvaW5nDQo+Pj4+PiB0aGlzIGRvZXNuJ3QgbWFr
ZSBhbnkgc2Vuc2UgYXQgYWxsOg0KPj4+Pj4NCj4+Pj4+IC0gb24gbW9zdCBsaW51eCBzeXN0ZW1z
IGRtYS1idWYgYXJlIG9ubHkgaW5zdGFudGlhdGVkIGZvciBzaGFyZWQgYnVmZmVyLg0KPj4+Pj4g
ICBTbyB0aGVyZSB0aGlzIGdpdmVzIHlvdSBhIGZhaXJseSBtZWFuaW5nbGVzcyBudW1iZXIgYW5k
IG5vdCBhbnl0aGluZw0KPj4+Pj4gICByZWZsZWN0aW5nIGdwdSBtZW1vcnkgdXNhZ2UgYXQgYWxs
Lg0KPj4+Pj4NCj4+Pj4+IC0gb24gQW5kcm9pZCBhbGwgYnVmZmVycyBhcmUgYWxsb2NhdGVkIHRo
cm91Z2ggZG1hLWJ1ZiBhZmFpay4gQnV0IHRoZXJlDQo+Pj4+PiAgIHdlJ3ZlIHJlY2VudGx5IGhh
ZCBzb21lIGRpc2N1c3Npb25zIGFib3V0IGhvdyBleGFjdGx5IHdlIHNob3VsZCB0cmFjaw0KPj4+
Pj4gICBhbGwgdGhpcywgYW5kIHRoZSBjb25jbHVzaW9uIHdhcyB0aGF0IG1vc3Qgb2YgdGhpcyBz
aG91bGQgYmUgc29sdmVkIGJ5DQo+Pj4+PiAgIGNncm91cHMgbG9uZyB0ZXJtLiBTbyBpZiB0aGlz
IGlzIGZvciBBbmRyb2lkLCB0aGVuIEkgZG9uJ3QgdGhpbmsgYWRkaW5nDQo+Pj4+PiAgIHJhbmRv
bSBxdWljayBzdG9wLWdhcHMgdG8gdXBzdHJlYW0gaXMgYSBnb29kIGlkZWEgKGJlY2F1c2UgaXQn
cyBhIHByZXR0eQ0KPj4+Pj4gICBsb25nIGxpc3Qgb2YgcGF0Y2hlcyB0aGF0IGhhdmUgY29tZSB1
cCBvbiB0aGlzKS4NCj4+Pj4+DQo+Pj4+PiBTbyB3aGF0IGlzIHRoaXMgZm9yPw0KPj4+PiBGb3Ig
dGhlIG92ZXJ2aWV3LiBkbWEtYnVmIHRvZGF5IG9ubHkgaGF2ZSBkZWJ1Z2ZzIGZvciBpbmZvLiBE
ZWJ1Z2ZzDQo+Pj4+IGlzIG5vdCBhbGxvd2VkIGJ5IGdvb2dsZSB0byB1c2UgaW4gYW5kb2lkLiBT
byB0aGlzIGFnZ3JlZ2F0ZSB0aGUgaW5mb3JtYXRpb24NCj4+Pj4gc28gd2UgY2FuIGdldCBpbmZv
cm1hdGlvbiBvbiB3aGF0IGdvaW5nIG9uIG9uIHRoZSBzeXN0ZW0uwqANCj4+PiAgDQo+Pj4gQ2Fu
IHlvdSBzZW5kIGFuIGV4YW1wbGUgZGVidWdmcyBvdXRwdXQgdG8gc2VlIHdoYXQgZGF0YSBhcmUg
d2UgdGFsa2luZw0KPj4+IGFib3V0Pw0KPj4gU3VyZS4gVGhpcyBpcyBvbiBhIGlkbGUgc3lzdGVt
LiBJbSBub3Qgc3VyZSB3aHkgeW91IG5lZWQgaXQuVGhlIHByb2JsZW0gaXMgcGFydGx5IHRoYXQg
ZGVidWdmcyBpcw0KPj4gbm90IGFjY2Vzc2FibGUgb24gYSBjb21tZXJjaWFsIGRldmljZS4NCj4g
SSB3YW50ZWQgdG8gc2VlIHdoYXQga2luZCBvZiBpbmZvcm1hdGlvbiBpcyB0aGVyZSwgYnV0IEkg
ZGlkbid0IHRoaW5rIGl0J3MNCj4gdGhhdCBsb25nIDopDQpTb3JyeSwgYnV0IGl0IHdhcyBtYWtp
bmcgYSBwb2ludC4NCj4gIA0KPj4gRG1hLWJ1ZiBPYmplY3RzOg0KPj4gc2l6ZcKgwqDCoCDCoMKg
wqAgZmxhZ3PCoMKgIMKgwqDCoCBtb2RlwqDCoMKgIMKgwqDCoCBjb3VudMKgwqAgwqDCoMKgIGV4
cF9uYW1lwqDCoMKgIMKgwqDCoCBidWYgbmFtZcKgwqDCoCBpbm/CoMKgwqDCoA0KPj4gMDAwMzI3
NjjCoMKgwqAgMDAwMDAwMDLCoMKgwqAgMDAwODAwMDfCoMKgwqAgMDAwMDAwMDLCoMKgwqAgaW9u
LXN5c3RlbS0xMDA2LWFsbG9jYXRvci1zZXJ2acKgwqDCoCBkbWFidWYxNzcyOMKgwqDCoCAwNzQw
MDgyNcKgwqDCoCBkbWFidWYxNzcyOA0KPj4gwqDCoMKgIEF0dGFjaGVkIERldmljZXM6DQo+PiBU
b3RhbCAwIGRldmljZXMgYXR0YWNoZWQNCj4+DQo+PiAxMTA4Mzc3NsKgwqDCoCAwMDAwMDAwMsKg
wqDCoCAwMDA4MDAwN8KgwqDCoCAwMDAwMDAwM8KgwqDCoCBpb24tc3lzdGVtLTEwMDYtYWxsb2Nh
dG9yLXNlcnZpwqDCoMKgIGRtYWJ1ZjE3NzI3wqDCoMKgIDA3NDAwODI0wqDCoMKgIGRtYWJ1ZjE3
NzI3DQo+PiDCoMKgwqAgQXR0YWNoZWQgRGV2aWNlczoNCj4+IMKgwqDCoCBhZTAwMDAwLnFjb20s
bWRzc19tZHA6cWNvbSxzbW11X3NkZV91bnNlY19jYg0KPj4gVG90YWwgMSBkZXZpY2VzIGF0dGFj
aGVkDQo+Pg0KPj4gMDAwMzI3NjjCoMKgwqAgMDAwMDAwMDLCoMKgwqAgMDAwODAwMDfCoMKgwqAg
MDAwMDAwMDLCoMKgwqAgaW9uLXN5c3RlbS0xMDA2LWFsbG9jYXRvci1zZXJ2acKgwqDCoCBkbWFi
dWYxNzcyNsKgwqDCoCAwNzQwMDgyM8KgwqDCoCBkbWFidWYxNzcyNg0KPj4gwqDCoMKgIEF0dGFj
aGVkIERldmljZXM6DQo+PiBUb3RhbCAwIGRldmljZXMgYXR0YWNoZWQNCj4+DQo+PiAxMTA4Mzc3
NsKgwqDCoCAwMDAwMDAwMsKgwqDCoCAwMDA4MDAwN8KgwqDCoCAwMDAwMDAwMsKgwqDCoCBpb24t
c3lzdGVtLTEwMDYtYWxsb2NhdG9yLXNlcnZpwqDCoMKgIGRtYWJ1ZjE3NzI1wqDCoMKgIDA3NDAw
ODIywqDCoMKgIGRtYWJ1ZjE3NzI1DQo+PiDCoMKgwqAgQXR0YWNoZWQgRGV2aWNlczoNCj4+IMKg
wqDCoCBhZTAwMDAwLnFjb20sbWRzc19tZHA6cWNvbSxzbW11X3NkZV91bnNlY19jYg0KPj4gVG90
YWwgMSBkZXZpY2VzIGF0dGFjaGVkDQo+IC4uLg0KPg0KPj4gVG90YWwgNjU0IG9iamVjdHMsIDc0
NDE0NDg5NiBieXRlcw0KPiAgDQo+IElzbid0IHRoZSBzaXplIGZyb20gdGhlIGZpcnN0IGNvbHVt
biBhbHNvIGF2YWlsYWJsZSBpbiBmZGluZm8/DQo+DQo+IElzIHRoZXJlIGFueXRoaW5nIHRoYXQg
cHJldmVudHMgbW9uaXRvcmluZyB0aG9zZT8NCj4NClllcywgc2VsaW51eC4NCg==
