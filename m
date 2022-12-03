Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E746764147D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Dec 2022 07:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiLCGWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Dec 2022 01:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiLCGWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:22:38 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2057.outbound.protection.outlook.com [40.92.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68EA392;
        Fri,  2 Dec 2022 22:22:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkNl4JbvbjRnQHtwAcbzuQRvab6yW2wQNnLGLjiRcWO2EWMl7mFWYqgkq+DnX9Q6FnhDmJHBTz2Ro2veYaOT9IpPgl/Mwz0ZHaZlBN/hnAKnRprZsIFez0AaegBJYh3W3W/s+SstogNLABgq5R/8fiT4nkGWz3GSUF4zXZOW/ut0heOnkE3OoBgCJw9Qun+CoGDx/FdHJFq+3zWyQQPQGy/W/23rrS1EhHY+QVCxAOFh8VKiXYBciAOqOSXqQPdRNrAjLCkpQOCMzWGQvd8N7vvpkKcgEp2A+bo/QxZunivfQOE91OTnUJqkoakU0YCd0t7d/d3GV81oRDiE/kze/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upT+DNiQwVYP+pMz2bwGrHeWsmYjdoDqN20WmtuvMQ4=;
 b=MfgHkri7tGwzfPfdrhySBujB3yZXYngcbnPxe64g7jqe8No8C/AIFx7c8ipqNhJJgtq/AEQvjIAOO1dVT3yhxu1F4DLLtsdfoXJKnxjFZQ2Fpm2BuKxufNvPIQ83NVTY4o0WZ7nb8SFaYsHPUaFSe/NdFIvHSNe3VcUJrV//9jRH5OyKZfIQ31dKmixAwhBCDKBsXLT8PYD3N7HCvJwhnKWncPj68soy7Tk2weiFysJy+xIuNUAQqzlRXTE8WQBstB6JdHl09mEJCw6nv1z3uKSuYsH1XV3/kWrMHElalmy+vcX61GVabPHdLWk3tXawZhp5rCMo5z9WBhdn7a2qiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upT+DNiQwVYP+pMz2bwGrHeWsmYjdoDqN20WmtuvMQ4=;
 b=N+WUVW78r+yKTcVX+ScVP4HavOWSs3kqxNDWhtkMPQ2AVSdUt1NZTUEanYM6kmw/LRzS3bqxMNPdbMHXD+Dpz05+UGG1t30F1AeBBzkOWYB9ijrslGiBMrNMAMv5Qyn/qi49VXg/MO9F/V3PNKBznxvvQrxKZMNwvc5DNbIScVekz1Mkr4vAmShJo09MKNqvQ3iQqDh/wAiRPNUv6nM+su+6r5q06ERhQy6Cv8WL2k1pRAnsmNkCWvwY5b4MjFHXxikXbyEtHVQx2zQz0HWoJ86gP5Z8YK4BtWmG0+Q31voViYLVpKAOdBuAIzIrDE6cR/9oI6xXsBAaezD4hlayhA==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MAZPR01MB7039.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:59::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8; Sat, 3 Dec 2022 06:22:28 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1%4]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 06:22:27 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] hfsplus: Add module parameter to enable force writes
Thread-Topic: [PATCH] hfsplus: Add module parameter to enable force writes
Thread-Index: AQHZBhN91tyHb5NS2Eynd+A7F1BLCK5bFC0AgACe1YA=
Date:   Sat, 3 Dec 2022 06:22:27 +0000
Message-ID: <05EDE31B-9ADC-4421-B96B-98C3A8EE4C95@live.com>
References: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com>
 <20221202125344.4254ab20d2fe0a8e784b33e8@linux-foundation.org>
