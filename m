Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10AB701EFF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 May 2023 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjENSjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENSjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 14:39:04 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2058.outbound.protection.outlook.com [40.107.9.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289A83593;
        Sun, 14 May 2023 11:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B47LRVozw5xBpM6O45sFU6YWvOB3DeQtVlM9SzpawiI1YTse7nTU7Za/dQ98KrzVatHtwNBN2MPSu53FpE6oIYN88ZP6vkyTRc4j1AXimkWRohR9oY6pC/MU0DaU5Dzu5IXukjpOQA9ikxasf3wEP1OAKMG9u1vjoMc0+Z7jC8MrJ+/ERpoHOOxHbyHwCaMI9TPKkhhJftz5zU8DFi5pwstZ6hfO7fSjDd0uFmUKIHsnNH4NiuQXBbrhGh30sQsX7DSuYEGfKxX3SDVXy0+P0qp5CFls4sLlNn7peruGnUqhNA4TtKyCfkNXnS5qQjcgyCH9HeQcw2kg+6YTsga5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg7d7NAmCIj1Huk93eec7T5yU+XTC5F3kggTsFB3bF0=;
 b=l9Oby93xGj752WqdJQ1yix3KCJm5YMCNqaXasedRr0KFWunoRpTeMxLYX2VdBzeuE4ZP7z5f+DiCujbxyQKohi/BehdyMl+AhznQSQpSOd1y1SbV7tLSmBDjTeuAODpTYdIAsre8Z+VF9PJ8DMey+QRuuGdLgi5bT+YR2/ddLti4asVeHZQIO6HGamFrLcfVkdxg4XgSnfo1DigQfvF36+cyPlfyCrlRdgwOSK2vHSzqlCD0h7OrQcReMklnzYqYMoADcIlqplPCPLaJInel8JOHdBIiLS1vC/1GAanvaEDXvsyBNDlAT+gVhWgvKhDA5Z9q8howWhNpqkIbgBD6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg7d7NAmCIj1Huk93eec7T5yU+XTC5F3kggTsFB3bF0=;
 b=Sw/9GRcf34b6x/FWkpLdZiGQR/kGYC4ifSWaI9+Rz3H32CYg8TRJFTkd+OQ0Bl0Nr/Vm/loFMBjSq0+mVY0e8uQCTZOoZNi4d/sKEdClcNgD0YaZmGhU5cDqpIbn73OpEdp7n6bH1ZeRMoWLLpzwyJPwqZ4ECAqOpvnIT1a6zZDDL8EAhLdJ1BBFYTI18luJysikZlMPKY5o9iZKIhMqKdEY3UujYM/Wua5fXIVSfd5OEcWOozX7VM5YGE+6Y7buQbE1+an3jPCVT+2PCBZLKVLK3mgEH0hqjM79GIVeoDNeIT8BwF95WMEQ3O3vlgJQ3TUrFgkwB9TpgfJqNgBndg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1909.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Sun, 14 May
 2023 18:39:00 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243%3]) with mapi id 15.20.6387.030; Sun, 14 May 2023
 18:39:00 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Thread-Topic: [PATCH 07/32] mm: Bring back vmalloc_exec
Thread-Index: AQHZgpdUsgx7flCbUE+3jXS45Hg7zK9SaWKAgAAHaoCABcbjAIAB6dOA
Date:   Sun, 14 May 2023 18:39:00 +0000
Message-ID: <ce5125be-464e-44ad-8d9e-7c818f794db1@csgroup.eu>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org> <ZFq3SdSBJ_LWsOgd@murray>
 <8f76b8c2-f59d-43fc-9613-bb094e53fb16@lucifer.local>
