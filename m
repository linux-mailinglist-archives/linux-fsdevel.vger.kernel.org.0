Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099C9365BC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 17:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhDTPDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 11:03:13 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:16154 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232682AbhDTPDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:03:12 -0400
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KEsoaF004962;
        Tue, 20 Apr 2021 15:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=MChrM/DOrQm5L3CU/omVmn9xm8xxGpvnm8p5e3rJVU4=;
 b=Htf7BO5qUtHx7Omhu6cIM7ZiEdFMtBri+EVlCERVbKKy5OZPq+I6f/CVeP5DigFIk0re
 BJE5+MBGkQyQxeueP3nJbqnCdhmXwXF+dh3Ha3XIJjc+7rdMEdPSHFlvZU360YrMA9ci
 0PNHz6NJ8hf1b5KcZeQ+l3nFsE0am4ljBxw7sixpS4Upj0dp/EQoQwDZpbYSFfbA3Zv1
 eWCR805xTQfVo4Qu2odcbG+C/ZfSrbabo7CbhhDwEzxAUc5GIqrPzLk+JtPdepiJBhv/
 hKSfHmbIPE0szzZHm0j0sEWE8gBvYcosbvYFZjQkor3od4eJinIUcGj84/VKHd24ZmxI CA== 
Received: from eur01-db5-obe.outbound.protection.outlook.com (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57])
        by mx08-001d1705.pphosted.com with ESMTP id 37ypj1t57v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 15:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiduXywzIDjB7eXDXnU7IRTSS5HnoKI/kbtB4U6MoTm8G4ZzeqBO5TjHDz7MqxQ2YBoA0wKtfbFiVuUBKMkj1QsKoBfwtngCVZS2PwdArr5sMRlVCFaMlJcs42sB8GLZrFrqRL/bPjTxI/FvPstzKE6SXkVIyegV1AwD/mm2idkjI/ZcrYftxgR9iFzcIgDyZq1Fx1PGDxSuMSVrK4fcMm31WEomrszv2Dp8yLsdHndzs7vz9JtXEBgYPn3Z8hDIVa6HVGxiVfGKVr24b0qM66lImuamUj/EPLOr7oGVPId5ypnlzJ0P7gxFkL68AYD0dF8ghftVJU2YXbxbrXSrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MChrM/DOrQm5L3CU/omVmn9xm8xxGpvnm8p5e3rJVU4=;
 b=M7eI9FE/7KLtsx8eH11WFRpKYIlLVDxc3OOtlc6IgvdGosnJCxaewy3rQZGBxRFLntduPewDPnI+ENO4xNuMqxlSaUztkUBPyGmxWPO/hv/hFjS8aLaREMkMTuR++bpAqfg2kCj+wXmYVAhjB08zop18YZHCJjzwtbkxHOCRfTxo+h22x6cwRQRVl97LZNNroL+Tv1ODRq1Ifmhhnbd0FEeJtwGkJZcO16qmSYi0fY02wTTaK5psidFvmxHI1+iCsZY8sGukdZkTzGKm023rVH6TRumNqV/UC3TEBMg0dZZF/tqKMgbspj3/8gSQ8FcjbSRYkKXeaqn/4lzaEunxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM8P193MB0819.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 15:02:03 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 15:02:03 +0000
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
Thread-Index: AQHXMrzS5xsiePyv1kC49iGqOSZm9aq9bm8AgAADNoCAABFLgIAAA9SA
Date:   Tue, 20 Apr 2021 15:02:03 +0000
Message-ID: <761db8ec-8d26-5472-123b-6ae76b4bec24@sony.com>
References: <20210416123352.10747-1-peter.enderborg@sony.com>
 <CAPj87rM9gaPS5SOHo3CKUU=5H0PDaG28r8BXimhVp-wmCbMvWA@mail.gmail.com>
 <9d4b7f7d-1a7d-0899-bf33-49fac1847bbe@sony.com>
 <CAPj87rNo2WS8A0BUoncZhZg4gMOcBrjOF5gxiAWrbpO6z1Rnqg@mail.gmail.com>
