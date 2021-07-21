Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93303D12DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 17:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbhGUPMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 11:12:43 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:51196 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238108AbhGUPMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:12:43 -0400
X-Greylist: delayed 826 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jul 2021 11:12:42 EDT
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LFdH7l022507;
        Wed, 21 Jul 2021 15:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=2c/Zs8QsAjKg82TV2po83wSybsX8uVGkFeEndj596qg=;
 b=XwfFqZ8hqCocZLMi3kI2uggeMVzXwht2l509+/NQQZc+GFdVpoORME8StyobAJmw/Ui8
 f3g6FRqa828EIIM0wZ9Cj5V22Q3MuoZ7SQbfVcT2tIvBQv3/BkljjOa38c0fR+0hX45U
 ekZhOXZXTmwyl/7oTWJ+RGZxGUCHteuDxAf0wpgYu83fO+E2W7Hfcmfeg4w139qpwtiX
 gUVhKyFjWyrAAfd+BvS0jC0ZACLgYZB6A5jA1wIMD6JHCTjCSM2bv9W0CYWvrshfcYYJ
 Zf2PlG+ALut8W5srNekKESPs1BM8dpN+EUZ2XZ6m/qcSAGSE+3YBd4uziHTnpMiKQdcP 8w== 
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175])
        by mx08-001d1705.pphosted.com with ESMTP id 39vyuct111-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 15:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEtHlaeuM2z2Ya+81cdybkdQb6K2/rzeNkLkyiikEJTT2Av+PhZV7XoHCFF4WazSOJr29F5vFh4gag7sEAh/mbasqqF4DVlSZV2t6sbi+RDi02/nZ5srwO4R9djZiLTsv2p6YjsGvIZXJE2o+n/cR6vWQOW428tjfMjlKv5V1FmP0vDlMfCJnWDYvn1Jbh82oUxQtb9GLIF3+OYqwzZ7d480+yLR/q/8+HoeQwGPz3nGeCsAENTxfB/mq3Y3Vvpg+2Z+ODlhO33kJVs/oTbUokmYAxHP7gHGjWNVBsX8sLOhTw21VshTjoo3IpqkWmbda8QTmE/3Rl6dpD9z9NGaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c/Zs8QsAjKg82TV2po83wSybsX8uVGkFeEndj596qg=;
 b=gQZCFCkJYy5OfPuHmBHvyAMtH11WZzdrqRMrDFzG6O83+nIc/ZIeA64MWEXvLdtiCHv3Tjz8q4nOldnLjdwdY3YPzpZ4sXJixjOHcnr9PPfwda+efDvcjxEcVFJhK2CvL8AsA07QRX2/MHq1p7WiKnk2bs4ljPIm48927UHb1SE3c2sjBxHPe6DkkPRF7HDuk9t62mw5xLoei3Q2JpVPDx+CqKHVtSd0uscnpAj1c4YNV9NhL6gVtY1QsWt9Ksklbhvn6sXVnW2l0UmvwAGwG1czrQW3Ik/4O06cgwmujIbwFP8zGFh0yVRHT96WKMsMM5xEj78U1WNxeHrL/jm+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM0P193MB0578.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:166::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Wed, 21 Jul
 2021 15:39:13 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::d104:306f:a063:bcce]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::d104:306f:a063:bcce%6]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 15:39:13 +0000
From:   <Peter.Enderborg@sony.com>
To:     <willy@infradead.org>
CC:     <hch@infradead.org>, <nborisov@suse.com>,
        <linux-kernel@vger.kernel.org>, <ndesaulniers@google.com>,
        <torvalds@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
        <david@fromorbit.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
Thread-Topic: [PATCH] lib/string: Bring optimized memcmp from glibc
Thread-Index: AQHXfkOTpsQK/isENkuotdGMivwLH6tNj2SAgAABLIA=
Date:   Wed, 21 Jul 2021 15:39:13 +0000
Message-ID: <4693ebde-e0e8-e9b0-6d89-9463e1d9c243@sony.com>
References: <20210721135926.602840-1-nborisov@suse.com>
 <YPgwATAQBfU2eeOk@infradead.org>
 <b1fdda4c-5f2a-a86a-0407-1591229bb241@suse.com>
 <YPgyQsG7PFLL8yE3@infradead.org> <YPg0Ylbmk4qIZ/63@casper.infradead.org>
 <0c3b5f75-3a8e-2b99-9032-d8e394db2a5d@sony.com>
 <YPg+oSsrb5iiWT4A@casper.infradead.org>
