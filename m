Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312F23D1341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 18:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhGUPZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 11:25:09 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:25616 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231286AbhGUPZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:25:08 -0400
X-Greylist: delayed 2839 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jul 2021 11:25:06 EDT
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LFF7gQ008433;
        Wed, 21 Jul 2021 15:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=oEIV+9dPcloLX9P7zIFTdHSHcpo1/5ngZlDHzZrJrEE=;
 b=JLWiESBT3gRUGmj+A1s+SKDuEvY21i34QFpdMeGonEQXDmNB46V9AtjdDK2kP0EFT3bv
 7mWctL8SNBcGqHbODkJLfK6yWK+iYXmZHWiYu2+Wikt3A2u06+/apM/1zEF6RqY0x8k9
 woBY4DG+aBD3GR7MlaU8xaxexfdXqgKhiMi5rqBiDP6r5itQsG3sE+sqPkBcuMrxiWW+
 hLGstukg/jeykzEuysycBcKP7irpS2DKtzBl9ykHS7Ts78S5ziR7a48xs7V0Iy3Fkw54
 l9bZm+qfIOHxdQhVmRqUiLs3q2AsRYY4/JbqGb6VGVeiPKdFojRGZ6ej4UCTbzmcbgi3 Cw== 
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58])
        by mx08-001d1705.pphosted.com with ESMTP id 39vyttmcab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 15:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzS/iKCwws6Zbxsphk5akYHbE7rBGJtI9zEF6KolTFJOQyTbMAMUETYlyGcdARGugdoB4DDEY/B9ylknG76OBed1ILcBzGP08UN9XQMC9sgyLdTZ+grEh7wNxF9SeHG8OWN8Vj1lPnkNpZGvP8UZygGJrHm8T3kBxzQATqxy6jhnFrQy34OQAKxaEAnXG5XxMdFVQiXCLz+QogTY2ETX8R3g8J2bcb8a4ViuwhOk6gM/d8LwoppdMkboQdWPuas5IVyyBxdYb0l0qTgXcxItFlogNfWHbKItc+Tpiet4e61erR73Q2rbgSoXnsY58d4rW0b6YeEA6q9AF7+IB+OC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEIV+9dPcloLX9P7zIFTdHSHcpo1/5ngZlDHzZrJrEE=;
 b=Mkj8QtCcXBqRYPKwzeXh18ROaY/knTwizU3vseKLcfab8H9cLGTG5YO0hYQrS+ueyX7icZNeL6FKgAfsx/8I6gmPtkCiwRTpdDRPRRHK3UMJ6LpOUJK7rNsqrql/yTDsFr2AG7WFezQg7QxR7RFJBgfFMgPATssmXsivV0a1CtGvDICpykc9GuKn8074aqAcaUKithS5QqAWzH/c915X6VjZRG3BrPjOBCwO06D2T40ixIap0MrrySYvpbeDiFyB79eUWUgSTSmEMv/F3Yj+c2LiRmLh9bOKdt57QoTzrFkI/025sgH6ryido9tWNUPdMrhqoCUx7t899O5+TLHfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM8P193MB0787.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 15:17:53 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::d104:306f:a063:bcce]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::d104:306f:a063:bcce%6]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 15:17:53 +0000
From:   <Peter.Enderborg@sony.com>
To:     <willy@infradead.org>, <hch@infradead.org>, <tege@sics.se>
CC:     <nborisov@suse.com>, <linux-kernel@vger.kernel.org>,
        <ndesaulniers@google.com>, <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <david@fromorbit.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
Thread-Topic: [PATCH] lib/string: Bring optimized memcmp from glibc
Thread-Index: AQHXfkOTpsQK/isENkuotdGMivwLHw==
Date:   Wed, 21 Jul 2021 15:17:53 +0000
Message-ID: <0c3b5f75-3a8e-2b99-9032-d8e394db2a5d@sony.com>
References: <20210721135926.602840-1-nborisov@suse.com>
 <YPgwATAQBfU2eeOk@infradead.org>
 <b1fdda4c-5f2a-a86a-0407-1591229bb241@suse.com>
 <YPgyQsG7PFLL8yE3@infradead.org> <YPg0Ylbmk4qIZ/63@casper.infradead.org>