In-Reply-To: <CAPj87rNo2WS8A0BUoncZhZg4gMOcBrjOF5gxiAWrbpO6z1Rnqg@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: a3d60e74-a293-48ff-99cd-08d9040d41f4
x-ms-traffictypediagnostic: AM8P193MB0819:
x-microsoft-antispam-prvs: <AM8P193MB0819D82397F81992B91C732F86489@AM8P193MB0819.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqvBQC71r6JEM8Sdy9rJyUPDT7hcJoc0zLTdoK5PMpXsy86+ktz2nmaX+ltvfPsHLErKRaIMpzz/uTUr/EIkromKWrynyf4QH7jKj4Cg/k27QvPlJjhM8xULbEqzbmz3F5te1dOFF3QGuL1jsl/JwGcNFP9XSg9ovVAfDmdo2bqsK3oy88jszvAH8ct9ZKpRhP6HUQ9vJbXFsqdP/ZYFv3MK8JWJwoIMw9mAJWRNZqstz1MVZYI3FyIhFVxaC5kUKg7oFJazdIg+eEPP2ghp6W5RioKTc/sRGRvIPbifQI19asQV7ZrPNs5D144G95esRQvNGxNtwX0ALgbKb4kHb9M8cbx59UhHHGCgg7SC6qtXtYCoy3CJMdCzuwrmbkIvEhYlUpvODeyNxCFid01zvo9fCRZ74Z+jJ2IqOh6ifnUDclqVRUwTHje6ZTGYZ/wkebirDyDn6S7xEjnZnK7I8RwvoGz0xtFIaQD8FxFwA4pi21l5o0/HIgnWDs3Y3F56D4oepbgDfCT13sTT7b8MKWRMmNXdtGrSvJ4CsBFU+uHJflMR45k+aqKYMC/nrjBmtmoSonPrAa35cTIPiJZz4UQgVmXbNSIhebF9KLmQTU3PxsyNOj91jHsK/dkJ0SApky8byalBGL3iDhi/oqfwNst8m+nMamPSnP7o0Fj2Ge4NcFWzLV84nc902I1ko18g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(366004)(8676002)(66556008)(66946007)(66446008)(38100700002)(8936002)(66476007)(64756008)(316002)(36756003)(2616005)(86362001)(71200400001)(26005)(54906003)(7416002)(5660300002)(91956017)(186003)(4326008)(83380400001)(76116006)(6506007)(53546011)(31686004)(31696002)(6512007)(478600001)(2906002)(122000001)(6916009)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RFRzUzBJV2xhOW9PTit2d1BnckRsMUFkTjRCdzlyMDhqQWMxZnA3Z2RkSUJK?=
 =?utf-8?B?ZXRMN0lLV2pycXFuM3VVWTlYK0Y3VzFhRjRRUWRjMEVQVThhNTVPTStJT3Yy?=
 =?utf-8?B?b1MyZThpTDYrYllaVjZza01Hc2lBVGRZZmZ1eU1RNTRlNTN2bnJyRmoydWxv?=
 =?utf-8?B?OEFvYzZoRjJ2dDVYNjc3cm5pR3VUVXV2L3g1eVFzVUtDM1FXb1oyM2ZPcmZU?=
 =?utf-8?B?TkVNNjFDa0h3ZjJWQ3JLUVRUOGtpKzFuUDhHVXBBelgxdlY5YUpuTG5qYXZI?=
 =?utf-8?B?b2cxSGxNYnQ2S0xFN3hBbXVaam12YkxkZU90R3hqT2tVTmpEcXRhOFhCenNG?=
 =?utf-8?B?QzVtKzg4Wmtmb0ZFdExjQ2ZUZzQySCtlLzVTZ1lPTHlpd3VVSWlWbERMWXRm?=
 =?utf-8?B?dXFrOXdGVWkrRi9VQVBKbkNFYWNBVkh4M2dLMURtOHlubGNBYlVYWUd1UUxG?=
 =?utf-8?B?MzhuZUtheERlU2FZVTZJY3dWZ25sUytBU0lJVWZoaUVISFZjWFZST1hYT2JH?=
 =?utf-8?B?ZWRTekZ5VW00eDZjUDFUazJDU0QvZ1pYTXhZN1RjaEFNWkVEVjE1ZVZYb3RQ?=
 =?utf-8?B?TWVZditGZjlwL2ltci9iR0JnWTE3R09YTTZXVVlhTXByU05XcG4waXZzTWZj?=
 =?utf-8?B?dTc5ZlhhK25MQkU0ZEtBRUtCZkJUNmFJbDFnNkFsejMrdnNCK0hsVUI1RUZO?=
 =?utf-8?B?cVdVVnA1QytNUjhnYW40YW9uTE1xbHlPZXkrUlR2c0xNOGxVSStGSjE3QUFk?=
 =?utf-8?B?ak4zbldkbXF2blIraFI1a3pSNUlWaWdMR2pUZ2JzalZuS1NJeVJYbzFRR2Vx?=
 =?utf-8?B?NkFKZXRSWXJiZnZtVTAzbnBWRXFvWHR1Q3lUcWxQdS9tbkJLa202emlXU2FP?=
 =?utf-8?B?UEsramxEWFo2TFhLL0U5ZDVCZitMbGNsRndxS1A0dExheTBwb2lvSnNHY3gr?=
 =?utf-8?B?eGszN3RxL2NLWEZ4MUxUcGdqbTk4VlhjNkMvWC82dCtvUE9CYlZqMjNCZEUz?=
 =?utf-8?B?emhIZXY3RFNka0xLbXAzNVZ1Zm9PM1lYMG5VaWdpS05rRDRpbko3c1FWczZX?=
 =?utf-8?B?VnlUQlFkMWdXZlQvcGtFMWNwL0hKaHlVZHdQK3NCSWZrMkhteXlZNFdxNGI5?=
 =?utf-8?B?VHNacWtuZldoVGYrYU93MDdxMUxaUk40Z0NEY1pOZnFGU0MyTDZiaUhWTHZG?=
 =?utf-8?B?MkxYUVQ0Q1VuNXhxY1Nib1NJdEExOStMT2RWcTVxR1BhYmRrN1R2NlZzWVl1?=
 =?utf-8?B?ZXpDRm12ckxvenV4SlVDaThWK3ZaTVhHbk1EamY2Y2pUYTNtY2JWTThtaW96?=
 =?utf-8?B?eXIvS0JqdkpEY1N2SlQ4SlFuOGhKeGhmQUdEeG1qaVlxalFGMUJCMWRjc1py?=
 =?utf-8?B?OXZYOEZJRHFlOWxLUUQ1dzFIR0oxMWxJWGQ0dzZBcGZvL0JuSWd5b0JqRFJm?=
 =?utf-8?B?SkxWYnFFVDg2K09FTnEwUEdxYTN1N0NIdHZ1czByMzNMOS9qMzFuWm4wTDND?=
 =?utf-8?B?bHpIanVwTVFGMFcyMmxOd1NHaUkyS1JzZWRFL1FrRkZ3RTY5dUJxQlU0VUNq?=
 =?utf-8?B?U3JGRHVPeGZPalFLR2FVZHhVUUQyUkRuaDdvQkhwTHJsdHRteC96S0ZHMFIw?=
 =?utf-8?B?eDlFNE5jYXNEUFVQK09PM0NocDJFNEFuSHNGZEhaQUxlTXpReTNJeGVlN1pO?=
 =?utf-8?B?UUtmMlkzUlpLcUQwcHFEaGtuMm53QkJ1SnhqNUpBOHN1SEUzWHc3eGpERWxn?=
 =?utf-8?Q?pxuNaM0WZrrz8volMd5ne76LgLVc5Vav8qivGxT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B3E9B65ACC5B44FAEAC341BDE5BF3E9@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d60e74-a293-48ff-99cd-08d9040d41f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 15:02:03.6723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98xjkrl31mXxA+hpzw06UtuZ8rGpuoAvzYQ6c8XisgLTU4A4FlI5udTQt4bAO399nGVEI81ZuLYxW1h6ip5Zk+Rv6F4xlADSnHOyu7jAfmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0819