In-Reply-To: <8f76b8c2-f59d-43fc-9613-bb094e53fb16@lucifer.local>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB1909:EE_
x-ms-office365-filtering-correlation-id: 490fcecb-9bce-42a3-5244-08db54aa7bfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w7/xef2PUTR2oleZrkTTp4k2WXmpK2UDvDuuAuq3tjs53JEPbn95ocwlo9BsVCRwb74wmJMQtI428bR4GwE9pB1XRMi11dixJ6I21DNAXJ+ZxrX7WLs9pwWFBI/q60Pi+w/Ba1K3MaoOHtl8uNanzwqsS7GAQtCVLWxVQl5uD5adfrQHQbveXp+99qkssS0MAXKqr0pOjfkQU4KtGZ6RV0g4pyC+Xmlbu8oyeAfRExdFMe9+f46PZ+2TWuklyS0Ube2YHfX4SvgE/VE8sA/afV+Fh8wU8gX9jqXNXdtnTNHnb9MBgD16zC2bRz9+a2bh/XfCd69c6JhMpmm9A3+Gk5VJrnOVQjVTSQ7hW+OdY0rTVezQ+7sBFg2H8ey1KEutfBsX9fmC+ZxQj/+JtQ8M8EjaD2RqTsm1fSZWVOQLOQUCUJmwOh1OvPi6IRBHBt1BW2iBEo8BpCHTUL3GF6SQOAP+orWbligAWukbM0+6wjIWkjjRzLBBzOs3L0DukF8KI02ABYwpwdzi9hZuDOlOrFGN+26QuQ9kfQFA5xHvpiwA4ADQiCOeLIwvsIX/bhW9MezYWlipjSYfjSPCDulVvpoX70sp9hDMa6Nrk8J8mmPKhckozGRGkbtpjYezJupR/nTjHu3KBYWYFKtXg5uSIHOm1KYSeymxl/lBshNiNH3mcvVUz3mhTJ7jELMg1Bae
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39850400004)(376002)(396003)(451199021)(66574015)(83380400001)(64756008)(66446008)(66476007)(66556008)(66946007)(91956017)(76116006)(2616005)(26005)(6486002)(6512007)(6506007)(478600001)(54906003)(110136005)(186003)(71200400001)(86362001)(44832011)(7416002)(2906002)(8676002)(8936002)(31696002)(5660300002)(36756003)(4326008)(41300700001)(38070700005)(38100700002)(122000001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjE4eGtlSFFXVE1hdmlzR1RtUjRSQk1qcG9TSzB1Mk5NbzIySlVuOHE3SFVu?=
 =?utf-8?B?c1o5VGtCWjBjMzJZb1JvR3BUMlhLK09mSWhqaTRSTzNPaDE3K0E1MmdwQUFO?=
 =?utf-8?B?K0FyVUdFT1hoQWRRUzRCdk9kdDB1YWJ4R293YjRYd2g3NEtTYUkxQk5NOWlJ?=
 =?utf-8?B?UTUrZXVEeDl2TUZlSzVXZmZWMi9EL21QeTB6S1VLbDJHRm9zcjJIcm4xcEta?=
 =?utf-8?B?SWNLMjZZNEFSRkc3L3pRZVQ2bjBZbTVQMzAyeHNFb3ZJUTNEa05ucmZCbFl0?=
 =?utf-8?B?UVJGWm9ZZUJGTUs4eXhiQWxvcG1kOFJQZXlSb3d5YjFpcXFSQjY5OG9JY01r?=
 =?utf-8?B?V1hlKzRvdmk3UG9UaEN5UmtJNmdCQW9KTDNKM1BnUVRaMm5IbXY4WitnVUZV?=
 =?utf-8?B?SEJRd1kzc3V3OUpSdFJocUVmTm1OT3o3Y2paQys5TDk0Wjh3V3Z2aFlWOWND?=
 =?utf-8?B?Wm9RRzhzRUdOMkdadXNSQU1KWWNOVUlSUlhPRlY2eitKenh6K25MaXpyakNn?=
 =?utf-8?B?R2F1dmJDNC85bUt5NDdHMFBCakZNZDd0UDlzT291aGJGM2JiOHp4bVJZT3J5?=
 =?utf-8?B?TFlFYUhsYUE3SVptRHIyZGhyUEQ0Y2plczR0elRPZWw4YjR2bDdsZ3JLZ0Fs?=
 =?utf-8?B?SDhlaHBCNXZsU2dpS1IrNzRIcjRJQldGVzFRZnNvM3ZyakpYeTNpMWZ2bG02?=
 =?utf-8?B?cHFwNjNoODVQV21pVU5Mc0hqc0dFeUppSWViRXhJMXJWOVZCTjRwQlp1TWxl?=
 =?utf-8?B?cCtWc25EMVpIdHZYZVJqaE1XR0R4NFQ4NE84T0VvZEp1OHphRzZ0d29HWGt4?=
 =?utf-8?B?Q1M5UG45SEVKT2hFWFFjcGJTdlpYM1Q0R05uMldJYnhOVDFUQkVWbG9paUli?=
 =?utf-8?B?dXVVNzR6NGVxOHJURUlQcmFWUm4yTW1uUUgySHgrN1o1dmR5YjFqWlBYUHRh?=
 =?utf-8?B?SXVYcDZTZEc4MXl0OVlGWkVjSXh1MHNQZmk3cm5peEt3QUZlTzlNQUxIZ0Ru?=
 =?utf-8?B?TzgzSkdkRjBnQ1RzRUpHTTJzZXJuNzh3c2NLOWlJbVFxaUY3VWI5OWVSYzQz?=
 =?utf-8?B?aHpwTnI3dkhPWG9DQ2F6RGhpK3hZSTFqb2FJNkJzYURIanpwSVl2SFRhaHc1?=
 =?utf-8?B?dUpNd05mdHFmUGxYWDJTaUVLQ2hWN20welFnL0VOcHBuMzJaOGI5RTlkaGxH?=
 =?utf-8?B?bEszKzIxZDFkdjM0TjN5U3owV3hIWnZ0ekh5a3A2em0ydWVCdHhVY1lmYmdE?=
 =?utf-8?B?NXkzTWx6MnpHYlNOUGxDLytJTHN6Z09WR1A3bUovR3RseHM3UmpRNHgyOEN3?=
 =?utf-8?B?Q2NaNzZzR0NkK212aUpzendJT3hnTkhjMkl0VW9QSHA1RDhKTDljemd0UDJi?=
 =?utf-8?B?ZG8xL0pPN1MrN2dnMGJvYjJOVUZ6TzJpR3FmV25ObnJrbHNiYjl0dS9PdHNK?=
 =?utf-8?B?ODQyMjNUY3pkR0hzeW9SU1lMS0JNRCs3MVJUQ3prZW1pNXBlTzJFRThGY09L?=
 =?utf-8?B?MHFId3Z6K2laS2J0WnlJcjNxbTVOVFlYQmREdjhpTDhKZnBIU0txcXUveWdO?=
 =?utf-8?B?SDkxLzlQRkFFZjhzSFdzU0swV1VNRG52RWUxVkpJVWdCNmtwY2lUcnByakQ0?=
 =?utf-8?B?UG03Vis0TzUvZ1hzbXJock1EZXM3NkVJMG9hWkg2WXRUT2I1L0orcitMMGc4?=
 =?utf-8?B?aUJ1U3M1dGp5cU82cEE4UXZUcFczTVY0R0ptbk1FWHhleUJnd2tnZVR6YkVj?=
 =?utf-8?B?VnV2UVZhak5BOUVyMTJ4UE1pazlhSHUyZklNNmhGcHcrL3U2WFRVb2JxSjRK?=
 =?utf-8?B?Q0xrY096cGtnWkJiakFsS1pUcXdrZDF5K1RiWkhHZXRrZStxc3NtMEo3aUwx?=
 =?utf-8?B?VFI4MFNacjRwVlJsblFvMEhKQWtKdXdyemp6VUdCQ1JCWkhnZmp5SFo5RWNO?=
 =?utf-8?B?b2pBL2xqT1dKUmhxZ2p2elVEdzhPOXlabDVWK1FzR0RFSHYzdHR2aStKd29y?=
 =?utf-8?B?eGF1WnNVSU9QK2tXa3cxaVR4UWluYnlaNEdoYWhldXhMSlFEYnhmWVJuQXNr?=
 =?utf-8?B?SnYzK0xKS2E5M0d0SWRGUUdDVjYrSHAwckY2cUFicUtPK3JjL1AzbmIwckJu?=
 =?utf-8?Q?y0o5jYWNhNzVG405W8kiFYSlc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7D3A28A719AFF4E96B25C1FF17F54A4@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 490fcecb-9bce-42a3-5244-08db54aa7bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2023 18:39:00.3699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mt1FgbJkZw03SFmg5L35YYbMXzOVmiGxhOVHDe67kDd7qCAztFmj9+iqVjPZgSNovxGnPpFa2Og024kqjOaa6O7ie3k3bDGolxdno4VnceI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1909
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCkxlIDEzLzA1LzIwMjMgw6AgMTU6MjUsIExvcmVuem8gU3RvYWtlcyBhIMOpY3JpdMKgOg0K
PiBPbiBUdWUsIE1heSAwOSwgMjAyMyBhdCAwMjoxMjo0MVBNIC0wNzAwLCBMb3JlbnpvIFN0b2Fr
ZXMgd3JvdGU6DQo+PiBPbiBUdWUsIE1heSAwOSwgMjAyMyBhdCAwMTo0NjowOVBNIC0wNzAwLCBD
aHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+PiBPbiBUdWUsIE1heSAwOSwgMjAyMyBhdCAxMjo1
NjozMlBNIC0wNDAwLCBLZW50IE92ZXJzdHJlZXQgd3JvdGU6DQo+Pj4+IEZyb206IEtlbnQgT3Zl
cnN0cmVldCA8a2VudC5vdmVyc3RyZWV0QGdtYWlsLmNvbT4NCj4+Pj4NCj4+Pj4gVGhpcyBpcyBu
ZWVkZWQgZm9yIGJjYWNoZWZzLCB3aGljaCBkeW5hbWljYWxseSBnZW5lcmF0ZXMgcGVyLWJ0cmVl
IG5vZGUNCj4+Pj4gdW5wYWNrIGZ1bmN0aW9ucy4NCj4+Pg0KPj4+IE5vLCB3ZSB3aWxsIG5ldmVy
IGFkZCBiYWNrIGEgd2F5IGZvciByYW5kb20gY29kZSBhbGxvY2F0aW5nIGV4ZWN1dGFibGUNCj4+
PiBtZW1vcnkgaW4ga2VybmVsIHNwYWNlLg0KPj4NCj4+IFllYWggSSB0aGluayBJIGdsb3NzZWQg
b3ZlciB0aGlzIGFzcGVjdCBhIGJpdCBhcyBpdCBsb29rcyBvc3RlbnNpYmx5IGxpa2Ugc2ltcGx5
DQo+PiByZWluc3RhdGluZyBhIGhlbHBlciBmdW5jdGlvbiBiZWNhdXNlIHRoZSBjb2RlIGlzIG5v
dyB1c2VkIGluIG1vcmUgdGhhbiBvbmUNCj4+IHBsYWNlIChhdCBsc2YvbW0gc28gYSBsaXR0bGUg
ZGlzdHJhY3RlZCA6KQ0KPj4NCj4+IEJ1dCBpdCBiZWluZyBleHBvcnRlZCBpcyBhIHByb2JsZW0u
IFBlcmhhcHMgdGhlcmUncyBhbm90aGVyIHdheSBvZiBhY2hldmluZyB0aGUNCj4+IHNhbWUgYWlt
IHdpdGhvdXQgaGF2aW5nIHRvIGRvIHNvPw0KPiANCj4gSnVzdCB0byBiZSBhYnVuZGFudGx5IGNs
ZWFyLCBteSBvcmlnaW5hbCBhY2sgd2FzIGEgbWlzdGFrZSAoSSBvdmVybG9va2VkDQo+IHRoZSBf
ZXhwb3J0aW5nXyBvZiB0aGUgZnVuY3Rpb24gYmVpbmcgYXMgc2lnbmlmaWNhbnQgYXMgaXQgaXMg
YW5kIGFzc3VtZWQNCj4gaW4gYW4gTFNGL01NIGhhemUgdGhhdCBpdCB3YXMgc2ltcGx5IGEgcmVm
YWN0b3Jpbmcgb2YgX2FscmVhZHkgYXZhaWxhYmxlXw0KPiBmdW5jdGlvbmFsaXR5IHJhdGhlciB0
aGFuIG5ld2x5IHByb3ZpZGluZyBhIG1lYW5zIHRvIGFsbG9jYXRlIGRpcmVjdGx5DQo+IGV4ZWN1
dGFibGUga2VybmVsIG1lbW9yeSkuDQo+IA0KPiBFeHBvcnRpbmcgdGhpcyBpcyBob3JyaWJsZSBm
b3IgdGhlIG51bWVyb3VzIHJlYXNvbnMgZXhwb3VuZGVkIG9uIGluIHRoaXMNCj4gdGhyZWFkLCB3
ZSBuZWVkIGEgZGlmZmVyZW50IHNvbHV0aW9uLg0KPiANCj4gTmFja2VkLWJ5OiBMb3JlbnpvIFN0
b2FrZXMgPGxzdG9ha2VzQGdtYWlsLmNvbT4NCj4gDQoNCkkgYWRkaXRpb24gdG8gdGhhdCwgSSBz
dGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoeSB5b3UgYnJpbmcgYmFjayANCnZtYWxsb2NfZXhlYygp
IGluc3RlYWQgb2YgdXNpbmcgbW9kdWxlX2FsbG9jKCkuDQoNCkFzIHJlbWluZGVkIGluIGEgcHJl
dmlvdXMgcmVzcG9uc2UsIHNvbWUgYXJjaGl0ZWN0dXJlcyBsaWtlIHBvd2VycGMvMzJzIA0KY2Fu
bm90IGFsbG9jYXRlIGV4ZWMgbWVtb3J5IGluIHZtYWxsb2Mgc3BhY2UuIE9uIHBvd2VycGMgdGhp
cyBpcyBiZWNhdXNlIA0KZXhlYyBwcm90ZWN0aW9uIGlzIHBlcmZvcm1lZCBvbiAyNTZNYnl0ZXMg
c2VnbWVudHMgYW5kIHZtYWxsb2Mgc3BhY2UgaXMgDQpmbGFnZ2VkIG5vbi1leGVjLiBTb21lIG90
aGVyIGFyY2hpdGVjdHVyZXMgaGF2ZSBhIGNvbnN0cmFpbnQgb24gZGlzdGFuY2UgDQpiZXR3ZWVu
IGtlcm5lbCBjb3JlIHRleHQgYW5kIG90aGVyIHRleHQuDQoNClRvZGF5IHlvdSBoYXZlIGZvciBp
bnN0YW5jZSBrcHJvYmVzIGluIHRoZSBrZXJuZWwgdGhhdCBuZWVkIGR5bmFtaWMgZXhlYyANCm1l
bW9yeS4gSXQgdXNlcyBtb2R1bGVfYWxsb2MoKSB0byBnZXQgaXQuIE9uIHNvbWUgYXJjaGl0ZWN0
dXJlcyB5b3UgYWxzbyANCmhhdmUgZnRyYWNlIHRoYXQgZ2V0cyBzb21lIGV4ZWMgbWVtb3J5IHdp
dGggbW9kdWxlX2FsbG9jKCkuDQoNClNvLCBJIHN0aWxsIGRvbid0IHVuZGVyc3RhbmQgd2h5IHlv
dSBjYW5ub3QgdXNlIG1vZHVsZV9hbGxvYygpIGFuZCBuZWVkIA0Kdm1hbGxvY19leGVjKCkgaW5z
dGVhZC4NCg0KVGhhbmtzDQpDaHJpc3RvcGhlDQo=
