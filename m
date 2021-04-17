Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E6436306B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 15:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhDQNpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 09:45:34 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:35466 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230442AbhDQNpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 09:45:33 -0400
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13HDa5ut028883;
        Sat, 17 Apr 2021 13:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=FIYgSnmAVjYQO0YZCpmFSZbA+N33lXiBD8dve9NOCE8=;
 b=Pm7n6qXbW7j0u1ZqIX4qq/czfifRbAn6okdpoflAB3gQ526bVUgideYHRtX20kByi44h
 +Kx6LO3HpTlcvj0povsPdWjFPfUYiHqhMyW9exZ95VB53pYc1Ubrhy4gj4dtRXPi8xCn
 rYeDQdMUxm6InQEs1ebZ7a0VAopBuKanTbLkcN3umjM7O2hIbLWpy+teVPmBniHuY25r
 gq4Byh2Y1AZ4g1J3P5/vxS+279t/f6xOR618tXLoUauj3snRauRg4FQdsVXl1/HJ2C46
 eeBp0dZoLeenEz9IA5Aga5UAW71WCaLFxccDJdy3CKTnTb3fY/1prsc5nDxci7oQyFnF IQ== 
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51])
        by mx08-001d1705.pphosted.com with ESMTP id 37ynvkr6w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 13:44:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcMkkYpO8iEmUtTawBHz+qgqOOkstO2Exjst5dOT0C0IzMCWN/wZuVDq6Y4y1ciuHMNZ+qHVVTfK8kPIBC8msVrQP68sFofYrJaVprg9DxRhXce6DRU9/0c6C1XcpL4qpS/NjM0E84Xcw8MVirWYfq++ZxrAkYMZjVcdKh0HDrXTeZymPF47RQMQeKV28/rMCIPs8q9mlilVA5WpCTof8FooI5kXQd3DGGRJ4AgGiiHkbKegbEFKpZMhnvGu6ao9bXFD9PBT+Pv5Vs4lGqy7bsJZ99wXg8iy5FUz0dTEIsiqlXO24wNO8ApgWPB6tltEchYN97Bf3sNUI9Cv1+xfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIYgSnmAVjYQO0YZCpmFSZbA+N33lXiBD8dve9NOCE8=;
 b=i4pbw8Kufqw3u30I64ziZ1imQpJ5FA1SssJKkLmsNjykL1PnLhX22SOWa6HxVDwaYTj6ybqPcMo54uhdyYF4AkOLD0YMVjZuzHv7T8UWo+osy3yCioEcC+hULRGhZAABAr/QkKPa3chblrJON9T7bG2JtJgDD/irgyChM/vKcBxHstDM3aM+dSg7ACjthRAwIhAuE8Cx2ScHK5rXtJwT1q7ZxidotiLZGR2fzEsj5sUklKL3QNXw6lUumO/SjFV+6g7FsxFmCkw46Xcd41CbqyBiSRd/U5wP2MF++FwZXuVrd757uo+eqi9KrXVqdrZwBNrONAsmP4d04mbPhVKCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM0P193MB0578.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:166::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Sat, 17 Apr
 2021 13:43:58 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4042.021; Sat, 17 Apr 2021
 13:43:58 +0000
From:   <Peter.Enderborg@sony.com>
To:     <songmuchun@bytedance.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <guro@fb.com>,
        <shakeelb@google.com>, <mhocko@suse.com>, <neilb@suse.de>,
        <samitolvanen@google.com>, <rppt@kernel.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <willy@infradead.org>