X-Proofpoint-GUID: yeySn4I7HrYkhrgZYFIul24V9ENirUHV
X-Proofpoint-ORIG-GUID: yeySn4I7HrYkhrgZYFIul24V9ENirUHV
X-Sony-Outbound-GUID: yeySn4I7HrYkhrgZYFIul24V9ENirUHV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_07:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200112
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMC8yMSA0OjQ4IFBNLCBEYW5pZWwgU3RvbmUgd3JvdGU6DQo+IE9uIFR1ZSwgMjAgQXBy
IDIwMjEgYXQgMTQ6NDYsIDxQZXRlci5FbmRlcmJvcmdAc29ueS5jb20gPG1haWx0bzpQZXRlci5F
bmRlcmJvcmdAc29ueS5jb20+PiB3cm90ZToNCj4NCj4gICAgIE9uIDQvMjAvMjEgMzozNCBQTSwg
RGFuaWVsIFN0b25lIHdyb3RlOg0KPiAgICAgPiBPbiBGcmksIDE2IEFwciAyMDIxIGF0IDEzOjM0
LCBQZXRlciBFbmRlcmJvcmcgPHBldGVyLmVuZGVyYm9yZ0Bzb255LmNvbSA8bWFpbHRvOnBldGVy
LmVuZGVyYm9yZ0Bzb255LmNvbT4gPG1haWx0bzpwZXRlci5lbmRlcmJvcmdAc29ueS5jb20gPG1h
aWx0bzpwZXRlci5lbmRlcmJvcmdAc29ueS5jb20+Pj4gd3JvdGU6DQo+ICAgICA+wqAgwqAgwqBU
aGlzIGFkZHMgYSB0b3RhbCB1c2VkIGRtYS1idWYgbWVtb3J5LiBEZXRhaWxzDQo+ICAgICA+wqAg
wqAgwqBjYW4gYmUgZm91bmQgaW4gZGVidWdmcywgaG93ZXZlciBpdCBpcyBub3QgZm9yIGV2ZXJ5
b25lDQo+ICAgICA+wqAgwqAgwqBhbmQgbm90IGFsd2F5cyBhdmFpbGFibGUuIGRtYS1idWYgYXJl
IGluZGlyZWN0IGFsbG9jYXRlZCBieQ0KPiAgICAgPsKgIMKgIMKgdXNlcnNwYWNlLiBTbyB3aXRo
IHRoaXMgdmFsdWUgd2UgY2FuIG1vbml0b3IgYW5kIGRldGVjdA0KPiAgICAgPsKgIMKgIMKgdXNl
cnNwYWNlIGFwcGxpY2F0aW9ucyB0aGF0IGhhdmUgcHJvYmxlbXMuDQo+ICAgICA+DQo+ICAgICA+
DQo+ICAgICA+IEZXSVcsIHRoaXMgd29uJ3Qgd29yayBzdXBlciB3ZWxsIGZvciBBbmRyb2lkIHdo
ZXJlIGdyYWxsb2MgaXMgaW1wbGVtZW50ZWQgYXMgYSBzeXN0ZW0gc2VydmljZSwgc28gYWxsIGdy
YXBoaWNzIHVzYWdlIHdpbGwgaW5zdGFudGx5IGJlIGFjY291bnRlZCB0byBpdC4NCj4NCj4gICAg
IFRoaXMgcmVzb3VyY2UgYWxsb2NhdGlvbiBpcyBhIGJpZyBwYXJ0IG9mIHdoeSB3ZSBuZWVkIGl0
LiBXaHkgc2hvdWxkIGl0IG5vdCB3b3JrPw0KPg0KPg0KPiBTb3JyeSwgSSdkIHNvbWVob3cgY29t
cGxldGVseSBtaXNyZWFkIHRoYXQgYXMgYmVpbmcgbG9jYWxseSByYXRoZXIgdGhhbiBnbG9iYWxs
eSBhY2NvdW50ZWQuIEdpdmVuIHRoYXQsIGl0J3MgbW9yZSBjb3JyZWN0LCBqdXN0IGFsc28gbm90
IHN1cGVyIHVzZWZ1bC4NCj4NCj4gU29tZSBkcml2ZXJzIGV4cG9ydCBhbGxvY2F0aW9uIHRyYWNl
cG9pbnRzIHdoaWNoIHlvdSBjb3VsZCB1c2UgaWYgeW91IGhhdmUgYSBkZWNlbnQgdXNlcnNwYWNl
IHRyYWNpbmcgaW5mcmFzdHJ1Y3R1cmUuIFNob3J0IG9mIHRoYXQsIG1hbnkgZHJpdmVycyBleHBv
cnQgdGhpcyBraW5kIG9mIHRoaW5nIHRocm91Z2ggZGVidWdmcyBhbHJlYWR5LiBJIHRoaW5rIGEg
YmV0dGVyIGxvbmctdGVybSBkaXJlY3Rpb24gaXMgcHJvYmFibHkgZ2V0dGluZyBhY2NvdW50aW5n
IGZyb20gZG1hLWhlYXBzIHJhdGhlciB0aGFuIGV4dGVuZGluZyBjb3JlIGRtYWJ1ZiBpdHNlbGYu
DQo+DQo+IENoZWVycywNCj4gRGFuaWVswqANCg0KRGVidWdmcyBhbmQgdHJhY2VzIGFyZSB1c2Vm
dWwgd2hlbiB5b3UgcGluIGRvd24geW91ciBwcm9ibGVtLsKgIERlYnVnZnMgZG9lcyBub3QgZXhp
c3Qgb24gY29tbWVyY2lhbCBkZXZpY2VzIHNvIHdlIG5lZWQgc29tZSBoaW50cyBvbiB3aGF0IGdv
aW5nIG9uLCBhbmQgdHJhY2UgcG9pbnRzIG5lZWRzIGFjdGl2ZSBkZWJ1Z2dpbmcNCmFuZCBiZWZv
cmUgdGhlIHByb2JsZW0gb2NjdXJzLiBBIG1ldHJpYyBvbiBkbWEtYnVmIGNhbiBiZSBzZW50IHdp
dGggYSBidWdyZXBvcnQuDQo=