In-Reply-To: <20221202125344.4254ab20d2fe0a8e784b33e8@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [hWh02CEy5dQ4wMVAzKk+861WK0BWXklM]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MAZPR01MB7039:EE_
x-ms-office365-filtering-correlation-id: a91679de-b2eb-44e7-7c13-08dad4f6c033
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LoB5i0/xlJI2q0SAKUIat82Fu1ydcCpw4CAOLGVuErUJOL5UdpEx30S7cINr2dwzpBBpxuzFlqs2dbJ+Aof7Y4s3d2bPWfVD2RoUtsQfNmIbz5cRhTOM9yfTQyU1CoUfG6H7gC4+p5Bhd8FvmJpvokXYiz5q6fnb5Q90YpDkSADMhyJC+cetLCg/sA9EyaXzchBOjhfkuST1d/bgLY/XVh8M2E3pt27jDsLhWhPl8IRpibZXzSXeOx+Sc3deAQRs347VimBUATyq/WYs+z+X6vLG10/gF5dwrXGt8LT1aMfSZWmbV6uniIedBG87VYVa5ImK9gei8mvglovlBQjG/VfGvHp+YrAosStq99QU0BTEkZUo6c5Sp5oKHUYe7oD/GbNiZTCDSySpZ0CaKXZP50rq/s5QNXclql2zjmuNuZuoOf9ekeXfdB68v+Ngbd2LuBXTE0XILEWyRPKdUfbX0KI+OMzXP03amaOpCx2zCu9oi9nLLJ2VIWMDtL0w98hAXHkv/BQF8EeAl+lAa8KaMvaaKY4cNGN5aIUWjF/UAC8VA1fHUG8bf+TTUF3f5u8uvsjSgo8Xq+pNHb6gAOOYxXZ43GPMiw9Mo0zeKRxfD+KEoibGRrncmYpLaHjtcDoc4FYgIBVDDHkXcmvZVVOo1A==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEhaWlBnY3hqRy8rTmlFcXlmWGgxcmh2SnRlaDA5bnZrVUJ3VDBucXRBQkNT?=
 =?utf-8?B?eEJTRWRhbkJ0blB5dmJYYjJFdnNDcnNnT3owNjUrbnZTd3J1ZWtiS2EvbjlI?=
 =?utf-8?B?bE1udWZ3UmdWbWRDVjRLSU1zMVFUY1VWZDBJczV3N3pJTjE1dU81YnNqbFla?=
 =?utf-8?B?d1d4bldUbjBuVVdxbDByYUFsZGVsa3owRSt4aGZWbG8xN2hlRkdhM2VkdUZk?=
 =?utf-8?B?YTRaZ1cva1BVRFo5K3BTSjdXVFMrbmtkTStDQnA4b0lrNVpXVUFndWxuV3Zr?=
 =?utf-8?B?WTlrZG5wUnYvTU43eEZmdTIyU3dlc2hOQThBb3hNSzVSb2pwbll2UzNpVWNT?=
 =?utf-8?B?cWhwRS9MajgzalkxWWw3QnJ0NmNZblY5K0lML2p5UmYyTnNqV2E5dHZ4MU56?=
 =?utf-8?B?dGthWXpQOGdjaUF0WG9yMmRRNGI4emUwdDRmOFFMUTVKVW4wNnYxdnFnaXFs?=
 =?utf-8?B?d0pjaU9zaWxaMmlnN09tVFVqK0lNYmlUZmM5VlRSTTBxT01mUjU1VWlOZXpU?=
 =?utf-8?B?U1FWSW56WHJrSG5oSWZoazE0N1ZXaUpCbUJ5d3NDOUg0M21zNlBmOVRTSGN3?=
 =?utf-8?B?eXRnS2pXR2U2VzRUK1JYMDNOclZQbG04ZnRvR0xOWGRDakw2YUFMdHZrUFY0?=
 =?utf-8?B?NkVSaXRWLzZqTEhNSmhxWEJuSTdDaEFQTGFwZDUyaHBiRk1Ub3JiL3ZYM1ZP?=
 =?utf-8?B?YWZHd3NLRlV4RFFvWHpXZ3lNUnczMWtmQkhEWmlFRE5NVHVjb0VPclJxU2pM?=
 =?utf-8?B?TTVsTjYrenZKNW5FWFl6bWthOG4zNUR1czY5RkI4ZXJmKzNtTUdHY1VRUUR5?=
 =?utf-8?B?ekFHemN2NktvUk1nQTB6TzlOdFdHcU16NnFOdzZpVXM4a1ZaWlVuUnNCSnB0?=
 =?utf-8?B?WXVpM2hqL2l4eWE1M3VRa0FwaStEUE9melRLTVdOdzZoa2FjRkgvUlNOM1Fr?=
 =?utf-8?B?TEFveXBacWpuYnNQeDNsZnZiSi9PVDhpRm5zMFF3eWRoU2tGSzg2cGduTVA4?=
 =?utf-8?B?anRqZDJJV2k1cHZxQWVDS2RpUysyRWNLVHZwb2ZkdnpheHliZnNWb2tVV2Vq?=
 =?utf-8?B?ekJmZmg0c1BoZi80WTJnZ2ZRUENpVUhxL0JFOGhTK3ptMyt0cHVKUTZ5WEpY?=
 =?utf-8?B?MTFVK3BZZWYwSm9uVEFSMjd1ZjNTeUxLVVpQd3RFYy92WDBVMi82TmNySmVw?=
 =?utf-8?B?ajVpNm4xMzRFbDloTEJHbFRpd3ZLNjhDTXhYQnVQMFhHUHlsY3ZUUW1BMThK?=
 =?utf-8?B?R3pXU21zRUJNb0FqdXg3TkpRTkE2ZXl4enVtRmRGTk5GSm5ocEFyMXNhZGJm?=
 =?utf-8?B?N1hkRjQvbDJRd29aNngzUXpDY2FOdm9NOWI3Y09OS0F3Uy9yVHY1T1gwdWJs?=
 =?utf-8?B?WjhKdTk2czFsM1pwbjRoUUNJeUxaUG5TUVc3NlA2QVpMNDJ0Y0g4bnpBU0Rq?=
 =?utf-8?B?QmlEMzhha0lMZ0QvTWgvRnV4SGtOWXkxWi9YT3hYMGt4VUNlNWpuZ1UvVzdQ?=
 =?utf-8?B?S1JoTGZZOHVFZ0w1UWozd1R6Z0pBQmUvTFZ5K0tFSmJxTHkyektneGluK2VO?=
 =?utf-8?B?SzlLa3FZcjVQTzNkOUZKaS9LT1liRThCSllGZXNld1dZZFVkN0Z4SmlDa0kr?=
 =?utf-8?B?WWhXRjVYQ1B5bXRPWURuempERFpJOUZRSG9ZbHVRQy9zRjRaL2xtOHJRRjZR?=
 =?utf-8?B?WjBteVU3aGNWaWF2cDU0OFBUbkFWSm03ZHI0ZzlpTGJoWjhtYVcvUUZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E916C2FA14ED724DA04E8FAB49CEC878@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a91679de-b2eb-44e7-7c13-08dad4f6c033
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 06:22:27.7520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IFByZXN1bWFibHkgYW55b25lIHdobyBlbmFibGVzIHRoaXMga25vd3MgdGhlIHJpc2ssIGFu
ZCBpZiBpdCdzIGENCj4gY29udmVuaWVuY2UsIHdoeSBub3QuDQo+IA0KPiBEb2N1bWVudGF0aW9u
L2ZpbGVzeXN0ZW1zL2hmc3BsdXMucnN0IHdvdWxkIGJlIGEgZ29vZCBwbGFjZSB0byBkb2N1bWVu
dA0KPiB0aGlzIG1vZHVsZSBwYXJhbWV0ZXIgcGxlYXNlLg0KDQpJ4oCZbGwgYWRkIGl0IHRvIHRo
ZSB2Mg0KDQo+IEFsbCB0aGVzZSBzdXBlciBsb25nIGxpbmVzIGFyZSBhbiBleWVzb3JlLiAgSG93
IGFib3V0DQo+IA0KPiBwcl93YXJuKCJ3cml0ZSBhY2Nlc3MgdG8gYSBqb3VybmFsZWQgZmlsZXN5
c3RlbSBpcyAiDQo+ICJub3Qgc3VwcG9ydGVkLCBidXQgaGFzIGJlZW4gZm9yY2UgZW5hYmxlZC5c
biIpOw0KDQpJ4oCZbGwgZml4IHRoaXMsIGJ1dCB5b3UnbGwgZmluZCBhIGxvdCBvZiBleWVzb3Jl
IGxpbmVzIGluIHRoaXMgZHJpdmVyLCB3aGljaCBJIGd1ZXNzIHNvbWVvbmUgd291bGQgaGF2ZSB0
byBmaXggdGhlbi4NCg0K