Subject: Re: [External] [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Topic: [External] [PATCH v4] dma-buf: Add DmaBufTotal counter in
 meminfo
Thread-Index: AQHXM3Yw6ll+UCWErEeaPUdSTn+rzaq4rmwAgAAKFYA=
Date:   Sat, 17 Apr 2021 13:43:58 +0000
Message-ID: <ac32baa5-94a5-bf7b-661e-aca66c0850bc@sony.com>
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <CAMZfGtWZwXemox5peP738v2awsHxABcpYeqccPunLCZzRXynBQ@mail.gmail.com>
In-Reply-To: <CAMZfGtWZwXemox5peP738v2awsHxABcpYeqccPunLCZzRXynBQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d3df87c-1106-4dea-28c4-08d901a6da0f
x-ms-traffictypediagnostic: AM0P193MB0578:
x-microsoft-antispam-prvs: <AM0P193MB057817756DADD468E71E2533864B9@AM0P193MB0578.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BUbVEqZ3V1mo5MZCdT32Y226PSKK28/NR0XE9sKemDNS+yOuwuXSq77bHlPRuyf46YKfMx52wG+OZZ+98LhL8ZueyPm00mv9kVR3Atw4cFNA9eUoBJZKJrO6rzDBY+gxRkp8Eou1JzhuDH1JejDFj5yjfVNgbvckLparxHw+sWOcAyHZ+Zc3DCssqx3DbzZNGakkwHchMrAokdP4TD3c9bRywrG5ppuBFWVOBfeGmgZVE4ZKjfW0twrLlJ3DjHH3eMPzWXcIDI5GMvmpFqxaAnxngeTrxJlv1tTIK8lTGMLjeId57Uul6BGZq/omNL+2EGZ1IvsYjDO9C1rGgmlSD6V/z4/EjQZpwPYhvCuHWfwmITdBDuM1cE3neMnym53rXRskOOrnQjXsZAKl2kQmzR/IHGziQKovmkVqtvc0AAJ+Nudr+K3/GsOKe05Ht2tIaHlbDE1PHub0LRP1lueYm/urxvXyjVtFzVl/Zzh6VBhmJyi8glRYbIhV8fLGuKIMKbRds6XpYCYIT4ceAue+R28fF4upiEMAui3iXuLUDh/y80oSlT6yPOOWzsIJLvxrWN90xITtGe7Tr4F1NGSpAsavxLbBPNAUZoLDiquX77FoP4WXpsadzeEoCpFb+DRpbFTg4Eu8e1+YhCI3EwSjpBjMj4Hp8kdrUJn6i14ewgSxUH36u5kVs0P/g6gnwRf4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39840400004)(396003)(6916009)(8676002)(6506007)(53546011)(478600001)(5660300002)(2616005)(83380400001)(6486002)(66556008)(8936002)(31686004)(36756003)(7416002)(4326008)(54906003)(71200400001)(2906002)(76116006)(186003)(316002)(66946007)(38100700002)(31696002)(66446008)(66476007)(64756008)(86362001)(6512007)(26005)(91956017)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V2QwQ0pJSjkvK0JBeHB3QUQ4Q1M3N0JQQlZQY2dDOWxLV1Zub1ZBMnRPYVFY?=
 =?utf-8?B?NnU5THNMSGNYeU9hQ2NadkdROTFhQmd3R3JUQk9INy81RnVNcHJFQ0dUTzRN?=
 =?utf-8?B?L2djVzRjT0ZlQ25rZFJvUWxSMjg5MW1qd1dpcWI0MkxCbXFRWjZYNkRwNTRI?=
 =?utf-8?B?cE1pWTd1dFNPZ201UXQ2R1B2SGpLNGpNWmk0VlVKUDV0bTFHdk5NMDcreFY1?=
 =?utf-8?B?dlNBSkozV25PK0h3bU1jbkdSbkhlNVJKRldxbDB1eEJRczA3Ky9GOVE4eEVX?=
 =?utf-8?B?WEJqN25xaGlqRW1oOUpZcDVkRDdaa2E1R0lGMmlldDQ3MERMYURmWFFSeWJK?=
 =?utf-8?B?UnN0dWVwQ21lS1JyWWM2SDV0SjJsQkJGWFo4S0lPYUIvekV5Yll2NW9HWUhh?=
 =?utf-8?B?K00rQ1M4Qks1Q2V2U3F3Z21sQUdOOFAzSjBoNUJoQ0UzSnBOOFR2TnpsNTVB?=
 =?utf-8?B?Q29DanRISXNwQVpSVXB3SEE0UjBMTnppR3paQTRrYTNNSyt2SnRWVms1a3Rv?=
 =?utf-8?B?QWpRMWhvM3F4SkY1SFNJdTNndStDc1FrOTF0MjJVR3FxNTVFYnBVbUlnQWor?=
 =?utf-8?B?QVRiN2lHK3RTN29JdXhvS0hGVmVtblNjNUMrNjdXNW53TjNsMDBDanQzdTYy?=
 =?utf-8?B?aEs4bFdEYUNVaUdKQmJiVk5sdHhaSFkvZkVPVkFSekdlY282THVySThUREpF?=
 =?utf-8?B?REQvTjJJOU83TGR1K1NoakF4R043aEcyMk1rdGlObzhQQ0pjZTJ4Vld1MEcw?=
 =?utf-8?B?NWQzUkNPTXJ5UVRyb3d5VlNiRmFWalR6NzlzVW1ZV2wyRUJuM2JUOHV4UDRI?=
 =?utf-8?B?cVZwdWF1Y0FleEVUb2JXUGd1Y2xJOEZCcjd3UmI5RmlabFl3UERvcWpQRERG?=
 =?utf-8?B?NmJBTzU5THc0L2wyMnZMa3BlN1l1N1JaNEpzV1ZLRGxHZzNXVDUzN1A1cXBz?=
 =?utf-8?B?TktyenVnVk5GNWRkbVNJT2o3ZndxTnoydkhBeHdlRHVWeGo4aFYwVlRkQzVZ?=
 =?utf-8?B?SkU4VkRlQXUxVndWUWpEdVF5amtTaGE0bi9wdlYzdkxiVzhkd2xRcmJvZFhN?=
 =?utf-8?B?VFcydUt3Sm9yRnArNTlOSWlvK1dNenZzYVlQZTJGakRTTWFwOG56VUxDMEdq?=
 =?utf-8?B?RkViUGQzVU13UTNBYytiWmxUcEpLZlRRYml3VSt0VkoyTklqTWRZTjVpa1oz?=
 =?utf-8?B?bjZjRGxWaEYzdE12QXZuYnBsMTgwTStXRy93eCtEZlcwclZycUFGSWdwZnVi?=
 =?utf-8?B?M01BY3J6QnJxTFVsLzEzRXQxVXFJOFdTL0NuSWNpaGxJdDByQ2xIQ0QxZS9R?=
 =?utf-8?B?Z0VsMnlYTllWNi83MjhlWTBid09pSHNlOTdmSlF4T292eWZLOXd2bnV0MEU4?=
 =?utf-8?B?MWpkY0N1OTR6RDlySWR3QXR4WE5LRUZtUTBlNDR0emRKM2NnWHVoU3NyUG5O?=
 =?utf-8?B?TTFxbjdFVTNUVDd0MGE3MC9CV25NVHQ5OHA4NFRiM2FUOWRJVzgxUTd4TVhI?=
 =?utf-8?B?R212UzVzT2Y2U2JYMWxTakdsUTkwcWxZNjV6M09LbytkdHdoTVhyRjZKcDJZ?=
 =?utf-8?B?YjFJbTVBUm9Kd3dHMDZDMEc5b1NhNS9EMDBoaXNaejVOYkt3aVlQY2RueXpK?=
 =?utf-8?B?NlRMR2RKRjNKeVBxOXlGQ1BZZEN4Si9rclJZdXpzWVJuZ2hwWi91cFNMMm1J?=
 =?utf-8?B?ckc3YTJLZ2x6eldaQmZ3UysxRCtpL24yekpUaVhYS25oTExnUkUvakpvOHlM?=
 =?utf-8?Q?f/xqyfOdL77dv3Anr6Gfd9bwYNshzXi/672ZaZw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E16C310D6431544AFA55D9E4C377D5D@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3df87c-1106-4dea-28c4-08d901a6da0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2021 13:43:58.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqYvEcwhaeWF8vxtwPHjPu/uWdPNy5hqNLz2giwXTYdbOi2gHrEJkH8Et4/CAIITXuEln/brrdguiKqG1QOhaXkBDvXmGHELMABaojj1gf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0578
