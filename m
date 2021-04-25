Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B24136A5CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 10:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhDYImV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 04:42:21 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:31064 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229485AbhDYImU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 04:42:20 -0400
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13P8f3PB019433;
        Sun, 25 Apr 2021 08:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=7hKI6JzhjQ20V9sLvht/nLKWeP4k4MT4CLSgMSNxcW0=;
 b=TX+c7A8lFuqAe+FpdyOvqrGdsNjt3jf85nQE2gB+swDe6zBWpWJxlOYbVqs260FDCn3h
 uvakGJaF/I/HKMa9kRzAsYX2R2u2M4FXxrewKTXmO5DiW9UtHGPCbMW7mXYeBTPSNEPq
 GciZ62MNsBCv0QVauHEGkZW5YtTDtk8EmoHxi6Yol2ynYHNxQr6GBi6anzi/raMhViuu
 c6XnS+J9JvnX9nJA4UHjwjZM597q2iBeUMutNFV0YYzeUPM+NocD4U1sN+Ba9Whyjv3h
 Fnzsx7h0+3PU/CTlFFek5RUnyUtPis/ggIRXX85JBE1zezjrUw/lPrAGd2Z5rmiKRjlZ lQ== 
Received: from eur03-am5-obe.outbound.protection.outlook.com (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58])
        by mx08-001d1705.pphosted.com with ESMTP id 3848r61bxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Apr 2021 08:41:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8psSRIxJZeUdc8D1S/DpEW3vYAcWybXNytbb875NxM9+JY7o5dMhoJtbHLx6mcFzseuOdjv+gke3jNQcuSiivkjmWLlG4brTXYGGRh5vUIgu/O4WFeR3l8e0LC5A6LzoNVmzamlkjObJtQ5Eagw+bmzBccuQFwxhP/7wifTZiQTZVq2GHJCt05eKXBmXLYc9Y7wpefw8gOGrP8E9i7CcYqWzGF7OymS2gD7Ohd5H+9v+gyNtUSSegbjkV0pZ4vasL4jZsnL0Skce0UsWMugkUN8S8XlmdKJ4SusngTFOPEYaO7hTlluEnIjBu9xsTYuKXLQGksWcTN/W+kmbKJNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hKI6JzhjQ20V9sLvht/nLKWeP4k4MT4CLSgMSNxcW0=;
 b=Bj4JBlt3bBxnzCR8LVIScfh5UP+PnNULUoX3VPlprnp8uDp7NQWE7MwI6aPPmISvHpEV8AdCoVoB0BQhEPivUmjfSjnasw1GBX3ddub9xHS6gstF6tUjHnhCL84EGiGsPESoib5jSl8G8CScuWqKPfmKpv7z9Dz+8y4hBBGqUeoURLmM3uhxLfIzJMDYcEr/dm4Gcswxp5tOCkc0vRLjoh3tXzUUE+Th8PGENv2RzQdUxLJaFRCqXVHCwJj547I6hsp+AnJ2erW+huVcC67ipm/GBzLiy39PV9yV8jI92FP7i8c0fnpj9W9Pq/0iH4bLFP+M6keDu7p281km1fS6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM8P193MB1124.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sun, 25 Apr
 2021 08:40:17 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.026; Sun, 25 Apr 2021
 08:40:16 +0000
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
Thread-Index: AQHXM6gnmsuLu+Ufhk6GusLEaztxYKq9H2WAgAAHpACAAB5AAIAABooAgAFqggCAABbkAIAAUmUAgAAinACAAPM+AIAAZTkAgARIsoCAABJ/gA==
Date:   Sun, 25 Apr 2021 08:40:16 +0000
Message-ID: <136c3696-8dda-7abd-ea21-c4764f17db86@sony.com>
References: <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
 <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
 <YH63iPzbGWzb676T@phenom.ffwll.local>
 <a60d1eaf-f9f8-e0f3-d214-15ce2c0635c2@sony.com>
 <YH/tHFBtIawBfGBl@phenom.ffwll.local>
 <cbde932e-8887-391f-4a1d-515e5c56c01d@sony.com> <YIBFbh4Dd1XaDbto@kernel.org>
 <84e0c6d9-74c6-5fa8-f75a-45c8ec995ac2@sony.com> <YIEugg9RIVSReN97@kernel.org>
 <ae091d3d-623b-ce18-e0f2-1591be6db83e@sony.com> <YIUbZWm+jW21vYJ9@kernel.org>