In-Reply-To: <YPg+oSsrb5iiWT4A@casper.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=sony.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aae76031-31cb-40ca-23cd-08d94c5db122
x-ms-traffictypediagnostic: AM0P193MB0578:
x-microsoft-antispam-prvs: <AM0P193MB0578BBA67B0789AE115492B586E39@AM0P193MB0578.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WxGCrqmqOpfaaYVo+KCbIgPJ4ctEwPpZmQF7uR5LVN9hqkQs0WBjdEs8rrT3IEyanBvj1haQ0qN0GDEDaYb5sM+tZJ1nbEvsZWygvaMLTznD7v9c+r6A7/LUXWYvzVTLA+kb0D5fVyCNWUiRcTrobkAp3hOCE6FxH36qAWOWjc0w7EPn4eXTyzzNRNCFyxSv48zoKaQsqTYKfz+Gbg05urL7JyGtyTYEbFhQzOwVUw1tfFawIjwETeojfnznv1PVUf8yHHFwV4zWT259IruD07r6QUIsxgaM/E5IPSEsAFOwRXQ5oDLoMwc+SI/AJwOXSzDU9k3rTnupBbXytrMnUUnzgMysiouqtM5bEwqKfxm/IonBK2FP1hS9cxs1itVIOamnWUwvBZbhcNzrJPireYPtx0kqH/B7ryO3yCvZm1MfuiaDV1dSlzgKDJS1AEb6wPcWyv2YLIXcsll8v94mdAJy3wKoHdMiYxQP4OBSWOY6z//hNNKbSBN3hf5UH2i81mXPfxnF+Nve4T0030WjjDrEjHSLtRyqmkUehtFxn1rvR/C9M3Ug4clHiHIkC9dI7CwafqSqpFus4OZCSZVWMVgSzdhKAK8nEK7bgHSCYnDGxg8VFjJUcWh2KSdILKTWkJ1t+9UHk61DXYheo5ozOJvpiCKCAB7b//tRchY7FYEruePWs8yOYg+y6yluXzCCvEWcJy3NdbNXo1JzpKvXf1SbyD7Ee+NSZS3jEKZnFJG3XVkClgFaMhjjzIebe/4WSjCKDkC3v33JeFAPUmY3vaqqXknkIfUpzMf+CYGMySU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39850400004)(396003)(36756003)(91956017)(5660300002)(316002)(76116006)(2616005)(54906003)(6486002)(66476007)(66446008)(66556008)(31686004)(64756008)(4326008)(6916009)(31696002)(122000001)(38100700002)(2906002)(8936002)(66946007)(26005)(86362001)(6506007)(478600001)(53546011)(186003)(83380400001)(71200400001)(8676002)(6512007)(2004002)(43740500002)(38070700004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHVFcHFDbVVxb25paVA2Wi9KZHJ4WHNUdzJCcWQyQnFUeDRpZHNRQUQ5R1Qw?=
 =?utf-8?B?Y0IrRjhOcFlPazdaVGdFb1JqT1lBM1hyc2xqaFY3bVEvT3dYNlhBUHZaYWtx?=
 =?utf-8?B?QTE1dDFQNTlXY2s3b1dPeE1KNWpja3NSb2hlVjN4ako5dkJseTRXMDNWZFBz?=
 =?utf-8?B?WlRyNTcrSjZLVHJVNnpvdk9DSkxLQ0FMaThQVFZ0bTdJcExYWk8xT2dOczA2?=
 =?utf-8?B?SHVlTTd6YXNJdFFiQzRZSStSNTRsaTl3aTg0ZHNnWmxKblV6ZVlNcVVMMWlk?=
 =?utf-8?B?dk1WSElhbTFRTTcrYm9idFM0WmFYL0FXclZFWGx3MC9TdXF5eThPRm5uamJL?=
 =?utf-8?B?SmQyZWxSa3JqeERsNkcrZFhOVHRlOEhTK2RCRE5XdC82b3E2Z2RUQ2VoaWJN?=
 =?utf-8?B?Z0xKdmc2ZXF0TWxja1NrRGFFNHBIZEQybHNFcnpjMHFiSUVBaTZZVENGdnd2?=
 =?utf-8?B?RGUxWVFPTFU2NGc3bU9mT2FPMkpLeXpZc3pXMW01Y2xjamxmdmYvRi9KK3pQ?=
 =?utf-8?B?MU92ZnBFallOWWkvRGRuc2VZdDR2SkxOYWV3WSt6cVdUQjQ1RTliRU1tZ2M5?=
 =?utf-8?B?STdIL2t1N3dOakhnaExqRnpZcEpZaDV6Ui9zQ1dlQ3NRZTVqR0xjQUd6SVUz?=
 =?utf-8?B?SWVkZG1hR0VEN3JLSDlLT2RucmpCK1RnVFFPZ05XcE5SNDFjUTUrWVdhdExE?=
 =?utf-8?B?NmlEcmdOVGZkZ29mcjlsMS80T0JKVEl3VzlQZ3ErWXdkUmk1d2htdnhvRmtm?=
 =?utf-8?B?djBJNXdMeTVPTm56ay9OSzVvV0c5MWhFNU53eC9zaUhPeWorQjN6MWcwTXgw?=
 =?utf-8?B?UjBod3dHSXNxWElJeUh1YUI4VWRodkUwRi9QNTY1RnRmY2FJNlpHYmhyM09z?=
 =?utf-8?B?eU5DWlNObGZQYzY4VlN2WjQyS1BzdjN2WmEyZXJXUWY1MndaT2NQSWw2ZXJn?=
 =?utf-8?B?UDRidHhuRENvTmljaVJYWWNKcmxicUQyNzBSSFl5aTg4NXJWbHhwY1dWVUNa?=
 =?utf-8?B?Mkk2amV5dHJXMHpjREI4VTk1OFVBdU1TVHc4S1hBRzJOdEd1Z0QrdThWa2lF?=
 =?utf-8?B?aWsvRUZzWDQxQUJ3QUZlaCs0dEMvUURHTWc1Q0lSQ1JhU0k4RzV5WHpqSk05?=
 =?utf-8?B?bFNSLzMxOG9FMWplblJMWmdyYjg0MjA5YlVZNFJ5bWhzN1AxcjczenJzNnZv?=
 =?utf-8?B?VjhWVmcvaHJ1a3VwU1RybVlPNi9ycVpnQUF1ZUdNZE9jS3FadnVQUEV3OWtp?=
 =?utf-8?B?YVN3Rk1UaE9aMHIwNjlZa3lLc3FjbjdEd3JMbE00MHRrdE9iT1dvWHdhY0cx?=
 =?utf-8?B?NGZqYmtZejlIOGZ0L29xMW1CMTRHcmE4TnEwUW1WY21DQTVhZldnSVlGbmtF?=
 =?utf-8?B?VGVXRm5JN1ZJR3RuNm9qTnA2YzdXWDJsTFU0MzI2TU0wTXhGT3JCcktFTWNB?=
 =?utf-8?B?eU1DUGkzdUt4ZVRXVG9xYU1GZ0NNNE5YRFdhQXd6SGJqQnBuR3U4YTB1L0pR?=
 =?utf-8?B?MjFDanNrdG05OGJoRHU5UWNORm1KV1Z0Yld4eGRhaGhSNS9rQU5lQXZRaTJU?=
 =?utf-8?B?c25Sa0h3ZWVUZm9YTnF5a0tjQ0Q3N2lKSUgxeTVpVUJFM2NLUTVaY3RrUkdk?=
 =?utf-8?B?MmpIL0d6TG5va2FqbzJiWWxHS01KOGM3eksrZW9MT3ZCeVc2K3AxUzV2MFpJ?=
 =?utf-8?B?dmtvYkwzbkM3ODZqcEdlZElRc0ZqeTBGSGMwKzZMeWpVOXJlS0JWYkVHMlBh?=
 =?utf-8?Q?DVQjzG744vIOPZo8EUGwK+8zxuA4Hpy4GtfUetI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <77E41506F0FDBB4088A200D6A78572F4@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aae76031-31cb-40ca-23cd-08d94c5db122
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 15:39:13.5895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3fuJKKmj9uxADFSd85MC1O88ljsfyApJDww9hCU6dK2LyATBwr9B0gvmf8gjUD2vUrsq+P3JLqJ01cfGKjE8x9jA6UyPMbeihxDw61yoc18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0578
X-Proofpoint-ORIG-GUID: rKdBCQsPwFcyppe4X_CbQaNWZjnnjLDG
X-Proofpoint-GUID: rKdBCQsPwFcyppe4X_CbQaNWZjnnjLDG
X-Sony-Outbound-GUID: rKdBCQsPwFcyppe4X_CbQaNWZjnnjLDG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_09:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=940 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210091
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy8yMS8yMSA1OjM0IFBNLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gT24gV2VkLCBKdWwg
MjEsIDIwMjEgYXQgMDM6MTc6NTNQTSArMDAwMCwgUGV0ZXIuRW5kZXJib3JnQHNvbnkuY29tIHdy
b3RlOg0KPj4gT24gNy8yMS8yMSA0OjUxIFBNLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4+PiBP
biBXZWQsIEp1bCAyMSwgMjAyMSBhdCAwMzo0MjoxMFBNICswMTAwLCBDaHJpc3RvcGggSGVsbHdp
ZyB3cm90ZToNCj4+Pj4gT24gV2VkLCBKdWwgMjEsIDIwMjEgYXQgMDU6MzU6NDJQTSArMDMwMCwg
Tmlrb2xheSBCb3Jpc292IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IE9uIDIxLjA3LjIxID8/LiAxNzoz
MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+Pj4+Pj4gVGhpcyBzZWVtcyB0byBoYXZlIGxv
c3QgdGhlIGNvcHlyaWdodCBub3RpY2VzIGZyb20gZ2xpYmMuDQo+Pj4+Pj4NCj4+Pj4+IEkgY29w
aWVkIG92ZXIgb25seSB0aGUgY29kZSwgd2hhdCBlbHNlIG5lZWRzIHRvIGJlIGJyb3VnaHQgdXA6
DQo+Pj4+Pg0KPj4+Pj4gIENvcHlyaWdodCAoQykgMTk5MS0yMDIxIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbiwgSW5jLg0KPj4+Pj4gICAgVGhpcyBmaWxlIGlzIHBhcnQgb2YgdGhlIEdOVSBDIExp
YnJhcnkuDQo+Pj4+PiAgICBDb250cmlidXRlZCBieSBUb3Jiam9ybiBHcmFubHVuZCAodGVnZUBz
aWNzLnNlKS4NCj4+Pj4+DQo+Pj4+PiBUaGUgcmVzdCBpcyB0aGUgZ2VuZXJpYyBHUEwgbGljZW5z
ZSB0eHQgPw0KPj4+PiBMYXN0IHRpbWUgSSBjaGVja2VkIGdsaWJjIGlzIHVuZGVyIExHUEwuDQo+
Pj4gVGhpcyBwYXJ0aWN1bGFyIGZpbGUgaXMgdW5kZXIgTEdQTC0yLjEsIHNvIHdlIGNhbiBkaXN0
cmlidXRlIGl0IHVuZGVyDQo+Pj4gR1BMIDIuDQo+Pg0KPj4gU3VyZS4gQnV0IHNob3VsZCBub3Qg
VG9yYmrDtnJuIEdyYW5sdW5kIGhhdmUgc29tZSBjcmVkPw0KPiANCj4gSSBkaWRuJ3Qgc2F5IHdl
IGNvdWxkIHJlbW92ZSBoaXMgY29weXJpZ2h0LiAgSXQncyBjbGVhcmx5IHN0aWxsDQo+IGNvcHly
aWdodCBUb3JiasO2cm4uDQo+IA0KDQpZZXMsIGJ1dCBob3c/