X-Proofpoint-ORIG-GUID: CcUlwSf88ipuyyWt2LD_k6szu02v3Lf7
X-Proofpoint-GUID: CcUlwSf88ipuyyWt2LD_k6szu02v3Lf7
X-Sony-Outbound-GUID: CcUlwSf88ipuyyWt2LD_k6szu02v3Lf7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-17_09:2021-04-16,2021-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104170096
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xNy8yMSAzOjA3IFBNLCBNdWNodW4gU29uZyB3cm90ZToNCj4gT24gU2F0LCBBcHIgMTcs
IDIwMjEgYXQgNjo0MSBQTSBQZXRlciBFbmRlcmJvcmcNCj4gPHBldGVyLmVuZGVyYm9yZ0Bzb255
LmNvbT4gd3JvdGU6DQo+PiBUaGlzIGFkZHMgYSB0b3RhbCB1c2VkIGRtYS1idWYgbWVtb3J5LiBE
ZXRhaWxzDQo+PiBjYW4gYmUgZm91bmQgaW4gZGVidWdmcywgaG93ZXZlciBpdCBpcyBub3QgZm9y
IGV2ZXJ5b25lDQo+PiBhbmQgbm90IGFsd2F5cyBhdmFpbGFibGUuIGRtYS1idWYgYXJlIGluZGly
ZWN0IGFsbG9jYXRlZCBieQ0KPj4gdXNlcnNwYWNlLiBTbyB3aXRoIHRoaXMgdmFsdWUgd2UgY2Fu
IG1vbml0b3IgYW5kIGRldGVjdA0KPj4gdXNlcnNwYWNlIGFwcGxpY2F0aW9ucyB0aGF0IGhhdmUg
cHJvYmxlbXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgRW5kZXJib3JnIDxwZXRlci5l
bmRlcmJvcmdAc29ueS5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5j
IHwgMTMgKysrKysrKysrKysrKw0KPj4gIGZzL3Byb2MvbWVtaW5mby5jICAgICAgICAgfCAgNSAr
KysrLQ0KPj4gIGluY2x1ZGUvbGludXgvZG1hLWJ1Zi5oICAgfCAgMSArDQo+PiAgMyBmaWxlcyBj
aGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5j
DQo+PiBpbmRleCBmMjY0YjcwYzM4M2UuLjE5N2U1YzQ1ZGQyNiAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMNCj4+ICsrKyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVm
LmMNCj4+IEBAIC0zNyw2ICszNyw3IEBAIHN0cnVjdCBkbWFfYnVmX2xpc3Qgew0KPj4gIH07DQo+
Pg0KPj4gIHN0YXRpYyBzdHJ1Y3QgZG1hX2J1Zl9saXN0IGRiX2xpc3Q7DQo+PiArc3RhdGljIGF0
b21pY19sb25nX3QgZG1hX2J1Zl9nbG9iYWxfYWxsb2NhdGVkOw0KPj4NCj4+ICBzdGF0aWMgY2hh
ciAqZG1hYnVmZnNfZG5hbWUoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBjaGFyICpidWZmZXIsIGlu
dCBidWZsZW4pDQo+PiAgew0KPj4gQEAgLTc5LDYgKzgwLDcgQEAgc3RhdGljIHZvaWQgZG1hX2J1
Zl9yZWxlYXNlKHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCj4+ICAgICAgICAgaWYgKGRtYWJ1Zi0+
cmVzdiA9PSAoc3RydWN0IGRtYV9yZXN2ICopJmRtYWJ1ZlsxXSkNCj4+ICAgICAgICAgICAgICAg
ICBkbWFfcmVzdl9maW5pKGRtYWJ1Zi0+cmVzdik7DQo+Pg0KPj4gKyAgICAgICBhdG9taWNfbG9u
Z19zdWIoZG1hYnVmLT5zaXplLCAmZG1hX2J1Zl9nbG9iYWxfYWxsb2NhdGVkKTsNCj4+ICAgICAg
ICAgbW9kdWxlX3B1dChkbWFidWYtPm93bmVyKTsNCj4+ICAgICAgICAga2ZyZWUoZG1hYnVmLT5u
YW1lKTsNCj4+ICAgICAgICAga2ZyZWUoZG1hYnVmKTsNCj4+IEBAIC01ODYsNiArNTg4LDcgQEAg
c3RydWN0IGRtYV9idWYgKmRtYV9idWZfZXhwb3J0KGNvbnN0IHN0cnVjdCBkbWFfYnVmX2V4cG9y
dF9pbmZvICpleHBfaW5mbykNCj4+ICAgICAgICAgbXV0ZXhfbG9jaygmZGJfbGlzdC5sb2NrKTsN
Cj4+ICAgICAgICAgbGlzdF9hZGQoJmRtYWJ1Zi0+bGlzdF9ub2RlLCAmZGJfbGlzdC5oZWFkKTsN
Cj4+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkYl9saXN0LmxvY2spOw0KPj4gKyAgICAgICBhdG9t
aWNfbG9uZ19hZGQoZG1hYnVmLT5zaXplLCAmZG1hX2J1Zl9nbG9iYWxfYWxsb2NhdGVkKTsNCj4+
DQo+PiAgICAgICAgIHJldHVybiBkbWFidWY7DQo+Pg0KPj4gQEAgLTEzNDYsNiArMTM0OSwxNiBA
QCB2b2lkIGRtYV9idWZfdnVubWFwKHN0cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0cnVjdCBkbWFf
YnVmX21hcCAqbWFwKQ0KPj4gIH0NCj4+ICBFWFBPUlRfU1lNQk9MX0dQTChkbWFfYnVmX3Z1bm1h
cCk7DQo+Pg0KPj4gKy8qKg0KPj4gKyAqIGRtYV9idWZfYWxsb2NhdGVkX3BhZ2VzIC0gUmV0dXJu
IHRoZSB1c2VkIG5yIG9mIHBhZ2VzDQo+PiArICogYWxsb2NhdGVkIGZvciBkbWEtYnVmDQo+PiAr
ICovDQo+PiArbG9uZyBkbWFfYnVmX2FsbG9jYXRlZF9wYWdlcyh2b2lkKQ0KPj4gK3sNCj4+ICsg
ICAgICAgcmV0dXJuIGF0b21pY19sb25nX3JlYWQoJmRtYV9idWZfZ2xvYmFsX2FsbG9jYXRlZCkg
Pj4gUEFHRV9TSElGVDsNCj4+ICt9DQo+PiArRVhQT1JUX1NZTUJPTF9HUEwoZG1hX2J1Zl9hbGxv
Y2F0ZWRfcGFnZXMpOw0KPiBkbWFfYnVmX2FsbG9jYXRlZF9wYWdlcyBpcyBvbmx5IGNhbGxlZCBm
cm9tIGZzL3Byb2MvbWVtaW5mby5jLg0KPiBJIGFtIGNvbmZ1c2VkIHdoeSBpdCBzaG91bGQgYmUg
ZXhwb3J0ZWQuIElmIGl0IHdvbid0IGJlIGNhbGxlZA0KPiBmcm9tIHRoZSBkcml2ZXIgbW9kdWxl
LCB3ZSBzaG91bGQgbm90IGV4cG9ydCBpdC4NCg0KQWguIEkgdGhvdWdodCB5b3UgZGlkIG5vdCB3
YW50IHRoZSBHUEwgcmVzdHJpY3Rpb24uIEkgZG9uJ3QgaGF2ZSByZWFsDQpvcGluaW9uIGFib3V0
IGl0LiBJdCdzIHdyaXR0ZW4gdG8gYmUgZm9sbG93aW5nIHRoZSByZXN0IG9mIHRoZSBtb2R1bGUu
DQpJdCBpcyBub3QgbmVlZGVkIGZvciB0aGUgdXNhZ2Ugb2YgZG1hLWJ1ZiBpbiBrZXJuZWwgbW9k
dWxlLiBCdXQgSQ0KZG9uJ3Qgc2VlIGFueSByZWFzb24gZm9yIGhpZGluZyBpdCBlaXRoZXIuDQoN
Cg0KPiBUaGFua3MuDQo+DQo+PiArDQo+PiAgI2lmZGVmIENPTkZJR19ERUJVR19GUw0KPj4gIHN0
YXRpYyBpbnQgZG1hX2J1Zl9kZWJ1Z19zaG93KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqdW51
c2VkKQ0KPj4gIHsNCj4+IGRpZmYgLS1naXQgYS9mcy9wcm9jL21lbWluZm8uYyBiL2ZzL3Byb2Mv
bWVtaW5mby5jDQo+PiBpbmRleCA2ZmE3NjFjOWNjNzguLmNjYzdjNDBjOGRiNyAxMDA2NDQNCj4+
IC0tLSBhL2ZzL3Byb2MvbWVtaW5mby5jDQo+PiArKysgYi9mcy9wcm9jL21lbWluZm8uYw0KPj4g
QEAgLTE2LDYgKzE2LDcgQEANCj4+ICAjaWZkZWYgQ09ORklHX0NNQQ0KPj4gICNpbmNsdWRlIDxs
aW51eC9jbWEuaD4NCj4+ICAjZW5kaWYNCj4+ICsjaW5jbHVkZSA8bGludXgvZG1hLWJ1Zi5oPg0K
Pj4gICNpbmNsdWRlIDxhc20vcGFnZS5oPg0KPj4gICNpbmNsdWRlICJpbnRlcm5hbC5oIg0KPj4N
Cj4+IEBAIC0xNDUsNyArMTQ2LDkgQEAgc3RhdGljIGludCBtZW1pbmZvX3Byb2Nfc2hvdyhzdHJ1
Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpDQo+PiAgICAgICAgIHNob3dfdmFsX2tiKG0sICJDbWFG
cmVlOiAgICAgICAgIiwNCj4+ICAgICAgICAgICAgICAgICAgICAgZ2xvYmFsX3pvbmVfcGFnZV9z
dGF0ZShOUl9GUkVFX0NNQV9QQUdFUykpOw0KPj4gICNlbmRpZg0KPj4gLQ0KPj4gKyNpZmRlZiBD
T05GSUdfRE1BX1NIQVJFRF9CVUZGRVINCj4+ICsgICAgICAgc2hvd192YWxfa2IobSwgIkRtYUJ1
ZlRvdGFsOiAgICAiLCBkbWFfYnVmX2FsbG9jYXRlZF9wYWdlcygpKTsNCj4+ICsjZW5kaWYNCj4+
ICAgICAgICAgaHVnZXRsYl9yZXBvcnRfbWVtaW5mbyhtKTsNCj4+DQo+PiAgICAgICAgIGFyY2hf
cmVwb3J0X21lbWluZm8obSk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kbWEtYnVm
LmggYi9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaA0KPj4gaW5kZXggZWZkYzU2YjlkOTVmLi41YjA1
ODE2YmQyY2QgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaA0KPj4gKysr
IGIvaW5jbHVkZS9saW51eC9kbWEtYnVmLmgNCj4+IEBAIC01MDcsNCArNTA3LDUgQEAgaW50IGRt
YV9idWZfbW1hcChzdHJ1Y3QgZG1hX2J1ZiAqLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKiwNCj4+
ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyk7DQo+PiAgaW50IGRtYV9idWZfdm1hcChz
dHJ1Y3QgZG1hX2J1ZiAqZG1hYnVmLCBzdHJ1Y3QgZG1hX2J1Zl9tYXAgKm1hcCk7DQo+PiAgdm9p
ZCBkbWFfYnVmX3Z1bm1hcChzdHJ1Y3QgZG1hX2J1ZiAqZG1hYnVmLCBzdHJ1Y3QgZG1hX2J1Zl9t
YXAgKm1hcCk7DQo+PiArbG9uZyBkbWFfYnVmX2FsbG9jYXRlZF9wYWdlcyh2b2lkKTsNCj4+ICAj
ZW5kaWYgLyogX19ETUFfQlVGX0hfXyAqLw0KPj4gLS0NCj4+IDIuMTcuMQ0KPj4NCg==