In-Reply-To: <YIUbZWm+jW21vYJ9@kernel.org>
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
x-ms-office365-filtering-correlation-id: f1032839-f1e8-420a-0ed5-08d907c5c056
x-ms-traffictypediagnostic: AM8P193MB1124:
x-microsoft-antispam-prvs: <AM8P193MB1124D4E0502BED33A64F917686439@AM8P193MB1124.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIyUeh3dMbj94Yt2os+TGCF9tMKicC9An73pfuLa9rVxsEIegLf4szn7+PJI0mktEAnfRBaS3QZ2SIl49/iQK41dy6kk8gP+HZfDb4cbyiZNjhxAPI27203mSaG30Ww3+65Om8qA1TryKGcDCZZAt+yT2FkMraGb5gtivWQfEO4H7k/nJvGwDQMGWZU0Qq78G4GKnZEw8MOHjv9snHfZq6EH+yMNdsGWUapHfu8u1dtidOa89T2ov9n/eBykpPTa5K9jw6XaIGp/fH2EVGV9hWXOGM8OpkM4hx584r921hAL1DRdYx11NJJGTyQVgrn+6ei6q9aoOeiT6i6zgTM91Vfbo/XjiTy5NWT8McBvPGurSieWGSB/MrEtlMjhnhR5KPj9uaAumpws3n60yn5Zs0hfERHjxDEOwzSVHyADiBAGo8N1dwdKNdGvl2lgOhLGb6qU6JTHOYREay7vUpquw32GH6CExxzNW39iUJKMbmaVpNYIxkwm9iy/yv2zUtiXn7wgs1083BWdMaJsv/Vi/PCJmeZWtsQEvO8M5XoUbYHrC/4DdSAcGJjqQdyNvkujcjNhPnZ2vppU4bShPGlSAVfN62KcryCHmlVOzy4M0/nJ057H3qVBXc2hPFmXpAIR9wZzcRoq6w66iZPDMXb3cFowOxnqyo5QGuQtNgLx8Lm6Tg++cHn0XcC+1E7AJKGM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(136003)(396003)(376002)(366004)(83380400001)(53546011)(186003)(6486002)(2906002)(6916009)(31686004)(71200400001)(2616005)(478600001)(6506007)(54906003)(26005)(91956017)(76116006)(316002)(5660300002)(66556008)(66446008)(64756008)(66946007)(66476007)(4326008)(7416002)(36756003)(38100700002)(31696002)(8936002)(8676002)(86362001)(6512007)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MHJVRDV2MnZEcnlRSEl3eXdmL3VnN3UwTlZ3UXdBeTRxSy9aSVlwaXZqd3pM?=
 =?utf-8?B?QjhjQTZwRXhxVHI4WG55c0l5TktoS3NFZGlvOXdoV3FPcDVDMUowb0JYQmwz?=
 =?utf-8?B?VjI3b2NOa1hrWEhTL29CazZYc3d1SjIwWmRWc3p2WnhMR2hmc25qTzkxczlk?=
 =?utf-8?B?UkxNVWRsWGpXL2JOUnJuZ3VoelZPbFhpelFvNVpFS096aW5HZW1YcnA0NUZx?=
 =?utf-8?B?cXB2WWRnTmVUaG1MbFQwMEt1OFZpN2luWElwL2kzemJSYTNGQWVhZEcva3Fq?=
 =?utf-8?B?aTJCMU5QQ2UzcVpiSEJCL3phREtsZlQwNVF0RmxPR0pNT0tOZlNDMGwzOGM5?=
 =?utf-8?B?RHM4OCtkTmNxRGowbTBwRWpSWkI2VnhPalVKQlEvWGRwZDRZdmRwdXFjZGdB?=
 =?utf-8?B?RGdaTXBvRGNBb20rVnI1WGR5aFlVSWhLSXpBZWVQeGxTYStqQ2xtWGdaU1hS?=
 =?utf-8?B?ODcrMGlJZlNFWWtoVm5pUFZsanA5WmgrOVMzR0Q2Q0I0dG9oR3dqc3hOaGIr?=
 =?utf-8?B?c2VrQnhjNFBoZ2hRdDlSaUxyZVpIbG41RXhuM3R1UjFMV3M3UGgreTk1WW8x?=
 =?utf-8?B?M2ZjcC94QW1JRkxnYlljWkNPbFU2WVk1TnZ0aS8zNStOcGt4bVQrQ2lsZ2NI?=
 =?utf-8?B?cDM3bUoxeENrdTVUaVhQTGoxOHEvTFVkbzlVMmVHSkhqOUo1U0E5dHczWWxi?=
 =?utf-8?B?M0t3QXFWaUFKZGJXWERhQ3doSWdGODhBdytMY0tRRHV2UDY0V3hYM0JHOWlN?=
 =?utf-8?B?QkhxWUJRQXB4Q3hOL01NUzFJd09PWUxGeHhLZnRBbzYyd1ZsaE4wZ096ZWhn?=
 =?utf-8?B?dE1zSSt5RHBtRVdTN0kvbkxFREJhTUtZd1JoSDBOYVB4QmxKTFFCUG9yTW1m?=
 =?utf-8?B?c0huNlprelpLSFBabkFjSS9xU1dnWHRUN0l2b0VVdFdyRFBBRVNjSmdzdFVo?=
 =?utf-8?B?aU9zcWljRGRXYllzNVhRZElIeFZTUnpLbkRJSm40V2oycERWOUZnbjd3YlBZ?=
 =?utf-8?B?SXdxUGluV3BtSGxIQm85VGNvNkZUNno1Sk1HSEFDYkVFdGlyalhmSldSWU9v?=
 =?utf-8?B?a2xtNnYzZ0tjeXpUUFhMTG81aDUwNGhXeis2VWNRNzdxT2FpMEhPV2NHY1Ft?=
 =?utf-8?B?UlZNNHlMRE5ncmdQSzdRYzh6RzlNbCtoTkdaZmpITlpHaE5mWWp2NmV3aDZp?=
 =?utf-8?B?M1RDVmQySEg1WkpQSlduUUtqR0pHdEhYMjhBSFdxcnJUdFhmZ2xheXZya2JM?=
 =?utf-8?B?aEIrMzliaVNBZG5LeVNXaGZpcGRCdGl0SmtGeEQwY3psYmp3S05YdDNBdzFO?=
 =?utf-8?B?d0tjWlJyYzhPMjFJS0dxblV4VDhoVHBva0J4MWVWYkw0bldGTXF5bzYwN2dt?=
 =?utf-8?B?YURQWFA3NEFIMmszLzFNaWZLeC9IWWNkRGs2ZWRVUHVERnllRS9JNVh1WWQ1?=
 =?utf-8?B?OWdYU3kwMjJ4QkZZWG50SU5BN1Z2V1BwMVF4V3Z0K2FxYVN4TmxJQVZ0ck1M?=
 =?utf-8?B?aFczOHpaMm5kOHFUUTBrVjVVKzh2ckM4RS8wcjBVblVQcXFnbElGQW05aUZT?=
 =?utf-8?B?K0JIQzFoREk1RFJKMC9RaDBsVlNTa3RkUHZqSG1NaWRLMU1GbFdMQWFtQnAy?=
 =?utf-8?B?bnV2dEREYitHMjdaU2Q0REs2RXRTYWJGNUJkV3RybU9lYzhoV016MWJvWlln?=
 =?utf-8?B?VzQyS3JqVk9YN2lJNFFRRDN1ZzYrdlVHTGViNHVqN1Q4aW1KelNPaDNSTzBB?=
 =?utf-8?Q?sDPstxJgT0uIKxXXJs5YngV2LFM/MBgm+6wyJvl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F45DBBC03714A244AA6E07778E6E0FFD@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1032839-f1e8-420a-0ed5-08d907c5c056
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 08:40:16.5676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZ3TNOjOopqVWuxsNGImqkMugpIabp5oXGSa6xppsOCsJujt6SjIlOHWwwHpZziSZaItEn+YypWHOAB5X4hkxpHjYS0djiIAnTBdmk578MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1124
X-Proofpoint-GUID: fsQCySKswn5PWC91OncKjBKKE-d6TlpO
X-Proofpoint-ORIG-GUID: fsQCySKswn5PWC91OncKjBKKE-d6TlpO
X-Sony-Outbound-GUID: fsQCySKswn5PWC91OncKjBKKE-d6TlpO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-24_06:2021-04-23,2021-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104250063
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yNS8yMSA5OjMzIEFNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBPbiBUaHUsIEFwciAy
MiwgMjAyMSBhdCAwMjowODo1MVBNICswMDAwLCBQZXRlci5FbmRlcmJvcmdAc29ueS5jb20gd3Jv
dGU6DQo+PiBPbiA0LzIyLzIxIDEwOjA2IEFNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPj4+IFNv
IHRoZSBmbG93IGlzIGxpa2UgdGhpczoNCj4+Pg0KPj4+ICogYSB1c2VyIGhhcyBhIHByb2JsZW0g
YW5kIHJlcG9ydHMgaXQgdG8gYW4gYXBwbGljYXRpb24gZGV2ZWxvcGVyOyBhdCBiZXN0DQo+Pj4g
ICB0aGUgdXNlciBydW5zIHNpbXBsZSBhbmQgbGltaXRlZCBhcHAgdG8gY29sbGVjdCBzb21lIGRh
dGENCj4+PiAqIGlmIHRoZSBhcHBsaWNhdGlvbiBkZXZlbG9wZXIgY29uc2lkZXJzIHRoaXMgaXNz
dWUgYXMgYSBzeXN0ZW0gcmVsYXRlZA0KPj4+ICAgdGhleSBjYW4gb3BlbiBhZGIgYW5kIGNvbGxl
Y3Qgc29tZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHRoZSBzeXN0ZW0NCj4+PiAgIHVzaW5nIG5v
bi1yb290IHNoZWxsIHdpdGggc2VsaW51eCBwb2xpY3kgcmVzdHJpY3Rpb25zIGFuZCBzZW5kIHRo
aXMNCj4+PiAgIGluZm9ybWF0aW9uIHRvIHRoZSBkZXZpY2UgbWFudWZhY3R1cmVyLg0KPj4+ICog
dGhlIG1hbnVmYWN0dXJlciBjb250aW51ZXMgdG8gZGVidWcgdGhlIGlzc3VlIGFuZCBhdCB0aGlz
IHBvaW50IGFzIG11Y2gNCj4+PiAgIGluZm9ybWF0aW9uIGlzIHBvc3NpYmxlIHdvdWxkIGhhdmUg
YmVlbiB1c2VmdWwuDQo+Pj4NCj4+PiBJbiB0aGlzIGZsb3cgSSBzdGlsbCBmYWlsIHRvIHVuZGVy
c3RhbmQgd2h5IHRoZSBtYW51ZmFjdHVyZXIgY2Fubm90IHByb3ZpZGUNCj4+PiB1c2Vyc3BhY2Ug
dG9vbHMgdGhhdCB3aWxsIGJlIGFibGUgdG8gY29sbGVjdCB0aGUgcmVxdWlyZWQgaW5mb3JtYXRp
b24uDQo+Pj4gVGhlc2UgdG9vbHMgbm90IG5lY2Vzc2FyaWx5IG5lZWQgdG8gdGFyZ2V0IHRoZSBl
bmQgdXNlciwgdGhleSBtYXkgYmUgb25seQ0KPj4+IGludGVuZGVkIGZvciB0aGUgYXBwbGljYXRp
b24gZGV2ZWxvcGVycywgZS5nLiBwb2xpY3kgY291bGQgYWxsb3cgc3VjaCB0b29sDQo+Pj4gdG8g
YWNjZXNzIHNvbWUgb2YgdGhlIHN5c3RlbSBkYXRhIG9ubHkgd2hlbiB0aGUgc3lzdGVtIGlzIGlu
IGRldmVsb3Blcg0KPj4+IG1vZGUuDQo+Pj4NCj4+IFRoZSBtYW51ZmFjdHVyZSBpcyB0cnlpbmcg
dG8gZ2V0IHRoZSB0b29sIHRvIHdvcmsuIFRoaXMgaXMgd2hhdCB0aGUNCj4+IHBhdGNoIGlzIGFi
b3V0LiBFdmVuIGZvciBhIGFwcGxpY2F0aW9uIGRldmVsb3BlciBhIGNvbW1lcmNpYWwNCj4+IHBo
b25lIGlzIGxvY2tlZCBkb3duLg0KPiBSaWdodCwgYnV0IGl0J3Mgc3RpbGwgaW4gZnVsbCBjb250
cm9sIG9mIHRoZSBtYW51ZmFjdHVyZXIgd2hhdCdzIGZsYXNoZWQNCj4gdGhlcmUsIGlzbid0IGl0
Pw0KDQpOby4gVGhlcmUgaXMgYSBsb3Qgb2YgcmVzdHJpY3Rpb25zLCBhbmQgR29vZ2xlIHdpbGwg
cHJvdmlkZSBhIGJpbmFyeQ0Ka2VybmVsIHRoYXQgaXMgdXNlZCBvbiBhbmRyb2lkIGRldmljZXMg
dGhhdCBpcyB0aGUgb25lIGhhdCBNVVNUDQpiZSB1c2VkIG9uIGNvbW1lcmNpYWwgbW9kZWxzLiBJ
dCBpcyBjYWxsZWQgR0tJLg0KDQo+IFNvIHRoZXJlIGNvdWxkIGJlIHNvbWUgdG9vbHMgdGhhdCBh
cmUgb25seSBhdmFpbGFibGUgaW4gdGhlIGRldmVsb3BlciBtb2RlPw0KPiBUaGVzZSB0b29scyBj
b3VsZCBoYXZlIGRpZmZlcmVudCBwZXJtaXNzaW9ucyBldGMuDQo+DQo+PiBNYW55IHZlbmRvcnMg
YWxsb3cgdGhhdCB5b3UgZmxhc2ggc29tZSBvdGhlciBzb2Z0d2FyZSBsaWtlIGEgQU9TUC7CoCBC
dXQNCj4+IHRoYXQgY2FuIGJlIHZlcnkgZGlmZmVyZW50LiBMaWtlIGluc3RhbGxpbmcgYSB1YnVu
dHUgb24gYSBQQyB0byBkZWJ1ZyBhDQo+PiBGZWRvcmEgaXNzdWUuDQo+Pg0KPj4gQW5kIHN1cmUg
d2UgY2FuIHBpY2t1cCBwYXJ0cyBvZiB3aGF0IHVzaW5nIHRoZSBkbWEtYnVmLiBCdXQNCj4+IHdl
IGNhbiBub3QgZ2V0IHRoZSB0b3RhbCBhbmQgYmUgc3VyZSB0aGF0IGlzIHRoZSB0b3RhbCB3aXRo
b3V0IGENCj4+IHByb3BlciBjb3VudGVyLg0KPiBJZiBJIHVuZGVyc3RhbmQgeW91IGNvcnJlY3Rs
eSwgYSB1c2VyIHNwYWNlIHRvb2wgdGhhdCBzY2FucyBmZGluZm8gYW5kDQo+IGFjY3VtdWxhdGVz
IGRtYS1idWYgc2l6ZSBmcm9tIHRoZXJlIGlzIG5vdCBhY2N1cmF0ZSBlbm91Z2gsIHRoYXQncyB3
aHkgYW4NCj4gYXRvbWljIGNvdW50ZXIgZXhwb3NlZCBieSBrZXJuZWwgaXMgYSBtdXN0Lg0KQW5k
IGl0IGlzIGxpZ2h0d2VpZ2h0Lg0KPiBCdXQgaWYgdGhlIGNoYW5nZXMgaW4gY29uc3VtcHRpb24g
b2YgZG1hLWJ1ZnMgYXJlIHRoYXQgZnJlcXVlbnQsIEkgY2Fubm90DQo+IHNlZSBob3cgYSBnbG9i
YWwgY291bnRlciB3aWxsIGhlbHAgdG8gaWRlbnRpZnkgYW4gaXNzdWUuDQpTYW1lIGdvZXMgZm9y
IGFsbCBtZW1vcnkgY291bnRlcnMuIFlvdSBjYW4gc2FtcGxlIHRoZSBjb3VudGVycw0KYW5kIGJ1
aWxkIHN0YXRpc3RpY3Mgd2hlbiB5b3UgaGF2ZSBtYW55IGRldmljZXMuIFN0YXRpc3RpY3MgY2hh
bmdlDQp5b3UgdXN1YWxseSBzZWUgbGVha3MuDQo+IEFuZCBpZiB0aGlzIGNvdW50ZXIgaXMgbmVl
ZGVkIHRvIHNlZSBpZiB0aGVyZSBpcyBhIG1lbW9yeSBsZWFrLCBzdW1taW5nDQo+IHNpemVzIG9m
IGRtYS1idWZzIGZyb20gZmRpbmZvIHdpbGwgaWRlbnRpZnkgYSBsZWFrLg0KPg0KPiBXaGF0IGFt
IEkgbWlzc2luZz8NCj4NCkkgdGhpbmsgeW91IGNhbiBvbmx5IHNlZSBkbWEtYnVmIHRoYXQgaXMg
bWFwcGVkIHRvIGEgcHJvY2Vzcw0Kd2l0aCB0aGF0IG1ldGhvZCwgd2UgaGF2ZSBidWZmZXJzIHRo
YXQgZ29lcyB0byBvdGhlciBzdWJzeXN0ZW1zIGxpa2UgYXVkaW9kc3AuDQpBbmQgcHJvY2Vzc2lu
ZyBhbGwgZmQncyBvbiBhIHN5c3RlbSBmcmVxdWVudGx5IGFuZCBzb3J0IG91dA0KYWxsIGR1cGxp
Y2F0ZXMgaXMgbm90IGxpZ2h0LCBhbmQgaXQgc2lsbCB3aWxsIG5vdCBiZSBhIHRvdGFsLiBOb3Ig
aXMgaXQNCmEgc25hcHNob3QuDQoNCldoZW4gaXQgaXMgYWJvdXQgdG8gZmluZCB0aGUgbGVha3Ms
IGttZW1sZWFrIHdvcmtzIGZpbmUgd2l0aA0Ka2VybmVsIGxlYWtzLCBhbmQgcGFnZV9vd25lciAo
YWxzbyBvbmx5IGluIGRlYnVnZnMpIGlzIGEgZ29vZCB0b29sLg0K