In-Reply-To: <YPg0Ylbmk4qIZ/63@casper.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=sony.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03553fe0-06ab-4273-3254-08d94c5ab64a
x-ms-traffictypediagnostic: AM8P193MB0787:
x-microsoft-antispam-prvs: <AM8P193MB078736DC1C553C12789A1DC686E39@AM8P193MB0787.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /4HwFZyd9kCRtcVxmcsPhyyJzmDGf/oMb2OIvjwK3l8CfoZ90easzow8JE3AAtUXTBZous3uDqc0CmngeiRGAAMEBQV8tXyG2z3b8hXLu5e9AkGXdv0zGG1CrCcjSImvjq6UdNPwAzkp6ZgWdRIjc6K9/vTjt/GvvvLSitOWSPyjBqSpZ4P5PvHH7i6qpO748xIPps1iNgu8+G8RZX/0XzxwdtFwqwUkMCnstMtynara+nPOPTrjqda1zCHfuFv3WrpEEm4i9+VdnlD7BcXp0iwCKZ9RwjMBkAmEO13aAGiDTdNyBWPUt6/Cw8PL+B+Pb8hlUTeUAFxt3Xghuj6ssnkLb/wAE5dtJlg6uH3Exx+qdf+pPSgwkL2CsMmPxFRlZF2H3eE+aOZpNrMU59eUmwWEXOOt5+A4N8yyzZt/NRTIT1vd94TqjaznnpjirPSgox0kkfMELjKBX1W9E+75SqXNz5b1RKFeE9LAyb7xpUAQr85t6sYwEaTFlCxtcCkSp0ZcpoTIAOgxM1UGWM8okFD8bD10NkEhohhlqy2Lx93JPCjNAoAdk7bF/jnkx86GBsB0om7ezek+ahyOD19EixzsfeBeoJTYQ4P2dViPer6q9eMQ9gNqITSD+2Jn3RH+kPrblFleGSD7PzOsIQPqVeLSstN4fUE58rueogers5rQP7+E3lL14Xj+nrEbVgDp6xaMJXArVFAZSKaD6+m6owbDMqeOBeIqbpAj/Kp9PY5BEGzXgEiRr0EGEVYjuNOBFk+1ZSQ021R1ghd5UpST/9IHcMdr45tt3MptxpNxDSQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39850400004)(396003)(136003)(346002)(31686004)(54906003)(110136005)(8676002)(316002)(66476007)(122000001)(478600001)(2906002)(64756008)(66556008)(66446008)(91956017)(5660300002)(8936002)(26005)(36756003)(4326008)(4744005)(6486002)(6506007)(186003)(71200400001)(83380400001)(2616005)(38100700002)(86362001)(66946007)(76116006)(31696002)(53546011)(6512007)(2004002)(43740500002)(38070700004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGlMVHE0UmxlWmh4Q2pOY09NUHV6ZGFXMnpGM2xja2RMQzhwdWdXUXZxZGlp?=
 =?utf-8?B?ZjR3anZwTG8zc1hRcWo1Q2NISXJmd2tHU25DZDZCYXNCOWRwSmJZZS95T3RD?=
 =?utf-8?B?Zklvc2E3dk5rU29jS2drcWl6Q2VITzVqMDBoMlYyQ095UkFpM0lkYUh4TVdr?=
 =?utf-8?B?enU1WXF1RHoxT2hma3R1dEc4dlo5cmVjU0FPZ0RZUFRyeHQ3WUowSHdqK2hr?=
 =?utf-8?B?Zk9scFRodHk1Wnl1K3g4Skw5SHc1bDU2NkZVZ29JbWhhWFllNTZGSDl2Q0o4?=
 =?utf-8?B?YVZKTHpaeU82NVlrMmgwZjNXMHRWaXQ3a3F4V2EyY2dEOU9zQjFGQ0lEQ3By?=
 =?utf-8?B?dVNGTnZVdzdBUHpRUVVxbkhSTkNnYjNMQjByYkdlcXdqQzYxTHdZNUNyN2dQ?=
 =?utf-8?B?Q0d0UVVZRDNFZUIxd0l6VzNtQnc3RWg3TGVWOHo4Um95NTBmMk9VRGFxUzN5?=
 =?utf-8?B?NHBvRmhvRVR4VzNia3FVY3BMOU0zQ1g2WS9tbXd2Skh1aE5ubnljVUpRSktT?=
 =?utf-8?B?VnBERFhJM0I0eFFQNzVCZzBZeEpGMXFMYzEwdDFSMU5XSkFaRGJWL0w0TVBi?=
 =?utf-8?B?Q1QvbDlyT0pxcFlKSnNJTlg5UzBaVHBTODRqcFlYcTJvQm90SWRkV0NWbGFj?=
 =?utf-8?B?OG5zSDdCRlhuUHRVZFRLWmZMTFk2bXVjTUoyRXVHYnVMdHdud01WRENnMWN2?=
 =?utf-8?B?VzhkRElkOHR1aW9NNFEySzluVjlMVjlFL05xTkYyTnRPRXJFVVhyTkdxcnhM?=
 =?utf-8?B?SlN3bUNCWi82bVdRLzl2UldSSW9EaXh2TjlONFJOWHduSVdPTXVGdURQOERT?=
 =?utf-8?B?RjQvdHVNOHBNWkF2T1NHUU9ub0JVSHY0am9saFNSZ1hCVzFiQmZzQUN2Qkdk?=
 =?utf-8?B?MlZ0U052OXg1Tm4zeGlWNkh3Z2tmV0RHWnBNbmtXUG40RzU3S24rdkhSbm1F?=
 =?utf-8?B?QjdqNzg1dXFQSDB6NmdvVWM4dWhJT0R0MkpkUGVWdFdWRGtlNmtDS091cHc2?=
 =?utf-8?B?cU5vZ0QvaFVTMHhzbFUzVTlJcW0yK0JMeFR2NURiYmVTeHYzLzhETnhjL1VZ?=
 =?utf-8?B?Um52ZHM5ZStCczFzVTJKK3VqK0drRlUrY3hKaWs5VGhORkxFalNuN0Mvb3l6?=
 =?utf-8?B?MzQyOUtZYXpBK1RPOUhpUkJ5K25TMUkyMjRMbHAzNmZ3MUh1T0FDY2ttQzY1?=
 =?utf-8?B?aWJ6ZFI3dHVsMWlydUQrczhUL2RKYTJpRzhGZkhJdHQxb1VZNVFYZ1NRZDQx?=
 =?utf-8?B?WjM0VVhTS1N0ZjFWWUxORHBVeE84R2piaVN4b2UrVXpONVBNaE9Oejk2Sk5w?=
 =?utf-8?B?NTZoQnN3WjdvWVpBMVR3c2s4TW5MeHZmTjZtNUpWQVhIMjBOTjVlMFowMXV1?=
 =?utf-8?B?NklSc3oxN21iNG9pNzhLWHpydkVWOVZmTjlOTmpWdENnb1RydGdHU3VpTmFm?=
 =?utf-8?B?bEhLQWl5MHNxRlI0aDNFcHpDV2lGWGI4WVpDU0tMSXc5QlM0cTNOUWpOUE9q?=
 =?utf-8?B?WlJkNTlKZ1BjT0crVTJyMDNiSVNYMnNIMnUwellVKytXSTYrNlQ2SE1FOGF3?=
 =?utf-8?B?RmFzbWtoTmdjMUZ1cTNGTzIrU1l1V1p6SVJpYXF4cjB6ZS8wOGI3SFRvQlNY?=
 =?utf-8?B?NzVpd3orcTNHME9jL2hRajNtb0tUUzZCT1lteW1NNVZ6QUQ0UGRUYXZQdGZI?=
 =?utf-8?B?ZlhVa3NQakxVTzQ0U1JZWlljaEhhd2hvNTdNa3p6c01UOElvTXUrTjdIR1dz?=
 =?utf-8?Q?1k54iVTmuv8wbXUKOyEgUJhbXkf6iQ5IK0yIOrW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4DDAB90E1841B4891F0EC988169CF73@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 03553fe0-06ab-4273-3254-08d94c5ab64a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 15:17:53.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mk0nOrWNcxvu31nUgORtd6xtRrbpvRkHLeE5In4r+/xGJYNd5HsKAUV5u/0gSRMhyuB5buUrcW5Fqe9IOx78HEqJSuVhsT9fvANGio6nB+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0787
X-Proofpoint-GUID: kgMkHxsBEhdOA_ECcuuYPjYhpV7KuC54
X-Proofpoint-ORIG-GUID: kgMkHxsBEhdOA_ECcuuYPjYhpV7KuC54
X-Sony-Outbound-GUID: kgMkHxsBEhdOA_ECcuuYPjYhpV7KuC54
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_09:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=915 adultscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210089
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy8yMS8yMSA0OjUxIFBNLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gT24gV2VkLCBKdWwg
MjEsIDIwMjEgYXQgMDM6NDI6MTBQTSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+
PiBPbiBXZWQsIEp1bCAyMSwgMjAyMSBhdCAwNTozNTo0MlBNICswMzAwLCBOaWtvbGF5IEJvcmlz
b3Ygd3JvdGU6DQo+Pj4NCj4+PiBPbiAyMS4wNy4yMSA/Py4gMTc6MzIsIENocmlzdG9waCBIZWxs
d2lnIHdyb3RlOg0KPj4+PiBUaGlzIHNlZW1zIHRvIGhhdmUgbG9zdCB0aGUgY29weXJpZ2h0IG5v
dGljZXMgZnJvbSBnbGliYy4NCj4+Pj4NCj4+PiBJIGNvcGllZCBvdmVyIG9ubHkgdGhlIGNvZGUs
IHdoYXQgZWxzZSBuZWVkcyB0byBiZSBicm91Z2h0IHVwOg0KPj4+DQo+Pj4gIENvcHlyaWdodCAo
QykgMTk5MS0yMDIxIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLg0KPj4+ICAgIFRoaXMg
ZmlsZSBpcyBwYXJ0IG9mIHRoZSBHTlUgQyBMaWJyYXJ5Lg0KPj4+ICAgIENvbnRyaWJ1dGVkIGJ5
IFRvcmJqb3JuIEdyYW5sdW5kICh0ZWdlQHNpY3Muc2UpLg0KPj4+DQo+Pj4gVGhlIHJlc3QgaXMg
dGhlIGdlbmVyaWMgR1BMIGxpY2Vuc2UgdHh0ID8NCj4+IExhc3QgdGltZSBJIGNoZWNrZWQgZ2xp
YmMgaXMgdW5kZXIgTEdQTC4NCj4gVGhpcyBwYXJ0aWN1bGFyIGZpbGUgaXMgdW5kZXIgTEdQTC0y
LjEsIHNvIHdlIGNhbiBkaXN0cmlidXRlIGl0IHVuZGVyDQo+IEdQTCAyLg0KDQpTdXJlLiBCdXQg
c2hvdWxkIG5vdCBUb3JiasO2cm4gR3Jhbmx1bmQgaGF2ZSBzb21lIGNyZWQ/DQoNClNvcnQgb2Yg
Ik9yaWdpbmFsLUF1dGhvciIgdGFnIG9yIHNvbWV0aGluZz8NCg0K
